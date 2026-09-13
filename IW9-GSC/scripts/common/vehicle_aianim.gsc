/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\vehicle_aianim.gsc
***********************************************/

guy_enter(guy, _id_5B0CAB0A9420DA60) {
  guy endon("death_or_disconnect");

  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(!isDefined(self.vehicletype)) {
    return;
  }
  classname = scripts\common\vehicle_code::get_vehicle_classname();
  _id_DE99D908F027883A = level.vehicle.templates.aianims[classname];
  self.attachedguys[self.attachedguys.size] = guy;
  pos = set_pos(guy, _id_DE99D908F027883A);

  if(!isDefined(pos)) {
    return;
  }
  if(pos == 0)
    guy.drivingvehicle = 1;

  _id_C458EDAC96D58B16 = anim_pos(self, pos);
  self.usedpositions[pos] = 1;
  guy.vehicle_position = pos;
  guy.vehicle_idling = 0;

  if(isDefined(_id_C458EDAC96D58B16.delay)) {
    guy.delay = _id_C458EDAC96D58B16.delay;

    if(isDefined(_id_C458EDAC96D58B16.delayinc))
      self.delayer = guy.delay;
  }

  if(isDefined(_id_C458EDAC96D58B16.delayinc)) {
    self.delayer = self.delayer + _id_C458EDAC96D58B16.delayinc;
    guy.delay = self.delayer;
  }

  guy.ridingvehicle = self;
  guy.orghealth = guy.health;
  guy.vehicle_idle = _id_C458EDAC96D58B16.idle;
  guy.vehicle_standattack = _id_C458EDAC96D58B16.standattack;

  if(!getdvarint("dvar_9403D7D31FC1D981")) {
    guy.deathanim = _id_C458EDAC96D58B16.death;
    guy.deathanimscript = _id_C458EDAC96D58B16.deathscript;
  }

  guy.standing = 0;
  guy.allowdeath = 1;

  if(!getdvarint("dvar_9403D7D31FC1D981")) {
    if(isDefined(guy.deathanim) && !isDefined(guy.magic_bullet_shield) && vehicle_allows_rider_death()) {
      if(guy.vehicle_position != 0 || vehicle_allows_driver_death()) {
        guy.allowdeath = !isDefined(guy.script_allowdeath) || guy.script_allowdeath;

        if(isDefined(_id_C458EDAC96D58B16.death_no_ragdoll))
          guy.noragdoll = _id_C458EDAC96D58B16.death_no_ragdoll;
      }
    }
  } else if(!isDefined(guy.magic_bullet_shield) && vehicle_allows_rider_death()) {
    guy.allowdeath = !isDefined(guy.script_allowdeath) || guy.script_allowdeath;

    if(isDefined(_id_C458EDAC96D58B16.death_no_ragdoll))
      guy.noragdoll = _id_C458EDAC96D58B16.death_no_ragdoll;
  }

  if(!isDefined(guy.classname)) {
    return;
  }
  if(guy.classname == "script_model") {
    if(isDefined(_id_C458EDAC96D58B16.death) && guy.allowdeath && (!isDefined(guy.script_allowdeath) || guy.script_allowdeath))
      thread guy_death(guy, _id_C458EDAC96D58B16);
  }

  self.riders[self.riders.size] = guy;

  if(guy.classname != "script_model" && scripts\common\ai::spawn_failed(guy)) {
    return;
  }
  org = self gettagorigin(_id_C458EDAC96D58B16.sittag);
  angles = self gettagangles(_id_C458EDAC96D58B16.sittag);

  if(!getdvarint("dvar_9403D7D31FC1D981"))
    link_to_sittag(guy, _id_C458EDAC96D58B16.sittag, _id_C458EDAC96D58B16.sittag_origin_offset, _id_C458EDAC96D58B16.sittag_angles_offset, _id_C458EDAC96D58B16.linktoblend);
  else if(guy.classname != "script_model" && !guy scripts\vehicle\vehicle_common::hasvehicle()) {
    _id_D8D5168B7EC53597 = vehicle_getinstart(pos);
    guy scripts\vehicle\vehicle_common::entervehicle(self, 1, _id_D8D5168B7EC53597, _id_C458EDAC96D58B16);
  }

  if(isai(guy)) {
    if(!getdvarint("dvar_9403D7D31FC1D981"))
      guy forceteleport(org, angles);

    if(isDefined(_id_C458EDAC96D58B16.bhasgunwhileriding) && !_id_C458EDAC96D58B16.bhasgunwhileriding)
      guy scripts\common\ai::gun_remove();

    if(guy_should_man_turret(_id_C458EDAC96D58B16))
      thread guy_man_turret(guy, pos, _id_5B0CAB0A9420DA60);
  } else {
    if(isDefined(_id_C458EDAC96D58B16.bhasgunwhileriding) && !_id_C458EDAC96D58B16.bhasgunwhileriding)
      detach_models_with_substr(guy, "weapon_");

    guy.origin = org;
    guy.angles = angles;
  }

  if(pos == 0) {
    self.driver = guy;

    if(getdvarint("dvar_9403D7D31FC1D981") || isDefined(_id_DE99D908F027883A[0].death))
      thread driverdead(guy);
  }

  self notify("guy_entered", guy, pos);
  guy notify("loaded");
  scripts\engine\utility::ent_flag_clear("unloaded");
  thread guy_handle(guy, pos);

  if(isDefined(_id_C458EDAC96D58B16.rider_func)) {
    guy[[_id_C458EDAC96D58B16.rider_func]]();
    return;
  }

  if(!getdvarint("dvar_9403D7D31FC1D981")) {
    if(isDefined(_id_C458EDAC96D58B16.getin_idle_func))
      thread[[_id_C458EDAC96D58B16.getin_idle_func]](guy, pos);
    else
      thread guy_idle(guy, pos);
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

guy_should_man_turret(_id_C458EDAC96D58B16) {
  if(!isDefined(_id_C458EDAC96D58B16.mgturret))
    return 0;

  if(!isDefined(self.script_nomg))
    return 1;

  return !self.script_nomg;
}

handle_attached_guys() {
  classname = scripts\common\vehicle_code::get_vehicle_classname();
  self.attachedguys = [];

  if(!(isDefined(level.vehicle.templates.aianims) && isDefined(level.vehicle.templates.aianims[classname]))) {
    return;
  }
  _id_D686C2BF0F2C7E39 = level.vehicle.templates.aianims[classname].size;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "ai_wait_go")
    thread ai_wait_go();

  self.runningtovehicle = [];
  self.usedpositions = [];
  self.getinorgs = [];
  self.delayer = 0;
  _id_DE99D908F027883A = level.vehicle.templates.aianims[classname];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D686C2BF0F2C7E39; _id_AC0E594AC96AA3A8++) {
    self.usedpositions[_id_AC0E594AC96AA3A8] = 0;

    if(isDefined(self.script_nomg) && self.script_nomg && isDefined(_id_DE99D908F027883A[_id_AC0E594AC96AA3A8].bisgunner) && _id_DE99D908F027883A[_id_AC0E594AC96AA3A8].bisgunner)
      self.usedpositions[1] = 1;
  }
}

load_ai_goddriver(array) {
  load_ai(array, 1);
}

guy_death(guy, _id_C458EDAC96D58B16) {
  waittillframeend;
  guy setCanDamage(1);
  guy endon("death");
  guy.allowdeath = 0;
  guy.health = 10150;

  if(isDefined(guy.script_startinghealth))
    guy.health = guy.health + guy.script_startinghealth;

  guy endon("jumping_out");

  if(isDefined(guy.magic_bullet_shield) && guy.magic_bullet_shield) {
    while(isDefined(guy.magic_bullet_shield) && guy.magic_bullet_shield)
      wait 0.05;
  }

  while(guy.health > 10000)
    guy waittill("damage");

  thread guy_deathimate_me(guy, _id_C458EDAC96D58B16);
}

guy_deathimate_me(guy, _id_C458EDAC96D58B16) {
  _id_EE7B04B3C11DFFED = gettime() + getanimlength(_id_C458EDAC96D58B16.death) * 1000;
  angles = guy.angles;
  origin = guy.origin;
  guy = convert_guy_to_drone(guy);
  detach_models_with_substr(guy, "weapon_");
  guy linkTo(self);
  guy notsolid();
  guy setanim(_id_C458EDAC96D58B16.death);

  if(isai(guy))
    guy scripts\engine\utility::script_func("anim_dropallaiweapons");
  else
    detach_models_with_substr(guy, "weapon_");

  if(isDefined(_id_C458EDAC96D58B16.death_delayed_ragdoll)) {
    guy unlink();

    if(isDefined(guy.fnpreragdoll))
      guy[[guy.fnpreragdoll]]();

    guy startragdoll();
    wait(_id_C458EDAC96D58B16.death_delayed_ragdoll);
    guy delete();
    return;
  }
}

load_ai(array, _id_2D4646DCBB00A733, group) {
  self endon("death");

  if(array.size) {
    if(!isDefined(_id_2D4646DCBB00A733))
      _id_2D4646DCBB00A733 = 0;

    scripts\engine\utility::ent_flag_clear("unloaded");
    scripts\engine\utility::ent_flag_clear("loaded");
    scripts\engine\utility::array_levelthread(array, ::get_in_vehicle, _id_2D4646DCBB00A733, group);
    scripts\engine\utility::array_wait(array, "loaded");
  }

  scripts\engine\utility::ent_flag_set("loaded");
}

is_rider(guy) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.riders.size; _id_AC0E594AC96AA3A8++) {
    if(self.riders[_id_AC0E594AC96AA3A8] == guy)
      return 1;
  }

  return 0;
}

get_in_vehicle(guy, _id_2D4646DCBB00A733, group) {
  if(is_rider(guy)) {
    return;
  }
  if(!handle_detached_guys_check()) {
    return;
  }
  guy_runtovehicle(guy, self, _id_2D4646DCBB00A733, group);
}

handle_detached_guys_check() {
  if(vehicle_hasavailablespots())
    return 1;

  if(!scripts\common\utility::issp())
    classname = self.classname_mp;
  else
    classname = self.class;
}

