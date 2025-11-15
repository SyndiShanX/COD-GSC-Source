/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\mp_chinatown.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_load;
#using scripts\mp\_util;
#using scripts\mp\mp_chinatown_fx;
#using scripts\mp\mp_chinatown_sound;
#using scripts\shared\util_shared;
#namespace mp_chinatown;

function main() {
  mp_chinatown_fx::main();
  mp_chinatown_sound::main();
  level.disablefxaniminsplitscreencount = 3;
  load::main();
  level.domflagbasefxoverride = & dom_flag_base_fx_override;
  level.domflagcapfxoverride = & dom_flag_cap_fx_override;
  util::waitforclient(0);
  level.endgamexcamname = "ui_cam_endgame_mp_chinatown";
  level.var_283122e6 = & function_ea38265c;
}

function function_ea38265c(scriptbundlename) {
  if(isDefined(level.localplayers) && level.localplayers.size < 2) {
    return false;
  }
  if(issubstr(scriptbundlename, "p7_fxanim_gp_shutter")) {
    return true;
  }
  if(issubstr(scriptbundlename, "p7_fxanim_gp_trash")) {
    return true;
  }
  return false;
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
        return "ui/fx_dom_marker_neutral_r120";
      } else {
        return "ui/fx_dom_marker_team_r120";
      }
      break;
    }
    case "c": {
      if(team == "neutral") {
        return "ui/fx_dom_marker_neutral_r120";
      } else {
        return "ui/fx_dom_marker_team_r120";
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
        return "ui/fx_dom_cap_indicator_neutral_r120";
      } else {
        return "ui/fx_dom_cap_indicator_team_r120";
      }
      break;
    }
    case "c": {
      if(team == "neutral") {
        return "ui/fx_dom_cap_indicator_neutral_r120";
      } else {
        return "ui/fx_dom_cap_indicator_team_r120";
      }
      break;
    }
  }
}