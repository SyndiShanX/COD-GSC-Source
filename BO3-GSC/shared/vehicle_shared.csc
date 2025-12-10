/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\vehicle_shared.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\filter_shared;
#using scripts\shared\math_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicleriders_shared;
#namespace vehicle;

function autoexec __init__sytem__() {
  system::register("vehicle_shared", &__init__, undefined, undefined);
}

function __init__() {
  level._customvehiclecbfunc = &spawned_callback;
  clientfield::register("vehicle", "toggle_lockon", 1, 1, "int", &field_toggle_lockon_handler, 0, 0);
  clientfield::register("vehicle", "toggle_sounds", 1, 1, "int", &field_toggle_sounds, 0, 0);
  clientfield::register("vehicle", "use_engine_damage_sounds", 1, 2, "int", &field_use_engine_damage_sounds, 0, 0);
  clientfield::register("vehicle", "toggle_treadfx", 1, 1, "int", &field_toggle_treadfx, 0, 0);
  clientfield::register("vehicle", "toggle_exhaustfx", 1, 1, "int", &field_toggle_exhaustfx_handler, 0, 0);
  clientfield::register("vehicle", "toggle_lights", 1, 2, "int", &field_toggle_lights_handler, 0, 0);
  clientfield::register("vehicle", "toggle_lights_group1", 1, 1, "int", &field_toggle_lights_group_handler1, 0, 0);
  clientfield::register("vehicle", "toggle_lights_group2", 1, 1, "int", &field_toggle_lights_group_handler2, 0, 0);
  clientfield::register("vehicle", "toggle_lights_group3", 1, 1, "int", &field_toggle_lights_group_handler3, 0, 0);
  clientfield::register("vehicle", "toggle_lights_group4", 1, 1, "int", &field_toggle_lights_group_handler4, 0, 0);
  clientfield::register("vehicle", "toggle_ambient_anim_group1", 1, 1, "int", &field_toggle_ambient_anim_handler1, 0, 0);
  clientfield::register("vehicle", "toggle_ambient_anim_group2", 1, 1, "int", &field_toggle_ambient_anim_handler2, 0, 0);
  clientfield::register("vehicle", "toggle_ambient_anim_group3", 1, 1, "int", &field_toggle_ambient_anim_handler3, 0, 0);
  clientfield::register("vehicle", "toggle_emp_fx", 1, 1, "int", &field_toggle_emp, 0, 0);
  clientfield::register("vehicle", "toggle_burn_fx", 1, 1, "int", &field_toggle_burn, 0, 0);
  clientfield::register("vehicle", "deathfx", 1, 2, "int", &field_do_deathfx, 0, 0);
  clientfield::register("vehicle", "alert_level", 1, 2, "int", &field_update_alert_level, 0, 0);
  clientfield::register("vehicle", "set_lighting_ent", 1, 1, "int", &util::field_set_lighting_ent, 0, 0);
  clientfield::register("vehicle", "use_lighting_ent", 1, 1, "int", &util::field_use_lighting_ent, 0, 0);
  clientfield::register("vehicle", "damage_level", 1, 3, "int", &field_update_damage_state, 0, 0);
  clientfield::register("vehicle", "spawn_death_dynents", 1, 2, "int", &field_death_spawn_dynents, 0, 0);
  clientfield::register("vehicle", "spawn_gib_dynents", 1, 1, "int", &field_gib_spawn_dynents, 0, 0);
  clientfield::register("helicopter", "toggle_lockon", 1, 1, "int", &field_toggle_lockon_handler, 0, 0);
  clientfield::register("helicopter", "toggle_sounds", 1, 1, "int", &field_toggle_sounds, 0, 0);
  clientfield::register("helicopter", "use_engine_damage_sounds", 1, 2, "int", &field_use_engine_damage_sounds, 0, 0);
  clientfield::register("helicopter", "toggle_treadfx", 1, 1, "int", &field_toggle_treadfx, 0, 0);
  clientfield::register("helicopter", "toggle_exhaustfx", 1, 1, "int", &field_toggle_exhaustfx_handler, 0, 0);
  clientfield::register("helicopter", "toggle_lights", 1, 2, "int", &field_toggle_lights_handler, 0, 0);
  clientfield::register("helicopter", "toggle_lights_group1", 1, 1, "int", &field_toggle_lights_group_handler1, 0, 0);
  clientfield::register("helicopter", "toggle_lights_group2", 1, 1, "int", &field_toggle_lights_group_handler2, 0, 0);
  clientfield::register("helicopter", "toggle_lights_group3", 1, 1, "int", &field_toggle_lights_group_handler3, 0, 0);
  clientfield::register("helicopter", "toggle_lights_group4", 1, 1, "int", &field_toggle_lights_group_handler4, 0, 0);
  clientfield::register("helicopter", "toggle_ambient_anim_group1", 1, 1, "int", &field_toggle_ambient_anim_handler1, 0, 0);
  clientfield::register("helicopter", "toggle_ambient_anim_group2", 1, 1, "int", &field_toggle_ambient_anim_handler2, 0, 0);
  clientfield::register("helicopter", "toggle_ambient_anim_group3", 1, 1, "int", &field_toggle_ambient_anim_handler3, 0, 0);
  clientfield::register("helicopter", "toggle_emp_fx", 1, 1, "int", &field_toggle_emp, 0, 0);
  clientfield::register("helicopter", "toggle_burn_fx", 1, 1, "int", &field_toggle_burn, 0, 0);
  clientfield::register("helicopter", "deathfx", 1, 1, "int", &field_do_deathfx, 0, 0);
  clientfield::register("helicopter", "alert_level", 1, 2, "int", &field_update_alert_level, 0, 0);
  clientfield::register("helicopter", "set_lighting_ent", 1, 1, "int", &util::field_set_lighting_ent, 0, 0);
  clientfield::register("helicopter", "use_lighting_ent", 1, 1, "int", &util::field_use_lighting_ent, 0, 0);
  clientfield::register("helicopter", "damage_level", 1, 3, "int", &field_update_damage_state, 0, 0);
  clientfield::register("helicopter", "spawn_death_dynents", 1, 2, "int", &field_death_spawn_dynents, 0, 0);
  clientfield::register("helicopter", "spawn_gib_dynents", 1, 1, "int", &field_gib_spawn_dynents, 0, 0);
  clientfield::register("plane", "toggle_treadfx", 1, 1, "int", &field_toggle_treadfx, 0, 0);
  clientfield::register("toplayer", "toggle_dnidamagefx", 1, 1, "int", &field_toggle_dnidamagefx, 0, 0);
  clientfield::register("toplayer", "toggle_flir_postfx", 1, 2, "int", &toggle_flir_postfxbundle, 0, 0);
  clientfield::register("toplayer", "static_postfx", 1, 1, "int", &set_static_postfxbundle, 0, 0);
}

