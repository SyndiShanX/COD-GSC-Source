/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_offshore_alt.csc
***********************************************/

#include scripts\core_common\util_shared;
#include scripts\mp\mp_offshore_alt_fx;
#include scripts\mp\mp_offshore_alt_player_rain;
#include scripts\mp\mp_offshore_alt_sound;
#include scripts\mp_common\load;

#namespace mp_offshore_alt;

event_handler[level_init] main(eventstruct) {
  level.draftxcam = #"ui_cam_draft_common";
  level.var_482af62e = #"hash_12263e5d70551bf9";
  mp_offshore_alt_fx::main();
  mp_offshore_alt_sound::main();
  load::main();
  level.domflagbasefxoverride = &dom_flag_base_fx_override;
  level.domflagcapfxoverride = &dom_flag_cap_fx_override;
  util::waitforclient(0);
  level.endgamexcamname = "ui_cam_endgame_mp_common";
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

on_localclient_connect(localclientnum) {
  waitframe(1);
  setpbgactivebank(localclientnum, 8);
}

on_gameplay_started(localclientnum) {
  waitframe(1);
  setpbgactivebank(localclientnum, 1);
}