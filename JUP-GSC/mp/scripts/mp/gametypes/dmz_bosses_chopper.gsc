/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dmz_bosses_chopper.gsc
*******************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\chopper_support;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_supply_drops_common;
#using scripts\mp\gametypes\dmz_ai_chopper;
#using scripts\mp\gametypes\dmz_audio;
#using scripts\mp\gametypes\dmz_bosses;
#using scripts\mp\gametypes\dmz_task_utils;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\poi;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\points;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#using scripts\mp\vehicles\damage;
#using scripts\mp\weapons;
#namespace dmz_bosses_chopper;

function autoexec init() {
  registersharedfunc("dmz_bosses_chopper", "chopper_getCurrentTargetPlayer", &chopper_getcurrenttargetplayer);
}

function chopper_register() {
  bossdetails = spawnStruct();
  bossdetails.spawnlocs = [];
  bossdetails.name = "chopper";
  bossdetails.initfunc = &chopper_init;
  bossdetails.spawnfunc = &function_369a1dfb674d9262;
  bossdetails.var_e68429b39c75b6ee = &function_369a1dfb674d9262;
  bossdetails.var_7232c52496c3a94a = &function_463307a73b2cd8df;
  scripts\mp\gametypes\dmz_bosses::function_469eceae21900c7d(bossdetails, "additive", 1);
  scripts\mp\gametypes\dmz_bosses::registerboss(bossdetails);
}

function chopper_init(bossdetails) {
  level.var_cb36bea0db8a829f = getdvarint(@ "hash_41a5f023a6b9d7b6", 100);
  level.var_d44040648e9624f = getdvarint(@ "hash_2e1a1ee4432ba896", 4000);
  level.var_426503bd899fe79d = getdvarint(@ "hash_f8cfa0a3e3979732", 6000);
  level.var_8b0166c08f79ba6f = getdvarint(@ "hash_fb9f16d91bcc8a8", 420);
  level.var_af333105a68edcaf = getdvarint(@ "hash_d539a28855e76e9a", 0);
  level.var_72f4ae7b6cc41376 = getdvarint(@ "hash_4b206bd3a88e108b", 360);
  level.var_7317a07b6cea3c64 = getdvarint(@ "hash_4afd81d3a867f935", 440);
  level.var_6884e659bd874ed9 = getdvarint(@ "hash_29c7a74c7b9dd1b2", 3);
  level.var_920d2d352811f372 = getdvarint(@ "hash_4e73bb68df397fbf", 6);
  level.var_eda461803cdadc2c = getdvarint(@ "hash_995dd383d134e9ed", 10000);
  level.var_fdd8206d27c6e843 = getdvarint(@ "hash_7926da00afdcd474", 4500);
  level.var_147a8bca293848ea = getdvarint(@ "hash_87a6941b45c05399", 4);
  level.var_c11e773465a38fb7 = getdvarint(@ "hash_b45a6072bee6b2d4", 15);
  level.var_f787cf36b2e0e7f7 = getdvarint(@ "hash_369e173b0e8d08ba", 12);
  level.var_50b14458069e6de = getdvarint(@ "hash_8b1842e92794c807", 7);
  level.var_26c9eb02a050f11a = getdvarint(@ "hash_cc7feb01eae01a3f", 1);
  level.var_103b912267715093 = getdvarint(@ "hash_45da2e0688e80016", 5000);
  level.var_808f834a75546c5c = getdvarint(@ "hash_dd6e4061977972e5", 4);
  level.var_30c5e90e94b964fc = getdvarint(@ "hash_1da644016c35bdad", 0) == 1;
  level.var_e21f87900a38b4e0 = getdvarint(@ "hash_2b111045e5d27399", 155);
  level.var_e21f8a900a38bb79 = getdvarint(@ "hash_2b110d45e5d26d00", 75);
  level.var_e21f89900a38b946 = getdvarint(@ "hash_2b110e45e5d26f33", 10);
  level.var_59c6585d2f989571 = getdvarint(@ "hash_23583556fb69ec0e", 30) * 1000;
  level.var_baff2d8310c2551d = int(level.var_59c6585d2f989571 * 0.4);

  if(scripts\cp_mp\utility\game_utility::function_7ee65fae13124702()) {
    level.var_80d62fadb785ec94 = ["saba_moderncity"];
    level.var_b4d5f28b79e4c447 = ["saba_moderncity", "saba_observatory"];
  } else if(scripts\cp_mp\utility\game_utility::function_e21746abaaaf8414()) {
    level.var_80d62fadb785ec94 = ["sealion_castle", "sealion_coastalruins", "sealion_culdesac", "sealion_powerplant", "sealion_shipwreck", "sealion_watertreatment", "sealion_waterways"];
  } else if(scripts\cp_mp\utility\game_utility::function_5e0e3a24dbb1fae1()) {
    level.var_80d62fadb785ec94 = ["delta_castle", "delta_museum"];
    level.var_b4d5f28b79e4c447 = ["delta_castle", "delta_museum"];
  }

  level.averagealliesz = 0;
  level.killstreakweaponmap["chopper_gunner_proj_dmz"] = "chopper_gunner";
}

