/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_rocketshield.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weap_riotshield;
#using scripts\zm\_zm_weapons;
#using scripts\zm\craftables\_zm_craft_shield;
#namespace rocketshield;

function autoexec __init__sytem__() {
  system::register("zm_weap_rocketshield", &__init__, &__main__, undefined);
}

function __init__() {
  zm_craft_shield::init("craft_shield_zm", "zod_riotshield", "wpn_t7_zmb_zod_rocket_shield_world");
  clientfield::register("allplayers", "rs_ammo", 1, 1, "int");
  callback::on_connect(&on_player_connect);
  callback::on_spawned(&on_player_spawned);
  level.weaponriotshield = getweapon("zod_riotshield");
  zm_equipment::register("zod_riotshield", &"ZOMBIE_EQUIP_RIOTSHIELD_PICKUP_HINT_STRING", &"ZOMBIE_EQUIP_RIOTSHIELD_HOWTO", undefined, "riotshield");
  level.weaponriotshieldupgraded = getweapon("zod_riotshield_upgraded");
  zm_equipment::register("zod_riotshield_upgraded", &"ZOMBIE_EQUIP_RIOTSHIELD_PICKUP_HINT_STRING", &"ZOMBIE_EQUIP_RIOTSHIELD_HOWTO", undefined, "riotshield");
}

function __main__() {
  zm_equipment::register_for_level("zod_riotshield");
  zm_equipment::include("zod_riotshield");
  zm_equipment::set_ammo_driven("zod_riotshield", level.weaponriotshield.startammo, 1);
  zm_equipment::register_for_level("zod_riotshield_upgraded");
  zm_equipment::include("zod_riotshield_upgraded");
  zm_equipment::set_ammo_driven("zod_riotshield_upgraded", level.weaponriotshieldupgraded.startammo, 1);
  setdvar("juke_enabled", 1);
  zombie_utility::set_zombie_var("riotshield_fling_damage_shield", 100);
  zombie_utility::set_zombie_var("riotshield_knockdown_damage_shield", 15);
  zombie_utility::set_zombie_var("riotshield_juke_damage_shield", 0);
  zombie_utility::set_zombie_var("riotshield_fling_force_juke", 175);
  zombie_utility::set_zombie_var("riotshield_fling_range", 120);
  zombie_utility::set_zombie_var("riotshield_gib_range", 120);
  zombie_utility::set_zombie_var("riotshield_knockdown_range", 120);
  level thread spawn_recharge_tanks();
  level.riotshield_damage_callback = &player_damage_rocketshield;
  level thread function_3f94d6cf();
}

function on_player_connect() {
  self thread watchfirstuse();
}

function watchfirstuse() {
  self endon("disconnect");
  while(isDefined(self)) {
    self waittill("weapon_change", newweapon);
    if(newweapon.isriotshield) {
      break;
    }
  }
  self.rocket_shield_hint_shown = 1;
  zm_equipment::show_hint_text(&"ZM_ZOD_ROCKET_HINT", 5);
}

function on_player_spawned() {
  self.player_shield_apply_damage = &player_damage_rocketshield;
  self thread player_watch_shield_juke();
  self thread player_watch_ammo_change();
  self thread player_watch_max_ammo();
  self thread player_watch_upgraded_pickup_from_table();
}

function player_watch_ammo_change() {
  self notify("player_watch_ammo_change");
  self endon("player_watch_ammo_change");
  for(;;) {
    self waittill("equipment_ammo_changed", equipment);
    if(isstring(equipment)) {
      equipment = getweapon(equipment);
    }
    if(equipment == getweapon("zod_riotshield") || equipment == getweapon("zod_riotshield_upgraded")) {
      self thread check_weapon_ammo(equipment);
    }
  }
}

function player_watch_max_ammo() {
  self notify("player_watch_max_ammo");
  self endon("player_watch_max_ammo");
  for(;;) {
    self waittill("zmb_max_ammo");
    wait(0.05);
    if(isDefined(self.hasriotshield) && self.hasriotshield) {
      self thread check_weapon_ammo(self.weaponriotshield);
    }
  }
}

