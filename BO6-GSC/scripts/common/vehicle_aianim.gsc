/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\vehicle_aianim.gsc
*********************************************/

#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\notetrack;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_ai;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_paths;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\vehicle\vehicle_common;
#namespace vehicle_aianim;

function guy_enter(guy, var_12adb1f13b90f22f, var_a5a3e93973f5d241 = 1) {
  guy endon("death_or_disconnect");
  assert(!isspawner(self), "<dev string:x24>");
  assert(!isDefined(guy.ridingvehicle), "<dev string:x4a>");

  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  if(!isDefined(self.vehicletype)) {
    return;
  }

  classname = vehicle_code::get_vehicle_classname();
  vehicleanim = level.vehicle.templates.aianims[classname];
  pos = set_pos(guy, vehicleanim);

  if(!isDefined(pos)) {
    return;
  }

  if(pos == 0) {
    guy.drivingvehicle = 1;
  }

  animpos = anim_pos(self, pos);
  self.usedpositions[pos] = 1;
  guy.vehicle_position = pos;
  guy.vehicle_idling = 0;
  guy.ridingvehicle = self;
  guy.orghealth = guy.health;
  guy.vehicle_idle = animpos.idle;
  guy.vehicle_standattack = animpos.standattack;
  guy.standing = 0;
  guy.allowdeath = 1;

  if(!isDefined(guy.magic_bullet_shield) && vehicle_allows_rider_death()) {
    guy.allowdeath = !isDefined(guy.script_allowdeath) || guy.script_allowdeath;
  }

  if(!isDefined(guy.classname)) {
    return;
  }

  if(guy.classname == "script_model") {
    if(isDefined(animpos.death) && guy.allowdeath && (!isDefined(guy.script_allowdeath) || guy.script_allowdeath)) {
      thread guy_death(guy, animpos);
    }
  }

  self.riders[self.riders.size] = guy;
  vehicle_occupancy::update_occupancy(self);

  if(guy.classname != "script_model" && ai::spawn_failed(guy)) {
    return;
  }

  org = self gettagorigin(animpos.sittag);
  angles = self gettagangles(animpos.sittag);

  if(guy.classname != "script_model" && !guy vehicle_common::hasvehicle()) {
    chosenpos = vehicle_getinstart(pos);
    guy vehicle_common::entervehicle(self, var_a5a3e93973f5d241, chosenpos, animpos);
  }

  if(isai(guy)) {
    if(var_a5a3e93973f5d241) {
      guy forceteleport(org, angles);
    }

    if(isDefined(animpos.bhasgunwhileriding) && !animpos.bhasgunwhileriding) {
      guy ai::gun_remove();
    }

    if(guy_should_man_turret(animpos)) {
      thread guy_man_turret(guy, pos, var_12adb1f13b90f22f);
    }
  } else {
    if(isDefined(animpos.bhasgunwhileriding) && !animpos.bhasgunwhileriding) {
      detach_models_with_substr(guy, "weapon_");
    }

    guy.origin = org;
    guy.angles = angles;
  }

  if(pos == 0) {
    self.driver = guy;
    thread driverdead(guy);
  }

  self notify("guy_entered", guy, pos);
  guy notify("loaded");
  utility::ent_flag_clear("unloaded");
  thread guy_handle(guy, pos);

  if(isDefined(animpos.rider_func)) {
    guy[[animpos.rider_func]]();
    return;
  }
}

function vehicle_allows_driver_death() {
  if(!isDefined(self.script_allow_driver_death)) {
    return 0;
  }

  return self.script_allow_driver_death;
}

function vehicle_allows_rider_death() {
  if(!isDefined(self.script_allow_rider_deaths)) {
    return 1;
  }

  return self.script_allow_rider_deaths;
}

function guy_should_man_turret(animpos) {
  if(!isDefined(animpos.mgturret)) {
    return false;
  }

  if(!isDefined(self.script_nomg)) {
    return true;
  }

  return !self.script_nomg;
}

function handle_attached_guys() {
  classname = vehicle_code::get_vehicle_classname();
  self.attachedguys = [];

  if(!(isDefined(level.vehicle.templates.aianims) && isDefined(level.vehicle.templates.aianims[classname]))) {
    return;
  }

  maxpos = level.vehicle.templates.aianims[classname].size;

  if(self.script_noteworthy == "ai_wait_go") {
    thread ai_wait_go();
  }

  self.runningtovehicle = [];
  self.usedpositions = [];
  self.var_2c1b14ee4b7cd97c = [];
  self.getinorgs = [];
  self.delayer = 0;
  vehicleanim = level.vehicle.templates.aianims[classname];

  for(i = 0; i < maxpos; i++) {
    self.usedpositions[i] = 0;
    self.var_2c1b14ee4b7cd97c[i] = 0;

    if(isDefined(self.script_nomg) && self.script_nomg && isDefined(vehicleanim[i].bisgunner) && vehicleanim[i].bisgunner) {
      self.usedpositions[i] = 1;
    }
  }
}

function load_ai_goddriver(array) {
  load_ai(array, 1);
}

function guy_death(guy, animpos) {
  waittillframeend();
  assert(!isai(guy));
  guy setCanDamage(1);
  guy endon("death");
  guy.allowdeath = 0;
  guy.health = 10150;

  if(isDefined(guy.script_startinghealth)) {
    guy.health += guy.script_startinghealth;
  }

  guy endon("jumping_out");

  if(isDefined(guy.magic_bullet_shield) && guy.magic_bullet_shield) {
    while(isDefined(guy.magic_bullet_shield) && guy.magic_bullet_shield) {
      wait 0.05;
    }
  }

  while(guy.health > 10000) {
    guy waittill("damage");
  }

  thread guy_deathimate_me(guy, animpos);
}

function guy_deathimate_me(guy, animpos) {
  guy = convert_guy_to_drone(guy);
  detach_models_with_substr(guy, "weapon_");
  guy linkTo(self);
  guy notsolid();
  guy setanim(animpos.death);

  if(isai(guy)) {
    guy utility::script_func("anim_dropallaiweapons");
  } else {
    detach_models_with_substr(guy, "weapon_");
  }

  if(isDefined(animpos.death_delayed_ragdoll)) {
    guy unlink();

    if(isDefined(guy.fnpreragdoll)) {
      guy[[guy.fnpreragdoll]]();
    }

    guy startragdoll();
    wait animpos.death_delayed_ragdoll;
    guy delete();
    return;
  }
}

function load_ai(array, bgoddriver, group, spawninvehicle) {
  self endon("death");
  assert(self.code_classname == "<dev string:x79>");

  if(array.size) {
    if(!isDefined(bgoddriver)) {
      bgoddriver = 0;
    }

    utility::ent_flag_clear("unloaded");
    utility::ent_flag_clear("loaded");
    utility::array_levelthread(array, &get_in_vehicle, bgoddriver, group, spawninvehicle);
    utility::array_wait(array, "loaded");
  }

  utility::ent_flag_set("loaded");
}

function is_rider(guy) {
  for(i = 0; i < self.riders.size; i++) {
    if(self.riders[i] == guy) {
      return true;
    }
  }

  return false;
}

function get_in_vehicle(guy, bgoddriver, group, spawninvehicle) {
  if(is_rider(guy)) {
    return;
  }

  if(!handle_detached_guys_check()) {
    return;
  }

  assert(isalive(guy), "<dev string:x8b>");
  guy_runtovehicle(guy, self, bgoddriver, group, spawninvehicle);
}

function handle_detached_guys_check() {
  if(vehicle_hasavailablespots()) {
    return 1;
  }

  if(!utility::issp()) {
    classname = self.classname_mp;
  } else {
    classname = self.class;
  }

  assertmsg("<dev string:xe8>" + level.vehicle.templates.aianims[classname].size + "<dev string:x118>");
}

function vehicle_hasavailablespots() {
  if(level.vehicle.templates.aianims[vehicle_code::get_vehicle_classname()].size - self.runningtovehicle.size) {
    return 1;
  }

  return 0;
}