function function_369a1dfb674d9262(locoverride) {
  if(getdvarint(@ "hash_e8345a47ed69d00a", 1) != 1) {
    return;
  }

  if(!percent_chance(level.var_cb36bea0db8a829f)) {
    return;
  }

  level thread function_b12b6f997c04f0d0();

  level thread function_289402be40270fb7(locoverride);
}

function function_289402be40270fb7(locoverride) {
  instance = scripts\mp\gametypes\dmz_bosses::function_2e6e2b664dfe3186("chopper");
  instance.spawned = 0;
  instance.bossname = "chopper";

  if(isDefined(locoverride) && isstruct(locoverride)) {
    if(scripts\mp\poi::poi_issystemactive()) {
      instance.var_91403901a31fa2f8 = scripts\mp\poi::poi_findpoioriginisin(locoverride.origin, 1);
    }
  } else {
    keys = getarraykeys(level.poi_origins);
    keys = array_randomize(keys);

    foreach(key in keys) {
      if(!isDefined(level.var_80d62fadb785ec94) || !isDefined(array_find(level.var_80d62fadb785ec94, key))) {
        instance.var_91403901a31fa2f8 = key;
        break;
      }
    }
  }

  if(!isDefined(instance.var_91403901a31fa2f8)) {
    instance.var_91403901a31fa2f8 = random_key(level.poi_origins);
  }

  instance.spawnloc = level.poi_origins[instance.var_91403901a31fa2f8];
  instance scripts\cp_mp\utility\game_utility::function_6b6b6273f8180522("Boss_Dmz", instance.spawnloc, 6000);
  scripts\mp\flags::gameflagwait("prematch_done");
  waittime = ter_op(level.var_af333105a68edcaf, randomintrange(level.var_72f4ae7b6cc41376, level.var_7317a07b6cea3c64), level.var_8b0166c08f79ba6f);
  wait waittime;
  instance chopper_spawn();
  instance notify("boss_spawned");
}

function function_b12b6f997c04f0d0() {
  level endon("<dev string:x1c>");

  while(true) {
    if(getdvarint(@ "hash_4caeed66c64f0e35", 0) == 1) {
      instance = scripts\mp\gametypes\dmz_bosses::function_2e6e2b664dfe3186("<dev string:x2a>");
      instance.spawned = 0;
      instance.spawnloc = level.players[0].origin;
      chopper = instance function_978010e5ff5d52bc(instance.spawnloc);

      if(isDefined(chopper)) {
        instance.spawned = 1;
        instance.boss = chopper;
        instance.boss.var_109d6afbc11c5f9 = 3;
        instance.chopper = chopper;
      }

      setDvar(@ "hash_4caeed66c64f0e35", 0);
    }

    waitframe();
  }
}

function function_c2a173266d940d79(chopper) {
  if(isalive(chopper) && isstring(chopper.currentstate)) {
    state = chopper.currentstate;

    if(state == "idle") {
      state = "patrol";
    }

    return state;
  }

  return "death";
}

