/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\bots\bot_action.gsc
***********************************************/

#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\bots\bot;
#include scripts\core_common\bots\bot_position;
#include scripts\core_common\bots\bot_stance;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\killstreaks\killstreaks_util;

#namespace bot_action;

autoexec __init__system__() {
  system::register(#"bot_action", &__init__, undefined, undefined);
}

__init__() {
  level.botactions = [];
  level.botweapons = [];
}

register_actions() {
  register_action(#"revive_player", &rank_priority, &revive_player_weight, &revive_player);
  register_action(#"use_gameobject", &rank_priority, &function_3cb4c00e, &use_gameobject);
  register_action(#"switch_to_weapon", &best_stowed_primary_weapon_rank, &switch_to_weapon_weight, &switch_to_weapon);
  register_action(#"hash_78881ac649c38041", &rank_priority, &function_5647e838, &function_40aa6f87);
  register_action(#"melee_glass", &current_melee_weapon_rank, &function_abf40e98, &melee_glass);
  register_action(#"melee_enemy", &current_melee_weapon_rank, &melee_enemy_weight, &melee_enemy);
  register_action(#"reload_weapon", &current_weapon_rank, &reload_weapon_weight, &reload_weapon);
  register_action(#"look_for_enemy", &current_weapon_rank, &look_for_enemy_weight, &look_for_enemy);
  register_action(#"hash_55fc6b6e868ae6c3", &current_weapon_rank, &function_1176a20b, &function_e0dcb8c1);
  register_action(#"hash_2bbb309be663cb4c", &function_728212e8, &scan_for_threats_weight, &function_9e1d8dfe);
  register_action(#"scan_for_threats", &function_728212e8, &scan_for_threats_weight, &scan_for_threats);
  register_action(#"bleed_out", &rank_priority, &bleed_out_weight, &bleed_out);
  register_action(#"hash_7aaeac32a4e1bf84", &weapon_rank, &function_36505c2d, &function_a314673);
  register_action(#"hash_434716893aa869f3", &weapon_rank, &function_294f4909, &function_e73c8946);
  register_action(#"hash_4c707ba80bf09cec", &weapon_rank, &function_294f4909, &function_22e2ba8c);
  register_action(#"hash_3d7dd2878425bcce", &weapon_rank, &function_2bc7472b, &function_36ca6d92);
  register_action(#"fire_grenade", &weapon_rank, &registersndrampend_death, &fire_grenade);
  register_action(#"fire_rocketlauncher", &weapon_rank, &function_a365f27e, &fire_rocketlauncher);
  register_action(#"fire_locked_rocketlauncher", &weapon_rank, &function_4de5fcc3, &fire_locked_rocketlauncher);
}

register_weapons() {
  register_weapon(#"none", &function_d9c35bee);
  register_bulletweapon(#"ar_accurate_t8");
  register_bulletweapon(#"ar_damage_t8");
  register_bulletweapon(#"ar_fastfire_t8");
  register_bulletweapon(#"ar_modular_t8");
  register_bulletweapon(#"ar_stealth_t8");
  register_bulletweapon(#"lmg_double_t8");
  register_bulletweapon(#"lmg_heavy_t8");
  register_bulletweapon(#"lmg_spray_t8");
  register_bulletweapon(#"lmg_standard_t8");
  register_bulletweapon(#"pistol_burst_t8");
  register_bulletweapon(#"pistol_standard_t8");
  register_bulletweapon(#"pistol_revolver_t8");
  register_bulletweapon(#"shotgun_pump_t8");
  register_bulletweapon(#"shotgun_semiauto_t8");
  register_bulletweapon(#"smg_accurate_t8");
  register_bulletweapon(#"smg_capacity_t8");
  register_bulletweapon(#"smg_fastfire_t8");
  register_bulletweapon(#"smg_handling_t8");
  register_bulletweapon(#"smg_standard_t8");
  register_sniperweapon(#"sniper_fastrechamber_t8");
  register_sniperweapon(#"sniper_powerbolt_t8");
  register_sniperweapon(#"sniper_powersemi_t8");
  register_sniperweapon(#"sniper_quickscope_t8");
  register_bulletweapon(#"tr_leveraction_t8");
  register_bulletweapon(#"tr_longburst_t8");
  register_bulletweapon(#"tr_midburst_t8");
  register_bulletweapon(#"tr_powersemi_t8");
  register_weapon(#"launcher_standard_t8", &function_317d4797);
}

function_25f1e3c1() {
  function_a2c83569(#"launcher_standard_t8", "fire_rocketlauncher");
  function_a2c83569(#"launcher_standard_t8", "fire_locked_rocketlauncher");
}

start() {
  self function_42907fd4();
}

function_42907fd4() {
  self.bot.var_469cfe53 = {
    #maxhealth: 100, 
    #distsq: 1000000, 
    #istarget: 0, 
    #isfavoriteenemy: 0
  };
}

stop() {
  self notify(#"hash_5b4f399c08222e2");
}

reset() {
  if(isDefined(self.bot)) {
    self.bot.var_bdbba2cd = 0;
  }
}

update() {
  if(isDefined(self.bot.action)) {
    self notify(#"hash_347a612b61067eb3");

    forcedstr = isDefined(self.bot.actionparams.forced) && self.bot.actionparams.forced ? "<dev string:x38>" : "<dev string:x43>";
    record3dtext("<dev string:x46>" + function_9e72a96(self.bot.action.name) + forcedstr, self.origin, (1, 0, 1), "<dev string:x4b>", self, 0.5);

    return;
  }

  self thread execution_loop();
}

force(actionname, weapon, target) {
  action = get_action(actionname);

  if(!isDefined(action)) {
    return false;
  }

  self function_fced7d8a(action, weapon, target);
  return true;
}

function_ee2eaccc(slot) {
  gadgetweapon = undefined;
  weapons = self getweaponslist();

  foreach(weapon in weapons) {
    if(self gadgetgetslot(weapon) == slot) {
      gadgetweapon = weapon;
      break;
    }
  }

  if(!isDefined(gadgetweapon)) {
    return;
  }

  var_13e42e18 = gadgetweapon.rootweapon.var_791bc2f7;

  if(!isDefined(var_13e42e18) || var_13e42e18.size <= 0) {
    self botprinterror("<dev string:x54>" + function_9e72a96(weapon.name));

    return;
  }

  self gadgetpowerset(slot, 100);
  self gadgetcharging(slot, 0);
  self function_fced7d8a(var_13e42e18[0], gadgetweapon, self.enemy);
}

function_4a53ae1f() {
  scorestreakweapon = undefined;
  weapons = self getweaponslist();

  for(i = 5; i < weapons.size; i++) {
    if(killstreaks::is_killstreak_weapon(weapons[i])) {
      scorestreakweapon = weapons[i];
      break;
    }
  }

  if(!isDefined(scorestreakweapon)) {
    return;
  }

  var_13e42e18 = scorestreakweapon.rootweapon.var_791bc2f7;

  if(!isDefined(var_13e42e18) || var_13e42e18.size <= 0) {
    self botprinterror("<dev string:x73>" + function_9e72a96(weapons[i].name));

    return;
  }

  self function_fced7d8a(var_13e42e18[0], scorestreakweapon, self.enemy);
}

private function_fced7d8a(action, weapon, target) {
  self.bot.var_e6a1f475 = {
    #action: action, 
    #weapon: weapon, 
    #target: target, 
    #forced: 1
  };
  self reset();
}

register_action(name, rankfunc, weightfunc, executefunc) {
  level.botactions[name] = {
    #name: name, 
    #rankfunc: rankfunc, 
    #weightfunc: weightfunc, 
    #executefunc: executefunc
  };
}

register_weapon(weaponname, rankfunc) {
  weapon = getweapon(weaponname);

  if(weapon.name == #"none") {
    return;
  }

  level.botweapons[weaponname] = weapon;
  weapon.var_ede647ad = rankfunc;
}

function_36052a7f(weaponname) {
  if(!isDefined(level.botweapons[weaponname])) {
    assertmsg("<dev string:x97>" + function_9e72a96(weaponname) + "<dev string:xa9>");
  }
}

register_bulletweapon(weaponname) {
  register_weapon(weaponname, &function_22991a48);
  function_a2c83569(weaponname, #"hash_7aaeac32a4e1bf84");
  function_a2c83569(weaponname, #"hash_434716893aa869f3");
}

register_sniperweapon(weaponname) {
  register_weapon(weaponname, &function_22991a48);
  function_a2c83569(weaponname, #"hash_4c707ba80bf09cec");
}

function_f4302f2a(weaponname, rankfunc, activatefunc) {
  register_weapon(weaponname, rankfunc);
  weapon = level.botweapons[weaponname];

  if(!isDefined(weapon)) {
    return;
  }

  weapon.var_c7e8f553 = activatefunc;
}

function_c67ea19e(weaponname, rankfunc, activatefunc) {
  register_weapon(weaponname, rankfunc);
  weapon = level.botweapons[weaponname];

  if(!isDefined(weapon)) {
    return;
  }

  weapon.var_c75f000 = activatefunc;
}

function_a2c83569(weaponname, actionname) {
  weapon = level.botweapons[weaponname];

  if(!isDefined(weapon)) {
    return;
  }

  action = get_action(actionname);

  if(!isDefined(action)) {
    return;
  }

  if(!isDefined(weapon.var_e2f5d985)) {
    weapon.var_e2f5d985 = [];
  }

  weapon.var_e2f5d985[weapon.var_e2f5d985.size] = action;
}

function_7e847a84(weaponname, actionname) {
  weapon = level.botweapons[weaponname];

  if(!isDefined(weapon)) {
    return;
  }

  action = get_action(actionname);

  if(!isDefined(action)) {
    return;
  }

  if(!isDefined(weapon.var_791bc2f7)) {
    weapon.var_791bc2f7 = [];
  }

  weapon.var_791bc2f7[weapon.var_791bc2f7.size] = action;
}

get_action(name) {
  return level.botactions[name];
}

function_10723c01(weapon, var_3f4e87bd) {
  if(!isDefined(var_3f4e87bd)) {
    return;
  }

  paramslist = self.bot.paramslist;

  foreach(action in var_3f4e87bd) {
    actionparams = {
      #action: action, 
      #weapon: weapon
    };

    actionparams.debug = [];

    paramslist[paramslist.size] = actionparams;
  }
}

function_fd9117cc() {
  currentweapon = self getcurrentweapon();
  var_c300ee65 = self.bot.var_469cfe53;

  if(self function_3094610b(self.bot.tacbundle.var_82aa37d8)) {
    var_c300ee65 = spawnStruct();
    var_c300ee65.maxhealth = self.enemy get_max_health();
    var_c300ee65.distsq = distancesquared(self.origin, self.enemy.origin);
    var_c300ee65.istarget = target_istarget(self.enemy);
    var_c300ee65.isfavoriteenemy = isDefined(self.favoriteenemy) && self.favoriteenemy == self.enemy;
  }

  if(isDefined(self.revivetrigger)) {
    self rank_weapon(currentweapon, var_c300ee65);
    self function_10723c01(currentweapon, currentweapon.rootweapon.var_e2f5d985);
    return;
  }

  weapons = self getweaponslist();

  foreach(weapon in weapons) {
    self rank_weapon(weapon, var_c300ee65);

    if(weapon == currentweapon) {
      self function_10723c01(weapon, weapon.rootweapon.var_e2f5d985);
      continue;
    }

    self function_10723c01(weapon, weapon.rootweapon.var_791bc2f7);
  }

  self.bot.var_469cfe53 = var_c300ee65;
}

function_9480d296() {
  actionlist = self.bot.tacbundle.actionlist;

  if(!isDefined(actionlist)) {
    return;
  }

  paramslist = self.bot.paramslist;

  for(i = 0; i < actionlist.size; i++) {
    if(!isDefined(actionlist[i])) {
      continue;
    }

    actionname = actionlist[i].name;

    if(!isDefined(actionname)) {
      continue;
    }

    action = get_action(actionname);

    if(!isDefined(action)) {
      self botprinterror("<dev string:xcf>" + function_9e72a96(actionname));

      continue;
    }

    actionparams = {
      #action: action
    };

    actionparams.debug = [];

    paramslist[paramslist.size] = actionparams;
  }
}

private execution_loop() {
  self endon(#"hash_5b4f399c08222e2", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
  level endon(#"game_ended");

  while(self bot::initialized()) {
    actionparams = self function_9e181b0f();

    if(isDefined(self.bot.var_211ab18e) && !self.bot.var_211ab18e) {
      self bot_position::start();
    }

    if(!isDefined(actionparams)) {
      self botprintwarning("<dev string:xe9>");

      return;
    }

    self function_e7b123e8(actionparams);
    self bot::function_ffbfd83b();
  }
}

private function_e7b123e8(actionparams) {
  self endoncallback(&function_7a456ee0, #"hash_5b4f399c08222e2", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
  level endon(#"game_ended");
  action = actionparams.action;
  self.bot.action = action;
  self.bot.actionparams = actionparams;
  self thread action_timeout(action.name);
  executetime = gettime();
  self function_fef5423c(self.bot.tacbundle.var_5eaa9e02, self.bot.tacbundle.var_bc0b2a06);
  self[[action.executefunc]](actionparams);
  self notify(#"hash_1728f8b5de3bde13");
  finishtime = gettime();

  if(executetime == finishtime) {
    self botprinterror("<dev string:xfb>" + function_9e72a96(action.name) + "<dev string:x105>");

    self waittill(#"hash_347a612b61067eb3");
  }

  self.bot.action = undefined;
  self.bot.actionparams = undefined;
}

private function_7a456ee0(notifyhash) {
  if(!self bot::initialized()) {
    return;
  }

  self.bot.action = undefined;
  self.bot.actionparams = undefined;
}

private action_timeout(actionname) {
  self endon(#"hash_5b4f399c08222e2", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start", #"hash_1728f8b5de3bde13");
  level endon(#"game_ended");
  wait 10;

  if(!isbot(self)) {
    return;
  }

  self botprintwarning("<dev string:xfb>" + function_9e72a96(actionname) + "<dev string:x119>" + 10 + "<dev string:x12d>");

  self notify(#"hash_5b4f399c08222e2");
}

function_fef5423c(smin, smax) {
  self.bot.var_bdbba2cd = bot::function_7aeb27f1(smin, smax);
}

function_cf788c22() {
  return gettime() > self.bot.var_bdbba2cd;
}

function_9e181b0f() {
  self.bot.weaponranks = [];
  self.bot.paramslist = [];

  self.bot.var_c4fbaffc = [];

  var_e6a1f475 = function_54449420();

  if(isDefined(var_e6a1f475)) {
    if(self bot::should_record("<dev string:x131>")) {
      record3dtext("<dev string:x144>" + function_9e72a96(var_e6a1f475.action.name), self.origin, (1, 0, 1), "<dev string:x4b>", self, 0.5);
    }

    return var_e6a1f475;
  }

  if(self bot::should_record("<dev string:x131>")) {
    record3dtext("<dev string:x150>", self.origin, (1, 0, 1), "<dev string:x4b>", self, 0.5);
  }

  self function_bf21ead1();
  self function_fd9117cc();
  self function_9480d296();
  pixbeginevent(#"bot_pick_action");
  aiprofile_beginentry("bot_pick_action");
  self rank_actions();
  var_3a4035f3 = self weight_actions();
  pixendevent();
  aiprofile_endentry();

  if(self bot::should_record("<dev string:x131>")) {
    pixbeginevent(#"bot_record_action_eval");
    aiprofile_beginentry("<dev string:x164>");

    foreach(actionparams in self.bot.paramslist) {
      color = (0.75, 0.75, 0.75);
      headerstr = "<dev string:x17d>";
      recordrank = "<dev string:x17d>";
      recordweight = "<dev string:x17d>";

      if(isDefined(actionparams.rank)) {
        recordrank = actionparams.rank;

        if(isDefined(actionparams.weight)) {
          color = (1, 1, 1);
          headerstr = "<dev string:x181>";
          recordweight = actionparams.weight;

          if(isDefined(var_3a4035f3)) {
            if(actionparams.rank >= var_3a4035f3.rank) {
              color = utility_color(actionparams.weight, 100);
              headerstr = actionparams == var_3a4035f3 ? "<dev string:x185>" : "<dev string:x189>";
            }
          }
        }
      }

      record3dtext(headerstr + function_9e72a96(actionparams.action.name) + "<dev string:x18d>" + recordrank + "<dev string:x192>" + recordweight, self.origin, color, "<dev string:x4b>", self, 0.5);

      if(isDefined(actionparams.weapon) && isDefined(self.bot.var_c4fbaffc[actionparams.weapon])) {
        foreach(str in self.bot.var_c4fbaffc[actionparams.weapon]) {
          record3dtext("<dev string:x197>" + str, self.origin, color, "<dev string:x4b>", self, 0.5);
        }
      }

      foreach(entry in actionparams.debug) {
        record3dtext("<dev string:x197>" + entry, self.origin, color, "<dev string:x4b>", self, 0.5);
      }
    }

    pixendevent();
    aiprofile_endentry();
  }

  return var_3a4035f3;
}

function_54449420() {
  if(!isDefined(self.bot.var_e6a1f475)) {
    return undefined;
  }

  actionparams = self.bot.var_e6a1f475;
  self.bot.var_e6a1f475 = undefined;

  if(!isDefined(actionparams)) {
    return undefined;
  }

  return actionparams;
}

weight_actions() {
  pixbeginevent(#"bot_weight_actions");
  aiprofile_beginentry("bot_weight_actions");
  var_3a4035f3 = undefined;
  bestrank = undefined;
  bestweight = undefined;
  paramslist = self.bot.paramslist;

  foreach(actionparams in paramslist) {
    if(!isDefined(actionparams.rank)) {
      continue;
    }

    action = actionparams.action;
    pixbeginevent("bot_weight_" + action.name);
    aiprofile_beginentry("bot_weight_" + action.name);
    actionparams.weight = self[[action.weightfunc]](actionparams);
    pixendevent();
    aiprofile_endentry();

    if(!isDefined(actionparams.weight)) {
      continue;
    }

    if(isDefined(var_3a4035f3) && actionparams.rank < bestrank) {
      continue;
    }

    if(!isDefined(var_3a4035f3) || actionparams.rank > bestrank || actionparams.weight > bestweight) {
      var_3a4035f3 = actionparams;
      bestrank = actionparams.rank;
      bestweight = actionparams.weight;
    }
  }

  pixendevent();
  aiprofile_endentry();
  return var_3a4035f3;
}

rank_actions() {
  pixbeginevent(#"bot_rank_actions");
  aiprofile_beginentry("bot_rank_actions");
  paramslist = self.bot.paramslist;

  foreach(actionparams in paramslist) {
    action = actionparams.action;
    pixbeginevent("bot_rank_" + action.name);
    aiprofile_beginentry("bot_rank_" + action.name);
    actionparams.rank = self[[action.rankfunc]](actionparams);
    pixendevent();
    aiprofile_endentry();
  }

  pixendevent();
  aiprofile_endentry();
}

rank_priority(actionparams) {
  return 1000;
}

function_b85d4a92(actionparams) {
  return -1000;
}

current_melee_weapon_rank(actionparams) {
  weapon = self getcurrentweapon();
  actionparams.weapon = weapon;

  if(sessionmodeiszombiesgame()) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x19d>";

    return 1000;
  }

  if(!weapon.ismeleeweapon) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = weapon.name + "<dev string:x1b2>";

    return undefined;
  }

  return 1000;
}

current_weapon_rank(actionparams) {
  weapon = self getcurrentweapon();
  actionparams.weapon = weapon;

  if(weapon == level.weaponnone) {
    return -1000;
  }

  return weapon_rank(actionparams);
}

best_stowed_primary_weapon_rank(actionparams) {
  currentweapon = self getcurrentweapon();
  weapons = self getweaponslistprimaries();
  bestweapon = undefined;
  bestweaponrank = undefined;

  foreach(weapon in weapons) {
    if(weapon == currentweapon) {
      continue;
    }

    weaponrank = self function_30e579d5(weapon);

    if(!isDefined(weaponrank)) {
      continue;
    }

    if(!isDefined(bestweapon) || bestweaponrank < weaponrank) {
      bestweapon = weapon;
      bestweaponrank = weaponrank;
    }
  }

  if(!isDefined(bestweapon)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x1c8>";

    return undefined;
  }

  actionparams.weapon = bestweapon;
  return weapon_rank(actionparams);
}

weapon_rank(actionparams) {
  weapon = actionparams.weapon;
  return self function_30e579d5(weapon);
}

function_30e579d5(weapon) {
  ammo = self getammocount(weapon);

  if(ammo <= 0) {
    return -1000;
  }

  return self.bot.weaponranks[weapon];
}

function_3df363bf(actionparams) {
  weapon = actionparams.weapon;
  return self.bot.weaponranks[weapon];
}

rank_weapon(weapon, var_c300ee65) {
  rankfunc = weapon.rootweapon.var_ede647ad;

  if(!isDefined(rankfunc)) {
    return;
  }

  self[[rankfunc]](weapon, var_c300ee65);
}

function_d31777fa(weapon, var_c300ee65) {
  self set_weapon_rank(weapon, 0);
}

function_22991a48(weapon, var_c300ee65) {
  self set_weapon_rank(weapon, 1);
  self factor_damage_range(weapon, var_c300ee65);

  if(weapon.weapclass == "pistol" || weapon.weapclass == "pistol spread") {
    self set_weapon_rank(weapon, 0.8, "Pistol");
  }

  self factor_ammo(weapon);
}

function_317d4797(weapon, var_c300ee65) {
  self set_weapon_rank(weapon, 0);
  self factor_lockon(weapon, var_c300ee65);
  self factor_dumbfire_range(weapon, var_c300ee65);
  self factor_rocketlauncher_overkill(weapon, var_c300ee65);
  self factor_ammo(weapon);
}

function_6d366261(weapon, var_c300ee65) {
  self set_weapon_rank(weapon, 998, "Secondary offhand weapon");
  self factor_ammo(weapon, var_c300ee65);
}

function_1879a202(weapon, var_c300ee65) {
  self set_weapon_rank(weapon, 999, "Special offhand weapon");
  self factor_ammo(weapon, var_c300ee65);
}

function_791f5097(weapon, var_c300ee65) {
  if(self getcurrentweapon() != weapon) {
    self set_weapon_rank(weapon, 999, "Scorestreak weapon");
    return;
  }

  self set_weapon_rank(weapon, -1000, "Don't use scorestreak weapon that is already equipped");
}

function_2c39b990(weapon, var_c300ee65) {
  self set_weapon_rank(weapon, 1000, "This weapon is a priority");
  self factor_ammo(weapon, var_c300ee65);
}

function_d9c35bee(weapon, var_c300ee65) {
  self set_weapon_rank(weapon, -1000, "This weapon is unusable");
}

set_weapon_rank(weapon, rank, reason) {
  self.bot.weaponranks[weapon] = rank;

  rankstr = isDefined(rank) ? rank : "<dev string:x17d>";
  self.bot.var_c4fbaffc[weapon] = array(weapon.name + "<dev string:x18d>" + rankstr);

  if(isDefined(reason)) {
    self.bot.var_c4fbaffc[weapon][self.bot.var_c4fbaffc[weapon].size] = "<dev string:x1e4>" + reason;
  }

}

modify_weapon_rank(weapon, amount, reason) {
  if(!isDefined(self.bot.weaponranks[weapon])) {
    return;
  }

  self.bot.weaponranks[weapon] += amount;

  sign = amount < 0 ? "<dev string:x43>" : "<dev string:x1e9>";
  self.bot.var_c4fbaffc[weapon][self.bot.var_c4fbaffc[weapon].size] = "<dev string:x1e4>" + sign + amount + "<dev string:x189>" + reason;
}

factor_ammo(weapon, var_c300ee65) {
  clipammo = self clip_ammo(weapon);
  stockammo = self getweaponammostock(weapon);

  if(clipammo + stockammo <= 0) {
    if(weapon.isgadget) {
      slot = self gadgetgetslot(weapon);

      if(!self gadgetisready(slot)) {
        self set_weapon_rank(weapon, undefined, "Gadget not ready");
      }

      return;
    }

    self set_weapon_rank(weapon, -1000, "No ammo");
  }
}

factor_damage_range(weapon, var_c300ee65) {
  if(!isDefined(self.enemy)) {
    return;
  }

  if(var_c300ee65.distsq < weapon.maxdamagerange * weapon.maxdamagerange) {
    self modify_weapon_rank(weapon, 1, "In max damage range");
    return;
  }

  if(var_c300ee65.distsq >= weapon.mindamagerange * weapon.mindamagerange) {
    if(weapon.weapclass == "spread") {
      self set_weapon_rank(weapon, undefined, "Outside of spread min damage range");
      return;
    }

    self modify_weapon_rank(weapon, -1, "In min damage range");
  }
}

factor_lockon(weapon, var_c300ee65) {
  if(var_c300ee65.istarget) {
    if(weapon.lockontype != "None") {
      self modify_weapon_rank(weapon, 3, "Lockon Target");
    }

    return;
  }

  if(weapon.requirelockontofire) {
    self set_weapon_rank(weapon, undefined, "Requires Lockon");
  }
}

factor_dumbfire_range(weapon, var_c300ee65) {
  if(var_c300ee65.istarget && weapon.lockontype != "None") {
    return;
  }

  if(var_c300ee65.distsq < 2250000) {
    self modify_weapon_rank(weapon, 1, "In Dumbfire Range");
    return;
  }

  self modify_weapon_rank(weapon, -1, "Outside Dumbfire Range");
}

factor_rocketlauncher_overkill(weapon, var_c300ee65) {
  if(var_c300ee65.istarget && weapon.lockontype != "None") {
    return;
  }

  if(!isDefined(var_c300ee65.maxhealth)) {
    self set_weapon_rank(weapon, undefined, "Max Health is undefined");
    return;
  }

  if(var_c300ee65.maxhealth >= 400) {
    self modify_weapon_rank(weapon, 2, "Enemy Max Health " + var_c300ee65.maxhealth + " >= " + 400);
    return;
  }

  self modify_weapon_rank(weapon, -1, "Enemy Max Health " + var_c300ee65.maxhealth + " < " + 400);
}

utility_color(utility, targetutility) {
  colorscale = array((1, 0, 0), (1, 0.5, 0), (1, 1, 0), (0, 1, 0));

  if(utility >= targetutility) {
    return colorscale[colorscale.size - 1];
  } else if(utility <= 0) {
    return colorscale[0];
  }

  utilityindex = utility * colorscale.size / targetutility;
  utilityindex -= 1;
  colorindex = int(utilityindex);
  colorfrac = utilityindex - colorindex;
  utilitycolor = vectorlerp(colorscale[colorindex], colorscale[colorindex + 1], colorfrac);
  return utilitycolor;
}

look_for_enemy_weight(actionparams) {
  actionparams.target = self.enemy;
  weapon = actionparams.weapon;

  if(!self bot::in_combat()) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x1ed>";

    return undefined;
  }

  if(self is_target_visible(actionparams)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x1fd>";

    return undefined;
  }

  if(!self function_3094610b(self.bot.tacbundle.var_82aa37d8)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x210>";

    return undefined;
  }

  return 0;
}

look_for_enemy(actionparams) {
  var_47851891 = self.enemy;
  weapon = self getcurrentweapon();

  while(!self function_cf788c22() && self function_ab4c3550() && self bot::in_combat() && self is_target_enemy(actionparams) && !self is_target_visible(actionparams)) {
    self function_d273d4e7();
    self waittill(#"hash_347a612b61067eb3");
  }
}

function_1176a20b(actionparams) {
  if(self.ignoreall) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x233>";

    return undefined;
  }

  if(self bot::has_visible_enemy()) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x23f>";

    return undefined;
  }

  target = self ai::function_31a31a25(0);

  if(!isDefined(target)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x24f>";

    return undefined;
  }

  actionparams.target = target;
  self set_target_aim(actionparams);
  return 0;
}

function_e0dcb8c1(actionparams) {
  target = actionparams.target;
  self setentitytarget(target);
  self.bot.var_2a98e9ea = 1;

  while(!self function_cf788c22() && !self.ignoreall && isDefined(target) && self is_target_enemy(actionparams) && isalive(target) && !self is_target_visible(actionparams)) {
    self function_8a2b82ad(actionparams);
    self aim_at_target(actionparams);
    self waittill(#"hash_347a612b61067eb3");
  }
}

function_728212e8(actionparams) {
  currentweaponrank = self current_weapon_rank(actionparams);

  if(isDefined(currentweaponrank)) {
    return currentweaponrank;
  }

  return -1000;
}

scan_for_threats_weight(actionparams) {
  actionparams.target = self.enemy;
  self set_target_aim(actionparams);
  return false;
}

scan_for_threats(actionparams) {
  targetvisible = self is_target_visible(actionparams);
  actionparams.targetvisible = targetvisible;

  while(!self function_cf788c22() && self is_target_enemy(actionparams) && actionparams.targetvisible == targetvisible) {
    if(targetvisible && self function_ee402bf6(actionparams)) {
      self function_8a2b82ad(actionparams);
      self function_e69a1e2e(actionparams);
    } else if(!targetvisible && self function_ee402bf6(actionparams)) {
      self function_8a2b82ad(actionparams);
      self function_e69a1e2e(actionparams);
    } else if(self function_4fbd6cf1()) {
      self function_3b98ad10();
    } else if(targetvisible) {
      self function_8a2b82ad(actionparams);
      self aim_at_target(actionparams);
    } else {
      self function_2b8f7067();
    }

    self waittill(#"hash_347a612b61067eb3");
    targetvisible = self is_target_visible(actionparams);
  }
}

function_9e1d8dfe(actionparams) {
  targetvisible = self is_target_visible(actionparams);
  actionparams.targetvisible = targetvisible;

  while(!self function_cf788c22() && self is_target_enemy(actionparams) && actionparams.targetvisible == targetvisible) {
    if(targetvisible && self function_ee402bf6(actionparams)) {
      self function_8a2b82ad(actionparams);
      self function_e69a1e2e(actionparams);
    } else if(!targetvisible && self function_ee402bf6(actionparams)) {
      self function_8a2b82ad(actionparams);
      self function_e69a1e2e(actionparams);
    } else if(self function_4fbd6cf1()) {
      self function_3b98ad10();
    } else {
      self function_2b8f7067();
    }

    self waittill(#"hash_347a612b61067eb3");
    targetvisible = self is_target_visible(actionparams);
  }
}

revive_player_weight(actionparams) {
  if(!self ai::get_behavior_attribute("revive")) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x26d>";

    return undefined;
  }

  revivetarget = self bot::get_revive_target();

  if(!isDefined(revivetarget)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x28b>";

    return undefined;
  }

  actionparams.revivetarget = revivetarget;

  if(!isDefined(actionparams.debug)) {
    actionparams.debug = [];
  } else if(!isarray(actionparams.debug)) {
    actionparams.debug = array(actionparams.debug);
  }

  actionparams.debug[actionparams.debug.size] = "<dev string:x29e>" + revivetarget.name;

  if(!isDefined(revivetarget.revivetrigger)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x2a9>";

    return undefined;
  }

  if(!self istouching(revivetarget.revivetrigger)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x2bd>";

    return undefined;
  }

  if(isDefined(revivetarget.revivetrigger.beingrevived) && revivetarget.revivetrigger.beingrevived) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x2d4>";

    return;
  }

  pathenemyfightdist = self.bot.tacbundle.pathenemyfightdist;

  if(!self ai::get_behavior_attribute("ignorepathenemyfightdist") && isDefined(self.enemy) && isDefined(pathenemyfightdist) && pathenemyfightdist > 0 && distance2dsquared(self.origin, self.enemy.origin) < pathenemyfightdist * pathenemyfightdist) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x2e4>";

    return undefined;
  }

  return 100;
}

revive_player(actionparams) {
  player = actionparams.revivetarget;

  if(!isDefined(player)) {
    self botprinterror("<dev string:x2f2>" + "<dev string:x30e>");

    return;
  }

  self.attackeraccuracy = 0.01;

  while(isalive(player) && isDefined(player.revivetrigger) && self istouching(player.revivetrigger)) {
    if(isDefined(player.revivetrigger.beingrevived) && player.revivetrigger.beingrevived) {
      function_e0c89027();
      return;
    }

    self look_at_point(player.revivetrigger.origin, "Revive Trigger", (1, 1, 1));

    if(self botgetlookdot() >= 0) {
      self botsetlookcurrent();
      break;
    }

    self bot_stance::crouch();
    self waittill(#"hash_347a612b61067eb3");
  }

  while(isalive(player) && isDefined(player.revivetrigger) && self istouching(player.revivetrigger)) {
    self look_at_point(player.revivetrigger.origin, "Revive Trigger", (1, 1, 1));
    self bot_stance::crouch();
    self bottapbutton(3);
    self waittill(#"hash_347a612b61067eb3");
  }

  self function_e0c89027();
}

function_e0c89027(notifyhash) {
  self.attackeraccuracy = 1;
  self bot_stance::reset();
}

function_3cb4c00e(actionparams) {
  if(!self bot::function_dd750ead()) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x329>";

    return undefined;
  }

  gameobject = self bot::get_interact();
  actionparams.gameobject = gameobject;

  if(self haspath()) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x342>";

    return undefined;
  }

  if(!self istouching(gameobject.trigger)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x2bd>";

    return undefined;
  }

  return 100;
}

use_gameobject(actionparams) {
  gameobject = actionparams.gameobject;
  lookpoint = gameobject.trigger.origin;

  while(isDefined(gameobject) && gameobject === self bot::get_interact() && self istouching(gameobject.trigger)) {
    self look_at_point(lookpoint, "Gameobject Trigger", (1, 1, 1));

    if(self botgetlookdot() >= 0.76) {
      self botsetlookcurrent();
      break;
    }

    waitframe(1);
  }

  while(isDefined(gameobject) && gameobject === self bot::get_interact() && self istouching(gameobject.trigger) && !isDefined(self.claimtrigger)) {
    self bottapbutton(3);
    waitframe(1);
  }

  if(isDefined(gameobject) && gameobject === self bot::get_interact() && isDefined(gameobject.inuse) && gameobject.inuse && isDefined(gameobject.trigger) && self.claimtrigger === gameobject.trigger) {
    self bottapbutton(3);
    waitframe(1);
  }
}

function_5647e838(actionparams) {
  if(!isDefined(self.bot.traversal)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x350>";

    return undefined;
  }

  if(isDefined(self.bot.traversal.mantlenode)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x363>";

    return undefined;
  }

  if(self.bot.traversal.targetheight < 40) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x375>" + self.bot.traversal.targetheight + "<dev string:x386>";

    return undefined;
  }

  return 100;
}

function_40aa6f87(actionparams) {
  while(isDefined(self.bot.traversal)) {
    self botsetlookpoint(self.bot.traversal.endpos);
    self waittill(#"hash_347a612b61067eb3");
  }
}

switch_to_weapon_weight(actionparams) {
  currentweapon = self getcurrentweapon();
  currentweaponrank = self function_30e579d5(currentweapon);

  if(isDefined(currentweaponrank) && actionparams.rank <= currentweaponrank) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x38e>" + currentweaponrank;

    return undefined;
  }

  return 0;
}

switch_to_weapon(actionparams) {
  weapon = actionparams.weapon;
  self botswitchtoweapon(weapon);
  self waittill(#"hash_347a612b61067eb3");

  while(self isswitchingweapons()) {
    self waittill(#"hash_347a612b61067eb3");
  }
}

reload_weapon_weight(actionparams) {
  weapon = actionparams.weapon;
  actionparams.target = self.enemy;
  self set_target_aim(actionparams);
  stockammo = self getweaponammostock(weapon);

  if(!isDefined(actionparams.debug)) {
    actionparams.debug = [];
  } else if(!isarray(actionparams.debug)) {
    actionparams.debug = array(actionparams.debug);
  }

  actionparams.debug[actionparams.debug.size] = "<dev string:x3ae>" + stockammo;

  if(stockammo <= 0) {
    return undefined;
  }

  clipammo = self clip_ammo(weapon);

  if(!isDefined(actionparams.debug)) {
    actionparams.debug = [];
  } else if(!isarray(actionparams.debug)) {
    actionparams.debug = array(actionparams.debug);
  }

  actionparams.debug[actionparams.debug.size] = "<dev string:x3b8>" + clipammo + "<dev string:x3c1>" + weapon.clipsize;

  if(clipammo >= weapon.clipsize) {
    return undefined;
  }

  if(self bot::in_combat() && clipammo > weapon.clipsize * 0.2) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x3c5>";

    return undefined;
  }

  if(self isreloading()) {
    return 100;
  }

  if(!self isweaponready()) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x3d1>";

    return undefined;
  }

  return 0;
}

reload_weapon(actionparams) {
  weapon = self getcurrentweapon();

  if(!self isreloading()) {
    self bottapbutton(4);
  }

  self waittill(#"hash_347a612b61067eb3");

  while(self isreloading()) {
    if(self is_target_enemy(actionparams) && self is_target_visible(actionparams)) {
      self function_8a2b82ad(actionparams);
      self function_e69a1e2e(actionparams);
    } else if(self is_target_enemy(actionparams) && self function_3094610b(self.bot.tacbundle.var_82aa37d8)) {
      if(self function_ca71ffdb()) {
        self function_d273d4e7();
      } else {
        self function_c17972fc();
      }
    } else if(self function_4fbd6cf1()) {
      self function_3b98ad10();
    } else {
      self function_2b8f7067();
    }

    self waittill(#"hash_347a612b61067eb3");
  }
}

function_4d9b6e04() {
  if(level.script == "mp_mountain2") {
    return true;
  }

  if(level.script == "mp_slums2") {
    return true;
  }

  return false;
}

function_abf40e98(actionparams) {
  if(!function_4d9b6e04()) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x3e4>";

    return undefined;
  }

  if(!self haspath()) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x3f8>";

    return undefined;
  }

  eye = self getEye();
  forwarddir = anglesToForward(self getplayerangles());
  traceend = eye + forwarddir * actionparams.weapon.var_bfbec33f;
  trace = bulletTrace(eye, traceend, 0, self);

  if(trace[#"fraction"] >= 1) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x405>";

    return undefined;
  }

  if(!isDefined(trace[#"surfacetype"]) || trace[#"surfacetype"] != "glass") {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x419>";

    return undefined;
  }

  return 100;
}

melee_glass(actionparams) {
  self look_along_path();
  self bottapbutton(2);
  self waittill(#"hash_347a612b61067eb3");

  if(self ismeleeing()) {
    self look_along_path();

    while(self ismeleeing()) {
      self waittill(#"hash_347a612b61067eb3");
    }
  }
}

melee_enemy_weight(actionparams) {
  actionparams.target = self.enemy;
  weapon = actionparams.weapon;

  if(!self is_target_visible(actionparams)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x432>";

    return undefined;
  }

  meleerange = actionparams.weapon.var_bfbec33f;

  if(distancesquared(self.origin, self.enemy.origin) > meleerange * meleerange) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x445>";

    return undefined;
  }

  if(self bot::fwd_dot(self.enemy.origin) < 0.5) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x460>";

    return undefined;
  }

  if(!isDefined(self.bot.var_d8397b2) || gettime() - self.bot.var_d8397b2 > 1000) {
    self.bot.var_d8397b2 = gettime();
    self.bot.meleeallowed = randomfloat(1) < (isDefined(self.bot.tacbundle.meleechance) ? self.bot.tacbundle.meleechance : 0);
  }

  if(!self.bot.meleeallowed) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x47a>";

    return undefined;
  }

  self set_target_aim(actionparams);
  return 100;
}

melee_enemy(actionparams) {
  self function_8a2b82ad(actionparams);
  self function_e69a1e2e(actionparams);
  self bottapbutton(2);

  if(sessionmodeiszombiesgame()) {
    wait 0.5;
    return;
  }

  self waittill(#"hash_347a612b61067eb3");

  if(self ismeleeing()) {
    while(self ismeleeing()) {
      self waittill(#"hash_347a612b61067eb3");
    }
  }
}

function_36505c2d(actionparams) {
  actionparams.target = self.enemy;
  weapon = actionparams.weapon;

  if(!self is_target_visible(actionparams)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x432>";

    return undefined;
  }

  clipammo = self clip_ammo(weapon);

  if(!isDefined(actionparams.debug)) {
    actionparams.debug = [];
  } else if(!isarray(actionparams.debug)) {
    actionparams.debug = array(actionparams.debug);
  }

  actionparams.debug[actionparams.debug.size] = "<dev string:x4bd>" + clipammo + "<dev string:x3c1>" + weapon.clipsize;

  if(clipammo <= 0) {
    return undefined;
  }

  if(!self function_ee402bf6(actionparams)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x4c5>";

    return undefined;
  }

  self set_target_aim(actionparams);
  return 100;
}

function_a314673(actionparams) {
  weapon = actionparams.weapon;

  while(!self function_cf788c22() && self is_target_enemy(actionparams) && self is_target_visible(actionparams) && self bot::weapon_loaded(weapon)) {
    self function_8a2b82ad(actionparams);
    self function_e69a1e2e(actionparams);

    if(self function_31a76186(actionparams)) {
      self bot::function_e2c892a5();
      self bot::function_e2c892a5(1);
    }

    self waittill(#"hash_347a612b61067eb3");
  }
}

function_294f4909(actionparams) {
  actionparams.target = self.enemy;
  weapon = actionparams.weapon;

  if(!self is_target_visible(actionparams)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x432>";

    return undefined;
  }

  if(!weapon.aimdownsight) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x4e3>";

    return undefined;
  }

  if(self haspath() && !(isDefined(self.bot.tacbundle.movingads) && self.bot.tacbundle.movingads)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x4f7>";

    return undefined;
  }

  clipammo = self clip_ammo(weapon);

  if(!isDefined(actionparams.debug)) {
    actionparams.debug = [];
  } else if(!isarray(actionparams.debug)) {
    actionparams.debug = array(actionparams.debug);
  }

  actionparams.debug[actionparams.debug.size] = "<dev string:x4bd>" + clipammo + "<dev string:x3c1>" + weapon.clipsize;

  if(clipammo <= 0) {
    return undefined;
  }

  if(!self function_679b5b7a(actionparams)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x500>";

    return undefined;
  }

  self set_target_aim(actionparams);
  return 100;
}

function_e73c8946(actionparams) {
  weapon = actionparams.weapon;

  while(!self function_cf788c22() && self is_target_enemy(actionparams) && self is_target_visible(actionparams) && self bot::weapon_loaded(weapon)) {
    self function_8a2b82ad(actionparams);
    self aim_at_target(actionparams);

    if(self function_55d5a581(actionparams)) {
      self bottapbutton(11);

      if(self function_bacb1c08(actionparams) && self playerads() >= 1) {
        self bot::function_e2c892a5();
        self bot::function_e2c892a5(1);
      }
    }

    self waittill(#"hash_347a612b61067eb3");
  }
}

function_22e2ba8c(actionparams) {
  weapon = actionparams.weapon;
  weaponclass = util::getweaponclass(weapon);
  assert(weaponclass == #"weapon_sniper");

  while(!self function_cf788c22() && self is_target_enemy(actionparams) && self is_target_visible(actionparams) && self bot::weapon_loaded(weapon)) {
    self function_8a2b82ad(actionparams);
    self aim_at_target(actionparams);

    if(self function_55d5a581(actionparams)) {
      self bottapbutton(11);

      if(self function_bacb1c08(actionparams) && self playerads() >= 1) {
        if(!isDefined(self.bot.var_ddc0e12b)) {
          self.bot.var_ddc0e12b = randomfloat(1) < (isDefined(self.bot.tacbundle.var_6ef48dfa) ? self.bot.tacbundle.var_6ef48dfa : 0);
        }

        if(!isDefined(self.bot.var_f2b47a08)) {
          if(self.bot.var_ddc0e12b) {
            self.bot.var_f2b47a08 = gettime();
          } else {
            delaytimesec = randomfloatrange(isDefined(self.bot.tacbundle.var_b9f05fc) ? self.bot.tacbundle.var_b9f05fc : 0, isDefined(self.bot.tacbundle.var_c850085f) ? self.bot.tacbundle.var_c850085f : 0);
            self.bot.var_f2b47a08 = gettime() + int(delaytimesec * 1000);
          }
        }

        if(gettime() >= self.bot.var_f2b47a08) {
          self bot::function_e2c892a5();
          self bot::function_e2c892a5(1);
        }
      }
    }

    self waittill(#"hash_347a612b61067eb3");
  }
}

function_2bc7472b(actionparams) {
  actionparams.target = self.enemy;
  weapon = actionparams.weapon;

  if(!self is_target_visible(actionparams)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x432>";

    return undefined;
  }

  if(self haspath() && !(isDefined(self.bot.tacbundle.movingads) && self.bot.tacbundle.movingads)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x4f7>";

    return undefined;
  }

  clipammo = self clip_ammo(weapon);

  if(!isDefined(actionparams.debug)) {
    actionparams.debug = [];
  } else if(!isarray(actionparams.debug)) {
    actionparams.debug = array(actionparams.debug);
  }

  actionparams.debug[actionparams.debug.size] = "<dev string:x4bd>" + clipammo + "<dev string:x3c1>" + weapon.clipsize;

  if(clipammo <= 0) {
    return undefined;
  }

  if(!self function_679b5b7a(actionparams)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x500>";

    return undefined;
  }

  self set_target_aim(actionparams);
  return 100;
}

function_36ca6d92(actionparams) {
  weapon = actionparams.weapon;
  self function_b74c1de4();

  while(!self function_cf788c22() && self is_target_enemy(actionparams) && self is_target_visible(actionparams) && self bot::weapon_loaded(weapon)) {
    self function_8a2b82ad(actionparams);
    self aim_at_target(actionparams);
    self bottapbutton(11);
    self bottapbutton(24);

    if(self function_55d5a581(actionparams)) {
      if(self function_bacb1c08(actionparams)) {
        self bot::function_e2c892a5();
        self bot::function_e2c892a5(1);
      }
    }

    self waittill(#"hash_347a612b61067eb3");
  }

  self function_b74c1de4();
  wait 0.1;

  while(self isswitchingweapons()) {
    self waittill(#"hash_347a612b61067eb3");
  }
}

registersndrampend_death(actionparams) {
  actionparams.target = self.enemy;
  weapon = actionparams.weapon;

  if(!self is_target_visible(actionparams)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x432>";

    return undefined;
  }

  if(self haspath()) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x4f7>";

    return undefined;
  }

  clipammo = self clip_ammo(weapon);

  if(!isDefined(actionparams.debug)) {
    actionparams.debug = [];
  } else if(!isarray(actionparams.debug)) {
    actionparams.debug = array(actionparams.debug);
  }

  actionparams.debug[actionparams.debug.size] = "<dev string:x4bd>" + clipammo + "<dev string:x3c1>" + weapon.clipsize;

  if(clipammo <= 0) {
    return undefined;
  }

  self function_8a2b82ad(actionparams);
  self function_a3dfc4aa(actionparams);

  if(!isDefined(actionparams.var_cb785841)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x51e>";

    return undefined;
  }

  self function_9004d3ca(actionparams);

  if(!self function_ade341c(actionparams)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x542>";

    return undefined;
  }

  return 100;
}

fire_grenade(actionparams) {
  weapon = actionparams.weapon;

  while(!self function_cf788c22() && self is_target_enemy(actionparams) && self is_target_visible(actionparams) && self bot::weapon_loaded(weapon)) {
    self function_8a2b82ad(actionparams);
    self function_a3dfc4aa(actionparams);
    self function_9004d3ca(actionparams);
    self function_3a2f51fd(actionparams);

    if(self function_ade341c(actionparams)) {
      if(self botgetlookdot() >= 1 && self bot::function_a7106162()) {
        self bot::function_b78e1ebf();
      }
    }

    self waittill(#"hash_347a612b61067eb3");
  }
}

function_4de5fcc3(actionparams) {
  actionparams.target = self.enemy;
  weapon = actionparams.weapon;

  if(!self is_target_visible(actionparams)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x432>";

    return undefined;
  }

  if(!self function_daa4968(actionparams)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x55c>";

    return undefined;
  }

  clipammo = self clip_ammo(weapon);

  if(!isDefined(actionparams.debug)) {
    actionparams.debug = [];
  } else if(!isarray(actionparams.debug)) {
    actionparams.debug = array(actionparams.debug);
  }

  actionparams.debug[actionparams.debug.size] = "<dev string:x4bd>" + clipammo + "<dev string:x3c1>" + weapon.clipsize;

  if(clipammo <= 0) {
    return undefined;
  }

  distsq = distancesquared(self.origin, self.enemy.origin);

  if(distsq < 2250000) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x579>";

    return 0;
  }

  return 100;
}

fire_locked_rocketlauncher(actionparams) {
  target = actionparams.target;
  weapon = actionparams.weapon;
  lockedflag = 1 << self getentitynumber();

  while(!self function_cf788c22() && self is_target_enemy(actionparams) && self is_target_visible(actionparams) && self function_daa4968(actionparams) && self bot::weapon_loaded(weapon)) {
    self function_ab6b1fc9(actionparams);
    self aim_at_target(actionparams);

    if(self function_55d5a581(actionparams)) {
      self bottapbutton(11);

      if(self playerads() >= 1 && isDefined(self.stingertarget) && isDefined(self.stingertarget.locked_on) && self.stingertarget.locked_on&lockedflag) {
        self bottapbutton(0);
      }
    }

    self waittill(#"hash_347a612b61067eb3");

    if(self isfiring()) {
      break;
    }
  }

  while(self isfiring()) {
    if(self is_target_visible(actionparams)) {
      self function_8a2b82ad(actionparams);
      self aim_at_target(actionparams);
    }

    self waittill(#"hash_347a612b61067eb3");
  }
}

function_a365f27e(actionparams) {
  actionparams.target = self.enemy;
  weapon = actionparams.weapon;

  if(!self is_target_visible(actionparams)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x432>";

    return undefined;
  }

  clipammo = self clip_ammo(weapon);

  if(!isDefined(actionparams.debug)) {
    actionparams.debug = [];
  } else if(!isarray(actionparams.debug)) {
    actionparams.debug = array(actionparams.debug);
  }

  actionparams.debug[actionparams.debug.size] = "<dev string:x4bd>" + clipammo + "<dev string:x3c1>" + weapon.clipsize;

  if(clipammo <= 0) {
    return undefined;
  }

  distsq = distancesquared(self.origin, self.enemy.origin);

  if(distsq > 2250000) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x593>";

    return undefined;
  }

  return 100;
}

fire_rocketlauncher(actionparams) {
  target = actionparams.target;
  weapon = actionparams.weapon;

  while(!self function_cf788c22() && self is_target_enemy(actionparams) && self is_target_visible(actionparams) && self bot::weapon_loaded(weapon)) {
    self function_8a2b82ad(actionparams);
    self aim_at_target(actionparams);

    if(self function_55d5a581(actionparams)) {
      if(self function_bacb1c08(actionparams)) {
        if(!self haspath()) {
          self bottapbutton(11);

          if(self playerads() >= 1) {
            self bottapbutton(0);
            self waittill(#"hash_347a612b61067eb3");
            break;
          }
        } else {
          self bottapbutton(0);
        }
      }
    }

    self waittill(#"hash_347a612b61067eb3");

    if(self isfiring()) {
      break;
    }
  }

  while(self isfiring()) {
    if(self is_target_visible(actionparams)) {
      self function_8a2b82ad(actionparams);
      self aim_at_target(actionparams);
    }

    self waittill(#"hash_347a612b61067eb3");
  }
}

function_ccdcc5d9(weapon) {
  activatefunc = weapon.rootweapon.var_c7e8f553;

  if(!isDefined(activatefunc)) {
    self botprinterror(weapon.name + "<dev string:x5c0>");

    return;
  }

  self[[activatefunc]](weapon);
}

activate_health_gadget(actionparams) {
  weapon = actionparams.weapon;
  self function_ccdcc5d9(weapon);

  while(self isthrowinggrenade() || !self isweaponready() || self getcurrentweapon() == level.weaponnone) {
    self waittill(#"hash_347a612b61067eb3");
  }
}

function_5aa9dd1b(actionparams) {
  if(self is_target_enemy(actionparams) && self is_target_visible(actionparams)) {
    var_b4843bc3 = actionparams.aimpoint;
    var_7c23d596 = actionparams.var_97065630;
    var_66c8d0f4 = actionparams.var_cb785841;
    self function_8a2b82ad(actionparams);
    self function_a3dfc4aa(actionparams);
    self function_9004d3ca(actionparams);

    if(!self function_ade341c(actionparams)) {
      actionparams.aimpoint = var_b4843bc3;
      actionparams.var_97065630 = var_7c23d596;
      actionparams.var_cb785841 = var_66c8d0f4;
    }
  }

  self function_3a2f51fd(actionparams);
}

throw_offhand(actionparams) {
  weapon = actionparams.weapon;
  self function_ccdcc5d9(weapon);
  slot = self gadgetgetslot(weapon);
  button = self function_c6e02c38(weapon);
  self function_5aa9dd1b(actionparams);
  self waittill(#"hash_347a612b61067eb3");

  while(!self function_d911b948()) {
    self function_5aa9dd1b(actionparams);
    self bottapbutton(button);
    self waittill(#"hash_347a612b61067eb3");
  }

  holding = 1;

  while(!self function_cf788c22() && self isthrowinggrenade()) {
    self function_5aa9dd1b(actionparams);

    if(holding) {
      self bottapbutton(button);

      if(self botgetlookdot() >= 1) {
        holding = 0;
      }
    }

    self waittill(#"hash_347a612b61067eb3");
  }

  if(holding) {
    while(self isthrowinggrenade()) {
      self bottapbutton(71);
      self bottapbutton(49);
      self function_c17972fc();
      self waittill(#"hash_347a612b61067eb3");
    }
  }

  while(!self isweaponready() || self getcurrentweapon() == level.weaponnone) {
    self waittill(#"hash_347a612b61067eb3");
  }
}

bleed_out_weight(actionparams) {
  if(!isDefined(self.owner)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x5e7>";

    return undefined;
  }

  if(self.owner.sessionstate == "playing") {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x5f2>";

    return undefined;
  }

  if(!isDefined(self.revivetrigger)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x605>";

    return undefined;
  }

  if(isDefined(self.revivetrigger.beingrevived) && self.revivetrigger.beingrevived) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x619>";

    return undefined;
  }

  if(!isDefined(actionparams.debug)) {
    actionparams.debug = [];
  } else if(!isarray(actionparams.debug)) {
    actionparams.debug = array(actionparams.debug);
  }

  actionparams.debug[actionparams.debug.size] = "<dev string:x629>" + self.owner.sessionstate;

  return 100;
}

bleed_out(actionparams) {
  while(!isDefined(self.revivetrigger) && !(isDefined(self.revivetrigger.beingrevived) && self.revivetrigger.beingrevived)) {
    self bottapbutton(3);
    self waittill(#"hash_347a612b61067eb3");
  }
}

set_target_aim(actionparams) {
  if(!isDefined(self.bot.var_67b4ea54)) {
    self.bot.var_67b4ea54 = randomfloat(1) < (isDefined(self.bot.tacbundle.headshotchance) ? self.bot.tacbundle.headshotchance : 0);
  }

  if(self.bot.var_67b4ea54) {
    function_d4102d11(actionparams);
    return;
  }

  function_9c6ca396(actionparams);
}

function_9c6ca396(actionparams) {
  self function_26c2bce7(actionparams, self.bot.tacbundle.var_a78526b8);
}

function_d4102d11(actionparams) {
  self function_26c2bce7(actionparams, self.bot.tacbundle.aimtaghead);
}

function_26c2bce7(actionparams, aimtag) {
  target = actionparams.target;

  if(!isentity(target)) {
    return;
  }

  if(self.scriptenemy === target && isDefined(self.scriptenemytag)) {
    actionparams.aimtag = self.scriptenemytag;
  } else if(isDefined(target.shootattag)) {
    actionparams.aimtag = target.shootattag;
  } else {
    actionparams.aimtag = aimtag;
  }

  actionparams.var_5b865e5e = actionparams.aimtag;

  if(isDefined(target.aimattag)) {
    actionparams.var_5b865e5e = target.aimattag;
  }
}

private function_627e3d2c(tag, target, defaultorigin) {
  if(!isDefined(tag)) {
    return defaultorigin;
  }

  if(tag == "tag_origin") {
    return target.origin;
  }

  tagorigin = target gettagorigin(tag);

  if(isDefined(tagorigin)) {
    return tagorigin;
  }

  return defaultorigin;
}

function_8a2b82ad(actionparams) {
  target = actionparams.target;

  if(isDefined(target)) {
    if(isvec(target)) {
      actionparams.aimpoint = target;
    } else if(function_ffa5b184(target)) {
      actionparams.aimpoint = target.var_88f8feeb;
    } else if(isentity(target)) {
      centroid = target getcentroid();
      actionparams.aimpoint = function_627e3d2c(actionparams.aimtag, target, centroid);
      actionparams.var_97065630 = function_627e3d2c(actionparams.var_5b865e5e, target, centroid);
    }
  } else {
    eyes = self getEye();
    angles = self getplayerangles();
    fwd = anglesToForward(angles);
    actionparams.aimpoint = eyes + fwd * 300;
  }

  if(!isDefined(actionparams.var_97065630)) {
    actionparams.var_97065630 = actionparams.aimpoint;
  }

  if(isDefined(actionparams.aimpoint)) {
    self function_7355c240(actionparams);
  }
}

function_7355c240(actionparams) {
  if(!isDefined(self.bot.var_d7771ac3) || gettime() >= self.bot.var_d7771ac3) {
    eyes = self getEye();
    angles = self getplayerangles();
    fwd = anglesToForward(angles);
    right = anglestoright(angles);
    up = anglestoup(angles);
    aimoffset = function_d2e41376(actionparams.aimpoint, eyes, fwd, right, up, self.bot.var_ea5b64df, 0);

    if(isDefined(aimoffset)) {
      self.bot.aimoffset = aimoffset;
    }

    var_9492fdcb = function_d2e41376(actionparams.var_97065630, eyes, fwd, right, up, self.bot.var_ea5b64df, 1);

    if(isDefined(var_9492fdcb)) {
      self.bot.var_9492fdcb = var_9492fdcb;
    }

    if(isDefined(aimoffset) || isDefined(var_9492fdcb)) {
      self.bot.var_ea5b64df *= randomfloatrange(0.8, 0.9);
      self.bot.var_d7771ac3 = gettime() + randomintrange(300, 600);
    }
  }

  actionparams.aimpoint += self.bot.aimoffset;
  actionparams.var_97065630 += self.bot.var_9492fdcb;
}

function_d2e41376(var_9d9ae85, eyes, fwd, right, up, var_ea5b64df, close) {
  attachmentisselectable = var_9d9ae85 - eyes;
  var_df4809a5 = vectornormalize(attachmentisselectable);
  aimoffset = undefined;

  if(vectordot(fwd, var_df4809a5) > 0.7) {
    var_dafe1813 = min(var_ea5b64df, length(attachmentisselectable) * 0.25);

    if(close) {
      var_dafe1813 *= 0.5;
    }

    if(var_dafe1813 == 0) {
      return (0, 0, 0);
    }

    var_18451fac = var_dafe1813 * 0.25;
    var_d83e24eb = var_dafe1813;
    assert(var_18451fac > 0);
    assert(var_d83e24eb > 0);
    var_b91ee594 = vectordot(attachmentisselectable, right) < 0;

    if(var_b91ee594) {
      aimoffset = right * randomfloatrange(var_d83e24eb * -1, var_18451fac);
    } else {
      aimoffset = right * randomfloatrange(var_18451fac * -1, var_d83e24eb);
    }

    var_7bbaffc = vectordot(attachmentisselectable, up) < 0;

    if(var_7bbaffc) {
      aimoffset = (aimoffset[0], aimoffset[1], randomfloatrange(var_d83e24eb * -1, var_18451fac) * 0.5);
    } else {
      aimoffset = (aimoffset[0], aimoffset[1], randomfloatrange(var_18451fac * -1, var_d83e24eb) * 0.5);
    }
  }

  return aimoffset;
}

function_ab6b1fc9(actionparams) {
  target = actionparams.target;

  if(!isentity(target)) {
    return;
  }

  subtargets = target_getsubtargets(target);

  if(subtargets[0] != 0) {
    actionparams.aimpoint = target_getorigin(target, subtargets[0]);
    return;
  }

  actionparams.aimpoint = target_getorigin(target);
}

function_a3dfc4aa(actionparams) {
  aimpoint = actionparams.aimpoint;
  weapon = actionparams.weapon;

  if(isDefined(aimpoint) && isDefined(weapon)) {
    actionparams.var_cb785841 = self botgetprojectileaimangles(weapon, aimpoint);
    return;
  }

  actionparams.var_cb785841 = undefined;
}

function_d136dabe(actionparams) {
  aimpoint = actionparams.aimpoint;

  if(isDefined(aimpoint)) {
    actionparams.bullettrace = bulletTrace(self getEye(), aimpoint, 1, self);
    return;
  }

  actionparams.bullettrace = undefined;
}

function_9004d3ca(actionparams) {
  var_cb785841 = actionparams.var_cb785841;
  weapon = actionparams.weapon;

  if(isDefined(var_cb785841) && isDefined(weapon)) {
    actionparams.projectiletrace = self function_6e8a2d86(weapon, var_cb785841.var_478aeacd);
    return;
  }

  actionparams.projectiletrace = undefined;
}

is_target_visible(actionparams) {
  target = actionparams.target;

  if(!isDefined(target)) {
    return 0;
  }

  if(isentity(target)) {
    return (isalive(target) && self cansee(target, self.bot.tacbundle.var_82aa37d8));
  }

  if(isvec(target)) {
    return sighttracepassed(self getEye(), target, 1, self);
  }

  return 0;
}

function_ecf6dc7a(actionparams) {
  if(!self bot::in_combat()) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x1ed>";

    return false;
  }

  if(!self is_target_visible(actionparams)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x432>";

    return false;
  }

  return true;
}

function_b70a8fcf(actionparams) {
  target = actionparams.target;

  if(!isDefined(target)) {
    return false;
  }

  if(isplayer(target)) {
    return isDefined(target.revivetrigger);
  }

  return false;
}

is_target_enemy(actionparams) {
  target = actionparams.target;

  if(isvec(target)) {
    return true;
  }

  return self.enemy === target;
}

function_daa4968(actionparams) {
  target = actionparams.target;

  if(!isDefined(target)) {
    return 0;
  }

  return target_istarget(target);
}

function_ee402bf6(actionparams) {
  target = actionparams.target;
  weapon = actionparams.weapon;

  if(!isDefined(target) || !isDefined(weapon)) {
    return false;
  }

  if(issentient(target) && self lastknowntime(target) + 5000 < gettime()) {
    return false;
  }

  targetorigin = isvec(target) ? target : target.origin;
  targetdistsq = distancesquared(self.origin, targetorigin);
  var_1d4ad8f2 = self.bot.tacbundle.shortrange;
  return targetdistsq <= var_1d4ad8f2 * var_1d4ad8f2;
}

function_679b5b7a(actionparams) {
  target = actionparams.target;
  weapon = actionparams.weapon;

  if(!isDefined(target) || !isDefined(weapon)) {
    return false;
  }

  targetorigin = isvec(target) ? target : target.origin;
  targetdistsq = distancesquared(self.origin, targetorigin);
  var_97c37e78 = self.bot.tacbundle.maxrange;
  return targetdistsq <= var_97c37e78 * var_97c37e78;
}

function_faa6a59d(actionparams, range) {
  target = actionparams.target;

  if(!isDefined(target)) {
    return false;
  }

  if(issentient(target) && self lastknowntime(target) + 5000 < gettime()) {
    return false;
  }

  targetorigin = isvec(target) ? target : target.origin;
  targetdistsq = distancesquared(self.origin, targetorigin);
  return targetdistsq <= range * range;
}

function_43505382(actionparams) {
  target = actionparams.target;
  bullettrace = actionparams.bullettrace;

  if(!isDefined(target) || !isDefined(bullettrace)) {
    return false;
  }

  if(isentity(target)) {
    return (target === bullettrace[#"entity"]);
  } else if(isvec(target)) {
    return (bullettrace[#"fraction"] >= 1);
  }

  return false;
}

function_ade341c(actionparams) {
  target = actionparams.target;
  projectiletrace = actionparams.projectiletrace;

  if(!isDefined(target) || !isDefined(projectiletrace)) {
    return false;
  }

  if(isentity(target)) {
    return (target === projectiletrace[#"entity"]);
  } else if(isvec(target)) {
    return (distancesquared(projectiletrace[#"position"], target) < 100);
  }

  return false;
}

aim_at_target(actionparams) {
  aimpoint = actionparams.aimpoint;

  if(!isDefined(aimpoint)) {
    return;
  }

  self look_at_point(aimpoint, "Aim", (1, 0, 0));
  return aimpoint;
}

function_e69a1e2e(actionparams) {
  aimpoint = actionparams.var_97065630;

  if(!isDefined(aimpoint)) {
    return;
  }

  self look_at_point(aimpoint, "Aim", (1, 0, 0));
  return aimpoint;
}

function_3a2f51fd(actionparams) {
  var_cb785841 = actionparams.var_cb785841;

  if(isDefined(var_cb785841)) {
    self botsetlookangles(var_cb785841.var_478aeacd);
  }

  if(self bot::should_record("<dev string:x635>") && isDefined(actionparams.aimpoint)) {
    recordsphere(actionparams.aimpoint, 4, (1, 0, 0), "<dev string:x4b>");
    record3dtext("<dev string:x646>", actionparams.aimpoint + (0, 0, 5), (1, 0, 0), "<dev string:x4b>", undefined, 0.5);
  }

}

function_31a76186(actionparams) {
  var_f5842481 = self haspath() ? self.bot.tacbundle.var_19019506 : self.bot.tacbundle.var_d5bf8f0d;

  if(!isDefined(var_f5842481)) {
    var_f5842481 = 0;
  }

  return self botgetlookdot() >= var_f5842481;
}

function_bacb1c08(actionparams) {
  var_b4c8298c = isDefined(self.bot.tacbundle.var_b4c8298c) ? self.bot.tacbundle.var_b4c8298c : 0;
  return self botgetlookdot() >= var_b4c8298c;
}

function_55d5a581(actionparams) {
  adsdot = isDefined(self.bot.tacbundle.adsdot) ? self.bot.tacbundle.adsdot : 0;
  return self botgetlookdot() >= adsdot;
}

get_max_health() {
  if(isvehicle(self)) {
    return self.healthdefault;
  }

  return self.maxhealth;
}

look_along_path() {
  var_e125ba43 = "Path";
  debugcolor = (1, 1, 1);
  var_8be65bb9 = self function_f04bd922();

  if(isDefined(var_8be65bb9) && isDefined(var_8be65bb9.var_2cfdc66d)) {
    var_104d463 = var_8be65bb9.var_2cfdc66d;
    var_e125ba43 = "Corner";

    if(isDefined(var_8be65bb9.var_b7af6731)) {
      distsq = distance2dsquared(self.origin, var_104d463);

      if(distsq < 4096) {
        var_104d463 = var_8be65bb9.var_b7af6731;
        var_e125ba43 = "Next Corner";
      }
    }

    lookpoint = var_104d463;
    debugcolor = (1, 1, 0);
  } else if(isDefined(self.overridegoalpos)) {
    lookpoint = self.overridegoalpos;
    var_e125ba43 = "Override Goal Pos";
    debugcolor = (1, 0, 1);
  } else {
    lookpoint = self.goalpos;
    var_e125ba43 = self.goalforced ? "Goal Pos (Forced)" : "Goal Pos";
    debugcolor = self.goalforced ? (0, 1, 1) : (0, 1, 0);
  }

  viewheight = self getplayerviewheight();
  lookpoint += (0, 0, viewheight);
  self look_at_point(lookpoint, var_e125ba43, debugcolor);
}

function_412e04fa(node) {
  var_208965cf = node.spawnflags&262144;
  var_a26a51ba = node.spawnflags&524288;

  if(!var_208965cf && !var_a26a51ba) {
    self botsetlookangles(node.angles);
    return;
  }

  noderight = anglestoright(node.angles);
  rotation = isfullcovernode(node) ? 20 : 45;

  if(var_208965cf && var_a26a51ba) {
    if(isfullcovernode(node)) {
      if(vectordot(noderight, self.origin - node.origin) >= 0) {
        rotation *= -1;
      }
    } else if(isDefined(self.enemylastseenpos)) {
      if(vectordot(noderight, self.enemylastseenpos - self.origin) >= 0) {
        rotation *= -1;
      }
    } else if(randomint(2) > 0) {
      rotation *= -1;
    }
  } else if(var_a26a51ba) {
    rotation *= -1;
  }

  lookangles = (node.angles[0], node.angles[1] + rotation, node.angles[2]);
  self botsetlookangles(lookangles);
}

look_at_point(point, var_e125ba43, debugcolor) {
  self botsetlookpoint(point);

  if(self bot::should_record("<dev string:x635>")) {
    recordsphere(point, 4, debugcolor, "<dev string:x4b>");
    record3dtext(var_e125ba43, point + (0, 0, 5), debugcolor, "<dev string:x4b>", undefined, 0.5);
  }

}

function_2b8f7067() {
  if(self haspath()) {
    self look_along_path();
    return;
  }

  if(isDefined(self.ignoreall) && self.ignoreall || isDefined(self.var_911100f4) && self.var_911100f4) {
    self function_c17972fc();
    return;
  }

  if(length(self getvelocity()) > 10) {
    self function_c17972fc();
    return;
  }

  var_4f1e4d22 = !isDefined(self.var_b6b6a5d9) || distancesquared(self.origin, self.var_b6b6a5d9) > 256;

  if(var_4f1e4d22) {
    self.var_83867a22 = undefined;
    self.var_b6b6a5d9 = self.origin;
    var_7607a546 = getclosesttacpoint(self.origin);

    if(!isDefined(var_7607a546)) {
      return;
    }

    var_7607a546.searched = 1;
    var_b43277fd = [var_7607a546];
    var_d56aeea7 = [var_7607a546];
    v_start_hardpoint_navmesh_collision = [];
    var_4a39f740 = [];
    self.var_77ae9678 = [];

    while(var_b43277fd.size > 0) {
      currentpoint = var_b43277fd[0];
      newpoints = function_9086d9a4(currentpoint);

      foreach(point in newpoints) {
        if(!(isDefined(point.searched) && point.searched)) {
          point.searched = 1;
          var_d56aeea7[var_d56aeea7.size] = point;

          if(var_7607a546.region != point.region) {
            if(!array::contains(v_start_hardpoint_navmesh_collision, currentpoint)) {
              v_start_hardpoint_navmesh_collision[v_start_hardpoint_navmesh_collision.size] = currentpoint;
            }

            continue;
          }

          if(!function_96c81b85(var_7607a546, point.origin + (0, 0, 60))) {
            if(!array::contains(var_4a39f740, currentpoint)) {
              var_4a39f740[var_4a39f740.size] = currentpoint;
            }

            continue;
          }

          var_b43277fd[var_b43277fd.size] = point;
        }
      }

      var_b43277fd = array::remove_index(var_b43277fd, 0);
    }

    foreach(point in var_d56aeea7) {
      point.searched = undefined;
    }

    self.var_77ae9678 = arraycombine(v_start_hardpoint_navmesh_collision, var_4a39f740, 0, 0);
  }

  if(isDefined(self.var_77ae9678) && self.var_77ae9678.size > 0) {
    if(!isDefined(self.var_83867a22) || !isDefined(self.var_fa107838) || gettime() >= self.var_fa107838) {
      self.var_fa107838 = gettime() + randomintrange(2000, 4000);
      pointsarray = self.var_77ae9678;

      if(isDefined(self.var_83867a22) && pointsarray.size >= 2) {
        arrayremovevalue(pointsarray, self.var_83867a22);
      }

      self.var_83867a22 = array::random(pointsarray);
    }
  }

  if(isDefined(self.var_83867a22)) {
    viewheight = self getplayerviewheight();
    lookpoint = self.var_83867a22.origin + (0, 0, viewheight);
    var_e125ba43 = "Neighboring Region Entrance";
    debugcolor = (1, 0, 0);
    self look_at_point(lookpoint, var_e125ba43, debugcolor);
    return;
  }

  node = self bot::get_position_node();

  if(isDefined(node)) {
    self function_412e04fa(node);
    return;
  }

  self function_c17972fc();
}

function_c17972fc() {
  self botsetlookangles(self.angles);
}

function_ab4c3550() {
  return isDefined(self.enemylastseenpos);
}

function_3094610b(limit = 0) {
  return isDefined(self.enemylastseenpos) && isDefined(self.enemylastseentime) && gettime() < self.enemylastseentime + limit;
}

function_ca71ffdb() {
  return sighttracepassed(self getEye(), self.enemylastseenpos, 0, self);
}

function_d273d4e7() {
  self look_at_point(self.enemylastseenpos, "EnemyLastSeenPos", (1, 0.5, 0));
}

function_4fbd6cf1() {
  return isDefined(self.var_2925fedc);
}

function_3b98ad10() {
  self look_at_point(self.var_2925fedc, "LikelyEnemyPosition", (1, 0.5, 0));
}

clip_ammo(weapon) {
  return self getweaponammoclip(weapon) + self getweaponammoclip(weapon.dualwieldweapon);
}

function_39317d6e(actionparams) {
  if(self.ignoreall) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x233>";

    return undefined;
  }

  if(!self function_5de4c088(actionparams)) {
    return undefined;
  }

  return 100;
}

function_30636b1c(actionparams) {
  if(!self function_5de4c088(actionparams)) {
    return undefined;
  }

  if(!self bot::in_combat()) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x1ed>";

    return undefined;
  }

  return 100;
}

function_38d0d1df(actionparams) {
  if(!self function_5de4c088(actionparams)) {
    return undefined;
  }

  if(self bot::has_visible_enemy()) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x657>";

    return undefined;
  }

  return 100;
}

function_a9847723(weapon) {
  slot = self gadgetgetslot(weapon);
  button = self function_c6e02c38(weapon);

  if(!isDefined(button)) {
    return;
  }

  self bottapbutton(button);
  self waittill(#"hash_347a612b61067eb3");
}

function_8171a298(weapon) {
  slot = self gadgetgetslot(weapon);
  button = self function_c6e02c38(weapon);

  if(!isDefined(button)) {
    return;
  }

  self botswitchtoweapon(weapon);
  self waittill(#"hash_347a612b61067eb3");
  self bottapbutton(button);
  self waittill(#"hash_347a612b61067eb3");
}

function_ec16df22(weapon) {
  slot = self gadgetgetslot(weapon);
  button = self function_c6e02c38(weapon);

  if(!isDefined(button)) {
    return;
  }

  self bottapbutton(button);
  self botswitchtoweapon(weapon);
  self waittill(#"hash_347a612b61067eb3");
}

test_gadget(actionparams) {
  weapon = actionparams.weapon;

  if(!isDefined(weapon)) {
    self botprinterror("<dev string:x667>" + "<dev string:x681>");

    self waittill(#"hash_347a612b61067eb3");
    return;
  }

  self function_ccdcc5d9(weapon);

  while(self isthrowinggrenade() || !self isweaponready() || self getcurrentweapon() == level.weaponnone) {
    self waittill(#"hash_347a612b61067eb3");
  }
}

function_fe0b0c29(slot) {
  switch (slot) {
    case 0:
      return self ai::get_behavior_attribute("allowprimaryoffhand");
    case 1:
      return self ai::get_behavior_attribute("allowsecondaryoffhand");
    case 2:
      return self ai::get_behavior_attribute("allowspecialoffhand");
  }

  return 0;
}

function_5de4c088(actionparams) {
  weapon = actionparams.weapon;
  slot = self gadgetgetslot(weapon);

  if(!self function_fe0b0c29(slot)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x696>";

    return false;
  }

  if(!self gadgetisready(slot)) {
    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x6ba>";

    return false;
  }

  return true;
}

deploy_gadget(actionparams, checkgrenade) {
  weapon = actionparams.weapon;

  if(!isDefined(weapon)) {
    self botprinterror("<dev string:x6cd>" + "<dev string:x681>");

    self waittill(#"hash_347a612b61067eb3");
    return;
  }

  self function_ccdcc5d9(weapon);

  while(isDefined(checkgrenade) && checkgrenade && self isthrowinggrenade() || !self isweaponready() || self getcurrentweapon() == level.weaponnone) {
    self waittill(#"hash_347a612b61067eb3");
  }
}

function_94f96101(actionparams) {
  self deploy_gadget(actionparams, 1);
}

function_e7fa3d0() {
  return self ai::get_behavior_attribute("allowscorestreak");
}

function_29163ca5(weapon) {
  self botswitchtoweapon(weapon);
  self waittill(#"hash_347a612b61067eb3");
}

function_11c3d810(weapon) {
  activatefunc = weapon.rootweapon.var_c75f000;

  if(!isDefined(activatefunc)) {
    self botprinterror(weapon.name + "<dev string:x5c0>");

    return;
  }

  self[[activatefunc]](weapon);
}

function_bf21ead1() {
  if(!isDefined(self.bot.tacbundle.var_d1fb2f1a) || (isDefined(self.bot.tacbundle.var_d1fb2f1a) ? self.bot.tacbundle.var_d1fb2f1a : 0) == 0) {
    return;
  }

  if(!self function_37256a9b()) {
    return;
  }

  if(!isDefined(self.var_3ec95cb4) || gettime() >= self.var_3ec95cb4) {
    if(self bot::has_visible_enemy() && self.enemy.classname == "player") {
      self.favoriteenemy = undefined;
      self clearentitytarget();
      return;
    }

    self.favoriteenemy = self function_2a24a928();

    if(isDefined(self.favoriteenemy)) {
      self setentitytarget(self.favoriteenemy);
    } else {
      self clearentitytarget();
    }

    if(!isDefined(self.favoriteenemy) && !isDefined(self.enemy) && self.bot.var_469cfe53.isfavoriteenemy) {
      self function_42907fd4();
    }

    self.var_3ec95cb4 = gettime() + randomintrange(1000, 10000);
  }
}

function_37256a9b() {
  weapons = self getweaponslist();

  foreach(weapon in weapons) {
    if(weapon.lockontype != "None") {
      clipammo = self clip_ammo(weapon);
      stockammo = self getweaponammostock(weapon);

      if(clipammo + stockammo > 0) {
        return true;
      }
    }
  }

  return false;
}

function_2a24a928() {
  potentialtargets = [];

  if(isDefined(level.spawneduavs)) {
    foreach(uav in level.spawneduavs) {
      if(isDefined(uav) && util::function_fbce7263(uav.team, self.team)) {
        potentialtargets[potentialtargets.size] = uav;
      }
    }
  }

  if(isDefined(level.counter_uav_entities)) {
    foreach(cuav in level.counter_uav_entities) {
      if(isDefined(cuav) && util::function_fbce7263(cuav.team, self.team)) {
        potentialtargets[potentialtargets.size] = cuav;
      }
    }
  }

  choppers = getEntArray("chopper", "targetName");

  if(isDefined(choppers)) {
    foreach(chopper in choppers) {
      if(isDefined(chopper) && util::function_fbce7263(chopper.team, self.team)) {
        potentialtargets[potentialtargets.size] = chopper;
      }
    }
  }

  planes = getEntArray("strafePlane", "targetName");

  if(isDefined(planes)) {
    foreach(plane in planes) {
      if(isDefined(plane) && util::function_fbce7263(plane.team, self.team)) {
        potentialtargets[potentialtargets.size] = plane;
      }
    }
  }

  if(isDefined(level.ac130) && util::function_fbce7263(level.ac130.team, self.team)) {
    potentialtargets[potentialtargets.size] = level.ac130;
  }

  if(potentialtargets.size == 0) {
    return undefined;
  }

  var_137299d = [];
  var_7607a546 = getclosesttacpoint(self.origin);

  if(isDefined(var_7607a546)) {
    foreach(target in potentialtargets) {
      if(issentient(target)) {
        if(!isDefined(target.var_e38e137f) || !isDefined(target.var_e38e137f[self getentitynumber()])) {
          target.var_e38e137f[self getentitynumber()] = randomfloat(1) < (isDefined(self.bot.tacbundle.var_d1fb2f1a) ? self.bot.tacbundle.var_d1fb2f1a : 0);
        }

        if(!target.var_e38e137f[self getentitynumber()]) {
          continue;
        }

        if(function_96c81b85(var_7607a546, target.origin)) {
          var_137299d[var_137299d.size] = target;
        }
      }
    }
  }

  if(var_137299d.size == 0) {
    return undefined;
  }

  var_1f5c2eac = util::get_array_of_closest(self.origin, var_137299d);
  return var_1f5c2eac[0];
}