function add_vehicletype_callback(vehicletype, callback) {
  if(!isDefined(level.vehicletypecallbackarray)) {
    level.vehicletypecallbackarray = [];
  }
  level.vehicletypecallbackarray[vehicletype] = callback;
}

function spawned_callback(localclientnum) {
  if(isDefined(self.vehicleridersbundle)) {
    set_vehicleriders_bundle(self.vehicleridersbundle);
  }
  vehicletype = self.vehicletype;
  if(isDefined(level.vehicletypecallbackarray)) {
    if(isDefined(vehicletype) && isDefined(level.vehicletypecallbackarray[vehicletype])) {
      self thread[[level.vehicletypecallbackarray[vehicletype]]](localclientnum);
    } else if(isDefined(self.scriptvehicletype) && isDefined(level.vehicletypecallbackarray[self.scriptvehicletype])) {
      self thread[[level.vehicletypecallbackarray[self.scriptvehicletype]]](localclientnum);
    }
  }
}

function rumble(localclientnum) {
  self endon("entityshutdown");
  if(!isDefined(self.rumbletype) || self.rumbleradius == 0) {
    return;
  }
  if(!isDefined(self.rumbleon)) {
    self.rumbleon = 1;
  }
  height = self.rumbleradius * 2;
  zoffset = -1 * self.rumbleradius;
  self.player_touching = 0;
  radius_squared = self.rumbleradius * self.rumbleradius;
  wait(2);
  while(true) {
    if(!isDefined(level.localplayers[localclientnum]) || distancesquared(self.origin, level.localplayers[localclientnum].origin) > radius_squared || self getspeed() == 0) {
      wait(0.2);
      continue;
    }
    if(isDefined(self.rumbleon) && !self.rumbleon) {
      wait(0.2);
      continue;
    }
    self playrumblelooponentity(localclientnum, self.rumbletype);
    while(isDefined(level.localplayers[localclientnum]) && distancesquared(self.origin, level.localplayers[localclientnum].origin) < radius_squared && self getspeed() > 0) {
      self earthquake(self.rumblescale, self.rumbleduration, self.origin, self.rumbleradius);
      time_to_wait = self.rumblebasetime + randomfloat(self.rumbleadditionaltime);
      if(time_to_wait <= 0) {
        time_to_wait = 0.05;
      }
      wait(time_to_wait);
    }
    if(isDefined(level.localplayers[localclientnum])) {
      self stoprumble(localclientnum, self.rumbletype);
    }
    wait(0.05);
  }
}

function kill_treads_forever() {
  self notify("kill_treads_forever");
}

function play_exhaust(localclientnum) {
  if(isDefined(self.csf_no_exhaust) && self.csf_no_exhaust) {
    return;
  }
  if(!isDefined(self.exhaust_fx) && isDefined(self.exhaustfxname)) {
    if(!isDefined(level._effect)) {
      level._effect = [];
    }
    if(!isDefined(level._effect[self.exhaustfxname])) {
      level._effect[self.exhaustfxname] = self.exhaustfxname;
    }
    self.exhaust_fx = level._effect[self.exhaustfxname];
  }
  if(isDefined(self.exhaust_fx) && isDefined(self.exhaustfxtag1)) {
    if(isalive(self)) {
      assert(isDefined(self.exhaustfxtag1), self.vehicletype + "");
      self endon("entityshutdown");
      self wait_for_dobj(localclientnum);
      self.exhaust_id_left = playFXOnTag(localclientnum, self.exhaust_fx, self, self.exhaustfxtag1);
      if(!isDefined(self.exhaust_id_right) && isDefined(self.exhaustfxtag2)) {
        self.exhaust_id_right = playFXOnTag(localclientnum, self.exhaust_fx, self, self.exhaustfxtag2);
      }
      self thread kill_exhaust_watcher(localclientnum);
    }
  }
}

function kill_exhaust_watcher(localclientnum) {
  self waittill("stop_exhaust_fx");
  if(isDefined(self.exhaust_id_left)) {
    stopfx(localclientnum, self.exhaust_id_left);
    self.exhaust_id_left = undefined;
  }
  if(isDefined(self.exhaust_id_right)) {
    stopfx(localclientnum, self.exhaust_id_right);
    self.exhaust_id_right = undefined;
  }
}

function stop_exhaust(localclientnum) {
  self notify("stop_exhaust_fx");
}

function aircraft_dustkick() {
  waittillframeend();
  self endon("kill_treads_forever");
  self endon("entityshutdown");
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.csf_no_tread) && self.csf_no_tread) {
    return;
  }
  if(self.vehicleclass == "plane_mig17" || self.vehicleclass == "plane_mig21") {
    numframespertrace = 1;
  } else {
    numframespertrace = 3;
  }
  dotracethisframe = numframespertrace;
  repeatrate = 1;
  trace = undefined;
  d = undefined;
  trace_ent = self;
  while(isDefined(self)) {
    if(repeatrate <= 0) {
      repeatrate = 1;
    }
    if(self.vehicleclass == "plane_mig17" || self.vehicleclass == "plane_mig21") {
      repeatrate = 0.02;
    }
    waitrealtime(repeatrate);
    if(!isDefined(self)) {
      return;
    }
    dotracethisframe--;
    if(dotracethisframe <= 0) {
      dotracethisframe = numframespertrace;
      trace = tracepoint(trace_ent.origin, trace_ent.origin - vectorscale((0, 0, 1), 100000));
      d = distance(trace_ent.origin, trace["position"]);
      if(d > 350) {
        repeatrate = (d - 350) / (1200 - 350) * (0.2 - 0.1) + 0.1;
      } else {
        repeatrate = 0.1;
      }
    }
    if(isDefined(trace)) {
      if(d > 1200) {
        repeatrate = 1;
        continue;
      }
      if(!isDefined(trace["surfacetype"])) {
        trace["surfacetype"] = "dirt";
      }
    }
  }
}

