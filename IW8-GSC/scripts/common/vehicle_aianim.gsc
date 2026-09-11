/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\vehicle_aianim.gsc
***********************************************/

function guy_enter(var_0, var_1) {
  var_0 endon("death_or_disconnect");

  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  if(!isDefined(self.vehicletype)) {
    return;
  }

  var_2 = scripts\common\vehicle_code::get_vehicle_classname();
  var_3 = level.vehicle.templates.aianims[var_2];
  self.attachedguys[self.attachedguys.size] = var_0;
  var_4 = set_pos(var_0, var_3);

  if(!isDefined(var_4)) {
    return;
  }

  if(var_4 == 0) {
    var_0.drivingvehicle = 1;
  }

  var_5 = anim_pos(self, var_4);
  self.usedpositions[var_4] = 1;
  var_0.vehicle_position = var_4;
  var_0.vehicle_idling = 0;

  if(isDefined(var_5.delay)) {
    var_0.delay = var_5.delay;

    if(isDefined(var_5.delayinc)) {
      self.delayer = var_0.delay;
    }
  }

  if(isDefined(var_5.delayinc)) {
    self.delayer += var_5.delayinc;
    var_0.delay = self.delayer;
  }

  var_0.ridingvehicle = self;
  var_0.orghealth = var_0.health;
  var_0.vehicle_idle = var_5.idle;
  var_0.vehicle_standattack = var_5.standattack;

  if(!getdvarint("enable_vehicle_ai_using_BT")) {
    var_0.deathanim = var_5.death;
    var_0.deathanimscript = var_5.deathscript;
  }

  var_0.standing = 0;
  var_0.allowdeath = 1;

  if(!getdvarint("enable_vehicle_ai_using_BT")) {
    if(isDefined(var_0.deathanim) && !isDefined(var_0.magic_bullet_shield) && vehicle_allows_rider_death()) {
      if(var_0.vehicle_position != 0 || vehicle_allows_driver_death()) {
        var_0.allowdeath = !isDefined(var_0.script_allowdeath) || var_0.script_allowdeath;

        if(isDefined(var_5.death_no_ragdoll)) {
          var_0.noragdoll = var_5.death_no_ragdoll;
        }
      }
    }
  } else if(!isDefined(var_0.magic_bullet_shield) && vehicle_allows_rider_death()) {
    var_0.allowdeath = !isDefined(var_0.script_allowdeath) || var_0.script_allowdeath;

    if(isDefined(var_5.death_no_ragdoll)) {
      var_0.noragdoll = var_5.death_no_ragdoll;
    }
  }

  if(!isDefined(var_0.classname)) {
    return;
  }

  if(var_0.classname == "script_model") {
    if(isDefined(var_5.death) && var_0.allowdeath && (!isDefined(var_0.script_allowdeath) || var_0.script_allowdeath)) {
      thread guy_death(var_0, var_5);
    }
  }

  self.riders[self.riders.size] = var_0;

  if(var_0.classname != "script_model" && scripts\common\ai::spawn_failed(var_0)) {
    return;
  }

  var_6 = self gettagorigin(var_5.sittag);
  var_7 = self gettagangles(var_5.sittag);

  if(!getdvarint("enable_vehicle_ai_using_BT")) {
    link_to_sittag(var_0, var_5.sittag, var_5.sittag_origin_offset, var_5.sittag_angles_offset, var_5.linktoblend);
  } else if(!var_0 scripts\vehicle\vehicle_common::hasvehicle()) {
    var_8 = vehicle_getinstart(var_4);
    var_0 scripts\vehicle\vehicle_common::entervehicle(self, 1, var_8, var_5);
  }

  if(isai(var_0)) {
    if(!getdvarint("enable_vehicle_ai_using_BT")) {
      var_0 forceteleport(var_6, var_7);
    }

    if(isDefined(var_0.a)) {
      var_0.a.disablelongdeath = 1;
    }

    if(isDefined(var_5.bhasgunwhileriding) && !var_5.bhasgunwhileriding) {
      var_0 scripts\common\ai::gun_remove();
    }

    if(guy_should_man_turret(var_5)) {
      thread guy_man_turret(var_0, var_4, var_1);
    }
  } else {
    if(isDefined(var_5.bhasgunwhileriding) && !var_5.bhasgunwhileriding) {
      detach_models_with_substr(var_0, "weapon_");
    }

    var_0.origin = var_6;
    var_0.angles = var_7;
  }

  if(var_4 == 0) {
    self.driver = var_0;

    if(getdvarint("enable_vehicle_ai_using_BT") || isDefined(var_3[0].death)) {
      thread driverdead(var_0);
    }
  }

  self notify("guy_entered", var_0, var_4);
  var_0 notify("loaded");
  scripts\engine\utility::ent_flag_clear("unloaded");
  thread guy_handle(var_0, var_4);

  if(isDefined(var_5.rider_func)) {
    var_0[[var_5.rider_func]]();
    return;
  }

  if(!getdvarint("enable_vehicle_ai_using_BT")) {
    if(isDefined(var_5.getin_idle_func)) {
      GscBinSkip1(0x74, var_5.getin_idle_func, var_0, var_4);
    }

    thread guy_idle(var_0, var_4);
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

function guy_should_man_turret(var_0) {
  if(!isDefined(var_0.mgturret)) {
    return false;
  }

  if(!isDefined(self.script_nomg)) {
    return true;
  }

  return !self.script_nomg;
}

function handle_attached_guys() {
  var_0 = scripts\common\vehicle_code::get_vehicle_classname();
  self.attachedguys = [];

  if(!(isDefined(level.vehicle.templates.aianims) && isDefined(level.vehicle.templates.aianims[var_0]))) {
    return;
  }

  var_1 = level.vehicle.templates.aianims[var_0].size;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "ai_wait_go") {
    thread ai_wait_go();
  }

  self.runningtovehicle = [];
  self.usedpositions = [];
  self.getinorgs = [];
  self.delayer = 0;
  var_2 = level.vehicle.templates.aianims[var_0];

  for(var_3 = 0; var_3 < var_1; var_3++) {
    self.usedpositions[var_3] = 0;

    if(isDefined(self.script_nomg) && self.script_nomg && isDefined(var_2[var_3].bisgunner) && var_2[var_3].bisgunner) {
      self.usedpositions[1] = 1;
    }
  }
}

function load_ai_goddriver(var_0) {
  load_ai(var_0, 1);
}

function guy_death(var_0, var_1) {
  waittillframeend();
  var_0 setCanDamage(1);
  var_0 endon("death");
  var_0.allowdeath = 0;
  var_0.health = 10150;

  if(isDefined(var_0.script_startinghealth)) {
    var_0.health += var_0.script_startinghealth;
  }

  var_0 endon("jumping_out");

  if(isDefined(var_0.magic_bullet_shield) && var_0.magic_bullet_shield) {
    while(isDefined(var_0.magic_bullet_shield) && var_0.magic_bullet_shield) {
      wait 0.05;
    }
  }

  while(var_0.health > 10000) {
    var_0 waittill("damage");
  }

  thread guy_deathimate_me(var_0, var_1);
}

function guy_deathimate_me(var_0, var_1) {
  var_2 = gettime() + getanimlength(var_1.death) * 1000;
  var_3 = var_0.angles;
  var_4 = var_0.origin;
  var_0 = convert_guy_to_drone(var_0);
  detach_models_with_substr(var_0, "weapon_");
  var_0 linkTo(self);
  var_0 notsolid();
  var_0 setanim(var_1.death);

  if(isai(var_0)) {
    var_0 scripts\engine\utility::script_func("anim_dropallaiweapons");
  } else {
    detach_models_with_substr(var_0, "weapon_");
  }

  if(isDefined(var_1.death_delayed_ragdoll)) {
    var_0 unlink();

    if(isDefined(var_0.fnpreragdoll)) {
      var_0[[var_0.fnpreragdoll]]();
    }

    var_0 startragdoll();
    wait var_1.death_delayed_ragdoll;
    var_0 delete();
    return;
  }
}

function load_ai(var_0, var_1, var_2) {
  self endon("death");

  if(var_0.size) {
    if(!isDefined(var_1)) {
      var_1 = 0;
    }

    scripts\engine\utility::ent_flag_clear("unloaded");
    scripts\engine\utility::ent_flag_clear("loaded");
    scripts\engine\utility::array_levelthread(var_0, &get_in_vehicle, var_1, var_2);
    scripts\engine\utility::array_wait(var_0, "loaded");
  }

  scripts\engine\utility::ent_flag_set("loaded");
}

function is_rider(var_0) {
  for(var_1 = 0; var_1 < self.riders.size; var_1++) {
    if(self.riders[var_1] == var_0) {
      return true;
    }
  }

  return false;
}

function get_in_vehicle(var_0, var_1, var_2) {
  if(is_rider(var_0)) {
    return;
  }

  if(!handle_detached_guys_check()) {
    return;
  }

  guy_runtovehicle(var_0, self, var_1, var_2);
}

function handle_detached_guys_check() {
  if(vehicle_hasavailablespots()) {
    return 1;
  }

  if(!scripts\common\utility::issp()) {
    var_0 = self.classname_mp;
    return;
  }

  var_0 = self.class;
}

function vehicle_hasavailablespots() {
  if(level.vehicle.templates.aianims[scripts\common\vehicle_code::get_vehicle_classname()].size - self.runningtovehicle.size) {
    return 1;
  }

  return 0;
}

function guy_runtovehicle_loaded(var_0, var_1) {
  var_1 endon("death");
  var_1 endon("stop_loading");

  if(!getdvarint("enable_vehicle_ai_using_BT")) {
    var_2 = var_0 scripts\engine\utility::ref_143ae("long_death", "death", "enteredvehicle");

    if(var_2 != "enteredvehicle" && isDefined(var_0.forced_startingposition)) {
      var_1.usedpositions[var_0.forced_startingposition] = 0;
    }
  } else if(!var_0 scripts\vehicle\vehicle_common::waitforentervehicle() && isDefined(var_0.forced_startingposition)) {
    var_1.usedpositions[var_0.forced_startingposition] = 0;
  }

  var_1.runningtovehicle = scripts\engine\utility::array_remove(var_1.runningtovehicle, var_0);
  vehicle_loaded_if_full(var_1);
}

function vehicle_loaded_if_full(var_0) {
  if(isDefined(var_0.vehicletype) && isDefined(var_0.vehicle_loaded_notify_size)) {
    if(var_0.riders.size == var_0.vehicle_loaded_notify_size) {
      var_0 scripts\engine\utility::ent_flag_set("loaded");
      return;
    }

    return;
  }

  if(!var_0.runningtovehicle.size && var_0.riders.size) {
    if(var_0.usedpositions[0]) {
      var_0 scripts\engine\utility::ent_flag_set("loaded");
      return;
    }

    if(!getdvarint("enable_vehicle_ai_using_BT")) {
      thread vehicle_reload();
      return;
    }

    return;
  }
}

function vehicle_reload() {
  var_0 = self.riders;
  scripts\common\vehicle::vehicle_unload();
  scripts\engine\utility::ent_flag_wait("unloaded");
  var_0 = scripts\engine\utility::array_removedead(var_0);
  thread scripts\common\vehicle::vehicle_load_ai(var_0);
}

function remove_magic_bullet_shield_from_guy_on_unload_or_death(var_0) {
  scripts\engine\utility::ref_143a5("unload", "death");
  var_0 scripts\common\ai::stop_magic_bullet_shield();
}

function choose_vehicle_position(var_0, var_1, var_2) {
  var_0 endon("stop_loading");
  self endon("stop_loading");

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_3 = undefined;
  var_4 = 0;

  if(isDefined(var_0.script_startingposition)) {
    var_3 = vehicle_getinstart(var_0.script_startingposition);
  } else if(!self.usedpositions[0]) {
    var_3 = vehicle_getinstart(0);

    if(var_2) {
      var_0 thread scripts\common\ai::magic_bullet_shield();
      thread remove_magic_bullet_shield_from_guy_on_unload_or_death(var_0);
    }
  } else if(var_1.availablepositions.size) {
    var_3 = scripts\engine\utility::getclosest(var_0.origin, var_1.availablepositions);
  } else {
    var_3 = undefined;
  }

  return var_3;
}

function guy_runtovehicle(var_0, var_1, var_2, var_3) {
  var_0 endon("stop_loading");
  var_1 endon("stop_loading");
  var_4 = 1;

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_5 = level.vehicle.templates.aianims[var_1 scripts\common\vehicle_code::get_vehicle_classname()];

  if(isDefined(var_1.runtovehicleoverride)) {
    var_1 thread[[var_1.runtovehicleoverride]](var_0);
    return;
  }

  var_1 endon("death");
  var_0 endon("death");
  var_1.runningtovehicle[var_1.runningtovehicle.size] = var_0;
  thread guy_runtovehicle_loaded(var_0, var_1);
  var_6 = [];
  var_7 = undefined;
  var_8 = 0;
  var_9 = getdvarint("enable_vehicle_ai_using_BT");

  for(var_10 = 0; var_10 < var_5.size; var_10++) {
    if(isDefined(var_5[var_10].getin)) {
      var_9 = 1;
    }
  }

  if(!var_9) {
    var_0 notify("enteredvehicle");

    if(getdvarint("enable_vehicle_ai_using_BT")) {
      var_7 = choose_vehicle_position(var_0, get_availablepositions(var_3), var_2);
      var_0.forced_startingposition = var_7.vehicle_position;
      var_1.usedpositions[var_7.vehicle_position] = 1;
      var_0 scripts\vehicle\vehicle_common::entervehicle(self, 1, var_7, anim_pos(self, var_0.forced_startingposition));
    }

    guy_enter(var_1, var_0, var_4);
    return;
  }

  if(!isDefined(var_0.get_in_moving_vehicle)) {
    while(var_1 vehicle_getspeed() > 1) {
      wait 0.05;
    }
  }

  var_11 = get_availablepositions(var_1, var_3);

  if(!var_11.availablepositions.size && var_11.nonanimatedpositions.size) {
    var_0 notify("enteredvehicle");
    guy_enter(var_1, var_0, var_4);
    return;
  }

  var_7 = choose_vehicle_position(var_0, var_11, var_2);

  if(!isDefined(var_7)) {
    return;
  }

  var_8 = var_7.origin;
  var_12 = var_7.angles;
  var_0.forced_startingposition = var_7.vehicle_position;
  var_1.usedpositions[var_7.vehicle_position] = 1;

  if(!getdvarint("enable_vehicle_ai_using_BT")) {
    var_0.script_moveoverride = 1;
    var_0 notify("stop_going_to_node");
    var_0 scripts\common\ai::set_forcegoal();
    var_0 scripts\common\ai::disable_arrivals();
    var_0.goalradius = 64;
    var_0 setgoalpos(var_8);
    var_0 waittill("goal");
    var_0 scripts\common\ai::enable_arrivals();
    var_0 scripts\common\ai::unset_forcegoal();
    var_0 notify("boarding_vehicle");
  } else {
    var_0 scripts\vehicle\vehicle_common::requestentervehicle(self, 0, var_7, anim_pos(self, var_7.vehicle_position));
    var_0 scripts\vehicle\vehicle_common::waitforarrivedatvehicle();
  }

  var_13 = anim_pos(var_1, var_7.vehicle_position);

  if(isDefined(var_13.delay)) {
    var_0.delay = var_13.delay;

    if(isDefined(var_13.delayinc)) {
      self.delayer = var_0.delay;
    }
  }

  if(isDefined(var_13.delayinc)) {
    self.delayer += var_13.delayinc;
    var_0.delay = self.delayer;
  }

  if(!getdvarint("enable_vehicle_ai_using_BT")) {
    link_to_sittag(var_1, var_0, var_13.sittag, var_13.sittag_origin_offset, var_13.sittag_angles_offset, var_13.linktoblend);
  }

  var_0.allowdeath = 0;
  var_13 = var_5[var_7.vehicle_position];

  if(isDefined(var_7)) {
    if(isDefined(var_13.vehicle_getinanim)) {
      var_14 = isDefined(var_0.no_vehicle_getoutanim);

      if(!var_14 && !isagent(var_0)) {
        if(isDefined(var_13.vehicle_getoutanim)) {
          var_1 clearanim(var_13.vehicle_getoutanim, 0);
        }

        if(isDefined(var_13.vehicle_getoutanim_combat)) {
          var_1 clearanim(var_13.vehicle_getoutanim_combat, 0);
        }

        if(isDefined(var_13.vehicle_getoutanim_combat_run)) {
          var_1 clearanim(var_13.vehicle_getoutanim_combat_run, 0);
        }
      }

      var_1 = getanimatemodel(var_1);
      thread setanimrestart_once(var_1, var_13.vehicle_getinanim);
      var_1 thread scripts\common\notetrack::start_notetrack_wait(var_1, "vehicle_anim_flag", undefined, undefined, var_13.vehicle_getinanim);
    }

    if(isDefined(var_13.vehicle_getinsoundtag)) {
      var_8 = var_1 gettagorigin(var_13.vehicle_getinsoundtag);
    } else {
      var_8 = var_1.origin;
    }

    if(isDefined(var_13.vehicle_getinsound)) {
      playworldsound(var_13.vehicle_getinsound, var_8);
    }

    var_15 = undefined;
    var_16 = undefined;

    if(isDefined(var_13.getin_enteredvehicletrack)) {
      var_15 = [];
      var_15 = var_13.getin_enteredvehicletrack;
      var_16 = [];
      GscBinSkip0(0x2e, 0, &entered_vehicle_notify, var_13.vehicle_getinanim_clear);
    }

    if(!getdvarint("enable_vehicle_ai_using_BT")) {
      animontag(var_1, var_0, var_13.sittag, var_13.getin, var_15, var_16, undefined, var_13.sittag_origin_offset, var_13.sittag_angles_offset);
    }
  }

  if(getdvarint("enable_vehicle_ai_using_BT")) {
    var_0 scripts\vehicle\vehicle_common::waitforentervehicle();
  }

  var_0 notify("enteredvehicle");
  guy_enter(var_1, var_0, var_4);
}

function entered_vehicle_notify() {
  self notify("enteredvehicle");
}

function driverdead(var_0) {
  if(scripts\common\vehicle::ishelicopter()) {
    return;
  }

  self.driver = var_0;
  self endon("death");
  var_0 endon("jumping_out");
  var_0 waittill("death");

  if(getdvarint("VehicleContinuesOnDriverDeath", 0) == 1) {
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
    scripts\common\vehicle::vehicle_unload();
    return;
  }
}

function guy_becomes_real_ai(var_0, var_1) {
  if(isai(var_0)) {
    return var_0;
  }

  if(istrue(var_0.drone_delete_on_unload)) {
    var_0 delete();
    return;
  }

  var_0 = scripts\engine\utility::script_func("spawner_makerealai", var_0);

  if(scripts\common\utility::issp()) {
    var_2 = self.classname;
  } else {
    var_2 = self.classname_mp;
  }

  var_3 = level.vehicle.templates.aianims[var_2].size;
  var_4 = anim_pos(self, var_2);
  link_to_sittag(var_1, var_4.sittag, var_4.sittag_origin_offset, var_4.sittag_angles_offset, var_4.linktoblend);
  var_1.vehicle_idle = var_4.idle;

  if(!istrue(var_1.disable_vehicle_idle)) {
    thread guy_idle(var_1, var_2);
  }

  return var_1;
}

function link_to_sittag(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  if(!isDefined(var_3)) {
    var_3 = (0, 0, 0);
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(var_4 && !isDefined(var_0.script_drone)) {
    var_0 linktoblendtotag(self, var_1, 0);
    return;
  }

  var_0 linkTo(self, var_1, var_2, var_3);
}

function anim_pos(var_0, var_1) {
  return level.vehicle.templates.aianims[var_0 scripts\common\vehicle_code::get_vehicle_classname()][var_1];
}

function guy_deathhandle(var_0, var_1) {
  var_0 waittill("death");

  if(!isDefined(self)) {
    return;
  }

  self.riders = scripts\engine\utility::array_remove(self.riders, var_0);
  self.usedpositions[var_1] = 0;
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

function guy_handle(var_0, var_1) {
  var_0.vehicle_idling = 1;
  thread guy_deathhandle(var_0, var_1);
}

function driver_idle_speed(var_0, var_1) {
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");
  var_2 = anim_pos(self, var_1);

  for(;;) {
    if(self vehicle_getspeed() == 0) {
      var_0.vehicle_idle = var_2.idle_animstop;
    } else {
      var_0.vehicle_idle = var_2.idle_anim;
    }

    wait 0.25;
  }
}

function guy_idle(var_0, var_1, var_2) {
  var_0 endon("newanim");

  if(!isDefined(var_2)) {
    self endon("death");
  }

  var_0 endon("death");
  var_0.vehicle_idling = 1;
  var_0 notify("gotime");

  if(!isDefined(var_0.vehicle_idle)) {
    return;
  }

  var_3 = anim_pos(self, var_1);

  if(isDefined(var_3.mgturret)) {
    return;
  }

  if(isDefined(var_3.idle_animstop) && isDefined(var_3.idle_anim)) {
    thread driver_idle_speed(var_0, var_1);
  }

  for(;;) {
    var_0 notify("idle");
    play_new_idle(var_0, var_3);
  }
}

function play_new_idle(var_0, var_1) {
  if(isDefined(var_0.vehicle_idle_override)) {
    animontag(var_0, var_1.sittag, var_0.vehicle_idle_override, undefined, undefined, undefined, var_1.sittag_origin_offset, var_1.sittag_angles_offset);
    return;
  }

  if(isDefined(var_1.idleoccurrence)) {
    var_2 = randomoccurrance(var_0, var_1.idleoccurrence);
    animontag(var_0, var_1.sittag, var_0.vehicle_idle[var_2], undefined, undefined, undefined, var_1.sittag_origin_offset, var_1.sittag_angles_offset);
    return;
  }

  if(isDefined(var_1.playerpiggyback) && isDefined(var_2.player_idle)) {
    animontag(var_1, var_2.sittag, var_2.player_idle, undefined, undefined, undefined, var_2.sittag_origin_offset, var_2.sittag_angles_offset);
    return;
  }

  if(isDefined(var_2.vehicle_idle)) {
    thread setanimrestart_once(var_2.vehicle_idle);
  }

  animontag(var_1, var_2.sittag, var_1.vehicle_idle, undefined, undefined, undefined, var_2.sittag_origin_offset, var_2.sittag_angles_offset);
}

function randomoccurrance(var_0, var_1) {
  var_2 = [];
  var_3 = 0;

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    var_3 += var_1[var_4];
    var_2 = var_3;
  }

  var_5 = randomint(var_3);

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(var_5 < var_2[var_4]) {
      return var_4;
    }
  }
}

function guy_unload_que(var_0) {
  self endon("death");
  self.unloadque = scripts\engine\utility::array_add(self.unloadque, var_0);
  var_0 scripts\engine\utility::ref_143a5("death", "jumpedout");
  self.unloadque = scripts\engine\utility::array_remove(self.unloadque, var_0);

  if(!self.unloadque.size) {
    scripts\engine\utility::ent_flag_set("unloaded");
    self.unload_group = "default";
    self.maxdogtags = undefined;
    return;
  }
}

function riders_unloadable(var_0) {
  if(!self.riders.size) {
    return false;
  }

  for(var_1 = 0; var_1 < self.riders.size; var_1++) {
    if(!isalive(self.riders[var_1]) && !isDefined(self.riders[var_1].isvehicle)) {
      continue;
    }

    if(check_unloadgroup(self.riders[var_1].vehicle_position, var_0)) {
      return true;
    }
  }

  return false;
}

function get_unload_group() {
  var_0 = [];
  var_1 = [];
  var_2 = "default";

  if(isDefined(self.unload_group)) {
    var_2 = self.unload_group;
  }

  var_1 = level.vehicle.templates.unloadgroups[scripts\common\vehicle_code::get_vehicle_classname()][var_2];

  if(!isDefined(var_1)) {
    var_1 = level.vehicle.templates.unloadgroups[scripts\common\vehicle_code::get_vehicle_classname()]["default"];
  }

  foreach(var_4 in var_1) {
    var_0 = var_4;
  }

  return var_0;
}

function check_unloadgroup(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = self.unload_group;
  }

  var_2 = scripts\common\vehicle_code::get_vehicle_classname();

  if(!isDefined(level.vehicle.templates.unloadgroups[var_2])) {
    return true;
  }

  if(!isDefined(level.vehicle.templates.unloadgroups[var_2][var_1])) {
    return true;
  }

  var_3 = level.vehicle.templates.unloadgroups[var_2][var_1];

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(var_0 == var_3[var_4]) {
      return true;
    }
  }

  return false;
}

