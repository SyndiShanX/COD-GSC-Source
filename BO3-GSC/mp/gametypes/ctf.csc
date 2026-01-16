/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\ctf.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_shoutcaster;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\util_shared;
#namespace ctf;

function main() {
  callback::on_localclient_connect( & on_localclient_connect);
}

function on_localclient_connect(localclientnum) {
  objective_ids = [];
  while (!isdefined(objective_ids["allies_base"])) {
    objective_ids["allies_base"] = serverobjective_getobjective(localclientnum, "allies_base");
    objective_ids["axis_base"] = serverobjective_getobjective(localclientnum, "axis_base");
    wait(0.05);
  }
  foreach(key, objective in objective_ids) {
    level.ctfflags[key] = spawnstruct();
    level.ctfflags[key].objectiveid = objective;
    setup_flag(localclientnum, level.ctfflags[key]);
  }
  setup_fx(localclientnum);
}

function setup_flag(localclientnum, flag) {
  flag.origin = serverobjective_getobjectiveorigin(localclientnum, flag.objectiveid);
  flag_entity = serverobjective_getobjectiveentity(localclientnum, flag.objectiveid);
  flag.angles = (0, 0, 0);
  if(isdefined(flag_entity)) {
    flag.origin = flag_entity.origin;
    flag.angles = flag_entity.angles;
  }
  flag.team = serverobjective_getobjectiveteam(localclientnum, flag.objectiveid);
}

function setup_flag_fx(localclientnum, flag, effects) {
  if(isdefined(flag.base_fx)) {
    stopfx(localclientnum, flag.base_fx);
  }
  up = anglestoup(flag.angles);
  forward = anglestoforward(flag.angles);
  flag.base_fx = playfx(localclientnum, effects[flag.team], flag.origin, up, forward);
  setfxteam(localclientnum, flag.base_fx, flag.team);
  thread watch_for_team_change(localclientnum);
}

function setup_fx(localclientnum) {
  effects = [];
  if(shoutcaster::is_shoutcaster_using_team_identity(localclientnum)) {
    if(getdvarint("tu11_programaticallyColoredGameFX")) {
      effects["allies"] = "ui/fx_ctf_flag_base_white";
      effects["axis"] = "ui/fx_ctf_flag_base_white";
    } else {
      effects = shoutcaster::get_color_fx(localclientnum, level.effect_scriptbundle);
    }
  } else {
    effects["allies"] = "ui/fx_ctf_flag_base_team";
    effects["axis"] = "ui/fx_ctf_flag_base_team";
  }
  foreach(flag in level.ctfflags) {
    thread setup_flag_fx(localclientnum, flag, effects);
  }
}

function watch_for_team_change(localclientnum) {
  level notify("end_team_change_watch");
  level endon("end_team_change_watch");
  level waittill("team_changed");
  thread setup_fx(localclientnum);
}