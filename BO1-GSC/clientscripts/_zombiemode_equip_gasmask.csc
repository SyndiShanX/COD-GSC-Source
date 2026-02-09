/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_zombiemode_equip_gasmask\.csc
*******************************************************/

#include clientscripts\_utility;
#include clientscripts\_fx;

init_filter_indices() {
  if(isDefined(level.genericfilterinitialized)) {
    return;
  }
  level.genericfilterinitialized = true;
  level.filter_matcount = 4;
  level.targetid_none = 0;
  level.targerid_small0 = 1;
  level.targerid_small1 = 2;
  level.targerid_scene = 3;
  level.targerid_postsun = 4;
  level.targerid_smallblur = 5;
}
map_material_helper(player, materialname) {
  if(!isDefined(level.filter_matid)) {
    level.filter_matid = [];
  }
  if(isDefined(level.filter_matid[materialname])) {
    player map_material(level.filter_matid[materialname], materialname);
  } else {
    level.filter_matid[materialname] = level.filter_matcount;
    player map_material(level.filter_matcount, materialname);
    level.filter_matcount++;
  }
}
init_filter_hazmat(player) {
  init_filter_indices();
  map_material_helper(player, "zom_generic_filter_hazmat_moon");
  map_material_helper(player, "zom_generic_overlay_hazmat_1");
}
set_filter_hazmat_opacity(player, filterid, overlayid, opacity) {
  player set_filter_pass_constant(filterid, 0, 0, opacity);
  player set_overlay_constant(overlayid, 0, opacity);
}
enable_filter_hazmat(player, filterid, overlayid, opacity) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["zom_generic_filter_hazmat_moon"], level.targerid_scene, level.targerid_scene, level.targetid_none);
  player set_filter_pass_enabled(filterid, 0, true);
  player set_overlay_material(overlayid, level.filter_matid["zom_generic_overlay_hazmat_1"], 1);
  player set_overlay_enabled(overlayid, true);
  set_filter_hazmat_opacity(player, filterid, overlayid, opacity);
}
disable_filter_hazmat(player, filterid, overlayid) {
  player set_filter_pass_enabled(filterid, 0, false);
  player set_overlay_enabled(overlayid, false);
}
init() {
  if(getDvar(#"createfx") == "on") {
    return;
  }
  if(!clientscripts\_zombiemode_equipment::is_equipment_included("equip_gasmask_zm")) {
    return;
  }
  level._CF_PLAYER_GASMASK_OVERLAY = 9;
  register_clientflag_callback("player", level._CF_PLAYER_GASMASK_OVERLAY, ::gasmask_overlay_handler);
  level thread player_init();
}
gasmask_overlay_handler(lcn, set, newEnt) {
  player = GetLocalPlayers()[lcn];
  if(player GetEntityNumber() != self GetEntityNumber()) {
    return;
  }
  if(self IsSpectating()) {
    return;
  }
  if(isDefined(newEnt) && newEnt) {
    return;
  }
  if(set) {
    enable_filter_hazmat(self, 0, 0, 1.0);
    self thread playsounds_gasmask(1);
  } else {
    disable_filter_hazmat(self, 0, 0);
    self thread playsounds_gasmask(0);
  }
}
player_init() {
  waitforallclients();
  wait(1.0);
  players = GetLocalPlayers();
  for(i = 0; i < players.size; i++) {
    init_filter_hazmat(players[i]);
  }
}
playsounds_gasmask(on) {
  if(!isDefined(self.gasmask_audio_ent)) {
    self.gasmask_audio_ent = spawn(0, (0, 0, 0), "script_origin");
  }
  if(on) {
    self.gasmask_audio_ent playLoopSound("evt_gasmask_loop", .5);
    if(isDefined(level._audio_zombie_gasmask_func)) {
      level thread[[level._audio_zombie_gasmask_func]](on);
    }
  } else {
    playSound(0, "evt_gasmask_off", (0, 0, 0));
    self.gasmask_audio_ent stoploopsound(.5);
    self.gasmask_audio_ent delete();
    self.gasmask_audio_ent = undefined;
    if(isDefined(level._audio_zombie_gasmask_func)) {
      level thread[[level._audio_zombie_gasmask_func]](on);
    }
  }
}