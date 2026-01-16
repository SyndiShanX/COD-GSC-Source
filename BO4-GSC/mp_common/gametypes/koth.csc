/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\koth.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\shoutcaster;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\mp_common\gametypes\ct_tutorial_skirmish;

#namespace koth;

event_handler[gametype_init] main(eventstruct) {
  level.current_zone = [];
  level.current_state = [];

  for(i = 0; i < 4; i++) {
    level.current_zone[i] = 0;
    level.current_state[i] = 0;
  }

  level.hardpoints = [];
  level.visuals = [];
  level.hardpointfx = [];
  clientfield::register("world", "hardpoint", 1, 5, "int", &hardpoint, 0, 0);
  clientfield::register("world", "hardpointteam", 1, 5, "int", &hardpoint_state, 0, 0);
  level._effect[#"zoneedgemarker"] = [];
  level._effect[#"zoneedgemarker"][0] = #"ui/fx8_infil_marker_neutral";
  level._effect[#"zoneedgemarker"][1] = #"hash_5c2ae9f4f331d4b9";
  level._effect[#"zoneedgemarker"][2] = #"hash_7d1b0f001ea88b82";
  level._effect[#"zoneedgemarker"][3] = #"hash_7981eb245ea536fc";
  level._effect[#"zoneedgemarkerwndw"] = [];
  level._effect[#"zoneedgemarkerwndw"][0] = #"ui/fx8_infil_marker_neutral_window";
  level._effect[#"zoneedgemarkerwndw"][1] = #"hash_5565c3fc2c7742fe";
  level._effect[#"zoneedgemarkerwndw"][2] = #"hash_3283b765fe480df7";
  level._effect[#"zoneedgemarkerwndw"][3] = #"hash_6a512c225256a2e9";
  callback::on_spawned(&function_df78674f);

  if(util::function_8570168d()) {
    ct_tutorial_skirmish::init();
  }
}

function_df78674f() {
  localclientnum = self getlocalclientnumber();

  if(isDefined(localclientnum) && isDefined(level.current_zone) && isDefined(level.current_state)) {
    setup_hardpoint_fx(localclientnum, level.current_zone[localclientnum], level.current_state[localclientnum]);
  }
}

get_shoutcaster_fx(local_client_num) {
  effects = [];
  effects[#"zoneedgemarker"] = level._effect[#"zoneedgemarker"];
  effects[#"zoneedgemarkerwndw"] = level._effect[#"zoneedgemarkerwndw"];
  effects[#"zoneedgemarker"][1] = #"ui/fx8_infil_marker_shoutcaster_allies";
  effects[#"zoneedgemarker"][2] = #"ui/fx8_infil_marker_shoutcaster_axis";
  effects[#"zoneedgemarker"][3] = [];
  effects[#"zoneedgemarker"][3][1] = #"hash_2d6240bcbe378735";
  effects[#"zoneedgemarker"][3][2] = #"hash_1485defdfe47975a";
  effects[#"zoneedgemarkerwndw"][1] = #"ui/fx8_infil_marker_shoutcaster_allies_window";
  effects[#"zoneedgemarkerwndw"][2] = #"ui/fx8_infil_marker_shoutcaster_axis_window";
  effects[#"zoneedgemarkerwndw"][3] = [];
  effects[#"zoneedgemarkerwndw"][3][1] = #"hash_3add4ab2008b6ea2";
  effects[#"zoneedgemarkerwndw"][3][2] = #"hash_49751fe881244b5f";
  return effects;
}

get_fx_state(local_client_num, state, is_shoutcaster) {
  if(is_shoutcaster) {
    return state;
  }

  if(state == 1) {
    if(function_9b3f0ed1(local_client_num) == #"allies") {
      return 1;
    } else {
      return 2;
    }
  } else if(state == 2) {
    if(function_9b3f0ed1(local_client_num) == #"axis") {
      return 1;
    } else {
      return 2;
    }
  }

  return state;
}

get_fx(fx_name, fx_state, effects) {
  return effects[fx_name][fx_state];
}

setup_hardpoint_fx(local_client_num, zone_index, state) {
  effects = [];

  if(shoutcaster::is_shoutcaster_using_team_identity(local_client_num)) {
    effects = get_shoutcaster_fx(local_client_num);
  } else {
    effects[#"zoneedgemarker"] = level._effect[#"zoneedgemarker"];
    effects[#"zoneedgemarkerwndw"] = level._effect[#"zoneedgemarkerwndw"];
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

        if(isarray(fxid)) {
          state = 1;
          function_ca8ebccf(local_client_num, visual, fxid[state], state);
          state = 2;
          function_ca8ebccf(local_client_num, visual, fxid[state], state);
          continue;
        }

        function_ca8ebccf(local_client_num, visual, fxid, state);
      }
    }
  }

  thread watch_for_team_change(local_client_num);
}

private function_ca8ebccf(local_client_num, visual, fxid, state) {
  if(isDefined(visual.angles)) {
    forward = anglesToForward(visual.angles);
  } else {
    forward = (0, 0, 0);
  }

  fxhandle = playFX(local_client_num, fxid, visual.origin, forward);
  level.hardpointfx[local_client_num][level.hardpointfx[local_client_num].size] = fxhandle;

  if(isDefined(fxhandle)) {
    if(state == 1) {
      setfxteam(local_client_num, fxhandle, #"allies");
      return;
    }

    if(state == 2) {
      setfxteam(local_client_num, fxhandle, #"axis");
      return;
    }

    setfxteam(local_client_num, fxhandle, "free");
  }
}

hardpoint(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
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

hardpoint_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval != level.current_state[localclientnum]) {
    level.current_state[localclientnum] = newval;
    setup_hardpoint_fx(localclientnum, level.current_zone[localclientnum], level.current_state[localclientnum]);
  }
}

watch_for_team_change(localclientnum) {
  level notify(#"end_team_change_watch");
  level endon(#"end_team_change_watch");
  level waittill(#"team_changed");
  thread setup_hardpoint_fx(localclientnum, level.current_zone[localclientnum], level.current_state[localclientnum]);
}