function weapon_fired() {
  self endon("entityshutdown");
  while(true) {
    self waittill("weapon_fired");
    players = level.localplayers;
    for(i = 0; i < players.size; i++) {
      player_distance = distancesquared(self.origin, players[i].origin);
      if(player_distance < 250000) {
        if(isDefined(self.shootrumble) && self.shootrumble != "") {
          playrumbleonposition(i, self.shootrumble, self.origin + vectorscale((0, 0, 1), 32));
        }
      }
      if(player_distance < 160000) {
        fraction = player_distance / 160000;
        time = 4 - (3 * fraction);
        if(isDefined(players[i])) {
          if(isDefined(self.shootshock) && self.shootshock != "") {
            players[i] shellshock(i, self.shootshock, time);
          }
        }
      }
    }
  }
}

function wait_for_dobj(localclientnum) {
  count = 30;
  while(!self hasdobj(localclientnum)) {
    if(count < 0) {
      iprintlnbold("");
      return;
    }
    wait(0.016);
    count = count - 1;
  }
}

function lights_on(localclientnum, team) {
  self endon("entityshutdown");
  lights_off(localclientnum);
  wait_for_dobj(localclientnum);
  if(isDefined(self.lightfxnamearray)) {
    if(!isDefined(self.light_fx_handles)) {
      self.light_fx_handles = [];
    }
    for(i = 0; i < self.lightfxnamearray.size; i++) {
      self.light_fx_handles[i] = playFXOnTag(localclientnum, self.lightfxnamearray[i], self, self.lightfxtagarray[i]);
      setfxignorepause(localclientnum, self.light_fx_handles[i], 1);
      if(isDefined(team)) {
        setfxteam(localclientnum, self.light_fx_handles[i], team);
      }
    }
  }
}

function addanimtolist(animitem, &liston, &listoff, playwhenoff, id, maxid) {
  if(isDefined(animitem) && id <= maxid) {
    if(playwhenoff === 1) {
      if(!isDefined(listoff)) {
        listoff = [];
      } else if(!isarray(listoff)) {
        listoff = array(listoff);
      }
      listoff[listoff.size] = animitem;
    } else {
      if(!isDefined(liston)) {
        liston = [];
      } else if(!isarray(liston)) {
        liston = array(liston);
      }
      liston[liston.size] = animitem;
    }
  }
}

function ambient_anim_toggle(localclientnum, groupid, ison) {
  self endon("entityshutdown");
  if(!isDefined(self.scriptbundlesettings)) {
    return;
  }
  settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
  if(!isDefined(settings)) {
    return;
  }
  wait_for_dobj(localclientnum);
  liston = [];
  listoff = [];
  switch (groupid) {
    case 1: {
      addanimtolist(settings.ambient_group1_anim1, liston, listoff, settings.ambient_group1_off1, 1, settings.ambient_group1_numslots);
      addanimtolist(settings.ambient_group1_anim2, liston, listoff, settings.ambient_group1_off2, 2, settings.ambient_group1_numslots);
      addanimtolist(settings.ambient_group1_anim3, liston, listoff, settings.ambient_group1_off3, 3, settings.ambient_group1_numslots);
      addanimtolist(settings.ambient_group1_anim4, liston, listoff, settings.ambient_group1_off4, 4, settings.ambient_group1_numslots);
      break;
    }
    case 2: {
      addanimtolist(settings.ambient_group2_anim1, liston, listoff, settings.ambient_group2_off1, 1, settings.ambient_group2_numslots);
      addanimtolist(settings.ambient_group2_anim2, liston, listoff, settings.ambient_group2_off2, 2, settings.ambient_group2_numslots);
      addanimtolist(settings.ambient_group2_anim3, liston, listoff, settings.ambient_group2_off3, 3, settings.ambient_group2_numslots);
      addanimtolist(settings.ambient_group2_anim4, liston, listoff, settings.ambient_group2_off4, 4, settings.ambient_group2_numslots);
      break;
    }
    case 3: {
      addanimtolist(settings.ambient_group3_anim1, liston, listoff, settings.ambient_group3_off1, 1, settings.ambient_group3_numslots);
      addanimtolist(settings.ambient_group3_anim2, liston, listoff, settings.ambient_group3_off2, 2, settings.ambient_group3_numslots);
      addanimtolist(settings.ambient_group3_anim3, liston, listoff, settings.ambient_group3_off3, 3, settings.ambient_group3_numslots);
      addanimtolist(settings.ambient_group3_anim4, liston, listoff, settings.ambient_group3_off4, 4, settings.ambient_group3_numslots);
      break;
    }
    case 4: {
      addanimtolist(settings.ambient_group4_anim1, liston, listoff, settings.ambient_group4_off1, 1, settings.ambient_group4_numslots);
      addanimtolist(settings.ambient_group4_anim2, liston, listoff, settings.ambient_group4_off2, 2, settings.ambient_group4_numslots);
      addanimtolist(settings.ambient_group4_anim3, liston, listoff, settings.ambient_group4_off3, 3, settings.ambient_group4_numslots);
      addanimtolist(settings.ambient_group4_anim4, liston, listoff, settings.ambient_group4_off4, 4, settings.ambient_group4_numslots);
      break;
    }
  }
  if(ison) {
    weighton = 1;
    weightoff = 0;
  } else {
    weighton = 0;
    weightoff = 1;
  }
  for(i = 0; i < liston.size; i++) {
    self setanim(liston[i], weighton, 0.2, 1);
  }
  for(i = 0; i < listoff.size; i++) {
    self setanim(listoff[i], weightoff, 0.2, 1);
  }
}

function field_toggle_ambient_anim_handler1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self ambient_anim_toggle(localclientnum, 1, newval);
}

function field_toggle_ambient_anim_handler2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self ambient_anim_toggle(localclientnum, 2, newval);
}

function field_toggle_ambient_anim_handler3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self ambient_anim_toggle(localclientnum, 3, newval);
}

function field_toggle_ambient_anim_handler4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self ambient_anim_toggle(localclientnum, 4, newval);
}