function chopper_getcurrenttargetplayer(chopper) {
  if(isDefined(chopper) && isDefined(chopper.currenttarget) && isarray(chopper.threatlist) && isDefined(chopper.threatlist[chopper.currenttarget]) && isPlayer(chopper.threatlist[chopper.currenttarget].player)) {
    return chopper.threatlist[chopper.currenttarget].player;
  }

  return undefined;
}

function function_6c1462b3f7b01684(chopper) {
  targetplayer = chopper_getcurrenttargetplayer(chopper);

  if(isPlayer(targetplayer) && isstring(targetplayer.team)) {
    return targetplayer.team;
  }

  return undefined;
}

function chopper_spawn() {
  poiname = self.var_91403901a31fa2f8;

  if(!isDefined(level.poi_origins) || !array_contains_key(level.poi_origins, poiname)) {
    assertmsg("<dev string:x35>" + poiname + "<dev string:x62>");
    return;
  }

  self.spawnloc += (0, 0, level.var_103b912267715093);
  chopper = function_978010e5ff5d52bc(self.spawnloc);
  chopper.bossinstance = self;
  self.spawned = 1;
  self.boss = chopper;
  self.boss.var_109d6afbc11c5f9 = getdvarint(@ "hash_abc9aa0d61dcc958", 3);
  scripts\cp_mp\utility\game_utility::function_af5604ce591768e1();

  foreach(team in self.var_7d8ad21e5dfd7c94) {
    scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.objidnum, team);
  }

  thread chopper_splash(self.spawnloc, poiname);
  scripts\mp\weapons::function_e00b77a9cb4d8322(chopper);
  var_985ae874212b863e = [];
  var_985ae874212b863e["idle"] = ["dmz_boss_chopper_escape", 0];
  var_985ae874212b863e["combat"] = ["dmz_boss_chopper_combat", 1.5];
  thread function_b5be3a44077aec21(self, var_985ae874212b863e, level.var_baff2d8310c2551d, level.var_59c6585d2f989571);
}

function function_978010e5ff5d52bc(pos) {
  var_44dd61e9bc4b4304 = getDvar(@ "hash_85e8885fce5027e7", "veh9_mil_air_heli_hind_physics_dmz");
  choppermodel = getDvar(@ "hash_fad92b3f5a4631f2", "veh9_mil_air_heli_hind_dmz_weapons");
  chopper = scripts\mp\gametypes\dmz_ai_chopper::function_4c4df9aeb773709a(pos, var_44dd61e9bc4b4304, choppermodel, level.var_d44040648e9624f, "dmz_boss_chopper");
  chopper function_247ad6a91f6a4ffe(1);
  chopper.var_980d543a9814a36f = 20;
  chopper.var_d31810c7eb37abfe = 500;
  chopper.var_cd2fa7e9b25262d0 = chopper.var_d31810c7eb37abfe;
  chopper.currenthealth = level.var_426503bd899fe79d;
  chopper.health = level.var_426503bd899fe79d;
  chopper.maxhealth = level.var_426503bd899fe79d;
  chopper.lootfunc = &chopper_droploot;
  chopper.var_ecbc9cd30d3db0be = [];
  chopper.combatstate = 0;
  chopper.shouldshoot = 1;
  chopper.var_e0bf649e3b37455d = 0;
  chopper.postmodifydamage = &chopper_postmodifydamage;
  chopper.var_f09811d8bb92df96 = &function_80eb9ba6d517fefe;
  chopper.attackfunc = &chopper_attack;
  chopper.funcs["strafe"] = &function_c1feeb5592d1018;
  chopper.var_580ba3be57af233e = 0;
  chopper.missileweapon = makeweapon("chopper_gunner_proj_dmz");
  chopper.bossname = "chopper";
  chopper thread function_7d5210c8e3520f4c();
  self.chopper = chopper;
  scripts\mp\gametypes\dmz_bosses::function_8002b09b8348902c(pos, "ui_map_icon_boss_chopper");
  scripts\mp\objidpoolmanager::update_objective_onentity(self.objidnum, chopper);
  scripts\mp\vehicles\damage::set_death_callback(self.chopper.vehiclename, &chopper_handledeathdamage);
  thread chopper_ondeath();

  if(isDefined(level.var_d8d4808549090419)) {
    [[level.var_d8d4808549090419]](self);
  }

  return chopper;
}

