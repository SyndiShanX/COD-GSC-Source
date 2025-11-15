/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\koth.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_shoutcaster;
#using scripts\shared\clientfield_shared;
#using scripts\shared\util_shared;
#namespace koth;

function main() {
  level.current_zone = [];
  level.current_state = [];
  for(i = 0; i < 4; i++) {
    level.current_zone[i] = 0;
    level.current_state[i] = 0;
  }
  level.hardpoints = [];
  level.visuals = [];
  level.hardpointfx = [];
  clientfield::register("world", "hardpoint", 1, 5, "int", & hardpoint, 0, 0);
  clientfield::register("world", "hardpointteam", 1, 5, "int", & hardpoint_state, 0, 0);
  level.effect_scriptbundles = [];
  level.effect_scriptbundles["zoneEdgeMarker"] = struct::get_script_bundle("teamcolorfx", "teamcolorfx_koth_edge_marker");
  level.effect_scriptbundles["zoneEdgeMarkerWndw"] = struct::get_script_bundle("teamcolorfx", "teamcolorfx_koth_edge_marker_window");
  level._effect["zoneEdgeMarker"] = [];
  level._effect["zoneEdgeMarker"][0] = "ui/fx_koth_marker_neutral";
  level._effect["zoneEdgeMarker"][1] = "ui/fx_koth_marker_blue";
  level._effect["zoneEdgeMarker"][2] = "ui/fx_koth_marker_orng";
  level._effect["zoneEdgeMarker"][3] = "ui/fx_koth_marker_contested";
  level._effect["zoneEdgeMarkerWndw"] = [];
  level._effect["zoneEdgeMarkerWndw"][0] = "ui/fx_koth_marker_neutral_window";
  level._effect["zoneEdgeMarkerWndw"][1] = "ui/fx_koth_marker_blue_window";
  level._effect["zoneEdgeMarkerWndw"][2] = "ui/fx_koth_marker_orng_window";
  level._effect["zoneEdgeMarkerWndw"][3] = "ui/fx_koth_marker_contested_window";
}

function get_shoutcaster_fx(local_client_num) {
  effects = [];
  effects["zoneEdgeMarker"][0] = level._effect["zoneEdgeMarker"][0];
  effects["zoneEdgeMarker"][3] = level._effect["zoneEdgeMarker"][3];
  effects["zoneEdgeMarkerWndw"][0] = level._effect["zoneEdgeMarkerWndw"][0];
  effects["zoneEdgeMarkerWndw"][3] = level._effect["zoneEdgeMarkerWndw"][3];
  if(getdvarint("tu11_programaticallyColoredGameFX")) {
    effects["zoneEdgeMarker"][1] = "ui/fx_koth_marker_white";
    effects["zoneEdgeMarker"][2] = "ui/fx_koth_marker_white";
    effects["zoneEdgeMarkerWndw"][1] = "ui/fx_koth_marker_white_window";
    effects["zoneEdgeMarkerWndw"][2] = "ui/fx_koth_marker_white_window";
  } else {
    caster_effects = [];
    caster_effects["zoneEdgeMarker"] = shoutcaster::get_color_fx(local_client_num, level.effect_scriptbundles["zoneEdgeMarker"]);
    caster_effects["zoneEdgeMarkerWndw"] = shoutcaster::get_color_fx(local_client_num, level.effect_scriptbundles["zoneEdgeMarkerWndw"]);
    effects["zoneEdgeMarker"][1] = caster_effects["zoneEdgeMarker"]["allies"];
    effects["zoneEdgeMarker"][2] = caster_effects["zoneEdgeMarker"]["axis"];
    effects["zoneEdgeMarkerWndw"][1] = caster_effects["zoneEdgeMarkerWndw"]["allies"];
    effects["zoneEdgeMarkerWndw"][2] = caster_effects["zoneEdgeMarkerWndw"]["axis"];
  }
  return effects;
}

function get_fx_state(local_client_num, state, is_shoutcaster) {
  if(is_shoutcaster) {
    return state;
  }
  if(state == 1) {
    if(util::friend_not_foe_team(local_client_num, "allies")) {
      return 1;
    }
    return 2;
  }
  if(state == 2) {
    if(util::friend_not_foe_team(local_client_num, "axis")) {
      return 1;
    }
    return 2;
  }
  return state;
}

function get_fx(fx_name, fx_state, effects) {
  return effects[fx_name][fx_state];
}

function setup_hardpoint_fx(local_client_num, zone_index, state) {
  effects = [];
  if(shoutcaster::is_shoutcaster_using_team_identity(local_client_num)) {
    effects = get_shoutcaster_fx(local_client_num);
  } else {
    effects["zoneEdgeMarker"] = level._effect["zoneEdgeMarker"];
    effects["zoneEdgeMarkerWndw"] = level._effect["zoneEdgeMarkerWndw"];
  }
  if(isDefined(level.hardpointfx[local_client_num])) {
    foreach(fx in level.hardpointfx[local_client_num]) {
      stopfx(local_client_num, fx);
    }
  }
  level.hardpointfx[local_client_num] = [];
  if(zone_index) {
    if(isDefined(level.visuals[zone_index])) {
      fx_state = get_fx_state(local_client_num, state, shoutcaster::is_shoutcaster(local_client_num));
      foreach(visual in level.visuals[zone_index]) {
        if(!isDefined(visual.script_fxid)) {
          continue;
        }
        fxid = get_fx(visual.script_fxid, fx_state, effects);
        if(isDefined(visual.angles)) {
          forward = anglesToForward(visual.angles);
        } else {
          forward = (0, 0, 0);
        }
        fxhandle = playFX(local_client_num, fxid, visual.origin, forward);
        level.hardpointfx[local_client_num][level.hardpointfx[local_client_num].size] = fxhandle;
        if(isDefined(fxhandle)) {
          if(state == 1) {
            setfxteam(local_client_num, fxhandle, "allies");
            continue;
          }
          if(state == 2) {
            setfxteam(local_client_num, fxhandle, "axis");
            continue;
          }
          setfxteam(local_client_num, fxhandle, "free");
        }
      }
    }
  }
  thread watch_for_team_change(local_client_num);
}

function hardpoint(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(level.hardpoints.size == 0) {
    hardpoints = struct::get_array("koth_zone_center", "targetname");
    foreach(point in hardpoints) {
      level.hardpoints[point.script_index] = point;
    }
    foreach(point in level.hardpoints) {
      level.visuals[point.script_index] = struct::get_array(point.target, "targetname");
    }
  }
  level.current_zone[localclientnum] = newval;
  level.current_state[localclientnum] = 0;
  setup_hardpoint_fx(localclientnum, level.current_zone[localclientnum], level.current_state[localclientnum]);
}

function hardpoint_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval != level.current_state[localclientnum]) {
    level.current_state[localclientnum] = newval;
    setup_hardpoint_fx(localclientnum, level.current_zone[localclientnum], level.current_state[localclientnum]);
  }
}

function watch_for_team_change(localclientnum) {
  level notify("end_team_change_watch");
  level endon("end_team_change_watch");
  level waittill("team_changed");
  wait(0.05);
  thread setup_hardpoint_fx(localclientnum, level.current_zone[localclientnum], level.current_state[localclientnum]);
}