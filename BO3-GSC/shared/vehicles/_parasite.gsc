/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\vehicles\_parasite.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\blackboard_vehicle;
#using scripts\shared\ai\systems\ai_interface;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\math_shared;
#using scripts\shared\statemachine_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_ai_shared;
#using scripts\shared\vehicle_death_shared;
#using scripts\shared\vehicle_shared;
#using_animtree("generic");
#namespace parasite;

function autoexec __init__sytem__() {
  system::register("parasite", &__init__, undefined, undefined);
}

function __init__() {
  vehicle::add_main_callback("parasite", &parasite_initialize);
  clientfield::register("vehicle", "parasite_tell_fx", 1, 1, "int");
  clientfield::register("vehicle", "parasite_secondary_deathfx", 1, 1, "int");
  clientfield::register("toplayer", "parasite_damage", 1, 1, "counter");
  callback::on_spawned(&parasite_damage);
  ai::registermatchedinterface("parasite", "firing_rate", "slow", array("slow", "medium", "fast"));
}

function parasite_damage() {
  self notify("parasite_damage_thread");
  self endon("parasite_damage_thread");
  self endon("death");
  while(true) {
    self waittill("damage", n_ammount, e_attacker);
    if(isDefined(e_attacker) && (isDefined(e_attacker.is_parasite) && e_attacker.is_parasite) && (!(isDefined(e_attacker.squelch_damage_overlay) && e_attacker.squelch_damage_overlay))) {
      self clientfield::increment_to_player("parasite_damage");
    }
  }
}

function private is_target_valid(target) {
  if(!isDefined(target)) {
    return 0;
  }
  if(!isalive(target)) {
    return 0;
  }
  if(isPlayer(target) && target.sessionstate == "spectator") {
    return 0;
  }
  if(isPlayer(target) && target.sessionstate == "intermission") {
    return 0;
  }
  if(isDefined(target.ignoreme) && target.ignoreme) {
    return 0;
  }
  if(target isnotarget()) {
    return 0;
  }
  if(isDefined(self.is_target_valid_cb)) {
    return self[[self.is_target_valid_cb]](target);
  }
  return 1;
}

function get_parasite_enemy() {
  parasite_targets = getplayers();
  least_hunted = parasite_targets[0];
  for(i = 0; i < parasite_targets.size; i++) {
    if(!isDefined(parasite_targets[i].hunted_by)) {
      parasite_targets[i].hunted_by = 0;
    }
    if(!is_target_valid(parasite_targets[i])) {
      continue;
    }
    if(!is_target_valid(least_hunted)) {
      least_hunted = parasite_targets[i];
    }
    if(parasite_targets[i].hunted_by < least_hunted.hunted_by) {
      least_hunted = parasite_targets[i];
    }
  }
  if(!is_target_valid(least_hunted)) {
    return undefined;
  }
  return least_hunted;
}

function set_parasite_enemy(enemy) {
  if(!is_target_valid(enemy)) {
    return;
  }
  if(isDefined(self.parasiteenemy)) {
    if(!isDefined(self.parasiteenemy.hunted_by)) {
      self.parasiteenemy.hunted_by = 0;
    }
    if(self.parasiteenemy.hunted_by > 0) {
      self.parasiteenemy.hunted_by--;
    }
  }
  self.parasiteenemy = enemy;
  if(!isDefined(self.parasiteenemy.hunted_by)) {
    self.parasiteenemy.hunted_by = 0;
  }
  self.parasiteenemy.hunted_by++;
  self setlookatent(self.parasiteenemy);
  self setturrettargetent(self.parasiteenemy);
}

function private parasite_target_selection() {
  self endon("change_state");
  self endon("death");
  for(;;) {
    if(isDefined(self.ignoreall) && self.ignoreall) {
      wait(0.5);
      continue;
    }
    if(is_target_valid(self.parasiteenemy)) {
      wait(0.5);
      continue;
    }
    target = get_parasite_enemy();
    if(!isDefined(target)) {
      self.parasiteenemy = undefined;
    } else {
      self.parasiteenemy = target;
      self.parasiteenemy.hunted_by = self.parasiteenemy.hunted_by + 1;
      self setlookatent(self.parasiteenemy);
      self setturrettargetent(self.parasiteenemy);
    }
    wait(0.5);
  }
}