function getoutrig_model_idle(var_0, var_1, var_2) {
  self endon("unloading");

  for(;;) {
    animontag(var_0, var_1, var_2);
  }
}

function getoutrig_model(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\common\vehicle_code::get_vehicle_classname();

  if(var_4) {
    thread getoutrig_model_idle(var_1, var_2, level.vehicle.templates.attachedmodels[var_5][var_0.fastroperig].idleanim);
    self waittill("unloading");
  }

  self.unloadque = scripts\engine\utility::array_add(self.unloadque, var_1);
  thread getoutrig_abort(var_1, var_2, var_3);

  if(!scripts\common\vehicle_code::vehicle_iscrashing()) {
    animontag(var_1, var_2, var_3);
  }

  var_1 unlink();

  if(!isDefined(self)) {
    var_1 delete();
    return;
  }

  self.unloadque = scripts\engine\utility::array_remove(self.unloadque, var_1);

  if(!self.unloadque.size) {
    self notify("unloaded");
  }

  self.fastroperig[var_0.fastroperig] = undefined;
  wait 10;
  var_1 delete();
}

function getoutrig_model_new(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  var_5 = scripts\common\vehicle_code::get_vehicle_classname();
  thread scripts\engine\utility::delete_on_death(var_1);
  var_6 = self gettagorigin(var_2);
  var_7 = self gettagangles(var_2);
  var_8 = level.vehicle.templates.attachedmodels[var_5][var_0.fastroperig].idleanim;
  var_9 = getstartorigin(var_6, var_7, var_8);
  var_10 = getstartangles(var_6, var_7, var_8);
  var_10 = self.angles;
  var_11 = var_1 gettagorigin("j_rope_1", 1);
  var_12 = var_11 - self.origin;

  if(var_4) {
    var_1.origin = var_9;
    var_1.angles = var_10;
    thread scripts\engine\utility::script_func("fastrope_anim", var_1, var_8, "getoutrigidle");
    scripts\engine\utility::ent_flag_wait("unloaded");
  }

  var_6 = self gettagorigin(var_2);
  var_7 = self gettagangles(var_2);
  var_13 = self.angles - var_10;
  var_13 = (angleclamp(var_13[0]), angleclamp(var_13[1]), angleclamp(var_13[2]));
  var_14 = rotatevector(var_12, var_13) + self.origin;
  var_15 = scripts\engine\trace::ray_trace(var_14, var_14 - (0, 0, 1000), self, scripts\engine\trace::create_world_contents());
  var_16 = var_14[2] - 400;

  if(isDefined(var_15["position"])) {
    var_16 = var_15["position"][2];
  }

  var_17 = (var_6[0], var_6[1], var_16);

  if(istrue(level.vehicle.templates.attachedmodels[var_5][var_0.fastroperig].dropusestraceorigin)) {
    var_17 = (var_14[0], var_14[1], var_16);
  }

  thread getoutrig_abort(var_1, undefined, var_3, var_17);

  if(!scripts\common\vehicle_code::vehicle_iscrashing()) {
    var_1 unlink();
    var_1.origin = var_17;
    thread scripts\engine\utility::script_func("fastrope_anim", var_1, var_3, "getoutrigfall");
  }

  self.fastroperig[var_0.fastroperig] = undefined;
  wait 10;
  var_1 delete();
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

  var_0 = [];

  foreach(var_2 in self.riders) {
    if(isalive(var_2)) {
      scripts\engine\utility::array_add_safe(var_0, var_2);
    }
  }

  scripts\engine\utility::array_delete(var_0);
  self notify("crashed_while_deploying");
  var_0 = undefined;
}