function chopper_ondeath() {
  self.chopper waittill("death");
  scripts\mp\gameobjects::releaseid();
  scripts\mp\gametypes\dmz_bosses::function_3e409004edf37731("chopper");
}

function function_80eb9ba6d517fefe(player) {
  if(isDefined(player) && isDefined(player.team) && isreallyalive(player) && isDefined(self.var_ecbc9cd30d3db0be[player.team]) && self.var_ecbc9cd30d3db0be[player.team] >= level.var_147a8bca293848ea && !istrue(player.extracted)) {
    return true;
  }

  return false;
}

function chopper_postmodifydamage(data) {
  scripts\cp_mp\killstreaks\chopper_support::function_400022dabdb64055(data);

  if(isPlayer(data.attacker)) {
    scripts\mp\gametypes\dmz_bosses::function_9483543f1b1bfa73("chopper", undefined, data.attacker, undefined, 20000);
  }

  switch (self.damagestate) {
    case 0:
      if(self.currenthealth < level.var_426503bd899fe79d * 0.65) {
        self.damagestate = 1;
        self setscriptablepartstate("body_damage_light", "on", 0);
      }

      break;
    case 1:
      if(self.currenthealth < level.var_426503bd899fe79d * 0.25) {
        self.damagestate = 2;
        self setscriptablepartstate("damage_left_wing", "on", 0);
        self setscriptablepartstate("body_damage_medium", "on", 0);
      }

      break;
    case 2:
      if(self.currenthealth < level.var_426503bd899fe79d * 0.05) {
        self.damagestate = 3;
        self setscriptablepartstate("damage_right_wing", "on", 0);
        self setscriptablepartstate("body_damage_heavy", "on", 0);
      }

      break;
    case 3:
    default:
      break;
  }

  if(!self.combatstate) {
    function_4b35485c0af17453();
  }

  if(isDefined(data.attacker) && isPlayer(data.attacker) && !istrue(level.var_f7ca3f03d0ed22a9)) {
    scripts\mp\gametypes\dmz_bosses::function_ae49568842bce7e(data.attacker, "chopper", 1);
    self.var_ecbc9cd30d3db0be[data.attacker.team] = level.var_147a8bca293848ea;
  }

  return true;
}

function chopper_handledeathdamage(data) {
  instance = self.bossinstance;

  if(isDefined(instance)) {
    instance notify("boss_death");
    instance.killed = 1;
    instance.killer = data.attacker;
  }

  scripts\cp_mp\killstreaks\chopper_support::choppersupport_handledeathdamage(data);
  thread function_aa4375c53e07b7ec(data.attacker.team);
  thread function_103478f5d3688256(self, data.attacker);
  self notify("death");
  return true;
}

function function_aa4375c53e07b7ec(team) {
  chopper = self;

  if(!isstring(team)) {
    return;
  }

  while(isDefined(chopper)) {
    waitframe();
  }

  delaytime = 5;
  scripts\cp_mp\overlord::function_9793a81bc3bc19e9("boss_chopper_eliminated", team, delaytime);
  xpoverride = getdvarint(@ "hash_dfcad66b7ba8da13", 500);

  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
    if(!isDefined(player.var_8c8050d7d861d06c)) {
      player.var_8c8050d7d861d06c = 0;
    }

    player.var_8c8050d7d861d06c++;
    player thread scripts\mp\utility\points::doscoreevent(#"kill", undefined, undefined, xpoverride, self, undefined, undefined, 1, undefined, 1);
  }
}

