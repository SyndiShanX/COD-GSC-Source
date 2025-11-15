/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_phoenix_up.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_phoenix_up;

function autoexec __init__sytem__() {
  system::register("zm_bgb_phoenix_up", & __init__, undefined, "bgb");
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_phoenix_up", "activated", 1, undefined, undefined, & validation, & activation);
  bgb::register_lost_perk_override("zm_bgb_phoenix_up", & lost_perk_override, 1);
}

function validation() {
  players = level.players;
  foreach(player in players) {
    if(isDefined(player.var_df0decf1) && player.var_df0decf1) {
      return false;
    }
    if(isDefined(level.var_11b06c2f) && self[[level.var_11b06c2f]](player, 1, 1)) {
      return true;
    }
    if(self zm_laststand::can_revive(player, 1, 1)) {
      return true;
    }
  }
  return false;
}

function activation() {
  playsoundatposition("zmb_bgb_phoenix_activate", (0, 0, 0));
  players = level.players;
  foreach(player in players) {
    can_revive = 0;
    if(isDefined(level.var_11b06c2f) && self[[level.var_11b06c2f]](player, 1, 1)) {
      can_revive = 1;
    } else if(self zm_laststand::can_revive(player, 1, 1)) {
      can_revive = 1;
    }
    if(can_revive) {
      player thread bgb::bgb_revive_watcher();
      player zm_laststand::auto_revive(self, 0);
      self zm_stats::increment_challenge_stat("GUM_GOBBLER_PHOENIX_UP");
    }
  }
}

function lost_perk_override(perk, var_2488e46a = undefined, var_24df4040 = undefined) {
  self thread bgb::revive_and_return_perk_on_bgb_activation(perk);
  return false;
}