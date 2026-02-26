/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicle_shared.csc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicleriders_shared;
#namespace vehicle;

function private autoexec __init__system__() {
  system::register(#"vehicle_shared", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level._customvehiclecbfunc = &spawned_callback;
  level.var_e583fd9b = &function_2f2a656a;
  level.var_8e36d09b = &function_cc71cf1a;
  level.allvehicles = [];
  clientfield::register("vehicle", "toggle_lockon", 1, 1, "int", &field_toggle_lockon_handler, 0, 0);
  clientfield::register("vehicle", "toggle_sounds", 1, 1, "int", &field_toggle_sounds, 0, 1);
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
  clientfield::register("vehicle", "vehicle_assembly_death_hint", 1, 1, "counter", &function_dacff0e7, 0, 0);
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
  clientfield::register("vehicle", "stunned", 1, 1, "int", &callback::callback_stunned, 0, 0);
  clientfield::register("vehicle", "rocket_damage_rumble", 1, 1, "counter", &function_f8e7ae58, 0, 0);

  if(!is_true(level.var_7b05c4b5)) {
    clientfield::register_clientuimodel("vehicle.ammoCount", #"vehicle_info", #"ammocount", 1, 10, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("vehicle.ammoReloading", #"vehicle_info", #"ammoreloading", 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("vehicle.ammoLow", #"vehicle_info", #"ammolow", 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("vehicle.rocketAmmo", #"vehicle_info", #"rocketammo", 1, 2, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("vehicle.ammo2Count", #"vehicle_info", #"ammo2count", 1, 10, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("vehicle.ammo2Reloading", #"vehicle_info", #"ammo2reloading", 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("vehicle.ammo2Low", #"vehicle_info", #"ammo2low", 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("vehicle.collisionWarning", #"vehicle_info", #"collisionwarning", 1, 2, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("vehicle.enemyInReticle", #"vehicle_info", #"enemyinreticle", 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("vehicle.missileRepulsed", #"vehicle_info", #"missilerepulsed", 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("vehicle.incomingMissile", #"vehicle_info", #"incomingmissile", 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("vehicle.missileLock", #"vehicle_info", #"missilelock", 1, 2, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("vehicle.malfunction", #"vehicle_info", #"malfunction", 1, 2, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("vehicle.showHoldToExitPrompt", #"vehicle_info", #"showholdtoexitprompt", 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("vehicle.holdToExitProgress", #"vehicle_info", #"holdtoexitprogress", 1, 5, "float", undefined, 0, 0);
    clientfield::register_clientuimodel("vehicle.vehicleAttackMode", #"vehicle_info", #"vehicleattackmode", 1, 3, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("vehicle.invalidLanding", #"vehicle_info", #"invalidlanding", 1, 1, "int", undefined, 0, 0);

    for(i = 0; i < 3; i++) {
      clientfield::register_clientuimodel("vehicle.bindingCooldown" + i + ".cooldown", #"vehicle_info", [#"bindingcooldown" + (isDefined(i) ? "" + i : ""), #"cooldown"], 1, 5, "float", undefined, 0, 0);
    }
  }

  clientfield::register("toplayer", "toggle_dnidamagefx", 1, 1, "int", &field_toggle_dnidamagefx, 0, 0);
  clientfield::register("toplayer", "toggle_flir_postfx", 1, 2, "int", &toggle_flir_postfxbundle, 0, 0);
  clientfield::register("toplayer", "static_postfx", 1, 1, "int", &set_static_postfxbundle, 0, 1);
  clientfield::register("vehicle", "vehUseMaterialPhysics", 1, 1, "int", &function_9facca21, 0, 0);
  clientfield::register("scriptmover", "play_flare_fx", 1, 1, "int", &play_flare_fx, 0, 0);
  clientfield::register("scriptmover", "play_flare_hit_fx", 1, 1, "int", &play_flare_hit_fx, 0, 0);
}

function add_vehicletype_callback(vehicletype, callback, data = undefined) {
  if(!isDefined(level.vehicletypecallbackarray)) {
    level.vehicletypecallbackarray = [];
  }

  if(!isDefined(level.var_1ac8f820)) {
    level.var_1ac8f820 = [];
  }

  level.vehicletypecallbackarray[vehicletype] = callback;
  level.var_1ac8f820[vehicletype] = data;
}

function private function_dd27aacd(localclientnum, vehicletype) {
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

function spawned_callback(localclientnum) {
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

  if(!isDefined(level.var_54e78305)) {
    level.var_54e78305 = [];
  }

  if(isDefined(vehicletype) && !isDefined(level.var_54e78305[vehicletype])) {
    function_59020fad(vehicletype);
    level.var_54e78305[vehicletype] = 1;
  }

  var_d790a4e9 = 0;

  if(!isDefined(self.settings) && isDefined(self.scriptbundlesettings)) {
    self.settings = getscriptbundle(self.scriptbundlesettings);
    var_a6de9f17 = self.settings.var_a6de9f17;
  }

  if(self usessubtargets() || isDefined(var_a6de9f17)) {
    self thread watch_vehicle_damage(localclientnum, var_a6de9f17);
  }

  if(!is_true(self.settings.var_4221c285) && isDefined(self.settings.var_681129b2)) {
    self playrumblelooponentity(localclientnum, self.settings.var_681129b2);
  }

  if(!isDefined(level.allvehicles[localclientnum])) {
    level.allvehicles[localclientnum] = [];
  }

  array::add(level.allvehicles[localclientnum], self, 0);
  self callback::on_shutdown(&on_shutdown);
}

function function_2f97bc52(vehicletype, callback) {
  if(!isDefined(level.var_fedb0575)) {
    level.var_fedb0575 = [];
  }

  level.var_fedb0575[vehicletype] = callback;
}

function function_2f2a656a(localclientnum, vehicle) {
  if(isDefined(vehicle)) {
    vehicletype = vehicle.vehicletype;

    if(isDefined(vehicletype) && isDefined(level.var_fedb0575) && isDefined(level.var_fedb0575[vehicletype])) {
      self thread[[level.var_fedb0575[vehicletype]]](localclientnum, vehicle);
    }
  }
}

function function_cd2ede5(vehicletype, callback) {
  if(!isDefined(level.var_9b02f595)) {
    level.var_9b02f595 = [];
  }

  level.var_9b02f595[vehicletype] = callback;
}

function function_cc71cf1a(localclientnum, vehicle) {
  if(isDefined(vehicle)) {
    vehicletype = vehicle.vehicletype;

    if(isDefined(vehicletype) && isDefined(level.var_9b02f595) && isDefined(level.var_9b02f595[vehicletype])) {
      self thread[[level.var_9b02f595[vehicletype]]](localclientnum, vehicle);
    }
  }
}

function on_shutdown(localclientnum) {
  self function_dcec5385();

  if(isarray(level.allvehicles[localclientnum])) {
    arrayremovevalue(level.allvehicles[localclientnum], self);
  }
}

function watch_vehicle_damage(localclientnum, rumble) {
  self endon(#"death");
  self.notifyonbulletimpact = 1;

  while(isDefined(self)) {
    waitresult = self waittill(#"damage");
    mod = waitresult.mod;
    subtarget = waitresult.subtarget;
    attacker = waitresult.attacker;

    if(attacker function_21c0fa55() && isDefined(subtarget) && subtarget > 0) {
      self thread function_a87e7c22(subtarget);
    }

    if(isDefined(rumble) && self function_979020fe() && (mod == "MOD_RIFLE_BULLET" || mod == "MOD_PISTOL_BULLET")) {
      occupant = function_5c10bd79(localclientnum);
      occupant playrumbleonentity(localclientnum, rumble);
    }
  }
}

function function_f8e7ae58(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!self function_979020fe()) {
    return;
  }

  if(!isDefined(self.settings) && isDefined(self.scriptbundlesettings)) {
    self.settings = getscriptbundle(self.scriptbundlesettings);
  }

  occupant = function_5c10bd79(bwastimejump);
  occupant playrumbleonentity(bwastimejump, self.settings.var_2cc03de3);
}

function function_a87e7c22(subtarget) {
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

function kill_treads_forever() {
  self notify(#"kill_treads_forever");
}

function play_exhaust(localclientnum) {
  if(!isDefined(self)) {
    return;
  }

  if(is_true(self.csf_no_exhaust)) {
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

function stop_exhaust(localclientnum) {
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

function boost_think(localclientnum) {
  self notify("49bfafce10361788");
  self endon("49bfafce10361788");
  self endon(#"death");

  for(;;) {
    self waittill(#"veh_boost");
    self play_boost(localclientnum, 0);

    if(isinvehicle(localclientnum, self)) {
      self play_boost(localclientnum, 1);
    }
  }
}

function play_boost(localclientnum, var_a7ba3864, duration) {
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
      assert(isDefined(var_c1da0b13), self.vehicletype + "<dev string:x97>");
      self endon(#"death");
      self util::waittill_dobj(localclientnum);
      var_1ca9b241 = util::playFXOnTag(localclientnum, var_121afd6f, self, var_c1da0b13);

      if(isDefined(var_74ceb128)) {
        var_4dfb2154 = util::playFXOnTag(localclientnum, var_121afd6f, self, var_74ceb128);
      }

      if(var_a7ba3864) {
        self thread function_5ce3e74e(localclientnum, var_1ca9b241);
      }

      self thread kill_boost(localclientnum, var_1ca9b241, undefined, undefined, duration);

      if(isDefined(var_4dfb2154)) {
        self thread kill_boost(localclientnum, var_4dfb2154, undefined, undefined, duration);
      }
    }
  }

  if(var_a7ba3864 && isDefined(self.var_b96c7687) && isalive(self)) {
    player = function_5c10bd79(localclientnum);

    if(isPlayer(player) && isalive(player)) {
      player playrumblelooponentity(localclientnum, self.var_b96c7687);
      self thread kill_boost(localclientnum, undefined, self.var_b96c7687, player, duration);
      self thread function_5ce3e74e(localclientnum, undefined, self.var_b96c7687, player);
    }
  }
}

function kill_boost(localclientnum, var_1ca9b241, var_dc0238cc, player, duration) {
  self endon(#"death");
  wait isDefined(duration) ? duration : self.boostduration + 0.5;
  self notify(#"end_boost");

  if(isDefined(var_1ca9b241)) {
    stopfx(localclientnum, var_1ca9b241);
  }

  if(isDefined(var_dc0238cc) && isPlayer(player)) {
    player stoprumble(localclientnum, var_dc0238cc);
  }
}

function function_5ce3e74e(localclientnum, var_1ca9b241, var_dc0238cc, player) {
  self endon(#"end_boost");
  self endon(#"veh_boost");
  self endon(#"death");

  while(true) {
    if(!isinvehicle(localclientnum, self)) {
      if(isDefined(var_1ca9b241)) {
        stopfx(localclientnum, var_1ca9b241);
      }

      if(isDefined(var_dc0238cc)) {
        player stoprumble(localclientnum, var_dc0238cc);
      }

      break;
    }

    waitframe(1);
  }
}

function aircraft_dustkick() {
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

    if(trace[#"fraction"] < 0.01 || distsqr < sqr(0)) {
      wait 0.2;
      continue;
    } else if(trace[#"fraction"] >= 1 || distsqr > sqr(700)) {
      wait 1;
      continue;
    }

    if(sqr(0) < distsqr && distsqr < sqr(700)) {
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

function lights_on(localclientnum, team) {
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

function addanimtolist(animitem, &liston, &listoff, playwhenoff, id, maxid) {
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

function ambient_anim_toggle(localclientnum, groupid, ison) {
  if(!isDefined(self.scriptbundlesettings)) {
    return;
  }

  settings = getscriptbundle(self.scriptbundlesettings);

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

function field_toggle_ambient_anim_handler1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self ambient_anim_toggle(fieldname, 1, bwastimejump);
}

function field_toggle_ambient_anim_handler2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self ambient_anim_toggle(fieldname, 2, bwastimejump);
}

function field_toggle_ambient_anim_handler3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self ambient_anim_toggle(fieldname, 3, bwastimejump);
}

function field_toggle_ambient_anim_handler4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self ambient_anim_toggle(fieldname, 4, bwastimejump);
}

function function_7927d9b1(settings, groupid) {
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

function function_34105b89(localclientnum, groupid, ison) {
  if(!isDefined(self.scriptbundlesettings)) {
    return;
  }

  settings = getscriptbundle(self.scriptbundlesettings);

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

function function_d427b534(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_34105b89(fieldname, 1, bwastimejump);
}

function nova_crawler_spawnerbamfterminate(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_34105b89(fieldname, 2, bwastimejump);
}

function function_48a01e23(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_34105b89(fieldname, 3, bwastimejump);
}

function function_6ad96295(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_34105b89(fieldname, 4, bwastimejump);
}

function event_handler[enter_vehicle] codecallback_vehicleenter(eventstruct) {
  if(!isPlayer(self)) {
    return;
  }

  vehicle = eventstruct.vehicle;
  localclientnum = eventstruct.localclientnum;
  var_6c2c0da5 = eventstruct.var_6c2c0da5;

  if(is_true(var_6c2c0da5)) {
    return;
  }

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
      if(is_true(var_8730ee3e.zmenhancedstatejukeinit)) {
        if(!isDefined(vehicle.t_sarah_foy_objective__indicator_)) {
          vehicle.t_sarah_foy_objective__indicator_ = [];
        }

        if(is_true(vehicle.t_sarah_foy_objective__indicator_[seatindex])) {
          return;
        }

        vehicle.t_sarah_foy_objective__indicator_[seatindex] = 1;
      }

      animation = var_8730ee3e.vehicleenteranim;

      if(isDefined(animation)) {
        vehicle setanimrestart(animation, 1, 0, isDefined(vehicle.var_7d3d0f72) ? vehicle.var_7d3d0f72 : 1);
      }
    }
  }
}

function event_handler[change_seat] function_124469f4(eventstruct) {
  if(!isPlayer(self)) {
    return;
  }

  vehicle = eventstruct.vehicle;
  localclientnum = eventstruct.localclientnum;
  var_6c2c0da5 = eventstruct.var_6c2c0da5;

  if(is_true(var_6c2c0da5)) {
    return;
  }

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
      if(!is_true(var_8730ee3e.var_8d496bb1)) {
        return;
      }

      if(is_true(var_8730ee3e.zmenhancedstatejukeinit)) {
        if(!isDefined(vehicle.t_sarah_foy_objective__indicator_)) {
          vehicle.t_sarah_foy_objective__indicator_ = [];
        }

        if(is_true(vehicle.t_sarah_foy_objective__indicator_[seatindex])) {
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

function lights_group_toggle(localclientnum, groupid, ison) {
  if(!isDefined(self.scriptbundlesettings)) {
    return;
  }

  settings = getscriptbundle(self.scriptbundlesettings);

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

function field_toggle_lights_group_handler1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self lights_group_toggle(fieldname, 0, bwastimejump);
}

function field_toggle_lights_group_handler2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self lights_group_toggle(fieldname, 1, bwastimejump);
}

function field_toggle_lights_group_handler3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self lights_group_toggle(fieldname, 2, bwastimejump);
}

function field_toggle_lights_group_handler4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self lights_group_toggle(fieldname, 3, bwastimejump);
}

function function_7baff7f6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self function_e1a2a256(1);
    return;
  }

  self function_e1a2a256(0);
}

function delete_alert_lights(localclientnum) {
  if(isDefined(self.alert_light_fx_handles)) {
    for(i = 0; i < self.alert_light_fx_handles.size; i++) {
      if(isDefined(self.alert_light_fx_handles[i])) {
        stopfx(localclientnum, self.alert_light_fx_handles[i]);
      }
    }
  }

  self.alert_light_fx_handles = undefined;
}

function lights_off(localclientnum) {
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

function lights_flicker(localclientnum, duration = 8, var_5db078ba = 1) {
  self notify("28f070328d3b8709");
  self endon("28f070328d3b8709");
  self endon(#"cancel_flicker");
  self endon(#"death");

  if(!isDefined(self.scriptbundlesettings)) {
    return;
  }

  state = 1;
  durationleft = gettime() + int(duration * 1000);
  settings = getscriptbundle(self.scriptbundlesettings);

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

function field_toggle_emp(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread toggle_fx_bundle(fieldname, "emp_base", bwastimejump == 1);
}

function field_toggle_burn(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread toggle_fx_bundle(fieldname, "burn_base", bwastimejump == 1);
}

function flicker_lights(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 0) {
    self notify(#"cancel_flicker");
    self lights_off(fieldname);
    return;
  }

  if(bwastimejump == 1) {
    self thread lights_flicker(fieldname);
    return;
  }

  if(bwastimejump == 2) {
    self thread lights_flicker(fieldname, 20);
    return;
  }

  if(bwastimejump == 3) {
    self notify(#"cancel_flicker");
  }
}

function function_1ea3bdef(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::waittill_dobj(fieldname);

  if(isDefined(self)) {
    function_c45d231e(fieldname, self, 1);
    self thread function_e5f88559(fieldname, "emp_base");
    self thread function_e5f88559(fieldname, "burn_base");
    self thread function_e5f88559(fieldname, "smolder");
    self thread function_e5f88559(fieldname, "death");
    self thread function_e5f88559(fieldname, "empdeath");

    if(bwastimejump) {
      self lights_off(fieldname);
    }

    self thread stop_exhaust(fieldname);
  }
}

function function_e5f88559(localclientnum, name) {
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

function toggle_fx_bundle(localclientnum, name, turnon) {
  if(!isDefined(self.settings) && isDefined(self.scriptbundlesettings)) {
    self.settings = getscriptbundle(self.scriptbundlesettings);
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

function delayed_fx_thread(localclientnum, name, fx, tag, delay) {
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

function field_toggle_sounds(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(self.vehicleclass === "helicopter") {
    if(bwastimejump) {
      self notify(#"stop_heli_sounds");
      self.should_not_play_sounds = 1;
    } else {
      self notify(#"play_heli_sounds");
      self.should_not_play_sounds = 0;
    }
  }

  if(bwastimejump) {
    self disablevehiclesounds();
    self function_dcec5385();

    if(is_true(self.settings.var_4221c285) && isDefined(self.settings.var_681129b2)) {
      self stoprumble(fieldname, self.settings.var_681129b2);
    }

    return;
  }

  self enablevehiclesounds();

  if(is_true(self.settings.var_4221c285) && isDefined(self.settings.var_681129b2)) {
    self playrumblelooponentity(fieldname, self.settings.var_681129b2);
  }
}

function private function_dcec5385() {
  self function_f753359a();
  self function_3aa94f97();
}

function field_toggle_dnidamagefx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self thread postfx::playpostfxbundle(#"pstfx_dni_vehicle_dmg");
  }
}

function toggle_flir_postfxbundle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  player = self;

  if(bwastimejump == fieldname) {
    return;
  }

  if(!isDefined(player) || !player function_21c0fa55()) {
    return;
  }

  if(bwastimejump == 0) {
    if(fieldname == 1) {
      player thread postfx::stoppostfxbundle("pstfx_infrared");
    } else if(fieldname == 2) {
      player thread postfx::stoppostfxbundle("pstfx_flir");
    }

    update_ui_fullscreen_filter_model(binitialsnap, 0);
    return;
  }

  if(bwastimejump == 1) {
    if(player shouldchangescreenpostfx(binitialsnap)) {
      player thread postfx::playpostfxbundle(#"pstfx_infrared");
      update_ui_fullscreen_filter_model(binitialsnap, 2);
    }

    return;
  }

  if(bwastimejump == 2) {
    should_change = 1;

    if(player shouldchangescreenpostfx(binitialsnap)) {
      player thread postfx::playpostfxbundle(#"pstfx_flir");
      update_ui_fullscreen_filter_model(binitialsnap, 1);
    }
  }
}

function shouldchangescreenpostfx(localclientnum) {
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

function set_static_postfxbundle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  player = self;

  if(bwastimejump == fieldname) {
    return;
  }

  if(!isDefined(player) || !player function_21c0fa55()) {
    return;
  }

  if(bwastimejump == 0) {
    if(player postfx::function_556665f2(#"pstfx_static")) {
      player thread postfx::stoppostfxbundle(#"pstfx_static");
    }

    if(player postfx::function_556665f2(#"hash_15d46f4ad6539103")) {
      player thread postfx::stoppostfxbundle(#"hash_15d46f4ad6539103");
    }

    return;
  }

  if(bwastimejump == 1) {
    var_8efa62c3 = 1;
    vehicle = getplayervehicle(player);

    if(isDefined(vehicle)) {
      if(vehicle.vehicletype == # "veh_hawk_player_mp" || vehicle.vehicletype == # "veh_hawk_player_far_range_mp" || vehicle.vehicletype == # "veh_hawk_player_wz" || vehicle.vehicletype == # "veh_hawk_player_far_range_wz") {
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

function update_ui_fullscreen_filter_model(localclientnum, vision_set_value) {
  model = getuimodel(function_1df4c3b0(localclientnum, #"vehicle"), "fullscreenFilter");

  if(isDefined(model)) {
    setuimodelvalue(model, vision_set_value);
  }
}

function field_toggle_treadfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(self.vehicleclass === "helicopter" || self.vehicleclass === "plane") {
    println("<dev string:xf2>");

    if(fieldname) {
      if(isDefined(self.csf_no_tread)) {
        self.csf_no_tread = 0;
      }

      self kill_treads_forever();
      self thread aircraft_dustkick();
    } else if(isDefined(bwastimejump) && bwastimejump) {
      self.csf_no_tread = 1;
    } else {
      self kill_treads_forever();
    }

    return;
  }

  if(fieldname) {
    println("<dev string:x115>");

    if(isDefined(bwastimejump) && bwastimejump) {
      println("<dev string:x13f>" + self getentitynumber());
      self.csf_no_tread = 1;
    } else {
      println("<dev string:x160>" + self getentitynumber());
      self kill_treads_forever();
    }

    return;
  }

  println("<dev string:x17f>");

  if(isDefined(self.csf_no_tread)) {
    self.csf_no_tread = 0;
  }

  self kill_treads_forever();
}

function field_use_engine_damage_sounds(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(self.vehicleclass === "helicopter") {
    switch (bwastimejump) {
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

function private function_cc6f861b(localclientnum) {
  self function_3aa94f97();

  if(is_true(self.var_6aedef46)) {
    self.var_5a428a07 = self playSound(localclientnum, self.hornsound);
    return;
  }

  self.var_76660b3a = self playLoopSound(self.hornsound);
}

function private function_3aa94f97() {
  if(isDefined(self.var_5a428a07)) {
    stopsound(self.var_5a428a07);
    self.var_5a428a07 = undefined;
  }
}

function private function_f753359a() {
  if(isDefined(self.var_76660b3a)) {
    self stoploopsound(self.var_76660b3a);
    self.var_76660b3a = undefined;
  }
}

function private function_27b19317(localclientnum) {
  if(!self function_4add50a7()) {
    return false;
  }

  if(function_65b9eb0f(localclientnum)) {
    return false;
  }

  if(is_true(self.var_304cf9da)) {
    return false;
  }

  if(is_true(self.var_6aedef46)) {
    return false;
  }

  return true;
}

function private function_2d24296(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(self function_27b19317(fieldname)) {
    return;
  }

  if(!isDefined(self.hornsound)) {
    return;
  }

  if(bwastimejump) {
    self function_cc6f861b(fieldname);
    return;
  }

  self function_f753359a();
}

function function_7d1d0e65(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.settings) && isDefined(self.scriptbundlesettings)) {
    self.settings = getscriptbundle(self.scriptbundlesettings);
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
    stopfx(binitialsnap, handle);
  }

  self.fx_handles[#"malfunction"] = [];

  if(bwastimejump) {
    foreach(var_b5ddf091 in self.settings.malfunction_effects) {
      tag = var_b5ddf091.var_454a4e08;
      effect = var_b5ddf091.transition;

      if(isDefined(var_b5ddf091.transition) && isDefined(var_b5ddf091.var_454a4e08)) {
        util::playFXOnTag(binitialsnap, var_b5ddf091.transition, self, var_b5ddf091.var_454a4e08);
      }

      switch (bwastimejump) {
        case 0:
          break;
        case 1:
          if(isDefined(var_b5ddf091.warning) && isDefined(var_b5ddf091.tag_warning)) {
            handle = util::playFXOnTag(binitialsnap, var_b5ddf091.warning, self, var_b5ddf091.tag_warning);

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
            handle = util::playFXOnTag(binitialsnap, var_b5ddf091.active, self, var_b5ddf091.var_2f451e59);

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
            handle = util::playFXOnTag(binitialsnap, var_b5ddf091.fatal, self, var_b5ddf091.var_ceeccc7a);

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

  if(bwastimejump != fieldname) {
    var_ca456b21 = "uin_chopper_alarm_warning";
    var_b10574a9 = "uin_chopper_alarm_critical";

    switch (fieldname) {
      case 0:
      case 1:
        if(isDefined(self.var_30141f5c)) {
          self stoploopsound(self.var_30141f5c);
          self.var_30141f5c = undefined;
        }

        break;
      case 2:
      case 3:
        if(bwastimejump != 2 && bwastimejump != 3 && isDefined(self.var_30141f5c)) {
          self stoploopsound(self.var_30141f5c);
          self.var_30141f5c = undefined;
        }

        break;
    }

    switch (bwastimejump) {
      case 0:
        break;
      case 1:
        self.var_30141f5c = self playLoopSound(var_ca456b21);
        break;
      case 2:
      case 3:
        if(fieldname != 2 && fieldname != 3) {
          self.var_30141f5c = self playLoopSound(var_b10574a9);
        }

        break;
    }
  }
}

function field_do_deathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(newval) {
    self stop_stun_fx(localclientnum);
    self notify(#"vehicle_death_fx");
  }

  if(newval == 2) {
    self field_do_empdeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
  } else {
    self field_do_standarddeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
  }

  self thread function_18758bfa(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
}

function private function_724c261b(localclientnum, var_9ea6f38a) {
  if(!isDefined(var_9ea6f38a)) {
    return;
  }

  if(isDefined(var_9ea6f38a.var_d6402306)) {
    if(isDefined(var_9ea6f38a.var_77369946)) {
      handle = util::playFXOnTag(localclientnum, var_9ea6f38a.var_d6402306, self, var_9ea6f38a.var_77369946);
    } else {
      handle = playFX(localclientnum, var_9ea6f38a.var_d6402306, self.origin);
    }

    setfxignorepause(localclientnum, handle, 1);

    if(!isDefined(self.fx_handles[#"smolder"])) {
      self.fx_handles[#"smolder"] = [];
    } else if(!isarray(self.fx_handles[#"smolder"])) {
      self.fx_handles[#"smolder"] = array(self.fx_handles[#"smolder"]);
    }

    self.fx_handles[#"smolder"][self.fx_handles[#"smolder"].size] = handle;
  }

  if(isDefined(var_9ea6f38a.var_2ddda1c6)) {
    self playSound(localclientnum, var_9ea6f38a.var_2ddda1c6);
  }
}

function private function_5ec745e3(localclientnum) {
  if(!isDefined(self.settings) && isDefined(self.scriptbundlesettings)) {
    self.settings = getscriptbundle(self.scriptbundlesettings);
  }

  if(!isDefined(self.settings)) {
    return;
  }

  if(!isDefined(self.settings.var_24cedff1)) {
    return;
  }

  foreach(var_9ea6f38a in self.settings.var_24cedff1) {
    self function_724c261b(localclientnum, var_9ea6f38a);
  }
}

function function_18758bfa(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(fieldname && !bwastimejump) {
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
        handle = util::playFXOnTag(binitialsnap, self.var_8a037014, self, self.var_20eae439);
      } else {
        handle = playFX(binitialsnap, self.var_8a037014, self.origin);
      }

      setfxignorepause(binitialsnap, handle, 1);

      if(!isDefined(self.fx_handles[#"smolder"])) {
        self.fx_handles[#"smolder"] = [];
      } else if(!isarray(self.fx_handles[#"smolder"])) {
        self.fx_handles[#"smolder"] = array(self.fx_handles[#"smolder"]);
      }

      self.fx_handles[#"smolder"][self.fx_handles[#"smolder"].size] = handle;
    }

    self function_5ec745e3(binitialsnap);

    if(isDefined(self.var_68f20b20) && self.var_68f20b20 != "") {
      self playSound(binitialsnap, self.var_68f20b20);
    }

    if(isDefined(handle) && isDefined(self.var_b321fcb3) && self.var_b321fcb3 > 0) {
      wait self.var_b321fcb3;

      if(isfxplaying(binitialsnap, handle)) {
        stopfx(binitialsnap, handle);
        arrayremovevalue(self.fx_handles[#"smolder"], handle, 0);
      }
    }

    return;
  }

  if(isDefined(self.fx_handles) && isDefined(self.fx_handles[#"smolder"])) {
    foreach(handle in self.fx_handles[#"smolder"]) {
      stopfx(binitialsnap, handle);
    }

    self.fx_handles[#"smolder"] = [];
  }
}

function private function_fc7e495f(localclientnum, var_47bcd3d1) {
  if(!isDefined(var_47bcd3d1)) {
    return;
  }

  self endon(#"death");

  if(isDefined(var_47bcd3d1.var_ad486dc4) && var_47bcd3d1.var_ad486dc4 > 0) {
    wait var_47bcd3d1.var_ad486dc4;
  }

  if(isDefined(var_47bcd3d1.var_82aeef56)) {
    if(isDefined(var_47bcd3d1.var_e9927fbf)) {
      handle = util::playFXOnTag(localclientnum, var_47bcd3d1.var_82aeef56, self, var_47bcd3d1.var_e9927fbf);
    } else {
      handle = playFX(localclientnum, var_47bcd3d1.var_82aeef56, self.origin);
    }

    setfxignorepause(localclientnum, handle, 1);

    if(!isDefined(self.fx_handles[#"death"])) {
      self.fx_handles[#"death"] = [];
    } else if(!isarray(self.fx_handles[#"death"])) {
      self.fx_handles[#"death"] = array(self.fx_handles[#"death"]);
    }

    self.fx_handles[#"death"][self.fx_handles[#"death"].size] = handle;
  }

  if(isDefined(var_47bcd3d1.var_346b417d)) {
    self playSound(localclientnum, var_47bcd3d1.var_346b417d);
  }
}

function private function_eea2c7ff(localclientnum) {
  if(!isDefined(self.settings) && isDefined(self.scriptbundlesettings)) {
    self.settings = getscriptbundle(self.scriptbundlesettings);
  }

  if(!isDefined(self.settings)) {
    return;
  }

  if(!isDefined(self.settings.var_b3fbebad)) {
    return;
  }

  foreach(var_47bcd3d1 in self.settings.var_b3fbebad) {
    self thread function_fc7e495f(localclientnum, var_47bcd3d1);
  }
}

function field_do_standarddeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(fieldname && !bwastimejump) {
    self endon(#"death");
    util::waittill_dobj(binitialsnap);

    if(!isDefined(self.fx_handles)) {
      self.fx_handles = [];
    }

    if(!isDefined(self.fx_handles[#"death"])) {
      self.fx_handles[#"death"] = [];
    }

    if(isDefined(self.deathfxname)) {
      if(isDefined(self.deathfxtag) && self.deathfxtag != "") {
        handle = util::playFXOnTag(binitialsnap, self.deathfxname, self, self.deathfxtag);
      } else {
        handle = playFX(binitialsnap, self.deathfxname, self.origin);
      }

      setfxignorepause(binitialsnap, handle, 1);

      if(!isDefined(self.fx_handles[#"death"])) {
        self.fx_handles[#"death"] = [];
      } else if(!isarray(self.fx_handles[#"death"])) {
        self.fx_handles[#"death"] = array(self.fx_handles[#"death"]);
      }

      self.fx_handles[#"death"][self.fx_handles[#"death"].size] = handle;
    }

    self function_eea2c7ff(binitialsnap);
    self playSound(binitialsnap, self.deathfxsound);

    if(isDefined(self.deathquakescale) && self.deathquakescale > 0) {
      earthquake(binitialsnap, self.deathquakescale, self.deathquakeduration, self.origin, self.deathquakeradius);
    }

    if(isDefined(self.var_d0569e25) && self.var_d0569e25 != "") {
      self playrumbleonentity(binitialsnap, self.var_d0569e25);
    }
  }
}

function field_do_empdeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.settings) && isDefined(self.scriptbundlesettings)) {
    self.settings = getscriptbundle(self.scriptbundlesettings);
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

    if(isDefined(s.emp_death_sound_1)) {
      self playSound(localclientnum, s.emp_death_sound_1);
    }

    if(isDefined(self.deathquakescale) && self.deathquakescale > 0) {
      earthquake(localclientnum, self.deathquakescale * 0.25, self.deathquakeduration * 2, self.origin, self.deathquakeradius);
    }
  }
}

function private function_245fd53b(localclientnum) {
  self endon(#"death");
  starttime = self getclienttime();
  var_d183f050 = getservertime(localclientnum);

  while(true) {
    self function_43d26f48();
    waitframe(1);
    currenttime = self getclienttime();
    var_5710f35c = getservertime(localclientnum);

    if(var_5710f35c < var_d183f050) {
      break;
    }

    elapsedtime = currenttime - starttime;

    if(elapsedtime >= 5000) {
      break;
    }
  }
}

function function_dacff0e7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread function_245fd53b(bwastimejump);
}

function field_update_alert_level(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  delete_alert_lights(fieldname);

  if(!isDefined(self.scriptbundlesettings)) {
    return;
  }

  if(!isDefined(self.alert_light_fx_handles)) {
    self.alert_light_fx_handles = [];
  }

  settings = getscriptbundle(self.scriptbundlesettings);

  switch (bwastimejump) {
    case 0:
      break;
    case 1:
      if(isDefined(settings.unawarelightfx1)) {
        self.alert_light_fx_handles[0] = util::playFXOnTag(fieldname, settings.unawarelightfx1, self, settings.lighttag1);
      }

      break;
    case 2:
      if(isDefined(settings.alertlightfx1)) {
        self.alert_light_fx_handles[0] = util::playFXOnTag(fieldname, settings.alertlightfx1, self, settings.lighttag1);
      }

      break;
    case 3:
      if(isDefined(settings.combatlightfx1)) {
        self.alert_light_fx_handles[0] = util::playFXOnTag(fieldname, settings.combatlightfx1, self, settings.lighttag1);
      }

      break;
  }
}

function field_toggle_exhaustfx_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(fieldname) {
    if(isDefined(bwastimejump) && bwastimejump) {
      self.csf_no_exhaust = 1;
    } else {
      self stop_exhaust(binitialsnap);
    }

    return;
  }

  if(isDefined(self.csf_no_exhaust)) {
    self.csf_no_exhaust = 0;
  }

  self stop_exhaust(binitialsnap);
  self play_exhaust(binitialsnap);
}

function field_toggle_lights_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self lights_off(fieldname);
    return;
  }

  if(bwastimejump == 2) {
    self lights_on(fieldname, #"allies");
    return;
  }

  if(bwastimejump == 3) {
    self lights_on(fieldname, #"axis");
    return;
  }

  self lights_on(fieldname);
}

function field_toggle_lockon_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}

function function_670a62e7(var_96ceb3eb, &fxlist, &taglist) {
  if(isDefined(var_96ceb3eb) && isarray(var_96ceb3eb)) {
    for(i = 0; i < var_96ceb3eb.size; i++) {
      addfxandtagtolists(var_96ceb3eb[i].fx, var_96ceb3eb[i].tag, fxlist, taglist, i, var_96ceb3eb.size - 1);
    }
  }
}

function addfxandtagtolists(fx, tag, &fxlist, &taglist, id, maxid) {
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

function function_d7a2c2f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(bwastimejump) {
    self notify(#"light_disable");
    self stop_stun_fx(fieldname);
    self start_stun_fx(fieldname);
    return;
  }

  self stop_stun_fx(fieldname);
}

function start_stun_fx(localclientnum) {
  stunfx = isDefined(self.global_zm_specialty_staminup_drankdie) ? self.global_zm_specialty_staminup_drankdie : # "killstreaks/fx_agr_emp_stun";
  _exp_special_web_dissolve = isDefined(self.stunfxtag) ? self.stunfxtag : "tag_origin";
  var_6dc7131c = isDefined(self.var_c254489e) ? self.var_c254489e : # "veh_talon_shutdown";
  self.stun_fx = util::playFXOnTag(localclientnum, stunfx, self, _exp_special_web_dissolve);
  playSound(localclientnum, var_6dc7131c, self.origin);
}

function stop_stun_fx(localclientnum) {
  if(isDefined(self.stun_fx)) {
    stopfx(localclientnum, self.stun_fx);
    self.stun_fx = undefined;
  }
}

function field_update_damage_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.scriptbundlesettings)) {
    return;
  }

  settings = getscriptbundle(self.scriptbundlesettings);

  if(isDefined(self.damage_state_fx_handles)) {
    foreach(fx_handle in self.damage_state_fx_handles) {
      if(isDefined(fx_handle)) {
        stopfx(fieldname, fx_handle);
      }
    }
  }

  self.damage_state_fx_handles = [];
  fxlist = [];
  taglist = [];
  sound = undefined;

  if(bwastimejump > 0) {
    var_c0e21df2 = "damagestate_lv" + bwastimejump;
    numslots = settings.(var_c0e21df2 + "_numslots");

    for(fxindex = 1; isDefined(numslots) && fxindex <= numslots; fxindex++) {
      addfxandtagtolists(settings.(var_c0e21df2 + "_fx" + fxindex), settings.(var_c0e21df2 + "_tag" + fxindex), fxlist, taglist, fxindex, numslots);
    }

    sound = settings.(var_c0e21df2 + "_sound");
  }

  for(i = 0; i < fxlist.size; i++) {
    fx_handle = util::playFXOnTag(fieldname, fxlist[i], self, taglist[i]);

    if(!isDefined(self.damage_state_fx_handles)) {
      self.damage_state_fx_handles = [];
    } else if(!isarray(self.damage_state_fx_handles)) {
      self.damage_state_fx_handles = array(self.damage_state_fx_handles);
    }

    self.damage_state_fx_handles[self.damage_state_fx_handles.size] = fx_handle;
  }

  if(isDefined(self) && isDefined(sound)) {
    self playSound(fieldname, sound);
  }
}

function field_death_spawn_dynents(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.scriptbundlesettings)) {
    return;
  }

  settings = getscriptbundle(self.scriptbundlesettings);

  if(fieldname == 0) {
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

      switch (bwastimejump) {
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
      hitoffset = (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-5, 5));
      hitoffset = rotatepoint(hitoffset, self.angles);

      if(bwastimejump > 1 && isDefined(fx)) {
        dynent = createdynentandlaunch(fieldname, model, self.origin + offset, self.angles, self.origin + hitoffset, force, fx);
        continue;
      }

      if(bwastimejump == 1 && isDefined(fx)) {
        dynent = createdynentandlaunch(fieldname, model, self.origin + offset, self.angles, self.origin + hitoffset, force, fx);
        continue;
      }

      dynent = createdynentandlaunch(fieldname, model, self.origin + offset, self.angles, self.origin + hitoffset, force);
    }
  }
}

function field_gib_spawn_dynents(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.scriptbundlesettings)) {
    return;
  }

  settings = getscriptbundle(self.scriptbundlesettings);

  if(bwastimejump == 0) {
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
        dynent = createdynentandlaunch(bwastimejump, model, origin + offset, angles, (0, 0, 0), velocity * 0.8, fx);
      } else {
        dynent = createdynentandlaunch(bwastimejump, model, origin + offset, angles, (0, 0, 0), velocity * 0.8);
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
}

function damage_filter_enable(localclientnum, materialid) {
  level.localplayers[0].damage_filter_intensity = 0;
}

function damage_filter_disable(localclientnum) {
  level notify(#"damage_filter_off");
  level.localplayers[0].damage_filter_intensity = 0;
}

function damage_filter_off(localclientnum) {
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

    wait 0.016667;
  }
}

function damage_filter_light(localclientnum) {
  level endon(#"damage_filter_off");
  level endon(#"damage_filter_heavy");
  level notify(#"damage_filter");

  while(level.localplayers[0].damage_filter_intensity < 0.5) {
    level.localplayers[0].damage_filter_intensity += 0.083335;

    if(level.localplayers[0].damage_filter_intensity > 0.5) {
      level.localplayers[0].damage_filter_intensity = 0.5;
    }

    wait 0.016667;
  }
}

function damage_filter_heavy(localclientnum) {
  level endon(#"damage_filter_off");
  level notify(#"damage_filter_heavy");

  while(level.localplayers[0].damage_filter_intensity < 1) {
    level.localplayers[0].damage_filter_intensity += 0.083335;

    if(level.localplayers[0].damage_filter_intensity > 1) {
      level.localplayers[0].damage_filter_intensity = 1;
    }

    wait 0.016667;
  }
}

function function_9facca21(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self function_3f24c5a(bwastimejump);
  }
}

function play_flare_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self.var_26fb93b4 = util::playFXOnTag(fieldname, #"hash_3905863dd0908e4a", self, "tag_origin");
  }

  if(bwastimejump == 0) {
    if(isDefined(self.var_26fb93b4)) {
      stopfx(fieldname, self.var_26fb93b4);
      self.var_26fb93b4 = undefined;
    }
  }
}

function play_flare_hit_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self.var_b4178826 = util::playFXOnTag(fieldname, #"hash_1e747bdc27127b91", self, "tag_origin");
  }

  if(bwastimejump == 0) {
    if(isDefined(self.var_b4178826)) {
      stopfx(fieldname, self.var_b4178826);
      self.var_b4178826 = undefined;
    }
  }
}

function set_static_amount(staticamount) {
  driverlocalclient = self getlocalclientdriver();

  if(isDefined(driverlocalclient)) {}
}