function check_weapon_ammo(weapon) {
  wait(0.05);
  if(isDefined(self)) {
    ammo = self getweaponammoclip(weapon);
    self clientfield::set("rs_ammo", ammo);
  }
}

function player_watch_upgraded_pickup_from_table() {
  self notify("player_watch_upgraded_pickup_from_table");
  self endon("player_watch_upgraded_pickup_from_table");
  var_4e7bbc60 = level.weaponriotshield.name;
  str_notify = var_4e7bbc60 + "_pickup_from_table";
  for(;;) {
    self waittill(str_notify);
    if(isDefined(self.b_has_upgraded_shield) && self.b_has_upgraded_shield) {
      self zm_equipment::buy("zod_riotshield_upgraded");
    }
  }
}

function player_damage_rocketshield(idamage, bheld, fromcode = 0, smod = "MOD_UNKNOWN") {
  shielddamage = idamage;
  if(smod === "MOD_EXPLOSIVE") {
    shielddamage = shielddamage + (idamage * 2);
  }
  self riotshield::player_damage_shield(shielddamage, bheld, fromcode, smod);
}

function player_watch_shield_juke() {
  self notify("player_watch_shield_juke");
  self endon("player_watch_shield_juke");
  for(;;) {
    self waittill("weapon_melee_juke", weapon);
    if(weapon.isriotshield) {
      self disableoffhandweapons();
      self playSound("zmb_rocketshield_start");
      self riotshield_melee_juke(weapon);
      self playSound("zmb_rocketshield_end");
      self enableoffhandweapons();
      self thread check_weapon_ammo(weapon);
      self notify("shield_juke_done");
    }
  }
}

function riotshield_melee_juke(weapon) {
  self endon("weapon_melee");
  self endon("weapon_melee_power");
  self endon("weapon_melee_charge");
  start_time = gettime();
  if(!isDefined(level.riotshield_knockdown_enemies)) {
    level.riotshield_knockdown_enemies = [];
  }
  if(!isDefined(level.riotshield_knockdown_gib)) {
    level.riotshield_knockdown_gib = [];
  }
  if(!isDefined(level.riotshield_fling_enemies)) {
    level.riotshield_fling_enemies = [];
  }
  if(!isDefined(level.riotshield_fling_vecs)) {
    level.riotshield_fling_vecs = [];
  }
  while((start_time + 3000) > gettime()) {
    self playrumbleonentity("zod_shield_juke");
    forward = anglesToForward(self getplayerangles());
    shield_damage = 0;
    enemies = riotshield_get_juke_enemies_in_range();
    if(isDefined(level.riotshield_melee_juke_callback) && isfunctionptr(level.riotshield_melee_juke_callback)) {
      [
        [level.riotshield_melee_juke_callback]
      ](enemies);
    }
    foreach(zombie in enemies) {
      self playSound("zmb_rocketshield_imp");
      zombie thread riotshield::riotshield_fling_zombie(self, zombie.fling_vec, 0);
      shield_damage = shield_damage + level.zombie_vars["riotshield_juke_damage_shield"];
    }
    if(shield_damage) {
      self riotshield::player_damage_shield(shield_damage, 0);
    }
    level.riotshield_knockdown_enemies = [];
    level.riotshield_knockdown_gib = [];
    level.riotshield_fling_enemies = [];
    level.riotshield_fling_vecs = [];
    wait(0.1);
  }
}

function function_92debe0a() {
  level waittill("start_of_round");
  foreach(player in getplayers()) {}
  while(true) {
    level waittill("start_of_round");
    foreach(player in getplayers()) {
      if(isDefined(player.hasriotshield) && player.hasriotshield) {
        player givestartammo(player.weaponriotshield);
      }
    }
  }
}

