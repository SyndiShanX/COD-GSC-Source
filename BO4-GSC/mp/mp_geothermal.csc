/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_geothermal.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\util_shared;
#include scripts\mp\mp_geothermal_fx;
#include scripts\mp\mp_geothermal_sound;
#include scripts\mp_common\load;

#namespace mp_geothermal;

event_handler[level_init] main(eventstruct) {
  clientfield::register("toplayer", "toggle_player_steam", 1, 1, "int", &toggle_player_steam, 0, 0);
  level.draftxcam = #"ui_cam_draft_common";
  level.var_482af62e = #"hash_12263e5d70551bf9";
  callback::on_localclient_connect(&on_localclient_connect);
  callback::on_gameplay_started(&on_gameplay_started);
  mp_geothermal_fx::main();
  mp_geothermal_sound::main();
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

on_localclient_connect(localclientnum) {
  waitframe(1);
  setpbgactivebank(localclientnum, 8);
}

on_gameplay_started(localclientnum) {
  waitframe(1);
  setpbgactivebank(localclientnum, 1);
}

toggle_player_steam(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(self !== function_5c10bd79(localclientnum)) {
    return;
  }

  if(newval) {
    if(!self postfx::function_556665f2("pstfx_sprite_rain_loop_sparse")) {
      self postfx::playpostfxbundle("pstfx_sprite_rain_loop_sparse");
      self playrumblelooponentity(localclientnum, "tank_rumble");
    }

    return;
  }

  self postfx::stoppostfxbundle("pstfx_sprite_rain_loop_sparse");
  self stoprumble(localclientnum, "tank_rumble");
}