function private guy_runtovehicle_loaded(guy, vehicle) {
  vehicle endon("death");
  vehicle endon("stop_loading");

  if(!guy vehicle_common::waitforentervehicle() && isDefined(guy.forced_startingposition)) {
    vehicle.usedpositions[guy.forced_startingposition] = 0;
  }

  vehicle.runningtovehicle = arrayremove(vehicle.runningtovehicle, guy);
  vehicle_loaded_if_full(vehicle);
}

function vehicle_loaded_if_full(vehicle) {
  if(isDefined(vehicle.vehicletype) && isDefined(vehicle.vehicle_loaded_notify_size)) {
    if(vehicle.riders.size == vehicle.vehicle_loaded_notify_size) {
      vehicle utility::ent_flag_set("loaded");
    }

    return;
  }

  if(!vehicle.runningtovehicle.size && vehicle.riders.size) {
    if(vehicle.usedpositions[0]) {
      vehicle utility::ent_flag_set("loaded");
    }
  }
}

function remove_magic_bullet_shield_from_guy_on_unload_or_death(guy) {
  utility::waittill_any("unload", "death");
  guy ai::stop_magic_bullet_shield();
}

function choose_vehicle_position(guy, vehiclepositions, bgoddriver) {
  guy endon("stop_loading");
  self endon("stop_loading");

  if(!isDefined(bgoddriver)) {
    bgoddriver = 0;
  }

  chosenorg = undefined;
  origin = 0;

  if(isDefined(guy.script_startingposition)) {
    chosenorg = vehicle_getinstart(guy.script_startingposition);
  } else if(!self.usedpositions[0]) {
    chosenorg = vehicle_getinstart(0);

    if(bgoddriver) {
      assert(!isDefined(guy.magic_bullet_shield), "<dev string:x11e>");
      guy thread ai::magic_bullet_shield();
      thread remove_magic_bullet_shield_from_guy_on_unload_or_death(guy);
    }
  } else if(vehiclepositions.availablepositions.size) {
    chosenorg = function_47c86977a18df38b(vehiclepositions.availablepositions, guy.origin);
  } else {
    chosenorg = undefined;
  }

  return chosenorg;
}

function guy_runtovehicle(guy, vehicle, bgoddriver = 0, group, spawninvehicle = 0) {
  guy endon("stop_loading");
  vehicle endon("stop_loading");
  var_12adb1f13b90f22f = 1;
  vehicleanim = level.vehicle.templates.aianims[vehicle vehicle_code::get_vehicle_classname()];

  if(isDefined(vehicle.runtovehicleoverride)) {
    vehicle thread[[vehicle.runtovehicleoverride]](guy);
    return;
  }

  vehicle endon("death");
  guy endon("death");
  vehicle.runningtovehicle[vehicle.runningtovehicle.size] = guy;
  thread guy_runtovehicle_loaded(guy, vehicle);
  availablepositions = [];
  chosenorg = undefined;
  origin = 0;

  if(!isDefined(guy.get_in_moving_vehicle)) {
    while(vehicle vehicle_getspeed() > 1) {
      wait 0.05;
    }
  }

  positions = vehicle get_availablepositions(group);

  if(!positions.availablepositions.size && positions.nonanimatedpositions.size) {
    guy notify("enteredvehicle");
    vehicle guy_enter(guy, var_12adb1f13b90f22f);
    return;
  }

  chosenorg = choose_vehicle_position(guy, positions, bgoddriver);

  if(!isDefined(chosenorg)) {
    return;
  }

  origin = chosenorg.origin;
  angles = chosenorg.angles;
  guy.forced_startingposition = chosenorg.vehicle_position;
  vehicle.usedpositions[chosenorg.vehicle_position] = 1;

  if(spawninvehicle) {
    guy notify("enteredvehicle");
    vehicle guy_enter(guy, var_12adb1f13b90f22f);
    return;
  }

  guy vehicle_common::requestentervehicle(self, 0, chosenorg, anim_pos(self, chosenorg.vehicle_position));
  guy vehicle_common::waitforarrivedatvehicle();
  animpos = anim_pos(vehicle, chosenorg.vehicle_position);
  guy.allowdeath = 0;
  animpos = vehicleanim[chosenorg.vehicle_position];

  if(isDefined(chosenorg)) {
    if(isDefined(animpos.vehicle_getinanim_combat) && (guy isincombat() || !guy.stealth_enabled)) {
      var_d9b19809c3f0f869 = isDefined(guy.no_vehicle_getoutanim);

      if(!var_d9b19809c3f0f869 && !isagent(guy)) {
        if(isDefined(animpos.vehicle_getoutanim)) {
          vehicle clearanim(animpos.vehicle_getoutanim, 0);
        }

        if(isDefined(animpos.vehicle_getoutanim_combat)) {
          vehicle clearanim(animpos.vehicle_getoutanim_combat, 0);
        }

        if(isDefined(animpos.vehicle_getoutanim_combat_run)) {
          vehicle clearanim(animpos.vehicle_getoutanim_combat_run, 0);
        }
      }

      vehicle = vehicle getanimatemodel();
      vehicle thread setanimrestart_once(animpos.vehicle_getinanim_combat, animpos.vehicle_getinanim_clear);
      vehicle thread notetrack::start_notetrack_wait(vehicle, "vehicle_anim_flag", undefined, undefined, animpos.vehicle_getinanim_combat);
    } else if(isDefined(animpos.vehicle_getinanim)) {
      var_d9b19809c3f0f869 = isDefined(guy.no_vehicle_getoutanim);

      if(!var_d9b19809c3f0f869 && !isagent(guy)) {
        if(isDefined(animpos.vehicle_getoutanim)) {
          vehicle clearanim(animpos.vehicle_getoutanim, 0);
        }

        if(isDefined(animpos.vehicle_getoutanim_combat)) {
          vehicle clearanim(animpos.vehicle_getoutanim_combat, 0);
        }

        if(isDefined(animpos.vehicle_getoutanim_combat_run)) {
          vehicle clearanim(animpos.vehicle_getoutanim_combat_run, 0);
        }
      }

      vehicle = vehicle getanimatemodel();
      vehicle thread setanimrestart_once(animpos.vehicle_getinanim, animpos.vehicle_getinanim_clear);
      vehicle thread notetrack::start_notetrack_wait(vehicle, "vehicle_anim_flag", undefined, undefined, animpos.vehicle_getinanim);
    }
  }

  if(isDefined(animpos.vehicle_getinsoundtag)) {
    origin = vehicle gettagorigin(animpos.vehicle_getinsoundtag);
  } else {
    origin = vehicle.origin;
  }

  if(isDefined(animpos.vehicle_getinsound)) {
    playsoundatpos(origin, animpos.vehicle_getinsound);
  }

  getintags = undefined;
  getinthreads = undefined;

  if(isDefined(animpos.getin_enteredvehicletrack)) {
    getintags = [];
    getintags[0] = animpos.getin_enteredvehicletrack;
    getinthreads = [];
    getinthreads[0] = &entered_vehicle_notify;
    vehicle link_to_sittag(guy, animpos.sittag, animpos.sittag_origin_offset, animpos.sittag_angles_offset, animpos.linktoblend);
  }

  guy vehicle_common::waitforentervehicle();
  guy notify("enteredvehicle");
  vehicle guy_enter(guy, var_12adb1f13b90f22f);
}

function entered_vehicle_notify() {
  self notify("enteredvehicle");
}

function driverdead(guy) {
  if(vehicle::ishelicopter()) {
    return;
  }

  self.driver = guy;
  self endon("death");
  guy endon("jumping_out");
  guy waittill("death");

  if(getdvarint(@ "hash_bd29c0db2cf41967", 0) == 1) {
    return;
  }

  if(isDefined(self.vehicle_keeps_going_after_driver_dies)) {
    return;
  }

  self notify("driver dead");
  self.deaddriver = 1;

  if(isDefined(self.hasstarted) && self.hasstarted) {
    vehicle_paths::_vehicle_stop_named("driver_dead", 20, 20);

    while(self vehicle_getspeed() > 0) {
      wait 0.15;
    }
  }

  if(!self.donotunloadondriverdeath) {
    vehicle::vehicle_unload();
  }
}

