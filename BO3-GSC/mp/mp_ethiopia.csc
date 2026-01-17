/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\mp_ethiopia.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_load;
#using scripts\mp\_util;
#using scripts\mp\_waterfall;
#using scripts\mp\mp_ethiopia_fx;
#using scripts\mp\mp_ethiopia_sound;
#using scripts\shared\callbacks_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\shared\water_surface;
#namespace mp_ethiopia;

function main() {
  mp_ethiopia_fx::main();
  mp_ethiopia_sound::main();
  load::main();
  level.domflagbasefxoverride = &dom_flag_base_fx_override;
  level.domflagcapfxoverride = &dom_flag_cap_fx_override;
  util::waitforclient(0);
  level.endgamexcamname = "ui_cam_endgame_mp_ethiopia";
  callback::on_localplayer_spawned(&waterfall::waterfalloverlay);
  callback::on_localplayer_spawned(&waterfall::waterfallmistoverlay);
  callback::on_localplayer_spawned(&waterfall::waterfallmistoverlayreset);
  setdvar("phys_buoyancy", 1);
  setdvar("phys_ragdoll_buoyancy", 1);
}

function dom_flag_base_fx_override(flag, team) {
  switch (flag.name) {
    case "a": {
      break;
    }
    case "b": {
      if(team == "neutral") {
        return "ui/fx_dom_marker_neutral_r120";
      } else {
        return "ui/fx_dom_marker_team_r120";
      }
      break;
    }
    case "c": {
      break;
    }
  }
}

function dom_flag_cap_fx_override(flag, team) {
  switch (flag.name) {
    case "a": {
      break;
    }
    case "b": {
      if(team == "neutral") {
        return "ui/fx_dom_marker_neutral_r120";
      } else {
        return "ui/fx_dom_marker_team_r120";
      }
      break;
    }
    case "c": {
      break;
    }
  }
}