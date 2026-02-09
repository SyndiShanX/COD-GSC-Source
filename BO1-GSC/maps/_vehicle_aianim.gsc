/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_vehicle_aianim.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#using_animtree("generic_human");

vehicle_enter(vehicle, tag) {
  assertEX(!isDefined(self.ridingvehicle), "ai can't ride two vehicles at the same time");
  if(isDefined(tag)) {
    self.forced_startingposition = anim_pos_from_tag(vehicle, tag);
  }
  type = vehicle.vehicletype;
  vehicleanim = vehicle get_aianims();
  maxpos = level.vehicle_aianims[type].size;
  if(isDefined(self.script_vehiclewalk)) {
    pos = set_walkerpos(self, level.vehicle_walkercount[type]);
    vehicle thread WalkWithVehicle(self, pos);
    return;
  }
  vehicle.attachedguys[vehicle.attachedguys.size] = self;
  pos = vehicle set_pos(self, maxpos);
  if(!isDefined(pos)) {
    return;
  }
  if(pos == 0) {
    self.drivingVehicle = true;
  }
  animpos = anim_pos(vehicle, pos);
  vehicle.usedPositions[pos] = true;
  self.pos = pos;
  if(isDefined(animpos.delay)) {
    self.delay = animpos.delay;
    if(isDefined(animpos.delayinc)) {
      vehicle.delayer = self.delay;
    }
  }
  if(isDefined(animpos.delayinc)) {
    vehicle.delayer += animpos.delayinc;
    self.delay = vehicle.delayer;
  }
  self.ridingvehicle = vehicle;
  self.orghealth = self.health;
  self.vehicle_idle = animpos.idle;
  self.vehicle_idle_combat = animpos.idle_combat;
  self.vehicle_standattack = animpos.standattack;
  self.standing = 0;
  self.allowdeath = false;
  if(isDefined(self.deathanim) && !isDefined(self.magic_bullet_shield)) {
    self.allowdeath = true;
  }
  if(isDefined(animpos.death)) {
    vehicle thread guy_death(self, animpos);
  }
  if(!isDefined(self.vehicle_idle)) {
    self.allowdeath = true;
  }
  vehicle.riders[vehicle.riders.size] = self;
  if(!isDefined(animpos.explosion_death)) {
    vehicle thread guy_vehicle_death(self);
  }
  if(self.classname != "script_model" && spawn_failed(self)) {
    return;
  }
  org = vehicle gettagorigin(animpos.sittag);
  angles = vehicle gettagAngles(animpos.sittag);
  self linkto(vehicle, animpos.sittag, (0, 0, 0), (0, 0, 0));
  if(isai(self)) {
    self teleport(org, angles);
    self.a.disablelongdeath = true;
    if(isDefined(animpos.bHasGunWhileRiding) && !animpos.bHasGunWhileRiding) {
      self gun_remove();
    }
    if(isDefined(animpos.vehiclegunner)) {
      self.vehicle_pos = pos;
      self.vehicle = vehicle;
      self AnimCustom(::guy_man_gunner_turret);
    } else if(isDefined(animpos.mgturret) && !(isDefined(vehicle.script_nomg) && vehicle.script_nomg > 0)) {
      vehicle thread guy_man_turret(self, pos);
    }
    if(isDefined(self.script_combat_getout) && self.script_combat_getout) {
      self.do_combat_getout = true;
    }
    if(isDefined(self.script_combat_idle) && self.script_combat_idle) {
      self.do_combat_idle = true;
    }
  } else {
    if(isDefined(animpos.bHasGunWhileRiding) && !animpos.bHasGunWhileRiding) {
      detach_models_with_substr(self, "weapon_");
    }
    self.origin = org;
    self.angles = angles;
    if(isDefined(animpos.vehiclegunner)) {
      self.vehicle_pos = pos;
      self.vehicle = vehicle;
      self thread guy_man_gunner_turret();
    } else if(isDefined(animpos.mgturret) && !(isDefined(vehicle.script_nomg) && vehicle.script_nomg > 0)) {
      vehicle thread guy_man_turret(self, pos);
    }
  }
  if(pos == 0 && isDefined(vehicleanim[0].death)) {
    vehicle thread driverdead(self);
  }
  if(!isDefined(animpos.vehiclegunner)) {
    vehicle thread guy_handle(self, pos);
    vehicle thread guy_idle(self, pos);
  }
}
guy_array_enter(guysarray, vehicle) {
  guysarray = maps\_vehicle::sort_by_startingpos(guysarray);
  lastguy = false;
  for(i = 0; i < guysarray.size; i++) {
    if(!(i + 1 < guysarray.size)) {
      lastguy = true;
    }
    guysarray[i] vehicle_enter(vehicle);
  }
}
handle_attached_guys() {
  type = self.vehicletype;
  if(isDefined(self.script_vehiclewalk)) {
    for(i = 0; i < 6; i++) {
      self.walk_tags[i] = ("tag_walker" + i);
      self.walk_tags_used[i] = false;
    }
  }
  self.attachedguys = [];
  if(!(isDefined(level.vehicle_aianims) && isDefined(level.vehicle_aianims[type]))) {
    return;
  }
  maxpos = level.vehicle_aianims[type].size;
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "ai_wait_go") {
    thread ai_wait_go();
  }
  self.runningtovehicle = [];
  self.usedPositions = [];
  self.getinorgs = [];
  self.delayer = 0;
  vehicleanim = self get_aianims();
  for(i = 0; i < maxpos; i++) {
    self.usedPositions[i] = false;
    if(isDefined(self.script_nomg) && self.script_nomg && isDefined(vehicleanim[i].bIsgunner) && vehicleanim[i].bIsgunner) {
      self.usedpositions[1] = true;
    }
  }
}
load_ai_goddriver(array) {
  load_ai(array, true);
}
guy_death(guy, animpos) {
  waittillframeend;
  guy endon("death");
  guy.allowdeath = false;
  guy.health = 100000;
  guy endon("jumping_out");
  guy waittill("damage");
  thread guy_deathimate_me(guy, animpos);
}
guy_deathimate_me(guy, animpos) {
  animtimer = gettime() + (getanimlength(animpos.death) * 1000);
  angles = guy.angles;
  origin = guy.origin;
  guy = convert_guy_to_drone(guy);
  [[level.global_kill_func]]("MOD_RIFLE_BULLET", "torso_upper", origin);
  detach_models_with_substr(guy, "weapon_");
  guy linkto(self, animpos.sittag, (0, 0, 0), (0, 0, 0));
  guy notsolid();
  thread animontag(guy, animpos.sittag, animpos.death);
  if(!isDefined(animpos.death_delayed_ragdoll)) {
    guy waittillmatch("animontagdone", "start_ragdoll");
  } else {
    guy unlink();
    guy startragdoll();
    wait animpos.death_delayed_ragdoll;
    guy delete();
    return;
  }
  guy unlink();
  if(getDvar(#"ragdoll_enable") == "0") {
    guy delete();
    return;
  }
  while(gettime() < animtimer && !guy isragdoll()) {
    guy startragdoll();
    wait .05;
  }
  if(!guy isragdoll()) {
    guy delete();
  }
}
load_ai(array, bGoddriver) {
  if(!isDefined(bGoddriver)) {
    bGoddriver = false;
  }
  if(!isDefined(array)) {
    array = vehicle_get_riders();
  }
  array_levelthread(array, ::get_in_vehicle, bGoddriver);
}
is_rider(guy) {
  for(i = 0; i < self.riders.size; i++) {
    if(self.riders[i] == guy) {
      return true;
    }
  }
  return false;
}
vehicle_get_riders() {
  array = [];
  ai = getaiarray(self.vteam);
  for(i = 0; i < ai.size; i++) {
    guy = ai[i];
    if(!isDefined(guy.script_vehicleride)) {
      continue;
    }
    if(guy.script_vehicleride != self.script_vehicleride) {
      continue;
    }
    array[array.size] = guy;
  }
  return array;
}
get_my_vehicleride() {
  array = [];
  assertex(isDefined(self.script_vehicleride), "Tried to get my ride but I have no .script_vehicleride");
  vehicles = getEntArray("script_vehicle", "classname");
  for(i = 0; i < vehicles.size; i++) {
    vehicle = vehicles[i];
    if(!isDefined(vehicle.script_vehicleride)) {
      continue;
    }
    if(vehicle.script_vehicleride != self.script_vehicleride) {
      continue;
    }
    array[array.size] = vehicle;
  }
  assertex(array.size == 1, "Tried to get my ride but there was zero or multiple rides to choose from");
  return array[0];
}
get_in_vehicle(guy, bGoddriver) {
  if(is_rider(guy)) {
    return;
  }
  if(!handle_detached_guys_check()) {
    return;
  }
  assertEX(isalive(guy), "tried to load a vehicle with dead guy, check your AI count to assure spawnability of ai's");
  guy run_to_vehicle(self, bGoddriver);
}
handle_detached_guys_check() {
  if(vehicle_hasavailablespots()) {
    return true;
  }
  assertmsg("script sent too many ai to vehicle( max is: " + level.vehicle_aianims[self.vehicletype].size + " )");
}
vehicle_hasavailablespots() {
  if(level.vehicle_aianims[self.vehicletype].size - self.runningtovehicle.size) {
    return true;
  } else {
    return false;
  }
}
run_to_vehicle_loaded(vehicle) {
  vehicle endon("death");
  self waittill_any("long_death", "death", "enteredvehicle");
  vehicle.runningtovehicle = array_remove(vehicle.runningtovehicle, self);
  if(!vehicle.runningtovehicle.size && vehicle.riders.size && vehicle.usedpositions[0]) {
    vehicle notify("loaded");
  }
}
remove_magic_bullet_shield_from_guy_on_unload_or_death(guy) {
  self waittill_any("unload", "death");
  guy stop_magic_bullet_shield();
}
run_to_vehicle(vehicle, bGodDriver, seat_tag) {
  if(!isDefined(bGodDriver)) {
    bGodDriver = false;
  }
  vehicleanim = vehicle get_aianims();
  if(isDefined(vehicle.runtovehicleoverride)) {
    vehicle thread[[vehicle.runtovehicleoverride]](self);
    return;
  }
  vehicle endon("death");
  self endon("death");
  vehicle.runningtovehicle[vehicle.runningtovehicle.size] = self;
  self thread run_to_vehicle_loaded(vehicle);
  availablepositions = [];
  chosenorg = undefined;
  origin = 0;
  bIsgettin = false;
  for(i = 0; i < vehicleanim.size; i++) {
    if(isDefined(vehicleanim[i].getin)) {
      bIsgettin = true;
      break;
    }
  }
  if(!bIsgettin) {
    self notify("enteredvehicle");
    self enter_vehicle(vehicle);
    return;
  }
  while(vehicle getspeedmph() > 1) {
    wait .05;
  }
  positions = vehicle get_availablepositions();
  if(!vehicle.usedPositions[0]) {
    chosenorg = vehicle vehicle_getInstart(0);
    if(bGoddriver) {
      assertEX(!isDefined(self.magic_bullet_shield), "magic_bullet_shield guy told to god mode drive a vehicle, you should simply load_ai without the god function for this guy");
      self thread magic_bullet_shield();
      vehicle thread remove_magic_bullet_shield_from_guy_on_unload_or_death(self);
    }
  } else if(isDefined(self.script_startingposition)) {
    position_valid = -1;
    for(i = 0; i < positions.availablepositions.size; i++) {
      if(positions.availablepositions[i].pos == self.script_startingposition) {
        position_valid = i;
      }
    }
    if(position_valid > -1) {
      chosenorg = positions.availablepositions[position_valid];
    } else {
      if(positions.availablepositions.size) {
        chosenorg = getclosest(self.origin, positions.availablepositions);
      } else {
        chosenorg = undefined;
      }
    }
  } else if(isDefined(seat_tag)) {
    for(i = 0; i < vehicleanim.size; i++) {
      if(vehicleanim[i].sittag == seat_tag) {
        for(j = 0; j < positions.availablepositions.size; j++) {
          if(positions.availablepositions[j].pos == i) {
            chosenorg = positions.availablepositions[j];
            break;
          }
        }
        break;
      }
    }
  } else if(positions.availablepositions.size) {
    chosenorg = getclosest(self.origin, positions.availablepositions);
  } else {
    chosenorg = undefined;
  }
  if((!positions.availablepositions.size) && (positions.nonanimatedpositions.size)) {
    self notify("enteredvehicle");
    self enter_vehicle(vehicle);
    return;
  } else if(!isDefined(chosenorg)) {
    return;
  }
  self.forced_startingposition = chosenorg.pos;
  vehicle.usedpositions[chosenorg.pos] = true;
  self.script_moveoverride = true;
  self notify("stop_going_to_node");
  if(isDefined(vehicleanim[chosenorg.pos].wait_for_notify)) {
    if(isDefined(vehicleanim[chosenorg.pos].waiting)) {
      self set_forcegoal();
      self.goalradius = 64;
      self setgoalpos(chosenorg.origin);
      self waittill("goal");
      self unset_forcegoal();
      self AnimScripted("anim_wait_done", self.origin, self.angles, vehicleanim[chosenorg.pos].waiting);
      vehicle waittill(vehicleanim[chosenorg.pos].wait_for_notify);
    }
  } else if(isDefined(vehicleanim[chosenorg.pos].wait_for_player)) {
    if(isDefined(vehicleanim[chosenorg.pos].waiting)) {
      self set_forcegoal();
      self.goalradius = 64;
      self setgoalpos(chosenorg.origin);
      self waittill("goal");
      self unset_forcegoal();
      self AnimScripted("anim_wait_done", self.origin, self.angles, vehicleanim[chosenorg.pos].waiting);
      while(true) {
        on_vehicle = 0;
        for(i = 0; i < vehicleanim[chosenorg.pos].wait_for_player.size; i++) {
          if(vehicleanim[chosenorg.pos].wait_for_player[i] is_on_vehicle(vehicle)) {
            on_vehicle++;
          }
        }
        if(on_vehicle == vehicleanim[chosenorg.pos].wait_for_player.size) {
          break;
        }
        wait(0.05);
      }
    }
  }
  self set_forcegoal();
  self.goalradius = 16;
  self setgoalpos(chosenorg.origin);
  self waittill("goal");
  self unset_forcegoal();
  self.allowdeath = false;
  if(isDefined(chosenorg)) {
    if(isDefined(vehicleanim[chosenorg.pos].vehicle_getinanim)) {
      vehicle = vehicle getanimatemodel();
      vehicle thread setanimrestart_once(vehicleanim[chosenorg.pos].vehicle_getinanim, vehicleanim[chosenorg.pos].vehicle_getinanim_clear);
    }
    if(isDefined(vehicleanim[chosenorg.pos].vehicle_getinsoundtag)) {
      origin = vehicle gettagorigin(vehicleanim[chosenorg.pos].vehicle_getinsoundtag);
    } else {
      origin = vehicle.origin;
    }
    if(isDefined(vehicleanim[chosenorg.pos].vehicle_getinsound)) {
      sound = vehicleanim[chosenorg.pos].vehicle_getinsound;
    } else {
      sound = "veh_truck_door_open";
    }
    vehicle thread maps\_utility::play_sound_in_space(sound, origin);
    vehicle animontag(self, vehicleanim[chosenorg.pos].sittag, vehicleanim[chosenorg.pos].getin);
  }
  self notify("enteredvehicle");
  self enter_vehicle(vehicle);
}
driverdead(guy) {
  self.driver = guy;
  self endon("death");
  guy waittill("death");
  self.deaddriver = true;
  self setwaitspeed(0);
  self setspeed(0, 4);
  self waittill("reached_wait_speed");
  self notify("unload");
}
anim_pos(vehicle, pos) {
  return (vehicle get_aianims()[pos]);
}
anim_pos_from_tag(vehicle, tag) {
  vehicleanims = level.vehicle_aianims[vehicle.vehicletype];
  keys = GetArrayKeys(vehicleanims);
  for(i = 0; i < keys.size; i++) {
    pos = keys[i];
    if(isDefined(vehicleanims[pos].sittag) && vehicleanims[pos].sittag == tag) {
      return pos;
    }
  }
}
guy_deathhandle(guy, pos) {
  guy waittill("death");
  if(!isDefined(self)) {
    return;
  }
  self.riders = array_remove(self.riders, guy);
  self.usedPositions[pos] = false;
}
setup_aianimthreads() {
  if(!isDefined(level.vehicle_aianimthread)) {
    level.vehicle_aianimthread = [];
  }
  if(!isDefined(level.vehicle_aianimcheck)) {
    level.vehicle_aianimcheck = [];
  }
  level.vehicle_aianimthread["idle"] = ::guy_idle;
  level.vehicle_aianimthread["duck"] = ::guy_duck;
  level.vehicle_aianimthread["duck_once"] = ::guy_duck_once;
  level.vehicle_aianimcheck["duck_once"] = ::guy_duck_once_check;
  level.vehicle_aianimthread["weave"] = ::guy_weave;
  level.vehicle_aianimcheck["weave"] = ::guy_weave_check;
  level.vehicle_aianimthread["stand"] = ::guy_stand;
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
  level.vehicle_aianimthread["reaction"] = ::guy_turret_turnright;
  level.vehicle_aianimthread["drive_reaction"] = ::guy_drive_reaction;
  level.vehicle_aianimcheck["drive_reaction"] = ::guy_drive_reaction_check;
  level.vehicle_aianimthread["death_fire"] = ::guy_death_fire;
  level.vehicle_aianimcheck["death_fire"] = ::guy_death_fire_check;
  level.vehicle_aianimthread["move_to_driver"] = ::guy_move_to_driver;
}
guy_handle(guy, pos) {
  guy.vehicle_idling = true;
  guy.queued_anim_threads = [];
  thread guy_deathhandle(guy, pos);
  thread guy_queue_anim(guy, pos);
  guy endon("death");
  guy endon("jumpedout");
  while(1) {
    self waittill("groupedanimevent", other);
    if(isDefined(level.vehicle_aianimcheck[other]) && ![[level.vehicle_aianimcheck[other]]](guy, pos)) {
      continue;
    }
    if(isDefined(self.groupedanim_pos)) {
      if(pos != self.groupedanim_pos) {
        continue;
      }
      waittillframeend;
      self.groupedanim_pos = undefined;
    }
    if(isDefined(level.vehicle_aianimthread[other])) {
      if(isDefined(self.queueanim) && self.queueanim) {
        add_anim_queue(guy, level.vehicle_aianimthread[other]);
        waittillframeend;
        self.queueanim = false;
      } else {
        guy notify("newanim");
        guy.queued_anim_threads = [];
        thread[[level.vehicle_aianimthread[other]]](guy, pos);
      }
    } else
      println("leaaaaaaaaaaaaaak", other);
  }
}
add_anim_queue(guy, sthread) {
  guy.queued_anim_threads[guy.queued_anim_threads.size] = sthread;
}
guy_queue_anim(guy, pos) {
  guy endon("death");
  self endon("death");
  lastanimframe = gettime() - 100;
  while(1) {
    if(guy.queued_anim_threads.size) {
      if(gettime() != lastanimframe) {
        guy waittill("anim_on_tag_done");
      }
      if(!guy.queued_anim_threads.size) {
        continue;
      }
      guy notify("newanim");
      thread[[guy.queued_anim_threads[0]]](guy, pos);
      guy.queued_anim_threads = array_remove(guy.queued_anim_threads, guy.queued_anim_threads[0]);
      wait .05;
    } else {
      guy waittill("anim_on_tag_done");
      lastanimframe = gettime();
    }
  }
}
guy_stand(guy, pos) {
  animpos = anim_pos(self, pos);
  vehicleanim = self get_aianims();
  if(!isDefined(animpos.standup)) {
    return;
  }
  guy endon("newanim");
  self endon("death");
  guy endon("death");
  animontag(guy, animpos.sittag, animpos.standup);
  guy_stand_attack(guy, pos);
}
guy_stand_attack(guy, pos) {
  animpos = anim_pos(self, pos);
  guy endon("newanim");
  self endon("death");
  guy endon("death");
  guy.standing = 1;
  mintime = 0;
  while(1) {
    timer2 = gettime() + 2000;
    while(gettime() < timer2 && isDefined(guy.enemy)) {
      animontag(guy, animpos.sittag, guy.vehicle_standattack, undefined, undefined, "firing");
    }
    rnum = randomint(5) + 10;
    for(i = 0; i < rnum; i++) {
      animontag(guy, animpos.sittag, animpos.standidle);
    }
  }
}
guy_stand_down(guy, pos) {
  animpos = anim_pos(self, pos);
  if(!isDefined(animpos.standdown)) {
    thread guy_stand_attack(guy, pos);
    return;
  }
  animontag(guy, animpos.sittag, animpos.standdown);
  guy.standing = 0;
  thread guy_idle(guy, pos);
}
driver_idle_speed(driver, pos) {
  driver endon("newanim");
  self endon("death");
  driver endon("death");
  animpos = anim_pos(self, pos);
  while(1) {
    if(self getspeedmph() == 0) {
      driver.vehicle_idle = animpos.idle_animstop;
    } else {
      driver.vehicle_idle = animpos.idle_anim;
    }
    wait .25;
  }
}
guy_reaction(guy, pos) {
  animpos = anim_pos(self, pos);
  guy endon("newanim");
  self endon("death");
  guy endon("death");
  if(isDefined(animpos.reaction)) {
    animontag(guy, animpos.sittag, animpos.reaction);
  }
  thread guy_idle(guy, pos);
}
guy_turret_turnleft(guy, pos) {
  animpos = anim_pos(self, pos);
  guy endon("newanim");
  self endon("death");
  guy endon("death");
  while(1) {
    animontag(guy, animpos.sittag, guy.turret_turnleft);
  }
}
guy_turret_turnright(guy, pos) {
  guy endon("newanim");
  self endon("death");
  guy endon("death");
  animpos = anim_pos(self, pos);
  while(1) {
    animontag(guy, animpos.sittag, guy.turret_turnleft);
  }
}
guy_turret_fire(guy, pos) {
  guy endon("newanim");
  self endon("death");
  guy endon("death");
  animpos = anim_pos(self, pos);
  if(isDefined(animpos.turret_fire)) {
    animontag(guy, animpos.sittag, animpos.turret_fire);
  }
  thread guy_idle(guy, pos);
}
guy_idle(guy, pos, ignoredeath) {
  guy endon("newanim");
  if(!isDefined(ignoredeath)) {
    self endon("death");
  }
  guy endon("death");
  guy.vehicle_idling = true;
  guy notify("gotime");
  if(!isDefined(guy.vehicle_idle)) {
    return;
  }
  animpos = anim_pos(self, pos);
  if(isDefined(animpos.mgturret)) {
    return;
  }
  if(isDefined(animpos.hideidle) && animpos.hideidle) {
    guy hide();
  }
  if(isDefined(animpos.idle_animstop) && isDefined(animpos.idle_anim)) {
    thread driver_idle_speed(guy, pos);
  }
  while(1) {
    guy notify("idle");
    if(isDefined(guy.vehicle_idle_override)) {
      animontag(guy, animpos.sittag, guy.vehicle_idle_override);
    } else if(isDefined(animpos.idleoccurrence)) {
      theanim = randomoccurrance(guy, animpos.idleoccurrence);
      animontag(guy, animpos.sittag, guy.vehicle_idle[theanim]);
    } else if(isDefined(guy.playerpiggyback) && isDefined(animpos.player_idle))
      animontag(guy, animpos.sittag, animpos.player_idle);
    else {
      if(isDefined(animpos.vehicle_idle)) {
        self thread setanimrestart_once(animpos.vehicle_idle);
      }
      if(isDefined(guy.do_combat_idle) && guy.do_combat_idle && isDefined(guy.vehicle_idle_combat)) {
        animontag(guy, animpos.sittag, guy.vehicle_idle_combat);
      } else {
        animontag(guy, animpos.sittag, guy.vehicle_idle);
      }
    }
  }
}
randomoccurrance(guy, occurrences) {
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
guy_duck_once_check(guy, pos) {
  return isDefined(anim_pos(self, pos).duck_once);
}
guy_duck_once(guy, pos) {
  guy endon("newanim");
  self endon("death");
  guy endon("death");
  animpos = anim_pos(self, pos);
  if(isDefined(animpos.duck_once)) {
    if(isDefined(animpos.vehicle_duck_once)) {
      self thread setanimrestart_once(animpos.vehicle_duck_once);
    }
    animontag(guy, animpos.sittag, animpos.duck_once);
  }
  thread guy_idle(guy, pos);
}
guy_weave_check(guy, pos) {
  return isDefined(anim_pos(self, pos).weave);
}
guy_weave(guy, pos) {
  guy endon("newanim");
  self endon("death");
  guy endon("death");
  animpos = anim_pos(self, pos);
  if(isDefined(animpos.weave)) {
    if(isDefined(animpos.vehicle_weave)) {
      self thread setanimrestart_once(animpos.vehicle_weave);
    }
    animontag(guy, animpos.sittag, animpos.weave);
  }
  thread guy_idle(guy, pos);
}
guy_duck(guy, pos) {
  guy endon("newanim");
  self endon("death");
  guy endon("death");
  animpos = anim_pos(self, pos);
  if(isDefined(animpos.duckin)) {
    animontag(guy, animpos.sittag, animpos.duckin);
  }
  thread guy_duck_idle(guy, pos);
}
guy_duck_idle(guy, pos) {
  guy endon("newanim");
  self endon("death");
  guy endon("death");
  animpos = anim_pos(self, pos);
  theanim = randomoccurrance(guy, animpos.duckidleoccurrence);
  while(1) {
    animontag(guy, animpos.sittag, animpos.duckidle[theanim]);
  }
}
guy_duck_out(guy, pos) {
  animpos = anim_pos(self, pos);
  if(isDefined(animpos.ducking) && guy.ducking) {
    animontag(guy, animpos.sittag, animpos.duckout);
    guy.ducking = false;
  }
  thread guy_idle(guy, pos);
}
guy_unload_que(guy) {
  self endon("death");
  self.unloadque = array_add(self.unloadque, guy);
  guy waittill_any("death", "jumpedout");
  self.unloadque = array_remove(self.unloadque, guy);
  if(!self.unloadque.size) {
    self notify("unloaded");
    self.unload_group = "default";
  }
}
riders_unloadable(unload_group) {
  if(!self.riders.size) {
    return false;
  }
  for(i = 0; i < self.riders.size; i++) {
    assert(isDefined(self.riders[i].pos));
    if(check_unloadgroup(self.riders[i].pos, unload_group)) {
      return true;
    }
  }
  return false;
}
check_unloadgroup(pos, unload_group) {
  if(!isDefined(unload_group)) {
    unload_group = self.unload_group;
  }
  type = self.vehicletype;
  if(!isDefined(level.vehicle_unloadgroups[type])) {
    return true;
  }
  if(!isDefined(level.vehicle_unloadgroups[type][unload_group])) {
    println("Invalid Unload group on node at origin: " + self.currentnode.origin + " with group:( \"" + unload_group + "\" )");
    println("Unloading everybody");
    return true;
  }
  group = level.vehicle_unloadgroups[type][unload_group];
  for(i = 0; i < group.size; i++) {
    if(pos == group[i]) {
      return true;
    }
    return false;
  }
}
getoutrig_model_idle(model, tag, animation) {
  self endon("unload");
  while(1) {
    animontag(model, tag, animation);
  }
}
getoutrig_model(animpos, model, tag, animation, bIdletillunload) {
  type = self.vehicletype;
  if(bIdletillunload) {
    thread getoutrig_model_idle(model, tag, level.vehicle_attachedmodels[type][animpos.getoutrig].idleanim);
    self waittill("unload");
  }
  self.unloadque = array_add(self.unloadque, model);
  self thread getoutrig_abort(model, tag, animation);
  if(!isDefined(self.crashing)) {
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
  self.getoutrig[animpos.getoutrig] = undefined;
  wait 10;
  model delete();
}
getoutrig_disable_abort_notify_after_riders_out() {
  wait .05;
  while(isalive(self) && self.unloadque.size > 2) {
    wait .05;
  }
  if(!isalive(self) || (isDefined(self.crashing) && self.crashing)) {
    return;
  }
  self notify("getoutrig_disable_abort");
}
getoutrig_abort_while_deploying() {
  self endon("end_getoutrig_abort_while_deploying");
  while(!isDefined(self.crashing)) {
    wait 0.05;
  }
  array_delete(self.riders);
  self notify("crashed_while_deploying");
}
getoutrig_abort(model, tag, animation) {
  totalAnimTime = getanimlength(animation);
  ropesFallAnimTime = totalAnimTime - 1.0;
  if(self.vehicletype == "mi17") {
    ropesFallAnimTime = totalAnimTime - .5;
  }
  ropesDeployedAnimTime = 2.5;
  assert(totalAnimTime > ropesDeployedAnimTime);
  assert(ropesFallAnimTime - ropesDeployedAnimTime > 0);
  self endon("getoutrig_disable_abort");
  thread getoutrig_disable_abort_notify_after_riders_out();
  thread getoutrig_abort_while_deploying();
  waittill_notify_or_timeout("crashed_while_deploying", ropesDeployedAnimTime);
  self notify("end_getoutrig_abort_while_deploying");
  while(!isDefined(self.crashing)) {
    wait 0.05;
  }
  thread animontag(model, tag, animation);
  waittillframeend;
  model setanimtime(animation, ropesFallAnimTime / totalAnimTime);
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
    self.riders[i] damage_notify_wrapper(100, self.riders[i].ridingvehicle);
  }
}
setanimrestart_once(vehicle_anim, bClearAnim) {
  self endon("death");
  self endon("dont_clear_anim");
  if(!isDefined(bClearAnim)) {
    bClearAnim = true;
  }
  cycletime = getanimlength(vehicle_anim);
  self SetAnimRestart(vehicle_anim);
  wait cycletime;
  if(bClearAnim) {
    self clearanim(vehicle_anim, 0);
  }
}
getout_rigspawn(animatemodel, pos, bIdletillunload) {
  if(!isDefined(bIdletillunload)) {
    bIdletillunload = true;
  }
  type = self.vehicletype;
  animpos = anim_pos(self, pos);
  if(isDefined(self.attach_model_override) && isDefined(self.attach_model_override[animpos.getoutrig])) {
    overrridegetoutrig = true;
  } else {
    overrridegetoutrig = false;
  }
  if(!isDefined(animpos.getoutrig) || isDefined(self.getoutrig[animpos.getoutrig]) || overrridegetoutrig) {
    return;
  }
  origin = animatemodel gettagorigin(level.vehicle_attachedmodels[type][animpos.getoutrig].tag);
  angles = animatemodel gettagangles(level.vehicle_attachedmodels[type][animpos.getoutrig].tag);
  self.getoutriganimating[animpos.getoutrig] = true;
  getoutrig_model = spawn("script_model", origin);
  getoutrig_model.angles = angles;
  getoutrig_model.origin = origin;
  getoutrig_model setModel(level.vehicle_attachedmodels[type][animpos.getoutrig].model);
  self.getoutrig[animpos.getoutrig] = getoutrig_model;
  getoutrig_model UseAnimTree(#animtree);
  getoutrig_model linkto(animatemodel, level.vehicle_attachedmodels[type][animpos.getoutrig].tag, (0, 0, 0), (0, 0, 0));
  thread getoutrig_model(animpos, getoutrig_model, level.vehicle_attachedmodels[type][animpos.getoutrig].tag, level.vehicle_attachedmodels[type][animpos.getoutrig].dropanim, bIdletillunload);
  return getoutrig_model;
}
check_sound_tag_dupe(soundtag) {
  if(!isDefined(self.sound_tag_dupe)) {
    self.sound_tag_dupe = [];
  }
  duped = false;
  if(!isDefined(self.sound_tag_dupe[soundtag])) {
    self.sound_tag_dupe[soundtag] = true;
  } else {
    duped = true;
  }
  thread check_sound_tag_dupe_reset(soundtag);
  return duped;
}
check_sound_tag_dupe_reset(soundtag) {
  wait .05;
  if(!isDefined(self)) {
    return;
  }
  self.sound_tag_dupe[soundtag] = false;
  keys = getarraykeys(self.sound_tag_dupe);
  for(i = 0; i < keys.size; i++) {
    if(self.sound_tag_dupe[keys[i]]) {
      return;
    }
    self.sound_tag_dupe = undefined;
  }
}
guy_unload(guy, pos) {
  animpos = anim_pos(self, pos);
  type = self.vehicletype;
  if(!check_unloadgroup(pos)) {
    thread guy_idle(guy, pos);
    return;
  }
  if(!isDefined(animpos.getout)) {
    thread guy_idle(guy, pos);
    return;
  }
  if(isDefined(animpos.hideidle) && animpos.hideidle) {
    guy show();
  }
  thread guy_unload_que(guy);
  self endon("death");
  if(isai(guy) && isalive(guy)) {
    guy endon("death");
  }
  animatemodel = getanimatemodel();
  if(isDefined(animpos.vehicle_getoutanim)) {
    animatemodel thread setanimrestart_once(animpos.vehicle_getoutanim, animpos.vehicle_getoutanim_clear);
    self notify("open_door_climbout");
    sound_tag_dupped = false;
    if(is_true(self._vehicle_use_interior_lights)) {
      self maps\_vehicle::interior_lights_on();
    }
    if(isDefined(animpos.vehicle_getoutsoundtag)) {
      sound_tag_dupped = check_sound_tag_dupe(animpos.vehicle_getoutsoundtag);
      origin = animatemodel gettagorigin(animpos.vehicle_getoutsoundtag);
    } else
      origin = animatemodel.origin;
    if(isDefined(animpos.vehicle_getoutsound)) {
      sound = animpos.vehicle_getoutsound;
    } else {
      sound = "veh_truck_door_open";
    }
    if(!sound_tag_dupped) {
      thread maps\_utility::play_sound_in_space(sound, origin);
    }
    sound_tag_dupped = undefined;
  }
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
    thread guy_idle(guy, pos);
    wait delay;
  }
  hascombatjumpout = isDefined(animpos.getout_combat);
  if(!hascombatjumpout && guy.standing) {
    guy_stand_down(guy, pos);
  } else if(!hascombatjumpout && !guy.vehicle_idling && isDefined(guy.vehicle_idle)) {
    guy waittill("idle");
  }
  guy.deathanim = undefined;
  guy notify("newanim");
  if(isai(guy)) {
    guy pushplayer(true);
  }
  bNoanimUnload = false;
  if(isDefined(animpos.bNoanimUnload)) {
    bNoanimUnload = true;
  } else if(!isDefined(animpos.getout) || (!isDefined(self.script_unloadmgguy) && (isDefined(animpos.bIsgunner) && animpos.bIsgunner)) || isDefined(self.script_keepdriver) && pos == 0) {
    self thread guy_idle(guy, pos);
    return;
  }
  if(guy should_give_orghealth()) {
    guy.health = guy.orghealth;
  }
  guy.orghealth = undefined;
  if(isai(guy) && isalive(guy)) {
    guy endon("death");
  }
  guy.allowdeath = false;
  if(isDefined(animpos.exittag)) {
    tag = animpos.exittag;
  } else {
    tag = animpos.sittag;
  }
  if(hascombatjumpout && guy.standing) {
    animation = animpos.getout_combat;
  } else if(hascombatjumpout && isDefined(guy.do_combat_getout) && (guy.do_combat_getout)) {
    animation = animpos.getout_combat;
  } else if(isDefined(guy.get_out_override)) {
    animation = guy.get_out_override;
  } else if(isDefined(guy.playerpiggyback) && isDefined(animpos.player_getout)) {
    animation = animpos.player_getout;
  } else {
    animation = animpos.getout;
  }
  if(!bNoanimUnload) {
    thread guy_unlink_on_death(guy);
    if(isDefined(animpos.getoutrig)) {
      if(!isDefined(self.getoutrig[animpos.getoutrig])) {
        thread guy_idle(guy, pos);
        getoutrig_model = self getout_rigspawn(animatemodel, guy.pos, false);
      }
    }
    if(isDefined(animpos.getoutsnd)) {
      guy thread play_sound_on_tag(animpos.getoutsnd, "J_Wrist_RI", true);
    }
    if(isDefined(guy.playerpiggyback) && isDefined(animpos.player_getout_sound)) {
      guy thread play_sound_on_entity(animpos.player_getout_sound);
    }
    if(isDefined(animpos.getoutloopsnd)) {
      guy thread play_loop_sound_on_tag(animpos.getoutloopsnd);
    }
    if(isDefined(guy.playerpiggyback) && isDefined(animpos.player_getout_sound_loop)) {
      get_players()[0] thread play_loop_sound_on_entity(animpos.player_getout_sound_loop);
    }
    guy notify("newanim");
    guy notify("jumping_out");
    guy.ragdoll_getout_death = true;
    if(isDefined(animpos.ragdoll_getout_death)) {
      guy.ragdoll_getout_death = true;
      if(isDefined(animpos.ragdoll_fall_anim)) {
        guy.ragdoll_fall_anim = animpos.ragdoll_fall_anim;
      }
    }
    animontag(guy, tag, animation);
    if(isDefined(animpos.getout_secondary)) {
      secondaryunloadtag = tag;
      if(isDefined(animpos.getout_secondary_tag)) {
        secondaryunloadtag = animpos.getout_secondary_tag;
      }
      animontag(guy, secondaryunloadtag, animpos.getout_secondary);
    }
    if(isDefined(guy.playerpiggyback) && isDefined(animpos.player_getout_sound_loop)) {
      get_players()[0] thread stop_loop_sound_on_entity(animpos.player_getout_sound_loop);
    }
    if(isDefined(animpos.getoutloopsnd)) {
      guy thread stop_loop_sound_on_entity(animpos.getoutloopsnd);
    }
    if(isDefined(guy.playerpiggyback) && isDefined(animpos.player_getout_sound_end)) {
      get_players()[0] thread play_sound_on_entity(animpos.player_getout_sound_end);
    }
  }
  self.riders = array_remove(self.riders, guy);
  self.usedPositions[pos] = false;
  guy.ridingvehicle = undefined;
  guy.drivingVehicle = undefined;
  if(!isalive(self) && !isDefined(animpos.unload_ondeath)) {
    guy delete();
    return;
  }
  guy unlink();
  if(!isDefined(guy.magic_bullet_shield)) {
    guy.allowdeath = true;
  }
  if(!isai(guy)) {
    if(is_true(guy.drone_delete_on_unload)) {
      guy delete();
      return;
    }
    guy = make_real_ai(guy);
  }
  if(isalive(guy)) {
    guy.a.disablelongdeath = false;
    guy.forced_startingposition = undefined;
    guy notify("jumpedout");
    if(isDefined(animpos.getoutstance)) {
      guy.desired_anim_pose = animpos.getoutstance;
      guy allowedstances("crouch");
      guy thread animscripts\utility::UpdateAnimPose();
      guy allowedstances("stand", "crouch", "prone");
    }
    guy pushplayer(false);
    qSetGoalPos = false;
    if(guy has_color()) {
      qSetGoalPos = false;
    } else if(!isDefined(guy.target) && !isDefined(guy.script_spawner_targets)) {
      qSetGoalPos = true;
    } else if(!isDefined(guy.script_spawner_targets)) {
      targetedNodes = getNodeArray(guy.target, "targetname");
      if(targetedNodes.size == 0) {
        qSetGoalPos = true;
      }
    }
    if(qSetGoalPos) {
      if(!isDefined(guy.script_goalradius)) {
        guy.goalradius = 600;
      }
      guy setGoalPos(guy.origin);
    }
  }
  if(isDefined(animpos.getout_delete) && animpos.getout_delete) {
    guy delete();
    return;
  }
}
animontag(guy, tag, animation, notetracks, sthreads, flag) {
  guy notify("animontag_thread");
  guy endon("animontag_thread");
  if(!isDefined(flag)) {
    flag = "animontagdone";
  }
  if(isDefined(self.modeldummy)) {
    animatemodel = self.modeldummy;
  } else {
    animatemodel = self;
  }
  if(!isDefined(tag)) {
    org = guy.origin;
    angles = guy.angles;
  } else {
    org = animatemodel gettagOrigin(tag);
    angles = animatemodel gettagAngles(tag);
  }
  if(isDefined(guy.ragdoll_getout_death)) {
    level thread animontag_ragdoll_death(guy, self);
  }
  guy animscripted(flag, org, angles, animation);
  if(isai(guy)) {
    thread DoNoteTracks(guy, animatemodel, flag);
  }
  if(isDefined(notetracks)) {
    for(i = 0; i < notetracks.size; i++) {
      guy waittillmatch(flag, notetracks[i]);
      guy thread[[sthreads[i]]]();
    }
  }
  guy waittillmatch(flag, "end");
  guy notify("anim_on_tag_done");
  guy.ragdoll_getout_death = undefined;
}
animontag_ragdoll_death_watch_for_damage() {
  self endon("anim_on_tag_done");
  while(1) {
    self waittill("damage", damage, attacker, damageDirection, damagePoint, damageMod);
    self notify("vehicle_damage", damage, attacker, damageDirection, damagePoint, damageMod);
  }
}
animontag_ragdoll_death_watch_for_damage_notdone() {
  self endon("anim_on_tag_done");
  while(1) {
    self waittill("damage_notdone", damage, attacker, damageDirection, damagePoint, damageMod);
    self notify("vehicle_damage", damage, attacker, damageDirection, damagePoint, damageMod);
  }
}
animontag_ragdoll_death(guy, vehicle) {
  if(isDefined(guy.magic_bullet_shield) && guy.magic_bullet_shield) {
    return;
  }
  if(!isAI(guy)) {
    guy setCanDamage(true);
  }
  guy endon("anim_on_tag_done");
  guy thread animontag_ragdoll_death_watch_for_damage();
  guy thread animontag_ragdoll_death_watch_for_damage_notdone();
  damage = undefined;
  attacker = undefined;
  damageDirection = undefined;
  damagePoint = undefined;
  damageMod = undefined;
  explosiveDamage = false;
  vehicleallreadydead = vehicle.health <= 0;
  while(true) {
    if(!vehicleallreadydead && !(isDefined(vehicle) && vehicle.health > 0)) {
      break;
    }
    guy waittill("vehicle_damage", damage, attacker, damageDirection, damagePoint, damageMod);
    explosiveDamage = call_overloaded_func("animscripts\pain", "isExplosiveDamageMOD", damageMod);
    if(!isDefined(damage)) {
      continue;
    }
    if(damage < 1) {
      continue;
    }
    if(!isDefined(attacker)) {
      continue;
    }
    if(isDefined(guy.ridingvehicle) && attacker == guy.ridingvehicle) {
      break;
    }
    if(isPlayer(attacker) && (explosiveDamage || !isDefined(guy.allow_ragdoll_getout_death) || guy.allow_ragdoll_getout_death)) {
      break;
    }
  }
  if(!isDefined(guy)) {
    return;
  }
  arcademode_assignpoints("arcademode_score_enemyexitingcar", attacker);
  guy.deathanim = undefined;
  guy.deathFunction = undefined;
  guy.anim_disablePain = true;
  if(isDefined(guy.ragdoll_fall_anim)) {
    moveDelta = getmovedelta(guy.ragdoll_fall_anim, 0, 1);
    groundPos = physicstrace(guy.origin + (0, 0, 16), guy.origin - (0, 0, 10000));
    distanceFromGround = distance(guy.origin + (0, 0, 16), groundPos);
    if(abs(moveDelta[2] + 16) <= abs(distanceFromGround)) {
      guy thread play_sound_on_entity("generic_death_falling");
      guy animscripted("fastrope_fall", guy.origin, guy.angles, guy.ragdoll_fall_anim);
      guy waittillmatch("fastrope_fall", "start_ragdoll");
    }
  }
  if(!isDefined(guy)) {
    return;
  }
  guy.deathanim = undefined;
  guy.deathFunction = undefined;
  guy.anim_disablePain = true;
  guy doDamage(guy.health + 100, attacker.origin, attacker);
  if(explosiveDamage) {
    guy stopanimscripted();
    guy.delayedDeath = false;
    guy.allowDeath = true;
    guy.noGibDeathAnim = true;
    guy.health = guy.maxHealth;
    guy doDamage(guy.health + 100, damagePoint, attacker, -1, "explosive");
  } else {
    guy animscripts\utility::do_ragdoll_death();
  }
}
DoNoteTracks(guy, vehicle, flag) {
  guy endon("newanim");
  vehicle endon("death");
  guy endon("death");
  guy animscripts\shared::DoNoteTracks(flag);
}
animatemoveintoplace(guy, org, angles, movetospotanim) {
  guy animscripted("movetospot", org, angles, movetospotanim);
  guy waittillmatch("movetospot", "end");
}
guy_vehicle_death(guy) {
  animpos = anim_pos(self, guy.pos);
  if(isDefined(animpos.getout)) {
    self endon("unload");
  }
  guy endon("death");
  self endon("forcedremoval");
  self waittill("death");
  if(isDefined(animpos.unload_ondeath) && isDefined(self)) {
    thread guy_idle(guy, guy.pos, true);
    wait animpos.unload_ondeath;
    self.groupedanim_pos = guy.pos;
    self notify("groupedanimevent", "unload");
    return;
  }
  if(isDefined(guy)) {
    origin = guy.origin;
    guy delete();
    [[level.global_kill_func]]("MOD_RIFLE_BULLET", "torso_upper", origin);
  }
}
guy_turn_right_check(guy, pos) {
  return isDefined(anim_pos(self, pos).turn_right);
}
guy_turn_right(guy, pos) {
  guy endon("newanim");
  self endon("death");
  guy endon("death");
  animpos = anim_pos(self, pos);
  if(isDefined(animpos.vehicle_turn_right)) {
    thread setanimrestart_once(animpos.vehicle_turn_right);
  }
  animontag(guy, animpos.sittag, animpos.turn_right);
  thread guy_idle(guy, pos);
}
guy_turn_left(guy, pos) {
  guy endon("newanim");
  self endon("death");
  guy endon("death");
  animpos = anim_pos(self, pos);
  if(isDefined(animpos.vehicle_turn_left)) {
    self thread setanimrestart_once(animpos.vehicle_turn_left);
  }
  animontag(guy, animpos.sittag, animpos.turn_left);
  thread guy_idle(guy, pos);
}
guy_turn_left_check(guy, pos) {
  return isDefined(anim_pos(self, pos).turn_left);
}
guy_turn_hardright(guy, pos) {
  animpos = level.vehicle_aianims[self.vehicletype][pos];
  if(isDefined(animpos.idle_hardright)) {
    guy.vehicle_idle_override = animpos.idle_hardright;
  }
}
guy_turn_hardleft(guy, pos) {
  animpos = level.vehicle_aianims[self.vehicletype][pos];
  if(isDefined(animpos.idle_hardleft)) {
    guy.vehicle_idle_override = animpos.idle_hardleft;
  }
}
guy_drive_reaction(guy, pos) {
  guy endon("newanim");
  self endon("death");
  guy endon("death");
  animpos = anim_pos(self, pos);
  animontag(guy, animpos.sittag, animpos.drive_reaction);
  thread guy_idle(guy, pos);
}
guy_drive_reaction_check(guy, pos) {
  return isDefined(anim_pos(self, pos).drive_reaction);
}
guy_death_fire(guy, pos) {
  guy endon("newanim");
  self endon("death");
  guy endon("death");
  animpos = anim_pos(self, pos);
  animontag(guy, animpos.sittag, animpos.death_fire);
  thread guy_idle(guy, pos);
}
guy_death_fire_check(guy, pos) {
  return isDefined(anim_pos(self, pos).death_fire);
}
guy_move_to_driver(guy, pos) {
  guy endon("newanim");
  self endon("death");
  guy endon("death");
  pos = 0;
  animpos = anim_pos(self, pos);
  guy.pos = 0;
  guy.drivingvehicle = true;
  guy.vehicle_idle = animpos.idle;
  guy.ridingvehicle = self;
  guy.orghealth = guy.health;
  self.attachedguys = array_remove(self.attachedguys, self.attachedguys[1]);
  self.attachedguys[0] = guy;
  if(isDefined(animpos.move_to_driver)) {
    animontag(guy, animpos.sittag, animpos.move_to_driver);
    guy Unlink();
    guy LinkTo(self, animpos.sittag);
  }
  wait(0.05);
  thread guy_idle(guy, pos);
  guy notify("moved_to_driver");
}
ai_wait_go() {
  self endon("death");
  self waittill("loaded");
  self maps\_vehicle::gopath();
}
set_pos(guy, maxpos) {
  pos = undefined;
  script_startingposition = isDefined(guy.script_startingposition);
  if(isDefined(guy.forced_startingposition)) {
    pos = guy.forced_startingposition;
    assertEx(((pos < maxpos) && (pos >= 0)), "script_startingposition on a vehicle rider must be between " + maxpos + " and 0");
    return pos;
  }
  if(script_startingposition && !self.usedpositions[guy.script_startingposition]) {
    pos = guy.script_startingposition;
    assertEx(((pos < maxpos) && (pos >= 0)), "script_startingposition on a vehicle rider must be between " + maxpos + " and 0");
  } else {
    if(script_startingposition) {
      println("vehicle rider with script_startingposition: " + guy.script_startingposition + " and script_vehicleride: " + self.script_vehicleride + " that's been taken");
      assertmsg("startingposition conflict, see console");
    }
    assert(!script_startingposition);
    for(j = 0; j < self.usedPositions.size; j++) {
      if(self.usedPositions[j] == true) {
        continue;
      }
      pos = j;
      break;
    }
  }
  return pos;
}
guy_man_gunner_turret() {
  self notify("animontag_thread");
  self endon("animontag_thread");
  self endon("death");
  self.vehicle endon("death");
  aimBlendTime = .05;
  animLimit = 60;
  animpos = anim_pos(self.vehicle, self.vehicle_pos);
  for(;;) {
    if(IsAI(self)) {
      self AnimMode("point relative");
      org = self.vehicle gettagorigin(animpos.sittag);
      org2 = self.vehicle gettagorigin("tag_gunner_turret1");
    }
    self ClearAnim(%root, aimBlendTime);
    self SetAnim(animpos.idle, 1.0);
    pitchDelta = self.vehicle GetGunnerAnimPitch(animpos.vehiclegunner - 1);
    if(pitchDelta >= 0) {
      if(pitchDelta > animLimit) {
        pitchDelta = animLimit;
      }
      weight = pitchDelta / animLimit;
      self setAnimLimited(animpos.aimdown, weight, aimBlendTime);
      self setAnimLimited(animpos.idle, 1.0 - weight, aimBlendTime);
    } else if(pitchDelta < 0) {
      if(pitchDelta < 0 - animLimit) {
        pitchDelta = 0 - animLimit;
      }
      weight = 0 - (pitchDelta / animLimit);
      self setAnimLimited(animpos.aimup, weight, aimBlendTime);
      self setAnimLimited(animpos.idle, 1.0 - weight, aimBlendTime);
    }
    wait .05;
  }
}
guy_man_turret(guy, pos) {
  animpos = anim_pos(self, pos);
  turret = self.mgturret[animpos.mgturret];
  turret setdefaultdroppitch(0);
  wait(0.1);
  turret endon("death");
  guy endon("death");
  level thread maps\_mgturret::mg42_setdifficulty(turret, getdifficulty());
  turret setmode("auto_ai");
  turret setturretignoregoals(true);
  guy.script_on_vehicle_turret = 1;
  while(1) {
    if(!isDefined(guy getturret())) {
      guy useturret(turret);
    }
    wait 1;
  }
}
guy_unlink_on_death(guy) {
  guy endon("jumpedout");
  guy waittill("death");
  if(isDefined(guy)) {
    guy unlink();
  }
}
blowup_riders() {
  self array_levelthread(self.riders, ::guy_blowup);
}
guy_blowup(guy) {
  if(!isDefined(guy.pos)) {
    return;
  }
  pos = guy.pos;
  anim_pos = anim_pos(self, pos);
  if(!isDefined(anim_pos.explosion_death)) {
    return;
  }
  [[level.global_kill_func]]("MOD_RIFLE_BULLET", "torso_upper", guy.origin);
  guy.deathanim = anim_pos.explosion_death;
  angles = self.angles;
  origin = guy.origin;
  if(isDefined(anim_pos.explosion_death_offset)) {
    origin += vector_scale(anglesToForward(angles), anim_pos.explosion_death_offset[0]);
    origin += vector_scale(anglestoright(angles), anim_pos.explosion_death_offset[1]);
    origin += vector_scale(anglestoup(angles), anim_pos.explosion_death_offset[2]);
  }
  guy = convert_guy_to_drone(guy);
  detach_models_with_substr(guy, "weapon_");
  guy notsolid();
  guy.origin = origin;
  guy.angles = angles;
  guy stopanimscripted();
  guy animscripted("deathanim", origin, angles, anim_pos.explosion_death);
  fraction = .3;
  if(isDefined(anim_pos.explosion_death_ragdollfraction)) {
    fraction = anim_pos.explosion_death_ragdollfraction;
  }
  animlength = getanimlength(anim_pos.explosion_death);
  timer = gettime() + (animlength * 1000);
  wait animlength * fraction;
  force = (0, 0, 1);
  org = guy.origin;
  if(getDvar(#"ragdoll_enable") == "0") {
    guy delete();
    return;
  }
  while(!guy isragdoll() && gettime() < timer) {
    org = guy.origin;
    wait .05;
    force = guy.origin - org;
    guy startragdoll();
  }
  wait .05;
  force = vector_scale(force, 20000);
  for(i = 0; i < 3; i++) {
    if(isDefined(guy)) {
      org = guy.origin;
    }
    wait(0.05);
  }
  if(!guy isragdoll()) {
    guy delete();
  }
}
convert_guy_to_drone(guy, bKeepguy) {
  if(!isDefined(bKeepguy)) {
    bKeepguy = false;
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
  if(!bKeepguy) {
    guy delete();
  }
  model makefakeai();
  return model;
}
vehicle_animate(animation, animtree) {
  self UseAnimTree(animtree);
  self setAnim(animation);
}
vehicle_getInstart(pos) {
  animpos = anim_pos(self, pos);
  return vehicle_getanimstart(animpos.getin, animpos.sittag, pos);
}
vehicle_getanimstart(animation, tag, pos) {
  struct = spawnStruct();
  origin = undefined;
  angles = undefined;
  assert(isDefined(animation));
  org = self gettagorigin(tag);
  ang = self gettagangles(tag);
  origin = getstartorigin(org, ang, animation);
  angles = getstartangles(org, ang, animation);
  struct.origin = origin;
  struct.angles = angles;
  struct.pos = pos;
  return struct;
}
get_availablepositions() {
  vehicleanim = get_aianims();
  availablepositions = [];
  nonanimatedpositions = [];
  for(i = 0; i < self.usedPositions.size; i++) {
    if(!self.usedPositions[i]) {
      if(isDefined(vehicleanim[i].getin)) {
        availablepositions[availablepositions.size] = vehicle_getInstart(i);
      } else {
        nonanimatedpositions[nonanimatedpositions.size] = i;
      }
    }
  }
  struct = spawnStruct();
  struct.availablepositions = availablepositions;
  struct.nonanimatedpositions = nonanimatedpositions;
  return struct;
}
set_walkerpos(guy, maxpos) {
  pos = undefined;
  if(isDefined(guy.script_startingposition)) {
    pos = guy.script_startingposition;
    assertEx(((pos < maxpos) && (pos >= 0)), "script_startingposition on a vehicle rider must be between " + maxpos + " and 0");
  } else {
    pos = -1;
    for(j = 0; j < self.walk_tags_used.size; j++) {
      if(self.walk_tags_used[j] == true) {
        continue;
      }
      pos = j;
      self.walk_tags_used[j] = true;
      break;
    }
    assertEX(pos >= 0, "Vehicle ran out of walking spots. This is usually caused by making more than 6 AI walk with a vehicle.");
  }
  return pos;
}
WalkWithVehicle(guy, pos) {
  if(!isDefined(self.walkers)) {
    self.walkers = [];
  }
  self.walkers[self.walkers.size] = guy;
  if(!isDefined(guy.FollowMode)) {
    guy.FollowMode = "close";
  }
  guy.WalkingVehicle = self;
  if(guy.FollowMode == "close") {
    guy.vehiclewalkmember = pos;
    level thread vehiclewalker_freespot_ondeath(guy);
  }
  guy notify("stop friendly think");
  guy vehiclewalker_updateGoalPos(self, "once");
  guy thread vehiclewalker_removeonunload(self);
  guy thread vehiclewalker_updateGoalPos(self);
  guy thread vehiclewalker_teamUnderAttack();
}
vehiclewalker_removeonunload(vehicle) {
  vehicle endon("death");
  vehicle waittill("unload");
  vehicle.walkers = array_remove(vehicle.walkers, self);
}
shiftSides(side) {
  if(!isDefined(side)) {
    return;
  }
  if((side != "left") && (side != "right")) {
    return;
  }
  if(!isDefined(self.WalkingVehicle)) {
    return;
  }
  if(self.WalkingVehicle.walk_tags[self.vehiclewalkmember].side == side) {
    return;
  }
  for(i = 0; i < self.WalkingVehicle.walk_tags.size; i++) {
    if(self.WalkingVehicle.walk_tags[i].side != side) {
      continue;
    }
    if(self.WalkingVehicle.walk_tags_used[i] == false) {
      if(self.WalkingVehicle getspeedMPH() > 0) {
        self notify("stop updating goalpos");
        self setgoalpos(self.WalkingVehicle.backpos.origin);
        self.WalkingVehicle.walk_tags_used[self.vehiclewalkmember] = false;
        self.vehiclewalkmember = i;
        self.WalkingVehicle.walk_tags_used[self.vehiclewalkmember] = true;
        self waittill("goal");
        self thread vehiclewalker_updateGoalPos(self.WalkingVehicle);
      } else
        self.vehiclewalkmember = i;
      return;
    }
  }
}
vehiclewalker_freespot_ondeath(guy) {
  guy waittill("death");
  if(!isDefined(guy.WalkingVehicle)) {
    return;
  }
  guy.WalkingVehicle.walk_tags_used[guy.vehiclewalkmember] = false;
}
vehiclewalker_teamUnderAttack() {
  self endon("death");
  for(;;) {
    self waittill("damage", amount, attacker);
    if(!isDefined(attacker)) {
      continue;
    }
    if((!isDefined(attacker.team)) || (isPlayer(attacker))) {
      continue;
    }
    if((isDefined(self.RidingTank)) && (isDefined(self.RidingTank.allowUnloadIfAttacked)) && (self.RidingTank.allowUnloadIfAttacked == false)) {
      continue;
    }
    if((isDefined(self.WalkingVehicle)) && (isDefined(self.WalkingVehicle.allowUnloadIfAttacked)) && (self.WalkingVehicle.allowUnloadIfAttacked == false)) {
      continue;
    }
    self.WalkingVehicle.teamUnderAttack = true;
    self.WalkingVehicle notify("unload");
    return;
  }
}
GetNewNodePositionAheadofVehicle(guy) {
  minimumDistance = 300 + (50 * (self getspeedMPH()));
  nextNode = undefined;
  if(!isDefined(self.CurrentNode.target)) {
    return self.origin;
  }
  nextNode = getVehicleNode(self.CurrentNode.target, "targetname");
  if(!isDefined(nextNode)) {
    if(isDefined(guy.NodeAfterVehicleWalk)) {
      return guy.NodeAfterVehicleWalk.origin;
    } else {
      return self.origin;
    }
  }
  if(distance(self.origin, nextNode.origin) >= minimumDistance) {
    return nextNode.origin;
  }
  for(;;) {
    if(distance(self.origin, nextNode.origin) >= minimumDistance) {
      return nextNode.origin;
    }
    if(!isDefined(nextNode.target)) {
      break;
    }
    nextNode = getVehicleNode(nextNode.target, "targetname");
  }
  if(isDefined(guy.NodeAfterVehicleWalk)) {
    return guy.NodeAfterVehicleWalk.origin;
  } else {
    return self.origin;
  }
}
vehiclewalker_updateGoalPos(tank, option) {
  self endon("death");
  tank endon("death");
  self endon("stop updating goalpos");
  self endon("unload");
  for(;;) {
    if(self.FollowMode == "cover nodes") {
      self.oldgoalradius = self.goalradius;
      self.goalradius = 300;
      self.walkdist = 64;
      position = tank GetNewNodePositionAheadofVehicle(self);
    } else {
      self.oldgoalradius = self.goalradius;
      self.goalradius = 2;
      self.walkdist = 64;
      position = tank gettagOrigin(tank.walk_tags[self.vehiclewalkmember]);
    }
    if((isDefined(option)) && (option == "once")) {
      trace = bulletTrace((position + (0, 0, 100)), (position - (0, 0, 500)), false, undefined);
      if(self.FollowMode == "close") {
        self teleport(trace["position"]);
      }
      self setGoalPos(trace["position"]);
      return;
    }
    tankSpeed = tank getspeedmph();
    if(tankSpeed > 0) {
      trace = bulletTrace((position + (0, 0, 100)), (position - (0, 0, 500)), false, undefined);
      self setGoalPos(trace["position"]);
    }
    wait 0.5;
  }
}
getanimatemodel() {
  if(isDefined(self.modeldummy)) {
    return self.modeldummy;
  } else {
    return self;
  }
}
animpos_override_standattack(type, pos, animation) {
  level.vehicle_aianims[type][pos].vehicle_standattack = animation;
}
detach_models_with_substr(guy, substr) {
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
should_give_orghealth() {
  if(!isai(self)) {
    return false;
  }
  if(!isDefined(self.orghealth)) {
    return false;
  }
  return !isDefined(self.magic_bullet_shield);
}
get_aianims() {
  vehicleanims = level.vehicle_aianims[self.vehicletype];
  if(isDefined(self.vehicle_aianims)) {
    keys = GetArrayKeys(vehicleanims);
    for(i = 0; i < keys.size; i++) {
      key = keys[i];
      if(isDefined(self.vehicle_aianims[key])) {
        override = self.vehicle_aianims[key];
        if(isDefined(override.idle)) {
          vehicleanims[key].idle = override.idle;
        }
        if(isDefined(override.getout)) {
          vehicleanims[key].getout = override.getout;
        }
        if(isDefined(override.getin)) {
          vehicleanims[key].getin = override.getin;
        }
        if(isDefined(override.waiting)) {
          vehicleanims[key].waiting = override.waiting;
        }
      }
    }
  }
  return vehicleanims;
}
override_anim(action, tag, animation) {
  pos = anim_pos_from_tag(self, tag);
  AssertEx(isDefined(pos), "_vehicle_aianim::override_anim - No valid position set up for tag '" + tag + "' on vehicle of type '" + self.vehicletype + "'.");
  if(!isDefined(self.vehicle_aianims) || !isDefined(self.vehicle_aianims[pos])) {
    self.vehicle_aianims[pos] = spawnStruct();
  }
  switch (action) {
    case "getin":
      self.vehicle_aianims[pos].getin = animation;
      break;
    case "idle":
      self.vehicle_aianims[pos].idle = animation;
      break;
    case "getout":
      self.vehicle_aianims[pos].getout = animation;
      break;
    default:
      AssertMsg("_vehicle_aianim::override_anim - '" + action + "' action is not supported for overriding the animation.");
  }
}