function guy_becomes_real_ai(guy, pos) {
  if(isai(guy)) {
    return guy;
  }

  if(guy.drone_delete_on_unload) {
    guy delete();
    return;
  }

  guy = utility::script_func("spawner_makerealai", guy);

  if(utility::issp()) {
    classname = self.classname;
  } else {
    classname = self.classname_mp;
  }

  maxpos = level.vehicle.templates.aianims[classname].size;
  animpos = anim_pos(self, pos);
  link_to_sittag(guy, animpos.sittag, animpos.sittag_origin_offset, animpos.sittag_angles_offset, animpos.linktoblend);
  guy.vehicle_idle = animpos.idle;

  if(!guy.disable_vehicle_idle) {
    thread guy_idle(guy, pos);
  }

  return guy;
}

function link_to_sittag(guy, tag, origin_offset, angles_offset, linktoblend) {
  if(!isDefined(origin_offset)) {
    origin_offset = (0, 0, 0);
  }

  if(!isDefined(angles_offset)) {
    angles_offset = (0, 0, 0);
  }

  if(!isDefined(linktoblend)) {
    linktoblend = 0;
  }

  if(linktoblend && !isDefined(guy.script_drone)) {
    guy linktoblendtotag(self, tag, 0);
    return;
  }

  guy linkTo(self, tag, origin_offset, angles_offset);
}

function anim_pos(vehicle, pos) {
  assert(isDefined(pos), "<dev string:x19b>" + vehicle vehicle_code::get_vehicle_classname() + "<dev string:x1af>");

  if(!isDefined(pos)) {
    return spawnStruct();
  }

  return level.vehicle.templates.aianims[vehicle vehicle_code::get_vehicle_classname()][pos];
}

function setup_aianimthreads() {
  if(!isDefined(level.vehicle.aianimthread)) {
    level.vehicle.aianimthread = [];
  }

  if(!isDefined(level.vehicle.aianimcheck)) {
    level.vehicle.aianimcheck = [];
  }

  level.vehicle.aianimthread["idle"] = &guy_idle;
  level.vehicle.aianimthread["unload"] = &guy_unload;
}

function guy_handle(guy, pos) {
  guy.vehicle_idling = 1;
  thread vehicle_ai::handle_rider_death(guy, pos);
}

function driver_idle_speed(driver, pos) {
  driver endon("newanim");
  self endon("death");
  driver endon("death");
  animpos = anim_pos(self, pos);

  while(true) {
    if(self vehicle_getspeed() == 0) {
      driver.vehicle_idle = animpos.idle_animstop;
    } else {
      driver.vehicle_idle = animpos.idle_anim;
    }

    wait 0.25;
  }
}

function guy_idle(guy, pos, ignoredeath) {
  guy endon("newanim");

  if(!isDefined(ignoredeath)) {
    self endon("death");
  }

  guy endon("death");
  guy.vehicle_idling = 1;
  guy notify("gotime");

  if(!isDefined(guy.vehicle_idle)) {
    return;
  }

  animpos = anim_pos(self, pos);

  if(isDefined(animpos.mgturret)) {
    return;
  }

  if(isDefined(animpos.idle_animstop) && isDefined(animpos.idle_anim)) {
    thread driver_idle_speed(guy, pos);
  }

  while(true) {
    guy notify("idle");
    play_new_idle(guy, animpos);
  }
}

function play_new_idle(guy, animpos) {
  if(isDefined(guy.vehicle_idle_override)) {
    animontag(guy, animpos.sittag, guy.vehicle_idle_override, undefined, undefined, undefined, animpos.sittag_origin_offset, animpos.sittag_angles_offset);
    return;
  }

  if(isDefined(animpos.idleoccurrence)) {
    theanim = randomoccurrance(guy, animpos.idleoccurrence);
    animontag(guy, animpos.sittag, guy.vehicle_idle[theanim], undefined, undefined, undefined, animpos.sittag_origin_offset, animpos.sittag_angles_offset);
    return;
  }

  if(isDefined(guy.playerpiggyback) && isDefined(animpos.player_idle)) {
    animontag(guy, animpos.sittag, animpos.player_idle, undefined, undefined, undefined, animpos.sittag_origin_offset, animpos.sittag_angles_offset);
    return;
  }

  if(isDefined(animpos.vehicle_idle)) {
    thread setanimrestart_once(animpos.vehicle_idle);
  }

  animontag(guy, animpos.sittag, guy.vehicle_idle, undefined, undefined, undefined, animpos.sittag_origin_offset, animpos.sittag_angles_offset);
}

function randomoccurrance(guy, occurrences) {
  range = [];
  var_7bfca19af4bf7d21 = 0;

  for(i = 0; i < occurrences.size; i++) {
    var_7bfca19af4bf7d21 += occurrences[i];
    range[i] = var_7bfca19af4bf7d21;
  }

  pick = randomint(var_7bfca19af4bf7d21);

  for(i = 0; i < occurrences.size; i++) {
    if(pick < range[i]) {
      return i;
    }
  }
}

function guy_unload_watcher(guy) {
  self endon("death");
  wait 50;

  if(isDefined(guy) && arraycontains(self.unloadque, guy)) {
    self.unloadque = arrayremove(self.unloadque, guy);

    if(!self.unloadque.size) {
      utility::ent_flag_set("unloaded");
      self.unload_group = "default";
      self function_3a59b1430ed51a61();
    }

    guy notify("jumpedout");
  }
}

function guy_unload_que(guy) {
  self endon("death");
  self.unloadque[self.unloadque.size] = guy;
  guy utility::waittill_any("death", "jumpedout");
  self.unloadque = arrayremove(self.unloadque, guy);

  if(!self.unloadque.size) {
    utility::ent_flag_set("unloaded");
    self.unload_group = "default";
    self function_3a59b1430ed51a61();
  }
}

function riders_unloadable(unload_group) {
  if(!isDefined(self.riders)) {
    return false;
  }

  if(!self.riders.size) {
    return false;
  }

  for(i = 0; i < self.riders.size; i++) {
    if(!isalive(self.riders[i]) && !isDefined(self.riders[i].isvehicle)) {
      continue;
    }

    if(!isDefined(self.riders[i].vehicle_position)) {
      continue;
    }

    if(check_unloadgroup(self.riders[i].vehicle_position, unload_group)) {
      return true;
    }
  }

  return false;
}

function function_b7200b981d41e212(unload_group) {
  if(!isDefined(self.riders)) {
    return [];
  }

  if(!self.riders.size) {
    return [];
  }

  group = [];

  foreach(rider in self.riders) {
    if(!isalive(rider) && !isDefined(rider.isvehicle)) {
      continue;
    }

    if(!isDefined(rider.vehicle_position)) {
      continue;
    }

    if(check_unloadgroup(rider.vehicle_position, unload_group)) {
      group[group.size] = rider;
    }
  }

  return group;
}

function get_unload_group() {
  group = [];
  unloadgroups = [];
  unload_group = "default";

  if(isDefined(self.unload_group)) {
    unload_group = self.unload_group;
  }

  unloadgroups = level.vehicle.templates.unloadgroups[vehicle_code::get_vehicle_classname()][unload_group];

  if(!isDefined(unloadgroups)) {
    unloadgroups = level.vehicle.templates.unloadgroups[vehicle_code::get_vehicle_classname()]["default"];
  }

  foreach(pos in unloadgroups) {
    group[pos] = pos;
  }

  return group;
}

function check_unloadgroup(pos, unload_group) {
  if(!isDefined(unload_group)) {
    unload_group = self.unload_group;
  }

  classname = vehicle_code::get_vehicle_classname();

  if(!isDefined(level.vehicle.templates.unloadgroups[classname])) {
    return true;
  }

  if(!isDefined(level.vehicle.templates.unloadgroups[classname][unload_group])) {
    if(isDefined(self.currentnode)) {
      println("<dev string:x1cb>" + self.currentnode.origin + "<dev string:x1f7>" + unload_group + "<dev string:x20a>");
    }

    println("<dev string:x211>");
    return true;
  }

  group = level.vehicle.templates.unloadgroups[classname][unload_group];

  for(i = 0; i < group.size; i++) {
    if(pos == group[i]) {
      return true;
    }
  }

  return false;
}

