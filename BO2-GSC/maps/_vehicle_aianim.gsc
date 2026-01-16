/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_vehicle_aianim.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_turret;
#include maps\_vehicle;
#include animscripts\utility;
#include animscripts\shared;

vehicle_enter(vehicle, tag) {
  assert(!isDefined(self.ridingvehicle), "ai can't ride two vehicles at the same time");

  if(isDefined(tag))
    self.forced_startingposition = anim_pos_from_tag(vehicle, tag);

  type = vehicle.vehicletype;
  vehicleanim = vehicle get_aianims();
  maxpos = level.vehicle_aianims[type].size;

  if(isDefined(self.script_vehiclewalk)) {
    pos = set_walkerpos(self, level.vehicle_walkercount[type]);
    vehicle thread walkwithvehicle(self, pos);
    return;
  }

  vehicle.attachedguys[vehicle.attachedguys.size] = self;
  pos = vehicle set_pos(self, maxpos);

  if(!isDefined(pos)) {
    return;
  }
  if(pos == 0)
    self.drivingvehicle = 1;

  animpos = anim_pos(vehicle, pos);
  vehicle.usedpositions[pos] = 1;
  self.pos = pos;

  if(isDefined(animpos.delay)) {
    self.delay = animpos.delay;

    if(isDefined(animpos.delayinc))
      vehicle.delayer = self.delay;
  }

  if(isDefined(animpos.delayinc)) {
    vehicle.delayer = vehicle.delayer + animpos.delayinc;
    self.delay = vehicle.delayer;
  }

  self.ridingvehicle = vehicle;
  self.orghealth = self.health;
  self.vehicle_idle = animpos.idle;
  self.vehicle_idle_combat = animpos.idle_combat;
  self.vehicle_idle_pistol = animpos.idle_pistol;
  self.vehicle_standattack = animpos.standattack;
  self.standing = 0;
  self.allowdeath = 0;

  if(isDefined(self.deathanim) && !isDefined(self.magic_bullet_shield))
    self.allowdeath = 1;

  if(isDefined(animpos.death)) {
    if(!isDefined(self.magic_bullet_shield) || self.magic_bullet_shield == 0)
      vehicle thread guy_death(self, animpos);
  }

  if(!isDefined(self.vehicle_idle))
    self.allowdeath = 1;

  vehicle.riders[vehicle.riders.size] = self;

  if(!isDefined(animpos.explosion_death))
    vehicle thread guy_vehicle_death(self);

  if(self.classname != "script_model" && spawn_failed(self)) {
    return;
  }
  org = vehicle gettagorigin(animpos.sittag);
  angles = vehicle gettagangles(animpos.sittag);
  self linkto(vehicle, animpos.sittag, (0, 0, 0), (0, 0, 0));
  n_turret_index = _get_turret_index_for_tag(animpos.sittag);

  if(isDefined(n_turret_index)) {
    if(isDefined(vehicle get_turret_weapon_name(n_turret_index)))
      vehicle _vehicle_turret_set_user(self, animpos.sittag);
  }

  if(isai(self)) {
    self teleport(org, angles);
    self.a.disablelongdeath = 1;

    if(isDefined(animpos.bhasgunwhileriding) && !animpos.bhasgunwhileriding)
      self gun_remove();

    if(isDefined(animpos.vehiclegunner)) {
      self.vehicle_pos = pos;
      self.vehicle = vehicle;
      self animcustom(::guy_man_gunner_turret);
    } else if(isDefined(animpos.mgturret) && !(isDefined(vehicle.script_nomg) && vehicle.script_nomg > 0))
      vehicle thread guy_man_turret(self, pos);

    if(isDefined(self.script_combat_getout) && self.script_combat_getout)
      self.do_combat_getout = 1;

    if(isDefined(self.script_combat_getout) && self.script_combat_getout > 1) {
      self.do_combat_getout = 0;
      self.do_pistol_getout = 1;
    }

    if(isDefined(self.script_combat_idle) && self.script_combat_idle)
      self.do_combat_idle = 1;

    if(isDefined(self.script_combat_idle) && self.script_combat_idle > 1) {
      self.do_combat_idle = 0;
      self.do_pistol_idle = 1;
    }
  } else {
    if(isDefined(animpos.bhasgunwhileriding) && !animpos.bhasgunwhileriding)
      detach_models_with_substr(self, "weapon_");

    self.origin = org;
    self.angles = angles;

    if(isDefined(animpos.vehiclegunner)) {
      self.vehicle_pos = pos;
      self.vehicle = vehicle;
      self thread guy_man_gunner_turret();
    } else if(isDefined(animpos.mgturret) && !(isDefined(vehicle.script_nomg) && vehicle.script_nomg > 0))
      vehicle thread guy_man_turret(self, pos);
  }

  if(!isDefined(animpos.vehiclegunner)) {
    vehicle thread guy_handle(self, pos);
    vehicle thread guy_idle(self, pos);
  } else
    vehicle thread guy_deathhandle(self, pos);

  self notify("enter_vehicle", vehicle);
  vehicle thread vehicle_handleunloadevent();
}

guy_array_enter(guysarray, vehicle) {
  guysarray = maps\_vehicle::sort_by_startingpos(guysarray);
  lastguy = 0;

  for(i = 0; i < guysarray.size; i++) {
    if(!(i + 1 < guysarray.size))
      lastguy = 1;

    guysarray[i] vehicle_enter(vehicle);
  }
}

handle_attached_guys() {
  type = self.vehicletype;

  if(isDefined(self.script_vehiclewalk)) {
    for(i = 0; i < 6; i++) {
      self.walk_tags[i] = "tag_walker" + i;
      self.walk_tags_used[i] = 0;
    }
  }

  self.attachedguys = [];

  if(!(isDefined(level.vehicle_aianims) && isDefined(level.vehicle_aianims[type]))) {
    return;
  }
  maxpos = level.vehicle_aianims[type].size;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "ai_wait_go")
    thread ai_wait_go();

  self.runningtovehicle = [];
  self.usedpositions = [];
  self.getinorgs = [];
  self.delayer = 0;
  vehicleanim = self get_aianims();

  for(i = 0; i < maxpos; i++) {
    self.usedpositions[i] = 0;

    if(isDefined(self.script_nomg) && self.script_nomg && isDefined(vehicleanim[i].bisgunner) && vehicleanim[i].bisgunner)
      self.usedpositions[1] = 1;
  }
}

load_ai_goddriver(array) {
  load_ai(array, 1);
}

guy_death(guy, animpos) {
  guy endon("death");
  guy endon("jumping_out");
  waittillframeend;
  guy.allowdeath = 0;
  guy.health = 100000;

  while(true) {
    guy waittill("damage");

    if(!isDefined(guy.magic_bullet_shield) || guy.magic_bullet_shield == 0) {
      thread guy_deathimate_me(guy, animpos);
      return;
    }
  }
}

