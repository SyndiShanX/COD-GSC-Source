/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\mp\helicopter.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\helicopter_sounds_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\helicopter_shared;
#namespace helicopter;

function private autoexec __init__system__() {
  system::register(#"helicopter", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  init_shared();
  bundle = "killstreak_helicopter_guard";

  if(sessionmodeiswarzonegame()) {
    bundle += "_wz";
  }

  params = getscriptbundle(bundle);
  level._effect[# "heli_guard_light"][# "friendly"] = params.var_667eb0de;
  level._effect[# "heli_guard_light"][# "enemy"] = params.var_1d8c24a8;
  clientfield::register("vehicle", "heli_warn_targeted", 1, 1, "int", &warnmissilelocking, 0, 0);
  clientfield::register("vehicle", "heli_warn_locked", 1, 1, "int", &warnmissilelocked, 0, 0);
  clientfield::register("vehicle", "heli_warn_fired", 1, 1, "int", &warnmissilefired, 0, 0);
  clientfield::register("vehicle", "heli_comlink_bootup_anim", 1, 1, "int", &heli_comlink_bootup_anim, 0, 0);
  clientfield::register("vehicle", "active_camo", 1, 3, "int", &active_camo_changed, 0, 0);
  callback::on_spawned(&on_player_spawned);
}

function on_player_spawned(localclientnum) {
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

function active_camo_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 0) {
    self thread heli_comlink_lights_on_after_wait(fieldname, 0.7);
  } else {
    self heli_comlink_lights_off(fieldname);
  }

  self notify(#"endtest");
  self thread doreveal(fieldname, bwastimejump != 0);
}

function doreveal(local_client_num, direction) {
  self notify(#"endtest");
  self endon(#"endtest");
  self endon(#"death");

  if(direction) {
    startval = 0;
    endval = 1;
  } else {
    startval = 1;
    endval = 0;
  }

  priorvalue = startval;

  while(startval >= 0 && startval <= 1) {
    self mapshaderconstant(local_client_num, 0, "scriptVector0", startval, 0, 0, 0);

    if(direction) {
      startval += 0.032;

      if(priorvalue < 0.5 && startval >= 0.5) {}
    } else {
      startval -= 0.032;

      if(priorvalue > 0.5 && startval <= 0.5) {}
    }

    priorvalue = startval;
    waitframe(1);
  }

  self mapshaderconstant(local_client_num, 0, "scriptVector0", endval, 0, 0, 0);
}

function heli_comlink_bootup_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}

function warnmissilelocking(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump && !self function_4add50a7()) {
    return;
  }

  helicopter_sounds::play_targeted_sound(bwastimejump);
}

function warnmissilelocked(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump && !self function_4add50a7()) {
    return;
  }

  helicopter_sounds::play_locked_sound(bwastimejump);
}

function warnmissilefired(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump && !self function_4add50a7()) {
    return;
  }

  helicopter_sounds::play_fired_sound(bwastimejump);
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
  self endon(#"death");

  if(isDefined(self.vehicletype)) {
    if(self.vehicletype == # "remote_mortar_vehicle_mp") {
      return;
    }

    if(self.vehicletype == # "vehicle_straferun_mp") {
      return;
    }
  }

  if(isDefined(self.exhaustfxname) && self.exhaustfxname != "") {
    self.exhaustfx = self.exhaustfxname;
  }

  if(isDefined(self.exhaustfx)) {
    self.exhaustleftfxhandle = util::playFXOnTag(localclientnum, self.exhaustfx, self, "tag_engine_left");

    if(!is_true(self.oneexhaust)) {
      self.exhaustrightfxhandle = util::playFXOnTag(localclientnum, self.exhaustfx, self, "tag_engine_right");
    }
  } else {
    println("<dev string:x38>");
  }

  if(isDefined(self.vehicletype)) {
    light_fx = undefined;

    switch (self.vehicletype) {
      case # "heli_ai_mp":
        light_fx = "heli_comlink_light";
        break;
      case # "heli_guard_mp":
        light_fx = "heli_guard_light";
        break;
    }

    if(isDefined(light_fx)) {
      self.lightfxid = self fx::function_3539a829(localclientnum, level._effect[light_fx][# "friendly"], level._effect[light_fx][# "enemy"], "tag_origin");
    }
  }
}

function startfx_loop(localclientnum) {
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

function heli_comlink_lights_on_after_wait(localclientnum, wait_time) {
  self endon(#"death");
  self endon(#"heli_comlink_lights_off");
  wait wait_time;
  self heli_comlink_lights_on(localclientnum);
}

function heli_comlink_lights_on(localclientnum) {
  if(!isDefined(self.light_fx_handles_heli_comlink)) {
    self.light_fx_handles_heli_comlink = [];
  }

  params = getscriptbundle("killstreak_helicopter_comlink");
  self.light_fx_handles_heli_comlink[0] = util::playFXOnTag(localclientnum, params.var_ffb74bd2, self, params.var_cc7457a3);
  self.light_fx_handles_heli_comlink[1] = util::playFXOnTag(localclientnum, params.var_ffb74bd2, self, params.var_a4b60827);
  self.light_fx_handles_heli_comlink[2] = util::playFXOnTag(localclientnum, params.var_ffb74bd2, self, params.var_caf75475);
  self.light_fx_handles_heli_comlink[3] = util::playFXOnTag(localclientnum, params.var_ffb74bd2, self, params.var_a6b70bf5);

  if(isDefined(self.team)) {
    for(i = 0; i < self.light_fx_handles_heli_comlink.size; i++) {
      setfxteam(localclientnum, self.light_fx_handles_heli_comlink[i], self.owner.team);
    }
  }
}

function heli_comlink_lights_off(localclientnum) {
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

function updatemarkerthread(localclientnum) {
  self endon(#"death");
  player = self;
  killstreakcorebundle = getscriptbundle("killstreak_core");

  while(isDefined(player.markerobj)) {
    viewangles = getlocalclientangles(localclientnum);
    forwardvector = vectorscale(anglesToForward(viewangles), killstreakcorebundle.ksmaxairdroptargetrange);
    results = bulletTrace(player getEye(), player getEye() + forwardvector, 0, player);
    player.markerobj.origin = results[# "position"];
    waitframe(1);
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
  crate notify(#"cleanupthrustersthread_singleton");
  crate endon(#"cleanupthrustersthread_singleton");
  crate waittill(#"death");
  crate stopcrateeffects(localclientnum);
}

function marker_state_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  player = self;
  killstreakcorebundle = getscriptbundle("killstreak_core");

  if(bwastimejump == 1) {
    player.markerfx = killstreakcorebundle.fxvalidlocation;
  } else if(bwastimejump == 2) {
    player.markerfx = killstreakcorebundle.fxinvalidlocation;
  } else {
    player.markerfx = undefined;
  }

  if(isDefined(player.markerobj) && !player.markerobj hasdobj(fieldname)) {
    return;
  }

  if(isDefined(player.markerfxhandle)) {
    killfx(fieldname, player.markerfxhandle);
    player.markerfxhandle = undefined;
  }

  if(isDefined(player.markerfx)) {
    if(!isDefined(player.markerobj)) {
      player.markerobj = spawn(fieldname, (0, 0, 0), "script_model");
      player.markerobj.angles = (270, 0, 0);
      player.markerobj setModel(#"wpn_t7_none_world");
      player.markerobj util::waittill_dobj(fieldname);
      player thread updatemarkerthread(fieldname);
    }

    player.markerfxhandle = util::playFXOnTag(fieldname, player.markerfx, player.markerobj, "tag_origin");
    return;
  }

  if(isDefined(player.markerobj)) {
    player.markerobj delete();
  }
}