/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_russianbase.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\load;

#namespace mp_russianbase;

event_handler[level_init] main(eventstruct) {
  clientfield::register("scriptmover", "center_explosion_rope_pulse", 1, 1, "counter", &center_explosion_rope_pulse, 0, 0);
  setsaveddvar(#"enable_global_wind", 1);
  setsaveddvar(#"wind_global_vector", "88 0 0");
  setsaveddvar(#"wind_global_low_altitude", 0);
  setsaveddvar(#"wind_global_hi_altitude", 10000);
  setsaveddvar(#"wind_global_low_strength_percent", 100);
  level.draftxcam = #"ui_cam_draft_common";
  level.var_482af62e = #"hash_12263e5d70551bf9";
  callback::on_localclient_connect(&on_localclient_connect);
  callback::on_gameplay_started(&on_gameplay_started);
  callback::on_end_game(&on_end_game);
  load::main();
  level.domflagbasefxoverride = &dom_flag_base_fx_override;
  level.domflagcapfxoverride = &dom_flag_cap_fx_override;
  level.var_4970b0af = 1;
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
  level thread function_bfd25720(localclientnum);
  waitframe(1);
  setpbgactivebank(localclientnum, 1);
}

on_end_game(localclientnum) {
  level notify(#"hash_6a45a7996febf687");
}

center_explosion_rope_pulse(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  ropepulse(self.origin, 1, 1024, 50, 120);
}

function_bfd25720(localclientnum) {
  level endon(#"hash_6a45a7996febf687");
  a_v_pa[0] = (-1680, -43, 618);
  a_v_pa[1] = (-1694, 1548, 771);
  a_v_pa[2] = (-1229, 1645, 293);
  a_v_pa[3] = (129, 1054, 491);
  a_v_pa[4] = (138, -36, 504);
  a_v_pa[5] = (974, -630, 501);

  while(true) {
    wait randomintrange(120, 180);

    foreach(v_pa in a_v_pa) {
      playSound(localclientnum, #"hash_5e4a6db5676d1cbd", v_pa);
    }
  }
}