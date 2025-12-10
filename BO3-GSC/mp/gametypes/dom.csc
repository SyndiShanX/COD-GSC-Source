/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\dom.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\util_shared;
#namespace dom;

function main() {
  callback::on_localclient_connect(&on_localclient_connect);
  if(getgametypesetting("silentPlant") != 0) {
    setsoundcontext("bomb_plant", "silent");
  }
}

function on_localclient_connect(localclientnum) {
  self.domflags = [];
  while(!isDefined(level.domflags["a"])) {
    self.domflags["a"] = serverobjective_getobjective(localclientnum, "dom_a");
    self.domflags["b"] = serverobjective_getobjective(localclientnum, "dom_b");
    self.domflags["c"] = serverobjective_getobjective(localclientnum, "dom_c");
    wait(0.05);
  }
  foreach(key, flag_objective in self.domflags) {
    self thread monitor_flag_fx(localclientnum, flag_objective, key);
  }
}

function monitor_flag_fx(localclientnum, flag_objective, flag_name) {
  if(!isDefined(flag_objective)) {
    return;
  }
  flag = spawnStruct();
  flag.name = flag_name;
  flag.objectiveid = flag_objective;
  flag.origin = serverobjective_getobjectiveorigin(localclientnum, flag_objective);
  flag.angles = (0, 0, 0);
  flag_entity = serverobjective_getobjectiveentity(localclientnum, flag_objective);
  if(isDefined(flag_entity)) {
    flag.origin = flag_entity.origin;
    flag.angles = flag_entity.angles;
  }
  fx_name = get_base_fx(flag, "neutral");
  play_base_fx(localclientnum, flag, fx_name, "neutral");
  flag.last_progress = 0;
  while(true) {
    team = serverobjective_getobjectiveteam(localclientnum, flag_objective);
    if(team != flag.last_team) {
      flag update_base_fx(localclientnum, flag, team);
    }
    progress = serverobjective_getobjectiveprogress(localclientnum, flag_objective) > 0;
    if(progress != flag.last_progress) {
      flag update_cap_fx(localclientnum, flag, team, progress);
    }
    wait(0.05);
  }
}

function play_base_fx(localclientnum, flag, fx_name, team) {
  if(isDefined(flag.base_fx)) {
    stopfx(localclientnum, flag.base_fx);
  }
  up = anglestoup(flag.angles);
  forward = anglesToForward(flag.angles);
  flag.base_fx = playFX(localclientnum, fx_name, flag.origin, up, forward);
  setfxteam(localclientnum, flag.base_fx, team);
  flag.last_team = team;
}

function update_base_fx(localclientnum, flag, team) {
  fx_name = get_base_fx(flag, team);
  if(team == "neutral") {
    play_base_fx(localclientnum, flag, fx_name, team);
  } else {
    if(flag.last_team == "neutral") {
      play_base_fx(localclientnum, flag, fx_name, team);
    } else {
      setfxteam(localclientnum, flag.base_fx, team);
      flag.last_team = team;
    }
  }
}

function play_cap_fx(localclientnum, flag, fx_name, team) {
  if(isDefined(flag.cap_fx)) {
    killfx(localclientnum, flag.cap_fx);
  }
  up = anglestoup(flag.angles);
  forward = anglesToForward(flag.angles);
  flag.cap_fx = playFX(localclientnum, fx_name, flag.origin, up, forward);
  setfxteam(localclientnum, flag.cap_fx, team);
}

function update_cap_fx(localclientnum, flag, team, progress) {
  if(progress == 0) {
    if(isDefined(flag.cap_fx)) {
      killfx(localclientnum, flag.cap_fx);
    }
    flag.last_progress = progress;
    return;
  }
  fx_name = get_cap_fx(flag, team);
  play_cap_fx(localclientnum, flag, fx_name, team);
  flag.last_progress = progress;
}

function get_base_fx(flag, team) {
  if(isDefined(level.domflagbasefxoverride)) {
    fx = [[level.domflagbasefxoverride]](flag, team);
    if(isDefined(fx)) {
      return fx;
    }
  }
  if(team == "neutral") {
    return "ui/fx_dom_marker_neutral";
  }
  return "ui/fx_dom_marker_team";
}

function get_cap_fx(flag, team) {
  if(isDefined(level.domflagcapfxoverride)) {
    fx = [[level.domflagcapfxoverride]](flag, team);
    if(isDefined(fx)) {
      return fx;
    }
  }
  if(team == "neutral") {
    return "ui/fx_dom_cap_indicator_neutral";
  }
  return "ui/fx_dom_cap_indicator_team";
}