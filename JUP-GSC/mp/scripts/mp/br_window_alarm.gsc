/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\br_window_alarm.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\flags;
#using scripts\stealth\event;
#namespace br_window_alarm;

function init() {
  if(!getdvarint(@ "hash_7a7e37d9ccf3bff4", 1)) {
    return;
  }

  thread function_6daf5a86616316bd();
}

function function_6daf5a86616316bd() {
  level endon("game_ended");
  level.alarmwindows = getStructArray("alarmmanager", "script_noteworthy");
  scripts\mp\flags::function_1240434f4201ac9d("prematch_fade_done");
  wait 1;

  foreach(alarm in level.alarmwindows) {
    alarm.active = 0;
    alarm.glass = getglass(alarm.target);
    stickers = getentitylessscriptablearray(alarm.target, "targetname");

    if(stickers.size > 0) {
      assertex(stickers.size == 1, "<dev string:x1c>" + alarm.origin + "<dev string:x32>");
      alarm.sticker = stickers[0];

      if(isDefined(alarm.sticker)) {
        alarm.sticker setscriptablepartstate("base", "visible");
      }
    }
  }

  thread windowwatcher();
}

function windowwatcher() {
  level endon("game_ended");

  if(!isDefined(level.var_cbe618f35b332990)) {
    level.var_cbe618f35b332990 = spawn("script_origin", (0, 0, 0));
  }

  while(true) {
    level waittill("glass_destroyed", glassid);

    foreach(alarm in level.alarmwindows) {
      if(isDefined(alarm.glass) && alarm.glass == glassid) {
        if(isDefined(alarm.sticker)) {
          alarm.sticker setscriptablepartstate("base", "destroyed");
          level.var_cbe618f35b332990.orgin = alarm.sticker.origin;
          scripts\stealth\event::event_broadcast_generic("cover_blown", alarm.sticker.origin, 2500, level.var_cbe618f35b332990);
          level.var_cbe618f35b332990.orgin = (0, 0, 0);
        }

        if(!alarm.active) {
          dlog_recordevent("dlog_event_br_window_alarm", ["window_x", alarm.origin[0], "window_y", alarm.origin[1], "window_z", alarm.origin[2]]);
        }
      }
    }
  }
}