/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_crawl_space.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_crawl_space;

function autoexec __init__sytem__() {
  system::register("zm_bgb_crawl_space", & __init__, undefined, "bgb");
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_crawl_space", "activated", 5, undefined, undefined, undefined, & activation);
}

function activation() {
  a_ai = getaiarray();
  for(i = 0; i < a_ai.size; i++) {
    if(isDefined(a_ai[i]) && isalive(a_ai[i]) && a_ai[i].archetype === "zombie" && isDefined(a_ai[i].gibdef)) {
      var_5a3ad5d6 = distancesquared(self.origin, a_ai[i].origin);
      if(var_5a3ad5d6 < 360000) {
        a_ai[i] zombie_utility::makezombiecrawler();
      }
    }
  }
}