function lights_group_toggle(localclientnum, id, ison) {
  self endon("entityshutdown");
  if(!isDefined(self.scriptbundlesettings)) {
    return;
  }
  settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
  if(!isDefined(settings) || !isDefined(settings.lightgroups_numgroups)) {
    return;
  }
  wait_for_dobj(localclientnum);
  groupid = id - 1;
  if(isDefined(self.lightfxgroups) && groupid < self.lightfxgroups.size) {
    foreach(fx_handle in self.lightfxgroups[groupid]) {
      stopfx(localclientnum, fx_handle);
    }
  }
  if(!ison) {
    return;
  }
  if(!isDefined(self.lightfxgroups)) {
    self.lightfxgroups = [];
    for(i = 0; i < settings.lightgroups_numgroups; i++) {
      newfxhandlearray = [];
      if(!isDefined(self.lightfxgroups)) {
        self.lightfxgroups = [];
      } else if(!isarray(self.lightfxgroups)) {
        self.lightfxgroups = array(self.lightfxgroups);
      }
      self.lightfxgroups[self.lightfxgroups.size] = newfxhandlearray;
    }
  }
  self.lightfxgroups[groupid] = [];
  fxlist = [];
  taglist = [];
  switch (groupid) {
    case 0: {
      addfxandtagtolists(settings.lightgroups_1_fx1, settings.lightgroups_1_tag1, fxlist, taglist, 1, settings.lightgroups_1_numslots);
      addfxandtagtolists(settings.lightgroups_1_fx2, settings.lightgroups_1_tag2, fxlist, taglist, 2, settings.lightgroups_1_numslots);
      addfxandtagtolists(settings.lightgroups_1_fx3, settings.lightgroups_1_tag3, fxlist, taglist, 3, settings.lightgroups_1_numslots);
      addfxandtagtolists(settings.lightgroups_1_fx4, settings.lightgroups_1_tag4, fxlist, taglist, 4, settings.lightgroups_1_numslots);
      break;
    }
    case 1: {
      addfxandtagtolists(settings.lightgroups_2_fx1, settings.lightgroups_2_tag1, fxlist, taglist, 1, settings.lightgroups_2_numslots);
      addfxandtagtolists(settings.lightgroups_2_fx2, settings.lightgroups_2_tag2, fxlist, taglist, 2, settings.lightgroups_2_numslots);
      addfxandtagtolists(settings.lightgroups_2_fx3, settings.lightgroups_2_tag3, fxlist, taglist, 3, settings.lightgroups_2_numslots);
      addfxandtagtolists(settings.lightgroups_2_fx4, settings.lightgroups_2_tag4, fxlist, taglist, 4, settings.lightgroups_2_numslots);
      break;
    }
    case 2: {
      addfxandtagtolists(settings.lightgroups_3_fx1, settings.lightgroups_3_tag1, fxlist, taglist, 1, settings.lightgroups_3_numslots);
      addfxandtagtolists(settings.lightgroups_3_fx2, settings.lightgroups_3_tag2, fxlist, taglist, 2, settings.lightgroups_3_numslots);
      addfxandtagtolists(settings.lightgroups_3_fx3, settings.lightgroups_3_tag3, fxlist, taglist, 3, settings.lightgroups_3_numslots);
      addfxandtagtolists(settings.lightgroups_3_fx4, settings.lightgroups_3_tag4, fxlist, taglist, 4, settings.lightgroups_3_numslots);
      break;
    }
    case 3: {
      addfxandtagtolists(settings.lightgroups_4_fx1, settings.lightgroups_4_tag1, fxlist, taglist, 1, settings.lightgroups_4_numslots);
      addfxandtagtolists(settings.lightgroups_4_fx2, settings.lightgroups_4_tag2, fxlist, taglist, 2, settings.lightgroups_4_numslots);
      addfxandtagtolists(settings.lightgroups_4_fx3, settings.lightgroups_4_tag3, fxlist, taglist, 3, settings.lightgroups_4_numslots);
      addfxandtagtolists(settings.lightgroups_4_fx4, settings.lightgroups_4_tag4, fxlist, taglist, 4, settings.lightgroups_4_numslots);
      break;
    }
  }
  for(i = 0; i < fxlist.size; i++) {
    fx_handle = playFXOnTag(localclientnum, fxlist[i], self, taglist[i]);
    if(!isDefined(self.lightfxgroups[groupid])) {
      self.lightfxgroups[groupid] = [];
    } else if(!isarray(self.lightfxgroups[groupid])) {
      self.lightfxgroups[groupid] = array(self.lightfxgroups[groupid]);
    }
    self.lightfxgroups[groupid][self.lightfxgroups[groupid].size] = fx_handle;
  }
}

function field_toggle_lights_group_handler1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self lights_group_toggle(localclientnum, 1, newval);
}

function field_toggle_lights_group_handler2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self lights_group_toggle(localclientnum, 2, newval);
}

function field_toggle_lights_group_handler3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self lights_group_toggle(localclientnum, 3, newval);
}

function field_toggle_lights_group_handler4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self lights_group_toggle(localclientnum, 4, newval);
}

function delete_alert_lights(localclientnum) {
  if(isDefined(self.alert_light_fx_handles)) {
    for(i = 0; i < self.alert_light_fx_handles.size; i++) {
      stopfx(localclientnum, self.alert_light_fx_handles[i]);
    }
  }
  self.alert_light_fx_handles = undefined;
}

function lights_off(localclientnum) {
  if(isDefined(self.light_fx_handles)) {
    for(i = 0; i < self.light_fx_handles.size; i++) {
      stopfx(localclientnum, self.light_fx_handles[i]);
    }
  }
  self.light_fx_handles = undefined;
  delete_alert_lights(localclientnum);
}

function field_toggle_emp(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread toggle_fx_bundle(localclientnum, "emp_base", newval == 1);
}

function field_toggle_burn(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread toggle_fx_bundle(localclientnum, "burn_base", newval == 1);
}

function toggle_fx_bundle(localclientnum, name, turnon) {
  if(!isDefined(self.settings) && isDefined(self.scriptbundlesettings)) {
    self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
  }
  if(!isDefined(self.settings)) {
    return;
  }
  self endon("entityshutdown");
  self notify("end_toggle_field_fx_" + name);
  self endon("end_toggle_field_fx_" + name);
  wait_for_dobj(localclientnum);
  if(!isDefined(self.fx_handles)) {
    self.fx_handles = [];
  }
  if(isDefined(self.fx_handles[name])) {
    handle = self.fx_handles[name];
    if(isarray(handle)) {
      foreach(handleelement in handle) {
        stopfx(localclientnum, handleelement);
      }
    } else {
      stopfx(localclientnum, handle);
    }
  }
  if(turnon) {
    i = 1;
    for(;;) {
      fx = getstructfield(self.settings, (name + "_fx_") + i);
      if(!isDefined(fx)) {
        return;
      }
      tag = getstructfield(self.settings, (name + "_tag_") + i);
      delay = getstructfield(self.settings, (name + "_delay_") + i);
      self thread delayed_fx_thread(localclientnum, name, fx, tag, delay);
      i++;
    }
  }
}

