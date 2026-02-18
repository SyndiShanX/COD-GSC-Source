/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\load.csc
***********************************************/

#using script_26e61ae2e1d842a9;
#using script_446b64250de153ef;
#using script_644007a8c3885fc;
#using script_727042a075af51b7;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gametype_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_spawn_groups;
#using scripts\core_common\item_supply_drop;
#using scripts\core_common\item_world;
#using scripts\core_common\item_world_cleanup;
#using scripts\core_common\item_world_fixup;
#using scripts\core_common\map;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicles\driving_fx;
#using scripts\mp_common\callbacks;
#using scripts\wz_common\wz_perk_paranoia;
#namespace load;

function levelnotifyhandler(clientnum, state, oldstate) {
  if(oldstate != "") {
    level notify(oldstate, {
      #localclientnum: state
    });
  }
}

function autoexec function_aeb1baea() {
  assert(!isDefined(level.var_f18a6bd6));
  level.var_f18a6bd6 = &function_5e443ed1;
}

function function_5e443ed1() {
  assert(isDefined(level.first_frame), "<dev string:x38>");
  level thread util::init_utility();
  util::registersystem("levelNotify", &levelnotifyhandler);
  register_clientfields();
  level.createfx_disable_fx = getdvarint(#"disable_fx", 0) == 1;
  setDvar(#"hash_7633a587d5705d08", 1);
  setDvar(#"hash_3fe46a1700f8faf6", 0.25);
  map::init();
  gametype::init();
  system::function_c11b0642();
  level flag::set(#"load_main_complete");
}

function register_clientfields() {
  clientfield::register("missile", "cf_m_proximity", 1, 1, "int", &callback::callback_proximity, 0, 0);
  clientfield::register("missile", "cf_m_emp", 1, 1, "int", &callback::callback_emp, 0, 0);
  clientfield::register("missile", "cf_m_stun", 1, 1, "int", &callback::callback_stunned, 0, 0);
}