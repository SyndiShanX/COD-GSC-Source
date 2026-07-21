/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: common\vehicle_aianim.gsc
***********************************************/

guy_enter(var_0, var_1) {
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

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
  if(var_4 == 0)
    var_0.drivingvehicle = 1;

  var_5 = anim_pos(self, var_4);
  self.usedpositions[var_4] = 1;
  var_0.vehicle_position = var_4;
  var_0.vehicle_idling = 0;

  if(isDefined(var_5.delay)) {
    var_0.delay = var_5.delay;

    if(isDefined(var_5.delayinc))
      self.delayer = var_0.delay;
  }

  if(isDefined(var_5.delayinc)) {
    self.delayer = self.delayer + var_5.delayinc;
    var_0.delay = self.delayer;
  }

  var_0.ridingvehicle = self;
  var_0.orghealth = var_0.health;
  var_0.vehicle_idle = var_5.idle;
  var_0.vehicle_standattack = var_5.standattack;

  if(!getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F")) {
    var_0.deathanim = var_5.death;
    var_0.deathanimscript = var_5.deathscript;
  }

  var_0.standing = 0;
  var_0.allowdeath = 1;

  if(!getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F")) {
    if(isDefined(var_0.deathanim) && !isDefined(var_0.magic_bullet_shield) && vehicle_allows_rider_death()) {
      if(var_0.vehicle_position != 0 || vehicle_allows_driver_death()) {
        var_0.allowdeath = !isDefined(var_0.script_allowdeath) || var_0.script_allowdeath;

        if(isDefined(var_5.death_no_ragdoll))
          var_0.noragdoll = var_5.death_no_ragdoll;
      }
    }
  } else if(!isDefined(var_0.magic_bullet_shield) && vehicle_allows_rider_death()) {
    var_0.allowdeath = !isDefined(var_0.script_allowdeath) || var_0.script_allowdeath;

    if(isDefined(var_5.death_no_ragdoll))
      var_0.noragdoll = var_5.death_no_ragdoll;
  }

  if(!isDefined(var_0.classname)) {
    return;
  }
  if(var_0.classname == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0") {
    if(isDefined(var_5.death) && var_0.allowdeath && (!isDefined(var_0.script_allowdeath) || var_0.script_allowdeath))
      thread guy_death(var_0, var_5);
  }

  self.riders[self.riders.size] = var_0;

  if(var_0.classname != "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0" && scripts\common\ai::spawn_failed(var_0)) {
    return;
  }
  var_6 = self gettagorigin(var_5.sittag);
  var_7 = self gettagangles(var_5.sittag);

  if(!getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F"))
    link_to_sittag(var_0, var_5.sittag, var_5.sittag_origin_offset, var_5.sittag_angles_offset, var_5.linktoblend);
  else if(!var_0 scripts\vehicle\vehicle_common::hasvehicle()) {
    var_8 = vehicle_getinstart(var_4);
    var_0 scripts\vehicle\vehicle_common::entervehicle(self, 1, var_8, var_5);
  }

  if(isai(var_0)) {
    if(!getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F"))
      var_0 forceteleport(var_6, var_7);

    if(isDefined(var_0.a))
      var_0.a.disablelongdeath = 1;

    if(isDefined(var_5.bhasgunwhileriding) && !var_5.bhasgunwhileriding)
      var_0 scripts\common\ai::gun_remove();

    if(guy_should_man_turret(var_5))
      thread guy_man_turret(var_0, var_4, var_1);
  } else {
    if(isDefined(var_5.bhasgunwhileriding) && !var_5.bhasgunwhileriding)
      detach_models_with_substr(var_0, "_encstr_B2010820C5337B67C8CF");

    var_0.origin = var_6;
    var_0.angles = var_7;
  }

  if(var_4 == 0) {
    self.driver = var_0;

    if(getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F") || isDefined(var_3[0].death))
      thread driverdead(var_0);
  }

  self notify("_encstr_9AA80CCEAE97F5957347CA9CB2C8", var_0, var_4);
  var_0 notify("_encstr_92D20741F7CEB03D1B");
  scripts\engine\utility::ent_flag_clear("_encstr_BD82096B5DA4B07F924F29");
  thread guy_handle(var_0, var_4);

  if(isDefined(var_5.rider_func)) {
    var_0[[var_5.rider_func]]();
    return;
  }

  if(!getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F")) {
    if(isDefined(var_5.getin_idle_func))
      thread[[var_5.getin_idle_func]](var_0, var_4);
    else
      thread guy_idle(var_0, var_4);
  }
}

vehicle_allows_driver_death() {
  if(!isDefined(self.script_allow_driver_death))
    return 0;

  return self.script_allow_driver_death;
}

vehicle_allows_rider_death() {
  if(!isDefined(self.script_allow_rider_deaths))
    return 1;

  return self.script_allow_rider_deaths;
}

guy_should_man_turret(var_0) {
  if(!isDefined(var_0.mgturret))
    return 0;

  if(!isDefined(self.script_nomg))
    return 1;

  return !self.script_nomg;
}

handle_attached_guys() {
  var_0 = scripts\common\vehicle_code::get_vehicle_classname();
  self.attachedguys = [];

  if(!(isDefined(level.vehicle.templates.aianims) && isDefined(level.vehicle.templates.aianims[var_0]))) {
    return;
  }
  var_1 = level.vehicle.templates.aianims[var_0].size;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "_encstr_BA1B0B91775F0BF14B6B3F6ACF")
    thread ai_wait_go();

  self.runningtovehicle = [];
  self.usedpositions = [];
  self.getinorgs = [];
  self.delayer = 0;
  var_2 = level.vehicle.templates.aianims[var_0];

  for(var_3 = 0; var_3 < var_1; var_3++) {
    self.usedpositions[var_3] = 0;

    if(isDefined(self.script_nomg) && self.script_nomg && isDefined(var_2[var_3].bisgunner) && var_2[var_3].bisgunner)
      self.usedpositions[1] = 1;
  }
}

load_ai_goddriver(var_0) {
  load_ai(var_0, 1);
}

guy_death(var_0, var_1) {
  waittillframeend;
  var_0 setCanDamage(1);
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.allowdeath = 0;
  var_0.health = 10150;

  if(isDefined(var_0.script_startinghealth))
    var_0.health = var_0.health + var_0.script_startinghealth;

  var_0 endon("_encstr_8A450C30FD60580AC8473EE8F323");

  if(isDefined(var_0.magic_bullet_shield) && var_0.magic_bullet_shield) {
    while(isDefined(var_0.magic_bullet_shield) && var_0.magic_bullet_shield)
      wait 0.05;
  }

  while(var_0.health > 10000)
    var_0 waittill("_encstr_B2BE0788BAF573592F");

  thread guy_deathimate_me(var_0, var_1);
}

guy_deathimate_me(var_0, var_1) {
  var_2 = gettime() + getanimlength(var_1.death) * 1000;
  var_3 = var_0.angles;
  var_4 = var_0.origin;
  var_0 = convert_guy_to_drone(var_0);
  detach_models_with_substr(var_0, "_encstr_B2010820C5337B67C8CF");
  var_0 linkTo(self);
  var_0 notsolid();
  var_0 setanim(var_1.death);

  if(isai(var_0))
    var_0 scripts\engine\utility::script_func("_encstr_8B1216E955C0D5EFA5D352AB99897B8EA81F6571C148DD97");
  else
    detach_models_with_substr(var_0, "_encstr_B2010820C5337B67C8CF");

  if(isDefined(var_1.death_delayed_ragdoll)) {
    var_0 unlink();

    if(isDefined(var_0.fnpreragdoll))
      var_0[[var_0.fnpreragdoll]]();

    var_0 startragdoll();
    wait(var_1.death_delayed_ragdoll);
    var_0 delete();
    return;
  }
}

load_ai(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");

  if(var_0.size) {
    if(!isDefined(var_1))
      var_1 = 0;

    scripts\engine\utility::ent_flag_clear("_encstr_BD82096B5DA4B07F924F29");
    scripts\engine\utility::ent_flag_clear("_encstr_92D20741F7CEB03D1B");
    scripts\engine\utility::array_levelthread(var_0, ::get_in_vehicle, var_1, var_2);
    scripts\engine\utility::array_wait(var_0, "_encstr_92D20741F7CEB03D1B");
  }

  scripts\engine\utility::ent_flag_set("_encstr_92D20741F7CEB03D1B");
}

is_rider(var_0) {
  for(var_1 = 0; var_1 < self.riders.size; var_1++) {
    if(self.riders[var_1] == var_0)
      return 1;
  }

  return 0;
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

  if(!scripts\common\utility::issp())
    var_0 = self.classname_mp;
  else
    var_0 = self.class;
}

vehicle_hasavailablespots() {
  if(level.vehicle.templates.aianims[scripts\common\vehicle_code::get_vehicle_classname()].size - self.runningtovehicle.size)
    return 1;
  else
    return 0;
}

guy_runtovehicle_loaded(var_0, var_1) {
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_97010DC7E1B0035F9818B6FFF0A0AF");

  if(!getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F")) {
    var_2 = var_0 scripts\engine\utility::_id_143AE("_encstr_93530B91C713410FAFEAC86852", "_encstr_AD75063D571AE108", "_encstr_8E130FA9E2D34D68AF94052BB094D8813F");

    if(var_2 != "_encstr_8E130FA9E2D34D68AF94052BB094D8813F" && isDefined(var_0.forced_startingposition))
      var_1.usedpositions[var_0.forced_startingposition] = 0;
  } else if(!var_0 scripts\vehicle\vehicle_common::waitforentervehicle() && isDefined(var_0.forced_startingposition))
    var_1.usedpositions[var_0.forced_startingposition] = 0;

  var_1.runningtovehicle = scripts\engine\utility::array_remove(var_1.runningtovehicle, var_0);
  vehicle_loaded_if_full(var_1);
}

vehicle_loaded_if_full(var_0) {
  if(isDefined(var_0.vehicletype) && isDefined(var_0.vehicle_loaded_notify_size)) {
    if(var_0.riders.size == var_0.vehicle_loaded_notify_size)
      var_0 scripts\engine\utility::ent_flag_set("_encstr_92D20741F7CEB03D1B");
  } else if(!var_0.runningtovehicle.size && var_0.riders.size) {
    if(var_0.usedpositions[0])
      var_0 scripts\engine\utility::ent_flag_set("_encstr_92D20741F7CEB03D1B");
    else if(!getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F"))
      var_0 thread vehicle_reload();
  }
}

vehicle_reload() {
  var_0 = self.riders;
  scripts\common\vehicle::vehicle_unload();
  scripts\engine\utility::ent_flag_wait("_encstr_BD82096B5DA4B07F924F29");
  var_0 = scripts\engine\utility::array_removedead(var_0);
  thread scripts\common\vehicle::vehicle_load_ai(var_0);
}

remove_magic_bullet_shield_from_guy_on_unload_or_death(var_0) {
  scripts\engine\utility::_id_143A5("_encstr_81A8077D3088BFA631", "_encstr_AD75063D571AE108");
  var_0 scripts\common\ai::stop_magic_bullet_shield();
}

choose_vehicle_position(var_0, var_1, var_2) {
  var_0 endon("_encstr_97010DC7E1B0035F9818B6FFF0A0AF");
  self endon("_encstr_97010DC7E1B0035F9818B6FFF0A0AF");

  if(!isDefined(var_2))
    var_2 = 0;

  var_3 = undefined;
  var_4 = 0;

  if(isDefined(var_0.script_startingposition))
    var_3 = vehicle_getinstart(var_0.script_startingposition);
  else if(!self.usedpositions[0]) {
    var_3 = vehicle_getinstart(0);

    if(var_2) {
      var_0 thread scripts\common\ai::magic_bullet_shield();
      thread remove_magic_bullet_shield_from_guy_on_unload_or_death(var_0);
    }
  } else if(var_1.availablepositions.size)
    var_3 = scripts\engine\utility::getclosest(var_0.origin, var_1.availablepositions);
  else
    var_3 = undefined;

  return var_3;
}

guy_runtovehicle(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_97010DC7E1B0035F9818B6FFF0A0AF");
  var_1 endon("_encstr_97010DC7E1B0035F9818B6FFF0A0AF");
  var_4 = 1;

  if(!isDefined(var_2))
    var_2 = 0;

  var_5 = level.vehicle.templates.aianims[var_1 scripts\common\vehicle_code::get_vehicle_classname()];

  if(isDefined(var_1.runtovehicleoverride)) {
    var_1 thread[[var_1.runtovehicleoverride]](var_0);
    return;
  }

  var_1 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");
  var_1.runningtovehicle[var_1.runningtovehicle.size] = var_0;
  thread guy_runtovehicle_loaded(var_0, var_1);
  var_6 = [];
  var_7 = undefined;
  var_8 = 0;
  var_9 = getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F");

  for(var_10 = 0; var_10 < var_5.size; var_10++) {
    if(isDefined(var_5[var_10].getin))
      var_9 = 1;
  }

  if(!var_9) {
    var_0 notify("_encstr_8E130FA9E2D34D68AF94052BB094D8813F");

    if(getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F")) {
      var_7 = choose_vehicle_position(var_0, get_availablepositions(var_3), var_2);
      var_0.forced_startingposition = var_7.vehicle_position;
      var_1.usedpositions[var_7.vehicle_position] = 1;
      var_0 scripts\vehicle\vehicle_common::entervehicle(self, 1, var_7, anim_pos(self, var_0.forced_startingposition));
    }

    var_1 guy_enter(var_0, var_4);
    return;
  }

  if(!isDefined(var_0.get_in_moving_vehicle)) {
    while(var_1 vehicle_getspeed() > 1)
      wait 0.05;
  }

  var_11 = var_1 get_availablepositions(var_3);

  if(!var_11.availablepositions.size && var_11.nonanimatedpositions.size) {
    var_0 notify("_encstr_8E130FA9E2D34D68AF94052BB094D8813F");
    var_1 guy_enter(var_0, var_4);
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

  if(!getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F")) {
    var_0.script_moveoverride = 1;
    var_0 notify("_encstr_AFF5136B4BEAA2CF4A38B86349D06B40CED5D004B0");
    var_0 scripts\common\ai::set_forcegoal();
    var_0 scripts\common\ai::disable_arrivals();
    var_0.goalradius = 64;
    var_0 setgoalpos(var_8);
    var_0 waittill("_encstr_8B7205D9ED5958");
    var_0 scripts\common\ai::enable_arrivals();
    var_0 scripts\common\ai::unset_forcegoal();
    var_0 notify("_encstr_99F2114CED859346A5CD3B7DEC95864BB16395");
  } else {
    var_0 scripts\vehicle\vehicle_common::requestentervehicle(self, 0, var_7, anim_pos(self, var_7.vehicle_position));
    var_0 scripts\vehicle\vehicle_common::waitforarrivedatvehicle();
  }

  var_13 = anim_pos(var_1, var_7.vehicle_position);

  if(isDefined(var_13.delay)) {
    var_0.delay = var_13.delay;

    if(isDefined(var_13.delayinc))
      self.delayer = var_0.delay;
  }

  if(isDefined(var_13.delayinc)) {
    self.delayer = self.delayer + var_13.delayinc;
    var_0.delay = self.delayer;
  }

  if(!getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F"))
    var_1 link_to_sittag(var_0, var_13.sittag, var_13.sittag_origin_offset, var_13.sittag_angles_offset, var_13.linktoblend);

  var_0.allowdeath = 0;
  var_13 = var_5[var_7.vehicle_position];

  if(isDefined(var_7)) {
    if(isDefined(var_13.vehicle_getinanim)) {
      var_14 = isDefined(var_0.no_vehicle_getoutanim);

      if(!var_14 && !isagent(var_0)) {
        if(isDefined(var_13.vehicle_getoutanim))
          var_1 clearanim(var_13.vehicle_getoutanim, 0);

        if(isDefined(var_13.vehicle_getoutanim_combat))
          var_1 clearanim(var_13.vehicle_getoutanim_combat, 0);

        if(isDefined(var_13.vehicle_getoutanim_combat_run))
          var_1 clearanim(var_13.vehicle_getoutanim_combat_run, 0);
      }

      var_1 = var_1 getanimatemodel();
      var_1 thread setanimrestart_once(var_13.vehicle_getinanim, var_13.vehicle_getinanim_clear);
      var_1 thread scripts\common\notetrack::start_notetrack_wait(var_1, "_encstr_A372126756434B368DB2BE0B9B966B7DCC8D85CE", undefined, undefined, var_13.vehicle_getinanim);
    }

    if(isDefined(var_13.vehicle_getinsoundtag))
      var_8 = var_1 gettagorigin(var_13.vehicle_getinsoundtag);
    else
      var_8 = var_1.origin;

    if(isDefined(var_13.vehicle_getinsound))
      playworldsound(var_13.vehicle_getinsound, var_8);

    var_15 = undefined;
    var_16 = undefined;

    if(isDefined(var_13.getin_enteredvehicletrack)) {
      var_15 = [];
      var_15[0] = var_13.getin_enteredvehicletrack;
      var_16 = [];
      var_16[0] = ::entered_vehicle_notify;
      var_1 link_to_sittag(var_0, var_13.sittag, var_13.sittag_origin_offset, var_13.sittag_angles_offset, var_13.linktoblend);
    }

    if(!getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F"))
      var_1 animontag(var_0, var_13.sittag, var_13.getin, var_15, var_16, undefined, var_13.sittag_origin_offset, var_13.sittag_angles_offset);
  }

  if(getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F"))
    var_0 scripts\vehicle\vehicle_common::waitforentervehicle();

  var_0 notify("_encstr_8E130FA9E2D34D68AF94052BB094D8813F");
  var_1 guy_enter(var_0, var_4);
}

entered_vehicle_notify() {
  self notify("_encstr_8E130FA9E2D34D68AF94052BB094D8813F");
}

driverdead(var_0) {
  if(scripts\common\vehicle::ishelicopter()) {
    return;
  }
  self.driver = var_0;
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8A450C30FD60580AC8473EE8F323");
  var_0 waittill("_encstr_AD75063D571AE108");

  if(getdvarint("_encstr_8E221E59AC0D96361B95A1DB731D969BD5ACB9A7DC2239A567569388950BA3D0", 0) == 1) {
    return;
  }
  if(isDefined(self.vehicle_keeps_going_after_driver_dies)) {
    return;
  }
  self notify("_encstr_ADD00C0CF8285D2BD5C629A72733");
  self.deaddriver = 1;

  if(isDefined(self.hasstarted) && self.hasstarted) {
    self setwaitspeed(0);
    self vehicle_setspeed(0, 20, 20);
    self waittill("_encstr_83F31382ADE312408110479F407814999FBFCFFF85");
  }

  if(!istrue(self.donotunloadondriverdeath))
    scripts\common\vehicle::vehicle_unload();
}

guy_becomes_real_ai(var_0, var_1) {
  if(isai(var_0))
    return var_0;

  if(istrue(var_0.drone_delete_on_unload))
    var_0 delete();
  else {
    var_0 = scripts\engine\utility::script_func("_encstr_BE3B136E8316BB73AC9CAFD60BB6AC4ECA0B8D85B4", var_0);

    if(scripts\common\utility::issp())
      var_2 = self.classname;
    else
      var_2 = self.classname_mp;

    var_3 = level.vehicle.templates.aianims[var_2].size;
    var_4 = anim_pos(self, var_1);
    link_to_sittag(var_0, var_4.sittag, var_4.sittag_origin_offset, var_4.sittag_angles_offset, var_4.linktoblend);
    var_0.vehicle_idle = var_4.idle;

    if(!istrue(var_0.disable_vehicle_idle))
      thread guy_idle(var_0, var_1);
  }
}

link_to_sittag(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2))
    var_2 = (0, 0, 0);

  if(!isDefined(var_3))
    var_3 = (0, 0, 0);

  if(!isDefined(var_4))
    var_4 = 0;

  if(var_4 && !isDefined(var_0.script_drone))
    var_0 linktoblendtotag(self, var_1, 0);
  else
    var_0 linkTo(self, var_1, var_2, var_3);
}

anim_pos(var_0, var_1) {
  return level.vehicle.templates.aianims[var_0 scripts\common\vehicle_code::get_vehicle_classname()][var_1];
}

guy_deathhandle(var_0, var_1) {
  var_0 waittill("_encstr_AD75063D571AE108");

  if(!isDefined(self)) {
    return;
  }
  self.riders = scripts\engine\utility::array_remove(self.riders, var_0);
  self.usedpositions[var_1] = 0;
}

setup_aianimthreads() {
  if(!isDefined(level.vehicle.aianimthread))
    level.vehicle.aianimthread = [];

  if(!isDefined(level.vehicle.aianimcheck))
    level.vehicle.aianimcheck = [];

  level.vehicle.aianimthread["_encstr_A7C5056BD931D1"] = ::guy_idle;
  level.vehicle.aianimthread["_encstr_81A8077D3088BFA631"] = ::guy_unload;
}

guy_handle(var_0, var_1) {
  var_0.vehicle_idling = 1;
  thread guy_deathhandle(var_0, var_1);
}

driver_idle_speed(var_0, var_1) {
  var_0 endon("_encstr_815B08652FCB0FB0A195");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");
  var_2 = anim_pos(self, var_1);

  for(;;) {
    if(self vehicle_getspeed() == 0)
      var_0.vehicle_idle = var_2.idle_animstop;
    else
      var_0.vehicle_idle = var_2.idle_anim;

    wait 0.25;
  }
}

guy_idle(var_0, var_1, var_2) {
  var_0 endon("_encstr_815B08652FCB0FB0A195");

  if(!isDefined(var_2))
    self endon("_encstr_AD75063D571AE108");

  var_0 endon("_encstr_AD75063D571AE108");
  var_0.vehicle_idling = 1;
  var_0 notify("_encstr_835407CEBDA396ADAC");

  if(!isDefined(var_0.vehicle_idle)) {
    return;
  }
  var_3 = anim_pos(self, var_1);

  if(isDefined(var_3.mgturret)) {
    return;
  }
  if(isDefined(var_3.idle_animstop) && isDefined(var_3.idle_anim))
    thread driver_idle_speed(var_0, var_1);

  for(;;) {
    var_0 notify("_encstr_A7C5056BD931D1");
    play_new_idle(var_0, var_3);
  }
}

play_new_idle(var_0, var_1) {
  if(isDefined(var_0.vehicle_idle_override)) {
    animontag(var_0, var_1.sittag, var_0.vehicle_idle_override, undefined, undefined, undefined, var_1.sittag_origin_offset, var_1.sittag_angles_offset);
    return;
  }

  if(isDefined(var_1.idleoccurrence)) {
    var_2 = randomoccurrance(var_0, var_1.idleoccurrence);
    animontag(var_0, var_1.sittag, var_0.vehicle_idle[var_2], undefined, undefined, undefined, var_1.sittag_origin_offset, var_1.sittag_angles_offset);
    return;
  }

  if(isDefined(var_0.playerpiggyback) && isDefined(var_1.player_idle)) {
    animontag(var_0, var_1.sittag, var_1.player_idle, undefined, undefined, undefined, var_1.sittag_origin_offset, var_1.sittag_angles_offset);
    return;
  }

  if(isDefined(var_1.vehicle_idle))
    thread setanimrestart_once(var_1.vehicle_idle);

  animontag(var_0, var_1.sittag, var_0.vehicle_idle, undefined, undefined, undefined, var_1.sittag_origin_offset, var_1.sittag_angles_offset);
}

randomoccurrance(var_0, var_1) {
  var_2 = [];
  var_3 = 0;

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    var_3 = var_3 + var_1[var_4];
    var_2[var_4] = var_3;
  }

  var_5 = randomint(var_3);

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(var_5 < var_2[var_4])
      return var_4;
  }
}

guy_unload_que(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self.unloadque = scripts\engine\utility::array_add(self.unloadque, var_0);
  var_0 scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_B4350A0AAB73BA371120E5FC");
  self.unloadque = scripts\engine\utility::array_remove(self.unloadque, var_0);

  if(!self.unloadque.size) {
    scripts\engine\utility::ent_flag_set("_encstr_BD82096B5DA4B07F924F29");
    self.unload_group = "_encstr_8B1608EC43B8D647A113";
    self.maxdogtags = undefined;
  }
}

riders_unloadable(var_0) {
  if(!self.riders.size)
    return 0;

  for(var_1 = 0; var_1 < self.riders.size; var_1++) {
    if(!isalive(self.riders[var_1]) && !isDefined(self.riders[var_1].isvehicle)) {
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
  var_2 = "_encstr_8B1608EC43B8D647A113";

  if(isDefined(self.unload_group))
    var_2 = self.unload_group;

  var_1 = level.vehicle.templates.unloadgroups[scripts\common\vehicle_code::get_vehicle_classname()][var_2];

  if(!isDefined(var_1))
    var_1 = level.vehicle.templates.unloadgroups[scripts\common\vehicle_code::get_vehicle_classname()]["_encstr_8B1608EC43B8D647A113"];

  foreach(var_4 in var_1)
  var_0[var_4] = var_4;

  return var_0;
}

check_unloadgroup(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = self.unload_group;

  var_2 = scripts\common\vehicle_code::get_vehicle_classname();

  if(!isDefined(level.vehicle.templates.unloadgroups[var_2]))
    return 1;

  if(!isDefined(level.vehicle.templates.unloadgroups[var_2][var_1]))
    return 1;

  var_3 = level.vehicle.templates.unloadgroups[var_2][var_1];

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(var_0 == var_3[var_4])
      return 1;
  }

  return 0;
}

getoutrig_model_idle(var_0, var_1, var_2) {
  self endon("_encstr_A9210A283BEC90BB323450EC");

  for(;;)
    animontag(var_0, var_1, var_2);
}

getoutrig_model(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\common\vehicle_code::get_vehicle_classname();

  if(var_4) {
    thread getoutrig_model_idle(var_1, var_2, level.vehicle.templates.attachedmodels[var_5][var_0.fastroperig].idleanim);
    self waittill("_encstr_A9210A283BEC90BB323450EC");
  }

  self.unloadque = scripts\engine\utility::array_add(self.unloadque, var_1);
  thread getoutrig_abort(var_1, var_2, var_3);

  if(!scripts\common\vehicle_code::vehicle_iscrashing())
    animontag(var_1, var_2, var_3);

  var_1 unlink();

  if(!isDefined(self)) {
    var_1 delete();
    return;
  }

  self.unloadque = scripts\engine\utility::array_remove(self.unloadque, var_1);

  if(!self.unloadque.size)
    self notify("_encstr_BD82096B5DA4B07F924F29");

  self.fastroperig[var_0.fastroperig] = undefined;
  wait 10;
  var_1 delete();
}

getoutrig_model_new(var_0, var_1, var_2, var_3, var_4) {
  self endon("_encstr_AD75063D571AE108");
  var_5 = scripts\common\vehicle_code::get_vehicle_classname();
  thread scripts\engine\utility::delete_on_death(var_1);
  var_6 = self gettagorigin(var_2);
  var_7 = self gettagangles(var_2);
  var_8 = level.vehicle.templates.attachedmodels[var_5][var_0.fastroperig].idleanim;
  var_9 = getstartorigin(var_6, var_7, var_8);
  var_10 = getstartangles(var_6, var_7, var_8);
  var_10 = self.angles;
  var_11 = var_1 gettagorigin("_encstr_B66109F3C70B7F877D1FE7", 1);
  var_12 = var_11 - self.origin;

  if(var_4) {
    var_1.origin = var_9;
    var_1.angles = var_10;
    thread scripts\engine\utility::script_func("_encstr_A7370ECC589B3A4E7BC1ACFA1673D2B6", var_1, var_8, "_encstr_815C0E772FFB0868BC52F831BC9498B5");
    scripts\engine\utility::ent_flag_wait("_encstr_BD82096B5DA4B07F924F29");
  }

  var_6 = self gettagorigin(var_2);
  var_7 = self gettagangles(var_2);
  var_13 = self.angles - var_10;
  var_13 = (angleclamp(var_13[0]), angleclamp(var_13[1]), angleclamp(var_13[2]));
  var_14 = rotatevector(var_12, var_13) + self.origin;
  var_15 = scripts\engine\trace::ray_trace(var_14, var_14 - (0, 0, 1000), self, scripts\engine\trace::create_world_contents());
  var_16 = var_14[2] - 400;

  if(isDefined(var_15["_encstr_BD260953AA97E3F014279D"]))
    var_16 = var_15["_encstr_BD260953AA97E3F014279D"][2];

  var_17 = (var_6[0], var_6[1], var_16);

  if(istrue(level.vehicle.templates.attachedmodels[var_5][var_0.fastroperig].dropusestraceorigin))
    var_17 = (var_14[0], var_14[1], var_16);

  thread getoutrig_abort(var_1, undefined, var_3, var_17);

  if(!scripts\common\vehicle_code::vehicle_iscrashing()) {
    var_1 unlink();
    var_1.origin = var_17;
    thread scripts\engine\utility::script_func("_encstr_A7370ECC589B3A4E7BC1ACFA1673D2B6", var_1, var_3, "_encstr_BE980EEFB763908044AA10A9D7396359");
  }

  self.fastroperig[var_0.fastroperig] = undefined;
  wait 10;
  var_1 delete();
}

getoutrig_disable_abort_notify_after_riders_out() {
  wait 0.05;

  while(isalive(self) && self.unloadque.size > 2)
    wait 0.05;

  if(!isalive(self) || scripts\common\vehicle_code::vehicle_iscrashing()) {
    return;
  }
  self notify("_encstr_92FD182AB01CE84BE892D8C2C7698A63B975AA672F688A1813C3");
}

getoutrig_abort_while_deploying() {
  self endon("_encstr_992724C9FD0C91DC22AB5F6343BB13889F9691ED6264D98CCAC7A15BD7826D7874ED7A580DDF");

  while(!scripts\common\vehicle_code::vehicle_iscrashing())
    wait 0.05;

  var_0 = [];

  foreach(var_2 in self.riders) {
    if(isalive(var_2))
      scripts\engine\utility::array_add_safe(var_0, var_2);
  }

  scripts\engine\utility::array_delete(var_0);
  self notify("_encstr_AD1318D8E4169BA1B219EB7743966356D732CA38D8EDF24BB99D");
  var_0 = undefined;
}

getoutrig_abort(var_0, var_1, var_2, var_3) {
  var_4 = getanimlength(var_2);
  var_5 = var_4 - 1.0;

  if(self.vehicletype == "_encstr_ADA2056BD298B9")
    var_5 = var_4 - 0.5;

  var_6 = 0.8;
  self endon("_encstr_92FD182AB01CE84BE892D8C2C7698A63B975AA672F688A1813C3");
  thread getoutrig_disable_abort_notify_after_riders_out();
  thread getoutrig_abort_while_deploying();
  scripts\engine\utility::waittill_notify_or_timeout("_encstr_AD1318D8E4169BA1B219EB7743966356D732CA38D8EDF24BB99D", var_6);
  self notify("_encstr_992724C9FD0C91DC22AB5F6343BB13889F9691ED6264D98CCAC7A15BD7826D7874ED7A580DDF");

  while(!isDefined(self.vehiclecrashing))
    waitframe();

  if(isDefined(var_0)) {
    if(!isDefined(var_1) && isDefined(var_3)) {
      var_0 unlink();
      var_0.origin = var_3;

      if(!scripts\common\utility::issp()) {
        var_7 = var_0 scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", var_2);
        var_8 = var_0 scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_7);
        var_9 = getstartorigin(self.origin, self.angles, var_8);
        var_10 = getstartangles(self.origin, self.angles, var_8);
        var_0 dontinterpolate();
        var_0 forceteleport(var_9, var_10);
        var_0 animmode("_encstr_8B970A9BF6D99C589DD2472F");
        var_0 aisetanim("_encstr_84610D49100897C2DF809A03583BFF", var_7);
      } else
        var_0 animScripted("_encstr_BE980EEFB763908044AA10A9D7396359", var_0.origin, var_0.angles, var_2, undefined, undefined, 0);
    } else
      thread animontag(var_0, var_1, var_2);

    waittillframeend;
    var_0 setanimtime(var_2, var_5 / var_4);
  }

  var_11 = self;

  if(isDefined(self.original_attacker))
    var_11 = self.original_attacker;

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

    if(isalive(self.riders[var_12]))
      thread animontag_ragdoll_death_fall(self.riders[var_12], self, var_11);
  }
}

setanimrestart_once(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_962F1023F6CDE8F5C6D859164ED70B9BB4B5");

  if(!isDefined(var_1))
    var_1 = 1;

  var_2 = getanimlength(var_0);
  self endon("_encstr_AD75063D571AE108");
  thread scripts\engine\utility::script_func("_encstr_8A9812CCE71CF0912B19E7C9A87F2D69AEE072C7", self, var_0);
  wait(var_2);

  if(scripts\common\utility::issp() && var_1)
    self clearanim(var_0, 0);
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");

getout_rigspawn(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 1;

  var_3 = scripts\common\vehicle_code::get_vehicle_classname();

  if(isDefined(self.attach_model_override) && isDefined(self.attach_model_override[var_1.fastroperig]))
    var_4 = 1;
  else
    var_4 = 0;

  if(!isDefined(var_1.fastroperig) || isDefined(self.fastroperig[var_1.fastroperig]) || var_4) {
    return;
  }
  var_5 = var_0 gettagorigin(level.vehicle.templates.attachedmodels[var_3][var_1.fastroperig].tag);
  var_6 = var_0 gettagangles(level.vehicle.templates.attachedmodels[var_3][var_1.fastroperig].tag);
  self.fastroperiganimating[var_1.fastroperig] = 1;
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5);
  var_7.angles = var_6;
  var_7.origin = var_5;
  var_7 useanimtree(#animtree);
  var_7 setModel(level.vehicle.templates.attachedmodels[var_3][var_1.fastroperig].model);
  self.fastroperig[var_1.fastroperig] = var_7;
  var_7 linkTo(var_0, level.vehicle.templates.attachedmodels[var_3][var_1.fastroperig].tag);

  if(getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F"))
    thread getoutrig_model_new(var_1, var_7, level.vehicle.templates.attachedmodels[var_3][var_1.fastroperig].tag, level.vehicle.templates.attachedmodels[var_3][var_1.fastroperig].dropanim, var_2);
  else
    thread getoutrig_model(var_1, var_7, level.vehicle.templates.attachedmodels[var_3][var_1.fastroperig].tag, level.vehicle.templates.attachedmodels[var_3][var_1.fastroperig].dropanim, var_2);

  return var_7;
}

check_sound_tag_dupe(var_0) {
  if(!isDefined(self.sound_tag_dupe))
    self.sound_tag_dupe = [];

  var_1 = 0;

  if(!isDefined(self.sound_tag_dupe[var_0]))
    self.sound_tag_dupe[var_0] = 1;
  else
    var_1 = 1;

  thread check_sound_tag_dupe_reset(var_0);
  return var_1;
}

check_sound_tag_dupe_reset(var_0) {
  wait 0.05;

  if(!isDefined(self)) {
    return;
  }
  self.sound_tag_dupe[var_0] = 0;
  var_1 = getarraykeys(self.sound_tag_dupe);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(self.sound_tag_dupe[var_1[var_2]])
      return;
  }

  self.sound_tag_dupe = undefined;
}

vehicle_play_exit_anim(var_0, var_1, var_2) {
  var_3 = level.vehicle.templates.aianims[scripts\common\vehicle_code::get_vehicle_classname()];
  var_4 = getanimatemodel();

  if(!isDefined(var_1))
    var_1 = var_0.vehicle_getoutanim;

  if(!isDefined(var_2))
    var_2 = var_0.vehicle_getoutanim_clear;

  if(isDefined(var_1)) {
    var_4 thread setanimrestart_once(var_1, var_2);
    var_5 = 0;

    if(isDefined(var_0.vehicle_getoutsoundtag)) {
      var_5 = check_sound_tag_dupe(var_0.vehicle_getoutsoundtag);
      var_6 = var_4 gettagorigin(var_0.vehicle_getoutsoundtag);
    } else
      var_6 = var_4.origin;

    if(isDefined(var_0.vehicle_getoutsound) && !var_5)
      playworldsound(var_0.vehicle_getoutsound, var_6);

    var_5 = undefined;
  }
}

vehicle_end_loop_sounds(var_0, var_1) {
  var_2 = anim_pos(self, var_1);

  if(isDefined(var_0.playerpiggyback) && isDefined(var_2.player_getout_sound_loop))
    level.player thread scripts\engine\utility::script_func("_encstr_A63818E036C25E63ED7B07E67BAE9BC8AFDEE6F559CD1D4BA3F2", var_2.player_getout_sound_loop);

  if(isDefined(var_2.getoutloopsnd))
    var_0 thread scripts\engine\utility::script_func("_encstr_A63818E036C25E63ED7B07E67BAE9BC8AFDEE6F559CD1D4BA3F2", var_2.getoutloopsnd);

  if(isDefined(var_0.playerpiggyback) && isDefined(var_2.player_getout_sound_end))
    level.player thread scripts\engine\utility::script_func("_encstr_AF701477B15A8392B8AB4D7A11F508D78158959B8302", var_2.player_getout_sound_end);
}

_id_1286B() {
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
      self.maxdogtags[var_2]._id_1212C = 0;
    }
  }
}

wait_for_open_door(var_0, var_1) {
  var_0 endon("_encstr_B4350A0AAB73BA371120E5FC");
  var_0 endon("_encstr_AD75063D571AE108");
  _id_1286B();

  while(!istrue(var_0.requestopendoor))
    waitframe();

  if(isDefined(var_1.vehicle_getoutanim)) {
    var_2 = getanimname(var_1.vehicle_getoutanim);

    if(!self.maxdogtags[var_2].open) {
      var_3 = var_1.vehicle_getoutanim;
      var_4 = var_1.vehicle_getoutanim_clear;

      if(isDefined(var_0.requestopendoorparams)) {
        if(var_0.requestopendoorparams == "_encstr_AD380BFA20795B8E785F9A8525" && isDefined(var_1.vehicle_getoutanim_combat_run)) {
          var_3 = var_1.vehicle_getoutanim_combat_run;
          var_4 = var_1.vehicle_getoutanim_combat_run_clear;
        } else if(var_0.requestopendoorparams == "_encstr_AA7C07466F9DA30713" && isDefined(var_1.vehicle_getoutanim_combat)) {
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
    }
  }
}

guy_setup_rope(var_0, var_1) {
  if(isDefined(var_1.fastroperig)) {
    thread wait_for_open_door(var_0, var_1);
    var_0 scripts\vehicle\vehicle_common::setuprope();
  } else {}
}

guy_unload(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0.isvehicle))
    var_2 = 1;

  var_3 = anim_pos(self, var_1);
  var_4 = self.vehicletype;

  if(!check_unloadgroup(var_1)) {
    if(!getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F"))
      thread guy_idle(var_0, var_1);

    return;
  }

  if(!getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F") && !isDefined(var_3.getout)) {
    thread guy_idle(var_0, var_1);
    return;
  }

  thread guy_unload_que(var_0);
  self endon("_encstr_AD75063D571AE108");

  if(isai(var_0) && isalive(var_0))
    var_0 endon("_encstr_AD75063D571AE108");

  var_5 = 0;

  if(isDefined(var_0.getoffvehiclefunc)) {
    var_6 = var_0[[var_0.getoffvehiclefunc]]();

    if(isDefined(var_6) && var_6)
      var_5 = 1;
  }

  if(isDefined(var_0.onrotatingvehicleturret)) {
    var_0.onrotatingvehicleturret = undefined;

    if(isDefined(var_0.getoffvehiclefunc))
      var_0[[var_0.getoffvehiclefunc]]();
  }

  if(!getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F")) {
    vehicle_play_exit_anim(var_3);
    var_7 = 0;

    if(isDefined(var_3.getout_timed_anim))
      var_7 = var_7 + getanimlength(var_3.getout_timed_anim);

    if(isDefined(var_3.delay))
      var_7 = var_7 + var_3.delay;

    if(isDefined(var_0.delay))
      var_7 = var_7 + var_0.delay;

    if(var_7 > 0) {
      if(!getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F"))
        thread guy_idle(var_0, var_1);

      wait(var_7);
    }
  }

  if(!getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F")) {
    var_0.deathanim = undefined;
    var_0.deathanimscript = undefined;
  }

  var_0 notify("_encstr_815B08652FCB0FB0A195");

  if(isDefined(var_3.bhasgunwhileriding) && !var_3.bhasgunwhileriding) {
    if(!isDefined(var_0.disable_gun_recall))
      var_0 scripts\common\ai::gun_recall();
  }

  if(isai(var_0))
    var_0 pushplayer(1);

  if(isDefined(var_3.bnoanimunload))
    var_5 = 1;
  else if(!getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F") && !isDefined(var_3.getout) || !isDefined(self.script_unloadmgguy) && (isDefined(var_3.bisgunner) && var_3.bisgunner) || isDefined(self.script_keepdriver) && var_1 == 0) {
    thread guy_idle(var_0, var_1);
    return;
  }

  if(var_0 should_give_orghealth())
    var_0.health = var_0.orghealth;

  var_0.orghealth = undefined;

  if(isai(var_0) && isalive(var_0))
    var_0 endon("_encstr_AD75063D571AE108");

  var_0.allowdeath = 0;

  if(isDefined(var_3.exittag))
    var_8 = var_3.exittag;
  else
    var_8 = var_3.sittag;

  if(isDefined(var_0.get_out_override))
    var_9 = var_0.get_out_override;
  else if(scripts\engine\utility::ent_flag("_encstr_9A93071D297064AAC5") && isDefined(var_3.getout_landed))
    var_9 = var_3.getout_landed;
  else if(isDefined(var_0.playerpiggyback) && isDefined(var_3.player_getout))
    var_9 = var_3.player_getout;
  else
    var_9 = var_3.getout;

  if(!var_5) {
    if(!getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F"))
      thread guy_unlink_on_death(var_0);

    if(!getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F") && isDefined(var_3.fastroperig)) {
      if(!isDefined(self.fastroperig[var_3.fastroperig])) {
        if(!getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F"))
          thread guy_idle(var_0, var_1);

        var_10 = getanimatemodel();
        var_11 = getout_rigspawn(var_10, var_3, 1);
      }
    }

    if(isDefined(var_3.getoutsnd))
      var_0 thread scripts\engine\utility::script_func("_encstr_84A5118395F1582E6A777579C732F8219CAEE9", var_3.getoutsnd, "_encstr_83190BAD47D7A3B3B20C5E03E4", 1);

    if(isDefined(var_0.playerpiggyback) && isDefined(var_3.player_getout_sound))
      var_0 thread scripts\engine\utility::script_func("_encstr_84A5118395F1582E6A777579C732F8219CAEE9", var_3.player_getout_sound);

    if(isDefined(var_3.getoutloopsnd))
      var_0 thread scripts\engine\utility::script_func("_encstr_87F01598DA46D3A8975F0F86278790A1A172E059F39E17", var_3.getoutloopsnd);

    if(isDefined(var_0.playerpiggyback) && isDefined(var_3.player_getout_sound_loop))
      level.player thread scripts\engine\utility::script_func("_encstr_87F01598DA46D3A8975F0F86278790A1A172E059F39E17", var_3.player_getout_sound_loop);

    var_0 notify("_encstr_815B08652FCB0FB0A195");
    var_0 notify("_encstr_8A450C30FD60580AC8473EE8F323");
    var_12 = 0;

    if(!isai(var_0) && !var_2)
      var_12 = 1;

    if(!isDefined(var_0.script_stay_drone) && !var_2)
      var_0 = guy_becomes_real_ai(var_0, var_1);

    if(!isalive(var_0) && !var_2) {
      return;
    }
    if(!var_2)
      var_0.ragdoll_getout_death = 1;

    if(isDefined(var_3.ragdoll_getout_death)) {
      var_0.ragdoll_getout_death = 1;

      if(isDefined(var_3.ragdoll_fall_anim))
        var_0.ragdoll_fall_anim = var_3.ragdoll_fall_anim;
    }

    if(var_12) {
      self.riders = scripts\engine\utility::array_add(self.riders, var_0);
      thread guy_deathhandle(var_0, var_1);
      thread guy_unload_que(var_0);
      var_0.ridingvehicle = self;
    }

    if(isai(var_0))
      var_0 endon("_encstr_AD75063D571AE108");

    var_0 notify("_encstr_815B08652FCB0FB0A195");
    var_0 notify("_encstr_8A450C30FD60580AC8473EE8F323");

    if(isDefined(var_3.littlebirde_getout_unlinks) && var_3.littlebirde_getout_unlinks)
      thread stable_unlink(var_0);

    if(isalive(var_0) && isai(var_0) && guy_resets_goalpos(var_0)) {
      var_0.goalradius = 600;
      var_0 setgoalpos(var_0.origin);
    }

    if(isDefined(var_3.getout_secondary)) {
      animontag(var_0, var_8, var_9);
      var_13 = var_8;

      if(isDefined(var_3.getout_secondary_tag))
        var_13 = var_3.getout_secondary_tag;

      animontag(var_0, var_13, var_3.getout_secondary, undefined, undefined, undefined, var_3.sittag_origin_offset, var_3.sittag_angles_offset);
    } else {
      var_14 = 0;

      if(isDefined(var_3.getout_hover_loop) && isDefined(var_3.getout_hover_land)) {
        thread guy_unload_land(var_0, var_8, var_3.getout, var_3.getout_hover_loop, var_3.getout_hover_land);
        var_14 = 1;
      } else if(!var_2)
        var_0.anim_end_early = 1;

      if(!getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F"))
        animontag(var_0, var_8, var_9, undefined, undefined, undefined, var_3.sittag_origin_offset, var_3.sittag_angles_offset);
      else {
        thread wait_for_open_door(var_0, var_3);
        var_0 scripts\vehicle\vehicle_common::exitvehicle();
      }

      if(var_14)
        var_0 waittill("_encstr_A9A911A87DDE8096E3031917579A48D06F95B1");
    }

    if(isDefined(var_0.playerpiggyback) && isDefined(var_3.player_getout_sound_loop))
      level.player thread scripts\engine\utility::stop_loop_sound_on_entity(var_3.player_getout_sound_loop);

    if(isDefined(var_3.getoutloopsnd))
      var_0 thread scripts\engine\utility::stop_loop_sound_on_entity(var_3.getoutloopsnd);

    if(isDefined(var_0.playerpiggyback) && isDefined(var_3.player_getout_sound_end))
      level.player thread scripts\engine\utility::script_func("_encstr_AF701477B15A8392B8AB4D7A11F508D78158959B8302", var_3.player_getout_sound_end);
  } else if(!isai(var_0)) {
    if(istrue(var_0.drone_delete_on_unload)) {
      var_0 delete();
      return;
    }

    var_0 = scripts\engine\utility::script_func("_encstr_BE3B136E8316BB73AC9CAFD60BB6AC4ECA0B8D85B4", var_0);
  }

  self.riders = scripts\engine\utility::array_remove(self.riders, var_0);
  self.usedpositions[var_1] = 0;
  var_0.ridingvehicle = undefined;
  var_0.drivingvehicle = undefined;

  if(!isalive(self) && !isDefined(var_3.unload_ondeath)) {
    var_0 delete();
    return;
  }

  if(!getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F"))
    var_0 unlink();

  if(!isDefined(var_0.magic_bullet_shield))
    var_0.allowdeath = 1;

  if(isalive(var_0) || var_2) {
    if(isai(var_0))
      var_0.a.disablelongdeath = !var_0 isbadguy();

    var_0.forced_startingposition = undefined;

    if(isai(var_0)) {
      if(isDefined(var_3.getoutstance)) {
        var_0.desired_anim_pose = var_3.getoutstance;
        var_0 allowedstances("_encstr_B13D076BED70539F23");
        var_0 thread scripts\engine\utility::script_func("_encstr_BA291485375AD6BE5D381916D1AC0BCDB4AD837BDCB2");
        var_0 allowedstances("_encstr_A5AD069B231F0BAF", "_encstr_B13D076BED70539F23", "_encstr_922406F1A6FD5E05");
      }

      var_0 pushplayer(0);
    } else if(var_2) {
      var_0.vspawner.origin = var_0.origin;
      var_0.vspawner.angles = var_0.angles;

      if(isDefined(var_0.vspawner.target))
        var_0.vspawner scripts\common\vehicle::spawn_vehicle_and_gopath();
      else
        var_15 = var_0.vspawner scripts\common\utility::spawn_vehicle();

      var_0 delete();
    }

    if(!getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F"))
      var_0 notify("_encstr_B4350A0AAB73BA371120E5FC");
  }

  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "_encstr_884114186A258BCBDF0FE76C1CE73337CB42D0B8C2FF") {
    var_0 delete();
    return;
  }

  if(isDefined(var_3.getout_delete) && var_3.getout_delete) {
    var_0 delete();
    return;
  }

  var_0 guy_cleanup_vehiclevars();
}

guy_unload_land(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self gettagorigin(var_1);
  var_6 = self gettagangles(var_1);
  var_7 = getstartorigin(var_5, var_6, var_2);
  var_8 = getstartangles(var_5, var_6, var_2);
  var_9 = getmovedelta(var_2, 0, 1);
  var_10 = scripts\engine\utility::spawn_tag_origin();
  var_10.origin = var_7;
  var_10.angles = var_8;
  var_11 = var_10 localtoworldcoords(var_9);
  var_10 thread scripts\engine\utility::delete_on_notify("_encstr_9B420907FD535DAC6DF285");
  var_12 = var_11;
  var_13 = scripts\common\utility::groundpos(var_12);
  var_14 = getstartorigin(var_5, var_6, var_4);
  var_9 = getmovedelta(var_4, 0, 1);
  var_15 = var_14 + var_9;
  var_16 = var_14[2] - var_15[2];
  var_17 = var_13 + (0, 0, var_16);
  var_0.allowdeath = 0;
  var_0 setCanDamage(0);
  var_0 endon("_encstr_AD75063D571AE108");
  wait(getanimlength(var_2) - 0.1);
  var_0 unlink();
  var_0 notify("_encstr_84F11111A8CAD9DAD0E0AF0C264958C3F51F0A");
  var_0 stopanimScripted();
  var_10.origin = var_0.origin;
  var_10.angles = var_0.angles;
  var_10 dontinterpolate();
  var_0 dontinterpolate();
  var_0 linkTo(var_10, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  var_0.allowdeath = 1;
  var_0 setCanDamage(1);
  var_0.unload_loopanim = var_3;

  if(isai(var_0))
    var_0 scripts\engine\utility::script_func("_encstr_874A0F7AF0B3B1E790E33D2B855BFBC5CB", ::guy_fall_loop, ::guy_fall_loop_end);
  else
    var_0 thread guy_fall_loop();

  var_18 = length((0, 0, var_17[2]) - (0, 0, var_12[2]));
  var_19 = 350;
  var_20 = var_18 / var_19;
  var_10 moveTo(var_17, var_20);
  var_10 waittill("_encstr_9B420907FD535DAC6DF285");
  var_0 unlink();
  var_0 animScripted("_encstr_AF760E0C3E18099B83CA7370448038EC", var_0.origin, var_0.angles, var_4);
  wait(getanimlength(var_4));
  var_0 notify("_encstr_A9A911A87DDE8096E3031917579A48D06F95B1");
  var_0 notify("_encstr_A7DA11471D0B6AE7C8607183B9B0DF32D085DF");
}

guy_fall_loop() {
  if(isai(self)) {
    if(scripts\engine\utility::actor_is3d())
      self orientmode("_encstr_91440EF5D7AA1B467F70DAB9531A9ED1", self.angles);
    else
      self orientmode("_encstr_A34A0B518A172592D6E64FA115", self.angles[1]);

    self animmode("_encstr_A1370EF3FA638AFB695A587B03B42E57", 1);
    self clearanim(scripts\asm\asm::asm_getbodyknob(), 0.2);
  }

  self setanim(self.unload_loopanim, 1);
  self waittill("_encstr_AF760E0C3E18099B83CA7370448038EC");
}

guy_fall_loop_end() {}

guy_resets_goalpos(var_0) {
  if(isDefined(var_0.script_delayed_playerseek))
    return 0;

  if(istrue(var_0 scripts\engine\utility::script_func("_encstr_ADC70DC1B4AFB047CB7FCFCFABD216")))
    return 0;

  if(isDefined(var_0.qsetgoalpos))
    return 0;

  if(!isDefined(var_0.target))
    return 1;

  var_1 = getnodearray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::getStructArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_1.size > 0 || var_2.size > 0)
    return 0;

  var_3 = getEnt(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_3) && var_3.classname == "_encstr_AC790C38CB1680D7038561F51D6A")
    return 0;

  return 1;
}

animontag(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_0 notify("_encstr_84F11111A8CAD9DAD0E0AF0C264958C3F51F0A");
  var_0 endon("_encstr_84F11111A8CAD9DAD0E0AF0C264958C3F51F0A");

  if(!isDefined(var_6))
    var_6 = (0, 0, 0);

  if(!isDefined(var_7))
    var_7 = (0, 0, 0);

  if(!isDefined(var_5))
    var_5 = "_encstr_974A0E5288F3FF9520B1010FB97B1D07";

  if(isDefined(self.modeldummy))
    var_8 = self.modeldummy;
  else
    var_8 = self;

  if(!isDefined(var_1) || !scripts\engine\utility::hastag(var_8.model, var_1)) {
    var_9 = var_0.origin;
    var_10 = var_0.angles;
  } else {
    var_9 = var_8 gettagorigin(var_1);
    var_10 = var_8 gettagangles(var_1) + var_7;
    var_11 = anglestoaxis(var_10);
    var_12 = ["_encstr_B42E085325A82CB3F221", "_encstr_8253060E2B5FE330", "_encstr_87070365F7"];

    for(var_13 = 0; var_13 < var_11.size; var_13++)
      var_9 = var_9 + var_11[var_12[var_13]] * var_6[var_13];
  }

  if(isDefined(var_0.ragdoll_getout_death) && !isDefined(var_0.no_vehicle_ragdoll))
    level thread animontag_ragdoll_death(var_0, self);

  if(!scripts\common\utility::issp()) {
    var_0 dontinterpolate();

    if(isai(var_0)) {
      var_14 = var_0 scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", var_2);
      var_15 = var_0 scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_14);
      var_16 = getstartorigin(self.origin, self.angles, var_15);
      var_17 = getstartangles(self.origin, self.angles, var_15);
      var_0 forceteleport(var_16, var_17);
      var_0 animmode("_encstr_8B970A9BF6D99C589DD2472F");
      var_0 aisetanim("_encstr_84610D49100897C2DF809A03583BFF", var_14);
    }
  } else
    var_0 animScripted(var_5, var_9, var_10, var_2);

  if(isai(var_0))
    thread donotetracks(var_0, var_8, var_5);

  if(isDefined(var_0.anim_end_early)) {
    var_0.anim_end_early = undefined;
    var_18 = getanimlength(var_2) - 0.25;

    if(var_18 > 0)
      wait(var_18);

    if(getdvarint("_encstr_82E40A260539151545254A41", 0) == 1)
      var_0 stopanimScripted();

    var_0.interval = 0;
    var_0 thread recover_interval();
  } else {
    if(isDefined(var_3)) {
      for(var_13 = 0; var_13 < var_3.size; var_13++) {
        var_0 waittillmatch(var_5, var_3[var_13]);
        var_0 thread[[var_4[var_13]]]();
      }
    }

    var_0 waittillmatch(var_5, "_encstr_961804BD954A");
  }

  var_0 notify("_encstr_A7DA11471D0B6AE7C8607183B9B0DF32D085DF");
  var_0.ragdoll_getout_death = undefined;
}

recover_interval() {
  self endon("_encstr_AD75063D571AE108");
  wait 2;

  if(self.interval == 0)
    self.interval = 80;
}

animontag_ragdoll_death(var_0, var_1) {
  if(isDefined(var_0.magic_bullet_shield) && var_0.magic_bullet_shield) {
    return;
  }
  if(!isai(var_0))
    var_0 setCanDamage(1);

  var_0 endon("_encstr_A7DA11471D0B6AE7C8607183B9B0DF32D085DF");
  var_2 = undefined;
  var_3 = undefined;
  var_4 = var_1.health <= 0;

  for(;;) {
    if(!var_4 && !(isDefined(var_1) && var_1.health > 0)) {
      break;
    }

    var_0 waittill("_encstr_B2BE0788BAF573592F", var_2, var_3);

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

animontag_ragdoll_death_fall(var_0, var_1, var_2) {
  var_0.deathanim = undefined;
  var_0.deathfunction = undefined;
  var_0.anim_disablepain = 1;

  if(isDefined(var_0.ragdoll_fall_anim)) {
    var_3 = getmovedelta(var_0.ragdoll_fall_anim, 0, 1);
    var_4 = physicstrace(var_0.origin + (0, 0, 16), var_0.origin - (0, 0, 10000));
    var_5 = distance(var_0.origin + (0, 0, 16), var_4);

    if(abs(var_3[2] + 16) <= abs(var_5)) {
      var_0 thread scripts\engine\utility::script_func("_encstr_AF701477B15A8392B8AB4D7A11F508D78158959B8302", "_encstr_843B160F79A0B5EB7307C723632FD3E081A10655B0607672");
      var_0 animScripted("_encstr_86610ECC2CCD1DC9ED83ACD7992CB18D", var_0.origin, var_0.angles, var_0.ragdoll_fall_anim);
      var_0 waittillmatch("_encstr_86610ECC2CCD1DC9ED83ACD7992CB18D", "_encstr_A6B50E7F1099CAFB7FFE960FED37326C");
    }
  }

  if(!isDefined(var_0)) {
    return;
  }
  var_0.deathanim = undefined;
  var_0.deathfunction = undefined;
  var_0.anim_disablepain = 1;
  var_0 notify("_encstr_829F0BCB5DF8A020D20F634113", var_2);
  var_0 kill(var_2.origin, var_2);

  if(isDefined(var_0.script_stay_drone)) {
    var_0 notsolid();
    var_6 = getweaponmodel(var_0.weapon);
    var_7 = var_0.weapon;

    if(isDefined(var_6)) {
      var_0 detach(var_6, "_encstr_91AC11A5C6EA277BF50F837BCB371383322C1D");
      var_8 = var_0 gettagorigin("_encstr_91AC11A5C6EA277BF50F837BCB371383322C1D");
      var_9 = var_0 gettagangles("_encstr_91AC11A5C6EA277BF50F837BCB371383322C1D");
      level.gun = spawn("_encstr_B2010820C5337B67C8CF" + createheadicon(var_7), (0, 0, 0));
      level.gun.angles = var_9;
      level.gun.origin = var_8;
    }
  } else
    var_0 scripts\engine\utility::script_func("_encstr_8B1216E955C0D5EFA5D352AB99897B8EA81F6571C148DD97");

  if(isDefined(var_0.fnpreragdoll))
    var_0[[var_0.fnpreragdoll]]();

  var_0 startragdoll();
}

donotetracks(var_0, var_1, var_2) {
  var_0 endon("_encstr_A7C5056BD931D1");
  var_0 endon("_encstr_815B08652FCB0FB0A195");
  var_1 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 scripts\engine\utility::script_func("_encstr_A90B1279C550455F15C0D2CACBFD8BFA7847FBD3", var_2);
}

animatemoveintoplace(var_0, var_1, var_2, var_3) {
  var_0 animScripted("_encstr_8EB70BCD2075CAD44830730760", var_1, var_2, var_3);
  var_0 waittillmatch("_encstr_8EB70BCD2075CAD44830730760", "_encstr_961804BD954A");
}

guy_vehicle_death(var_0, var_1) {
  if(!isalive(var_0)) {
    return;
  }
  if(isDefined(self.no_rider_death)) {
    return;
  }
  var_2 = anim_pos(self, var_0.vehicle_position);

  if(isDefined(var_2.explosion_death))
    return guy_blowup(var_0);

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
    wait(var_2.unload_ondeath);

    if(isDefined(var_0) && isDefined(self)) {
      self.groupedanim_pos = var_0.vehicle_position;
      animate_guys("_encstr_81A8077D3088BFA631");
    }

    return;
  }

  if(isDefined(var_0)) {
    if(isDefined(var_0.ragdoll_getout_death)) {
      return;
    }
    var_0 delete();
  }
}

ai_wait_go() {
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_92D20741F7CEB03D1B");
  scripts\common\vehicle_paths::gopath(self);
}

set_pos(var_0, var_1) {
  var_2 = var_0.script_startingposition;

  if(isDefined(var_0.forced_startingposition))
    var_2 = var_0.forced_startingposition;

  if(isDefined(var_2))
    return var_2;

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
  return;
}

guy_man_turret(var_0, var_1, var_2) {
  var_3 = anim_pos(self, var_1);
  var_4 = self.mgturret[var_3.mgturret];

  if(!isalive(var_0)) {
    return;
  }
  var_4 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");

  if(isDefined(var_2) && var_2 && isDefined(var_3.passenger_2_turret_func))
    [[var_3.passenger_2_turret_func]](self, var_0, var_1, var_4);

  scripts\common\vehicle_code::set_turret_team(var_4);
  var_4 setdefaultdroppitch(0);
  wait 0.1;
  var_0 endon("_encstr_86C514ACDBB029813FFA3FDBF3165BCDBBC972BCFF60");
  level thread scripts\common\vehicle_code::vehicle_turret_difficulty(var_4, scripts\common\utility::getdifficulty());
  var_4 scripts\engine\utility::self_func("_encstr_B6011506E7FB511BC263883837EFB0AF430FF4807ED2E7", 1);
  var_5 = "_encstr_A5AD069B231F0BAF";

  if(isDefined(var_3.turretpos))
    var_5 = var_3.turretpos;

  var_0 scripts\engine\utility::script_func("_encstr_9B930BAE6E56FAA3D527E495D1", var_4, var_5);
}

guy_unlink_on_death(var_0) {
  var_0 endon("_encstr_B4350A0AAB73BA371120E5FC");
  var_0 waittill("_encstr_AD75063D571AE108");

  if(isDefined(var_0))
    var_0 unlink();
}

guy_blowup(var_0) {
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
    var_4 = var_4 + anglesToForward(var_3) * var_2.explosion_death_offset[0];
    var_4 = var_4 + anglestoright(var_3) * var_2.explosion_death_offset[1];
    var_4 = var_4 + anglestoup(var_3) * var_2.explosion_death_offset[2];
  }

  var_0 = convert_guy_to_drone(var_0);
  detach_models_with_substr(var_0, "_encstr_B2010820C5337B67C8CF");
  var_0 notsolid();
  var_0.origin = var_4;
  var_0.angles = var_3;
  var_0 animScripted("_encstr_9B080A912B851D43B0DC5AB5", var_4, var_3, var_2.explosion_death);
  var_5 = 0.3;

  if(isDefined(var_2.explosion_death_ragdollfraction))
    var_5 = var_2.explosion_death_ragdollfraction;

  var_6 = getanimlength(var_2.explosion_death);
  var_7 = gettime() + var_6 * 1000;
  wait(var_6 * var_5);
  var_8 = (0, 0, 1);
  var_9 = var_0.origin;

  if(getDvar("_encstr_85700B98396294A2966AA0B4A9") == "_encstr_934C0218") {
    var_0 delete();
    return;
  }

  if(isai(var_0))
    var_0 scripts\engine\utility::script_func("_encstr_8B1216E955C0D5EFA5D352AB99897B8EA81F6571C148DD97");
  else
    detach_models_with_substr(var_0, "_encstr_B2010820C5337B67C8CF");

  while(!var_0 isragdoll() && gettime() < var_7) {
    var_9 = var_0.origin;
    wait 0.05;
    var_8 = var_0.origin - var_9;

    if(isDefined(var_0.fnpreragdoll))
      var_0[[var_0.fnpreragdoll]]();

    var_0 startragdoll();
  }

  wait 0.05;
  var_8 = var_8 * 20000;

  for(var_10 = 0; var_10 < 3; var_10++) {
    if(isDefined(var_0))
      var_9 = var_0.origin;

    wait 0.05;
  }

  if(!var_0 isragdoll())
    var_0 delete();
}

#using_animtree("_encstr_B40101");

convert_guy_to_drone(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_2.angles = var_0.angles;
  var_2 setModel(var_0.model);
  var_3 = var_0 getattachsize();

  for(var_4 = 0; var_4 < var_3; var_4++)
    var_2 attach(var_0 getattachmodelname(var_4), var_0 getattachtagname(var_4));

  var_2 useanimtree(#animtree);

  if(isDefined(var_0.team))
    var_2.team = var_0.team;

  if(!var_1)
    var_0 delete();

  var_2 scripts\engine\utility::self_func("_encstr_85530B29C62A5359F127A870D7");
  return var_2;
}

vehicle_animate(var_0, var_1) {
  self useanimtree(var_1);
  self setanim(var_0);
}

vehicle_getinstart(var_0) {
  var_1 = anim_pos(self, var_0);
  return vehicle_getanimstart(var_1.getin, var_1.sittag, var_0, var_1.canshootinvehicle);
}

vehicle_getanimstart(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_5 = undefined;
  var_6 = undefined;
  var_7 = self gettagorigin(var_1);
  var_8 = self gettagangles(var_1);

  if(!getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F") || isDefined(var_0)) {
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

is_position_in_group(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    return 1;

  var_3 = var_0 scripts\common\vehicle_code::get_vehicle_classname();
  var_4 = level.vehicle.templates.unloadgroups[var_3][var_2];

  foreach(var_6 in var_4) {
    if(var_6 == var_1)
      return 1;
  }

  return 0;
}

get_availablepositions(var_0) {
  var_1 = level.vehicle.templates.aianims[scripts\common\vehicle_code::get_vehicle_classname()];
  var_2 = [];
  var_3 = [];

  for(var_4 = 0; var_4 < self.usedpositions.size; var_4++) {
    if(self.usedpositions[var_4]) {
      continue;
    }
    if((getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F") || isDefined(var_1[var_4].getin)) && is_position_in_group(self, var_4, var_0)) {
      var_2[var_2.size] = vehicle_getinstart(var_4);
      continue;
    }

    var_3[var_3.size] = var_4;
  }

  var_5 = spawnStruct();
  var_5.availablepositions = var_2;
  var_5.nonanimatedpositions = var_3;
  return var_5;
}

getanimatemodel() {
  if(isDefined(self.modeldummy))
    return self.modeldummy;
  else
    return self;
}

detach_models_with_substr(var_0, var_1) {
  var_2 = var_0 getattachsize();
  var_3 = [];
  var_4 = [];
  var_5 = 0;

  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_7 = var_0 getattachmodelname(var_6);
    var_8 = var_0 getattachtagname(var_6);

    if(issubstr(var_7, var_1)) {
      var_3[var_5] = var_7;
      var_4[var_5] = var_8;
    }
  }

  for(var_6 = 0; var_6 < var_3.size; var_6++)
    var_0 detach(var_3[var_6], var_4[var_6]);
}

should_give_orghealth() {
  if(!isai(self))
    return 0;

  if(!isDefined(self.orghealth))
    return 0;

  return !isDefined(self.magic_bullet_shield);
}

stable_unlink(var_0) {
  self waittill("_encstr_832912682391A131B209E4785A495B68F42F0830");

  if(isalive(var_0))
    var_0 unlink();
}

animate_guys(var_0) {
  var_1 = [];

  foreach(var_3 in self.riders) {
    if(isai(var_3) && !isalive(var_3)) {
      continue;
    }
    if(isDefined(level.vehicle.aianimcheck[var_0]) && ![[level.vehicle.aianimcheck[var_0]]](var_3, var_3.vehicle_position)) {
      continue;
    }
    if(isDefined(level.vehicle.aianimthread[var_0])) {
      var_3 notify("_encstr_815B08652FCB0FB0A195");
      thread[[level.vehicle.aianimthread[var_0]]](var_3, var_3.vehicle_position);
      var_1[var_1.size] = var_3;
      continue;
    }
  }

  return var_1;
}

guy_cleanup_vehiclevars() {
  self.vehicle_idling = undefined;
  self.standing = undefined;
  self.vehicle_position = undefined;
  self.delay = undefined;
}