function getoutrig_abort(var_0, var_1, var_2, var_3) {
  var_4 = getanimlength(var_2);
  var_5 = var_4 - 1;

  if(self.vehicletype == "mi17") {
    var_5 = var_4 - 0.5;
  }

  var_6 = 0.8;
  self endon("getoutrig_disable_abort");
  thread getoutrig_disable_abort_notify_after_riders_out();
  thread getoutrig_abort_while_deploying();
  scripts\engine\utility::waittill_notify_or_timeout("crashed_while_deploying", var_6);
  self notify("end_getoutrig_abort_while_deploying");

  while(!isDefined(self.vehiclecrashing)) {
    waitframe();
  }

  if(isDefined(var_0)) {
    if(!isDefined(var_1) && isDefined(var_3)) {
      var_0 unlink();
      var_0.origin = var_3;

      if(!scripts\common\utility::issp()) {
        var_7 = var_0 scripts\asm\asm::asm_lookupanimfromalias("animscripted", var_2);
        var_8 = var_0 scripts\asm\asm::asm_getxanim("animscripted", var_7);
        var_9 = getstartorigin(self.origin, self.angles, var_8);
        var_10 = getstartangles(self.origin, self.angles, var_8);
        var_0 dontinterpolate();
        var_0 forceteleport(var_9, var_10);
        var_0 animmode("nogravity");
        var_0 aisetanim("animscripted", var_7);
      } else {
        var_0 animScripted("getoutrigfall", var_0.origin, var_0.angles, var_2, undefined, undefined, 0);
      }
    } else {
      thread animontag(var_0, var_1, var_2);
    }

    waittillframeend();
    var_0 setanimtime(var_2, var_5 / var_4);
  }

  var_11 = self;

  if(isDefined(self.original_attacker)) {
    var_11 = self.original_attacker;
  }

  for(var_12 = 0; var_12 < self.riders.size; var_12++) {
    if(!isDefined(self.riders[var_12])) {
      continue;
    }

    if(!isDefined(self.riders[var_12].ragdoll_getout_death)) {
      continue;
    }

    if(self.riders[var_12].ragdoll_getout_death != 1) {
      continue;
    }

    if(!isDefined(self.riders[var_12].ridingvehicle)) {
      continue;
    }

    self.riders[var_12].forcefallthroughonropes = 1;

    if(isalive(self.riders[var_12])) {
      thread animontag_ragdoll_death_fall(self.riders[var_12], self, var_11);
    }
  }
}

