/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_21efec9a54bfcf79.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_7feaed3f883fe324;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\cp_mp\powerups\nuke;
#using scripts\cp_mp\powerups\powerups;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_weapons;
#namespace namespace_73d87acd9f4a87e2;

function autoexec main() {
  if(getdvarint(@ "hash_5f4c8ff726eb8e87", 0) && !getdvarint(@ "hash_6d05eef17bf3efaa", 0)) {
    init();
  }
}

function init() {
  utility::registersharedfunc("powerup_nuke", "should_drop", &should_drop);
  utility::registersharedfunc("powerup_nuke", "drop_nuke_powerup", &drop_powerup);
  utility::registersharedfunc("powerup_nuke", "trigger_nuke", &trigger_nuke);
  level utility::flag_set("powerup_disable_nuke");
}

function should_drop() {
  return false;
}

function drop_powerup(spawn_pos, lifetime_override) {
  if(utility::issharedfuncdefined("powerups", "dropPowerup")) {
    return utility::callsharedfunc("powerups", "dropPowerup", "nuke", spawn_pos, lifetime_override);
  }
}

function trigger_nuke(origin, skip_flash, var_16ae9c6156ab4fab) {
  dummy_struct = {
    #origin: origin
  };
  scripts\cp_mp\powerups\nuke::grab_nuke("nuke", dummy_struct, 1, 1, 1, 1, skip_flash, var_16ae9c6156ab4fab);
}