/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_placeable_mine.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weaponobjects;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace zm_placeable_mine;

function autoexec __init__sytem__() {
  system::register("placeable_mine", undefined, &__main__, undefined);
}

function private __main__() {
  if(isDefined(level.placeable_mines)) {
    level thread replenish_after_rounds();
  }
}

function private init_internal() {
  if(isDefined(level.placeable_mines)) {
    return;
  }
  level.placeable_mines = [];
  level.placeable_mines_on_damage = &placeable_mine_damage;
  level.pickup_placeable_mine = &pickup_placeable_mine;
  level.pickup_placeable_mine_trigger_listener = &pickup_placeable_mine_trigger_listener;
  level.placeable_mine_planted_callbacks = [];
}

function get_first_available() {
  if(isDefined(level.placeable_mines) && level.placeable_mines.size > 0) {
    str_key = getarraykeys(level.placeable_mines)[0];
    return level.placeable_mines[str_key];
  }
  return level.weaponnone;
}

function add_mine_type(mine_name, str_retrieval_prompt) {
  init_internal();
  weaponobjects::createretrievablehint(mine_name, str_retrieval_prompt);
  level.placeable_mines[mine_name] = getweapon(mine_name);
  level.placeable_mine_planted_callbacks[mine_name] = [];
}

function add_weapon_to_mine_slot(mine_name) {
  init_internal();
  level.placeable_mines[mine_name] = getweapon(mine_name);
  level.placeable_mine_planted_callbacks[mine_name] = [];
  if(!isDefined(level.placeable_mines_in_name_only)) {
    level.placeable_mines_in_name_only = [];
  }
  level.placeable_mines_in_name_only[mine_name] = getweapon(mine_name);
}

function set_max_per_player(n_max_per_player) {
  level.placeable_mines_max_per_player = n_max_per_player;
}

function add_planted_callback(fn_planted_cb, wpn_name) {
  if(!isDefined(level.placeable_mine_planted_callbacks[wpn_name])) {
    level.placeable_mine_planted_callbacks[wpn_name] = [];
  } else if(!isarray(level.placeable_mine_planted_callbacks[wpn_name])) {
    level.placeable_mine_planted_callbacks[wpn_name] = array(level.placeable_mine_planted_callbacks[wpn_name]);
  }
  level.placeable_mine_planted_callbacks[wpn_name][level.placeable_mine_planted_callbacks[wpn_name].size] = fn_planted_cb;
}

function private run_planted_callbacks(e_planter) {
  foreach(fn in level.placeable_mine_planted_callbacks[self.weapon.name]) {
    self thread[[fn]](e_planter);
  }
}

function private safe_to_plant() {
  if(isDefined(level.placeable_mines_max_per_player) && self.owner.placeable_mines.size >= level.placeable_mines_max_per_player) {
    return false;
  }
  return true;
}

function private wait_and_detonate() {
  wait(0.1);
  self detonate(self.owner);
}

function private mine_watch(wpn_type) {
  self endon("death");
  self notify("mine_watch");
  self endon("mine_watch");
  while(true) {
    self waittill("grenade_fire", mine, fired_weapon);
    if(fired_weapon == wpn_type) {
      mine.owner = self;
      mine.team = self.team;
      mine.weapon = fired_weapon;
      self notify(("zmb_enable_" + fired_weapon.name) + "_prompt");
      if(mine safe_to_plant()) {
        mine run_planted_callbacks(self);
        self zm_stats::increment_client_stat(fired_weapon.name + "_planted");
        self zm_stats::increment_player_stat(fired_weapon.name + "_planted");
      } else {
        mine thread wait_and_detonate();
      }
    }
  }
}

function is_true_placeable_mine(mine_name) {
  if(!isDefined(level.placeable_mines_in_name_only)) {
    return true;
  }
  if(!isDefined(level.placeable_mines_in_name_only[mine_name])) {
    return true;
  }
  return false;
}

