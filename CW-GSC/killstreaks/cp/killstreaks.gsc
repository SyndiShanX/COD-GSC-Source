/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\cp\killstreaks.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\cp\killstreakrules;
#using scripts\killstreaks\killstreaks_shared;
#namespace killstreaks;

function private autoexec __init__system__() {
  system::register(#"killstreaks", &preinit, undefined, undefined, #"weapons");
}

function private preinit() {
  init_shared();
  callback::on_start_gametype(&init);
}

function init() {
  level.killstreak_init_start_time = getmillisecondsraw();
  thread debug_ricochet_protection();

  function_447e6858();
  callback::callback(#"hash_45f35669076bc317");
  killstreakrules::init();

  level.killstreak_init_end_time = getmillisecondsraw();
  elapsed_time = level.killstreak_init_end_time - level.killstreak_init_start_time;
  println("<dev string:x38>" + elapsed_time + "<dev string:x59>");
  level thread killstreak_debug_think();
}