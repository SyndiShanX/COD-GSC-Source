/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\challenges.gsc
***********************************************/

#using script_7f6cd71c43c45c57;
#using scripts\core_common\activecamo_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawning_squad;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\emp_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\mp\uav;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\scoreevents;
#using scripts\mp_common\util;
#using scripts\weapons\weapon_utils;
#namespace challenges;

function private autoexec __init__system__() {
  system::register(#"challenges", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!isDefined(level.challengescallbacks)) {
    level.challengescallbacks = [];
  }

  callback::on_start_gametype(&start_gametype);
  callback::on_spawned(&on_player_spawn);
  callback::add_callback(#"scavenged_primary_grenade", &scavenged_primary_grenade);
  callback::add_callback(#"skydive_end", &function_2bc84a5f);
  level.challenges_callback_vehiclekilled = &vehiclekilled;
  level.var_4d062db3 = &killstreak_started;
  level.var_706f827 = &function_e7e09ca1;
  level.var_d92c4db3 = &function_1123ffd1;
  level.var_de946e0 = &function_3d9dbb3a;
  level.var_f18966dd = &function_e143d63b;
  level.var_c8de519d = {};
  level.var_c8de519d.multikill = &function_19e8b086;
  level.var_c8de519d.var_ec391d55 = &function_3ee91387;
  level.var_7897141a = [];
  level.var_7897141a[getweapon(#"hash_66401df7cd6bf292")] = 1;
  level.var_7897141a[getweapon(#"hash_3f62a872201cd1ce")] = 1;
  level.var_ca4ce464 = [];
  level.var_ca4ce464[getweapon(#"ability_smart_cover")] = 1;
  level.var_1d971504 = &function_7007692f;
  level.var_deeabb17 = &function_e68cbed4;
  level.var_fc6cd245 = &function_5af500d9;
  level.var_f9922f0b = &function_23320f51;
  level.var_faccd7d4 = [#"hash_7ef27b4daf600fa3": &function_8c48d8ff, #"hash_494be20e0ae54646": &function_8c48d8ff, #"hash_5b3c69ab88f8a086": &function_8c48d8ff, #"hash_73f1fe390db552da": &function_486d4ce3];

  if(getdvarint(#"hash_571aded0846491e8", 0) == 0) {
    level.var_d619bc61 = 1;
  }

  if(!isDefined(level.var_b7bc3c75)) {
    level.var_b7bc3c75 = {};
  }

  level.var_b7bc3c75.var_1d3ef959 = &function_1d3ef959;
  level.var_b7bc3c75.var_e2298731 = &function_bb19a72c;
  level.var_b7bc3c75.var_fbbc4c75 = &function_fbbc4c75;
}

function start_gametype() {
  waittillframeend();

  if(isDefined(level.scoreeventgameendcallback)) {
    registerchallengescallback("gameEnd", level.scoreeventgameendcallback);
  }

  if(canprocesschallenges()) {
    registerchallengescallback("playerKilled", &challengekills);
    registerchallengescallback("vehicleKilled", &function_8e9b2d44);
    registerchallengescallback("gameEnd", &challengegameendmp);
    registerchallengescallback("gun_level_complete_last_rank", &function_b15a1e1e);
    registerchallengescallback("roundEnd", &function_de80e959);
    player::function_3c5cc656(&function_a79ea08b);
    self callback::add_callback(#"done_healing", &player_fully_healed);
    level.var_9ff21849 = isDefined(getgametypesetting(#"hash_7647d0e9a45eeca6")) ? getgametypesetting(#"hash_7647d0e9a45eeca6") : 0;
    level.max_players = getgametypesetting(#"maxplayers");

    if(level.var_9ff21849 && isDefined(level.max_players) && isDefined(level.var_704bcca1) && level.var_704bcca1 > 0) {
      level.var_77e0887f = level.max_players / level.var_704bcca1;
    } else if(isDefined(level.max_players) && level.max_players > 0) {
      level.var_77e0887f = level.max_players;
    }

    if(level.teambased) {
      function_be3d23d1();
    }

    level.var_3236015 = &function_b661072d;
    level thread function_f9478088();
    level.var_7d790c58 = &function_20456466;
    level.var_91dfce3b = &function_ac98baa9;
  }

  callback::on_connect(&on_player_connect);
}

function on_player_connect() {
  profilestart();
  initchallengedata();
  profilestop();
}

function function_1123ffd1() {
  return self loadout::function_18a77b37("primary");
}

function function_3d9dbb3a() {
  return self loadout::function_18a77b37("secondary");
}

function function_e143d63b() {
  return self loadout::function_18a77b37("specialgrenade");
}

function initchallengedata() {
  self.var_9cd2c51d = {};
  self.pers[#"stickexplosivekill"] = 0;
  self.pers[#"carepackagescalled"] = 0;
  self.pers[#"challenge_anteup_earn"] = 0;
  self.pers[#"specialiststatabilityusage"] = 0;
  self.pers[#"activekillstreaks"] = [];
  self.pers[#"killnemesis"] = 0;
  self.pers[#"killsfastmagext"] = 0;
  self.pers[#"longshotsperlife"] = 0;
  self.pers[#"specialiststatabilityusage"] = 0;
  self.challenge_defenderkillcount = 0;
  self.challenge_offenderkillcount = 0;
  self.challenge_offenderprojectilemultikillcount = 0;
  self.challenge_offendercomlinkkillcount = 0;
  self.challenge_offendersentryturretkillcount = 0;
  self.challenge_objectivedefensivekillcount = 0;
  self.challenge_scavengedcount = 0;
  self.challenge_resuppliednamekills = 0;
  self.challenge_objectivedefensive = undefined;
  self.challenge_objectiveoffensive = undefined;
  self.challenge_lastsurvivewithflakfrom = undefined;
  self.explosiveinfo = [];
  self function_6b34141d();
}

function function_6b34141d() {
  self.weaponkillsthisspawn = [];
  self.var_341473f2 = [];
  self.var_93da0d74 = [];
  self.var_c9062c1c = [];
  self.attachmentkillsthisspawn = [];
  self.challenge_hatchettosscount = 0;
  self.challenge_hatchetkills = 0;
  self.challenge_combatrobotattackclientid = [];
  self.var_ee07421b = [];
  self.var_9cd2c51d.var_a063d754 = 0;
  self.var_3c9fd034 = undefined;
  self.var_26b87dc4 = 1;
  self.var_492785e6 = [];
  self.var_19b50427 = 0;
  self.var_9cd2c51d.var_697d048e = undefined;
  self.var_a570722a = undefined;
  self.var_e846bafa = undefined;
  self.var_1d821323 = undefined;
  self.var_4ea3d30c = undefined;
  self.var_88f25284 = undefined;
  self.var_b9962de6 = 0;
  self function_b661072d(gettime());
  self.var_88d3f4a4 = undefined;
  self.var_1022302b = undefined;
  self.var_8d93ada4 = undefined;
  self.var_aec3f150 = undefined;
}

function event_handler[weapon_change] function_edc4ebe8(eventstruct) {
  if(!isDefined(self.var_ea1458aa)) {
    return;
  }

  challengeweapon = self isusingoffhand() ? self getcurrentoffhand() : eventstruct.weapon;

  if(challengeweapon.var_76ce72e8) {
    self.var_ea1458aa.var_59ac2f5 = undefined;
    scoreevents = globallogic_score::function_3cbc4c6c(challengeweapon.var_2e4a8800);

    if(isDefined(scoreevents) && scoreevents.var_fcd2ff3a === 1) {
      self.var_ea1458aa.var_59ac2f5 = 0;
    }

    return;
  }

  if(!isDefined(level.var_ca4ce464) || level.var_ca4ce464[challengeweapon] !== 1) {
    self.var_ea1458aa.var_96d50420 = undefined;

    if(challengeweapon.issignatureweapon) {
      self.var_ea1458aa.var_96d50420 = 0;
    }
  }
}

function event_handler[offhand_fire] function_97023fdf(eventstruct) {
  if(!isDefined(self.var_ea1458aa)) {
    return;
  }

  newweapon = eventstruct.weapon;
}

function event_handler[grenade_fire] function_4776caf4(eventstruct) {
  if(!isPlayer(self)) {
    return;
  }

  newweapon = eventstruct.weapon;

  if(isDefined(self.var_9cd2c51d)) {
    if(isDefined(level.var_ca4ce464) && level.var_ca4ce464[newweapon] === 1) {
      self.var_9cd2c51d.var_d298c9a8 = undefined;

      if(newweapon.issignatureweapon) {
        self.var_9cd2c51d.var_d298c9a8 = 0;
      }
    }
  }

  if(isDefined(self.var_ea1458aa)) {
    if(isDefined(level.var_7897141a) && level.var_7897141a[newweapon] !== 1) {
      if(!newweapon.issignatureweapon) {
        self.var_ea1458aa.var_59ac2f5 = undefined;

        if(newweapon.var_76ce72e8) {
          scoreevents = globallogic_score::function_3cbc4c6c(newweapon.var_2e4a8800);

          if(isDefined(scoreevents) && scoreevents.var_fcd2ff3a === 1) {
            self.var_ea1458aa.var_59ac2f5 = 0;
          }
        }
      }
    }
  }

  if(level.var_e7c95d09 !== 1) {
    if(isDefined(eventstruct.projectile)) {
      grenade = eventstruct.projectile;
      weapon = eventstruct.weapon;

      if(weapon.rootweapon.name == "hatchet") {
        self.challenge_hatchettosscount++;
        grenade.challenge_hatchettosscount = self.challenge_hatchettosscount;
      }

      if(self issprinting()) {
        grenade.ownerwassprinting = 1;
      }
    }
  }
}

function player_fully_healed() {
  var_c3ade07c = self.var_ea1458aa;
  info = self.var_9cd2c51d;

  if(isDefined(var_c3ade07c) && isDefined(info)) {
    if(isDefined(info.var_6e219f3c) && info.var_6e219f3c <= 52) {
      if(!isDefined(var_c3ade07c.recover_full_health_from_critical)) {
        var_c3ade07c.recover_full_health_from_critical = 0;
      }

      var_c3ade07c.recover_full_health_from_critical++;

      if(var_c3ade07c.recover_full_health_from_critical >= 3) {
        self stats::function_dad108fa(#"recover_full_health_from_critical", 1);
        var_c3ade07c.recover_full_health_from_critical = undefined;
      }

      var_c3ade07c.var_55a37dc7 = 1;
    } else {
      var_c3ade07c.var_55a37dc7 = 0;
    }

    var_c3ade07c.var_a440c10 = gettime();
  }
}

function scavenged_primary_grenade(params) {
  if(!isDefined(self.challenge_scavengedcount)) {
    self.challenge_scavengedcount = 0;
  }

  self.challenge_scavengedcount++;
}

function function_2bc84a5f(var_23c2e47f) {
  if(isPlayer(self)) {
    level thread function_53813a83(self);
  }
}

function function_53813a83(player) {
  self notify("206fc3f5b15d514d");
  self endon("206fc3f5b15d514d");
  player endon(#"death", #"disconnect");

  while(!player isonground()) {
    waitframe(1);
  }

  now = gettime();
  player.var_1e1c7f1b = now;
  player function_b661072d(now);
  player.var_f469393 = now;
  player.var_99d26a94 = player.origin;
}

function event_handler[jump_begin] function_6a50096c(eventstruct) {
  self.challenge_jump_begin = gettime();
}

function event_handler[slide_end] function_d385546a(eventstruct) {
  self.challenge_slide_end = gettime();
}

function event_handler[sprint_end] function_a65ce628(eventstruct) {
  self.challenge_sprint_end = gettime();
}

function event_handler[event_4be77411] function_e62ade94(eventstruct) {
  self.var_9c19dd03 = gettime();
}

function event_handler[rappel_end] function_e51b8b9d(eventstruct) {
  self.var_21b1a39 = gettime();
}

function event_handler[ladder_begin] function_e4a87edd(eventstruct) {}

function event_handler[ladder_end] function_ffe73fe3(eventstruct) {
  self.var_d8783e02 = gettime();
}

function event_handler[event_10f46d5a] function_9873c666(eventstruct) {
  self.var_f469393 = gettime();
  self.var_99d26a94 = self.origin;
}

function function_a79ea08b(einflictor, victim, idamage, weapon) {
  if(!isPlayer(self)) {
    return;
  }

  if(!isPlayer(idamage)) {
    return;
  }

  if(!isDefined(self.team)) {
    return;
  }

  if(!isDefined(idamage.team)) {
    return;
  }

  if(!isDefined(weapon) || !isDefined(idamage.var_ea1458aa.attackerdamage)) {
    return;
  }

  if(level.teambased) {
    if(self.team == idamage.team) {
      return;
    }
  } else if(self == idamage) {
    return;
  }

  time = gettime();
  var_5afc3871 = self function_65776b07();
  killstreak = killstreaks::get_from_weapon(weapon);

  if(!isDefined(killstreak)) {
    var_6af452fc = structcopy(idamage.var_ea1458aa.attackerdamage[self.clientid]);
    var_5018995b = idamage.gadget_weapon;
    var_bcbcb4ec = isDefined(level.var_49ef5263) ? idamage[[level.var_49ef5263]]() : 0;
    var_fff76b4 = idamage.var_b6672e47;
    totalenemies = countplayers(idamage.team);
    victimentnum = idamage getentitynumber();
    var_3cd641b = var_6af452fc.class_num;
    isprimaryweapon = weapon.statname == self function_b958b70d(var_3cd641b, "primary");
    var_197329e6 = weapon.statname == self function_b958b70d(var_3cd641b, "secondary");
    scoreevents = globallogic_score::function_3cbc4c6c(weapon.var_2e4a8800);
    var_8a4cfbd = weapon.var_76ce72e8 && isDefined(scoreevents) && scoreevents.var_fcd2ff3a === 1;

    if(isDefined(self.var_9cd2c51d)) {
      if(weapon.issignatureweapon && isDefined(level.var_ca4ce464) && level.var_ca4ce464[weapon] === 1) {
        if(!isDefined(self.var_9cd2c51d.var_d298c9a8)) {
          self.var_9cd2c51d.var_d298c9a8 = 0;
        }

        self.var_9cd2c51d.var_d298c9a8++;

        if(self.var_9cd2c51d.var_d298c9a8 % 4 == 0) {
          var_828dac8f = 1;
        }
      }
    }

    if(!isDefined(var_828dac8f)) {
      if(weapon.issignatureweapon && isDefined(self.var_ea1458aa.var_96d50420)) {
        if(!isDefined(self.var_9cd2c51d.var_96d50420)) {
          self.var_9cd2c51d.var_96d50420 = 0;
        }

        self.var_ea1458aa.var_96d50420++;

        if(self.var_ea1458aa.var_96d50420 % 4 == 0) {
          var_828dac8f = 1;
        }
      } else if(var_8a4cfbd && isDefined(self.var_ea1458aa.var_59ac2f5)) {
        if(!isDefined(self.var_9cd2c51d.var_59ac2f5)) {
          self.var_9cd2c51d.var_59ac2f5 = 0;
        }

        self.var_ea1458aa.var_59ac2f5++;

        if(self.var_ea1458aa.var_59ac2f5 % 4 == 0) {
          var_828dac8f = 1;
        }
      }
    }

    var_ffe9dfa5 = self weaponhasattachmentandunlocked(weapon, "extclip");

    if(var_ffe9dfa5) {
      if(!isDefined(self.var_ea1458aa.var_23f5861b)) {
        self.var_ea1458aa.var_23f5861b = 0;
      }

      self.var_ea1458aa.var_23f5861b++;
    }

    if(totalenemies >= 4) {
      if(!isDefined(self.var_ea1458aa.ekia_every_enemy_onelife)) {
        self.var_ea1458aa.ekia_every_enemy_onelife = [];
      }

      self.var_ea1458aa.ekia_every_enemy_onelife[victimentnum] = 1;

      if(self.var_ea1458aa.ekia_every_enemy_onelife.size >= totalenemies) {
        var_2adaec2f = 1;
        self.var_ea1458aa.ekia_every_enemy_onelife = undefined;
      }
    }

    if(isDefined(level.var_1aef539f) && [[level.var_1aef539f]](idamage, self)) {
      var_1f0bdb8f = 1;
    }

    var_70137a58 = structcopy(self.var_ea1458aa);

    if(!isDefined(var_5afc3871[#"talent_resistance"])) {
      var_2d4a24ea = self.var_ef9b6f0b === 1;
      var_6c5ba24c = self.lastflashedby === idamage;

      if(isDefined(self.var_121392a1) && isDefined(self.var_121392a1[#"shock_seeker_mine"])) {
        if(self.var_121392a1[#"shock_seeker_mine"].var_4b22e697 === idamage) {
          var_ba9c5900 = 1;
        }
      }
    }

    var_30f88120 = scoreevents::function_c28e2c05(idamage.origin, var_6af452fc.sensordarts, 0);

    switch (weapon.statname) {
      case # "ar_mobility_t9":
      case # "smg_handling_t9":
        self stats::function_42277145(#"hash_76bf58f08a08d598", 1);
        break;
      case # "ar_damage_t9":
      case # "smg_burst_t9":
      case # "shotgun_pump_t9":
        self stats::function_42277145(#"hash_734f1d49f5395c1", 1);
        break;
      case # "smg_heavy_t9":
      case # "ar_standard_t9":
        self stats::function_42277145(#"hash_777767b99c350232", 1);
        break;
      default:
        break;
    }

    switch (weapon.statname) {
      case # "smg_burst_t9":
      case # "ar_british_t9":
        self stats::function_42277145(#"hash_24abaa59aafa466b", 1);
        break;
      case # "ar_slowhandling_t9":
      case # "smg_heavy_t9":
      case # "lmg_light_t9":
        self stats::function_42277145(#"hash_3d9159bfdb045054", 1);
        break;
      case # "special_grenadelauncher_t9":
      case # "smg_standard_t9":
        self stats::function_42277145(#"hash_3a26c6202d86ed8d", 1);
        break;
      default:
        break;
    }

    switch (weapon.statname) {
      case # "pistol_fullauto_t9":
      case # "ar_british_t9":
      case # "smg_handling_t9":
        self stats::function_42277145(#"hash_7208e21496453ace", 1);
        break;
      default:
        break;
    }
  }

  data = idamage.var_1318544a;

  if(!isDefined(data)) {
    return;
  }

  var_89775a8e = self util::function_14e61d05();
  var_21409def = self util::function_5e7e010();
  var_b0ca1732 = self hasperk(#"specialty_paranoia");
  var_ca5827fd = self hasperk(#"specialty_tracker");
  var_f22bbd84 = self hasperk(#"specialty_flakjacket");
  var_4e8a56b1 = self isinvehicle() && !self isremotecontrolling();
  var_7ca8dd34 = 0;

  if(!var_4e8a56b1 && isDefined(killstreak)) {
    switch (killstreak) {
      case # "hoverjet":
      case # "inventory_chopper_gunner":
      case # "chopper_gunner":
      case # "inventory_ac130":
      case # "ac130":
      case # "inventory_hoverjet":
        var_7ca8dd34 = 1;
        break;
      default:
        break;
    }
  }

  if(var_4e8a56b1 || var_7ca8dd34) {
    attackervehicle = self getvehicleoccupied();
    var_d7b43cfe = attackervehicle.vehicleclass === "4 wheel" || attackervehicle.vehicleclass === "motorcycle" || attackervehicle.vehicleclass === "tank";
    var_c48b1869 = isairborne(attackervehicle);
  }

  var_cf99d005 = idamage.laststand === 1;
  util::waittillslowprocessallowed();

  if(!isPlayer(self)) {
    return;
  }

  if(!isPlayer(idamage)) {
    return;
  }

  self stats::function_dad108fa(#"ekia_s1", 1);
  self stats::function_dad108fa(#"hash_64f7d07880a0dc03", 1);

  if(getdvarint(#"hash_1ad35129069d0b0a", 0)) {
    self stats::function_bcf9602(#"hash_47351685227336cc", 1, #"hash_5c49df97f4f82e12");
  }

  self stats::function_bcf9602(#"hash_5a96ee436e73190", 1, #"hash_6abe83944d701459");

  if(!isDefined(killstreak)) {
    weaponclass = util::getweaponclass(weapon);

    if(isDefined(var_3cd641b)) {
      if(isprimaryweapon) {
        self stats::function_dad108fa(#"ekia_primary_secondary_weapon", 1);
        self stats::function_dad108fa(#"hash_403bf319c5b8aa47", 1);

        if(weapon.attachments.size > 2) {
          self stats::function_dad108fa(#"hash_6803083fa39064a4", 1);
        }
      } else if(var_197329e6) {
        self stats::function_dad108fa(#"ekia_primary_secondary_weapon", 1);
        self stats::function_dad108fa(#"hash_1d965783ae1b802", 1);
        self stats::function_dad108fa(#"hash_71b8e34a1ad838f8", 1);
        self stats::function_dad108fa(#"hash_71b8e54a1ad83c5e", 1);
        self stats::function_dad108fa(#"hash_b584efad55d38c4", 1);

        if(weapon.attachments.size > 2) {
          self stats::function_dad108fa(#"hash_7b0b54996f4aafbc", 1);
        }

        if(util::function_ed82a8a(weapon).loadoutslotname === "primary") {
          self stats::function_dad108fa(#"hash_73961fa132aff2ba", 1);
        }
      }

      talents = self function_4a9f1384(var_3cd641b);

      if(isDefined(talents) && isarray(talents)) {
        if(self function_db654c9(var_3cd641b, #"bonuscard_perk_1_greed")) {
          if(isDefined(talents[0]) && talents[0] != # "weapon_null" && isDefined(talents[3]) && talents[3] != # "weapon_null") {
            self stats::function_dad108fa(#"ekia_perk1_greed", 1);
            self contracts::increment_contract(#"hash_714a511ec2adab44");
          }
        }

        if(self function_db654c9(var_3cd641b, #"bonuscard_perk_2_greed")) {
          if(isDefined(talents[1]) && talents[1] != # "weapon_null" && isDefined(talents[4]) && talents[4] != # "weapon_null") {
            self stats::function_dad108fa(#"ekia_perk2_greed", 1);
          }
        }

        if(self function_db654c9(var_3cd641b, #"bonuscard_perk_3_greed")) {
          if(isDefined(talents[2]) && talents[2] != # "weapon_null" && isDefined(talents[5]) && talents[5] != # "weapon_null") {
            self stats::function_dad108fa(#"ekia_perk3_greed", 1);
          }
        }

        arrayremovevalue(talents, #"weapon_null");

        if(talents.size > 2) {
          var_ee03db9e = 0;

          if(self function_db654c9(var_3cd641b, #"bonuscard_perk_1_gluttony")) {
            self stats::function_dad108fa(#"ekia_perk1_gluttony", 1);
            var_ee03db9e = 1;
          } else if(self function_db654c9(var_3cd641b, #"bonuscard_perk_2_gluttony")) {
            self stats::function_dad108fa(#"ekia_perk2_gluttony", 1);
            var_ee03db9e = 1;
          } else if(self function_db654c9(var_3cd641b, #"bonuscard_perk_3_gluttony")) {
            self stats::function_dad108fa(#"ekia_perk3_gluttony", 1);
            var_ee03db9e = 1;
          }

          if(var_ee03db9e) {
            self contracts::increment_contract(#"contract_mp_class_gluttony");
          }
        }

        if(talents.size >= 5) {
          self contracts::increment_contract(#"contract_mp_class_5_perks");
        }

        if(isDefined(var_5afc3871[#"talent_resistance"])) {
          if(var_6af452fc.var_5745c480 === 1) {
            self stats::function_dad108fa(#"ekia_stunned_slowed_irradiated_cuav_resistance", 1);
          } else if(isDefined(var_6af452fc.var_121392a1) && isarray(var_6af452fc.var_121392a1) && var_6af452fc.var_121392a1.size > 0) {
            foreach(effect in var_6af452fc.var_121392a1) {
              if(!isDefined(effect.var_4b22e697) || self == effect.var_4b22e697 || !isDefined(effect.var_3d1ed4bd)) {
                continue;
              }

              switch (effect.var_3d1ed4bd.name) {
                case # "ability_smart_cover":
                case # "eq_swat_grenade":
                case # "hash_3f62a872201cd1ce":
                case # "eq_seeker_mine":
                case # "eq_concertina_wire":
                case # "eq_slow_grenade":
                case # "gadget_radiation_field":
                  award = 1;
                  break;
                default:
                  break;
              }

              if(award === 1) {
                self stats::function_dad108fa(#"ekia_stunned_slowed_irradiated_cuav_resistance", 1);
                break;
              }
            }
          }
        }

        if(var_6af452fc.var_53611a9c === 1) {
          if(isDefined(var_5afc3871[#"talent_teamlink"])) {
            self stats::function_dad108fa(#"ekia_minimap_teamlink", 1);
          }

          if(isDefined(var_5afc3871[#"talent_tracker"])) {
            self stats::function_dad108fa(#"ekia_tracker", 1);
          }
        } else if(isDefined(var_5afc3871[#"talent_teamlink"]) && var_6af452fc.var_ec93e5f2 === 1) {
          self stats::function_dad108fa(#"ekia_minimap_teamlink", 1);
        }

        if(isDefined(var_5afc3871[#"talent_deadsilence"])) {
          self stats::function_dad108fa(#"ekia_deadsilence", 1);
        }

        if(isDefined(var_5afc3871[#"talent_ghost"])) {
          if(var_6af452fc.var_8e35fb71 === 1 || var_6af452fc.var_efc9cf4d === 1) {
            self stats::function_dad108fa(#"ekia_enemy_uav_sensordart_ghost", 1);
          }

          self stats::function_bcf9602(#"hash_513bcb963a91d81b", 1, #"hash_735ace6b22542a65");
        }

        if(isDefined(var_5afc3871[#"talent_gungho"]) && var_6af452fc.var_e8072c8d === 1) {
          self stats::function_dad108fa(#"hash_cdd16b48f26b85f", 1);
        }

        if(isDefined(var_5afc3871[#"talent_dexterity"])) {
          if(var_6af452fc.ismantling === 1 || var_6af452fc.var_bd77a1eb === 1 || var_6af452fc.isjumping === 1) {
            self stats::function_dad108fa(#"ekia_swap_weapon_jump_mantle_dexterity", 1);
          }
        }

        if(isDefined(var_5afc3871[#"talent_scavenger"]) && var_6af452fc.var_54433d4b === 1) {
          self stats::function_dad108fa(#"ekia_ammo_pickup_scavenger", 1);
        }

        if(isDefined(var_5afc3871[#"talent_coldblooded"])) {
          self stats::function_dad108fa(#"hash_1e0aca21e6c6e00c", 1);
          self stats::function_dad108fa(#"hash_3035a5f29811a3f9", 1);
        }
      }

      wildcards = self function_6f2c0492(var_3cd641b);
      arrayremovevalue(wildcards, #"weapon_null");

      if(wildcards.size > 1) {
        self stats::function_dad108fa(#"hash_3c794263f2d7e231", 1);
      }

      gear = self function_b958b70d(var_3cd641b, "tacticalgear");

      if(isDefined(gear)) {
        switch (gear) {
          case # "gear_armor":
            if(var_6af452fc.var_d7bd6f9b === 1) {
              self stats::function_dad108fa(#"ekia_against_armor_damager", 1);
            }

            break;
          case # "gear_awareness":
            minimaprange = function_fd82b127() * 0.5;

            if(var_6af452fc.var_85997af0 < sqr(minimaprange)) {
              self stats::function_dad108fa(#"ekia_minimap_awareness", 1);

              if(isDefined(var_5afc3871[#"talent_tracker"]) && var_6af452fc.var_53611a9c === 1) {
                self stats::function_dad108fa(#"ekia_minimap_awareness_tracker", 1);
              }
            }

            break;
          case # "gear_equipmentcharge":
            scoreevents = globallogic_score::function_3cbc4c6c(weapon.var_2e4a8800);
            baseweapon = weapons::getbaseweapon(weapon);

            if(baseweapon.var_76ce72e8 && isDefined(scoreevents) && scoreevents.var_fcd2ff3a === 1) {
              self stats::function_dad108fa(#"ekia_specialist_equipment_equipmentcharge", 1);

              if(!isDefined(self.var_9cd2c51d.var_b385927)) {
                self.var_9cd2c51d.var_b385927 = 0;
              }

              self.var_9cd2c51d.var_b385927++;

              if(self.var_9cd2c51d.var_b385927 == 7) {
                self stats::function_dad108fa(#"hash_7db6a4180312b94c", 1);
              }
            }

            break;
          case # "gear_medicalinjectiongun":
            if(var_6af452fc.var_46a82df0 === 1) {
              self stats::function_dad108fa(#"ekia_full_heal_medicalinjectiongun", 1);

              if(var_6af452fc.var_69b66e8e === 1) {
                self stats::function_dad108fa(#"ekia_critical_heal_medicalinjectiongun_revenge", 1);
              }
            }

            break;
          case # "weapon_null":
          default:
            break;
        }
      }
    }

    if(isDefined(level.gametype) && (level.gametype == # "tdm" || level.gametype == # "dm")) {
      if(level.hardcoremode) {
        self stats::function_dad108fa(#"ekia_hc_in_tdm_dm", 1);
      } else if(!level.arenamatch) {
        self stats::function_dad108fa(#"ekia_core_in_tdm_dm", 1);
      }
    }

    if(isDefined(weaponclass)) {
      switch (weaponclass) {
        case # "weapon_tactical":
          if(weapon.name === # "tr_powerburst_t9") {
            break;
          }
        case # "weapon_pistol":
        case # "weapon_shotgun":
        case # "weapon_lmg":
        case # "weapon_smg":
        case # "weapon_cqb":
        case # "weapon_assault":
          if(!function_cd84dead(weapon, "optic")) {
            var_b77ad7ec = 1;
          }

          break;
        case # "weapon_sniper":
          if(self weaponhasattachmentandunlocked(weapon, "elo")) {
            var_b77ad7ec = 1;
          }

          break;
        default:
          break;
      }

      if(var_b77ad7ec === 1) {
        self stats::function_dad108fa(#"hash_5c41a492b47fc297", 1);

        if(data.smeansofdeath === "MOD_HEAD_SHOT") {
          self stats::function_dad108fa(#"hash_3f8f3c056d0347a8", 1);
        }
      }
    }

    switch (weapon.firetype) {
      case # "full auto":
        if(data.smeansofdeath == "MOD_PISTOL_BULLET" || data.smeansofdeath == "MOD_RIFLE_BULLET" || data.smeansofdeath == "MOD_HEAD_SHOT") {
          self stats::function_dad108fa(#"hash_365e781f4a2d8599", 1);
          self stats::function_dad108fa(#"hash_41d7899e04e68759", 1);
        }

        break;
      default:
        break;
    }

    if(isDefined(weapon.attachments) && weapon.attachments.size > 0) {
      isads = is_true(var_6af452fc.isads);

      if(weapon.attachments.size >= 5) {
        self stats::function_dad108fa(#"hash_36dfb920467c2f92", 1);
        self stats::function_dad108fa(#"hash_4ef7534ca1c8f27b", 1);
      }

      if(self weaponhasattachmentandunlocked(weapon, "light")) {
        self contracts::increment_contract(#"hash_2e1bfcaefd254812");
      }

      if(self weaponhasattachmentandunlocked(weapon, "steadyaim") || self weaponhasattachmentandunlocked(weapon, "steadyaim2") || self weaponhasattachmentandunlocked(weapon, "mixbody2")) {
        self contracts::increment_contract(#"hash_6114067f8444fe37");
        self stats::function_dad108fa(#"hash_231dd7ca6b97126", 1);

        if(!isads && weaponclass === # "weapon_smg") {
          self stats::function_dad108fa(#"hash_515c3ec5c8a5d793", 1);
        }
      }

      var_8a4dd851 = 0;

      if(self weaponhasattachmentandunlocked(weapon, "extclip") || self weaponhasattachmentandunlocked(weapon, "extclip2")) {
        var_8a4dd851 = 1;

        switch (weapon.name) {
          case # "tr_fastburst_t9":
          case # "smg_burst_t9":
          case # "ar_slowfire_t9":
          case # "tr_powerburst_t9":
          case # "smg_standard_t9":
          case # "smg_heavy_t9":
          case # "smg_fastfire_t9":
          case # "smg_spray_t9":
          case # "ar_mobility_t9":
          case # "smg_handling_t9":
          case # "shotgun_fullauto_t9":
            self contracts::increment_contract(#"hash_6a3f7e63a5f3991f");

            if(weaponclass === # "weapon_smg") {
              self stats::function_dad108fa(#"hash_37ca29310542d08e", 1);
            }

            break;
        }
      }

      if(self weaponhasattachmentandunlocked(weapon, "mixclip") || self weaponhasattachmentandunlocked(weapon, "mixclip2")) {
        var_8a4dd851 = 1;

        switch (weapon.name) {
          case # "lmg_accurate_t9":
          case # "lmg_light_t9":
            self contracts::increment_contract(#"hash_6a3f7e63a5f3991f");
            break;
        }
      }

      if(var_8a4dd851) {
        if(weaponclass === # "weapon_assault") {
          self stats::function_dad108fa(#"hash_414c5885507e9aa6", 1);
        }

        self stats::function_dad108fa(#"hash_2932bf9faf2f8a4d", 1);
        self stats::function_dad108fa(#"hash_15512193d31af0cc", 1);
      }

      if(self weaponhasattachmentandunlocked(weapon, "sprintout")) {
        if(weaponclass === # "weapon_cqb") {
          switch (weapon.name) {
            case # "shotgun_pump_t9":
              break;
            default:
              self stats::function_dad108fa(#"hash_71804c7bbbaad1f6", 1);
              break;
          }
        }
      }

      if(self weaponhasattachmentandunlocked(weapon, "sprintout2")) {
        switch (weapon.name) {
          case # "tr_fastburst_t9":
          case # "sniper_powersemi_t9":
          case # "ar_fastfire_t9":
          case # "sniper_quickscope_t9":
          case # "ar_slowfire_t9":
          case # "tr_powerburst_t9":
          case # "tr_longburst_t9":
          case # "sniper_standard_t9":
          case # "smg_spray_t9":
          case # "ar_fasthandling_t9":
          case # "ar_mobility_t9":
          case # "sniper_cannon_t9":
          case # "ar_standard_t9":
          case # "smg_handling_t9":
            break;
          default:
            self contracts::increment_contract(#"hash_73b57ed83e48a782");

            if(weaponclass === # "weapon_smg") {
              self stats::function_dad108fa(#"hash_62c4816f8e75e33", 1);
            } else if(weaponclass === # "weapon_cqb") {
              self stats::function_dad108fa(#"hash_67e2e956f75df47a", 1);
            }

            break;
        }
      }

      var_75de4d7b = self getweaponoptic(weapon);

      if(var_75de4d7b != "") {
        var_e5a434eb = function_2edf4eec(weapon);

        if(var_e5a434eb > 1.9) {
          self stats::function_dad108fa(#"hash_40c77418f9182719", 1);
          self contracts::increment_contract(#"hash_7591ac5acde94624");
          self stats::function_dad108fa(#"hash_6e8aebca8a7e908d", 1);

          if(weaponclass === # "weapon_tactical") {
            self stats::function_dad108fa(#"hash_4d1dfcd775e80c6d", 1);
          }

          if(var_e5a434eb > 3.9) {
            self contracts::increment_contract(#"hash_299fe10aa21712ea");
          }
        }

        switch (var_75de4d7b) {
          case # "ir":
            self stats::function_dad108fa(#"hash_4c52eb020ea39538", 1);
            self contracts::increment_contract(#"hash_24754d0ed68133e3");
            self stats::function_dad108fa(#"hash_4aec80d782b89cf5", 1);
            break;
          case # "smoothzoom2":
          case # "dualoptic":
          case # "smoothzoom":
            self contracts::increment_contract(#"hash_445fb44209fddf36");
            break;
        }
      }

      attachmentupgrades = 0;

      if(self weaponhasattachmentandunlocked(weapon, "grip")) {
        if(isads) {
          self stats::function_dad108fa(#"ekia_ads_grip", 1);
        }

        if(self weaponhasattachmentandunlocked(weapon, "grip2")) {
          attachmentupgrades++;
        }
      }

      if(function_cd84dead(weapon, "underbarrel")) {
        self stats::function_dad108fa(#"hash_315eb81146ec9089", 1);
      }

      if(self weaponhasattachmentandunlocked(weapon, "quickdraw")) {
        if(isads) {
          self stats::function_dad108fa(#"ekia_ads_quickdraw", 1);
        }

        if(self weaponhasattachmentandunlocked(weapon, "quickdraw2")) {
          attachmentupgrades++;
        }

        self stats::function_dad108fa(#"hash_3f9ba286e92137dd", 1);
      }

      if(self weaponhasattachmentandunlocked(weapon, "stalker")) {
        if(isads) {
          self stats::function_dad108fa(#"ekia_ads_stalker", 1);
        }

        if(self weaponhasattachmentandunlocked(weapon, "stalker2")) {
          attachmentupgrades++;
        }
      }

      if(isads) {
        if(self weaponhasattachmentandunlocked(weapon, "quickdraw", "stalker", "grip")) {
          self stats::function_dad108fa(#"ekia_ads_quickdraw_stalker_grip", 1);
        }
      }

      if(var_ffe9dfa5 == 1) {
        if(var_70137a58.var_23f5861b % 2 == 0) {
          self stats::function_dad108fa(#"hash_779e1fc5021c532c", 1);
        }

        if(self weaponhasattachmentandunlocked(weapon, "extclip2")) {
          attachmentupgrades++;
        }
      }

      if(self weaponhasattachmentandunlocked(weapon, "steadyaim")) {
        if(var_6af452fc.var_bd77a1eb === 1) {
          if(isDefined(var_3cd641b) && isDefined(var_5afc3871[#"talent_dexterity"]) && self function_db654c9(var_3cd641b, #"bonuscard_overkill")) {
            if(!isDefined(self.var_9cd2c51d.var_1a72ebf5)) {
              self.var_9cd2c51d.var_1a72ebf5 = 0;
            }

            self.var_9cd2c51d.var_1a72ebf5++;

            if(self.var_9cd2c51d.var_1a72ebf5 == 5) {
              self stats::function_dad108fa(#"hash_6c13ae81deff608b", 1);
            }
          }
        }

        if(self weaponhasattachmentandunlocked(weapon, "steadyaim2")) {
          attachmentupgrades++;
        }
      }

      if(self weaponhasattachmentandunlocked(weapon, "fastreload")) {
        self stats::function_dad108fa(#"ekia_fastreload_mixclip", 1);

        if(weaponclass === # "weapon_launcher") {
          self stats::function_dad108fa(#"hash_4b19afce40dfc918", 1);
        }

        if(self weaponhasattachmentandunlocked(weapon, "fastreload2")) {
          attachmentupgrades++;

          if(isads && var_6af452fc.var_14f058c7 === 1 && self weaponhasattachmentandunlocked(weapon, "quickdraw")) {
            self stats::function_dad108fa(#"ekia_ads_reload_quickdraw_fastreload2", 1);
          }
        }
      }

      if(self weaponhasattachmentandunlocked(weapon, "mixclip")) {
        self stats::function_dad108fa(#"ekia_fastreload_mixclip", 1);
      }

      if(attachmentupgrades < 2) {
        if(self weaponhasattachmentandunlocked(weapon, "barrel", "barrel2")) {
          attachmentupgrades++;
        }
      }

      if(attachmentupgrades == 1) {
        self stats::function_dad108fa(#"hash_51430fd20ccb2b05", 1);
      } else if(attachmentupgrades > 1) {
        self stats::function_dad108fa(#"hash_6c36aa2d7d6f2b4", 1);
      }
    }

    if(isDefined(var_5018995b) && var_5018995b.statname == # "gadget_radiation_field" && (!isDefined(var_6af452fc.var_75c08813) || var_6af452fc.var_75c08813 < 1)) {
      self stats::function_dad108fa(#"radiation_field_shutdown_ekia", 1);
    }

    if(var_bcbcb4ec === 1) {
      self stats::function_dad108fa(#"kill_enemy_who_has_goldenammo", 1);
    }

    if(var_fff76b4 === 1) {
      self stats::function_dad108fa(#"kill_enemy_who_has_bonus_health", 1);
    }

    if(!isDefined(var_5afc3871[#"talent_resistance"])) {
      if(var_2d4a24ea) {
        if(var_6c5ba24c) {
          self stats::function_dad108fa(#"kill_enemy_who_stunned_you_during_stun", 1);
        }
      }

      if(var_ba9c5900 === 1) {
        self stats::function_dad108fa(#"kill_enemy_who_stunned_you_during_stun", 1);
      }
    }

    if(isDefined(var_70137a58.var_64ffda50)) {
      var_f4917629 = var_70137a58.var_64ffda50[victimentnum];

      if(isDefined(var_f4917629) && var_f4917629 + 6000 > time) {
        self stats::function_dad108fa(#"kill_after_shot_in_back", 1);
      }
    }

    if(weapon != level.weaponnone) {
      if(isDefined(self.pickedupweapons) && isDefined(self.pickedupweapons[weapon]) && isDefined(self.var_c9062c1c)) {
        var_eef88563 = self.pickedupweapons[weapon];

        if(var_eef88563 >= 0 && var_eef88563 == victimentnum) {
          if(!isDefined(self.var_c9062c1c[weapon])) {
            self.var_c9062c1c[weapon] = [];
          }

          if(!isDefined(self.var_c9062c1c[weapon][var_eef88563])) {
            self.var_c9062c1c[weapon][var_eef88563] = 0;
          }

          self.var_c9062c1c[weapon][var_eef88563]++;
        }

        if(isDefined(self.var_93da0d74[weapon])) {
          self.var_93da0d74[weapon]++;

          if(self.var_93da0d74[weapon] >= 5 && isDefined(self.var_c9062c1c[weapon]) && var_eef88563 == victimentnum && self.var_c9062c1c[weapon][var_eef88563] > 0) {
            self stats::function_dad108fa(#"killstreak_5_picked_up_weapon", 1);
            self.var_93da0d74[weapon] -= 5;
            self.var_c9062c1c[weapon][var_eef88563]--;
          }
        } else {
          self.var_93da0d74[weapon] = 1;
        }

        self contracts::increment_contract(#"hash_48fef2dc09d2af16");
        self stats::function_dad108fa(#"hash_1e868415652219af", 1);
        weaponowner = getentbynum(var_eef88563);

        if(util::function_fbce7263(weaponowner.team, self.team)) {
          self stats::function_dad108fa(#"hash_760f298458773e70", 1);
        }
      }
    }

    if(var_2adaec2f === 1) {
      self stats::function_dad108fa(#"ekia_every_enemy_onelife", 1);
    }

    if(var_1f0bdb8f === 1) {
      self stats::function_dad108fa(#"hash_3bf4605458c33226", 1);
    }

    if(var_8a4cfbd) {
      self stats::function_dad108fa(#"ekia_specialized_equipment", 1);
    } else if(weapon.issignatureweapon) {
      self stats::function_dad108fa(#"ekia_specialized_weapons", 1);
    }

    if(var_6af452fc.var_9a5c07a === 1) {
      if(var_6af452fc.var_79eb9a59 === self) {
        self stats::function_dad108fa(#"ekia_debuffed_enemies_specialized_weapon_equipment", 1);
        var_38a1a18 = 1;
      }
    }

    if(!(var_38a1a18 === 1) && isDefined(var_6af452fc.sensor_darts)) {
      if(isDefined(var_30f88120)) {
        self stats::function_dad108fa(#"ekia_debuffed_enemies_specialized_weapon_equipment", 1);
        var_38a1a18 = 1;
      }
    }

    if(!(var_38a1a18 === 1) && isDefined(var_6af452fc.var_2acdce3e)) {
      foreach(effect in var_6af452fc.var_2acdce3e) {
        if(!isDefined(effect.var_4b22e697) || self != effect.var_4b22e697 || !isDefined(effect.var_3d1ed4bd)) {
          continue;
        }

        switch (effect.var_3d1ed4bd.name) {
          case # "shock_rifle":
          case # "ability_smart_cover":
          case # "eq_swat_grenade":
          case # "hash_3f62a872201cd1ce":
          case # "eq_seeker_mine":
          case # "eq_concertina_wire":
          case # "hero_flamethrower":
          case # "gadget_radiation_field":
            award = 1;
            break;
          default:
            break;
        }

        if(award === 1) {
          self stats::function_dad108fa(#"ekia_debuffed_enemies_specialized_weapon_equipment", 1);
          break;
        }
      }
    }

    if(var_828dac8f === 1) {
      self stats::function_dad108fa(#"hash_23d2a4d333f13590", 1);
    }

    if(weapon.issniperweapon) {
      self function_38ad2427(#"hash_1593f24b861eb245", 1);
    }

    if(weapon.isdualwield && weaponclass === # "weapon_pistol") {
      self contracts::increment_contract(#"hash_1c53a42892bbff2a");
    }

    if(weapon.var_a9a55985) {
      self stats::function_dad108fa(#"hash_6f4a03c7df254b96", 1);
      self contracts::increment_contract(#"hash_46fe92531db42ce1");

      if(weaponclass === # "weapon_smg") {
        self stats::function_dad108fa(#"hash_33fd6fbea2e1d112", 1);
      } else if(weaponclass === # "weapon_pistol") {
        self stats::function_dad108fa(#"hash_369bb5d15d4b680d", 1);
      }
    }

    if(var_89775a8e) {
      self stats::function_dad108fa(#"hash_200b9eaa7df992a8", 1);
      self stats::function_dad108fa(#"hash_6be4fc5f3e98048c", 1);
    }

    if(var_f22bbd84) {
      self stats::function_dad108fa(#"hash_345a3aa1489f6839", 1);
      self stats::function_dad108fa(#"hash_1cf4be42778c8b60", 1);
      self stats::function_dad108fa(#"hash_1cf4c542778c9745", 1);
      self stats::function_dad108fa(#"hash_1cf4c442778c9592", 1);
    }

    if(var_21409def) {
      self stats::function_dad108fa(#"hash_63b656007f0362c4", 1);
    }

    if(var_b0ca1732) {
      self stats::function_dad108fa(#"hash_41fbdc6f4aa1a875", 1);
      self stats::function_dad108fa(#"hash_16b2c41d0ccb0961", 1);
      self stats::function_dad108fa(#"hash_1c68fbe2a42d2b26", 1);
      self stats::function_dad108fa(#"hash_1c68fae2a42d2973", 1);
    }

    if(var_ca5827fd) {
      self stats::function_dad108fa(#"hash_2cceb05c88366b28", 1);
      self stats::function_dad108fa(#"hash_300c58880c01bf58", 1);
      self stats::function_dad108fa(#"hash_661621bdcf8b9cf3", 1);
      self stats::function_dad108fa(#"hash_661627bdcf8ba725", 1);
    }

    if(data.var_e020b97e === 1 && data.var_af1b39cb === self && data.var_ac7c0ef7 !== 1) {
      self stats::function_dad108fa(#"hash_19868ed34c58dae", 1);
    }

    weaponclass = util::getweaponclass(weapon);

    if(isDefined(weaponclass)) {
      weaponclass = isstring(weaponclass) ? hash(weaponclass) : weaponclass;
      optic = self getweaponoptic(weapon);

      if(!isDefined(optic)) {
        optic = "";
      }

      switch (weaponclass) {
        case # "weapon_cqb":
          self stats::function_dad108fa(#"hash_496927d497fdf692", 1);
          self stats::function_dad108fa(#"hash_24f356ecf6fb6c0e", 1);
          self stats::function_dad108fa(#"hash_36a1f1959ae7445e", 1);
          self stats::function_dad108fa(#"hash_36a1ef959ae740f8", 1);
          break;
        case # "weapon_assault":
          self stats::function_dad108fa(#"hash_64d78a0e86ba8b55", 1);
          self stats::function_dad108fa(#"hash_41393b0369e02954", 1);
          self stats::function_dad108fa(#"hash_3d11f2e0b14e9cac", 1);
          self stats::function_dad108fa(#"hash_173e56cb34460575", 1);
          self stats::function_dad108fa(#"hash_173e55cb344603c2", 1);
          self stats::function_dad108fa(#"hash_173e54cb3446020f", 1);
          break;
        case # "weapon_lmg":
          self stats::function_dad108fa(#"hash_52aa8f35541651b8", 1);
          self stats::function_dad108fa(#"hash_49b83486e6f9bc38", 1);
          self stats::function_dad108fa(#"hash_1a83f392aff69fc3", 1);
          self stats::function_dad108fa(#"hash_10f2c3998c0efe9c", 1);
          self stats::function_dad108fa(#"hash_10f2c4998c0f004f", 1);
          self stats::function_dad108fa(#"hash_10f2c5998c0f0202", 1);
          break;
        case # "weapon_pistol":
          self stats::function_dad108fa(#"hash_50ce2207b80f9fa5", 1);
          self stats::function_dad108fa(#"hash_48f5753f9361f31", 1);
          self stats::function_dad108fa(#"hash_73d936b41c0e7db3", 1);

          switch (optic) {
            case # "elo":
            case # "elo2":
              self stats::function_dad108fa(#"hash_39d29f9c4fe7e54e", 1);
              break;
            default:
              break;
          }

          break;
        case # "weapon_smg":
          self stats::function_dad108fa(#"hash_26e871c3fec523d3", 1);
          self stats::function_dad108fa(#"hash_54112cceeab59f46", 1);
          self stats::function_dad108fa(#"hash_62c4e16f8e76865", 1);
          self stats::function_dad108fa(#"hash_5004dee0210ef879", 1);
          break;
        case # "weapon_tactical":
          self stats::function_dad108fa(#"hash_94d913babcd584", 1);
          self stats::function_dad108fa(#"hash_4f45ca1828646934", 1);
          self stats::function_dad108fa(#"hash_380d0317d7caf20", 1);
          self stats::function_dad108fa(#"hash_2db210a1cfea8647", 1);
          break;
        case # "weapon_sniper":
          self stats::function_dad108fa(#"hash_5f8a23bbf07a8769", 1);
          self stats::function_dad108fa(#"hash_607598d00d891bd0", 1);
          self stats::function_dad108fa(#"hash_61a2b2e6028a56e8", 1);
          break;
        case # "weapon_special":
          self stats::function_dad108fa(#"hash_9cb2805c8c9d8fb", 1);
          self contracts::increment_contract(#"hash_5b4412649ebfeba5");
          self stats::function_dad108fa(#"hash_d6e068459b6a04b", 1);
          self stats::function_dad108fa(#"hash_9cb2e05c8c9e32d", 1);

          if(!isDefined(self.pers[#"hash_43c816413d480a82"]) && self function_c9e4f73f(5, #"hash_43c816413d480a82", #"hash_5c6e56538689d991")) {
            self stats::function_d0de7686(#"hash_6c9ea22e0bd57fc1", 1, #"hash_4edbfffde3c9a22e");
          }

          break;
        default:
          break;
      }
    }

    if(weaponclass === # "weapon_pistol") {
      if(!isDefined(self.pers[#"hash_31c0f65353df667e"]) && self function_c9e4f73f(5, #"hash_31c0f65353df667e", #"hash_55fb8a49a1f8330a")) {
        self stats::function_d0de7686(#"hash_5e3e453862ca1816", 1, "weapon_unlock_challenge_enabled_pm63");
      }

      if(weapon.isdualwield) {
        self stats::function_dad108fa(#"hash_5fb1bddfef22fc62", 1);
      }
    }

    if(var_cf99d005) {
      self stats::function_dad108fa(#"hash_7f05b25034ae349f", 1);
      self stats::function_dad108fa(#"hash_5df87ce6dd360abf", 1);
      self stats::function_dad108fa(#"hash_2cd7f6dca1ce1d14", 1);
      self stats::function_dad108fa(#"hash_6c9b07f9cd4f45d6", 1);

      if(weaponclass === # "weapon_pistol") {
        self stats::function_dad108fa(#"hash_304caa23a8e24278", 1);
      }
    }

    if(weapon.issemiauto && !weapon.var_a6a8f158) {
      self stats::function_dad108fa(#"hash_4c3c3affa43f9f08", 1);
      self stats::function_dad108fa(#"hash_6d80510c601c5bb9", 1);
    } else if(weapon.isburstfire) {
      self stats::function_dad108fa(#"hash_2bd95491d08078a3", 1);
      self stats::function_dad108fa(#"hash_2e82801fbae18571", 1);
    }

    if(isDefined(level.var_a0b75cfd)) {
      self stats::function_dad108fa(#"hash_4d854a6b2d8ad76a", 1);
    }

    if(isDefined(level.var_a845ba28)) {
      self[[level.var_a845ba28]](data);
    }

    if(!isDefined(level.var_cad17b9b)) {
      level.var_cad17b9b = getgametypesetting(#"hash_1eaa149676ef52d9") === 1;
    }

    if(level.var_cad17b9b) {
      self stats::function_bcf9602(#"hash_513bcc963a91d9ce", 1, #"hash_735ace6b22542a65");
    }
  }

  if(isDefined(level.basegametype) && (level.basegametype == "sd" || level.basegametype == "vip" || level.basegametype == "gunfight" || level.basegametype == "fireteam_elimination")) {
    self stats::function_dad108fa(#"hash_567d404e2f27433b", 1);
    self stats::function_dad108fa(#"hash_6016b0a57e1cd493", 1);
  }

  if(isDefined(level.activeplayeruavs[self.entnum]) && level.activeplayeruavs[self.entnum] && (!isDefined(level.forceradar) || level.forceradar == 0)) {
    self stats::function_dad108fa(#"ekia_uav", 1);
  }

  if(isDefined(level.activeplayercounteruavs[self.entnum]) && level.activeplayercounteruavs[self.entnum] > 0) {
    self stats::function_dad108fa(#"ekia_counteruav", 1);
  }

  if(killstreak === # "ability_dog") {
    if(weapon.issignatureweapon) {
      self stats::function_dad108fa(#"ekia_specialized_weapons", 1);
    }
  }

  function_88235aee(idamage, self);

  if(var_4e8a56b1 || var_7ca8dd34) {
    self stats::function_dad108fa(#"hash_3cbe820401e3d5c6", 1);
    self stats::function_dad108fa(#"hash_15e9f992b5497ad7", 1);

    if(var_d7b43cfe) {
      self stats::function_dad108fa(#"hash_19b522874d71d0c2", 1);
      return;
    }

    if(var_c48b1869) {
      self stats::function_dad108fa(#"hash_7d65f6cc85a27569", 1);
    }
  }
}

function challengekills(data) {
  weapon = data.weapon;
  player = data.attacker;
  victim = data.victim;
  attacker = data.attacker;
  time = data.time;

  if(!isDefined(attacker.team)) {
    return;
  }

  if(!isDefined(victim.team)) {
    return;
  }

  attacker.lastkilledplayer = victim;
  attackertraversing = data.attackertraversing;
  var_1fa3e8cc = data.var_1fa3e8cc;
  var_8556c722 = data.var_8556c722;
  attackerwasconcussed = data.attackerwasconcussed;
  attackerwasflashed = data.attackerwasflashed;
  attackerwasunderwater = data.attackerwasunderwater;
  var_911b9b40 = data.var_911b9b40;
  attackerlastfastreloadtime = data.attackerlastfastreloadtime;
  var_2e1b3ac1 = data.var_2e1b3ac1;
  lastweaponbeforetoss = data.lastweaponbeforetoss;
  meansofdeath = data.smeansofdeath;
  ownerweaponatlaunch = data.ownerweaponatlaunch;
  killstreak = data.killstreaktype;
  var_18db7a57 = data.var_18db7a57;
  victimweapon = data.victimweapon;
  var_cb8ee1f0 = data.var_cb8ee1f0;
  victimbledout = data.bledout;
  var_59a8c5c7 = data.var_59a8c5c7;
  victimorigin = data.victimorigin;
  victimforward = data.victimforward;
  var_241836bd = data.var_241836bd;
  victimelectrifiedby = data.victimelectrifiedby;
  victimattackersthisspawn = data.victimattackersthisspawn;
  victimwasinslamstate = data.victimwasinslamstate;
  var_9fb5719b = data.var_9fb5719b;
  victimwasonground = data.victimonground;
  var_8e5d0c71 = data.var_8e5d0c71;
  var_59b78db0 = data.var_59b78db0;
  victimwasunderwater = data.wasunderwater;
  var_e828179e = data.var_e828179e;
  victimlaststunnedby = data.victimlaststunnedby;
  var_f150ae0c = data.var_f150ae0c;
  var_da9749ea = data.var_da9749ea;
  var_642d3a64 = data.var_642d3a64;
  victimactiveproximitygrenades = data.victimactiveproximitygrenades;
  victimactivebouncingbetties = data.victimactivebouncingbetties;
  var_f91a4dd6 = data.var_f91a4dd6;
  var_8099aa99 = data.var_8099aa99;
  attackerlastflashedby = data.attackerlastflashedby;
  attackerlaststunnedby = data.attackerlaststunnedby;
  attackerlaststunnedtime = data.attackerlaststunnedtime;
  attackeronground = data.attackeronground;
  attackerwassliding = data.attackerwassliding;
  attackerwassprinting = data.attackerwassprinting;
  attackerstance = data.attackerstance;
  wasdefusing = data.wasdefusing;
  wasplanting = data.wasplanting;
  inflictorownerwassprinting = data.inflictorownerwassprinting;
  attackerorigin = data.attackerorigin;
  attackerforward = data.attackerforward;
  var_4e8a56b1 = data.var_4e8a56b1;
  var_adb68654 = data.var_adb68654;
  var_1452c652 = data.var_1452c652;
  var_70763083 = data.var_70763083;
  var_d6553aa9 = data.var_d6553aa9;
  var_d24b8539 = data.var_6799f1da;
  attacker_slide_end = isDefined(data.attacker_slide_end) ? data.attacker_slide_end : 0;
  attacker_sprint_end = isDefined(data.attacker_sprint_end) ? data.attacker_sprint_end : 0;
  var_e5241328 = data.var_e5241328;
  var_cc8f0762 = data.var_cc8f0762;
  var_f2bc9529 = data.var_f2bc9529;
  var_117e9294 = data.var_117e9294;
  var_26aed950 = data.var_26aed950;
  inflictoriscooked = data.inflictoriscooked;
  var_dc8c6b51 = data.var_dc8c6b51;
  var_74f23861 = data.var_74f23861;
  inflictorchallenge_hatchettosscount = data.inflictorchallenge_hatchettosscount;
  inflictorownerwassprinting = data.inflictorownerwassprinting;
  inflictorplayerhasengineerperk = data.inflictorplayerhasengineerperk;
  var_9e818622 = data.var_9e818622;
  inflictor = data.einflictor;
  var_937b6de2 = isDefined(victim.challenge_combatrobotattackclientid) && isDefined(victim.challenge_combatrobotattackclientid[player.clientid]);
  weaponclass = data.weaponclass;
  baseweapon = getbaseweapon(weapon);
  baseweaponitemindex = getbaseweaponitemindex(baseweapon);
  weaponpurchased = player isitempurchased(baseweaponitemindex);

  if(meansofdeath == # "mod_head_shot" || meansofdeath == # "mod_pistol_bullet" || meansofdeath == # "mod_rifle_bullet") {
    bulletkill = 1;
  } else if((baseweapon == level.var_38b456aa || baseweapon == level.weaponspecialcrossbow) && (meansofdeath == "MOD_IMPACT" || meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_PROJECTILE_SPLASH")) {
    bulletkill = 1;
  } else {
    bulletkill = 0;
  }

  if(level.teambased) {
    if(player.team == victim.team) {
      return;
    }
  } else if(player == victim) {
    return;
  }

  if(!isDefined(player.pers[#"hash_66340bee14d4bc05"])) {
    player.pers[#"hash_66340bee14d4bc05"] = 0;
  }

  if(!isDefined(player.pers[#"hash_5ecbfbcefa68d091"])) {
    player.pers[#"hash_5ecbfbcefa68d091"] = 0;
  }

  if(!isDefined(player.pers[#"hash_4c09a54d2f2a741f"])) {
    player.pers[#"hash_4c09a54d2f2a741f"] = 0;
  }

  if(!isDefined(player.pers[#"hash_253555289d0b2bcf"])) {
    player.pers[#"hash_253555289d0b2bcf"] = 0;
  }

  if(!isDefined(killstreak)) {
    if(!isDefined(player.var_ea1458aa)) {
      player.var_ea1458aa = {};
    }

    if(!isDefined(player.var_ea1458aa.var_e7c6fe5a)) {
      player.var_ea1458aa.var_e7c6fe5a = [];
    }

    if(!isDefined(player.var_ea1458aa.var_e7c6fe5a[#"primary"])) {
      player.var_ea1458aa.var_e7c6fe5a[#"primary"] = 0;
    }

    if(!isDefined(player.var_ea1458aa.var_e7c6fe5a[#"secondary"])) {
      player.var_ea1458aa.var_e7c6fe5a[#"secondary"] = 0;
    }

    if(!isDefined(player.var_ea1458aa.var_bd50cd6d[#"primary"])) {
      player.var_ea1458aa.var_bd50cd6d[#"primary"] = 0;
    }

    if(!isDefined(player.var_ea1458aa.var_bd50cd6d[#"secondary"])) {
      player.var_ea1458aa.var_bd50cd6d[#"secondary"] = 0;
    }

    if(!isDefined(player.var_ea1458aa.var_bd50cd6d[#"lethal"])) {
      player.var_ea1458aa.var_bd50cd6d[#"lethal"] = 0;
    }

    if(!isDefined(player.var_ea1458aa.var_6bcfcdc4[#"hash_2d5867a8c6518a12"])) {
      player.var_ea1458aa.var_6bcfcdc4[#"hash_2d5867a8c6518a12"] = 0;
    }

    if(!isDefined(player.var_ea1458aa.var_6bcfcdc4[#"lethal"])) {
      player.var_ea1458aa.var_6bcfcdc4[#"lethal"] = 0;
    }

    if(level.hardcoremode) {
      player stats::function_dad108fa(#"kill_hc", 1);

      if(isDefined(var_e5241328) && var_e5241328 + 4500 > time) {
        player stats::function_dad108fa(#"kill_hc_stim", 1);
      }

      if(player.health < player.maxhealth) {
        player stats::function_dad108fa(#"kill_hc_crit_health", 1);
      }

      if(weapons::ismeleemod(meansofdeath) && weapons::ispunch(weapon)) {
        player stats::function_dad108fa(#"kill_hc_fist", 1);
      }
    }

    player processspecialistchallenge("kills");

    if(weapon.isheavyweapon) {
      if(!isDefined(player.pers[#"challenge_heroweaponkills"])) {
        player.pers[#"challenge_heroweaponkills"] = 0;
      }

      player processspecialistchallenge("kills_weapon");
      player.pers[#"challenge_heroweaponkills"]++;

      if(player.pers[#"challenge_heroweaponkills"] >= 6) {
        player processspecialistchallenge("kill_one_game_weapon");
        player.pers[#"challenge_heroweaponkills"] = 0;
      }
    }
  } else {
    player function_ea966b4a(killstreak, var_18db7a57, weapon);
  }

  if(data.var_b75b215 === 1) {
    player stats::function_dad108fa(#"hash_1793c828270825be", 1);
    player stats::function_dad108fa(#"hash_7adb8f843b82a52a", 1);
    player stats::function_42277145(#"hash_3a26c3202d86e874", 1);
  }

  if(bulletkill && !isDefined(killstreak)) {
    var_455d60a2 = distancesquared(attackerorigin, victimorigin);

    if(var_455d60a2 >= 15499969) {
      player stats::function_dad108fa(#"hash_778662db221c6d9f", 1);
    }

    if(data.var_78e3b537 === time) {
      if(data.var_d7dddd05 & 8) {
        player stats::function_dad108fa(#"kill_enemy_through_objects", 1);
        player stats::function_dad108fa(#"hash_718f05b5fd44a07e", 1);
        player stats::function_dad108fa(#"hash_20bf80a75132c05", 1);
        player stats::function_dad108fa(#"hash_38d5b7c2db747144", 1);
      }
    }

    player function_80327323(data);

    if(isDefined(victim.firsttimedamaged) && victim.firsttimedamaged == time) {
      if(weaponpurchased) {
        if(weaponclass === # "weapon_sniper") {
          player stats::function_dad108fa(#"kill_enemy_one_bullet_sniper", 1);
          player stats::function_e24eec31(weapon, #"kill_enemy_one_bullet_sniper", 1);

          if(!isDefined(player.pers[#"kill_enemy_one_bullet_sniper"])) {
            player.pers[#"kill_enemy_one_bullet_sniper"] = 0;
          }

          player.pers[#"kill_enemy_one_bullet_sniper"]++;

          if(player.pers[#"kill_enemy_one_bullet_sniper"] % 10 == 0) {
            player stats::function_dad108fa(#"hash_2ebd387ffb67e1dc", 1);
          }
        }
      }

      if(weaponclass === # "weapon_sniper") {
        player stats::function_dad108fa(#"hash_44655b9f24b38f68", 1);
      }

      if(baseweapon === level.weaponspecialcrossbow) {
        if(!isDefined(player.pers[#"hash_2a6f43cff7927145"])) {
          player.pers[#"hash_2a6f43cff7927145"] = 0;
        }

        player.pers[#"hash_2a6f43cff7927145"]++;

        if(player.pers[#"hash_2a6f43cff7927145"] % 5 == 0) {
          player stats::function_e24eec31(weapon, #"hash_44ee37a6f2b220c9", 1);
        }
      }

      player.var_ea1458aa.kill_enemy_one_bullet = 1;

      if(isDefined(player.var_ea1458aa.var_658eaa00) && !isDefined(player.pers[#"hash_49afb6aabd111f8b"])) {
        player stats::function_d0de7686(#"hash_2db8ed5da8ee8550", 1, #"hash_43f0f74bb67f952c");
        player.pers[#"hash_49afb6aabd111f8b"] = 1;
      }

      if(!isDefined(weapon.attachments) || weapon.attachments.size == 0) {
        if(!isDefined(player.pers[#"hash_5fd35ed903bc42a3"])) {
          player.pers[#"hash_5fd35ed903bc42a3"] = 0;
        }

        player.pers[#"hash_5fd35ed903bc42a3"]++;

        if(player.pers[#"hash_5fd35ed903bc42a3"] == 3) {
          player stats::function_d0de7686(#"hash_6daf88d537c4ae9d", 1, #"hash_3be00484d9ce9a63");
        }
      }
    }

    if(!isDefined(player.pers[#"hash_15f486ff20a9984f"])) {
      if(!isDefined(player.var_aec3f150)) {
        player.var_aec3f150 = 0;
      }

      player.var_aec3f150 |= 1;

      if(player.var_aec3f150 == 7) {
        player stats::function_d0de7686(#"hash_68b5c40f079f4af0", 1, #"hash_2b2b28f1d1323b99");
        player.pers[#"hash_15f486ff20a9984f"] = 1;
      }
    }

    function_7fd1799f(baseweapon, player, weaponclass, meansofdeath);
    function_b2b18857(player);

    if(meansofdeath == # "mod_head_shot") {
      if(isDefined(victim.var_ea1458aa) && isDefined(victim.var_ea1458aa.attackerdamage)) {
        var_d72bd991 = victim.var_ea1458aa.attackerdamage[player.clientid];
        gear = player function_b958b70d(player.class_num, "tacticalgear");

        if(gear === # "gear_armor" && isDefined(var_d72bd991)) {
          if(var_d72bd991.var_d7bd6f9b === 1) {
            player stats::function_dad108fa(#"hash_2ed3de647f5090f1", 1);
          }
        }
      }

      player stats::function_dad108fa(#"headshots_s2", 1);
      player stats::function_dad108fa(#"hash_10e2902d2d4ffcc", 1);
      player stats::function_42277145(#"hash_24abac59aafa49d1", 1);

      if(!isDefined(player.pers[#"hash_744391d538abedc"]) && player function_c9e4f73f(3, #"hash_744391d538abedc", #"hash_4c6cc7ccc53b0d83")) {
        player stats::function_dad108fa(#"hash_55531d9b7bb2a748", 1);
      }

      if(!isDefined(player.pers[#"hash_356aadc7b1cd756d"]) && player function_c9e4f73f(2, #"hash_356aadc7b1cd756d", #"hash_8be6fac74192a7e")) {
        player stats::function_dad108fa(#"hash_64d75a7ec139fdf7", 1);
      }

      player.var_19b50427++;

      if(player.var_19b50427 % 2 == 0) {
        player stats::function_dad108fa(#"hash_7455e919746eba4d", 1);
      }

      if(weaponclass === # "weapon_assault") {
        player stats::function_dad108fa(#"hash_31d5721ee9793424", 1);
        player stats::function_dad108fa(#"hash_5dd25904c990744e", 1);

        if(!isDefined(player.pers[#"hash_36a7b702420af0b8"]) && player function_c9e4f73f(2, #"hash_36a7b702420af0b8", #"hash_4f4e25cbf5c7ea7f")) {
          player stats::function_841e4896(#"hash_21a7824cfc151de4", 1, #"hash_a5417e397f372f2", #"ar_slowhandling_t9");
        }
      } else if(weaponclass === # "weapon_sniper") {
        if(!isDefined(player.pers[#"hash_3b986cd66018f097"]) && player function_c9e4f73f(2, #"hash_3b986cd66018f097", #"hash_7bd70a9b560ddb9a")) {
          player stats::function_841e4896(#"hash_45c809e6fc999f3a", 1, #"hash_34403f1f2912461f", #"sniper_accurate_t9");
        }
      } else if(weaponclass === # "weapon_pistol") {
        if(!isDefined(player.pers[#"hash_3722a14b880f6468"])) {
          player stats::function_d0de7686(#"hash_1f4655121772d2c5", 1, #"hash_7a7208607a705d6d");
          player.pers[#"hash_3722a14b880f6468"] = 1;
        }
      } else if(weaponclass === # "weapon_smg") {
        if(!isDefined(player.pers[#"hash_283f99725567f269"]) && player function_c9e4f73f(2, #"hash_283f99725567f269", #"hash_1ddb2360e194a87c")) {
          player stats::function_841e4896(#"hash_2fb4d0164593f277", 1, #"hash_6d5c2b4b0c5834bc", #"smg_semiauto_t9");
        }
      } else if(weaponclass === # "weapon_grenade") {
        if(weapon.statname === # "hatchet") {
          player stats::function_dad108fa(#"hash_26f18c40643aa0e3", 1);
          player stats::function_dad108fa(#"hash_12b2c63ec1a158f5", 1);
        }
      }
    }

    if(isDefined(var_26aed950[#"talent_lightweight"])) {
      player stats::function_dad108fa(#"kill_lightweight", 1);
    }

    if(weapon.isdualwield && weaponpurchased) {
      checkdualwield(baseweapon, player, attacker, time, attackerwassprinting, attacker_sprint_end);
    }

    if(player weaponhasattachmentandunlocked(weapon, "steadyaim") || player weaponhasattachmentandunlocked(weapon, "steadyaim2")) {
      player stats::function_dad108fa(#"hash_6b018ac14c58cef1", 1);
    }

    if(isDefined(weapon.attachments) && weapon.attachments.size > 0) {
      var_d7742480 = player getweaponoptic(weapon);

      if(isDefined(var_d7742480) && var_d7742480 != "" && player weaponhasattachmentandunlocked(weapon, var_d7742480)) {
        if(weapon.attachments.size > 5 && player allweaponattachmentsunlocked(weapon) && !isDefined(attacker.tookweaponfrom[weapon])) {
          player stats::function_dad108fa(#"kill_optic_5_attachments", 1);
        }

        if(isDefined(player.attachmentkillsthisspawn[var_d7742480])) {
          player.attachmentkillsthisspawn[var_d7742480]++;

          if(player.attachmentkillsthisspawn[var_d7742480] == 5) {
            player stats::function_e24eec31(weapon, #"killstreak_5_attachment", 1);
          }
        } else {
          player.attachmentkillsthisspawn[var_d7742480] = 1;
        }

        if(weapons::ispistol(weapon.rootweapon)) {
          if(player weaponhasattachmentandunlocked(weapon, "suppressed", "barrel")) {
            player stats::function_dad108fa(#"kills_pistol_lasersight_suppressor_longbarrel", 1);
          }
        }

        switch (var_d7742480) {
          case # "ir":
            if(data.var_4c540e11 === 1) {
              player stats::function_dad108fa(#"hash_17d0d0cb03016ae5", 1);
            }

            break;
          case # "elo":
          case # "elo2":
            if(data.var_4c540e11 === 1) {
              player stats::function_dad108fa(#"hash_cce5e38ca00479d", 1);
            }

            break;
        }
      }

      if(player weaponhasattachmentandunlocked(weapon, "suppressed")) {
        if(attacker util::has_hard_wired_perk_purchased_and_equipped() && attacker util::has_ghost_perk_purchased_and_equipped() && attacker util::has_jetquiet_perk_purchased_and_equipped()) {
          player stats::function_dad108fa(#"kills_suppressor_ghost_hardwired_blastsuppressor", 1);
        }
      }

      if(data.var_4c540e11 === 1 && weaponclass === # "weapon_smg") {
        if(player weaponhasattachmentandunlocked(weapon, "handle2") || player weaponhasattachmentandunlocked(weapon, "mixhandle2") || player weaponhasattachmentandunlocked(weapon, "quickdraw") || player weaponhasattachmentandunlocked(weapon, "quickdraw2")) {
          player stats::function_dad108fa(#"hash_43ad1d063cdd0cb7", 1);
        }

        if(!isDefined(player.pers[#"hash_140cbe46f39ac288"]) && player function_c9e4f73f(3, #"hash_140cbe46f39ac288", #"hash_3e170a3f5d930096")) {
          player stats::function_d0de7686(#"hash_488b3dbe0a2f928c", 1, #"hash_1e39c78c6ebed29b");
        }
      }

      if(weapon.attachments.size > 1) {
        if(data.var_4c540e11 === 1) {
          if(player weaponhasattachmentandunlocked(weapon, "grip", "quickdraw")) {
            player stats::function_dad108fa(#"kills_ads_quickdraw_and_grip", 1);
          }
        }

        if(player weaponhasattachmentandunlocked(weapon, "fastreload", "extclip")) {
          player.pers[#"killsfastmagext"]++;

          if(player.pers[#"killsfastmagext"] > 4) {
            player stats::function_dad108fa(#"kills_one_life_fastmags_and_extclip", 1);
            player.pers[#"killsfastmagext"] = 0;
          }
        }
      }

      if(weapon.attachments.size > 4) {
        if(player weaponhasattachmentandunlocked(weapon, "extclip", "grip", "fastreload", "quickdraw", "stalker")) {
          player stats::function_dad108fa(#"kills_extclip_grip_fastmag_quickdraw_stock", 1);
        }
      }
    }

    if(isDefined(attackerlastfastreloadtime) && time - attackerlastfastreloadtime <= 5000 && player weaponhasattachmentandunlocked(weapon, "fastreload")) {
      player stats::function_dad108fa(#"kills_after_reload_fastreload", 1);
    }

    if(data.var_b0985dfc === 1 && weapon != level.weaponnone) {
      player stats::function_e24eec31(weapon, #"hash_7ecef0e52a9dcf4b", 1);
    }

    if(data.var_4c540e11 === 1) {
      player stats::function_dad108fa(#"hash_66f86d062e57a06b", 1);

      if(weaponclass === # "weapon_smg") {
        if(!isDefined(player.pers[#"hash_140cbe46f39ac288"]) && player function_c9e4f73f(3, #"hash_140cbe46f39ac288", #"hash_65a41fe94bc40f8f")) {
          player stats::function_d0de7686(#"hash_488b3dbe0a2f928c", 1, #"hash_1e39c78c6ebed29b");
        }
      }
    }

    if(weaponclass === # "weapon_sniper") {
      var_20bfb55b = 0;

      if(isDefined(var_1452c652.lasttimedamaged) && var_1452c652.lasttimedamaged + 5000 > time && is_true(var_1452c652.weapon.issniperweapon)) {
        var_20bfb55b = 1;
      } else if(is_true(victimweapon.issniperweapon) && data.var_f0b3c772) {
        var_3311cbe2 = vectordot(vectornormalize(attackerorigin - victimorigin), victimforward);

        if(var_3311cbe2 > 0.997) {
          var_20bfb55b = 1;
        }
      }

      if(var_20bfb55b) {
        player stats::function_dad108fa(#"hash_57495bb6f7e6d2f9", 1);
      }
    }

    if(weaponclass === # "weapon_lmg") {
      if(data.var_63a3295e >= 3) {
        if(!isDefined(player.pers[#"hash_445aea675719f5f6"])) {
          player stats::function_841e4896(#"hash_603615ffae21f65f", 1, #"hash_329170867acd33e9", #"lmg_fastfire_t9");
          player.pers[#"hash_445aea675719f5f6"] = 1;
        }
      }
    }
  } else if(weapons::ismeleemod(meansofdeath) && !isDefined(killstreak)) {
    player stats::function_dad108fa(#"melee", 1);

    if(weapons::ispunch(weapon)) {
      player stats::function_dad108fa(#"kill_enemy_with_fists", 1);
    }

    if(baseweapon.isbulletweapon || baseweapon.forcedamagehitlocation || baseweapon == level.weaponshotgunenergy || baseweapon.statname == level.weaponballisticknife.statname) {
      function_7fd1799f(baseweapon, player, weaponclass, meansofdeath);
    } else {
      function_8e3fdb84(baseweapon, player, weaponclass);
    }

    if(weaponclass === # "weapon_knife") {
      player stats::function_dad108fa(#"hash_51035ce3c359156", 1);
      player stats::function_dad108fa(#"hash_47aa6679efd7b139", 1);
      player stats::function_dad108fa(#"hash_51037ce3c3594bc", 1);
      player stats::function_dad108fa(#"hash_47aa6579efd7af86", 1);
      player stats::function_bcf9602(#"hash_513bcd963a91db81", 1, #"hash_735ace6b22542a65");

      if(!isDefined(player.pers[#"hash_15f486ff20a9984f"])) {
        if(!isDefined(player.var_aec3f150)) {
          player.var_aec3f150 = 0;
        }

        player.var_aec3f150 |= 2;

        if(player.var_aec3f150 == 7) {
          player stats::function_d0de7686(#"hash_68b5c40f079f4af0", 1, #"hash_2b2b28f1d1323b99");
          player.pers[#"hash_15f486ff20a9984f"] = 1;
        }
      }
    }

    player.var_ea1458aa.var_658eaa00 = 1;

    if(isDefined(player.var_ea1458aa.kill_enemy_one_bullet) && !isDefined(player.pers[#"hash_49afb6aabd111f8b"])) {
      player stats::function_d0de7686(#"hash_2db8ed5da8ee8550", 1, #"hash_43f0f74bb67f952c");
      player.pers[#"hash_49afb6aabd111f8b"] = 1;
    }

    if(!isDefined(player.pers[#"hash_7dd4f6171e2ea0d5"]) && player function_c9e4f73f(3, #"hash_7dd4f6171e2ea0d5", #"hash_789994e89b497f00")) {
      player stats::function_dad108fa(#"hash_78961e51d07dc4ad", 1);
      player stats::function_dad108fa(#"hash_21a608644ae7afcc", 1);
    }

    if(!isDefined(player.pers[#"hash_65ce175c5f90055e"])) {
      player.var_1022302b = 1;

      if(isDefined(player.var_8d93ada4)) {
        player stats::function_d0de7686(#"hash_26fc476300986ac1", 1, #"hash_4e7e61b2bbe2f0e1");
        player.pers[#"hash_65ce175c5f90055e"] = 1;
      }
    }
  } else if(!isDefined(killstreak)) {
    var_455d60a2 = distancesquared(attackerorigin, victimorigin);

    if(var_455d60a2 >= 15499969) {
      player stats::function_dad108fa(#"hash_778662db221c6d9f", 1);
    }

    if(weaponclass === # "weapon_launcher") {
      player stats::function_dad108fa(#"hash_be93d1227e6db1", 1);
      player stats::function_dad108fa(#"hash_6b344091a61ea57a", 1);
      player stats::function_dad108fa(#"hash_6b343b91a61e9cfb", 1);
      player stats::function_dad108fa(#"hash_689e13f25737ea0", 1);
      player stats::function_dad108fa(#"hash_315afd945b989705", 1);
      player stats::function_dad108fa(#"hash_6b343a91a61e9b48", 1);
      player stats::function_dad108fa(#"hash_6b343d91a61ea061", 1);

      if(!is_true(data.var_84a369d1)) {
        if(var_455d60a2 >= 3873024) {
          player stats::function_dad108fa(#"hash_171796d645780487", 1);
        }
      }
    }

    if(weapon.islethalgrenade) {
      player stats::function_dad108fa(#"hash_7d215eff481f4f85", 1);
      player stats::function_42277145(#"hash_777765b99c34fecc", 1);

      if(data.var_2f59a6b8 === 1) {
        player stats::function_dad108fa(#"hash_fac49b9c9fcdb8d", 1);
        player stats::function_dad108fa(#"hash_1a2391c6ff1cc84", 1);
      }

      if(isDefined(data.var_3d8f6ba2)) {
        switch (weapon.statname) {
          case # "hatchet":
            var_a6957800 = 2250000;
            break;
          case # "satchel_charge":
            var_a6957800 = 1440000;
            break;
          default:
            var_a6957800 = 3240000;
            break;
        }

        var_216acd45 = distancesquared(data.var_3d8f6ba2, victimorigin);

        if(var_216acd45 >= var_a6957800) {
          player stats::function_dad108fa(#"hash_3436173279a2c7a3", 1);
        }
      }

      if(isDefined(data.var_e8c642a1)) {
        if(!isDefined(player.var_1a21226b)) {
          player.var_1a21226b = [];
        }

        var_1a21226b = player.var_1a21226b;
        var_60114e15 = getarraykeys(var_1a21226b);

        foreach(var_f15c1f25 in var_60114e15) {
          maxduration = isDefined(var_1a21226b[var_f15c1f25].max_duration) ? var_1a21226b[var_f15c1f25].max_duration : 3000;

          if(data.time - var_1a21226b[var_f15c1f25].var_821ec614 > maxduration) {
            var_1a21226b[var_f15c1f25] = undefined;
          }
        }

        arrayremovevalue(var_1a21226b, undefined, 1);

        if(!isDefined(var_1a21226b[data.var_e8c642a1])) {
          var_1a21226b[data.var_e8c642a1] = {
            #kills: 1, #var_821ec614: data.time
          };

          if(weapon.statname == # "eq_molotov") {
            var_1a21226b[data.var_e8c642a1].max_duration = 35000;
          }
        } else {
          var_1a21226b[data.var_e8c642a1].kills++;
        }

        if(var_1a21226b[data.var_e8c642a1].kills % 2 == 0) {
          player stats::function_dad108fa(#"hash_3bd72103b95eb93e", 1);
        }

        if(!isDefined(player.pers[#"hash_15f486ff20a9984f"])) {
          if(!isDefined(player.var_aec3f150)) {
            player.var_aec3f150 = 0;
          }

          player.var_aec3f150 |= 4;

          if(player.var_aec3f150 == 7) {
            player stats::function_d0de7686(#"hash_68b5c40f079f4af0", 1, #"hash_2b2b28f1d1323b99");
            player.pers[#"hash_15f486ff20a9984f"] = 1;
          }
        }
      }
    }

    if(weaponpurchased) {
      slot_weapon = player loadout::function_18a77b37("primarygrenade");

      if(weapon === slot_weapon) {
        if(player.challenge_scavengedcount > 0) {
          player.challenge_resuppliednamekills++;

          if(player.challenge_resuppliednamekills >= 3) {
            player stats::function_dad108fa(#"kills_3_resupplied_nade_one_life", 1);
            player.challenge_resuppliednamekills = 0;
          }

          player.challenge_scavengedcount--;
        }
      }

      if(isDefined(inflictoriscooked)) {
        if(inflictoriscooked == 1 && weapon.statname == # "frag_grenade") {
          player stats::function_dad108fa(#"kill_with_cooked_grenade", 1);
        }
      }

      if(isDefined(var_dc8c6b51)) {
        if(var_dc8c6b51 == 1 && weapon.statname == # "frag_grenade") {
          player stats::function_dad108fa(#"kill_enemy_grenade_throwback", 1);
          player contracts::increment_contract(#"hash_4529ad00eb0b976d");
        }

        if(var_74f23861 === victim) {
          player stats::function_dad108fa(#"hash_70670980a3a22c4", 1);
        }
      }

      if(victimlaststunnedby === player) {
        if(weaponclass === "weapon_grenade") {
          player stats::function_dad108fa(#"kill_stun_lethal", 1);
        }
      }

      if(baseweapon.statname == level.weaponballisticknife.statname) {
        player function_80327323(data);

        if(isDefined(var_26aed950[#"talent_lightweight"])) {
          player stats::function_dad108fa(#"kill_lightweight", 1);
        }
      }
    }

    if(weapon.statname === # "satchel_charge") {
      player stats::function_dad108fa(#"hash_76c2a7d61abd306d", 1);
      player stats::function_dad108fa(#"hash_4de1ffd2115bd019", 1);
    } else if(weapon.statname === # "eq_molotov") {
      player stats::function_dad108fa(#"hash_1519552f0db891c2", 1);
      player stats::function_dad108fa(#"hash_172b3bc29a9fabde", 1);
      player stats::function_dad108fa(#"hash_a77c3dd233743eb", 1);
      player stats::function_dad108fa(#"hash_3ef5b668aaef6551", 1);
    } else if(weapon.statname === # "land_mine") {
      player stats::function_dad108fa(#"hash_101aa1c56608b02d", 1);
      player stats::function_bcf9602(#"hash_5a979e436e74441", 1, #"hash_6abe83944d701459");
    } else if(weapon.statname === # "hatchet") {
      player stats::function_dad108fa(#"hash_26f18c40643aa0e3", 1);
      player stats::function_dad108fa(#"hash_12b2c63ec1a158f5", 1);
    } else if(weapon.statname === # "eq_sticky_grenade") {
      player stats::function_dad108fa(#"hash_46faf6240c2fe71a", 1);
      player stats::function_dad108fa(#"hash_6d6935026ede6415", 1);
      player stats::function_dad108fa(#"hash_6d692e026ede5830", 1);
      player stats::function_dad108fa(#"hash_6d692f026ede59e3", 1);
    } else if(weapon.statname === # "frag_grenade") {
      player stats::function_dad108fa(#"hash_43a02e8eda81d313", 1);
      player stats::function_dad108fa(#"hash_16e0efab9e84e9d2", 1);
      player stats::function_dad108fa(#"hash_16e0ecab9e84e4b9", 1);
    }

    if(baseweapon.forcedamagehitlocation || baseweapon == level.weaponshotgunenergy || baseweapon.statname == level.weaponballisticknife.statname) {
      function_7fd1799f(baseweapon, player, weaponclass, meansofdeath);
    } else {
      function_8e3fdb84(baseweapon, player, weaponclass);
    }

    if(weapon.islethalgrenade) {
      player stats::function_dad108fa(#"hash_3b463a7a4b6fb7d7", 1);
      player stats::function_dad108fa(#"hash_3b46377a4b6fb2be", 1);
      player stats::function_dad108fa(#"hash_3b46387a4b6fb471", 1);
      player stats::function_dad108fa(#"hash_3b46357a4b6faf58", 1);
      player.var_ea1458aa.var_bd50cd6d[#"lethal"]++;
      player.var_ea1458aa.var_6bcfcdc4[#"lethal"]++;
      player.pers[#"hash_4c09a54d2f2a741f"]++;

      if(player.pers[#"hash_4c09a54d2f2a741f"] % 3 == 0) {
        player stats::function_dad108fa(#"hash_5f61b89b6d2a2ad3", 1);
      }

      player stats::function_bcf9602(#"hash_5a975e436e73d75", 1, #"hash_6abe83944d701459");
    }
  }

  if(isDefined(data.var_254ce896)) {
    if(!isDefined(player.var_85e94f6e)) {
      player.var_85e94f6e = [];
    }

    var_85e94f6e = player.var_85e94f6e;
    var_c83d7e6d = getarraykeys(var_85e94f6e);

    foreach(var_edde3be1 in var_c83d7e6d) {
      maxduration = isDefined(var_85e94f6e[var_edde3be1].max_duration) ? var_85e94f6e[var_edde3be1].max_duration : 3000;

      if(data.time - var_85e94f6e[var_edde3be1].var_821ec614 > maxduration) {
        var_85e94f6e[var_edde3be1] = undefined;
      }
    }

    arrayremovevalue(var_85e94f6e, undefined, 1);

    if(!isDefined(var_85e94f6e[data.var_254ce896])) {
      var_85e94f6e[data.var_254ce896] = {
        #kills: 1, #var_821ec614: data.time
      };
    } else {
      var_85e94f6e[data.var_254ce896].kills++;
    }

    if(var_85e94f6e[data.var_254ce896].kills == 2) {
      player stats::function_dad108fa(#"hash_40035722dda93fc9", 1);
    }
  }

  if(!isDefined(killstreak)) {
    if(var_4e8a56b1 === 1) {
      player stats::function_dad108fa(#"hash_1f8dde89d75659ab", 1);

      if(isPlayer(var_adb68654) && var_adb68654 != attacker) {
        var_adb68654 stats::function_dad108fa(#"hash_3ecd1137e44e6325", 1);
      }
    }

    if(victimwasonground && !var_8e5d0c71) {
      var_141c7081 = victimorigin + (0, 0, 31);
      var_a2d0af6e = attackerorigin + (0, 0, 31);
      dirtoplayer = vectornormalize(var_a2d0af6e - victimorigin);

      if(!isDefined(var_455d60a2)) {
        var_455d60a2 = distancesquared(attackerorigin, victimorigin);
      }

      if(var_455d60a2 < 144 * 144) {
        var_d5b5f94 = sqrt(var_455d60a2);
      }

      var_2baca0fc = !bullettracepassed(var_141c7081, var_141c7081 + dirtoplayer * (isDefined(var_d5b5f94) ? var_d5b5f94 : 144), 0, victim);

      if(var_2baca0fc) {
        if(baseweapon !== level.weaponspecialcrossbow) {
          player stats::function_e24eec31(weapon, #"hash_6a9ef93d619f4bcc", 1);
        }

        player contracts::increment_contract(#"hash_72fe5b5f010b1df3");

        if(bulletkill && isDefined(var_642d3a64) && var_642d3a64 + 5500 > time) {
          var_31d806d5 = vectordot(attackerforward, victimforward);

          if(var_31d806d5 < -0.98) {
            player stats::function_dad108fa(#"kill_enemy_shooting_in_partial_cover", 1);
          }
        }
      }
    }

    if(attackeronground && !attackerwassprinting) {
      var_b1cd76d4 = victimorigin + (0, 0, 31);
      var_a3a1ea2e = attackerorigin + (0, 0, 31);
      var_88cb8e4 = vectornormalize(var_b1cd76d4 - var_a3a1ea2e);

      if(!isDefined(var_455d60a2)) {
        var_455d60a2 = distancesquared(attackerorigin, victimorigin);
      }

      if(!isDefined(var_d5b5f94) && var_455d60a2 < 144 * 144) {
        var_d5b5f94 = sqrt(var_455d60a2);
      }

      var_b010529d = !bullettracepassed(var_a3a1ea2e, var_a3a1ea2e + var_88cb8e4 * (isDefined(var_d5b5f94) ? var_d5b5f94 : 144), 0, attacker);

      if(var_b010529d) {
        player stats::function_dad108fa(#"hash_393ee8c94a7bccb9", 1);
        player stats::function_dad108fa(#"hash_565dc844d8939160", 1);
      }
    }

    if(weapon.islethalgrenade && (!isDefined(var_2baca0fc) || var_2baca0fc)) {
      dirtoattacker = vectornormalize(data.var_351dc5f - var_241836bd);

      if(!isDefined(var_455d60a2)) {
        var_455d60a2 = distancesquared(attackerorigin, victimorigin);
      }

      if(!isDefined(var_d5b5f94) && var_455d60a2 < 144 * 144) {
        var_d5b5f94 = sqrt(var_455d60a2);
      }

      var_f2b67463 = bullettracepassed(var_241836bd, var_241836bd + dirtoattacker * (isDefined(var_d5b5f94) ? var_d5b5f94 : 144), 0, victim);

      if(!var_f2b67463) {
        player stats::function_dad108fa(#"hash_609f4df480177cea", 1);
        player stats::function_dad108fa(#"hash_16e0a7b81c1be41e", 1);
      }
    }

    if(!isDefined(player.var_88d3f4a4)) {
      player.var_88d3f4a4 = {
        #var_c879622c: attackerorigin, #var_273b4eaf: 1
      };
    } else if(abs(player.var_88d3f4a4.var_c879622c[2] - attackerorigin[2]) < 45 && distance2dsquared(player.var_88d3f4a4.var_c879622c, attackerorigin) < 40000) {
      player.var_88d3f4a4.var_273b4eaf++;
      player.var_88d3f4a4.var_c879622c += attackerorigin;
      player.var_88d3f4a4.var_c879622c *= 0.5;

      if(player.var_88d3f4a4.var_273b4eaf >= 3) {
        player stats::function_dad108fa(#"hash_6a6377a03ebc1503", 1);
        player.var_88d3f4a4 = undefined;
      }
    } else {
      player.var_88d3f4a4.var_c879622c = attackerorigin;
      player.var_88d3f4a4.var_273b4eaf = 1;
    }
  }

  if(isDefined(attacker) && isDefined(attacker.tookweaponfrom) && isDefined(attacker.tookweaponfrom[weapon]) && isDefined(attacker.tookweaponfrom[weapon].previousowner)) {
    if(!isDefined(attacker.tookweaponfrom[weapon].previousowner.team) || attacker.tookweaponfrom[weapon].previousowner.team != player.team) {
      player stats::function_dad108fa(#"kill_with_pickup", 1);
      player stats::function_bcf9602(#"hash_4714f96a091995", 1, #"event_test_enabled");
    }
  }

  awarded_kill_enemy_that_blinded_you = 0;

  if(attackerwasflashed) {
    if(attackerlastflashedby === victim && !data.var_a15d12b0) {
      player stats::function_dad108fa(#"kill_enemy_that_blinded_you", 1);
      awarded_kill_enemy_that_blinded_you = 1;
    }
  }

  if(attackerwassliding || time - attacker_slide_end < 350) {
    player stats::function_dad108fa(#"hash_4bdd06fd222df3f4", 1);
    player stats::function_dad108fa(#"hash_26aa9cf1b9f61e70", 1);

    if(weaponclass === # "weapon_knife" && !isDefined(player.pers[#"hash_cf08e56423fda4c"])) {
      player stats::function_d0de7686(#"hash_66e8176635440bb2", 1, #"hash_663c1b8697faad25");
      player.pers[#"hash_cf08e56423fda4c"] = 1;
    }
  }

  if(!awarded_kill_enemy_that_blinded_you && isDefined(attackerlaststunnedtime) && attackerlaststunnedtime + 5000 > time) {
    if(attackerlaststunnedby === victim && !data.var_a15d12b0) {
      player stats::function_dad108fa(#"kill_enemy_that_blinded_you", 1);
      awarded_kill_enemy_that_blinded_you = 1;
    }
  }

  killedstunnedvictim = victimlaststunnedby === attacker && !data.var_90795a2c && var_f150ae0c.statname === # "eq_slow_grenade" && isDefined(var_da9749ea) && var_da9749ea + 5000 > time;

  if(isDefined(victim.lastshockedby) && victim.lastshockedby == attacker) {
    if(victim.shockendtime > time) {
      if(player util::is_item_purchased(#"proximity_grenade")) {
        player stats::function_dad108fa(#"kill_shocked_enemy", 1);
      }

      player function_be7a08a8(getweapon(#"proximity_grenade"), 1);
      killedstunnedvictim = 1;

      if(weapon.rootweapon.name == "bouncingbetty") {
        player stats::function_dad108fa(#"kill_trip_mine_shocked", 1);
      }
    }
  }

  var_ef47612c = 0;

  if(data.var_e020b97e === 1 && data.var_ac7c0ef7 !== 1) {
    if(victim.lastflashedby === player) {
      var_ef47612c = 1;

      if(player util::is_item_purchased(#"flash_grenade")) {
        player stats::function_dad108fa(#"kill_flashed_enemy", 1);
      }

      player function_be7a08a8(getweapon(#"flash_grenade"), 1);
    }
  }

  var_27c478e3 = 0;

  if(!isDefined(victim.var_93866180[attacker.clientid].lasttimedamaged) || victim.var_93866180[attacker.clientid].lasttimedamaged + 30000 > time) {
    if(attacker.health >= attacker.maxhealth) {
      var_27c478e3 = 1;
    }
  }

  if(isDefined(attacker.attackerdamage[victim.clientid].lasttimedamaged) && attacker.attackerdamage[victim.clientid].lasttimedamaged + 1500 > time) {
    attacker stats::function_dad108fa(#"kill_enemy_damage_you", 1);
    attacker stats::function_dad108fa(#"hash_75953e02a0eacbac", 1);
    attacker stats::function_dad108fa(#"hash_44978e0160dc6c6", 1);
  }

  if(level.teambased) {
    if(!isDefined(player.pers[#"kill_every_enemy_with_specialist"]) && level.playercount[victim.pers[#"team"]] > 3 && player.pers[#"killed_players_with_specialist"].size >= level.playercount[victim.pers[#"team"]]) {
      player stats::function_dad108fa(#"kill_every_enemy", 1);
      player.pers[#"kill_every_enemy_with_specialist"] = 1;
    }

    if(isDefined(victimattackersthisspawn) && isarray(victimattackersthisspawn)) {
      if(victimattackersthisspawn.size > 5) {
        attackercount = 0;

        foreach(attacking_player in victimattackersthisspawn) {
          if(!isDefined(attacking_player)) {
            continue;
          }

          if(attacking_player == attacker) {
            continue;
          }

          if(attacking_player.team !== attacker.team) {
            continue;
          }

          attackercount++;
        }

        if(attackercount > 4) {
          player stats::function_dad108fa(#"kill_enemy_5_teammates_assists", 1);
        }
      }
    }
  }

  if(isDefined(killstreak)) {
    if(killstreak == "ultimate_turret" || killstreak == "inventory_ultimate_turret") {
      if(isDefined(inflictor)) {
        if(!isDefined(inflictor.challenge_killcount)) {
          inflictor.challenge_killcount = 0;
        }

        inflictor.challenge_killcount++;

        if(inflictor.challenge_killcount == 5) {
          player stats::function_dad108fa(#"hash_636e38d21d529ce3", 1);
        }
      }
    }
  }

  if(var_937b6de2) {
    if(!isDefined(inflictor) || !isDefined(inflictor.killstreaktype) || !isstring(inflictor.killstreaktype) || inflictor.killstreaktype != "combat_robot") {
      player stats::function_dad108fa(#"kill_enemy_who_damaged_robot", 1);
    }
  }

  var_46119dfa = player getloadoutitem(player.class_num, "primarygrenadecount");

  if(var_46119dfa) {
    if(weapon.rootweapon.name == "hatchet" && inflictorchallenge_hatchettosscount <= 2) {
      player.challenge_hatchetkills++;

      if(player.challenge_hatchetkills == 2) {
        player stats::function_dad108fa(#"kills_first_throw_both_hatchets", 1);
      }
    }
  }

  if(var_2e1b3ac1 === 1) {
    player stats::function_dad108fa(#"hash_21792d157fabd319", 1);
    player stats::function_dad108fa(#"hash_5149c3617e49007f", 1);
    player stats::function_dad108fa(#"hash_7049f63ee0b63090", 1);
  }

  player trackkillstreaksupportkills(victim);

  if(!isDefined(killstreak)) {
    if(attackerwasunderwater) {
      player stats::function_dad108fa(#"kill_while_underwater", 1);
    }

    if(attackerwasunderwater && var_e828179e < 5 && !var_8556c722) {
      player stats::function_dad108fa(#"kill_enemy_on_land_underwater", 1);
    }

    if(player util::has_purchased_perk_equipped(#"specialty_jetcharger")) {}

    trackedplayer = 0;

    if(player util::has_purchased_perk_equipped(#"specialty_tracker")) {
      if(!victim hasperk(#"specialty_trackerjammer")) {
        player stats::function_dad108fa(#"kill_detect_tracker", 1);
        var_31d806d5 = vectordot(attackerforward, victimforward);
        var_7a4be4ad = distancesquared(attackerorigin, victimorigin);

        if(var_31d806d5 > 0.5 && var_7a4be4ad <= 129600) {
          if(!isDefined(var_1452c652) || !(isDefined(var_1452c652.lasttimedamaged) && var_1452c652.lasttimedamaged + 10000 > time)) {
            player stats::function_dad108fa(#"hash_36fa9e723c26f593", 1);
          }
        }

        trackedplayer = 1;
      }
    }

    if(player util::has_purchased_perk_equipped(#"specialty_detectnearbyenemies")) {
      if(!victim hasperk(#"specialty_sixthsensejammer")) {
        player stats::function_dad108fa(#"kill_enemy_sixth_sense", 1);

        if(player util::has_purchased_perk_equipped(#"specialty_loudenemies")) {
          if(!victim hasperk(#"specialty_quieter")) {
            player stats::function_dad108fa(#"kill_sixthsense_awareness", 1);
          }
        }
      }

      if(trackedplayer) {
        player stats::function_dad108fa(#"kill_tracker_sixthsense", 1);
      }
    }

    if(player hasperk(#"specialty_gpsjammer")) {
      if(player uav::function_781f1bf2() || isDefined(level.var_efb43e1) && player[[level.var_efb43e1]]()) {
        player stats::function_dad108fa(#"hash_5bdb4dad0048aead", 1);
        player stats::function_dad108fa(#"hash_74b19794b9a484d9", 1);
        player stats::function_dad108fa(#"hash_37adf828f2a9ecfe", 1);
      }
    }

    if(uav::hasuav(player.team)) {
      player stats::function_dad108fa(#"hash_14821486655da5ec", 1);
    }

    if(player util::has_purchased_perk_equipped(#"specialty_gpsjammer")) {
      if(uav::hasuav(victim.team)) {
        player stats::function_dad108fa(#"kill_uav_enemy_with_ghost", 1);
      }

      if(player util::has_blind_eye_perk_purchased_and_equipped()) {
        activekillstreaks = victim killstreaks::getactivekillstreaks();
        awarded_kill_blindeye_ghost_aircraft = 0;

        foreach(activestreak in activekillstreaks) {
          if(awarded_kill_blindeye_ghost_aircraft) {
            break;
          }

          switch (activestreak.killstreaktype) {
            case # "drone_striked":
            case # "uav":
            case # "helicopter_comlink":
            case # "sentinel":
              player stats::function_dad108fa(#"kill_blindeye_ghost_aircraft", 1);
              awarded_kill_blindeye_ghost_aircraft = 1;
              break;
          }
        }
      }
    }

    if(player util::has_purchased_perk_equipped(#"specialty_flakjacket")) {
      if(isDefined(player.challenge_lastsurvivewithflakfrom) && player.challenge_lastsurvivewithflakfrom == victim) {
        player stats::function_dad108fa(#"kill_enemy_survive_flak", 1);
      }

      if(player util::has_tactical_mask_purchased_and_equipped()) {
        if(attackerwasflashed || isDefined(player.challenge_lastsurvivewithflaktime) && player.challenge_lastsurvivewithflaktime + 3500 > time || isDefined(attackerlaststunnedtime) && attackerlaststunnedtime + 2500 > time) {
          player stats::function_dad108fa(#"kill_flak_tac_while_stunned", 1);
        }
      }
    }

    if(player util::has_hard_wired_perk_purchased_and_equipped()) {
      if(isDefined(level.hasindexactivecounteruav) && victim[[level.hasindexactivecounteruav]](victim.team)) {
        player stats::function_dad108fa(#"kills_counteruav_emp_hardline", 1);
      }
    }

    if(player util::has_scavenger_perk_purchased_and_equipped()) {
      if(player.scavenged) {
        player stats::function_dad108fa(#"kill_after_resupply", 1);

        if(trackedplayer) {
          player stats::function_dad108fa(#"kill_scavenger_tracker_resupply", 1);
        }
      }
    }

    if(player util::has_hard_wired_perk_purchased_and_equipped()) {
      if(player util::has_cold_blooded_perk_purchased_and_equipped()) {
        player stats::function_dad108fa(#"kill_hardwired_coldblooded", 1);
      }
    }

    killedplayerwithgungho = 0;

    if(player util::has_gung_ho_perk_purchased_and_equipped()) {
      if(bulletkill) {
        killedplayerwithgungho = 1;

        if(attackerwassprinting && isDefined(data.var_4c540e11) && data.var_4c540e11 != 1) {
          player stats::function_dad108fa(#"kill_hip_gung_ho", 1);
        }
      }

      if(weaponclass === "weapon_grenade") {
        if(isDefined(inflictorownerwassprinting) && inflictorownerwassprinting == 1) {
          killedplayerwithgungho = 1;
          player stats::function_dad108fa(#"kill_hip_gung_ho", 1);
        }
      }

      player stats::function_dad108fa(#"hash_65ae5dabb9c13a06", 1);
      player stats::function_dad108fa(#"hash_65ae5fabb9c13d6c", 1);
    }

    if(player util::has_awareness_perk_purchased_and_equipped()) {
      player stats::function_dad108fa(#"kill_awareness", 1);
    }

    if(attackerwassprinting || attacker_sprint_end + 1500 > time) {
      player stats::function_dad108fa(#"hash_57f979618206b04", 1);

      if(weaponclass === # "weapon_smg") {
        if(!isDefined(player.pers[#"hash_503fd807bb4d25ff"]) && player function_c9e4f73f(3, #"hash_503fd807bb4d25ff", #"hash_2a044617f955e702")) {
          player stats::function_841e4896(#"hash_19a15fdb3f31884a", 1, #"hash_7483a7699470a94c", #"smg_spray_t9");
        }
      }
    }

    if(killedstunnedvictim || var_ef47612c) {
      if(weapon !== level.weaponnone) {
        player stats::function_e24eec31(weapon, #"hash_6759c0df02e8aa9d", 1);
        player stats::function_e24eec31(weapon, #"hash_dd38fe3b56f0644", 1);

        if(baseweapon === level.weaponspecialcrossbow && !weapons::ismeleemod(meansofdeath)) {
          player stats::function_e24eec31(weapon, #"hash_6a9ef93d619f4bcc", 1);
        }
      }

      if(weaponclass === # "weapon_smg") {
        player function_ac98baa9();
      } else if(weaponclass === # "weapon_knife") {
        if(!isDefined(player.pers[#"hash_1fb43d84fb3d3b06"])) {
          player stats::function_d0de7686(#"hash_647fad939355f5e7", 1, #"hash_24fa97d9f5305a82");
          player.pers[#"hash_1fb43d84fb3d3b06"] = 1;
        }
      }
    }

    if(weaponclass === # "weapon_knife") {
      if(!isDefined(var_1452c652) || !(isDefined(var_1452c652.lasttimedamaged) && var_1452c652.lasttimedamaged + 10000 > time)) {
        if(!isDefined(player.pers[#"hash_500a79b8d2f15f27"])) {
          player stats::function_841e4896(#"hash_1468ae1763b44910", 1, #"hash_f9572f1792a7862", #"melee_sai_t9_dw");
          player.pers[#"hash_500a79b8d2f15f27"] = 1;
        }
      }
    }

    if(killedstunnedvictim) {
      player stats::function_dad108fa(#"hash_3c511176cb6b5853", 1);
      player stats::function_dad108fa(#"hash_690dea6b04058192", 1);
      player stats::function_dad108fa(#"hash_690de56b04057913", 1);
    }

    if(var_ef47612c) {
      player stats::function_dad108fa(#"hash_79914da435788fe4", 1);
      player stats::function_dad108fa(#"hash_266899c5f3b4e93f", 1);
    }

    if(player hastalent(#"talent_deadsilence")) {
      player stats::function_dad108fa(#"kill_dead_silence", 1);
      player stats::function_dad108fa(#"hash_457a3db89d8cbef7", 1);

      if(distancesquared(attackerorigin, victimorigin) < sqr(120)) {
        if(player util::has_awareness_perk_purchased_and_equipped()) {
          player stats::function_dad108fa(#"kill_close_deadsilence_awareness", 1);
        }

        if(player util::has_jetquiet_perk_purchased_and_equipped()) {
          player stats::function_dad108fa(#"kill_close_blast_deadsilence", 1);
        }

        if(var_27c478e3 === 1) {
          player stats::function_dad108fa(#"hash_193d0738fd876c0f", 1);
          player stats::function_dad108fa(#"hash_3eab9afb4f03dab0", 1);
        }
      }

      if(weaponclass === # "weapon_knife" && !isDefined(player.pers[#"hash_62def6648a8d8274"])) {
        if(!isDefined(player.pers[#"hash_42b95760f574bb33"])) {
          player.pers[#"hash_42b95760f574bb33"] = 1;
        } else {
          player stats::function_d0de7686(#"hash_753784669444a09d", 1, #"hash_4abd131971e6f7a7");
          player.pers[#"hash_62def6648a8d8274"] = 1;
        }
      }
    }

    primary_weapon = player loadout::function_18a77b37("primary");

    if(isDefined(primary_weapon) && weapon == primary_weapon || isDefined(primary_weapon) && isDefined(primary_weapon.altweapon) && weapon == primary_weapon.altweapon) {
      player.var_ea1458aa.var_e7c6fe5a[#"primary"]++;
      player.var_ea1458aa.var_bd50cd6d[#"primary"]++;
      player.var_ea1458aa.var_6bcfcdc4[#"hash_2d5867a8c6518a12"]++;
      player.pers[#"hash_66340bee14d4bc05"]++;

      if(player function_861fe993("secondary")) {
        player function_7ec2f2c("primary", 0);
        player function_7ec2f2c("secondary", 0);
      } else {
        player function_7ec2f2c("primary", 1);
      }
    } else {
      secondary_weapon = player loadout::function_18a77b37("secondary");

      if(isDefined(secondary_weapon) && weapon == secondary_weapon || isDefined(secondary_weapon) && isDefined(secondary_weapon.altweapon) && weapon == secondary_weapon.altweapon) {
        player.var_ea1458aa.var_e7c6fe5a[#"secondary"]++;
        player.var_ea1458aa.var_bd50cd6d[#"secondary"]++;
        player.var_ea1458aa.var_6bcfcdc4[#"hash_2d5867a8c6518a12"]++;
        player.pers[#"hash_5ecbfbcefa68d091"]++;

        if(player function_861fe993("primary")) {
          player function_7ec2f2c("primary", 0);
          player function_7ec2f2c("secondary", 0);
        } else {
          player function_7ec2f2c("secondary", 1);
        }
      }
    }

    var_e7c6fe5a = player.var_ea1458aa.var_e7c6fe5a;

    if(var_e7c6fe5a[#"primary"] > 0 && var_e7c6fe5a[#"secondary"] > 0) {
      player stats::function_dad108fa(#"hash_58ee12dacf893367", 1);
      player stats::function_bcf9602(#"hash_4713f96a0917e2", 1, #"event_test_enabled");
      player stats::function_dad108fa(#"hash_258a142c083b632f", 1);
      player stats::function_dad108fa(#"hash_258a122c083b5fc9", 1);
      var_e7c6fe5a[#"primary"]--;
      var_e7c6fe5a[#"secondary"]--;
    }

    if(player util::has_hacker_perk_purchased_and_equipped() && player util::has_hard_wired_perk_purchased_and_equipped()) {
      should_award_kill_near_plant_engineer_hardwired = 0;

      if(isDefined(victimactivebouncingbetties)) {
        foreach(bouncingbettyinfo in victimactivebouncingbetties) {
          if(!isDefined(bouncingbettyinfo) || !isDefined(bouncingbettyinfo.origin)) {
            continue;
          }

          if(distancesquared(bouncingbettyinfo.origin, victimorigin) < sqr(400)) {
            should_award_kill_near_plant_engineer_hardwired = 1;
            break;
          }
        }
      }

      if(isDefined(victimactiveproximitygrenades) && should_award_kill_near_plant_engineer_hardwired == 0) {
        foreach(proximitygrenadeinfo in victimactiveproximitygrenades) {
          if(!isDefined(proximitygrenadeinfo) || !isDefined(proximitygrenadeinfo.origin)) {
            continue;
          }

          if(distancesquared(proximitygrenadeinfo.origin, victimorigin) < sqr(400)) {
            should_award_kill_near_plant_engineer_hardwired = 1;
            break;
          }
        }
      }

      if(should_award_kill_near_plant_engineer_hardwired) {
        player stats::function_dad108fa(#"kill_near_plant_engineer_hardwired", 1);
      }
    }

    if(isDefined(var_70763083) && var_70763083 + 2500 > time) {
      player stats::function_dad108fa(#"kill_enemy_after_they_heal", 1);
    }

    if(isDefined(var_e5241328) && var_e5241328 + 4500 > time) {
      if(isDefined(attacker.health) && isDefined(var_cc8f0762) && attacker.health - var_cc8f0762 > 40) {
        attacker stats::function_dad108fa(#"kill_enemy_after_you_heal", 1);
      }
    }

    if(var_d6553aa9 === 1 && level.teambased) {
      attacker stats::function_dad108fa(#"kill_enemy_revealed_by_team_fog_of_war", 1);
    }

    if(!victimwasonground && var_e828179e <= 0) {
      attacker stats::function_dad108fa(#"kill_enemy_thats_in_air", 1);
    }

    if(victimweapon.issignatureweapon === 1) {
      if(!isDefined(var_f91a4dd6) || var_f91a4dd6 < 1) {
        attacker stats::function_dad108fa(#"kill_before_specialist_weapon_use", 1);
      }

      if(victimweapon.statname == # "sig_buckler_dw") {
        if(!isDefined(killstreak) && bulletkill && vectordot(victimforward, attackerorigin - victimorigin) < 0) {
          attacker stats::function_dad108fa(#"shutdown_ballisticshield_in_back", 1);
        }
      }
    }

    if(var_1fa3e8cc === 1 && !var_8556c722 && var_911b9b40 !== 1) {
      attacker stats::function_dad108fa(#"kill_with_weapon_in_right_hand_only", 1);
    }

    if(var_27c478e3) {
      attacker stats::function_dad108fa(#"hash_512dd9eae51dae25", 1);
      attacker stats::function_dad108fa(#"hash_17973dab722356fe", 1);
      attacker stats::function_dad108fa(#"hash_179742ab72235f7d", 1);
      attacker contracts::increment_contract(#"hash_47140d92c0c2a86c");
      attacker stats::function_42277145(#"hash_7208e1149645391b", 1);
    }

    if(!victimwasonground && victimwasinslamstate && var_d24b8539 === 1) {
      attacker stats::function_dad108fa(#"shutdown_gravslam_midair_after_grapple", 1);
    }

    if(isDefined(data.var_58b48038)) {
      attacker stats::function_dad108fa(#"kill_enemy_after_surviving_rcxd", 1);
    }

    var_bd50cd6d = attacker.var_ea1458aa.var_bd50cd6d;

    if(var_bd50cd6d[#"primary"] > 0 && var_bd50cd6d[#"secondary"] > 0 && var_bd50cd6d[#"lethal"] > 0) {
      attacker stats::function_dad108fa(#"hash_1fad18ffd7086c2a", 1);
      attacker stats::function_dad108fa(#"hash_1fad15ffd7086711", 1);
      var_bd50cd6d[#"primary"]--;
      var_bd50cd6d[#"secondary"]--;
      var_bd50cd6d[#"lethal"]--;
    }

    var_6bcfcdc4 = attacker.var_ea1458aa.var_6bcfcdc4;

    if(var_6bcfcdc4[#"hash_2d5867a8c6518a12"] > 0 && var_6bcfcdc4[#"lethal"]) {
      attacker stats::function_dad108fa(#"hash_21575a60e8a6ab32", 1);
      var_6bcfcdc4[#"hash_2d5867a8c6518a12"]--;
      var_6bcfcdc4[#"lethal"]--;
    }

    if(isstruct(data.var_9ef7e31)) {
      var_1def3436 = data.var_9ef7e31;

      if(var_1def3436.var_619db00b + 5000 < time && abs(var_1def3436.var_de319bcb[2] - var_1def3436.var_c4fff679[2]) < 45 && distance2dsquared(var_1def3436.var_de319bcb, var_1def3436.var_c4fff679) < 40000) {
        attacker stats::function_dad108fa(#"hash_64834a65d1e57778", 1);
      }
    }
  } else {
    if(weapon.name == # "supplydrop") {
      if(isDefined(inflictorplayerhasengineerperk)) {
        player stats::function_dad108fa(#"kill_booby_trap_engineer", 1);
      }
    }

    var_2cf35051 = globallogic_score::function_3cbc4c6c(victimweapon.var_2e4a8800);

    if(victimweapon.issignatureweapon === 1 || isDefined(var_2cf35051) && var_2cf35051.var_fcd2ff3a === 1) {
      if(killstreak == # "dart" || killstreak == # "inventory_dart" || killstreak == # "recon_car" || killstreak == # "inventory_recon_car" || (killstreak == # "tank_robot" || killstreak == # "inventory_tank_robot") && var_911b9b40 === 1) {
        attacker stats::function_dad108fa(#"shutdown_enemy_by_controlling_scorestreak", 1);
      }
    }

    if(weapon.statname == # "hero_annihilator") {
      attacker stats::function_a47092b5(#"hash_10090ce1490926e", 1, #"hash_3c861ebd76fd24eb");
    }
  }

  if(var_8099aa99 === 1 && isDefined(data.var_4ff87ec1) && data.var_4ff87ec1 > 0) {
    attacker stats::function_dad108fa(#"hash_2c01bc7b9ae95b81", 1);
    attacker contracts::increment_contract(#"hash_6f0eb3d065bcf77e");
  }

  var_eae59bb8 = globallogic_score::function_3cbc4c6c(weapon.var_2e4a8800);

  if(weapon.issignatureweapon === 1 || isDefined(var_eae59bb8) && var_eae59bb8.var_fcd2ff3a === 1) {
    if(victimweapon.issignatureweapon === 1) {
      attacker stats::function_dad108fa(#"kill_specialist_with_specialist", 1);
    }
  }

  if(level.var_9ff21849) {
    if(victimbledout !== 1 || var_59a8c5c7 === 1) {
      if(!isDefined(attacker.var_ee07421b[victim.squad])) {
        attacker.var_ee07421b[victim.squad] = 0;
      }

      attacker.var_ee07421b[victim.squad]++;
    }
  }

  if(isDefined(attacker.var_1e1c7f1b) && attacker.var_1e1c7f1b + int(20 * 1000) > time) {
    attacker stats::function_dad108fa(#"hash_529c12e133e45b94", 1);
    attacker stats::function_dad108fa(#"hash_3dd233c2a2cb7eec", 1);
    attacker stats::function_dad108fa(#"hash_1ca13a22c5b59987", 1);
  }

  if(var_9e818622 === 1) {
    attacker stats::function_dad108fa(#"hash_1674502cb913305d", 1);
  }

  if(attacker.var_26b87dc4 === 1 && isDefined(attacker.var_3c9fd034) && attacker.var_3c9fd034 != weapon) {
    attacker stats::function_dad108fa(#"hash_2859c7926269f2a7", 1);
    attacker stats::function_dad108fa(#"hash_12a1bb4be79bb684", 1);
    attacker.var_26b87dc4 = 0;
  }

  if(!isDefined(attacker.pers[#"hash_27fbc63d598bc996"][weapon.statname])) {
    if(!isDefined(attacker.pers[#"hash_27fbc63d598bc996"])) {
      attacker.pers[#"hash_27fbc63d598bc996"] = [];
    }

    attacker.pers[#"hash_27fbc63d598bc996"][weapon.statname] = 1;

    if(attacker.pers[#"hash_27fbc63d598bc996"].size % 6 == 0) {
      attacker stats::function_dad108fa(#"hash_3b25d69f938af30c", 1);
    }
  }

  heightdiff = attackerorigin[2] - victimorigin[2];

  if(heightdiff >= 72) {
    dist = distance2d(attackerorigin, victimorigin);
    var_73898817 = heightdiff / dist;
    var_3771d22 = 0;

    if(dist > 4000) {
      if(var_73898817 >= 0.05) {
        var_3771d22 = 1;
      }
    } else if(dist > 1500) {
      if(var_73898817 >= 0.1) {
        var_3771d22 = 1;
      }
    } else if(var_73898817 >= 0.15) {
      var_3771d22 = 1;
    }

    if(var_3771d22) {
      attacker stats::function_dad108fa(#"hash_421ceddf01cb65c6", 1);

      if(weaponclass === # "weapon_assault") {
        if(!isDefined(player.pers[#"hash_5822ec5bf1b282eb"])) {
          player stats::function_841e4896(#"hash_7bc34d1910ad008", 1, #"hash_564ac287fb7075d8", #"ar_season6_t9");
          player.pers[#"hash_5822ec5bf1b282eb"] = 1;
        }
      }
    }
  }

  if(var_cb8ee1f0 === 1) {
    if(isDefined(killstreak)) {
      attacker stats::function_dad108fa(#"hash_9eb7f104b26e17c", 1);
    } else if(var_4e8a56b1 === 1) {
      attacker stats::function_dad108fa(#"hash_9eb7f104b26e17c", 1);

      if(isPlayer(var_adb68654) && var_adb68654 != attacker) {
        var_adb68654 stats::function_dad108fa(#"hash_9eb7f104b26e17c", 1);
      }
    }
  }

  if(isDefined(var_f2bc9529) && isDefined(var_f2bc9529) && var_f2bc9529 + 3000 > time) {
    if(distancesquared(victimorigin, var_117e9294) <= 1000000) {
      attacker stats::function_dad108fa(#"hash_77fa206964523e57", 1);
    }
  }

  if(data.var_ae515dc9 === 1 || data.var_5a900b8f === 1) {
    attacker stats::function_dad108fa(#"hash_548697522dba9e7a", 1);
  }

  if(isDefined(baseweapon.statname)) {
    switch (baseweapon.statname) {
      case # "hash_ed62df533816471":
      case # "napalm_strike":
      case # "sig_bow_flame":
      case # "eq_molotov":
      case # "hero_flamethrower":
        attacker stats::function_dad108fa(#"hash_5f4d95085e8f9a1c", 1);
        attacker stats::function_bcf9602(#"hash_513bc9963a91d4b5", 1, #"hash_735ace6b22542a65");
        break;
      case # "land_mine":
      case # "tear_gas":
      case # "satchel_charge":
        if(data.var_b4e7eecb || data.var_fb4d11c6 || data.var_c496a910 || isDefined(data.var_7c5ded5a) && data.var_7c5ded5a + 3000 > time || isDefined(data.var_4a01f856) && data.var_4a01f856 + 3000 > time || isDefined(data.var_a1c9eb28) && data.var_a1c9eb28 + 3000 > time) {
          attacker stats::function_dad108fa(#"hash_9d7fba655e34b0a", 1);
        }

        break;
    }
  }

  if(!isDefined(attacker.pers[#"hash_68aee41059ec5bad"])) {
    if(attacker.pers[#"hash_66340bee14d4bc05"] > 0 && attacker.pers[#"hash_5ecbfbcefa68d091"] > 0 && attacker.pers[#"hash_4c09a54d2f2a741f"] && player.pers[#"hash_253555289d0b2bcf"] > 0) {
      attacker.pers[#"hash_68aee41059ec5bad"] = 1;
      attacker stats::function_dad108fa(#"hash_427fcf61792ac9eb", 1);
    }
  }

  attacker.var_3c9fd034 = weapon;
}

function on_player_spawn() {
  profilestart();

  if(canprocesschallenges()) {
    self fix_challenge_stats_on_spawn();
    self function_b6d44fd9();
  }

  self function_6b34141d();
  profilestop();
}

function function_b6d44fd9() {
  self.var_ea1458aa = {};
}

function force_challenge_stat(stat_name, stat_value) {
  self stats::set_stat_global(stat_name, stat_value);
  self stats::set_stat_challenge(stat_name, stat_value);
}

function get_challenge_group_stat(group_name, stat_name) {
  return self stats::get_stat(#"groupstats", group_name, #"stats", stat_name, #"challengevalue");
}

function fix_challenge_stats_on_spawn() {
  player = self;

  if(!isDefined(player)) {
    return;
  }

  if(player.var_8efcbd6a === 1) {
    return;
  }

  player thread function_4039ce49();
  player.var_8efcbd6a = 1;
}

function private function_4039ce49() {
  player = self;
  player endon(#"disconnect");

  while(game.state != # "playing") {
    wait 1;
  }

  wait_time = randomfloatrange(3, 5);
  wait wait_time;

  if(!isDefined(player)) {
    return;
  }

  profilestart();
  player function_ba57595b();
  player function_8f60c536();
  profilestop();
}

function private function_8f60c536() {
  player = self;
  params = {};
  primary_weapon = player loadout::function_18a77b37("primary");

  if(isDefined(primary_weapon) && primary_weapon != level.weaponnone) {
    params.item_index = getbaseweaponitemindex(primary_weapon);
    player function_4e40694d(#"hash_354a96dc1d24e7a3", params);
  }

  secondary_weapon = player loadout::function_18a77b37("secondary");

  if(isDefined(secondary_weapon) && secondary_weapon != level.weaponnone) {
    params.item_index = getbaseweaponitemindex(secondary_weapon);
    player function_4e40694d(#"hash_354a96dc1d24e7a3", params);
  }
}

function private function_ba57595b() {
  if(!util::isfirstround()) {
    return;
  }

  player = self;
  player function_ee1898d0();
}

function function_ee1898d0() {
  if(self stats::function_af5584ca(#"top_scorer") === 3 && !(self stats::function_af5584ca(#"hash_70c5595e6963954b") === 1)) {
    if(self stats::function_af5584ca(#"hash_726639776bb5add") === 3 && self stats::function_af5584ca(#"hash_4551622490fb634f") === 3 && self stats::function_af5584ca(#"hash_20b4a91c344d73ec") === 3 && self stats::function_af5584ca(#"hash_59a333a70cbf2d40") === 1 && self stats::function_af5584ca(#"featured_in_best_play") === 1) {
      self stats::function_dad108fa(#"hash_70c5595e6963954b", 1);
    }
  }
}

function function_223ff464() {
  if(!(self stats::get_stat(#"extrabools", 0) === 1)) {
    self force_challenge_stat(#"mastery_marksman", 0);
    marksmanarray = [];
    array::add(marksmanarray, #"hash_4075f20007923416");
    array::add(marksmanarray, #"hash_72d1952fced05f40");
    array::add(marksmanarray, #"hash_70cd6c54d1c07272");
    array::add(marksmanarray, #"hash_6b828c2fcb0e8df5");
    array::add(marksmanarray, #"hash_2ea8a6bab2364c58");
    array::add(marksmanarray, #"hash_7ecfcae46143397c");
    array::add(marksmanarray, #"hash_3b30f98820bc20cf");
    array::add(marksmanarray, #"hash_18816731b999fbfb");
    array::add(marksmanarray, #"hash_6c1c399dcbe1af97");
    array::add(marksmanarray, #"hash_5630ec40181e1db3");
    array::add(marksmanarray, #"hash_354bfe5c140365bf");
    array::add(marksmanarray, #"hash_51eff59939399dc9");

    for(index = 0; index < marksmanarray.size; index++) {
      if(self stats::function_af5584ca(marksmanarray[index]) === 1) {
        self stats::function_dad108fa(#"mastery_marksman", 1);
      }
    }

    self stats::set_stat(#"extrabools", 0, 1);
  }
}

function function_bd5db926() {
  if(!(self stats::get_stat(#"extrabools", 1) === 1)) {
    var_5d157945 = self stats::get_stat_global(#"stats_rcxd_kill");
    recon_car = getweapon(#"hash_38ffd09564931482");
    self stats::function_e24eec31(recon_car, #"kills", var_5d157945);
    self stats::set_stat(#"extrabools", 1, 1);
  }
}

function function_f4106216() {
  if(!(self stats::get_stat(#"playerstatslist", #"hash_195a18a5697c5c96") === 1)) {
    challengetier = self stats::function_af5584ca("shutdown_gravslam_before_impact");

    if(!isDefined(challengetier)) {
      return;
    }

    if(challengetier > 0) {
      self stats::function_8e071909("stats_gravity_slam_shutdown", challengetier);
    }

    challengevalue = self stats::get_stat_challenge("shutdown_gravslam_before_impact");
    self stats::set_stat_challenge("stats_gravity_slam_shutdown", challengevalue);
    self stats::set_stat(#"playerstatslist", #"hash_195a18a5697c5c96", 1);
  }
}

function function_34364901() {
  player = self;
  var_fae27922 = player stats::get_stat(#"item_stats", #"sniper_locus_t8", #"challenges_tu", #"challengevalue");

  if(var_fae27922 === 6) {
    player stats::set_stat(#"item_stats", #"sniper_locus_t8", #"challenges_tu", #"challengevalue", 5);
    player stats::set_stat(#"item_stats", #"sniper_locus_t8", #"challenges_tu", #"statvalue", 5);
    player stats::set_stat(#"item_stats", #"sniper_locus_t8", #"challenges_tu", #"challengetier", 0);
    player addweaponstat(getweapon(#"sniper_locus_t8"), #"challenges_tu", 1);
  }
}

function fix_tu6_weapon_for_diamond(stat_name) {
  player = self;
  wepaon_for_diamond = player stats::get_stat_challenge(stat_name);

  if(wepaon_for_diamond == 1) {
    secondary_mastery = player stats::get_stat_challenge("secondary_mastery");

    if(secondary_mastery == 3) {
      player force_challenge_stat(stat_name, 2);
      return;
    }

    player force_challenge_stat(stat_name, 0);
  }
}

function fix_tu6_ar_garand() {
  player = self;
  group_weapon_assault = player get_challenge_group_stat("weapon_assault", "challenges");
  weapons_mastery_assault = player stats::get_stat_challenge("weapons_mastery_assault");

  if(group_weapon_assault >= 49 && weapons_mastery_assault < 1) {
    player force_challenge_stat("weapons_mastery_assault", 1);
    player stats::function_dad108fa(#"ar_garand_for_diamond", 1);
  }
}

function fix_tu6_pistol_shotgun() {
  player = self;
  group_weapon_pistol = player get_challenge_group_stat("weapon_pistol", "challenges");
  secondary_mastery_pistol = player stats::get_stat_challenge("secondary_mastery_pistol");

  if(group_weapon_pistol >= 21 && secondary_mastery_pistol < 1) {
    player force_challenge_stat("secondary_mastery_pistol", 1);
    player stats::function_dad108fa(#"pistol_shotgun_for_diamond", 1);
  }
}

function completed_specific_challenge(target_value, challenge_name) {
  challenge_count = self stats::get_stat_challenge(challenge_name);
  return challenge_count >= target_value;
}

function tally_completed_challenge(target_value, challenge_name) {
  return self completed_specific_challenge(target_value, challenge_name) ? 1 : 0;
}

function tu7_fix_100_percenter() {
  self tu7_fix_mastery_perk_2();
}

function tu7_fix_mastery_perk_2() {
  player = self;
  mastery_perk_2 = player stats::get_stat_challenge("mastery_perk_2");

  if(mastery_perk_2 >= 12) {
    return;
  }

  if(player completed_specific_challenge(200, "earn_scorestreak_anteup") == 0) {
    return;
  }

  perk_2_tally = 1;
  perk_2_tally += player tally_completed_challenge(100, #"destroy_ai_scorestreak_coldblooded");
  perk_2_tally += player tally_completed_challenge(100, #"kills_counteruav_emp_hardline");
  perk_2_tally += player tally_completed_challenge(200, #"kill_after_resupply");
  perk_2_tally += player tally_completed_challenge(100, #"kills_after_sprint_fasthands");
  perk_2_tally += player tally_completed_challenge(200, #"kill_detect_tracker");
  perk_2_tally += player tally_completed_challenge(10, #"earn_5_scorestreaks_anteup");
  perk_2_tally += player tally_completed_challenge(25, #"kill_scavenger_tracker_resupply");
  perk_2_tally += player tally_completed_challenge(25, #"kill_hardwired_coldblooded");
  perk_2_tally += player tally_completed_challenge(25, #"kill_anteup_overclock_scorestreak_specialist");
  perk_2_tally += player tally_completed_challenge(50, #"kill_fasthands_gungho_sprint");
  perk_2_tally += player tally_completed_challenge(50, #"kill_tracker_sixthsense");

  if(mastery_perk_2 < perk_2_tally) {
    player stats::function_dad108fa(#"mastery_perk_2", 1);
  }
}

function getbaseweapon(weapon) {
  rootweapon = weapons::getbaseweapon(weapon);
  baseweapon = getweapon(rootweapon.statname);

  if(level.weaponnone == baseweapon) {
    baseweapon = rootweapon;
  }

  return baseweapon.rootweapon;
}

function function_8e3fdb84(baseweapon, player, weaponclass) {
  assert(isDefined(baseweapon));
  assert(isDefined(player.weaponkillsthisspawn));

  if(isDefined(player.weaponkillsthisspawn[baseweapon])) {
    player.weaponkillsthisspawn[baseweapon]++;
    weaponkillsthisspawn = player.weaponkillsthisspawn[baseweapon];
    isballisticknife = baseweapon === level.weaponballisticknife;

    if(weaponkillsthisspawn % 2 == 0 && !isballisticknife) {
      player stats::function_e24eec31(baseweapon, #"killstreak_3", 1);
    }

    if(weaponkillsthisspawn % 3 == 0) {
      if(baseweapon.islethalgrenade && player hastalent(#"talent_quartermaster")) {
        player contracts::increment_contract(#"hash_1c0d581d27b54c2a");
      }

      if(isballisticknife) {
        player stats::function_e24eec31(baseweapon, #"killstreak_3", 1);
      }

      if(weaponclass === # "weapon_knife" && !isDefined(player.pers[#"hash_2b0aa9d6dc24efd7"])) {
        player stats::function_d0de7686(#"hash_515b8f2bd79567f8", 1, #"hash_2b6ca84b97ab9928");
        player.pers[#"hash_2b0aa9d6dc24efd7"] = 1;
      }
    }

    if(weaponkillsthisspawn % 2 == 0) {
      if(baseweapon.islethalgrenade && player hastalent(#"talent_quartermaster")) {
        player stats::function_dad108fa(#"hash_4b735f945ca5d5b5", 1);
      }
    }

    return;
  }

  player.weaponkillsthisspawn[baseweapon] = 1;
}

function function_7fd1799f(baseweapon, player, weaponclass, meansofdeath) {
  assert(isDefined(baseweapon));
  assert(isDefined(player.weaponkillsthisspawn));

  if(isDefined(player.weaponkillsthisspawn[baseweapon])) {
    player.weaponkillsthisspawn[baseweapon]++;
    weaponkillsthisspawn = player.weaponkillsthisspawn[baseweapon];

    if(weaponkillsthisspawn % 3 == 0) {
      player stats::function_e24eec31(baseweapon, #"killstreak_3", 1);

      if(weaponclass === # "weapon_cqb") {
        player stats::function_dad108fa(#"hash_71469963d480c64e", 1);

        if(!isDefined(player.pers[#"hash_21f4e05360177d4b"])) {
          player stats::function_d0de7686(#"hash_458e8316073535c4", 1, #"hash_37fcfdb6e2a551aa");
          player.pers[#"hash_21f4e05360177d4b"] = 1;
        }
      } else if(weaponclass === # "weapon_assault") {
        player stats::function_dad108fa(#"hash_18fc969186722670", 1);
        player stats::function_dad108fa(#"hash_50513027398440db", 1);

        if(!isDefined(player.pers[#"hash_19bc4812e186371a"])) {
          player stats::function_841e4896(#"hash_4749db0b7b2d6e3", 1, #"hash_51465116c1efc9be", #"ar_fasthandling_t9");
          player.pers[#"hash_19bc4812e186371a"] = 1;
        }
      } else if(weaponclass === # "weapon_smg" && !isDefined(player.pers[#"hash_1e0b27804513787"])) {
        player stats::function_841e4896(#"hash_6b9dbfd78454d618", 1, #"hash_3142d28c7a02bdf7", #"smg_accurate_t9");
        player.pers[#"hash_1e0b27804513787"] = 1;
      }
    }

    if(weaponkillsthisspawn % 5 == 0) {
      player stats::function_e24eec31(baseweapon, #"killstreak_5", 1);
    }

    if(weaponkillsthisspawn == 30) {
      player stats::function_e24eec31(baseweapon, #"killstreak_30", 1);
    }
  } else {
    player.weaponkillsthisspawn[baseweapon] = 1;
  }

  if(weaponclass === # "weapon_cqb") {
    if(isDefined(player.var_341473f2[weaponclass])) {
      player.var_341473f2[weaponclass]++;

      if(player.var_341473f2[weaponclass] % 3 == 0) {
        player stats::function_dad108fa(#"hash_38bc3cf519198f90", 1);
      }
    } else {
      player.var_341473f2[weaponclass] = 1;
    }
  }

  if(is_true(player.var_9cd2c51d.var_697d048e)) {
    if(!is_true(player.var_a570722a)) {
      var_32b01dc1 = 0;

      foreach(weaponkillsthisspawn in player.weaponkillsthisspawn) {
        var_32b01dc1 += weaponkillsthisspawn;
      }

      if(var_32b01dc1 >= 5) {
        player.var_a570722a = 1;
        player stats::function_dad108fa(#"hash_3fe247a47fed579e", 1);
      }
    }

    if(!is_true(player.var_1d821323)) {
      if(!isDefined(var_32b01dc1)) {
        var_32b01dc1 = 0;

        foreach(weaponkillsthisspawn in player.weaponkillsthisspawn) {
          var_32b01dc1 += weaponkillsthisspawn;
        }
      }

      if(var_32b01dc1 >= 3) {
        player.var_1d821323 = 1;
        player stats::function_dad108fa(#"hash_7ef1a1bd8a7aaea7", 1);
      }
    }
  }

  if(baseweapon === level.weaponballisticknife) {
    if(!isDefined(player.var_492785e6[baseweapon])) {
      player.var_492785e6[baseweapon] = {};
    }

    var_62fdcebe = player.var_492785e6[baseweapon];

    if(!isDefined(var_62fdcebe.var_94e54112)) {
      var_62fdcebe.var_94e54112 = 0;
    }

    if(!isDefined(var_62fdcebe.var_50bbc52b)) {
      var_62fdcebe.var_50bbc52b = 0;
    }

    if(weapons::ismeleemod(meansofdeath)) {
      var_62fdcebe.var_94e54112++;
    } else {
      var_62fdcebe.var_50bbc52b++;
    }

    if(var_62fdcebe.var_94e54112 >= 1 && var_62fdcebe.var_50bbc52b >= 1) {
      player stats::function_e24eec31(baseweapon, #"hash_55a8e5d42964c1ea", 1);
      var_62fdcebe.var_94e54112--;
      var_62fdcebe.var_50bbc52b--;
    }

    player stats::function_dad108fa(#"hash_47aa6679efd7b139", 1);
    player stats::function_dad108fa(#"hash_47aa6579efd7af86", 1);
  }
}

function function_b2b18857(player) {
  if(isDefined(player.headshots) && player.headshots > 0) {
    if(player.headshots % 5 == 0) {
      player stats::function_dad108fa(#"headshot_5", 1);
    }
  }
}

function checkdualwield(baseweapon, player, attacker, time, attackerwassprinting, attacker_sprint_end) {}

function challengegameendmp(data) {
  player = data.player;
  winner = data.winner;
  var_f5d9e583 = data.place;

  if(!isDefined(player.team)) {
    return;
  }

  if(!level.hostforcedend) {
    if(player.ekia > player.deaths) {
      player stats::function_dad108fa(#"hash_392ee0534adcefe8", 1);
      player stats::function_dad108fa(#"hash_392ee1534adcf19b", 1);
      player stats::function_dad108fa(#"hash_392ee2534adcf34e", 1);
      player stats::function_42277145(#"hash_734f4d49f539ada", 1);
      player stats::function_42277145(#"hash_3d9156bfdb044b3b", 1);
    }

    if(player.ekia > 0 && player.ekia - player.deaths >= player.deaths) {
      player stats::function_dad108fa(#"hash_18ef4c50d0338dbb", 1);
    }

    if(isDefined(player.pers[#"hash_44e8177631c77116"]) && player.pers[#"hash_44e8177631c77116"] >= 5) {
      player stats::function_dad108fa(#"hash_4cef080aa44cd2f6", 1);
    }

    if(getdvarint(#"hash_1ad35129069d0b0a", 0)) {
      player stats::function_bcf9602(#"hash_5677d9133114a8ac", 1, #"hash_5c49df97f4f82e12");
    }

    if(!isDefined(level.var_57662894)) {
      level.var_57662894 = getgametypesetting(#"hash_5183877c20675325") === 1;
    }

    if(level.var_57662894) {
      player stats::function_bcf9602(#"hash_513bd1963a91e24d", 1, #"hash_735ace6b22542a65");
    }

    var_c261010c = 1;

    for(index = 0; index < level.placement[#"all"].size; index++) {
      if(level.placement[#"all"][index].ekia > player.ekia) {
        var_c261010c = 0;
        break;
      }
    }

    if(var_c261010c && player.ekia > 0) {
      player stats::function_dad108fa(#"hash_4c67670e68b1faab", 1);
    }

    player function_a66bed3e();
  }

  if(endedearly(winner, match::get_flag("tie"))) {
    return;
  }

  if(level.teambased) {
    winnerscore = game.stat[#"teamscores"][winner];
    loserscore = getlosersteamscores(winner);
  }

  mostekiasleastdeaths = 1;

  for(index = 0; index < level.placement[#"all"].size; index++) {
    if(level.placement[#"all"][index].deaths < player.deaths) {
      mostekiasleastdeaths = 0;
    }

    if(level.placement[#"all"][index].ekia > player.ekia) {
      mostekiasleastdeaths = 0;
    }
  }

  if(mostekiasleastdeaths && player.ekia > 0 && level.placement[#"all"].size > 3) {
    if(level.teambased) {
      playeriswinner = player.team === winner;
    } else {
      playeriswinner = var_f5d9e583 < 3;
    }

    if(playeriswinner) {
      player stats::function_dad108fa(#"most_ekias_least_deaths", 1);
      player contracts::increment_contract(#"hash_8f83854f9aa068e");
      player stats::function_dad108fa(#"hash_3a99adcb0a44c32b", 1);

      if(level.basegametype == # "tdm" || level.basegametype == # "dm" || level.basegametype == # "sd") {
        player stats::function_dad108fa(#"hash_59a333a70cbf2d40", 1);
      }
    }
  }

  var_172b2a9d = 0;

  if(var_f5d9e583 < 3) {
    player contracts::player_contract_event(#"hash_32ed5d2b274397c1");

    if(level.hardcoremode) {
      player stats::function_dad108fa(#"hash_4551622490fb634f", 1);
    } else if(!level.arenamatch) {
      player stats::function_dad108fa(#"hash_726639776bb5add", 1);
    }

    if(level.basegametype == # "dm" || level.var_9ff21849) {
      player stats::function_dad108fa(#"hash_52acb9c328698c58", 1);
      var_172b2a9d = 1;
    }

    if(level.var_9ff21849) {
      player stats::function_dad108fa(#"hash_53c962b66dc62fd1", 1);
    }

    if(!isDefined(level.var_57662894)) {
      level.var_57662894 = getgametypesetting(#"hash_5183877c20675325") === 1;
    }

    if(level.basegametype == # "scream" && level.var_57662894) {
      player stats::function_bcf9602(#"hash_513bcf963a91dee7", 1, #"hash_735ace6b22542a65");
    }
  }

  if(!isDefined(level.var_77e0887f)) {
    level.var_77e0887f = level.placement[#"all"].size;
  }

  if((var_f5d9e583 + 1) / level.var_77e0887f <= 0.1) {
    player stats::function_dad108fa(#"hash_1fdfb27491a52cc2", 1);
  }

  if((var_f5d9e583 + 1) / level.var_77e0887f <= 0.25) {
    player stats::function_dad108fa(#"hash_5221b0475b9fd5af", 1);
    player stats::function_dad108fa(#"hash_1970343201f6d4b2", 1);
    player stats::function_dad108fa(#"hash_1970323201f6d14c", 1);
    player stats::function_42277145(#"hash_7208e7149645434d", 1);
  }

  if(level.var_9ff21849 && player.team == winner) {
    player stats::function_dad108fa(#"hash_20b4a91c344d73ec", 1);
  }

  if(level.teambased && !var_172b2a9d && player.team === winner) {
    player stats::function_dad108fa(#"hash_52acb9c328698c58", 1);
    var_172b2a9d = 1;
  }

  if(level.teambased && !level.var_9ff21849 ? player.team === winner : var_f5d9e583 < 3) {
    player stats::function_42277145(#"hash_24abab59aafa481e", 1);

    if(getdvarint(#"hash_1ad35129069d0b0a", 0)) {
      player stats::function_bcf9602(#"hash_4941bc4d64a8e38", 1, #"hash_5c49df97f4f82e12");
    }
  }

  switch (level.basegametype) {
    case # "tdm":
      if(player.team == winner) {
        if(winnerscore >= loserscore + 25) {
          player stats::function_d40764f3(#"crush", 1);
          player stats::function_dad108fa(#"hash_38cf622aaf2ce3d7", 1);
        }
      }

      break;
    case # "dm":
      if(player == winner) {
        if(level.placement[#"all"].size >= 2) {
          secondplace = level.placement[#"all"][1];

          if(player.kills >= secondplace.kills + 7) {
            player stats::function_d40764f3(#"crush", 1);
            player stats::function_dad108fa(#"hash_38cf622aaf2ce3d7", 1);
          }

          player stats::function_dad108fa(#"hash_20b4a91c344d73ec", 1);
        }
      }

      break;
    case # "ctf":
      if(player.team == winner) {
        if(loserscore == 0) {
          player stats::function_d40764f3(#"shut_out", 1);
        }
      }

      break;
    case # "dom":
      if(player.team == winner) {
        if(winnerscore >= loserscore + 70) {
          player stats::function_d40764f3(#"crush", 1);
          player stats::function_dad108fa(#"hash_1b0c06f37648493f", 1);
        }
      }

      break;
    case # "hq":
      if(player.team == winner && winnerscore > 0) {
        if(winnerscore >= loserscore + 70) {
          player stats::function_d40764f3(#"crush", 1);
        }
      }

      break;
    case # "koth":
      if(player.team == winner && winnerscore > 0) {
        if(winnerscore >= loserscore + 70) {
          player stats::function_d40764f3(#"crush", 1);
          player stats::function_dad108fa(#"hash_1b0c06f37648493f", 1);
        }
      }

      if(player.team == winner && winnerscore > 0) {
        if(winnerscore >= loserscore + 110) {
          player stats::function_d40764f3(#"annihilation", 1);
        }
      }

      break;
    case # "dem":
      if(player.team == game.defenders && player.team == winner) {
        if(loserscore == 0) {
          player stats::function_d40764f3(#"shut_out", 1);
        }
      }

      if(player.team == winner) {
        player stats::function_bcf9602(#"hash_5a96fe436e73343", 1, #"hash_6abe83944d701459");
      }

      break;
    case # "control":
    case # "sd":
    case # "bounty":
      if(player.team == winner) {
        if(loserscore == 0) {
          player stats::function_d40764f3(#"crush", 1);
          player stats::function_dad108fa(#"hash_644326620d99cbbb", 1);
        }
      }

      break;
    case # "conf":
      if(player.team == winner) {
        if(winnerscore >= loserscore + 25) {
          player stats::function_d40764f3(#"crush", 1);
        }
      }

      break;
    case # "gunfight":
      if(player.team == winner) {
        player stats::function_dad108fa(#"hash_5072c55850678079", 1);
      }

      break;
    default:
      break;
  }
}

function function_ea966b4a(killstreak, var_18db7a57, weapon) {
  if(!isDefined(killstreak) || !isDefined(self) || !isPlayer(self)) {
    return;
  }

  self stats::function_dad108fa(#"hash_2d62481543a7209", 1);
  self stats::function_dad108fa(#"hash_139b997bc49d4b16", 1);

  if(self.var_311d1335 !== 1 && self stats::get_stat_global(#"hash_2d62481543a7209") >= 50) {
    self giveachievement(#"mp_achievement_scorestreak_kills");
    self.var_311d1335 = 1;
  }

  self stats::function_dad108fa(#"hash_4693318a66e8a0b7", 1);
  self stats::function_dad108fa(#"hash_15fb183dc7fd005f", 1);
  self stats::function_dad108fa(#"hash_1d73823f33cb13ff", 1);
  self stats::function_dad108fa(#"hash_382ca9fc9d4af1ee", 1);
  self stats::function_bcf9602(#"hash_5a972e436e7385c", 1, #"hash_6abe83944d701459");
  self stats::function_42277145(#"hash_7208e01496453768", 1);
  self.pers[#"hash_253555289d0b2bcf"]++;

  if(self.pers[#"hash_253555289d0b2bcf"] % 5 == 0) {
    self stats::function_dad108fa(#"hash_39e738852f3d1b6e", 1);
  }

  playercontrolled = 0;

  switch (killstreak) {
    case # "remote_missile":
    case # "inventory_planemortar":
    case # "napalm_strike":
    case # "inventory_remote_missile":
    case # "inventory_napalm_strike":
    case # "planemortar":
      var_6616c2ea = 1;
    case # "dart":
    case # "hoverjet":
    case # "inventory_chopper_gunner":
    case # "chopper_gunner":
    case # "inventory_dart":
    case # "inventory_straferun":
    case # "inventory_ac130":
    case # "straferun":
    case # "ac130":
    case # "inventory_hoverjet":
      playercontrolled = 1;
    case # "drone_squadron":
    case # "inventory_drone_squadron":
    case # "overwatch_helicopter":
    case # "helicopter_comlink":
    case # "inventory_overwatch_helicopter":
    case # "inventory_helicopter_comlink":
      self stats::function_dad108fa(#"air_assault_total_kills", 1);
      self stats::function_dad108fa(#"hash_3a2c1b5b8901cb5b", 1);
      self stats::function_dad108fa(#"hash_3837599602e870c", 1);
      self contracts::player_contract_event(#"air_assault_total_kills");
      break;
    case # "recon_car":
    case # "inventory_recon_car":
      self stats::function_dad108fa(#"hash_7686cce076b616b", 1);
      playercontrolled = 1;
    case # "ultimate_turret":
    case # "inventory_ultimate_turret":
    case # "tank_robot":
    case # "swat_team":
    case # "inventory_tank_robot":
    case # "inventory_swat_team":
      self stats::function_dad108fa(#"hash_10b0c56ae630070d", 1);
      self contracts::player_contract_event(#"hash_10b0c56ae630070d");
      break;
  }

  if(playercontrolled && var_18db7a57 === 4) {
    self stats::function_dad108fa(#"hash_6400ff0ff3d29c3e", 1);
  }

  if(var_6616c2ea === 1) {
    self stats::function_dad108fa(#"hash_6e9e59a789ec1e80", 1);
    self stats::function_dad108fa(#"hash_519555d106fdf1e7", 1);
    self stats::function_dad108fa(#"hash_500ec14cbdae7c8a", 1);
    self stats::function_dad108fa(#"hash_500ec24cbdae7e3d", 1);
  }

  if(killstreak == "napalm_strike" || killstreak == "inventory_napalm_strike") {
    self stats::function_dad108fa(#"hash_61993e47134677e2", 1);
    self stats::function_dad108fa(#"hash_61993c471346747c", 1);
  }

  if(var_18db7a57 === 2) {
    self stats::function_dad108fa(#"hash_46d214ee909c2c6a", 1);
  }

  if(weapon.iscarriedkillstreak === 1) {
    self stats::function_dad108fa(#"hash_5eb597b88ee14385", 1);
    self stats::function_dad108fa(#"hash_4f81cd91028ce8d2", 1);
    self stats::function_dad108fa(#"hash_4f81cb91028ce56c", 1);
  }
}

function function_2f462ffd(victim, weapon, inflictor, objective) {
  if(!isDefined(objective)) {
    return;
  }

  if(!isPlayer(self)) {
    return;
  }

  if(!isPlayer(inflictor)) {
    return;
  }

  if(!isDefined(self.team)) {
    return;
  }

  if(!isDefined(inflictor.team)) {
    return;
  }

  if(level.teambased) {
    if(self.team == inflictor.team) {
      return;
    }
  } else if(self == inflictor) {
    return;
  }

  killstreak = killstreaks::get_from_weapon(objective);

  if(isDefined(killstreak)) {
    switch (killstreak) {
      case # "dart":
      case # "remote_missile":
      case # "inventory_planemortar":
      case # "drone_squadron":
      case # "inventory_drone_squadron":
      case # "overwatch_helicopter":
      case # "inventory_dart":
      case # "inventory_straferun":
      case # "inventory_ac130":
      case # "inventory_remote_missile":
      case # "straferun":
      case # "ac130":
      case # "helicopter_comlink":
      case # "planemortar":
      case # "inventory_overwatch_helicopter":
      case # "inventory_helicopter_comlink":
        self stats::function_dad108fa(#"hash_55a5fc51678a4dde", 1);
        break;
      case # "recon_car":
      case # "inventory_recon_car":
        self stats::function_dad108fa(#"hash_7daf653f5e86b75", 1);
      case # "ultimate_turret":
      case # "inventory_ultimate_turret":
      case # "tank_robot":
      case # "swat_team":
      case # "inventory_tank_robot":
      case # "inventory_swat_team":
        self stats::function_dad108fa(#"hash_1efa6ab922134e1d", 1);
        break;
    }
  } else {
    if(level.hardcoremode) {
      self stats::function_dad108fa(#"hash_753f02ea48b19cd", 1);
    } else if(!level.arenamatch) {
      self stats::function_dad108fa(#"hash_45fca5cee12d8bdb", 1);
    }

    self stats::function_dad108fa(#"objective_ekia", 1);
    self contracts::player_contract_event(#"objective_ekia");
    scoreevents = globallogic_score::function_3cbc4c6c(objective.var_2e4a8800);
    var_8a4cfbd = objective.var_76ce72e8 && isDefined(scoreevents) && scoreevents.var_fcd2ff3a === 1;

    if(var_8a4cfbd) {
      self stats::function_dad108fa(#"hash_d4a989a2da3fa72", 1);
    } else if(objective.issignatureweapon) {
      self stats::function_dad108fa(#"hash_6c3172682467122", 1);
    }

    if(isDefined(inflictor.var_ea1458aa)) {
      var_d72bd991 = inflictor.var_ea1458aa.attackerdamage[self.clientid];

      if(isDefined(var_d72bd991.class_num)) {
        gear = self function_b958b70d(var_d72bd991.class_num, "tacticalgear");
      }

      if(gear === # "gear_medicalinjectiongun") {
        if(var_d72bd991.var_46a82df0 === 1) {
          self stats::function_dad108fa(#"hash_47c5c8af0f105c71", 1);
        }
      } else if(gear === # "gear_equipmentcharge") {
        if(var_8a4cfbd) {
          if(!isDefined(self.var_9cd2c51d.var_17ff6e52)) {
            self.var_9cd2c51d.var_17ff6e52 = 0;
          }

          self.var_9cd2c51d.var_17ff6e52++;

          if(self.var_9cd2c51d.var_17ff6e52 == 5) {
            self stats::function_dad108fa(#"hash_386525eb8f4537c2", 1);
          }
        }
      }
    }
  }

  victimweapon = inflictor.currentweapon;
  var_2cf35051 = globallogic_score::function_3cbc4c6c(victimweapon.var_2e4a8800);

  if(victimweapon.issignatureweapon === 1 || isDefined(var_2cf35051) && var_2cf35051.var_fcd2ff3a === 1) {
    self stats::function_dad108fa(#"end_enemy_specialist_weapon_on_objective", 1);
  }
}

function function_82bb78f7(weapon, victim) {
  if(!isDefined(self) || !isPlayer(self) || !isDefined(weapon) || isDefined(killstreaks::get_from_weapon(weapon))) {
    return;
  }

  if(isDefined(victim.var_1318544a)) {
    victim.var_1318544a.var_60cb0c39 = 1;
  }

  if(!isDefined(self.pers[#"hash_44e8177631c77116"])) {
    self.pers[#"hash_44e8177631c77116"] = 0;
  }

  self.pers[#"hash_44e8177631c77116"]++;
  self activecamo::function_896ac347(weapon, #"vanguard", 1);

  if(isDefined(self.var_aef7ad9) && self.var_aef7ad9 + int(5 * 1000) >= gettime()) {
    self activecamo::function_896ac347(weapon, #"rapid_vanguard", 1);
  }

  self.var_aef7ad9 = gettime();
}

function function_e0f51b6f(weapon) {
  should_award = 0;

  if(weapon.issignatureweapon) {
    should_award = 1;
  } else {
    scoreevents = globallogic_score::function_3cbc4c6c(weapon.var_2e4a8800);
    should_award = weapon.var_76ce72e8 && isDefined(scoreevents) && scoreevents.var_fcd2ff3a === 1;
  }

  if(should_award) {
    self stats::function_dad108fa(#"hash_7dfdf288a8fccdb0", 1);
  }
}

function function_57ca42c6(weapon) {
  should_award = 0;

  if(weapon.issignatureweapon) {
    should_award = 1;
  } else {
    scoreevents = globallogic_score::function_3cbc4c6c(weapon.var_2e4a8800);
    should_award = weapon.var_76ce72e8 && isDefined(scoreevents) && scoreevents.var_fcd2ff3a === 1;
  }

  if(should_award) {
    self stats::function_dad108fa(#"hash_7ddba69a0de126e5", 1);
  }
}

function killedbaseoffender(objective, weapon, inflictor) {
  self endon(#"disconnect");
  self stats::function_bb7eedf0(#"defends", 1);
  self.challenge_offenderkillcount++;

  if(isDefined(self.var_ea1458aa) && isDefined(objective)) {
    if(!isDefined(self.var_ea1458aa.challenge_objectiveoffensive) || !(self.var_ea1458aa.challenge_objectiveoffensive === objective)) {
      self.var_ea1458aa.challenge_objectiveoffensivekillcount = 0;
    }

    self.var_ea1458aa.challenge_objectiveoffensivekillcount++;
    self.var_ea1458aa.challenge_objectiveoffensive = objective;

    if(self.var_ea1458aa.challenge_objectiveoffensivekillcount > 4) {
      self stats::function_dad108fa(#"multikill_5_attackers", 1);
      self.var_ea1458aa.challenge_objectiveoffensivekillcount = 0;
    }
  }

  killstreak = killstreaks::get_from_weapon(weapon);

  if(isDefined(killstreak)) {
    switch (killstreak) {
      case # "remote_missile":
      case # "inventory_planemortar":
      case # "inventory_straferun":
      case # "inventory_remote_missile":
      case # "straferun":
      case # "planemortar":
        self.challenge_offenderprojectilemultikillcount++;
        break;
      case # "helicopter_comlink":
      case # "inventory_helicopter_comlink":
        self.challenge_offendercomlinkkillcount++;
        break;
      case # "combat_robot":
      case # "inventory_combat_robot":
        self stats::function_dad108fa(#"kill_attacker_with_robot_or_tank", 1);
        break;
      case # "autoturret":
      case # "inventory_autoturret":
        self.challenge_offendersentryturretkillcount++;
        self stats::function_dad108fa(#"kill_attacker_with_robot_or_tank", 1);
        break;
      case # "swat_team":
      case # "inventory_swat_team":
        self stats::function_dad108fa(#"hash_103a235d7563069c", 1);
        break;
      case # "ultimate_turret":
      case # "inventory_ultimate_turret":
        self stats::function_dad108fa(#"hash_103a235d7563069c", 1);

        if(isDefined(inflictor)) {
          if(!isDefined(inflictor.var_d6489fb6)) {
            inflictor.var_d6489fb6 = 0;
          }

          inflictor.var_d6489fb6++;

          if(inflictor.var_d6489fb6 == 3) {
            self stats::function_dad108fa(#"hash_1379d16cee958f3e", 1);
          }
        }

        break;
    }
  }

  if(self.challenge_offendercomlinkkillcount == 2) {
    self stats::function_dad108fa(#"kill_2_attackers_with_comlink", 1);
  }

  if(self.challenge_offendersentryturretkillcount > 2) {
    self stats::function_dad108fa(#"multikill_3_attackers_ai_tank", 1);
    self.challenge_offendersentryturretkillcount = 0;
  }

  self contracts::player_contract_event(#"offender_kill");
  self waittilltimeoutordeath(4);

  if(self.challenge_offenderkillcount > 1) {
    self stats::function_dad108fa(#"hash_4b3049ba027dd495", 1);
  }

  self.challenge_offenderkillcount = 0;

  if(self.challenge_offenderprojectilemultikillcount >= 2) {
    self stats::function_dad108fa(#"multikill_2_objective_scorestreak_projectile", 1);
  }

  self.challenge_offenderprojectilemultikillcount = 0;
}

function killedbasedefender(objective) {
  self endon(#"disconnect");
  self stats::function_bb7eedf0(#"offends", 1);

  if(!isDefined(self.challenge_objectivedefensive) || self.challenge_objectivedefensive !== objective) {
    self.challenge_objectivedefensivekillcount = 0;
  }

  self.challenge_objectivedefensivekillcount++;
  self.challenge_objectivedefensive = objective;
  self.challenge_defenderkillcount++;
  self contracts::player_contract_event(#"defender_kill");
  self waittilltimeoutordeath(4);

  if(self.challenge_defenderkillcount > 1) {
    self stats::function_dad108fa(#"hash_4b3049ba027dd495", 1);
  }

  self.challenge_defenderkillcount = 0;
}

function waittilltimeoutordeath(timeout) {
  self endon(#"death");
  wait timeout;
}

function killstreak_30_noscorestreaks() {
  if(level.gametype == "dm" || level.gametype == "dm_hc") {
    self stats::function_dad108fa(#"killstreak_30_no_scorestreaks", 1);
  }
}

function calledincomlinkchopper() {
  self.challenge_offendercomlinkkillcount = 0;
}

function combat_robot_damage(eattacker, combatrobotowner) {
  if(!isDefined(eattacker.challenge_combatrobotattackclientid[combatrobotowner.clientid])) {
    eattacker.challenge_combatrobotattackclientid[combatrobotowner.clientid] = spawnStruct();
  }
}

function trackkillstreaksupportkills(victim) {
  if(isDefined(level.activeplayeruavs[self.entnum]) && level.activeplayeruavs[self.entnum] > 0 && (!isDefined(level.forceradar) || level.forceradar == 0)) {
    self stats::function_e24eec31(getweapon(#"uav"), #"kills_while_active", 1);
  }

  if(isDefined(level.activeplayersatellites) && level.activeplayersatellites[self.entnum] > 0) {
    self stats::function_e24eec31(getweapon(#"satellite"), #"kills_while_active", 1);
  }

  if(isDefined(level.activeplayercounteruavs[self.entnum]) && level.activeplayercounteruavs[self.entnum] > 0) {
    self stats::function_e24eec31(getweapon(#"counteruav"), #"kills_while_active", 1);
  }

  if(isDefined(victim.lastmicrowavedby) && victim.lastmicrowavedby == self) {
    self stats::function_e24eec31(getweapon(#"microwave_turret"), #"kills_while_active", 1);
  }
}

function event_handler[reload] function_b4174270(eventstruct) {
  if(level.var_e7c95d09 === 1) {
    return;
  }

  currentweapon = eventstruct.weapon;

  if(currentweapon == level.weaponnone) {
    return;
  }

  time = gettime();
  self.lastreloadtime = time;

  if(isDefined(self.var_ea1458aa)) {
    self.var_ea1458aa.var_23f5861b = undefined;
  }

  if(weaponhasattachment(currentweapon, "fastreload")) {
    self.lastfastreloadtime = time;
  }

  weaponclass = util::getweaponclass(currentweapon);
  weaponclass = isstring(weaponclass) ? hash(weaponclass) : weaponclass;

  if(isDefined(self.var_e846bafa[weaponclass]) && isDefined([])) {
    self.var_e846bafa[weaponclass] = undefined;
  }
}

function longdistancekillmp(weapon, meansofdeath, var_ccf15c41) {
  self stats::function_e24eec31(weapon, #"longshot_kill", 1);
  self stats::function_dad108fa(#"hash_6735e4eb7d54b9f4", 1);
  self stats::function_dad108fa(#"hash_191b00b02f6c4144", 1);
  self stats::function_dad108fa(#"hash_48c09600fe06dba9", 1);

  if(isDefined(weapon.attachments) && weapon.attachments.size > 1) {
    if(self weaponhasattachmentandunlocked(weapon, "barrel", "suppressed")) {
      if(self getweaponoptic(weapon) != "") {
        self stats::function_dad108fa(#"long_shot_longbarrel_suppressor_optic", 1);
      }
    }
  }

  weaponclass = util::getweaponclass(weapon);

  if(weaponclass === # "weapon_sniper") {
    if(!isDefined(self.pers[#"hash_34fa8e9b0799c487"])) {
      self.pers[#"hash_34fa8e9b0799c487"] = 0;
    }

    self.pers[#"hash_34fa8e9b0799c487"]++;

    if(self.pers[#"hash_34fa8e9b0799c487"] == 2) {
      self stats::function_d0de7686(#"hash_4733deea0d442bf1", 1, #"hash_699bb6cd0eb6fe01");
    }

    if(var_ccf15c41 * 0.000645161 > sqr(250)) {
      self stats::function_dad108fa(#"hash_5d07bb5d067ff8da", 1);
    }

    if(meansofdeath === "MOD_HEAD_SHOT") {
      self stats::function_dad108fa(#"hash_18a3416361174e88", 1);
    }
  } else if(weaponclass === # "weapon_assault") {
    if(!isDefined(self.pers[#"hash_64b2f411af96d828"])) {
      self stats::function_841e4896(#"hash_48bce293a3c7ef5d", 1, #"hash_1b9cabf1c8e31391", #"ar_slowfire_t9");
      self.pers[#"hash_64b2f411af96d828"] = 1;
    }
  }

  if(weaponclass === # "weapon_tactical" || weaponclass === # "weapon_sniper") {
    if(meansofdeath === "MOD_HEAD_SHOT") {
      self stats::function_dad108fa(#"hash_512b329b0603295f", 1);
    }
  }
}

function function_ffdecc69(attacker, weapon, weaponclass) {
  attacker stats::function_e24eec31(weapon, #"hash_56ede06b1821a561", 1);
  attacker stats::function_dad108fa(#"hash_396f347b1d4c7db7", 1);
  attacker stats::function_dad108fa(#"hash_534a88a25d5f0737", 1);
  attacker stats::function_dad108fa(#"hash_19cdb54bb392db3f", 1);
  attacker stats::function_dad108fa(#"hash_19cdb44bb392d98c", 1);
  attacker contracts::increment_contract(#"hash_f9e1c9ceb2539ca");

  if(weaponclass === # "weapon_cqb") {
    attacker stats::function_dad108fa(#"hash_1b44d2efdcfc12b1", 1);
    attacker stats::function_dad108fa(#"hash_6cff9f8c30192558", 1);

    if(!isDefined(attacker.pers[#"hash_7099922d60cd6630"]) && attacker function_c9e4f73f(2, #"hash_7099922d60cd6630", #"hash_4a2f4e360aba5a57")) {
      attacker stats::function_d0de7686(#"hash_3d0bf673b9ea1117", 1, #"hash_776eb055b10b2533");
    }
  }
}

function processspecialistchallenge(statname) {
  self addspecialiststat(statname, 1);
}

function flakjacketprotectedmp() {
  self endon(#"death");
  level endon(#"game_ended");
  self notify("a17af42327067be");
  self endon("a17af42327067be");

  if(!self hastalent(#"talent_flakjacket")) {
    return;
  }

  wait 2;
  self stats::function_dad108fa(#"survive_with_flak", 1);
}

function private function_7ec2f2c(slot_index, killed) {
  slot = self loadout::get_loadout_slot(slot_index);
  slot.killed = killed;
}

function private function_861fe993(slot_index) {
  slot = self loadout::get_loadout_slot(slot_index);
  return slot.killed;
}

function function_3ee91387(weapon, playercontrolled, groundbased, countaskillstreakvehicle) {
  if(isDefined(level.hintobjectivehint_updat)) {
    self[[level.hintobjectivehint_updat]](groundbased);
  }

  if(countaskillstreakvehicle) {
    self function_6c21a4de(groundbased);
  }
}

function function_19e8b086(killcount, weapon, var_2e4a8800) {
  self function_90aad780(weapon, var_2e4a8800);
}

function private function_90aad780(killcount, weapon) {
  baseweapon = getweapon(weapon.statname);

  if(baseweapon.var_76ce72e8 && weapon.offhandslot == "Lethal grenade") {
    self stats::function_dad108fa(#"hash_43f515139ba38c55", 1);
  }
}

function vehiclekilled(inflictor, attacker, damage, mod, weapon, hitloc) {
  if(!is_true(self.isplayervehicle)) {
    return;
  }

  if(!isDefined(weapon)) {
    weapon = level.weaponnone;
  }

  attacker endon(#"disconnect");
  data = spawnStruct();
  data.vehicle = self;
  data.vehicleteam = self.team;
  data.isoccupied = self getvehoccupants().size;
  data.var_528b83c2 = self.var_38800c0;
  data.inflictor = inflictor;
  data.damage = damage;
  data.mod = mod;
  data.weapon = weapon;
  data.hitloc = hitloc;
  data.time = gettime();
  data.var_c8757561 = 0;
  data.killstreaktype = killstreaks::get_from_weapon(weapon);

  if(isPlayer(attacker)) {
    data.attackerwasunderwater = attacker isplayerunderwater();
    data.var_8e1828ea = attacker isparachuting();
    data.var_5ffb0b0d = attacker isinfreefall();
    data.var_360acc8e = attacker isinvehicle();

    if(data.var_360acc8e) {
      attackervehicle = attacker getvehicleoccupied();
      data.var_adb68654 = attackervehicle getseatoccupant(0);
    }
  }

  if(!isPlayer(attacker) && isarray(self.attackers)) {
    lastdamagetime = -1;

    foreach(var_2338ad61 in self.attackers) {
      if(isDefined(var_2338ad61.clientid) && isDefined(self.attackerdamage[var_2338ad61.clientid])) {
        var_b8b7b6cf = self.attackerdamage[var_2338ad61.clientid].lastdamagetime;

        if(var_b8b7b6cf > lastdamagetime) {
          lastdamagetime = var_b8b7b6cf;
          lastattacker = var_2338ad61;
        }
      }
    }

    if(isDefined(lastattacker) && lastdamagetime + 2000 >= data.time) {
      attacker = lastattacker;
    }
  }

  data.attacker = attacker;

  if(isPlayer(attacker)) {
    data.isenemyvehicle = isDefined(self.team) && self.team != # "neutral" && self.team !== attacker.team;
    data.var_da46f58a = isDefined(self.var_8e382c5f) && self.var_8e382c5f + 2000 >= data.time && isDefined(self.var_beafde27) && self.var_beafde27 !== attacker.team;
  } else {
    data.isenemyvehicle = 0;
    data.var_da46f58a = 0;
  }

  for(i = 0; i < 11; i++) {
    if(!self function_dcef0ba1(i)) {
      break;
    }

    var_e082d5c = self seatgetweapon(i);

    if(isDefined(var_e082d5c) && var_e082d5c.var_29d24e37 && !var_e082d5c.var_9a789947) {
      data.var_c8757561 = 1;
      break;
    }
  }

  data.isgroundvehicle = self.vehicleclass === "4 wheel" || self.vehicleclass === "motorcycle" || self.vehicleclass === "tank";
  data.var_a14dfd03 = isairborne(self);
  function_94d6aade(data);
  data.attacker notify(#"hash_56b121e50d70ac18");
}

function function_94d6aade(data) {
  if(isDefined(data.attacker)) {
    data.attacker endon(#"disconnect");
  }

  waitframe(1);
  util::waittillslowprocessallowed();
  level thread dochallengecallback("vehicleKilled", data);
  level thread scoreevents::doscoreeventcallback("vehicleKilled", data);
}

function function_8e9b2d44(data, time) {
  attacker = time.attacker;

  if(!isPlayer(attacker)) {
    return;
  }

  attackerwasunderwater = time.attackerwasunderwater;
  var_8e1828ea = time.var_8e1828ea;
  var_5ffb0b0d = time.var_5ffb0b0d;
  var_360acc8e = time.var_360acc8e;
  var_adb68654 = time.var_adb68654;
  isoccupied = time.isoccupied;
  var_da46f58a = time.var_da46f58a;
  vehicle = time.vehicle;
  vehicleteam = time.vehicleteam;
  isenemyvehicle = time.isenemyvehicle;
  isgroundvehicle = time.isgroundvehicle;
  var_a14dfd03 = time.var_a14dfd03;
  var_528b83c2 = time.var_528b83c2;
  weapon = time.weapon;
  killstreak = time.killstreaktype;

  if(isenemyvehicle && isoccupied || var_da46f58a) {
    attacker contracts::player_contract_event(#"hash_2f3b5cfd90466f60", weapon);
    attacker stats::function_dad108fa(#"hash_33d24eb29a631f61", 1);

    if(isgroundvehicle) {
      attacker stats::function_dad108fa(#"hash_160d0dd620800569", 1);
      attacker stats::function_dad108fa(#"hash_18c0785801027269", 1);
    }

    if(isDefined(killstreak)) {
      attacker stats::function_dad108fa(#"hash_9eb7f104b26e17c", 1);
    } else if(var_360acc8e === 1) {
      attacker stats::function_dad108fa(#"hash_9eb7f104b26e17c", 1);

      if(isDefined(var_adb68654) && var_adb68654 != attacker) {
        var_adb68654 stats::function_dad108fa(#"hash_9eb7f104b26e17c", 1);
      }
    }

    if(weapon.name === # "satchel_charge") {
      if(vehicle.scriptvehicletype === "player_tank") {
        attacker stats::function_dad108fa(#"hash_252a4cbc963fc617", 1);
      }

      if(attackerwasunderwater === 1) {
        attacker stats::function_dad108fa(#"hash_53316bf26e1435bb", 1);
      }

      if(isgroundvehicle) {
        attacker stats::function_dad108fa(#"hash_7659bc4836c71dee", 1);
      }
    } else if(weapon.name === # "land_mine") {
      if(isgroundvehicle) {
        attacker stats::function_dad108fa(#"hash_68f56bb01d2ea427", 1);
      }
    }

    if(!isDefined(vehicle.killstreak_id)) {
      if(weapon.statname !== # "special_crossbow_t9") {
        attacker stats::function_e24eec31(weapon, #"destroy_any", 1);
      }

      attacker stats::function_e24eec31(weapon, #"hash_497df827743010c3", 1);
      attacker stats::function_e24eec31(weapon, #"hash_67536f932f6aeb36", 1);
      attacker function_38ad2427(#"hash_450f99ce50083544", 1);
      attacker stats::function_dad108fa(#"hash_5d209f828d9bbd96", 1);
      attacker stats::function_dad108fa(#"hash_55becb3a18f3c612", 1);
      attacker stats::function_dad108fa(#"hash_73653f3482eed5a1", 1);
      attacker stats::function_dad108fa(#"hash_3cec8f96e8988e85", 1);
      attacker stats::function_dad108fa(#"hash_2fe91bb302563c57", 1);
      attacker stats::function_dad108fa(#"hash_2fe91ab302563aa4", 1);

      if(var_528b83c2 === 0) {
        attacker stats::function_e24eec31(weapon, #"hash_4c3e48c162ff0279", 1);
      } else {
        attacker stats::function_e24eec31(weapon, #"hash_8fafad87a8bd288", 1);
      }

      if(var_a14dfd03 === 1) {
        attacker stats::function_dad108fa(#"hash_7dab2161d3681f85", 1);
        weaponclass = util::getweaponclass(weapon);

        if(isDefined(weaponclass)) {
          weaponclass = isstring(weaponclass) ? hash(weaponclass) : weaponclass;

          if(weaponclass == # "weapon_launcher") {
            attacker stats::function_dad108fa(#"hash_32a02036b210e14d", 1);
            attacker stats::function_dad108fa(#"hash_5f20e4f510b85f5e", 1);
          }
        }
      }

      attacker function_6c21a4de(weapon);
    }
  }
}

function function_6c21a4de(weapon) {
  if(weapon.statname === # "special_crossbow_t9") {
    return;
  }

  if(!isDefined(self.pers[#"hash_47e7ebe61b42a76e"])) {
    self.pers[#"hash_47e7ebe61b42a76e"] = 0;
  }

  self.pers[#"hash_47e7ebe61b42a76e"]++;

  if(self.pers[#"hash_47e7ebe61b42a76e"] % 3 == 0) {
    self stats::function_e24eec31(weapon, #"hash_44ee37a6f2b220c9", 1);
  }
}

function function_88235aee(victim, attacker) {
  if(!isDefined(victim.squad)) {
    return;
  }

  if(!isDefined(attacker.var_ee07421b[victim.squad])) {
    attacker.var_ee07421b[victim.squad] = 0;
  }

  if(attacker.var_ee07421b[victim.squad] >= 2 && function_a1cff525(victim.squad).size == 0) {
    attacker stats::function_dad108fa(#"hash_18cc315440f11102", 1);
    attacker.var_ee07421b[victim.squad] = -100;
  }
}

function function_7007692f(attacker, victim, killstreak_weapon) {
  if(victim util::isenemyplayer(attacker) && (isDefined(victim.var_8e94d71c[killstreak_weapon]) ? victim.var_8e94d71c[killstreak_weapon] : 0) == 0) {
    attacker stats::function_dad108fa(#"hash_760e917a4024491a", 1);
  }
}

function function_e68cbed4() {
  if(!isDefined(self.pers[#"hash_144b3b626e9fd7b9"])) {
    self.pers[#"hash_144b3b626e9fd7b9"] = 0;
  }

  self.pers[#"hash_144b3b626e9fd7b9"]++;

  if(self.pers[#"hash_144b3b626e9fd7b9"] % 5 == 0) {
    self stats::function_dad108fa(#"hash_544dc5b57d96f408", 1);
  }
}

function function_3f57a5b(attacker, weapon) {
  weaponclass = util::getweaponclass(weapon);

  if(isDefined(weaponclass)) {
    weaponclass = isstring(weaponclass) ? hash(weaponclass) : weaponclass;

    if(weaponclass == # "weapon_sniper") {
      attacker stats::function_dad108fa(#"hash_59b75115ee254217", 1);
    }
  }
}

function private function_b15a1e1e(eventstruct) {
  self function_d43316bd(#"hash_354a96dc1d24e7a3", eventstruct);
  self function_4e40694d(#"hash_354a96dc1d24e7a3", eventstruct);
}

function private function_8c48d8ff(eventstruct) {
  self function_4e40694d(#"hash_354a96dc1d24e7a3", eventstruct);
}

function private function_486d4ce3(eventstruct) {
  self function_4e40694d(#"hash_354a96dc1d24e7a3", eventstruct);
}

function private function_80327323(data) {
  player = self;
  attackerstance = data.attackerstance;

  if(isDefined(attackerstance)) {
    if(attackerstance == # "crouch") {
      player stats::function_dad108fa(#"kill_enemy_while_crouched", 1);
      player stats::function_bcf9602(#"hash_4711f96a09147c", 1, #"event_test_enabled");
      player stats::function_dad108fa(#"hash_529cb0a2c0619c09", 1);
      player stats::function_dad108fa(#"hash_5f4b951cc4725fe2", 1);
      player stats::function_dad108fa(#"hash_5f4b941cc4725e2f", 1);
      return;
    }

    if(attackerstance == # "prone") {
      player stats::function_dad108fa(#"kill_enemy_while_prone", 1);
      player stats::function_dad108fa(#"hash_529cb0a2c0619c09", 1);
      player stats::function_dad108fa(#"hash_5f4b951cc4725fe2", 1);
      player stats::function_dad108fa(#"hash_5f4b941cc4725e2f", 1);
    }
  }
}

function private killstreak_started(params) {
  if(!isPlayer(self)) {
    return;
  }

  if(params.hardpointtype !== # "planemortar") {
    self stats::function_dad108fa(#"hash_4cb341530c521448", 1);
    function_e68cbed4();
    killstreak_bundle = killstreaks::get_script_bundle(params.hardpointtype);

    if(killstreak_bundle.var_192bb442 !== 1) {
      self stats::function_dad108fa(#"hash_4a20ff7cceff217c", 1);
    }
  }
}

function private function_5af500d9(killstreak_weapon) {
  if(!isPlayer(self)) {
    return;
  }

  if(!isDefined(killstreak_weapon)) {
    return;
  }

  if(!isDefined(self.var_e52625f)) {
    self.var_e52625f = [];
  }

  if(isDefined(self.var_e52625f[killstreak_weapon])) {
    return;
  }

  self stats::function_dad108fa(#"hash_4cb341530c521448", 1);
  self stats::function_dad108fa(#"hash_4a20ff7cceff217c", 1);
  function_e68cbed4();
  self.var_e52625f[killstreak_weapon] = 1;
}

function private function_23320f51(killstreak_weapon) {
  if(isDefined(self.var_e52625f[killstreak_weapon])) {
    self.var_e52625f[killstreak_weapon] = undefined;
  }
}

function private function_e7e09ca1(params) {
  if(!isPlayer(self)) {
    return;
  }

  if(self.just_given_new_inventory_killstreak === 1) {
    self stats::function_dad108fa(#"hash_e46234e26adf731", 1);
    self stats::function_dad108fa(#"hash_4234fb2534d8a2d7", 1);
  }
}

function private function_1d3ef959() {
  if(self hastalent(#"talent_spycraft")) {
    self stats::function_dad108fa(#"hash_6eea40459827b86", 1);
    self stats::function_dad108fa(#"hash_75c3033c8b4cabc7", 1);
  }
}

function private function_fbbc4c75(var_3995d41e) {
  if(var_3995d41e.ishacked === 1) {
    self stats::function_dad108fa(#"hash_75cb4218072916b4", 1);
  }
}

function function_b661072d(reset_time) {
  self.var_fcfb50c6 = {
    #var_de319bcb: self getorigin(), #var_e30954e3: reset_time, #var_619db00b: reset_time
  };
}

function private function_f9478088() {
  self notify("62320f1f60769c02");
  self endon("62320f1f60769c02");
  level endon(#"game_ended");

  while(true) {
    players = getplayers();

    if(players.size == 0) {
      wait 1;
      continue;
    }

    updatecount = 0;
    now = gettime();
    var_359bb79d = 0;

    foreach(player in players) {
      updatecount++;

      if(updatecount >= 2) {
        updatecount = 0;
        waitframe(1);
        var_359bb79d = 1;
        now = gettime();
      }

      if(!isalive(player)) {
        continue;
      }

      var_1def3436 = player.var_fcfb50c6;

      if(!isDefined(var_1def3436)) {
        player.var_fcfb50c6 = {
          #var_de319bcb: player getorigin(), #var_e30954e3: now, #var_619db00b: now
        };
        continue;
      }

      player_velocity = player getvelocity();

      if(lengthsquared(player_velocity) > 100 * 100) {
        var_1def3436.var_e30954e3 = now;
        continue;
      }

      var_1def3436.var_de319bcb = lerpvector(var_1def3436.var_de319bcb, player getorigin(), (now - var_1def3436.var_e30954e3) / 2250);
      var_1def3436.var_e30954e3 = now;
    }

    if(!var_359bb79d) {
      waitframe(1);
    }
  }
}

function private function_bb19a72c() {
  self stats::function_dad108fa(#"hash_755831c765749822", 1);
}

function private function_20456466(params) {
  attacker = params.attacker;
  attacker contracts::increment_contract(#"hash_6c38f28fb66ca0c4");
  attacker stats::function_dad108fa(#"hash_5ea3238f59bae1e5", 1);
  attacker stats::function_dad108fa(#"hash_4da14f9b7ebe092d", 1);
  attacker stats::function_dad108fa(#"hash_4605553e8458607e", 1);

  if(isDefined(params.attackerweapon)) {
    weaponclass = util::getweaponclass(params.attackerweapon);
  }

  if(weaponclass === # "weapon_smg") {
    attacker function_ac98baa9();
  }
}

function function_ac98baa9() {
  if(!isDefined(self.pers[#"hash_7bbea1ea94f9d898"]) && self function_c9e4f73f(3, #"hash_7bbea1ea94f9d898", #"hash_5564d2e27489af2f")) {
    self stats::function_d0de7686(#"hash_60c539b6c6bc428", 1, #"hash_564ba202834000a6");
  }
}

function function_de80e959(data) {
  if(!isDefined(data)) {
    return;
  }

  player = data.player;

  if(!isPlayer(player)) {
    return;
  }

  winningteam = data.winner;

  if(isDefined(winningteam) && player.team === winningteam) {
    switch (level.basegametype) {
      case # "gunfight":
        player stats::function_dad108fa(#"hash_5d841dfc6114d2ae", 1);
        break;
    }
  }
}