function setup_for_player(wpn_type, ui_model = "hudItems.showDpadRight") {
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
  self zm_utility::set_player_placeable_mine(wpn_type);
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

function disable_prompt_for_player(wpn_type) {
  self notify(("zmb_disable_" + wpn_type.name) + "_prompt");
}

function disable_all_prompts_for_player() {
  foreach(mine in level.placeable_mines) {
    self disable_prompt_for_player(mine);
  }
}

function private pickup_placeable_mine() {
  player = self.owner;
  wpn_type = self.weapon;
  if(player.is_drinking > 0) {
    return;
  }
  current_player_mine = player zm_utility::get_player_placeable_mine();
  if(current_player_mine != wpn_type) {
    player takeweapon(current_player_mine);
  }
  if(!player hasweapon(wpn_type)) {
    player thread mine_watch(wpn_type);
    player giveweapon(wpn_type);
    player zm_utility::set_player_placeable_mine(wpn_type);
    player setactionslot(4, "weapon", wpn_type);
    player setweaponammoclip(wpn_type, 0);
    player notify(("zmb_enable_" + wpn_type.name) + "_prompt");
  } else {
    clip_ammo = player getweaponammoclip(wpn_type);
    clip_max_ammo = wpn_type.clipsize;
    if(clip_ammo >= clip_max_ammo) {
      self zm_utility::destroy_ent();
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

function private pickup_placeable_mine_trigger_listener(trigger, player) {
  self thread pickup_placeable_mine_trigger_listener_enable(trigger, player);
  self thread pickup_placeable_mine_trigger_listener_disable(trigger, player);
}

function private pickup_placeable_mine_trigger_listener_enable(trigger, player) {
  self endon("delete");
  self endon("death");
  while(true) {
    player util::waittill_any(("zmb_enable_" + self.weapon.name) + "_prompt", "spawned_player");
    if(!isDefined(trigger)) {
      return;
    }
    trigger triggerenable(1);
    trigger linkto(self);
  }
}

function private pickup_placeable_mine_trigger_listener_disable(trigger, player) {
  self endon("delete");
  self endon("death");
  while(true) {
    player waittill(("zmb_disable_" + self.weapon.name) + "_prompt");
    if(!isDefined(trigger)) {
      return;
    }
    trigger unlink();
    trigger triggerenable(0);
  }
}

function private placeable_mine_damage() {
  self endon("death");
  self setCanDamage(1);
  self.health = 100000;
  self.maxhealth = self.health;
  attacker = undefined;
  while(true) {
    self waittill("damage", amount, attacker);
    if(!isDefined(self)) {
      return;
    }
    self.health = self.maxhealth;
    if(!isplayer(attacker)) {
      continue;
    }
    if(isDefined(self.owner) && attacker == self.owner) {
      continue;
    }
    if(isDefined(attacker.pers) && isDefined(attacker.pers["team"]) && attacker.pers["team"] != level.zombie_team) {
      continue;
    }
    break;
  }
  if(level.satchelexplodethisframe) {
    wait(0.1 + randomfloat(0.4));
  } else {
    wait(0.05);
  }
  if(!isDefined(self)) {
    return;
  }
  level.satchelexplodethisframe = 1;
  thread reset_satchel_explode_this_frame();
  self detonate(attacker);
}

function private reset_satchel_explode_this_frame() {
  wait(0.05);
  level.satchelexplodethisframe = 0;
}

function private replenish_after_rounds() {
  while(true) {
    level waittill("between_round_over");
    if(isDefined(level.func_custom_placeable_mine_round_replenish)) {
      [[level.func_custom_placeable_mine_round_replenish]]();
      continue;
    }
    if(!level flag::exists("teleporter_used") || !level flag::get("teleporter_used")) {
      players = getplayers();
      for(i = 0; i < players.size; i++) {
        foreach(mine in level.placeable_mines) {
          if(players[i] zm_utility::is_player_placeable_mine(mine) && is_true_placeable_mine(mine.name)) {
            players[i] giveweapon(mine);
            players[i] zm_utility::set_player_placeable_mine(mine);
            players[i] setactionslot(4, "weapon", mine);
            players[i] setweaponammoclip(mine, 2);
            break;
          }
        }
      }
    }
  }
}

function setup_watchers() {
  if(isDefined(level.placeable_mines)) {
    foreach(mine_type in level.placeable_mines) {
      watcher = self weaponobjects::createuseweaponobjectwatcher(mine_type.name, self.team);
      watcher.onspawnretrievetriggers = &on_spawn_retrieve_trigger;
      watcher.adjusttriggerorigin = &adjust_trigger_origin;
      watcher.pickup = level.pickup_placeable_mine;
      watcher.pickup_trigger_listener = level.pickup_placeable_mine_trigger_listener;
      watcher.skip_weapon_object_damage = 1;
      watcher.headicon = 0;
      watcher.watchforfire = 1;
      watcher.ondetonatecallback = &placeable_mine_detonate;
      watcher.ondamage = level.placeable_mines_on_damage;
    }
  }
}

function private on_spawn_retrieve_trigger(watcher, player) {
  self weaponobjects::onspawnretrievableweaponobject(watcher, player);
  if(isDefined(self.pickuptrigger)) {
    self.pickuptrigger sethintlowpriority(0);
  }
}

function private adjust_trigger_origin(origin) {
  origin = origin + vectorscale((0, 0, 1), 20);
  return origin;
}

function private placeable_mine_detonate(attacker, weapon, target) {
  if(weapon.isemp) {
    self delete();
    return;
  }
  if(isDefined(attacker)) {
    self detonate(attacker);
  } else {
    if(isDefined(self.owner) && isplayer(self.owner)) {
      self detonate(self.owner);
    } else {
      self detonate();
    }
  }
}