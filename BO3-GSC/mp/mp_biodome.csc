/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\mp_biodome.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_load;
#using scripts\mp\_util;
#using scripts\mp\mp_biodome_fx;
#using scripts\mp\mp_biodome_sound;
#using scripts\shared\util_shared;
#namespace namespace_86fa17e8;

function main() {
  namespace_d22f7529::main();
  namespace_8911e65c::main();
  load::main();
  level.domflagbasefxoverride = &dom_flag_base_fx_override;
  level.domflagcapfxoverride = &dom_flag_cap_fx_override;
  setdvar("phys_buoyancy", 1);
  setdvar("phys_ragdoll_buoyancy", 1);
  util::waitforclient(0);
  level.endgamexcamname = "ui_cam_endgame_mp_biodome";
}

function dom_flag_base_fx_override(flag, team) {
  switch (flag.name) {
    case "a": {
      if(team == "neutral") {
        return "ui/fx_dom_marker_neutral_r120";
      } else {
        return "ui/fx_dom_marker_team_r120";
      }
      break;
    }
    case "b": {
      if(team == "neutral") {
        return "ui/fx_dom_marker_neutral_r90";
      } else {
        return "ui/fx_dom_marker_team_r90";
      }
      break;
    }
    case "c": {
      if(team == "neutral") {
        return "ui/fx_dom_marker_neutral_r90";
      } else {
        return "ui/fx_dom_marker_team_r90";
      }
      break;
    }
  }
}

function dom_flag_cap_fx_override(flag, team) {
  switch (flag.name) {
    case "a": {
      if(team == "neutral") {
        return "ui/fx_dom_cap_indicator_neutral_r120";
      } else {
        return "ui/fx_dom_cap_indicator_team_r120";
      }
      break;
    }
    case "b": {
      if(team == "neutral") {
        return "ui/fx_dom_cap_indicator_neutral_r90";
      } else {
        return "ui/fx_dom_cap_indicator_team_r90";
      }
      break;
    }
    case "c": {
      if(team == "neutral") {
        return "ui/fx_dom_cap_indicator_neutral_r90";
      } else {
        return "ui/fx_dom_cap_indicator_team_r90";
      }
      break;
    }
  }
}