function delayed_fx_thread(localclientnum, name, fx, tag, delay) {
  self endon("entityshutdown");
  self endon("end_toggle_field_fx_" + name);
  if(!isDefined(tag)) {
    return;
  }
  if(isDefined(delay) && delay > 0) {
    wait(delay);
  }
  fx_handle = playFXOnTag(localclientnum, fx, self, tag);
  if(!isDefined(self.fx_handles[name])) {
    self.fx_handles[name] = [];
  } else if(!isarray(self.fx_handles[name])) {
    self.fx_handles[name] = array(self.fx_handles[name]);
  }
  self.fx_handles[name][self.fx_handles[name].size] = fx_handle;
}

function field_toggle_sounds(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.vehicleclass) && self.vehicleclass == "helicopter") {
    if(newval) {
      self notify("stop_heli_sounds");
      self.should_not_play_sounds = 1;
    } else {
      self notify("play_heli_sounds");
      self.should_not_play_sounds = 0;
    }
  }
  if(newval) {
    self disablevehiclesounds();
  } else {
    self enablevehiclesounds();
  }
}

function field_toggle_dnidamagefx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self thread postfx::playpostfxbundle("pstfx_dni_vehicle_dmg");
  }
}

function toggle_flir_postfxbundle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  player = self;
  if(newval == oldval) {
    return;
  }
  if(!isDefined(player) || !player islocalplayer()) {
    return;
  }
  if(newval == 0) {
    player thread postfx::stopplayingpostfxbundle();
    update_ui_fullscreen_filter_model(localclientnum, 0);
  } else {
    if(newval == 1) {
      if(player shouldchangescreenpostfx(localclientnum)) {
        player thread postfx::playpostfxbundle("pstfx_infrared");
        update_ui_fullscreen_filter_model(localclientnum, 2);
      }
    } else if(newval == 2) {
      should_change = 1;
      if(player shouldchangescreenpostfx(localclientnum)) {
        player thread postfx::playpostfxbundle("pstfx_flir");
        update_ui_fullscreen_filter_model(localclientnum, 1);
      }
    }
  }
}

function shouldchangescreenpostfx(localclientnum) {
  player = self;
  assert(isDefined(player));
  if(player getinkillcam(localclientnum)) {
    killcamentity = player getkillcamentity(localclientnum);
    if(isDefined(killcamentity) && killcamentity != player) {
      return false;
    }
  }
  return true;
}

function set_static_postfxbundle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  player = self;
  if(newval == oldval) {
    return;
  }
  if(!isDefined(player) || !player islocalplayer()) {
    return;
  }
  if(newval == 0) {
    player thread postfx::stopplayingpostfxbundle();
  } else if(newval == 1) {
    player thread postfx::playpostfxbundle("pstfx_static");
  }
}

function update_ui_fullscreen_filter_model(localclientnum, vision_set_value) {
  controllermodel = getuimodelforcontroller(localclientnum);
  model = getuimodel(controllermodel, "vehicle.fullscreenFilter");
  if(isDefined(model)) {
    setuimodelvalue(model, vision_set_value);
  }
}

function field_toggle_treadfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.vehicleclass) && self.vehicleclass == "helicopter" || (isDefined(self.vehicleclass) && self.vehicleclass == "plane")) {
    println("");
    if(newval) {
      if(isDefined(bnewent) && bnewent) {
        self.csf_no_tread = 1;
      } else {
        self kill_treads_forever();
      }
    } else {
      if(isDefined(self.csf_no_tread)) {
        self.csf_no_tread = 0;
      }
      self kill_treads_forever();
      self thread aircraft_dustkick();
    }
  } else {
    if(newval) {
      println("");
      if(isDefined(bnewent) && bnewent) {
        println("" + self getentitynumber());
        self.csf_no_tread = 1;
      } else {
        println("" + self getentitynumber());
        self kill_treads_forever();
      }
    } else {
      println("");
      if(isDefined(self.csf_no_tread)) {
        self.csf_no_tread = 0;
      }
      self kill_treads_forever();
    }
  }
}

function field_use_engine_damage_sounds(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.vehicleclass) && self.vehicleclass == "helicopter") {
    switch (newval) {
      case 0: {
        self.engine_damage_low = 0;
        self.engine_damage_high = 0;
        break;
      }
      case 1: {
        self.engine_damage_low = 1;
        self.engine_damage_high = 0;
        break;
      }
      case 1: {
        self.engine_damage_low = 0;
        self.engine_damage_high = 1;
        break;
      }
    }
  }
}

function field_do_deathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  if(newval == 2) {
    self field_do_empdeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
  } else {
    self field_do_standarddeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
  }
}

function field_do_standarddeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval && !binitialsnap) {
    wait_for_dobj(localclientnum);
    if(isDefined(self.deathfxname)) {
      if(isDefined(self.deathfxtag) && self.deathfxtag != "") {
        handle = playFXOnTag(localclientnum, self.deathfxname, self, self.deathfxtag);
      } else {
        handle = playFX(localclientnum, self.deathfxname, self.origin);
      }
      setfxignorepause(localclientnum, handle, 1);
    }
    self playSound(localclientnum, self.deathfxsound);
    if(isDefined(self.deathquakescale) && self.deathquakescale > 0) {
      self earthquake(self.deathquakescale, self.deathquakeduration, self.origin, self.deathquakeradius);
    }
  }
}

function field_do_empdeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.settings) && isDefined(self.scriptbundlesettings)) {
    self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
  }
  if(!isDefined(self.settings)) {
    self field_do_standarddeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
    return;
  }
  if(newval && !binitialsnap) {
    wait_for_dobj(localclientnum);
    s = self.settings;
    if(isDefined(s.emp_death_fx_1)) {
      if(isDefined(s.emp_death_tag_1) && s.emp_death_tag_1 != "") {
        handle = playFXOnTag(localclientnum, s.emp_death_fx_1, self, s.emp_death_tag_1);
      } else {
        handle = playFX(localclientnum, s.emp_death_tag_1, self.origin);
      }
      setfxignorepause(localclientnum, handle, 1);
    }
    self playSound(localclientnum, s.emp_death_sound_1);
    if(isDefined(self.deathquakescale) && self.deathquakescale > 0) {
      self earthquake(self.deathquakescale * 0.25, self.deathquakeduration * 2, self.origin, self.deathquakeradius);
    }
  }
}