vehicle_hasavailablespots() {
  if(level.vehicle.templates.aianims[scripts\common\vehicle_code::get_vehicle_classname()].size - self.runningtovehicle.size)
    return 1;
  else
    return 0;
}

guy_runtovehicle_loaded(guy, vehicle) {
  vehicle endon("death");
  vehicle endon("stop_loading");

  if(!getdvarint("dvar_9403D7D31FC1D981")) {
    msg = guy scripts\engine\utility::waittill_any_return_3("long_death", "death", "enteredvehicle");

    if(msg != "enteredvehicle" && isDefined(guy.forced_startingposition))
      vehicle.usedpositions[guy.forced_startingposition] = 0;
  } else if(!guy scripts\vehicle\vehicle_common::waitforentervehicle() && isDefined(guy.forced_startingposition))
    vehicle.usedpositions[guy.forced_startingposition] = 0;

  vehicle.runningtovehicle = scripts\engine\utility::array_remove(vehicle.runningtovehicle, guy);
  vehicle_loaded_if_full(vehicle);
}

vehicle_loaded_if_full(vehicle) {
  if(isDefined(vehicle.vehicletype) && isDefined(vehicle.vehicle_loaded_notify_size)) {
    if(vehicle.riders.size == vehicle.vehicle_loaded_notify_size)
      vehicle scripts\engine\utility::ent_flag_set("loaded");
  } else if(!vehicle.runningtovehicle.size && vehicle.riders.size) {
    if(vehicle.usedpositions[0])
      vehicle scripts\engine\utility::ent_flag_set("loaded");
    else if(!getdvarint("dvar_9403D7D31FC1D981"))
      vehicle thread vehicle_reload();
  }
}

vehicle_reload() {
  riders = self.riders;
  scripts\common\vehicle::vehicle_unload();
  scripts\engine\utility::ent_flag_wait("unloaded");
  riders = scripts\engine\utility::array_removedead(riders);
  thread scripts\common\vehicle::vehicle_load_ai(riders);
}

remove_magic_bullet_shield_from_guy_on_unload_or_death(guy) {
  scripts\engine\utility::waittill_any_2("unload", "death");
  guy scripts\common\ai::stop_magic_bullet_shield();
}

choose_vehicle_position(guy, _id_287A5461F98150E9, _id_2D4646DCBB00A733) {
  guy endon("stop_loading");
  self endon("stop_loading");

  if(!isDefined(_id_2D4646DCBB00A733))
    _id_2D4646DCBB00A733 = 0;

  _id_D0D2BB8C350E1F6B = undefined;
  origin = 0;

  if(isDefined(guy.script_startingposition))
    _id_D0D2BB8C350E1F6B = vehicle_getinstart(guy.script_startingposition);
  else if(!self.usedpositions[0]) {
    _id_D0D2BB8C350E1F6B = vehicle_getinstart(0);

    if(_id_2D4646DCBB00A733) {
      guy thread scripts\common\ai::magic_bullet_shield();
      thread remove_magic_bullet_shield_from_guy_on_unload_or_death(guy);
    }
  } else if(_id_287A5461F98150E9.availablepositions.size)
    _id_D0D2BB8C350E1F6B = scripts\engine\utility::getclosest(guy.origin, _id_287A5461F98150E9.availablepositions);
  else
    _id_D0D2BB8C350E1F6B = undefined;

  return _id_D0D2BB8C350E1F6B;
}

guy_runtovehicle(guy, vehicle, _id_2D4646DCBB00A733, group) {
  guy endon("stop_loading");
  vehicle endon("stop_loading");
  _id_5B0CAB0A9420DA60 = 1;

  if(!isDefined(_id_2D4646DCBB00A733))
    _id_2D4646DCBB00A733 = 0;

  _id_DE99D908F027883A = level.vehicle.templates.aianims[vehicle scripts\common\vehicle_code::get_vehicle_classname()];

  if(isDefined(vehicle.runtovehicleoverride)) {
    vehicle thread[[vehicle.runtovehicleoverride]](guy);
    return;
  }

  vehicle endon("death");
  guy endon("death");
  vehicle.runningtovehicle[vehicle.runningtovehicle.size] = guy;
  thread guy_runtovehicle_loaded(guy, vehicle);
  availablepositions = [];
  _id_D0D2BB8C350E1F6B = undefined;
  origin = 0;
  _id_F15089151C320C06 = getdvarint("dvar_9403D7D31FC1D981");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_DE99D908F027883A.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(_id_DE99D908F027883A[_id_AC0E594AC96AA3A8].getin))
      _id_F15089151C320C06 = 1;
  }

  if(!_id_F15089151C320C06) {
    guy notify("enteredvehicle");

    if(getdvarint("dvar_9403D7D31FC1D981")) {
      _id_D0D2BB8C350E1F6B = choose_vehicle_position(guy, get_availablepositions(group), _id_2D4646DCBB00A733);
      guy.forced_startingposition = _id_D0D2BB8C350E1F6B.vehicle_position;
      vehicle.usedpositions[_id_D0D2BB8C350E1F6B.vehicle_position] = 1;
      guy scripts\vehicle\vehicle_common::entervehicle(self, 1, _id_D0D2BB8C350E1F6B, anim_pos(self, guy.forced_startingposition));
    }

    vehicle guy_enter(guy, _id_5B0CAB0A9420DA60);
    return;
  }

  if(!isDefined(guy.get_in_moving_vehicle)) {
    while(vehicle vehicle_getspeed() > 1)
      wait 0.05;
  }

  _id_E4B7E99A96C8829F = vehicle get_availablepositions(group);

  if(!_id_E4B7E99A96C8829F.availablepositions.size && _id_E4B7E99A96C8829F.nonanimatedpositions.size) {
    guy notify("enteredvehicle");
    vehicle guy_enter(guy, _id_5B0CAB0A9420DA60);
    return;
  }

  _id_D0D2BB8C350E1F6B = choose_vehicle_position(guy, _id_E4B7E99A96C8829F, _id_2D4646DCBB00A733);

  if(!isDefined(_id_D0D2BB8C350E1F6B)) {
    return;
  }
  origin = _id_D0D2BB8C350E1F6B.origin;
  angles = _id_D0D2BB8C350E1F6B.angles;
  guy.forced_startingposition = _id_D0D2BB8C350E1F6B.vehicle_position;
  vehicle.usedpositions[_id_D0D2BB8C350E1F6B.vehicle_position] = 1;

  if(!getdvarint("dvar_9403D7D31FC1D981")) {
    guy.script_moveoverride = 1;
    guy notify("stop_going_to_node");
    guy scripts\common\ai::set_forcegoal();
    guy scripts\common\ai::disable_arrivals();
    guy.goalradius = 64;
    guy setgoalpos(origin);
    guy waittill("goal");
    guy scripts\common\ai::enable_arrivals();
    guy scripts\common\ai::unset_forcegoal();
    guy notify("boarding_vehicle");
  } else {
    guy scripts\vehicle\vehicle_common::requestentervehicle(self, 0, _id_D0D2BB8C350E1F6B, anim_pos(self, _id_D0D2BB8C350E1F6B.vehicle_position));
    guy scripts\vehicle\vehicle_common::waitforarrivedatvehicle();
  }

  _id_C458EDAC96D58B16 = anim_pos(vehicle, _id_D0D2BB8C350E1F6B.vehicle_position);

  if(isDefined(_id_C458EDAC96D58B16.delay)) {
    guy.delay = _id_C458EDAC96D58B16.delay;

    if(isDefined(_id_C458EDAC96D58B16.delayinc))
      self.delayer = guy.delay;
  }

  if(isDefined(_id_C458EDAC96D58B16.delayinc)) {
    self.delayer = self.delayer + _id_C458EDAC96D58B16.delayinc;
    guy.delay = self.delayer;
  }

  if(!getdvarint("dvar_9403D7D31FC1D981"))
    vehicle link_to_sittag(guy, _id_C458EDAC96D58B16.sittag, _id_C458EDAC96D58B16.sittag_origin_offset, _id_C458EDAC96D58B16.sittag_angles_offset, _id_C458EDAC96D58B16.linktoblend);

  guy.allowdeath = 0;
  _id_C458EDAC96D58B16 = _id_DE99D908F027883A[_id_D0D2BB8C350E1F6B.vehicle_position];

  if(isDefined(_id_D0D2BB8C350E1F6B)) {
    if(isDefined(_id_C458EDAC96D58B16.vehicle_getinanim)) {
      _id_B92DE7D48A424C1C = isDefined(guy.no_vehicle_getoutanim);

      if(!_id_B92DE7D48A424C1C && !isagent(guy)) {
        if(isDefined(_id_C458EDAC96D58B16.vehicle_getoutanim))
          vehicle clearanim(_id_C458EDAC96D58B16.vehicle_getoutanim, 0);

        if(isDefined(_id_C458EDAC96D58B16.vehicle_getoutanim_combat))
          vehicle clearanim(_id_C458EDAC96D58B16.vehicle_getoutanim_combat, 0);

        if(isDefined(_id_C458EDAC96D58B16.vehicle_getoutanim_combat_run))
          vehicle clearanim(_id_C458EDAC96D58B16.vehicle_getoutanim_combat_run, 0);
      }

      vehicle = vehicle getanimatemodel();
      vehicle thread setanimrestart_once(_id_C458EDAC96D58B16.vehicle_getinanim, _id_C458EDAC96D58B16.vehicle_getinanim_clear);
      vehicle thread scripts\common\notetrack::start_notetrack_wait(vehicle, "vehicle_anim_flag", undefined, undefined, _id_C458EDAC96D58B16.vehicle_getinanim);
    }

    if(isDefined(_id_C458EDAC96D58B16.vehicle_getinsoundtag))
      origin = vehicle gettagorigin(_id_C458EDAC96D58B16.vehicle_getinsoundtag);
    else
      origin = vehicle.origin;

    if(isDefined(_id_C458EDAC96D58B16.vehicle_getinsound))
      playworldsound(_id_C458EDAC96D58B16.vehicle_getinsound, origin);

    _id_499E24A61E1E6679 = undefined;
    _id_DCBA226DB1794B09 = undefined;

    if(isDefined(_id_C458EDAC96D58B16.getin_enteredvehicletrack)) {
      _id_499E24A61E1E6679 = [];
      _id_499E24A61E1E6679[0] = _id_C458EDAC96D58B16.getin_enteredvehicletrack;
      _id_DCBA226DB1794B09 = [];
      _id_DCBA226DB1794B09[0] = ::entered_vehicle_notify;
      vehicle link_to_sittag(guy, _id_C458EDAC96D58B16.sittag, _id_C458EDAC96D58B16.sittag_origin_offset, _id_C458EDAC96D58B16.sittag_angles_offset, _id_C458EDAC96D58B16.linktoblend);
    }

    if(!getdvarint("dvar_9403D7D31FC1D981"))
      vehicle animontag(guy, _id_C458EDAC96D58B16.sittag, _id_C458EDAC96D58B16.getin, _id_499E24A61E1E6679, _id_DCBA226DB1794B09, undefined, _id_C458EDAC96D58B16.sittag_origin_offset, _id_C458EDAC96D58B16.sittag_angles_offset);
  }

  if(getdvarint("dvar_9403D7D31FC1D981"))
    guy scripts\vehicle\vehicle_common::waitforentervehicle();

  guy notify("enteredvehicle");
  vehicle guy_enter(guy, _id_5B0CAB0A9420DA60);
}