function parasite_initialize() {
  self useanimtree($generic);
  blackboard::createblackboardforentity(self);
  self blackboard::registervehicleblackboardattributes();
  ai::createinterfaceforentity(self);
  blackboard::registerblackboardattribute(self, "_parasite_firing_rate", "slow", &getparasitefiringrate);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  self.health = self.healthdefault;
  self vehicle::friendly_fire_shield();
  self enableaimassist();
  self setneargoalnotifydist(25);
  self setdrawinfrared(1);
  self.fovcosine = 0;
  self.fovcosinebusy = 0;
  self.vehaircraftcollisionenabled = 1;
  assert(isDefined(self.scriptbundlesettings));
  self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
  self.goalradius = 999999;
  self.goalheight = 4000;
  self setgoal(self.origin, 0, self.goalradius, self.goalheight);
  self.is_parasite = 1;
  self thread vehicle_ai::nudge_collision();
  if(isDefined(level.vehicle_initializer_cb)) {
    [[level.vehicle_initializer_cb]](self);
  }
  defaultrole();
}

function defaultrole() {
  self vehicle_ai::init_state_machine_for_role("default");
  self vehicle_ai::get_state_callbacks("combat").enter_func = &state_combat_enter;
  self vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
  self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
  self vehicle_ai::call_custom_add_state_callbacks();
  vehicle_ai::startinitialstate("combat");
}

function getparasitefiringrate() {
  return self ai::get_behavior_attribute("firing_rate");
}

function state_death_update(params) {
  self endon("death");
  self asmrequestsubstate("death@stationary");
  if(isDefined(self.parasiteenemy) && isDefined(self.parasiteenemy.hunted_by)) {
    self.parasiteenemy.hunted_by--;
  }
  self setphysacceleration(vectorscale((0, 0, -1), 300));
  self.vehcheckforpredictedcrash = 1;
  self thread vehicle_death::death_fx();
  self playSound("zmb_parasite_explo");
  self util::waittill_notify_or_timeout("veh_predictedcollision", 4);
  self clientfield::set("parasite_secondary_deathfx", 1);
  wait(0.2);
  self delete();
}

function state_combat_enter(params) {
  if(isDefined(self.owner) && isDefined(self.owner.enemy)) {
    self.parasiteenemy = self.owner.enemy;
  }
  self thread parasite_target_selection();
}

function state_combat_update(params) {
  self endon("change_state");
  self endon("death");
  lasttimechangeposition = 0;
  self.shouldgotonewposition = 0;
  self.lasttimetargetinsight = 0;
  self.lasttimejuked = 0;
  self asmrequestsubstate("locomotion@movement");
  for(;;) {
    if(isDefined(self._override_parasite_combat_speed)) {
      self setspeed(self._override_parasite_combat_speed);
    } else {
      self setspeed(self.settings.defaultmovespeed);
    }
    if(isDefined(self.inpain) && self.inpain) {
      wait(0.1);
      continue;
    }
    if(!isDefined(self.parasiteenemy)) {
      wait(0.25);
      continue;
    }
    if(self.goalforced) {
      returndata = [];
      returndata["origin"] = self getclosestpointonnavvolume(self.goalpos, 100);
      returndata["centerOnNav"] = ispointinnavvolume(self.origin, "navvolume_small");
    } else {
      if(randomint(100) < self.settings.jukeprobability && (!(isDefined(self.lasttimejuked) && self.lasttimejuked)) || (isDefined(self._override_juke) && self._override_juke)) {
        returndata = getnextmoveposition_forwardjuke();
        self.lasttimejuked = 1;
        self._override_juke = undefined;
      } else {
        returndata = getnextmoveposition_tactical();
        self.lasttimejuked = 0;
      }
    }
    self.current_pathto_pos = returndata["origin"];
    if(isDefined(self.current_pathto_pos)) {
      if(isDefined(self.stucktime)) {
        self.stucktime = undefined;
      }
      if(self setvehgoalpos(self.current_pathto_pos, 1, returndata["centerOnNav"])) {
        self thread path_update_interrupt();
        self playSound("zmb_vocals_parasite_juke");
        self vehicle_ai::waittill_pathing_done(5);
      } else {
        wait(0.1);
      }
    } else if(!(isDefined(returndata["centerOnNav"]) && returndata["centerOnNav"])) {
      if(!isDefined(self.stucktime)) {
        self.stucktime = gettime();
      }
      if((gettime() - self.stucktime) > 10000) {
        self dodamage(self.health + 100, self.origin);
      }
    }
    if(isDefined(self.lasttimejuked) && self.lasttimejuked) {
      if(randomint(100) < 50 && isDefined(self.parasiteenemy) && distance2dsquared(self.origin, self.parasiteenemy.origin) < (64 * 64)) {
        self.parasiteenemy dodamage(self.settings.meleedamage, self.parasiteenemy.origin, self);
      } else {
        self fire_pod_logic(self.lasttimejuked);
      }
      continue;
    }
    if(randomint(100) < 30) {
      self fire_pod_logic(self.lasttimejuked);
    }
  }
}