function riotshield_get_juke_enemies_in_range() {
  view_pos = self.origin;
  zombies = array::get_all_closest(view_pos, getaiteamarray(level.zombie_team), undefined, undefined, 120);
  if(!isDefined(zombies)) {
    return;
  }
  forward = anglesToForward(self getplayerangles());
  up = anglestoup(self getplayerangles());
  segment_start = view_pos + (36 * forward);
  segment_end = segment_start + ((120 - 36) * forward);
  fling_force = level.zombie_vars["riotshield_fling_force_juke"];
  fling_force_vlo = fling_force * 0.5;
  fling_force_vhi = fling_force * 0.6;
  enemies = [];
  for(i = 0; i < zombies.size; i++) {
    if(!isDefined(zombies[i]) || !isalive(zombies[i])) {
      continue;
    }
    if(zombies[i].archetype == "margwa") {
      continue;
    }
    test_origin = zombies[i] getcentroid();
    radial_origin = pointonsegmentnearesttopoint(segment_start, segment_end, test_origin);
    lateral = test_origin - radial_origin;
    if(abs(lateral[2]) > 72) {
      continue;
    }
    lateral = (lateral[0], lateral[1], 0);
    len = length(lateral);
    if(len > 36) {
      continue;
    }
    lateral = (lateral[0], lateral[1], 0);
    zombies[i].fling_vec = (fling_force * forward) + (randomfloatrange(fling_force_vlo, fling_force_vhi) * up);
    enemies[enemies.size] = zombies[i];
  }
  return enemies;
}

function spawn_recharge_tanks() {
  level flag::wait_till("all_players_spawned");
  n_spawned = 0;
  n_charges = level.players.size + 3;
  a_e_spawnpoints = array::randomize(struct::get_array("zod_shield_charge"));
  level thread function_fc8bb1d(a_e_spawnpoints);
  foreach(e_spawnpoint in a_e_spawnpoints) {
    if(isDefined(e_spawnpoint.spawned) && e_spawnpoint.spawned) {
      n_spawned++;
    }
  }
  foreach(e_spawnpoint in a_e_spawnpoints) {
    if(n_spawned < n_charges) {
      if(!(isDefined(e_spawnpoint.spawned) && e_spawnpoint.spawned)) {
        e_spawnpoint thread create_bottle_unitrigger(e_spawnpoint.origin, e_spawnpoint.angles);
        n_spawned++;
      }
      continue;
    }
    break;
  }
  level waittill("start_of_round");
  level thread spawn_recharge_tanks();
}

function create_bottle_unitrigger(v_origin, v_angles) {
  s_struct = self;
  if(self == level) {
    s_struct = spawnStruct();
    s_struct.origin = v_origin;
    s_struct.angles = v_angles;
  }
  width = 128;
  height = 128;
  length = 128;
  unitrigger_stub = spawnStruct();
  unitrigger_stub.origin = v_origin;
  unitrigger_stub.angles = v_angles;
  unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
  unitrigger_stub.cursor_hint = "HINT_NOICON";
  unitrigger_stub.script_width = width;
  unitrigger_stub.script_height = height;
  unitrigger_stub.script_length = length;
  unitrigger_stub.require_look_at = 0;
  unitrigger_stub.mdl_shield_recharge = spawn("script_model", v_origin);
  modelname = "p7_zm_zod_nitrous_tank";
  if(isDefined(s_struct.model) && isstring(s_struct.model)) {
    modelname = s_struct.model;
  }
  unitrigger_stub.mdl_shield_recharge setModel(modelname);
  unitrigger_stub.mdl_shield_recharge.angles = v_angles;
  s_struct.spawned = 1;
  unitrigger_stub.shield_recharge_spawnpoint = s_struct;
  unitrigger_stub.prompt_and_visibility_func = &bottle_trigger_visibility;
  zm_unitrigger::register_static_unitrigger(unitrigger_stub, &shield_recharge_trigger_think);
  return unitrigger_stub;
}