function field_update_alert_level(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  delete_alert_lights(localclientnum);
  if(!isDefined(self.scriptbundlesettings)) {
    return;
  }
  if(!isDefined(self.alert_light_fx_handles)) {
    self.alert_light_fx_handles = [];
  }
  settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
  switch (newval) {
    case 0: {
      break;
    }
    case 1: {
      if(isDefined(settings.unawarelightfx1)) {
        self.alert_light_fx_handles[0] = playFXOnTag(localclientnum, settings.unawarelightfx1, self, settings.lighttag1);
      }
      break;
    }
    case 2: {
      if(isDefined(settings.alertlightfx1)) {
        self.alert_light_fx_handles[0] = playFXOnTag(localclientnum, settings.alertlightfx1, self, settings.lighttag1);
      }
      break;
    }
    case 3: {
      if(isDefined(settings.combatlightfx1)) {
        self.alert_light_fx_handles[0] = playFXOnTag(localclientnum, settings.combatlightfx1, self, settings.lighttag1);
      }
      break;
    }
  }
}

function field_toggle_exhaustfx_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(isDefined(bnewent) && bnewent) {
      self.csf_no_exhaust = 1;
    } else {
      self stop_exhaust(localclientnum);
    }
  } else {
    if(isDefined(self.csf_no_exhaust)) {
      self.csf_no_exhaust = 0;
    }
    self stop_exhaust(localclientnum);
    self play_exhaust(localclientnum);
  }
}

function control_lights_groups(localclientnum, on) {
  if(!isDefined(self.scriptbundlesettings)) {
    return;
  }
  settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
  if(!isDefined(settings) || !isDefined(settings.lightgroups_numgroups)) {
    return;
  }
  if(settings.lightgroups_numgroups >= 1 && settings.lightgroups_1_always_on !== 1) {
    lights_group_toggle(localclientnum, 1, on);
  }
  if(settings.lightgroups_numgroups >= 2 && settings.lightgroups_2_always_on !== 1) {
    lights_group_toggle(localclientnum, 2, on);
  }
  if(settings.lightgroups_numgroups >= 3 && settings.lightgroups_3_always_on !== 1) {
    lights_group_toggle(localclientnum, 3, on);
  }
  if(settings.lightgroups_numgroups >= 4 && settings.lightgroups_4_always_on !== 1) {
    lights_group_toggle(localclientnum, 4, on);
  }
}

function field_toggle_lights_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self lights_off(localclientnum);
  } else {
    if(newval == 2) {
      self lights_on(localclientnum, "allies");
    } else {
      if(newval == 3) {
        self lights_on(localclientnum, "axis");
      } else {
        self lights_on(localclientnum);
      }
    }
  }
  control_lights_groups(localclientnum, newval != 1);
}

function field_toggle_lockon_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}

function addfxandtagtolists(fx, tag, &fxlist, &taglist, id, maxid) {
  if(isDefined(fx) && isDefined(tag) && id <= maxid) {
    if(!isDefined(fxlist)) {
      fxlist = [];
    } else if(!isarray(fxlist)) {
      fxlist = array(fxlist);
    }
    fxlist[fxlist.size] = fx;
    if(!isDefined(taglist)) {
      taglist = [];
    } else if(!isarray(taglist)) {
      taglist = array(taglist);
    }
    taglist[taglist.size] = tag;
  }
}