function fire_pod_logic(chosetojuke) {
  if(isDefined(self.parasiteenemy) && self vehcansee(self.parasiteenemy) && distance2dsquared(self.parasiteenemy.origin, self.origin) < ((0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax)) * 3) * ((0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax)) * 3)) {
    self asmrequestsubstate("fire@stationary");
    self playSound("zmb_vocals_parasite_preattack");
    self clientfield::set("parasite_tell_fx", 1);
    self waittill("pre_fire");
    if(isDefined(self.parasiteenemy) && self vehcansee(self.parasiteenemy) && distance2dsquared(self.parasiteenemy.origin, self.origin) < ((0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax)) * 3) * ((0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax)) * 3)) {
      self setturrettargetent(self.parasiteenemy, self.parasiteenemy getvelocity() * 0.3);
    }
    self vehicle_ai::waittill_asm_complete("fire@stationary", 5);
    self asmrequestsubstate("locomotion@movement");
    self clientfield::set("parasite_tell_fx", 0);
    if(!chosetojuke) {
      wait(randomfloatrange(0.25, 0.5));
    }
  } else {
    wait(randomfloatrange(1, 2));
  }
}

function getnextmoveposition_tactical() {
  self endon("change_state");
  self endon("death");
  selfdisttotarget = distance2d(self.origin, self.parasiteenemy.origin);
  gooddist = 0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax);
  closedist = 1.2 * gooddist;
  fardist = 3 * gooddist;
  querymultiplier = mapfloat(closedist, fardist, 1, 3, selfdisttotarget);
  preferedheightrange = 0.5 * (self.settings.engagementheightmax - self.settings.engagementheightmin);
  randomness = 30;
  queryresult = positionquery_source_navigation(self.origin, 75, 225 * querymultiplier, 75, 20 * querymultiplier, self, 20 * querymultiplier);
  if(!(isDefined(queryresult.centeronnav) && queryresult.centeronnav)) {
    self.vehaircraftcollisionenabled = 0;
  } else {
    self.vehaircraftcollisionenabled = 1;
  }
  positionquery_filter_distancetogoal(queryresult, self);
  vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
  self vehicle_ai::positionquery_filter_engagementdist(queryresult, self.parasiteenemy, self.settings.engagementdistmin, self.settings.engagementdistmax);
  goalheight = self.parasiteenemy.origin[2] + (0.5 * (self.settings.engagementheightmin + self.settings.engagementheightmax));
  best_point = undefined;
  best_score = -999999;
  trace_count = 0;
  foreach(point in queryresult.data) {
    if(!(isDefined(queryresult.centeronnav) && queryresult.centeronnav)) {
      if(sighttracepassed(self.origin, point.origin, 0, undefined)) {
        trace_count++;
        if(trace_count > 3) {
          wait(0.05);
          trace_count = 0;
        }
        if(!bullettracepassed(self.origin, point.origin, 0, self)) {
          continue;
        }
      } else {
        continue;
      }
    }
    if(!isDefined(point._scoredebug)) {
      point._scoredebug = [];
    }
    point._scoredebug[""] = randomfloatrange(0, randomness);
    point.score = point.score + randomfloatrange(0, randomness);
    if(!isDefined(point._scoredebug)) {
      point._scoredebug = [];
    }
    point._scoredebug[""] = point.distawayfromengagementarea * -1;
    point.score = point.score + (point.distawayfromengagementarea * -1);
    distfrompreferredheight = abs(point.origin[2] - goalheight);
    if(distfrompreferredheight > preferedheightrange) {
      heightscore = mapfloat(0, 500, 0, 2000, distfrompreferredheight);
      if(!isDefined(point._scoredebug)) {
        point._scoredebug = [];
      }
      point._scoredebug[""] = heightscore * -1;
      point.score = point.score + (heightscore * -1);
    }
    if(point.score > best_score) {
      best_score = point.score;
      best_point = point;
    }
  }
  self vehicle_ai::positionquery_debugscores(queryresult);
  if(isDefined(getdvarint("")) && getdvarint("")) {
    recordline(self.origin, best_point.origin, (0.3, 1, 0));
    recordline(self.origin, self.parasiteenemy.origin, (1, 0, 0.4));
  }
  returndata = [];
  returndata["origin"] = (isDefined(best_point) ? best_point.origin : undefined);
  returndata["centerOnNav"] = queryresult.centeronnav;
  return returndata;
}

