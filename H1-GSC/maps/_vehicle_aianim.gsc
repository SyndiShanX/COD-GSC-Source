/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_vehicle_aianim.gsc
********************************/

guy_enter(var_0, var_1) {
  if(!isdefined(self)) {
    return;
  }
  if(!isdefined(self.vehicletype)) {
    return;
  }
  var_2 = self.classname;
  var_3 = level.vehicle_aianims[var_2];
  var_4 = level.vehicle_aianims[var_2].size;
  self.attachedguys[self.attachedguys.size] = var_0;
  var_5 = set_pos(var_0, var_4);

  if(!isdefined(var_5)) {
    return;
  }
  if(var_5 == 0)
    var_0.drivingvehicle = 1;

  var_6 = anim_pos(self, var_5);
  self.usedpositions[var_5] = 1;
  var_0.vehicle_position = var_5;
  var_0.vehicle_idling = 0;

  if(isdefined(var_6.delay)) {
    var_0.delay = var_6.delay;

    if(isdefined(var_6.delayinc))
      self.delayer = var_0.delay;
  }

  if(isdefined(var_6.delayinc)) {
    self.delayer = self.delayer + var_6.delayinc;
    var_0.delay = self.delayer;
  }

  var_0.ridingvehicle = self;
  var_0.orghealth = var_0.health;
  var_0.vehicle_idle = var_6.idle;
  var_0.vehicle_standattack = var_6.standattack;

  if(isdefined(var_6.nodeath))
    var_0.a.nodeath = 1;

  var_0.death_flop_dir = var_6.death_flop_dir;
  var_0.min_unload_frac_to_flop = var_6.min_unload_frac_to_flop;
  var_0.deathanimscript = var_6.deathscript;
  var_0.standing = 0;

  if(isdefined(var_6.getout)) {
    var_0.get_out_time = getanimlength(var_6.getout);
    var_0.get_out_anim = var_6.getout;

    if(isdefined(var_6.getout_ik))
      var_0.getout_ik = 1;
  }

  var_0.allowdeath = 0;

  if(isdefined(var_0.deathanim) && !isdefined(var_0.magic_bullet_shield))
    var_0.allowdeath = 1;

  if(isdefined(var_6.death))
    thread guy_death(var_0, var_6);

  if(!isdefined(var_0.vehicle_idle))
    var_0.allowdeath = 1;

  self.riders[self.riders.size] = var_0;

  if(var_0.classname != "script_model" && maps\_utility::spawn_failed(var_0)) {
    return;
  }
  var_7 = vehicle_animpos_get_tag_origin(var_6);
  var_8 = vehicle_animpos_get_tag_angles(var_6);
  link_to_sittag(var_0, var_6.sittag, var_6.sittag_offset, var_6.linktoblend, var_6.sittag_on_turret, var_6.mgturret);

  if(isai(var_0)) {
    var_0 teleport(var_7, var_8);
    var_0.a.disablelongdeath_saved = var_0.a.disablelongdeath;
    var_0.a.disablelongdeath = 1;

    if(isdefined(var_6.bhasgunwhileriding) && !var_6.bhasgunwhileriding)
      var_0 maps\_utility::gun_remove();

    if(guy_should_man_turret(var_6))
      thread guy_man_turret(var_0, var_5, var_1);
  } else {
    if(isdefined(var_6.bhasgunwhileriding) && !var_6.bhasgunwhileriding)
      detach_models_with_substr(var_0, "weapon_");

    var_0.origin = var_7;
    var_0.angles = var_8;
  }

  if(var_5 == 0 && isdefined(var_3[0].death))
    thread driverdead(var_0);

  self notify("guy_entered", var_0, var_5);
  thread guy_handle(var_0, var_5);

  if(isdefined(var_6.rider_func))
    var_0[[var_6.rider_func]]();
  else {
    if(isdefined(self.parachute_unload))
      var_0.parachute_unload = 1;

    if(isdefined(var_6.getin_idle_func)) {
      thread[[var_6.getin_idle_func]](var_0, var_5);
      return;
    }

    thread guy_idle(var_0, var_5);
  }
}

vehicle_animpos_get_tag_origin(var_0) {
  var_1 = self;

  if(isdefined(var_0.sittag_on_turret) && var_0.sittag_on_turret)
    var_1 = self.mgturret[var_0.mgturret];

  return var_1 gettagorigin(var_0.sittag);
}

vehicle_animpos_get_tag_angles(var_0) {
  var_1 = self;

  if(isdefined(var_0.sittag_on_turret) && var_0.sittag_on_turret)
    var_1 = self.mgturret[var_0.mgturret];

  return var_1 gettagangles(var_0.sittag);
}

vehicle_allows_driver_death() {
  if(!isdefined(self.script_allow_driver_death))
    return 0;

  return self.script_allow_driver_death;
}

vehicle_allows_rider_death() {
  if(!isdefined(self.script_allow_rider_deaths))
    return 1;

  return self.script_allow_rider_deaths;
}

guy_should_man_turret(var_0) {
  if(!isdefined(var_0.mgturret))
    return 0;

  if(!isdefined(self.script_nomg))
    return 1;

  return !self.script_nomg;
}

handle_attached_guys() {
  var_0 = self.classname;
  self.attachedguys = [];

  if(!(isdefined(level.vehicle_aianims) && isdefined(level.vehicle_aianims[var_0]))) {
    return;
  }
  var_1 = level.vehicle_aianims[var_0].size;

  if(isdefined(self.script_noteworthy) && self.script_noteworthy == "ai_wait_go")
    thread ai_wait_go();

  self.runningtovehicle = [];
  self.usedpositions = [];
  self.getinorgs = [];
  self.delayer = 0;
  var_2 = level.vehicle_aianims[var_0];

  for (var_3 = 0; var_3 < var_1; var_3++) {
    self.usedpositions[var_3] = 0;

    if(isdefined(self.script_nomg) && self.script_nomg && isdefined(var_2[var_3].bisgunner) && var_2[var_3].bisgunner)
      self.usedpositions[1] = 1;
  }
}

load_ai_goddriver(var_0) {
  load_ai(var_0, 1);
}

guy_death(var_0, var_1) {
  waittillframeend;
  var_0 setcandamage(1);
  var_0 endon("death");
  var_0.allowdeath = 0;
  var_0.health = 10150;

  if(isdefined(var_0.script_startinghealth))
    var_0.health = var_0.health + var_0.script_startinghealth;

  var_0 endon("jumping_out");

  if(isdefined(var_0.magic_bullet_shield) && var_0.magic_bullet_shield) {
    while (isdefined(var_0.magic_bullet_shield) && var_0.magic_bullet_shield)
      wait 0.05;
  }

  while (var_0.health > 10000)
    var_0 waittill("damage");

  thread guy_deathimate_me(var_0, var_1);
}

guy_deathimate_me(var_0, var_1) {
  var_2 = gettime() + getanimlength(var_1.death) * 1000;
  var_3 = var_0.angles;
  var_4 = var_0.origin;
  var_0 = convert_guy_to_drone(var_0);
  [[level.global_kill_func]]("MOD_RIFLE_BULLET", "torso_upper", var_4);
  detach_models_with_substr(var_0, "weapon_");
  var_0 linkto(self, var_1.sittag, (0, 0, 0), (0, 0, 0));
  var_0 notsolid();
  thread animontag(var_0, var_1.sittag, var_1.death);

  if(!isdefined(var_1.death_delayed_ragdoll))
    var_0 waittillmatch("animontagdone", "start_ragdoll");
  else {
    var_0 unlink();
    var_0 startragdoll();
    wait(var_1.death_delayed_ragdoll);
    var_0 delete();
    return;
  }

  var_0 unlink();

  if(getdvar("ragdoll_enable") == "0") {
    var_0 delete();
    return;
  }

  while (gettime() < var_2 && !var_0 isragdoll()) {
    var_0 startragdoll();
    wait 0.05;
  }

  if(!var_0 isragdoll())
    var_0 delete();
}

load_ai(var_0, var_1, var_2) {
  if(!isdefined(var_1))
    var_1 = 0;

  if(!isdefined(var_0))
    var_0 = vehicle_get_riders();

  maps\_utility::ent_flag_clear("unloaded");
  maps\_utility::ent_flag_clear("loaded");
  common_scripts\utility::array_levelthread(var_0, ::get_in_vehicle, var_1, var_2);
}

is_rider(var_0) {
  for (var_1 = 0; var_1 < self.riders.size; var_1++) {
    if(self.riders[var_1] == var_0)
      return 1;
  }

  return 0;
}

vehicle_get_riders() {
  var_0 = [];
  var_1 = getaiarray(self.script_team);

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(!isdefined(var_3.script_vehicleride)) {
      continue;
    }
    if(var_3.script_vehicleride != self.script_vehicleride) {
      continue;
    }
    var_0[var_0.size] = var_3;
  }

  return var_0;
}

get_my_vehicleride() {
  var_0 = [];
  var_1 = maps\_vehicle::get_script_vehicles();

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(!isdefined(var_3.script_vehicleride)) {
      continue;
    }
    if(var_3.script_vehicleride != self.script_vehicleride) {
      continue;
    }
    var_0[var_0.size] = var_3;
  }

  return var_0[0];
}

