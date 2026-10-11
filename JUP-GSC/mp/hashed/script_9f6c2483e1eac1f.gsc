/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_9f6c2483e1eac1f.gsc
************************************************/

#using script_53aac5ae7d2ac1b4;
#using scripts\common\utility;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_collision;
#using scripts\cp_mp\vehicles\vehicle_compass;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_dlog;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\objidpoolmanager;
#namespace namespace_bb407b77b0bcebee;

function autoexec main() {
  function_c0b3ddc9a6bdcc46("veh_jup_space_shipment_transport", &function_3ef5f926204cbd9e);
}

function private function_3ef5f926204cbd9e() {
  if(!function_9697379150687859("veh_jup_space_shipment_transport")) {
    return;
  }

  level.var_48e4bd8587968f9 = getdvarfloat(@ "hash_63997342447b8b87", 1);
  level.var_6d2d9d6d9a73cc7 = getdvarfloat(@ "hash_90e419f6d32eba39", 1);
  level.var_3e1c52fb7c3f1bc9 = getdvarfloat(@ "hash_e2da3b6e24619503", 1.2);
  level.var_6f19dd2299ccde22 = getdvarfloat(@ "hash_b0aeaf5f49bc9880", 1);
  level.var_c7432004084941b0 = getdvarfloat(@ "hash_14a693e48ce554c2", 0.5);
  level.var_45a061f49e1c9a50 = getdvarfloat(@ "hash_6ca40904bced7f47", 0.9);
  level.var_c5a60af4413f9fa9 = getdvarfloat(@ "hash_48d77161e444423f", 0.5);
  level.var_d2ec30f44a87286d = getdvarfloat(@ "hash_5514bb61ec6780cb", 0.2);
  level.var_7b0c541baa0443ef = getdvarfloat(@ "hash_cfa87dc67c8884dd", 0.05);
  level.var_5b4e83373390b0be = getdvarfloat(@ "hash_be17ad18edc41a8", 0.2);
  level.var_bab8ebdbb45d860 = getdvarfloat(@ "hash_6ee8bc7a35a3cdaa", 0.4);
  callbacks = [];
  callbacks["spawn"] = &function_31f42ad9450cb938;
  callbacks["enterStart"] = &function_c92daf0d2d3b4c32;
  callbacks["enterEnd"] = &function_1238715fb4ade17;
  callbacks["exitEnd"] = &function_b8efede8329d0df1;
  callbacks["reenter"] = &function_90edb9e4cbf08215;
  callbacks["outOfFuel"] = &function_c2ae8b4f4def3709;
  callbacks["beginBurnDown"] = &function_d35260397fd3eba0;
  callbacks["interactsWithOOBTrigger"] = &function_f7f993d241e44b19;
  callbacks["onStartRiding"] = &function_153a6accf001dff6;
  callbacks["onEndRiding"] = &function_71adb8f84c3df6bb;
  callbacks["isInInterior"] = &function_3d25af3a88ad31c3;
  callbacks["onEnterInterior"] = &function_3ffe455e5ea6d0f5;
  callbacks["onExitInterior"] = &function_b2cc563ed7324a8d;
  callbacks["explode"] = &function_f58b3f0830ae1232;
  function_8497e7e46b5e397("veh_jup_space_shipment_transport", callbacks);
  function_92b52877803f326a();
  vehicle_damage_setpremoddamagecallback("veh_jup_space_shipment_transport", &function_b1a115a5e806a8fc);
}

function private function_92b52877803f326a() {
  leveldataforvehicle = vehomn_getleveldataforvehicle("veh_jup_space_shipment_transport", 1);
  leveldataforvehicle.ammoids["flares"] = 1;
}

function private function_b1a115a5e806a8fc(data) {
  return false;
}

function private function_f7f993d241e44b19(trigger, vehicle) {
  return ispointinvolume(vehicle.origin, trigger);
}

