/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_67e37e63e177f107.gsc
***********************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\globallogic\globallogic_score;
#include scripts\core_common\statemachine_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\core_common\vehicle_ai_shared;
#include scripts\core_common\vehicle_shared;

#namespace namespace_77b8863;

autoexec __init__system__() {
  system::register(#"hash_60e9e594b4389b03", &__init__, undefined, undefined);
}

__init__() {
  vehicle::add_main_callback(#"dust_ball", &function_c346ef73);
  clientfield::register("scriptmover", "towers_boss_dust_ball_fx", 1, getminbitcountfornum(4), "int");

  level thread update_dvars();

}

update_dvars() {}

  function function_c346ef73() {
    self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    self.var_1dab821a = 0;
    self useanimtree("generic");

    if(isDefined(self.owner)) {
      self setteam(self.owner.team);
    }

    self setneargoalnotifydist(60);
    defaultrole();
  }

defaultrole() {
  statemachine = self vehicle_ai::init_state_machine_for_role("default");
  statemachine statemachine::add_state("seek", &function_9ddc7275, &function_3e16dec3, &function_64f7393f);
  statemachine statemachine::add_state("soul", &function_3f83eb6, &function_e452a40c, &function_22828012);
  self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
  self val::set(#"dust_ball", "takedamage", 0);
  self.takedamage = 0;
  self vehicle_ai::call_custom_add_state_callbacks();
  self.fxent = spawn("script_model", self.origin);
  self.fxent setModel("tag_origin");
  self.fxent linkto(self);
  self.fxent clientfield::set("towers_boss_dust_ball_fx", 1);
  vehicle_ai::startinitialstate("seek");
}

function_d3a9800e() {
  return self.origin + (0, 0, 30);
}

waittill_pathing_done(maxtime = 15) {
  self endon(#"death");
  self endon(#"change_state");
  self waittilltimeout(maxtime, #"near_goal");
}

function_f2fd92d1() {
  if(isDefined(self.favoriteenemy)) {
    target_pos = self.favoriteenemy.origin;
  }

  if(isDefined(target_pos)) {
    target_pos_onnavmesh = getclosestpointonnavmesh(target_pos, 20, self.radius, 4194287);
  }

  if(isDefined(target_pos_onnavmesh)) {
    return target_pos_onnavmesh;
  }

  if(isDefined(self.current_pathto_pos)) {
    return self.current_pathto_pos;
  }
}

function_3f83eb6(params) {
  self.fxent unlink();
  self.fxent linkto(self, "tag_origin", (0, 0, 50));
  self.fxent clientfield::set("towers_boss_dust_ball_fx", 3);
}

function_e452a40c(params) {
  self endon(#"death");
  self setneargoalnotifydist(40);

  while(true) {
    if(!isDefined(self.ai.var_a38db64f)) {
      waitframe(1);
      continue;
    }

    self setspeed(self.settings.var_9eff22ee);
    self setbrake(0);
    self function_a57c34b7(self.ai.var_a38db64f, 1, 1);
    self waittilltimeout(30, #"near_goal");

    if(isDefined(self.fxent)) {
      self.fxent delete();
    }

    self delete();
  }
}

function_22828012(params) {}

function_9ddc7275(params) {
  self.var_33506050 = undefined;
  self.favoriteenemy = undefined;
  duration = 2;
  self.var_373d5c91 = gettime() + int(duration * 1000);
  self thread function_ef0bfb9d();
  self thread function_419f8ccb();

  if(isDefined(self.settings.var_d76543dd)) {
    self playLoopSound(self.settings.var_d76543dd);
  }
}

function_64f7393f(params) {
  self stoploopsound();
}

function_78b6454d() {
  if(gettime() > self.var_373d5c91) {
    return true;
  }

  return false;
}

function_3e16dec3(params) {
  self endon(#"death");
  self endon(#"change_state");

  for(;;) {
    if(isDefined(self.favoriteenemy)) {
      if(isDefined(self.settings.var_cfe1cc83)) {
        self playLoopSound(self.settings.var_cfe1cc83);
      }

      self.current_pathto_pos = self function_f2fd92d1();

      if(isDefined(self.current_pathto_pos)) {
        self setspeed(self.settings.var_9eff22ee);
        self setbrake(0);
        self function_a57c34b7(self.current_pathto_pos, 1, 1);
        self waittill_pathing_done(1);
        continue;
      }
    } else {
      self function_55be8453();
    }

    waitframe(1);
  }
}

function_ef0bfb9d() {
  self endon(#"death");
  self endon(#"change_state");
  wait 0.5;

  while(true) {
    enemies = util::function_81ccf6d3(self.team);
    alltargets = arraysort(enemies, self function_d3a9800e(), 1);
    zombiesarray = getaiarchetypearray(#"zombie");
    zombiesarray = arraycombine(zombiesarray, getaiarchetypearray(#"catalyst"), 0, 0);
    alltargets = arraycombine(zombiesarray, alltargets, 0, 0);

    foreach(target in alltargets) {
      distsqtotarget = distancesquared(target.origin, self function_d3a9800e());

      if(distsqtotarget <= self.settings.damage_radius * self.settings.damage_radius) {
        if(isDefined(target.archetype)) {
          target zombie_utility::setup_zombie_knockdown(self);
          target.knockdown_type = "knockdown_shoved";
          continue;
        }

        target dodamage(self.settings.var_274be2d6, self.origin, self, self, "", "MOD_IMPACT", 0);
      }
    }

    physicsexplosionsphere(self.origin, 200, 100, 2);
    waitframe(1);
  }
}

function_413aacb3(target) {
  var_7588d977 = getaiarchetypearray(#"dust_ball");

  foreach(dustball in var_7588d977) {
    if(dustball == self) {
      continue;
    }

    if(dustball.favoriteenemy === target) {
      return true;
    }
  }

  return false;
}

function_55be8453() {
  self endon(#"death");
  self endon(#"change_state");
  wait 0.5;

  if(isDefined(self.favoriteenemy)) {
    if(util::within_fov(self.origin, self.angles, self.favoriteenemy.origin, 0.939)) {
      distsqtotarget = distancesquared(self.favoriteenemy.origin, self function_d3a9800e());

      if(distsqtotarget <= 10000) {
        return;
      }
    }
  }

  enemies = util::function_81ccf6d3(self.team);
  alltargets = arraysort(enemies, self function_d3a9800e(), 1);

  foreach(target in alltargets) {
    angles = self.angles;

    if(self function_413aacb3(target)) {
      continue;
    }

    if(util::within_fov(self.origin, angles, target.origin, 0)) {
      self.favoriteenemy = target;
      return;
    }
  }

  foreach(target in alltargets) {
    distsqtotarget = distancesquared(target.origin, self function_d3a9800e());

    if(distsqtotarget <= 10000) {
      self.favoriteenemy = target;
      return;
    }
  }

  if(alltargets.size && isDefined(alltargets[0])) {
    self.favoriteenemy = alltargets[0];
  }
}

function_419f8ccb() {
  self endon(#"death");
  self endon(#"change_state");

  for(;;) {
    if(self function_78b6454d()) {
      self vehicle_ai::set_state("death");
    }

    if(isDefined(self.favoriteenemy)) {
      distfromplayer = distancesquared(self.origin, self.favoriteenemy.origin);

      if(distfromplayer < self.settings.var_2c001f55 * self.settings.var_2c001f55 && !(isDefined(self.var_8d5279eb) && self.var_8d5279eb)) {
        self.fxent clientfield::set("towers_boss_dust_ball_fx", 2);
        self.var_8d5279eb = 1;
      }

      if(distfromplayer < self.settings.var_7e3165c1 * self.settings.var_7e3165c1) {
        self vehicle_ai::set_state("death");
      }
    }

    waitframe(1);
  }
}

function_469f1e03(fxent) {
  wait 0.1;
  fxent delete();
}

state_death_update(params) {
  self.fxent clientfield::set("towers_boss_dust_ball_fx", 0);

  if(isDefined(level.var_c6001986)) {
    [[level.var_c6001986]](self);
  }

  fxent = self.fxent;
  vehicle_ai::defaultstate_death_update(params);
  wait 2;

  if(isDefined(fxent)) {
    level thread function_469f1e03(fxent);
  }

  if(isDefined(self)) {
    self delete();
  }
}