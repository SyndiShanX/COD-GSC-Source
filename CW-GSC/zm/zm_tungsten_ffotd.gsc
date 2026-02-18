/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_tungsten_ffotd.gsc
***********************************************/

#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_player;
#namespace zm_tungsten_ffotd;

function private autoexec __init__system__() {
  system::register(#"zm_tungsten_ffotd", &preinit, &postinit, undefined, undefined);
}

function private preinit() {}

function private postinit() {
  level thread function_e0cfb01("zone_service_tunnels_02_spawns", (4938.35, -2918.99, -3247.5));
  level thread function_e0cfb01("zone_service_tunnels_01_spawns", (6619.54, -2900.19, -3207));
  level thread function_e0cfb01("zone_board_room_02_spawns", (5439.51, -3917.67, -3207));
  level thread function_e0cfb01("zone_bunker_entrance_02_spawns", (6918, -4223.5, -3208));
  spawncollision("collision_clip_512x512x512", "collider", (3670, 7762, 165), (0, 0, 0));
  level thread function_6526f34b();
  level thread function_13b9705e();
  zm_player::spawn_kill_brush((1373, 7298, -681), 1000, 128);
  zm_player::spawn_kill_brush((5409, 4150, -681), 1000, 128);
  zm_player::spawn_kill_brush((6282, 4972, -681), 1000, 128);
  spawncollision("collision_clip_64x64x128", "collider", (4939.5, 1818.5, -185.5), (0, 0, 0));
}

function function_6526f34b() {
  level endon(#"game_ended");
  var_f7336730 = spawncollision("collision_clip_wall_256x256x10", "collider", (3357, 906, 109), (0, 0, 0));
  var_84e50295 = spawncollision("collision_clip_wall_512x512x10", "collider", (3357, 1558, 140), (0, 0, 0));
  level flag::wait_till("connect_anytown_usa_rooftops");

  if(isDefined(var_f7336730)) {
    var_f7336730 delete();
  }

  if(isDefined(var_84e50295)) {
    var_84e50295 delete();
  }
}

function function_13b9705e() {
  level endon(#"game_ended");
  var_f7336730 = spawncollision("collision_clip_wall_512x512x10", "collider", (4489, 6969, 156), (0, 270, 0));
  var_84e50295 = spawncollision("collision_clip_wall_512x512x10", "collider", (3977, 6969, 156), (0, 270, 0));
  var_a30d3edd = spawncollision("collision_clip_wall_512x512x10", "collider", (3788, 6969, 156), (0, 270, 0));
  var_ae7355a9 = spawncollision("collision_clip_wall_512x512x10", "collider", (3537, 6708, 156), (0, 0, 0));
  level flag::wait_till("connect_diner");

  if(isDefined(var_f7336730)) {
    var_f7336730 delete();
  }

  if(isDefined(var_84e50295)) {
    var_84e50295 delete();
  }

  if(isDefined(var_a30d3edd)) {
    var_a30d3edd delete();
  }

  if(isDefined(var_ae7355a9)) {
    var_ae7355a9 delete();
  }
}

function function_67a43327(str_struct, v_origin, v_angles) {
  s_loc = struct::get(str_struct);

  if(isDefined(s_loc)) {
    s_loc.origin = v_origin;
    s_loc.angles = v_angles;
  }
}

function function_e0cfb01(str_zone_name, v_origin) {
  foreach(s_loc in struct::get_array(str_zone_name)) {
    if(s_loc.script_noteworthy === "wait_location") {
      s_loc.origin = v_origin;
    }
  }
}