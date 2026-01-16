/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_melee_weapon.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_pers_upgrades_functions;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace zm_melee_weapon;

function autoexec __init__sytem__() {
  system::register("melee_weapon", & __init__, & __main__, undefined);
}

function private __init__() {
  if(!isdefined(level._melee_weapons)) {
    level._melee_weapons = [];
  }
}

function private __main__() {}

function init(weapon_name, flourish_weapon_name, ballistic_weapon_name, ballistic_upgraded_weapon_name, cost, wallbuy_targetname, hint_string, vo_dialog_id, flourish_fn) {
  weapon = getweapon(weapon_name);
  flourish_weapon = getweapon(flourish_weapon_name);
  ballistic_weapon = level.weaponnone;
  if(isdefined(ballistic_weapon_name)) {
    ballistic_weapon = getweapon(ballistic_weapon_name);
  }
  ballistic_upgraded_weapon = level.weaponnone;
  if(isdefined(ballistic_upgraded_weapon_name)) {
    ballistic_upgraded_weapon = getweapon(ballistic_upgraded_weapon_name);
  }
  add_melee_weapon(weapon, flourish_weapon, ballistic_weapon, ballistic_upgraded_weapon, cost, wallbuy_targetname, hint_string, vo_dialog_id, flourish_fn);
  melee_weapon_triggers = getentarray(wallbuy_targetname, "targetname");
  for (i = 0; i < melee_weapon_triggers.size; i++) {
    knife_model = getent(melee_weapon_triggers[i].target, "targetname");
    if(isdefined(knife_model)) {
      knife_model hide();
    }
    melee_weapon_triggers[i] thread melee_weapon_think(weapon, cost, flourish_fn, vo_dialog_id, flourish_weapon, ballistic_weapon, ballistic_upgraded_weapon);
    melee_weapon_triggers[i] sethintstring(hint_string, cost);
    cursor_hint = "HINT_WEAPON";
    cursor_hint_weapon = weapon;
    melee_weapon_triggers[i] setcursorhint(cursor_hint, cursor_hint_weapon);
    melee_weapon_triggers[i] usetriggerrequirelookat();
  }
  melee_weapon_structs = struct::get_array(wallbuy_targetname, "targetname");
  for (i = 0; i < melee_weapon_structs.size; i++) {
    prepare_stub(melee_weapon_structs[i].trigger_stub, weapon, flourish_weapon, ballistic_weapon, ballistic_upgraded_weapon, cost, wallbuy_targetname, hint_string, vo_dialog_id, flourish_fn);
  }
  zm_utility::register_melee_weapon_for_level(weapon.name);
  if(!isdefined(level.ballistic_weapon)) {
    level.ballistic_weapon = [];
  }
  level.ballistic_weapon[weapon] = ballistic_weapon;
  if(!isdefined(level.ballistic_upgraded_weapon)) {
    level.ballistic_upgraded_weapon = [];
  }
  level.ballistic_upgraded_weapon[weapon] = ballistic_upgraded_weapon;
  if(!isdefined(level.zombie_weapons[weapon])) {
    if(isdefined(level.devgui_add_weapon)) {
      [
        [level.devgui_add_weapon]
      ](weapon, "", weapon_name, cost);
    }
  }
}

function prepare_stub(stub, weapon, flourish_weapon, ballistic_weapon, ballistic_upgraded_weapon, cost, wallbuy_targetname, hint_string, vo_dialog_id, flourish_fn) {
  if(isdefined(stub)) {
    stub.hint_string = hint_string;
    stub.cursor_hint = "HINT_WEAPON";
    stub.cursor_hint_weapon = weapon;
    stub.cost = cost;
    if(!(isdefined(level.weapon_cost_client_filled) && level.weapon_cost_client_filled)) {
      stub.hint_parm1 = cost;
    }
    stub.weapon = weapon;
    stub.vo_dialog_id = vo_dialog_id;
    stub.flourish_weapon = flourish_weapon;
    stub.ballistic_weapon = ballistic_weapon;
    stub.ballistic_upgraded_weapon = ballistic_upgraded_weapon;
    stub.trigger_func = & melee_weapon_think;
    stub.flourish_fn = flourish_fn;
  }
}