function function_7d5210c8e3520f4c() {
  self endon("death");
  level endon("game_ended");

  while(!self.combatstate) {
    players = utility::function_2d7fd59d039fa69b(self.origin, level.var_fdd8206d27c6e843, 1);
    var_694236c50bb536fe = [];

    foreach(player in players) {
      if(!isDefined(var_694236c50bb536fe[player.team])) {
        var_694236c50bb536fe[player.team] = 1;

        if(!isDefined(self.var_ecbc9cd30d3db0be[player.team])) {
          self.var_ecbc9cd30d3db0be[player.team] = 0;
        }

        self.var_ecbc9cd30d3db0be[player.team]++;

        if(self.var_ecbc9cd30d3db0be[player.team] >= level.var_147a8bca293848ea) {
          function_4b35485c0af17453();
        }
      }
    }

    if(!istrue(level.var_30c5e90e94b964fc)) {
      self setscriptablepartstate("speaker", "idle", 0);
      wait 1;

      if(scripts\cp_mp\utility\game_utility::function_e21746abaaaf8414()) {
        self setscriptablepartstate("speaker", "warning_sc", 0);
      } else {
        self setscriptablepartstate("speaker", "warning", 0);
      }
    }

    wait level.var_c11e773465a38fb7;
  }
}

function function_4b35485c0af17453() {
  self.combatstate = 1;
  thread function_e20f2ba1dcb6f312();
}

function function_e20f2ba1dcb6f312() {
  self endon("death");
  level endon("game_ended");

  while(true) {
    if(!istrue(level.var_30c5e90e94b964fc)) {
      self setscriptablepartstate("speaker", "idle", 0);
      wait 1;

      if(scripts\cp_mp\utility\game_utility::function_e21746abaaaf8414()) {
        self setscriptablepartstate("speaker", "attacking_sc", 0);
      } else {
        self setscriptablepartstate("speaker", "attacking", 0);
      }
    }

    wait level.var_c11e773465a38fb7;
  }
}

function chopper_splash(bossorigin, poiname) {
  if(level.var_eda461803cdadc2c < 0) {
    return;
  }

  if(level.var_eda461803cdadc2c > 0) {
    playerlist = [];

    foreach(player in level.players) {
      if(distance2dsquared(player.origin, bossorigin) < level.var_eda461803cdadc2c) {
        playerlist[playerlist.size] = player;
      }
    }
  } else {
    playerlist = level.players;
  }

  teamlist = [];

  foreach(player in playerlist) {
    if(!isarray(teamlist[player.team])) {
      teamlist[player.team] = [];
    }

    teamlist[player.team] = array_add(teamlist[player.team], player);
  }

  var_5619598e6a21f53c = [];

  foreach(players in teamlist) {
    if(players.size == 1) {
      var_5619598e6a21f53c[var_5619598e6a21f53c.size] = players[0];
      continue;
    }

    if(players.size > 1) {
      closestplayer = undefined;

      foreach(player in players) {
        if(!isDefined(closestplayer)) {
          closestplayer = player;
          continue;
        }

        if(isDefined(closestplayer) && isDefined(player)) {
          var_762f99b56d7dfc4c = distance2dsquared(closestplayer.origin, bossorigin);
          var_6008ea8bacb77120 = distance2dsquared(player.origin, bossorigin);

          if(var_6008ea8bacb77120 < var_762f99b56d7dfc4c) {
            closestplayer = player;
          }
        }
      }

      if(isDefined(closestplayer)) {
        var_5619598e6a21f53c[var_5619598e6a21f53c.size] = closestplayer;
      }
    }
  }

  foreach(var_4c9c6a9aa1f72df4 in var_5619598e6a21f53c) {
    function_463307a73b2cd8df(var_4c9c6a9aa1f72df4, 0, 1);
  }
}

function chopper_droploot() {
  crate = scripts\mp\gametypes\br_supply_drops_common::function_52f17e5fbec318a6(self.origin, level.supplydroptypes["dmz_boss_drop"], self.origin);

  if(isDefined(crate)) {
    crate unlink();
    crate physicslaunchserver((0, 0, 0), (0, 0, 0));
    bodyid = crate physics_getbodyid(0);
    physics_setbodycenterofmassnormal(bodyid, (0, 0, -0.75));
    crate.physicsactivated = 1;
    crate.usetime = 10;
    crate setscriptablepartstate("dmz_supply_drop", "usable");
    crate.onopenfunc = &function_e018ddec11a442b;
  }
}

