/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\mp_freerun_01.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_load;
#using scripts\mp\_util;
#using scripts\mp\gametypes\_spawnlogic;
#using scripts\shared\callbacks_shared;
#using scripts\shared\compass;
#using scripts\shared\util_shared;
#namespace namespace_49ee819c;

function main() {
  precache();
  load::main();
  init();
}

function precache() {}

function init() {}

function speed_test_init() {
  trigger1 = getent("speed_trigger1", "targetname");
  trigger2 = getent("speed_trigger2", "targetname");
  trigger3 = getent("speed_trigger3", "targetname");
  trigger4 = getent("speed_trigger4", "targetname");
  trigger5 = getent("speed_trigger5", "targetname");
  trigger6 = getent("speed_trigger6", "targetname");
  trigger1 thread speed_test();
  trigger2 thread speed_test();
  trigger3 thread speed_test();
  trigger4 thread speed_test();
  trigger5 thread speed_test();
  trigger6 thread speed_test();
}

function speed_test() {
  while(true) {
    self waittill("trigger", player);
    if(isPlayer(player)) {
      self thread util::trigger_thread(player, &player_on_trigger, &player_off_trigger);
    }
    wait(0.05);
  }
}

function player_on_trigger(player, endon_string) {
  player endon("death");
  player endon("disconnect");
  player endon(endon_string);
  if(isDefined(player._speed_test2)) {
    player._speed_test1 = gettime();
    total_time = player._speed_test1 - player._speed_test2;
    iprintlnbold(("" + (total_time / 1000)) + "seconds");
    player._speed_test2 = undefined;
  }
}

function player_off_trigger(player) {
  player endon("death");
  player endon("disconnect");
  player._speed_test2 = gettime();
  if(isDefined(player._speed_test1)) {
    player._speed_test1 = undefined;
  }
}