function private function_31f42ad9450cb938(spawndata, faildata) {
  vehicle = function_bba34cf920370ff4("veh_jup_space_shipment_transport", spawndata, faildata);
  vehicle forcenetfieldhighlod(1);

  if(!isDefined(vehicle)) {
    return undefined;
  }

  vehicle.borntime = gettime();
  vehicle.flareslive = [];
  vehicle.flareready = 1;

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    vehicle.flarecooldown = 35;
  } else {
    vehicle.flarecooldown = 10;
  }

  vehicle.entstouching = [];
  vehicle thread vehicle_handleflarerecharge();
  vehicle thread collision_damage_watcher();

  if(istrue(spawndata.var_cae20238ee346e02)) {
    vehicle.ishovering = 1;
    vehicle addcomponent("p2p");
  }

  leveldataforvehicle = scripts\cp_mp\vehicles\vehicle_collision::vehicle_collision_getleveldataforvehicle("veh_jup_space_shipment_transport", 1);
  leveldataforvehicle.handleeventcallback = &function_8c08b5b97a81fb61;
  return vehicle;
}

function private function_c2ae8b4f4def3709() {
  if(istrue(self.ishovering)) {
    self.ishovering = 0;
    self removecomponent("p2p");
  }

  self.var_e114008648967bfb = 1;
  scripts\cp_mp\vehicles\vehicle_spawn::function_357783d7c1d96273();
}

function private function_d35260397fd3eba0() {
  if(istrue(self.ishovering)) {
    self.ishovering = 0;
    self removecomponent("p2p");
  }

  self.var_e114008648967bfb = 1;
}

function private collision_damage_watcher() {
  self endon("death");
  self vehphys_enablecollisioncallback(1);

  while(true) {
    self waittill("collision", body0, body1, flag0, flag1, position, normal, normalspeed, ent, partenum);

    if(gettime() - self.borntime < 5000) {
      continue;
    }

    if(isDefined(ent) && isDefined(ent.helperdronetype) && ent.helperdronetype == "radar_drone_recon") {
      continue;
    }

    var_b84ea23d4b065f9b = 1;
    damagefactor = normalspeed * var_b84ea23d4b065f9b;
    dmgval = 0;

    if(damagefactor > level.var_c5a60af4413f9fa9) {
      range = level.var_45a061f49e1c9a50 - level.var_c5a60af4413f9fa9;
      factorscale = (damagefactor - level.var_c5a60af4413f9fa9) / range;
      mindmg = self.maxhealth * level.var_5b4e83373390b0be;
      maxdmg = self.maxhealth * level.var_bab8ebdbb45d860;
      dmgval = math::lerp(mindmg, maxdmg, factorscale);
    } else if(damagefactor > level.var_d2ec30f44a87286d) {
      dmgval = self.maxhealth * level.var_7b0c541baa0443ef;
    } else {
      continue;
    }

    if(istrue(self.var_e114008648967bfb) && (length(self vehicle_getvelocity()) > 264 || isDefined(ent) && ent isvehicle() && length(ent vehicle_getvelocity()) > 264)) {
      dmgval = self.maxhealth;
    }

    if(dmgval > 0) {
      vehicle_damage_disablestatedamagefloor(1);
      self dodamage(dmgval, position, undefined, undefined, "MOD_CRUSH");
      vehicle_damage_disablestatedamagefloor(0);
    }

    wait 0.5;
  }
}