function function_e018ddec11a442b(instance, player) {
  if(!isDefined(instance.contents)) {
    lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("brloot_konni_safehouse_intel");
    instance scripts\mp\gametypes\br_lootcache::function_d683a60016231237(lootid, 1);
  }
}

function chopper_attack(target) {
  self endon("death");
  self endon("crashing");
  self endon("state_change");

  if(!isDefined(target)) {
    return;
  }

  var_40130bd790669c04 = target.origin;
  targetpoi = scripts\mp\poi::poi_findpoioriginisin(target.origin);
  var_cb9ac661c1f66862 = 1;

  if(isDefined(level.var_b4d5f28b79e4c447) && isDefined(targetpoi)) {
    var_cb9ac661c1f66862 = !array_contains(level.var_b4d5f28b79e4c447, targetpoi);
  }

  self.shouldshoot = 1;
  self.var_e0bf649e3b37455d = 0;
  thread function_d105b5766895909d(target);

  if(isPlayer(target)) {
    scripts\mp\gametypes\dmz_bosses::function_9483543f1b1bfa73("chopper", undefined, target, undefined, 20000);
  }

  while(true) {
    if(isDefined(target)) {
      self setturrettargetvec(target.origin);

      if(function_dd5ca63b6ca176b8(target)) {
        if(self.var_580ba3be57af233e > level.var_6884e659bd874ed9) {
          if(level.var_920d2d352811f372 > 0 && self.damagestate < 3 && var_cb9ac661c1f66862) {
            scripts\mp\gametypes\dmz_ai_chopper::function_9f656e924a854c1b(target, 4000, 8, randomint(360), 1000);
          } else {
            function_e278235100ed92f4(target);
          }
        } else {
          function_e278235100ed92f4(target);

          if(level.var_920d2d352811f372 > 0 && self.damagestate < 3 && var_cb9ac661c1f66862) {
            scripts\mp\gametypes\dmz_ai_chopper::function_9f656e924a854c1b(target, 4000, 8, randomint(360), 1000);
          } else {
            self.var_580ba3be57af233e = 0;
          }
        }
      }
    }

    if(!isDefined(target) || !isreallyalive(target)) {
      scripts\mp\gametypes\dmz_ai_chopper::function_7743aeff79a08975("idle");
      return;
    }

    if(distance2dsquared(var_40130bd790669c04, target.origin) > 100000000) {
      scripts\mp\gametypes\dmz_ai_chopper::function_3be784d69cc30a0(target, -800);
      scripts\mp\gametypes\dmz_ai_chopper::function_7743aeff79a08975("idle");
      return;
    }

    wait 3;
  }
}

function function_c1feeb5592d1018(target) {
  self.var_580ba3be57af233e = 0;
  missiletags = ["tag_gun_right1", "tag_gun_left1", "tag_gun_right2", "tag_gun_left2"];
  wait 1;

  for(i = 0; i < level.var_920d2d352811f372; i++) {
    if(self.damagestate > 1 && (i % 4 == 1 || i % 4 == 3)) {
      wait 0.3;
      continue;
    } else if(self.damagestate > 2) {
      wait 0.3;
      continue;
    }

    missilestart = self gettagorigin(missiletags[i % 4]) + anglesToForward(self.angles + (6, 0, 0)) * 200;
    missileend = self gettagorigin(missiletags[i % 4]) + anglesToForward(self.angles + (6, 0, 0)) * 1000;
    missile = scripts\cp_mp\utility\weapon_utility::_magicbullet(self.missileweapon, missilestart, missileend, self.owner);
    wait 0.3;
  }
}

