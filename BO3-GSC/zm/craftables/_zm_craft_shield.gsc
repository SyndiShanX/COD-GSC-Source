/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\craftables\_zm_craft_shield.gsc
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
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_powerup_shield_charge;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weap_riotshield;
#using scripts\zm\craftables\_zm_craftables;
#namespace zm_craft_shield;

function autoexec __init__sytem__() {
  system::register("zm_craft_shield", & __init__, & __main__, undefined);
}

function __init__() {}

function init(shield_equipment, shield_weapon, shield_model, str_to_craft = & "ZOMBIE_CRAFT_RIOT", str_taken = & "ZOMBIE_BOUGHT_RIOT", str_grab = & "ZOMBIE_GRAB_RIOTSHIELD") {
  level.craftable_shield_equipment = shield_equipment;
  level.craftable_shield_weapon = shield_weapon;
  level.craftable_shield_model = shield_model;
  level.craftable_shield_grab = str_grab;
  level.riotshield_supports_deploy = 0;
  riotshield_dolly = zm_craftables::generate_zombie_craftable_piece(level.craftable_shield_equipment, "dolly", 32, 64, 0, undefined, & on_pickup_common, & on_drop_common, undefined, undefined, undefined, undefined, "piece_riotshield_dolly", 1, "build_zs");
  riotshield_door = zm_craftables::generate_zombie_craftable_piece(level.craftable_shield_equipment, "door", 48, 15, 25, undefined, & on_pickup_common, & on_drop_common, undefined, undefined, undefined, undefined, "piece_riotshield_door", 1, "build_zs");
  riotshield_clamp = zm_craftables::generate_zombie_craftable_piece(level.craftable_shield_equipment, "clamp", 48, 15, 25, undefined, & on_pickup_common, & on_drop_common, undefined, undefined, undefined, undefined, "piece_riotshield_clamp", 1, "build_zs");
  registerclientfield("world", "piece_riotshield_dolly", 1, 1, "int", undefined, 0);
  registerclientfield("world", "piece_riotshield_door", 1, 1, "int", undefined, 0);
  registerclientfield("world", "piece_riotshield_clamp", 1, 1, "int", undefined, 0);
  clientfield::register("toplayer", "ZMUI_SHIELD_PART_PICKUP", 1, 1, "int");
  clientfield::register("toplayer", "ZMUI_SHIELD_CRAFTED", 1, 1, "int");
  riotshield = spawnStruct();
  riotshield.name = level.craftable_shield_equipment;
  riotshield.weaponname = level.craftable_shield_weapon;
  riotshield zm_craftables::add_craftable_piece(riotshield_dolly);
  riotshield zm_craftables::add_craftable_piece(riotshield_door);
  riotshield zm_craftables::add_craftable_piece(riotshield_clamp);
  riotshield.onbuyweapon = & on_buy_weapon_riotshield;
  riotshield.triggerthink = & riotshield_craftable;
  zm_craftables::include_zombie_craftable(riotshield);
  zm_craftables::add_zombie_craftable(level.craftable_shield_equipment, str_to_craft, "ERROR", str_taken, & on_fully_crafted, 1);
  zm_craftables::add_zombie_craftable_vox_category(level.craftable_shield_equipment, "build_zs");
  zm_craftables::make_zombie_craftable_open(level.craftable_shield_equipment, level.craftable_shield_model, vectorscale((0, -1, 0), 90), vectorscale((0, 0, 1), 26));
}

function __main__() {
  function_f3127c4f();
}

function riotshield_craftable() {
  zm_craftables::craftable_trigger_think("riotshield_zm_craftable_trigger", level.craftable_shield_equipment, level.craftable_shield_weapon, level.craftable_shield_grab, 1, 1);
}

function show_infotext_for_duration(str_infotext, n_duration) {
  self clientfield::set_to_player(str_infotext, 1);
  wait(n_duration);
  self clientfield::set_to_player(str_infotext, 0);
}

