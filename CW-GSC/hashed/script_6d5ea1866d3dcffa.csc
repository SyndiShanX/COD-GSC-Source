/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6d5ea1866d3dcffa.csc
***********************************************/

#using script_71b355b2496e3c6d;
#using scripts\core_common\system_shared;
#namespace namespace_5a359049;

function private autoexec __init__system__() {
  system::register(#"hash_695bd4a240716800", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(is_true(level.legacy_cymbal_monkey)) {
    level.cymbal_monkey_model = "weapon_zombie_monkey_bomb";
  } else {
    level.cymbal_monkey_model = "wpn_t7_zmb_monkey_bomb_world";
  }

  namespace_cc411409::preinit();
}