/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\killstreaks\_helicopter.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_helicopter_sounds;
#using scripts\mp\_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using_animtree("mp_vehicles");
#namespace helicopter;

function autoexec __init__sytem__() {
  system::register("helicopter", &__init__, undefined, undefined);
}

function __init__() {
  level.chopper_fx["damage"]["light_smoke"] = "killstreaks/fx_heli_smk_trail_engine_33";
  level.chopper_fx["damage"]["heavy_smoke"] = "killstreaks/fx_heli_smk_trail_engine_66";
  level._effect["qrdrone_prop"] = "killstreaks/fx_drgnfire_rotor_wash_runner";
  level._effect["heli_guard_light"]["friendly"] = "killstreaks/fx_sc_lights_grn";
  level._effect["heli_guard_light"]["enemy"] = "killstreaks/fx_sc_lights_red";
  level._effect["heli_comlink_light"]["common"] = "killstreaks/fx_drone_hunter_lights";
  level._effect["heli_gunner_light"]["friendly"] = "killstreaks/fx_vtol_lights_grn";
  level._effect["heli_gunner_light"]["enemy"] = "killstreaks/fx_vtol_lights_red";
  level._effect["heli_gunner"]["vtol_fx"] = "killstreaks/fx_vtol_thruster";
  level._effect["heli_gunner"]["vtol_fx_ft"] = "killstreaks/fx_vtol_thruster";
  clientfield::register("helicopter", "heli_warn_targeted", 1, 1, "int", &warnmissilelocking, 0, 0);
  clientfield::register("helicopter", "heli_warn_locked", 1, 1, "int", &warnmissilelocked, 0, 0);
  clientfield::register("helicopter", "heli_warn_fired", 1, 1, "int", &warnmissilefired, 0, 0);
  clientfield::register("helicopter", "supplydrop_care_package_state", 1, 1, "int", &supplydrop_care_package_state, 0, 0);
  clientfield::register("helicopter", "supplydrop_ai_tank_state", 1, 1, "int", &supplydrop_ai_tank_state, 0, 0);
  clientfield::register("helicopter", "heli_comlink_bootup_anim", 1, 1, "int", &heli_comlink_bootup_anim, 0, 0);
  clientfield::register("vehicle", "heli_warn_targeted", 1, 1, "int", &warnmissilelocking, 0, 0);
  clientfield::register("vehicle", "heli_warn_locked", 1, 1, "int", &warnmissilelocked, 0, 0);
  clientfield::register("vehicle", "heli_warn_fired", 1, 1, "int", &warnmissilefired, 0, 0);
  clientfield::register("vehicle", "supplydrop_care_package_state", 1, 1, "int", &supplydrop_care_package_state, 0, 0);
  clientfield::register("vehicle", "supplydrop_ai_tank_state", 1, 1, "int", &supplydrop_ai_tank_state, 0, 0);
  clientfield::register("vehicle", "heli_comlink_bootup_anim", 1, 1, "int", &heli_comlink_bootup_anim, 0, 0);
  duplicate_render::set_dr_filter_framebuffer("active_camo_scorestreak", 90, "active_camo_on", "", 0, "mc/hud_outline_predator_camo_active_enemy_scorestreak", 0);
  duplicate_render::set_dr_filter_framebuffer("active_camo_flicker_scorestreak", 80, "active_camo_flicker", "", 0, "mc/hud_outline_predator_camo_disruption_enemy_scorestreak", 0);
  duplicate_render::set_dr_filter_framebuffer_duplicate("active_camo_reveal_scorestreak_dr", 90, "active_camo_reveal", "hide_model", 1, "mc/hud_outline_predator_camo_active_enemy_scorestreak", 0);
  duplicate_render::set_dr_filter_framebuffer("active_camo_reveal_scorestreak", 80, "active_camo_reveal,hide_model", "", 0, "mc/hud_outline_predator_scorestreak", 0);
  clientfield::register("helicopter", "active_camo", 1, 3, "int", &active_camo_changed, 0, 0);
  clientfield::register("vehicle", "active_camo", 1, 3, "int", &active_camo_changed, 0, 0);
  clientfield::register("toplayer", "marker_state", 1, 2, "int", &marker_state_changed, 0, 0);
  clientfield::register("scriptmover", "supplydrop_thrusters_state", 1, 1, "int", &setsupplydropthrustersstate, 0, 0);
  clientfield::register("scriptmover", "aitank_thrusters_state", 1, 1, "int", &setaitankhrustersstate, 0, 0);
  clientfield::register("vehicle", "mothership", 1, 1, "int", &mothership_cb, 0, 0);
  callback::on_spawned(&on_player_spawned);
}

