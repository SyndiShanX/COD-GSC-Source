/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bots\zm_bot_action.gsc
***********************************************/

#include scripts\core_common\ai_shared;
#include scripts\core_common\bots\bot;
#include scripts\core_common\bots\bot_action;
#include scripts\core_common\system_shared;

#namespace zm_bot_action;

autoexec __init__system__() {
  system::register(#"zm_bot_action", &__init__, &__main__, undefined);
}

__init__() {}

__main__() {
  level bot_action::register_actions();
  level bot_action::register_weapons();
  level bot_action::function_25f1e3c1();
  level register_actions();
  level register_weapons();
  level function_25f1e3c1();
}

register_actions() {
  bot_action::register_action(#"melee_zombie_enemy", &bot_action::current_melee_weapon_rank, &function_aa4daa54, &bot_action::melee_enemy);
  bot_action::register_action(#"hash_22d98a5a241c78ba", &bot_action::rank_priority, &function_b4d8b7d6, &function_3c22de9a);
  bot_action::register_action(#"hash_5c2824c8a8f125f7", &bot_action::rank_priority, &function_ae19f70f, &function_2c6e5988);
  bot_action::register_action(#"zombie_auto_revive", &bot_action::rank_priority, &function_f4707540, &zombie_auto_revive);
  bot_action::register_action(#"zombie_reload_weapon", &bot_action::current_weapon_rank, &bot_action::reload_weapon_weight, &zombie_reload_weapon);
  bot_action::register_action(#"zombie_revive_player", &bot_action::rank_priority, &function_296516b4, &bot_action::revive_player);
  bot_action::register_action(#"zombie_scan_for_threats", &bot_action::function_728212e8, &bot_action::scan_for_threats_weight, &zombie_scan_for_threats);
}

register_weapons() {
  bot_action::register_bulletweapon(#"ar_mg1909_t8");
  bot_action::register_bulletweapon(#"minigun");
  bot_action::register_bulletweapon(#"pistol_revolver38");
  bot_action::register_bulletweapon(#"pistol_topbreak_t8");
  bot_action::register_bulletweapon(#"shotgun_trenchgun_t8");
  bot_action::register_bulletweapon(#"smg_drum_pistol_t8");
  bot_action::register_bulletweapon(#"ww_tricannon_t8");
  bot_action::register_bulletweapon(#"ww_tricannon_air_t8");
  bot_action::register_bulletweapon(#"ww_tricannon_earth_t8");
  bot_action::register_bulletweapon(#"ww_tricannon_fire_t8");
  bot_action::register_bulletweapon(#"ww_tricannon_water_t8");
  self function_c31a5c42();
}

function_25f1e3c1() {}

function_c31a5c42() {}

function_95600a05(actionparams) {
  actionparams.target = self.enemy;
  self bot_action::function_9c6ca396(actionparams);
  return 100;
}

throw_chakram(actionparams) {
  weapon = actionparams.weapon;
  dualwieldweapon = weapon.dualwieldweapon;

  while(!self bot_action::function_cf788c22() && self bot::weapon_loaded(dualwieldweapon)) {
    self bot_action::function_8a2b82ad(actionparams);
    self bot_action::function_e69a1e2e(actionparams);

    if(self bot_action::function_faa6a59d(actionparams, dualwieldweapon.maxdamagerange) && self bot_action::function_31a76186(actionparams)) {
      self bottapbutton(24);
    }

    self waittill(#"hash_347a612b61067eb3");
  }
}

function_5f02aeee(actionparams) {
  weapon = actionparams.weapon;
  slot = self gadgetgetslot(weapon);

  if(!self bot_action::function_fe0b0c29(slot)) {

    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x38>";

      return undefined;
  }

  if(!self gadgetisready(slot)) {

    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x5c>";

      return undefined;
  }

  if(!self bot::in_combat()) {

    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x6f>";

      return undefined;
  }

  if(!isDefined(self.enemy) || !isalive(self.enemy)) {

    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x7f>";

      return undefined;
  }

  if(self getenemiesinradius(self.origin, 512).size < 8 && self getenemiesinradius(self.origin, 256).size < 5) {

    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x8a>";

      return undefined;
  }

  return 100;
}

function_ef04e9cc(actionparams) {
  weapon = actionparams.weapon;
  self bot_action::function_ccdcc5d9(weapon);

  while(self isswitchingweapons()) {
    self waittill(#"hash_347a612b61067eb3");
  }
}

function_aa4daa54(actionparams) {
  actionparams.target = self.enemy;
  weapon = actionparams.weapon;
  primaryweapons = self getweaponslistprimaries();

  foreach(primary in primaryweapons) {
    if(isDefined(primary) && primary.name != "none") {
      if(self getammocount(primary) > 0) {

        if(!isDefined(actionparams.debug)) {
          actionparams.debug = [];
        } else if(!isarray(actionparams.debug)) {
          actionparams.debug = array(actionparams.debug);
        }

        actionparams.debug[actionparams.debug.size] = "<dev string:xa6>";

          return undefined;
      }
    }
  }

  if(!self bot_action::is_target_visible(actionparams)) {

    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:xc0>";

      return undefined;
  }

  meleerange = actionparams.weapon.var_bfbec33f;
  enemyradius = self.enemy getpathfindingradius();

  if(distance2dsquared(self.origin, self.enemy.origin) > (meleerange + enemyradius) * (meleerange + enemyradius)) {

    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:xd3>";

      return undefined;
  }

  return 100;
}

zombie_auto_revive(actionparams) {
  while(isDefined(self.revivetrigger)) {
    self bottapbutton(3);
    waitframe(1);
  }
}

function_f4707540(actionparams) {
  if(!isDefined(self.var_72249004) || self.var_72249004 <= 0) {

    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:xee>";

      return undefined;
  }

  return 100;
}

function_ae19f70f(actionparams) {
  if(self getcurrentweapon().isgadget) {

    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x107>";

      return undefined;
  }

  if(!self bot::function_914feddd()) {

    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x116>";

      return undefined;
  }

  if(self haspath()) {

    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x133>";

      return undefined;
  }

  zombie_weapon_upgrade = self bot::get_interact();
  actionparams.zombie_weapon_upgrade = zombie_weapon_upgrade;
  trigger = function_d41104ab(zombie_weapon_upgrade);

  if(!isDefined(trigger)) {

    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x145>";

      return undefined;
  }

  if(!self function_f59547eb(trigger)) {

    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x152>";

      return undefined;
  }

  return 100;
}

function_99428ae2(actionparams) {
  self notify(#"hash_782d5f24975a7cd1");
  self endon(#"hash_782d5f24975a7cd1", #"hash_5b4f399c08222e2", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start", #"hash_1728f8b5de3bde13");
  level endon(#"game_ended");
  self waittill(#"wallbuy_done");
  actionparams.var_d9c6fa12 = 1;
}

private function_f59547eb(trigger) {
  var_e61f062b = self getpathfindingradius();
  maxs = (trigger.maxs[0], trigger.maxs[1], 0);
  var_12f8c7ca = length(maxs);
  return distance2dsquared(self.origin, trigger.origin) <= (120 + var_12f8c7ca + var_e61f062b) * (120 + var_12f8c7ca + var_e61f062b);
}

function_2c6e5988(actionparams) {
  zombie_weapon_upgrade = actionparams.zombie_weapon_upgrade;
  trigger = zombie_weapon_upgrade.trigger_stub.playertrigger[self getentitynumber()];
  trigger useby(self);
  waitframe(1);
  self bot::clear_interact();
}

function_d41104ab(interact) {
  assert(isbot(self));

  if(!isDefined(interact)) {
    return;
  }

  if(isentity(interact)) {
    return interact;
  }

  if(isDefined(interact.trigger_stub) && isDefined(interact.trigger_stub.playertrigger)) {
    return interact.trigger_stub.playertrigger[self getentitynumber()];
  }

  if(isDefined(interact.unitrigger_stub) && isDefined(interact.unitrigger_stub.playertrigger)) {
    return interact.unitrigger_stub.playertrigger[self getentitynumber()];
  }

  if(isDefined(interact.playertrigger)) {
    return interact.playertrigger[self getentitynumber()];
  }
}

function_b4d8b7d6(actionparams) {
  if(self getcurrentweapon().isgadget) {

    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x107>";

      return undefined;
  }

  if(!self bot::function_43a720c7()) {

    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x169>";

      return undefined;
  }

  if(self haspath()) {

    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x133>";

      return undefined;
  }

  interact = self bot::get_interact();
  actionparams.interact = interact;
  trigger = function_d41104ab(interact);

  if(!isDefined(trigger)) {

    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x145>";

      return undefined;
  }

  if(!self function_f59547eb(trigger)) {

    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x152>";

      return undefined;
  }

  return 100;
}

function_3c22de9a(actionparams) {
  trigger = function_d41104ab(actionparams.interact);
  self bottapbutton(3);
  waitframe(1);

  if(isDefined(self) && isDefined(trigger)) {
    self bottapbutton(3);
    trigger useby(self);
  }

  waitframe(1);
  self bot::clear_interact();
}

zombie_scan_for_threats(actionparams) {
  targetvisible = self bot_action::is_target_visible(actionparams);
  actionparams.targetvisible = targetvisible;

  while(!self bot_action::function_cf788c22() && self bot_action::is_target_enemy(actionparams) && actionparams.targetvisible == targetvisible) {
    trigger = function_d41104ab(bot::get_interact());

    if(isDefined(trigger) && self bot::function_914feddd() && function_f59547eb(trigger)) {
      break;
    }

    if(targetvisible && self bot_action::function_ee402bf6(actionparams)) {
      self bot_action::function_8a2b82ad(actionparams);
      self bot_action::function_e69a1e2e(actionparams);
    } else if(targetvisible) {
      self bot_action::function_8a2b82ad(actionparams);
      self bot_action::aim_at_target(actionparams);
    } else if(!targetvisible && self bot_action::function_ee402bf6(actionparams) && self seerecently(actionparams.target, 4000)) {
      self bot_action::function_8a2b82ad(actionparams);
      self bot_action::function_e69a1e2e(actionparams);
    } else if(self bot_action::function_4fbd6cf1()) {
      self bot_action::function_3b98ad10();
    } else if(self haspath()) {
      self bot_action::look_along_path();
    } else {
      self bot_action::function_c17972fc();
    }

    self waittill(#"hash_347a612b61067eb3");
    targetvisible = self bot_action::is_target_visible(actionparams);
  }
}

zombie_reload_weapon(actionparams) {
  weapon = self getcurrentweapon();

  if(!self isreloading()) {
    self bottapbutton(4);
  }

  self waittill(#"hash_347a612b61067eb3");

  while(self isreloading()) {
    if(self bot_action::is_target_enemy(actionparams) && self bot_action::is_target_visible(actionparams)) {
      self bot_action::function_8a2b82ad(actionparams);
      self bot_action::function_e69a1e2e(actionparams);
    } else if(self bot_action::is_target_enemy(actionparams) && self bot_action::function_3094610b(self.bot.tacbundle.var_82aa37d8)) {
      if(self bot_action::function_ca71ffdb()) {
        self bot_action::function_d273d4e7();
      } else {
        self bot_action::function_c17972fc();
      }
    } else if(self bot_action::function_4fbd6cf1()) {
      self bot_action::function_3b98ad10();
    } else {
      if(self haspath()) {
        self bot_action::look_along_path();
        return;
      }

      self bot_action::function_c17972fc();
    }

    self waittill(#"hash_347a612b61067eb3");
  }
}

function_296516b4(actionparams) {
  if(self getcurrentweapon().isgadget) {

    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x107>";

      return undefined;
  }

  if(!self ai::get_behavior_attribute("revive")) {

    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x17e>";

      return undefined;
  }

  revivetarget = self bot::get_revive_target();

  if(!isDefined(revivetarget)) {

    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x19c>";

      return undefined;
  }

  actionparams.revivetarget = revivetarget;

  if(!isDefined(actionparams.debug)) {
    actionparams.debug = [];
  } else if(!isarray(actionparams.debug)) {
    actionparams.debug = array(actionparams.debug);
  }

  actionparams.debug[actionparams.debug.size] = "<dev string:x1af>" + revivetarget.name;

    if(!isDefined(revivetarget.revivetrigger)) {

      if(!isDefined(actionparams.debug)) {
        actionparams.debug = [];
      } else if(!isarray(actionparams.debug)) {
        actionparams.debug = array(actionparams.debug);
      }

      actionparams.debug[actionparams.debug.size] = "<dev string:x1ba>";

        return undefined;
    }

  if(!self istouching(revivetarget.revivetrigger)) {

    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x1ce>";

      return undefined;
  }

  if(isDefined(revivetarget.revivetrigger.beingrevived) && revivetarget.revivetrigger.beingrevived) {

    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x1e5>";

      return;
  }

  pathenemyfightdist = self.bot.tacbundle.pathenemyfightdist;

  if(!self ai::get_behavior_attribute("ignorepathenemyfightdist") && isDefined(self.enemy) && isDefined(pathenemyfightdist) && pathenemyfightdist > 0 && distance2dsquared(self.origin, self.enemy.origin) < pathenemyfightdist * pathenemyfightdist) {

    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x1f5>";

      return undefined;
  }

  nearbyenemies = self getenemiesinradius(revivetarget.revivetrigger.origin, 256);

  if(nearbyenemies.size > 0) {

    if(!isDefined(actionparams.debug)) {
      actionparams.debug = [];
    } else if(!isarray(actionparams.debug)) {
      actionparams.debug = array(actionparams.debug);
    }

    actionparams.debug[actionparams.debug.size] = "<dev string:x203>";

      return undefined;
  }

  return 100;
}