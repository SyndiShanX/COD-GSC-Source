/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\vehicles\_dragon_whelp.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\blackboard_vehicle;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\animation_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\math_shared;
#using scripts\shared\statemachine_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_ai_shared;
#using scripts\shared\vehicle_death_shared;
#using scripts\shared\vehicle_shared;
#using_animtree("generic");
#namespace dragon;

function autoexec __init__sytem__() {
  system::register("dragon", &__init__, undefined, undefined);
}

function __init__() {
  vehicle::add_main_callback("dragon", &dragon_initialize);
}

function dragon_initialize() {
  self useanimtree($generic);
  self.health = self.healthdefault;
  self vehicle::friendly_fire_shield();
  if(isDefined(self.scriptbundlesettings)) {
    self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
  }
  assert(isDefined(self.settings));
  self setneargoalnotifydist(self.radius * 1.5);
  self sethoverparams(self.radius, self.settings.defaultmovespeed * 2, self.radius);
  self setspeed(self.settings.defaultmovespeed);
  blackboard::createblackboardforentity(self);
  self blackboard::registervehicleblackboardattributes();
  self.fovcosine = 0;
  self.fovcosinebusy = 0;
  self.vehaircraftcollisionenabled = 0;
  self.goalradius = 9999999;
  self.goalheight = 512;
  self setgoal(self.origin, 0, self.goalradius, self.goalheight);
  self.delete_on_death = 1;
  self.overridevehicledamage = &dragon_callback_damage;
  self.allowfriendlyfiredamageoverride = &dragon_allowfriendlyfiredamage;
  self.ignoreme = 1;
  if(isDefined(level.vehicle_initializer_cb)) {
    [[level.vehicle_initializer_cb]](self);
  }
  defaultrole();
}

function defaultrole() {
  self vehicle_ai::init_state_machine_for_role("default");
  self vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
  self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
  if(sessionmodeiszombiesgame()) {
    self vehicle_ai::add_state("power_up", undefined, &state_power_up_update, undefined);
    self vehicle_ai::add_utility_connection("combat", "power_up", &should_go_for_power_up);
    self vehicle_ai::add_utility_connection("power_up", "combat");
  }
  setDvar("", 0);
  self thread dragon_target_selection();
  vehicle_ai::startinitialstate("combat");
  self.starttime = gettime();
}

function private is_enemy_valid(target) {
  if(!isDefined(target)) {
    return false;
  }
  if(!isalive(target)) {
    return false;
  }
  if(isDefined(self.intermission) && self.intermission) {
    return false;
  }
  if(isDefined(target.ignoreme) && target.ignoreme) {
    return false;
  }
  if(target isnotarget()) {
    return false;
  }
  if(isDefined(target._dragon_ignoreme) && target._dragon_ignoreme) {
    return false;
  }
  if(distancesquared(self.owner.origin, target.origin) > (self.settings.guardradius * self.settings.guardradius)) {
    return false;
  }
  if(self vehcansee(target)) {
    return true;
  }
  if(isactor(target) && target cansee(self.owner)) {
    return true;
  }
  if(isvehicle(target) && target vehcansee(self.owner)) {
    return true;
  }
  return false;
}

function private get_dragon_enemy() {
  dragon_enemies = getaiteamarray("axis");
  distsqr = 10000 * 10000;
  best_enemy = undefined;
  foreach(enemy in dragon_enemies) {
    newdistsqr = distance2dsquared(enemy.origin, self.owner.origin);
    if(is_enemy_valid(enemy)) {
      if(enemy.archetype === "raz") {
        newdistsqr = max(distance2d(enemy.origin, self.owner.origin) - 700, 0);
        newdistsqr = newdistsqr * newdistsqr;
      } else {
        if(enemy.archetype === "sentinel_drone") {
          newdistsqr = max(distance2d(enemy.origin, self.owner.origin) - 500, 0);
          newdistsqr = newdistsqr * newdistsqr;
        } else if(enemy === self.dragonenemy) {
          newdistsqr = max(distance2d(enemy.origin, self.owner.origin) - 300, 0);
          newdistsqr = newdistsqr * newdistsqr;
        }
      }
      if(newdistsqr < distsqr) {
        distsqr = newdistsqr;
        best_enemy = enemy;
      }
    }
  }
  return best_enemy;
}