get_in_vehicle(var_0, var_1, var_2) {
  if(is_rider(var_0)) {
    return;
  }
  if(!handle_detached_guys_check()) {
    return;
  }
  guy_runtovehicle(var_0, self, var_1, var_2);
}

handle_detached_guys_check() {
  if(vehicle_hasavailablespots())
    return 1;
}

vehicle_hasavailablespots() {
  if(level.vehicle_aianims[self.classname].size - self.runningtovehicle.size)
    return 1;
  else
    return 0;
}

guy_runtovehicle_loaded(var_0, var_1) {
  var_1 endon("death");
  var_1 endon("stop_loading");
  var_2 = var_0 common_scripts\utility::waittill_any_return("long_death", "death", "enteredvehicle");

  if(var_2 != "enteredvehicle" && isdefined(var_0.forced_startingposition))
    var_1.usedpositions[var_0.forced_startingposition] = 0;

  var_1.runningtovehicle = common_scripts\utility::array_remove(var_1.runningtovehicle, var_0);
  vehicle_loaded_if_full(var_1);
}

vehicle_loaded_if_full(var_0) {
  if(isdefined(var_0.vehicletype) && isdefined(var_0.vehicle_loaded_notify_size)) {
    if(var_0.riders.size == var_0.vehicle_loaded_notify_size)
      var_0 maps\_utility::ent_flag_set("loaded");
  } else if(!var_0.runningtovehicle.size && var_0.riders.size) {
    if(var_0.usedpositions[0])
      var_0 maps\_utility::ent_flag_set("loaded");
    else
      var_0 thread vehicle_reload();
  }
}

vehicle_reload() {
  var_0 = self.riders;
  maps\_vehicle::vehicle_unload();
  maps\_utility::ent_flag_wait("unloaded");
  var_0 = maps\_utility::array_removedead(var_0);
  thread maps\_vehicle::vehicle_load_ai(var_0);
}

remove_magic_bullet_shield_from_guy_on_unload_or_death(var_0) {
  common_scripts\utility::waittill_any("unload", "death");
  var_0 maps\_utility::stop_magic_bullet_shield();
}

