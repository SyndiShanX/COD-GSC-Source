/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_morocco.gsc
***********************************************/

#include scripts\core_common\compass;
#include scripts\core_common\struct;
#include scripts\mp\mp_morocco_fx;
#include scripts\mp\mp_morocco_scripted;
#include scripts\mp\mp_morocco_sound;
#include scripts\mp_common\gametypes\globallogic_spawn;
#include scripts\mp_common\load;

#namespace mp_morocco;

event_handler[level_init] main(eventstruct) {
  load::main();
  compass::setupminimap("");
  level.cleandepositpoints = array((425, 1058, 136.5), (-1392, -592, 46.75), (1888, -520, 136), (1523, 1860, 136), (-672, 1592, 135));
  level spawnkilltrigger();
  level function_89088577();
  fixspawnpoints();
}

fixspawnpoints() {
  findpoint = (2532.35, 1640.41, 128.125);

  if(!level.teambased) {
    rawspawns = struct::get_array("mp_t8_spawn_point", "targetname");

    foreach(spawn in rawspawns) {
      if(!(isDefined(spawn._human_were) && spawn._human_were)) {
        continue;
      }

      distance = distancesquared(spawn.origin, findpoint);

      if(distance > 5) {
        continue;
      }

      spawn.origin = (3140.85, 913.91, 128.125);
      break;
    }
  }
}

function_89088577() {
  spawncollision("collision_clip_128x128x128", "collider", (-128, -600, 728), (0, 0, 0));
}

spawnkilltrigger() {
  trigger = spawn("trigger_radius", (2856, 600, 64), 0, 700, 32);
  trigger thread watchkilltrigger();
  trigger = spawn("trigger_radius", (2792, 1368, 64), 0, 700, 32);
  trigger thread watchkilltrigger();
  trigger = spawn("trigger_radius", (200, 1920, 64), 0, 300, 32);
  trigger thread watchkilltrigger();
  trigger = spawn("trigger_radius", (-224, 1992, 64), 0, 300, 32);
  trigger thread watchkilltrigger();
  trigger = spawn("trigger_radius", (-768, 1952, 64), 0, 360, 32);
  trigger thread watchkilltrigger();
  trigger = spawn("trigger_radius", (480, -1568, 96), 0, 32, 128);
  trigger thread watchkilltrigger();
}

watchkilltrigger() {
  level endon(#"game_ended");
  trigger = self;

  while(true) {
    waitresult = trigger waittill(#"trigger");
    waitresult.activator dodamage(1000, trigger.origin + (0, 0, 0), trigger, trigger, "none", "MOD_SUICIDE", 0);
  }
}