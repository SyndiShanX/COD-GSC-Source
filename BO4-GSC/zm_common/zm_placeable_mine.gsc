/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_placeable_mine.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\trigger_shared;
#include scripts\core_common\util_shared;
#include scripts\weapons\weaponobjects;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_equipment;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_placeable_mine;

autoexec __init__system__() {
  system::register(#"placeable_mine", undefined, &__main__, undefined);
}

private __main__() {
  if(isDefined(level.placeable_mines)) {
    level thread replenish_after_rounds();
  }
}

private init_internal() {
  if(isDefined(level.placeable_mines)) {
    return;
  }

  level.placeable_mines = [];
  level.placeable_mines_on_damage = &placeable_mine_damage;
  level.pickup_placeable_mine = &pickup_placeable_mine;
  level.pickup_placeable_mine_trigger_listener = &pickup_placeable_mine_trigger_listener;
  level.placeable_mine_planted_callbacks = [];
}

get_first_available() {
  if(isDefined(zm_loadout::function_5a5a742a("placeable_mine")) && zm_loadout::function_5a5a742a("placeable_mine").size > 0) {
    str_key = getarraykeys(zm_loadout::function_5a5a742a("placeable_mine"))[0];
    return zm_loadout::function_5a5a742a("placeable_mine")[str_key];
  }

  return level.weaponnone;
}

add_mine_type(mine_name, str_retrieval_prompt) {
  init_internal();
  zm_loadout::function_e884e095("placeable_mine", mine_name);
  level.placeable_mine_planted_callbacks[mine_name] = [];
}

add_weapon_to_mine_slot(mine_name) {
  init_internal();
  level.placeable_mines[mine_name] = getweapon(mine_name);
  level.placeable_mine_planted_callbacks[mine_name] = [];

  if(!isDefined(level.placeable_mines_in_name_only)) {
    level.placeable_mines_in_name_only = [];
  }

  level.placeable_mines_in_name_only[mine_name] = getweapon(mine_name);
}

set_max_per_player(n_max_per_player) {
  level.placeable_mines_max_per_player = n_max_per_player;
}

add_planted_callback(fn_planted_cb, wpn_name) {
  if(!isDefined(level.placeable_mine_planted_callbacks[wpn_name])) {
    level.placeable_mine_planted_callbacks[wpn_name] = [];
  } else if(!isarray(level.placeable_mine_planted_callbacks[wpn_name])) {
    level.placeable_mine_planted_callbacks[wpn_name] = array(level.placeable_mine_planted_callbacks[wpn_name]);
  }

  level.placeable_mine_planted_callbacks[wpn_name][level.placeable_mine_planted_callbacks[wpn_name].size] = fn_planted_cb;
}

private run_planted_callbacks(e_planter) {
  foreach(fn in level.placeable_mine_planted_callbacks[self.weapon.name]) {
    self thread[[fn]](e_planter);
  }
}

private safe_to_plant() {
  if(isDefined(level.placeable_mines_max_per_player) && self.owner.placeable_mines.size >= level.placeable_mines_max_per_player) {
    return false;
  }

  return true;
}

private wait_and_detonate() {
  wait 0.1;
  self detonate(self.owner);
}

private mine_watch(wpn_type) {
  self endon(#"death");
  self notify(#"mine_watch");
  self endon(#"mine_watch");

  while(true) {
    waitresult = self waittill(#"grenade_fire");
    mine = waitresult.projectile;
    fired_weapon = waitresult.weapon;

    if(fired_weapon == wpn_type) {
      mine.owner = self;
      mine.team = self.team;
      mine.weapon = fired_weapon;
      self notify("zmb_enable_" + fired_weapon.name + "_prompt");

      if(mine safe_to_plant()) {
        mine run_planted_callbacks(self);
        self zm_stats::increment_client_stat(fired_weapon.name + "_planted");
        self zm_stats::increment_player_stat(fired_weapon.name + "_planted");
        continue;
      }

      mine thread wait_and_detonate();
    }
  }
}

is_true_placeable_mine(mine_name) {
  if(!isDefined(level.placeable_mines_in_name_only)) {
    return true;
  }

  if(!isDefined(level.placeable_mines_in_name_only[mine_name])) {
    return true;
  }

  return false;
}

setup_for_player(wpn_type, ui_model = "hudItems.showDpadRight") {
  if(!isDefined(self.placeable_mines)) {
    self.placeable_mines = [];
  }

  if(isDefined(self.last_placeable_mine_uimodel)) {
    self clientfield::set_player_uimodel(self.last_placeable_mine_uimodel, 0);
  }

  if(is_true_placeable_mine(wpn_type.name)) {
    self thread mine_watch(wpn_type);
  }

  self giveweapon(wpn_type);
  self zm_loadout::set_player_placeable_mine(wpn_type);
  self setactionslot(4, "weapon", wpn_type);
  startammo = wpn_type.startammo;

  if(startammo) {
    self setweaponammostock(wpn_type, startammo);
  }

  if(isDefined(ui_model)) {
    self clientfield::set_player_uimodel(ui_model, 1);
  }

  self.last_placeable_mine_uimodel = ui_model;
}

disable_prompt_for_player(wpn_type) {
  self notify("zmb_disable_" + wpn_type.name + "_prompt");
}

disable_all_prompts_for_player() {
  foreach(mine in zm_loadout::function_5a5a742a("placeable_mine")) {
    self disable_prompt_for_player(mine);
  }
}

private pickup_placeable_mine() {
  player = self.owner;
  wpn_type = self.weapon;

  if(player zm_utility::is_drinking()) {
    return;
  }

  current_player_mine = player zm_loadout::get_player_placeable_mine();

  if(current_player_mine != wpn_type) {
    player takeweapon(current_player_mine);
  }

  if(!player hasweapon(wpn_type)) {
    player thread mine_watch(wpn_type);
    player giveweapon(wpn_type);
    player zm_loadout::set_player_placeable_mine(wpn_type);
    player setactionslot(4, "weapon", wpn_type);
    player setweaponammoclip(wpn_type, 0);
    player notify("zmb_enable_" + wpn_type.name + "_prompt");
  } else {
    clip_ammo = player getweaponammoclip(wpn_type);
    clip_max_ammo = wpn_type.clipsize;

    if(clip_ammo >= clip_max_ammo) {
      self delete();
      player disable_prompt_for_player(wpn_type);
      return;
    }
  }

  self zm_utility::pick_up();
  clip_ammo = player getweaponammoclip(wpn_type);
  clip_max_ammo = wpn_type.clipsize;

  if(clip_ammo >= clip_max_ammo) {
    player disable_prompt_for_player(wpn_type);
  }

  player zm_stats::increment_client_stat(wpn_type.name + "_pickedup");
  player zm_stats::increment_player_stat(wpn_type.name + "_pickedup");
}

private pickup_placeable_mine_trigger_listener(trigger, player) {
  self thread pickup_placeable_mine_trigger_listener_enable(trigger, player);
  self thread pickup_placeable_mine_trigger_listener_disable(trigger, player);
}

private pickup_placeable_mine_trigger_listener_enable(trigger, player) {
  self endon(#"delete", #"death");

  while(true) {
    player waittill("zmb_enable_" + self.weapon.name + "_prompt", #"spawned_player");

    if(!isDefined(trigger)) {
      return;
    }

    trigger triggerenable(1);
    trigger linkto(self);
  }
}

private pickup_placeable_mine_trigger_listener_disable(trigger, player) {
  self endon(#"delete", #"death");

  while(true) {
    player waittill("zmb_disable_" + self.weapon.name + "_prompt");

    if(!isDefined(trigger)) {
      return;
    }

    trigger unlink();
    trigger triggerenable(0);
  }
}

private placeable_mine_damage() {
  self endon(#"death");
  self setCanDamage(1);
  self.health = 100000;
  self.maxhealth = self.health;
  attacker = undefined;

  while(true) {
    waitresult = self waittill(#"damage");

    if(!isDefined(self)) {
      return;
    }

    self.health = self.maxhealth;

    if(!isplayer(waitresult.attacker)) {
      continue;
    }

    if(isDefined(self.owner) && attacker == self.owner) {
      continue;
    }

    if(isDefined(waitresult.attacker.pers) && isDefined(waitresult.attacker.pers[#"team"]) && waitresult.attacker.pers[#"team"] != level.zombie_team) {
      continue;
    }

    break;
  }

  if(level.satchelexplodethisframe) {
    wait 0.1 + randomfloat(0.4);
  } else {
    waitframe(1);
  }

  if(!isDefined(self)) {
    return;
  }

  level.satchelexplodethisframe = 1;
  thread reset_satchel_explode_this_frame();
  self detonate(waitresult.attacker);
}

private reset_satchel_explode_this_frame() {
  waitframe(1);
  level.satchelexplodethisframe = 0;
}

private replenish_after_rounds() {
  while(true) {
    level waittill(#"between_round_over");

    if(isDefined(level.var_9c6b209c)) {
      [
        [level.var_9c6b209c]
      ]();
      continue;
    }

    if(!level flag::exists("teleporter_used") || !level flag::get("teleporter_used")) {
      players = getplayers();

      for(i = 0; i < players.size; i++) {
        foreach(mine in zm_loadout::function_5a5a742a("placeable_mine")) {
          if(players[i] zm_loadout::is_player_placeable_mine(mine) && is_true_placeable_mine(mine.name)) {
            players[i] giveweapon(mine);
            players[i] zm_loadout::set_player_placeable_mine(mine);
            players[i] setactionslot(4, "weapon", mine);
            players[i] setweaponammoclip(mine, 2);
            break;
          }
        }
      }
    }
  }
}

setup_watchers() {
  if(isDefined(zm_loadout::function_5a5a742a("placeable_mine"))) {
    foreach(mine_type in zm_loadout::function_5a5a742a("placeable_mine")) {
      weaponobjects::function_e6400478(mine_type.name, &zm_red_challenges_hud_wear, 1);
    }
  }
}

zm_red_challenges_hud_wear(watcher) {
  watcher.onspawnretrievetriggers = &on_spawn_retrieve_trigger;
  watcher.adjusttriggerorigin = &adjust_trigger_origin;
  watcher.pickup = level.pickup_placeable_mine;
  watcher.pickup_trigger_listener = level.pickup_placeable_mine_trigger_listener;
  watcher.skip_weapon_object_damage = 1;
  watcher.watchforfire = 1;
  watcher.ondetonatecallback = &placeable_mine_detonate;
  watcher.ondamage = level.placeable_mines_on_damage;
}

private on_spawn_retrieve_trigger(watcher, player) {
  self weaponobjects::function_23b0aea9(watcher, player);

  if(isDefined(self.pickuptrigger)) {
    self.pickuptrigger sethintlowpriority(0);
  }
}

private adjust_trigger_origin(origin) {
  origin += (0, 0, 20);
  return origin;
}

private placeable_mine_detonate(attacker, weapon, target) {
  if(weapon.isemp) {
    self delete();
    return;
  }

  if(isDefined(attacker)) {
    self detonate(attacker);
    return;
  }

  if(isDefined(self.owner) && isplayer(self.owner)) {
    self detonate(self.owner);
    return;
  }

  self detonate();
}