function private dragon_target_selection() {
  self endon("death");
  for(;;) {
    if(!isDefined(self.owner)) {
      wait(0.25);
      continue;
    }
    if(isDefined(self.ignoreall) && self.ignoreall) {
      wait(0.25);
      continue;
    }
    if(getdvarint("", 0)) {
      if(isDefined(self.dragonenemy)) {
        line(self.origin, self.dragonenemy.origin, (1, 0, 0), 1, 0, 5);
      }
    }
    target = get_dragon_enemy();
    if(!isDefined(target)) {
      self.dragonenemy = undefined;
    } else {
      self.dragonenemy = target;
    }
    wait(0.25);
  }
}

function state_power_up_update(params) {
  self endon("change_state");
  self endon("death");
  closest_distsqr = 10000 * 10000;
  closest = undefined;
  foreach(powerup in level.active_powerups) {
    powerup.navvolumeorigin = self getclosestpointonnavvolume(powerup.origin, 100);
    if(!isDefined(powerup.navvolumeorigin)) {
      continue;
    }
    distsqr = distancesquared(powerup.origin, self.origin);
    if(distsqr < closest_distsqr) {
      closest_distsqr = distsqr;
      closest = powerup;
    }
  }
  if(isDefined(closest) && distsqr < (2000 * 2000)) {
    self setvehgoalpos(closest.navvolumeorigin, 1, 1);
    if(vehicle_ai::waittill_pathresult()) {
      self vehicle_ai::waittill_pathing_done();
    }
    if(isDefined(closest)) {
      trace = bulletTrace(self.origin, closest.origin, 0, self);
      if(trace["fraction"] == 1) {
        self setvehgoalpos(closest.origin, 1, 0);
      }
    }
  }
  self vehicle_ai::evaluate_connections();
}

function should_go_for_power_up(from_state, to_state, connection) {
  if(level.whelp_no_power_up_pickup === 1) {
    return false;
  }
  if(isDefined(self.dragonenemy)) {
    return false;
  }
  if(level.active_powerups.size < 1) {
    return false;
  }
  return true;
}

function state_combat_update(params) {
  self endon("change_state");
  self endon("death");
  idealdisttoowner = 300;
  self asmrequestsubstate("locomotion@movement");
  while(!isDefined(self.owner)) {
    wait(0.05);
  }
  self thread attack_thread();
  for(;;) {
    self setspeed(self.settings.defaultmovespeed);
    self asmrequestsubstate("locomotion@movement");
    if(isDefined(self.owner) && distance2dsquared(self.origin, self.owner.origin) < (idealdisttoowner * idealdisttoowner) && ispointinnavvolume(self.origin, "navvolume_small")) {
      if(!isDefined(self.current_pathto_pos)) {
        self.current_pathto_pos = self getclosestpointonnavvolume(self.origin, 100);
      }
      self setvehgoalpos(self.current_pathto_pos, 1, 0);
      wait(0.1);
      continue;
    }
    if(isDefined(self.owner)) {
      queryresult = positionquery_source_navigation(self.origin, 0, 256, 90, self.radius, self);
      sighttarget = undefined;
      if(isDefined(self.dragonenemy)) {
        sighttarget = self.dragonenemy getEye();
        positionquery_filter_sight(queryresult, sighttarget, (0, 0, 0), self, 4);
      }
      if(isDefined(queryresult.centeronnav) && queryresult.centeronnav) {
        ownerorigin = self.owner.origin;
        ownerforward = anglesToForward(self.owner.angles);
        best_point = undefined;
        best_score = -999999;
        foreach(point in queryresult.data) {
          distsqr = distance2dsquared(point.origin, ownerorigin);
          if(distsqr > (idealdisttoowner * idealdisttoowner)) {
            if(!isDefined(point._scoredebug)) {
              point._scoredebug = [];
            }
            point._scoredebug[""] = (sqrt(distsqr) * -1) * 2;
            point.score = point.score + ((sqrt(distsqr) * -1) * 2);
          }
          if(isDefined(point.visibility) && point.visibility) {
            if(bullettracepassed(point.origin, sighttarget, 0, self)) {
              if(!isDefined(point._scoredebug)) {
                point._scoredebug = [];
              }
              point._scoredebug[""] = 400;
              point.score = point.score + 400;
            }
          }
          vectoowner = point.origin - ownerorigin;
          dirtoowner = vectornormalize((vectoowner[0], vectoowner[1], 0));
          if(vectordot(ownerforward, dirtoowner) > 0.34) {
            if(abs(vectoowner[2]) < 100) {
              if(!isDefined(point._scoredebug)) {
                point._scoredebug = [];
              }
              point._scoredebug[""] = 300;
              point.score = point.score + 300;
            } else if(abs(vectoowner[2]) < 200) {
              if(!isDefined(point._scoredebug)) {
                point._scoredebug = [];
              }
              point._scoredebug[""] = 100;
              point.score = point.score + 100;
            }
          }
          if(point.score > best_score) {
            best_score = point.score;
            best_point = point;
          }
        }
        self vehicle_ai::positionquery_debugscores(queryresult);
        if(isDefined(best_point)) {
          if(isDefined(getdvarint("")) && getdvarint("")) {
            recordline(self.origin, best_point.origin, (0.3, 1, 0));
            recordline(self.origin, self.owner.origin, (1, 0, 0.4));
          }
          if(distancesquared(self.origin, best_point.origin) > (50 * 50)) {
            self.current_pathto_pos = best_point.origin;
            self setvehgoalpos(self.current_pathto_pos, 1, 1);
            self vehicle_ai::waittill_pathing_done(5);
          } else {
            self vehicle_ai::cooldown("move_cooldown", 4);
          }
        }
      } else {
        go_back_on_navvolume();
      }
    }
    wait(0.1);
  }
}