function private function_e654f2c9ee8ea94a(oldstateref, data) {
  self setscriptablepartstate("alarm", "engineFailure", 0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_onenterstateheavy(oldstateref, data);
}

function private function_fb5146a15cb434d2(oldstateref, data) {
  self setscriptablepartstate("alarm", "off", 0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_onexitstateheavy(oldstateref, data);
}

function private function_f58b3f0830ae1232(data, immediate) {}

function private function_c92daf0d2d3b4c32(vehicle, seatid, oldseatid, player, data) {
  if(istrue(vehicle.israllypointvehicle)) {
    foreach(plr in level.players) {
      if(istrue(vehicle.revealed) || is_equal(plr.team, vehicle.team)) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(vehicle.marker.objidnum, plr);
      }
    }

    foreach(occupant in vehicle.occupants) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(vehicle.marker.objidnum, occupant);
    }

    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(vehicle.marker.objidnum, player);
  }
}

function private function_1238715fb4ade17(vehicle, seatid, oldseatid, player, data) {
  if(istrue(data.success)) {
    player scripts\cp_mp\parachute::parachutecleanup();
    function_cb229daefb97c2ee(vehicle, seatid, oldseatid, player, data);
  }
}

function private function_cb229daefb97c2ee(vehicle, seatid, oldseatid, player, data) {
  if(seatid == "driver") {
    vehicle thread vehicle_handleflarefire(player);
    vehicle notify("palfa_driver_enter");
    vehicle.ishovering = 0;
    vehicle removecomponent("p2p");
  }

  vehicle setscriptablepartstate("enterExit_audio", "enter_audio");
  vehomn_updateomnvarsonseatenter(vehicle, oldseatid, seatid, player);

  if(isDefined(level.var_9215e3a9dfe8a262)) {
    [[level.var_9215e3a9dfe8a262]](vehicle, seatid, oldseatid, player, data);
  }
}

function private function_b8efede8329d0df1(vehicle, seatid, newseatid, player, data) {
  if(istrue(data.success)) {
    function_d2053cec6126f014(vehicle, seatid, newseatid, player, data);
  }
}

function private function_d2053cec6126f014(vehicle, seatid, newseatid, player, data) {
  if(seatid == "driver") {
    vehicle notify("palfa_driver_exit");
    vehicle thread function_619d5050126cbfae(player);
  }

  if(!istrue(data.playerdisconnect)) {
    success = vehicle_occupancy_moveplayertoexit(vehicle, seatid, newseatid, player, data);

    if(!success) {
      if(issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles")) {
        [[getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](player);
      } else {
        player suicide();
      }
    } else if(istrue(vehicle.israllypointvehicle)) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(vehicle.marker.objidnum, player);
    }
  }

  vehicle setscriptablepartstate("enterExit_audio", "exit_audio");
  vehomn_updateomnvarsonseatexit(vehicle, seatid, newseatid, player);
}

function private function_619d5050126cbfae(player) {
  if(!isalive(player)) {
    self endon("death");
    self endon("palfa_driver_enter");
    wait 0.5;
  }

  if(!self vehicle_isonground() && distance(self.origin, function_653b91b3edf76c93()) > 350 && !istrue(self.ishovering) && !istrue(self.var_e114008648967bfb)) {
    self.ishovering = 1;
    self addcomponent("p2p");
  }
}

function private function_653b91b3edf76c93() {
  contents = scripts\engine\trace::create_solid_ai_contents(1);
  finalpos = self.origin - anglestoup(self.angles) * 400;

  if(getdvarint(@ "hash_bedb65b7141dd04e", 0)) {
    sphere(self.origin, 100, (0, 0, 1), 0, 10000);
    sphere(finalpos, 100, (0, 0, 1), 0, 10000);
  }

  pos = scripts\engine\trace::sphere_trace(self.origin, finalpos, 100, [self], contents)["position"];

  if(getdvarint(@ "hash_bedb65b7141dd04e", 0)) {
    sphere(pos, 100, (1, 0, 0), 0, 10000);
    line(self.origin, pos, (1, 0, 0), 1, 0, 10000);
    print3d(pos, "<dev string:x1c>" + distance(self.origin, pos), (1, 0, 0), 1, 1, 10000, 1);
  }

  return pos;
}

function private function_90edb9e4cbf08215(vehicle, reenterseatid, var_3f68c37bafd38606, player, data) {}

