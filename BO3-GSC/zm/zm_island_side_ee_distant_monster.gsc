/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_island_side_ee_distant_monster.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\zm_island_util;
#namespace zm_island_side_ee_distant_monster;

function autoexec __init__sytem__() {
  system::register("zm_island_side_ee_distant_monster", & __init__, undefined, undefined);
}

function __init__() {}

function main() {
  var_53564731 = getent("ee_vista_monster", "targetname");
  level thread function_e94b80b9();
  level thread function_abe01b4d();
}

function on_player_spawned() {}

function function_e94b80b9() {
  while(level.round_number < 50) {
    level waittill("start_of_round");
  }
  var_d95fb733 = 0;
  do {
    foreach(player in level.activeplayers) {
      if(zm_utility::is_player_valid(player) && player hasweapon(level.var_c003f5b, 1)) {
        var_d95fb733 = 1;
      }
    }
    wait(2);
  }
  while(!(isDefined(var_d95fb733) && var_d95fb733));
  function_549b07cb();
}

function function_549b07cb() {
  e_vehicle = vehicle::simple_spawn_single("veh_distant_monster");
  e_vehicle hide();
  nd_start = getvehiclenode(e_vehicle.target, "targetname");
  e_vehicle attachpath(nd_start);
  var_53564731 = getent("ee_vista_monster", "targetname");
  var_53564731 setforcenocull();
  var_53564731.origin = e_vehicle.origin;
  var_53564731.angles = e_vehicle.angles;
  var_53564731 linkto(e_vehicle);
  e_vehicle setspeed(5, 100);
  e_vehicle startpath();
  var_53564731 playSound("zmb_distant_monster_mash");
  e_vehicle waittill("reached_end_node");
  e_vehicle.delete_on_death = 1;
  e_vehicle notify("death");
  if(!isalive(e_vehicle)) {
    e_vehicle delete();
  }
}

function function_abe01b4d() {
  zm_devgui::add_custom_devgui_callback( & function_603ad7e1);
  level.var_7b18dfab = 0;
  adddebugcommand("");
  adddebugcommand("");
}

function function_603ad7e1(cmd) {
  switch (cmd) {
    case "": {
      function_549b07cb();
      return true;
    }
    case "": {
      level.var_7b18dfab = !level.var_7b18dfab;
      return true;
    }
  }
  return false;
}