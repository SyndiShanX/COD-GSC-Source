/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\vehicle_ai.gsc
*****************************************/

#using script_16ea1b94f0f381b3;
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\notetrack;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_spawn;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\vehicle\vehicle_common;
#namespace vehicle_ai;

function init() {
  if(!isDefined(level.var_8df7c17ba952d077)) {
    level.var_8df7c17ba952d077 = [];
  }

  setdevdvarifuninitialized(@ "hash_2a67f2406b1d6460", 0);
}

function function_76f7ea069893edd2(data) {
  if(utility::ent_flag("ai_initted")) {
    return;
  }

  utility::ent_flag_init("unloaded");
  utility::ent_flag_init("loaded");
  utility::ent_flag_init("landed");
  self.riders = [];
  self.unloadque = [];
  self.unload_group = "default";
  self.fastroperig = [];

  if(isDefined(data)) {
    isheli = vehicle::ishelicopter();
    ref = self.vehiclename;
    self.vehicleanimalias = data.ai.vehicleanimalias;
    self.classname_mp = ref;
    self.deathfunc = &vehicle::death;
    self.script_badplace = !isheli;
    self.unload_land_offset = data.ai.unload_land_offset;
    self.unload_hover_offset = data.ai.unload_hover_offset;
    self.vehiclesetuprope = data.ai.vehiclesetuprope;
    vehicle_spawn::prevent_respawn();

    if(isheli) {
      self vehicle_setspeed(60, 20, 10);
      vehicle_occupancy::function_474d87fe62493d22();
    }
  }

  thread vehicle_aianim::handle_attached_guys();
  utility::ent_flag_set("ai_initted");
}

function function_c439ae025b2bf434() {
  self addcomponent("p2p");
}

function function_fb0af73dcefe123() {
  self removecomponent("p2p");
}

function try_horn(final_dest) {
  if(!isDefined(self.var_1311060992aff23) || self.var_1311060992aff23 < 5) {
    if(distancesquared(self.origin, final_dest) < squared(750)) {
      if(!isDefined(self.var_f969432374ae8c0b)) {
        self.var_f969432374ae8c0b = 0;
        self.var_1311060992aff23 = 0;
      }

      if(gettime() > self.var_f969432374ae8c0b) {
        if(soundexists("veh_horn_mid_random")) {
          self playsoundonmovingent("veh_horn_mid_random");
        }

        self.var_1311060992aff23++;
        self.var_f969432374ae8c0b = gettime() + randomintrange(200, 1000);
      }
    }
  }
}

function has_anim_intro() {
  ref = vehicle::get_ref();

  if(vehicle::has_data(ref)) {
    data = vehicle::get_data(ref);
    return (isDefined(data.ai) && istrue(data.ai.animintro));
  }

  return false;
}

function function_1f72bceb8e93b361() {
  if(!has_anim_intro()) {
    return;
  }

  foreach(seat in vehicle::get_data(vehicle::get_ref()).aiseats) {
    var_7237854e3be197ca = seat.vehicle_getoutanim;

    if(isDefined(var_7237854e3be197ca)) {
      return var_7237854e3be197ca;
    }
  }
}

function function_e88eb42ddd02765b() {
  if(!has_anim_intro()) {
    return;
  }

  var_7237854e3be197ca = vehicle::get_data(vehicle::get_ref()).ai.animintrolength;

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  return getanimlength(function_1f72bceb8e93b361());
}

function function_3f791d10e984b5fc() {
  return vehicle::get_data(vehicle::get_ref()).ai.var_a5f09aae7b460b24 ?? 400;
}

function function_a17e8d27cb11154c() {
  return function_69a7fc27a2f10141() * 17.6;
}

function function_69a7fc27a2f10141() {
  return vehicle::get_data(vehicle::get_ref()).ai.var_f7d3550554dbd6a9 ?? 10;
}

function function_b653bae885b293df() {
  return vehicle::get_data(vehicle::get_ref()).ai.var_f56254142506eaa8;
}

function function_1db0768558d44471(pathdata, speed, var_4520e0d9c889c80a, navmeshlayer) {
  self endon("death");
  self endon("unloaded");
  self notify("newFollowPath");
  self endon("newFollowPath");

  while(!isDefined(level.vehiclenavmeshlayer)) {
    waitframe();
  }

  while(true) {
    function_d260dc8c71afa7a0(pathdata);
    try_horn(pathdata.path[pathdata.index].origin);
    adjustedspeed = function_961ae66d309dfdf4(pathdata.path[pathdata.index], speed);

    if(adjustedspeed != speed) {
      self setconfigvalue("p2p", "goalThreshold", adjustedspeed * 4);
    }

    result = function_1a6c0d0264fdd63c(self.origin, pathdata.path[pathdata.index].origin, adjustedspeed, undefined, undefined, navmeshlayer);

    if(isDefined(var_4520e0d9c889c80a) && isDefined(result) && result == "path_blocked") {
      [[var_4520e0d9c889c80a]]();
    }

    waitframe();
  }
}

function function_961ae66d309dfdf4(node, speed) {
  if(!isDefined(node.relativespeed)) {
    return speed;
  }

  if(node.relativespeed == "slow") {
    return 20;
  }

  if(node.relativespeed == "fast") {
    return 80;
  }

  if(node.relativespeed == "furious") {
    return 128;
  }

  return speed;
}

function function_d260dc8c71afa7a0(pathdata) {
  pathdata.index = (pathdata.index + pathdata.direction) % pathdata.path.size;

  if(pathdata.index < 0) {
    pathdata.index += pathdata.path.size;
  }
}

