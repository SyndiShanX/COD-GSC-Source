/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bots\zm_bot.gsc
***********************************************/

#include scripts\core_common\ai_shared;
#include scripts\core_common\bots\bot;
#include scripts\core_common\bots\bot_action;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\ai\zm_ai_utility;
#include scripts\zm_common\bots\zm_bot_action;
#include scripts\zm_common\bots\zm_bot_position;
#include scripts\zm_common\zm_utility;

#namespace zm_bot;

autoexec __init__system__() {
  system::register(#"zm_bot", &__init__, undefined, undefined);
}

__init__() {
  callback::on_connect(&on_player_connect);
  callback::on_spawned(&on_player_spawned);
  callback::on_player_killed(&on_player_killed);
  callback::on_disconnect(&on_player_disconnect);
  callback::on_laststand(&on_player_laststand);
  callback::on_revived(&on_player_revived);
  callback::on_start_gametype(&init);
  level.var_df0a0911 = "bot_tacstate_zm_default";
  level.var_258cdebb = "bot_tacstate_zm_laststand";
  level.onbotconnect = &on_bot_connect;
  level.onbotspawned = &on_bot_spawned;
  level.var_34eb792d = &handleplayerfasttravel;
  level.zm_bots_scale = getdvarint(#"zm_bots_scale", 1);
}

init() {
  level endon(#"game_ended");
  botsoak = isdedicated() && getdvarint(#"sv_botsoak", 0);

  if(!botsoak) {
    level flag::wait_till("all_players_connected");
  }

  level thread bot::populate_bots();
}

on_bot_connect() {}

on_bot_spawned() {
  self.bot.var_b2b8f0b6 = 150;
  self.bot.var_e8c941d6 = 300;
}

on_player_connect() {
  if(isbot(self)) {
    self botclassadditem(0, "perk_electric_cherry");
    self botclassadditem(0, "perk_staminup");
    self botclassadditem(0, "perk_quick_revive");
    self botclassadditem(0, "perk_dead_shot");
    self botclassadditem(0, "hero_chakram_lv1");
  }
}

on_player_spawned() {
  level bot::function_301f229d(self.team);
  self thread function_69745ea0();
  self function_70e42260();
}

private function_70e42260() {
  if(isprofilebuild()) {
    if(getdvarint(#"scr_botsoaktest", 0)) {
      if(isbot(self)) {
        self.allowdeath = 0;
      }
    }
  }
}

on_player_killed() {
  if(isbot(self)) {
    self bot::clear_revive_target();
  }

  level bot::function_301f229d(self.team);
}

on_player_disconnect() {
  level bot::function_301f229d(self.team);
}

on_player_laststand() {
  if(isbot(self)) {
    self bot::clear_revive_target();
  }

  waitframe(1);

  if(!isDefined(self)) {
    return;
  }

  level bot::function_301f229d(self.team);
}

on_player_revived(params) {
  level bot::function_301f229d(self.team);
}

event_handler[button_bit_actionslot_2_pressed] function_9b83de0f() {
  if(getdvarint(#"zm_bot_orders", 0) == 0) {
    return;
  }

  players = getplayers();
  players = arraysort(players, self.origin);

  foreach(player in players) {
    if(!isbot(player)) {
      continue;
    }

    self order_bot(player);
    break;
  }
}

  function order_bot(bot) {
    target = undefined;
    targetdistsq = undefined;
    targetdot = undefined;

    foreach(wallbuy in level._spawned_wallbuys) {
      distsq = distancesquared(self.origin, wallbuy.origin);

      if(distsq > 262144) {
        continue;
      }

      dot = self bot::fwd_dot(wallbuy.origin);

      if(dot < 0.985) {
        continue;
      }

      if(!isDefined(target) || dot > targetdot) {
        target = wallbuy;
        targetdistsq = distsq;
        targetdot = dot;
      }
    }

    if(isDefined(target)) {

      iprintlnbold(bot.name + "<dev string:x38>" + target.zombie_weapon_upgrade);

        bot bot::set_interact(target);
      return;
    }

    doors = getEntArray("zombie_door", "targetname");
    targetdistsq = undefined;
    targetdot = undefined;

    foreach(door in doors) {
      if(door._door_open) {
        continue;
      }

      distsq = distancesquared(self.origin, door.origin);

      if(distsq > 262144) {
        continue;
      }

      dot = self bot::fwd_dot(door.origin);

      if(dot < 0.985) {
        continue;
      }

      if(!isDefined(target) || dot > targetdot) {
        target = door;
        targetdistsq = distsq;
        targetdot = dot;
      }
    }

    if(isDefined(target)) {

      iprintlnbold(bot.name + "<dev string:x47>");

        bot bot::set_interact(target);
      return;
    }
  }

function_69745ea0() {
  self endon(#"death", #"disconnect");
  self notify(#"hash_6b46933396f9db04");
  self endon(#"hash_6b46933396f9db04");

  while(isDefined(self)) {
    if(isbot(self)) {
      maxsightdist = sqrt(self.maxsightdistsqrd);
      allenemies = self getenemiesinradius(self.origin, maxsightdist);
      allenemies = arraysortclosest(allenemies, self.origin);
      visibleenemy = allenemies[0];

      foreach(enemy in allenemies) {
        if(self cansee(enemy, 2500)) {
          visibleenemy = enemy;
          break;
        }
      }

      if(isDefined(visibleenemy) && isDefined(self.favoriteenemy) && self cansee(self.favoriteenemy, 2500)) {
        if(distance(self.origin, visibleenemy.origin) < distance(self.origin, self.favoriteenemy.origin) * 0.9) {
          self.favoriteenemy = visibleenemy;
        }
      } else {
        self.favoriteenemy = visibleenemy;
      }
    }

    waitframe(1);
  }
}

function_e16b5033(actor) {
  if(!isDefined(level.var_faf67c27)) {
    level.var_faf67c27 = [];
  }

  if(!isDefined(level.var_faf67c27[actor.archetype])) {
    level.var_faf67c27[actor.archetype] = spawnStruct();
    level.var_faf67c27[actor.archetype].round_number = -1;
    min_health = 100;
    var_6109b81d = 0;

    if(isDefined(actor ai::function_9139c839())) {
      min_health = actor ai::function_9139c839().minhealth;
      var_6109b81d = actor ai::function_9139c839().var_854eebd;
    }

    level.var_faf67c27[actor.archetype].min_health = min_health;
    level.var_faf67c27[actor.archetype].var_6109b81d = var_6109b81d;
  }

  if(level.var_faf67c27[actor.archetype].round_number != level.round_number) {
    override_round_num = undefined;

    if(isDefined(actor._starting_round_number)) {
      override_round_num = actor._starting_round_number;
    }

    if(actor.archetype == #"zombie") {
      max_health = float(level.zombie_health);
    } else {
      max_health = float(actor zm_ai_utility::function_8d44707e(level.var_faf67c27[actor.archetype].var_6109b81d, override_round_num));
    }

    level.var_faf67c27[actor.archetype].scale = max_health / level.var_faf67c27[actor.archetype].min_health;
    level.var_faf67c27[actor.archetype].round_number = level.round_number;
  }

  return level.var_faf67c27[actor.archetype].scale * 1;
}

function_1f9de69d(var_40b86c4b) {
  if(!isDefined(var_40b86c4b)) {
    return false;
  }

  players = getplayers();

  foreach(player in players) {
    if(isbot(player)) {
      continue;
    }

    currentzone = player zm_utility::get_current_zone();

    if(currentzone === var_40b86c4b) {
      return true;
    }
  }

  return false;
}

handleplayerfasttravel(player, var_12230d08) {
  player endon(#"death");
  level notify(#"handleplayerfasttravel");
  level endon(#"handleplayerfasttravel");

  if(!isDefined(var_12230d08)) {
    return;
  }

  wait 3;
  currentzone = player zm_utility::get_current_zone();
  currentorigin = player.origin;

  if(!isDefined(currentzone)) {
    return;
  }

  players = getplayers();

  foreach(player in players) {
    if(!isbot(player)) {
      continue;
    }

    var_40b86c4b = player zm_utility::get_current_zone();

    if(var_40b86c4b === currentzone) {
      continue;
    }

    if(function_1f9de69d(var_40b86c4b)) {
      continue;
    }

    if(isDefined(level.var_1dbf5163) && ![
        [level.var_1dbf5163]
      ](player)) {
      continue;
    }

    if(isDefined(level.var_3c84697b)) {
      player thread[[level.var_3c84697b]](var_12230d08);
      continue;
    }

    player setorigin(currentorigin);
    player dontinterpolate();
  }
}