entered_vehicle_notify() {
  self notify("enteredvehicle");
}

driverdead(guy) {
  if(scripts\common\vehicle::ishelicopter()) {
    return;
  }
  self.driver = guy;
  self endon("death");
  guy endon("jumping_out");
  guy waittill("death");

  if(getdvarint("dvar_BD29C0DB2CF41967", 0) == 1) {
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

  if(!istrue(self.donotunloadondriverdeath))
    scripts\common\vehicle::vehicle_unload();
}

guy_becomes_real_ai(guy, pos) {
  if(isai(guy))
    return guy;

  if(istrue(guy.drone_delete_on_unload))
    guy delete();
  else {
    guy = scripts\engine\utility::script_func("spawner_makerealai", guy);

    if(scripts\common\utility::issp())
      classname = self.classname;
    else
      classname = self.classname_mp;

    _id_D686C2BF0F2C7E39 = level.vehicle.templates.aianims[classname].size;
    _id_C458EDAC96D58B16 = anim_pos(self, pos);
    link_to_sittag(guy, _id_C458EDAC96D58B16.sittag, _id_C458EDAC96D58B16.sittag_origin_offset, _id_C458EDAC96D58B16.sittag_angles_offset, _id_C458EDAC96D58B16.linktoblend);
    guy.vehicle_idle = _id_C458EDAC96D58B16.idle;

    if(!istrue(guy.disable_vehicle_idle))
      thread guy_idle(guy, pos);
  }
}

link_to_sittag(guy, tag, origin_offset, angles_offset, linktoblend) {
  if(!isDefined(origin_offset))
    origin_offset = (0, 0, 0);

  if(!isDefined(angles_offset))
    angles_offset = (0, 0, 0);

  if(!isDefined(linktoblend))
    linktoblend = 0;

  if(linktoblend && !isDefined(guy.script_drone))
    guy linktoblendtotag(self, tag, 0);
  else
    guy linkTo(self, tag, origin_offset, angles_offset);
}

anim_pos(vehicle, pos) {
  return level.vehicle.templates.aianims[vehicle scripts\common\vehicle_code::get_vehicle_classname()][pos];
}

guy_deathhandle(guy, pos) {
  guy waittill("death");

  if(!isDefined(self)) {
    return;
  }
  self.riders = scripts\engine\utility::array_remove(self.riders, guy);
  self.usedpositions[pos] = 0;
}

setup_aianimthreads() {
  if(!isDefined(level.vehicle.aianimthread))
    level.vehicle.aianimthread = [];

  if(!isDefined(level.vehicle.aianimcheck))
    level.vehicle.aianimcheck = [];

  level.vehicle.aianimthread["idle"] = ::guy_idle;
  level.vehicle.aianimthread["unload"] = ::guy_unload;
}

guy_handle(guy, pos) {
  guy.vehicle_idling = 1;
  thread guy_deathhandle(guy, pos);
}

driver_idle_speed(driver, pos) {
  driver endon("newanim");
  self endon("death");
  driver endon("death");
  _id_C458EDAC96D58B16 = anim_pos(self, pos);

  for(;;) {
    if(self vehicle_getspeed() == 0)
      driver.vehicle_idle = _id_C458EDAC96D58B16.idle_animstop;
    else
      driver.vehicle_idle = _id_C458EDAC96D58B16.idle_anim;

    wait 0.25;
  }
}

guy_idle(guy, pos, _id_A6AE0590DDFEAF03) {
  guy endon("newanim");

  if(!isDefined(_id_A6AE0590DDFEAF03))
    self endon("death");

  guy endon("death");
  guy.vehicle_idling = 1;
  guy notify("gotime");

  if(!isDefined(guy.vehicle_idle)) {
    return;
  }
  _id_C458EDAC96D58B16 = anim_pos(self, pos);

  if(isDefined(_id_C458EDAC96D58B16.mgturret)) {
    return;
  }
  if(isDefined(_id_C458EDAC96D58B16.idle_animstop) && isDefined(_id_C458EDAC96D58B16.idle_anim))
    thread driver_idle_speed(guy, pos);

  for(;;) {
    guy notify("idle");
    play_new_idle(guy, _id_C458EDAC96D58B16);
  }
}

play_new_idle(guy, _id_C458EDAC96D58B16) {
  if(isDefined(guy.vehicle_idle_override)) {
    animontag(guy, _id_C458EDAC96D58B16.sittag, guy.vehicle_idle_override, undefined, undefined, undefined, _id_C458EDAC96D58B16.sittag_origin_offset, _id_C458EDAC96D58B16.sittag_angles_offset);
    return;
  }

  if(isDefined(_id_C458EDAC96D58B16.idleoccurrence)) {
    _id_64885102A4A4C1F5 = randomoccurrance(guy, _id_C458EDAC96D58B16.idleoccurrence);
    animontag(guy, _id_C458EDAC96D58B16.sittag, guy.vehicle_idle[_id_64885102A4A4C1F5], undefined, undefined, undefined, _id_C458EDAC96D58B16.sittag_origin_offset, _id_C458EDAC96D58B16.sittag_angles_offset);
    return;
  }

  if(isDefined(guy.playerpiggyback) && isDefined(_id_C458EDAC96D58B16.player_idle)) {
    animontag(guy, _id_C458EDAC96D58B16.sittag, _id_C458EDAC96D58B16.player_idle, undefined, undefined, undefined, _id_C458EDAC96D58B16.sittag_origin_offset, _id_C458EDAC96D58B16.sittag_angles_offset);
    return;
  }

  if(isDefined(_id_C458EDAC96D58B16.vehicle_idle))
    thread setanimrestart_once(_id_C458EDAC96D58B16.vehicle_idle);

  animontag(guy, _id_C458EDAC96D58B16.sittag, guy.vehicle_idle, undefined, undefined, undefined, _id_C458EDAC96D58B16.sittag_origin_offset, _id_C458EDAC96D58B16.sittag_angles_offset);
}

randomoccurrance(guy, _id_E98CD170A6D8296D) {
  range = [];
  _id_C32808289F6A7CC0 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_E98CD170A6D8296D.size; _id_AC0E594AC96AA3A8++) {
    _id_C32808289F6A7CC0 = _id_C32808289F6A7CC0 + _id_E98CD170A6D8296D[_id_AC0E594AC96AA3A8];
    range[_id_AC0E594AC96AA3A8] = _id_C32808289F6A7CC0;
  }

  _id_3EC07B9F2F28C414 = randomint(_id_C32808289F6A7CC0);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_E98CD170A6D8296D.size; _id_AC0E594AC96AA3A8++) {
    if(_id_3EC07B9F2F28C414 < range[_id_AC0E594AC96AA3A8])
      return _id_AC0E594AC96AA3A8;
  }
}

_id_B4600DF9B9F46F3D(guy) {
  self endon("death");
  wait 50;

  if(isDefined(guy) && scripts\engine\utility::array_contains(self.unloadque, guy)) {
    self.unloadque = scripts\engine\utility::array_remove(self.unloadque, guy);

    if(!self.unloadque.size) {
      scripts\engine\utility::ent_flag_set("unloaded");
      self.unload_group = "default";
      self _meth_75FEDA26550D4F0E();
    }

    guy notify("jumpedout");
  }
}

guy_unload_que(guy) {
  self endon("death");
  self.unloadque = scripts\engine\utility::array_add(self.unloadque, guy);
  guy scripts\engine\utility::waittill_any_2("death", "jumpedout");
  self.unloadque = scripts\engine\utility::array_remove(self.unloadque, guy);

  if(!self.unloadque.size) {
    scripts\engine\utility::ent_flag_set("unloaded");
    self.unload_group = "default";
    self _meth_75FEDA26550D4F0E();
  }
}

riders_unloadable(unload_group) {
  if(!self.riders.size)
    return 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.riders.size; _id_AC0E594AC96AA3A8++) {
    if(!isalive(self.riders[_id_AC0E594AC96AA3A8]) && !isDefined(self.riders[_id_AC0E594AC96AA3A8].isvehicle)) {
      continue;
    }
    if(!isDefined(self.riders[_id_AC0E594AC96AA3A8].vehicle_position)) {
      continue;
    }
    if(check_unloadgroup(self.riders[_id_AC0E594AC96AA3A8].vehicle_position, unload_group))
      return 1;
  }

  return 0;
}

get_unload_group() {
  group = [];
  unloadgroups = [];
  unload_group = "default";

  if(isDefined(self.unload_group))
    unload_group = self.unload_group;

  unloadgroups = level.vehicle.templates.unloadgroups[scripts\common\vehicle_code::get_vehicle_classname()][unload_group];

  if(!isDefined(unloadgroups))
    unloadgroups = level.vehicle.templates.unloadgroups[scripts\common\vehicle_code::get_vehicle_classname()]["default"];

  foreach(pos in unloadgroups)
  group[pos] = pos;

  return group;
}

