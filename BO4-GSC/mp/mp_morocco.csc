/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_morocco.csc
***********************************************/

#include scripts\core_common\util_shared;
#include scripts\mp\mp_morocco_scripted;
#include scripts\mp_common\load;

#namespace mp_morocco;

event_handler[level_init] main(eventstruct) {
  level.draftxcam = #"ui_cam_draft_common";
  level.var_482af62e = #"hash_12263e5d70551bf9";
  setsaveddvar(#"enable_global_wind", 1);
  setsaveddvar(#"wind_global_vector", "88 0 0");
  setsaveddvar(#"wind_global_low_altitude", 0);
  setsaveddvar(#"wind_global_hi_altitude", 10000);
  setsaveddvar(#"wind_global_low_strength_percent", 100);
  load::main();
  level.domflagbasefxoverride = &dom_flag_base_fx_override;
  level.domflagcapfxoverride = &dom_flag_cap_fx_override;
  util::waitforclient(0);
}

dom_flag_base_fx_override(flag, team) {
  switch (flag.name) {
    case #"a":
      if(team == #"neutral") {
        return "ui/fx_dom_marker_neutral_r120";
      } else {
        return "ui/fx_dom_marker_team_r120";
      }

      break;
    case #"b":
      if(team == #"neutral") {
        return "ui/fx_dom_marker_neutral_r120";
      } else {
        return "ui/fx_dom_marker_team_r120";
      }

      break;
    case #"c":
      if(team == #"neutral") {
        return "ui/fx_dom_marker_neutral_r120";
      } else {
        return "ui/fx_dom_marker_team_r120";
      }

      break;
  }
}

dom_flag_cap_fx_override(flag, team) {
  switch (flag.name) {
    case #"a":
      if(team == #"neutral") {
        return "ui/fx_dom_cap_indicator_neutral_r120";
      } else {
        return "ui/fx_dom_cap_indicator_team_r120";
      }

      break;
    case #"b":
      if(team == #"neutral") {
        return "ui/fx_dom_cap_indicator_neutral_r120";
      } else {
        return "ui/fx_dom_cap_indicator_team_r120";
      }

      break;
    case #"c":
      if(team == #"neutral") {
        return "ui/fx_dom_cap_indicator_neutral_r120";
      } else {
        return "ui/fx_dom_cap_indicator_team_r120";
      }

      break;
  }
}