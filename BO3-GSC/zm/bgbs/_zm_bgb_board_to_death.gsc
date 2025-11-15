/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_board_to_death.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_board_to_death;

function autoexec __init__sytem__() {
  system::register("zm_bgb_board_to_death", & __init__, undefined, "bgb");
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_board_to_death", "time", 300, & enable, & disable, undefined);
}

function enable() {
  self thread function_3c61f2df();
}

function disable() {}

function function_3c61f2df() {
  self endon("disconnect");
  self endon("bled_out");
  self endon("bgb_update");
  while(true) {
    self waittill("boarding_window", s_window);
    self bgb::do_one_shot_use();
    self thread function_64ea6cea(s_window);
  }
}

function function_64ea6cea(s_window) {
  wait(0.3);
  a_ai = getaiteamarray(level.zombie_team);
  a_closest = arraysortclosest(a_ai, s_window.origin, a_ai.size, 0, 180);
  for(i = 0; i < a_closest.size; i++) {
    if(a_closest[i].archetype === "zombie" && isalive(a_closest[i])) {
      a_closest[i] dodamage(a_closest[i].health + 100, a_closest[i].origin);
      a_closest[i] playSound("zmb_bgb_boardtodeath_imp");
      wait(randomfloatrange(0.05, 0.2));
    }
  }
}