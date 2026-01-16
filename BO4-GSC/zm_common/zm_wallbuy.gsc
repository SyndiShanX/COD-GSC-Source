/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_wallbuy.gsc
***********************************************/

#include script_301f64a4090c381a;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\bb;
#include scripts\zm_common\trials\zm_trial_disable_buys;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_contracts;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_equipment;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_magicbox;
#include scripts\zm_common\zm_melee_weapon;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_wallbuy;

autoexec __init__system__() {
  system::register(#"zm_wallbuy", &__init__, &__main__, array(#"zm", #"zm_zonemgr", #"zm_unitrigger", #"zm_weapons"));
}

__init__() {
  if(!zm_custom::function_901b751c(#"zmwallbuysenabled")) {
    a_outlines = getEntArray("wallbuy_outline", "targetname");

    foreach(e_outline in a_outlines) {
      e_outline delete();
    }

    return;
  }

  clientfield::register("scriptmover", "wallbuy_ambient_fx", 1, 1, "int");
  clientfield::register("scriptmover", "wallbuy_reveal_fx", 1, 1, "int");
}

__main__() {
  if(!getgametypesetting(#"zmwallbuysenabled")) {
    return;
  }

  thread init_spawnable_weapon_upgrade();
  thread init_weapon_upgrade();
}

init_weapon_upgrade() {
  weapon_spawns = [];
  weapon_spawns = getEntArray("weapon_upgrade", "targetname");

  for(i = 0; i < weapon_spawns.size; i++) {
    weapon_spawns[i].weapon = getweapon(weapon_spawns[i].zombie_weapon_upgrade);
    hint_string = zm_weapons::get_weapon_hint(weapon_spawns[i].weapon);
    cost = zm_weapons::get_weapon_cost(weapon_spawns[i].weapon);
    weapon_spawns[i] sethintstring(hint_string);
    weapon_spawns[i] setcursorhint("HINT_NOICON");
    weapon_spawns[i] usetriggerrequirelookat();
    weapon_spawns[i] thread weapon_spawn_think();
    model = getent(weapon_spawns[i].target, "targetname");

    if(isDefined(model)) {
      model useweaponhidetags(weapon_spawns[i].weapon);
      model hide();
    }
  }
}

init_spawnable_weapon_upgrade() {
  spawn_list = [];
  spawnable_weapon_spawns = struct::get_array("weapon_upgrade", "targetname");
  spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("bowie_upgrade", "targetname"), 1, 0);
  spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("sickle_upgrade", "targetname"), 1, 0);
  spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("tazer_upgrade", "targetname"), 1, 0);
  spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("buildable_wallbuy", "targetname"), 1, 0);

  if(isDefined(level.use_autofill_wallbuy) && level.use_autofill_wallbuy) {
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, level.active_autofill_wallbuys, 1, 0);
  }

  if(!(isDefined(level.headshots_only) && level.headshots_only)) {
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("claymore_purchase", "targetname"), 1, 0);
  }

  location = level.scr_zm_map_start_location;

  if((location == "default" || location == "") && isDefined(level.default_start_location)) {
    location = level.default_start_location;
  }

  match_string = level.scr_zm_ui_gametype;

  if("" != location) {
    match_string = match_string + "_" + location;
  }

  match_string_plus_space = " " + match_string;

  for(i = 0; i < spawnable_weapon_spawns.size; i++) {
    spawnable_weapon = spawnable_weapon_spawns[i];
    spawnable_weapon.weapon = getweapon(spawnable_weapon.zombie_weapon_upgrade);
    weapon_group = zm_utility::getweaponclasszm(spawnable_weapon.weapon);

    if(weapon_group == #"weapon_pistol" && !zm_custom::function_901b751c(#"zmweaponspistol") || weapon_group == #"weapon_cqb" && !zm_custom::function_901b751c(#"zmweaponsshotgun") || weapon_group == #"weapon_smg" && !zm_custom::function_901b751c(#"zmweaponssmg") || weapon_group == #"weapon_assault" && !zm_custom::function_901b751c(#"zmweaponsar") || weapon_group == #"weapon_tactical" && !zm_custom::function_901b751c(#"zmweaponstr") || weapon_group == #"weapon_lmg" && !zm_custom::function_901b751c(#"zmweaponslmg") || weapon_group == #"weapon_sniper" && !zm_custom::function_901b751c(#"zmweaponssniper") || weapon_group == #"weapon_knife" && !zm_custom::function_901b751c(#"zmweaponsknife")) {
      continue;
    }

    if(isDefined(spawnable_weapon.zombie_weapon_upgrade) && spawnable_weapon.weapon.isgrenadeweapon && isDefined(level.headshots_only) && level.headshots_only) {
      continue;
    }

    if(!isDefined(spawnable_weapon.script_noteworthy) || spawnable_weapon.script_noteworthy == "") {
      spawn_list[spawn_list.size] = spawnable_weapon;
      continue;
    }

    matches = strtok(spawnable_weapon.script_noteworthy, ", ");

    for(j = 0; j < matches.size; j++) {
      if(matches[j] == match_string || matches[j] == match_string_plus_space) {
        spawn_list[spawn_list.size] = spawnable_weapon;
      }
    }
  }

  tempmodel = spawn("script_model", (0, 0, 0));

  for(i = 0; i < spawn_list.size; i++) {
    clientfieldname = spawn_list[i].zombie_weapon_upgrade + "_" + spawn_list[i].origin;
    numbits = 2;

    if(isDefined(level._wallbuy_override_num_bits)) {
      numbits = level._wallbuy_override_num_bits;
    }

    clientfield::register("world", clientfieldname, 1, numbits, "int");
    target_struct = struct::get(spawn_list[i].target, "targetname");

    if(spawn_list[i].targetname == "buildable_wallbuy") {
      bits = 4;

      if(isDefined(level.buildable_wallbuy_weapons)) {
        bits = getminbitcountfornum(level.buildable_wallbuy_weapons.size + 1);
      }

      clientfield::register("world", clientfieldname + "_idx", 1, bits, "int");
      spawn_list[i].clientfieldname = clientfieldname;
      continue;
    }

    var_f8d30499 = 50;
    var_887e6ebe = 32;
    var_b0e9dcba = 120;

    if(isDefined(level.var_a8f3193b) && level.var_a8f3193b) {
      tempmodel.origin = spawn_list[i].origin;
      tempmodel.angles = spawn_list[i].angles;
      mins = undefined;
      maxs = undefined;
      absmins = undefined;
      absmaxs = undefined;
      tempmodel setModel(target_struct.model);
      tempmodel useweaponhidetags(spawn_list[i].weapon);
      mins = tempmodel getmins();
      maxs = tempmodel getmaxs();
      absmins = tempmodel getabsmins();
      absmaxs = tempmodel getabsmaxs();
      bounds = absmaxs - absmins;
      var_887e6ebe = bounds[0] * 0.25;
      var_f8d30499 = bounds[1];
      var_b0e9dcba = bounds[2];
    }

    unitrigger_stub = zm_unitrigger::function_9267812e(var_f8d30499, var_887e6ebe, var_b0e9dcba);
    zm_unitrigger::function_47625e58(unitrigger_stub, spawn_list[i].origin - anglestoright(spawn_list[i].angles) * var_887e6ebe * 0.2, spawn_list[i].angles);
    zm_unitrigger::function_c4a5fdf5(unitrigger_stub, 1);

    if(isDefined(spawn_list[i].require_look_from) && spawn_list[i].require_look_from) {
      unitrigger_stub.require_look_from = 1;
    }

    unitrigger_stub.target = spawn_list[i].target;
    unitrigger_stub.targetname = spawn_list[i].targetname;
    zm_unitrigger::function_c9e3607c(unitrigger_stub, "HINT_WEAPON", spawn_list[i].weapon);
    zm_unitrigger::unitrigger_set_hint_string(unitrigger_stub, zm_weapons::get_weapon_hint(spawn_list[i].weapon), zm_weapons::get_weapon_cost(spawn_list[i].weapon));

    if(isDefined(spawn_list[i].require_look_from) && spawn_list[i].require_look_from) {
      unitrigger_stub.require_look_from = 1;
    }

    if(isDefined(spawn_list[i].script_string) && isDefined(int(spawn_list[i].script_string)) && int(spawn_list[i].script_string)) {
      zm_unitrigger::function_89380dda(unitrigger_stub, 0);
    } else {
      zm_unitrigger::function_89380dda(unitrigger_stub, 1);
    }

    unitrigger_stub.target = spawn_list[i].target;
    unitrigger_stub.targetname = spawn_list[i].targetname;
    unitrigger_stub.weapon = spawn_list[i].weapon;
    unitrigger_stub.clientfieldname = clientfieldname;

    if(!unitrigger_stub.weapon.ismeleeweapon && !unitrigger_stub.weapon.isgrenadeweapon) {
      zm_unitrigger::function_2547d31f(unitrigger_stub, &wall_weapon_update_prompt);
    }

    zm_unitrigger::register_static_unitrigger(unitrigger_stub, &weapon_spawn_think);
    spawn_list[i].trigger_stub = unitrigger_stub;

    if(isDefined(target_struct.target) && !(isDefined(level.var_c1013f84) && level.var_c1013f84)) {
      spawn_list[i] thread function_44840c02(target_struct.target);
    }
  }

  level._spawned_wallbuys = spawn_list;

  if(isDefined(tempmodel)) {
    tempmodel delete();
  }
}