function getoutrig_model(animpos, model, tag, animation, var_3fbf3458dbd0f99e) {
  self endon("death");
  classname = vehicle_code::get_vehicle_classname();
  thread utility::delete_on_death(model);
  origin = self gettagorigin(tag);
  angles = self gettagangles(tag);
  xanim = level.vehicle.templates.attachedmodels[classname][animpos.fastroperig].idleanim;
  startorg = getstartorigin(origin, angles, xanim);
  startangles = getstartangles(origin, angles, xanim);
  startangles = self.angles;
  tagorigin = model gettagorigin("j_rope_1", 1);

  if(!isDefined(tagorigin)) {
    tagorigin = self.origin;
  }

  tagoffset = tagorigin - self.origin;

  if(var_3fbf3458dbd0f99e) {
    model.origin = startorg;
    model.angles = startangles;
    thread utility::script_func("fastrope_anim", model, xanim, "getoutrigidle");
    utility::ent_flag_wait("unloaded");
  }

  origin = self gettagorigin(tag);
  angles = self gettagangles(tag);

  if(vehicle_ai::has_anim_intro()) {
    if(riders_unloadable(self.currentnode.script_unload)) {
      ropeorigin = origin;
      thread getoutrig_abort(model, undefined, animation, ropeorigin);

      if(!vehicle_code::vehicle_iscrashing()) {
        model unlink();
        model.origin = origin;
        model.angles = angles;
        thread utility::script_func("fastrope_anim", model, animation, "getoutrigfall");
      }
    }
  } else {
    moveangles = self.angles - startangles;
    moveangles = (angleclamp(moveangles[0]), angleclamp(moveangles[1]), angleclamp(moveangles[2]));
    traceorigin = rotatevector(tagoffset, moveangles) + self.origin;
    results = trace::ray_trace(traceorigin, traceorigin - (0, 0, 1000), self, trace::create_world_contents());
    ropeheight = traceorigin[2] - 400;

    if(isDefined(results["position"])) {
      ropeheight = results["position"][2];
    }

    ropeorigin = (origin[0], origin[1], ropeheight);

    if(self.var_24929b195372afe6) {
      ropeorigin = (origin[0], origin[1], origin[2]);
    }

    if(level.vehicle.templates.attachedmodels[classname][animpos.fastroperig].dropusestraceorigin) {
      ropeorigin = (traceorigin[0], traceorigin[1], ropeheight);
    }

    if(getdvarint(@ "hash_c318492e4a168bb3", 0) == 1) {
      line(traceorigin, traceorigin - (0, 0, 1000), (0, 0, 1), 1, 0, 400);
      sphere(ropeorigin, 4, (0, 1, 0), 0, 400);
    }

    thread getoutrig_abort(model, undefined, animation, ropeorigin);

    if(!vehicle_code::vehicle_iscrashing()) {
      model unlink();
      model.origin = ropeorigin;
      thread utility::script_func("fastrope_anim", model, animation, "getoutrigfall");
    }
  }

  self.fastroperig[animpos.fastroperig] = undefined;
  wait 10;
  model delete();
}

function getoutrig_disable_abort_notify_after_riders_out() {
  wait 0.05;

  while(isalive(self) && self.unloadque.size > 2) {
    wait 0.05;
  }

  if(!isalive(self) || vehicle_code::vehicle_iscrashing()) {
    return;
  }

  self notify("getoutrig_disable_abort");
}

function getoutrig_abort_while_deploying() {
  self endon("end_getoutrig_abort_while_deploying");

  while(!vehicle_code::vehicle_iscrashing()) {
    wait 0.05;
  }

  updatedriders = [];

  foreach(rider in self.riders) {
    if(isalive(rider)) {
      updatedriders[updatedriders.size] = rider;
    }
  }

  utility::array_delete(updatedriders);
  self notify("crashed_while_deploying");
  updatedriders = undefined;
}

function getoutrig_abort(model, tag, animation, ropeorigin) {
  totalanimtime = getanimlength(animation);
  var_380a7b5a14894bae = totalanimtime - 1;

  if(self.vehicletype == "mi17") {
    var_380a7b5a14894bae = totalanimtime - 0.5;
  }

  var_be49b1d9db359c31 = 0.8;
  assert(totalanimtime > var_be49b1d9db359c31);
  assert(var_380a7b5a14894bae - var_be49b1d9db359c31 > 0);
  self endon("getoutrig_disable_abort");
  thread getoutrig_disable_abort_notify_after_riders_out();
  thread getoutrig_abort_while_deploying();
  utility::waittill_notify_or_timeout("crashed_while_deploying", var_be49b1d9db359c31);
  self notify("end_getoutrig_abort_while_deploying");

  while(!isDefined(self.vehiclecrashing)) {
    waitframe();
  }

  if(isDefined(model)) {
    if(!isDefined(tag) && isDefined(ropeorigin)) {
      model unlink();
      model.origin = ropeorigin;

      if(!utility::issp()) {
        animindex = model asm::asm_lookupanimfromalias("animscripted", animation);
        xanim = model asm::asm_getxanim("animscripted", animindex);
        startorg = getstartorigin(self.origin, self.angles, xanim);
        startangles = getstartangles(self.origin, self.angles, xanim);
        model dontinterpolate();
        model forceteleport(startorg, startangles);
        model animmode("nogravity");
        model aisetanim("animscripted", animindex);
      } else {
        model animScripted("getoutrigfall", model.origin, model.angles, animation, undefined, undefined, 0);
      }
    } else {
      thread animontag(model, tag, animation);
    }

    waittillframeend();
    model setanimtime(animation, var_380a7b5a14894bae / totalanimtime);
  }

  attacker = self;

  if(isDefined(self.original_attacker)) {
    attacker = self.original_attacker;
  }

  for(i = 0; i < self.riders.size; i++) {
    if(!isDefined(self.riders[i])) {
      continue;
    }

    if(!isDefined(self.riders[i].ragdoll_getout_death)) {
      continue;
    }

    if(self.riders[i].ragdoll_getout_death != 1) {
      continue;
    }

    if(!isDefined(self.riders[i].ridingvehicle)) {
      continue;
    }

    self.riders[i].forcefallthroughonropes = 1;

    if(isalive(self.riders[i])) {
      thread animontag_ragdoll_death_fall(self.riders[i], self, attacker);
    }
  }
}

function setanimrestart_once(vehicle_anim, bclearanim) {
  self endon("death");
  self endon("dont_clear_anim");

  if(!isDefined(bclearanim)) {
    bclearanim = 1;
  }

  cycletime = getanimlength(vehicle_anim);
  self endon("death");
  thread utility::script_func("vehicle_door_anim", self, vehicle_anim);
  wait cycletime;

  if(utility::issp() && bclearanim) {
    self clearanim(vehicle_anim, 0);
  }
}

#using_animtree("script_model");

