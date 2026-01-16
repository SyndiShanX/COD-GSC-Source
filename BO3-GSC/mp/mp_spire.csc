/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\mp_spire.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_load;
#using scripts\mp\mp_spire_amb;
#using scripts\mp\mp_spire_fx;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\util_shared;
#namespace mp_spire;

function main() {
  clientfield::register("world", "mpSpireExteriorBillboard", 1, 2, "int", & exteriorbillboard, 1, 1);
  level.disablefxaniminsplitscreencount = 3;
  load::main();
  level.domflagbasefxoverride = & dom_flag_base_fx_override;
  level.domflagcapfxoverride = & dom_flag_cap_fx_override;
  mp_spire_fx::main();
  thread mp_spire_amb::main();
  util::waitforclient(0);
  level.endgamexcamname = "ui_cam_endgame_mp_spire";
  println("");
}

function exteriorbillboard(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}

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