/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\escort.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\duplicaterender_mgr;
#include scripts\core_common\shoutcaster;
#include scripts\core_common\util_shared;

#namespace escort;

event_handler[gametype_init] main(eventstruct) {
  clientfield::register("actor", "escort_robot_burn", 6000, 1, "int", &robot_burn, 0, 0);
  clientfield::register("worlduimodel", "Escort.robotProgress", 6000, 7, "float", undefined, 0, 0);
  clientfield::register("worlduimodel", "Escort.robotMoving", 6000, 1, "int", undefined, 0, 0);
  callback::on_localclient_connect(&on_localclient_connect);
}

on_localclient_connect(localclientnum) {
  conmodel = getuimodelforcontroller(localclientnum);
  setuimodelvalue(createuimodel(conmodel, "Escort.robotIsEnemy"), 0);
  setuimodelvalue(createuimodel(conmodel, "Escort.robotRebooting"), 0);
  level wait_team_changed(localclientnum);
}

robot_burn(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    fxhandles = playtagfxset(localclientnum, "escort_robot_burn", self);
    self thread watch_fx_shutdown(localclientnum, fxhandles);
  }
}

watch_fx_shutdown(localclientnum, fxhandles) {
  wait 3;

  foreach(fx in fxhandles) {
    stopfx(localclientnum, fx);
  }
}

wait_team_changed(localclientnum) {
  while(true) {
    level waittill(#"team_changed");

    if(!isDefined(level.escortrobots)) {
      continue;
    }

    foreach(robot in level.escortrobots) {
      if(isDefined(robot)) {
        robot thread update_robot_team(localclientnum);
      }
    }
  }
}

update_robot_team(localclientnum) {
  localplayerteam = function_73f4b33(localclientnum);

  if(shoutcaster::is_shoutcaster(localclientnum)) {
    friend = self shoutcaster::is_friendly(localclientnum);
  } else {
    friend = self.team == localplayerteam;
  }

  if(friend) {
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "escortGametype.enemyRobot"), 0);
  } else {
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "escortGametype.enemyRobot"), 1);
  }

  self duplicate_render::set_dr_flag("enemyvehicle_fb", !friend);
  localplayer = function_5c10bd79(localclientnum);
  localplayer duplicate_render::update_dr_filters(localclientnum);
}