check_unloadgroup(pos, unload_group) {
  if(!isDefined(unload_group))
    unload_group = self.unload_group;

  classname = scripts\common\vehicle_code::get_vehicle_classname();

  if(!isDefined(level.vehicle.templates.unloadgroups[classname]))
    return 1;

  if(!isDefined(level.vehicle.templates.unloadgroups[classname][unload_group]))
    return 1;

  group = level.vehicle.templates.unloadgroups[classname][unload_group];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < group.size; _id_AC0E594AC96AA3A8++) {
    if(pos == group[_id_AC0E594AC96AA3A8])
      return 1;
  }

  return 0;
}

getoutrig_model_idle(model, tag, animation) {
  self endon("unloading");

  for(;;)
    animontag(model, tag, animation);
}

getoutrig_model(_id_C458EDAC96D58B16, model, tag, animation, _id_EC8A68BDE7AC6A73) {
  classname = scripts\common\vehicle_code::get_vehicle_classname();

  if(_id_EC8A68BDE7AC6A73) {
    thread getoutrig_model_idle(model, tag, level.vehicle.templates.attachedmodels[classname][_id_C458EDAC96D58B16.fastroperig].idleanim);
    self waittill("unloading");
  }

  self.unloadque = scripts\engine\utility::array_add(self.unloadque, model);
  thread getoutrig_abort(model, tag, animation);

  if(!scripts\common\vehicle_code::vehicle_iscrashing())
    animontag(model, tag, animation);

  model unlink();

  if(!isDefined(self)) {
    model delete();
    return;
  }

  self.unloadque = scripts\engine\utility::array_remove(self.unloadque, model);

  if(!self.unloadque.size)
    self notify("unloaded");

  self.fastroperig[_id_C458EDAC96D58B16.fastroperig] = undefined;
  wait 10;
  model delete();
}

getoutrig_model_new(_id_C458EDAC96D58B16, model, tag, animation, _id_EC8A68BDE7AC6A73) {
  self endon("death");
  classname = scripts\common\vehicle_code::get_vehicle_classname();
  thread scripts\engine\utility::delete_on_death(model);
  origin = self gettagorigin(tag);
  angles = self gettagangles(tag);
  xanim = level.vehicle.templates.attachedmodels[classname][_id_C458EDAC96D58B16.fastroperig].idleanim;
  _id_D917428537562C1F = getstartorigin(origin, angles, xanim);
  startangles = getstartangles(origin, angles, xanim);
  startangles = self.angles;
  tagorigin = model gettagorigin("j_rope_1", 1);

  if(!isDefined(tagorigin))
    tagorigin = self.origin;

  tagoffset = tagorigin - self.origin;

  if(_id_EC8A68BDE7AC6A73) {
    model.origin = _id_D917428537562C1F;
    model.angles = startangles;
    thread scripts\engine\utility::script_func("fastrope_anim", model, xanim, "getoutrigidle");
    scripts\engine\utility::ent_flag_wait("unloaded");
  }

  origin = self gettagorigin(tag);
  angles = self gettagangles(tag);

  if(istrue(self._id_7B349DC60A25D9FE)) {
    _id_D2DC14A7732E42DB = origin;
    thread getoutrig_abort(model, undefined, animation, _id_D2DC14A7732E42DB);

    if(!scripts\common\vehicle_code::vehicle_iscrashing()) {
      model unlink();
      model.origin = origin;
      model.angles = angles;
      thread scripts\engine\utility::script_func("fastrope_anim", model, animation, "getoutrigfall");
    }
  } else {
    _id_4CF543314C134490 = self.angles - startangles;
    _id_4CF543314C134490 = (angleclamp(_id_4CF543314C134490[0]), angleclamp(_id_4CF543314C134490[1]), angleclamp(_id_4CF543314C134490[2]));
    _id_32EDCDCF986B48C4 = rotatevector(tagoffset, _id_4CF543314C134490) + self.origin;
    results = scripts\engine\trace::ray_trace(_id_32EDCDCF986B48C4, _id_32EDCDCF986B48C4 - (0, 0, 1000), self, scripts\engine\trace::create_world_contents());
    _id_C995307DAADDA4FE = _id_32EDCDCF986B48C4[2] - 400;

    if(isDefined(results["position"]))
      _id_C995307DAADDA4FE = results["position"][2];

    _id_D2DC14A7732E42DB = (origin[0], origin[1], _id_C995307DAADDA4FE);

    if(istrue(level.vehicle.templates.attachedmodels[classname][_id_C458EDAC96D58B16.fastroperig].dropusestraceorigin))
      _id_D2DC14A7732E42DB = (_id_32EDCDCF986B48C4[0], _id_32EDCDCF986B48C4[1], _id_C995307DAADDA4FE);

    thread getoutrig_abort(model, undefined, animation, _id_D2DC14A7732E42DB);

    if(!scripts\common\vehicle_code::vehicle_iscrashing()) {
      model unlink();
      model.origin = _id_D2DC14A7732E42DB;
      thread scripts\engine\utility::script_func("fastrope_anim", model, animation, "getoutrigfall");
    }
  }

  self.fastroperig[_id_C458EDAC96D58B16.fastroperig] = undefined;
  wait 10;
  model delete();
}

getoutrig_disable_abort_notify_after_riders_out() {
  wait 0.05;

  while(isalive(self) && self.unloadque.size > 2)
    wait 0.05;

  if(!isalive(self) || scripts\common\vehicle_code::vehicle_iscrashing()) {
    return;
  }
  self notify("getoutrig_disable_abort");
}

getoutrig_abort_while_deploying() {
  self endon("end_getoutrig_abort_while_deploying");

  while(!scripts\common\vehicle_code::vehicle_iscrashing())
    wait 0.05;

  _id_9E36434DB96CF25D = [];

  foreach(rider in self.riders) {
    if(isalive(rider))
      scripts\engine\utility::array_add_safe(_id_9E36434DB96CF25D, rider);
  }

  scripts\engine\utility::array_delete(_id_9E36434DB96CF25D);
  self notify("crashed_while_deploying");
  _id_9E36434DB96CF25D = undefined;
}

getoutrig_abort(model, tag, animation, _id_D2DC14A7732E42DB) {
  _id_1B711D7D9977B93D = getanimlength(animation);
  _id_EC4312F917FCFBF3 = _id_1B711D7D9977B93D - 1.0;

  if(self.vehicletype == "mi17")
    _id_EC4312F917FCFBF3 = _id_1B711D7D9977B93D - 0.5;

  _id_22A98BC45239B860 = 0.8;
  self endon("getoutrig_disable_abort");
  thread getoutrig_disable_abort_notify_after_riders_out();
  thread getoutrig_abort_while_deploying();
  scripts\engine\utility::waittill_notify_or_timeout("crashed_while_deploying", _id_22A98BC45239B860);
  self notify("end_getoutrig_abort_while_deploying");

  while(!isDefined(self.vehiclecrashing))
    waitframe();

  if(isDefined(model)) {
    if(!isDefined(tag) && isDefined(_id_D2DC14A7732E42DB)) {
      model unlink();
      model.origin = _id_D2DC14A7732E42DB;

      if(!scripts\common\utility::issp()) {
        animindex = model scripts\asm\asm::asm_lookupanimfromalias("animscripted", animation);
        xanim = model scripts\asm\asm::asm_getxanim("animscripted", animindex);
        _id_D917428537562C1F = getstartorigin(self.origin, self.angles, xanim);
        startangles = getstartangles(self.origin, self.angles, xanim);
        model dontinterpolate();
        model forceteleport(_id_D917428537562C1F, startangles);
        model animmode("nogravity");
        model aisetanim("animscripted", animindex);
      } else
        model animScripted("getoutrigfall", model.origin, model.angles, animation, undefined, undefined, 0);
    } else
      thread animontag(model, tag, animation);

    waittillframeend;
    model setanimtime(animation, _id_EC4312F917FCFBF3 / _id_1B711D7D9977B93D);
  }

  attacker = self;

  if(isDefined(self.original_attacker))
    attacker = self.original_attacker;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.riders.size; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(self.riders[_id_AC0E594AC96AA3A8])) {
      continue;
    }
    if(!isDefined(self.riders[_id_AC0E594AC96AA3A8].ragdoll_getout_death)) {
      continue;
    }
    if(self.riders[_id_AC0E594AC96AA3A8].ragdoll_getout_death != 1) {
      continue;
    }
    if(!isDefined(self.riders[_id_AC0E594AC96AA3A8].ridingvehicle)) {
      continue;
    }
    self.riders[_id_AC0E594AC96AA3A8].forcefallthroughonropes = 1;

    if(isalive(self.riders[_id_AC0E594AC96AA3A8]))
      thread animontag_ragdoll_death_fall(self.riders[_id_AC0E594AC96AA3A8], self, attacker);
  }
}

setanimrestart_once(_id_93EECC7204143FA9, _id_D393E2740E2AF547) {
  self endon("death");
  self endon("dont_clear_anim");

  if(!isDefined(_id_D393E2740E2AF547))
    _id_D393E2740E2AF547 = 1;

  _id_7DD991F08B7A55C4 = getanimlength(_id_93EECC7204143FA9);
  self endon("death");
  thread scripts\engine\utility::script_func("vehicle_door_anim", self, _id_93EECC7204143FA9);
  wait(_id_7DD991F08B7A55C4);

  if(scripts\common\utility::issp() && _id_D393E2740E2AF547)
    self clearanim(_id_93EECC7204143FA9, 0);
}

#using_animtree("script_model");