function function_fc8bb1d(a_spawnpoints) {
  level notify("hash_afd0dfa9");
  level endon("hash_afd0dfa9");
  while(true) {
    n_debug = getdvarint("", 0);
    if(n_debug > 0) {
      foreach(spawnpoint in a_spawnpoints) {
        v_color = (1, 1, 1);
        if(isDefined(spawnpoint.spawned) && spawnpoint.spawned) {
          v_color = (0, 1, 0);
        }
        sphere(spawnpoint.origin, 25, v_color, 0.1, 0, 25, 10);
      }
    }
    wait(10 * 0.05);
  }
}

function bottle_trigger_visibility(player) {
  self sethintstring(&"ZM_ZOD_PICKUP_BOTTLE");
  if(!(isDefined(player.hasriotshield) && player.hasriotshield) || player getammocount(player.weaponriotshield) == player.weaponriotshield.maxammo) {
    b_is_invis = 1;
  } else {
    b_is_invis = 0;
  }
  self setinvisibletoplayer(player, b_is_invis);
  return !b_is_invis;
}

function shield_recharge_trigger_think() {
  while(true) {
    self waittill("trigger", player);
    if(player zm_utility::in_revive_trigger()) {
      continue;
    }
    if(player.is_drinking > 0) {
      continue;
    }
    if(!zm_utility::is_player_valid(player)) {
      continue;
    }
    level thread bottle_trigger_activate(self.stub, player);
    break;
  }
}

function bottle_trigger_activate(trig_stub, player) {
  trig_stub notify("bottle_collected");
  if(isDefined(player.hasriotshield) && player.hasriotshield) {
    player zm_equipment::change_ammo(player.weaponriotshield, 1);
  }
  v_origin = trig_stub.mdl_shield_recharge.origin;
  v_angles = trig_stub.mdl_shield_recharge.angles;
  trig_stub.mdl_shield_recharge delete();
  zm_unitrigger::unregister_unitrigger(trig_stub);
  trig_stub.shield_recharge_spawnpoint.spawned = undefined;
}

function function_3f94d6cf() {
  level flagsys::wait_till("");
  wait(1);
  zm_devgui::add_custom_devgui_callback(&function_e2f5a93);
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    ip1 = i + 1;
  }
}

function function_e2f5a93(cmd) {
  players = getplayers();
  retval = 0;
  switch (cmd) {
    case "": {
      array::thread_all(players, &zm_devgui::zombie_devgui_equipment_give, "");
      retval = 1;
      break;
    }
    case "": {
      array::thread_all(players, &function_3796f8bc);
      retval = 1;
      break;
    }
    case "": {
      array::thread_all(players, &function_e7c51939);
      retval = 1;
      break;
    }
  }
  return retval;
}

function detect_reentry() {
  if(isDefined(self.devgui_preserve_time)) {
    if(self.devgui_preserve_time == gettime()) {
      return true;
    }
  }
  self.devgui_preserve_time = gettime();
  return false;
}

function function_e7c51939() {
  self zm_equipment::buy("");
  self.b_has_upgraded_shield = 1;
}

function function_3796f8bc() {
  if(self detect_reentry()) {
    return;
  }
  self notify("hash_3796f8bc");
  self endon("hash_3796f8bc");
  level flagsys::wait_till("");
  self.var_3796f8bc = !(isDefined(self.var_3796f8bc) && self.var_3796f8bc);
  if(self.var_3796f8bc) {
    while(isDefined(self)) {
      damagemax = level.weaponriotshield.weaponstarthitpoints;
      if(isDefined(self.weaponriotshield)) {
        damagemax = self.weaponriotshield.weaponstarthitpoints;
      }
      shieldhealth = self damageriotshield(0);
      if(shieldhealth == 0) {
        shieldhealth = self damageriotshield(damagemax * -1);
      } else {
        shieldhealth = self damageriotshield(int(damagemax / 10));
      }
      wait(0.5);
    }
  }
}