function private vehicle_handleflarerecharge() {
  self endon("death");

  while(true) {
    if(!self.flareready) {
      wait self.flarecooldown;
      self.flareready = 1;
      driver = vehicle_occupancy_getdriver(self);

      if(isDefined(driver)) {
        vehomn_setammo("veh_jup_space_shipment_transport", "flares", 1, driver);
      }
    }

    waitframe();
  }
}

function private vehicle_handleflarefire(player) {
  self endon("death");
  self endon("palfa_driver_exit");
  player endon("death_or_disconnect");
  player endon("vehicle_exit");
  player notifyonplayercommand("shoot_flare", "+attack");
  vehomn_setammo("veh_jup_space_shipment_transport", "flares", ter_op(self.flareready, 1, 0), player);

  while(true) {
    player waittill("shoot_flare");

    if(!self.flareready) {
      self playsoundtoplayer("lbravo_noflares_warning", player);
      continue;
    }

    if(issharedfuncdefined("flares", "playFx")) {
      self thread[[getsharedfunc("flares", "playFx")]]();
    }

    newtarget = undefined;

    if(issharedfuncdefined("flares", "deploy")) {
      newtarget = self[[getsharedfunc("flares", "deploy")]]();
    }

    if(isDefined(level.missiles)) {
      foreach(missile in level.missiles) {
        if(!isDefined(missile.origin) || !isDefined(missile.lockontarget) || missile.lockontarget != self) {
          continue;
        }

        curdist = distance(self.origin, missile.origin);

        if(curdist < 4000) {
          if(issharedfuncdefined("player", "doScoreEvent")) {
            player thread[[getsharedfunc("player", "doScoreEvent")]]("manual_flare_missile_redirect");
          }

          clearprojectilelockedon(missile);
          missile missile_settargetEnt(newtarget);
          missile notify("missile_pairedWithFlare");
        }
      }
    }

    self.flareready = 0;
    vehomn_setammo("veh_jup_space_shipment_transport", "flares", 0, player);
    vehicle_occupancy_fadeoutcontrols(player);
  }
}

function function_8c08b5b97a81fb61(vehicle1, vehicle2, position, normal, normalspeed) {
  if(vehicle1 function_d93ec4635290febd() == "veh_jup_space_shipment_transport") {
    hitvehicle = vehicle2;
  } else if(vehicle2 function_d93ec4635290febd() == "veh_jup_space_shipment_transport") {
    hitvehicle = vehicle1;
  } else {
    return;
  }

  if(!isDefined(hitvehicle) || !hitvehicle isvehicle()) {
    return;
  }

  if(isDefined(hitvehicle.targetname) && hitvehicle.targetname == "dmz_ai_chopper") {
    callsharedfunc("veh9_mil_air_heli_hind_physics_limbo", "explode");
    return;
  }

  if(isDefined(hitvehicle.targetname) && hitvehicle.targetname == "veh9_blima") {
    hitvehicle dodamage(10000000, position);

    if(isDefined(hitvehicle.spawnernode)) {
      callsharedfunc("ai_heli_reinforce", "release_path", hitvehicle.spawnernode);
    }

    return;
  }

  var_5eb0207ec5e4a0a9 = getdvarfloat(@ "hash_aa027fbc10a93855", 0.1) * 1000;

  if(isDefined(hitvehicle.var_3abb0e413fb97b63) && gettime() - hitvehicle.var_3abb0e413fb97b63 < var_5eb0207ec5e4a0a9) {
    return;
  }

  impulsestrength = getdvarint(@ "hash_eaab71fc906a7125", 600);
  var_18733544e2015df = vectorNormalize(hitvehicle.origin - position);
  hitvehicle vehphys_impulse(var_18733544e2015df, impulsestrength);
  hitvehicle.var_3abb0e413fb97b63 = gettime();
}