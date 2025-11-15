/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\mp\helicopter.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\duplicaterender_mgr;
#include scripts\core_common\fx_shared;
#include scripts\core_common\helicopter_sounds_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\killstreaks\helicopter_shared;

#namespace helicopter;

autoexec __init__system__() {
  system::register(#"helicopter", &__init__, undefined, #"killstreaks");
}

__init__() {
  init_shared();
  level.chopper_fx[#"damage"][#"light_smoke"] = "destruct/fx8_atk_chppr_smk_trail";
  level.chopper_fx[#"damage"][#"heavy_smoke"] = "destruct/fx8_atk_chppr_exp_trail";
  level._effect[#"qrdrone_prop"] = #"hash_6cd811fe548313ca";
  level._effect[#"heli_guard_light"][#"friendly"] = #"killstreaks/fx_sc_lights_grn";
  level._effect[#"heli_guard_light"][#"enemy"] = #"killstreaks/fx_sc_lights_red";
  level._effect[#"heli_comlink_light"][#"common"] = #"killstreaks/fx_drone_hunter_lights";
  level._effect[#"heli_gunner_light"][#"friendly"] = #"killstreaks/fx_vtol_lights_grn";
  level._effect[#"heli_gunner_light"][#"enemy"] = #"killstreaks/fx_vtol_lights_red";
  level._effect[#"heli_gunner"][#"vtol_fx"] = #"killstreaks/fx_vtol_thruster";
  level._effect[#"heli_gunner"][#"vtol_fx_ft"] = #"killstreaks/fx_vtol_thruster";
  clientfield::register("vehicle", "heli_warn_targeted", 1, 1, "int", &warnmissilelocking, 0, 0);
  clientfield::register("vehicle", "heli_warn_locked", 1, 1, "int", &warnmissilelocked, 0, 0);
  clientfield::register("vehicle", "heli_warn_fired", 1, 1, "int", &warnmissilefired, 0, 0);
  clientfield::register("vehicle", "supplydrop_care_package_state", 1, 1, "int", &supplydrop_care_package_state, 0, 0);
  clientfield::register("vehicle", "supplydrop_ai_tank_state", 1, 1, "int", &supplydrop_ai_tank_state, 0, 0);
  clientfield::register("vehicle", "heli_comlink_bootup_anim", 1, 1, "int", &heli_comlink_bootup_anim, 0, 0);
  duplicate_render::set_dr_filter_framebuffer("active_camo_scorestreak", 90, "active_camo_on", "", 0, "mc/hud_outline_predator_camo_active_enemy_scorestreak", 0);
  duplicate_render::set_dr_filter_framebuffer("active_camo_flicker_scorestreak", 80, "active_camo_flicker", "", 0, "mc/hud_outline_predator_camo_disruption_enemy_scorestreak", 0);
  duplicate_render::set_dr_filter_framebuffer_duplicate("active_camo_reveal_scorestreak_dr", 90, "active_camo_reveal", "hide_model", 1, "mc/hud_outline_predator_camo_active_enemy_scorestreak", 0);
  duplicate_render::set_dr_filter_framebuffer("active_camo_reveal_scorestreak", 80, "active_camo_reveal, hide_model", "", 0, "mc/hud_outline_predator_scorestreak", 0);
  clientfield::register("vehicle", "active_camo", 1, 3, "int", &active_camo_changed, 0, 0);
  clientfield::register("scriptmover", "supplydrop_thrusters_state", 1, 1, "int", &setsupplydropthrustersstate, 0, 0);
  clientfield::register("scriptmover", "aitank_thrusters_state", 1, 1, "int", &setaitankhrustersstate, 0, 0);
  callback::on_spawned(&on_player_spawned);
}

on_player_spawned(localclientnum) {
  player = self;
  player waittill(#"death");
  player.markerfx = undefined;

  if(isDefined(player.markerobj)) {
    player.markerobj delete();
  }

  if(isDefined(player.markerfxhandle)) {
    killfx(localclientnum, player.markerfxhandle);
    player.markerfxhandle = undefined;
  }
}

active_camo_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 0) {
    self thread heli_comlink_lights_on_after_wait(localclientnum, 0.7);
  } else {
    self heli_comlink_lights_off(localclientnum);
  }

  flags_changed = self duplicate_render::set_dr_flag("active_camo_flicker", newval == 2);
  flags_changed = self duplicate_render::set_dr_flag("active_camo_on", 0) || flags_changed;
  flags_changed = self duplicate_render::set_dr_flag("active_camo_reveal", 1) || flags_changed;

  if(flags_changed) {
    self duplicate_render::update_dr_filters(localclientnum);
  }

  self notify(#"endtest");
  self thread doreveal(localclientnum, newval != 0);
}

doreveal(local_client_num, direction) {
  self notify(#"endtest");
  self endon(#"endtest");
  self endon(#"death");

  if(direction) {
    self duplicate_render::update_dr_flag(local_client_num, "hide_model", 0);
    startval = 0;
    endval = 1;
  } else {
    self duplicate_render::update_dr_flag(local_client_num, "hide_model", 1);
    startval = 1;
    endval = 0;
  }

  priorvalue = startval;

  while(startval >= 0 && startval <= 1) {
    self mapshaderconstant(local_client_num, 0, "scriptVector0", startval, 0, 0, 0);

    if(direction) {
      startval += 0.032;

      if(priorvalue < 0.5 && startval >= 0.5) {
        self duplicate_render::set_dr_flag("hide_model", 1);
        self duplicate_render::change_dr_flags(local_client_num);
      }
    } else {
      startval -= 0.032;

      if(priorvalue > 0.5 && startval <= 0.5) {
        self duplicate_render::set_dr_flag("hide_model", 0);
        self duplicate_render::change_dr_flags(local_client_num);
      }
    }

    priorvalue = startval;
    waitframe(1);
  }

  self mapshaderconstant(local_client_num, 0, "scriptVector0", endval, 0, 0, 0);
  flags_changed = self duplicate_render::set_dr_flag("active_camo_reveal", 0);
  flags_changed = self duplicate_render::set_dr_flag("active_camo_on", direction) || flags_changed;

  if(flags_changed) {
    self duplicate_render::update_dr_filters(local_client_num);
  }
}

heli_comlink_bootup_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}

supplydrop_care_package_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}

supplydrop_ai_tank_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}

warnmissilelocking(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval && !self function_4add50a7()) {
    return;
  }

  helicopter_sounds::play_targeted_sound(newval);
}

warnmissilelocked(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval && !self function_4add50a7()) {
    return;
  }

  helicopter_sounds::play_locked_sound(newval);
}

warnmissilefired(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval && !self function_4add50a7()) {
    return;
  }

  helicopter_sounds::play_fired_sound(newval);
}

heli_deletefx(localclientnum) {
  if(isDefined(self.exhaustleftfxhandle)) {
    deletefx(localclientnum, self.exhaustleftfxhandle);
    self.exhaustleftfxhandle = undefined;
  }

  if(isDefined(self.exhaustrightfxhandlee)) {
    deletefx(localclientnum, self.exhaustrightfxhandle);
    self.exhaustrightfxhandle = undefined;
  }

  if(isDefined(self.lightfxid)) {
    deletefx(localclientnum, self.lightfxid);
    self.lightfxid = undefined;
  }

  if(isDefined(self.propfxid)) {
    deletefx(localclientnum, self.propfxid);
    self.propfxid = undefined;
  }

  if(isDefined(self.vtolleftfxid)) {
    deletefx(localclientnum, self.vtolleftfxid);
    self.vtolleftfxid = undefined;
  }

  if(isDefined(self.vtolrightfxid)) {
    deletefx(localclientnum, self.vtolrightfxid);
    self.vtolrightfxid = undefined;
  }
}

startfx(localclientnum) {
  self endon(#"death");

  if(isDefined(self.vehicletype)) {
    if(self.vehicletype == #"remote_mortar_vehicle_mp") {
      return;
    }

    if(self.vehicletype == #"vehicle_straferun_mp") {
      return;
    }
  }

  if(isDefined(self.exhaustfxname) && self.exhaustfxname != "") {
    self.exhaustfx = self.exhaustfxname;
  }

  if(isDefined(self.exhaustfx)) {
    self.exhaustleftfxhandle = util::playFXOnTag(localclientnum, self.exhaustfx, self, "tag_engine_left");

    if(!(isDefined(self.oneexhaust) && self.oneexhaust)) {
      self.exhaustrightfxhandle = util::playFXOnTag(localclientnum, self.exhaustfx, self, "tag_engine_right");
    }
  } else {
    println("<dev string:x38>");
  }

  if(isDefined(self.vehicletype)) {
    light_fx = undefined;
    prop_fx = undefined;

    switch (self.vehicletype) {
      case #"heli_ai_mp":
        light_fx = "heli_comlink_light";
        break;
      case #"heli_player_gunner_mp":
        self.vtolleftfxid = util::playFXOnTag(localclientnum, level._effect[#"heli_gunner"][#"vtol_fx"], self, "tag_engine_left");
        self.vtolrightfxid = util::playFXOnTag(localclientnum, level._effect[#"heli_gunner"][#"vtol_fx_ft"], self, "tag_engine_right");
        light_fx = "heli_gunner_light";
        break;
      case #"heli_guard_mp":
        light_fx = "heli_guard_light";
        break;
      case #"qrdrone_mp":
        prop_fx = "qrdrone_prop";
        break;
    }

    if(isDefined(light_fx)) {
      self.lightfxid = self fx::function_3539a829(localclientnum, level._effect[light_fx][#"friendly"], level._effect[light_fx][#"enemy"], "tag_origin");
    }

    if(isDefined(prop_fx) && !self function_4add50a7()) {
      self.propfxid = util::playFXOnTag(localclientnum, level._effect[prop_fx], self, "tag_origin");
    }
  }
}

startfx_loop(localclientnum) {
  self endon(#"death");
  self thread helicopter_sounds::aircraft_dustkick(localclientnum);
  startfx(localclientnum);
  servertime = getservertime(0);
  lastservertime = servertime;

  while(isDefined(self)) {
    if(servertime < lastservertime) {
      heli_deletefx(localclientnum);
      startfx(localclientnum);
    }

    waitframe(1);
    lastservertime = servertime;
    servertime = getservertime(0);
  }
}

trail_fx(localclientnum, trail_fx, trail_tag) {
  id = util::playFXOnTag(localclientnum, trail_fx, self, trail_tag);
  return id;
}

heli_comlink_lights_on_after_wait(localclientnum, wait_time) {
  self endon(#"death");
  self endon(#"heli_comlink_lights_off");
  wait wait_time;
  self heli_comlink_lights_on(localclientnum);
}

heli_comlink_lights_on(localclientnum) {
  if(!isDefined(self.light_fx_handles_heli_comlink)) {
    self.light_fx_handles_heli_comlink = [];
  }

  self.light_fx_handles_heli_comlink[0] = util::playFXOnTag(localclientnum, level._effect[#"heli_comlink_light"][#"common"], self, "tag_fx_light_left");
  self.light_fx_handles_heli_comlink[1] = util::playFXOnTag(localclientnum, level._effect[#"heli_comlink_light"][#"common"], self, "tag_fx_light_right");
  self.light_fx_handles_heli_comlink[2] = util::playFXOnTag(localclientnum, level._effect[#"heli_comlink_light"][#"common"], self, "tag_fx_tail");
  self.light_fx_handles_heli_comlink[3] = util::playFXOnTag(localclientnum, level._effect[#"heli_comlink_light"][#"common"], self, "tag_fx_scanner");

  if(isDefined(self.team)) {
    for(i = 0; i < self.light_fx_handles_heli_comlink.size; i++) {
      setfxteam(localclientnum, self.light_fx_handles_heli_comlink[i], self.owner.team);
    }
  }
}

heli_comlink_lights_off(localclientnum) {
  self notify(#"heli_comlink_lights_off");

  if(isDefined(self.light_fx_handles_heli_comlink)) {
    for(i = 0; i < self.light_fx_handles_heli_comlink.size; i++) {
      if(isDefined(self.light_fx_handles_heli_comlink[i])) {
        deletefx(localclientnum, self.light_fx_handles_heli_comlink[i]);
      }
    }

    self.light_fx_handles_heli_comlink = undefined;
  }
}

updatemarkerthread(localclientnum) {
  self endon(#"death");
  player = self;
  killstreakcorebundle = struct::get_script_bundle("killstreak", "killstreak_core");

  while(isDefined(player.markerobj)) {
    viewangles = getlocalclientangles(localclientnum);
    forwardvector = vectorscale(anglesToForward(viewangles), killstreakcorebundle.ksmaxairdroptargetrange);
    results = bulletTrace(player getEye(), player getEye() + forwardvector, 0, player);
    player.markerobj.origin = results[#"position"];
    waitframe(1);
  }
}

stopcrateeffects(localclientnum) {
  crate = self;

  if(isDefined(crate.thrusterfxhandle0)) {
    stopfx(localclientnum, crate.thrusterfxhandle0);
  }

  if(isDefined(crate.thrusterfxhandle1)) {
    stopfx(localclientnum, crate.thrusterfxhandle1);
  }

  if(isDefined(crate.thrusterfxhandle2)) {
    stopfx(localclientnum, crate.thrusterfxhandle2);
  }

  if(isDefined(crate.thrusterfxhandle3)) {
    stopfx(localclientnum, crate.thrusterfxhandle3);
  }

  crate.thrusterfxhandle0 = undefined;
  crate.thrusterfxhandle1 = undefined;
  crate.thrusterfxhandle2 = undefined;
  crate.thrusterfxhandle3 = undefined;
}

cleanupthrustersthread(localclientnum) {
  crate = self;
  crate notify(#"cleanupthrustersthread_singleton");
  crate endon(#"cleanupthrustersthread_singleton");
  crate waittill(#"death");
  crate stopcrateeffects(localclientnum);
}

setsupplydropthrustersstate(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  crate = self;
  params = struct::get_script_bundle("killstreak", "killstreak_supply_drop");

  if(newval != oldval && isDefined(params.ksthrusterfx)) {
    if(newval == 1) {
      crate stopcrateeffects(localclientnum);
      crate.thrusterfxhandle0 = util::playFXOnTag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_01");
      crate.thrusterfxhandle1 = util::playFXOnTag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_02");
      crate.thrusterfxhandle2 = util::playFXOnTag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_03");
      crate.thrusterfxhandle3 = util::playFXOnTag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_04");
      crate thread cleanupthrustersthread(localclientnum);
      return;
    }

    crate stopcrateeffects(localclientnum);
  }
}

setaitankhrustersstate(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  crate = self;
  params = struct::get_script_bundle("killstreak", "killstreak_tank_robot");

  if(newval != oldval && isDefined(params.ksthrusterfx)) {
    if(newval == 1) {
      crate stopcrateeffects(localclientnum);
      crate.thrusterfxhandle0 = util::playFXOnTag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_01");
      crate.thrusterfxhandle1 = util::playFXOnTag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_02");
      crate.thrusterfxhandle2 = util::playFXOnTag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_03");
      crate.thrusterfxhandle3 = util::playFXOnTag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_04");
      crate thread cleanupthrustersthread(localclientnum);
      return;
    }

    crate stopcrateeffects(localclientnum);
  }
}

marker_state_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  player = self;
  killstreakcorebundle = struct::get_script_bundle("killstreak", "killstreak_core");

  if(newval == 1) {
    player.markerfx = killstreakcorebundle.fxvalidlocation;
  } else if(newval == 2) {
    player.markerfx = killstreakcorebundle.fxinvalidlocation;
  } else {
    player.markerfx = undefined;
  }

  if(isDefined(player.markerobj) && !player.markerobj hasdobj(localclientnum)) {
    return;
  }

  if(isDefined(player.markerfxhandle)) {
    killfx(localclientnum, player.markerfxhandle);
    player.markerfxhandle = undefined;
  }

  if(isDefined(player.markerfx)) {
    if(!isDefined(player.markerobj)) {
      player.markerobj = spawn(localclientnum, (0, 0, 0), "script_model");
      player.markerobj.angles = (270, 0, 0);
      player.markerobj setModel(#"wpn_t7_none_world");
      player.markerobj util::waittill_dobj(localclientnum);
      player thread updatemarkerthread(localclientnum);
    }

    player.markerfxhandle = util::playFXOnTag(localclientnum, player.markerfx, player.markerobj, "tag_origin");
    return;
  }

  if(isDefined(player.markerobj)) {
    player.markerobj delete();
  }
}