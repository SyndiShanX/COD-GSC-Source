/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\duplicaterender_mgr.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\filter_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\shoutcaster;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace duplicate_render;

autoexec __init__system__() {
  system::register(#"duplicate_render", &__init__, undefined, undefined);
}

__init__() {
  if(!isDefined(level.drfilters)) {
    level.drfilters = [];
  }

  set_dr_filter_framebuffer("none_fb", 0, undefined, undefined, 0, 1, 0);
  set_dr_filter_framebuffer_duplicate("none_fbd", 0, undefined, undefined, 1, 0, 0);
  set_dr_filter_offscreen("none_os", 0, undefined, undefined, 2, 0, 0);
  set_dr_filter_framebuffer("frveh_fb", 8, "friendlyvehicle_fb", undefined, 0, 1, 1);
  set_dr_filter_offscreen("retrv", 5, "retrievable", undefined, 2, "mc/hud_keyline_retrievable", 1);
  set_dr_filter_offscreen("unplc", 7, "unplaceable", undefined, 2, "mc/hud_keyline_unplaceable", 1);
  set_dr_filter_offscreen("eneqp", 8, "enemyequip", undefined, 2, "mc/hud_outline_rim", 1);
  set_dr_filter_offscreen("enexp", 8, "enemyexplo", undefined, 2, "mc/hud_outline_rim", 1);
  set_dr_filter_offscreen("enveh", 8, "enemyvehicle", undefined, 2, "mc/hud_outline_rim", 1);
  set_dr_filter_offscreen("freqp", 8, "friendlyequip", undefined, 2, "mc/hud_keyline_friendlyequip", 1);
  set_dr_filter_offscreen("frexp", 8, "friendlyexplo", undefined, 2, "mc/hud_keyline_friendlyequip", 1);
  set_dr_filter_offscreen("frveh", 8, "friendlyvehicle", undefined, 2, "mc/hud_keyline_friendlyequip", 1);
  set_dr_filter_offscreen("infrared", 9, "infrared_entity", undefined, 2, 2, 1);
  set_dr_filter_offscreen("threat_detector_enemy", 10, "threat_detector_enemy", undefined, 2, "mc/hud_keyline_enemyequip", 1);
  set_dr_filter_offscreen("bcarrier", 9, "ballcarrier", undefined, 2, "mc/hud_keyline_friendlyequip", 1);
  set_dr_filter_offscreen("poption", 9, "passoption", undefined, 2, "mc/hud_keyline_friendlyequip", 1);
  set_dr_filter_offscreen("draft_unselected", 10, "draft_unselected", undefined, 0, "mc/hud_outline_model_z_scriptint", 1);
  level.friendlycontentoutlines = getdvarint(#"friendlycontentoutlines", 0);
}

on_player_spawned(local_client_num) {
  self.currentdrfilter = [];
  self change_dr_flags(local_client_num);

  if(!level flagsys::get(#"duplicaterender_registry_ready")) {
    waitframe(1);
    level flagsys::set(#"duplicaterender_registry_ready");
  }
}

set_dr_filter(filterset, name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3) {
  if(!isDefined(level.drfilters)) {
    level.drfilters = [];
  }

  if(!isDefined(level.drfilters[filterset])) {
    level.drfilters[filterset] = [];
  }

  if(!isDefined(level.drfilters[filterset][name])) {
    level.drfilters[filterset][name] = spawnStruct();
  }

  filter = level.drfilters[filterset][name];
  filter.name = name;
  filter.priority = priority * -1;

  if(!isDefined(require_flags)) {
    filter.require = [];
  } else if(isarray(require_flags)) {
    filter.require = require_flags;
  } else {
    filter.require = strtok(require_flags, ", ");
  }

  if(!isDefined(refuse_flags)) {
    filter.refuse = [];
  } else if(isarray(refuse_flags)) {
    filter.refuse = refuse_flags;
  } else {
    filter.refuse = strtok(refuse_flags, ", ");
  }

  filter.types = [];
  filter.values = [];
  filter.culling = [];
  filter.method = [];

  if(isDefined(drtype1)) {
    idx = filter.types.size;
    filter.types[idx] = drtype1;
    filter.values[idx] = drval1;
    filter.culling[idx] = drcull1;
  }

  if(isDefined(drtype2)) {
    idx = filter.types.size;
    filter.types[idx] = drtype2;
    filter.values[idx] = drval2;
    filter.culling[idx] = drcull2;
  }

  if(isDefined(drtype3)) {
    idx = filter.types.size;
    filter.types[idx] = drtype3;
    filter.values[idx] = drval3;
    filter.culling[idx] = drcull3;
  }

  thread register_filter_materials(filter);
}

set_dr_filter_framebuffer(name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3) {
  set_dr_filter("framebuffer", name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3);
}

set_dr_filter_framebuffer_duplicate(name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3) {
  set_dr_filter("framebuffer_duplicate", name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3);
}

set_dr_filter_offscreen(name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3) {
  set_dr_filter("offscreen", name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3);
}

register_filter_materials(filter) {
  playercount = undefined;
  opts = filter.types.size;

  for(i = 0; i < opts; i++) {
    value = filter.values[i];

    if(isstring(value)) {
      if(!isDefined(playercount)) {
        while(!isDefined(level.localplayers) && !isDefined(level.frontendclientconnected)) {
          waitframe(1);
        }

        if(isDefined(level.frontendclientconnected)) {
          playercount = 1;
        } else {
          util::waitforallclients();
          playercount = level.localplayers.size;
        }
      }

      if(!isDefined(filter::mapped_material_id(value))) {
        for(localclientnum = 0; localclientnum < playercount; localclientnum++) {
          filter::map_material_helper_by_localclientnum(localclientnum, value);
        }
      }
    }
  }

  filter.priority = abs(filter.priority);
}

update_dr_flag(localclientnum, toset, setto = 1) {
  if(set_dr_flag(toset, setto)) {
    update_dr_filters(localclientnum);
  }
}

set_dr_flag_not_array(toset, setto = 1) {
  if(!isDefined(self.flag) || !isDefined(self.flag[toset])) {
    self flag::init(toset);
  }

  if(setto == self.flag[toset]) {
    return false;
  }

  if(isDefined(setto) && setto) {
    self flag::set(toset);
  } else {
    self flag::clear(toset);
  }

  return true;
}

set_dr_flag(toset, setto = 1) {
  assert(isDefined(setto));

  if(isarray(toset)) {
    foreach(ts in toset) {
      set_dr_flag(ts, setto);
    }

    return;
  }

  if(!isDefined(self.flag) || !isDefined(self.flag[toset])) {
    self flag::init(toset);
  }

  if(setto == self.flag[toset]) {
    return 0;
  }

  if(isDefined(setto) && setto) {
    self flag::set(toset);
  } else {
    self flag::clear(toset);
  }

  return 1;
}

clear_dr_flag(toclear) {
  set_dr_flag(toclear, 0);
}

change_dr_flags(localclientnum, toset, toclear) {
  if(isDefined(toset)) {
    if(isstring(toset)) {
      toset = strtok(toset, ", ");
    }

    self set_dr_flag(toset);
  }

  if(isDefined(toclear)) {
    if(isstring(toclear)) {
      toclear = strtok(toclear, ", ");
    }

    self clear_dr_flag(toclear);
  }

  update_dr_filters(localclientnum);
}

_update_dr_filters(localclientnum) {
  self notify(#"update_dr_filters");
  self endon(#"update_dr_filters");
  self endon(#"death");
  waittillframeend();

  foreach(key, filterset in level.drfilters) {
    filter = self find_dr_filter(filterset);

    if(isDefined(filter) && (!isDefined(self.currentdrfilter) || !(self.currentdrfilter[key] === filter.name))) {
      self apply_filter(localclientnum, filter, key);
    }
  }

  if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
    self thread disable_all_filters_on_game_ended();
  }
}

update_dr_filters(localclientnum) {
  self thread _update_dr_filters(localclientnum);
}

find_dr_filter(filterset = level.drfilters[#"framebuffer"]) {
  best = undefined;

  foreach(filter in filterset) {
    if(self can_use_filter(filter)) {
      if(!isDefined(best) || filter.priority > best.priority) {
        best = filter;
      }
    }
  }

  return best;
}

can_use_filter(filter) {
  for(i = 0; i < filter.require.size; i++) {
    if(!self flagsys::get(filter.require[i])) {
      return false;
    }
  }

  for(i = 0; i < filter.refuse.size; i++) {
    if(self flagsys::get(filter.refuse[i])) {
      return false;
    }
  }

  return true;
}

apply_filter(localclientnum, filter, filterset = "framebuffer") {
  if(isDefined(level.postgame) && level.postgame && !(isDefined(level.showedtopthreeplayers) && level.showedtopthreeplayers)) {
    if(!function_1cbf351b(localclientnum)) {
      return;
    }
  }

  if(getdvarint(#"scr_debug_duplicaterender", 0)) {
    name = "<dev string:x38>";

    if(isplayer(self)) {
      if(isDefined(self.name)) {
        name = "<dev string:x43>" + self.name;
      }
    } else if(isDefined(self.model)) {
      name += "<dev string:x4d>" + self.model;
    }

    msg = "<dev string:x51>" + filter.name + "<dev string:x75>" + name + "<dev string:x7c>" + filterset;
    println(msg);
  }

  if(!isDefined(self.currentdrfilter)) {
    self.currentdrfilter = [];
  }

  self.currentdrfilter[filterset] = filter.name;
  opts = filter.types.size;

  for(i = 0; i < opts; i++) {
    type = filter.types[i];
    value = filter.values[i];
    culling = filter.culling[i];
    var_385a59fa = filter.method[i];
    material = undefined;

    if(isstring(value)) {
      material = filter::mapped_material_id(value);

      if(!isDefined(var_385a59fa)) {
        var_385a59fa = 3;
      }

      if(isDefined(material)) {
        self addduplicaterenderoption(type, var_385a59fa, material, culling);
      } else {
        self.currentdrfilter[filterset] = undefined;
      }

      continue;
    }

    self addduplicaterenderoption(type, value, -1, culling);
  }
}

disable_all_filters_on_game_ended() {
  self endon(#"death");
  self notify(#"disable_all_filters_on_game_ended");
  self endon(#"disable_all_filters_on_game_ended");
  level waittill(#"post_game");
  self disableduplicaterendering();
}

set_item_retrievable(localclientnum, on_off) {
  self update_dr_flag(localclientnum, "retrievable", on_off);
}

set_item_unplaceable(localclientnum, on_off) {
  self update_dr_flag(localclientnum, "unplaceable", on_off);
}

set_item_enemy_equipment(localclientnum, on_off) {
  self update_dr_flag(localclientnum, "enemyequip", on_off);
}

set_item_friendly_equipment(localclientnum, on_off) {
  self update_dr_flag(localclientnum, "friendlyequip", on_off);
}

set_entity_thermal(localclientnum, on_off) {
  self update_dr_flag(localclientnum, "infrared_entity", on_off);
}

set_player_threat_detected(localclientnum, on_off) {
  self update_dr_flag(localclientnum, "threat_detector_enemy", on_off);
}

set_hacker_tool_hacked(localclientnum, on_off) {}

set_hacker_tool_hacking(localclientnum, on_off) {}

set_hacker_tool_breaching(localclientnum, on_off) {}

show_friendly_outlines(local_client_num) {
  if(!(isDefined(level.friendlycontentoutlines) && level.friendlycontentoutlines)) {
    return false;
  }

  if(shoutcaster::is_shoutcaster(local_client_num)) {
    return false;
  }

  return true;
}

set_entity_draft_unselected(localclientnum, on_off) {
  if(util::is_frontend_map()) {
    rob = #"hash_79892e1d5a8f9f33";
  } else if(util::function_26489405()) {
    rob = #"hash_5418181592b8b61a";
  } else {
    rob = #"hash_68bd6efcb1324e3";
  }

  if(isDefined(on_off) && on_off) {
    self playrenderoverridebundle(rob);
    return;
  }

  self stoprenderoverridebundle(rob);
}