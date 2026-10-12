/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\vehicle_aianim.gsc
***********************************************/



#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\notetrack;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_paths;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\vehicle\vehicle_common;
#namespace vehicle_aianim;

function guy_enter(guy, var_5b0cab0a9420da60) {
  guy endon("death_or_disconnect");
  assertex(!isspawner(self), "Tried to make guys enter a spawner");
  assertex(!isDefined(guy.ridingvehicle), "ai can't ride two vehicles at the same time");

  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  if(!isDefined(self.vehicletype)) {
    return;
  }

  classname = get_vehicle_classname();
  vehicleanim = level.vehicle.templates.aianims[classname];
  self.attachedguys[self.attachedguys.size] = guy;
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

  if(isDefined(animpos.delay)) {
    guy.delay = animpos.delay;

    if(isDefined(animpos.delayinc)) {
      self.delayer = guy.delay;
    }
  }

  if(isDefined(animpos.delayinc)) {
    self.delayer += animpos.delayinc;
    guy.delay = self.delayer;
  }

  guy.ridingvehicle = self;
  guy.orghealth = guy.health;
  guy.vehicle_idle = animpos.idle;
  guy.vehicle_standattack = animpos.standattack;

  if(!getdvarint(@ "hash_9403d7d31fc1d981")) {
    guy.deathanim = animpos.death;
    guy.deathanimscript = animpos.deathscript;
  }

  guy.standing = 0;
  guy.allowdeath = 1;

  if(!getdvarint(@ "hash_9403d7d31fc1d981")) {
    if(isDefined(guy.deathanim) && !isDefined(guy.magic_bullet_shield) && vehicle_allows_rider_death()) {
      if(guy.vehicle_position != 0 || vehicle_allows_driver_death()) {
        guy.allowdeath = !isDefined(guy.script_allowdeath) || guy.script_allowdeath;
      }
    }
  } else if(!isDefined(guy.magic_bullet_shield) && vehicle_allows_rider_death()) {
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

  if(guy.classname != "script_model" && spawn_failed(guy)) {
    return;
  }

  org = self gettagorigin(animpos.sittag);
  angles = self gettagangles(animpos.sittag);

  if(!getdvarint(@ "hash_9403d7d31fc1d981")) {
    link_to_sittag(guy, animpos.sittag, animpos.sittag_origin_offset, animpos.sittag_angles_offset, animpos.linktoblend);
  } else if(guy.classname != "script_model" && !guy hasvehicle()) {
    chosenpos = vehicle_getinstart(pos);
    guy entervehicle(self, 1, chosenpos, animpos);
  }

  if(isai(guy)) {
    if(!getdvarint(@ "hash_9403d7d31fc1d981")) {
      guy forceteleport(org, angles);
    }

    if(isDefined(animpos.bhasgunwhileriding) && !animpos.bhasgunwhileriding) {
      guy gun_remove();
    }

    if(guy_should_man_turret(animpos)) {
      thread guy_man_turret(guy, pos, var_5b0cab0a9420da60);
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

    if(getdvarint(@ "hash_9403d7d31fc1d981") || isDefined(vehicleanim[0].death)) {
      thread driverdead(guy);
    }
  }

  self notify("guy_entered", guy, pos);
  guy notify("loaded");
  scripts\engine\utility::ent_flag_clear("unloaded");
  thread guy_handle(guy, pos);

  if(isDefined(animpos.rider_func)) {
    guy[[animpos.rider_func]]();
    return;
  }

  if(!getdvarint(@ "hash_9403d7d31fc1d981")) {
    if(isDefined(animpos.getin_idle_func)) {
      thread[[animpos.getin_idle_func]](guy, pos);
      return;
    }

    thread guy_idle(guy, pos);
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
  classname = get_vehicle_classname();
  self.attachedguys = [];

  if(!(isDefined(level.vehicle.templates.aianims) && isDefined(level.vehicle.templates.aianims[classname]))) {
    return;
  }

  maxpos = level.vehicle.templates.aianims[classname].size;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "ai_wait_go") {
    thread ai_wait_go();
  }

  self.runningtovehicle = [];
  self.usedpositions = [];
  self.getinorgs = [];
  self.delayer = 0;
  vehicleanim = level.vehicle.templates.aianims[classname];

  for(i = 0; i < maxpos; i++) {
    self.usedpositions[i] = 0;

    if(isDefined(self.script_nomg) && self.script_nomg && isDefined(vehicleanim[i].bisgunner) && vehicleanim[i].bisgunner) {
      self.usedpositions[1] = 1;
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
  animtimer = gettime() + getanimlength(animpos.death) * 1000;
  angles = guy.angles;
  origin = guy.origin;
  guy = convert_guy_to_drone(guy);
  detach_models_with_substr(guy, "weapon_");
  guy linkTo(self);
  guy notsolid();
  guy setanim(animpos.death);

  if(isai(guy)) {
    guy script_func("anim_dropallaiweapons");
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

function load_ai(array, bgoddriver, group) {
  self endon("death");
  assert(self.code_classname == "script_vehicle");

  if(array.size) {
    if(!isDefined(bgoddriver)) {
      bgoddriver = 0;
    }

    scripts\engine\utility::ent_flag_clear("unloaded");
    scripts\engine\utility::ent_flag_clear("loaded");
    array_levelthread(array, &get_in_vehicle, bgoddriver, group);
    array_wait(array, "loaded");
  }

  scripts\engine\utility::ent_flag_set("loaded");
}

function is_rider(guy) {
  for(i = 0; i < self.riders.size; i++) {
    if(self.riders[i] == guy) {
      return true;
    }
  }

  return false;
}

function get_in_vehicle(guy, bgoddriver, group) {
  if(is_rider(guy)) {
    return;
  }

  if(!handle_detached_guys_check()) {
    return;
  }

  assertex(isalive(guy), "tried to load a vehicle with dead guy, check your AI count to assure spawnability of ai's");
  guy_runtovehicle(guy, self, bgoddriver, group);
}

function handle_detached_guys_check() {
  if(vehicle_hasavailablespots()) {
    return 1;
  }

  if(!issp()) {
    classname = self.classname_mp;
  } else {
    classname = self.class;
  }

  assertmsg("script sent too many ai to vehicle( max is: " + level.vehicle.templates.aianims[classname].size + " )");
}

function vehicle_hasavailablespots() {
  if(level.vehicle.templates.aianims[get_vehicle_classname()].size - self.runningtovehicle.size) {
    return 1;
  }

  return 0;
}

function guy_runtovehicle_loaded(guy, vehicle) {
  vehicle endon("death");
  vehicle endon("stop_loading");

  if(!getdvarint(@ "hash_9403d7d31fc1d981")) {
    msg = guy waittill_any_return_3("long_death", "death", "enteredvehicle");

    if(msg != "enteredvehicle" && isDefined(guy.forced_startingposition)) {
      vehicle.usedpositions[guy.forced_startingposition] = 0;
    }
  } else if(!guy waitforentervehicle() && isDefined(guy.forced_startingposition)) {
    vehicle.usedpositions[guy.forced_startingposition] = 0;
  }

  vehicle.runningtovehicle = array_remove(vehicle.runningtovehicle, guy);
  vehicle_loaded_if_full(vehicle);
}

function vehicle_loaded_if_full(vehicle) {
  if(isDefined(vehicle.vehicletype) && isDefined(vehicle.vehicle_loaded_notify_size)) {
    if(vehicle.riders.size == vehicle.vehicle_loaded_notify_size) {
      vehicle scripts\engine\utility::ent_flag_set("loaded");
    }

    return;
  }

  if(!vehicle.runningtovehicle.size && vehicle.riders.size) {
    if(vehicle.usedpositions[0]) {
      vehicle scripts\engine\utility::ent_flag_set("loaded");
      return;
    }

    if(!getdvarint(@ "hash_9403d7d31fc1d981")) {
      vehicle thread vehicle_reload();
    }
  }
}

function vehicle_reload() {
  assert(self.riders.size);
  riders = self.riders;
  vehicle_unload();
  scripts\engine\utility::ent_flag_wait("unloaded");
  riders = array_removedead(riders);
  thread vehicle_load_ai(riders);
}

function remove_magic_bullet_shield_from_guy_on_unload_or_death(guy) {
  waittill_any_2("unload", "death");
  guy stop_magic_bullet_shield();
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
      assertex(!isDefined(guy.magic_bullet_shield), "magic_bullet_shield guy told to god mode drive a vehicle, you should simply load_ai without the god function for this guy");
      guy thread magic_bullet_shield();
      thread remove_magic_bullet_shield_from_guy_on_unload_or_death(guy);
    }
  } else if(vehiclepositions.availablepositions.size) {
    chosenorg = getclosest(guy.origin, vehiclepositions.availablepositions);
  } else {
    chosenorg = undefined;
  }

  return chosenorg;
}

function guy_runtovehicle(guy, vehicle, bgoddriver, group) {
  guy endon("stop_loading");
  vehicle endon("stop_loading");
  var_5b0cab0a9420da60 = 1;

  if(!isDefined(bgoddriver)) {
    bgoddriver = 0;
  }

  vehicleanim = level.vehicle.templates.aianims[vehicle get_vehicle_classname()];

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
  bisgettin = getdvarint(@ "hash_9403d7d31fc1d981");

  for(i = 0; i < vehicleanim.size; i++) {
    if(isDefined(vehicleanim[i].getin)) {
      bisgettin = 1;
    }
  }

  if(!bisgettin) {
    guy notify("enteredvehicle");

    if(getdvarint(@ "hash_9403d7d31fc1d981")) {
      chosenorg = choose_vehicle_position(guy, get_availablepositions(group), bgoddriver);
      guy.forced_startingposition = chosenorg.vehicle_position;
      vehicle.usedpositions[chosenorg.vehicle_position] = 1;
      guy entervehicle(self, 1, chosenorg, anim_pos(self, guy.forced_startingposition));
    }

    vehicle guy_enter(guy, var_5b0cab0a9420da60);
    return;
  }

  if(!isDefined(guy.get_in_moving_vehicle)) {
    while(vehicle vehicle_getspeed() > 1) {
      wait 0.05;
    }
  }

  positions = vehicle get_availablepositions(group);

  if(!positions.availablepositions.size && positions.nonanimatedpositions.size) {
    guy notify("enteredvehicle");
    vehicle guy_enter(guy, var_5b0cab0a9420da60);
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

  if(!getdvarint(@ "hash_9403d7d31fc1d981")) {
    guy.script_moveoverride = 1;
    guy notify("stop_going_to_node");
    guy set_forcegoal();
    guy disable_arrivals();
    guy.goalradius = 64;
    guy setgoalpos(origin);
    guy waittill("goal");
    guy enable_arrivals();
    guy unset_forcegoal();
    guy notify("boarding_vehicle");
  } else {
    guy requestentervehicle(self, 0, chosenorg, anim_pos(self, chosenorg.vehicle_position));
    guy waitforarrivedatvehicle();
  }

  animpos = anim_pos(vehicle, chosenorg.vehicle_position);

  if(isDefined(animpos.delay)) {
    guy.delay = animpos.delay;

    if(isDefined(animpos.delayinc)) {
      self.delayer = guy.delay;
    }
  }

  if(isDefined(animpos.delayinc)) {
    self.delayer += animpos.delayinc;
    guy.delay = self.delayer;
  }

  if(!getdvarint(@ "hash_9403d7d31fc1d981")) {
    vehicle link_to_sittag(guy, animpos.sittag, animpos.sittag_origin_offset, animpos.sittag_angles_offset, animpos.linktoblend);
  }

  guy.allowdeath = 0;
  animpos = vehicleanim[chosenorg.vehicle_position];

  if(isDefined(chosenorg)) {
    if(isDefined(animpos.vehicle_getinanim)) {
      var_b92de7d48a424c1c = isDefined(guy.no_vehicle_getoutanim);

      if(!var_b92de7d48a424c1c && !isagent(guy)) {
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
      vehicle thread scripts\common\notetrack::start_notetrack_wait(vehicle, "vehicle_anim_flag", undefined, undefined, animpos.vehicle_getinanim);
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

    if(!getdvarint(@ "hash_9403d7d31fc1d981")) {
      vehicle animontag(guy, animpos.sittag, animpos.getin, getintags, getinthreads, undefined, animpos.sittag_origin_offset, animpos.sittag_angles_offset);
    }
  }

  if(getdvarint(@ "hash_9403d7d31fc1d981")) {
    guy waitforentervehicle();
  }

  guy notify("enteredvehicle");
  vehicle guy_enter(guy, var_5b0cab0a9420da60);
}

function entered_vehicle_notify() {
  self notify("enteredvehicle");
}

function driverdead(guy) {
  if(scripts\common\vehicle::ishelicopter()) {
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
    self setwaitspeed(0);
    self vehicle_setspeed(0, 20, 20);
    self waittill("reached_wait_speed");
  }

  if(!istrue(self.donotunloadondriverdeath)) {
    vehicle_unload();
  }
}

function guy_becomes_real_ai(guy, pos) {
  if(isai(guy)) {
    return guy;
  }

  if(istrue(guy.drone_delete_on_unload)) {
    guy delete();
    return;
  }

  guy = script_func("spawner_makerealai", guy);

  if(utility::issp()) {
    classname = self.classname;
  } else {
    classname = self.classname_mp;
  }

  maxpos = level.vehicle.templates.aianims[classname].size;
  animpos = anim_pos(self, pos);
  link_to_sittag(guy, animpos.sittag, animpos.sittag_origin_offset, animpos.sittag_angles_offset, animpos.linktoblend);
  guy.vehicle_idle = animpos.idle;

  if(!istrue(guy.disable_vehicle_idle)) {
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
  return level.vehicle.templates.aianims[vehicle get_vehicle_classname()][pos];
}

function guy_deathhandle(guy, pos) {
  guy waittill("death");

  if(!isDefined(self)) {
    return;
  }

  self.riders = array_remove(self.riders, guy);
  self.usedpositions[pos] = 0;
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
  thread guy_deathhandle(guy, pos);
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
  totaloccurrance = 0;

  for(i = 0; i < occurrences.size; i++) {
    totaloccurrance += occurrences[i];
    range[i] = totaloccurrance;
  }

  pick = randomint(totaloccurrance);

  for(i = 0; i < occurrences.size; i++) {
    if(pick < range[i]) {
      return i;
    }
  }
}

function guy_unload_watcher(guy) {
  self endon("death");
  wait 50;

  if(isDefined(guy) && array_contains(self.unloadque, guy)) {
    self.unloadque = array_remove(self.unloadque, guy);

    if(!self.unloadque.size) {
      scripts\engine\utility::ent_flag_set("unloaded");
      self.unload_group = "default";
      self function_75feda26550d4f0e();
    }

    guy notify("jumpedout");
  }
}

function guy_unload_que(guy) {
  self endon("death");
  self.unloadque = array_add(self.unloadque, guy);
  guy waittill_any_2("death", "jumpedout");
  self.unloadque = array_remove(self.unloadque, guy);

  if(!self.unloadque.size) {
    scripts\engine\utility::ent_flag_set("unloaded");
    self.unload_group = "default";
    self function_75feda26550d4f0e();
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

function get_unload_group() {
  group = [];
  unloadgroups = [];
  unload_group = "default";

  if(isDefined(self.unload_group)) {
    unload_group = self.unload_group;
  }

  unloadgroups = level.vehicle.templates.unloadgroups[get_vehicle_classname()][unload_group];

  if(!isDefined(unloadgroups)) {
    unloadgroups = level.vehicle.templates.unloadgroups[get_vehicle_classname()]["default"];
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

  classname = get_vehicle_classname();

  if(!isDefined(level.vehicle.templates.unloadgroups[classname])) {
    return true;
  }

  if(!isDefined(level.vehicle.templates.unloadgroups[classname][unload_group])) {
    println("<dev string:x1c>" + self.currentnode.origin + "<dev string:x45>" + unload_group + "<dev string:x55>");
    println("<dev string:x59>");
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

function getoutrig_model_idle(model, tag, animation) {
  self endon("unloading");

  while(true) {
    animontag(model, tag, animation);
  }
}

function getoutrig_model(animpos, model, tag, animation, bidletillunload) {
  classname = get_vehicle_classname();

  if(bidletillunload) {
    thread getoutrig_model_idle(model, tag, level.vehicle.templates.attachedmodels[classname][animpos.fastroperig].idleanim);
    self waittill("unloading");
  }

  self.unloadque = array_add(self.unloadque, model);
  thread getoutrig_abort(model, tag, animation);

  if(!scripts\common\vehicle_code::vehicle_iscrashing()) {
    animontag(model, tag, animation);
  }

  model unlink();

  if(!isDefined(self)) {
    model delete();
    return;
  }

  assert(isDefined(self.unloadque));
  self.unloadque = array_remove(self.unloadque, model);

  if(!self.unloadque.size) {
    self notify("unloaded");
  }

  self.fastroperig[animpos.fastroperig] = undefined;
  wait 10;
  model delete();
}

function getoutrig_model_new(animpos, model, tag, animation, bidletillunload) {
  self endon("death");
  classname = get_vehicle_classname();
  thread delete_on_death(model);
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

  if(bidletillunload) {
    model.origin = startorg;
    model.angles = startangles;
    thread script_func("fastrope_anim", model, xanim, "getoutrigidle");
    scripts\engine\utility::ent_flag_wait("unloaded");
  }

  origin = self gettagorigin(tag);
  angles = self gettagangles(tag);

  if(istrue(self.animintro)) {
    ropeorigin = origin;
    thread getoutrig_abort(model, undefined, animation, ropeorigin);

    if(!scripts\common\vehicle_code::vehicle_iscrashing()) {
      model unlink();
      model.origin = origin;
      model.angles = angles;
      thread script_func("fastrope_anim", model, animation, "getoutrigfall");
    }
  } else {
    moveangles = self.angles - startangles;
    moveangles = (angleclamp(moveangles[0]), angleclamp(moveangles[1]), angleclamp(moveangles[2]));
    traceorigin = rotatevector(tagoffset, moveangles) + self.origin;
    results = ray_trace(traceorigin, traceorigin - (0, 0, 1000), self, create_world_contents());
    ropeheight = traceorigin[2] - 400;

    if(isDefined(results["position"])) {
      ropeheight = results["position"][2];
    }

    ropeorigin = (origin[0], origin[1], ropeheight);

    if(istrue(self.var_e662d8c3659cb3e3)) {
      ropeorigin = (origin[0], origin[1], origin[2]);
    }

    if(istrue(level.vehicle.templates.attachedmodels[classname][animpos.fastroperig].dropusestraceorigin)) {
      ropeorigin = (traceorigin[0], traceorigin[1], ropeheight);
    }

    if(getdvarint(@ "hash_c318492e4a168bb3", 0) == 1) {
      line(traceorigin, traceorigin - (0, 0, 1000), (0, 0, 1), 1, 0, 400);
      sphere(ropeorigin, 4, (0, 1, 0), 0, 400);
    }

    thread getoutrig_abort(model, undefined, animation, ropeorigin);

    if(!scripts\common\vehicle_code::vehicle_iscrashing()) {
      model unlink();
      model.origin = ropeorigin;
      thread script_func("fastrope_anim", model, animation, "getoutrigfall");
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

  if(!isalive(self) || scripts\common\vehicle_code::vehicle_iscrashing()) {
    return;
  }

  self notify("getoutrig_disable_abort");
}

function getoutrig_abort_while_deploying() {
  self endon("end_getoutrig_abort_while_deploying");

  while(!scripts\common\vehicle_code::vehicle_iscrashing()) {
    wait 0.05;
  }

  updatedriders = [];

  foreach(rider in self.riders) {
    if(isalive(rider)) {
      array_add_safe(updatedriders, rider);
    }
  }

  array_delete(updatedriders);
  self notify("crashed_while_deploying");
  updatedriders = undefined;
}

function getoutrig_abort(model, tag, animation, ropeorigin) {
  totalanimtime = getanimlength(animation);
  ropesfallanimtime = totalanimtime - 1;

  if(self.vehicletype == "mi17") {
    ropesfallanimtime = totalanimtime - 0.5;
  }

  ropesdeployedanimtime = 0.8;
  assert(totalanimtime > ropesdeployedanimtime);
  assert(ropesfallanimtime - ropesdeployedanimtime > 0);
  self endon("getoutrig_disable_abort");
  thread getoutrig_disable_abort_notify_after_riders_out();
  thread getoutrig_abort_while_deploying();
  waittill_notify_or_timeout("crashed_while_deploying", ropesdeployedanimtime);
  self notify("end_getoutrig_abort_while_deploying");

  while(!isDefined(self.vehiclecrashing)) {
    waitframe();
  }

  if(isDefined(model)) {
    if(!isDefined(tag) && isDefined(ropeorigin)) {
      model unlink();
      model.origin = ropeorigin;

      if(!issp()) {
        if(iscp()) {} else {
          animindex = model scripts\asm\asm::asm_lookupanimfromalias("animscripted", animation);
          xanim = model scripts\asm\asm::asm_getxanim("animscripted", animindex);
          startorg = getstartorigin(self.origin, self.angles, xanim);
          startangles = getstartangles(self.origin, self.angles, xanim);
          model dontinterpolate();
          model forceteleport(startorg, startangles);
          model animmode("nogravity");
          model aisetanim("animscripted", animindex);
        }
      } else {
        model animScripted("getoutrigfall", model.origin, model.angles, animation, undefined, undefined, 0);
      }
    } else {
      thread animontag(model, tag, animation);
    }

    waittillframeend();

    if(!iscp()) {
      model setanimtime(animation, ropesfallanimtime / totalanimtime);
    }
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
  thread script_func("vehicle_door_anim", self, vehicle_anim);
  wait cycletime;

  if(utility::issp() && bclearanim) {
    self clearanim(vehicle_anim, 0);
  }
}

#using_animtree("script_model");

function getout_rigspawn(animatemodel, animpos, bidletillunload) {
  if(!isDefined(bidletillunload)) {
    bidletillunload = 1;
  }

  classname = get_vehicle_classname();

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

  if(getdvarint(@ "hash_9403d7d31fc1d981")) {
    thread getoutrig_model_new(animpos, getoutrig_model, level.vehicle.templates.attachedmodels[classname][animpos.fastroperig].tag, level.vehicle.templates.attachedmodels[classname][animpos.fastroperig].dropanim, bidletillunload);
  } else {
    thread getoutrig_model(animpos, getoutrig_model, level.vehicle.templates.attachedmodels[classname][animpos.fastroperig].tag, level.vehicle.templates.attachedmodels[classname][animpos.fastroperig].dropanim, bidletillunload);
  }

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
  vehicleanim = level.vehicle.templates.aianims[get_vehicle_classname()];
  animatemodel = getanimatemodel();

  if(!isDefined(vehicle_getoutanim)) {
    vehicle_getoutanim = animpos.vehicle_getoutanim;
  }

  if(!isDefined(vehicle_getoutanim_clear)) {
    vehicle_getoutanim_clear = animpos.vehicle_getoutanim_clear;
  }

  if(isDefined(vehicle_getoutanim)) {
    animatemodel thread setanimrestart_once(vehicle_getoutanim, vehicle_getoutanim_clear);
    sound_tag_dupped = 0;

    if(isDefined(animpos.vehicle_getoutsoundtag)) {
      sound_tag_dupped = check_sound_tag_dupe(animpos.vehicle_getoutsoundtag);
      origin = animatemodel gettagorigin(animpos.vehicle_getoutsoundtag);
    } else {
      origin = animatemodel.origin;
    }

    if(isDefined(animpos.vehicle_getoutsound) && !sound_tag_dupped) {
      playsoundatpos(origin, animpos.vehicle_getoutsound);
    }

    sound_tag_dupped = undefined;
  }
}

function vehicle_end_loop_sounds(guy, pos) {
  animpos = anim_pos(self, pos);

  if(isDefined(guy.playerpiggyback) && isDefined(animpos.player_getout_sound_loop)) {
    level.player thread script_func("playloopsound_on_entity", animpos.player_getout_sound_loop);
  }

  if(isDefined(animpos.getoutloopsnd)) {
    guy thread script_func("playloopsound_on_entity", animpos.getoutloopsnd);
  }

  if(isDefined(guy.playerpiggyback) && isDefined(animpos.player_getout_sound_end)) {
    level.player thread script_func("playsound_on_entity", animpos.player_getout_sound_end);
  }
}

function prepdoorsforunload() {
  if(self function_8fa29bf693c94b27()) {
    return;
  }

  for(i = 0; i < level.vehicle.templates.aianims[get_vehicle_classname()].size; i++) {
    animpos = level.vehicle.templates.aianims[get_vehicle_classname()][i];

    if(isDefined(animpos.vehicle_getoutanim)) {
      anim_name = getanimname(animpos.vehicle_getoutanim);
      self function_d043dd116c449128(anim_name);
    }
  }
}

function wait_for_open_door(guy, animpos) {
  guy endon("jumpedout");
  guy endon("death");
  self endon("death");
  prepdoorsforunload();

  while(!istrue(guy.requestopendoor)) {
    waitframe();
  }

  if(isDefined(animpos.vehicle_getoutanim)) {
    anim_name = getanimname(animpos.vehicle_getoutanim);

    if(!self function_6d897c252a37c080(anim_name)) {
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
      self function_dcec5ea95982c90c(anim_name, 1);
    }

    if(isDefined(animpos.fastroperig) && !isDefined(self.fastroperig[animpos.fastroperig])) {
      animatemodel = getanimatemodel();
      getoutrig_model = getout_rigspawn(animatemodel, animpos, 1);
    }
  }
}

function guy_setup_rope(guy, animpos) {
  if(isDefined(animpos.fastroperig)) {
    thread wait_for_open_door(guy, animpos);
    guy setuprope();
    return;
  }

  assertmsg("Guy is assigned to setup helicopter exit rope, but is missing a fastroperig.");
}

function guy_unload(guy, pos) {
  isvehicle = 0;

  if(isDefined(guy.isvehicle)) {
    isvehicle = 1;
  }

  animpos = anim_pos(self, pos);
  type = self.vehicletype;

  if(!check_unloadgroup(pos)) {
    if(!getdvarint(@ "hash_9403d7d31fc1d981")) {
      thread guy_idle(guy, pos);
    }

    return;
  }

  if(!getdvarint(@ "hash_9403d7d31fc1d981") && !isDefined(animpos.getout)) {
    thread guy_idle(guy, pos);
    return;
  }

  thread guy_unload_que(guy);

  if(!issp()) {
    thread guy_unload_watcher(guy);
  }

  self endon("death");

  if(isai(guy) && isalive(guy)) {
    guy endon("death");
  }

  bnoanimunload = 0;

  if(isDefined(guy.getoffvehiclefunc)) {
    var_f5b7a13c571f124c = guy[[guy.getoffvehiclefunc]]();

    if(isDefined(var_f5b7a13c571f124c) && var_f5b7a13c571f124c) {
      bnoanimunload = 1;
    }
  }

  if(isDefined(guy.onrotatingvehicleturret)) {
    guy.onrotatingvehicleturret = undefined;

    if(isDefined(guy.getoffvehiclefunc)) {
      guy[[guy.getoffvehiclefunc]]();
    }
  }

  if(!getdvarint(@ "hash_9403d7d31fc1d981")) {
    vehicle_play_exit_anim(animpos);
    delay = 0;

    if(isDefined(animpos.getout_timed_anim)) {
      delay += getanimlength(animpos.getout_timed_anim);
    }

    if(isDefined(animpos.delay)) {
      delay += animpos.delay;
    }

    if(isDefined(guy.delay)) {
      delay += guy.delay;
    }

    if(delay > 0) {
      if(!getdvarint(@ "hash_9403d7d31fc1d981")) {
        thread guy_idle(guy, pos);
      }

      wait delay;
    }
  }

  if(!getdvarint(@ "hash_9403d7d31fc1d981")) {
    guy.deathanim = undefined;
    guy.deathanimscript = undefined;
  }

  guy notify("newanim");

  if(isDefined(animpos.bhasgunwhileriding) && !animpos.bhasgunwhileriding) {
    if(!isDefined(guy.disable_gun_recall)) {
      guy gun_recall();
    }
  }

  if(isai(guy)) {
    guy pushplayer(1);
  }

  if(isDefined(animpos.bnoanimunload)) {
    bnoanimunload = 1;
  } else if(!getdvarint(@ "hash_9403d7d31fc1d981") && !isDefined(animpos.getout) || !isDefined(self.script_unloadmgguy) && isDefined(animpos.bisgunner) && animpos.bisgunner || isDefined(self.script_keepdriver) && pos == 0) {
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
  } else if(scripts\engine\utility::ent_flag("landed") && isDefined(animpos.getout_landed)) {
    animation = animpos.getout_landed;
  } else if(isDefined(guy.playerpiggyback) && isDefined(animpos.player_getout)) {
    animation = animpos.player_getout;
  } else {
    animation = animpos.getout;
  }

  if(!bnoanimunload) {
    if(!getdvarint(@ "hash_9403d7d31fc1d981")) {
      thread guy_unlink_on_death(guy);
    }

    if(!getdvarint(@ "hash_9403d7d31fc1d981") && isDefined(animpos.fastroperig)) {
      if(!isDefined(self.fastroperig[animpos.fastroperig])) {
        if(!getdvarint(@ "hash_9403d7d31fc1d981")) {
          thread guy_idle(guy, pos);
        }

        animatemodel = getanimatemodel();
        getoutrig_model = getout_rigspawn(animatemodel, animpos, 1);
      }
    }

    if(isDefined(animpos.getoutsnd)) {
      guy thread script_func("playsound_on_tag", animpos.getoutsnd, "J_Wrist_RI", 1);
    }

    if(isDefined(guy.playerpiggyback) && isDefined(animpos.player_getout_sound)) {
      guy thread script_func("playsound_on_tag", animpos.player_getout_sound);
    }

    if(isDefined(animpos.getoutloopsnd)) {
      guy thread script_func("playloopsound_on_tag", animpos.getoutloopsnd);
    }

    if(isDefined(guy.playerpiggyback) && isDefined(animpos.player_getout_sound_loop)) {
      level.player thread script_func("playloopsound_on_tag", animpos.player_getout_sound_loop);
    }

    guy notify("newanim");
    guy notify("jumping_out");
    var_c87c13106eca1f = 0;

    if(!isai(guy) && !isvehicle) {
      var_c87c13106eca1f = 1;
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

    if(var_c87c13106eca1f) {
      self.riders = array_add(self.riders, guy);
      thread guy_deathhandle(guy, pos);
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
      secondaryunloadtag = tag;

      if(isDefined(animpos.getout_secondary_tag)) {
        secondaryunloadtag = animpos.getout_secondary_tag;
      }

      animontag(guy, secondaryunloadtag, animpos.getout_secondary, undefined, undefined, undefined, animpos.sittag_origin_offset, animpos.sittag_angles_offset);
    } else {
      hoverunload = 0;

      if(isDefined(animpos.getout_hover_loop) && isDefined(animpos.getout_hover_land)) {
        thread guy_unload_land(guy, tag, animpos.getout, animpos.getout_hover_loop, animpos.getout_hover_land);
        hoverunload = 1;
      } else if(!isvehicle) {
        guy.anim_end_early = 1;
      }

      if(!getdvarint(@ "hash_9403d7d31fc1d981")) {
        animontag(guy, tag, animation, undefined, undefined, undefined, animpos.sittag_origin_offset, animpos.sittag_angles_offset);
      } else {
        thread wait_for_open_door(guy, animpos);
        guy exitvehicle();
      }

      if(hoverunload) {
        guy waittill("hoverunload_done");
      }
    }

    if(isDefined(guy.playerpiggyback) && isDefined(animpos.player_getout_sound_loop)) {
      level.player thread stop_loop_sound_on_entity(animpos.player_getout_sound_loop);
    }

    if(isDefined(animpos.getoutloopsnd)) {
      guy thread stop_loop_sound_on_entity(animpos.getoutloopsnd);
    }

    if(isDefined(guy.playerpiggyback) && isDefined(animpos.player_getout_sound_end)) {
      level.player thread script_func("playsound_on_entity", animpos.player_getout_sound_end);
    }
  } else if(!isai(guy)) {
    if(istrue(guy.drone_delete_on_unload)) {
      guy delete();
      return;
    }

    guy = script_func("spawner_makerealai", guy);
  }

  self.riders = array_remove(self.riders, guy);
  self.usedpositions[pos] = 0;
  guy.ridingvehicle = undefined;
  guy.drivingvehicle = undefined;

  if(!isalive(self) && !isDefined(animpos.unload_ondeath)) {
    guy delete();
    return;
  }

  if(!getdvarint(@ "hash_9403d7d31fc1d981")) {
    guy unlink();
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
        guy thread script_func("anim_updateanimpose");
        guy allowedstances("stand", "crouch", "prone");
      }

      guy pushplayer(0);
      guy notify("pushplayerchanged");
    } else if(isvehicle) {
      guy.vspawner.origin = guy.origin;
      guy.vspawner.angles = guy.angles;

      if(isDefined(guy.vspawner.target)) {
        guy.vspawner spawn_vehicle_and_gopath();
      } else {
        realvehicle = guy.vspawner utility::spawn_vehicle();
      }

      guy delete();
    }

    if(!getdvarint(@ "hash_9403d7d31fc1d981")) {
      guy notify("jumpedout");
    }
  }

  if(isDefined(guy.script_noteworthy) && guy.script_noteworthy == "delete_after_unload") {
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
  ent = spawn_tag_origin();
  ent.origin = startorigin;
  ent.angles = startangles;
  endorigin = ent localtoworldcoords(move_delta);
  ent thread delete_on_notify("movedone");
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
    guy script_func("asm_animcustom", &guy_fall_loop, &guy_fall_loop_end);
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
    if(actor_is3d()) {
      self orientmode("face angle 3d", self.angles);
    } else {
      self orientmode("face angle", self.angles[1]);
    }

    self animmode("zonly_physics", 1);
    self clearanim(scripts\asm\asm::asm_getbodyknob(), 0.2);
  }

  self setanim(self.unload_loopanim, 1);
  self waittill("dropship_land");
}

function guy_fall_loop_end() {}

function guy_resets_goalpos(guy) {
  if(isDefined(guy.script_delayed_playerseek)) {
    return false;
  }

  if(istrue(guy script_func("ai_has_color"))) {
    return false;
  }

  if(isDefined(guy.qsetgoalpos)) {
    return false;
  }

  if(!isDefined(guy.target)) {
    return true;
  }

  nodes = getnodearray(guy.target, "targetname");
  structs = getStructArray(guy.target, "targetname");

  if(nodes.size > 0 || structs.size > 0) {
    return false;
  }

  ent = getEnt(guy.target, "targetname");

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

  if(!isDefined(tag) || !hastag(animatemodel.model, tag)) {
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

  if(!issp()) {
    guy dontinterpolate();

    if(isai(guy)) {
      animindex = guy scripts\asm\asm::asm_lookupanimfromalias("animscripted", animation);
      xanim = guy scripts\asm\asm::asm_getxanim("animscripted", animindex);
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
  vehicleallreadydead = vehicle.health <= 0;

  while(true) {
    if(!vehicleallreadydead && !(isDefined(vehicle) && vehicle.health > 0)) {
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
      guy thread script_func("playsound_on_entity", "generic_death_falling");
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
    guy script_func("anim_dropallaiweapons");
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
  guy script_func("anim_donotetracks", flag);
}

function animatemoveintoplace(guy, org, angles, movetospotanim) {
  guy animScripted("movetospot", org, angles, movetospotanim);
  guy waittillmatch("movetospot", "end");
}

function guy_vehicle_death(guy, attacker) {
  assert(!getdvarint(@ "hash_9403d7d31fc1d981"));

  if(!isalive(guy)) {
    return;
  }

  if(isDefined(self.no_rider_death)) {
    return;
  }

  animpos = anim_pos(self, guy.vehicle_position);

  if(isDefined(animpos.explosion_death)) {
    return guy_blowup(guy);
  }

  classname = get_vehicle_classname();

  if(isDefined(level.vehicle.templates.rider_death_func) && isDefined(level.vehicle.templates.rider_death_func[classname])) {
    self[[level.vehicle.templates.rider_death_func[classname]]]();
    return;
  }

  if(isDefined(animpos.unload_ondeath) && isDefined(self)) {
    if(isDefined(self.dontunloadondeath) && self.dontunloadondeath) {
      return;
    }

    thread guy_idle(guy, guy.vehicle_position, 1);
    wait animpos.unload_ondeath;

    if(isDefined(guy) && isDefined(self)) {
      self.groupedanim_pos = guy.vehicle_position;
      animate_guys("unload");
    }

    return;
  }

  if(isDefined(guy)) {
    if(isDefined(guy.ragdoll_getout_death)) {
      return;
    }

    assertex(!isDefined(guy.magic_bullet_shield), "<dev string:x6d>" + guy getentitynumber());
    guy delete();
  }
}

function ai_wait_go() {
  self endon("death");
  self waittill("loaded");
  scripts\common\vehicle_paths::gopath(self);
}

function set_pos(guy, vehicleanim) {
  pos = guy.script_startingposition;

  if(isDefined(pos)) {
    assertex(pos < vehicleanim.size && pos >= 0, "<dev string:xa9>" + vehicleanim.size - 1);
  }

  if(isDefined(guy.forced_startingposition)) {
    pos = guy.forced_startingposition;
  }

  if(isDefined(pos)) {
    return pos;
  }

  assertex(!isDefined(pos), "Illegal starting position");

  for(j = 0; j < self.usedpositions.size; j++) {
    if(self.usedpositions[j]) {
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
    assertmsg("No vehicle (linked vehicles like cargo) positions were found.");
    return;
  }

  assertmsg("All spots on this vehicle were used up, too many AI trying to ride.");
}

function guy_man_turret(guy, pos, var_5b0cab0a9420da60) {
  animpos = anim_pos(self, pos);
  turret = self.mgturret[animpos.mgturret];

  if(!isalive(guy)) {
    return;
  }

  turret endon("death");
  guy endon("death");

  if(isDefined(var_5b0cab0a9420da60) && var_5b0cab0a9420da60 && isDefined(animpos.passenger_2_turret_func)) {
    [[animpos.passenger_2_turret_func]](self, guy, pos, turret);
  }

  set_turret_team(turret);
  turret setdefaultdroppitch(0);
  wait 0.1;
  guy endon("guy_man_turret_stop");
  level thread vehicle_turret_difficulty(turret, utility::getdifficulty());
  turret self_func("setturretignoregoals", 1);
  pose = "stand";

  if(isDefined(animpos.turretpos)) {
    pose = animpos.turretpos;
  }

  guy scripts\asm\asm_bb::bb_requestturret(turret);
}

function guy_unlink_on_death(guy) {
  guy endon("jumpedout");
  guy waittill("death");

  if(isDefined(guy)) {
    guy unlink();
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

  if(getDvar(@ "ragdoll_enable") == "0") {
    guy delete();
    return;
  }

  if(isai(guy)) {
    guy script_func("anim_dropallaiweapons");
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

function convert_guy_to_drone(guy, bkeepguy) {
  if(!isDefined(bkeepguy)) {
    bkeepguy = 0;
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

  if(!bkeepguy) {
    guy delete();
  }

  model self_func("makefakeai");
  return model;
}

function vehicle_animate(animation, animtree) {
  self useanimtree(animtree);
  self setanim(animation);
}

function vehicle_getinstart(pos) {
  animpos = anim_pos(self, pos);
  assert(isDefined(animpos));
  assert(isDefined(animpos.sittag));
  assert(getdvarint(@ "hash_9403d7d31fc1d981") || isDefined(animpos.getin));
  return vehicle_getanimstart(animpos.getin, animpos.sittag, pos, animpos.canshootinvehicle);
}

function vehicle_getanimstart(animation, tag, pos, canshootinvehicle) {
  struct = spawnStruct();
  origin = undefined;
  angles = undefined;
  assert(getdvarint(@ "hash_9403d7d31fc1d981") || isDefined(animation));
  org = self gettagorigin(tag);
  ang = self gettagangles(tag);

  if(!getdvarint(@ "hash_9403d7d31fc1d981") || isDefined(animation)) {
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

  classname = vehicle get_vehicle_classname();
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
  vehicleanim = level.vehicle.templates.aianims[get_vehicle_classname()];
  availablepositions = [];
  nonanimatedpositions = [];

  for(i = 0; i < self.usedpositions.size; i++) {
    if(self.usedpositions[i]) {
      continue;
    }

    if((getdvarint(@ "hash_9403d7d31fc1d981") || isDefined(vehicleanim[i].getin)) && is_position_in_group(self, i, group)) {
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
  if(isDefined(self.modeldummy)) {
    return self.modeldummy;
  }

  return self;
}

function detach_models_with_substr(guy, substr) {
  size = guy getattachsize();
  modelstodetach = [];
  tagsstodetach = [];
  index = 0;

  for(i = 0; i < size; i++) {
    modelname = guy getattachmodelname(i);
    tagname = guy getattachtagname(i);

    if(issubstr(modelname, substr)) {
      modelstodetach[index] = modelname;
      tagsstodetach[index] = tagname;
    }
  }

  for(i = 0; i < modelstodetach.size; i++) {
    guy detach(modelstodetach[i], tagsstodetach[i]);
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

function animate_guys(other) {
  return_guys = [];

  foreach(guy in self.riders) {
    if(isai(guy) && !isalive(guy)) {
      continue;
    }

    if(isDefined(level.vehicle.aianimcheck[other]) && ![[level.vehicle.aianimcheck[other]]](guy, guy.vehicle_position)) {
      continue;
    }

    if(isDefined(level.vehicle.aianimthread[other])) {
      guy notify("newanim");
      thread[[level.vehicle.aianimthread[other]]](guy, guy.vehicle_position);
      return_guys[return_guys.size] = guy;
      continue;
    }

    println("<dev string:xeb>", other);
  }

  return return_guys;
}

function guy_cleanup_vehiclevars() {
  self.vehicle_idling = undefined;
  self.standing = undefined;
  self.vehicle_position = undefined;
  self.delay = undefined;
}