function find_melee_weapon(weapon) {
  melee_weapon = undefined;
  for (i = 0; i < level._melee_weapons.size; i++) {
    if(level._melee_weapons[i].weapon == weapon) {
      return level._melee_weapons[i];
    }
  }
  return undefined;
}

function add_stub(stub, weapon) {
  melee_weapon = find_melee_weapon(weapon);
  if(isdefined(stub) && isdefined(melee_weapon)) {
    prepare_stub(stub, melee_weapon.weapon, melee_weapon.flourish_weapon, melee_weapon.ballistic_weapon, melee_weapon.ballistic_upgraded_weapon, melee_weapon.cost, melee_weapon.wallbuy_targetname, melee_weapon.hint_string, melee_weapon.vo_dialog_id, melee_weapon.flourish_fn);
  }
}

function add_melee_weapon(weapon, flourish_weapon, ballistic_weapon, ballistic_upgraded_weapon, cost, wallbuy_targetname, hint_string, vo_dialog_id, flourish_fn) {
  melee_weapon = spawnstruct();
  melee_weapon.weapon = weapon;
  melee_weapon.flourish_weapon = flourish_weapon;
  melee_weapon.ballistic_weapon = ballistic_weapon;
  melee_weapon.ballistic_upgraded_weapon = ballistic_upgraded_weapon;
  melee_weapon.cost = cost;
  melee_weapon.wallbuy_targetname = wallbuy_targetname;
  melee_weapon.hint_string = hint_string;
  melee_weapon.vo_dialog_id = vo_dialog_id;
  melee_weapon.flourish_fn = flourish_fn;
  if(!isdefined(level._melee_weapons)) {
    level._melee_weapons = [];
  }
  level._melee_weapons[level._melee_weapons.size] = melee_weapon;
}

function set_fallback_weapon(weapon_name, fallback_weapon_name) {
  melee_weapon = find_melee_weapon(getweapon(weapon_name));
  if(isdefined(melee_weapon)) {
    melee_weapon.fallback_weapon = getweapon(fallback_weapon_name);
  }
}

function determine_fallback_weapon() {
  fallback_weapon = level.weaponzmfists;
  if(isdefined(self zm_utility::get_player_melee_weapon()) && self hasweapon(self zm_utility::get_player_melee_weapon())) {
    melee_weapon = find_melee_weapon(self zm_utility::get_player_melee_weapon());
    if(isdefined(melee_weapon) && isdefined(melee_weapon.fallback_weapon)) {
      return melee_weapon.fallback_weapon;
    }
  }
  return fallback_weapon;
}

function give_fallback_weapon(immediate = 0) {
  fallback_weapon = self determine_fallback_weapon();
  had_weapon = self hasweapon(fallback_weapon);
  self giveweapon(fallback_weapon);
  if(immediate && had_weapon) {
    self switchtoweaponimmediate(fallback_weapon);
  } else {
    self switchtoweapon(fallback_weapon);
  }
}

function take_fallback_weapon() {
  fallback_weapon = self determine_fallback_weapon();
  had_weapon = self hasweapon(fallback_weapon);
  self zm_weapons::weapon_take(fallback_weapon);
  return had_weapon;
}

function player_can_see_weapon_prompt() {
  if(isdefined(level._allow_melee_weapon_switching) && level._allow_melee_weapon_switching) {
    return true;
  }
  if(isdefined(self zm_utility::get_player_melee_weapon()) && self hasweapon(self zm_utility::get_player_melee_weapon())) {
    return false;
  }
  return true;
}

function spectator_respawn_all() {
  for (i = 0; i < level._melee_weapons.size; i++) {
    self spectator_respawn(level._melee_weapons[i].wallbuy_targetname, level._melee_weapons[i].weapon);
  }
}

