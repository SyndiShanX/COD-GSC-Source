/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_madagascar.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\util_shared;
#include scripts\mp\mp_madagascar_fx;
#include scripts\mp\mp_madagascar_sound;
#include scripts\mp_common\load;
#include scripts\mp_common\util;

#namespace mp_madagascar;

event_handler[level_init] main(eventstruct) {
  setsaveddvar(#"enable_global_wind", 1);
  setsaveddvar(#"wind_global_vector", "88 0 0");
  setsaveddvar(#"wind_global_low_altitude", 0);
  setsaveddvar(#"wind_global_hi_altitude", 10000);
  setsaveddvar(#"wind_global_low_strength_percent", 100);
  level.draftxcam = #"ui_cam_draft_common";
  level.var_482af62e = #"hash_12263e5d70551bf9";
  callback::on_localclient_connect(&on_localclient_connect);
  callback::on_gameplay_started(&on_gameplay_started);
  mp_madagascar_fx::main();
  mp_madagascar_sound::main();
  load::main();
  level.domflagbasefxoverride = &dom_flag_base_fx_override;
  level.domflagcapfxoverride = &dom_flag_cap_fx_override;
  util::waitforclient(0);
}

on_localclient_connect(localclientnum) {
  waitframe(1);
  setpbgactivebank(localclientnum, 8);
}

on_gameplay_started(localclientnum) {
  waitframe(1);
  setpbgactivebank(localclientnum, 1);
}

dom_flag_base_fx_override(flag, team) {
  switch (flag.name) {
    case #"a":
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