function_44840c02(str_targetname) {
  level flag::wait_till("zones_initialized");
  var_8d0ce13b = getent(str_targetname, "targetname");
  var_8d0ce13b clientfield::set("wallbuy_ambient_fx", 1);
}

function_c970de50(trigger, parent) {
  if(isDefined(parent)) {
    trigger enablelinkto();
    trigger linkto(parent, "", self worldtolocalcoords(trigger.origin), (0, 0, 0));
  }

  trigger.weapon = getweapon(trigger.zombie_weapon_upgrade);
  trigger setcursorhint("HINT_WEAPON", trigger.weapon);
  trigger.cost = zm_weapons::get_weapon_cost(trigger.weapon);
  trigger.hint_string = zm_weapons::get_weapon_hint(trigger.weapon);
  trigger.hint_parm1 = trigger.cost;
  trigger sethintstring(trigger.hint_string);
  self.buyable_weapon = trigger;
  level._spawned_wallbuys[level._spawned_wallbuys.size] = trigger;
  weapon_model = getent(trigger.target, "targetname");

  if(isDefined(parent)) {
    weapon_model linkto(parent, "", self worldtolocalcoords(weapon_model.origin), weapon_model.angles + self.angles);
    weapon_model setmovingplatformenabled(1);
    weapon_model._linked_ent = trigger;
  }

  weapon_model show();
  weapon_model thread function_753c491c(trigger);
}