function function_d105b5766895909d(target) {
  self endon("death");
  self endon("crashing");
  self endon("state_change");
  target endon("death_or_disconnect");
  self setlookatent(target);
  var_29ae2ed56e057510 = 0;
  timer = 0;

  while(true) {
    if(!istrue(self.strafing)) {
      if(!isDefined(target) || !isDefined(target.origin)) {
        scripts\mp\gametypes\dmz_ai_chopper::function_7743aeff79a08975("idle");
      }

      contentsoverride = create_contents(0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0);
      canseetarget = ray_trace_passed(target.origin, self.origin, self.ignorelist, contentsoverride) && !target.notarget;

      if(timer > level.var_808f834a75546c5c || !canseetarget || distance2dsquared(target.origin, self.origin) > 20250000 || distance2dsquared(target.origin, self.origin) < 2250000) {
        timer = 0;

        if(!scripts\mp\gametypes\dmz_ai_chopper::function_e9cb677b6ba63162(target, 3000, 8, randomint(360))) {
          var_29ae2ed56e057510++;

          if(var_29ae2ed56e057510 > level.var_26c9eb02a050f11a) {
            self.var_e0bf649e3b37455d = 1;
          }

          if(var_29ae2ed56e057510 > level.var_50b14458069e6de) {
            self.shouldshoot = 0;
          }

          if(var_29ae2ed56e057510 > level.var_f787cf36b2e0e7f7) {
            scripts\mp\gametypes\dmz_ai_chopper::function_3be784d69cc30a0(target, -500);
            scripts\mp\gametypes\dmz_ai_chopper::function_7743aeff79a08975("idle");
          }
        } else {
          self.var_e0bf649e3b37455d = 0;
          self.shouldshoot = 1;
        }
      } else {
        self.var_e0bf649e3b37455d = 0;
        self.shouldshoot = 1;
      }
    }

    timer += 0.5;
    wait 0.5;
  }
}

function function_e278235100ed92f4(target) {
  self endon("death");
  self endon("crashing");
  self endon("state_change");

  if(!isDefined(target)) {
    return;
  }

  attackradius = level.var_e21f87900a38b4e0;
  var_795d7f662ba7e1a1 = 0;
  self.var_d706b7e51984c2ec = undefined;
  self.var_580ba3be57af233e++;
  guid = target.guid;
  dir = anglesToForward(target.angles);
  dir2d = vectorNormalize((dir[0], dir[1], 0));

  for(i = 0; i < 100; i++) {
    if(self.health <= 0) {
      return;
    }

    if(!isDefined(target)) {
      scripts\mp\gametypes\dmz_ai_chopper::function_83388ed388ddbddc(guid);
      scripts\mp\gametypes\dmz_ai_chopper::function_7743aeff79a08975("idle");
      return;
    }

    if(isreallyalive(target) && istrue(target.inlaststand)) {
      scripts\mp\gametypes\dmz_ai_chopper::function_3be784d69cc30a0(target, -2000);
      scripts\mp\gametypes\dmz_ai_chopper::function_7743aeff79a08975("idle");
      return;
    }

    if(i == 35) {
      attackradius = level.var_e21f8a900a38bb79;
    } else if(i == 65) {
      attackradius = level.var_e21f89900a38b946;
    }

    if(self.var_e0bf649e3b37455d && !isDefined(self.var_d706b7e51984c2ec)) {
      self.var_d706b7e51984c2ec = attackradius;
      var_795d7f662ba7e1a1 = 50;
      attackradius = int(level.var_e21f87900a38b4e0);
    } else if(!self.var_e0bf649e3b37455d && isDefined(self.var_d706b7e51984c2ec)) {
      attackradius = self.var_d706b7e51984c2ec;
      var_795d7f662ba7e1a1 = 0;
      self.var_d706b7e51984c2ec = undefined;
    }

    if(!self.shouldshoot) {
      wait 0.1;
      continue;
    }

    if(!isDefined(target) || !isDefined(target gettagorigin("j_spineupper"))) {
      scripts\mp\gametypes\dmz_ai_chopper::function_83388ed388ddbddc(guid);
      scripts\mp\gametypes\dmz_ai_chopper::function_7743aeff79a08975("idle");
      return;
    }

    centerpoint = target gettagorigin("j_spineupper");
    randdist = randomint(attackradius) + var_795d7f662ba7e1a1;
    randangle = randomint(360);
    x = centerpoint[0] + randdist * cos(randangle);
    y = centerpoint[1] + randdist * sin(randangle);
    z = centerpoint[2];
    point = (x, y, z);

    if(self.var_cd2fa7e9b25262d0 > 0) {
      point += dir2d * self.var_cd2fa7e9b25262d0;
      self.var_cd2fa7e9b25262d0 -= self.var_980d543a9814a36f;
    }

    self setturrettargetvec(point);
    wait 0.1;
    self fireweapon();
  }

  self.var_cd2fa7e9b25262d0 = self.var_d31810c7eb37abfe;
}

