/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_nuketown_mannequin.gsc
*************************************************/

#using scripts\shared\ai\archetype_mannequin;
#using scripts\shared\ai_shared;
#using scripts\shared\music_shared;
#using scripts\shared\util_shared;
#namespace nuketownmannequin;

function spawnmannequin(origin, angles, gender = "male", speed = undefined, weepingangel) {
  if(!isDefined(level.mannequinspawn_music)) {
    level.mannequinspawn_music = 1;
    music::setmusicstate("mann");
  }
  if(gender == "male") {
    mannequin = spawnactor("spawner_bo3_mannequin_male", origin, angles, "", 1, 1);
  } else {
    mannequin = spawnactor("spawner_bo3_mannequin_female", origin, angles, "", 1, 1);
  }
  rand = randomint(100);
  if(rand <= 35) {
    mannequin.zombie_move_speed = "walk";
  } else {
    if(rand <= 70) {
      mannequin.zombie_move_speed = "run";
    } else {
      mannequin.zombie_move_speed = "sprint";
    }
  }
  if(isDefined(speed)) {
    mannequin.zombie_move_speed = speed;
  }
  if(isDefined(level.zm_variant_type_max)) {
    mannequin.variant_type = randomintrange(1, level.zm_variant_type_max[mannequin.zombie_move_speed][mannequin.zombie_arms_position]);
  }
  mannequin ai::set_behavior_attribute("can_juke", 1);
  mannequin asmsetanimationrate(randomfloatrange(0.98, 1.02));
  mannequin.holdfire = 1;
  mannequin.canstumble = 1;
  mannequin.should_turn = 1;
  mannequin thread watch_game_ended();
  mannequin.team = "free";
  mannequin.overrideactordamage = &mannequindamage;
  mannequins = getaiarchetypearray("mannequin");
  foreach(othermannequin in mannequins) {
    if(othermannequin.archetype == "mannequin") {
      othermannequin setignoreent(mannequin, 1);
      mannequin setignoreent(othermannequin, 1);
    }
  }
  if(weepingangel) {
    mannequin thread _mannequin_unfreeze_ragdoll();
    mannequin.is_looking_at_me = 1;
    mannequin.was_looking_at_me = 0;
    mannequin _mannequin_update_freeze(mannequin.is_looking_at_me);
  }
  playFX("dlc0/nuketown/fx_de_rez_man_spawn", mannequin.origin, anglesToForward(mannequin.angles));
  return mannequin;
}

function mannequindamage(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
  if(isDefined(inflictor) && isactor(inflictor) && inflictor.archetype == "mannequin") {
    return 0;
  }
  return damage;
}

function private watch_game_ended() {
  self endon("death");
  level waittill("game_ended");
  self setentitypaused(1);
  level waittill("endgame_sequence");
  self hide();
}

function private _mannequin_unfreeze_ragdoll() {
  self waittill("death");
  if(isDefined(self)) {
    self setentitypaused(0);
    if(!self isragdoll()) {
      self startragdoll();
    }
  }
}

function private _mannequin_update_freeze(frozen) {
  self.is_looking_at_me = frozen;
  if(self.is_looking_at_me && !self.was_looking_at_me) {
    self setentitypaused(1);
  } else if(!self.is_looking_at_me && self.was_looking_at_me) {
    self setentitypaused(0);
  }
  self.was_looking_at_me = self.is_looking_at_me;
}

function watch_player_looking() {
  level endon("game_ended");
  level endon("mannequin_force_cleanup");
  while(true) {
    mannequins = getaiarchetypearray("mannequin");
    foreach(mannequin in mannequins) {
      mannequin.can_player_see_me = 1;
    }
    players = getplayers();
    unseenmannequins = mannequins;
    foreach(player in players) {
      unseenmannequins = player cantseeentities(unseenmannequins, 0.67, 0);
    }
    foreach(mannequin in unseenmannequins) {
      mannequin.can_player_see_me = 0;
    }
    foreach(mannequin in mannequins) {
      mannequin _mannequin_update_freeze(mannequin.can_player_see_me);
    }
    wait(0.05);
  }
}