function on_pickup_common(player) {
  println("");
  player playSound("zmb_craftable_pickup");
  if(isDefined(level.craft_shield_piece_pickup_vo_override)) {
    player thread[[level.craft_shield_piece_pickup_vo_override]]();
  }
  foreach(e_player in level.players) {
    e_player thread zm_craftables::player_show_craftable_parts_ui("zmInventory.player_crafted_shield", "zmInventory.widget_shield_parts", 0);
    e_player thread show_infotext_for_duration("ZMUI_SHIELD_PART_PICKUP", 3.5);
  }
  self pickup_from_mover();
  self.piece_owner = player;
}

function on_drop_common(player) {
  println("");
  self drop_on_mover(player);
  self.piece_owner = undefined;
}

function pickup_from_mover() {
  if(isDefined(level.craft_shield_pickup_override)) {
    [[level.craft_shield_pickup_override]]();
  }
}

function on_fully_crafted() {
  players = level.players;
  foreach(e_player in players) {
    if(zm_utility::is_player_valid(e_player)) {
      e_player thread zm_craftables::player_show_craftable_parts_ui("zmInventory.player_crafted_shield", "zmInventory.widget_shield_parts", 1);
      e_player thread show_infotext_for_duration("ZMUI_SHIELD_CRAFTED", 3.5);
    }
  }
  return true;
}

function drop_on_mover(player) {
  if(isDefined(level.craft_shield_drop_override)) {
    [[level.craft_shield_drop_override]]();
  }
}

function on_buy_weapon_riotshield(player) {
  if(isDefined(player.player_shield_reset_health)) {
    player[[player.player_shield_reset_health]]();
  }
  if(isDefined(player.player_shield_reset_location)) {
    player[[player.player_shield_reset_location]]();
  }
  player playSound("zmb_craftable_buy_shield");
  level notify("shield_built", player);
}

function function_f3127c4f() {
  level flagsys::wait_till("");
  wait(1);
  zm_devgui::add_custom_devgui_callback( & function_b6937313);
  setdvar("", 0);
  adddebugcommand(("" + level.craftable_shield_equipment) + "");
  adddebugcommand(("" + level.craftable_shield_equipment) + "");
  adddebugcommand(("" + level.craftable_shield_equipment) + "");
}

function function_b6937313(cmd) {
  players = getplayers();
  retval = 0;
  switch (cmd) {
    case "": {
      array::thread_all(players, & function_2b0b208f);
      retval = 1;
      break;
    }
    case "": {
      if(players.size >= 1) {
        players[0] thread function_2b0b208f();
      }
      retval = 1;
      break;
    }
    case "": {
      if(players.size >= 2) {
        players[1] thread function_2b0b208f();
      }
      retval = 1;
      break;
    }
    case "": {
      if(players.size >= 3) {
        players[2] thread function_2b0b208f();
      }
      retval = 1;
      break;
    }
    case "": {
      if(players.size >= 4) {
        players[3] thread function_2b0b208f();
      }
      retval = 1;
      break;
    }
    case "": {
      array::thread_all(level.players, & function_70d7908d);
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

function function_2b0b208f() {
  if(self detect_reentry()) {
    return;
  }
  self notify("hash_2b0b208f");
  self endon("hash_2b0b208f");
  self.var_74469a7a = !(isDefined(self.var_74469a7a) && self.var_74469a7a);
  println((("" + self.name) + "") + (self.var_74469a7a ? "" : ""));
  iprintlnbold((("" + self.name) + "") + (self.var_74469a7a ? "" : ""));
  if(self.var_74469a7a) {
    while(isDefined(self)) {
      damagemax = level.weaponriotshield.weaponstarthitpoints;
      if(isDefined(self.weaponriotshield)) {
        damagemax = self.weaponriotshield.weaponstarthitpoints;
      }
      shieldhealth = damagemax;
      shieldhealth = self damageriotshield(0);
      self damageriotshield(shieldhealth - damagemax);
      wait(0.05);
    }
  }
}

function function_70d7908d() {
  if(self detect_reentry()) {
    return;
  }
  if(isDefined(self.hasriotshield) && self.hasriotshield) {
    self zm_equipment::change_ammo(self.weaponriotshield, 1);
  }
}