/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_seaside.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\mp\mp_seaside_fx;
#include scripts\mp\mp_seaside_sound;
#include scripts\mp_common\load;

#namespace mp_seaside;

event_handler[level_init] main(eventstruct) {
  level.draftxcam = #"ui_cam_draft_common";
  level.var_482af62e = #"hash_12263e5d70551bf9";
  callback::on_localclient_connect(&on_localclient_connect);
  callback::on_gameplay_started(&on_gameplay_started);
  callback::on_localplayer_spawned(&on_localclient_spawned);
  clientfield::register("world", "remove_blood_decals", 1, 1, "int", &remove_blood_decals, 1, 0);
  clientfield::register("vehicle", "hide_tank_rob", 1, 1, "int", &hide_tank_rob, 1, 0);
  mp_seaside_fx::main();
  mp_seaside_sound::main();
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
        return "ui/fx_dom_marker_neutral_r90";
      } else {
        return "ui/fx_dom_marker_team_r90";
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
        return "ui/fx_dom_cap_indicator_neutral_r90";
      } else {
        return "ui/fx_dom_cap_indicator_team_r90";
      }

      break;
  }
}

on_localclient_connect(localclientnum) {
  waitresult = level waittill(#"positiondraft_open", #"hash_7b06b53a1ed7cfc4", #"disconnect");

  if(waitresult._notify === "PositionDraft_Open") {
    setpbgactivebank(localclientnum, 8);
    var_6d963dbf = findstaticmodelindexarray("spawn_flavor_tank");

    foreach(n_index in var_6d963dbf) {
      hidestaticmodel(n_index);
    }
  }
}

hide_tank_rob(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(!isDefined(level.var_f55e70b)) {
      level.var_f55e70b = [];
    }

    if(!isDefined(level.var_f55e70b)) {
      level.var_f55e70b = [];
    } else if(!isarray(level.var_f55e70b)) {
      level.var_f55e70b = array(level.var_f55e70b);
    }

    level.var_f55e70b[level.var_f55e70b.size] = self;
  }
}

on_localclient_spawned(localclientnum) {
  thread function_88a882af();
}

function_88a882af() {
  waitframe(1);

  if(!isDefined(level.var_f55e70b)) {
    return;
  }

  if(!isDefined(level.var_f55e70b[0])) {
    callback::remove_on_localplayer_spawned(&on_localclient_spawned);
    return;
  }

  foreach(tank in level.var_f55e70b) {
    tank stoprenderoverridebundle("rob_sonar_set_enemyequip");
    tank stoprenderoverridebundle("rob_sonar_set_enemy");
    tank playrenderoverridebundle("rob_sonar_set_enemy_cold");
  }
}

on_gameplay_started(localclientnum) {
  level notify(#"hash_7b06b53a1ed7cfc4");
  var_6d963dbf = findstaticmodelindexarray("spawn_flavor_tank");

  foreach(n_index in var_6d963dbf) {
    unhidestaticmodel(n_index);
  }

  waitframe(1);
  setpbgactivebank(localclientnum, 1);
}

remove_blood_decals(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    a_decals = findvolumedecalindexarray("recon_blood");

    foreach(decal in a_decals) {
      hidevolumedecal(decal);
    }
  }
}