getout_rigspawn(animatemodel, _id_C458EDAC96D58B16, _id_EC8A68BDE7AC6A73) {
  if(!isDefined(_id_EC8A68BDE7AC6A73))
    _id_EC8A68BDE7AC6A73 = 1;

  classname = scripts\common\vehicle_code::get_vehicle_classname();

  if(isDefined(self.attach_model_override) && isDefined(self.attach_model_override[_id_C458EDAC96D58B16.fastroperig]))
    _id_73FA9448302CBB29 = 1;
  else
    _id_73FA9448302CBB29 = 0;

  if(!isDefined(_id_C458EDAC96D58B16.fastroperig) || isDefined(self.fastroperig[_id_C458EDAC96D58B16.fastroperig]) || _id_73FA9448302CBB29) {
    return;
  }
  origin = animatemodel gettagorigin(level.vehicle.templates.attachedmodels[classname][_id_C458EDAC96D58B16.fastroperig].tag);
  angles = animatemodel gettagangles(level.vehicle.templates.attachedmodels[classname][_id_C458EDAC96D58B16.fastroperig].tag);
  self.fastroperiganimating[_id_C458EDAC96D58B16.fastroperig] = 1;
  getoutrig_model = spawn("script_model", origin);
  getoutrig_model.angles = angles;
  getoutrig_model.origin = origin;
  getoutrig_model useanimtree(#animtree);
  getoutrig_model setModel(level.vehicle.templates.attachedmodels[classname][_id_C458EDAC96D58B16.fastroperig].model);
  self.fastroperig[_id_C458EDAC96D58B16.fastroperig] = getoutrig_model;
  getoutrig_model linkTo(animatemodel, level.vehicle.templates.attachedmodels[classname][_id_C458EDAC96D58B16.fastroperig].tag);

  if(getdvarint("dvar_9403D7D31FC1D981"))
    thread getoutrig_model_new(_id_C458EDAC96D58B16, getoutrig_model, level.vehicle.templates.attachedmodels[classname][_id_C458EDAC96D58B16.fastroperig].tag, level.vehicle.templates.attachedmodels[classname][_id_C458EDAC96D58B16.fastroperig].dropanim, _id_EC8A68BDE7AC6A73);
  else
    thread getoutrig_model(_id_C458EDAC96D58B16, getoutrig_model, level.vehicle.templates.attachedmodels[classname][_id_C458EDAC96D58B16.fastroperig].tag, level.vehicle.templates.attachedmodels[classname][_id_C458EDAC96D58B16.fastroperig].dropanim, _id_EC8A68BDE7AC6A73);

  return getoutrig_model;
}

check_sound_tag_dupe(_id_7C44D494AA24E518) {
  if(!isDefined(self.sound_tag_dupe))
    self.sound_tag_dupe = [];

  _id_4ADF5358C5E1376B = 0;

  if(!isDefined(self.sound_tag_dupe[_id_7C44D494AA24E518]))
    self.sound_tag_dupe[_id_7C44D494AA24E518] = 1;
  else
    _id_4ADF5358C5E1376B = 1;

  thread check_sound_tag_dupe_reset(_id_7C44D494AA24E518);
  return _id_4ADF5358C5E1376B;
}

check_sound_tag_dupe_reset(_id_7C44D494AA24E518) {
  wait 0.05;

  if(!isDefined(self)) {
    return;
  }
  self.sound_tag_dupe[_id_7C44D494AA24E518] = 0;
  keys = getarraykeys(self.sound_tag_dupe);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < keys.size; _id_AC0E594AC96AA3A8++) {
    if(self.sound_tag_dupe[keys[_id_AC0E594AC96AA3A8]])
      return;
  }

  self.sound_tag_dupe = undefined;
}

vehicle_play_exit_anim(_id_C458EDAC96D58B16, vehicle_getoutanim, vehicle_getoutanim_clear) {
  _id_DE99D908F027883A = level.vehicle.templates.aianims[scripts\common\vehicle_code::get_vehicle_classname()];
  animatemodel = getanimatemodel();

  if(!isDefined(vehicle_getoutanim))
    vehicle_getoutanim = _id_C458EDAC96D58B16.vehicle_getoutanim;

  if(!isDefined(vehicle_getoutanim_clear))
    vehicle_getoutanim_clear = _id_C458EDAC96D58B16.vehicle_getoutanim_clear;

  if(isDefined(vehicle_getoutanim)) {
    animatemodel thread setanimrestart_once(vehicle_getoutanim, vehicle_getoutanim_clear);
    _id_B3B5DB2BC223FFD6 = 0;

    if(isDefined(_id_C458EDAC96D58B16.vehicle_getoutsoundtag)) {
      _id_B3B5DB2BC223FFD6 = check_sound_tag_dupe(_id_C458EDAC96D58B16.vehicle_getoutsoundtag);
      origin = animatemodel gettagorigin(_id_C458EDAC96D58B16.vehicle_getoutsoundtag);
    } else
      origin = animatemodel.origin;

    if(isDefined(_id_C458EDAC96D58B16.vehicle_getoutsound) && !_id_B3B5DB2BC223FFD6)
      playworldsound(_id_C458EDAC96D58B16.vehicle_getoutsound, origin);

    _id_B3B5DB2BC223FFD6 = undefined;
  }
}

vehicle_end_loop_sounds(guy, pos) {
  _id_C458EDAC96D58B16 = anim_pos(self, pos);

  if(isDefined(guy.playerpiggyback) && isDefined(_id_C458EDAC96D58B16.player_getout_sound_loop))
    level.player thread scripts\engine\utility::script_func("playloopsound_on_entity", _id_C458EDAC96D58B16.player_getout_sound_loop);

  if(isDefined(_id_C458EDAC96D58B16.getoutloopsnd))
    guy thread scripts\engine\utility::script_func("playloopsound_on_entity", _id_C458EDAC96D58B16.getoutloopsnd);

  if(isDefined(guy.playerpiggyback) && isDefined(_id_C458EDAC96D58B16.player_getout_sound_end))
    level.player thread scripts\engine\utility::script_func("playsound_on_entity", _id_C458EDAC96D58B16.player_getout_sound_end);
}

prepdoorsforunload() {
  if(self _meth_8FA29BF693C94B27()) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.vehicle.templates.aianims[scripts\common\vehicle_code::get_vehicle_classname()].size; _id_AC0E594AC96AA3A8++) {
    _id_C458EDAC96D58B16 = level.vehicle.templates.aianims[scripts\common\vehicle_code::get_vehicle_classname()][_id_AC0E594AC96AA3A8];

    if(isDefined(_id_C458EDAC96D58B16.vehicle_getoutanim)) {
      anim_name = getanimname(_id_C458EDAC96D58B16.vehicle_getoutanim);
      self _meth_D043DD116C449128(anim_name);
    }
  }
}

wait_for_open_door(guy, _id_C458EDAC96D58B16) {
  guy endon("jumpedout");
  guy endon("death");
  prepdoorsforunload();

  while(!istrue(guy.requestopendoor))
    waitframe();

  if(isDefined(_id_C458EDAC96D58B16.vehicle_getoutanim)) {
    anim_name = getanimname(_id_C458EDAC96D58B16.vehicle_getoutanim);

    if(!self _meth_6D897C252A37C080(anim_name)) {
      vehicle_getoutanim = _id_C458EDAC96D58B16.vehicle_getoutanim;
      vehicle_getoutanim_clear = _id_C458EDAC96D58B16.vehicle_getoutanim_clear;

      if(isDefined(guy.requestopendoorparams)) {
        if(guy.requestopendoorparams == "combat_run" && isDefined(_id_C458EDAC96D58B16.vehicle_getoutanim_combat_run)) {
          vehicle_getoutanim = _id_C458EDAC96D58B16.vehicle_getoutanim_combat_run;
          vehicle_getoutanim_clear = _id_C458EDAC96D58B16.vehicle_getoutanim_combat_run_clear;
        } else if(guy.requestopendoorparams == "combat" && isDefined(_id_C458EDAC96D58B16.vehicle_getoutanim_combat)) {
          vehicle_getoutanim = _id_C458EDAC96D58B16.vehicle_getoutanim_combat;
          vehicle_getoutanim_clear = _id_C458EDAC96D58B16.vehicle_getoutanim_combat_clear;
        }
      }

      vehicle_play_exit_anim(_id_C458EDAC96D58B16, vehicle_getoutanim, vehicle_getoutanim_clear);
      self _meth_DCEC5EA95982C90C(anim_name, 1);
    }

    if(isDefined(_id_C458EDAC96D58B16.fastroperig) && !isDefined(self.fastroperig[_id_C458EDAC96D58B16.fastroperig])) {
      animatemodel = getanimatemodel();
      getoutrig_model = getout_rigspawn(animatemodel, _id_C458EDAC96D58B16, 1);
    }
  }
}

guy_setup_rope(guy, _id_C458EDAC96D58B16) {
  if(isDefined(_id_C458EDAC96D58B16.fastroperig)) {
    thread wait_for_open_door(guy, _id_C458EDAC96D58B16);
    guy scripts\vehicle\vehicle_common::setuprope();
  } else {}
}