function field_update_damage_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.scriptbundlesettings)) {
    return;
  }
  settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
  if(isDefined(self.damage_state_fx_handles)) {
    foreach(fx_handle in self.damage_state_fx_handles) {
      stopfx(localclientnum, fx_handle);
    }
  }
  self.damage_state_fx_handles = [];
  fxlist = [];
  taglist = [];
  sound = undefined;
  switch (newval) {
    case 0: {
      break;
    }
    case 1: {
      addfxandtagtolists(settings.damagestate_lv1_fx1, settings.damagestate_lv1_tag1, fxlist, taglist, 1, settings.damagestate_lv1_numslots);
      addfxandtagtolists(settings.damagestate_lv1_fx2, settings.damagestate_lv1_tag2, fxlist, taglist, 2, settings.damagestate_lv1_numslots);
      addfxandtagtolists(settings.damagestate_lv1_fx3, settings.damagestate_lv1_tag3, fxlist, taglist, 3, settings.damagestate_lv1_numslots);
      addfxandtagtolists(settings.damagestate_lv1_fx4, settings.damagestate_lv1_tag4, fxlist, taglist, 4, settings.damagestate_lv1_numslots);
      sound = settings.damagestate_lv1_sound;
      break;
    }
    case 2: {
      addfxandtagtolists(settings.damagestate_lv2_fx1, settings.damagestate_lv2_tag1, fxlist, taglist, 1, settings.damagestate_lv2_numslots);
      addfxandtagtolists(settings.damagestate_lv2_fx2, settings.damagestate_lv2_tag2, fxlist, taglist, 2, settings.damagestate_lv2_numslots);
      addfxandtagtolists(settings.damagestate_lv2_fx3, settings.damagestate_lv2_tag3, fxlist, taglist, 3, settings.damagestate_lv2_numslots);
      addfxandtagtolists(settings.damagestate_lv2_fx4, settings.damagestate_lv2_tag4, fxlist, taglist, 4, settings.damagestate_lv2_numslots);
      sound = settings.damagestate_lv2_sound;
      break;
    }
    case 3: {
      addfxandtagtolists(settings.damagestate_lv3_fx1, settings.damagestate_lv3_tag1, fxlist, taglist, 1, settings.damagestate_lv3_numslots);
      addfxandtagtolists(settings.damagestate_lv3_fx2, settings.damagestate_lv3_tag2, fxlist, taglist, 2, settings.damagestate_lv3_numslots);
      addfxandtagtolists(settings.damagestate_lv3_fx3, settings.damagestate_lv3_tag3, fxlist, taglist, 3, settings.damagestate_lv3_numslots);
      addfxandtagtolists(settings.damagestate_lv3_fx4, settings.damagestate_lv3_tag4, fxlist, taglist, 4, settings.damagestate_lv3_numslots);
      sound = settings.damagestate_lv3_sound;
      break;
    }
    case 4: {
      addfxandtagtolists(settings.damagestate_lv4_fx1, settings.damagestate_lv4_tag1, fxlist, taglist, 1, settings.damagestate_lv4_numslots);
      addfxandtagtolists(settings.damagestate_lv4_fx2, settings.damagestate_lv4_tag2, fxlist, taglist, 2, settings.damagestate_lv4_numslots);
      addfxandtagtolists(settings.damagestate_lv4_fx3, settings.damagestate_lv4_tag3, fxlist, taglist, 3, settings.damagestate_lv4_numslots);
      addfxandtagtolists(settings.damagestate_lv4_fx4, settings.damagestate_lv4_tag4, fxlist, taglist, 4, settings.damagestate_lv4_numslots);
      sound = settings.damagestate_lv4_sound;
      break;
    }
    case 5: {
      addfxandtagtolists(settings.damagestate_lv5_fx1, settings.damagestate_lv5_tag1, fxlist, taglist, 1, settings.damagestate_lv5_numslots);
      addfxandtagtolists(settings.damagestate_lv5_fx2, settings.damagestate_lv5_tag2, fxlist, taglist, 2, settings.damagestate_lv5_numslots);
      addfxandtagtolists(settings.damagestate_lv5_fx3, settings.damagestate_lv5_tag3, fxlist, taglist, 3, settings.damagestate_lv5_numslots);
      addfxandtagtolists(settings.damagestate_lv5_fx4, settings.damagestate_lv5_tag4, fxlist, taglist, 4, settings.damagestate_lv5_numslots);
      sound = settings.damagestate_lv5_sound;
      break;
    }
    case 6: {
      addfxandtagtolists(settings.damagestate_lv6_fx1, settings.damagestate_lv6_tag1, fxlist, taglist, 1, settings.damagestate_lv6_numslots);
      addfxandtagtolists(settings.damagestate_lv6_fx2, settings.damagestate_lv6_tag2, fxlist, taglist, 2, settings.damagestate_lv6_numslots);
      addfxandtagtolists(settings.damagestate_lv6_fx3, settings.damagestate_lv6_tag3, fxlist, taglist, 3, settings.damagestate_lv6_numslots);
      addfxandtagtolists(settings.damagestate_lv6_fx4, settings.damagestate_lv6_tag4, fxlist, taglist, 4, settings.damagestate_lv6_numslots);
      sound = settings.damagestate_lv6_sound;
      break;
    }
  }
  for(i = 0; i < fxlist.size; i++) {
    fx_handle = playFXOnTag(localclientnum, fxlist[i], self, taglist[i]);
    if(!isDefined(self.damage_state_fx_handles)) {
      self.damage_state_fx_handles = [];
    } else if(!isarray(self.damage_state_fx_handles)) {
      self.damage_state_fx_handles = array(self.damage_state_fx_handles);
    }
    self.damage_state_fx_handles[self.damage_state_fx_handles.size] = fx_handle;
  }
  if(isDefined(self) && isDefined(sound)) {
    self playSound(localclientnum, sound);
  }
}

function field_death_spawn_dynents(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.scriptbundlesettings)) {
    return;
  }
  settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
  if(localclientnum == 0) {
    velocity = self getvelocity();
    numdynents = (isDefined(settings.death_dynent_count) ? settings.death_dynent_count : 0);
    for(i = 0; i < numdynents; i++) {
      model = getstructfield(settings, "death_dynmodel" + i);
      if(!isDefined(model)) {
        continue;
      }
      gibpart = getstructfield(settings, "death_dynent_gib" + i);
      if(self.gibbed === 1 && gibpart === 1) {
        continue;
      }
      pitch = (isDefined(getstructfield(settings, "death_dynent_force_pitch" + i)) ? getstructfield(settings, "death_dynent_force_pitch" + i) : 0);
      yaw = (isDefined(getstructfield(settings, "death_dynent_force_yaw" + i)) ? getstructfield(settings, "death_dynent_force_yaw" + i) : 0);
      angles = (randomfloatrange(pitch - 15, pitch + 15), randomfloatrange(yaw - 20, yaw + 20), randomfloatrange(-20, 20));
      direction = anglesToForward(self.angles + angles);
      minscale = (isDefined(getstructfield(settings, "death_dynent_force_minscale" + i)) ? getstructfield(settings, "death_dynent_force_minscale" + i) : 0);
      maxscale = (isDefined(getstructfield(settings, "death_dynent_force_maxscale" + i)) ? getstructfield(settings, "death_dynent_force_maxscale" + i) : 0);
      force = direction * randomfloatrange(minscale, maxscale);
      loc_00005A9E:
        loc_00005AEE:
        offset = ((isDefined(getstructfield(settings, "death_dynent_offsetX" + i)) ? getstructfield(settings, "death_dynent_offsetX" + i) : 0), (isDefined(getstructfield(settings, "death_dynent_offsetY" + i)) ? getstructfield(settings, "death_dynent_offsetY" + i) : 0), (isDefined(getstructfield(settings, "death_dynent_offsetZ" + i)) ? getstructfield(settings, "death_dynent_offsetZ" + i) : 0));
      switch (newval) {
        case 0: {
          break;
        }
        case 1: {
          fx = getstructfield(settings, "death_dynent_fx" + i);
          break;
        }
        case 2: {
          fx = getstructfield(settings, "death_dynent_elec_fx" + i);
          break;
        }
        case 3: {
          fx = getstructfield(settings, "death_dynent_fire_fx" + i);
          break;
        }
      }
      offset = rotatepoint(offset, self.angles);
      if(newval > 1 && isDefined(fx)) {
        dynent = createdynentandlaunch(localclientnum, model, self.origin + offset, self.angles, (0, 0, 0), velocity * 0.8, fx);
      } else {
        if(newval == 1 && isDefined(fx)) {
          dynent = createdynentandlaunch(localclientnum, model, self.origin + offset, self.angles, (0, 0, 0), velocity * 0.8, fx);
        } else {
          dynent = createdynentandlaunch(localclientnum, model, self.origin + offset, self.angles, (0, 0, 0), velocity * 0.8);
        }
      }
      if(isDefined(dynent)) {
        hitoffset = (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-5, 5));
        launchdynent(dynent, force, hitoffset);
      }
    }
  }
}