guy_runtovehicle(var_0, var_1, var_2, var_3) {
  var_1 endon("stop_loading");
  var_4 = 1;

  if(!isdefined(var_2))
    var_2 = 0;

  var_5 = level.vehicle_aianims[var_1.classname];

  if(isdefined(var_1.runtovehicleoverride)) {
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
  var_9 = 0;

  for (var_10 = 0; var_10 < var_5.size; var_10++) {
    if(isdefined(var_5[var_10].getin))
      var_9 = 1;
  }

  if(!var_9) {
    var_0 notify("enteredvehicle");
    var_1 guy_enter(var_0, var_4);
    return;
  }

  if(!isdefined(var_0.get_in_moving_vehicle)) {
    while (var_1 vehicle_getspeed() > 1)
      wait 0.05;
  }

  var_11 = var_1 get_availablepositions(var_3);

  if(isdefined(var_0.script_startingposition))
    var_7 = var_1 vehicle_getinstart(var_0.script_startingposition);
  else if(!var_1.usedpositions[0]) {
    var_7 = var_1 vehicle_getinstart(0);

    if(var_2) {
      var_0 thread maps\_utility::magic_bullet_shield();
      thread remove_magic_bullet_shield_from_guy_on_unload_or_death(var_0);
    }
  } else if(var_11.availablepositions.size)
    var_7 = common_scripts\utility::getclosest(var_0.origin, var_11.availablepositions);
  else
    var_7 = undefined;

  if(!var_11.availablepositions.size && var_11.nonanimatedpositions.size) {
    var_0 notify("enteredvehicle");
    var_1 guy_enter(var_0, var_4);
    return;
  } else if(!isdefined(var_7)) {
    return;
  }
  var_8 = var_7.origin;
  var_12 = var_7.angles;
  var_0.forced_startingposition = var_7.vehicle_position;
  var_1.usedpositions[var_7.vehicle_position] = 1;
  var_0.script_moveoverride = 1;
  var_0 notify("stop_going_to_node");
  var_0 maps\_utility::set_forcegoal();
  var_0 maps\_utility::disable_arrivals();
  var_0.goalradius = 16;
  var_0 setgoalpos(var_8);
  var_0 waittill("goal");
  var_0 maps\_utility::enable_arrivals();
  var_0 maps\_utility::unset_forcegoal();
  var_0 notify("boarding_vehicle");
  var_13 = anim_pos(var_1, var_7.vehicle_position);

  if(isdefined(var_13.delay)) {
    var_0.delay = var_13.delay;

    if(isdefined(var_13.delayinc))
      self.delayer = var_0.delay;
  }

  if(isdefined(var_13.delayinc)) {
    self.delayer = self.delayer + var_13.delayinc;
    var_0.delay = self.delayer;
  }

  var_1 link_to_sittag(var_0, var_13.sittag, var_13.sittag_offset, var_13.linktoblend);
  var_0.allowdeath = 0;
  var_13 = var_5[var_7.vehicle_position];

  if(isdefined(var_7)) {
    if(isdefined(var_13.vehicle_getinanim)) {
      if(isdefined(var_13.vehicle_getoutanim)) {
        var_14 = isdefined(var_0.no_vehicle_getoutanim);

        if(!var_14)
          var_1 clearanim(var_13.vehicle_getoutanim, 0);
      }

      var_1 = var_1 getanimatemodel();
      var_1 thread setanimrestart_once(var_13.vehicle_getinanim, var_13.vehicle_getinanim_clear);
      level thread maps\_anim::start_notetrack_wait(var_1, "vehicle_anim_flag");
    }

    if(isdefined(var_13.vehicle_getinsoundtag))
      var_8 = var_1 gettagorigin(var_13.vehicle_getinsoundtag);
    else
      var_8 = var_1.origin;

    if(isdefined(var_13.vehicle_getinsound))
      thread common_scripts\utility::play_sound_in_space(var_13.vehicle_getinsound, var_8);

    var_15 = undefined;
    var_16 = undefined;

    if(isdefined(var_13.getin_enteredvehicletrack)) {
      var_15 = [];
      var_15[0] = var_13.getin_enteredvehicletrack;
      var_16 = [];
      var_16[0] = ::entered_vehicle_notify;
      var_1 link_to_sittag(var_0, var_13.sittag, var_13.sittag_offset, var_13.linktoblend);
    }

    var_1 animontag(var_0, var_13.sittag, var_13.getin, var_15, var_16);
  }

  var_0 notify("enteredvehicle");
  var_1 guy_enter(var_0, var_4);
}

entered_vehicle_notify() {
  self notify("enteredvehicle");
}

driverdead(var_0) {
  if(maps\_vehicle::ishelicopter()) {
    return;
  }
  self.driver = var_0;
  self endon("death");
  var_0 endon("jumping_out");
  var_0 waittill("death");

  if(isdefined(self.vehicle_keeps_going_after_driver_dies)) {
    return;
  }
  self notify("driver dead");
  self.deaddriver = 1;

  if(isdefined(self.hasstarted) && self.hasstarted) {
    self setwaitspeed(0);
    self vehicle_setspeed(0, 10);
    self waittill("reached_wait_speed");
  }

  maps\_vehicle::vehicle_unload();
}

copy_cat() {
  var_0 = spawn("script_model", self.origin);
  var_0 setmodel(self.model);
  var_1 = self getattachsize();

  for (var_2 = 0; var_2 < var_1; var_2++)
    var_0 attach(self getattachmodelname(var_2));

  return var_0;
}

guy_becomes_real_ai(var_0, var_1) {
  if(isai(var_0))
    return var_0;

  if(var_0.drone_delete_on_unload == 1)
    var_0 delete();
  else {
    var_0 = maps\_utility::swap_drone_to_ai(var_0);
    var_2 = self.classname;
    var_3 = level.vehicle_aianims[var_2].size;
    var_4 = anim_pos(self, var_1);
    link_to_sittag(var_0, var_4.sittag, var_4.sittag_offset, var_4.linktoblend);
    var_0.vehicle_idle = var_4.idle;
    thread guy_idle(var_0, var_1);
  }
}

link_to_sittag(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self;

  if(isdefined(var_4) && var_4)
    var_6 = self.mgturret[var_5];

  if(!isdefined(var_2))
    var_2 = (0, 0, 0);

  if(!isdefined(var_3))
    var_3 = 0;

  if(var_3 && !isdefined(var_0.script_drone))
    var_0 linktoblendtotag(var_6, var_1, 0);
  else
    var_0 linkto(var_6, var_1, var_2, (0, 0, 0));
}

anim_pos(var_0, var_1) {
  return level.vehicle_aianims[var_0.classname][var_1];
}

guy_deathhandle(var_0, var_1) {
  var_0 waittill("death");

  if(!isdefined(self)) {
    return;
  }
  self.riders = common_scripts\utility::array_remove(self.riders, var_0);
  self.usedpositions[var_1] = 0;
}

setup_aianimthreads() {
  if(!isdefined(level.vehicle_aianimthread))
    level.vehicle_aianimthread = [];

  if(!isdefined(level.vehicle_aianimcheck))
    level.vehicle_aianimcheck = [];

  level.vehicle_aianimthread["idle"] = ::guy_idle;
  level.vehicle_aianimthread["duck"] = ::guy_duck;
  level.vehicle_aianimthread["duck_once"] = ::guy_duck_once;
  level.vehicle_aianimcheck["duck_once"] = ::guy_duck_once_check;
  level.vehicle_aianimthread["weave"] = ::guy_weave;
  level.vehicle_aianimcheck["weave"] = ::guy_weave_check;
  level.vehicle_aianimthread["turn_right"] = ::guy_turn_right;
  level.vehicle_aianimcheck["turn_right"] = ::guy_turn_right_check;
  level.vehicle_aianimthread["turn_left"] = ::guy_turn_left;
  level.vehicle_aianimcheck["turn_left"] = ::guy_turn_right_check;
  level.vehicle_aianimthread["turn_hardright"] = ::guy_turn_hardright;
  level.vehicle_aianimthread["turn_hardleft"] = ::guy_turn_hardleft;
  level.vehicle_aianimthread["turret_fire"] = ::guy_turret_fire;
  level.vehicle_aianimthread["turret_turnleft"] = ::guy_turret_turnleft;
  level.vehicle_aianimthread["turret_turnright"] = ::guy_turret_turnright;
  level.vehicle_aianimthread["unload"] = ::guy_unload;
  level.vehicle_aianimthread["pre_unload"] = ::guy_pre_unload;
  level.vehicle_aianimcheck["pre_unload"] = ::guy_pre_unload_check;
  level.vehicle_aianimthread["idle_alert"] = ::guy_idle_alert;
  level.vehicle_aianimcheck["idle_alert"] = ::guy_idle_alert_check;
  level.vehicle_aianimthread["idle_alert_to_casual"] = ::guy_idle_alert_to_casual;
  level.vehicle_aianimcheck["idle_alert_to_casual"] = ::guy_idle_alert_to_casual_check;
  level.vehicle_aianimthread["reaction"] = ::guy_turret_turnright;
}

guy_handle(var_0, var_1) {
  var_0.vehicle_idling = 1;
  thread guy_deathhandle(var_0, var_1);
}

guy_stand_attack(var_0, var_1) {
  var_2 = anim_pos(self, var_1);
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");
  var_0.standing = 1;
  var_3 = 0;

  for (;;) {
    var_4 = gettime() + 2000;

    while (gettime() < var_4 && isdefined(var_0.enemy))
      animontag(var_0, var_2.sittag, var_0.vehicle_standattack, undefined, undefined, "firing");

    var_5 = randomint(5) + 10;

    for (var_6 = 0; var_6 < var_5; var_6++)
      animontag(var_0, var_2.sittag, var_2.standidle);
  }
}

guy_stand_down(var_0, var_1) {
  var_2 = anim_pos(self, var_1);

  if(!isdefined(var_2.standdown)) {
    thread guy_stand_attack(var_0, var_1);
    return;
  }

  animontag(var_0, var_2.sittag, var_2.standdown);
  var_0.standing = 0;
  thread guy_idle(var_0, var_1);
}

driver_idle_speed(var_0, var_1) {
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");
  var_2 = anim_pos(self, var_1);

  for (;;) {
    if(self vehicle_getspeed() == 0)
      var_0.vehicle_idle = var_2.idle_animstop;
    else
      var_0.vehicle_idle = var_2.idle_anim;

    wait 0.25;
  }
}

guy_reaction(var_0, var_1) {
  var_2 = anim_pos(self, var_1);
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");

  if(isdefined(var_2.reaction))
    animontag(var_0, var_2.sittag, var_2.reaction);

  thread guy_idle(var_0, var_1);
}

guy_turret_turnleft(var_0, var_1) {
  var_2 = anim_pos(self, var_1);
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");

  for (;;)
    animontag(var_0, var_2.sittag, var_0.turret_turnleft);
}

guy_turret_turnright(var_0, var_1) {
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");
  var_2 = anim_pos(self, var_1);

  for (;;)
    animontag(var_0, var_2.sittag, var_0.turret_turnleft);
}

guy_turret_fire(var_0, var_1) {
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");
  var_2 = anim_pos(self, var_1);

  if(isdefined(var_2.vehicle_turret_fire))
    maps\_vehicle_code::_get_dummy() setanimrestart(var_2.vehicle_turret_fire);

  if(isdefined(var_2.turret_fire)) {
    if(isdefined(var_2.turret_fire_tag))
      animontag(var_0, var_2.turret_fire_tag, var_2.turret_fire);
    else
      animontag(var_0, var_2.sittag, var_2.turret_fire);
  }

  thread guy_idle(var_0, var_1);
}

guy_idle(var_0, var_1, var_2) {
  var_0 endon("newanim");

  if(!isdefined(var_2))
    self endon("death");

  var_0 endon("death");
  var_0.vehicle_idling = 1;
  var_0 notify("gotime");

  if(!isdefined(var_0.vehicle_idle)) {
    return;
  }
  var_3 = anim_pos(self, var_1);

  if(isdefined(var_3.mgturret)) {
    return;
  }
  if(isdefined(var_3.hideidle) && var_3.hideidle)
    var_0 hide();

  if(isdefined(var_3.idle_animstop) && isdefined(var_3.idle_anim))
    thread driver_idle_speed(var_0, var_1);

  for (;;) {
    var_0 notify("idle");
    play_new_idle(var_0, var_3);
  }
}

play_new_idle(var_0, var_1) {
  if(isdefined(var_0.vehicle_idle_override)) {
    animontag(var_0, var_1.sittag, var_0.vehicle_idle_override);
    return;
  }

  if(isdefined(var_1.idleoccurrence)) {
    var_2 = randomoccurrance(var_0, var_1.idleoccurrence);
    animontag(var_0, var_1.sittag, var_0.vehicle_idle[var_2]);
    return;
  }

  if(isdefined(var_0.playerpiggyback) && isdefined(var_1.player_idle)) {
    animontag(var_0, var_1.sittag, var_1.player_idle);
    return;
  }

  if(isdefined(var_1.vehicle_idle))
    thread setanimrestart_once(var_1.vehicle_idle);

  animontag(var_0, var_1.sittag, var_0.vehicle_idle);
}

randomoccurrance(var_0, var_1) {
  var_2 = [];
  var_3 = 0;

  for (var_4 = 0; var_4 < var_1.size; var_4++) {
    var_3 = var_3 + var_1[var_4];
    var_2[var_4] = var_3;
  }

  var_5 = randomint(var_3);

  for (var_4 = 0; var_4 < var_1.size; var_4++) {
    if(var_5 < var_2[var_4])
      return var_4;
  }
}

guy_duck_once_check(var_0, var_1) {
  return isdefined(anim_pos(self, var_1).duck_once);
}

guy_duck_once(var_0, var_1) {
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");
  var_2 = anim_pos(self, var_1);

  if(isdefined(var_2.duck_once)) {
    if(isdefined(var_2.vehicle_duck_once))
      thread setanimrestart_once(var_2.vehicle_duck_once);

    animontag(var_0, var_2.sittag, var_2.duck_once);
  }

  thread guy_idle(var_0, var_1);
}

guy_weave_check(var_0, var_1) {
  return isdefined(anim_pos(self, var_1).weave);
}

guy_weave(var_0, var_1) {
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");
  var_2 = anim_pos(self, var_1);

  if(isdefined(var_2.weave)) {
    if(isdefined(var_2.vehicle_weave))
      thread setanimrestart_once(var_2.vehicle_weave);

    animontag(var_0, var_2.sittag, var_2.weave);
  }

  thread guy_idle(var_0, var_1);
}

guy_duck(var_0, var_1) {
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");
  var_2 = anim_pos(self, var_1);

  if(isdefined(var_2.duckin))
    animontag(var_0, var_2.sittag, var_2.duckin);

  thread guy_duck_idle(var_0, var_1);
}

guy_duck_idle(var_0, var_1) {
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");
  var_2 = anim_pos(self, var_1);
  var_3 = randomoccurrance(var_0, var_2.duckidleoccurrence);

  for (;;)
    animontag(var_0, var_2.sittag, var_2.duckidle[var_3]);
}

guy_duck_out(var_0, var_1) {
  var_2 = anim_pos(self, var_1);

  if(isdefined(var_2.ducking) && var_0.ducking) {
    animontag(var_0, var_2.sittag, var_2.duckout);
    var_0.ducking = 0;
  }

  thread guy_idle(var_0, var_1);
}

guy_unload_que(var_0) {
  self endon("death");
  self.unloadque = common_scripts\utility::array_add(self.unloadque, var_0);
  var_0 common_scripts\utility::waittill_any("death", "jumpedout");
  self.unloadque = common_scripts\utility::array_remove(self.unloadque, var_0);

  if(!self.unloadque.size) {
    maps\_utility::ent_flag_set("unloaded");
    self.unload_group = "default";
  }
}

riders_unloadable(var_0) {
  if(!self.riders.size)
    return 0;

  for (var_1 = 0; var_1 < self.riders.size; var_1++) {
    if(!isalive(self.riders[var_1])) {
      continue;
    }
    if(check_unloadgroup(self.riders[var_1].vehicle_position, var_0))
      return 1;
  }

  return 0;
}

get_unload_group() {
  var_0 = [];
  var_1 = [];
  var_2 = "default";

  if(isdefined(self.unload_group))
    var_2 = self.unload_group;

  var_1 = level.vehicle_unloadgroups[self.classname][var_2];

  if(!isdefined(var_1))
    var_1 = level.vehicle_unloadgroups[self.classname]["default"];

  if(isdefined(var_1)) {
    foreach(var_4 in var_1)
    var_0[var_4] = var_4;
  }

  return var_0;
}

check_unloadgroup(var_0, var_1) {
  if(!isdefined(var_1))
    var_1 = self.unload_group;

  var_2 = self.classname;

  if(!isdefined(level.vehicle_unloadgroups[var_2]))
    return 1;

  if(!isdefined(level.vehicle_unloadgroups[var_2][var_1]))
    return 1;

  var_3 = level.vehicle_unloadgroups[var_2][var_1];

  for (var_4 = 0; var_4 < var_3.size; var_4++) {
    if(var_0 == var_3[var_4])
      return 1;
  }

  return 0;
}

getoutrig_model_idle(var_0, var_1, var_2) {
  self endon("unloading");

  for (;;)
    animontag(var_0, var_1, var_2);
}

getoutrig_model(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self.classname;

  if(var_4) {
    thread getoutrig_model_idle(var_1, var_2, level.vehicle_attachedmodels[var_5][var_0.fastroperig].idleanim);
    self waittill("unloading");
  }

  self.unloadque = common_scripts\utility::array_add(self.unloadque, var_1);
  thread getoutrig_abort(var_1, var_2, var_3);

  if(!isdefined(self.crashing))
    animontag(var_1, var_2, var_3);

  var_1 unlink();

  if(!isdefined(self)) {
    var_1 delete();
    return;
  }

  self.unloadque = common_scripts\utility::array_remove(self.unloadque, var_1);

  if(!self.unloadque.size)
    self notify("unloaded");

  self.fastroperig[var_0.fastroperig] = undefined;
  wait 10;
  var_1 delete();
}

getoutrig_disable_abort_notify_after_riders_out() {
  wait 0.05;

  while (isalive(self) && self.unloadque.size > 2)
    wait 0.05;

  if(!isalive(self) || isdefined(self.crashing) && self.crashing) {
    return;
  }
  self notify("getoutrig_disable_abort");
}

getoutrig_abort_while_deploying() {
  self endon("end_getoutrig_abort_while_deploying");

  while (!isdefined(self.crashing))
    wait 0.05;

  common_scripts\utility::array_levelthread(self.riders, maps\_utility::deleteent);
  self notify("crashed_while_deploying");
}

getoutrig_abort(var_0, var_1, var_2) {
  var_3 = getanimlength(var_2);
  var_4 = var_3 - 1.0;

  if(self.vehicletype == "mi17")
    var_4 = var_3 - 0.5;

  var_5 = 2.5;
  self endon("getoutrig_disable_abort");
  thread getoutrig_disable_abort_notify_after_riders_out();
  thread getoutrig_abort_while_deploying();
  common_scripts\utility::waittill_notify_or_timeout("crashed_while_deploying", var_5);
  self notify("end_getoutrig_abort_while_deploying");

  while (!isdefined(self.crashing))
    wait 0.05;

  thread animontag(var_0, var_1, var_2);
  waittillframeend;
  var_0 setanimtime(var_2, var_4 / var_3);
  var_6 = self;

  if(isdefined(self.achievement_attacker))
    var_6 = self.achievement_attacker;

  for (var_7 = 0; var_7 < self.riders.size; var_7++) {
    if(!isdefined(self.riders[var_7])) {
      continue;
    }
    if(!isdefined(self.riders[var_7].ragdoll_getout_death)) {
      continue;
    }
    if(self.riders[var_7].ragdoll_getout_death != 1) {
      continue;
    }
    if(!isdefined(self.riders[var_7].ridingvehicle)) {
      continue;
    }
    self.riders[var_7].forcefallthroughonropes = 1;

    if(isalive(self.riders[var_7]))
      thread animontag_ragdoll_death_fall(self.riders[var_7], self, var_6);
  }
}

setanimrestart_once(var_0, var_1) {
  self endon("death");
  self endon("dont_clear_anim");

  if(!isdefined(var_1))
    var_1 = 1;

  var_2 = getanimlength(var_0);
  var_3 = maps\_vehicle_code::_get_dummy();
  var_3 endon("death");
  var_3 setflaggedanimrestart("vehicle_anim_flag", var_0, 1, 0, 1);
  wait(var_2);

  if(var_1 && (!isdefined(self.dont_clear_vehicle_anim) || !self.dont_clear_vehicle_anim))
    var_3 clearanim(var_0, 0);
}

#using_animtree("generic_human");

getout_rigspawn(var_0, var_1, var_2) {
  if(!isdefined(var_2))
    var_2 = 1;

  var_3 = self.classname;
  var_4 = anim_pos(self, var_1);

  if(isdefined(self.attach_model_override) && isdefined(self.attach_model_override[var_4.fastroperig]))
    var_5 = 1;
  else
    var_5 = 0;

  if(!isdefined(var_4.fastroperig) || isdefined(self.fastroperig[var_4.fastroperig]) || var_5) {
    return;
  }
  var_6 = var_0 gettagorigin(level.vehicle_attachedmodels[var_3][var_4.fastroperig].tag);
  var_7 = var_0 gettagangles(level.vehicle_attachedmodels[var_3][var_4.fastroperig].tag);
  self.fastroperiganimating[var_4.fastroperig] = 1;
  var_8 = spawn("script_model", var_6);
  var_8.angles = var_7;
  var_8.origin = var_6;
  var_8 setmodel(level.vehicle_attachedmodels[var_3][var_4.fastroperig].model);
  self.fastroperig[var_4.fastroperig] = var_8;
  var_8 useanimtree(#animtree);
  var_8 linkto(var_0, level.vehicle_attachedmodels[var_3][var_4.fastroperig].tag, (0, 0, 0), (0, 0, 0));
  thread getoutrig_model(var_4, var_8, level.vehicle_attachedmodels[var_3][var_4.fastroperig].tag, level.vehicle_attachedmodels[var_3][var_4.fastroperig].dropanim, var_2);
  return var_8;
}

check_sound_tag_dupe(var_0) {
  if(!isdefined(self.sound_tag_dupe))
    self.sound_tag_dupe = [];

  var_1 = 0;

  if(!isdefined(self.sound_tag_dupe[var_0]))
    self.sound_tag_dupe[var_0] = 1;
  else
    var_1 = 1;

  thread check_sound_tag_dupe_reset(var_0);
  return var_1;
}

check_sound_tag_dupe_reset(var_0) {
  wait 0.05;

  if(!isdefined(self)) {
    return;
  }
  self.sound_tag_dupe[var_0] = 0;
  var_1 = getarraykeys(self.sound_tag_dupe);

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(self.sound_tag_dupe[var_1[var_2]])
      return;
  }

  self.sound_tag_dupe = undefined;
}

guy_unload_custom(var_0, var_1) {
  if(!check_unloadgroup(var_1)) {
    thread guy_idle(var_0, var_1);
    return;
  }

  self.unloadque = common_scripts\utility::array_add(self.unloadque, var_0);
  var_2 = var_0[[var_0.customunloadfunc]](self, var_1);

  if(!var_2)
    thread guy_idle(var_0, var_1);
  else
    guy_disassociate_internal(var_0, var_1);

  self.unloadque = common_scripts\utility::array_remove(self.unloadque, var_0);
  waittillframeend;

  if(!self.unloadque.size) {
    maps\_utility::ent_flag_set("unloaded");
    self.unload_group = "default";
  }
}

guy_unload(var_0, var_1) {
  if(isdefined(var_0.customunloadfunc)) {
    guy_unload_custom(var_0, var_1);
    return;
  }

  var_2 = anim_pos(self, var_1);
  var_3 = self.vehicletype;

  if(isdefined(var_2.nodeath))
    var_0.a.nodeath = 0;

  if(!check_unloadgroup(var_1)) {
    thread guy_idle(var_0, var_1);
    return;
  }

  if(!isdefined(var_2.getout) && !isdefined(var_2.bnoanimunload)) {
    thread guy_idle(var_0, var_1);
    return;
  }

  if(isdefined(var_2.hideidle) && var_2.hideidle)
    var_0 show();

  thread guy_unload_que(var_0);
  self endon("death");

  if(isai(var_0) && isalive(var_0))
    var_0 endon("death");

  if(isdefined(var_0.getoffvehiclefunc)) {
    if(isdefined(var_2.delay)) {
      wait(var_2.delay);
      var_2.delay = undefined;
      var_0.delay = undefined;
    }

    var_0[[var_0.getoffvehiclefunc]]();
  }

  if(isdefined(var_0.onrotatingvehicleturret)) {
    var_0.onrotatingvehicleturret = undefined;

    if(isdefined(var_0.getoffvehiclefunc))
      var_0[[var_0.getoffvehiclefunc]]();
  }

  var_4 = getanimatemodel();

  if(isdefined(var_2.vehicle_getoutanim)) {
    var_4 thread setanimrestart_once(var_2.vehicle_getoutanim, var_2.vehicle_getoutanim_clear);
    var_5 = 0;

    if(isdefined(var_2.vehicle_getoutsoundtag)) {
      var_5 = check_sound_tag_dupe(var_2.vehicle_getoutsoundtag);
      var_6 = var_4 gettagorigin(var_2.vehicle_getoutsoundtag);
    } else
      var_6 = var_4.origin;

    if(isdefined(var_2.vehicle_getoutsound) && !var_5)
      thread common_scripts\utility::play_sound_in_space(var_2.vehicle_getoutsound, var_6);

    var_5 = undefined;
  }

  var_7 = 0;

  if(isdefined(var_2.getout_timed_anim))
    var_7 = var_7 + getanimlength(var_2.getout_timed_anim);

  if(isdefined(var_2.delay))
    var_7 = var_7 + var_2.delay;

  if(isdefined(var_0.delay))
    var_7 = var_7 + var_0.delay;

  if(var_7 > 0) {
    thread guy_idle(var_0, var_1);
    wait(var_7);
  }

  var_8 = isdefined(var_2.getout_combat);

  if(!var_8 && var_0.standing)
    guy_stand_down(var_0, var_1);
  else if(!var_8 && !var_0.vehicle_idling && isdefined(var_0.vehicle_idle))
    var_0 waittill("idle");

  var_0.deathanim = undefined;
  var_0.deathanimscript = undefined;
  var_0 notify("newanim");

  if(isdefined(var_2.bhasgunwhileriding) && !var_2.bhasgunwhileriding) {
    if(!isdefined(var_0.disable_gun_recall))
      var_0 maps\_utility::gun_recall();
  }

  if(isai(var_0))
    var_0 pushplayer(1);

  var_9 = 0;

  if(isdefined(var_2.bnoanimunload))
    var_9 = 1;
  else if(!isdefined(var_2.getout) || !isdefined(self.script_unloadmgguy) && (isdefined(var_2.bisgunner) && var_2.bisgunner) || isdefined(self.script_keepdriver) && var_1 == 0) {
    thread guy_idle(var_0, var_1);
    return;
  }

  if(var_0 should_give_orghealth())
    var_0.health = var_0.orghealth;

  var_0.orghealth = undefined;

  if(isai(var_0) && isalive(var_0))
    var_0 endon("death");

  var_0.allowdeath = 0;

  if(isdefined(var_2.exittag))
    var_10 = var_2.exittag;
  else
    var_10 = var_2.sittag;

  if(var_8 && var_0.standing)
    var_11 = var_2.getout_combat;
  else if(isdefined(var_0.get_out_override))
    var_11 = var_0.get_out_override;
  else if(isdefined(var_0.playerpiggyback) && isdefined(var_2.player_getout))
    var_11 = var_2.player_getout;
  else
    var_11 = var_2.getout;

  if(!var_9) {
    if(!isdefined(var_0.parachute_unload))
      thread guy_unlink_on_death(var_0);

    if(isdefined(var_2.fastroperig)) {
      if(!isdefined(self.fastroperig[var_2.fastroperig])) {
        thread guy_idle(var_0, var_1);
        var_12 = getout_rigspawn(var_4, var_0.vehicle_position, 0);
      }
    }

    if(isdefined(var_2.getoutsnd))
      var_0 thread maps\_utility::play_sound_on_tag(var_2.getoutsnd, "J_Wrist_RI", 1);

    if(isdefined(var_0.playerpiggyback) && isdefined(var_2.player_getout_sound))
      var_0 thread maps\_utility::play_sound_on_entity(var_2.player_getout_sound);

    if(isdefined(var_2.getoutloopsnd))
      var_0 thread maps\_utility::play_loop_sound_on_tag(var_2.getoutloopsnd);

    if(isdefined(var_0.playerpiggyback) && isdefined(var_2.player_getout_sound_loop))
      level.player thread common_scripts\utility::play_loop_sound_on_entity(var_2.player_getout_sound_loop);

    var_0 notify("newanim");
    var_0 notify("jumping_out");
    var_13 = 0;

    if(!isai(var_0) && !var_0 should_stay_drone()) {
      var_13 = 1;
      var_0 = guy_becomes_real_ai(var_0, var_1);
    }

    if(!isalive(var_0)) {
      return;
    }
    var_0.ragdoll_getout_death = 1;

    if(isdefined(var_2.rappel_kill_achievement))
      var_0 maps\_utility::enable_achievement_harder_they_fall();

    if(isdefined(var_2.fastroperig))
      var_0 maps\_utility::enable_achievement_reinforcement_denied(self, var_2.fastroperig);

    if(isdefined(var_2.ragdoll_getout_death)) {
      var_0.ragdoll_getout_death = 1;

      if(isdefined(var_2.ragdoll_fall_anim))
        var_0.ragdoll_fall_anim = var_2.ragdoll_fall_anim;
    }

    if(var_13) {
      self.riders = common_scripts\utility::array_add(self.riders, var_0);
      thread guy_deathhandle(var_0, var_1);
      thread guy_unload_que(var_0);
      var_0.ridingvehicle = self;
    }

    if(isai(var_0))
      var_0 endon("death");

    var_0 notify("newanim");
    var_0 notify("jumping_out");

    if(isdefined(var_2.littlebirde_getout_unlinks) && var_2.littlebirde_getout_unlinks)
      thread stable_unlink(var_0);

    if(isdefined(var_2.getout_secondary)) {
      animontag(var_0, var_10, var_11);
      var_14 = var_10;

      if(isdefined(var_2.getout_secondary_tag))
        var_14 = var_2.getout_secondary_tag;

      animontag(var_0, var_14, var_2.getout_secondary);
    } else if(isdefined(var_2.parachute_unload)) {
      if(!isdefined(self.angle_offset)) {
        self.angle_offset = 0;
        self.origin_offset = (0, 0, 0);
        self.unload_delay = 0.5;
      } else {
        self.unload_delay = self.unload_delay + randomfloatrange(0.5, 1);
        wait(self.unload_delay);
      }

      if(!isdefined(self)) {
        return;
      }
      var_15 = spawn("script_model", self gettagorigin(var_10));
      var_15.angles = (0, self.angles[1] + self.angle_offset, 0);
      self.angle_offset = self.angle_offset + 5;
      var_15 setmodel("tag_origin");
      var_16 = maps\_utility::groundpos(self.origin) + (0, 0, self.unload_anim_height);
      var_15.origin = var_16 + (randomintrange(10, 20), randomintrange(10, 20), 0);
      var_17 = spawn("script_model", var_15.origin);
      var_17.angles = var_15.angles;
      var_17 setmodel(self.unload_model);
      var_17.animname = "parachute";
      var_17 useanimtree(level.scr_animtree["parachute"]);
      var_17 hide();
      var_17 maps\_utility::ent_flag_init("parachute_open");

      if(isdefined(var_2.parachute_function))
        var_15 parachute_unload(var_0, var_17, self.unload_model_unload_anim, var_11, var_2.parachute_function);
      else
        var_15 parachute_unload(var_0, var_17, self.unload_model_unload_anim, var_11);

      var_15 delete();
    } else {
      var_0.anim_end_early = 1;

      if(isdefined(var_0.getout_ik)) {
        thread animontag(var_0, var_10, var_11, undefined, undefined);
        var_0 thread wait_do_ik_on();
        var_0.a.nodeath = 1;
        var_18 = var_0 wait_interrupt_or_done();

        if(isdefined(var_18) && var_18 == "interrupt") {
          while (!isdefined(var_0.ik_turned_on))
            waitframe();

          var_0 stopanimscripted();
          var_0 notify("newanim");
          var_0 notify("animontag_thread");
        }

        var_0 _meth_8570(0);
        self.ik_turned_on = undefined;
        var_0.getout_ik = undefined;
        var_0.a.nodeath = 0;
      } else
        animontag(var_0, var_10, var_11, undefined, undefined);
    }

    if(isdefined(var_0.playerpiggyback) && isdefined(var_2.player_getout_sound_loop))
      level.player thread common_scripts\utility::stop_loop_sound_on_entity(var_2.player_getout_sound_loop);

    if(isdefined(var_2.getoutloopsnd))
      var_0 thread common_scripts\utility::stop_loop_sound_on_entity(var_2.getoutloopsnd);

    if(isdefined(var_0.playerpiggyback) && isdefined(var_2.player_getout_sound_end))
      level.player thread maps\_utility::play_sound_on_entity(var_2.player_getout_sound_end);
  } else if(!isai(var_0)) {
    if(var_0.drone_delete_on_unload == 1) {
      var_0 delete();
      return;
    }

    var_0 = maps\_utility::swap_drone_to_ai(var_0);
  }

  self.riders = common_scripts\utility::array_remove(self.riders, var_0);
  self.usedpositions[var_1] = 0;
  var_0.ridingvehicle = undefined;
  var_0.drivingvehicle = undefined;

  if(!isalive(self) && !isdefined(var_2.unload_ondeath)) {
    var_0 delete();
    return;
  }

  var_0 unlink();

  if(!isdefined(var_0.magic_bullet_shield)) {
    if(isdefined(var_0.noragdoll))
      var_0.noragdoll = undefined;
  }

  if(!isai(var_0) && var_0 should_stay_drone()) {
    if(var_0.drone_delete_on_unload) {
      var_0 delete();
      return;
    }
  }

  if(isalive(var_0)) {
    if(isai(var_0)) {
      if(isdefined(var_0.a.disablelongdeath_saved))
        var_0.a.disablelongdeath = var_0.a.disablelongdeath_saved;
      else
        var_0.a.disablelongdeath = !var_0 isbadguy();
    }

    var_0.forced_startingposition = undefined;
    var_0 notify("jumpedout");
    var_0 maps\_utility::disable_achievement_harder_they_fall();

    if(isdefined(var_2.fastroperig) && isalive(var_0))
      var_0 maps\_utility::disable_achievement_reinforcement_denied();

    if(isai(var_0)) {
      if(isdefined(var_2.getoutstance)) {
        var_0.desired_anim_pose = var_2.getoutstance;
        var_0 allowedstances("crouch");
        var_0 thread animscripts\utility::updateanimpose();
        var_0 allowedstances("stand", "crouch", "prone");
      }

      var_0 pushplayer(0);

      if(guy_resets_goalpos(var_0)) {
        var_0.goalradius = 600;
        var_0 setgoalpos(var_0.origin);
      }
    }
  }

  if(isdefined(var_2.getout_delete) && var_2.getout_delete) {
    var_0 delete();
    return;
  }

  var_0 guy_cleanup_vehiclevars();
}

wait_do_ik_on() {
  self endon("newanim");
  self endon("animontag_thread");
  self waittillmatch("animontagdone", "start_foot_ik");
  self _meth_8570(1);
  self.ik_turned_on = 1;
}

wait_interrupt_or_done() {
  self endon("anim_on_tag_done");
  common_scripts\utility::waittill_any("damage", "death", "explode", "bullethit", "gunshot", "explode", "doFlashBanged", "bulletwhizby");
  return "interrupt";
}

should_stay_drone() {
  if(isdefined(self.script_stay_drone))
    return 1;

  if(isdefined(self.drone_delete_on_unload) && self.drone_delete_on_unload)
    return 1;

  return 0;
}

parachute_unload(var_0, var_1, var_2, var_3, var_4) {
  var_0 unlink();
  var_5 = var_1 gettagorigin("tag_driver");
  var_6 = var_1 gettagangles("tag_driver");
  var_0 forceteleport(var_5, var_6);
  var_0 linkto(var_1, "tag_driver");
  var_1 animscripted("parachute_unload", self.origin, self.angles, var_2);

  if(isdefined(var_4))
    var_1 thread parachute_notetrack_logic("parachute_unload", "show_parachute", var_4);
  else
    var_1 thread parachute_notetrack_logic("parachute_unload", "show_parachute");

  var_0 animscripted("parachute_unload", var_0.origin, var_0.angles, var_3);
  level thread parachute_death_monitor(var_0, var_1);
  var_1 waittillmatch("parachute_unload", "end");
  var_1 notify("parachute_landed");

  if(isalive(var_0))
    var_0 unlink();
}

parachute_movement(var_0) {
  var_1 = anglestoforward(var_0.angles);
  var_2 = vectornormalize(common_scripts\utility::flat_angle(var_1));
  var_3 = self.origin + var_2 * 10000;
  thread maps\_utility::draw_line_from_ent_for_time(self, var_3, 1, 0, 0, 10);
  self moveto(var_3, 1);
}

parachute_death_monitor(var_0, var_1) {
  var_1 endon("parachute_landed");

  if(isdefined(var_0.magic_bullet_shield) && var_0.magic_bullet_shield) {
    return;
  }
  if(!isai(var_0))
    var_0 setcandamage(1);

  var_2 = undefined;
  var_3 = undefined;

  for (;;) {
    var_0 waittill("damage", var_2, var_3);

    if(!isdefined(var_2)) {
      continue;
    }
    if(var_2 < 1) {
      continue;
    }
    if(!isdefined(var_3)) {
      continue;
    }
    if(isplayer(var_3)) {
      break;
    }
  }

  if(!var_1 maps\_utility::ent_flag("parachute_open")) {
    var_1 notify("rider_dead");
    thread animontag_ragdoll_death_fall(var_0, undefined, var_3);
    wait 2;
    var_1 delete();
  } else
    iprintln("parachute death anim here!");
}

parachute_notetrack_logic(var_0, var_1, var_2) {
  self endon("rider_dead");
  self waittillmatch(var_0, var_1);

  if(isdefined(var_2))
    self thread[[var_2]]();

  maps\_utility::ent_flag_set("parachute_open");
}

guy_resets_goalpos(var_0) {
  if(isdefined(var_0.script_delayed_playerseek))
    return 0;

  if(var_0 maps\_utility::has_color())
    return 0;

  if(isdefined(var_0.qsetgoalpos))
    return 0;

  if(!isdefined(var_0.target))
    return 1;

  var_1 = getnodearray(var_0.target, "targetname");

  if(var_1.size > 1)
    return 0;

  var_2 = getent(var_0.target, "targetname");

  if(isdefined(var_2) && var_2.classname == "info_volume") {
    var_0 setgoalvolumeauto(var_2);
    return 0;
  } else if(var_1.size == 1)
    return 0;

  return 1;
}

animontag(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 notify("animontag_thread");
  var_0 endon("animontag_thread");

  if(!isdefined(var_5))
    var_5 = "animontagdone";

  if(isdefined(self.modeldummy))
    var_6 = self.modeldummy;
  else
    var_6 = self;

  if(!isdefined(var_1)) {
    var_7 = var_0.origin;
    var_8 = var_0.angles;
  } else {
    var_7 = var_6 gettagorigin(var_1);
    var_8 = var_6 gettagangles(var_1);
  }

  if(isdefined(var_0.ragdoll_getout_death) && !isdefined(var_0.no_vehicle_ragdoll))
    level thread animontag_ragdoll_death(var_0, self);

  var_0 animscripted(var_5, var_7, var_8, var_2);

  if(isai(var_0))
    thread donotetracks(var_0, var_6, var_5);

  if(isdefined(var_0.anim_end_early)) {
    var_0.anim_end_early = undefined;
    var_9 = getanimlength(var_2) - 0.25;

    if(var_9 > 0)
      wait(var_9);

    if(!isdefined(var_0) || isremovedentity(var_0)) {
      return;
    }
    var_0 stopanimscripted();
    var_0.interval = 0;
    var_0 thread recover_interval();
  } else {
    if(isdefined(var_3)) {
      for (var_10 = 0; var_10 < var_3.size; var_10++) {
        var_0 waittillmatch(var_5, var_3[var_10]);
        var_0 thread[[var_4[var_10]]]();
      }
    }

    var_0 waittillmatch(var_5, "end");
  }

  var_0 notify("anim_on_tag_done");
  var_0.ragdoll_getout_death = undefined;
}

recover_interval() {
  self endon("death");
  wait 2;

  if(isdefined(self) && self.interval == 0)
    self.interval = 80;
}

animontag_ragdoll_death(var_0, var_1) {
  if(isdefined(var_0.magic_bullet_shield) && var_0.magic_bullet_shield) {
    return;
  }
  if(!isai(var_0))
    var_0 setcandamage(1);

  var_0 endon("anim_on_tag_done");

  if(!isdefined(var_0.cansurvivevehicleexplosion) || !var_0.cansurvivevehicleexplosion)
    thread animontag_unloading_vehicle_explosion(var_0, var_1);

  var_2 = undefined;
  var_3 = undefined;
  var_4 = var_1.health <= 0;

  for (;;) {
    if(!var_4 && !(isdefined(var_1) && var_1.health > 0)) {
      break;
    }

    var_0 waittill("damage", var_2, var_3);

    while (isdefined(var_0.getout_ik) && !isdefined(var_0.ik_turned_on))
      waitframe();

    if(isdefined(var_0.forcefallthroughonropes)) {
      break;
    }

    if(!isdefined(var_2)) {
      continue;
    }
    if(var_2 < 1) {
      continue;
    }
    if(!isdefined(var_3)) {
      continue;
    }
    if(isplayer(var_3)) {
      break;
    }
  }

  if(!isalive(var_0)) {
    return;
  }
  thread animontag_ragdoll_death_fall(var_0, var_1, var_3);
}

animontag_ragdoll_death_fall(var_0, var_1, var_2) {
  var_0.deathanim = undefined;
  var_0.deathfunction = undefined;
  var_0.anim_disablepain = 1;

  if(isdefined(var_0.ragdoll_fall_anim)) {
    var_3 = getmovedelta(var_0.ragdoll_fall_anim, 0, 1);
    var_4 = physicstrace(var_0.origin + (0, 0, 16), var_0.origin - (0, 0, 10000));
    var_5 = distance(var_0.origin + (0, 0, 16), var_4);

    if(abs(var_3[2] + 16) <= abs(var_5)) {
      var_0 thread maps\_utility::play_sound_on_entity("generic_death_falling");
      var_0 animscripted("fastrope_fall", var_0.origin, var_0.angles, var_0.ragdoll_fall_anim);
      var_0 waittillmatch("fastrope_fall", "start_ragdoll");
    }
  }

  if(!isdefined(var_0)) {
    return;
  }
  var_0.deathanim = undefined;
  var_0.deathfunction = undefined;
  var_0.anim_disablepain = 1;
  var_0 notify("rope_death", var_2);
  maps\_spawner::death_achievements_rappel(var_2);
  var_0 kill(var_2.origin, var_2);

  if(isdefined(var_0.script_stay_drone) || isdefined(var_0.drone_delete_on_unload)) {
    var_0 notsolid();
    var_6 = getweaponmodel(var_0.weapon);
    var_7 = var_0.weapon;

    if(isdefined(var_6)) {
      var_0 detach(var_6, "tag_weapon_right");
      var_8 = var_0 gettagorigin("tag_weapon_right");
      var_9 = var_0 gettagangles("tag_weapon_right");
      level.gun = spawn("weapon_" + var_7, (0, 0, 0));
      level.gun.angles = var_9;
      level.gun.origin = var_8;
    }
  } else
    var_0 animscripts\shared::dropallaiweapons();

  if(isdefined(var_0.death_flop_dir)) {
    if(isdefined(var_0.get_out_time)) {
      var_10 = 0.33;

      if(isdefined(var_0.min_unload_frac_to_flop))
        var_10 = var_0.min_unload_frac_to_flop;

      var_11 = var_0 getanimtime(var_0.get_out_anim);

      if(var_11 < var_10)
        wait(var_0.get_out_time * (var_10 - var_11));

      if(isremovedentity(var_0))
        return;
    }

    var_12 = length(var_0.death_flop_dir);
    var_13 = vectornormalize(var_1 localtoworldcoords(var_0.death_flop_dir) - var_0.origin) * var_12;
    var_0 startragdollfromimpact("torso_lower", var_13);
  } else
    var_0 startragdoll();
}

animontag_unloading_vehicle_explosion(var_0, var_1) {
  var_0 endon("anim_on_tag_done");
  var_0 endon("death");
  var_1 waittill("death", var_2, var_3, var_4);

  if(isdefined(var_0.magic_bullet_shield) && var_0.magic_bullet_shield) {
    return;
  }
  var_5 = 0;

  if(isdefined(var_0.min_unload_frac_to_flop)) {
    var_6 = var_0 getanimtime(var_0.get_out_anim);

    if(var_6 < var_0.min_unload_frac_to_flop)
      var_5 = 1;
  }

  if(!isremovedentity(var_0)) {
    if(var_5) {
      var_0 notify("killanimscript");
      waittillframeend;
      var_0 thread delayed_exploded_guy_deletion();
    }

    if(isdefined(var_2))
      var_0 kill(var_0.origin, var_2);
    else
      var_0 kill();
  }
}

delayed_exploded_guy_deletion() {
  waitframe();

  if(!isremovedentity(self))
    self delete();
}

donotetracks(var_0, var_1, var_2) {
  var_0 endon("newanim");
  var_1 endon("death");
  var_0 endon("death");
  var_0 animscripts\shared::donotetracks(var_2);
}

animatemoveintoplace(var_0, var_1, var_2, var_3) {
  var_0 animscripted("movetospot", var_1, var_2, var_3);
  var_0 waittillmatch("movetospot", "end");
}

guy_vehicle_death(var_0, var_1, var_2) {
  if(!isalive(var_0)) {
    return;
  }
  if(isdefined(self.no_rider_death)) {
    return;
  }
  var_3 = anim_pos(self, var_0.vehicle_position);
  var_0.vehicle_attacker = var_1;

  if(isdefined(var_3.explosion_death))
    return guy_blowup(var_0);

  if(isdefined(level.vehicle_rider_death_func) && isdefined(level.vehicle_rider_death_func[self.classname])) {
    self[[level.vehicle_rider_death_func[self.classname]]]();
    return;
  }

  if(isdefined(var_3.unload_ondeath) && isdefined(self)) {
    if(isdefined(self.dontunloadondeath) && self.dontunloadondeath) {
      return;
    }
    thread guy_idle(var_0, var_0.vehicle_position, 1);
    wait(var_3.unload_ondeath);

    if(isdefined(var_0) && isdefined(self)) {
      self.groupedanim_pos = var_0.vehicle_position;
      maps\_vehicle::vehicle_ai_event("unload");
    }

    return;
  }

  if(isdefined(var_0)) {
    if(isdefined(var_0.ragdoll_getout_death) && var_2 != "bm21_troops") {
      return;
    }
    [
      [level.global_kill_func]
    ]("MOD_RIFLE_BULLET", "torso_upper", var_0.origin);
    var_0 delete();
  }
}

guy_turn_right_check(var_0, var_1) {
  return isdefined(anim_pos(self, var_1).turn_right);
}

guy_turn_right(var_0, var_1) {
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");
  var_2 = anim_pos(self, var_1);

  if(isdefined(var_2.vehicle_turn_right))
    thread setanimrestart_once(var_2.vehicle_turn_right);

  animontag(var_0, var_2.sittag, var_2.turn_right);
  thread guy_idle(var_0, var_1);
}

guy_turn_left(var_0, var_1) {
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");
  var_2 = anim_pos(self, var_1);

  if(isdefined(var_2.vehicle_turn_left))
    thread setanimrestart_once(var_2.vehicle_turn_left);

  animontag(var_0, var_2.sittag, var_2.turn_left);
  thread guy_idle(var_0, var_1);
}

guy_turn_left_check(var_0, var_1) {
  return isdefined(anim_pos(self, var_1).turn_left);
}

guy_turn_hardright(var_0, var_1) {
  var_2 = level.vehicle_aianims[self.classname][var_1];

  if(isdefined(var_2.idle_hardright))
    var_0.vehicle_idle_override = var_2.idle_hardright;
}

guy_turn_hardleft(var_0, var_1) {
  var_2 = level.vehicle_aianims[self.classname][var_1];

  if(isdefined(var_2.idle_hardleft))
    var_0.vehicle_idle_override = var_2.idle_hardleft;
}

ai_wait_go() {
  self endon("death");
  self waittill("loaded");
  maps\_vehicle::gopath(self);
}

set_pos(var_0, var_1) {
  var_2 = var_0.script_startingposition;

  if(isdefined(var_0.forced_startingposition))
    var_2 = var_0.forced_startingposition;

  if(isdefined(var_2))
    return var_2;

  if(!isdefined(self.usedpositions)) {
    return;
  }
  for (var_3 = 0; var_3 < self.usedpositions.size; var_3++) {
    if(self.usedpositions[var_3]) {
      continue;
    }
    return var_3;
  }

  if(isdefined(var_0.script_vehicleride)) {}
}

guy_man_turret(var_0, var_1, var_2) {
  var_3 = anim_pos(self, var_1);
  var_4 = self.mgturret[var_3.mgturret];

  if(!isalive(var_0)) {
    return;
  }
  var_4 endon("death");
  var_0 endon("death");

  if(isdefined(var_2) && var_2 && isdefined(var_3.passenger_2_turret_func))
    [[var_3.passenger_2_turret_func]](self, var_0, var_1, var_4);

  maps\_vehicle_code::set_turret_team(var_4);
  var_4 setdefaultdroppitch(0);
  wait 0.1;
  var_0 endon("guy_man_turret_stop");
  level thread maps\_mgturret::mg42_setdifficulty(var_4, maps\_utility::getdifficulty());
  var_4 setmode("auto_ai");
  var_4 setturretignoregoals(1);

  if(isdefined(var_3.sittag_on_turret) && var_3.sittag_on_turret)
    var_4 thread maps\_mgturret_auto_nonai::main(var_0, var_3);
  else {
    for (;;) {
      if(!isdefined(var_0 getturret()))
        var_0 useturret(var_4);

      wait 1;
    }
  }
}

guy_unlink_on_death(var_0) {
  var_0 endon("jumpedout");
  var_0 waittill("death");

  if(isdefined(var_0))
    var_0 unlink();
}

guy_blowup(var_0) {
  if(!isdefined(var_0.vehicle_position)) {
    return;
  }
  var_1 = var_0.vehicle_position;
  var_2 = anim_pos(self, var_1);

  if(!isdefined(var_2.explosion_death)) {
    return;
  }
  [[level.global_kill_func]]("MOD_RIFLE_BULLET", "torso_upper", var_0.origin);
  var_0.deathanim = var_2.explosion_death;
  var_3 = self.angles;
  var_4 = var_0.origin;

  if(isdefined(var_2.explosion_death_offset)) {
    var_4 = var_4 + anglestoforward(var_3) * var_2.explosion_death_offset[0];
    var_4 = var_4 + anglestoright(var_3) * var_2.explosion_death_offset[1];
    var_4 = var_4 + anglestoup(var_3) * var_2.explosion_death_offset[2];
  }

  var_0 = convert_guy_to_drone(var_0);
  detach_models_with_substr(var_0, "weapon_");
  var_0 notsolid();
  var_0.origin = var_4;
  var_0.angles = var_3;
  var_0 animscripted("deathanim", var_4, var_3, var_2.explosion_death);
  var_5 = 0.3;

  if(isdefined(var_2.explosion_death_ragdollfraction))
    var_5 = var_2.explosion_death_ragdollfraction;

  var_6 = getanimlength(var_2.explosion_death);
  var_7 = gettime() + var_6 * 1000;
  wait(var_6 * var_5);
  var_8 = (0, 0, 1);
  var_9 = var_0.origin;

  if(getdvar("ragdoll_enable") == "0") {
    var_0 delete();
    return;
  }

  if(isai(var_0))
    var_0 animscripts\shared::dropallaiweapons();
  else
    detach_models_with_substr(var_0, "weapon_");

  while (!var_0 isragdoll() && gettime() < var_7) {
    var_9 = var_0.origin;
    wait 0.05;
    var_8 = var_0.origin - var_9;
    var_0 startragdoll();
  }

  wait 0.05;
  var_8 = var_8 * 20000;

  for (var_10 = 0; var_10 < 3; var_10++) {
    if(isdefined(var_0))
      var_9 = var_0.origin;

    wait 0.05;
  }

  if(!var_0 isragdoll())
    var_0 delete();
}

convert_guy_to_drone(var_0, var_1, var_2) {
  if(!isdefined(var_1))
    var_1 = 0;

  if(!isdefined(var_2))
    var_2 = 1;

  var_3 = spawn("script_model", var_0.origin);
  var_3.angles = var_0.angles;
  var_3 setmodel(var_0.model);
  var_4 = var_0 getattachsize();

  for (var_5 = 0; var_5 < var_4 && (var_2 || var_5 < 1); var_5++)
    var_3 attach(var_0 getattachmodelname(var_5), var_0 getattachtagname(var_5));

  var_3 useanimtree(#animtree);

  if(isdefined(var_0.team))
    var_3.team = var_0.team;

  if(!var_1)
    var_0 delete();

  var_3 makefakeai();
  return var_3;
}

vehicle_animate(var_0, var_1) {
  self useanimtree(var_1);
  self setanim(var_0);
}

vehicle_getinstart(var_0) {
  var_1 = anim_pos(self, var_0);
  return vehicle_getanimstart(var_1.getin, var_1.sittag, var_0);
}

vehicle_getanimstart(var_0, var_1, var_2) {
  var_3 = spawnstruct();
  var_4 = undefined;
  var_5 = undefined;
  var_6 = self gettagorigin(var_1);
  var_7 = self gettagangles(var_1);
  var_4 = getstartorigin(var_6, var_7, var_0);
  var_5 = getstartangles(var_6, var_7, var_0);
  var_3.origin = var_4;
  var_3.angles = var_5;
  var_3.vehicle_position = var_2;
  return var_3;
}

is_position_in_group(var_0, var_1, var_2) {
  if(!isdefined(var_2))
    return 1;

  var_3 = var_0.classname;
  var_4 = level.vehicle_unloadgroups[var_3][var_2];

  foreach(var_6 in var_4) {
    if(var_6 == var_1)
      return 1;
  }

  return 0;
}

get_availablepositions(var_0) {
  var_1 = level.vehicle_aianims[self.classname];
  var_2 = [];
  var_3 = [];

  for (var_4 = 0; var_4 < self.usedpositions.size; var_4++) {
    if(self.usedpositions[var_4]) {
      continue;
    }
    if(isdefined(var_1[var_4].getin) && is_position_in_group(self, var_4, var_0)) {
      var_2[var_2.size] = vehicle_getinstart(var_4);
      continue;
    }

    var_3[var_3.size] = var_4;
  }

  var_5 = spawnstruct();
  var_5.availablepositions = var_2;
  var_5.nonanimatedpositions = var_3;
  return var_5;
}

getanimatemodel() {
  if(isdefined(self.modeldummy))
    return self.modeldummy;
  else
    return self;
}

detach_models_with_substr(var_0, var_1) {
  var_2 = var_0 getattachsize();
  var_3 = [];
  var_4 = [];
  var_5 = 0;

  for (var_6 = 0; var_6 < var_2; var_6++) {
    var_7 = var_0 getattachmodelname(var_6);
    var_8 = var_0 getattachtagname(var_6);

    if(issubstr(var_7, var_1)) {
      var_3[var_5] = var_7;
      var_4[var_5] = var_8;
      var_5++;
    }
  }

  for (var_6 = 0; var_6 < var_3.size; var_6++)
    var_0 detach(var_3[var_6], var_4[var_6]);
}

should_give_orghealth() {
  if(!isai(self))
    return 0;

  if(!isdefined(self.orghealth))
    return 0;

  return !isdefined(self.magic_bullet_shield);
}

guy_pre_unload_check(var_0, var_1) {
  return isdefined(anim_pos(self, var_1).pre_unload);
}

guy_pre_unload(var_0, var_1) {
  var_2 = anim_pos(self, var_1);

  if(!isdefined(var_2.pre_unload)) {
    return;
  }
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");
  animontag(var_0, var_2.sittag, var_2.pre_unload);

  for (;;)
    animontag(var_0, var_2.sittag, var_2.pre_unload_idle);
}

guy_idle_alert(var_0, var_1) {
  var_2 = anim_pos(self, var_1);

  if(!isdefined(var_2.idle_alert)) {
    return;
  }
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");

  for (;;)
    animontag(var_0, var_2.sittag, var_2.idle_alert);
}

guy_idle_alert_check(var_0, var_1) {
  return isdefined(anim_pos(self, var_1).idle_alert);
}

guy_idle_alert_to_casual(var_0, var_1) {
  var_2 = anim_pos(self, var_1);

  if(!isdefined(var_2.idle_alert)) {
    return;
  }
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");
  animontag(var_0, var_2.sittag, var_2.idle_alert_to_casual);
  thread guy_idle(var_0, var_1);
}

guy_idle_alert_to_casual_check(var_0, var_1) {
  return isdefined(anim_pos(self, var_1).idle_alert_to_casual);
}

stable_unlink(var_0) {
  self waittill("stable_for_unlink");

  if(isalive(var_0))
    var_0 unlink();
}

track_entered_vehicle() {}

animate_guys(var_0) {
  var_1 = [];

  foreach(var_3 in self.riders) {
    if(!isalive(var_3)) {
      continue;
    }
    if(isdefined(level.vehicle_aianimcheck[var_0]) && ![
        [level.vehicle_aianimcheck[var_0]]
      ](var_3, var_3.vehicle_position)) {
      continue;
    }
    if(isdefined(level.vehicle_aianimthread[var_0])) {
      var_3 notify("newanim");
      var_3.queued_anim_threads = [];
      thread[[level.vehicle_aianimthread[var_0]]](var_3, var_3.vehicle_position);
      var_1[var_1.size] = var_3;
      continue;
    }

    var_3 notify("newanim");
    var_3.queued_anim_threads = [];
    thread guy_vehicle_anim_simple(var_3, var_3.vehicle_position, var_0);
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

guy_vehicle_anim_simple(var_0, var_1, var_2) {
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");
  var_3 = anim_pos(self, var_1);

  if(isdefined(var_3.aianim_simple_vehicle[var_2]))
    thread setanimrestart_once(var_3.aianim_simple_vehicle[var_2]);

  animontag(var_0, var_3.sittag, var_3.aianim_simple[var_2]);
  guy_idle(var_0, var_1);
}

guy_cleanup_vehiclevars() {
  self.vehicle_idling = undefined;
  self.standing = undefined;
  self.vehicle_position = undefined;
  self.delay = undefined;
}

delete_corpses_around_vehicle() {
  var_0 = self getcentroid();
  var_1 = self getpointinbounds(1, 0, 0);
  var_2 = distance(var_1, var_0);
  var_3 = getcorpsearray();

  foreach(var_5 in var_3) {
    if(distance(var_5.origin, var_0) < var_2)
      var_5 delete();
  }
}

disassociate_guy_from_vehicle() {
  if(isdefined(self.ridingvehicle))
    self.ridingvehicle guy_disassociate_internal(self, self.vehicle_position);
}

guy_disassociate_internal(var_0, var_1) {
  var_0 notify("jumpedout");
  self.riders = common_scripts\utility::array_remove(self.riders, var_0);
  self.usedpositions[var_1] = 0;
  var_0.ridingvehicle = undefined;
  var_0.drivingvehicle = undefined;
  var_0 guy_cleanup_vehiclevars();
}