function getnextmoveposition_forwardjuke() {
  self endon("change_state");
  self endon("death");
  selfdisttotarget = distance2d(self.origin, self.parasiteenemy.origin);
  gooddist = 0.5 * (self.settings.forwardjukeengagementdistmin + self.settings.forwardjukeengagementdistmax);
  closedist = 1.2 * gooddist;
  fardist = 3 * gooddist;
  querymultiplier = mapfloat(closedist, fardist, 1, 3, selfdisttotarget);
  preferedheightrange = 0.5 * (self.settings.forwardjukeengagementheightmax - self.settings.forwardjukeengagementheightmin);
  randomness = 30;
  queryresult = positionquery_source_navigation(self.origin, 75, 300 * querymultiplier, 75, 20 * querymultiplier, self, 20 * querymultiplier);
  if(!(isDefined(queryresult.centeronnav) && queryresult.centeronnav)) {
    self.vehaircraftcollisionenabled = 0;
  } else {
    self.vehaircraftcollisionenabled = 1;
  }
  positionquery_filter_distancetogoal(queryresult, self);
  vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
  self vehicle_ai::positionquery_filter_engagementdist(queryresult, self.parasiteenemy, self.settings.forwardjukeengagementdistmin, self.settings.forwardjukeengagementdistmax);
  goalheight = self.parasiteenemy.origin[2] + (0.5 * (self.settings.forwardjukeengagementheightmin + self.settings.forwardjukeengagementheightmax));
  best_point = undefined;
  best_score = -999999;
  trace_count = 0;
  foreach(point in queryresult.data) {
    if(!(isDefined(queryresult.centeronnav) && queryresult.centeronnav)) {
      if(sighttracepassed(self.origin, point.origin, 0, undefined)) {
        trace_count++;
        if(trace_count > 3) {
          wait(0.05);
          trace_count = 0;
        }
        if(!bullettracepassed(self.origin, point.origin, 0, self)) {
          continue;
        }
      } else {
        continue;
      }
    }
    if(!isDefined(point._scoredebug)) {
      point._scoredebug = [];
    }
    point._scoredebug[""] = randomfloatrange(0, randomness);
    point.score = point.score + randomfloatrange(0, randomness);
    if(!isDefined(point._scoredebug)) {
      point._scoredebug = [];
    }
    point._scoredebug[""] = point.distawayfromengagementarea * -1;
    point.score = point.score + (point.distawayfromengagementarea * -1);
    distfrompreferredheight = abs(point.origin[2] - goalheight);
    if(distfrompreferredheight > preferedheightrange) {
      heightscore = mapfloat(0, 500, 0, 2000, distfrompreferredheight);
      if(!isDefined(point._scoredebug)) {
        point._scoredebug = [];
      }
      point._scoredebug[""] = heightscore * -1;
      point.score = point.score + (heightscore * -1);
    }
    if(point.score > best_score) {
      best_score = point.score;
      best_point = point;
    }
  }
  self vehicle_ai::positionquery_debugscores(queryresult);
  if(isDefined(getdvarint("")) && getdvarint("")) {
    recordline(self.origin, best_point.origin, (0.3, 1, 0));
    recordline(self.origin, self.parasiteenemy.origin, (1, 0, 0.4));
  }
  returndata = [];
  returndata["origin"] = (isDefined(best_point) ? best_point.origin : undefined);
  returndata["centerOnNav"] = queryresult.centeronnav;
  return returndata;
}

function path_update_interrupt() {
  self endon("death");
  self endon("change_state");
  self endon("near_goal");
  self endon("reached_end_node");
  wait(1);
  while(true) {
    if(isDefined(self.current_pathto_pos)) {
      if(distance2dsquared(self.current_pathto_pos, self.goalpos) > (self.goalradius * self.goalradius)) {
        wait(0.2);
        self._override_juke = 1;
        self notify("near_goal");
      }
    }
    wait(0.2);
  }
}

function drone_pain_for_time(time, stablizeparam, restorelookpoint) {
  self endon("death");
  self.painstarttime = gettime();
  if(!(isDefined(self.inpain) && self.inpain)) {
    self.inpain = 1;
    self playSound("zmb_vocals_parasite_pain");
    while(gettime() < (self.painstarttime + (time * 1000))) {
      self setvehvelocity(self.velocity * stablizeparam);
      self setangularvelocity(self getangularvelocity() * stablizeparam);
      wait(0.1);
    }
    if(isDefined(restorelookpoint)) {
      restorelookent = spawn("script_model", restorelookpoint);
      restorelookent setModel("tag_origin");
      self clearlookatent();
      self setlookatent(restorelookent);
      self setturrettargetent(restorelookent);
      wait(1.5);
      self clearlookatent();
      self clearturrettarget();
      restorelookent delete();
    }
    self.inpain = 0;
  }
}

function drone_pain(eattacker, damagetype, hitpoint, hitdirection, hitlocationinfo, partname) {
  if(!(isDefined(self.inpain) && self.inpain)) {
    yaw_vel = math::randomsign() * randomfloatrange(280, 320);
    ang_vel = self getangularvelocity();
    ang_vel = ang_vel + (randomfloatrange(-120, -100), yaw_vel, randomfloatrange(-200, 200));
    self setangularvelocity(ang_vel);
    self thread drone_pain_for_time(0.8, 0.7);
  }
}