guy_unload(guy, pos) {
  isvehicle = 0;

  if(isDefined(guy.isvehicle))
    isvehicle = 1;

  _id_C458EDAC96D58B16 = anim_pos(self, pos);
  type = self.vehicletype;

  if(!check_unloadgroup(pos)) {
    if(!getdvarint("dvar_9403D7D31FC1D981"))
      thread guy_idle(guy, pos);

    return;
  }

  if(!getdvarint("dvar_9403D7D31FC1D981") && !isDefined(_id_C458EDAC96D58B16.getout)) {
    thread guy_idle(guy, pos);
    return;
  }

  thread guy_unload_que(guy);

  if(!scripts\common\utility::issp())
    thread _id_B4600DF9B9F46F3D(guy);

  self endon("death");

  if(isai(guy) && isalive(guy))
    guy endon("death");

  bnoanimunload = 0;

  if(isDefined(guy.getoffvehiclefunc)) {
    _id_F5B7A13C571F124C = guy[[guy.getoffvehiclefunc]]();

    if(isDefined(_id_F5B7A13C571F124C) && _id_F5B7A13C571F124C)
      bnoanimunload = 1;
  }

  if(isDefined(guy.onrotatingvehicleturret)) {
    guy.onrotatingvehicleturret = undefined;

    if(isDefined(guy.getoffvehiclefunc))
      guy[[guy.getoffvehiclefunc]]();
  }

  if(!getdvarint("dvar_9403D7D31FC1D981")) {
    vehicle_play_exit_anim(_id_C458EDAC96D58B16);
    delay = 0;

    if(isDefined(_id_C458EDAC96D58B16.getout_timed_anim))
      delay = delay + getanimlength(_id_C458EDAC96D58B16.getout_timed_anim);

    if(isDefined(_id_C458EDAC96D58B16.delay))
      delay = delay + _id_C458EDAC96D58B16.delay;

    if(isDefined(guy.delay))
      delay = delay + guy.delay;

    if(delay > 0) {
      if(!getdvarint("dvar_9403D7D31FC1D981"))
        thread guy_idle(guy, pos);

      wait(delay);
    }
  }

  if(!getdvarint("dvar_9403D7D31FC1D981")) {
    guy.deathanim = undefined;
    guy.deathanimscript = undefined;
  }

  guy notify("newanim");

  if(isDefined(_id_C458EDAC96D58B16.bhasgunwhileriding) && !_id_C458EDAC96D58B16.bhasgunwhileriding) {
    if(!isDefined(guy.disable_gun_recall))
      guy scripts\common\ai::gun_recall();
  }

  if(isai(guy))
    guy pushplayer(1);

  if(isDefined(_id_C458EDAC96D58B16.bnoanimunload))
    bnoanimunload = 1;
  else if(!getdvarint("dvar_9403D7D31FC1D981") && !isDefined(_id_C458EDAC96D58B16.getout) || !isDefined(self.script_unloadmgguy) && (isDefined(_id_C458EDAC96D58B16.bisgunner) && _id_C458EDAC96D58B16.bisgunner) || isDefined(self.script_keepdriver) && pos == 0) {
    thread guy_idle(guy, pos);
    return;
  }

  if(guy should_give_orghealth())
    guy.health = guy.orghealth;

  guy.orghealth = undefined;

  if(isai(guy) && isalive(guy))
    guy endon("death");

  guy.allowdeath = 0;
  tag = _id_C458EDAC96D58B16.sittag;

  if(isDefined(guy.get_out_override))
    animation = guy.get_out_override;
  else if(scripts\engine\utility::ent_flag("landed") && isDefined(_id_C458EDAC96D58B16.getout_landed))
    animation = _id_C458EDAC96D58B16.getout_landed;
  else if(isDefined(guy.playerpiggyback) && isDefined(_id_C458EDAC96D58B16.player_getout))
    animation = _id_C458EDAC96D58B16.player_getout;
  else
    animation = _id_C458EDAC96D58B16.getout;

  if(!bnoanimunload) {
    if(!getdvarint("dvar_9403D7D31FC1D981"))
      thread guy_unlink_on_death(guy);

    if(!getdvarint("dvar_9403D7D31FC1D981") && isDefined(_id_C458EDAC96D58B16.fastroperig)) {
      if(!isDefined(self.fastroperig[_id_C458EDAC96D58B16.fastroperig])) {
        if(!getdvarint("dvar_9403D7D31FC1D981"))
          thread guy_idle(guy, pos);

        animatemodel = getanimatemodel();
        getoutrig_model = getout_rigspawn(animatemodel, _id_C458EDAC96D58B16, 1);
      }
    }

    if(isDefined(_id_C458EDAC96D58B16.getoutsnd))
      guy thread scripts\engine\utility::script_func("playsound_on_tag", _id_C458EDAC96D58B16.getoutsnd, "J_Wrist_RI", 1);

    if(isDefined(guy.playerpiggyback) && isDefined(_id_C458EDAC96D58B16.player_getout_sound))
      guy thread scripts\engine\utility::script_func("playsound_on_tag", _id_C458EDAC96D58B16.player_getout_sound);

    if(isDefined(_id_C458EDAC96D58B16.getoutloopsnd))
      guy thread scripts\engine\utility::script_func("playloopsound_on_tag", _id_C458EDAC96D58B16.getoutloopsnd);

    if(isDefined(guy.playerpiggyback) && isDefined(_id_C458EDAC96D58B16.player_getout_sound_loop))
      level.player thread scripts\engine\utility::script_func("playloopsound_on_tag", _id_C458EDAC96D58B16.player_getout_sound_loop);

    guy notify("newanim");
    guy notify("jumping_out");
    _id_00C87C13106ECA1F = 0;

    if(!isai(guy) && !isvehicle)
      _id_00C87C13106ECA1F = 1;

    if(!isDefined(guy.script_stay_drone) && !isvehicle)
      guy = guy_becomes_real_ai(guy, pos);

    if(!isalive(guy) && !isvehicle) {
      return;
    }
    if(!isvehicle)
      guy.ragdoll_getout_death = 1;

    if(isDefined(_id_C458EDAC96D58B16.ragdoll_getout_death)) {
      guy.ragdoll_getout_death = 1;

      if(isDefined(_id_C458EDAC96D58B16.ragdoll_fall_anim))
        guy.ragdoll_fall_anim = _id_C458EDAC96D58B16.ragdoll_fall_anim;
    }

    if(_id_00C87C13106ECA1F) {
      self.riders = scripts\engine\utility::array_add(self.riders, guy);
      thread guy_deathhandle(guy, pos);
      thread guy_unload_que(guy);
      guy.ridingvehicle = self;
    }

    if(isai(guy))
      guy endon("death");

    guy notify("newanim");
    guy notify("jumping_out");

    if(isDefined(_id_C458EDAC96D58B16.littlebirde_getout_unlinks) && _id_C458EDAC96D58B16.littlebirde_getout_unlinks)
      thread stable_unlink(guy);

    if(isalive(guy) && isai(guy) && guy_resets_goalpos(guy)) {
      guy.goalradius = 600;
      guy setgoalpos(guy.origin);
    }

    if(isDefined(_id_C458EDAC96D58B16.getout_secondary)) {
      animontag(guy, tag, animation);
      _id_DAC541EB37E05FBA = tag;

      if(isDefined(_id_C458EDAC96D58B16.getout_secondary_tag))
        _id_DAC541EB37E05FBA = _id_C458EDAC96D58B16.getout_secondary_tag;

      animontag(guy, _id_DAC541EB37E05FBA, _id_C458EDAC96D58B16.getout_secondary, undefined, undefined, undefined, _id_C458EDAC96D58B16.sittag_origin_offset, _id_C458EDAC96D58B16.sittag_angles_offset);
    } else {
      _id_D71F1E388EF9F02E = 0;

      if(isDefined(_id_C458EDAC96D58B16.getout_hover_loop) && isDefined(_id_C458EDAC96D58B16.getout_hover_land)) {
        thread guy_unload_land(guy, tag, _id_C458EDAC96D58B16.getout, _id_C458EDAC96D58B16.getout_hover_loop, _id_C458EDAC96D58B16.getout_hover_land);
        _id_D71F1E388EF9F02E = 1;
      } else if(!isvehicle)
        guy.anim_end_early = 1;

      if(!getdvarint("dvar_9403D7D31FC1D981"))
        animontag(guy, tag, animation, undefined, undefined, undefined, _id_C458EDAC96D58B16.sittag_origin_offset, _id_C458EDAC96D58B16.sittag_angles_offset);
      else {
        thread wait_for_open_door(guy, _id_C458EDAC96D58B16);
        guy scripts\vehicle\vehicle_common::exitvehicle();
      }

      if(_id_D71F1E388EF9F02E)
        guy waittill("hoverunload_done");
    }

    if(isDefined(guy.playerpiggyback) && isDefined(_id_C458EDAC96D58B16.player_getout_sound_loop))
      level.player thread scripts\engine\utility::stop_loop_sound_on_entity(_id_C458EDAC96D58B16.player_getout_sound_loop);

    if(isDefined(_id_C458EDAC96D58B16.getoutloopsnd))
      guy thread scripts\engine\utility::stop_loop_sound_on_entity(_id_C458EDAC96D58B16.getoutloopsnd);

    if(isDefined(guy.playerpiggyback) && isDefined(_id_C458EDAC96D58B16.player_getout_sound_end))
      level.player thread scripts\engine\utility::script_func("playsound_on_entity", _id_C458EDAC96D58B16.player_getout_sound_end);
  } else if(!isai(guy)) {
    if(istrue(guy.drone_delete_on_unload)) {
      guy delete();
      return;
    }

    guy = scripts\engine\utility::script_func("spawner_makerealai", guy);
  }

  self.riders = scripts\engine\utility::array_remove(self.riders, guy);
  self.usedpositions[pos] = 0;
  guy.ridingvehicle = undefined;
  guy.drivingvehicle = undefined;

  if(!isalive(self) && !isDefined(_id_C458EDAC96D58B16.unload_ondeath)) {
    guy delete();
    return;
  }

  if(!getdvarint("dvar_9403D7D31FC1D981"))
    guy unlink();

  if(!isDefined(guy.magic_bullet_shield))
    guy.allowdeath = 1;

  if(isalive(guy) || isvehicle) {
    guy.forced_startingposition = undefined;

    if(isai(guy)) {
      if(isDefined(_id_C458EDAC96D58B16.getoutstance)) {
        guy.desired_anim_pose = _id_C458EDAC96D58B16.getoutstance;
        guy allowedstances("crouch");
        guy thread scripts\engine\utility::script_func("anim_updateanimpose");
        guy allowedstances("stand", "crouch", "prone");
      }

      guy pushplayer(0);
      guy notify("pushplayerchanged");
    } else if(isvehicle) {
      guy.vspawner.origin = guy.origin;
      guy.vspawner.angles = guy.angles;

      if(isDefined(guy.vspawner.target))
        guy.vspawner scripts\common\vehicle::spawn_vehicle_and_gopath();
      else
        _id_5CCFD555CE351B7B = guy.vspawner scripts\common\utility::spawn_vehicle();

      guy delete();
    }

    if(!getdvarint("dvar_9403D7D31FC1D981"))
      guy notify("jumpedout");
  }

  if(isDefined(guy.script_noteworthy) && guy.script_noteworthy == "delete_after_unload") {
    guy delete();
    return;
  }

  if(isDefined(_id_C458EDAC96D58B16.getout_delete) && _id_C458EDAC96D58B16.getout_delete) {
    guy delete();
    return;
  }

  guy guy_cleanup_vehiclevars();
}

