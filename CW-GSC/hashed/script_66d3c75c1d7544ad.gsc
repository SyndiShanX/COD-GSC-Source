/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_66d3c75c1d7544ad.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_2cab06c8;

function private autoexec __init__system__() {
  system::register(#"hash_176447d3860a4b99", undefined, &postinit, undefined, undefined);
}

function postinit() {
  init_devgui();

  callback::on_vehicle_spawned(&on_vehicle_spawned);
}

function on_vehicle_spawned() {
  vehicle = self;

  if(isalive(vehicle) && isDefined(vehicle.target)) {
    start_spawn = struct::get(vehicle.target);

    if(isDefined(start_spawn)) {
      vehicle.origin = start_spawn.origin;
      vehicle.angles = start_spawn.angles;
    }
  }
}

function init_devgui() {
  mapname = util::get_map_name();
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x49>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xae>");
}