function_753c491c(trigger) {
  self.orgmodel = self.model;
  self setModel(#"wpn_t7_none_world");
  trigger waittill(#"trigger");
  self setModel(self.orgmodel);
}

add_dynamic_wallbuy(weapon, wallbuy, pristine) {
  spawned_wallbuy = undefined;

  for(i = 0; i < level._spawned_wallbuys.size; i++) {
    if(level._spawned_wallbuys[i].target == wallbuy) {
      spawned_wallbuy = level._spawned_wallbuys[i];
      break;
    }
  }

  if(!isDefined(spawned_wallbuy)) {
    assertmsg("<dev string:x38>");
    return;
  }

  if(isDefined(spawned_wallbuy.trigger_stub)) {
    assertmsg("<dev string:x56>");
    return;
  }

  target_struct = struct::get(wallbuy, "targetname");
  wallmodel = zm_utility::spawn_weapon_model(weapon, undefined, target_struct.origin, target_struct.angles, undefined);
  clientfieldname = spawned_wallbuy.clientfieldname;
  model = weapon.worldmodel;
  unitrigger_stub = spawnStruct();
  unitrigger_stub.origin = target_struct.origin;
  unitrigger_stub.angles = target_struct.angles;
  wallmodel.origin = target_struct.origin;
  wallmodel.angles = target_struct.angles;
  mins = undefined;
  maxs = undefined;
  absmins = undefined;
  absmaxs = undefined;
  wallmodel setModel(model);
  wallmodel useweaponhidetags(weapon);
  mins = wallmodel getmins();
  maxs = wallmodel getmaxs();
  absmins = wallmodel getabsmins();
  absmaxs = wallmodel getabsmaxs();
  bounds = absmaxs - absmins;
  unitrigger_stub.script_length = bounds[0] * 0.25;
  unitrigger_stub.script_width = bounds[1];
  unitrigger_stub.script_height = bounds[2];
  unitrigger_stub.origin -= anglestoright(unitrigger_stub.angles) * unitrigger_stub.script_length * 0.4;
  unitrigger_stub.target = spawned_wallbuy.target;
  unitrigger_stub.targetname = "weapon_upgrade";
  unitrigger_stub.cursor_hint = "HINT_NOICON";
  unitrigger_stub.first_time_triggered = !pristine;

  if(!weapon.ismeleeweapon) {
    if(pristine || zm_loadout::is_placeable_mine(weapon)) {
      unitrigger_stub.hint_string = zm_weapons::get_weapon_hint(weapon);
    } else {
      unitrigger_stub.hint_string = get_weapon_hint_ammo();
    }

    unitrigger_stub.cost = zm_weapons::get_weapon_cost(weapon);
  }

  unitrigger_stub.weapon = weapon;
  unitrigger_stub.weapon_upgrade = weapon;
  unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
  unitrigger_stub.require_look_at = 1;
  unitrigger_stub.clientfieldname = clientfieldname;
  zm_unitrigger::unitrigger_force_per_player_triggers(unitrigger_stub, 1);

  if(weapon.ismeleeweapon) {
    if(weapon == "tazer_knuckles" && isDefined(level.taser_trig_adjustment)) {
      unitrigger_stub.origin += level.taser_trig_adjustment;
    }

    zm_melee_weapon::add_stub(unitrigger_stub, weapon);
    zm_unitrigger::register_static_unitrigger(unitrigger_stub, &zm_melee_weapon::melee_weapon_think);
  } else {
    unitrigger_stub.prompt_and_visibility_func = &wall_weapon_update_prompt;
    zm_unitrigger::register_static_unitrigger(unitrigger_stub, &weapon_spawn_think);
  }

  spawned_wallbuy.trigger_stub = unitrigger_stub;
  weaponidx = undefined;

  if(isDefined(level.buildable_wallbuy_weapons)) {
    for(i = 0; i < level.buildable_wallbuy_weapons.size; i++) {
      if(weapon == level.buildable_wallbuy_weapons[i]) {
        weaponidx = i;
        break;
      }
    }
  }

  if(isDefined(weaponidx)) {
    level clientfield::set(clientfieldname + "_idx", weaponidx + 1);
    wallmodel delete();

    if(!pristine) {
      level clientfield::set(clientfieldname, 1);
    }

    return;
  }

  level clientfield::set(clientfieldname, 1);
  wallmodel show();
}

wall_weapon_update_prompt(player) {
  if(!isDefined(player.currentweapon)) {
    return false;
  }

  weapon = self.stub.weapon;
  player_has_weapon = player zm_weapons::has_weapon_or_upgrade(weapon);

  if(!player_has_weapon && isDefined(level.weapons_using_ammo_sharing) && level.weapons_using_ammo_sharing) {
    shared_ammo_weapon = player zm_weapons::get_shared_ammo_weapon(self.zombie_weapon_upgrade);

    if(isDefined(shared_ammo_weapon)) {
      weapon = shared_ammo_weapon;
      player_has_weapon = 1;
    }
  }

  if(isDefined(level.func_override_wallbuy_prompt)) {
    if(!self[[level.func_override_wallbuy_prompt]](player, player_has_weapon)) {
      return false;
    }
  } else if(zm_trial_disable_buys::is_active()) {
    return false;
  } else if(!player_has_weapon) {
    self.stub.cursor_hint = "HINT_WEAPON";
    cost = zm_weapons::get_weapon_cost(weapon);

    if(player function_284616f8()) {
      if(function_8b1a219a()) {
        self.stub.hint_string = #"hash_7778a99e3a7d47";
      } else {
        self.stub.hint_string = #"hash_18379e4e114fabf9";
      }

      if(self.stub.var_8d306e51) {
        self sethintstringforplayer(player, self.stub.hint_string);
      } else {
        self sethintstring(self.stub.hint_string);
      }
    } else if(player bgb::is_enabled(#"zm_bgb_wall_to_wall_clearance")) {
      if(function_8b1a219a()) {
        self.stub.hint_string = #"hash_7a24a147b8f09767";
      } else {
        self.stub.hint_string = #"hash_791fe9da17cf7059";
      }

      if(self.stub.var_8d306e51) {
        self sethintstringforplayer(player, self.stub.hint_string);
      } else {
        self sethintstring(self.stub.hint_string);
      }
    } else {
      if(function_8b1a219a()) {
        self.stub.hint_string = #"hash_2791ecebb85142c4";
      } else {
        self.stub.hint_string = #"hash_60606b68e93a29c8";
      }

      if(self.stub.var_8d306e51) {
        self sethintstringforplayer(player, self.stub.hint_string);
      } else {
        self sethintstring(self.stub.hint_string);
      }
    }
  } else {
    if(player function_284616f8()) {
      ammo_cost = player zm_weapons::get_ammo_cost_for_weapon(weapon);
    } else if(player zm_weapons::has_upgrade(weapon) && self.stub.hacked !== 1) {
      ammo_cost = zm_weapons::get_upgraded_ammo_cost(weapon);
    } else {
      ammo_cost = zm_weapons::get_ammo_cost(weapon);
    }

    var_f7b97cc4 = 0;
    w_upgrade = player zm_weapons::get_upgrade_weapon(weapon, 1);

    if(player zm_utility::function_aa45670f(weapon, 0) || player zm_utility::function_aa45670f(w_upgrade, 0)) {
      if(isDefined(player.var_4a06bcd2)) {
        special_ammo_cost = player[[player.var_4a06bcd2]](weapon, self.stub, 1);

        if(isDefined(special_ammo_cost)) {
          ammo_cost = special_ammo_cost;
        }
      }

      if(player zm_weapons::has_weapon_or_upgrade(weapon)) {
        var_f7b97cc4 = 1;

        if(function_8b1a219a()) {
          self.stub.hint_string = #"hash_4fc4a485b05c45ba";
        } else {
          self.stub.hint_string = #"hash_229abc68467e92ce";
        }

        if(self.stub.var_8d306e51) {
          self sethintstringforplayer(player, self.stub.hint_string, ammo_cost);
        } else {
          self sethintstring(self.stub.hint_string, ammo_cost);
        }
      }
    }

    if(player function_284616f8()) {
      if(isDefined(self.stub.hacked) && self.stub.hacked) {
        self.stub.hint_string = #"zombie_weaponammohacked_cfill_bgb_secret_shopper";
      } else if(function_8b1a219a()) {
        self.stub.hint_string = #"hash_1299ea66da4a06b0";
      } else {
        self.stub.hint_string = #"hash_4a6901dda0793d3c";
      }

      if(self.stub.var_8d306e51) {
        self sethintstringforplayer(player, self.stub.hint_string);
      } else {
        self sethintstring(self.stub.hint_string);
      }
    } else if(player bgb::is_enabled(#"zm_bgb_wall_to_wall_clearance")) {
      if(player zm_weapons::has_upgrade(weapon)) {
        if(function_8b1a219a()) {
          self.stub.hint_string = #"hash_5897b2e20dc09cfc";
        } else {
          self.stub.hint_string = #"hash_7d4f06d135499350";
        }
      } else if(function_8b1a219a()) {
        self.stub.hint_string = #"hash_cb6a56ab3b14604";
      } else {
        self.stub.hint_string = #"hash_43ab0adee9d55608";
      }

      if(self.stub.var_8d306e51) {
        self sethintstringforplayer(player, self.stub.hint_string);
      } else {
        self sethintstring(self.stub.hint_string);
      }
    } else if(!var_f7b97cc4) {
      if(isDefined(self.stub.hacked) && self.stub.hacked) {
        self.stub.hint_string = #"zombie_weaponammohacked_cfill";
      } else if(function_8b1a219a()) {
        self.stub.hint_string = #"hash_3f279e3e0f564e99";
      } else {
        self.stub.hint_string = #"hash_382490a598f64833";
      }

      if(self.stub.var_8d306e51) {
        self sethintstringforplayer(player, self.stub.hint_string);
      } else {
        self sethintstring(self.stub.hint_string);
      }
    }
  }

  self.stub.cursor_hint = "HINT_WEAPON";
  self.stub.cursor_hint_weapon = weapon;
  self setcursorhint(self.stub.cursor_hint, self.stub.cursor_hint_weapon);
  return true;
}

reset_wallbuy_internal(set_hint_string) {
  if(isDefined(self.first_time_triggered) && self.first_time_triggered) {
    self.first_time_triggered = 0;

    if(isDefined(self.clientfieldname)) {
      level clientfield::set(self.clientfieldname, 0);
    }

    if(set_hint_string) {
      hint_string = zm_weapons::get_weapon_hint(self.weapon);
      cost = zm_weapons::get_weapon_cost(self.weapon);
      self sethintstring(hint_string);
    }
  }
}

reset_wallbuys() {
  weapon_spawns = [];
  weapon_spawns = getEntArray("weapon_upgrade", "targetname");
  melee_and_grenade_spawns = [];
  melee_and_grenade_spawns = getEntArray("bowie_upgrade", "targetname");
  melee_and_grenade_spawns = arraycombine(melee_and_grenade_spawns, getEntArray("sickle_upgrade", "targetname"), 1, 0);
  melee_and_grenade_spawns = arraycombine(melee_and_grenade_spawns, getEntArray("tazer_upgrade", "targetname"), 1, 0);

  if(!(isDefined(level.headshots_only) && level.headshots_only)) {
    melee_and_grenade_spawns = arraycombine(melee_and_grenade_spawns, getEntArray("claymore_purchase", "targetname"), 1, 0);
  }

  for(i = 0; i < weapon_spawns.size; i++) {
    weapon_spawns[i].weapon = getweapon(weapon_spawns[i].zombie_weapon_upgrade);
    weapon_spawns[i] reset_wallbuy_internal(1);
  }

  for(i = 0; i < melee_and_grenade_spawns.size; i++) {
    melee_and_grenade_spawns[i].weapon = getweapon(melee_and_grenade_spawns[i].zombie_weapon_upgrade);
    melee_and_grenade_spawns[i] reset_wallbuy_internal(0);
  }

  if(isDefined(level._unitriggers)) {
    candidates = [];

    for(i = 0; i < level._unitriggers.trigger_stubs.size; i++) {
      stub = level._unitriggers.trigger_stubs[i];
      tn = stub.targetname;

      if(tn == "weapon_upgrade" || tn == "bowie_upgrade" || tn == "sickle_upgrade" || tn == "tazer_upgrade" || tn == "claymore_purchase") {
        stub.first_time_triggered = 0;

        if(isDefined(stub.clientfieldname)) {
          level clientfield::set(stub.clientfieldname, 0);
        }

        if(tn == "weapon_upgrade") {
          stub.hint_string = zm_weapons::get_weapon_hint(stub.weapon);
          stub.cost = zm_weapons::get_weapon_cost(stub.weapon);
        }
      }
    }
  }
}

get_weapon_hint_ammo() {
  if(function_8b1a219a()) {
    return #"hash_2791ecebb85142c4";
  }

  return #"hash_60606b68e93a29c8";
}

weapon_set_first_time_hint(cost, ammo_cost) {
  self sethintstring(get_weapon_hint_ammo());
}

placeable_mine_can_buy_weapon_extra_check_func(w_weapon) {
  if(isDefined(w_weapon) && w_weapon == self zm_loadout::get_player_placeable_mine()) {
    return false;
  }

  return true;
}

weapon_spawn_think() {
  cost = zm_weapons::get_weapon_cost(self.weapon);
  ammo_cost = zm_weapons::get_ammo_cost(self.weapon);
  is_grenade = self.weapon.isgrenadeweapon;
  shared_ammo_weapon = undefined;

  if(isDefined(self.parent_player) && !is_grenade) {
    self.parent_player notify(#"zm_bgb_secret_shopper", {
      #trigger: self
    });
  }

  second_endon = undefined;

  if(isDefined(self.stub)) {
    second_endon = "kill_trigger";
    self.first_time_triggered = self.stub.first_time_triggered;
  }

  onlyplayer = undefined;
  can_buy_weapon_extra_check_func = undefined;

  if(isDefined(self.stub) && isDefined(self.stub.trigger_per_player) && self.stub.trigger_per_player) {
    onlyplayer = self.parent_player;

    if(zm_loadout::is_placeable_mine(self.weapon)) {
      can_buy_weapon_extra_check_func = &placeable_mine_can_buy_weapon_extra_check_func;
    }
  }

  self thread zm_magicbox::decide_hide_show_hint("stop_hint_logic", second_endon, onlyplayer, can_buy_weapon_extra_check_func, 0);

  if(is_grenade || zm_loadout::is_melee_weapon(self.weapon)) {
    self.first_time_triggered = 0;
    hint = zm_weapons::get_weapon_hint(self.weapon);
    self sethintstring(hint);
    cursor_hint = "HINT_WEAPON";
    cursor_hint_weapon = self.weapon;
    self setcursorhint(cursor_hint, cursor_hint_weapon);
  } else if(!isDefined(self.first_time_triggered)) {
    self.first_time_triggered = 0;

    if(isDefined(self.stub)) {
      self.stub.first_time_triggered = 0;
    }
  }

  for(;;) {
    waitresult = self waittill(#"trigger");
    player = waitresult.activator;

    if(!zm_utility::is_player_valid(player)) {
      player thread zm_utility::ignore_triggers(0.5);
      continue;
    }

    if(!player zm_magicbox::can_buy_weapon(0)) {
      wait 0.1;
      continue;
    }

    if(isDefined(self.stub) && isDefined(self.stub.require_look_from) && self.stub.require_look_from) {
      toplayer = player util::get_eye() - self.origin;
      forward = -1 * anglestoright(self.angles);
      dot = vectordot(toplayer, forward);

      if(dot < 0) {
        continue;
      }
    }

    if(player zm_loadout::has_powerup_weapon()) {
      wait 0.1;
      continue;
    }

    if(zm_trial_disable_buys::is_active()) {
      wait 0.1;
      continue;
    }

    player_has_weapon = player zm_weapons::has_weapon_or_upgrade(self.weapon);

    if(!player_has_weapon && isDefined(level.weapons_using_ammo_sharing) && level.weapons_using_ammo_sharing) {
      shared_ammo_weapon = player zm_weapons::get_shared_ammo_weapon(self.weapon);

      if(isDefined(shared_ammo_weapon)) {
        player_has_weapon = 1;
      }
    }

    cost = zm_weapons::get_weapon_cost(self.weapon);

    if(isDefined(player.var_44b2ea64)) {
      foreach(func_override in player.var_44b2ea64) {
        n_cost = player[[func_override]](self.weapon, self);

        if(isDefined(n_cost)) {
          if(n_cost < cost) {
            cost = n_cost;
          }
        }
      }
    }

    if(isDefined(player.check_override_wallbuy_purchase)) {
      if(player[[player.check_override_wallbuy_purchase]](self.weapon, self)) {
        continue;
      }
    }

    if(!player_has_weapon) {
      if(zm_utility::function_e05ac4ad(player, cost)) {
        if(self.first_time_triggered == 0) {
          self show_all_weapon_buys(player, cost, ammo_cost, is_grenade);
        }

        player zm_score::minus_to_player_score(cost);

        if(isDefined(level.var_db463b5)) {
          self[[level.var_db463b5]](player);
        }

        level notify(#"weapon_bought", {
          #player: player, 
          #weapon: self.weapon
        });
        player zm_stats::increment_challenge_stat(#"survivalist_buy_wallbuy", undefined, 1);
        player zm_stats::increment_challenge_stat(#"hash_385398b8acbf8b4a", undefined, 1);
        player zm_stats::increment_challenge_stat(#"hash_702d98df99af63d5", undefined, 1);
        player zm_stats::function_c0c6ab19(#"weapons_bought", 1, 1);
        player zm_stats::function_c0c6ab19(#"wallbuys", 1, 1);
        player contracts::increment_zm_contract(#"contract_zm_weapons_bought", 1, #"zstandard");
        player contracts::increment_zm_contract(#"contract_zm_wallbuys", 1, #"zstandard");

        if(self.weapon.isriotshield) {
          player zm_equipment::give(self.weapon);

          if(isDefined(player.player_shield_reset_health)) {
            player[[player.player_shield_reset_health]](self.weapon);
          }
        } else {
          if(zm_loadout::is_lethal_grenade(self.weapon)) {
            player zm_weapons::weapon_take(player zm_loadout::get_player_lethal_grenade());
            player zm_loadout::set_player_lethal_grenade(self.weapon);
          }

          weapon = self.weapon;

          if(should_upgrade_weapon(player)) {
            if(player zm_weapons::can_upgrade_weapon(weapon)) {
              weapon = zm_weapons::get_upgrade_weapon(weapon);
              player notify(#"zm_bgb_wall_power_used");
            }
          }

          weapon = player zm_weapons::weapon_give(weapon);
        }

        if(isDefined(weapon)) {
          player notify(#"weapon_purchased", {
            #weapon: weapon
          });
          player zm_stats::increment_client_stat("wallbuy_weapons_purchased");
          player zm_stats::increment_player_stat("wallbuy_weapons_purchased");
          player zm_stats::forced_attachment("boas_wallbuy_weapons_purchased");
          bb::logpurchaseevent(player, self, cost, weapon.name, player zm_weapons::has_upgrade(weapon), "_weapon", "_purchase");
          weaponindex = undefined;

          if(isDefined(weaponindex)) {
            weaponindex = matchrecordgetweaponindex(weapon);
          }

          if(isDefined(weaponindex)) {
            player recordmapevent(6, gettime(), player.origin, level.round_number, weaponindex, cost);
          }
        }
      } else {
        zm_utility::play_sound_on_ent("no_purchase");
        player zm_audio::create_and_play_dialog(#"general", #"outofmoney");
      }
    } else {
      weapon = self.weapon;

      if(isDefined(shared_ammo_weapon)) {
        weapon = shared_ammo_weapon;
      }

      var_47834995 = player zm_weapons::has_upgrade(weapon);

      if(isDefined(self.stub) && isDefined(self.stub.hacked) && self.stub.hacked) {
        if(!var_47834995) {
          ammo_cost = 4500;
        } else {
          ammo_cost = zm_weapons::get_ammo_cost(weapon);
        }
      } else if(var_47834995) {
        ammo_cost = 4500;
      } else {
        ammo_cost = zm_weapons::get_ammo_cost(weapon);
      }

      if(isDefined(player.var_4a06bcd2)) {
        n_cost = player[[player.var_4a06bcd2]](weapon, self);

        if(isDefined(n_cost)) {
          ammo_cost = n_cost;
        }
      }

      if(player function_284616f8(1)) {
        ammo_cost = player zm_weapons::get_ammo_cost_for_weapon(weapon);
      }

      if(isDefined(player.var_6d2d0163)) {
        foreach(func_override in player.var_6d2d0163) {
          n_cost = player[[func_override]](weapon, self);

          if(isDefined(n_cost)) {
            if(n_cost < ammo_cost) {
              ammo_cost = n_cost;
            }
          }
        }
      }

      if(weapon.isriotshield) {
        zm_utility::play_sound_on_ent("no_purchase");
      } else if(zm_utility::function_e05ac4ad(player, ammo_cost)) {
        if(var_47834995) {
          ammo_given = player zm_weapons::ammo_give(level.zombie_weapons[weapon].upgrade);
        } else {
          ammo_given = player zm_weapons::ammo_give(weapon);
        }

        if(ammo_given) {
          if(self.first_time_triggered == 0) {
            self show_all_weapon_buys(player, cost, ammo_cost, is_grenade);
          }

          if(var_47834995) {
            player zm_stats::increment_client_stat("upgraded_ammo_purchased");
            player zm_stats::increment_player_stat("upgraded_ammo_purchased");
            player namespace_e38c57c1::function_183814d3();
          } else {
            player zm_stats::increment_client_stat("ammo_purchased");
            player zm_stats::increment_player_stat("ammo_purchased");
            player zm_stats::forced_attachment("boas_ammo_purchased");
          }

          player contracts::increment_zm_contract(#"contract_zm_wallbuys", 1, #"zstandard");
          player thread zm_audio::create_and_play_dialog(#"ammo", #"buy");
          player zm_score::minus_to_player_score(ammo_cost);

          if(isDefined(level.var_db463b5)) {
            self[[level.var_db463b5]](player);
          }

          bb::logpurchaseevent(player, self, ammo_cost, weapon.name, var_47834995, "_ammo", "_purchase");
          weaponindex = undefined;

          if(isDefined(weapon)) {
            weaponindex = matchrecordgetweaponindex(weapon);
          }

          if(isDefined(weaponindex)) {
            player recordmapevent(7, gettime(), player.origin, level.round_number, weaponindex, cost);
          }

          wait 1;
        }
      } else {
        zm_utility::play_sound_on_ent("no_purchase");

        if(isDefined(level.custom_generic_deny_vo_func)) {
          player[[level.custom_generic_deny_vo_func]]();
        } else {
          player zm_audio::create_and_play_dialog(#"general", #"outofmoney");
        }
      }
    }

    if(isDefined(player)) {
      player notify(#"wallbuy_done");

      if(isDefined(self.stub) && isDefined(self.stub.prompt_and_visibility_func)) {
        self[[self.stub.prompt_and_visibility_func]](player);
      }
    }
  }
}

should_upgrade_weapon(player) {
  if(isDefined(level.var_f270168a)) {
    return [[level.var_f270168a]]();
  }

  if(player bgb::is_enabled(#"zm_bgb_wall_power")) {
    return 1;
  }

  return 0;
}

show_all_weapon_buys(player, cost, ammo_cost, is_grenade) {
  model = getent(self.target, "targetname");
  is_melee = zm_loadout::is_melee_weapon(self.weapon);

  if(isDefined(model)) {
    model thread weapon_show(player);
  } else if(isDefined(self.clientfieldname)) {
    level clientfield::set(self.clientfieldname, 1);
  }

  if(zm_utility::get_story() != 1 && !isDefined(model)) {
    var_6ff4b667 = struct::get(self.target, "targetname");

    if(isDefined(var_6ff4b667) && isDefined(var_6ff4b667.target)) {
      var_8d0ce13b = getent(var_6ff4b667.target, "targetname");
      var_8d0ce13b clientfield::set("wallbuy_reveal_fx", 1);
      var_8d0ce13b clientfield::set("wallbuy_ambient_fx", 0);
    }
  }

  self.first_time_triggered = 1;

  if(isDefined(self.stub)) {
    self.stub.first_time_triggered = 1;
  }

  if(!is_grenade && !is_melee) {
    self weapon_set_first_time_hint(cost, ammo_cost);
  }

  if(!(isDefined(level.dont_link_common_wallbuys) && level.dont_link_common_wallbuys) && isDefined(level._spawned_wallbuys)) {
    for(i = 0; i < level._spawned_wallbuys.size; i++) {
      wallbuy = level._spawned_wallbuys[i];

      if(isDefined(self.stub) && isDefined(wallbuy.trigger_stub) && self.stub.clientfieldname == wallbuy.trigger_stub.clientfieldname) {
        continue;
      }

      if(self.weapon == wallbuy.weapon) {
        if(isDefined(wallbuy.trigger_stub) && isDefined(wallbuy.trigger_stub.clientfieldname)) {
          level clientfield::set(wallbuy.trigger_stub.clientfieldname, 1);
          var_6ff4b667 = struct::get(wallbuy.target, "targetname");

          if(isDefined(var_6ff4b667) && isDefined(var_6ff4b667.target)) {
            var_8d0ce13b = getent(var_6ff4b667.target, "targetname");
            var_8d0ce13b clientfield::set("wallbuy_ambient_fx", 0);
          }
        } else if(isDefined(wallbuy.target)) {
          model = getent(wallbuy.target, "targetname");

          if(isDefined(model)) {
            model thread weapon_show(player);
          }
        }

        if(isDefined(wallbuy.trigger_stub)) {
          wallbuy.trigger_stub.first_time_triggered = 1;

          if(isDefined(wallbuy.trigger_stub.trigger)) {
            wallbuy.trigger_stub.trigger.first_time_triggered = 1;

            if(!is_grenade && !is_melee) {
              wallbuy.trigger_stub.trigger weapon_set_first_time_hint(cost, ammo_cost);
            }
          }

          continue;
        }

        if(!is_grenade && !is_melee) {
          wallbuy weapon_set_first_time_hint(cost, ammo_cost);
        }
      }
    }
  }
}

weapon_show(player) {
  player_angles = vectortoangles(player.origin - self.origin);
  player_yaw = player_angles[1];
  weapon_yaw = self.angles[1];

  if(isDefined(self.script_int)) {
    weapon_yaw -= self.script_int;
  }

  yaw_diff = angleclamp180(player_yaw - weapon_yaw);

  if(yaw_diff > 0) {
    yaw = weapon_yaw - 90;
  } else {
    yaw = weapon_yaw + 90;
  }

  self.og_origin = self.origin;
  self.origin += anglesToForward((0, yaw, 0)) * 8;
  waitframe(1);
  self show();
  zm_utility::play_sound_at_pos("weapon_show", self.origin, self);
  time = 1;

  if(!isDefined(self._linked_ent)) {
    self moveto(self.og_origin, time);
  }
}

is_wallbuy(w_to_check) {
  w_base = zm_weapons::get_base_weapon(w_to_check);

  foreach(s_wallbuy in level._spawned_wallbuys) {
    if(s_wallbuy.weapon == w_base) {
      return true;
    }
  }

  return false;
}

function_c047c228(func_override) {
  if(!isDefined(self.var_44b2ea64)) {
    self.var_44b2ea64 = [];
  }

  if(!isDefined(self.var_44b2ea64)) {
    self.var_44b2ea64 = [];
  } else if(!isarray(self.var_44b2ea64)) {
    self.var_44b2ea64 = array(self.var_44b2ea64);
  }

  if(!isinarray(self.var_44b2ea64, func_override)) {
    self.var_44b2ea64[self.var_44b2ea64.size] = func_override;
  }
}

function_a6889c(func_override) {
  arrayremovevalue(self.var_44b2ea64, func_override);
}

function_48f914bd(func_override) {
  if(!isDefined(self.var_6d2d0163)) {
    self.var_6d2d0163 = [];
  }

  if(!isDefined(self.var_6d2d0163)) {
    self.var_6d2d0163 = [];
  } else if(!isarray(self.var_6d2d0163)) {
    self.var_6d2d0163 = array(self.var_6d2d0163);
  }

  if(!isinarray(self.var_6d2d0163, func_override)) {
    self.var_6d2d0163[self.var_6d2d0163.size] = func_override;
  }
}

function_99911dae(func_override) {
  arrayremovevalue(self.var_6d2d0163, func_override);
}

function_33023da5(func_override) {
  if(!isDefined(self.var_dc25727a)) {
    self.var_dc25727a = [];
  }

  if(!isDefined(self.var_dc25727a)) {
    self.var_dc25727a = [];
  } else if(!isarray(self.var_dc25727a)) {
    self.var_dc25727a = array(self.var_dc25727a);
  }

  if(!isinarray(self.var_dc25727a, func_override)) {
    self.var_dc25727a[self.var_dc25727a.size] = func_override;
  }
}

function_782e8955(func_override) {
  arrayremovevalue(self.var_dc25727a, func_override);
}

function_284616f8(var_8f48d608 = 0) {
  if(var_8f48d608) {
    if(self bgb::is_enabled(#"zm_bgb_secret_shopper") && !(isDefined(self.currentweapon.ammoregen) && self.currentweapon.ammoregen) && self.currentweapon.type !== "melee") {
      return true;
    }
  } else if(self bgb::is_enabled(#"zm_bgb_secret_shopper") && !(isDefined(self.currentweapon.ammoregen) && self.currentweapon.ammoregen)) {
    return true;
  }

  return false;
}