function on_player_spawned(localclientnum) {
  player = self;
  player waittill("entityshutdown");
  player.markerfx = undefined;
  if(isDefined(player.markerobj)) {
    player.markerobj delete();
  }
  if(isDefined(player.markerfxhandle)) {
    killfx(localclientnum, player.markerfxhandle);
    player.markerfxhandle = undefined;
  }
}

function setupanimtree() {
  if(self hasanimtree() == 0) {
    self useanimtree($mp_vehicles);
  }
}

function active_camo_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
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
  self notify("endtest");
  self thread doreveal(localclientnum, newval != 0);
}

function doreveal(local_client_num, direction) {
  self notify("endtest");
  self endon("endtest");
  self endon("entityshutdown");
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
      startval = startval + 0.032;
      if(priorvalue < 0.5 && startval >= 0.5) {
        self duplicate_render::set_dr_flag("hide_model", 1);
        self duplicate_render::change_dr_flags(local_client_num);
      }
    } else {
      startval = startval - 0.032;
      if(priorvalue > 0.5 && startval <= 0.5) {
        self duplicate_render::set_dr_flag("hide_model", 0);
        self duplicate_render::change_dr_flags(local_client_num);
      }
    }
    priorvalue = startval;
    wait(0.016);
  }
  self mapshaderconstant(local_client_num, 0, "scriptVector0", endval, 0, 0, 0);
  flags_changed = self duplicate_render::set_dr_flag("active_camo_reveal", 0);
  flags_changed = self duplicate_render::set_dr_flag("active_camo_on", direction) || flags_changed;
  if(flags_changed) {
    self duplicate_render::update_dr_filters(local_client_num);
  }
}

function heli_comlink_bootup_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self endon("death");
  self setupanimtree();
  self setanim(%mp_vehicles::veh_anim_future_heli_gearup_bay_open, 1, 0, 1);
}

function supplydrop_care_package_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self endon("death");
  self setupanimtree();
  if(newval == 1) {
    self setanim(%mp_vehicles::o_drone_supply_care_idle, 1, 0, 1);
  } else {
    self setanim(%mp_vehicles::o_drone_supply_care_drop, 1, 0, 0.3);
  }
}

function supplydrop_ai_tank_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self endon("death");
  self setupanimtree();
  if(newval == 1) {
    self setanim(%mp_vehicles::o_drone_supply_agr_idle, 1, 0, 1);
  } else {
    self setanim(%mp_vehicles::o_drone_supply_agr_drop, 1, 0, 0.3);
  }
}

function warnmissilelocking(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval && !self islocalclientdriver(localclientnum)) {
    return;
  }
  helicopter_sounds::play_targeted_sound(newval);
}

function warnmissilelocked(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval && !self islocalclientdriver(localclientnum)) {
    return;
  }
  helicopter_sounds::play_locked_sound(newval);
}

function warnmissilefired(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval && !self islocalclientdriver(localclientnum)) {
    return;
  }
  helicopter_sounds::play_fired_sound(newval);
}

