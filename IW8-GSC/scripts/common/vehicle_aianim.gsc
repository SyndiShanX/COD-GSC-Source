/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\vehicle_aianim.gsc
***********************************************/

function guy_enter(var0, var1) {
  var0 endon("death_or_disconnect");

  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  if(!isDefined(self.vehicletype)) {
    return;
  }

  var2 = scripts\common\vehicle_code::get_vehicle_classname();
  var3 = level.vehicle.templates.aianims[var2];
  self.attachedguys[self.attachedguys.size] = var0;
  var4 = set_pos(var0, var3);

  if(!isDefined(var4)) {
    return;
  }

  if(var4 == 0) {
    var0.drivingvehicle = 1;
  }

  var5 = anim_pos(self, var4);
  self.usedpositions[var4] = 1;
  var0.vehicle_position = var4;
  var0.vehicle_idling = 0;

  if(isDefined(var5.delay)) {
    var0.delay = var5.delay;

    if(isDefined(var5.delayinc)) {
      self.delayer = var0.delay;
    }
  }

  if(isDefined(var5.delayinc)) {
    self.delayer += var5.delayinc;
    var0.delay = self.delayer;
  }

  var0.ridingvehicle = self;
  var0.orghealth = var0.health;
  var0.vehicle_idle = var5.idle;
  var0.vehicle_standattack = var5.standattack;

  if(!getdvarint("enable_vehicle_ai_using_BT")) {
    var0.deathanim = var5.death;
    var0.deathanimscript = var5.deathscript;
  }

  var0.standing = 0;
  var0.allowdeath = 1;

  if(!getdvarint("enable_vehicle_ai_using_BT")) {
    if(isDefined(var0.deathanim) && !isDefined(var0.magic_bullet_shield) && vehicle_allows_rider_death()) {
      if(var0.vehicle_position != 0 || vehicle_allows_driver_death()) {
        var0.allowdeath = !isDefined(var0.script_allowdeath) || var0.script_allowdeath;

        if(isDefined(var5.death_no_ragdoll)) {
          var0.noragdoll = var5.death_no_ragdoll;
        }
      }
    }
  } else if(!isDefined(var0.magic_bullet_shield) && vehicle_allows_rider_death()) {
    var0.allowdeath = !isDefined(var0.script_allowdeath) || var0.script_allowdeath;

    if(isDefined(var5.death_no_ragdoll)) {
      var0.noragdoll = var5.death_no_ragdoll;
    }
  }

  if(!isDefined(var0.classname)) {
    return;
  }

  if(var0.classname == "script_model") {
    if(isDefined(var5.death) && var0.allowdeath && (!isDefined(var0.script_allowdeath) || var0.script_allowdeath)) {
      thread guy_death(var0, var5);
    }
  }

  self.riders[self.riders.size] = var0;

  if(var0.classname != "script_model" && scripts\common\ai::spawn_failed(var0)) {
    return;
  }

  var6 = self gettagorigin(var5.sittag);
  var7 = self gettagangles(var5.sittag);

  if(!getdvarint("enable_vehicle_ai_using_BT")) {
    link_to_sittag(var0, var5.sittag, var5.sittag_origin_offset, var5.sittag_angles_offset, var5.linktoblend);
  } else if(!var0 scripts\vehicle\vehicle_common::hasvehicle()) {
    var8 = vehicle_getinstart(var4);
    var0 scripts\vehicle\vehicle_common::entervehicle(self, 1, var8, var5);
  }

  if(isai(var0)) {
    if(!getdvarint("enable_vehicle_ai_using_BT")) {
      var0 forceteleport(var6, var7);
    }

    if(isDefined(var0.a)) {
      var0.a.disablelongdeath = 1;
    }

    if(isDefined(var5.bhasgunwhileriding) && !var5.bhasgunwhileriding) {
      var0 scripts\common\ai::gun_remove();
    }

    if(guy_should_man_turret(var5)) {
      thread guy_man_turret(var0, var4, var1);
    }
  } else {
    if(isDefined(var5.bhasgunwhileriding) && !var5.bhasgunwhileriding) {
      detach_models_with_substr(var0, "weapon_");
    }

    var0.origin = var6;
    var0.angles = var7;
  }

  if(var4 == 0) {
    self.driver = var0;

    if(getdvarint("enable_vehicle_ai_using_BT") || isDefined(var3[0].death)) {
      thread driverdead(var0);
    }
  }

  self notify("guy_entered", var0, var4);
  var0 notify("loaded");
  scripts\engine\utility::ent_flag_clear("unloaded");
  thread guy_handle(var0, var4);

  if(isDefined(var5.rider_func)) {
    var0[[var5.rider_func]]();
    return;
  }

  if(!getdvarint("enable_vehicle_ai_using_BT")) {
    if(isDefined(var5.getin_idle_func)) {
      GscBinSkip1(0x74, var5.getin_idle_func, var0, var4);
    }

    thread guy_idle(var0, var4);
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

function guy_should_man_turret(var0) {
  if(!isDefined(var0.mgturret)) {
    return false;
  }

  if(!isDefined(self.script_nomg)) {
    return true;
  }

  return !self.script_nomg;
}

function handle_attached_guys() {
  var0 = scripts\common\vehicle_code::get_vehicle_classname();
  self.attachedguys = [];

  if(!(isDefined(level.vehicle.templates.aianims) && isDefined(level.vehicle.templates.aianims[var0]))) {
    return;
  }

  var1 = level.vehicle.templates.aianims[var0].size;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "ai_wait_go") {
    thread ai_wait_go();
  }

  self.runningtovehicle = [];
  self.usedpositions = [];
  self.getinorgs = [];
  self.delayer = 0;
  var2 = level.vehicle.templates.aianims[var0];

  for(var3 = 0; var3 < var1; var3++) {
    self.usedpositions[var3] = 0;

    if(isDefined(self.script_nomg) && self.script_nomg && isDefined(var2[var3].bisgunner) && var2[var3].bisgunner) {
      self.usedpositions[1] = 1;
    }
  }
}

function load_ai_goddriver(var0) {
  load_ai(var0, 1);
}

function guy_death(var0, var1) {
  waittillframeend();
  var0 setCanDamage(1);
  var0 endon("death");
  var0.allowdeath = 0;
  var0.health = 10150;

  if(isDefined(var0.script_startinghealth)) {
    var0.health += var0.script_startinghealth;
  }

  var0 endon("jumping_out");

  if(isDefined(var0.magic_bullet_shield) && var0.magic_bullet_shield) {
    while(isDefined(var0.magic_bullet_shield) && var0.magic_bullet_shield) {
      wait 0.05;
    }
  }

  while(var0.health > 10000) {
    var0 waittill("damage");
  }

  thread guy_deathimate_me(var0, var1);
}

function guy_deathimate_me(var0, var1) {
  var2 = gettime() + getanimlength(var1.death) * 1000;
  var3 = var0.angles;
  var4 = var0.origin;
  var0 = convert_guy_to_drone(var0);
  detach_models_with_substr(var0, "weapon_");
  var0 linkTo(self);
  var0 notsolid();
  var0 setanim(var1.death);

  if(isai(var0)) {
    var0 scripts\engine\utility::script_func("anim_dropallaiweapons");
  } else {
    detach_models_with_substr(var0, "weapon_");
  }

  if(isDefined(var1.death_delayed_ragdoll)) {
    var0 unlink();

    if(isDefined(var0.fnpreragdoll)) {
      var0[[var0.fnpreragdoll]]();
    }

    var0 startragdoll();
    wait var1.death_delayed_ragdoll;
    var0 delete();
    return;
  }
}

function load_ai(var0, var1, var2) {
  self endon("death");

  if(var0.size) {
    if(!isDefined(var1)) {
      var1 = 0;
    }

    scripts\engine\utility::ent_flag_clear("unloaded");
    scripts\engine\utility::ent_flag_clear("loaded");
    scripts\engine\utility::array_levelthread(var0, &get_in_vehicle, var1, var2);
    scripts\engine\utility::array_wait(var0, "loaded");
  }

  scripts\engine\utility::ent_flag_set("loaded");
}

function is_rider(var0) {
  for(var1 = 0; var1 < self.riders.size; var1++) {
    if(self.riders[var1] == var0) {
      return true;
    }
  }

  return false;
}

function get_in_vehicle(var0, var1, var2) {
  if(is_rider(var0)) {
    return;
  }

  if(!handle_detached_guys_check()) {
    return;
  }

  guy_runtovehicle(var0, self, var1, var2);
}

function handle_detached_guys_check() {
  if(vehicle_hasavailablespots()) {
    return 1;
  }

  if(!scripts\common\utility::issp()) {
    var0 = self.classname_mp;
    return;
  }

  var0 = self.class;
}

function vehicle_hasavailablespots() {
  if(level.vehicle.templates.aianims[scripts\common\vehicle_code::get_vehicle_classname()].size - self.runningtovehicle.size) {
    return 1;
  }

  return 0;
}

function guy_runtovehicle_loaded(var0, var1) {
  var1 endon("death");
  var1 endon("stop_loading");

  if(!getdvarint("enable_vehicle_ai_using_BT")) {
    var2 = var0 scripts\engine\utility::ref_143ae("long_death", "death", "enteredvehicle");

    if(var2 != "enteredvehicle" && isDefined(var0.forced_startingposition)) {
      var1.usedpositions[var0.forced_startingposition] = 0;
    }
  } else if(!var0 scripts\vehicle\vehicle_common::waitforentervehicle() && isDefined(var0.forced_startingposition)) {
    var1.usedpositions[var0.forced_startingposition] = 0;
  }

  var1.runningtovehicle = scripts\engine\utility::array_remove(var1.runningtovehicle, var0);
  vehicle_loaded_if_full(var1);
}

function vehicle_loaded_if_full(var0) {
  if(isDefined(var0.vehicletype) && isDefined(var0.vehicle_loaded_notify_size)) {
    if(var0.riders.size == var0.vehicle_loaded_notify_size) {
      var0 scripts\engine\utility::ent_flag_set("loaded");
      return;
    }

    return;
  }

  if(!var0.runningtovehicle.size && var0.riders.size) {
    if(var0.usedpositions[0]) {
      var0 scripts\engine\utility::ent_flag_set("loaded");
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
  var0 = self.riders;
  scripts\common\vehicle::vehicle_unload();
  scripts\engine\utility::ent_flag_wait("unloaded");
  var0 = scripts\engine\utility::array_removedead(var0);
  thread scripts\common\vehicle::vehicle_load_ai(var0);
}

function remove_magic_bullet_shield_from_guy_on_unload_or_death(var0) {
  scripts\engine\utility::ref_143a5("unload", "death");
  var0 scripts\common\ai::stop_magic_bullet_shield();
}

function choose_vehicle_position(var0, var1, var2) {
  var0 endon("stop_loading");
  self endon("stop_loading");

  if(!isDefined(var2)) {
    var2 = 0;
  }

  var3 = undefined;
  var4 = 0;

  if(isDefined(var0.script_startingposition)) {
    var3 = vehicle_getinstart(var0.script_startingposition);
  } else if(!self.usedpositions[0]) {
    var3 = vehicle_getinstart(0);

    if(var2) {
      var0 thread scripts\common\ai::magic_bullet_shield();
      thread remove_magic_bullet_shield_from_guy_on_unload_or_death(var0);
    }
  } else if(var1.availablepositions.size) {
    var3 = scripts\engine\utility::getclosest(var0.origin, var1.availablepositions);
  } else {
    var3 = undefined;
  }

  return var3;
}

function guy_runtovehicle(var0, var1, var2, var3) {
  var0 endon("stop_loading");
  var1 endon("stop_loading");
  var4 = 1;

  if(!isDefined(var2)) {
    var2 = 0;
  }

  var5 = level.vehicle.templates.aianims[var1 scripts\common\vehicle_code::get_vehicle_classname()];

  if(isDefined(var1.runtovehicleoverride)) {
    var1 thread[[var1.runtovehicleoverride]](var0);
    return;
  }

  var1 endon("death");
  var0 endon("death");
  var1.runningtovehicle[var1.runningtovehicle.size] = var0;
  thread guy_runtovehicle_loaded(var0, var1);
  var6 = [];
  var7 = undefined;
  var8 = 0;
  var9 = getdvarint("enable_vehicle_ai_using_BT");

  for(var10 = 0; var10 < var5.size; var10++) {
    if(isDefined(var5[var10].getin)) {
      var9 = 1;
    }
  }

  if(!var9) {
    var0 notify("enteredvehicle");

    if(getdvarint("enable_vehicle_ai_using_BT")) {
      var7 = choose_vehicle_position(var0, get_availablepositions(var3), var2);
      var0.forced_startingposition = var7.vehicle_position;
      var1.usedpositions[var7.vehicle_position] = 1;
      var0 scripts\vehicle\vehicle_common::entervehicle(self, 1, var7, anim_pos(self, var0.forced_startingposition));
    }

    guy_enter(var1, var0, var4);
    return;
  }

  if(!isDefined(var0.get_in_moving_vehicle)) {
    while(var1 vehicle_getspeed() > 1) {
      wait 0.05;
    }
  }

  var11 = get_availablepositions(var1, var3);

  if(!var11.availablepositions.size && var11.nonanimatedpositions.size) {
    var0 notify("enteredvehicle");
    guy_enter(var1, var0, var4);
    return;
  }

  var7 = choose_vehicle_position(var0, var11, var2);

  if(!isDefined(var7)) {
    return;
  }

  var8 = var7.origin;
  var12 = var7.angles;
  var0.forced_startingposition = var7.vehicle_position;
  var1.usedpositions[var7.vehicle_position] = 1;

  if(!getdvarint("enable_vehicle_ai_using_BT")) {
    var0.script_moveoverride = 1;
    var0 notify("stop_going_to_node");
    var0 scripts\common\ai::set_forcegoal();
    var0 scripts\common\ai::disable_arrivals();
    var0.goalradius = 64;
    var0 setgoalpos(var8);
    var0 waittill("goal");
    var0 scripts\common\ai::enable_arrivals();
    var0 scripts\common\ai::unset_forcegoal();
    var0 notify("boarding_vehicle");
  } else {
    var0 scripts\vehicle\vehicle_common::requestentervehicle(self, 0, var7, anim_pos(self, var7.vehicle_position));
    var0 scripts\vehicle\vehicle_common::waitforarrivedatvehicle();
  }

  var13 = anim_pos(var1, var7.vehicle_position);

  if(isDefined(var13.delay)) {
    var0.delay = var13.delay;

    if(isDefined(var13.delayinc)) {
      self.delayer = var0.delay;
    }
  }

  if(isDefined(var13.delayinc)) {
    self.delayer += var13.delayinc;
    var0.delay = self.delayer;
  }

  if(!getdvarint("enable_vehicle_ai_using_BT")) {
    link_to_sittag(var1, var0, var13.sittag, var13.sittag_origin_offset, var13.sittag_angles_offset, var13.linktoblend);
  }

  var0.allowdeath = 0;
  var13 = var5[var7.vehicle_position];

  if(isDefined(var7)) {
    if(isDefined(var13.vehicle_getinanim)) {
      var14 = isDefined(var0.no_vehicle_getoutanim);

      if(!var14 && !isagent(var0)) {
        if(isDefined(var13.vehicle_getoutanim)) {
          var1 clearanim(var13.vehicle_getoutanim, 0);
        }

        if(isDefined(var13.vehicle_getoutanim_combat)) {
          var1 clearanim(var13.vehicle_getoutanim_combat, 0);
        }

        if(isDefined(var13.vehicle_getoutanim_combat_run)) {
          var1 clearanim(var13.vehicle_getoutanim_combat_run, 0);
        }
      }

      var1 = getanimatemodel(var1);
      thread setanimrestart_once(var1, var13.vehicle_getinanim);
      var1 thread scripts\common\notetrack::start_notetrack_wait(var1, "vehicle_anim_flag", undefined, undefined, var13.vehicle_getinanim);
    }

    if(isDefined(var13.vehicle_getinsoundtag)) {
      var8 = var1 gettagorigin(var13.vehicle_getinsoundtag);
    } else {
      var8 = var1.origin;
    }

    if(isDefined(var13.vehicle_getinsound)) {
      playworldsound(var13.vehicle_getinsound, var8);
    }

    var15 = undefined;
    var16 = undefined;

    if(isDefined(var13.getin_enteredvehicletrack)) {
      var15 = [];
      var15 = var13.getin_enteredvehicletrack;
      var16 = [];
      GscBinSkip0(0x2e, 0, &entered_vehicle_notify, var13.vehicle_getinanim_clear);
    }

    if(!getdvarint("enable_vehicle_ai_using_BT")) {
      animontag(var1, var0, var13.sittag, var13.getin, var15, var16, undefined, var13.sittag_origin_offset, var13.sittag_angles_offset);
    }
  }

  if(getdvarint("enable_vehicle_ai_using_BT")) {
    var0 scripts\vehicle\vehicle_common::waitforentervehicle();
  }

  var0 notify("enteredvehicle");
  guy_enter(var1, var0, var4);
}

function entered_vehicle_notify() {
  self notify("enteredvehicle");
}

function driverdead(var0) {
  if(scripts\common\vehicle::ishelicopter()) {
    return;
  }

  self.driver = var0;
  self endon("death");
  var0 endon("jumping_out");
  var0 waittill("death");

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

function guy_becomes_real_ai(var0, var1) {
  if(isai(var0)) {
    return var0;
  }

  if(istrue(var0.drone_delete_on_unload)) {
    var0 delete();
    return;
  }

  var0 = scripts\engine\utility::script_func("spawner_makerealai", var0);

  if(scripts\common\utility::issp()) {
    var2 = self.classname;
  } else {
    var2 = self.classname_mp;
  }

  var3 = level.vehicle.templates.aianims[var2].size;
  var4 = anim_pos(self, var2);
  link_to_sittag(var1, var4.sittag, var4.sittag_origin_offset, var4.sittag_angles_offset, var4.linktoblend);
  var1.vehicle_idle = var4.idle;

  if(!istrue(var1.disable_vehicle_idle)) {
    thread guy_idle(var1, var2);
  }

  return var1;
}

function link_to_sittag(var0, var1, var2, var3, var4) {
  if(!isDefined(var2)) {
    var2 = (0, 0, 0);
  }

  if(!isDefined(var3)) {
    var3 = (0, 0, 0);
  }

  if(!isDefined(var4)) {
    var4 = 0;
  }

  if(var4 && !isDefined(var0.script_drone)) {
    var0 linktoblendtotag(self, var1, 0);
    return;
  }

  var0 linkTo(self, var1, var2, var3);
}

function anim_pos(var0, var1) {
  return level.vehicle.templates.aianims[var0 scripts\common\vehicle_code::get_vehicle_classname()][var1];
}

function guy_deathhandle(var0, var1) {
  var0 waittill("death");

  if(!isDefined(self)) {
    return;
  }

  self.riders = scripts\engine\utility::array_remove(self.riders, var0);
  self.usedpositions[var1] = 0;
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

function guy_handle(var0, var1) {
  var0.vehicle_idling = 1;
  thread guy_deathhandle(var0, var1);
}

function driver_idle_speed(var0, var1) {
  var0 endon("newanim");
  self endon("death");
  var0 endon("death");
  var2 = anim_pos(self, var1);

  for(;;) {
    if(self vehicle_getspeed() == 0) {
      var0.vehicle_idle = var2.idle_animstop;
    } else {
      var0.vehicle_idle = var2.idle_anim;
    }

    wait 0.25;
  }
}

function guy_idle(var0, var1, var2) {
  var0 endon("newanim");

  if(!isDefined(var2)) {
    self endon("death");
  }

  var0 endon("death");
  var0.vehicle_idling = 1;
  var0 notify("gotime");

  if(!isDefined(var0.vehicle_idle)) {
    return;
  }

  var3 = anim_pos(self, var1);

  if(isDefined(var3.mgturret)) {
    return;
  }

  if(isDefined(var3.idle_animstop) && isDefined(var3.idle_anim)) {
    thread driver_idle_speed(var0, var1);
  }

  for(;;) {
    var0 notify("idle");
    play_new_idle(var0, var3);
  }
}

function play_new_idle(var0, var1) {
  if(isDefined(var0.vehicle_idle_override)) {
    animontag(var0, var1.sittag, var0.vehicle_idle_override, undefined, undefined, undefined, var1.sittag_origin_offset, var1.sittag_angles_offset);
    return;
  }

  if(isDefined(var1.idleoccurrence)) {
    var2 = randomoccurrance(var0, var1.idleoccurrence);
    animontag(var0, var1.sittag, var0.vehicle_idle[var2], undefined, undefined, undefined, var1.sittag_origin_offset, var1.sittag_angles_offset);
    return;
  }

  if(isDefined(var1.playerpiggyback) && isDefined(var2.player_idle)) {
    animontag(var1, var2.sittag, var2.player_idle, undefined, undefined, undefined, var2.sittag_origin_offset, var2.sittag_angles_offset);
    return;
  }

  if(isDefined(var2.vehicle_idle)) {
    thread setanimrestart_once(var2.vehicle_idle);
  }

  animontag(var1, var2.sittag, var1.vehicle_idle, undefined, undefined, undefined, var2.sittag_origin_offset, var2.sittag_angles_offset);
}

function randomoccurrance(var0, var1) {
  var2 = [];
  var3 = 0;

  for(var4 = 0; var4 < var1.size; var4++) {
    var3 += var1[var4];
    var2 = var3;
  }

  var5 = randomint(var3);

  for(var4 = 0; var4 < var1.size; var4++) {
    if(var5 < var2[var4]) {
      return var4;
    }
  }
}

function guy_unload_que(var0) {
  self endon("death");
  self.unloadque = scripts\engine\utility::array_add(self.unloadque, var0);
  var0 scripts\engine\utility::ref_143a5("death", "jumpedout");
  self.unloadque = scripts\engine\utility::array_remove(self.unloadque, var0);

  if(!self.unloadque.size) {
    scripts\engine\utility::ent_flag_set("unloaded");
    self.unload_group = "default";
    self.maxdogtags = undefined;
    return;
  }
}

function riders_unloadable(var0) {
  if(!self.riders.size) {
    return false;
  }

  for(var1 = 0; var1 < self.riders.size; var1++) {
    if(!isalive(self.riders[var1]) && !isDefined(self.riders[var1].isvehicle)) {
      continue;
    }

    if(check_unloadgroup(self.riders[var1].vehicle_position, var0)) {
      return true;
    }
  }

  return false;
}

function get_unload_group() {
  var0 = [];
  var1 = [];
  var2 = "default";

  if(isDefined(self.unload_group)) {
    var2 = self.unload_group;
  }

  var1 = level.vehicle.templates.unloadgroups[scripts\common\vehicle_code::get_vehicle_classname()][var2];

  if(!isDefined(var1)) {
    var1 = level.vehicle.templates.unloadgroups[scripts\common\vehicle_code::get_vehicle_classname()]["default"];
  }

  foreach(var4 in var1) {
    var0 = var4;
  }

  return var0;
}

function check_unloadgroup(var0, var1) {
  if(!isDefined(var1)) {
    var1 = self.unload_group;
  }

  var2 = scripts\common\vehicle_code::get_vehicle_classname();

  if(!isDefined(level.vehicle.templates.unloadgroups[var2])) {
    return true;
  }

  if(!isDefined(level.vehicle.templates.unloadgroups[var2][var1])) {
    return true;
  }

  var3 = level.vehicle.templates.unloadgroups[var2][var1];

  for(var4 = 0; var4 < var3.size; var4++) {
    if(var0 == var3[var4]) {
      return true;
    }
  }

  return false;
}

function getoutrig_model_idle(var0, var1, var2) {
  self endon("unloading");

  for(;;) {
    animontag(var0, var1, var2);
  }
}

function getoutrig_model(var0, var1, var2, var3, var4) {
  var5 = scripts\common\vehicle_code::get_vehicle_classname();

  if(var4) {
    thread getoutrig_model_idle(var1, var2, level.vehicle.templates.attachedmodels[var5][var0.fastroperig].idleanim);
    self waittill("unloading");
  }

  self.unloadque = scripts\engine\utility::array_add(self.unloadque, var1);
  thread getoutrig_abort(var1, var2, var3);

  if(!scripts\common\vehicle_code::vehicle_iscrashing()) {
    animontag(var1, var2, var3);
  }

  var1 unlink();

  if(!isDefined(self)) {
    var1 delete();
    return;
  }

  self.unloadque = scripts\engine\utility::array_remove(self.unloadque, var1);

  if(!self.unloadque.size) {
    self notify("unloaded");
  }

  self.fastroperig[var0.fastroperig] = undefined;
  wait 10;
  var1 delete();
}

function getoutrig_model_new(var0, var1, var2, var3, var4) {
  self endon("death");
  var5 = scripts\common\vehicle_code::get_vehicle_classname();
  thread scripts\engine\utility::delete_on_death(var1);
  var6 = self gettagorigin(var2);
  var7 = self gettagangles(var2);
  var8 = level.vehicle.templates.attachedmodels[var5][var0.fastroperig].idleanim;
  var9 = getstartorigin(var6, var7, var8);
  var10 = getstartangles(var6, var7, var8);
  var10 = self.angles;
  var11 = var1 gettagorigin("j_rope_1", 1);
  var12 = var11 - self.origin;

  if(var4) {
    var1.origin = var9;
    var1.angles = var10;
    thread scripts\engine\utility::script_func("fastrope_anim", var1, var8, "getoutrigidle");
    scripts\engine\utility::ent_flag_wait("unloaded");
  }

  var6 = self gettagorigin(var2);
  var7 = self gettagangles(var2);
  var13 = self.angles - var10;
  var13 = (angleclamp(var13[0]), angleclamp(var13[1]), angleclamp(var13[2]));
  var14 = rotatevector(var12, var13) + self.origin;
  var15 = scripts\engine\trace::ray_trace(var14, var14 - (0, 0, 1000), self, scripts\engine\trace::create_world_contents());
  var16 = var14[2] - 400;

  if(isDefined(var15["position"])) {
    var16 = var15["position"][2];
  }

  var17 = (var6[0], var6[1], var16);

  if(istrue(level.vehicle.templates.attachedmodels[var5][var0.fastroperig].dropusestraceorigin)) {
    var17 = (var14[0], var14[1], var16);
  }

  thread getoutrig_abort(var1, undefined, var3, var17);

  if(!scripts\common\vehicle_code::vehicle_iscrashing()) {
    var1 unlink();
    var1.origin = var17;
    thread scripts\engine\utility::script_func("fastrope_anim", var1, var3, "getoutrigfall");
  }

  self.fastroperig[var0.fastroperig] = undefined;
  wait 10;
  var1 delete();
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

  var0 = [];

  foreach(var2 in self.riders) {
    if(isalive(var2)) {
      scripts\engine\utility::array_add_safe(var0, var2);
    }
  }

  scripts\engine\utility::array_delete(var0);
  self notify("crashed_while_deploying");
  var0 = undefined;
}

function getoutrig_abort(var0, var1, var2, var3) {
  var4 = getanimlength(var2);
  var5 = var4 - 1;

  if(self.vehicletype == "mi17") {
    var5 = var4 - 0.5;
  }

  var6 = 0.8;
  self endon("getoutrig_disable_abort");
  thread getoutrig_disable_abort_notify_after_riders_out();
  thread getoutrig_abort_while_deploying();
  scripts\engine\utility::waittill_notify_or_timeout("crashed_while_deploying", var6);
  self notify("end_getoutrig_abort_while_deploying");

  while(!isDefined(self.vehiclecrashing)) {
    waitframe();
  }

  if(isDefined(var0)) {
    if(!isDefined(var1) && isDefined(var3)) {
      var0 unlink();
      var0.origin = var3;

      if(!scripts\common\utility::issp()) {
        var7 = var0 scripts\asm\asm::asm_lookupanimfromalias("animscripted", var2);
        var8 = var0 scripts\asm\asm::asm_getxanim("animscripted", var7);
        var9 = getstartorigin(self.origin, self.angles, var8);
        var10 = getstartangles(self.origin, self.angles, var8);
        var0 dontinterpolate();
        var0 forceteleport(var9, var10);
        var0 animmode("nogravity");
        var0 aisetanim("animscripted", var7);
      } else {
        var0 animScripted("getoutrigfall", var0.origin, var0.angles, var2, undefined, undefined, 0);
      }
    } else {
      thread animontag(var0, var1, var2);
    }

    waittillframeend();
    var0 setanimtime(var2, var5 / var4);
  }

  var11 = self;

  if(isDefined(self.original_attacker)) {
    var11 = self.original_attacker;
  }

  for(var12 = 0; var12 < self.riders.size; var12++) {
    if(!isDefined(self.riders[var12])) {
      continue;
    }

    if(!isDefined(self.riders[var12].ragdoll_getout_death)) {
      continue;
    }

    if(self.riders[var12].ragdoll_getout_death != 1) {
      continue;
    }

    if(!isDefined(self.riders[var12].ridingvehicle)) {
      continue;
    }

    self.riders[var12].forcefallthroughonropes = 1;

    if(isalive(self.riders[var12])) {
      thread animontag_ragdoll_death_fall(self.riders[var12], self, var11);
    }
  }
}

function setanimrestart_once(var0, var1) {
  self endon("death");
  self endon("dont_clear_anim");

  if(!isDefined(var1)) {
    var1 = 1;
  }

  var2 = getanimlength(var0);
  self endon("death");
  thread scripts\engine\utility::script_func("vehicle_door_anim", self, var0);
  wait var2;

  if(scripts\common\utility::issp() && var1) {
    self clearanim(var0, 0);
    return;
  }
}

#using_animtree("script_model");

function getout_rigspawn(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 1;
  }

  var3 = scripts\common\vehicle_code::get_vehicle_classname();

  if(isDefined(self.attach_model_override) && isDefined(self.attach_model_override[var1.fastroperig])) {
    var4 = 1;
  } else {
    var4 = 0;
  }

  if(!isDefined(var2.fastroperig) || isDefined(self.fastroperig[var2.fastroperig]) || var4) {
    return;
  }

  var5 = var1 gettagorigin(level.vehicle.templates.attachedmodels[var4][var2.fastroperig].tag);
  var6 = var1 gettagangles(level.vehicle.templates.attachedmodels[var4][var2.fastroperig].tag);
  self.fastroperiganimating[var2.fastroperig] = 1;
  var7 = spawn("script_model", var5);
  var7.angles = var6;
  var7.origin = var5;
  var7 useanimtree(#animtree);
  var7 setModel(level.vehicle.templates.attachedmodels[var4][var2.fastroperig].model);
  self.fastroperig[var2.fastroperig] = var7;
  var7 linkTo(var1, level.vehicle.templates.attachedmodels[var4][var2.fastroperig].tag);

  if(getdvarint("enable_vehicle_ai_using_BT")) {
    thread getoutrig_model_new(var2, var7, level.vehicle.templates.attachedmodels[var4][var2.fastroperig].tag, level.vehicle.templates.attachedmodels[var4][var2.fastroperig].dropanim, var3);
  } else {
    thread getoutrig_model(var2, var7, level.vehicle.templates.attachedmodels[var4][var2.fastroperig].tag, level.vehicle.templates.attachedmodels[var4][var2.fastroperig].dropanim, var3);
  }

  return var7;
}

function check_sound_tag_dupe(var0) {
  if(!isDefined(self.sound_tag_dupe)) {
    self.sound_tag_dupe = [];
  }

  var1 = 0;

  if(!isDefined(self.sound_tag_dupe[var0])) {
    self.sound_tag_dupe[var0] = 1;
  } else {
    var1 = 1;
  }

  thread check_sound_tag_dupe_reset(var0);
  return var1;
}

function check_sound_tag_dupe_reset(var0) {
  wait 0.05;

  if(!isDefined(self)) {
    return;
  }

  self.sound_tag_dupe[var0] = 0;
  var1 = getarraykeys(self.sound_tag_dupe);

  for(var2 = 0; var2 < var1.size; var2++) {
    if(self.sound_tag_dupe[var1[var2]]) {
      return;
    }
  }

  self.sound_tag_dupe = undefined;
}

function vehicle_play_exit_anim(var0, var1, var2) {
  var3 = level.vehicle.templates.aianims[scripts\common\vehicle_code::get_vehicle_classname()];
  var4 = getanimatemodel();

  if(!isDefined(var1)) {
    var1 = var0.vehicle_getoutanim;
  }

  if(!isDefined(var2)) {
    var2 = var0.vehicle_getoutanim_clear;
  }

  if(isDefined(var1)) {
    thread setanimrestart_once(var4, var1);
    var5 = 0;

    if(isDefined(var0.vehicle_getoutsoundtag)) {
      var5 = check_sound_tag_dupe(var0.vehicle_getoutsoundtag);
      var6 = var4 gettagorigin(var0.vehicle_getoutsoundtag);
    } else {
      var6 = var5.origin;
    }

    if(isDefined(var1.vehicle_getoutsound) && !var6) {
      playworldsound(var1.vehicle_getoutsound, var6);
    }

    var6 = undefined;
    return;
  }
}

function vehicle_end_loop_sounds(var0, var1) {
  var2 = anim_pos(self, var1);

  if(isDefined(var0.playerpiggyback) && isDefined(var2.player_getout_sound_loop)) {
    level.player thread scripts\engine\utility::script_func("playloopsound_on_entity", var2.player_getout_sound_loop);
  }

  if(isDefined(var2.getoutloopsnd)) {
    var0 thread scripts\engine\utility::script_func("playloopsound_on_entity", var2.getoutloopsnd);
  }

  if(isDefined(var0.playerpiggyback) && isDefined(var2.player_getout_sound_end)) {
    level.player thread scripts\engine\utility::script_func("playsound_on_entity", var2.player_getout_sound_end);
    return;
  }
}

function ref_1286b() {
  if(isDefined(self.maxdogtags)) {
    return;
  }

  self.maxdogtags = [];

  for(var0 = 0; var0 < level.vehicle.templates.aianims[scripts\common\vehicle_code::get_vehicle_classname()].size; var0++) {
    var1 = level.vehicle.templates.aianims[scripts\common\vehicle_code::get_vehicle_classname()][var0];

    if(isDefined(var1.vehicle_getoutanim)) {
      var2 = getanimname(var1.vehicle_getoutanim);
      self.maxdogtags[var2] = spawnStruct();
      self.maxdogtags[var2].open = 0;
      self.maxdogtags[var2].ref_1212c = 0;
    }
  }
}

function wait_for_open_door(var0, var1) {
  var0 endon("jumpedout");
  var0 endon("death");
  ref_1286b();

  while(!istrue(var0.requestopendoor)) {
    waitframe();
  }

  if(isDefined(var1.vehicle_getoutanim)) {
    var2 = getanimname(var1.vehicle_getoutanim);

    if(!self.maxdogtags[var2].open) {
      var3 = var1.vehicle_getoutanim;
      var4 = var1.vehicle_getoutanim_clear;

      if(isDefined(var0.requestopendoorparams)) {
        if(var0.requestopendoorparams == "combat_run" && isDefined(var1.vehicle_getoutanim_combat_run)) {
          var3 = var1.vehicle_getoutanim_combat_run;
          var4 = var1.vehicle_getoutanim_combat_run_clear;
        } else if(var0.requestopendoorparams == "combat" && isDefined(var1.vehicle_getoutanim_combat)) {
          var3 = var1.vehicle_getoutanim_combat;
          var4 = var1.vehicle_getoutanim_combat_clear;
        }
      }

      vehicle_play_exit_anim(var1, var3, var4);
      self.maxdogtags[var2].open = 1;
    }

    if(isDefined(var1.fastroperig) && !isDefined(self.fastroperig[var1.fastroperig])) {
      var5 = getanimatemodel();
      var6 = getout_rigspawn(var5, var1, 1);
      return;
    }

    return;
  }
}

function guy_setup_rope(var0, var1) {
  if(isDefined(var1.fastroperig)) {
    thread wait_for_open_door(var0, var1);
    var0 scripts\vehicle\vehicle_common::setuprope();
    return;
  }
}

function guy_unload(var0, var1) {
  var2 = 0;

  if(isDefined(var0.isvehicle)) {
    var2 = 1;
  }

  var3 = anim_pos(self, var1);
  var4 = self.vehicletype;

  if(!check_unloadgroup(var1)) {
    if(!getdvarint("enable_vehicle_ai_using_BT")) {
      thread guy_idle(var0, var1);
    }

    return;
  }

  if(!getdvarint("enable_vehicle_ai_using_BT") && !isDefined(var3.getout)) {
    thread guy_idle(var0, var1);
    return;
  }

  thread guy_unload_que(var0);
  self endon("death");

  if(isai(var0) && isalive(var0)) {
    var0 endon("death");
  }

  var5 = 0;

  if(isDefined(var0.getoffvehiclefunc)) {
    var6 = var0[[var0.getoffvehiclefunc]]();

    if(isDefined(var6) && var6) {
      var5 = 1;
    }
  }

  if(isDefined(var0.onrotatingvehicleturret)) {
    var0.onrotatingvehicleturret = undefined;

    if(isDefined(var0.getoffvehiclefunc)) {
      var0[[var0.getoffvehiclefunc]]();
    }
  }

  if(!getdvarint("enable_vehicle_ai_using_BT")) {
    vehicle_play_exit_anim(var3);
    var7 = 0;

    if(isDefined(var3.getout_timed_anim)) {
      var7 += getanimlength(var3.getout_timed_anim);
    }

    if(isDefined(var3.delay)) {
      var7 += var3.delay;
    }

    if(isDefined(var0.delay)) {
      var7 += var0.delay;
    }

    if(var7 > 0) {
      if(!getdvarint("enable_vehicle_ai_using_BT")) {
        thread guy_idle(var0, var1);
      }

      wait var7;
    }
  }

  if(!getdvarint("enable_vehicle_ai_using_BT")) {
    var0.deathanim = undefined;
    var0.deathanimscript = undefined;
  }

  var0 notify("newanim");

  if(isDefined(var3.bhasgunwhileriding) && !var3.bhasgunwhileriding) {
    if(!isDefined(var0.disable_gun_recall)) {
      var0 scripts\common\ai::gun_recall();
    }
  }

  if(isai(var0)) {
    var0 pushplayer(1);
  }

  if(isDefined(var3.bnoanimunload)) {
    var5 = 1;
  } else if(!getdvarint("enable_vehicle_ai_using_BT") && !isDefined(var3.getout) || !isDefined(self.script_unloadmgguy) && isDefined(var3.bisgunner) && var3.bisgunner || isDefined(self.script_keepdriver) && var1 == 0) {
    thread guy_idle(var0, var1);
    return;
  }

  if(should_give_orghealth(var0)) {
    var0.health = var0.orghealth;
  }

  var0.orghealth = undefined;

  if(isai(var0) && isalive(var0)) {
    var0 endon("death");
  }

  var0.allowdeath = 0;

  if(isDefined(var3.exittag)) {
    var8 = var3.exittag;
  } else {
    var8 = var4.sittag;
  }

  if(isDefined(var1.get_out_override)) {
    var9 = var1.get_out_override;
  } else if(scripts\engine\utility::ent_flag("landed") && isDefined(var5.getout_landed)) {
    var9 = var5.getout_landed;
  } else if(isDefined(var3.playerpiggyback) && isDefined(var8.player_getout)) {
    var9 = var8.player_getout;
  } else {
    var9 = var8.getout;
  }

  if(!var9) {
    if(!getdvarint("enable_vehicle_ai_using_BT")) {
      thread guy_unlink_on_death(var4);
    }

    if(!getdvarint("enable_vehicle_ai_using_BT") && isDefined(var8.fastroperig)) {
      if(!isDefined(self.fastroperig[var8.fastroperig])) {
        if(!getdvarint("enable_vehicle_ai_using_BT")) {
          thread guy_idle(var4, var5);
        }

        var10 = getanimatemodel();
        var11 = getout_rigspawn(var10, var8, 1);
      }
    }

    if(isDefined(var8.getoutsnd)) {
      var4 thread scripts\engine\utility::script_func("playsound_on_tag", var8.getoutsnd, "J_Wrist_RI", 1);
    }

    if(isDefined(var4.playerpiggyback) && isDefined(var8.player_getout_sound)) {
      var4 thread scripts\engine\utility::script_func("playsound_on_tag", var8.player_getout_sound);
    }

    if(isDefined(var8.getoutloopsnd)) {
      var4 thread scripts\engine\utility::script_func("playloopsound_on_tag", var8.getoutloopsnd);
    }

    if(isDefined(var4.playerpiggyback) && isDefined(var8.player_getout_sound_loop)) {
      level.player thread scripts\engine\utility::script_func("playloopsound_on_tag", var8.player_getout_sound_loop);
    }

    var4 notify("newanim");
    var4 notify("jumping_out");
    var12 = 0;

    if(!isai(var4) && !var8) {
      var12 = 1;
    }

    if(!isDefined(var4.script_stay_drone) && !var8) {
      var4 = guy_becomes_real_ai(var4, var5);
    }

    if(!isalive(var4) && !var8) {
      return;
    }

    if(!var8) {
      var4.ragdoll_getout_death = 1;
    }

    if(isDefined(var8.ragdoll_getout_death)) {
      var4.ragdoll_getout_death = 1;

      if(isDefined(var8.ragdoll_fall_anim)) {
        var4.ragdoll_fall_anim = var8.ragdoll_fall_anim;
      }
    }

    if(var12) {
      self.riders = scripts\engine\utility::array_add(self.riders, var4);
      thread guy_deathhandle(var4, var5);
      thread guy_unload_que(var4);
      var4.ridingvehicle = self;
    }

    if(isai(var4)) {
      var4 endon("death");
    }

    var4 notify("newanim");
    var4 notify("jumping_out");

    if(isDefined(var8.littlebirde_getout_unlinks) && var8.littlebirde_getout_unlinks) {
      thread stable_unlink(var4);
    }

    if(isalive(var4) && isai(var4) && guy_resets_goalpos(var4)) {
      var4.goalradius = 600;
      var4 setgoalpos(var4.origin);
    }

    if(isDefined(var8.getout_secondary)) {
      animontag(var4, var9, var9);
      var13 = var9;

      if(isDefined(var8.getout_secondary_tag)) {
        var13 = var8.getout_secondary_tag;
      }

      animontag(var4, var13, var8.getout_secondary, undefined, undefined, undefined, var8.sittag_origin_offset, var8.sittag_angles_offset);
    } else {
      var14 = 0;

      if(isDefined(var8.getout_hover_loop) && isDefined(var8.getout_hover_land)) {
        thread guy_unload_land(var4, var9, var8.getout, var8.getout_hover_loop, var8.getout_hover_land);
        var14 = 1;
      } else if(!var8) {
        var4.anim_end_early = 1;
      }

      if(!getdvarint("enable_vehicle_ai_using_BT")) {
        animontag(var4, var9, var9, undefined, undefined, undefined, var8.sittag_origin_offset, var8.sittag_angles_offset);
      } else {
        thread wait_for_open_door(var4, var8);
        var4 scripts\vehicle\vehicle_common::exitvehicle();
      }

      if(var14) {
        var4 waittill("hoverunload_done");
      }
    }

    if(isDefined(var4.playerpiggyback) && isDefined(var8.player_getout_sound_loop)) {
      level.player thread scripts\engine\utility::stop_loop_sound_on_entity(var8.player_getout_sound_loop);
    }

    if(isDefined(var8.getoutloopsnd)) {
      var4 thread scripts\engine\utility::stop_loop_sound_on_entity(var8.getoutloopsnd);
    }

    if(isDefined(var4.playerpiggyback) && isDefined(var8.player_getout_sound_end)) {
      level.player thread scripts\engine\utility::script_func("playsound_on_entity", var8.player_getout_sound_end);
    }
  } else if(!isai(var4)) {
    if(istrue(var4.drone_delete_on_unload)) {
      var4 delete();
      return;
    }

    var4 = scripts\engine\utility::script_func("spawner_makerealai", var4);
  }

  self.riders = scripts\engine\utility::array_remove(self.riders, var4);
  self.usedpositions[var5] = 0;
  var4.ridingvehicle = undefined;
  var4.drivingvehicle = undefined;

  if(!isalive(self) && !isDefined(var8.unload_ondeath)) {
    var4 delete();
    return;
  }

  if(!getdvarint("enable_vehicle_ai_using_BT")) {
    var4 unlink();
  }

  if(!isDefined(var4.magic_bullet_shield)) {
    var4.allowdeath = 1;
  }

  if(isalive(var4) || var8) {
    if(isai(var4)) {
      var4.a.disablelongdeath = !var4 isbadguy();
    }

    var4.forced_startingposition = undefined;

    if(isai(var4)) {
      if(isDefined(var8.getoutstance)) {
        var4.desired_anim_pose = var8.getoutstance;
        var4 allowedstances("crouch");
        var4 thread scripts\engine\utility::script_func("anim_updateanimpose");
        var4 allowedstances("stand", "crouch", "prone");
      }

      var4 pushplayer(0);
    } else if(var8) {
      var4.vspawner.origin = var4.origin;
      var4.vspawner.angles = var4.angles;

      if(isDefined(var4.vspawner.target)) {
        var4.vspawner scripts\common\vehicle::spawn_vehicle_and_gopath();
      } else {
        var15 = var4.vspawner scripts\common\utility::spawn_vehicle();
      }

      var4 delete();
    }

    if(!getdvarint("enable_vehicle_ai_using_BT")) {
      var4 notify("jumpedout");
    }
  }

  if(isDefined(var4.script_noteworthy) && var4.script_noteworthy == "delete_after_unload") {
    var4 delete();
    return;
  }

  if(isDefined(var8.getout_delete) && var8.getout_delete) {
    var4 delete();
    return;
  }

  guy_cleanup_vehiclevars(var4);
}

function guy_unload_land(var0, var1, var2, var3, var4) {
  var5 = self gettagorigin(var1);
  var6 = self gettagangles(var1);
  var7 = getstartorigin(var5, var6, var2);
  var8 = getstartangles(var5, var6, var2);
  var9 = getmovedelta(var2, 0, 1);
  var10 = scripts\engine\utility::spawn_tag_origin();
  var10.origin = var7;
  var10.angles = var8;
  var11 = var10 localtoworldcoords(var9);
  var10 thread scripts\engine\utility::delete_on_notify("movedone");
  var12 = var11;
  var13 = scripts\common\utility::groundpos(var12);
  var14 = getstartorigin(var5, var6, var4);
  var9 = getmovedelta(var4, 0, 1);
  var15 = var14 + var9;
  var16 = var14[2] - var15[2];
  var17 = var13 + (0, 0, var16);
  var0.allowdeath = 0;
  var0 setCanDamage(0);
  var0 endon("death");
  wait getanimlength(var2) - 0.1;
  var0 unlink();
  var0 notify("animontag_thread");
  var0 stopanimScripted();
  var10.origin = var0.origin;
  var10.angles = var0.angles;
  var10 dontinterpolate();
  var0 dontinterpolate();
  var0 linkTo(var10, "tag_origin", (0, 0, 0), (0, 0, 0));
  var0.allowdeath = 1;
  var0 setCanDamage(1);
  var0.unload_loopanim = var3;

  if(isai(var0)) {
    var0 scripts\engine\utility::script_func("asm_animcustom", &guy_fall_loop, &guy_fall_loop_end);
  } else {
    thread guy_fall_loop();
  }

  var18 = length((0, 0, var17[2]) - (0, 0, var12[2]));
  var19 = 350;
  var20 = var18 / var19;
  var10 moveTo(var17, var20);
  var10 waittill("movedone");
  var0 unlink();
  var0 animScripted("dropship_land", var0.origin, var0.angles, var4);
  wait getanimlength(var4);
  var0 notify("hoverunload_done");
  var0 notify("anim_on_tag_done");
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

function guy_resets_goalpos(var0) {
  if(isDefined(var0.script_delayed_playerseek)) {
    return false;
  }

  if(istrue(var0 scripts\engine\utility::script_func("ai_has_color"))) {
    return false;
  }

  if(isDefined(var0.qsetgoalpos)) {
    return false;
  }

  if(!isDefined(var0.target)) {
    return true;
  }

  var1 = getnodearray(var0.target, "targetname");
  var2 = scripts\engine\utility::getStructArray(var0.target, "targetname");

  if(var1.size > 0 || var2.size > 0) {
    return false;
  }

  var3 = getEnt(var0.target, "targetname");

  if(isDefined(var3) && var3.classname == "info_volume") {
    return false;
  }

  return true;
}

function animontag(var0, var1, var2, var3, var4, var5, var6, var7) {
  var0 notify("animontag_thread");
  var0 endon("animontag_thread");

  if(!isDefined(var6)) {
    var6 = (0, 0, 0);
  }

  if(!isDefined(var7)) {
    var7 = (0, 0, 0);
  }

  if(!isDefined(var5)) {
    var5 = "animontagdone";
  }

  if(isDefined(self.modeldummy)) {
    var8 = self.modeldummy;
  } else {
    var8 = self;
  }

  if(!isDefined(var2) || !scripts\engine\utility::hastag(var8.model, var2)) {
    var9 = var1.origin;
    var10 = var1.angles;
  } else {
    var9 = var10 gettagorigin(var4);
    var10 = var10 gettagangles(var4) + var9;
    var11 = anglestoaxis(var10);
    var12 = ["forward", "right", "up"];

    for(var13 = 0; var13 < var11.size; var13++) {
      var9 += var11[var12[var13]] * var8[var13];
    }
  }

  if(isDefined(var3.ragdoll_getout_death) && !isDefined(var3.no_vehicle_ragdoll)) {
    thread animontag_ragdoll_death(level, var3);
  }

  if(!scripts\common\utility::issp()) {
    var3 dontinterpolate();

    if(isai(var3)) {
      var14 = var3 scripts\asm\asm::asm_lookupanimfromalias("animscripted", var5);
      var15 = var3 scripts\asm\asm::asm_getxanim("animscripted", var14);
      var16 = getstartorigin(self.origin, self.angles, var15);
      var17 = getstartangles(self.origin, self.angles, var15);
      var3 forceteleport(var16, var17);
      var3 animmode("nogravity");
      var3 aisetanim("animscripted", var14);
    }
  } else {
    var3 animScripted(var8, var9, var10, var5);
  }

  if(isai(var3)) {
    thread donotetracks(var3, var10, var8);
  }

  if(isDefined(var3.anim_end_early)) {
    var3.anim_end_early = undefined;
    var18 = getanimlength(var5) - 0.25;

    if(var18 > 0) {
      wait var18;
    }

    if(getdvarint("LPNQTQRRP", 0) == 1) {
      var3 stopanimScripted();
    }

    var3.interval = 0;
    thread recover_interval();
  } else {
    if(isDefined(var6)) {
      for(var13 = 0; var13 < var6.size; var13++) {
        var3 waittillmatch(var8, var6[var13]);
        var3 thread[[var7[var13]]]();
      }
    }

    var3 waittillmatch(var8, "end");
  }

  var3 notify("anim_on_tag_done");
  var3.ragdoll_getout_death = undefined;
}

function recover_interval() {
  self endon("death");
  wait 2;

  if(self.interval == 0) {
    self.interval = 80;
    return;
  }
}

function animontag_ragdoll_death(var0, var1) {
  if(isDefined(var0.magic_bullet_shield) && var0.magic_bullet_shield) {
    return;
  }

  if(!isai(var0)) {
    var0 setCanDamage(1);
  }

  var0 endon("anim_on_tag_done");
  var2 = undefined;
  var3 = undefined;
  var4 = var1.health <= 0;

  for(;;) {
    if(!var4 && !(isDefined(var1) && var1.health > 0)) {
      break;
    }

    var0 waittill("damage", var2, var3);

    if(isDefined(var0.forcefallthroughonropes)) {
      break;
    }

    if(!isDefined(var2)) {
      continue;
    }

    if(var2 < 1) {
      continue;
    }

    if(!isDefined(var3)) {
      continue;
    }

    if(isPlayer(var3)) {
      break;
    }
  }

  if(!isalive(var0)) {
    return;
  }

  thread animontag_ragdoll_death_fall(var0, var1, var3);
}

function animontag_ragdoll_death_fall(var0, var1, var2) {
  var0.deathanim = undefined;
  var0.deathfunction = undefined;
  var0.anim_disablepain = 1;

  if(isDefined(var0.ragdoll_fall_anim)) {
    var3 = getmovedelta(var0.ragdoll_fall_anim, 0, 1);
    var4 = physicstrace(var0.origin + (0, 0, 16), var0.origin - (0, 0, 10000));
    var5 = distance(var0.origin + (0, 0, 16), var4);

    if(abs(var3[2] + 16) <= abs(var5)) {
      var0 thread scripts\engine\utility::script_func("playsound_on_entity", "generic_death_falling");
      var0 animScripted("fastrope_fall", var0.origin, var0.angles, var0.ragdoll_fall_anim);
      var0 waittillmatch("fastrope_fall", "start_ragdoll");
    }
  }

  if(!isDefined(var0)) {
    return;
  }

  var0.deathanim = undefined;
  var0.deathfunction = undefined;
  var0.anim_disablepain = 1;
  var0 notify("rope_death", var2);
  var0 kill(var2.origin, var2);

  if(isDefined(var0.script_stay_drone)) {
    var0 notsolid();
    var6 = getweaponmodel(var0.weapon);
    var7 = var0.weapon;

    if(isDefined(var6)) {
      var0 detach(var6, "tag_weapon_right");
      var8 = var0 gettagorigin("tag_weapon_right");
      var9 = var0 gettagangles("tag_weapon_right");
      level.gun = spawn("weapon_" + createheadicon(var7), (0, 0, 0));
      level.gun.angles = var9;
      level.gun.origin = var8;
    }
  } else {
    var0 scripts\engine\utility::script_func("anim_dropallaiweapons");
  }

  if(isDefined(var0.fnpreragdoll)) {
    var0[[var0.fnpreragdoll]]();
  }

  var0 startragdoll();
}

function donotetracks(var0, var1, var2) {
  var0 endon("idle");
  var0 endon("newanim");
  var1 endon("death");
  var0 endon("death");
  var0 scripts\engine\utility::script_func("anim_donotetracks", var2);
}

function animatemoveintoplace(var0, var1, var2, var3) {
  var0 animScripted("movetospot", var1, var2, var3);
  var0 waittillmatch("movetospot", "end");
}

function guy_vehicle_death(var0, var1) {
  if(!isalive(var0)) {
    return;
  }

  if(isDefined(self.no_rider_death)) {
    return;
  }

  var2 = anim_pos(self, var0.vehicle_position);

  if(isDefined(var2.explosion_death)) {
    return guy_blowup(var0);
  }

  var3 = scripts\common\vehicle_code::get_vehicle_classname();

  if(isDefined(level.vehicle.templates.rider_death_func) && isDefined(level.vehicle.templates.rider_death_func[var3])) {
    self[[level.vehicle.templates.rider_death_func[var3]]]();
    return;
  }

  if(isDefined(var2.unload_ondeath) && isDefined(self)) {
    if(isDefined(self.dontunloadondeath) && self.dontunloadondeath) {
      return;
    }

    thread guy_idle(var0, var0.vehicle_position, 1);
    wait var2.unload_ondeath;

    if(isDefined(var0) && isDefined(self)) {
      self.groupedanim_pos = var0.vehicle_position;
      animate_guys("unload");
    }

    return;
  }

  if(isDefined(var0)) {
    if(isDefined(var0.ragdoll_getout_death)) {
      return;
    }

    var0 delete();
    return;
  }
}

function ai_wait_go() {
  self endon("death");
  self waittill("loaded");
  scripts\common\vehicle_paths::gopath(self);
}

function set_pos(var0, var1) {
  var2 = var0.script_startingposition;

  if(isDefined(var0.forced_startingposition)) {
    var2 = var0.forced_startingposition;
  }

  if(isDefined(var2)) {
    return var2;
  }

  for(var3 = 0; var3 < self.usedpositions.size; var3++) {
    if(self.usedpositions[var3]) {
      continue;
    }

    if(isDefined(var0.isvehicle) && !isDefined(var1[var3].isvehicle)) {
      continue;
    }

    if(!isDefined(var0.isvehicle) && isDefined(var1[var3].isvehicle)) {
      continue;
    }

    return var3;
  }

  if(isDefined(var0.isvehicle) && var0.isvehicle) {
    return;
  }
}

function guy_man_turret(var0, var1, var2) {
  var3 = anim_pos(self, var1);
  var4 = self.mgturret[var3.mgturret];

  if(!isalive(var0)) {
    return;
  }

  var4 endon("death");
  var0 endon("death");

  if(isDefined(var2) && var2 && isDefined(var3.passenger_2_turret_func)) {
    [[var3.passenger_2_turret_func]](self, var0, var1, var4);
  }

  scripts\common\vehicle_code::set_turret_team(var4);
  var4 setdefaultdroppitch(0);
  wait 0.1;
  var0 endon("guy_man_turret_stop");
  level thread scripts\common\vehicle_code::vehicle_turret_difficulty(var4, scripts\common\utility::getdifficulty());
  var4 scripts\engine\utility::self_func("setturretignoregoals", 1);
  var5 = "stand";

  if(isDefined(var3.turretpos)) {
    var5 = var3.turretpos;
  }

  var0 scripts\engine\utility::script_func("use_turret", var4, var5);
}

function guy_unlink_on_death(var0) {
  var0 endon("jumpedout");
  var0 waittill("death");

  if(isDefined(var0)) {
    var0 unlink();
    return;
  }
}

function guy_blowup(var0) {
  if(!isDefined(var0.vehicle_position)) {
    return;
  }

  var1 = var0.vehicle_position;
  var2 = anim_pos(self, var1);

  if(!isDefined(var2.explosion_death)) {
    return;
  }

  var0.deathanim = var2.explosion_death;
  var3 = self.angles;
  var4 = var0.origin;

  if(isDefined(var2.explosion_death_offset)) {
    var4 += anglesToForward(var3) * var2.explosion_death_offset[0];
    var4 += anglestoright(var3) * var2.explosion_death_offset[1];
    var4 += anglestoup(var3) * var2.explosion_death_offset[2];
  }

  var0 = convert_guy_to_drone(var0);
  detach_models_with_substr(var0, "weapon_");
  var0 notsolid();
  var0.origin = var4;
  var0.angles = var3;
  var0 animScripted("deathanim", var4, var3, var2.explosion_death);
  var5 = 0.3;

  if(isDefined(var2.explosion_death_ragdollfraction)) {
    var5 = var2.explosion_death_ragdollfraction;
  }

  var6 = getanimlength(var2.explosion_death);
  var7 = gettime() + var6 * 1000;
  wait var6 * var5;
  var8 = (0, 0, 1);
  var9 = var0.origin;

  if(getDvar("LNLRQKMPKS") == "0") {
    var0 delete();
    return;
  }

  if(isai(var0)) {
    var0 scripts\engine\utility::script_func("anim_dropallaiweapons");
  } else {
    detach_models_with_substr(var0, "weapon_");
  }

  while(!var0 isragdoll() && gettime() < var7) {
    var9 = var0.origin;
    wait 0.05;
    var8 = var0.origin - var9;

    if(isDefined(var0.fnpreragdoll)) {
      var0[[var0.fnpreragdoll]]();
    }

    var0 startragdoll();
  }

  wait 0.05;
  var8 *= 20000;

  for(var10 = 0; var10 < 3; var10++) {
    if(isDefined(var0)) {
      var9 = var0.origin;
    }

    wait 0.05;
  }

  if(!var0 isragdoll()) {
    var0 delete();
    return;
  }
}

#using_animtree("");

function convert_guy_to_drone(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 0;
  }

  var2 = spawn("script_model", var0.origin);
  var2.angles = var0.angles;
  var2 setModel(var0.model);
  var3 = var0 getattachsize();

  for(var4 = 0; var4 < var3; var4++) {
    var2 attach(var0 getattachmodelname(var4), var0 getattachtagname(var4));
  }

  var2 useanimtree(#animtree);

  if(isDefined(var0.team)) {
    var2.team = var0.team;
  }

  if(!var1) {
    var0 delete();
  }

  var2 scripts\engine\utility::self_func("makefakeai");
  return var2;
}

function vehicle_animate(var0, var1) {
  self useanimtree(var1);
  self setanim(var0);
}

function vehicle_getinstart(var0) {
  var1 = anim_pos(self, var0);
  return vehicle_getanimstart(var1.getin, var1.sittag, var0, var1.canshootinvehicle);
}

function vehicle_getanimstart(var0, var1, var2, var3) {
  var4 = spawnStruct();
  var5 = undefined;
  var6 = undefined;
  var7 = self gettagorigin(var1);
  var8 = self gettagangles(var1);

  if(!getdvarint("enable_vehicle_ai_using_BT") || isDefined(var0)) {
    var5 = getstartorigin(var7, var8, var0);
    var6 = getstartangles(var7, var8, var0);
  } else {
    var5 = var7;
    var6 = var8;
  }

  var4.origin = var5;
  var4.angles = var6;
  var4.vehicle_position = var2;
  var4.canshootinvehicle = var3;
  return var4;
}

function is_position_in_group(var0, var1, var2) {
  if(!isDefined(var2)) {
    return true;
  }

  var3 = var0 scripts\common\vehicle_code::get_vehicle_classname();
  var4 = level.vehicle.templates.unloadgroups[var3][var2];

  foreach(var6 in var4) {
    if(var6 == var1) {
      return true;
    }
  }

  return false;
}

function get_availablepositions(var0) {
  var1 = level.vehicle.templates.aianims[scripts\common\vehicle_code::get_vehicle_classname()];
  var2 = [];
  var3 = [];

  for(var4 = 0; var4 < self.usedpositions.size; var4++) {
    if(self.usedpositions[var4]) {
      continue;
    }

    if((getdvarint("enable_vehicle_ai_using_BT") || isDefined(var1[var4].getin)) && is_position_in_group(self, var4, var0)) {
      var2 = vehicle_getinstart(var4);
      continue;
    }

    var3 = var4;
  }

  var5 = spawnStruct();
  var5.availablepositions = var2;
  var5.nonanimatedpositions = var3;
  return var5;
}

function getanimatemodel() {
  if(isDefined(self.modeldummy)) {
    return self.modeldummy;
  }

  return self;
}

function detach_models_with_substr(var0, var1) {
  var2 = var0 getattachsize();
  var3 = [];
  var4 = [];
  var5 = 0;

  for(var6 = 0; var6 < var2; var6++) {
    var7 = var0 getattachmodelname(var6);
    var8 = var0 getattachtagname(var6);

    if(issubstr(var7, var1)) {
      var3 = var7;
      var4 = var8;
    }
  }

  for(var6 = 0; var6 < var3.size; var6++) {
    var0 detach(var3[var6], var4[var6]);
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

function stable_unlink(var0) {
  self waittill("stable_for_unlink");

  if(isalive(var0)) {
    var0 unlink();
    return;
  }
}

function animate_guys(var0) {
  var1 = [];

  foreach(var3 in self.riders) {
    if(isai(var3) && !isalive(var3)) {
      continue;
    }

    if(isDefined(level.vehicle.aianimcheck[var0]) && ![[level.vehicle.aianimcheck[var0]]](var3, var3.vehicle_position)) {
      continue;
    }

    if(isDefined(level.vehicle.aianimthread[var0])) {
      var3 notify("newanim");
      GscBinSkip1(0x74, level.vehicle.aianimthread[var0], var3, var3.vehicle_position);
    }
  }

  return var1;
}

function guy_cleanup_vehiclevars() {
  self.vehicle_idling = undefined;
  self.standing = undefined;
  self.vehicle_position = undefined;
  self.delay = undefined;
}