function getout_rigspawn(animatemodel, animpos, var_3fbf3458dbd0f99e) {
  if(!isDefined(var_3fbf3458dbd0f99e)) {
    var_3fbf3458dbd0f99e = 1;
  }

  classname = vehicle_code::get_vehicle_classname();

  if(isDefined(self.attach_model_override) && isDefined(self.attach_model_override[animpos.fastroperig])) {
    overrridegetoutrig = 1;
  } else {
    overrridegetoutrig = 0;
  }

  if(!isDefined(animpos.fastroperig) || isDefined(self.fastroperig[animpos.fastroperig]) || overrridegetoutrig) {
    return;
  }

  origin = animatemodel gettagorigin(level.vehicle.templates.attachedmodels[classname][animpos.fastroperig].tag);
  angles = animatemodel gettagangles(level.vehicle.templates.attachedmodels[classname][animpos.fastroperig].tag);
  self.fastroperiganimating[animpos.fastroperig] = 1;
  getoutrig_model = spawn("script_model", origin);
  getoutrig_model.angles = angles;
  getoutrig_model.origin = origin;
  getoutrig_model useanimtree(#animtree);
  getoutrig_model setModel(level.vehicle.templates.attachedmodels[classname][animpos.fastroperig].model);
  self.fastroperig[animpos.fastroperig] = getoutrig_model;
  getoutrig_model linkTo(animatemodel, level.vehicle.templates.attachedmodels[classname][animpos.fastroperig].tag);
  thread getoutrig_model(animpos, getoutrig_model, level.vehicle.templates.attachedmodels[classname][animpos.fastroperig].tag, level.vehicle.templates.attachedmodels[classname][animpos.fastroperig].dropanim, var_3fbf3458dbd0f99e);
  return getoutrig_model;
}

function check_sound_tag_dupe(soundtag) {
  if(!isDefined(self.sound_tag_dupe)) {
    self.sound_tag_dupe = [];
  }

  duped = 0;

  if(!isDefined(self.sound_tag_dupe[soundtag])) {
    self.sound_tag_dupe[soundtag] = 1;
  } else {
    duped = 1;
  }

  thread check_sound_tag_dupe_reset(soundtag);
  return duped;
}

function check_sound_tag_dupe_reset(soundtag) {
  wait 0.05;

  if(!isDefined(self)) {
    return;
  }

  self.sound_tag_dupe[soundtag] = 0;
  keys = getarraykeys(self.sound_tag_dupe);

  for(i = 0; i < keys.size; i++) {
    if(self.sound_tag_dupe[keys[i]]) {
      return;
    }
  }

  self.sound_tag_dupe = undefined;
}

function vehicle_play_exit_anim(animpos, vehicle_getoutanim, vehicle_getoutanim_clear) {
  animatemodel = getanimatemodel();

  if(!isDefined(vehicle_getoutanim)) {
    vehicle_getoutanim = animpos.vehicle_getoutanim;
  }

  if(!isDefined(vehicle_getoutanim_clear)) {
    vehicle_getoutanim_clear = animpos.vehicle_getoutanim_clear;
  }

  if(isDefined(vehicle_getoutanim)) {
    animatemodel thread setanimrestart_once(vehicle_getoutanim, vehicle_getoutanim_clear);
    var_5d839596714f4fa9 = 0;

    if(isDefined(animpos.vehicle_getoutsoundtag)) {
      var_5d839596714f4fa9 = check_sound_tag_dupe(animpos.vehicle_getoutsoundtag);
      origin = animatemodel gettagorigin(animpos.vehicle_getoutsoundtag);
    } else {
      origin = animatemodel.origin;
    }

    if(isDefined(animpos.vehicle_getoutsound) && !var_5d839596714f4fa9) {
      playsoundatpos(origin, animpos.vehicle_getoutsound);
    }

    var_5d839596714f4fa9 = undefined;
  }
}

function vehicle_end_loop_sounds(guy, pos) {
  animpos = anim_pos(self, pos);

  if(isDefined(guy.playerpiggyback) && isDefined(animpos.player_getout_sound_loop)) {
    level.player thread utility::script_func("playloopsound_on_entity", animpos.player_getout_sound_loop);
  }

  if(isDefined(animpos.getoutloopsnd)) {
    guy thread utility::script_func("playloopsound_on_entity", animpos.getoutloopsnd);
  }

  if(isDefined(guy.playerpiggyback) && isDefined(animpos.player_getout_sound_end)) {
    level.player thread utility::script_func("playsound_on_entity", animpos.player_getout_sound_end);
  }
}

function prepdoorsforunload() {
  if(self function_413a92383b3f82bc()) {
    return;
  }

  for(i = 0; i < level.vehicle.templates.aianims[vehicle_code::get_vehicle_classname()].size; i++) {
    animpos = level.vehicle.templates.aianims[vehicle_code::get_vehicle_classname()][i];

    if(isDefined(animpos.vehicle_getoutanim)) {
      anim_name = getanimname(animpos.vehicle_getoutanim);
      self function_cbcabc88d34292ef(anim_name);
    }
  }
}

function wait_for_open_door(guy, animpos) {
  guy endon("jumpedout");
  guy endon("death");
  self endon("death");
  prepdoorsforunload();

  while(!guy.requestopendoor && !vehicle_ai::has_anim_intro()) {
    waitframe();
  }

  if(isDefined(animpos.vehicle_getoutanim)) {
    anim_name = getanimname(animpos.vehicle_getoutanim);

    if(!self function_c0a4dabbfae4a8b5(anim_name)) {
      vehicle_getoutanim = animpos.vehicle_getoutanim;
      vehicle_getoutanim_clear = animpos.vehicle_getoutanim_clear;

      if(isDefined(guy.requestopendoorparams)) {
        if(guy.requestopendoorparams == "combat_run" && isDefined(animpos.vehicle_getoutanim_combat_run)) {
          vehicle_getoutanim = animpos.vehicle_getoutanim_combat_run;
          vehicle_getoutanim_clear = animpos.vehicle_getoutanim_combat_run_clear;
        } else if(guy.requestopendoorparams == "combat" && isDefined(animpos.vehicle_getoutanim_combat)) {
          vehicle_getoutanim = animpos.vehicle_getoutanim_combat;
          vehicle_getoutanim_clear = animpos.vehicle_getoutanim_combat_clear;
        }
      }

      vehicle_play_exit_anim(animpos, vehicle_getoutanim, vehicle_getoutanim_clear);
      self function_d51ca5709183c041(anim_name, 1);
    }

    if(isDefined(animpos.fastroperig) && !isDefined(self.fastroperig[animpos.fastroperig])) {
      animatemodel = getanimatemodel();
      getoutrig_model = getout_rigspawn(animatemodel, animpos, 1);
    }
  }
}

function guy_setup_rope(guy, animpos) {
  heli_ref = vehicle_code::get_vehicle_classname();

  if(utility::issharedfuncdefined(heli_ref, #"setuprope")) {
    self[[utility::getsharedfunc(heli_ref, #"setuprope")]](guy);
    return;
  }

  if(isDefined(animpos.fastroperig)) {
    thread wait_for_open_door(guy, animpos);
    guy vehicle_common::setuprope();
    return;
  }

  assertmsg("<dev string:x228>");
}

function guy_unload(guy, pos) {
  isvehicle = 0;

  if(isDefined(guy.isvehicle)) {
    isvehicle = 1;
  }

  animpos = anim_pos(self, pos);
  type = self.vehicletype;

  if(!check_unloadgroup(pos)) {
    return;
  }

  thread guy_unload_que(guy);

  if(!utility::issp()) {
    thread guy_unload_watcher(guy);
  }

  self endon("death");

  if(isai(guy) && isalive(guy)) {
    guy endon("death");
  }

  bnoanimunload = 0;

  if(isDefined(guy.getoffvehiclefunc)) {
    var_be069f744cfc56eb = guy[[guy.getoffvehiclefunc]]();

    if(var_be069f744cfc56eb) {
      bnoanimunload = 1;
    }
  }

  if(isDefined(guy.onrotatingvehicleturret)) {
    guy.onrotatingvehicleturret = undefined;

    if(isDefined(guy.getoffvehiclefunc)) {
      guy[[guy.getoffvehiclefunc]]();
    }
  }

  guy notify("newanim");

  if(isDefined(animpos.bhasgunwhileriding) && !animpos.bhasgunwhileriding) {
    if(!isDefined(guy.disable_gun_recall)) {
      guy ai::gun_recall();
    }
  }

  if(isai(guy)) {
    guy pushplayer(1);
  }

  if(isDefined(animpos.bnoanimunload)) {
    bnoanimunload = 1;
  } else if(isDefined(self.script_keepdriver) && pos == 0) {
    thread guy_idle(guy, pos);
    return;
  }

  if(guy should_give_orghealth()) {
    guy.health = guy.orghealth;
  }

  guy.orghealth = undefined;

  if(isai(guy) && isalive(guy)) {
    guy endon("death");
  }

  guy.allowdeath = 0;
  tag = animpos.sittag;

  if(isDefined(guy.get_out_override)) {
    animation = guy.get_out_override;
  } else if(utility::ent_flag("landed") && isDefined(animpos.getout_landed)) {
    animation = animpos.getout_landed;
  } else if(isDefined(guy.playerpiggyback) && isDefined(animpos.player_getout)) {
    animation = animpos.player_getout;
  } else {
    animation = animpos.getout;
  }

  if(!bnoanimunload) {
    if(isDefined(animpos.getoutsnd)) {
      guy thread utility::script_func("playsound_on_tag", animpos.getoutsnd, "J_Wrist_RI", 1);
    }

    if(isDefined(guy.playerpiggyback) && isDefined(animpos.player_getout_sound)) {
      guy thread utility::script_func("playsound_on_tag", animpos.player_getout_sound);
    }

    if(isDefined(animpos.getoutloopsnd)) {
      guy thread utility::script_func("playloopsound_on_tag", animpos.getoutloopsnd);
    }

    if(isDefined(guy.playerpiggyback) && isDefined(animpos.player_getout_sound_loop)) {
      level.player thread utility::script_func("playloopsound_on_tag", animpos.player_getout_sound_loop);
    }

    guy notify("newanim");
    guy notify("jumping_out");
    var_c4b99b4885885994 = 0;

    if(!isai(guy) && !isvehicle) {
      var_c4b99b4885885994 = 1;
    }

    if(!isDefined(guy.script_stay_drone) && !isvehicle) {
      guy = guy_becomes_real_ai(guy, pos);
    }

    if(!isalive(guy) && !isvehicle) {
      return;
    }

    if(!isvehicle) {
      guy.ragdoll_getout_death = 1;
    }

    if(isDefined(animpos.ragdoll_getout_death)) {
      guy.ragdoll_getout_death = 1;

      if(isDefined(animpos.ragdoll_fall_anim)) {
        guy.ragdoll_fall_anim = animpos.ragdoll_fall_anim;
      }
    }

    if(var_c4b99b4885885994) {
      self.riders[self.riders.size] = guy;
      thread vehicle_ai::handle_rider_death(guy, pos);
      thread guy_unload_que(guy);
      guy.ridingvehicle = self;
    }

    if(isai(guy)) {
      guy endon("death");
    }

    guy notify("newanim");
    guy notify("jumping_out");

    if(isDefined(animpos.littlebirde_getout_unlinks) && animpos.littlebirde_getout_unlinks) {
      thread stable_unlink(guy);
    }

    if(isalive(guy) && isai(guy) && guy_resets_goalpos(guy)) {
      guy.goalradius = 600;
      guy setgoalpos(guy.origin);
    }

    if(isDefined(animpos.getout_secondary)) {
      animontag(guy, tag, animation);
      var_c2e1902b3ec1cda1 = tag;

      if(isDefined(animpos.getout_secondary_tag)) {
        var_c2e1902b3ec1cda1 = animpos.getout_secondary_tag;
      }

      animontag(guy, var_c2e1902b3ec1cda1, animpos.getout_secondary, undefined, undefined, undefined, animpos.sittag_origin_offset, animpos.sittag_angles_offset);
    } else {
      hoverunload = 0;

      if(isDefined(animpos.getout_hover_loop) && isDefined(animpos.getout_hover_land)) {
        thread guy_unload_land(guy, tag, animpos.getout, animpos.getout_hover_loop, animpos.getout_hover_land);
        hoverunload = 1;
      } else if(!isvehicle) {
        guy.anim_end_early = 1;
      }

      thread wait_for_open_door(guy, animpos);
      guy vehicle_common::exitvehicle();

      if(hoverunload) {
        guy waittill("hoverunload_done");
      }
    }

    if(isDefined(guy.playerpiggyback) && isDefined(animpos.player_getout_sound_loop)) {
      level.player thread utility::stop_loop_sound_on_entity(animpos.player_getout_sound_loop);
    }

    if(isDefined(animpos.getoutloopsnd)) {
      guy thread utility::stop_loop_sound_on_entity(animpos.getoutloopsnd);
    }

    if(isDefined(guy.playerpiggyback) && isDefined(animpos.player_getout_sound_end)) {
      level.player thread utility::script_func("playsound_on_entity", animpos.player_getout_sound_end);
    }
  } else if(!isai(guy)) {
    if(guy.drone_delete_on_unload) {
      guy delete();
      return;
    }

    guy = utility::script_func("spawner_makerealai", guy);
  }

  self.riders = arrayremove(self.riders, guy);
  self.usedpositions[pos] = 0;
  vehicle_occupancy::update_occupancy(self);
  guy.ridingvehicle = undefined;
  guy.drivingvehicle = undefined;

  if(!isalive(self) && !isDefined(animpos.unload_ondeath)) {
    guy delete();
    return;
  }

  if(!isDefined(guy.magic_bullet_shield)) {
    guy.allowdeath = 1;
  }

  if(isalive(guy) || isvehicle) {
    guy.forced_startingposition = undefined;

    if(isai(guy)) {
      if(isDefined(animpos.getoutstance)) {
        guy.desired_anim_pose = animpos.getoutstance;
        guy allowedstances("crouch");
        guy thread utility::script_func("anim_updateanimpose");
        guy allowedstances("stand", "crouch", "prone");
      }

      guy pushplayer(0);
      guy notify("pushplayerchanged");
    } else if(isvehicle) {
      guy.vspawner.origin = guy.origin;
      guy.vspawner.angles = guy.angles;

      if(isDefined(guy.vspawner.target)) {
        guy.vspawner utility::callsharedfunc(#"vehicle", #"spawn_vehicle_and_gopath_sp_only");
      } else {
        realvehicle = guy.vspawner utility::callsharedfunc(#"vehicle", #"spawn_vehicle_sp_only");
      }

      guy delete();
    }
  }

  if(guy.script_noteworthy == "delete_after_unload") {
    guy delete();
    return;
  }

  if(isDefined(animpos.getout_delete) && animpos.getout_delete) {
    guy delete();
    return;
  }

  guy guy_cleanup_vehiclevars();
}

function guy_unload_land(guy, exittag, jumpanim, loopanim, landanim) {
  jumporigin = self gettagorigin(exittag);
  jumpangles = self gettagangles(exittag);
  startorigin = getstartorigin(jumporigin, jumpangles, jumpanim);
  startangles = getstartangles(jumporigin, jumpangles, jumpanim);
  move_delta = getmovedelta(jumpanim, 0, 1);
  ent = utility::spawn_tag_origin();
  ent.origin = startorigin;
  ent.angles = startangles;
  endorigin = ent localtoworldcoords(move_delta);
  ent thread utility::delete_on_notify("movedone");
  fallstartorigin = endorigin;
  groundtrace = utility::groundpos(fallstartorigin);
  landstartorigin = getstartorigin(jumporigin, jumpangles, landanim);
  move_delta = getmovedelta(landanim, 0, 1);
  landendorigin = landstartorigin + move_delta;
  landheight = landstartorigin[2] - landendorigin[2];
  fallendorigin = groundtrace + (0, 0, landheight);
  guy.allowdeath = 0;
  guy setCanDamage(0);
  guy endon("death");
  wait getanimlength(jumpanim) - 0.1;
  guy unlink();
  guy notify("animontag_thread");
  guy stopanimScripted();
  ent.origin = guy.origin;
  ent.angles = guy.angles;
  ent dontinterpolate();
  guy dontinterpolate();
  guy linkTo(ent, "tag_origin", (0, 0, 0), (0, 0, 0));
  guy.allowdeath = 1;
  guy setCanDamage(1);
  guy.unload_loopanim = loopanim;

  if(isai(guy)) {
    guy utility::script_func("asm_animcustom", &guy_fall_loop, &guy_fall_loop_end);
  } else {
    guy thread guy_fall_loop();
  }

  falldist = length((0, 0, fallendorigin[2]) - (0, 0, fallstartorigin[2]));
  fallspeed = 350;
  falltime = falldist / fallspeed;
  ent moveTo(fallendorigin, falltime);
  ent waittill("movedone");
  guy unlink();
  guy animScripted("dropship_land", guy.origin, guy.angles, landanim);
  wait getanimlength(landanim);
  guy notify("hoverunload_done");
  guy notify("anim_on_tag_done");
}

function guy_fall_loop() {
  if(isai(self)) {
    if(utility::actor_is3d()) {
      self orientmode("face angle 3d", self.angles);
    } else {
      self orientmode("face angle", self.angles[1]);
    }

    self animmode("zonly_physics", 1);
    self clearanim(asm::asm_getbodyknob(), 0.2);
  }

  self setanim(self.unload_loopanim, 1);
  self waittill("dropship_land");
}

function guy_fall_loop_end() {}

function guy_resets_goalpos(guy) {
  if(isDefined(guy.script_delayed_playerseek)) {
    return false;
  }

  if(guy utility::script_func("ai_has_color")) {
    return false;
  }

  if(isDefined(guy.qsetgoalpos)) {
    return false;
  }

  if(!isDefined(guy.target)) {
    return true;
  }

  nodes = getnodearray(guy.target, #targetname);
  structs = utility::getStructArray(guy.target, "targetname");

  if(nodes.size > 0 || structs.size > 0) {
    return false;
  }

  ent = getEnt(guy.target, #targetname);

  if(isDefined(ent) && ent.classname == "info_volume") {
    return false;
  }

  return true;
}

function animontag(guy, tag, animation, notetracks, sthreads, flag, origin_offset, angles_offset) {
  guy notify("animontag_thread");
  guy endon("animontag_thread");

  if(!isDefined(origin_offset)) {
    origin_offset = (0, 0, 0);
  }

  if(!isDefined(angles_offset)) {
    angles_offset = (0, 0, 0);
  }

  if(!isDefined(flag)) {
    flag = "animontagdone";
  }

  if(isDefined(self.modeldummy)) {
    animatemodel = self.modeldummy;
  } else {
    animatemodel = self;
  }

  if(!isDefined(tag) || !utility::hastag(animatemodel.model, tag)) {
    org = guy.origin;
    angles = guy.angles;
  } else {
    org = animatemodel gettagorigin(tag);
    angles = animatemodel gettagangles(tag) + angles_offset;
    axes = anglestoaxis(angles);
    axesnames = ["forward", "right", "up"];

    for(i = 0; i < axes.size; i++) {
      org += axes[axesnames[i]] * origin_offset[i];
    }
  }

  if(isDefined(guy.ragdoll_getout_death)) {
    level thread animontag_ragdoll_death(guy, self);
  }

  if(!utility::issp()) {
    guy dontinterpolate();

    if(isai(guy)) {
      animindex = guy asm::asm_lookupanimfromalias("animscripted", animation);
      xanim = guy asm::asm_getxanim("animscripted", animindex);
      startorg = getstartorigin(self.origin, self.angles, xanim);
      startangles = getstartangles(self.origin, self.angles, xanim);
      guy forceteleport(startorg, startangles);
      guy animmode("nogravity");
      guy aisetanim("animscripted", animindex);
    }
  } else {
    guy animScripted(flag, org, angles, animation);
  }

  if(isai(guy)) {
    thread donotetracks(guy, animatemodel, flag);
  }

  if(isDefined(guy.anim_end_early)) {
    guy.anim_end_early = undefined;
    animwait = getanimlength(animation) - 0.25;

    if(animwait > 0) {
      wait animwait;
    }

    guy stopanimScripted();
    guy.interval = 0;
    guy thread recover_interval();
  } else {
    if(isDefined(notetracks)) {
      for(i = 0; i < notetracks.size; i++) {
        guy waittillmatch(flag, notetracks[i]);
        guy thread[[sthreads[i]]]();
      }
    }

    guy waittillmatch(flag, "end");
  }

  guy notify("anim_on_tag_done");
  guy.ragdoll_getout_death = undefined;
}

function recover_interval() {
  self endon("death");
  wait 2;

  if(self.interval == 0) {
    self.interval = 80;
  }
}

function animontag_ragdoll_death(guy, vehicle) {
  if(isDefined(guy.magic_bullet_shield) && guy.magic_bullet_shield) {
    return;
  }

  if(!isai(guy)) {
    guy setCanDamage(1);
  }

  guy endon("anim_on_tag_done");
  damage = undefined;
  attacker = undefined;
  var_4b017bc092dee052 = vehicle.health <= 0;

  while(true) {
    if(!var_4b017bc092dee052 && !(isDefined(vehicle) && vehicle.health > 0)) {
      break;
    }

    guy waittill("damage", damage, attacker);

    if(isDefined(guy.forcefallthroughonropes)) {
      break;
    }

    if(!isDefined(damage)) {
      continue;
    }

    if(damage < 1) {
      continue;
    }

    if(!isDefined(attacker)) {
      continue;
    }

    if(isPlayer(attacker)) {
      break;
    }
  }

  if(!isalive(guy)) {
    return;
  }

  thread animontag_ragdoll_death_fall(guy, vehicle, attacker);
}

function animontag_ragdoll_death_fall(guy, vehicle, attacker) {
  guy.deathanim = undefined;
  guy.deathfunction = undefined;
  guy.anim_disablepain = 1;

  if(isDefined(guy.ragdoll_fall_anim)) {
    movedelta = getmovedelta(guy.ragdoll_fall_anim, 0, 1);
    groundpos = physicstrace(guy.origin + (0, 0, 16), guy.origin - (0, 0, 10000));
    distancefromground = distance(guy.origin + (0, 0, 16), groundpos);

    if(abs(movedelta[2] + 16) <= abs(distancefromground)) {
      guy thread utility::script_func("playsound_on_entity", "generic_death_falling");
      guy animScripted("fastrope_fall", guy.origin, guy.angles, guy.ragdoll_fall_anim);
      guy waittillmatch("fastrope_fall", "start_ragdoll");
    }
  }

  if(!isDefined(guy)) {
    return;
  }

  guy.deathanim = undefined;
  guy.deathfunction = undefined;
  guy.anim_disablepain = 1;
  guy notify("rope_death", attacker);
  guy kill(attacker.origin, attacker);

  if(isDefined(guy.script_stay_drone)) {
    guy notsolid();
    weapon_model = getweaponmodel(guy.weapon);
    weapon = guy.weapon;

    if(isDefined(weapon_model)) {
      guy detach(weapon_model, "tag_weapon_right");
      org = guy gettagorigin("tag_weapon_right");
      ang = guy gettagangles("tag_weapon_right");
      level.gun = spawn("weapon_" + getcompleteweaponname(weapon), (0, 0, 0));
      level.gun.angles = ang;
      level.gun.origin = org;
    }
  } else {
    guy utility::script_func("anim_dropallaiweapons");
  }

  if(isDefined(guy.fnpreragdoll)) {
    guy[[guy.fnpreragdoll]]();
  }

  guy startragdoll();
}

function donotetracks(guy, vehicle, flag) {
  guy endon("idle");
  guy endon("newanim");
  vehicle endon("death");
  guy endon("death");
  guy utility::script_func("anim_donotetracks", flag);
}

function ai_wait_go() {
  self notify("5a7b095b1f7d25c0");
  self endon("5a7b095b1f7d25c0");
  self endon("death");
  self waittill("loaded");
  vehicle_paths::gopath(self);
}

function set_pos(guy, vehicleanim) {
  pos = guy.script_startingposition;

  if(isDefined(pos)) {
    assert(pos < vehicleanim.size && pos >= 0, "<dev string:x278>" + vehicleanim.size - 1);
  }

  if(isDefined(guy.forced_startingposition)) {
    pos = guy.forced_startingposition;
  }

  if(isDefined(pos)) {
    return pos;
  }

  assert(!isDefined(pos), "<dev string:x2bd>");

  for(j = 0; j < self.usedpositions.size; j++) {
    if(self.usedpositions[j] || !(vehicleanim[j].var_60b6d3b20648a38f ?? 1)) {
      continue;
    }

    if(isDefined(guy.isvehicle) && !isDefined(vehicleanim[j].isvehicle)) {
      continue;
    }

    if(!isDefined(guy.isvehicle) && isDefined(vehicleanim[j].isvehicle)) {
      continue;
    }

    return j;
  }

  if(isDefined(guy.isvehicle) && guy.isvehicle) {
    assertmsg("<dev string:x2da>");
    return;
  }

  assertmsg("<dev string:x31b>");
}

function guy_man_turret(guy, pos, var_12adb1f13b90f22f) {
  animpos = anim_pos(self, pos);
  turret = self.mgturret[0];

  if(!isalive(guy)) {
    return;
  }

  turret endon("death");
  guy endon("death");

  if(var_12adb1f13b90f22f && isDefined(animpos.passenger_2_turret_func)) {
    [[animpos.passenger_2_turret_func]](self, guy, pos, turret);
  }

  if(turret.classname == "misc_turret") {
    vehicle_code::set_turret_team(turret);
    turret setdefaultdroppitch(0);
  }

  wait 0.1;
  guy endon("guy_man_turret_stop");

  if(turret.classname == "misc_turret") {
    level thread vehicle_code::vehicle_turret_difficulty(turret, utility::getdifficulty());
  }

  if(turret.classname == "misc_turret") {
    guy asm_bb::bb_requestturret(turret);
    return;
  }

  if(turret.classname == "script_vehicle") {
    guy asm_bb::function_d97733fe1476f19e(turret, 1);
  }
}

function guy_blowup(guy) {
  if(!isDefined(guy.vehicle_position)) {
    return;
  }

  pos = guy.vehicle_position;
  anim_pos = anim_pos(self, pos);

  if(!isDefined(anim_pos.explosion_death)) {
    return;
  }

  guy.deathanim = anim_pos.explosion_death;
  angles = self.angles;
  origin = guy.origin;

  if(isDefined(anim_pos.explosion_death_offset)) {
    origin += anglesToForward(angles) * anim_pos.explosion_death_offset[0];
    origin += anglestoright(angles) * anim_pos.explosion_death_offset[1];
    origin += anglestoup(angles) * anim_pos.explosion_death_offset[2];
  }

  guy = convert_guy_to_drone(guy);
  detach_models_with_substr(guy, "weapon_");
  guy notsolid();
  guy.origin = origin;
  guy.angles = angles;
  guy animScripted("deathanim", origin, angles, anim_pos.explosion_death);
  fraction = 0.3;

  if(isDefined(anim_pos.explosion_death_ragdollfraction)) {
    fraction = anim_pos.explosion_death_ragdollfraction;
  }

  animlength = getanimlength(anim_pos.explosion_death);
  timer = gettime() + animlength * 1000;
  wait animlength * fraction;
  force = (0, 0, 1);
  org = guy.origin;

  if(getdvarint(@ "ragdoll_enable") == 0) {
    guy delete();
    return;
  }

  if(isai(guy)) {
    guy utility::script_func("anim_dropallaiweapons");
  } else {
    detach_models_with_substr(guy, "weapon_");
  }

  while(!guy isragdoll() && gettime() < timer) {
    org = guy.origin;
    wait 0.05;
    force = guy.origin - org;

    if(isDefined(guy.fnpreragdoll)) {
      guy[[guy.fnpreragdoll]]();
    }

    guy startragdoll();
  }

  wait 0.05;
  force *= 20000;

  for(i = 0; i < 3; i++) {
    if(isDefined(guy)) {
      org = guy.origin;
    }

    wait 0.05;
  }

  if(!guy isragdoll()) {
    guy delete();
  }
}

function convert_guy_to_drone(guy, var_9295811a6211753c) {
  if(!isDefined(var_9295811a6211753c)) {
    var_9295811a6211753c = 0;
  }

  model = spawn("script_model", guy.origin);
  model.angles = guy.angles;
  model setModel(guy.model);
  size = guy getattachsize();

  for(i = 0; i < size; i++) {
    model attach(guy getattachmodelname(i), guy getattachtagname(i));
  }

  model useanimtree(#animtree);

  if(isDefined(guy.team)) {
    model.team = guy.team;
  }

  if(!var_9295811a6211753c) {
    guy delete();
  }

  model utility::self_func("makefakeai");
  return model;
}

function vehicle_getinstart(pos) {
  animpos = anim_pos(self, pos);
  assert(isDefined(animpos), "<dev string:x362>" + vehicle_code::get_vehicle_classname() + "<dev string:x36f>" + pos + "<dev string:x399>");
  assert(isDefined(animpos.sittag), "<dev string:x362>" + vehicle_code::get_vehicle_classname() + "<dev string:x3aa>" + pos + "<dev string:x3cd>");
  return vehicle_getanimstart(animpos.getin, animpos.sittag, pos, animpos.canshootinvehicle);
}

function vehicle_getanimstart(animation, tag, pos, canshootinvehicle) {
  struct = spawnStruct();
  origin = undefined;
  angles = undefined;
  assert(isDefined(tag), "<dev string:x362>" + vehicle_code::get_vehicle_classname() + "<dev string:x3d3>");

  if(!isDefined(tag)) {
    tag = "tag_body";
  }

  org = self gettagorigin(tag);
  ang = self gettagangles(tag);

  if(isDefined(animation)) {
    origin = getstartorigin(org, ang, animation);
    angles = getstartangles(org, ang, animation);
  } else {
    origin = org;
    angles = ang;
  }

  struct.origin = origin;
  struct.angles = angles;
  struct.vehicle_position = pos;
  struct.canshootinvehicle = canshootinvehicle;
  return struct;
}

function is_position_in_group(vehicle, pos, group) {
  if(!isDefined(group)) {
    return true;
  }

  classname = vehicle vehicle_code::get_vehicle_classname();
  assert(isDefined(level.vehicle.templates.unloadgroups[classname][group]));
  vehicles_group = level.vehicle.templates.unloadgroups[classname][group];

  foreach(member in vehicles_group) {
    if(member == pos) {
      return true;
    }
  }

  return false;
}

function get_availablepositions(group) {
  vehicleanim = level.vehicle.templates.aianims[vehicle_code::get_vehicle_classname()];
  availablepositions = [];
  nonanimatedpositions = [];

  for(i = 0; i < self.usedpositions.size; i++) {
    if(self.usedpositions[i] || !(vehicleanim[i].var_60b6d3b20648a38f ?? 1) || vehicleanim[i].var_14f441f730dc229d) {
      continue;
    }

    if(is_position_in_group(self, i, group)) {
      availablepositions[availablepositions.size] = vehicle_getinstart(i);
      continue;
    }

    nonanimatedpositions[nonanimatedpositions.size] = i;
  }

  struct = spawnStruct();
  struct.availablepositions = availablepositions;
  struct.nonanimatedpositions = nonanimatedpositions;
  return struct;
}

function getanimatemodel() {
  var_7237854e3be197ca = self.modeldummy;

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  return self;
}

function detach_models_with_substr(guy, substr) {
  size = guy getattachsize();
  var_d39a52de9bccb3ba = [];
  var_551b9b0ac7e98ac2 = [];
  index = 0;

  for(i = 0; i < size; i++) {
    modelname = guy getattachmodelname(i);
    tagname = guy getattachtagname(i);

    if(issubstr(modelname, substr)) {
      var_d39a52de9bccb3ba[index] = modelname;
      var_551b9b0ac7e98ac2[index] = tagname;
    }
  }

  for(i = 0; i < var_d39a52de9bccb3ba.size; i++) {
    guy detach(var_d39a52de9bccb3ba[i], var_551b9b0ac7e98ac2[i]);
  }
}

function should_give_orghealth() {
  if(!isai(self)) {
    return false;
  }

  if(!isDefined(self.orghealth)) {
    return false;
  }

  return !isDefined(self.magic_bullet_shield);
}

function stable_unlink(guy) {
  self waittill("stable_for_unlink");

  if(isalive(guy)) {
    guy unlink();
  }
}

function guy_cleanup_vehiclevars() {
  self.vehicle_idling = undefined;
  self.standing = undefined;
  self.vehicle_position = undefined;
  self.delay = undefined;
}