function spectator_respawn(wallbuy_targetname, weapon) {
  melee_triggers = getentarray(wallbuy_targetname, "targetname");
  players = getplayers();
  for (i = 0; i < melee_triggers.size; i++) {
    melee_triggers[i] setvisibletoall();
    if(!(isdefined(level._allow_melee_weapon_switching) && level._allow_melee_weapon_switching)) {
      for (j = 0; j < players.size; j++) {
        if(!players[j] player_can_see_weapon_prompt()) {
          melee_triggers[i] setinvisibletoplayer(players[j]);
        }
      }
    }
  }
}

function trigger_hide_all() {
  for (i = 0; i < level._melee_weapons.size; i++) {
    self trigger_hide(level._melee_weapons[i].wallbuy_targetname);
  }
}

function trigger_hide(wallbuy_targetname) {
  melee_triggers = getentarray(wallbuy_targetname, "targetname");
  for (i = 0; i < melee_triggers.size; i++) {
    melee_triggers[i] setinvisibletoplayer(self);
  }
}

function has_any_ballistic_knife() {
  primaryweapons = self getweaponslistprimaries();
  for (i = 0; i < primaryweapons.size; i++) {
    if(primaryweapons[i].isballisticknife) {
      return true;
    }
  }
  return false;
}

function has_upgraded_ballistic_knife() {
  primaryweapons = self getweaponslistprimaries();
  for (i = 0; i < primaryweapons.size; i++) {
    if(primaryweapons[i].isballisticknife && zm_weapons::is_weapon_upgraded(primaryweapons[i])) {
      return true;
    }
  }
  return false;
}

function give_ballistic_knife(weapon, upgraded) {
  current_melee_weapon = self zm_utility::get_player_melee_weapon();
  if(isdefined(current_melee_weapon)) {
    if(upgraded && isdefined(level.ballistic_upgraded_weapon) && isdefined(level.ballistic_upgraded_weapon[current_melee_weapon])) {
      weapon = level.ballistic_upgraded_weapon[current_melee_weapon];
    }
    if(!upgraded && isdefined(level.ballistic_weapon) && isdefined(level.ballistic_weapon[current_melee_weapon])) {
      weapon = level.ballistic_weapon[current_melee_weapon];
    }
  }
  return weapon;
}

function change_melee_weapon(weapon, current_weapon) {
  had_fallback_weapon = self take_fallback_weapon();
  current_melee_weapon = self zm_utility::get_player_melee_weapon();
  if(current_melee_weapon != level.weaponnone && current_melee_weapon != weapon) {
    self takeweapon(current_melee_weapon);
  }
  self zm_utility::set_player_melee_weapon(weapon);
  had_ballistic = 0;
  had_ballistic_upgraded = 0;
  ballistic_was_primary = 0;
  primaryweapons = self getweaponslistprimaries();
  for (i = 0; i < primaryweapons.size; i++) {
    primary_weapon = primaryweapons[i];
    if(primary_weapon.isballisticknife) {
      had_ballistic = 1;
      if(primary_weapon == current_weapon) {
        ballistic_was_primary = 1;
      }
      self notify("zmb_lost_knife");
      self takeweapon(primary_weapon);
      if(zm_weapons::is_weapon_upgraded(primary_weapon)) {
        had_ballistic_upgraded = 1;
      }
    }
  }
  if(had_ballistic) {
    if(had_ballistic_upgraded) {
      new_ballistic = level.ballistic_upgraded_weapon[weapon];
      if(ballistic_was_primary) {
        current_weapon = new_ballistic;
      }
      self zm_weapons::give_build_kit_weapon(new_ballistic);
    } else {
      new_ballistic = level.ballistic_weapon[weapon];
      if(ballistic_was_primary) {
        current_weapon = new_ballistic;
      }
      self giveweapon(new_ballistic, 0);
    }
  }
  if(had_fallback_weapon) {
    self give_fallback_weapon();
  }
  return current_weapon;
}