guy_unload_land(guy, exittag, _id_2D08B404190FFB34, loopanim, _id_3212B2FCA3ECA795) {
  _id_59CA84FF0B0B2C1B = self gettagorigin(exittag);
  _id_C1D6ED48AC403E55 = self gettagangles(exittag);
  startorigin = getstartorigin(_id_59CA84FF0B0B2C1B, _id_C1D6ED48AC403E55, _id_2D08B404190FFB34);
  startangles = getstartangles(_id_59CA84FF0B0B2C1B, _id_C1D6ED48AC403E55, _id_2D08B404190FFB34);
  _id_703DFD8395B70F99 = getmovedelta(_id_2D08B404190FFB34, 0, 1);
  ent = scripts\engine\utility::spawn_tag_origin();
  ent.origin = startorigin;
  ent.angles = startangles;
  endorigin = ent localtoworldcoords(_id_703DFD8395B70F99);
  ent thread scripts\engine\utility::delete_on_notify("movedone");
  _id_B8D60C94893978FA = endorigin;
  _id_0DB1541018D7BADF = scripts\common\utility::groundpos(_id_B8D60C94893978FA);
  _id_101AA4DF00C5C196 = getstartorigin(_id_59CA84FF0B0B2C1B, _id_C1D6ED48AC403E55, _id_3212B2FCA3ECA795);
  _id_703DFD8395B70F99 = getmovedelta(_id_3212B2FCA3ECA795, 0, 1);
  _id_EC9901A4EBE157BF = _id_101AA4DF00C5C196 + _id_703DFD8395B70F99;
  _id_0E2895908736E88B = _id_101AA4DF00C5C196[2] - _id_EC9901A4EBE157BF[2];
  _id_A8E1EDAFFF060BBB = _id_0DB1541018D7BADF + (0, 0, _id_0E2895908736E88B);
  guy.allowdeath = 0;
  guy setCanDamage(0);
  guy endon("death");
  wait(getanimlength(_id_2D08B404190FFB34) - 0.1);
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

  if(isai(guy))
    guy scripts\engine\utility::script_func("asm_animcustom", ::guy_fall_loop, ::guy_fall_loop_end);
  else
    guy thread guy_fall_loop();

  falldist = length((0, 0, _id_A8E1EDAFFF060BBB[2]) - (0, 0, _id_B8D60C94893978FA[2]));
  _id_05493AA85DF3321F = 350;
  _id_BDA1DE83E1856735 = falldist / _id_05493AA85DF3321F;
  ent moveTo(_id_A8E1EDAFFF060BBB, _id_BDA1DE83E1856735);
  ent waittill("movedone");
  guy unlink();
  guy animScripted("dropship_land", guy.origin, guy.angles, _id_3212B2FCA3ECA795);
  wait(getanimlength(_id_3212B2FCA3ECA795));
  guy notify("hoverunload_done");
  guy notify("anim_on_tag_done");
}

guy_fall_loop() {
  if(isai(self)) {
    if(scripts\engine\utility::actor_is3d())
      self orientmode("face angle 3d", self.angles);
    else
      self orientmode("face angle", self.angles[1]);

    self animmode("zonly_physics", 1);
    self clearanim(scripts\asm\asm::asm_getbodyknob(), 0.2);
  }

  self setanim(self.unload_loopanim, 1);
  self waittill("dropship_land");
}

guy_fall_loop_end() {}

guy_resets_goalpos(guy) {
  if(isDefined(guy.script_delayed_playerseek))
    return 0;

  if(istrue(guy scripts\engine\utility::script_func("ai_has_color")))
    return 0;

  if(isDefined(guy.qsetgoalpos))
    return 0;

  if(!isDefined(guy.target))
    return 1;

  nodes = getnodearray(guy.target, "targetname");
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray(guy.target, "targetname");

  if(nodes.size > 0 || _id_9E4E1482CB40C9C5.size > 0)
    return 0;

  ent = getEnt(guy.target, "targetname");

  if(isDefined(ent) && ent.classname == "info_volume")
    return 0;

  return 1;
}

animontag(guy, tag, animation, notetracks, _id_A500F6EB31D94A23, flag, origin_offset, angles_offset) {
  guy notify("animontag_thread");
  guy endon("animontag_thread");

  if(!isDefined(origin_offset))
    origin_offset = (0, 0, 0);

  if(!isDefined(angles_offset))
    angles_offset = (0, 0, 0);

  if(!isDefined(flag))
    flag = "animontagdone";

  if(isDefined(self.modeldummy))
    animatemodel = self.modeldummy;
  else
    animatemodel = self;

  if(!isDefined(tag) || !scripts\engine\utility::hastag(animatemodel.model, tag)) {
    org = guy.origin;
    angles = guy.angles;
  } else {
    org = animatemodel gettagorigin(tag);
    angles = animatemodel gettagangles(tag) + angles_offset;
    _id_996A07FD7388DB1C = anglestoaxis(angles);
    _id_8131B69E561ED5AC = ["forward", "right", "up"];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_996A07FD7388DB1C.size; _id_AC0E594AC96AA3A8++)
      org = org + _id_996A07FD7388DB1C[_id_8131B69E561ED5AC[_id_AC0E594AC96AA3A8]] * origin_offset[_id_AC0E594AC96AA3A8];
  }

  if(isDefined(guy.ragdoll_getout_death) && !isDefined(guy.no_vehicle_ragdoll))
    level thread animontag_ragdoll_death(guy, self);

  if(!scripts\common\utility::issp()) {
    guy dontinterpolate();

    if(isai(guy)) {
      animindex = guy scripts\asm\asm::asm_lookupanimfromalias("animscripted", animation);
      xanim = guy scripts\asm\asm::asm_getxanim("animscripted", animindex);
      _id_D917428537562C1F = getstartorigin(self.origin, self.angles, xanim);
      startangles = getstartangles(self.origin, self.angles, xanim);
      guy forceteleport(_id_D917428537562C1F, startangles);
      guy animmode("nogravity");
      guy aisetanim("animscripted", animindex);
    }
  } else
    guy animScripted(flag, org, angles, animation);

  if(isai(guy))
    thread donotetracks(guy, animatemodel, flag);

  if(isDefined(guy.anim_end_early)) {
    guy.anim_end_early = undefined;
    _id_4594C87AA6B0AC8D = getanimlength(animation) - 0.25;

    if(_id_4594C87AA6B0AC8D > 0)
      wait(_id_4594C87AA6B0AC8D);

    guy stopanimScripted();
    guy.interval = 0;
    guy thread recover_interval();
  } else {
    if(isDefined(notetracks)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < notetracks.size; _id_AC0E594AC96AA3A8++) {
        guy waittillmatch(flag, notetracks[_id_AC0E594AC96AA3A8]);
        guy thread[[_id_A500F6EB31D94A23[_id_AC0E594AC96AA3A8]]]();
      }
    }

    guy waittillmatch(flag, "end");
  }

  guy notify("anim_on_tag_done");
  guy.ragdoll_getout_death = undefined;
}

recover_interval() {
  self endon("death");
  wait 2;

  if(self.interval == 0)
    self.interval = 80;
}