function setanimrestart_once(var_0, var_1) {
  self endon("death");
  self endon("dont_clear_anim");

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = getanimlength(var_0);
  self endon("death");
  thread scripts\engine\utility::script_func("vehicle_door_anim", self, var_0);
  wait var_2;

  if(scripts\common\utility::issp() && var_1) {
    self clearanim(var_0, 0);
    return;
  }
}

#using_animtree("script_model");

function getout_rigspawn(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = scripts\common\vehicle_code::get_vehicle_classname();

  if(isDefined(self.attach_model_override) && isDefined(self.attach_model_override[var_1.fastroperig])) {
    var_4 = 1;
  } else {
    var_4 = 0;
  }

  if(!isDefined(var_2.fastroperig) || isDefined(self.fastroperig[var_2.fastroperig]) || var_4) {
    return;
  }

  var_5 = var_1 gettagorigin(level.vehicle.templates.attachedmodels[var_4][var_2.fastroperig].tag);
  var_6 = var_1 gettagangles(level.vehicle.templates.attachedmodels[var_4][var_2.fastroperig].tag);
  self.fastroperiganimating[var_2.fastroperig] = 1;
  var_7 = spawn("script_model", var_5);
  var_7.angles = var_6;
  var_7.origin = var_5;
  var_7 useanimtree(#animtree);
  var_7 setModel(level.vehicle.templates.attachedmodels[var_4][var_2.fastroperig].model);
  self.fastroperig[var_2.fastroperig] = var_7;
  var_7 linkTo(var_1, level.vehicle.templates.attachedmodels[var_4][var_2.fastroperig].tag);

  if(getdvarint("enable_vehicle_ai_using_BT")) {
    thread getoutrig_model_new(var_2, var_7, level.vehicle.templates.attachedmodels[var_4][var_2.fastroperig].tag, level.vehicle.templates.attachedmodels[var_4][var_2.fastroperig].dropanim, var_3);
  } else {
    thread getoutrig_model(var_2, var_7, level.vehicle.templates.attachedmodels[var_4][var_2.fastroperig].tag, level.vehicle.templates.attachedmodels[var_4][var_2.fastroperig].dropanim, var_3);
  }

  return var_7;
}

function check_sound_tag_dupe(var_0) {
  if(!isDefined(self.sound_tag_dupe)) {
    self.sound_tag_dupe = [];
  }

  var_1 = 0;

  if(!isDefined(self.sound_tag_dupe[var_0])) {
    self.sound_tag_dupe[var_0] = 1;
  } else {
    var_1 = 1;
  }

  thread check_sound_tag_dupe_reset(var_0);
  return var_1;
}

function check_sound_tag_dupe_reset(var_0) {
  wait 0.05;

  if(!isDefined(self)) {
    return;
  }

  self.sound_tag_dupe[var_0] = 0;
  var_1 = getarraykeys(self.sound_tag_dupe);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(self.sound_tag_dupe[var_1[var_2]]) {
      return;
    }
  }

  self.sound_tag_dupe = undefined;
}