function damage_feedback(hittype) {
  if(hittype == "hitveharmorbreak") {
    level notify("armorplate_broken", self);
  }

  if(isPlayer(self)) {
    if(utility::issharedfuncdefined(#"damage", #"updatedamagefeedback")) {
      self[[utility::getsharedfunc(#"damage", #"updatedamagefeedback")]](hittype);
    }
  }
}

function armored_vehicle_death() {
  if(isDefined(self.aidriver)) {
    self.aidriver.fn_shoulddodamage = undefined;
  }

  origin = self.origin + (0, 0, 40);

  foreach(rider in self.riders) {
    if(!isalive(rider)) {
      continue;
    }

    rider.do_immediate_ragdoll = 1;
    rider.ragdoll_immediate = 1;

    if(!rider._blackboard.vehiclerequested) {
      anim_pos = vehicle_aianim::anim_pos(self, rider.vehicle_position);
      rider vehicle_common::requestentervehicle(self, 0, rider.vehicle_position, anim_pos);
    }

    if(isDefined(rider._blackboard.chosenvehicleanimpos)) {
      if(rider._blackboard.chosenvehicleanimpos_deathimpulse) {
        rider._blackboard.chosenvehicleanimpos_deathragdoll = 1;
      }
    }

    rider dodamage(rider.health + 100, self.origin + (0, 0, -100), undefined, undefined, "MOD_EXPLOSIVE");
  }
}

function function_1a6c0d0264fdd63c(start_point, end_point, speed, setmaxspeed, var_a806fa27d4c8f0a8, navmeshlayer = level.vehiclenavmeshlayer) {
  assert(isDefined(level.vehiclenavmeshlayer), "<dev string:x24>");
  var_88319952e6c79b9d = undefined;

  if(!isDefined(setmaxspeed)) {
    setmaxspeed = 1;
  }

  if(!isDefined(var_a806fa27d4c8f0a8)) {
    var_a806fa27d4c8f0a8 = 0;
  }

  if(distancesquared(start_point, end_point) < 62500) {
    var_88319952e6c79b9d = [getclosestpointonnavmesh(end_point, navmeshlayer)];
  } else {
    var_88319952e6c79b9d = findpathcustom(start_point, getclosestpointonnavmesh(end_point, navmeshlayer), 1, 1, navmeshlayer);
    var_88319952e6c79b9d[0] = undefined;

    if(getDvar(@ "hash_5932a654e8efe1fa", "<dev string:xae>") != "<dev string:xae>") {
      foreach(index, node in var_88319952e6c79b9d) {
        sphere(node, 16, (1, 1, 1), 200000);

        if(isDefined(var_88319952e6c79b9d[index + 1])) {
          line(node, var_88319952e6c79b9d[index + 1], (0, 1, 0), 200000);
        }
      }
    }

    if(getDvar(@ "scr_debugvehpos", "<dev string:xae>") != "<dev string:xae>") {
      sphere(end_point, 16, (1, 1, 1), 0, 2);
    }
  }

  if(var_88319952e6c79b9d.size >= 1) {
    return go_to_path(var_88319952e6c79b9d, speed, setmaxspeed, var_a806fa27d4c8f0a8);
  }
}

function go_to_path(var_88319952e6c79b9d, speed, setmaxspeed, var_a806fa27d4c8f0a8) {
  self notify("path_updated");
  self endon("path_updated");
  self endon("kill_thread_since_spotted");
  self endon("death");
  self endon("unloaded");

  if(!isDefined(speed) && !isDefined(self.var_2c37025c6a0e1fe9)) {
    assertmsg("<dev string:xb2>");
    return "path_blocked";
  }

  if(setmaxspeed && isDefined(speed)) {
    set_speed(speed);
  }

  last_point = undefined;

  if(var_a806fa27d4c8f0a8) {
    last_point = utility::function_f1933af772476229(var_88319952e6c79b9d);
  }

  foreach(point in var_88319952e6c79b9d) {
    var_c65210324564022c = 62500;

    if(isDefined(self.var_c65210324564022c)) {
      var_c65210324564022c = self.var_c65210324564022c;
    }

    if(distancesquared(self.origin, point) < var_c65210324564022c) {
      continue;
    }

    self setconfigvalue("p2p", "goalPoint", point);

    if(var_a806fa27d4c8f0a8 && point == last_point) {
      self setconfigvalue("p2p", "brakeAtGoal", 1);
    }

    self.goalpoint = point;

    if(!setmaxspeed && isDefined(speed)) {
      dist = distance(self.origin, point);
      time = undefined;

      if(dist > 0) {
        time = get_duration_between_points(self.origin, point, speed);
      }

      key = function_abd1a501c0438a5b("p2p", "targetTime");

      if(isDefined(time)) {
        self setconfigvalue(key, time);
      } else {
        self setconfigvalue(key, 0.2);
      }
    }

    result = utility::waittill_any_return("near_goal", "path_blocked");

    if(result == "path_blocked") {
      return "path_blocked";
    }
  }

  return "near_goal";
}

function set_speed(speed) {
  manualspeed = function_abd1a501c0438a5b("p2p", "manualSpeed");
  self setconfigvalue(manualspeed, utility::mph_to_ips(speed));
}

function get_duration_between_points(startpos, endpos, speed, convert) {
  dist = distance(startpos, endpos);

  if(convert) {
    dist *= 0.0568182;
  }

  moverate = dist / speed;
  return max(moverate, 0.05);
}

function function_4d0a509d2911b6c6(var_99bcf2eb77efe27c) {
  ref = isent(var_99bcf2eb77efe27c) ? var_99bcf2eb77efe27c vehicle::get_ref() : var_99bcf2eb77efe27c;

  if(!vehicle::has_data(ref)) {
    return 0;
  }

  data = vehicle::get_data(ref);

  if(!isDefined(data.ai) || !data.ai.supportsai) {
    return 0;
  }

  totalseats = data.aiseats.size;

  foreach(seat in data.aiseats) {
    if(seat.var_14f441f730dc229d) {
      totalseats -= 1;
    }
  }

  return totalseats;
}

function supports_ai(var_99bcf2eb77efe27c) {
  ref = isent(var_99bcf2eb77efe27c) ? var_99bcf2eb77efe27c vehicle::get_ref() : var_99bcf2eb77efe27c;

  if(!vehicle::has_data(ref)) {
    return false;
  }

  data = vehicle::get_data(ref);
  return isDefined(data.ai.supportsai);
}

function function_9133d94dfb2c34f(var_99bcf2eb77efe27c) {
  ref = isent(var_99bcf2eb77efe27c) ? var_99bcf2eb77efe27c vehicle::get_ref() : var_99bcf2eb77efe27c;

  if(!vehicle::has_data(ref)) {
    return 0;
  }

  data = vehicle::get_data(ref);

  if(self isincombat() || !self.stealth_enabled) {
    return (isDefined(data.ai.supportsai) && isDefined(data.aiseats[0].vehicle_getinanim_combat));
  }

  return isDefined(data.ai.supportsai) && isDefined(data.aiseats[0].vehicle_getinanim);
}

function can_load(riders) {
  return self && !vehicle::is_destroyed() && self.isempty;
}

function load(riders, spawninvehicle = 0, var_a2ce7ad489be5c4f, group, goddriver) {
  vehicleref = vehicle::get_ref();
  assert(utility::level_supports_ai() && istrue(vehicle::get_data(vehicleref).ai.supportsai), "<dev string:x103>");

  if(is_loading()) {
    return;
  }

  self.loading = 1;
  riders = vehicle_code::sort_by_startingpos(riders);

  if(!utility::ent_flag("ai_initted")) {
    function_76f7ea069893edd2(vehicle::get_data(vehicleref));
  }

  if(utility::issharedfuncdefined(vehicleref, #"loadAI")) {
    [[utility::getsharedfunc(vehicleref, #"loadAI")]](riders, spawninvehicle, var_a2ce7ad489be5c4f);
  } else {
    default_load(riders, spawninvehicle, var_a2ce7ad489be5c4f, group);
  }

  vehicle_occupancy::update_occupancy(self);
}

function default_load(riders, spawninvehicle = 0, var_a2ce7ad489be5c4f, group, goddriver) {
  thread function_c40dc2214ed65c47();
  vehicle_spawn::stop_watching_abandoned();
  vehicledata = vehicle::get_data(vehicle::get_ref());
  turrets = [];

  foreach(turret in vehicle::get_turrets(self)) {
    turrets[turrets.size] = turret;
  }

  var_6b123f50138e1aa7 = 0;
  turretindexes = vehicle::function_ffff4932a6fa99fb(self, 0);
  utility::ent_flag_clear("unloaded");
  utility::ent_flag_clear("loaded");
  thread function_f9ce24d8c6696807(riders);

  for(i = 0; i < riders.size; i++) {
    if(!(isDefined(riders[i]) && isDefined(riders[i]._blackboard))) {
      function_fb73b92ecd652540(riders[i]);

      continue;
    }

    if(getdvarint(@ "hash_b8d9dce6bbc23e00", 0)) {
      thread vehicle_aianim::guy_runtovehicle(riders[i], self, goddriver, group, spawninvehicle);
    } else {
      availablepositionsstruct = vehicle_aianim::get_availablepositions(group);

      if(isDefined(riders[i].spawner.script_startingposition) && !isDefined(riders[i].script_startingposition)) {
        riders[i].script_startingposition = int(riders[i].spawner.script_startingposition);
      }

      pos = vehicle_aianim::choose_vehicle_position(riders[i], availablepositionsstruct, goddriver);

      if(!isDefined(pos.vehicle_position) || !pos.origin || !pos.angles) {
        continue;
      }

      riders[i].vehicle_position = pos.vehicle_position;
      self.usedpositions[pos.vehicle_position] = 1;
      anim_pos = vehicle_aianim::anim_pos(self, pos.vehicle_position);
      seat_id = function_b171195b98497124(self, pos.vehicle_position);
      vehicle_occupancy::function_4793dd4d02d6e68c(self, seat_id, 1);

      if(!spawninvehicle) {
        if(!isDefined(self.runningtovehicle)) {
          self.runningtovehicle = [];
        }

        self.runningtovehicle[self.runningtovehicle.size] = riders[i];
      }

      thread function_86f2fd37d36948b6(riders[i], spawninvehicle, pos, anim_pos);
      thread handle_rider_death(riders[i], pos.vehicle_position, seat_id);

      if(isDefined(anim_pos.bhasgunwhileriding) && !anim_pos.bhasgunwhileriding) {
        riders[i] ai::gun_remove();
      }
    }

    if(isDefined(riders[i].team) && pos.vehicle_position == 0) {
      self.aidriver = riders[i];
      self.aidriver.fn_shoulddodamage = &function_2f06fac2aaf75236;

      if(!var_a2ce7ad489be5c4f) {
        riders[i] thread function_e848c7917f1d317f(self);
      }

      if(!spawninvehicle) {
        thread watch_cancel_load(riders[i]);
      }

      continue;
    }

    if(isDefined(vehicledata.aiseats[pos.vehicle_position]) && vehicledata.aiseats[pos.vehicle_position].mgturret) {
      if(!vehicle_aianim::guy_should_man_turret(anim_pos)) {
        continue;
      }

      if(!isDefined(self.mgturret)) {
        self.mgturret = [];
      }

      if(isDefined(turretindexes[var_6b123f50138e1aa7])) {
        turret = turrets[self.mgturret.size];

        if(!isDefined(turret)) {
          assert("<dev string:x151>" + riders[i] getentitynumber() + "<dev string:x158>");
          continue;
        }

        self.mgturret[self.mgturret.size] = turret;
        riders[i] asm_bb::function_d97733fe1476f19e(self, turretindexes[var_6b123f50138e1aa7]);
        var_6b123f50138e1aa7 += 1;
        turret = self;
      } else if(turrets.size > 0) {
        if(!isDefined(self.mgturret)) {
          self.mgturret = [];
        }

        turret = turrets[self.mgturret.size];

        if(!isDefined(turret)) {
          assert("<dev string:x151>" + riders[i] getentitynumber() + "<dev string:x158>");
          continue;
        }

        self.mgturret[self.mgturret.size] = turret;

        if(turret != self) {
          turret setturretteam(riders[i].team);
        }

        riders[i] asm_bb::bb_requestturret(turret);
      } else {
        assert("<dev string:x151>" + riders[i] getentitynumber() + "<dev string:x158>");
        continue;
      }

      riders[i] thread function_bab770ab3241c7c9(self, turret);
    }
  }

  if(spawninvehicle) {
    self.loading = undefined;
    return;
  }

  self endon("death");
  self endon("cancel_load");
  utility::ent_flag_wait("loaded");
  self.loading = undefined;
}

function private watch_cancel_load(driver) {
  self notify("24594d9313c8d82e");
  self endon("24594d9313c8d82e");
  self endon("death");
  self endon("ai_enter");
  self endon("loaded");
  utility::waittill_any_ents(self, "player_enter", driver, "death", self, "force_cancel_load");

  foreach(rider in self.runningtovehicle) {
    if(rider._blackboard) {
      rider vehicle_common::cancelentervehicle();
    }
  }

  self.loading = undefined;
  self notify("cancel_load");
}

function private function_f9ce24d8c6696807(array) {
  self notify("ee18253ac67281df");
  self endon("ee18253ac67281df");
  self endon("cancel_load");
  self endon("death");

  if(array.size) {
    utility::array_wait(array, "loaded");
  }

  utility::ent_flag_set("loaded");
}

function private function_86f2fd37d36948b6(rider, spawninvehicle, pos, anim_pos) {
  self endon("cancel_load");
  self endon("death");
  vehicle = self;

  if(spawninvehicle) {
    rider thread vehicle_common::entervehicle(vehicle, spawninvehicle, pos, anim_pos);

    if(vehicle_interact::can_use(self)) {
      self notify("ai_enter");
      vehicle_occupancy::set_team(self, rider.team);
      vehicle_occupancy::function_b901181db6fc2774();
      vehicle_interact::allow_use(self, 0);
    }

    self.riders[self.riders.size] = rider;
    rider.ridingvehicle = self;
    rider.vehicle = self;
  } else {
    rider vehicle_common::requestentervehicle(vehicle, 0, pos, anim_pos);
    rider vehicle_common::waitforarrivedatvehicle();

    if(!isalive(rider)) {
      return;
    }

    if(vehicle_interact::can_use(self)) {
      self notify("ai_enter");
      vehicle_occupancy::set_team(self, rider.team);
      vehicle_occupancy::function_b901181db6fc2774();
      vehicle_interact::allow_use(self, 0);
    }

    self.riders[self.riders.size] = rider;
    rider.ridingvehicle = self;
    rider.vehicle = self;

    if(isDefined(pos)) {
      if(isDefined(anim_pos.vehicle_getinanim_combat) && (rider isincombat() || !rider.stealth_enabled)) {
        var_d9b19809c3f0f869 = isDefined(rider.no_vehicle_getoutanim);

        if(!var_d9b19809c3f0f869 && !isagent(rider)) {
          if(isDefined(anim_pos.vehicle_getoutanim)) {
            vehicle clearanim(anim_pos.vehicle_getoutanim, 0);
          }

          if(isDefined(anim_pos.vehicle_getoutanim_combat)) {
            vehicle clearanim(anim_pos.vehicle_getoutanim_combat, 0);
          }

          if(isDefined(anim_pos.vehicle_getoutanim_combat_run)) {
            vehicle clearanim(anim_pos.vehicle_getoutanim_combat_run, 0);
          }
        }

        vehicle = vehicle vehicle_aianim::getanimatemodel();
        vehicle thread vehicle_aianim::setanimrestart_once(anim_pos.vehicle_getinanim_combat, anim_pos.vehicle_getinanim_clear);
        vehicle thread notetrack::start_notetrack_wait(vehicle, "vehicle_anim_flag", undefined, undefined, anim_pos.vehicle_getinanim_combat);
      } else if(isDefined(anim_pos.vehicle_getinanim)) {
        var_d9b19809c3f0f869 = isDefined(rider.no_vehicle_getoutanim);

        if(!var_d9b19809c3f0f869 && !isagent(rider)) {
          if(isDefined(anim_pos.vehicle_getoutanim)) {
            vehicle clearanim(anim_pos.vehicle_getoutanim, 0);
          }

          if(isDefined(anim_pos.vehicle_getoutanim_combat)) {
            vehicle clearanim(anim_pos.vehicle_getoutanim_combat, 0);
          }

          if(isDefined(anim_pos.vehicle_getoutanim_combat_run)) {
            vehicle clearanim(anim_pos.vehicle_getoutanim_combat_run, 0);
          }
        }

        vehicle = vehicle vehicle_aianim::getanimatemodel();
        vehicle thread vehicle_aianim::setanimrestart_once(anim_pos.vehicle_getinanim, anim_pos.vehicle_getinanim_clear);
        vehicle thread notetrack::start_notetrack_wait(vehicle, "vehicle_anim_flag", undefined, undefined, anim_pos.vehicle_getinanim);
      }

      if(isDefined(anim_pos.vehicle_getinsoundtag)) {
        origin = vehicle gettagorigin(anim_pos.vehicle_getinsoundtag);
      } else {
        origin = vehicle.origin;
      }

      if(isDefined(anim_pos.vehicle_getinsound)) {
        playsoundatpos(origin, anim_pos.vehicle_getinsound);
      }

      getintags = undefined;
      getinthreads = undefined;

      if(isDefined(anim_pos.getin_enteredvehicletrack)) {
        getintags = [];
        getintags[0] = anim_pos.getin_enteredvehicletrack;
        getinthreads = [];
        getinthreads[0] = &vehicle_aianim::entered_vehicle_notify;
        vehicle vehicle_aianim::link_to_sittag(rider, anim_pos.sittag, anim_pos.sittag_origin_offset, anim_pos.sittag_angles_offset, anim_pos.linktoblend);
      }
    }

    rider vehicle_common::waitforentervehicle();
  }

  if(isalive(rider)) {
    self.runningtovehicle = arrayremove(self.runningtovehicle, rider);
    rider notify("enteredvehicle");
    rider notify("loaded");
    self notify("guy_entered", rider, pos);

    if(isDefined(anim_pos.rider_func)) {
      rider[[anim_pos.rider_func]]();
    }
  }
}

function function_8ff9c3181d3164de(var_44394fd28e66ed9b) {
  if(!vehicle_interact::can_use(self)) {
    vehicle_interact::allow_use(self, 1);
  }

  vehicle_occupancy::set_team(self, "neutral");
  vehicle_occupancy::update_occupancy(self);

  if(var_44394fd28e66ed9b) {
    thread vehicle_spawn::function_dbc69ecc19a5dca3();
  } else {
    vehicle_occupancy::function_d96c2b596c63c80e();
  }

  thread vehicle_spawn::watch_abandoned();
}

function has_riders() {
  if(!(isDefined(self) && isDefined(self.riders))) {
    return false;
  }

  foreach(rider in self.riders) {
    if(isalive(rider)) {
      return true;
    }
  }

  return false;
}

function function_22c7e9c2186e23fe(ref) {
  if(!vehicle::has_data(ref)) {
    return undefined;
  }

  aiseats = vehicle::get_data(ref).aiseats;

  if(!isDefined(aiseats)) {
    return;
  }

  positions = [];

  foreach(index, seat in aiseats) {
    if(seat.setuprope) {
      positions[positions.size] = index;
    }
  }

  if(positions.size > 0) {
    return positions;
  }
}

function function_b171195b98497124(vehicle, seatindex) {
  ref = vehicle vehicle::get_ref();

  if(!vehicle::has_data(ref)) {
    return undefined;
  }

  aiseats = vehicle::get_data(ref).aiseats;

  if(!isDefined(aiseats)) {
    return undefined;
  }

  if(!isDefined(seatindex)) {
    return undefined;
  }

  return aiseats[seatindex].playerseatref;
}

function function_a0de630828deae7e(vehicle, seatid) {
  if(!isDefined(vehicle.riders)) {
    return undefined;
  }

  ref = vehicle vehicle::get_ref();

  if(!vehicle::has_data(ref)) {
    return undefined;
  }

  aiseats = vehicle::get_data(ref).aiseats;

  if(!isDefined(aiseats)) {
    return undefined;
  }

  foreach(agent in vehicle.riders) {
    if(aiseats[agent.vehicle_position].playerseatref == seatid) {
      return agent;
    }
  }
}

function is_loaded() {
  return self.riders.size > 0;
}

function is_unloading() {
  return istrue(self.unloading);
}

function is_loading() {
  return istrue(self.loading);
}

function unload(var_fd73840b5474c1dd, exittype, unloadgroup) {
  self endon("death");

  if(!is_loaded()) {
    return;
  }

  if(is_unloading()) {
    return;
  }

  self.unloading = 1;
  riders = self.riders;
  function_bb1331c371ffbd55(riders);
  function_8f7122f5d1124cae(1, exittype, unloadgroup);
}

function private function_d83622d750c42d31(var_fd73840b5474c1dd) {
  self endon("death");
  stop_moving(var_fd73840b5474c1dd);

  if(self.aidriver && isalive(self.aidriver)) {
    self.unload_group = "driver";
    self.riders[0].vehicle_position = 0;
    vehicle_code::_vehicle_unload("driver");
  }

  self waittill("unloaded");
  self.aidriver = undefined;
}

function stop_moving(var_fd73840b5474c1dd) {
  if(self hascomponent("path")) {
    self stoppath();

    if(var_fd73840b5474c1dd) {
      self removecomponent("path");
    }
  }

  self setconfigvalue("p2p", "manualSpeed", 0);
  self setconfigvalue("p2p", "brakeAtGoal", 1);
  self setconfigvalue("p2p", "goalPoint", self.origin);
  self vehicle_setspeedimmediate(0, 1, 1);
  self vehicle_cleardrivingstate();

  if(var_fd73840b5474c1dd) {
    thread function_fd02ac81423e6532();
  }
}

function get_unload_group(unloadgroup) {
  if(vehicle::ishelicopter()) {
    return (unloadgroup ?? "default");
  }

  return unloadgroup ?? level.gamemodebundle.defaultunloadgroup ?? "default";
}

function function_8f7122f5d1124cae(var_fd73840b5474c1dd, exittype, unloadgroup) {
  self endon("death");

  if(!isDefined(var_fd73840b5474c1dd)) {
    var_fd73840b5474c1dd = level.gamemodebundle.var_a6234436bb66db37 ?? 1;
  }

  unloadgroup = get_unload_group(unloadgroup);

  if(unloadgroup != "moving") {
    stop_moving(var_fd73840b5474c1dd);
  }

  riders = self.riders;
  utility::ent_flag_clear("unloaded");
  utility::ent_flag_clear("loaded");
  waitframe();
  childthread function_52baa3db61f989e8();

  if(!vehicle_damage::function_b06b0d26ac291477()) {
    foreach(rider in self.riders) {
      if(!vehicle_aianim::check_unloadgroup(rider.vehicle_position, unloadgroup)) {
        continue;
      }

      if(rider.stealth_enabled && exittype == "combat" || exittype == "combat_run") {
        rider.stealth_idledemeanor = "combat";
        rider.var_b52fca22f7f1e144 = "combat";
      }

      if(!(isDefined(rider._blackboard.var_25799974c1f2939b) && isDefined(rider._blackboard.chosenvehicleanimpos_sittag) && isDefined(rider._blackboard) && isDefined(rider.asmname) && isDefined(rider) && isDefined(rider._blackboard.currentvehicleanimalias))) {
        continue;
      }

      animindex = archetypegetrandomalias(rider._blackboard.currentvehicleanimalias, "get_out_vehicle_combat", rider._blackboard.chosenvehicleanimpos_seatalias, 0);

      if(!isDefined(animindex)) {
        continue;
      }

      xanim = animsetgetanimfromindex(rider._blackboard.currentvehicleanimalias, "get_out_vehicle_combat", animindex);

      if(!isDefined(xanim)) {
        continue;
      }

      targetorigin = rider getvehicleanimtargetorigin(self, xanim, rider._blackboard.chosenvehicleanimpos_sittag, self.origin, self.angles, 1);

      if(distance2dsquared(targetorigin, getclosestpointonnavmesh(targetorigin)) > 6400) {
        rider.skipdeathcount = 1;
        rider kill();
      }
    }
  }

  driver_unloading = vehicle_aianim::check_unloadgroup(0, unloadgroup);
  var_44394fd28e66ed9b = 0;

  if(unloadgroup == "moving") {
    driver_unloading = 1;
    utility::delaythread(2, &function_d83622d750c42d31, var_fd73840b5474c1dd);
  }

  vehicle_code::_vehicle_unload(unloadgroup);

  if(vehicle_aianim::riders_unloadable(unloadgroup)) {
    self waittill("unloaded");
  }

  if(driver_unloading) {
    var_44394fd28e66ed9b = isagent(self.aidriver) ? self.aidriver isincombat() : 0;
  }

  utility::self_func("vehicleClearAnims");

  foreach(rider in riders) {
    if(!rider || !isalive(rider)) {
      continue;
    }

    rider.vehicle_position = undefined;
    rider.script_startingposition = undefined;

    if(rider.spawner) {
      rider.spawner.script_startingposition = undefined;
    }
  }

  if(driver_unloading) {
    function_8ff9c3181d3164de(var_44394fd28e66ed9b);
  }

  self.var_af753e654dc7fe6c = gettime();
  self.unloading = undefined;
}

function private function_fb73b92ecd652540(rider) {
  if(!isDefined(rider)) {
    println("<dev string:x1f8>");
  } else if(!isDefined(rider._blackboard)) {
    println("<dev string:x24e>");
  }

  if(isDefined(rider) && isDefined(rider.origin)) {
    println("<dev string:x2b7>" + rider.origin);
  }

  if(isDefined(rider)) {
    category = rider.category;
    subcategory = rider.subcategory;
    println("<dev string:x2e8>" + (category ?? "<dev string:x31a>") + "<dev string:x327>" + (subcategory ?? "<dev string:x31a>"));
  }
}

function handle_rider_death(rider, pos, seat_id) {
  self endon("death");
  self endon("cancel_load");
  entnum = rider getentitynumber();
  rider utility::waittill_any("death", "exited_vehicle");

  if(!isDefined(self)) {
    return;
  }

  if(isalive(rider)) {
    return;
  }

  self.riders = arrayremove(self.riders, rider);
  self.usedpositions[pos] = 0;
  vehicle_occupancy::update_occupancy(self);

  if(!isactor(rider) || !seat_id) {
    return;
  }

  vehicle_occupancy::function_7730eb57fd31aeea(rider, self, seat_id, 1);

  while(rider && !isactorcorpse(rider)) {
    waitframe();
  }

  corpse = getentbynum(entnum);

  if(isactorcorpse(corpse)) {
    vehicle_occupancy::function_7730eb57fd31aeea(corpse, self, seat_id, 1);
  }
}

function function_c40dc2214ed65c47() {
  self notify("b13e13644e6515b");
  self endon("b13e13644e6515b");
  self endon("unloaded");
  self waittill("death");
  thread kill_riders();
}

function function_e848c7917f1d317f(vehicle) {
  self notify("ea94ca7f883b708f");
  self endon("ea94ca7f883b708f");
  vehicle endon("unloaded");
  vehicle endon("death");
  vehicle endon("cancel_load");
  self waittill("death");

  if(isalive(vehicle) && isDefined(vehicle.var_ad452e0ccaa3b809)) {
    vehicle thread[[vehicle.var_ad452e0ccaa3b809]]();
    return;
  }

  if(vehicle.isheli) {
    if(vehicle.var_5b7f931693e7743f) {
      vehicle thread vehicle::function_767d9021690bb2f3();
    } else {
      wait 1.5;
      vehicle thread vehicle::explode(undefined, 1);
    }

    return;
  }

  if(vehicle.unloadondriverdeath) {
    vehicle thread unload(undefined, "combat", "moving");
  }
}

function function_bab770ab3241c7c9(vehicle, turret) {
  vehicle endon("death");
  utility::waittill_any("death", "unload");

  if(turret == vehicle) {
    vehicle.gunner = undefined;
    return;
  }

  turret vehicle_occupancy::reset_turret();
}

function function_bb1331c371ffbd55(riders) {
  foreach(rider in riders) {
    if(isDefined(rider.og_nocorpse)) {
      rider.nocorpse = rider.og_nocorpse;
    } else {
      rider.nocorpse = undefined;
    }

    if(isDefined(rider.og_dropweapon)) {
      rider.dropweapon = rider.og_dropweapon;
    }

    if(isDefined(rider.var_6613071a5bd473f1)) {
      rider.dontdroploot = rider.var_6613071a5bd473f1;
    }

    if(isDefined(rider.var_e0810b143e10d30)) {
      rider.var_72d3e6c0dbcd1998 = rider.var_e0810b143e10d30;
    }

    rider allowvehiclepredictiveragdoll(1);
  }
}

function is_driver_dead() {
  return isDefined(self.aidriver) && isDefined(self) && isDefined(self.aidriver.health) && self.aidriver.health < 1;
}

function function_2f06fac2aaf75236(idamage, smeansofdeath, sweapon, partname, damageloc) {
  if(isDefined(self._blackboard.currentvehicle)) {
    if(isDefined(self._blackboard.currentvehicle.healthbuffer)) {
      if(self._blackboard.currentvehicle.health - idamage < self._blackboard.currentvehicle.healthbuffer) {
        return true;
      }
    }
  }

  if(isexplosivedamagemod(smeansofdeath)) {
    return false;
  }

  return true;
}

function private getvehicleanimtargetorigin(vehicle, vehicleanim, vehicletag, vehiclelocation, vehicleangles, animendfrac) {
  tagorigin = vehicle gettagorigin(vehicletag);
  tagangles = vehicle gettagangles(vehicletag);
  startorigin = getstartorigin(tagorigin, tagangles, vehicleanim);
  startangles = getstartangles(tagorigin, tagangles, vehicleanim);
  movedelta = getmovedelta(vehicleanim, 0, animendfrac);
  return rotatevector(movedelta, startangles) + startorigin;
}

function private function_52baa3db61f989e8() {
  while(self vehicle_getspeed() > 0) {
    waitframe();
  }

  self vehphys_parkingbrake(1);
}

function function_76fa954d53fa1435(bool = 1) {
  assert(vehicle::is_vehicle());
  assert(self vehicle_isphysveh());

  if(bool) {
    if(!isDefined(self.parkingbrake)) {
      self.parkingbrake = 0;
    }

    self.parkingbrake += 1;

    if(self.parkingbrake == 1) {
      self vehphys_parkingbrake(1);
    }

    return;
  }

  if(!isDefined(self.parkingbrake)) {
    assertmsg(isDefined(self.parkingbrake), "<dev string:x33d>");
    return;
  }

  self.parkingbrake -= 1;

  if(self.parkingbrake <= 0) {
    self.parkingbrake = undefined;
    self vehphys_parkingbrake(0);
  }
}

function private function_fd02ac81423e6532() {
  self notify("ad907e5efaaab28c");
  self endon("ad907e5efaaab28c");
  self endon("death");
  function_21e8e13eca0023cd();
  self removecomponent("p2p");
}

function private function_21e8e13eca0023cd() {
  self endon("vehicle_owner_update");

  while(self vehicle_getspeed() > 0) {
    waitframe();
  }
}

function function_8ca4f672db257850(riders) {
  foreach(rider in riders) {
    if(isDefined(rider.dropweapon)) {
      rider.og_dropweapon = rider.dropweapon;
    }

    rider.dropweapon = 0;

    if(isDefined(rider.dontdroploot)) {
      rider.var_6613071a5bd473f1 = rider.dontdroploot;
    }

    rider.dontdroploot = 1;

    if(isDefined(rider.var_72d3e6c0dbcd1998)) {
      rider.var_bcc9f8d847f02a59 = rider.var_72d3e6c0dbcd1998;
    }

    rider.var_72d3e6c0dbcd1998 = undefined;
    rider allowvehiclepredictiveragdoll(0);
  }
}

function kill_riders() {
  if(self.pilot_killed && !is_unloading()) {
    self waittill("flavor_done");
  }

  foreach(rider in self.riders) {
    if(!isalive(rider)) {
      continue;
    }

    if(!isDefined(rider.ridingvehicle)) {
      continue;
    }

    if(isDefined(rider.magic_bullet_shield)) {
      rider ai::stop_magic_bullet_shield();
    }

    if(isDefined(rider._blackboard) && isDefined(rider._blackboard.chosenvehicleanimpos) && istrue(rider._blackboard.chosenvehicleanimpos_deathimpulse)) {
      var_b6c01c45c70ed011 = 100;
      velocity = self vehicle_getvelocity();
      rider.do_immediate_ragdoll = 1;
      rider.ragdollhitloc = "torso_lower";
      rider.ragdollimpactvector = (rider.origin - self.origin) * var_b6c01c45c70ed011 + velocity;
    }

    rider kill();
  }
}

function function_9b3723ecd75f11e5(spawnhusk, damagedata) {
  var_2f7d098653e1480d = spawnhusk && istrue(level.var_c533d12f2be6403) && !istrue(self.var_d683648f8c548dc);

  if(isDefined(self.riders)) {
    foreach(rider in self.riders) {
      if(isDefined(damagedata) && isDefined(damagedata.attacker) && isPlayer(damagedata.attacker)) {
        rider.vehiclekiller = damagedata.attacker;
        damagedata.attacker thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc(#"kill", damagedata.objweapon, undefined, undefined, rider, undefined, undefined, 1, undefined, 1);
      }

      if(isDefined(rider) && var_2f7d098653e1480d) {
        rider.shouldburnfromdamage = 1;
        rider dodamage(rider.health, rider.origin, damagedata.attacker ?? self.burndownattacker, damagedata.inflictor, "MOD_FIRE", damagedata.objweapon, "torso_upper");
      }
    }
  }

  if(!var_2f7d098653e1480d) {
    delete_riders();
  }
}

function delete_riders() {
  if(isDefined(self.riders)) {
    foreach(rider in self.riders) {
      if(isDefined(rider)) {
        if(isDefined(rider.magic_bullet_shield)) {
          rider ai::stop_magic_bullet_shield();
        }

        if(!utility::issp() && isai(rider)) {
          if(!isalive(rider)) {
            if(utility::issharedfuncdefined(#"ai", #"getcorpseentity")) {
              body = rider utility::callsharedfunc(#"ai", #"getcorpseentity");

              if(isDefined(body) && !isint(body)) {
                body delete();
              }
            }
          } else {
            rider.var_70fbc1727d54c322 = 1;
            rider.diequietly = 1;
            rider.nocorpse = 1;
            rider kill();
          }

          continue;
        }

        if(level.var_caec56ac747c5a55) {
          rider kill();
          continue;
        }

        rider thread function_f5062356354a31c3();
      }
    }
  }
}

function private function_f5062356354a31c3() {
  self notify("f2a90f16ba6b9e36");
  self endon("f2a90f16ba6b9e36");
  waitframe();

  if(isent(self)) {
    self delete();
  }
}

function function_b8676d1cc4fc666e() {
  if(self.follow_slots) {
    return;
  }

  if(!isDefined(self.followers)) {
    self.followers = [];
  }

  if(!isDefined(self.follow_slots)) {
    self.follow_slots = [];
  }

  foreach(index, item in self.follow_slots_info) {
    org = isDefined(item.tag) ? self gettagorigin(item.tag) : self.origin;
    ang = isDefined(item.tag) ? self gettagangles(item.tag) : self.angles;
    spawn_loc = org + anglesToForward(ang) * item.forward_offset + anglestoright(ang) * item.right_offset;

    if(isDefined(item.up_offset)) {
      spawn_loc += (0, 0, item.up_offset);
    }

    follow_ent = utility::spawn_script_origin(spawn_loc, ang);
    follow_ent linkTo(self);
    self.follow_slots[index] = follow_ent;
  }

  thread function_f75c19ede6756cd();

  thread function_57ef74b2cdde50ff();
}

function function_2d3594432e29a48e(slot_name, tag, forward_offset, right_offset, up_offset) {
  if(!isDefined(self.follow_slots_info)) {
    self.follow_slots_info = [];
  }

  self.follow_slots_info[slot_name] = spawnStruct();
  self.follow_slots_info[slot_name].tag = tag;
  self.follow_slots_info[slot_name].forward_offset = forward_offset ?? 0;
  self.follow_slots_info[slot_name].right_offset = right_offset ?? 0;
  self.follow_slots_info[slot_name].up_offset = up_offset;
}

function function_f75c19ede6756cd() {
  self notify("90f4175807973915");
  self endon("90f4175807973915");
  utility::waittill_any("death", "stop_all_following");

  if(self.followers.size) {
    guys = function_5713d46873b29625(self.followers);

    foreach(guy in guys) {
      guy stop_following_vehicle();
    }
  }

  if(self.follow_slots) {
    self.follow_slots = function_5713d46873b29625(self.follow_slots);

    foreach(ent in self.follow_slots) {
      ent delete();
    }
  }
}

function ai_follow_vehicle(vehicle, position, var_8df680064a563eab = 130, var_668d9282d70b2701 = 200) {
  if(!vehicle.follow_slots) {
    return;
  }

  if(position) {
    assert(isDefined(vehicle.follow_slots[position]), "<dev string:x38c>" + position);
    assert(!isalive(vehicle.follow_slots[position].ai), "<dev string:x3af>" + position);
  }

  foreach(slotindex, slot in vehicle.follow_slots) {
    if(position && slotindex != position) {
      continue;
    }

    if(!slot.ai || !isalive(slot.ai)) {
      slot.ai = self;
      self.following_ent = slot;
      break;
    }
  }

  if(!self.following_ent) {
    iprintln("<dev string:x3d4>");

    return;
  }

  childthread function_51a2d8636e3a937d(var_8df680064a563eab, var_668d9282d70b2701);
}

function function_51a2d8636e3a937d(var_8df680064a563eab, var_668d9282d70b2701) {
  self notify("d134505e4b9c1aae");
  self endon("d134505e4b9c1aae");
  self endon("death", "stop_following_vehicle");
  vehicle = self.following_ent getlinkedparent();

  if(isDefined(self getgoalvolume())) {
    self cleargoalvolume();
  }

  self.goalradius = 10;
  self.disablearrivals = 1;
  self.disableexits = 1;
  self setgoalentity(self.following_ent, 1);
  maxspeedextra = 15;

  for(;;) {
    speed = utility::mph_to_ips(abs(vehicle vehicle_getspeed()));

    if(speed > var_668d9282d70b2701) {} else {
      aispeed = clamp(speed, 23, 250);

      if(aispeed < 250) {
        dist = int(distance2d(self.origin, self.following_ent.origin));

        if(dist > var_8df680064a563eab && speed < 5) {
          speed = 250;
        }

        maxspeedextra = 250 - aispeed;
        dist_normalized = math::normalize_value(150, 300, dist);
        speedextra = math::factor_value(6, maxspeedextra, dist_normalized);
      }

      utility::set_movement_speed(aispeed + int(speedextra));
    }

    wait 0.15;
  }
}

function stop_following_vehicle() {
  if(!isalive(self)) {
    return;
  }

  self notify("stop_following_vehicle");
  self.following_ent.ai = undefined;
  self.following_ent = undefined;
  self.disablearrivals = 0;
  self.disableexits = 0;
  self cleargoalentity();
  utility::clear_movement_speed();
}

function stop_all_following_vehicle() {
  guys = utility::array_removedead_or_dying(function_261bcf1cf86edc50());

  foreach(guy in guys) {
    guy stop_following_vehicle();
  }

  self notify("stop_all_following");
}

function kill_followers() {
  remove_followers(1);
}

function remove_followers(bkill = 0) {
  guys = utility::array_removedead_or_dying(function_261bcf1cf86edc50());

  foreach(guy in guys) {
    if(guy.magic_bullet_shield) {
      guy ai::stop_magic_bullet_shield();
    }

    if(bkill) {
      guy kill((0, 0, 0));
      continue;
    }

    guy delete();
  }
}

function function_261bcf1cf86edc50() {
  if(!self.follow_slots) {
    return;
  }

  guys = [];

  foreach(slot in self.follow_slots) {
    if(slot.ai && isalive(slot.ai)) {
      guys[guys.size] = slot.ai;
    }
  }

  return guys;
}

function function_57ef74b2cdde50ff() {
  self endon("<dev string:x3f6>");
  self endon("<dev string:x3ff>");

  while(true) {
    if(getdvarint(@ "hash_2a67f2406b1d6460") == 1) {
      foreach(slot in self.follow_slots) {
        item_color = isDefined(slot.ai) ? (0, 1, 0) : (1, 0, 0);
        line(self.origin, slot.origin, (1, 1, 0));
        orientedbox(slot.origin, (8, 8, 8), slot.angles, item_color);

        if(isDefined(slot.ai)) {
          line(slot.ai.origin, slot.origin, item_color);
        }
      }
    }

    waitframe();
  }
}

# /