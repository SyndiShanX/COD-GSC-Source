/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_ffotd.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\callbacks_shared;
#using scripts\zm\_zm_utility;
#namespace zm_ffotd;

function main_start() {}

function main_end() {
  difficulty = 1;
  column = int(difficulty) + 1;
  zombie_utility::set_zombie_var("zombie_move_speed_multiplier", 4, 0, column);
}

function optimize_for_splitscreen() {
  if(!isdefined(level.var_7064bd2e)) {
    level.var_7064bd2e = 3;
  }
  if(level.var_7064bd2e) {
    if(getdvarint("splitscreen_playerCount") >= level.var_7064bd2e) {
      return true;
    }
  }
  return false;
}