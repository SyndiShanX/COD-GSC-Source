/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4b69d230272caab3.gsc
*************************************************/

#using script_36998bb481626140;
#using script_3aeb1602bef2523b;
#using script_4a624801fb3628f2;
#using script_54a1efdab4e7909e;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\anim;
#using scripts\mp\compass;
#using scripts\mp\flags;
#using scripts\mp\load;
#using scripts\mp\utility\game;
#namespace mp_observatory;

function main() {
  namespace_a0fe32f1ff1b84f9::main();
  namespace_58ab1ec5cc4c1b7e::main();
  namespace_6433bfc2cec40fce::main();
  namespace_39485dc889b99b14::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::function_5b9e95acd14775a5();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_observatory");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level thread function_1682cf22619a5e55();
  level thread function_b82d39658afa02e9();
  level thread function_57be8efc25591b9c();
}

function function_1682cf22619a5e55() {
  level endon("game_ended");
  level waittill("infil_setup_complete");
  var_6120df12544987e8 = getEnt("static_infil_van", "targetname");

  if(gameflag("infil_will_run") && isDefined(var_6120df12544987e8)) {
    var_6120df12544987e8 hide();
  }
}

function function_b82d39658afa02e9() {
  level endon("game_ended");
  wait 3;
  locations = [(1383, -11996, 4804), (-586, -9693, 4696), (-2290, -13569, 4928), (-2587, -11449, 4712)];
  radius = 64;
  var_67c1cb9129565e = [];

  foreach(loc in locations) {
    doors = getentitylessscriptablearray("scriptable_scriptable_door_metal_04_flat_painted_clean_mp", "classname", loc, radius);

    if(istrue(doors.size)) {
      var_67c1cb9129565e = array_combine(var_67c1cb9129565e, doors);
    }
  }

  foreach(door in var_67c1cb9129565e) {
    if(door scriptableisdoor()) {
      door scriptabledoorfreeze(1);
    }
  }
}

function function_57be8efc25591b9c() {
  trigger_radius = spawn("trigger_radius", (-1872.04, -11414.5, 4908), 0, 128, 256);
  level.outofboundstriggers = array_add(level.outofboundstriggers, trigger_radius);
}