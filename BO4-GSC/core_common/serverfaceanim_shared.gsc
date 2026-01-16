/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\serverfaceanim_shared.gsc
*************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;

#namespace serverfaceanim;

autoexec __init__system__() {
  system::register(#"serverfaceanim", &__init__, undefined, undefined);
}

__init__() {
  if(!(isDefined(level._use_faceanim) && level._use_faceanim)) {
    return;
  }

  callback::on_spawned(&init_serverfaceanim);
}

init_serverfaceanim() {
  self.do_face_anims = 1;

  if(!isDefined(level.face_event_handler)) {
    level.face_event_handler = spawnStruct();
    level.face_event_handler.events = [];
    level.face_event_handler.events[#"death"] = "face_death";
    level.face_event_handler.events[#"grenade danger"] = "face_alert";
    level.face_event_handler.events[#"bulletwhizby"] = "face_alert";
    level.face_event_handler.events[#"projectile_impact"] = "face_alert";
    level.face_event_handler.events[#"explode"] = "face_alert";
    level.face_event_handler.events[#"alert"] = "face_alert";
    level.face_event_handler.events[#"shoot"] = "face_shoot_single";
    level.face_event_handler.events[#"melee"] = "face_melee";
    level.face_event_handler.events[#"damage"] = "face_pain";
    level thread wait_for_face_event();
  }
}

wait_for_face_event() {
  while(true) {
    waitresult = level waittill(#"face");
    face_notify = waitresult.face_notify;
    ent = waitresult.entity;

    if(isDefined(ent) && isDefined(ent.do_face_anims) && ent.do_face_anims) {
      if(isDefined(level.face_event_handler.events[face_notify])) {
        ent sendfaceevent(level.face_event_handler.events[face_notify]);
      }
    }
  }
}