/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_moon_ai_quad.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\animation_state_machine_mocomp;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\zombie_quad;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace zm_moon_ai_quad;

function autoexec init() {
  function_e9b3dfb0();
  spawner::add_archetype_spawn_function("zombie_quad", &function_5076473f);
}

function private function_e9b3dfb0() {
  behaviortreenetworkutility::registerbehaviortreescriptapi("quadPhasingService", &quadphasingservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldPhase", &shouldphase);
  behaviortreenetworkutility::registerbehaviortreescriptapi("phaseActionStart", &phaseactionstart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("phaseActionTerminate", &phaseactionterminate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("moonQuadKilledByMicrowaveGunDw", &killedbymicrowavegundw);
  behaviortreenetworkutility::registerbehaviortreescriptapi("moonQuadKilledByMicrowaveGun", &killedbymicrowavegun);
  animationstatenetwork::registernotetrackhandlerfunction("phase_start", &function_51ab54f7);
  animationstatenetwork::registernotetrackhandlerfunction("phase_end", &function_428f351c);
  animationstatenetwork::registeranimationmocomp("quad_phase", &function_4e0a671e, undefined, undefined);
}

function private quadphasingservice(entity) {
  if(isDefined(entity.is_phasing) && entity.is_phasing) {
    return false;
  }
  entity.var_662afd11 = 0;
  if(entity.var_20535e44 == 0) {
    if(math::cointoss()) {
      entity.var_3b07930a = "quad_phase_right";
    } else {
      entity.var_3b07930a = "quad_phase_left";
    }
  } else {
    if(entity.var_20535e44 == -1) {
      entity.var_3b07930a = "quad_phase_right";
    } else {
      entity.var_3b07930a = "quad_phase_left";
    }
  }
  if(entity.var_3b07930a == "quad_phase_left") {
    if(isplayer(entity.enemy) && entity.enemy islookingat(entity)) {
      if(entity maymovefrompointtopoint(entity.origin, zombie_utility::getanimendpos(level.var_9fcbbc83["phase_left_long"]))) {
        entity.var_662afd11 = 1;
      }
    }
  } else if(isplayer(entity.enemy) && entity.enemy islookingat(entity)) {
    if(entity maymovefrompointtopoint(entity.origin, zombie_utility::getanimendpos(level.var_9fcbbc83["phase_right_long"]))) {
      entity.var_662afd11 = 1;
    }
  }
  if(!(isDefined(entity.var_662afd11) && entity.var_662afd11)) {
    if(entity maymovefrompointtopoint(entity.origin, zombie_utility::getanimendpos(level.var_9fcbbc83["phase_forward"]))) {
      entity.var_662afd11 = 1;
      entity.var_3b07930a = "quad_phase_forward";
    }
  }
  if(isDefined(entity.var_662afd11) && entity.var_662afd11) {
    blackboard::setblackboardattribute(entity, "_quad_phase_direction", entity.var_3b07930a);
    if(math::cointoss()) {
      blackboard::setblackboardattribute(entity, "_quad_phase_distance", "quad_phase_short");
    } else {
      blackboard::setblackboardattribute(entity, "_quad_phase_distance", "quad_phase_long");
    }
    return true;
  }
  return false;
}

function private shouldphase(entity) {
  if(!(isDefined(entity.var_662afd11) && entity.var_662afd11)) {
    return false;
  }
  if(isDefined(entity.is_phasing) && entity.is_phasing) {
    return false;
  }
  if((gettime() - entity.var_b7d765b3) < 2000) {
    return false;
  }
  if(!isDefined(entity.enemy)) {
    return false;
  }
  dist_sq = distancesquared(entity.origin, entity.enemy.origin);
  min_dist_sq = 4096;
  max_dist_sq = 1000000;
  if(entity.var_3b07930a == "quad_phase_forward") {
    min_dist_sq = 14400;
    max_dist_sq = 5760000;
  }
  if(dist_sq < min_dist_sq) {
    return false;
  }
  if(dist_sq > max_dist_sq) {
    return false;
  }
  if(!isDefined(entity.pathgoalpos) || distancesquared(entity.origin, entity.pathgoalpos) < min_dist_sq) {
    return false;
  }
  if(abs(entity getmotionangle()) > 15) {
    return false;
  }
  yaw = zombie_utility::getyawtoorigin(entity.enemy.origin);
  if(abs(yaw) > 45) {
    return false;
  }
  return true;
}

function private phaseactionstart(entity) {
  entity.is_phasing = 1;
  if(entity.var_3b07930a == "quad_phase_left") {
    entity.var_20535e44--;
  } else if(entity.var_3b07930a == "quad_phase_right") {
    entity.var_20535e44++;
  }
}

function private phaseactionterminate(entity) {
  entity.var_b7d765b3 = gettime();
  entity.is_phasing = 0;
}

function private killedbymicrowavegundw(entity) {
  return isDefined(entity.microwavegun_dw_death) && entity.microwavegun_dw_death;
}

function private killedbymicrowavegun(entity) {
  return isDefined(entity.microwavegun_death) && entity.microwavegun_death;
}

function private function_51ab54f7(entity) {
  entity thread moon_quad_phase_fx("quad_phasing_out");
  entity ghost();
}

function private function_428f351c(entity) {
  entity thread moon_quad_phase_fx("quad_phasing_in");
  entity show();
}

function private function_4e0a671e(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity animmode("gravity", 0);
}

function function_5076473f() {
  self.var_662afd11 = 0;
  self.var_b7d765b3 = gettime();
  self.var_20535e44 = 0;
  if(!isDefined(level.var_9fcbbc83)) {
    level.var_9fcbbc83 = [];
    level.var_9fcbbc83["phase_forward"] = self animmappingsearch(istring("anim_zombie_phase_f_long_b"));
    level.var_9fcbbc83["phase_left_long"] = self animmappingsearch(istring("anim_zombie_phase_l_long_b"));
    level.var_9fcbbc83["phase_left_short"] = self animmappingsearch(istring("anim_zombie_phase_l_short_b"));
    level.var_9fcbbc83["phase_right_long"] = self animmappingsearch(istring("anim_zombie_phase_r_long_b"));
    level.var_9fcbbc83["phase_right_short"] = self animmappingsearch(istring("anim_zombie_phase_r_short_a"));
  }
}

function moon_quad_prespawn() {
  self.no_gib = 1;
  self.zombie_can_sidestep = 1;
  self.zombie_can_forwardstep = 1;
  self.sidestepfunc = &moon_quad_sidestep;
  self.fastsprintfunc = &moon_quad_fastsprint;
}

function moon_quad_sidestep(animname, stepanim) {
  self endon("death");
  self endon("stop_sidestep");
  self thread moon_quad_wait_phase_end(stepanim);
  self thread moon_quad_exit_align(stepanim);
  while(true) {
    self waittill(animname, note);
    if(note == "phase_start") {
      self thread moon_quad_phase_fx("quad_phasing_out");
      self playSound("zmb_quad_phase_out");
      self ghost();
    } else if(note == "phase_end") {
      self notify("stop_wait_phase_end");
      self thread moon_quad_phase_fx("quad_phasing_in");
      self show();
      self playSound("zmb_quad_phase_in");
      break;
    }
  }
}

function moon_quad_fastsprint() {
  if(isDefined(self.in_low_gravity) && self.in_low_gravity) {
    return "low_g_super_sprint";
  }
  return "super_sprint";
}

function moon_quad_wait_phase_end(stepanim) {
  self endon("death");
  self endon("stop_wait_phase_end");
  anim_length = getanimlength(stepanim);
  wait(anim_length);
  self thread moon_quad_phase_fx("quad_phasing_in");
  self show();
  self notify("stop_sidestep");
}

function moon_quad_exit_align(stepanim) {
  self endon("death");
  anim_length = getanimlength(stepanim);
  wait(anim_length);
  if(!(isDefined(self.exit_align) && self.exit_align)) {
    self notify("stepanim", "exit_align");
  }
}

function moon_quad_phase_fx(var_99a8589b) {
  self endon("death");
  if(isDefined(level._effect[var_99a8589b])) {
    playFXOnTag(level._effect[var_99a8589b], self, "j_spine4");
  }
}

function moon_quad_gas_immune() {
  self endon("disconnect");
  self endon("death");
}