function field_gib_spawn_dynents(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.scriptbundlesettings)) {
    return;
  }
  settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
  if(localclientnum == 0) {
    velocity = self getvelocity();
    numdynents = 2;
    for(i = 0; i < numdynents; i++) {
      model = getstructfield(settings, "servo_gib_model" + i);
      if(!isDefined(model)) {
        return;
      }
      self.gibbed = 1;
      origin = self.origin;
      angles = self.angles;
      hidetag = getstructfield(settings, "servo_gib_tag" + i);
      if(isDefined(hidetag)) {
        origin = self gettagorigin(hidetag);
        angles = self gettagangles(hidetag);
      }
      pitch = (isDefined(getstructfield(settings, "servo_gib_force_pitch" + i)) ? getstructfield(settings, "servo_gib_force_pitch" + i) : 0);
      yaw = (isDefined(getstructfield(settings, "servo_gib_force_yaw" + i)) ? getstructfield(settings, "servo_gib_force_yaw" + i) : 0);
      relative_angles = (randomfloatrange(pitch - 5, pitch + 5), randomfloatrange(yaw - 5, yaw + 5), randomfloatrange(-5, 5));
      direction = anglesToForward(angles + relative_angles);
      minscale = (isDefined(getstructfield(settings, "servo_gib_force_minscale" + i)) ? getstructfield(settings, "servo_gib_force_minscale" + i) : 0);
      maxscale = (isDefined(getstructfield(settings, "servo_gib_force_maxscale" + i)) ? getstructfield(settings, "servo_gib_force_maxscale" + i) : 0);
      force = direction * randomfloatrange(minscale, maxscale);
      loc_0000623E:
        loc_0000628E:
        offset = ((isDefined(getstructfield(settings, "servo_gib_offsetX" + i)) ? getstructfield(settings, "servo_gib_offsetX" + i) : 0), (isDefined(getstructfield(settings, "servo_gib_offsetY" + i)) ? getstructfield(settings, "servo_gib_offsetY" + i) : 0), (isDefined(getstructfield(settings, "servo_gib_offsetZ" + i)) ? getstructfield(settings, "servo_gib_offsetZ" + i) : 0));
      fx = getstructfield(settings, "servo_gib_fx" + i);
      offset = rotatepoint(offset, angles);
      if(isDefined(fx)) {
        dynent = createdynentandlaunch(localclientnum, model, origin + offset, angles, (0, 0, 0), velocity * 0.8, fx);
      } else {
        dynent = createdynentandlaunch(localclientnum, model, origin + offset, angles, (0, 0, 0), velocity * 0.8);
      }
      if(isDefined(dynent)) {
        hitoffset = (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-5, 5));
        launchdynent(dynent, force, hitoffset);
      }
    }
  }
}

function autoexec build_damage_filter_list() {
  if(!isDefined(level.vehicle_damage_filters)) {
    level.vehicle_damage_filters = [];
  }
  level.vehicle_damage_filters[0] = "generic_filter_vehicle_damage";
  level.vehicle_damage_filters[1] = "generic_filter_sam_damage";
  level.vehicle_damage_filters[2] = "generic_filter_f35_damage";
  level.vehicle_damage_filters[3] = "generic_filter_vehicle_damage_sonar";
  level.vehicle_damage_filters[4] = "generic_filter_rts_vehicle_damage";
}

function init_damage_filter(materialid) {
  level.localplayers[0].damage_filter_intensity = 0;
  materialname = level.vehicle_damage_filters[materialid];
  filter::init_filter_vehicle_damage(level.localplayers[0], materialname);
  filter::enable_filter_vehicle_damage(level.localplayers[0], 3, materialname);
  filter::set_filter_vehicle_damage_amount(level.localplayers[0], 3, 0);
  filter::set_filter_vehicle_sun_position(level.localplayers[0], 3, 0, 0);
}

function damage_filter_enable(localclientnum, materialid) {
  filter::enable_filter_vehicle_damage(level.localplayers[0], 3, level.vehicle_damage_filters[materialid]);
  level.localplayers[0].damage_filter_intensity = 0;
  filter::set_filter_vehicle_damage_amount(level.localplayers[0], 3, level.localplayers[0].damage_filter_intensity);
}

function damage_filter_disable(localclientnum) {
  level notify("damage_filter_off");
  level.localplayers[0].damage_filter_intensity = 0;
  filter::set_filter_vehicle_damage_amount(level.localplayers[0], 3, level.localplayers[0].damage_filter_intensity);
  filter::disable_filter_vehicle_damage(level.localplayers[0], 3);
}

function damage_filter_off(localclientnum) {
  level endon("damage_filter");
  level endon("damage_filter_off");
  level endon("damage_filter_heavy");
  if(!isDefined(level.localplayers[0].damage_filter_intensity)) {
    return;
  }
  while(level.localplayers[0].damage_filter_intensity > 0) {
    level.localplayers[0].damage_filter_intensity = level.localplayers[0].damage_filter_intensity - 0.05050606;
    if(level.localplayers[0].damage_filter_intensity < 0) {
      level.localplayers[0].damage_filter_intensity = 0;
    }
    filter::set_filter_vehicle_damage_amount(level.localplayers[0], 3, level.localplayers[0].damage_filter_intensity);
    wait(0.016667);
  }
}

function damage_filter_light(localclientnum) {
  level endon("damage_filter_off");
  level endon("damage_filter_heavy");
  level notify("damage_filter");
  while(level.localplayers[0].damage_filter_intensity < 0.5) {
    level.localplayers[0].damage_filter_intensity = level.localplayers[0].damage_filter_intensity + 0.083335;
    if(level.localplayers[0].damage_filter_intensity > 0.5) {
      level.localplayers[0].damage_filter_intensity = 0.5;
    }
    filter::set_filter_vehicle_damage_amount(level.localplayers[0], 3, level.localplayers[0].damage_filter_intensity);
    wait(0.016667);
  }
}

function damage_filter_heavy(localclientnum) {
  level endon("damage_filter_off");
  level notify("damage_filter_heavy");
  while(level.localplayers[0].damage_filter_intensity < 1) {
    level.localplayers[0].damage_filter_intensity = level.localplayers[0].damage_filter_intensity + 0.083335;
    if(level.localplayers[0].damage_filter_intensity > 1) {
      level.localplayers[0].damage_filter_intensity = 1;
    }
    filter::set_filter_vehicle_damage_amount(level.localplayers[0], 3, level.localplayers[0].damage_filter_intensity);
    wait(0.016667);
  }
}