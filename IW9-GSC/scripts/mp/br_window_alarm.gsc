/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\br_window_alarm.gsc
***********************************************/

init() {
  if(!getdvarint("dvar_7A7E37D9CCF3BFF4", 1)) {
    return;
  }
  thread _id_6DAF5A86616316BD();
}

_id_6DAF5A86616316BD() {
  level endon("game_ended");
  level._id_5DCC3658A9FCCF63 = scripts\engine\utility::getStructArray("alarmmanager", "script_noteworthy");
  scripts\mp\flags::_id_1240434F4201AC9D("prematch_fade_done");
  wait 1;

  foreach(_id_9E85FD38C09D58DE in level._id_5DCC3658A9FCCF63) {
    _id_9E85FD38C09D58DE.active = 0;
    _id_9E85FD38C09D58DE.glass = getglass(_id_9E85FD38C09D58DE.target);
    stickers = getentitylessscriptablearray(_id_9E85FD38C09D58DE.target, "targetname");

    if(stickers.size > 0) {
      _id_9E85FD38C09D58DE._id_514B604B42B22810 = stickers[0];

      if(isDefined(_id_9E85FD38C09D58DE._id_514B604B42B22810))
        _id_9E85FD38C09D58DE._id_514B604B42B22810 setscriptablepartstate("base", "visible");
    }
  }

  thread _id_ACDB910CC20A22FB();
}

_id_ACDB910CC20A22FB() {
  level endon("game_ended");

  if(!isDefined(level._id_CBE618F35B332990))
    level._id_CBE618F35B332990 = spawn("script_origin", (0, 0, 0));

  for(;;) {
    level waittill("glass_destroyed", _id_7CF165BC68D7F162);

    foreach(_id_9E85FD38C09D58DE in level._id_5DCC3658A9FCCF63) {
      if(isDefined(_id_9E85FD38C09D58DE.glass) && _id_9E85FD38C09D58DE.glass == _id_7CF165BC68D7F162) {
        if(isDefined(_id_9E85FD38C09D58DE._id_514B604B42B22810)) {
          _id_9E85FD38C09D58DE._id_514B604B42B22810 setscriptablepartstate("base", "destroyed");
          level._id_CBE618F35B332990._id_1FB1E7FE25742F06 = _id_9E85FD38C09D58DE._id_514B604B42B22810.origin;
          scripts\stealth\event::event_broadcast_generic("cover_blown", _id_9E85FD38C09D58DE._id_514B604B42B22810.origin, 2500, level._id_CBE618F35B332990);
          level._id_CBE618F35B332990._id_1FB1E7FE25742F06 = (0, 0, 0);
        }

        if(!_id_9E85FD38C09D58DE.active)
          dlog_recordevent("dlog_event_br_window_alarm", ["window_x", _id_9E85FD38C09D58DE.origin[0], "window_y", _id_9E85FD38C09D58DE.origin[1], "window_z", _id_9E85FD38C09D58DE.origin[2]]);
      }
    }
  }
}