animontag_ragdoll_death(guy, vehicle) {
  if(isDefined(guy.magic_bullet_shield) && guy.magic_bullet_shield) {
    return;
  }
  if(!isai(guy))
    guy setCanDamage(1);

  guy endon("anim_on_tag_done");
  damage = undefined;
  attacker = undefined;
  _id_D7C1A2EEBD0B7C47 = vehicle.health <= 0;

  for(;;) {
    if(!_id_D7C1A2EEBD0B7C47 && !(isDefined(vehicle) && vehicle.health > 0)) {
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

animontag_ragdoll_death_fall(guy, vehicle, attacker) {
  guy.deathanim = undefined;
  guy.deathfunction = undefined;
  guy.anim_disablepain = 1;

  if(isDefined(guy.ragdoll_fall_anim)) {
    movedelta = getmovedelta(guy.ragdoll_fall_anim, 0, 1);
    groundpos = physicstrace(guy.origin + (0, 0, 16), guy.origin - (0, 0, 10000));
    _id_49489DD09961F605 = distance(guy.origin + (0, 0, 16), groundpos);

    if(abs(movedelta[2] + 16) <= abs(_id_49489DD09961F605)) {
      guy thread scripts\engine\utility::script_func("playsound_on_entity", "generic_death_falling");
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
    _id_B8F5AC23CE0DFDE3 = getweaponmodel(guy.weapon);
    weapon = guy.weapon;

    if(isDefined(_id_B8F5AC23CE0DFDE3)) {
      guy detach(_id_B8F5AC23CE0DFDE3, "tag_weapon_right");
      org = guy gettagorigin("tag_weapon_right");
      _id_8BC14603A27FA3E7 = guy gettagangles("tag_weapon_right");
      level.gun = spawn("weapon_" + getcompleteweaponname(weapon), (0, 0, 0));
      level.gun.angles = _id_8BC14603A27FA3E7;
      level.gun.origin = org;
    }
  } else
    guy scripts\engine\utility::script_func("anim_dropallaiweapons");

  if(isDefined(guy.fnpreragdoll))
    guy[[guy.fnpreragdoll]]();

  guy startragdoll();
}

donotetracks(guy, vehicle, flag) {
  guy endon("idle");
  guy endon("newanim");
  vehicle endon("death");
  guy endon("death");
  guy scripts\engine\utility::script_func("anim_donotetracks", flag);
}

animatemoveintoplace(guy, org, angles, _id_4E90BF2523360F6C) {
  guy animScripted("movetospot", org, angles, _id_4E90BF2523360F6C);
  guy waittillmatch("movetospot", "end");
}

guy_vehicle_death(guy, attacker) {
  if(!isalive(guy)) {
    return;
  }
  if(isDefined(self.no_rider_death)) {
    return;
  }
  _id_C458EDAC96D58B16 = anim_pos(self, guy.vehicle_position);

  if(isDefined(_id_C458EDAC96D58B16.explosion_death))
    return guy_blowup(guy);

  classname = scripts\common\vehicle_code::get_vehicle_classname();

  if(isDefined(level.vehicle.templates.rider_death_func) && isDefined(level.vehicle.templates.rider_death_func[classname])) {
    self[[level.vehicle.templates.rider_death_func[classname]]]();
    return;
  }

  if(isDefined(_id_C458EDAC96D58B16.unload_ondeath) && isDefined(self)) {
    if(isDefined(self.dontunloadondeath) && self.dontunloadondeath) {
      return;
    }
    thread guy_idle(guy, guy.vehicle_position, 1);
    wait(_id_C458EDAC96D58B16.unload_ondeath);

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
    guy delete();
  }
}

ai_wait_go() {
  self endon("death");
  self waittill("loaded");
  scripts\common\vehicle_paths::gopath(self);
}

set_pos(guy, _id_DE99D908F027883A) {
  pos = guy.script_startingposition;

  if(isDefined(guy.forced_startingposition))
    pos = guy.forced_startingposition;

  if(isDefined(pos))
    return pos;

  for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < self.usedpositions.size; _id_AC0E5C4AC96AAA41++) {
    if(self.usedpositions[_id_AC0E5C4AC96AAA41]) {
      continue;
    }
    if(isDefined(guy.isvehicle) && !isDefined(_id_DE99D908F027883A[_id_AC0E5C4AC96AAA41].isvehicle)) {
      continue;
    }
    if(!isDefined(guy.isvehicle) && isDefined(_id_DE99D908F027883A[_id_AC0E5C4AC96AAA41].isvehicle)) {
      continue;
    }
    return _id_AC0E5C4AC96AAA41;
  }

  if(isDefined(guy.isvehicle) && guy.isvehicle) {
    return;
  }
  return;
}

guy_man_turret(guy, pos, _id_5B0CAB0A9420DA60) {
  _id_C458EDAC96D58B16 = anim_pos(self, pos);
  turret = self.mgturret[_id_C458EDAC96D58B16.mgturret];

  if(!isalive(guy)) {
    return;
  }
  turret endon("death");
  guy endon("death");

  if(isDefined(_id_5B0CAB0A9420DA60) && _id_5B0CAB0A9420DA60 && isDefined(_id_C458EDAC96D58B16.passenger_2_turret_func))
    [[_id_C458EDAC96D58B16.passenger_2_turret_func]](self, guy, pos, turret);

  scripts\common\vehicle_code::set_turret_team(turret);
  turret setdefaultdroppitch(0);
  wait 0.1;
  guy endon("guy_man_turret_stop");
  level thread scripts\common\vehicle_code::vehicle_turret_difficulty(turret, scripts\common\utility::getdifficulty());
  turret scripts\engine\utility::self_func("setturretignoregoals", 1);
  _id_5CAA9F9F456B4040 = "stand";

  if(isDefined(_id_C458EDAC96D58B16.turretpos))
    _id_5CAA9F9F456B4040 = _id_C458EDAC96D58B16.turretpos;

  guy scripts\engine\utility::script_func("use_turret", turret, _id_5CAA9F9F456B4040);
}

guy_unlink_on_death(guy) {
  guy endon("jumpedout");
  guy waittill("death");

  if(isDefined(guy))
    guy unlink();
}

guy_blowup(guy) {
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
    origin = origin + anglesToForward(angles) * anim_pos.explosion_death_offset[0];
    origin = origin + anglestoright(angles) * anim_pos.explosion_death_offset[1];
    origin = origin + anglestoup(angles) * anim_pos.explosion_death_offset[2];
  }

  guy = convert_guy_to_drone(guy);
  detach_models_with_substr(guy, "weapon_");
  guy notsolid();
  guy.origin = origin;
  guy.angles = angles;
  guy animScripted("deathanim", origin, angles, anim_pos.explosion_death);
  fraction = 0.3;

  if(isDefined(anim_pos.explosion_death_ragdollfraction))
    fraction = anim_pos.explosion_death_ragdollfraction;

  animlength = getanimlength(anim_pos.explosion_death);
  timer = gettime() + animlength * 1000;
  wait(animlength * fraction);
  _id_F8048727716242B0 = (0, 0, 1);
  org = guy.origin;

  if(getDvar("ragdoll_enable") == "0") {
    guy delete();
    return;
  }

  if(isai(guy))
    guy scripts\engine\utility::script_func("anim_dropallaiweapons");
  else
    detach_models_with_substr(guy, "weapon_");

  while(!guy isragdoll() && gettime() < timer) {
    org = guy.origin;
    wait 0.05;
    _id_F8048727716242B0 = guy.origin - org;

    if(isDefined(guy.fnpreragdoll))
      guy[[guy.fnpreragdoll]]();

    guy startragdoll();
  }

  wait 0.05;
  _id_F8048727716242B0 = _id_F8048727716242B0 * 20000;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++) {
    if(isDefined(guy))
      org = guy.origin;

    wait 0.05;
  }

  if(!guy isragdoll())
    guy delete();
}

convert_guy_to_drone(guy, _id_5D30C43BE498CBAF) {
  if(!isDefined(_id_5D30C43BE498CBAF))
    _id_5D30C43BE498CBAF = 0;

  model = spawn("script_model", guy.origin);
  model.angles = guy.angles;
  model setModel(guy.model);
  _id_A61C75B156FC1EE0 = guy getattachsize();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A61C75B156FC1EE0; _id_AC0E594AC96AA3A8++)
    model attach(guy getattachmodelname(_id_AC0E594AC96AA3A8), guy getattachtagname(_id_AC0E594AC96AA3A8));

  model useanimtree(#animtree);

  if(isDefined(guy.team))
    model.team = guy.team;

  if(!_id_5D30C43BE498CBAF)
    guy delete();

  model scripts\engine\utility::self_func("makefakeai");
  return model;
}

vehicle_animate(animation, animtree) {
  self useanimtree(animtree);
  self setanim(animation);
}

vehicle_getinstart(pos) {
  _id_C458EDAC96D58B16 = anim_pos(self, pos);
  return vehicle_getanimstart(_id_C458EDAC96D58B16.getin, _id_C458EDAC96D58B16.sittag, pos, _id_C458EDAC96D58B16.canshootinvehicle);
}

vehicle_getanimstart(animation, tag, pos, canshootinvehicle) {
  struct = spawnStruct();
  origin = undefined;
  angles = undefined;
  org = self gettagorigin(tag);
  _id_8BC14603A27FA3E7 = self gettagangles(tag);

  if(!getdvarint("dvar_9403D7D31FC1D981") || isDefined(animation)) {
    origin = getstartorigin(org, _id_8BC14603A27FA3E7, animation);
    angles = getstartangles(org, _id_8BC14603A27FA3E7, animation);
  } else {
    origin = org;
    angles = _id_8BC14603A27FA3E7;
  }

  struct.origin = origin;
  struct.angles = angles;
  struct.vehicle_position = pos;
  struct.canshootinvehicle = canshootinvehicle;
  return struct;
}

is_position_in_group(vehicle, pos, group) {
  if(!isDefined(group))
    return 1;

  classname = vehicle scripts\common\vehicle_code::get_vehicle_classname();
  _id_4C040F8ACAF932B4 = level.vehicle.templates.unloadgroups[classname][group];

  foreach(_id_80EF668C09FFB70F in _id_4C040F8ACAF932B4) {
    if(_id_80EF668C09FFB70F == pos)
      return 1;
  }

  return 0;
}

get_availablepositions(group) {
  _id_DE99D908F027883A = level.vehicle.templates.aianims[scripts\common\vehicle_code::get_vehicle_classname()];
  availablepositions = [];
  nonanimatedpositions = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.usedpositions.size; _id_AC0E594AC96AA3A8++) {
    if(self.usedpositions[_id_AC0E594AC96AA3A8]) {
      continue;
    }
    if((getdvarint("dvar_9403D7D31FC1D981") || isDefined(_id_DE99D908F027883A[_id_AC0E594AC96AA3A8].getin)) && is_position_in_group(self, _id_AC0E594AC96AA3A8, group)) {
      availablepositions[availablepositions.size] = vehicle_getinstart(_id_AC0E594AC96AA3A8);
      continue;
    }

    nonanimatedpositions[nonanimatedpositions.size] = _id_AC0E594AC96AA3A8;
  }

  struct = spawnStruct();
  struct.availablepositions = availablepositions;
  struct.nonanimatedpositions = nonanimatedpositions;
  return struct;
}

getanimatemodel() {
  if(isDefined(self.modeldummy))
    return self.modeldummy;
  else
    return self;
}

detach_models_with_substr(guy, _id_DE8A45DD2BF968EC) {
  _id_A61C75B156FC1EE0 = guy getattachsize();
  _id_895AEA96C7DEBFFD = [];
  _id_E51D4C9A2F109B4B = [];
  index = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A61C75B156FC1EE0; _id_AC0E594AC96AA3A8++) {
    modelname = guy getattachmodelname(_id_AC0E594AC96AA3A8);
    tagname = guy getattachtagname(_id_AC0E594AC96AA3A8);

    if(issubstr(modelname, _id_DE8A45DD2BF968EC)) {
      _id_895AEA96C7DEBFFD[index] = modelname;
      _id_E51D4C9A2F109B4B[index] = tagname;
    }
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_895AEA96C7DEBFFD.size; _id_AC0E594AC96AA3A8++)
    guy detach(_id_895AEA96C7DEBFFD[_id_AC0E594AC96AA3A8], _id_E51D4C9A2F109B4B[_id_AC0E594AC96AA3A8]);
}

should_give_orghealth() {
  if(!isai(self))
    return 0;

  if(!isDefined(self.orghealth))
    return 0;

  return !isDefined(self.magic_bullet_shield);
}

stable_unlink(guy) {
  self waittill("stable_for_unlink");

  if(isalive(guy))
    guy unlink();
}

animate_guys(other) {
  _id_4A5B0778CBC77A84 = [];

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
      _id_4A5B0778CBC77A84[_id_4A5B0778CBC77A84.size] = guy;
      continue;
    }
  }

  return _id_4A5B0778CBC77A84;
}

guy_cleanup_vehiclevars() {
  self.vehicle_idling = undefined;
  self.standing = undefined;
  self.vehicle_position = undefined;
  self.delay = undefined;
}