function vehicle_play_exit_anim(var_0, var_1, var_2) {
  var_3 = level.vehicle.templates.aianims[scripts\common\vehicle_code::get_vehicle_classname()];
  var_4 = getanimatemodel();

  if(!isDefined(var_1)) {
    var_1 = var_0.vehicle_getoutanim;
  }

  if(!isDefined(var_2)) {
    var_2 = var_0.vehicle_getoutanim_clear;
  }

  if(isDefined(var_1)) {
    thread setanimrestart_once(var_4, var_1);
    var_5 = 0;

    if(isDefined(var_0.vehicle_getoutsoundtag)) {
      var_5 = check_sound_tag_dupe(var_0.vehicle_getoutsoundtag);
      var_6 = var_4 gettagorigin(var_0.vehicle_getoutsoundtag);
    } else {
      var_6 = var_5.origin;
    }

    if(isDefined(var_1.vehicle_getoutsound) && !var_6) {
      playworldsound(var_1.vehicle_getoutsound, var_6);
    }

    var_6 = undefined;
    return;
  }
}

function vehicle_end_loop_sounds(var_0, var_1) {
  var_2 = anim_pos(self, var_1);

  if(isDefined(var_0.playerpiggyback) && isDefined(var_2.player_getout_sound_loop)) {
    level.player thread scripts\engine\utility::script_func("playloopsound_on_entity", var_2.player_getout_sound_loop);
  }

  if(isDefined(var_2.getoutloopsnd)) {
    var_0 thread scripts\engine\utility::script_func("playloopsound_on_entity", var_2.getoutloopsnd);
  }

  if(isDefined(var_0.playerpiggyback) && isDefined(var_2.player_getout_sound_end)) {
    level.player thread scripts\engine\utility::script_func("playsound_on_entity", var_2.player_getout_sound_end);
    return;
  }
}

function ref_1286b() {
  if(isDefined(self.maxdogtags)) {
    return;
  }

  self.maxdogtags = [];

  for(var_0 = 0; var_0 < level.vehicle.templates.aianims[scripts\common\vehicle_code::get_vehicle_classname()].size; var_0++) {
    var_1 = level.vehicle.templates.aianims[scripts\common\vehicle_code::get_vehicle_classname()][var_0];

    if(isDefined(var_1.vehicle_getoutanim)) {
      var_2 = getanimname(var_1.vehicle_getoutanim);
      self.maxdogtags[var_2] = spawnStruct();
      self.maxdogtags[var_2].open = 0;
      self.maxdogtags[var_2].ref_1212c = 0;
    }
  }
}

function wait_for_open_door(var_0, var_1) {
  var_0 endon("jumpedout");
  var_0 endon("death");
  ref_1286b();

  while(!istrue(var_0.requestopendoor)) {
    waitframe();
  }

  if(isDefined(var_1.vehicle_getoutanim)) {
    var_2 = getanimname(var_1.vehicle_getoutanim);

    if(!self.maxdogtags[var_2].open) {
      var_3 = var_1.vehicle_getoutanim;
      var_4 = var_1.vehicle_getoutanim_clear;

      if(isDefined(var_0.requestopendoorparams)) {
        if(var_0.requestopendoorparams == "combat_run" && isDefined(var_1.vehicle_getoutanim_combat_run)) {
          var_3 = var_1.vehicle_getoutanim_combat_run;
          var_4 = var_1.vehicle_getoutanim_combat_run_clear;
        } else if(var_0.requestopendoorparams == "combat" && isDefined(var_1.vehicle_getoutanim_combat)) {
          var_3 = var_1.vehicle_getoutanim_combat;
          var_4 = var_1.vehicle_getoutanim_combat_clear;
        }
      }

      vehicle_play_exit_anim(var_1, var_3, var_4);
      self.maxdogtags[var_2].open = 1;
    }

    if(isDefined(var_1.fastroperig) && !isDefined(self.fastroperig[var_1.fastroperig])) {
      var_5 = getanimatemodel();
      var_6 = getout_rigspawn(var_5, var_1, 1);
      return;
    }

    return;
  }
}

function guy_setup_rope(var_0, var_1) {
  if(isDefined(var_1.fastroperig)) {
    thread wait_for_open_door(var_0, var_1);
    var_0 scripts\vehicle\vehicle_common::setuprope();
    return;
  }
}

