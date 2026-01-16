/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\mp_nuketown_x.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_load;
#using scripts\mp\_util;
#using scripts\mp\mp_nuketown_x_fx;
#using scripts\mp\mp_nuketown_x_sound;
#using scripts\shared\clientfield_shared;
#using scripts\shared\util_shared;
#namespace mp_nuketown_x;

function main() {
  clientfield::register("scriptmover", "nuketown_population_ones", 1, 4, "int", & function_a3fc1001, 0, 0);
  clientfield::register("scriptmover", "nuketown_population_tens", 1, 4, "int", & function_a3fc1001, 0, 0);
  clientfield::register("world", "nuketown_endgame", 1, 1, "int", & function_db2629eb, 0, 0);
  namespace_6044bb60::main();
  namespace_4cda09f7::main();
  load::main();
  level.domflagbasefxoverride = & dom_flag_base_fx_override;
  level.domflagcapfxoverride = & dom_flag_cap_fx_override;
  util::waitforclient(0);
  level.endgamexcamname = "ui_cam_endgame_mp_nuketown";
}

function function_db2629eb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    setdvar("", 0);
    setdvar("", 10.64);
  } else {
    setdvar("", 1);
  }
}

function function_a3fc1001(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self mapshaderconstant(localclientnum, 0, "scriptVector0", newval, 0, 0, 0);
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