guy_deathimate_me(guy, animpos) {
  animtimer = gettime() + getanimlength(animpos.death) * 1000;
  angles = guy.angles;
  origin = guy.origin;
  guy = convert_guy_to_drone(guy);
  [[level.global_kill_func]]("MOD_RIFLE_BULLET", "torso_upper", origin);
  detach_models_with_substr(guy, "weapon_");
  guy linkto(self, animpos.sittag, (0, 0, 0), (0, 0, 0));
  guy notsolid();
  thread animontag(guy, animpos.sittag, animpos.death);

  if(!isDefined(animpos.death_delayed_ragdoll))
    guy waittillmatch("animontagdone", "start_ragdoll");
  else {
    guy unlink();
    guy startragdoll();
    wait(animpos.death_delayed_ragdoll);
    guy delete();
    return;
  }

  guy unlink();

  if(getdvar(#"ragdoll_enable") == "0") {
    guy delete();
    return;
  }

  while(gettime() < animtimer && !guy isragdoll()) {
    guy startragdoll();
    wait 0.05;
  }

  if(!guy isragdoll())
    guy delete();
  else {
    wait 40;
    guy delete();
  }
}

load_ai(array, bgoddriver) {
  if(!isDefined(bgoddriver))
    bgoddriver = 0;

  if(!isDefined(array))
    array = vehicle_get_riders();

  array_ent_thread(array, ::get_in_vehicle, bgoddriver);
}

is_rider(guy) {
  for(i = 0; i < self.riders.size; i++) {
    if(self.riders[i] == guy)
      return true;
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
  assert(isDefined(self.script_vehicleride), "Tried to get my ride but I have no .script_vehicleride");
  vehicles = getentarray("script_vehicle", "classname");

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

  assert(array.size == 1, "Tried to get my ride but there was zero or multiple rides to choose from");
  return array[0];
}

get_in_vehicle(guy, bgoddriver) {
  if(is_rider(guy)) {
    return;
  }
  if(!handle_detached_guys_check()) {
    return;
  }
  assert(isalive(guy), "tried to load a vehicle with dead guy, check your AI count to assure spawnability of ai's");
  guy run_to_vehicle(self, bgoddriver);
}

handle_detached_guys_check() {
  if(vehicle_hasavailablespots())
    return true;

  assertmsg("script sent too many ai to vehicle( max is: " + level.vehicle_aianims[self.vehicletype].size + " )");
}

vehicle_hasavailablespots() {
  if(level.vehicle_aianims[self.vehicletype].size - self.runningtovehicle.size)
    return true;
  else
    return false;
}

run_to_vehicle_loaded(vehicle) {
  vehicle endon("death");
  self waittill_any("long_death", "death", "enteredvehicle");
  arrayremovevalue(vehicle.runningtovehicle, self);

  if(!vehicle.runningtovehicle.size && vehicle.riders.size && vehicle.usedpositions[0])
    vehicle notify("loaded");
}

remove_magic_bullet_shield_from_guy_on_unload_or_death(guy) {
  self waittill_any("unload", "death");
  guy stop_magic_bullet_shield();
}

run_to_vehicle(vehicle, bgoddriver, seat_tag) {
  if(!isDefined(bgoddriver))
    bgoddriver = 0;

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
  bisgettin = 0;

  for(i = 0; i < vehicleanim.size; i++) {
    if(isDefined(vehicleanim[i].getin)) {
      bisgettin = 1;
      break;
    }
  }

  if(!bisgettin) {
    self notify("enteredvehicle");
    self enter_vehicle(vehicle);
    return;
  }

  while(vehicle getspeedmph() > 1)
    wait 0.05;

  positions = vehicle get_availablepositions();

  if(!vehicle.usedpositions[0]) {
    chosenorg = vehicle vehicle_getinstart(0);

    if(bgoddriver) {
      assert(!isDefined(self.magic_bullet_shield), "magic_bullet_shield guy told to god mode drive a vehicle, you should simply load_ai without the god function for this guy");
      self thread magic_bullet_shield();
      vehicle thread remove_magic_bullet_shield_from_guy_on_unload_or_death(self);
    }
  } else if(isDefined(self.script_startingposition)) {
    position_valid = -1;

    for(i = 0; i < positions.availablepositions.size; i++) {
      if(positions.availablepositions[i].pos == self.script_startingposition)
        position_valid = i;
    }

    if(position_valid > -1)
      chosenorg = positions.availablepositions[position_valid];
    else if(positions.availablepositions.size)
      chosenorg = getclosest(self.origin, positions.availablepositions);
    else
      chosenorg = undefined;
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
  } else if(positions.availablepositions.size)
    chosenorg = getclosest(self.origin, positions.availablepositions);
  else
    chosenorg = undefined;

  if(!positions.availablepositions.size && positions.nonanimatedpositions.size) {
    self notify("enteredvehicle");
    self enter_vehicle(vehicle);
    return;
  } else if(!isDefined(chosenorg)) {
    return;
  }
  self.forced_startingposition = chosenorg.pos;
  vehicle.usedpositions[chosenorg.pos] = 1;
  self.script_moveoverride = 1;
  self notify("stop_going_to_node");

  if(isDefined(vehicleanim[chosenorg.pos].wait_for_notify)) {
    if(isDefined(vehicleanim[chosenorg.pos].waiting)) {
      self set_forcegoal();
      self.goalradius = 64;
      self setgoalpos(chosenorg.origin);
      self waittill("goal");
      self unset_forcegoal();
      self animscripted("anim_wait_done", self.origin, self.angles, vehicleanim[chosenorg.pos].waiting);
      vehicle waittill(vehicleanim[chosenorg.pos].wait_for_notify);
    }
  } else if(isDefined(vehicleanim[chosenorg.pos].wait_for_player)) {
    if(isDefined(vehicleanim[chosenorg.pos].waiting)) {
      self set_forcegoal();
      self.goalradius = 64;
      self setgoalpos(chosenorg.origin);
      self waittill("goal");
      self unset_forcegoal();
      self animscripted("anim_wait_done", self.origin, self.angles, vehicleanim[chosenorg.pos].waiting);

      while(true) {
        on_vehicle = 0;

        for(i = 0; i < vehicleanim[chosenorg.pos].wait_for_player.size; i++) {
          if(vehicleanim[chosenorg.pos].wait_for_player[i] is_on_vehicle(vehicle))
            on_vehicle++;
        }

        if(on_vehicle == vehicleanim[chosenorg.pos].wait_for_player.size) {
          break;
        }

        wait 0.05;
      }
    }
  }

  self set_forcegoal();
  self.goalradius = 16;
  self setgoalpos(chosenorg.origin);
  self waittill("goal");
  self unset_forcegoal();
  self.allowdeath = 0;

  if(isDefined(chosenorg)) {
    if(isDefined(vehicleanim[chosenorg.pos].vehicle_getinanim)) {
      vehicle = vehicle getanimatemodel();
      vehicle thread setanimrestart_once(vehicleanim[chosenorg.pos].vehicle_getinanim, vehicleanim[chosenorg.pos].vehicle_getinanim_clear);
    }

    if(isDefined(vehicleanim[chosenorg.pos].vehicle_getinsoundtag))
      origin = vehicle gettagorigin(vehicleanim[chosenorg.pos].vehicle_getinsoundtag);
    else
      origin = vehicle.origin;

    if(isDefined(vehicleanim[chosenorg.pos].vehicle_getinsound))
      sound = vehicleanim[chosenorg.pos].vehicle_getinsound;
    else
      sound = "veh_truck_door_open";

    vehicle thread maps\_utility::play_sound_in_space(sound, origin);
    vehicle animontag(self, vehicleanim[chosenorg.pos].sittag, vehicleanim[chosenorg.pos].getin);
  }

  self notify("enteredvehicle");
  self enter_vehicle(vehicle);
}

anim_pos(vehicle, pos) {
  return vehicle get_aianims()[pos];
}

anim_pos_from_tag(vehicle, tag) {
  vehicleanims = level.vehicle_aianims[vehicle.vehicletype];
  keys = getarraykeys(vehicleanims);

  for(i = 0; i < keys.size; i++) {
    pos = keys[i];

    if(isDefined(vehicleanims[pos].sittag) && vehicleanims[pos].sittag == tag)
      return pos;
  }
}

guy_deathhandle(guy, pos) {
  guy waittill("death");

  if(!isDefined(self)) {
    return;
  }
  arrayremovevalue(self.riders, guy);
  self.usedpositions[pos] = 0;
}

setup_aianimthreads() {
  if(!isDefined(level.vehicle_aianimthread))
    level.vehicle_aianimthread = [];

  if(!isDefined(level.vehicle_aianimcheck))
    level.vehicle_aianimcheck = [];

  level.vehicle_aianimthread["idle"] = ::guy_idle;
  level.vehicle_aianimthread["duck"] = ::guy_duck;
  level.vehicle_aianimthread["duck_once"] = ::guy_duck_once;
  level.vehicle_aianimcheck["duck_once"] = ::guy_duck_once_check;
  level.vehicle_aianimthread["weave"] = ::guy_weave;
  level.vehicle_aianimcheck["weave"] = ::guy_weave_check;
  level.vehicle_aianimthread["stand"] = ::guy_stand;
  level.vehicle_aianimthread["twitch"] = ::guy_twitch;
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
  guy.vehicle_idling = 1;
  guy.queued_anim_threads = [];
  thread guy_deathhandle(guy, pos);
  thread guy_queue_anim(guy, pos);
  guy endon("death");
  guy endon("jumpedout");

  while(true) {
    self waittill("groupedanimevent", other);

    if(isDefined(level.vehicle_aianimcheck[other]) && ![
        [level.vehicle_aianimcheck[other]]
      ](guy, pos)) {
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
        self.queueanim = 0;
      } else {
        guy notify("newanim");
        guy.queued_anim_threads = [];
        thread[[level.vehicle_aianimthread[other]]](guy, pos);
      }
    } else {
      println("leaaaaaaaaaaaaaak", other);

    }
  }
}

add_anim_queue(guy, sthread) {
  guy.queued_anim_threads[guy.queued_anim_threads.size] = sthread;
}

guy_queue_anim(guy, pos) {
  guy endon("death");
  self endon("death");
  lastanimframe = gettime() - 100;

  while(true) {
    if(guy.queued_anim_threads.size) {
      if(gettime() != lastanimframe)
        guy waittill("anim_on_tag_done");

      if(!guy.queued_anim_threads.size) {
        continue;
      }
      guy notify("newanim");
      thread[[guy.queued_anim_threads[0]]](guy, pos);
      arrayremovevalue(guy.queued_anim_threads, guy.queued_anim_threads[0]);
      wait 0.05;
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

  while(true) {
    timer2 = gettime() + 2000;

    while(gettime() < timer2 && isDefined(guy.enemy))
      animontag(guy, animpos.sittag, guy.vehicle_standattack, undefined, undefined, "firing");

    rnum = randomint(5) + 10;

    for(i = 0; i < rnum; i++)
      animontag(guy, animpos.sittag, animpos.standidle);
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

  while(true) {
    if(self getspeedmph() == 0)
      driver.vehicle_idle = animpos.idle_animstop;
    else
      driver.vehicle_idle = animpos.idle_anim;

    wait 0.25;
  }
}

guy_reaction(guy, pos) {
  animpos = anim_pos(self, pos);
  guy endon("newanim");
  self endon("death");
  guy endon("death");

  if(isDefined(animpos.reaction))
    animontag(guy, animpos.sittag, animpos.reaction);

  thread guy_idle(guy, pos);
}

guy_turret_turnleft(guy, pos) {
  animpos = anim_pos(self, pos);
  guy endon("newanim");
  self endon("death");
  guy endon("death");

  while(true)
    animontag(guy, animpos.sittag, guy.turret_turnleft);
}

guy_turret_turnright(guy, pos) {
  guy endon("newanim");
  self endon("death");
  guy endon("death");
  animpos = anim_pos(self, pos);

  while(true)
    animontag(guy, animpos.sittag, guy.turret_turnleft);
}

guy_turret_fire(guy, pos) {
  guy endon("newanim");
  self endon("death");
  guy endon("death");
  animpos = anim_pos(self, pos);

  if(isDefined(animpos.turret_fire))
    animontag(guy, animpos.sittag, animpos.turret_fire);

  thread guy_idle(guy, pos);
}

guy_idle(guy, pos, ignoredeath) {
  guy endon("newanim");

  if(!isDefined(ignoredeath))
    self endon("death");

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
  if(isDefined(animpos.hideidle) && animpos.hideidle)
    guy hide();

  if(isDefined(animpos.idle_animstop) && isDefined(animpos.idle_anim))
    thread driver_idle_speed(guy, pos);

  while(true) {
    guy notify("idle");

    if(isDefined(guy.vehicle_idle_override))
      animontag(guy, animpos.sittag, guy.vehicle_idle_override);
    else if(isDefined(animpos.idleoccurrence)) {
      theanim = randomoccurrance(guy, animpos.idleoccurrence);
      animontag(guy, animpos.sittag, guy.vehicle_idle[theanim]);
    } else if(isDefined(guy.playerpiggyback) && isDefined(animpos.player_idle))
      animontag(guy, animpos.sittag, animpos.player_idle);
    else {
      if(isDefined(animpos.vehicle_idle))
        self thread setanimrestart_once(animpos.vehicle_idle);

      if(isDefined(guy)) {
        if(isDefined(guy.do_combat_idle) && guy.do_combat_idle && isDefined(guy.vehicle_idle_combat))
          animontag(guy, animpos.sittag, guy.vehicle_idle_combat);
        else if(isDefined(guy.do_pistol_idle) && guy.do_pistol_idle && isDefined(guy.vehicle_idle_pistol))
          animontag(guy, animpos.sittag, guy.vehicle_idle_pistol);
        else
          animontag(guy, animpos.sittag, guy.vehicle_idle);
      }
    }
  }
}

randomoccurrance(guy, occurrences) {
  range = [];
  totaloccurrance = 0;

  for(i = 0; i < occurrences.size; i++) {
    totaloccurrance = totaloccurrance + occurrences[i];
    range[i] = totaloccurrance;
  }

  pick = randomint(totaloccurrance);

  for(i = 0; i < occurrences.size; i++) {
    if(pick < range[i])
      return i;
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
    if(isDefined(animpos.vehicle_duck_once))
      self thread setanimrestart_once(animpos.vehicle_duck_once);

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
    if(isDefined(animpos.vehicle_weave))
      self thread setanimrestart_once(animpos.vehicle_weave);

    animontag(guy, animpos.sittag, animpos.weave);
  }

  thread guy_idle(guy, pos);
}

guy_duck(guy, pos) {
  guy endon("newanim");
  self endon("death");
  guy endon("death");
  animpos = anim_pos(self, pos);

  if(isDefined(animpos.duckin))
    animontag(guy, animpos.sittag, animpos.duckin);

  thread guy_duck_idle(guy, pos);
}

guy_duck_idle(guy, pos) {
  guy endon("newanim");
  self endon("death");
  guy endon("death");
  animpos = anim_pos(self, pos);
  theanim = randomoccurrance(guy, animpos.duckidleoccurrence);

  while(true)
    animontag(guy, animpos.sittag, animpos.duckidle[theanim]);
}

guy_duck_out(guy, pos) {
  animpos = anim_pos(self, pos);

  if(isDefined(animpos.ducking) && guy.ducking) {
    animontag(guy, animpos.sittag, animpos.duckout);
    guy.ducking = 0;
  }

  thread guy_idle(guy, pos);
}

guy_twitch(guy, pos) {
  guy endon("newanim");
  self endon("death");
  guy endon("death");
  animpos = anim_pos(self, pos);

  if(isDefined(animpos.vehicle_idle_twitchin))
    self thread setanimrestart_once(animpos.vehicle_idle_twitchin, 0);

  if(isDefined(animpos.idle_twitchin))
    animontag(guy, animpos.sittag, animpos.idle_twitchin);

  thread guy_twitch_idle(guy, pos);
}

guy_twitch_idle(guy, pos) {
  guy endon("newanim");
  self endon("death");
  guy endon("death");
  animpos = anim_pos(self, pos);

  while(true) {
    theanim = randomint(animpos.idle_twitch.size);
    animontag(guy, animpos.sittag, animpos.idle_twitch[theanim]);
  }
}

guy_unload_que(guy) {
  self endon("death");
  self.unloadque[self.unloadque.size] = guy;
  guy waittill_any("death", "jumpedout");
  arrayremovevalue(self.unloadque, guy);

  if(!self.unloadque.size) {
    self notify("unloaded");
    self.unload_group = "default";
  }
}

riders_unloadable(unload_group) {
  if(!self.riders.size)
    return false;

  for(i = 0; i < self.riders.size; i++) {
    assert(isDefined(self.riders[i].pos));

    if(check_unloadgroup(self.riders[i].pos, unload_group))
      return true;
  }

  return false;
}

check_unloadgroup(pos, unload_group) {
  if(!isDefined(unload_group))
    unload_group = self.unload_group;

  type = self.vehicletype;

  if(!isDefined(level.vehicle_unloadgroups[type]))
    return true;

  if(!isDefined(level.vehicle_unloadgroups[type][unload_group])) {
    println("Invalid Unload group on node at origin: " + self.currentnode.origin + " with group:( \"" + unload_group + "\" )");
    println("Unloading everybody");

    return true;
  }

  group = level.vehicle_unloadgroups[type][unload_group];

  for(i = 0; i < group.size; i++) {
    if(pos == group[i])
      return true;
  }

  return false;
}

getoutrig_model_idle(model, tag, animation) {
  self endon("unload");

  while(true)
    animontag(model, tag, animation);
}

getoutrig_model(animpos, model, tag, animation, bidletillunload) {
  type = self.vehicletype;

  if(bidletillunload) {
    thread getoutrig_model_idle(model, tag, level.vehicle_attachedmodels[type][animpos.getoutrig].idleanim);
    self waittill("unload");
  }

  self.unloadque[self.unloadque.size] = model;
  self thread getoutrig_abort(model, tag, animation);

  if(!isDefined(self.crashing))
    animontag(model, tag, animation);

  model unlink();

  if(!isDefined(self)) {
    model delete();
    return;
  }

  assert(isDefined(self.unloadque));
  arrayremovevalue(self.unloadque, model);

  if(!self.unloadque.size)
    self notify("unloaded");

  self.getoutrig[animpos.getoutrig] = undefined;
  wait 10;
  model delete();
}

getoutrig_disable_abort_notify_after_riders_out() {
  wait 0.05;

  while(isalive(self) && self.unloadque.size > 2)
    wait 0.05;

  if(!isalive(self) || isDefined(self.crashing) && self.crashing) {
    return;
  }
  self notify("getoutrig_disable_abort");
}

getoutrig_abort_while_deploying() {
  self endon("end_getoutrig_abort_while_deploying");

  while(!isDefined(self.crashing))
    wait 0.05;

  array_delete(self.riders);
  self notify("crashed_while_deploying");
}

getoutrig_abort(model, tag, animation) {
  totalanimtime = getanimlength(animation);
  ropesfallanimtime = totalanimtime - 1.0;

  if(self.vehicletype == "mi17")
    ropesfallanimtime = totalanimtime - 0.5;

  assert(totalanimtime > 2.5);
  assert(ropesfallanimtime - 2.5 > 0);
  self endon("getoutrig_disable_abort");
  thread getoutrig_disable_abort_notify_after_riders_out();
  thread getoutrig_abort_while_deploying();
  waittill_notify_or_timeout("crashed_while_deploying", 2.5);
  self notify("end_getoutrig_abort_while_deploying");

  while(!isDefined(self.crashing))
    wait 0.05;

  thread animontag(model, tag, animation);
  waittillframeend;
  model setanimtime(animation, ropesfallanimtime / totalanimtime);

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

setanimrestart_once(vehicle_anim, bclearanim) {
  self endon("death");
  self endon("dont_clear_anim");

  if(!isDefined(bclearanim))
    bclearanim = 1;

  cycletime = getanimlength(vehicle_anim);
  self setanimrestart(vehicle_anim);
  wait(cycletime);

  if(bclearanim)
    self clearanim(vehicle_anim, 0);
}

#using_animtree("generic_human");

getout_rigspawn(animatemodel, pos, bidletillunload) {
  if(!isDefined(bidletillunload))
    bidletillunload = 1;

  type = self.vehicletype;
  animpos = anim_pos(self, pos);

  if(isDefined(self.attach_model_override) && isDefined(self.attach_model_override[animpos.getoutrig]))
    overrridegetoutrig = 1;
  else
    overrridegetoutrig = 0;

  if(!isDefined(animpos.getoutrig) || isDefined(self.getoutrig[animpos.getoutrig]) || overrridegetoutrig) {
    return;
  }
  origin = animatemodel gettagorigin(level.vehicle_attachedmodels[type][animpos.getoutrig].tag);
  angles = animatemodel gettagangles(level.vehicle_attachedmodels[type][animpos.getoutrig].tag);
  self.getoutriganimating[animpos.getoutrig] = 1;
  getoutrig_model = spawn("script_model", origin);
  getoutrig_model.angles = angles;
  getoutrig_model.origin = origin;
  getoutrig_model setmodel(level.vehicle_attachedmodels[type][animpos.getoutrig].model);
  self.getoutrig[animpos.getoutrig] = getoutrig_model;
  getoutrig_model useanimtree(#animtree);
  getoutrig_model setforcenocull();
  getoutrig_model linkto(animatemodel, level.vehicle_attachedmodels[type][animpos.getoutrig].tag, (0, 0, 0), (0, 0, 0));
  thread getoutrig_model(animpos, getoutrig_model, level.vehicle_attachedmodels[type][animpos.getoutrig].tag, level.vehicle_attachedmodels[type][animpos.getoutrig].dropanim, bidletillunload);
  return getoutrig_model;
}

check_sound_tag_dupe(soundtag) {
  if(!isDefined(self.sound_tag_dupe))
    self.sound_tag_dupe = [];

  duped = 0;

  if(!isDefined(self.sound_tag_dupe[soundtag]))
    self.sound_tag_dupe[soundtag] = 1;
  else
    duped = 1;

  thread check_sound_tag_dupe_reset(soundtag);
  return duped;
}

check_sound_tag_dupe_reset(soundtag) {
  wait 0.05;

  if(!isDefined(self)) {
    return;
  }
  self.sound_tag_dupe[soundtag] = 0;
  keys = getarraykeys(self.sound_tag_dupe);

  for(i = 0; i < keys.size; i++) {
    if(self.sound_tag_dupe[keys[i]])
      return;
  }

  self.sound_tag_dupe = undefined;
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

  if(isDefined(animpos.hideidle) && animpos.hideidle)
    guy show();

  if(isDefined(guy.script_toggletakedamage))
    guy.takedamage = guy.script_toggletakedamage;

  self thread guy_unload_que(guy);
  self endon("death");

  if(isai(guy) && isalive(guy))
    guy endon("death");

  animatemodel = getanimatemodel();

  if(isDefined(self.script_combat_getout) && self.script_combat_getout > 1) {
    if(isDefined(animpos.vehicle_getoutanim_pistol)) {
      animatemodel thread setanimrestart_once(animpos.vehicle_getoutanim_pistol, animpos.vehicle_getoutanim_clear);
      self notify("open_door_climbout");
      sound_tag_dupped = 0;

      if(isDefined(animpos.vehicle_getoutsoundtag)) {
        sound_tag_dupped = check_sound_tag_dupe(animpos.vehicle_getoutsoundtag);
        origin = animatemodel gettagorigin(animpos.vehicle_getoutsoundtag);
      } else
        origin = animatemodel.origin;

      sound = isDefined(animpos.vehicle_getoutsound) ? animpos.vehicle_getoutsound : "veh_truck_door_open";

      if(!sound_tag_dupped)
        self thread maps\_utility::play_sound_in_space(sound, origin);

      sound_tag_dupped = undefined;
    }
  } else if(isDefined(animpos.vehicle_getoutanim)) {
    animatemodel thread setanimrestart_once(animpos.vehicle_getoutanim, animpos.vehicle_getoutanim_clear);
    self notify("open_door_climbout");
    sound_tag_dupped = 0;

    if(isDefined(animpos.vehicle_getoutsoundtag)) {
      sound_tag_dupped = check_sound_tag_dupe(animpos.vehicle_getoutsoundtag);
      origin = animatemodel gettagorigin(animpos.vehicle_getoutsoundtag);
    } else
      origin = animatemodel.origin;

    sound = isDefined(animpos.vehicle_getoutsound) ? animpos.vehicle_getoutsound : "veh_truck_door_open";

    if(!sound_tag_dupped)
      self thread maps\_utility::play_sound_in_space(sound, origin);

    sound_tag_dupped = undefined;
  }

  delay = 0;

  if(isDefined(animpos.getout_timed_anim))
    delay = delay + getanimlength(animpos.getout_timed_anim);

  if(isDefined(animpos.delay))
    delay = delay + animpos.delay;

  if(isDefined(guy.delay))
    delay = delay + guy.delay;

  if(delay > 0) {
    thread guy_idle(guy, pos);
    wait(delay);
  }

  hascombatjumpout = isDefined(animpos.getout_combat);
  haspistoljumpout = isDefined(animpos.getout_pistol);

  if(!hascombatjumpout && guy.standing)
    guy_stand_down(guy, pos);
  else if(!hascombatjumpout && !guy.vehicle_idling && isDefined(guy.vehicle_idle))
    guy waittill("idle");

  guy.deathanim = undefined;
  guy notify("newanim");

  if(isai(guy))
    guy pushplayer(1);

  bnoanimunload = 0;

  if(isDefined(animpos.bnoanimunload))
    bnoanimunload = 1;
  else if(!isDefined(animpos.getout) || !isDefined(self.script_unloadmgguy) && (isDefined(animpos.bisgunner) && animpos.bisgunner) || isDefined(self.script_keepdriver) && pos == 0) {
    self thread guy_idle(guy, pos);
    return;
  }

  if(guy should_give_orghealth())
    guy.health = guy.orghealth;

  guy.orghealth = undefined;

  if(isai(guy) && isalive(guy))
    guy endon("death");

  guy.allowdeath = 0;

  if(isDefined(animpos.exittag))
    tag = animpos.exittag;
  else
    tag = animpos.sittag;

  if(hascombatjumpout && guy.standing)
    animation = animpos.getout_combat;
  else if(hascombatjumpout && isDefined(guy.do_combat_getout) && guy.do_combat_getout)
    animation = animpos.getout_combat;
  else if(haspistoljumpout && (isDefined(guy.do_pistol_getout) && guy.do_pistol_getout))
    animation = animpos.getout_pistol;
  else if(isDefined(guy.get_out_override))
    animation = guy.get_out_override;
  else if(isDefined(guy.playerpiggyback) && isDefined(animpos.player_getout))
    animation = animpos.player_getout;
  else
    animation = animpos.getout;

  _vehicle_turret_clear_user(guy, animpos.sittag);

  if(!bnoanimunload) {
    self thread guy_unlink_on_death(guy);

    if(isDefined(animpos.getoutrig)) {
      if(!isDefined(self.getoutrig[animpos.getoutrig])) {
        thread guy_idle(guy, pos);
        getoutrig_model = self getout_rigspawn(animatemodel, guy.pos, 0);
      }
    }

    if(isDefined(animpos.getoutsnd))
      guy thread play_sound_on_tag(animpos.getoutsnd, "J_Wrist_RI", 1);

    if(isDefined(guy.playerpiggyback) && isDefined(animpos.player_getout_sound))
      guy thread play_sound_on_entity(animpos.player_getout_sound);

    if(isDefined(animpos.getoutloopsnd))
      guy thread play_loop_sound_on_tag(animpos.getoutloopsnd);

    if(isDefined(guy.playerpiggyback) && isDefined(animpos.player_getout_sound_loop))
      get_players()[0] thread play_loop_sound_on_entity(animpos.player_getout_sound_loop);

    guy notify("newanim");
    guy notify("jumping_out");

    if(guy.ridingvehicle.vehicleclass == "helicopter")
      guy.b_rappelling = 1;

    guy.ragdoll_getout_death = 1;

    if(isDefined(animpos.ragdoll_getout_death)) {
      guy.ragdoll_getout_death = 1;

      if(isDefined(animpos.ragdoll_fall_anim))
        guy.ragdoll_fall_anim = animpos.ragdoll_fall_anim;
    }

    animontag(guy, tag, animation);

    if(isDefined(animpos.getout_secondary)) {
      secondaryunloadtag = tag;

      if(isDefined(animpos.getout_secondary_tag))
        secondaryunloadtag = animpos.getout_secondary_tag;

      animontag(guy, secondaryunloadtag, animpos.getout_secondary);
    }

    if(isDefined(guy.playerpiggyback) && isDefined(animpos.player_getout_sound_loop))
      get_players()[0] thread stop_loop_sound_on_entity(animpos.player_getout_sound_loop);

    if(isDefined(animpos.getoutloopsnd))
      guy thread stop_loop_sound_on_entity(animpos.getoutloopsnd);

    if(isDefined(guy.playerpiggyback) && isDefined(animpos.player_getout_sound_end))
      get_players()[0] thread play_sound_on_entity(animpos.player_getout_sound_end);
  }

  arrayremovevalue(self.riders, guy);
  self.usedpositions[pos] = 0;
  guy.ridingvehicle = undefined;
  guy.drivingvehicle = undefined;
  guy notify("exit_vehicle");

  if(isDefined(guy.b_rappelling) && guy.b_rappelling)
    level notify("helicopter_unloaded_ai", guy);

  guy.b_rappelling = 0;

  if(!isalive(self) && !isDefined(animpos.unload_ondeath)) {
    guy delete();
    return;
  }

  guy unlink();

  if(!isDefined(guy.magic_bullet_shield))
    guy.allowdeath = 1;

  if(!isai(guy)) {
    guy delete();
    return;
  } else if(!isDefined(guy.script_noteworthy) && !isDefined("delete_on_unload") || isDefined(guy.script_noteworthy) && isDefined("delete_on_unload") && guy.script_noteworthy == "delete_on_unload") {
    guy delete();
    return;
  }

  if(isDefined(animpos.getout_delete) && animpos.getout_delete) {
    guy delete();
    return;
  }

  if(isalive(guy)) {
    guy.a.disablelongdeath = 0;
    guy.forced_startingposition = undefined;
    guy notify("jumpedout");

    if(isDefined(animpos.getoutstance)) {
      guy.desired_anim_pose = animpos.getoutstance;
      guy allowedstances("crouch");
      guy thread animscripts\utility::updateanimpose();
      guy allowedstances("stand", "crouch", "prone");
    }

    guy pushplayer(0);
    qsetgoalpos = 0;

    if(guy has_color())
      qsetgoalpos = 0;
    else if(!isDefined(guy.target) && !isDefined(guy.script_spawner_targets))
      qsetgoalpos = 1;
    else if(!isDefined(guy.script_spawner_targets)) {
      targetednodes = getnodearray(guy.target, "targetname");

      if(targetednodes.size == 0)
        qsetgoalpos = 1;
    }

    if(qsetgoalpos) {
      if(!isDefined(guy.script_goalradius))
        guy.goalradius = 600;

      guy setgoalpos(guy.origin);
    }
  }
}

animontag(guy, tag, animation, notetracks, sthreads, flag) {
  guy notify("animontag_thread");
  guy endon("animontag_thread");

  if(!isDefined(flag))
    flag = "animontagdone";

  if(isDefined(self.modeldummy))
    animatemodel = self.modeldummy;
  else
    animatemodel = self;

  if(!isDefined(tag)) {
    org = guy.origin;
    angles = guy.angles;
  } else {
    org = animatemodel gettagorigin(tag);
    angles = animatemodel gettagangles(tag);
  }

  if(isDefined(guy.ragdoll_getout_death))
    level thread animontag_ragdoll_death(guy, self);

  guy animscripted(flag, org, angles, animation);

  if(isai(guy))
    thread donotetracks(guy, animatemodel, flag);

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

  while(true) {
    self waittill("damage", damage, attacker, damagedirection, damagepoint, damagemod);
    self notify("vehicle_damage", damage, attacker, damagedirection, damagepoint, damagemod);
  }
}

animontag_ragdoll_death_watch_for_damage_notdone() {
  self endon("anim_on_tag_done");

  while(true) {
    self waittill("damage_notdone", damage, attacker, damagedirection, damagepoint, damagemod);
    self notify("vehicle_damage", damage, attacker, damagedirection, damagepoint, damagemod);
  }
}

animontag_ragdoll_death(guy, vehicle) {
  if(isDefined(guy.magic_bullet_shield) && guy.magic_bullet_shield) {
    return;
  }
  if(!isai(guy))
    guy setcandamage(1);

  guy endon("anim_on_tag_done");
  guy thread animontag_ragdoll_death_watch_for_damage();
  guy thread animontag_ragdoll_death_watch_for_damage_notdone();
  damage = undefined;
  attacker = undefined;
  damagedirection = undefined;
  damagepoint = undefined;
  damagemod = undefined;
  explosivedamage = 0;
  vehicleallreadydead = vehicle.health <= 0;

  while(true) {
    if(!vehicleallreadydead && !(isDefined(vehicle) && vehicle.health > 0)) {
      break;
    }

    guy waittill("vehicle_damage", damage, attacker, damagedirection, damagepoint, damagemod);
    explosivedamage = isexplosivedamagemod(damagemod);

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

    if(isplayer(attacker) && (explosivedamage || !isDefined(guy.allow_ragdoll_getout_death) || guy.allow_ragdoll_getout_death)) {
      break;
    }
  }

  if(!isDefined(guy)) {
    return;
  }
  guy.deathanim = undefined;
  guy.deathfunction = undefined;
  guy.anim_disablepain = 1;

  if(isDefined(guy.ragdoll_fall_anim)) {
    movedelta = getmovedelta(guy.ragdoll_fall_anim, 0, 1);
    groundpos = physicstrace(guy.origin + vectorscale((0, 0, 1), 16.0), guy.origin - vectorscale((0, 0, 1), 10000.0));
    distancefromground = distance(guy.origin + vectorscale((0, 0, 1), 16.0), groundpos);

    if(abs(movedelta[2] + 16) <= abs(distancefromground)) {
      guy thread play_sound_on_entity("generic_death_falling");
      guy animscripted("fastrope_fall", guy.origin, guy.angles, guy.ragdoll_fall_anim);
      guy waittillmatch("fastrope_fall", "start_ragdoll");
    }
  }

  if(!isDefined(guy)) {
    return;
  }
  guy.deathanim = undefined;
  guy.deathfunction = undefined;
  guy.anim_disablepain = 1;
  guy dodamage(guy.health + 100, attacker.origin, attacker);

  if(explosivedamage) {
    guy stopanimscripted();
    guy.delayeddeath = 0;
    guy.allowdeath = 1;
    guy.nogibdeathanim = 1;
    guy.health = guy.maxhealth;
    guy dodamage(guy.health + 100, damagepoint, attacker, -1, "explosive");
  } else
    guy animscripts\utility::do_ragdoll_death();
}

isexplosivedamagemod(mod) {
  if(!isDefined(mod))
    return false;

  if(mod == "MOD_GRENADE" || mod == "MOD_GRENADE_SPLASH" || mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH" || mod == "MOD_EXPLOSIVE")
    return true;

  return false;
}

donotetracks(guy, vehicle, flag) {
  guy endon("newanim");
  vehicle endon("death");
  guy endon("death");
  guy animscripts\shared::donotetracks(flag);
}

animatemoveintoplace(guy, org, angles, movetospotanim) {
  guy animscripted("movetospot", org, angles, movetospotanim);
  guy waittillmatch("movetospot", "end");
}

guy_vehicle_death(guy) {
  animpos = anim_pos(self, guy.pos);

  if(isDefined(animpos.getout))
    self endon("unload");

  guy endon("death");
  self endon("forcedremoval");
  self waittill("death");

  if(isDefined(animpos.unload_ondeath) && isDefined(self)) {
    thread guy_idle(guy, guy.pos, 1);
    wait(animpos.unload_ondeath);
    self.groupedanim_pos = guy.pos;
    self notify("groupedanimevent", "unload");
    return;
  }

  if(isDefined(guy)) {
    origin = guy.origin;
    guy delete();
    [
      [level.global_kill_func]
    ]("MOD_RIFLE_BULLET", "torso_upper", origin);
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

  if(isDefined(animpos.vehicle_turn_right))
    thread setanimrestart_once(animpos.vehicle_turn_right);

  animontag(guy, animpos.sittag, animpos.turn_right);
  thread guy_idle(guy, pos);
}

guy_turn_left(guy, pos) {
  guy endon("newanim");
  self endon("death");
  guy endon("death");
  animpos = anim_pos(self, pos);

  if(isDefined(animpos.vehicle_turn_left))
    self thread setanimrestart_once(animpos.vehicle_turn_left);

  animontag(guy, animpos.sittag, animpos.turn_left);
  thread guy_idle(guy, pos);
}

guy_turn_left_check(guy, pos) {
  return isDefined(anim_pos(self, pos).turn_left);
}

guy_turn_hardright(guy, pos) {
  animpos = level.vehicle_aianims[self.vehicletype][pos];

  if(isDefined(animpos.idle_hardright))
    guy.vehicle_idle_override = animpos.idle_hardright;
}

guy_turn_hardleft(guy, pos) {
  animpos = level.vehicle_aianims[self.vehicletype][pos];

  if(isDefined(animpos.idle_hardleft))
    guy.vehicle_idle_override = animpos.idle_hardleft;
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
  guy.drivingvehicle = 1;
  guy.vehicle_idle = animpos.idle;
  guy.ridingvehicle = self;
  guy.orghealth = guy.health;
  arrayremovevalue(self.attachedguys, self.attachedguys[1]);
  self.attachedguys[0] = guy;

  if(isDefined(animpos.move_to_driver)) {
    animontag(guy, animpos.sittag, animpos.move_to_driver);
    guy unlink();
    guy linkto(self, animpos.sittag);
  }

  wait 0.05;
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
    assert(pos < maxpos && pos >= 0, "script_startingposition on a vehicle rider must be between " + maxpos + " and 0");
    return pos;
  }

  if(script_startingposition && !self.usedpositions[guy.script_startingposition]) {
    pos = guy.script_startingposition;
    assert(pos < maxpos && pos >= 0, "script_startingposition on a vehicle rider must be between " + maxpos + " and 0");
  } else {
    if(script_startingposition) {
      println("vehicle rider with script_startingposition: " + guy.script_startingposition + " and script_vehicleride: " + self.script_vehicleride + " that's been taken");

      assertmsg("startingposition conflict, see console");

    }

    lowestpassengerindex = 0;

    if(isDefined(self.vehicle_passengersonly) && self.vehicle_passengersonly && isDefined(self.vehicle_numdrivers))
      lowestpassengerindex = self.vehicle_numdrivers;

    for(j = lowestpassengerindex; j < self.usedpositions.size; j++) {
      if(self.usedpositions[j] == 1) {
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
  animpos = anim_pos(self.vehicle, self.vehicle_pos);

  for(;;) {
    if(isai(self)) {
      self animmode("point relative");
      org = self.vehicle gettagorigin(animpos.sittag);
      org2 = self.vehicle gettagorigin("tag_gunner_turret1");

      recordline(self.vehicle.origin, org, (1, 0, 0), "Script", self);
      recordline(self.vehicle.origin, org2, (0, 1, 0), "Script", self);

    }

    if(isDefined(self.vehicle.stunned) && isDefined(animpos.stunned)) {
      self setanimknobrestart(animpos.stunned, 1.0, 0.25, 1.0);

      while(isDefined(self.vehicle.stunned))
        wait 0.1;
    }

    self clearanim( % root, 0.05);
    firing = self.vehicle isgunnerfiring(animpos.vehiclegunner - 1);
    baseanim = isDefined(animpos.fire) && firing ? animpos.fire : animpos.idle;
    upanim = isDefined(animpos.fireup) && firing ? animpos.fireup : animpos.aimup;
    downanim = isDefined(animpos.firedown) && firing ? animpos.firedown : animpos.aimdown;
    vehicle_baseanim = isDefined(animpos.vehicle_fire) && firing ? animpos.vehicle_fire : animpos.vehicle_idle;
    vehicle_upanim = isDefined(animpos.vehicle_fireup) && firing ? animpos.vehicle_fireup : animpos.vehicle_aimup;
    vehicle_downanim = isDefined(animpos.vehicle_firedown) && firing ? animpos.vehicle_firedown : animpos.vehicle_aimdown;
    self setanim(baseanim, 1.0);

    if(isDefined(vehicle_baseanim))
      self.vehicle setanim(vehicle_baseanim, 1.0);

    pitchdelta = self.vehicle getgunneranimpitch(animpos.vehiclegunner - 1);

    if(pitchdelta >= 0) {
      if(pitchdelta > 60)
        pitchdelta = 60;

      weight = pitchdelta / 60;
      self setanimlimited(downanim, weight, 0.05);
      self setanimlimited(baseanim, 1.0 - weight, 0.05);
    } else if(pitchdelta < 0) {
      if(pitchdelta < 0 - 60)
        pitchdelta = 0 - 60;

      weight = 0 - pitchdelta / 60;
      self setanimlimited(upanim, weight, 0.05);
      self setanimlimited(baseanim, 1.0 - weight, 0.05);
    }

    wait 0.05;
  }
}

guy_man_turret(guy, pos) {
  animpos = anim_pos(self, pos);
  turret = self.mgturret[animpos.mgturret];
  turret setdefaultdroppitch(0);
  wait 0.1;
  turret endon("death");
  guy endon("death");
  turret setmode("auto_ai");
  turret setturretignoregoals(1);
  guy.script_on_vehicle_turret = 1;

  while(true) {
    if(!isDefined(guy getturret()))
      guy useturret(turret);

    wait 1;
  }
}

guy_unlink_on_death(guy) {
  guy endon("jumpedout");
  guy waittill("death");

  if(isDefined(guy))
    guy unlink();
}

blowup_riders() {
  self array_ent_thread(self.riders, ::guy_blowup);
}

guy_blowup(guy) {
  if(!isDefined(guy) || !isDefined(guy.pos)) {
    return;
  }
  pos = guy.pos;
  anim_pos = anim_pos(self, pos);

  if(!isDefined(anim_pos.explosion_death)) {
    return;
  }
  [[level.global_kill_func]]("MOD_RIFLE_BULLET", "torso_upper", guy.origin);
  deathanim = anim_pos.explosion_death;

  if(isDefined(guy.explosion_death_override))
    deathanim = guy.explosion_death_override;

  angles = self.angles;
  origin = guy.origin;

  if(isDefined(anim_pos.explosion_death_offset)) {
    origin = origin + vectorscale(anglestoforward(angles), anim_pos.explosion_death_offset[0]);
    origin = origin + vectorscale(anglestoright(angles), anim_pos.explosion_death_offset[1]);
    origin = origin + vectorscale(anglestoup(angles), anim_pos.explosion_death_offset[2]);
  }

  guy = convert_guy_to_drone(guy);
  detach_models_with_substr(guy, "weapon_");
  guy notsolid();
  guy.origin = origin;
  guy.angles = angles;
  guy stopanimscripted();
  guy animscripted("deathanim", origin, angles, deathanim);
  fraction = 0.3;

  if(isDefined(anim_pos.explosion_death_ragdollfraction))
    fraction = anim_pos.explosion_death_ragdollfraction;

  animlength = getanimlength(anim_pos.explosion_death);
  timer = gettime() + animlength * 1000;
  wait(animlength * fraction);
  force = (0, 0, 1);
  org = guy.origin;

  if(getdvar(#"ragdoll_enable") == "0") {
    guy delete();
    return;
  }

  while(!guy isragdoll() && gettime() < timer) {
    org = guy.origin;
    wait 0.05;
    force = guy.origin - org;
    guy startragdoll();
  }

  wait 0.05;
  force = vectorscale(force, 20000);

  for(i = 0; i < 3; i++) {
    if(isDefined(guy))
      org = guy.origin;

    wait 0.05;
  }

  if(!guy isragdoll())
    guy delete();
  else {
    wait 40;
    guy delete();
  }
}

convert_guy_to_drone(guy, bkeepguy) {
  if(!isDefined(bkeepguy))
    bkeepguy = 0;

  model = spawn("script_model", guy.origin);
  model.angles = guy.angles;
  model setmodel(guy.model);
  size = guy getattachsize();

  for(i = 0; i < size; i++)
    model attach(guy getattachmodelname(i), guy getattachtagname(i));

  model useanimtree(#animtree);

  if(isDefined(guy.team))
    model.team = guy.team;

  if(!bkeepguy)
    guy delete();

  model makefakeai();
  return model;
}

vehicle_animate(animation, animtree) {
  self useanimtree(animtree);
  self setanim(animation);
}

vehicle_getinstart(pos) {
  animpos = anim_pos(self, pos);
  return vehicle_getanimstart(animpos.getin, animpos.sittag, pos);
}

vehicle_getanimstart(animation, tag, pos) {
  struct = spawnstruct();
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

  for(i = 0; i < self.usedpositions.size; i++) {
    if(!self.usedpositions[i]) {
      if(isDefined(vehicleanim[i].getin)) {
        availablepositions[availablepositions.size] = vehicle_getinstart(i);
        continue;
      }

      nonanimatedpositions[nonanimatedpositions.size] = i;
    }
  }

  struct = spawnstruct();
  struct.availablepositions = availablepositions;
  struct.nonanimatedpositions = nonanimatedpositions;
  return struct;
}

set_walkerpos(guy, maxpos) {
  pos = undefined;

  if(isDefined(guy.script_startingposition)) {
    pos = guy.script_startingposition;
    assert(pos < maxpos && pos >= 0, "script_startingposition on a vehicle rider must be between " + maxpos + " and 0");
  } else {
    pos = -1;

    for(j = 0; j < self.walk_tags_used.size; j++) {
      if(self.walk_tags_used[j] == 1) {
        continue;
      }
      pos = j;
      self.walk_tags_used[j] = 1;
      break;
    }

    assert(pos >= 0, "Vehicle ran out of walking spots. This is usually caused by making more than 6 AI walk with a vehicle.");
  }

  return pos;
}

walkwithvehicle(guy, pos) {
  if(!isDefined(self.walkers))
    self.walkers = [];

  self.walkers[self.walkers.size] = guy;

  if(!isDefined(guy.followmode))
    guy.followmode = "close";

  guy.walkingvehicle = self;

  if(guy.followmode == "close") {
    guy.vehiclewalkmember = pos;
    level thread vehiclewalker_freespot_ondeath(guy);
  }

  guy notify("stop friendly think");
  guy vehiclewalker_updategoalpos(self, "once");
  guy thread vehiclewalker_removeonunload(self);
  guy thread vehiclewalker_updategoalpos(self);
  guy thread vehiclewalker_teamunderattack();
}

vehiclewalker_removeonunload(vehicle) {
  vehicle endon("death");
  vehicle waittill("unload");
  arrayremovevalue(vehicle.walkers, self);
}

shiftsides(side) {
  if(!isDefined(side)) {
    return;
  }
  if(side != "left" && side != "right") {
    iprintln("Valid sides are 'left' and 'right' only");

    return;
  }

  if(!isDefined(self.walkingvehicle)) {
    return;
  }
  if(self.walkingvehicle.walk_tags[self.vehiclewalkmember].side == side) {
    return;
  }
  for(i = 0; i < self.walkingvehicle.walk_tags.size; i++) {
    if(self.walkingvehicle.walk_tags[i].side != side) {
      continue;
    }
    if(self.walkingvehicle.walk_tags_used[i] == 0) {
      if(self.walkingvehicle getspeedmph() > 0) {
        self notify("stop updating goalpos");
        self setgoalpos(self.walkingvehicle.backpos.origin);
        self.walkingvehicle.walk_tags_used[self.vehiclewalkmember] = 0;
        self.vehiclewalkmember = i;
        self.walkingvehicle.walk_tags_used[self.vehiclewalkmember] = 1;
        self waittill("goal");
        self thread vehiclewalker_updategoalpos(self.walkingvehicle);
      } else
        self.vehiclewalkmember = i;

      return;
    }

    iprintln("TANKAI: Guy couldn't move to the " + side + " side of the tank because no positions on that side are free");

  }
}

vehiclewalker_freespot_ondeath(guy) {
  guy waittill("death");

  if(!isDefined(guy.walkingvehicle)) {
    return;
  }
  guy.walkingvehicle.walk_tags_used[guy.vehiclewalkmember] = 0;
}

vehiclewalker_teamunderattack() {
  self endon("death");

  for(;;) {
    self waittill("damage", amount, attacker);

    if(!isDefined(attacker)) {
      continue;
    }
    if(!isDefined(attacker.team) || isplayer(attacker)) {
      continue;
    }
    if(isDefined(self.ridingtank) && isDefined(self.ridingtank.allowunloadifattacked) && self.ridingtank.allowunloadifattacked == 0) {
      continue;
    }
    if(isDefined(self.walkingvehicle) && isDefined(self.walkingvehicle.allowunloadifattacked) && self.walkingvehicle.allowunloadifattacked == 0) {
      continue;
    }
    self.walkingvehicle.teamunderattack = 1;
    self.walkingvehicle notify("unload");
    return;
  }
}

getnewnodepositionaheadofvehicle(guy) {
  minimumdistance = 300 + 50 * self getspeedmph();
  nextnode = undefined;

  if(!isDefined(self.currentnode.target))
    return self.origin;

  nextnode = getvehiclenode(self.currentnode.target, "targetname");

  if(!isDefined(nextnode)) {
    if(isDefined(guy.nodeaftervehiclewalk))
      return guy.nodeaftervehiclewalk.origin;
    else
      return self.origin;
  }

  if(distancesquared(self.origin, nextnode.origin) >= minimumdistance * minimumdistance)
    return nextnode.origin;

  for(;;) {
    if(distancesquared(self.origin, nextnode.origin) >= minimumdistance * minimumdistance)
      return nextnode.origin;

    if(!isDefined(nextnode.target)) {
      break;
    }

    nextnode = getvehiclenode(nextnode.target, "targetname");
  }

  if(isDefined(guy.nodeaftervehiclewalk))
    return guy.nodeaftervehiclewalk.origin;
  else
    return self.origin;
}

vehiclewalker_updategoalpos(tank, option) {
  self endon("death");
  tank endon("death");
  self endon("stop updating goalpos");
  self endon("unload");

  for(;;) {
    if(self.followmode == "cover nodes") {
      self.oldgoalradius = self.goalradius;
      self.goalradius = 300;
      self.walkdist = 64;
      position = tank getnewnodepositionaheadofvehicle(self);
    } else {
      self.oldgoalradius = self.goalradius;
      self.goalradius = 2;
      self.walkdist = 64;
      position = tank gettagorigin(tank.walk_tags[self.vehiclewalkmember]);
    }

    if(isDefined(option) && option == "once") {
      trace = bullettrace(position + vectorscale((0, 0, 1), 100.0), position - vectorscale((0, 0, 1), 500.0), 0, undefined);

      if(self.followmode == "close")
        self teleport(trace["position"]);

      self setgoalpos(trace["position"]);
      return;
    }

    tankspeed = tank getspeedmph();

    if(tankspeed > 0) {
      trace = bullettrace(position + vectorscale((0, 0, 1), 100.0), position - vectorscale((0, 0, 1), 500.0), 0, undefined);
      self setgoalpos(trace["position"]);
    }

    wait 0.5;
  }
}

getanimatemodel() {
  if(isDefined(self.modeldummy))
    return self.modeldummy;
  else
    return self;
}

animpos_override_standattack(type, pos, animation) {
  level.vehicle_aianims[type][pos].vehicle_standattack = animation;
}

detach_models_with_substr(guy, substr) {
  size = guy getattachsize();
  modelstodetach = [];
  tagsstodetach = [];

  for(i = 0; i < size; i++) {
    modelname = guy getattachmodelname(i);
    tagname = guy getattachtagname(i);

    if(issubstr(modelname, substr)) {
      modelstodetach[0] = modelname;
      tagsstodetach[0] = tagname;
    }
  }

  for(i = 0; i < modelstodetach.size; i++)
    guy detach(modelstodetach[i], tagsstodetach[i]);
}

should_give_orghealth() {
  if(!isai(self))
    return 0;

  if(!isDefined(self.orghealth))
    return 0;

  return !isDefined(self.magic_bullet_shield);
}

get_aianims() {
  vehicleanims = level.vehicle_aianims[self.vehicletype];

  if(isDefined(self.vehicle_aianims)) {
    keys = getarraykeys(vehicleanims);

    for(i = 0; i < keys.size; i++) {
      key = keys[i];

      if(isDefined(self.vehicle_aianims[key])) {
        override = self.vehicle_aianims[key];

        if(isDefined(override.idle))
          vehicleanims[key].idle = override.idle;

        if(isDefined(override.getout))
          vehicleanims[key].getout = override.getout;

        if(isDefined(override.getin))
          vehicleanims[key].getin = override.getin;

        if(isDefined(override.waiting))
          vehicleanims[key].waiting = override.waiting;
      }
    }
  }

  return vehicleanims;
}

override_anim(action, tag, animation) {
  pos = anim_pos_from_tag(self, tag);
  assert(isDefined(pos), "_vehicle_aianim::override_anim - No valid position set up for tag '" + tag + "' on vehicle of type '" + self.vehicletype + "'.");

  if(!isDefined(self.vehicle_aianims) || !isDefined(self.vehicle_aianims[pos]))
    self.vehicle_aianims[pos] = spawnstruct();

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

      assertmsg("_vehicle_aianim::override_anim - '" + action + "' action is not supported for overriding the animation.");

  }
}