function heli_deletefx(localclientnum) {
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

function startfx(localclientnum) {
  self endon("entityshutdown");
  if(isDefined(self.vehicletype)) {
    if(self.vehicletype == "remote_mortar_vehicle_mp") {
      return;
    }
    if(self.vehicletype == "vehicle_straferun_mp") {
      return;
    }
  }
  if(isDefined(self.exhaustfxname) && self.exhaustfxname != "") {
    self.exhaustfx = self.exhaustfxname;
  }
  if(isDefined(self.exhaustfx)) {
    self.exhaustleftfxhandle = playFXOnTag(localclientnum, self.exhaustfx, self, "tag_engine_left");
    if(!(isDefined(self.oneexhaust) && self.oneexhaust)) {
      self.exhaustrightfxhandle = playFXOnTag(localclientnum, self.exhaustfx, self, "tag_engine_right");
    }
  } else {
    println("");
  }
  if(isDefined(self.vehicletype)) {
    light_fx = undefined;
    prop_fx = undefined;
    switch (self.vehicletype) {
      case "heli_ai_mp": {
        light_fx = "heli_comlink_light";
        break;
      }
      case "heli_player_gunner_mp": {
        self.vtolleftfxid = playFXOnTag(localclientnum, level._effect["heli_gunner"]["vtol_fx"], self, "tag_engine_left");
        self.vtolrightfxid = playFXOnTag(localclientnum, level._effect["heli_gunner"]["vtol_fx_ft"], self, "tag_engine_right");
        light_fx = "heli_gunner_light";
        break;
      }
      case "heli_guard_mp": {
        light_fx = "heli_guard_light";
        break;
      }
      case "qrdrone_mp": {
        prop_fx = "qrdrone_prop";
        break;
      }
    }
    if(isDefined(light_fx)) {
      if(self util::friend_not_foe(localclientnum)) {
        self.lightfxid = playFXOnTag(localclientnum, level._effect[light_fx]["friendly"], self, "tag_origin");
      } else {
        self.lightfxid = playFXOnTag(localclientnum, level._effect[light_fx]["enemy"], self, "tag_origin");
      }
    }
    if(isDefined(prop_fx) && !self islocalclientdriver(localclientnum)) {
      self.propfxid = playFXOnTag(localclientnum, level._effect[prop_fx], self, "tag_origin");
    }
  }
  self damage_fx_stages(localclientnum);
}

function startfx_loop(localclientnum) {
  self endon("entityshutdown");
  self thread helicopter_sounds::aircraft_dustkick(localclientnum);
  startfx(localclientnum);
  servertime = getservertime(0);
  lastservertime = servertime;
  while(isDefined(self)) {
    if(servertime < lastservertime) {
      heli_deletefx(localclientnum);
      startfx(localclientnum);
    }
    wait(0.05);
    lastservertime = servertime;
    servertime = getservertime(0);
  }
}

function damage_fx_stages(localclientnum) {
  self endon("entityshutdown");
  last_damage_state = self gethelidamagestate();
  fx = undefined;
  for(;;) {
    if(last_damage_state != self gethelidamagestate()) {
      if(self gethelidamagestate() == 2) {
        if(isDefined(fx)) {
          stopfx(localclientnum, fx);
        }
        fx = trail_fx(localclientnum, level.chopper_fx["damage"]["light_smoke"], "tag_engine_left");
      } else {
        if(self gethelidamagestate() == 1) {
          if(isDefined(fx)) {
            stopfx(localclientnum, fx);
          }
          fx = trail_fx(localclientnum, level.chopper_fx["damage"]["heavy_smoke"], "tag_engine_left");
        } else {
          if(isDefined(fx)) {
            stopfx(localclientnum, fx);
          }
          self notify("hash_f6285749");
        }
      }
      last_damage_state = self gethelidamagestate();
    }
    wait(0.25);
  }
}

function trail_fx(localclientnum, trail_fx, trail_tag) {
  id = playFXOnTag(localclientnum, trail_fx, self, trail_tag);
  return id;
}

function heli_comlink_lights_on_after_wait(localclientnum, wait_time) {
  self endon("entityshutdown");
  self endon("heli_comlink_lights_off");
  wait(wait_time);
  self heli_comlink_lights_on(localclientnum);
}

function heli_comlink_lights_on(localclientnum) {
  if(!isDefined(self.light_fx_handles_heli_comlink)) {
    self.light_fx_handles_heli_comlink = [];
  }
  self.light_fx_handles_heli_comlink[0] = playFXOnTag(localclientnum, level._effect["heli_comlink_light"]["common"], self, "tag_fx_light_left");
  self.light_fx_handles_heli_comlink[1] = playFXOnTag(localclientnum, level._effect["heli_comlink_light"]["common"], self, "tag_fx_light_right");
  self.light_fx_handles_heli_comlink[2] = playFXOnTag(localclientnum, level._effect["heli_comlink_light"]["common"], self, "tag_fx_tail");
  self.light_fx_handles_heli_comlink[3] = playFXOnTag(localclientnum, level._effect["heli_comlink_light"]["common"], self, "tag_fx_scanner");
  if(isDefined(self.team)) {
    for(i = 0; i < self.light_fx_handles_heli_comlink.size; i++) {
      setfxteam(localclientnum, self.light_fx_handles_heli_comlink[i], self.owner.team);
    }
  }
}

function heli_comlink_lights_off(localclientnum) {
  self notify("heli_comlink_lights_off");
  if(isDefined(self.light_fx_handles_heli_comlink)) {
    for(i = 0; i < self.light_fx_handles_heli_comlink.size; i++) {
      if(isDefined(self.light_fx_handles_heli_comlink[i])) {
        deletefx(localclientnum, self.light_fx_handles_heli_comlink[i]);
      }
    }
    self.light_fx_handles_heli_comlink = undefined;
  }
}

function updatemarkerthread(localclientnum) {
  self endon("entityshutdown");
  player = self;
  killstreakcorebundle = struct::get_script_bundle("killstreak", "killstreak_core");
  while(isDefined(player.markerobj)) {
    viewangles = getlocalclientangles(localclientnum);
    forwardvector = vectorscale(anglesToForward(viewangles), killstreakcorebundle.ksmaxairdroptargetrange);
    results = bulletTrace(player getEye(), player getEye() + forwardvector, 0, player);
    player.markerobj.origin = results["position"];
    wait(0.016);
  }
}

function stopcrateeffects(localclientnum) {
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

function cleanupthrustersthread(localclientnum) {
  crate = self;
  crate notify("cleanupthrustersthread_singleton");
  crate endon("cleanupthrustersthread_singleton");
  crate waittill("entityshutdown");
  crate stopcrateeffects(localclientnum);
}

function setsupplydropthrustersstate(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  crate = self;
  params = struct::get_script_bundle("killstreak", "killstreak_supply_drop");
  if(newval != oldval && isDefined(params.ksthrusterfx)) {
    if(newval == 1) {
      crate stopcrateeffects(localclientnum);
      crate.thrusterfxhandle0 = playFXOnTag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_01");
      crate.thrusterfxhandle1 = playFXOnTag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_02");
      crate.thrusterfxhandle2 = playFXOnTag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_03");
      crate.thrusterfxhandle3 = playFXOnTag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_04");
      crate thread cleanupthrustersthread(localclientnum);
    } else {
      crate stopcrateeffects(localclientnum);
    }
  }
}

function mothership_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}

function setaitankhrustersstate(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  crate = self;
  params = struct::get_script_bundle("killstreak", "killstreak_ai_tank_drop");
  if(newval != oldval && isDefined(params.ksthrusterfx)) {
    if(newval == 1) {
      crate stopcrateeffects(localclientnum);
      crate.thrusterfxhandle0 = playFXOnTag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_01");
      crate.thrusterfxhandle1 = playFXOnTag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_02");
      crate.thrusterfxhandle2 = playFXOnTag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_03");
      crate.thrusterfxhandle3 = playFXOnTag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_04");
      crate thread cleanupthrustersthread(localclientnum);
    } else {
      crate stopcrateeffects(localclientnum);
    }
  }
}

function marker_state_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  player = self;
  killstreakcorebundle = struct::get_script_bundle("killstreak", "killstreak_core");
  if(newval == 1) {
    player.markerfx = killstreakcorebundle.fxvalidlocation;
  } else {
    if(newval == 2) {
      player.markerfx = killstreakcorebundle.fxinvalidlocation;
    } else {
      player.markerfx = undefined;
    }
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
      player.markerobj.angles = vectorscale((1, 0, 0), 270);
      player.markerobj setModel("wpn_t7_none_world");
      player.markerobj util::waittill_dobj(localclientnum);
      player thread updatemarkerthread(localclientnum);
    }
    player.markerfxhandle = playFXOnTag(localclientnum, player.markerfx, player.markerobj, "tag_origin");
  } else if(isDefined(player.markerobj)) {
    player.markerobj delete();
  }
}