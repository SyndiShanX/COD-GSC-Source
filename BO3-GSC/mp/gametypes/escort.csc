/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\escort.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_shoutcaster;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\util_shared;
#namespace escort;

function main() {
  clientfield::register("actor", "robot_state", 1, 2, "int", & robot_state_changed, 0, 1);
  clientfield::register("actor", "escort_robot_burn", 1, 1, "int", & robot_burn, 0, 0);
  callback::on_localclient_connect( & on_localclient_connect);
}

function onprecachegametype() {}

function onstartgametype() {}

function on_localclient_connect(localclientnum) {
  setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "escortGametype.robotStatusText"), & "MPUI_ESCORT_ROBOT_MOVING");
  setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "escortGametype.robotStatusVisible"), 0);
  setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "escortGametype.enemyRobot"), 0);
  level wait_team_changed(localclientnum);
}

function robot_burn(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self endon("entityshutdown");
    self util::waittill_dobj(localclientnum);
    fxhandles = playtagfxset(localclientnum, "escort_robot_burn", self);
    self thread watch_fx_shutdown(localclientnum, fxhandles);
  }
}

function watch_fx_shutdown(localclientnum, fxhandles) {
  wait(3);
  foreach(fx in fxhandles) {
    stopfx(localclientnum, fx);
  }
}

function robot_state_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bnewent) {
    if(!isDefined(level.escortrobots)) {
      level.escortrobots = [];
    } else if(!isarray(level.escortrobots)) {
      level.escortrobots = array(level.escortrobots);
    }
    level.escortrobots[level.escortrobots.size] = self;
    self thread update_robot_team(localclientnum);
  }
  if(newval == 1) {
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "escortGametype.robotStatusVisible"), 1);
  } else {
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "escortGametype.robotStatusVisible"), 0);
  }
}

function wait_team_changed(localclientnum) {
  while(true) {
    level waittill("team_changed");
    while(!isDefined(getnonpredictedlocalplayer(localclientnum))) {
      wait(0.05);
    }
    if(!isDefined(level.escortrobots)) {
      continue;
    }
    foreach(robot in level.escortrobots) {
      robot thread update_robot_team(localclientnum);
    }
  }
}

function update_robot_team(localclientnum) {
  localplayerteam = getlocalplayerteam(localclientnum);
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
  localplayer = getlocalplayer(localclientnum);
  localplayer duplicate_render::update_dr_filters(localclientnum);
}