function melee_weapon_think(weapon, cost, flourish_fn, vo_dialog_id, flourish_weapon, ballistic_weapon, ballistic_upgraded_weapon) {
  self.first_time_triggered = 0;
  if(isdefined(self.stub)) {
    self endon("kill_trigger");
    if(isdefined(self.stub.first_time_triggered)) {
      self.first_time_triggered = self.stub.first_time_triggered;
    }
    weapon = self.stub.weapon;
    cost = self.stub.cost;
    flourish_fn = self.stub.flourish_fn;
    vo_dialog_id = self.stub.vo_dialog_id;
    flourish_weapon = self.stub.flourish_weapon;
    ballistic_weapon = self.stub.ballistic_weapon;
    ballistic_upgraded_weapon = self.stub.ballistic_upgraded_weapon;
    players = getplayers();
    if(!(isdefined(level._allow_melee_weapon_switching) && level._allow_melee_weapon_switching)) {
      for (i = 0; i < players.size; i++) {
        if(!players[i] player_can_see_weapon_prompt()) {
          self setinvisibletoplayer(players[i]);
        }
      }
    }
  }
  for (;;) {
    self waittill("trigger", player);
    if(!zm_utility::is_player_valid(player)) {
      player thread zm_utility::ignore_triggers(0.5);
      continue;
    }
    if(player zm_utility::in_revive_trigger()) {
      wait(0.1);
      continue;
    }
    if(player isthrowinggrenade()) {
      wait(0.1);
      continue;
    }
    if(player.is_drinking > 0) {
      wait(0.1);
      continue;
    }
    player_has_weapon = player hasweapon(weapon);
    if(player_has_weapon || player zm_utility::has_powerup_weapon()) {
      wait(0.1);
      continue;
    }
    if(player isswitchingweapons()) {
      wait(0.1);
      continue;
    }
    current_weapon = player getcurrentweapon();
    if(zm_utility::is_placeable_mine(current_weapon) || zm_equipment::is_equipment(current_weapon)) {
      wait(0.1);
      continue;
    }
    if(player laststand::player_is_in_laststand() || (isdefined(player.intermission) && player.intermission)) {
      wait(0.1);
      continue;
    }
    if(isdefined(player.check_override_melee_wallbuy_purchase)) {
      if(player[[player.check_override_melee_wallbuy_purchase]](vo_dialog_id, flourish_weapon, weapon, ballistic_weapon, ballistic_upgraded_weapon, flourish_fn, self)) {
        continue;
      }
    }
    if(!player_has_weapon) {
      cost = self.stub.cost;
      if(player zm_pers_upgrades_functions::is_pers_double_points_active()) {
        cost = int(cost / 2);
      }
      if(player zm_score::can_player_purchase(cost)) {
        if(self.first_time_triggered == 0) {
          model = getent(self.target, "targetname");
          if(isdefined(model)) {
            model thread melee_weapon_show(player);
          } else if(isdefined(self.clientfieldname)) {
            level clientfield::set(self.clientfieldname, 1);
          }
          self.first_time_triggered = 1;
          if(isdefined(self.stub)) {
            self.stub.first_time_triggered = 1;
          }
        }
        player zm_score::minus_to_player_score(cost);
        player thread give_melee_weapon(vo_dialog_id, flourish_weapon, weapon, ballistic_weapon, ballistic_upgraded_weapon, flourish_fn, self);
      } else {
        zm_utility::play_sound_on_ent("no_purchase");
        player zm_audio::create_and_play_dialog("general", "outofmoney", 1);
      }
      continue;
    }
    if(!(isdefined(level._allow_melee_weapon_switching) && level._allow_melee_weapon_switching)) {
      self setinvisibletoplayer(player);
    }
  }
}

