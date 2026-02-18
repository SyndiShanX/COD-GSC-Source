/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\load.csc
***********************************************/

#using script_26e61ae2e1d842a9;
#using script_446b64250de153ef;
#using script_644007a8c3885fc;
#using script_727042a075af51b7;
#using scripts\core_common\clientfaceanim_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\footsteps_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_spawn_groups;
#using scripts\core_common\item_supply_drop;
#using scripts\core_common\item_world;
#using scripts\core_common\item_world_cleanup;
#using scripts\core_common\item_world_fixup;
#using scripts\core_common\load_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\driving_fx;
#using scripts\weapons\zm\weaponobjects;
#using scripts\zm_common\ambient;
#using scripts\zm_common\global_fx;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_aoe;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_traps;
#namespace load;

function private autoexec __init__system__() {
  system::register(#"zm_load", &function_aeb1baea, undefined, undefined, undefined);
}

function levelnotifyhandler(clientnum, state, oldstate) {
  if(oldstate != "") {
    level notify(oldstate, state);
  }
}

function warnmissilelocking(localclientnum, set) {}

function warnmissilelocked(localclientnum, set) {}

function warnmissilefired(localclientnum, set) {}

function function_aeb1baea() {
  assert(!isDefined(level.var_f18a6bd6));
  level.var_f18a6bd6 = &function_5e443ed1;
}

function function_5e443ed1() {
  assert(isDefined(level.first_frame), "<dev string:x38>");
  zm::init();
  level thread util::init_utility();
  util::register_system(#"levelnotify", &levelnotifyhandler);
  register_clientfields();
  level.createfx_disable_fx = getdvarint(#"disable_fx", 0) == 1;
  system::function_c11b0642();
  level thread art_review();
  level flag::set(#"load_main_complete");
}

function register_clientfields() {
  clientfield::register("allplayers", "zmbLastStand", 1, 1, "int", &zm::laststand, 0, 1);
}