function attack_thread() {
  self endon("change_state");
  self endon("death");
  for(;;) {
    wait(0.1);
    self vehicle_ai::evaluate_connections();
    if(!self vehicle_ai::iscooldownready("attack")) {
      continue;
    }
    if(!isDefined(self.dragonenemy)) {
      continue;
    }
    self setlookatent(self.dragonenemy);
    if(!self vehcansee(self.dragonenemy)) {
      continue;
    }
    if(distance2dsquared(self.dragonenemy.origin, self.owner.origin) > (self.settings.guardradius * self.settings.guardradius)) {
      continue;
    }
    eyeoffset = (self.dragonenemy getEye() - self.dragonenemy.origin) * 0.6;
    if(!bullettracepassed(self.origin, self.dragonenemy getEye() - eyeoffset, 0, self, self.dragonenemy)) {
      self.dragonenemy = undefined;
      continue;
    }
    aimoffset = (self.dragonenemy getvelocity() * 0.3) - eyeoffset;
    self setturrettargetent(self.dragonenemy, aimoffset);
    wait(0.2);
    if(isDefined(self.dragonenemy)) {
      self fireweapon(0, self.dragonenemy, (0, 0, 0), self);
      self vehicle_ai::cooldown("attack", 1);
    }
  }
}

function go_back_on_navvolume() {
  queryresult = positionquery_source_navigation(self.origin, 0, 100, 90, self.radius, self);
  multiplier = 2;
  while(queryresult.data.size < 1) {
    queryresult = positionquery_source_navigation(self.origin, 0, 100 * multiplier, 90 * multiplier, self.radius * multiplier, self);
    multiplier = multiplier + 2;
  }
  if(queryresult.data.size && !queryresult.centeronnav) {
    best_point = undefined;
    best_score = 999999;
    foreach(point in queryresult.data) {
      point.score = abs(point.origin[2] - queryresult.origin[2]);
      if(point.score < best_score) {
        best_score = point.score;
        best_point = point;
      }
    }
    if(isDefined(best_point)) {
      self setneargoalnotifydist(2);
      point = best_point;
      self.current_pathto_pos = point.origin;
      foundpath = self setvehgoalpos(self.current_pathto_pos, 1, 0);
      if(foundpath) {
        self vehicle_ai::waittill_pathing_done(5);
      }
      self setneargoalnotifydist(self.radius);
    }
  }
}

function dragon_allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon) {
  return false;
}

function dragon_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(self.dragon_recall_death !== 1) {
    return 0;
  }
  return idamage;
}

function state_death_update(params) {
  self endon("death");
  attacker = params.inflictor;
  if(!isDefined(attacker)) {
    attacker = params.attacker;
  }
  if(attacker !== self && (!isDefined(self.owner) || self.owner !== attacker) && (isai(attacker) || isPlayer(attacker))) {
    self.damage_on_death = 0;
    wait(0.05);
    attacker = params.inflictor;
    if(!isDefined(attacker)) {
      attacker = params.attacker;
    }
  }
  self vehicle_ai::defaultstate_death_update();
}