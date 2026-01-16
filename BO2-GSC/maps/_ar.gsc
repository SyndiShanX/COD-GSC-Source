/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_ar.gsc
**************************************/

init() {
  precachestring(&"ar_activate_target");
  precachestring(&"ar_show_target");
  precachestring(&"ar_hide_target");
  level.ar_target_id = 0;
}

add_ar_target(entity, infostring, visibleradius, activateradius, offset) {
  targetid = level.ar_target_id;
  level.ar_target_id++;
  self thread ar_target_think(targetid, entity, infostring, visibleradius, activateradius, offset);
  return targetid;
}

kill_ar_target(targetid) {
  level notify("kill_ar_target_" + targetid);
  luinotifyevent(&"ar_hide_target", 1, targetid);
}

ar_target_think(targetid, entity, infostring, visibleradius, activateradius, offset) {
  self endon("death");
  level endon("kill_ar_target_" + targetid);
  entityentnum = -1;

  if(isDefined(entity)) {
    entity endon("death");
    entityentnum = entity getentitynumber();
  }

  visibleradiussquared = visibleradius * visibleradius;
  activateradiussquared = activateradius * activateradius;
  visible = 0;
  activated = 0;

  if(!isDefined(offset))
    offset = (0, 0, 0);

  for(;;) {
    entityorigin = offset;

    if(isDefined(entity))
      entityorigin = entityorigin + entity.origin;

    sqdistance = distancesquared(self.origin, entityorigin);

    if(sqdistance < activateradiussquared) {
      if(!activated) {
        activated = 1;
        visible = 0;
        luinotifyevent(&"ar_activate_target", 6, targetid, entityentnum, infostring, int(offset[0]), int(offset[1]), int(offset[2]));
      }
    } else if(sqdistance < visibleradiussquared) {
      if(!visible) {
        activated = 0;
        visible = 1;
        luinotifyevent(&"ar_show_target", 5, targetid, entityentnum, int(offset[0]), int(offset[1]), int(offset[2]));
      }
    } else if(activated || visible) {
      activated = 0;
      visible = 0;
      luinotifyevent(&"ar_hide_target", 1, targetid);
    }

    wait 0.05;
  }
}