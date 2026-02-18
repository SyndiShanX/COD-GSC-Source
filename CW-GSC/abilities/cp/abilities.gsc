/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: abilities\cp\abilities.gsc
***********************************************/

#using scripts\abilities\ability_player;
#using scripts\abilities\gadgets\gadget_health_regen;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\cp_common\gametypes\loadout;
#namespace abilities;

function private autoexec __init__system__() {
  system::register(#"cp_abilities", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.abilities_devgui_add_gadgets_custom = &abilities_devgui_add_gadgets_custom;

  callback::on_spawned(&init_abilities);
  clientfield::register_clientuimodel("playerAbilities.inRange", 1, 1, "int");
}

function init_abilities() {
  if(!isDefined(self.var_25fa785)) {
    self.var_25fa785 = spawnStruct();
  }

  if(!isDefined(self.var_25fa785.var_b10e8797)) {
    self.var_25fa785.var_b10e8797 = 0;
  }
}

function function_b797206c(slot, weapon) {
  return true;
}

function function_5bcf55cb(var_28b5f8ed) {
  weapon_array = [];

  foreach(ability in var_28b5f8ed) {
    weapon = getweapon(ability);

    if(weapon != getweapon(#"none")) {
      arrayinsert(weapon_array, weapon, 0);
    }
  }

  return weapon_array;
}

function abilities_devgui_add_gadgets_custom(root, pname, pid, menu_index) {
  add_cmd_with_root = "<dev string:x38>" + root + pname + "<dev string:x47>";
  level.var_fefd47f = [];
  array::add(level.var_fefd47f, "<dev string:x4c>", 0);
  array::add(level.var_fefd47f, "<dev string:x58>", 0);
  array::add(level.var_fefd47f, "<dev string:x6e>", 0);
  array::add(level.var_fefd47f, "<dev string:x7d>", 0);
  array::add(level.var_fefd47f, "<dev string:x8d>", 0);
  array::add(level.var_fefd47f, "<dev string:x9d>", 0);
  array::add(level.var_fefd47f, "<dev string:xab>", 0);
  array::add(level.var_fefd47f, "<dev string:xb9>", 0);
  array::add(level.var_fefd47f, "<dev string:xcb>", 0);
  array::add(level.var_fefd47f, "<dev string:xdd>", 0);
  array::add(level.var_fefd47f, "<dev string:xf2>", 0);
  array::add(level.var_fefd47f, "<dev string:x101>", 0);
  array::add(level.var_fefd47f, "<dev string:x112>", 0);
  array::add(level.var_fefd47f, "<dev string:x122>", 0);
  array::add(level.var_fefd47f, "<dev string:x132>", 0);
  array::add(level.var_fefd47f, "<dev string:x148>", 0);
  array::add(level.var_fefd47f, "<dev string:x15b>", 0);
  array::add(level.var_fefd47f, "<dev string:x171>", 0);
  array::add(level.var_fefd47f, "<dev string:x186>", 0);
  array::add(level.var_fefd47f, "<dev string:x198>", 0);
  array::add(level.var_fefd47f, "<dev string:x1a9>", 0);
  a_grenades = function_5bcf55cb(level.var_fefd47f);
  ability_player::function_174037fe(add_cmd_with_root, pid, a_grenades, "<dev string:x1b7>", menu_index);
  level.var_29d4fb5b = [];
  array::add(level.var_29d4fb5b, "<dev string:x1c3>", 0);
  array::add(level.var_29d4fb5b, "<dev string:x1d8>", 0);
  array::add(level.var_29d4fb5b, "<dev string:x1ed>", 0);
  array::add(level.var_29d4fb5b, "<dev string:x201>", 0);
  array::add(level.var_29d4fb5b, "<dev string:x21f>", 0);
  array::add(level.var_29d4fb5b, "<dev string:x233>", 0);
  array::add(level.var_29d4fb5b, "<dev string:x24a>", 0);
  array::add(level.var_29d4fb5b, "<dev string:x264>", 0);
  array::add(level.var_29d4fb5b, "<dev string:x27d>", 0);
  array::add(level.var_29d4fb5b, "<dev string:x294>", 0);
  array::add(level.var_29d4fb5b, "<dev string:x2a6>", 0);
  array::add(level.var_29d4fb5b, "<dev string:x2b4>", 0);
  array::add(level.var_29d4fb5b, "<dev string:x2c3>", 0);
  array::add(level.var_29d4fb5b, "<dev string:x2da>", 0);
  a_abilities = function_5bcf55cb(level.var_29d4fb5b);
  ability_player::function_a40d04ca(add_cmd_with_root, pid, a_abilities, "<dev string:x2f0>", menu_index);
  menu_index++;
  menu_index = ability_player::abilities_devgui_add_power(add_cmd_with_root, pid, menu_index);
  wait 1;
  menu_index = ability_player::function_2e0162e9(add_cmd_with_root, pid, menu_index);
  level.var_86734d48 = &loadout::giveloadout;
  return menu_index;
}