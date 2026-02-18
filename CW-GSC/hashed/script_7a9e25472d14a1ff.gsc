/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7a9e25472d14a1ff.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1b01e95a6b5270fd;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_47851dbeea22fe66;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using scripts\core_common\ai\blackboard_vehicle;
#using scripts\core_common\ai\systems\ai_blackboard;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\statemachine_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_death_shared;
#using scripts\core_common\vehicle_shared;
#namespace namespace_8c89a9e9;

function init() {
  namespace_250e9486::function_252dff4d("ghost_zombie", 5, &function_5836955d, undefined, 25);
}

function function_5836955d() {
  namespace_250e9486::function_25b2c8a9();
  self.zombie_move_speed = "sprint";
  self.doa.var_74e4ded8 = 1;
  self setblackboardattribute("_locomotion_speed", "locomotion_speed_sprint");
  self.maxhealth = 100;
  self.health = self.maxhealth;
  self.animrate = 1.15;
  self asmsetanimationrate(self.animrate);
  self.var_e66cd6fb = 1;
  self.var_1c8b76d3 = 1;
  self.no_gib = 1;
  self.var_af545843 = 1;
  self.var_abe67a20 = 1;
  self.var_bbdaef90 = 1;
  self.var_5112b4b1 = 1;
  self setavoidancemask("avoid none");
  self collidewithactors(0);
  self setplayercollision(0);
  self.overrideactordamage = &function_b8c581fb;
  self thread function_d8e8920a();
  self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_ghost_spawn");
  self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_ghost_lp");
}

function private function_b8c581fb(inflictor, attacker, damage, flags, meansofdamage, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex) {
  if(modelindex >= self.health) {
    self.takedamage = 0;
    self namespace_ec06fe4a::function_8c808737();
    self notsolid();
    orb = namespace_ec06fe4a::spawnmodel(self.origin + (0, 0, 40));

    if(isDefined(orb)) {
      orb thread namespace_ec06fe4a::function_52afe5df(1);
      orb namespace_83eb6304::function_3ecfde67("electrical_explo");
      orb namespace_e32bb68::function_3a59ec34("zmb_doa_ai_ghost_explo");
    }
  }

  return modelindex;
}

function function_d8e8920a() {
  self endon(#"death");

  if(!isDefined(level.doa.var_39e3fa99)) {
    return;
  }

  wait randomint(6) + 1;

  while(true) {
    wait 1;

    if(isDefined(self.enemy)) {
      var_6e3ad56b = self.enemy.origin;

      if(isPlayer(self.enemy)) {
        velocity = self.enemy getvelocity();
        velocity = (velocity[0], velocity[1], 0);

        if(length(velocity) >= 0) {
          var_6e3ad56b += vectorscale(velocity, 1.8);
        }
      }

      dest = getrandomnavpoint(var_6e3ad56b, 20, self getpathfindingradius());

      if(isDefined(dest)) {
        spot = dest;
      } else {
        continue;
      }

      self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_ghost_warp_out");
      self namespace_83eb6304::function_3ecfde67("ethereal_vapors");
      self.ignoreall = 1;
      self setgoal(self.origin);
      angles = self.enemy.angles + (0, 180, 0);
      self clearenemy();
      self.takedamage = 0;
      self namespace_ec06fe4a::function_8c808737();
      self forceteleport(spot, angles);
      wait 0.3;
      self.takedamage = 1;
      self namespace_ec06fe4a::function_4f72130c();
      self namespace_83eb6304::function_3ecfde67("ethereal_vapors");
      self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_ghost_warp_in");
      wait 0.5;
      self.ignoreall = 0;
      wait 1 + randomint(8);
    }
  }
}