/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\vehicle_shared.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\filter_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\vehicleriders_shared;

#namespace vehicle;

autoexec __init__system__() {
  system::register(#"vehicle_shared", &__init__, undefined, undefined);
}

__init__() {
  level._customvehiclecbfunc = &spawned_callback;
  level.var_e583fd9b = &function_2f2a656a;
  level.var_8e36d09b = &function_cc71cf1a;
  level.allvehicles = [];
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
  clientfield::register("vehicle", "toggle_force_driver_taillights", 1, 1, "int", &function_7baff7f6, 0, 0);
  clientfield::register("vehicle", "toggle_ambient_anim_group1", 1, 1, "int", &field_toggle_ambient_anim_handler1, 0, 0);
  clientfield::register("vehicle", "toggle_ambient_anim_group2", 1, 1, "int", &field_toggle_ambient_anim_handler2, 0, 0);
  clientfield::register("vehicle", "toggle_ambient_anim_group3", 1, 1, "int", &field_toggle_ambient_anim_handler3, 0, 0);
  clientfield::register("vehicle", "toggle_control_bone_group1", 1, 1, "int", &function_d427b534, 0, 0);
  clientfield::register("vehicle", "toggle_control_bone_group2", 1, 1, "int", &nova_crawler_spawnerbamfterminate, 0, 0);
  clientfield::register("vehicle", "toggle_control_bone_group3", 1, 1, "int", &function_48a01e23, 0, 0);
  clientfield::register("vehicle", "toggle_control_bone_group4", 1, 1, "int", &function_6ad96295, 0, 0);
  clientfield::register("vehicle", "toggle_emp_fx", 1, 1, "int", &field_toggle_emp, 0, 0);
  clientfield::register("vehicle", "toggle_burn_fx", 1, 1, "int", &field_toggle_burn, 0, 0);
  clientfield::register("vehicle", "deathfx", 1, 2, "int", &field_do_deathfx, 0, 1);
  clientfield::register("vehicle", "stopallfx", 1, 1, "int", &function_1ea3bdef, 0, 0);
  clientfield::register("vehicle", "flickerlights", 1, 2, "int", &flicker_lights, 0, 0);
  clientfield::register("vehicle", "alert_level", 1, 2, "int", &field_update_alert_level, 0, 0);
  clientfield::register("vehicle", "set_lighting_ent", 1, 1, "int", &util::field_set_lighting_ent, 0, 0);
  clientfield::register("vehicle", "stun", 1, 1, "int", &function_d7a2c2f, 0, 0);
  clientfield::register("vehicle", "use_lighting_ent", 1, 1, "int", &util::field_use_lighting_ent, 0, 0);
  clientfield::register("vehicle", "damage_level", 1, 3, "int", &field_update_damage_state, 0, 0);
  clientfield::register("vehicle", "spawn_death_dynents", 1, 2, "int", &field_death_spawn_dynents, 0, 0);
  clientfield::register("vehicle", "spawn_gib_dynents", 1, 1, "int", &field_gib_spawn_dynents, 0, 0);
  clientfield::register("vehicle", "toggle_horn_sound", 1, 1, "int", &function_2d24296, 0, 0);
  clientfield::register("vehicle", "update_malfunction", 1, 2, "int", &function_7d1d0e65, 0, 0);

  if(!sessionmodeiszombiesgame() && !(isDefined(level.var_7b05c4b5) && level.var_7b05c4b5)) {
    clientfield::register("clientuimodel", "vehicle.ammoCount", 1, 10, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "vehicle.ammoReloading", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "vehicle.ammoLow", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "vehicle.rocketAmmo", 1, 2, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "vehicle.ammo2Count", 1, 10, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "vehicle.ammo2Reloading", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "vehicle.ammo2Low", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "vehicle.collisionWarning", 1, 2, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "vehicle.enemyInReticle", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "vehicle.missileRepulsed", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "vehicle.incomingMissile", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "vehicle.missileLock", 1, 2, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "vehicle.malfunction", 1, 2, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "vehicle.showHoldToExitPrompt", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "vehicle.holdToExitProgress", 1, 5, "float", undefined, 0, 0);
    clientfield::register("clientuimodel", "vehicle.vehicleAttackMode", 1, 3, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "vehicle.invalidLanding", 1, 1, "int", undefined, 0, 0);

    for(i = 0; i < 3; i++) {
      clientfield::register("clientuimodel", "vehicle.bindingCooldown" + i + ".cooldown", 1, 5, "float", undefined, 0, 0);
    }
  }

  clientfield::register("toplayer", "toggle_dnidamagefx", 1, 1, "int", &field_toggle_dnidamagefx, 0, 0);
  clientfield::register("toplayer", "toggle_flir_postfx", 1, 2, "int", &toggle_flir_postfxbundle, 0, 0);
  clientfield::register("toplayer", "static_postfx", 1, 1, "int", &set_static_postfxbundle, 0, 1);
  clientfield::register("vehicle", "vehUseMaterialPhysics", 1, 1, "int", &function_9facca21, 0, 0);
  clientfield::register("scriptmover", "play_flare_fx", 1, 1, "int", &play_flare_fx, 0, 0);
  clientfield::register("scriptmover", "play_flare_hit_fx", 1, 1, "int", &play_flare_hit_fx, 0, 0);
}

add_vehicletype_callback(vehicletype, callback, data = undefined) {
  if(!isDefined(level.vehicletypecallbackarray)) {
    level.vehicletypecallbackarray = [];
  }

  if(!isDefined(level.var_1ac8f820)) {
    level.var_1ac8f820 = [];
  }

  level.vehicletypecallbackarray[vehicletype] = callback;
  level.var_1ac8f820[vehicletype] = data;
}

private function_dd27aacd(localclientnum, vehicletype) {
  if(isDefined(vehicletype) && isDefined(level.vehicletypecallbackarray[vehicletype])) {
    if(isDefined(level.var_1ac8f820[vehicletype])) {
      self thread[[level.vehicletypecallbackarray[vehicletype]]](localclientnum, level.var_1ac8f820[vehicletype]);
    } else {
      self thread[[level.vehicletypecallbackarray[vehicletype]]](localclientnum);
    }

    return true;
  }

  return false;
}

spawned_callback(localclientnum) {
  if(isDefined(self.vehicleridersbundle)) {
    set_vehicleriders_bundle(self.vehicleridersbundle);
  }

  self callback::callback(#"on_vehicle_spawned", localclientnum);
  vehicletype = self.vehicletype;

  if(isDefined(level.vehicletypecallbackarray)) {
    if(!function_dd27aacd(localclientnum, vehicletype)) {
      function_dd27aacd(localclientnum, self.scriptvehicletype);
    }
  }

  if(self usessubtargets()) {
    self thread watch_vehicle_damage();
  }

  array::add(level.allvehicles, self, 0);
  self callback::on_shutdown(&on_shutdown);
}

function_2f97bc52(vehicletype, callback) {
  if(!isDefined(level.var_fedb0575)) {
    level.var_fedb0575 = [];
  }

  level.var_fedb0575[vehicletype] = callback;
}

function_2f2a656a(localclientnum, vehicle) {
  if(isDefined(vehicle)) {
    vehicletype = vehicle.vehicletype;

    if(isDefined(vehicletype) && isDefined(level.var_fedb0575) && isDefined(level.var_fedb0575[vehicletype])) {
      self thread[[level.var_fedb0575[vehicletype]]](localclientnum, vehicle);
    }
  }
}

function_cd2ede5(vehicletype, callback) {
  if(!isDefined(level.var_9b02f595)) {
    level.var_9b02f595 = [];
  }

  level.var_9b02f595[vehicletype] = callback;
}

function_cc71cf1a(localclientnum, vehicle) {
  if(isDefined(vehicle)) {
    vehicletype = vehicle.vehicletype;

    if(isDefined(vehicletype) && isDefined(level.var_9b02f595) && isDefined(level.var_9b02f595[vehicletype])) {
      self thread[[level.var_9b02f595[vehicletype]]](localclientnum, vehicle);
    }
  }
}

on_shutdown(localclientnum) {
  self function_dcec5385();
  arrayremovevalue(level.allvehicles, self);
}

watch_vehicle_damage() {
  self endon(#"death");
  self.notifyonbulletimpact = 1;

  while(isDefined(self)) {
    waitresult = self waittill(#"damage");
    subtarget = waitresult.subtarget;
    attacker = waitresult.attacker;

    if(attacker function_21c0fa55() && isDefined(subtarget) && subtarget > 0) {
      self thread function_a87e7c22(subtarget);
    }
  }
}

function_a87e7c22(subtarget) {
  self endon(#"death");
  time = gettime();

  if(isDefined(subtarget)) {
    if(!isDefined(self.var_d2c05029)) {
      self.var_d2c05029 = [];
    }

    if(!isDefined(self.var_d2c05029[subtarget]) || self.var_d2c05029[subtarget] <= time) {
      self.var_d2c05029[subtarget] = time + 150;
      bone = self submodelboneforsubtarget(subtarget);
      self playrenderoverridebundle(#"hash_20bdbaa0db5eb57d", bone);
      wait 0.1;
      self stoprenderoverridebundle(#"hash_20bdbaa0db5eb57d", bone);
    }

    return;
  }

  self playrenderoverridebundle(#"hash_20bdbaa0db5eb57d");
  wait 0.15;
  self stoprenderoverridebundle(#"hash_20bdbaa0db5eb57d");
}

rumble(localclientnum) {
  self endon(#"death");

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
  wait 2;

  while(true) {
    if(!isDefined(level.localplayers[localclientnum]) || distancesquared(self.origin, level.localplayers[localclientnum].origin) > radius_squared || self getspeed() == 0) {
      wait 0.2;
      continue;
    }

    if(isDefined(self.rumbleon) && !self.rumbleon) {
      wait 0.2;
      continue;
    }

    self playrumblelooponentity(localclientnum, self.rumbletype);

    while(isDefined(level.localplayers[localclientnum]) && distancesquared(self.origin, level.localplayers[localclientnum].origin) < radius_squared && self getspeed() > 0) {
      earthquake(localclientnum, self.rumblescale, self.rumbleduration, self.origin, self.rumbleradius);
      time_to_wait = self.rumblebasetime + randomfloat(self.rumbleadditionaltime);

      if(time_to_wait <= 0) {
        time_to_wait = 0.05;
      }

      wait time_to_wait;
    }

    if(isDefined(level.localplayers[localclientnum])) {
      self stoprumble(localclientnum, self.rumbletype);
    }

    waitframe(1);
  }
}

kill_treads_forever() {
  self notify(#"kill_treads_forever");
}

play_exhaust(localclientnum) {
  if(!isDefined(self)) {
    return;
  }

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
      assert(isDefined(self.exhaustfxtag1), self.vehicletype + "<dev string:x38>");
      self endon(#"death");
      self util::waittill_dobj(localclientnum);
      self.exhaust_id_left = util::playFXOnTag(localclientnum, self.exhaust_fx, self, self.exhaustfxtag1);

      if(!isDefined(self.exhaust_id_right) && isDefined(self.exhaustfxtag2)) {
        self.exhaust_id_right = util::playFXOnTag(localclientnum, self.exhaust_fx, self, self.exhaustfxtag2);
      }
    }
  }
}

stop_exhaust(localclientnum) {
  self util::waittill_dobj(localclientnum);
  waitframe(1);

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.exhaust_id_left)) {
    stopfx(localclientnum, self.exhaust_id_left);
    self.exhaust_id_left = undefined;
  }

  if(isDefined(self.exhaust_id_right)) {
    stopfx(localclientnum, self.exhaust_id_right);
    self.exhaust_id_right = undefined;
  }
}

boost_think(localclientnum) {
  self endon(#"death");

  for(;;) {
    self waittill(#"veh_boost");
    self play_boost(localclientnum, 0);

    if(isinvehicle(localclientnum, self)) {
      self play_boost(localclientnum, 1);
    }
  }
}

play_boost(localclientnum, var_a7ba3864) {
  if(var_a7ba3864) {
    var_121afd6f = self.var_9ded117e;
    var_c1da0b13 = self.var_8559c35b;
    var_74ceb128 = undefined;
  } else {
    var_121afd6f = self.var_82ecf3f7;
    var_c1da0b13 = self.var_41882855;
    var_74ceb128 = self.var_a75cf435;
  }

  if(isDefined(var_121afd6f)) {
    if(isalive(self)) {
      assert(isDefined(var_c1da0b13), self.vehicletype + "<dev string:x96>");
      self endon(#"death");
      self util::waittill_dobj(localclientnum);
      var_1ca9b241 = util::playFXOnTag(localclientnum, var_121afd6f, self, var_c1da0b13);

      if(isDefined(var_74ceb128)) {
        var_4dfb2154 = util::playFXOnTag(localclientnum, var_121afd6f, self, var_74ceb128);
      }

      if(var_a7ba3864) {
        self thread function_5ce3e74e(localclientnum, var_1ca9b241);
      }

      self thread kill_boost(localclientnum, var_1ca9b241);

      if(isDefined(var_4dfb2154)) {
        self thread kill_boost(localclientnum, var_4dfb2154);
      }
    }
  }
}

kill_boost(localclientnum, var_1ca9b241) {
  self endon(#"death");
  wait self.boostduration + 0.5;
  self notify(#"end_boost");

  if(isDefined(var_1ca9b241)) {
    stopfx(localclientnum, var_1ca9b241);
  }
}

function_5ce3e74e(localclientnum, var_1ca9b241) {
  self endon(#"end_boost");
  self endon(#"veh_boost");
  self endon(#"death");

  while(true) {
    if(!isinvehicle(localclientnum, self)) {
      if(isDefined(var_1ca9b241)) {
        stopfx(localclientnum, var_1ca9b241);
      }

      break;
    }

    waitframe(1);
  }
}

aircraft_dustkick() {
  self endon(#"death");
  waittillframeend();
  self endon(#"kill_treads_forever");

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.treadfxnamearray)) {
    return;
  }

  if(isDefined(self.csf_no_tread) && self.csf_no_tread) {
    return;
  }

  while(isDefined(self)) {
    fxarray = self.treadfxnamearray;

    if(!isDefined(fxarray)) {
      wait 1;
      continue;
    }

    trace = bulletTrace(self.origin, self.origin - (0, 0, 700 * 2), 0, self, 1);
    distsqr = distancesquared(self.origin, trace[#"position"]);

    if(trace[#"fraction"] < 0.01 || distsqr < 0 * 0) {
      wait 0.2;
      continue;
    } else if(trace[#"fraction"] >= 1 || distsqr > 700 * 700) {
      wait 1;
      continue;
    }

    if(0 * 0 < distsqr && distsqr < 700 * 700) {
      surfacetype = trace[#"surfacetype"];

      if(!isDefined(surfacetype)) {
        surfacetype = "dirt";
      }

      if(isDefined(fxarray[surfacetype])) {
        forward = anglesToForward(self.angles);
        playFX(0, fxarray[surfacetype], trace[#"position"], (0, 0, 1), forward);
      }

      velocity = self getvelocity();
      speed = length(velocity);
      waittime = mapfloat(10, 100, 1, 0.2, speed);
      wait waittime;
      continue;
    }

    wait 1;
    continue;
  }
}

lights_on(localclientnum, team) {
  lights_off(localclientnum);

  if(!isalive(self)) {
    return;
  }

  self endon(#"death");
  util::waittill_dobj(localclientnum);

  if(isDefined(self.lightfxnamearray)) {
    if(!isDefined(self.light_fx_handles)) {
      self.light_fx_handles = [];
    }

    for(i = 0; i < self.lightfxnamearray.size; i++) {
      self.light_fx_handles[i] = util::playFXOnTag(localclientnum, self.lightfxnamearray[i], self, self.lightfxtagarray[i]);
      setfxignorepause(localclientnum, self.light_fx_handles[i], 1);

      if(isDefined(team)) {
        setfxteam(localclientnum, self.light_fx_handles[i], team);
      }
    }
  }
}

addanimtolist(animitem, &liston, &listoff, playwhenoff, id, maxid) {
  if(isDefined(animitem) && id <= maxid) {
    if(playwhenoff === 1) {
      if(!isDefined(listoff)) {
        listoff = [];
      } else if(!isarray(listoff)) {
        listoff = array(listoff);
      }

      listoff[listoff.size] = animitem;
      return;
    }

    if(!isDefined(liston)) {
      liston = [];
    } else if(!isarray(liston)) {
      liston = array(liston);
    }

    liston[liston.size] = animitem;
  }
}

ambient_anim_toggle(localclientnum, groupid, ison) {
  if(!isDefined(self.scriptbundlesettings)) {
    return;
  }

  settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);

  if(!isDefined(settings)) {
    return;
  }

  self endon(#"death");
  util::waittill_dobj(localclientnum);
  liston = [];
  listoff = [];

  switch (groupid) {
    case 1:
      addanimtolist(settings.ambient_group1_anim1, liston, listoff, settings.ambient_group1_off1, 1, settings.ambient_group1_numslots);
      addanimtolist(settings.ambient_group1_anim2, liston, listoff, settings.ambient_group1_off2, 2, settings.ambient_group1_numslots);
      addanimtolist(settings.ambient_group1_anim3, liston, listoff, settings.ambient_group1_off3, 3, settings.ambient_group1_numslots);
      addanimtolist(settings.ambient_group1_anim4, liston, listoff, settings.ambient_group1_off4, 4, settings.ambient_group1_numslots);
      break;
    case 2:
      addanimtolist(settings.ambient_group2_anim1, liston, listoff, settings.ambient_group2_off1, 1, settings.ambient_group2_numslots);
      addanimtolist(settings.ambient_group2_anim2, liston, listoff, settings.ambient_group2_off2, 2, settings.ambient_group2_numslots);
      addanimtolist(settings.ambient_group2_anim3, liston, listoff, settings.ambient_group2_off3, 3, settings.ambient_group2_numslots);
      addanimtolist(settings.ambient_group2_anim4, liston, listoff, settings.ambient_group2_off4, 4, settings.ambient_group2_numslots);
      break;
    case 3:
      addanimtolist(settings.ambient_group3_anim1, liston, listoff, settings.ambient_group3_off1, 1, settings.ambient_group3_numslots);
      addanimtolist(settings.ambient_group3_anim2, liston, listoff, settings.ambient_group3_off2, 2, settings.ambient_group3_numslots);
      addanimtolist(settings.ambient_group3_anim3, liston, listoff, settings.ambient_group3_off3, 3, settings.ambient_group3_numslots);
      addanimtolist(settings.ambient_group3_anim4, liston, listoff, settings.ambient_group3_off4, 4, settings.ambient_group3_numslots);
      break;
    case 4:
      addanimtolist(settings.ambient_group4_anim1, liston, listoff, settings.ambient_group4_off1, 1, settings.ambient_group4_numslots);
      addanimtolist(settings.ambient_group4_anim2, liston, listoff, settings.ambient_group4_off2, 2, settings.ambient_group4_numslots);
      addanimtolist(settings.ambient_group4_anim3, liston, listoff, settings.ambient_group4_off3, 3, settings.ambient_group4_numslots);
      addanimtolist(settings.ambient_group4_anim4, liston, listoff, settings.ambient_group4_off4, 4, settings.ambient_group4_numslots);
      break;
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

field_toggle_ambient_anim_handler1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self ambient_anim_toggle(localclientnum, 1, newval);
}

field_toggle_ambient_anim_handler2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self ambient_anim_toggle(localclientnum, 2, newval);
}

field_toggle_ambient_anim_handler3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self ambient_anim_toggle(localclientnum, 3, newval);
}

field_toggle_ambient_anim_handler4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self ambient_anim_toggle(localclientnum, 4, newval);
}

function_7927d9b1(settings, groupid) {
  switch (groupid) {
    case 1:
      return settings.setup_lgt_glowyriver;
    case 2:
      return settings.var_aaf4ef8c;
    case 3:
      return settings.var_98404a23;
    case 4:
      return settings.var_8e9936d5;
  }
}

function_34105b89(localclientnum, groupid, ison) {
  if(!isDefined(self.scriptbundlesettings)) {
    return;
  }

  settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);

  if(!isDefined(settings)) {
    return;
  }

  num_slots = settings.var_e08bc957;

  if(isDefined(num_slots) && groupid > num_slots) {
    return;
  }

  self endon(#"death");
  util::waittill_dobj(localclientnum);
  bone_group = function_7927d9b1(settings, groupid);

  if(!isarray(bone_group)) {
    return;
  }

  foreach(var_b969bea7 in bone_group) {
    if(isDefined(var_b969bea7) && isDefined(var_b969bea7.var_f08513a)) {
      self function_d309e55a(var_b969bea7.var_f08513a, ison);
    }
  }
}

function_d427b534(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_34105b89(localclientnum, 1, newval);
}

nova_crawler_spawnerbamfterminate(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_34105b89(localclientnum, 2, newval);
}

function_48a01e23(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_34105b89(localclientnum, 3, newval);
}

function_6ad96295(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_34105b89(localclientnum, 4, newval);
}

event_handler[enter_vehicle] codecallback_vehicleenter(eventstruct) {
  if(!isplayer(self)) {
    return;
  }

  vehicle = eventstruct.vehicle;
  localclientnum = eventstruct.localclientnum;

  if(vehicle isvehicle()) {
    seatindex = vehicle getoccupantseat(localclientnum, self);

    if(!isDefined(seatindex)) {
      return;
    }

    var_fd110a27 = vehicle function_a3f90231(seatindex);

    if(!isDefined(var_fd110a27)) {
      return;
    }

    var_8730ee3e = getscriptbundle(var_fd110a27);

    if(isDefined(var_8730ee3e)) {
      if(isDefined(var_8730ee3e.zmenhancedstatejukeinit) && var_8730ee3e.zmenhancedstatejukeinit) {
        if(!isDefined(vehicle.t_sarah_foy_objective__indicator_)) {
          vehicle.t_sarah_foy_objective__indicator_ = [];
        }

        if(isDefined(vehicle.t_sarah_foy_objective__indicator_[seatindex]) && vehicle.t_sarah_foy_objective__indicator_[seatindex]) {
          return;
        }

        vehicle.t_sarah_foy_objective__indicator_[seatindex] = 1;
      }

      animation = var_8730ee3e.vehicleenteranim;

      if(isDefined(animation)) {
        vehicle setanimrestart(animation, 1, 0, 1);
      }
    }
  }
}

event_handler[change_seat] function_124469f4(eventstruct) {
  if(!isplayer(self)) {
    return;
  }

  vehicle = eventstruct.vehicle;
  localclientnum = eventstruct.localclientnum;

  if(vehicle isvehicle()) {
    seatindex = vehicle getoccupantseat(localclientnum, self);

    if(!isDefined(seatindex)) {
      return;
    }

    var_fd110a27 = vehicle function_a3f90231(seatindex);

    if(!isDefined(var_fd110a27)) {
      return;
    }

    var_8730ee3e = getscriptbundle(var_fd110a27);

    if(isDefined(var_8730ee3e)) {
      if(!(isDefined(var_8730ee3e.var_8d496bb1) && var_8730ee3e.var_8d496bb1)) {
        return;
      }

      if(isDefined(var_8730ee3e.zmenhancedstatejukeinit) && var_8730ee3e.zmenhancedstatejukeinit) {
        if(!isDefined(vehicle.t_sarah_foy_objective__indicator_)) {
          vehicle.t_sarah_foy_objective__indicator_ = [];
        }

        if(isDefined(vehicle.t_sarah_foy_objective__indicator_[seatindex]) && vehicle.t_sarah_foy_objective__indicator_[seatindex]) {
          return;
        }

        vehicle.t_sarah_foy_objective__indicator_[seatindex] = 1;
      }

      animation = var_8730ee3e.vehicleenteranim;

      if(isDefined(animation)) {
        vehicle setanimrestart(animation, 1, 0, 1);
      }
    }
  }
}

lights_group_toggle(localclientnum, groupid, ison) {
  if(!isDefined(self.scriptbundlesettings)) {
    return;
  }

  settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);

  if(!isDefined(settings) || !isDefined(settings.lightgroups_numgroups)) {
    return;
  }

  self endon(#"death");

  if(isDefined(self.lightfxgroups) && isDefined(self.lightfxgroups[groupid])) {
    foreach(fx_handle in self.lightfxgroups[groupid]) {
      if(isDefined(fx_handle)) {
        stopfx(localclientnum, fx_handle);
      }
    }
  }

  if(!ison) {
    return;
  }

  util::waittill_dobj(localclientnum);

  if(!isDefined(self.lightfxgroups)) {
    self.lightfxgroups = [];
  }

  if(!isDefined(self.lightfxgroups[groupid])) {
    self.lightfxgroups[groupid] = [];
  }

  fxlist = [];
  taglist = [];

  switch (groupid) {
    case 0:
      function_670a62e7(settings.lightgroups_1_slots, fxlist, taglist);
      break;
    case 1:
      function_670a62e7(settings.lightgroups_2_slots, fxlist, taglist);
      break;
    case 2:
      function_670a62e7(settings.lightgroups_3_slots, fxlist, taglist);
      break;
    case 3:
      function_670a62e7(settings.lightgroups_4_slots, fxlist, taglist);
      break;
  }

  for(i = 0; i < fxlist.size; i++) {
    fx_handle = util::playFXOnTag(localclientnum, fxlist[i], self, taglist[i]);

    if(!isDefined(self.lightfxgroups[groupid])) {
      self.lightfxgroups[groupid] = [];
    } else if(!isarray(self.lightfxgroups[groupid])) {
      self.lightfxgroups[groupid] = array(self.lightfxgroups[groupid]);
    }

    self.lightfxgroups[groupid][self.lightfxgroups[groupid].size] = fx_handle;
  }
}

field_toggle_lights_group_handler1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self lights_group_toggle(localclientnum, 0, newval);
}

field_toggle_lights_group_handler2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self lights_group_toggle(localclientnum, 1, newval);
}

field_toggle_lights_group_handler3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self lights_group_toggle(localclientnum, 2, newval);
}

field_toggle_lights_group_handler4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self lights_group_toggle(localclientnum, 3, newval);
}

function_7baff7f6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self function_e1a2a256(1);
    return;
  }

  self function_e1a2a256(0);
}

delete_alert_lights(localclientnum) {
  if(isDefined(self.alert_light_fx_handles)) {
    for(i = 0; i < self.alert_light_fx_handles.size; i++) {
      if(isDefined(self.alert_light_fx_handles[i])) {
        stopfx(localclientnum, self.alert_light_fx_handles[i]);
      }
    }
  }

  self.alert_light_fx_handles = undefined;
}

lights_off(localclientnum) {
  if(isDefined(self.light_fx_handles)) {
    for(i = 0; i < self.light_fx_handles.size; i++) {
      if(isDefined(self.light_fx_handles[i])) {
        stopfx(localclientnum, self.light_fx_handles[i]);
      }
    }
  }

  self.light_fx_handles = undefined;
  delete_alert_lights(localclientnum);
}

lights_flicker(localclientnum, duration = 8, var_5db078ba = 1) {
  self notify("15457a87e1f08c8e");
  self endon("15457a87e1f08c8e");
  self endon(#"cancel_flicker");
  self endon(#"death");

  if(!isDefined(self.scriptbundlesettings)) {
    return;
  }

  state = 1;
  durationleft = gettime() + int(duration * 1000);
  settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);

  if(!isDefined(settings) || !isDefined(settings.lightgroups_numgroups)) {
    while(durationleft > gettime()) {
      if(randomint(4) == 0) {
        state = !state;

        if(state) {
          self lights_on(localclientnum);
        } else {
          self lights_off(localclientnum);
        }
      }

      waitframe(1);
    }
  } else {
    while(durationleft > gettime()) {
      state = !state;
      self lights_group_toggle(localclientnum, randomint(settings.lightgroups_numgroups), state);
      waitframe(1);
    }

    if(var_5db078ba) {
      for(i = 0; i < settings.lightgroups_numgroups; i++) {
        self lights_group_toggle(localclientnum, i, 0);
      }
    }
  }

  if(var_5db078ba) {
    self lights_off(localclientnum);

    if(isDefined(settings) && isDefined(settings.lightgroups_numgroups)) {
      for(i = 0; i < settings.lightgroups_numgroups; i++) {
        self lights_group_toggle(localclientnum, i, 0);
      }
    }

    return;
  }

  if(!state) {
    self lights_on(localclientnum);

    if(isDefined(settings) && isDefined(settings.lightgroups_numgroups)) {
      for(i = 0; i < settings.lightgroups_numgroups; i++) {
        self lights_group_toggle(localclientnum, i, 1);
      }
    }
  }
}

field_toggle_emp(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread toggle_fx_bundle(localclientnum, "emp_base", newval == 1);
}

field_toggle_burn(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread toggle_fx_bundle(localclientnum, "burn_base", newval == 1);
}

flicker_lights(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 0) {
    self notify(#"cancel_flicker");
    self lights_off(localclientnum);
    return;
  }

  if(newval == 1) {
    self thread lights_flicker(localclientnum);
    return;
  }

  if(newval == 2) {
    self thread lights_flicker(localclientnum, 20);
    return;
  }

  if(newval == 3) {
    self notify(#"cancel_flicker");
  }
}

function_1ea3bdef(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::waittill_dobj(localclientnum);

  if(isDefined(self)) {
    function_c45d231e(localclientnum, self, 1);
    self thread function_e5f88559(localclientnum, "emp_base");
    self thread function_e5f88559(localclientnum, "burn_base");
    self thread function_e5f88559(localclientnum, "smolder");
    self thread function_e5f88559(localclientnum, "death");
    self thread function_e5f88559(localclientnum, "empdeath");

    if(newval) {
      self lights_off(localclientnum);
    }

    self thread stop_exhaust(localclientnum);
  }
}

function_e5f88559(localclientnum, name) {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.fx_handles)) {
    self.fx_handles = [];
  }

  if(isDefined(self.fx_handles[name])) {
    handle = self.fx_handles[name];

    if(isDefined(handle)) {
      if(isarray(handle)) {
        foreach(handleelement in handle) {
          stopfx(localclientnum, handleelement);
        }

        return;
      }

      stopfx(localclientnum, handle);
    }
  }
}

toggle_fx_bundle(localclientnum, name, turnon) {
  if(!isDefined(self.settings) && isDefined(self.scriptbundlesettings)) {
    self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
  }

  if(!isDefined(self.settings)) {
    return;
  }

  self endon(#"death");
  self notify("end_toggle_field_fx_" + name);
  self endon("end_toggle_field_fx_" + name);
  util::waittill_dobj(localclientnum);
  self function_e5f88559(localclientnum, name);

  if(turnon) {
    for(i = 1;; i++) {
      fx = self.settings.(name + "_fx_" + i);

      if(!isDefined(fx)) {
        return;
      }

      tag = self.settings.(name + "_tag_" + i);
      delay = self.settings.(name + "_delay_" + i);
      self thread delayed_fx_thread(localclientnum, name, fx, tag, delay);
    }
  }
}

delayed_fx_thread(localclientnum, name, fx, tag, delay) {
  self endon(#"death");
  self endon("end_toggle_field_fx_" + name);

  if(!isDefined(tag)) {
    return;
  }

  if(isDefined(delay) && delay > 0) {
    wait delay;
  }

  fx_handle = util::playFXOnTag(localclientnum, fx, self, tag);

  if(!isDefined(self.fx_handles[name])) {
    self.fx_handles[name] = [];
  } else if(!isarray(self.fx_handles[name])) {
    self.fx_handles[name] = array(self.fx_handles[name]);
  }

  self.fx_handles[name][self.fx_handles[name].size] = fx_handle;
}

field_toggle_sounds(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(self.vehicleclass === "helicopter") {
    if(newval) {
      self notify(#"stop_heli_sounds");
      self.should_not_play_sounds = 1;
    } else {
      self notify(#"play_heli_sounds");
      self.should_not_play_sounds = 0;
    }
  }

  if(newval) {
    self disablevehiclesounds();
    self function_dcec5385();
    return;
  }

  self enablevehiclesounds();
}

private function_dcec5385() {
  self function_f753359a();
}

field_toggle_dnidamagefx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self thread postfx::playpostfxbundle(#"pstfx_dni_vehicle_dmg");
  }
}

toggle_flir_postfxbundle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  player = self;

  if(newval == oldval) {
    return;
  }

  if(!isDefined(player) || !player function_21c0fa55()) {
    return;
  }

  if(newval == 0) {
    if(oldval == 1) {
      player thread postfx::stoppostfxbundle("pstfx_infrared");
    } else if(oldval == 2) {
      player thread postfx::stoppostfxbundle("pstfx_flir");
    }

    update_ui_fullscreen_filter_model(localclientnum, 0);
    return;
  }

  if(newval == 1) {
    if(player shouldchangescreenpostfx(localclientnum)) {
      player thread postfx::playpostfxbundle(#"pstfx_infrared");
      update_ui_fullscreen_filter_model(localclientnum, 2);
    }

    return;
  }

  if(newval == 2) {
    should_change = 1;

    if(player shouldchangescreenpostfx(localclientnum)) {
      player thread postfx::playpostfxbundle(#"pstfx_flir");
      update_ui_fullscreen_filter_model(localclientnum, 1);
    }
  }
}

shouldchangescreenpostfx(localclientnum) {
  player = self;
  assert(isDefined(player));

  if(function_1cbf351b(localclientnum)) {
    killcamentity = function_93e0f729(localclientnum);

    if(isDefined(killcamentity) && killcamentity != player) {
      return false;
    }
  }

  return true;
}

set_static_postfxbundle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  player = self;

  if(newval == oldval) {
    return;
  }

  if(!isDefined(player) || !player function_21c0fa55()) {
    return;
  }

  if(newval == 0) {
    if(player postfx::function_556665f2(#"pstfx_static")) {
      player thread postfx::stoppostfxbundle(#"pstfx_static");
    }

    if(player postfx::function_556665f2(#"hash_15d46f4ad6539103")) {
      player thread postfx::stoppostfxbundle(#"hash_15d46f4ad6539103");
    }

    return;
  }

  if(newval == 1) {
    var_8efa62c3 = 1;
    vehicle = getplayervehicle(player);

    if(isDefined(vehicle)) {
      if(vehicle.vehicletype == #"veh_hawk_player_mp" || vehicle.vehicletype == #"veh_hawk_player_far_range_mp" || vehicle.vehicletype == #"veh_hawk_player_wz" || vehicle.vehicletype == #"veh_hawk_player_far_range_wz") {
        if(player postfx::function_556665f2(#"hash_15d46f4ad6539103") == 0) {
          player thread postfx::playpostfxbundle(#"hash_15d46f4ad6539103");
        }

        var_8efa62c3 = 0;
      }
    }

    if(var_8efa62c3 && player postfx::function_556665f2(#"pstfx_static") == 0) {
      player thread postfx::playpostfxbundle(#"pstfx_static");
    }
  }
}

update_ui_fullscreen_filter_model(localclientnum, vision_set_value) {
  controllermodel = getuimodelforcontroller(localclientnum);
  model = getuimodel(controllermodel, "vehicle.fullscreenFilter");

  if(isDefined(model)) {
    setuimodelvalue(model, vision_set_value);
  }
}

field_toggle_treadfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(self.vehicleclass === "helicopter" || self.vehicleclass === "plane") {
    println("<dev string:xf0>");

    if(newval) {
      if(isDefined(self.csf_no_tread)) {
        self.csf_no_tread = 0;
      }

      self kill_treads_forever();
      self thread aircraft_dustkick();
    } else if(isDefined(bnewent) && bnewent) {
      self.csf_no_tread = 1;
    } else {
      self kill_treads_forever();
    }

    return;
  }

  if(newval) {
    println("<dev string:x112>");

    if(isDefined(bnewent) && bnewent) {
      println("<dev string:x13b>" + self getentitynumber());
      self.csf_no_tread = 1;
    } else {
      println("<dev string:x15b>" + self getentitynumber());
      self kill_treads_forever();
    }

    return;
  }

  println("<dev string:x179>");

  if(isDefined(self.csf_no_tread)) {
    self.csf_no_tread = 0;
  }

  self kill_treads_forever();
}

field_use_engine_damage_sounds(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(self.vehicleclass === "helicopter") {
    switch (newval) {
      case 0:
        self.engine_damage_low = 0;
        self.engine_damage_high = 0;
        break;
      case 1:
        self.engine_damage_low = 1;
        self.engine_damage_high = 0;
        break;
      case 1:
        self.engine_damage_low = 0;
        self.engine_damage_high = 1;
        break;
    }
  }
}

private function_a29f490a() {
  self.var_76660b3a = self playLoopSound(self.hornsound);
}

private function_f753359a() {
  if(isDefined(self.var_76660b3a)) {
    self stoploopsound(self.var_76660b3a);
    self.var_76660b3a = undefined;
  }
}

private function_27b19317(localclientnum) {
  if(!self function_4add50a7()) {
    return false;
  }

  if(function_65b9eb0f(localclientnum)) {
    return false;
  }

  if(self.vehicleclass === "helicopter") {
    return false;
  }

  if(isDefined(self.var_304cf9da) && self.var_304cf9da) {
    return false;
  }

  return true;
}

private function_2d24296(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(self function_27b19317(localclientnum)) {
    return;
  }

  if(!isDefined(self.hornsound)) {
    return;
  }

  if(newval) {
    if(self.vehicleclass === "helicopter" && !(isDefined(self.var_304cf9da) && self.var_304cf9da)) {
      self playSound(localclientnum, self.hornsound);
    } else {
      self function_a29f490a();
    }

    return;
  }

  self function_f753359a();
}

function_7d1d0e65(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.settings) && isDefined(self.scriptbundlesettings)) {
    self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
  }

  if(!isDefined(self.settings) || !isDefined(self.settings.malfunction_effects)) {
    return;
  }

  if(!isDefined(self.fx_handles)) {
    self.fx_handles = [];
  }

  if(!isDefined(self.fx_handles[#"malfunction"])) {
    self.fx_handles[#"malfunction"] = [];
  }

  foreach(handle in self.fx_handles[#"malfunction"]) {
    stopfx(localclientnum, handle);
  }

  self.fx_handles[#"malfunction"] = [];

  if(newval) {
    foreach(var_b5ddf091 in self.settings.malfunction_effects) {
      tag = var_b5ddf091.var_454a4e08;
      effect = var_b5ddf091.transition;

      if(isDefined(var_b5ddf091.transition) && isDefined(var_b5ddf091.var_454a4e08)) {
        util::playFXOnTag(localclientnum, var_b5ddf091.transition, self, var_b5ddf091.var_454a4e08);
      }

      switch (newval) {
        case 0:
          break;
        case 1:
          if(isDefined(var_b5ddf091.warning) && isDefined(var_b5ddf091.tag_warning)) {
            handle = util::playFXOnTag(localclientnum, var_b5ddf091.warning, self, var_b5ddf091.tag_warning);

            if(!isDefined(self.fx_handles[#"malfunction"])) {
              self.fx_handles[#"malfunction"] = [];
            } else if(!isarray(self.fx_handles[#"malfunction"])) {
              self.fx_handles[#"malfunction"] = array(self.fx_handles[#"malfunction"]);
            }

            self.fx_handles[#"malfunction"][self.fx_handles[#"malfunction"].size] = handle;
          }

          break;
        case 2:
          if(isDefined(var_b5ddf091.active) && isDefined(var_b5ddf091.var_2f451e59)) {
            handle = util::playFXOnTag(localclientnum, var_b5ddf091.active, self, var_b5ddf091.var_2f451e59);

            if(!isDefined(self.fx_handles[#"malfunction"])) {
              self.fx_handles[#"malfunction"] = [];
            } else if(!isarray(self.fx_handles[#"malfunction"])) {
              self.fx_handles[#"malfunction"] = array(self.fx_handles[#"malfunction"]);
            }

            self.fx_handles[#"malfunction"][self.fx_handles[#"malfunction"].size] = handle;
          }

          break;
        case 3:
          if(isDefined(var_b5ddf091.fatal) && isDefined(var_b5ddf091.var_ceeccc7a)) {
            handle = util::playFXOnTag(localclientnum, var_b5ddf091.fatal, self, var_b5ddf091.var_ceeccc7a);

            if(!isDefined(self.fx_handles[#"malfunction"])) {
              self.fx_handles[#"malfunction"] = [];
            } else if(!isarray(self.fx_handles[#"malfunction"])) {
              self.fx_handles[#"malfunction"] = array(self.fx_handles[#"malfunction"]);
            }

            self.fx_handles[#"malfunction"][self.fx_handles[#"malfunction"].size] = handle;
          }

          break;
      }
    }
  }

  if(newval != oldval) {
    var_ca456b21 = "uin_chopper_alarm_warning";
    var_b10574a9 = "uin_chopper_alarm_critical";

    switch (oldval) {
      case 0:
      case 1:
        if(isDefined(self.var_30141f5c)) {
          self stoploopsound(self.var_30141f5c);
          self.var_30141f5c = undefined;
        }

        break;
      case 2:
      case 3:
        if(newval != 2 && newval != 3 && isDefined(self.var_30141f5c)) {
          self stoploopsound(self.var_30141f5c);
          self.var_30141f5c = undefined;
        }

        break;
    }

    switch (newval) {
      case 0:
        break;
      case 1:
        self.var_30141f5c = self playLoopSound(var_ca456b21);
        break;
      case 2:
      case 3:
        if(oldval != 2 && oldval != 3) {
          self.var_30141f5c = self playLoopSound(var_b10574a9);
        }

        break;
    }
  }
}

field_do_deathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(newval) {
    self stop_stun_fx(localclientnum);
  }

  if(newval == 2) {
    self field_do_empdeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
  } else {
    self field_do_standarddeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
  }

  if(isDefined(self.var_8a037014)) {
    self thread function_18758bfa(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
  }
}

function_18758bfa(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval && !binitialsnap) {
    self endon(#"death");

    if(isDefined(self.var_6e8da11c) && self.var_6e8da11c > 0) {
      wait self.var_6e8da11c;
    }

    if(!isDefined(self.fx_handles)) {
      self.fx_handles = [];
    }

    if(!isDefined(self.fx_handles[#"smolder"])) {
      self.fx_handles[#"smolder"] = [];
    }

    if(isDefined(self.var_8a037014) && self.var_8a037014 != "") {
      if(isDefined(self.var_20eae439) && self.var_20eae439 != "") {
        handle = util::playFXOnTag(localclientnum, self.var_8a037014, self, self.var_20eae439);
      } else {
        handle = playFX(localclientnum, self.var_8a037014, self.origin);
      }

      setfxignorepause(localclientnum, handle, 1);

      if(!isDefined(self.fx_handles[#"smolder"])) {
        self.fx_handles[#"smolder"] = [];
      } else if(!isarray(self.fx_handles[#"smolder"])) {
        self.fx_handles[#"smolder"] = array(self.fx_handles[#"smolder"]);
      }

      self.fx_handles[#"smolder"][self.fx_handles[#"smolder"].size] = handle;
    }

    if(isDefined(self.var_68f20b20) && self.var_68f20b20 != "") {
      self playSound(localclientnum, self.var_68f20b20);
    }

    if(isDefined(handle) && isDefined(self.var_b321fcb3) && self.var_b321fcb3 > 0) {
      wait self.var_b321fcb3;

      if(isfxplaying(localclientnum, handle)) {
        stopfx(localclientnum, handle);
        arrayremovevalue(self.fx_handles[#"smolder"], handle, 0);
      }
    }

    return;
  }

  if(isDefined(self.fx_handles) && isDefined(self.fx_handles[#"smolder"])) {
    foreach(handle in self.fx_handles[#"smolder"]) {
      stopfx(localclientnum, handle);
    }

    self.fx_handles[#"smolder"] = [];
  }
}

field_do_standarddeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval && !binitialsnap) {
    self endon(#"death");
    util::waittill_dobj(localclientnum);

    if(!isDefined(self.fx_handles)) {
      self.fx_handles = [];
    }

    if(!isDefined(self.fx_handles[#"death"])) {
      self.fx_handles[#"death"] = [];
    }

    if(isDefined(self.deathfxname)) {
      if(isDefined(self.deathfxtag) && self.deathfxtag != "") {
        handle = util::playFXOnTag(localclientnum, self.deathfxname, self, self.deathfxtag);
      } else {
        handle = playFX(localclientnum, self.deathfxname, self.origin);
      }

      setfxignorepause(localclientnum, handle, 1);

      if(!isDefined(self.fx_handles[#"death"])) {
        self.fx_handles[#"death"] = [];
      } else if(!isarray(self.fx_handles[#"death"])) {
        self.fx_handles[#"death"] = array(self.fx_handles[#"death"]);
      }

      self.fx_handles[#"death"][self.fx_handles[#"death"].size] = handle;
    }

    self playSound(localclientnum, self.deathfxsound);

    if(isDefined(self.deathquakescale) && self.deathquakescale > 0) {
      earthquake(localclientnum, self.deathquakescale, self.deathquakeduration, self.origin, self.deathquakeradius);
    }

    if(isDefined(self.var_d0569e25) && self.var_d0569e25 != "") {
      self playrumbleonentity(localclientnum, self.var_d0569e25);
    }
  }
}

field_do_empdeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.settings) && isDefined(self.scriptbundlesettings)) {
    self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
  }

  if(!isDefined(self.settings)) {
    self field_do_standarddeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
    return;
  }

  if(newval && !binitialsnap) {
    self endon(#"death");
    util::waittill_dobj(localclientnum);

    if(!isDefined(self.fx_handles)) {
      self.fx_handles = [];
    }

    if(!isDefined(self.fx_handles[#"empdeath"])) {
      self.fx_handles[#"empdeath"] = [];
    }

    s = self.settings;

    if(isDefined(s.emp_death_fx_1)) {
      if(isDefined(s.emp_death_tag_1) && s.emp_death_tag_1 != "") {
        handle = util::playFXOnTag(localclientnum, s.emp_death_fx_1, self, s.emp_death_tag_1);
      } else {
        handle = playFX(localclientnum, s.emp_death_tag_1, self.origin);
      }

      setfxignorepause(localclientnum, handle, 1);

      if(!isDefined(self.fx_handles[#"empdeath"])) {
        self.fx_handles[#"empdeath"] = [];
      } else if(!isarray(self.fx_handles[#"empdeath"])) {
        self.fx_handles[#"empdeath"] = array(self.fx_handles[#"empdeath"]);
      }

      self.fx_handles[#"empdeath"][self.fx_handles[#"empdeath"].size] = handle;
    }

    self playSound(localclientnum, s.emp_death_sound_1);

    if(isDefined(self.deathquakescale) && self.deathquakescale > 0) {
      earthquake(localclientnum, self.deathquakescale * 0.25, self.deathquakeduration * 2, self.origin, self.deathquakeradius);
    }
  }
}

field_update_alert_level(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  delete_alert_lights(localclientnum);

  if(!isDefined(self.scriptbundlesettings)) {
    return;
  }

  if(!isDefined(self.alert_light_fx_handles)) {
    self.alert_light_fx_handles = [];
  }

  settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);

  switch (newval) {
    case 0:
      break;
    case 1:
      if(isDefined(settings.unawarelightfx1)) {
        self.alert_light_fx_handles[0] = util::playFXOnTag(localclientnum, settings.unawarelightfx1, self, settings.lighttag1);
      }

      break;
    case 2:
      if(isDefined(settings.alertlightfx1)) {
        self.alert_light_fx_handles[0] = util::playFXOnTag(localclientnum, settings.alertlightfx1, self, settings.lighttag1);
      }

      break;
    case 3:
      if(isDefined(settings.combatlightfx1)) {
        self.alert_light_fx_handles[0] = util::playFXOnTag(localclientnum, settings.combatlightfx1, self, settings.lighttag1);
      }

      break;
  }
}

field_toggle_exhaustfx_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(isDefined(bnewent) && bnewent) {
      self.csf_no_exhaust = 1;
    } else {
      self stop_exhaust(localclientnum);
    }

    return;
  }

  if(isDefined(self.csf_no_exhaust)) {
    self.csf_no_exhaust = 0;
  }

  self stop_exhaust(localclientnum);
  self play_exhaust(localclientnum);
}

field_toggle_lights_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self lights_off(localclientnum);
    return;
  }

  if(newval == 2) {
    self lights_on(localclientnum, #"allies");
    return;
  }

  if(newval == 3) {
    self lights_on(localclientnum, #"axis");
    return;
  }

  self lights_on(localclientnum);
}

field_toggle_lockon_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}

function_670a62e7(var_96ceb3eb, &fxlist, &taglist) {
  if(isDefined(var_96ceb3eb) && isarray(var_96ceb3eb)) {
    for(i = 0; i < var_96ceb3eb.size; i++) {
      addfxandtagtolists(var_96ceb3eb[i].fx, var_96ceb3eb[i].tag, fxlist, taglist, i, var_96ceb3eb.size - 1);
    }
  }
}

addfxandtagtolists(fx, tag, &fxlist, &taglist, id, maxid) {
  if(isDefined(fx) && isDefined(tag) && isint(id) && isint(maxid) && id <= maxid) {
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

function_d7a2c2f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(newval) {
    self notify(#"light_disable");
    self stop_stun_fx(localclientnum);
    self start_stun_fx(localclientnum);
    return;
  }

  self stop_stun_fx(localclientnum);
}

start_stun_fx(localclientnum) {
  stunfx = isDefined(self.global_zm_specialty_staminup_drankdie) ? self.global_zm_specialty_staminup_drankdie : #"killstreaks/fx_agr_emp_stun";
  _exp_special_web_dissolve = isDefined(self.stunfxtag) ? self.stunfxtag : "tag_origin";
  var_6dc7131c = isDefined(self.var_c254489e) ? self.var_c254489e : #"veh_talon_shutdown";
  self.stun_fx = util::playFXOnTag(localclientnum, stunfx, self, _exp_special_web_dissolve);
  playSound(localclientnum, var_6dc7131c, self.origin);
}

stop_stun_fx(localclientnum) {
  if(isDefined(self.stun_fx)) {
    stopfx(localclientnum, self.stun_fx);
    self.stun_fx = undefined;
  }
}

field_update_damage_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.scriptbundlesettings)) {
    return;
  }

  settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);

  if(isDefined(self.damage_state_fx_handles)) {
    foreach(fx_handle in self.damage_state_fx_handles) {
      if(isDefined(fx_handle)) {
        stopfx(localclientnum, fx_handle);
      }
    }
  }

  self.damage_state_fx_handles = [];
  fxlist = [];
  taglist = [];
  sound = undefined;

  if(newval > 0) {
    var_c0e21df2 = "damagestate_lv" + newval;
    numslots = settings.(var_c0e21df2 + "_numslots");

    for(fxindex = 1; isDefined(numslots) && fxindex <= numslots; fxindex++) {
      addfxandtagtolists(settings.(var_c0e21df2 + "_fx" + fxindex), settings.(var_c0e21df2 + "_tag" + fxindex), fxlist, taglist, fxindex, numslots);
    }

    sound = settings.(var_c0e21df2 + "_sound");
  }

  for(i = 0; i < fxlist.size; i++) {
    fx_handle = util::playFXOnTag(localclientnum, fxlist[i], self, taglist[i]);

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

field_death_spawn_dynents(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.scriptbundlesettings)) {
    return;
  }

  settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);

  if(localclientnum == 0) {
    velocity = self getvelocity();
    numdynents = isDefined(settings.death_dynent_count) ? settings.death_dynent_count : 0;

    for(i = 0; i < numdynents; i++) {
      model = settings.("death_dynmodel" + i);

      if(!isDefined(model)) {
        continue;
      }

      gibpart = settings.("death_dynent_gib" + i);

      if(self.gibbed === 1 && gibpart === 1) {
        continue;
      }

      pitch = isDefined(settings.("death_dynent_force_pitch" + i)) ? settings.("death_dynent_force_pitch" + i) : 0;
      yaw = isDefined(settings.("death_dynent_force_yaw" + i)) ? settings.("death_dynent_force_yaw" + i) : 0;
      angles = (randomfloatrange(pitch - 15, pitch + 15), randomfloatrange(yaw - 20, yaw + 20), randomfloatrange(-20, 20));
      direction = anglesToForward(self.angles + angles);
      minscale = isDefined(settings.("death_dynent_force_minscale" + i)) ? settings.("death_dynent_force_minscale" + i) : 0;
      maxscale = isDefined(settings.("death_dynent_force_maxscale" + i)) ? settings.("death_dynent_force_maxscale" + i) : 0;
      force = direction * randomfloatrange(minscale, maxscale);
      offset = (isDefined(settings.("death_dynent_offsetX" + i)) ? settings.("death_dynent_offsetX" + i) : 0, isDefined(settings.("death_dynent_offsetY" + i)) ? settings.("death_dynent_offsetY" + i) : 0, isDefined(settings.("death_dynent_offsetZ" + i)) ? settings.("death_dynent_offsetZ" + i) : 0);

      switch (newval) {
        case 0:
          break;
        case 1:
          fx = settings.("death_dynent_fx" + i);
          break;
        case 2:
          fx = settings.("death_dynent_elec_fx" + i);
          break;
        case 3:
          fx = settings.("death_dynent_fire_fx" + i);
          break;
      }

      offset = rotatepoint(offset, self.angles);

      if(newval > 1 && isDefined(fx)) {
        dynent = createdynentandlaunch(localclientnum, model, self.origin + offset, self.angles, (0, 0, 0), velocity * 0.8, fx);
      } else if(newval == 1 && isDefined(fx)) {
        dynent = createdynentandlaunch(localclientnum, model, self.origin + offset, self.angles, (0, 0, 0), velocity * 0.8, fx);
      } else {
        dynent = createdynentandlaunch(localclientnum, model, self.origin + offset, self.angles, (0, 0, 0), velocity * 0.8);
      }

      if(isDefined(dynent)) {
        hitoffset = (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-5, 5));
        launchdynent(dynent, force, hitoffset);
      }
    }
  }
}

field_gib_spawn_dynents(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.scriptbundlesettings)) {
    return;
  }

  settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);

  if(localclientnum == 0) {
    velocity = self getvelocity();
    numdynents = 2;

    for(i = 0; i < numdynents; i++) {
      model = settings.("servo_gib_model" + i);

      if(!isDefined(model)) {
        return;
      }

      self.gibbed = 1;
      origin = self.origin;
      angles = self.angles;
      hidetag = settings.("servo_gib_tag" + i);

      if(isDefined(hidetag)) {
        origin = self gettagorigin(hidetag);
        angles = self gettagangles(hidetag);
      }

      pitch = isDefined(settings.("servo_gib_force_pitch" + i)) ? settings.("servo_gib_force_pitch" + i) : 0;
      yaw = isDefined(settings.("servo_gib_force_yaw" + i)) ? settings.("servo_gib_force_yaw" + i) : 0;
      relative_angles = (randomfloatrange(pitch - 5, pitch + 5), randomfloatrange(yaw - 5, yaw + 5), randomfloatrange(-5, 5));
      direction = anglesToForward(angles + relative_angles);
      minscale = isDefined(settings.("servo_gib_force_minscale" + i)) ? settings.("servo_gib_force_minscale" + i) : 0;
      maxscale = isDefined(settings.("servo_gib_force_maxscale" + i)) ? settings.("servo_gib_force_maxscale" + i) : 0;
      force = direction * randomfloatrange(minscale, maxscale);
      offset = (isDefined(settings.("servo_gib_offsetX" + i)) ? settings.("servo_gib_offsetX" + i) : 0, isDefined(settings.("servo_gib_offsetY" + i)) ? settings.("servo_gib_offsetY" + i) : 0, isDefined(settings.("servo_gib_offsetZ" + i)) ? settings.("servo_gib_offsetZ" + i) : 0);
      fx = settings.("servo_gib_fx" + i);
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

autoexec build_damage_filter_list() {
  if(!isDefined(level.vehicle_damage_filters)) {
    level.vehicle_damage_filters = [];
  }

  level.vehicle_damage_filters[0] = "generic_filter_vehicle_damage";
  level.vehicle_damage_filters[1] = "generic_filter_sam_damage";
  level.vehicle_damage_filters[2] = "generic_filter_f35_damage";
  level.vehicle_damage_filters[3] = "generic_filter_vehicle_damage_sonar";
  level.vehicle_damage_filters[4] = "generic_filter_rts_vehicle_damage";
}

init_damage_filter(materialid) {
  level.localplayers[0].damage_filter_intensity = 0;
  materialname = level.vehicle_damage_filters[materialid];
  filter::init_filter_vehicle_damage(level.localplayers[0], materialname);
  filter::enable_filter_vehicle_damage(level.localplayers[0], 3, materialname);
  filter::set_filter_vehicle_damage_amount(level.localplayers[0], 3, 0);
  filter::set_filter_vehicle_sun_position(level.localplayers[0], 3, 0, 0);
}

damage_filter_enable(localclientnum, materialid) {
  filter::enable_filter_vehicle_damage(level.localplayers[0], 3, level.vehicle_damage_filters[materialid]);
  level.localplayers[0].damage_filter_intensity = 0;
  filter::set_filter_vehicle_damage_amount(level.localplayers[0], 3, level.localplayers[0].damage_filter_intensity);
}

damage_filter_disable(localclientnum) {
  level notify(#"damage_filter_off");
  level.localplayers[0].damage_filter_intensity = 0;
  filter::set_filter_vehicle_damage_amount(level.localplayers[0], 3, level.localplayers[0].damage_filter_intensity);
  filter::disable_filter_vehicle_damage(level.localplayers[0], 3);
}

damage_filter_off(localclientnum) {
  level endon(#"damage_filter");
  level endon(#"damage_filter_off");
  level endon(#"damage_filter_heavy");

  if(!isDefined(level.localplayers[0].damage_filter_intensity)) {
    return;
  }

  while(level.localplayers[0].damage_filter_intensity > 0) {
    level.localplayers[0].damage_filter_intensity -= 0.0505061;

    if(level.localplayers[0].damage_filter_intensity < 0) {
      level.localplayers[0].damage_filter_intensity = 0;
    }

    filter::set_filter_vehicle_damage_amount(level.localplayers[0], 3, level.localplayers[0].damage_filter_intensity);
    wait 0.016667;
  }
}

damage_filter_light(localclientnum) {
  level endon(#"damage_filter_off");
  level endon(#"damage_filter_heavy");
  level notify(#"damage_filter");

  while(level.localplayers[0].damage_filter_intensity < 0.5) {
    level.localplayers[0].damage_filter_intensity += 0.083335;

    if(level.localplayers[0].damage_filter_intensity > 0.5) {
      level.localplayers[0].damage_filter_intensity = 0.5;
    }

    filter::set_filter_vehicle_damage_amount(level.localplayers[0], 3, level.localplayers[0].damage_filter_intensity);
    wait 0.016667;
  }
}

damage_filter_heavy(localclientnum) {
  level endon(#"damage_filter_off");
  level notify(#"damage_filter_heavy");

  while(level.localplayers[0].damage_filter_intensity < 1) {
    level.localplayers[0].damage_filter_intensity += 0.083335;

    if(level.localplayers[0].damage_filter_intensity > 1) {
      level.localplayers[0].damage_filter_intensity = 1;
    }

    filter::set_filter_vehicle_damage_amount(level.localplayers[0], 3, level.localplayers[0].damage_filter_intensity);
    wait 0.016667;
  }
}

function_9facca21(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self function_3f24c5a(newval);
  }
}

play_flare_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.var_26fb93b4 = util::playFXOnTag(localclientnum, #"hash_3905863dd0908e4a", self, "tag_origin");
  }

  if(newval == 0) {
    if(isDefined(self.var_26fb93b4)) {
      stopfx(localclientnum, self.var_26fb93b4);
      self.var_26fb93b4 = undefined;
    }
  }
}

play_flare_hit_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.var_b4178826 = util::playFXOnTag(localclientnum, #"hash_1e747bdc27127b91", self, "tag_origin");
  }

  if(newval == 0) {
    if(isDefined(self.var_b4178826)) {
      stopfx(localclientnum, self.var_b4178826);
      self.var_b4178826 = undefined;
    }
  }
}

set_static_amount(staticamount) {
  driverlocalclient = self getlocalclientdriver();

  if(isDefined(driverlocalclient)) {
    setfilterpassconstant(driverlocalclient, 4, 0, 1, staticamount);
  }
}