function guy_unload(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0.isvehicle)) {
    var_2 = 1;
  }

  var_3 = anim_pos(self, var_1);
  var_4 = self.vehicletype;

  if(!check_unloadgroup(var_1)) {
    if(!getdvarint("enable_vehicle_ai_using_BT")) {
      thread guy_idle(var_0, var_1);
    }

    return;
  }

  if(!getdvarint("enable_vehicle_ai_using_BT") && !isDefined(var_3.getout)) {
    thread guy_idle(var_0, var_1);
    return;
  }

  thread guy_unload_que(var_0);
  self endon("death");

  if(isai(var_0) && isalive(var_0)) {
    var_0 endon("death");
  }

  var_5 = 0;

  if(isDefined(var_0.getoffvehiclefunc)) {
    var_6 = var_0[[var_0.getoffvehiclefunc]]();

    if(isDefined(var_6) && var_6) {
      var_5 = 1;
    }
  }

  if(isDefined(var_0.onrotatingvehicleturret)) {
    var_0.onrotatingvehicleturret = undefined;

    if(isDefined(var_0.getoffvehiclefunc)) {
      var_0[[var_0.getoffvehiclefunc]]();
    }
  }

  if(!getdvarint("enable_vehicle_ai_using_BT")) {
    vehicle_play_exit_anim(var_3);
    var_7 = 0;

    if(isDefined(var_3.getout_timed_anim)) {
      var_7 += getanimlength(var_3.getout_timed_anim);
    }

    if(isDefined(var_3.delay)) {
      var_7 += var_3.delay;
    }

    if(isDefined(var_0.delay)) {
      var_7 += var_0.delay;
    }

    if(var_7 > 0) {
      if(!getdvarint("enable_vehicle_ai_using_BT")) {
        thread guy_idle(var_0, var_1);
      }

      wait var_7;
    }
  }

  if(!getdvarint("enable_vehicle_ai_using_BT")) {
    var_0.deathanim = undefined;
    var_0.deathanimscript = undefined;
  }

  var_0 notify("newanim");

  if(isDefined(var_3.bhasgunwhileriding) && !var_3.bhasgunwhileriding) {
    if(!isDefined(var_0.disable_gun_recall)) {
      var_0 scripts\common\ai::gun_recall();
    }
  }

  if(isai(var_0)) {
    var_0 pushplayer(1);
  }

  if(isDefined(var_3.bnoanimunload)) {
    var_5 = 1;
  } else if(!getdvarint("enable_vehicle_ai_using_BT") && !isDefined(var_3.getout) || !isDefined(self.script_unloadmgguy) && isDefined(var_3.bisgunner) && var_3.bisgunner || isDefined(self.script_keepdriver) && var_1 == 0) {
    thread guy_idle(var_0, var_1);
    return;
  }

  if(should_give_orghealth(var_0)) {
    var_0.health = var_0.orghealth;
  }

  var_0.orghealth = undefined;

  if(isai(var_0) && isalive(var_0)) {
    var_0 endon("death");
  }

  var_0.allowdeath = 0;

  if(isDefined(var_3.exittag)) {
    var_8 = var_3.exittag;
  } else {
    var_8 = var_4.sittag;
  }

  if(isDefined(var_1.get_out_override)) {
    var_9 = var_1.get_out_override;
  } else if(scripts\engine\utility::ent_flag("landed") && isDefined(var_5.getout_landed)) {
    var_9 = var_5.getout_landed;
  } else if(isDefined(var_3.playerpiggyback) && isDefined(var_8.player_getout)) {
    var_9 = var_8.player_getout;
  } else {
    var_9 = var_8.getout;
  }

  if(!var_9) {
    if(!getdvarint("enable_vehicle_ai_using_BT")) {
      thread guy_unlink_on_death(var_4);
    }

    if(!getdvarint("enable_vehicle_ai_using_BT") && isDefined(var_8.fastroperig)) {
      if(!isDefined(self.fastroperig[var_8.fastroperig])) {
        if(!getdvarint("enable_vehicle_ai_using_BT")) {
          thread guy_idle(var_4, var_5);
        }

        var_10 = getanimatemodel();
        var_11 = getout_rigspawn(var_10, var_8, 1);
      }
    }

    if(isDefined(var_8.getoutsnd)) {
      var_4 thread scripts\engine\utility::script_func("playsound_on_tag", var_8.getoutsnd, "J_Wrist_RI", 1);
    }

    if(isDefined(var_4.playerpiggyback) && isDefined(var_8.player_getout_sound)) {
      var_4 thread scripts\engine\utility::script_func("playsound_on_tag", var_8.player_getout_sound);
    }

    if(isDefined(var_8.getoutloopsnd)) {
      var_4 thread scripts\engine\utility::script_func("playloopsound_on_tag", var_8.getoutloopsnd);
    }

    if(isDefined(var_4.playerpiggyback) && isDefined(var_8.player_getout_sound_loop)) {
      level.player thread scripts\engine\utility::script_func("playloopsound_on_tag", var_8.player_getout_sound_loop);
    }

    var_4 notify("newanim");
    var_4 notify("jumping_out");
    var_12 = 0;

    if(!isai(var_4) && !var_8) {
      var_12 = 1;
    }

    if(!isDefined(var_4.script_stay_drone) && !var_8) {
      var_4 = guy_becomes_real_ai(var_4, var_5);
    }

    if(!isalive(var_4) && !var_8) {
      return;
    }

    if(!var_8) {
      var_4.ragdoll_getout_death = 1;
    }

    if(isDefined(var_8.ragdoll_getout_death)) {
      var_4.ragdoll_getout_death = 1;

      if(isDefined(var_8.ragdoll_fall_anim)) {
        var_4.ragdoll_fall_anim = var_8.ragdoll_fall_anim;
      }
    }

    if(var_12) {
      self.riders = scripts\engine\utility::array_add(self.riders, var_4);
      thread guy_deathhandle(var_4, var_5);
      thread guy_unload_que(var_4);
      var_4.ridingvehicle = self;
    }

    if(isai(var_4)) {
      var_4 endon("death");
    }

    var_4 notify("newanim");
    var_4 notify("jumping_out");

    if(isDefined(var_8.littlebirde_getout_unlinks) && var_8.littlebirde_getout_unlinks) {
      thread stable_unlink(var_4);
    }

    if(isalive(var_4) && isai(var_4) && guy_resets_goalpos(var_4)) {
      var_4.goalradius = 600;
      var_4 setgoalpos(var_4.origin);
    }

    if(isDefined(var_8.getout_secondary)) {
      animontag(var_4, var_9, var_9);
      var_13 = var_9;

      if(isDefined(var_8.getout_secondary_tag)) {
        var_13 = var_8.getout_secondary_tag;
      }

      animontag(var_4, var_13, var_8.getout_secondary, undefined, undefined, undefined, var_8.sittag_origin_offset, var_8.sittag_angles_offset);
    } else {
      var_14 = 0;

      if(isDefined(var_8.getout_hover_loop) && isDefined(var_8.getout_hover_land)) {
        thread guy_unload_land(var_4, var_9, var_8.getout, var_8.getout_hover_loop, var_8.getout_hover_land);
        var_14 = 1;
      } else if(!var_8) {
        var_4.anim_end_early = 1;
      }

      if(!getdvarint("enable_vehicle_ai_using_BT")) {
        animontag(var_4, var_9, var_9, undefined, undefined, undefined, var_8.sittag_origin_offset, var_8.sittag_angles_offset);
      } else {
        thread wait_for_open_door(var_4, var_8);
        var_4 scripts\vehicle\vehicle_common::exitvehicle();
      }

      if(var_14) {
        var_4 waittill("hoverunload_done");
      }
    }

    if(isDefined(var_4.playerpiggyback) && isDefined(var_8.player_getout_sound_loop)) {
      level.player thread scripts\engine\utility::stop_loop_sound_on_entity(var_8.player_getout_sound_loop);
    }

    if(isDefined(var_8.getoutloopsnd)) {
      var_4 thread scripts\engine\utility::stop_loop_sound_on_entity(var_8.getoutloopsnd);
    }

    if(isDefined(var_4.playerpiggyback) && isDefined(var_8.player_getout_sound_end)) {
      level.player thread scripts\engine\utility::script_func("playsound_on_entity", var_8.player_getout_sound_end);
    }
  } else if(!isai(var_4)) {
    if(istrue(var_4.drone_delete_on_unload)) {
      var_4 delete();
      return;
    }

    var_4 = scripts\engine\utility::script_func("spawner_makerealai", var_4);
  }

  self.riders = scripts\engine\utility::array_remove(self.riders, var_4);
  self.usedpositions[var_5] = 0;
  var_4.ridingvehicle = undefined;
  var_4.drivingvehicle = undefined;

  if(!isalive(self) && !isDefined(var_8.unload_ondeath)) {
    var_4 delete();
    return;
  }

  if(!getdvarint("enable_vehicle_ai_using_BT")) {
    var_4 unlink();
  }

  if(!isDefined(var_4.magic_bullet_shield)) {
    var_4.allowdeath = 1;
  }

  if(isalive(var_4) || var_8) {
    if(isai(var_4)) {
      var_4.a.disablelongdeath = !var_4 isbadguy();
    }

    var_4.forced_startingposition = undefined;

    if(isai(var_4)) {
      if(isDefined(var_8.getoutstance)) {
        var_4.desired_anim_pose = var_8.getoutstance;
        var_4 allowedstances("crouch");
        var_4 thread scripts\engine\utility::script_func("anim_updateanimpose");
        var_4 allowedstances("stand", "crouch", "prone");
      }

      var_4 pushplayer(0);
    } else if(var_8) {
      var_4.vspawner.origin = var_4.origin;
      var_4.vspawner.angles = var_4.angles;

      if(isDefined(var_4.vspawner.target)) {
        var_4.vspawner scripts\common\vehicle::spawn_vehicle_and_gopath();
      } else {
        var_15 = var_4.vspawner scripts\common\utility::spawn_vehicle();
      }

      var_4 delete();
    }

    if(!getdvarint("enable_vehicle_ai_using_BT")) {
      var_4 notify("jumpedout");
    }
  }

  if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "delete_after_unload") {
    var_4 delete();
    return;
  }

  if(isDefined(var_8.getout_delete) && var_8.getout_delete) {
    var_4 delete();
    return;
  }

  guy_cleanup_vehiclevars(var_4);
}