function melee_weapon_show(player) {
  player_angles = vectortoangles(player.origin - self.origin);
  player_yaw = player_angles[1];
  weapon_yaw = self.angles[1];
  yaw_diff = angleclamp180(player_yaw - weapon_yaw);
  if(yaw_diff > 0) {
    yaw = weapon_yaw - 90;
  } else {
    yaw = weapon_yaw + 90;
  }
  self.og_origin = self.origin;
  self.origin = self.origin + (anglestoforward((0, yaw, 0)) * 8);
  wait(0.05);
  self show();
  zm_utility::play_sound_at_pos("weapon_show", self.origin, self);
  time = 1;
  self moveto(self.og_origin, time);
}

function award_melee_weapon(weapon_name) {
  weapon = getweapon(weapon_name);
  melee_weapon = find_melee_weapon(weapon);
  if(isdefined(melee_weapon)) {
    self give_melee_weapon(melee_weapon.vo_dialog_id, melee_weapon.flourish_weapon, melee_weapon.weapon, melee_weapon.ballistic_weapon, melee_weapon.ballistic_upgraded_weapon, melee_weapon.flourish_fn, undefined);
  }
}

function give_melee_weapon(vo_dialog_id, flourish_weapon, weapon, ballistic_weapon, ballistic_upgraded_weapon, flourish_fn, trigger) {
  if(isdefined(flourish_fn)) {
    self thread[[flourish_fn]]();
  }
  original_weapon = self do_melee_weapon_flourish_begin(flourish_weapon);
  self zm_audio::create_and_play_dialog("weapon_pickup", vo_dialog_id);
  self util::waittill_any("fake_death", "death", "player_downed", "weapon_change_complete");
  self do_melee_weapon_flourish_end(original_weapon, flourish_weapon, weapon, ballistic_weapon, ballistic_upgraded_weapon);
  if(self laststand::player_is_in_laststand() || (isdefined(self.intermission) && self.intermission)) {
    return;
  }
  if(!(isdefined(level._allow_melee_weapon_switching) && level._allow_melee_weapon_switching)) {
    if(isdefined(trigger)) {
      trigger setinvisibletoplayer(self);
    }
    self trigger_hide_all();
  }
}

function do_melee_weapon_flourish_begin(flourish_weapon) {
  self zm_utility::increment_is_drinking();
  self zm_utility::disable_player_move_states(1);
  original_weapon = self getcurrentweapon();
  weapon = flourish_weapon;
  self zm_weapons::give_build_kit_weapon(weapon);
  self switchtoweapon(weapon);
  return original_weapon;
}

function do_melee_weapon_flourish_end(original_weapon, flourish_weapon, weapon, ballistic_weapon, ballistic_upgraded_weapon) {
  assert(!original_weapon.isperkbottle);
  assert(original_weapon != level.weaponrevivetool);
  self zm_utility::enable_player_move_states();
  if(self laststand::player_is_in_laststand() || (isdefined(self.intermission) && self.intermission)) {
    self takeweapon(weapon);
    self.lastactiveweapon = level.weaponnone;
    return;
  }
  self takeweapon(flourish_weapon);
  self zm_weapons::give_build_kit_weapon(weapon);
  original_weapon = change_melee_weapon(weapon, original_weapon);
  if(self hasweapon(level.weaponbasemelee)) {
    self takeweapon(level.weaponbasemelee);
  }
  if(self zm_utility::is_multiple_drinking()) {
    self zm_utility::decrement_is_drinking();
    return;
  }
  if(original_weapon == level.weaponbasemelee) {
    self switchtoweapon(weapon);
    self zm_utility::decrement_is_drinking();
    return;
  }
  if(original_weapon != level.weaponbasemelee && !zm_utility::is_placeable_mine(original_weapon) && !zm_equipment::is_equipment(original_weapon)) {
    self zm_weapons::switch_back_primary_weapon(original_weapon);
  } else {
    self zm_weapons::switch_back_primary_weapon();
  }
  self waittill("weapon_change_complete");
  if(!self laststand::player_is_in_laststand() && (!(isdefined(self.intermission) && self.intermission))) {
    self zm_utility::decrement_is_drinking();
  }
}