function function_dd5ca63b6ca176b8(target) {
  maxviewangle = 0.8;
  turretforward = anglesToForward(self gettagangles("tag_flash"));
  targetdisplace = vectorNormalize(target.origin - self gettagorigin("tag_flash"));
  var_ff53e400dd536b82 = vectordot(turretforward, targetdisplace);
  return var_ff53e400dd536b82 >= maxviewangle;
}

function function_6326efaea227c12a(turret) {
  if(isDefined(self.currenttarget) && self.currenttarget == turret.attackingtarget) {
    self.currenttarget.var_5b7ed65d780010d7 = gettime();
    self.currenttarget = undefined;
  }

  if(istrue(turret.targetbrokelos)) {
    turret.targetbrokelos = undefined;
  }

  turret.attackingtarget = undefined;
  turret cleartargetentity();
  turret.groundtargetent unlink();
  turret notify("lost_target");
}

function function_463307a73b2cd8df(player, showicon, var_91e5939bcaba8460) {
  assertex(isPlayer(player), "<dev string:x78>");
  assertex(isstring(player.team), "<dev string:xa3>");
  team = player.team;

  if(array_contains(self.var_7d8ad21e5dfd7c94, team)) {
    return false;
  }

  if(istrue(self.spawned) && !isDefined(self.chopper)) {
    return false;
  }

  self.var_7d8ad21e5dfd7c94 = array_add(self.var_7d8ad21e5dfd7c94, team);
  players = getteamdata(team, "players");
  var_ac4c51bf033f6323 = players;

  if(!istrue(self.spawned)) {
    foreach(player in players) {
      scripts\cp_mp\utility\game_utility::function_cfd53c8f6878014f(player);
    }
  } else {
    scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.objidnum, team);

    if(istrue(var_91e5939bcaba8460)) {
      function_5c07a5046a6dc0f4(team, self.spawnloc, level.var_eda461803cdadc2c, "dmz_boss_chopper_approach", 1.5);
    } else {
      function_5c07a5046a6dc0f4(team, player, level.var_b1149892b2595056, "dmz_boss_chopper_approach", 1.5);
    }
  }

  poiname = undefined;

  if(scripts\mp\poi::poi_issystemactive()) {
    poiname = scripts\mp\poi::poi_findpoioriginisin(self.spawnloc, 1, 0);
  }

  splash = ter_op(istrue(self.spawned), "dmz_chopper_revealed", "dmz_chopper_revealed_circle");
  scripts\mp\gametypes\br_gametype_dmz::showdmzsplash(splash, var_ac4c51bf033f6323, poiname);
  thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9("boss_chopper_near", team, 2);
  return true;
}

function function_103478f5d3688256(chopper, killer) {
  assertex(isent(chopper), "<dev string:xd8>");
  assertex(isstruct(chopper.bossinstance), "<dev string:x105>");
  assertex(isent(killer), "<dev string:x13f>");
  bossinstance = chopper.bossinstance;
  bossinstance notify("stop_boss_ai_music_thread");
  function_caeaf68ab0e87565(bossinstance.musicplayers, "");

  while(isDefined(chopper)) {
    waitframe();
  }

  function_73f954808739f7bc(bossinstance, killer, "dmz_boss_chopper_win", 2.5, "dmz_boss_chopper_escape", 0);
}