function guy_unload_land(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self gettagorigin(var_1);
  var_6 = self gettagangles(var_1);
  var_7 = getstartorigin(var_5, var_6, var_2);
  var_8 = getstartangles(var_5, var_6, var_2);
  var_9 = getmovedelta(var_2, 0, 1);
  var_10 = scripts\engine\utility::spawn_tag_origin();
  var_10.origin = var_7;
  var_10.angles = var_8;
  var_11 = var_10 localtoworldcoords(var_9);
  var_10 thread scripts\engine\utility::delete_on_notify("movedone");
  var_12 = var_11;
  var_13 = scripts\common\utility::groundpos(var_12);
  var_14 = getstartorigin(var_5, var_6, var_4);
  var_9 = getmovedelta(var_4, 0, 1);
  var_15 = var_14 + var_9;
  var_16 = var_14[2] - var_15[2];
  var_17 = var_13 + (0, 0, var_16);
  var_0.allowdeath = 0;
  var_0 setCanDamage(0);
  var_0 endon("death");
  wait getanimlength(var_2) - 0.1;
  var_0 unlink();
  var_0 notify("animontag_thread");
  var_0 stopanimScripted();
  var_10.origin = var_0.origin;
  var_10.angles = var_0.angles;
  var_10 dontinterpolate();
  var_0 dontinterpolate();
  var_0 linkTo(var_10, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_0.allowdeath = 1;
  var_0 setCanDamage(1);
  var_0.unload_loopanim = var_3;

  if(isai(var_0)) {
    var_0 scripts\engine\utility::script_func("asm_animcustom", &guy_fall_loop, &guy_fall_loop_end);
  } else {
    thread guy_fall_loop();
  }

  var_18 = length((0, 0, var_17[2]) - (0, 0, var_12[2]));
  var_19 = 350;
  var_20 = var_18 / var_19;
  var_10 moveTo(var_17, var_20);
  var_10 waittill("movedone");
  var_0 unlink();
  var_0 animScripted("dropship_land", var_0.origin, var_0.angles, var_4);
  wait getanimlength(var_4);
  var_0 notify("hoverunload_done");
  var_0 notify("anim_on_tag_done");
}

function guy_fall_loop() {
  if(isai(self)) {
    if(scripts\engine\utility::actor_is3d()) {
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

function guy_resets_goalpos(var_0) {
  if(isDefined(var_0.script_delayed_playerseek)) {
    return false;
  }

  if(istrue(var_0 scripts\engine\utility::script_func("ai_has_color"))) {
    return false;
  }

  if(isDefined(var_0.qsetgoalpos)) {
    return false;
  }

  if(!isDefined(var_0.target)) {
    return true;
  }

  var_1 = getnodearray(var_0.target, "targetname");
  var_2 = scripts\engine\utility::getStructArray(var_0.target, "targetname");

  if(var_1.size > 0 || var_2.size > 0) {
    return false;
  }

  var_3 = getEnt(var_0.target, "targetname");

  if(isDefined(var_3) && var_3.classname == "info_volume") {
    return false;
  }

  return true;
}

function animontag(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_0 notify("animontag_thread");
  var_0 endon("animontag_thread");

  if(!isDefined(var_6)) {
    var_6 = (0, 0, 0);
  }

  if(!isDefined(var_7)) {
    var_7 = (0, 0, 0);
  }

  if(!isDefined(var_5)) {
    var_5 = "animontagdone";
  }

  if(isDefined(self.modeldummy)) {
    var_8 = self.modeldummy;
  } else {
    var_8 = self;
  }

  if(!isDefined(var_2) || !scripts\engine\utility::hastag(var_8.model, var_2)) {
    var_9 = var_1.origin;
    var_10 = var_1.angles;
  } else {
    var_9 = var_10 gettagorigin(var_4);
    var_10 = var_10 gettagangles(var_4) + var_9;
    var_11 = anglestoaxis(var_10);
    var_12 = ["forward", "right", "up"];

    for(var_13 = 0; var_13 < var_11.size; var_13++) {
      var_9 += var_11[var_12[var_13]] * var_8[var_13];
    }
  }

  if(isDefined(var_3.ragdoll_getout_death) && !isDefined(var_3.no_vehicle_ragdoll)) {
    thread animontag_ragdoll_death(level, var_3);
  }

  if(!scripts\common\utility::issp()) {
    var_3 dontinterpolate();

    if(isai(var_3)) {
      var_14 = var_3 scripts\asm\asm::asm_lookupanimfromalias("animscripted", var_5);
      var_15 = var_3 scripts\asm\asm::asm_getxanim("animscripted", var_14);
      var_16 = getstartorigin(self.origin, self.angles, var_15);
      var_17 = getstartangles(self.origin, self.angles, var_15);
      var_3 forceteleport(var_16, var_17);
      var_3 animmode("nogravity");
      var_3 aisetanim("animscripted", var_14);
    }
  } else {
    var_3 animScripted(var_8, var_9, var_10, var_5);
  }

  if(isai(var_3)) {
    thread donotetracks(var_3, var_10, var_8);
  }

  if(isDefined(var_3.anim_end_early)) {
    var_3.anim_end_early = undefined;
    var_18 = getanimlength(var_5) - 0.25;

    if(var_18 > 0) {
      wait var_18;
    }

    if(getdvarint("LPNQTQRRP", 0) == 1) {
      var_3 stopanimScripted();
    }

    var_3.interval = 0;
    thread recover_interval();
  } else {
    if(isDefined(var_6)) {
      for(var_13 = 0; var_13 < var_6.size; var_13++) {
        var_3 waittillmatch(var_8, var_6[var_13]);
        var_3 thread[[var_7[var_13]]]();
      }
    }

    var_3 waittillmatch(var_8, "end");
  }

  var_3 notify("anim_on_tag_done");
  var_3.ragdoll_getout_death = undefined;
}

function recover_interval() {
  self endon("death");
  wait 2;

  if(self.interval == 0) {
    self.interval = 80;
    return;
  }
}

function animontag_ragdoll_death(var_0, var_1) {
  if(isDefined(var_0.magic_bullet_shield) && var_0.magic_bullet_shield) {
    return;
  }

  if(!isai(var_0)) {
    var_0 setCanDamage(1);
  }

  var_0 endon("anim_on_tag_done");
  var_2 = undefined;
  var_3 = undefined;
  var_4 = var_1.health <= 0;

  for(;;) {
    if(!var_4 && !(isDefined(var_1) && var_1.health > 0)) {
      break;
    }

    var_0 waittill("damage", var_2, var_3);

    if(isDefined(var_0.forcefallthroughonropes)) {
      break;
    }

    if(!isDefined(var_2)) {
      continue;
    }

    if(var_2 < 1) {
      continue;
    }

    if(!isDefined(var_3)) {
      continue;
    }

    if(isPlayer(var_3)) {
      break;
    }
  }

  if(!isalive(var_0)) {
    return;
  }

  thread animontag_ragdoll_death_fall(var_0, var_1, var_3);
}

function animontag_ragdoll_death_fall(var_0, var_1, var_2) {
  var_0.deathanim = undefined;
  var_0.deathfunction = undefined;
  var_0.anim_disablepain = 1;

  if(isDefined(var_0.ragdoll_fall_anim)) {
    var_3 = getmovedelta(var_0.ragdoll_fall_anim, 0, 1);
    var_4 = physicstrace(var_0.origin + (0, 0, 16), var_0.origin - (0, 0, 10000));
    var_5 = distance(var_0.origin + (0, 0, 16), var_4);

    if(abs(var_3[2] + 16) <= abs(var_5)) {
      var_0 thread scripts\engine\utility::script_func("playsound_on_entity", "generic_death_falling");
      var_0 animScripted("fastrope_fall", var_0.origin, var_0.angles, var_0.ragdoll_fall_anim);
      var_0 waittillmatch("fastrope_fall", "start_ragdoll");
    }
  }

  if(!isDefined(var_0)) {
    return;
  }

  var_0.deathanim = undefined;
  var_0.deathfunction = undefined;
  var_0.anim_disablepain = 1;
  var_0 notify("rope_death", var_2);
  var_0 kill(var_2.origin, var_2);

  if(isDefined(var_0.script_stay_drone)) {
    var_0 notsolid();
    var_6 = getweaponmodel(var_0.weapon);
    var_7 = var_0.weapon;

    if(isDefined(var_6)) {
      var_0 detach(var_6, "tag_weapon_right");
      var_8 = var_0 gettagorigin("tag_weapon_right");
      var_9 = var_0 gettagangles("tag_weapon_right");
      level.gun = spawn("weapon_" + createheadicon(var_7), (0, 0, 0));
      level.gun.angles = var_9;
      level.gun.origin = var_8;
    }
  } else {
    var_0 scripts\engine\utility::script_func("anim_dropallaiweapons");
  }

  if(isDefined(var_0.fnpreragdoll)) {
    var_0[[var_0.fnpreragdoll]]();
  }

  var_0 startragdoll();
}

function donotetracks(var_0, var_1, var_2) {
  var_0 endon("idle");
  var_0 endon("newanim");
  var_1 endon("death");
  var_0 endon("death");
  var_0 scripts\engine\utility::script_func("anim_donotetracks", var_2);
}

function animatemoveintoplace(var_0, var_1, var_2, var_3) {
  var_0 animScripted("movetospot", var_1, var_2, var_3);
  var_0 waittillmatch("movetospot", "end");
}

function guy_vehicle_death(var_0, var_1) {
  if(!isalive(var_0)) {
    return;
  }

  if(isDefined(self.no_rider_death)) {
    return;
  }

  var_2 = anim_pos(self, var_0.vehicle_position);

  if(isDefined(var_2.explosion_death)) {
    return guy_blowup(var_0);
  }

  var_3 = scripts\common\vehicle_code::get_vehicle_classname();

  if(isDefined(level.vehicle.templates.rider_death_func) && isDefined(level.vehicle.templates.rider_death_func[var_3])) {
    self[[level.vehicle.templates.rider_death_func[var_3]]]();
    return;
  }

  if(isDefined(var_2.unload_ondeath) && isDefined(self)) {
    if(isDefined(self.dontunloadondeath) && self.dontunloadondeath) {
      return;
    }

    thread guy_idle(var_0, var_0.vehicle_position, 1);
    wait var_2.unload_ondeath;

    if(isDefined(var_0) && isDefined(self)) {
      self.groupedanim_pos = var_0.vehicle_position;
      animate_guys("unload");
    }

    return;
  }

  if(isDefined(var_0)) {
    if(isDefined(var_0.ragdoll_getout_death)) {
      return;
    }

    var_0 delete();
    return;
  }
}

function ai_wait_go() {
  self endon("death");
  self waittill("loaded");
  scripts\common\vehicle_paths::gopath(self);
}

function set_pos(var_0, var_1) {
  var_2 = var_0.script_startingposition;

  if(isDefined(var_0.forced_startingposition)) {
    var_2 = var_0.forced_startingposition;
  }

  if(isDefined(var_2)) {
    return var_2;
  }

  for(var_3 = 0; var_3 < self.usedpositions.size; var_3++) {
    if(self.usedpositions[var_3]) {
      continue;
    }

    if(isDefined(var_0.isvehicle) && !isDefined(var_1[var_3].isvehicle)) {
      continue;
    }

    if(!isDefined(var_0.isvehicle) && isDefined(var_1[var_3].isvehicle)) {
      continue;
    }

    return var_3;
  }

  if(isDefined(var_0.isvehicle) && var_0.isvehicle) {
    return;
  }
}

function guy_man_turret(var_0, var_1, var_2) {
  var_3 = anim_pos(self, var_1);
  var_4 = self.mgturret[var_3.mgturret];

  if(!isalive(var_0)) {
    return;
  }

  var_4 endon("death");
  var_0 endon("death");

  if(isDefined(var_2) && var_2 && isDefined(var_3.passenger_2_turret_func)) {
    [[var_3.passenger_2_turret_func]](self, var_0, var_1, var_4);
  }

  scripts\common\vehicle_code::set_turret_team(var_4);
  var_4 setdefaultdroppitch(0);
  wait 0.1;
  var_0 endon("guy_man_turret_stop");
  level thread scripts\common\vehicle_code::vehicle_turret_difficulty(var_4, scripts\common\utility::getdifficulty());
  var_4 scripts\engine\utility::self_func("setturretignoregoals", 1);
  var_5 = "stand";

  if(isDefined(var_3.turretpos)) {
    var_5 = var_3.turretpos;
  }

  var_0 scripts\engine\utility::script_func("use_turret", var_4, var_5);
}

function guy_unlink_on_death(var_0) {
  var_0 endon("jumpedout");
  var_0 waittill("death");

  if(isDefined(var_0)) {
    var_0 unlink();
    return;
  }
}

function guy_blowup(var_0) {
  if(!isDefined(var_0.vehicle_position)) {
    return;
  }

  var_1 = var_0.vehicle_position;
  var_2 = anim_pos(self, var_1);

  if(!isDefined(var_2.explosion_death)) {
    return;
  }

  var_0.deathanim = var_2.explosion_death;
  var_3 = self.angles;
  var_4 = var_0.origin;

  if(isDefined(var_2.explosion_death_offset)) {
    var_4 += anglesToForward(var_3) * var_2.explosion_death_offset[0];
    var_4 += anglestoright(var_3) * var_2.explosion_death_offset[1];
    var_4 += anglestoup(var_3) * var_2.explosion_death_offset[2];
  }

  var_0 = convert_guy_to_drone(var_0);
  detach_models_with_substr(var_0, "weapon_");
  var_0 notsolid();
  var_0.origin = var_4;
  var_0.angles = var_3;
  var_0 animScripted("deathanim", var_4, var_3, var_2.explosion_death);
  var_5 = 0.3;

  if(isDefined(var_2.explosion_death_ragdollfraction)) {
    var_5 = var_2.explosion_death_ragdollfraction;
  }

  var_6 = getanimlength(var_2.explosion_death);
  var_7 = gettime() + var_6 * 1000;
  wait var_6 * var_5;
  var_8 = (0, 0, 1);
  var_9 = var_0.origin;

  if(getDvar("LNLRQKMPKS") == "0") {
    var_0 delete();
    return;
  }

  if(isai(var_0)) {
    var_0 scripts\engine\utility::script_func("anim_dropallaiweapons");
  } else {
    detach_models_with_substr(var_0, "weapon_");
  }

  while(!var_0 isragdoll() && gettime() < var_7) {
    var_9 = var_0.origin;
    wait 0.05;
    var_8 = var_0.origin - var_9;

    if(isDefined(var_0.fnpreragdoll)) {
      var_0[[var_0.fnpreragdoll]]();
    }

    var_0 startragdoll();
  }

  wait 0.05;
  var_8 *= 20000;

  for(var_10 = 0; var_10 < 3; var_10++) {
    if(isDefined(var_0)) {
      var_9 = var_0.origin;
    }

    wait 0.05;
  }

  if(!var_0 isragdoll()) {
    var_0 delete();
    return;
  }
}

#using_animtree("");

function convert_guy_to_drone(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = spawn("script_model", var_0.origin);
  var_2.angles = var_0.angles;
  var_2 setModel(var_0.model);
  var_3 = var_0 getattachsize();

  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_2 attach(var_0 getattachmodelname(var_4), var_0 getattachtagname(var_4));
  }

  var_2 useanimtree(#animtree);

  if(isDefined(var_0.team)) {
    var_2.team = var_0.team;
  }

  if(!var_1) {
    var_0 delete();
  }

  var_2 scripts\engine\utility::self_func("makefakeai");
  return var_2;
}

function vehicle_animate(var_0, var_1) {
  self useanimtree(var_1);
  self setanim(var_0);
}

function vehicle_getinstart(var_0) {
  var_1 = anim_pos(self, var_0);
  return vehicle_getanimstart(var_1.getin, var_1.sittag, var_0, var_1.canshootinvehicle);
}

function vehicle_getanimstart(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_5 = undefined;
  var_6 = undefined;
  var_7 = self gettagorigin(var_1);
  var_8 = self gettagangles(var_1);

  if(!getdvarint("enable_vehicle_ai_using_BT") || isDefined(var_0)) {
    var_5 = getstartorigin(var_7, var_8, var_0);
    var_6 = getstartangles(var_7, var_8, var_0);
  } else {
    var_5 = var_7;
    var_6 = var_8;
  }

  var_4.origin = var_5;
  var_4.angles = var_6;
  var_4.vehicle_position = var_2;
  var_4.canshootinvehicle = var_3;
  return var_4;
}

function is_position_in_group(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    return true;
  }

  var_3 = var_0 scripts\common\vehicle_code::get_vehicle_classname();
  var_4 = level.vehicle.templates.unloadgroups[var_3][var_2];

  foreach(var_6 in var_4) {
    if(var_6 == var_1) {
      return true;
    }
  }

  return false;
}

function get_availablepositions(var_0) {
  var_1 = level.vehicle.templates.aianims[scripts\common\vehicle_code::get_vehicle_classname()];
  var_2 = [];
  var_3 = [];

  for(var_4 = 0; var_4 < self.usedpositions.size; var_4++) {
    if(self.usedpositions[var_4]) {
      continue;
    }

    if((getdvarint("enable_vehicle_ai_using_BT") || isDefined(var_1[var_4].getin)) && is_position_in_group(self, var_4, var_0)) {
      var_2 = vehicle_getinstart(var_4);
      continue;
    }

    var_3 = var_4;
  }

  var_5 = spawnStruct();
  var_5.availablepositions = var_2;
  var_5.nonanimatedpositions = var_3;
  return var_5;
}

function getanimatemodel() {
  if(isDefined(self.modeldummy)) {
    return self.modeldummy;
  }

  return self;
}

function detach_models_with_substr(var_0, var_1) {
  var_2 = var_0 getattachsize();
  var_3 = [];
  var_4 = [];
  var_5 = 0;

  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_7 = var_0 getattachmodelname(var_6);
    var_8 = var_0 getattachtagname(var_6);

    if(issubstr(var_7, var_1)) {
      var_3 = var_7;
      var_4 = var_8;
    }
  }

  for(var_6 = 0; var_6 < var_3.size; var_6++) {
    var_0 detach(var_3[var_6], var_4[var_6]);
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

function stable_unlink(var_0) {
  self waittill("stable_for_unlink");

  if(isalive(var_0)) {
    var_0 unlink();
    return;
  }
}

function animate_guys(var_0) {
  var_1 = [];

  foreach(var_3 in self.riders) {
    if(isai(var_3) && !isalive(var_3)) {
      continue;
    }

    if(isDefined(level.vehicle.aianimcheck[var_0]) && ![[level.vehicle.aianimcheck[var_0]]](var_3, var_3.vehicle_position)) {
      continue;
    }

    if(isDefined(level.vehicle.aianimthread[var_0])) {
      var_3 notify("newanim");
      GscBinSkip1(0x74, level.vehicle.aianimthread[var_0], var_3, var_3.vehicle_position);
    }
  }

  return var_1;
}

function guy_cleanup_vehiclevars() {
  self.vehicle_idling = undefined;
  self.standing = undefined;
  self.vehicle_position = undefined;
  self.delay = undefined;
}