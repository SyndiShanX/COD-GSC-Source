/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_killing_time.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_killing_time;

function autoexec __init__sytem__() {
  system::register("zm_bgb_killing_time", & __init__, undefined, "bgb");
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  level flag::init("world_is_paused");
  bgb::register("zm_bgb_killing_time", "activated", 1, undefined, undefined, & validation, & activation);
  bgb::register_actor_damage_override("zm_bgb_killing_time", & actor_damage_override);
  zm::register_vehicle_damage_callback( & vehicle_damage_override);
  clientfield::register("actor", "zombie_instakill_fx", 1, 1, "int");
  clientfield::register("toplayer", "instakill_upgraded_fx", 1, 1, "int");
}

function activation() {
  self function_eb0b4e74();
}

function validation() {
  if(bgb::is_team_active("zm_bgb_killing_time")) {
    return 0;
  }
  if(isDefined(level.var_9f5c2c50)) {
    return [[level.var_9f5c2c50]]();
  }
  return 1;
}

function private actor_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  if(self.archetype !== "zombie") {
    return idamage;
  }
  if(isDefined(level.var_48c4b2bf) && (!(isDefined([[level.var_48c4b2bf]](self)) && [[level.var_48c4b2bf]](self)))) {
    return idamage;
  }
  if(isDefined(self.interdimensional_gun_weapon) && isDefined(self.interdimensional_gun_attacker)) {
    return idamage;
  }
  if(isplayer(eattacker) && (isDefined(eattacker.forceanhilateondeath) && eattacker.forceanhilateondeath)) {
    if(isDefined(eattacker.var_d63e841a) && eattacker.var_d63e841a) {
      assert(isDefined(eattacker.var_b3258f2e));
      if(!isinarray(eattacker.var_b3258f2e, self)) {
        eattacker.var_b3258f2e[eattacker.var_b3258f2e.size] = self;
        self thread zombie_utility::zombie_eye_glow_stop();
      }
      return 0;
    }
    self clientfield::set("zombie_instakill_fx", 1);
    return self.health + 1;
  }
  return idamage;
}

function private vehicle_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(isDefined(self.var_a0e2dfff) && self.var_a0e2dfff) {
    return idamage;
  }
  if(isplayer(eattacker) && (isDefined(eattacker.forceanhilateondeath) && eattacker.forceanhilateondeath)) {
    if(isDefined(eattacker.var_d63e841a) && eattacker.var_d63e841a) {
      assert(isDefined(eattacker.var_b3258f2e));
      if(!isinarray(eattacker.var_b3258f2e, self)) {
        eattacker.var_b3258f2e[eattacker.var_b3258f2e.size] = self;
      }
      return 0;
    }
    return self.health + 1;
  }
  if(isDefined(level.bzm_worldpaused) && level.bzm_worldpaused) {
    return 0;
  }
  return idamage;
}

function function_eb0b4e74() {
  self endon("death");
  assert(!isDefined(self.var_b3258f2e));
  foreach(player in level.players) {
    player clientfield::set_to_player("instakill_upgraded_fx", 1);
  }
  self.var_b3258f2e = [];
  self.forceanhilateondeath = 1;
  self playSound("zmb_bgb_killingtime_start");
  self playLoopSound("zmb_bgb_killingtime_loop", 1);
  self.var_d63e841a = 1;
  level.bzm_worldpaused = 1;
  level flag::set("world_is_paused");
  setpauseworld(1);
  self thread function_f2925308();
  self bgb::run_timer(20);
  self notify("killing_time_done");
}

function function_f2925308() {
  str_notify = self util::waittill_any_return("death", "killing_time_done");
  if(str_notify == "killing_time_done") {
    self.var_d63e841a = 0;
    self stoploopsound(0.5);
    self playSound("zmb_bgb_killingtime_end");
    foreach(player in level.players) {
      self clientfield::set_to_player("instakill_upgraded_fx", 0);
    }
    for(i = self.var_b3258f2e.size - 1; i >= 0; i--) {
      ai = self.var_b3258f2e[i];
      if(isDefined(ai) && isalive(ai)) {
        if(isactor(ai)) {
          ai asmsetanimationrate(1);
          ai zombie_utility::gib_random_parts();
          gibserverutils::annihilate(ai);
        }
        ai dodamage(ai.health + 1, self.origin, self);
      }
    }
    self.var_b3258f2e = undefined;
    self.forceanhilateondeath = 0;
  }
  level.bzm_worldpaused = 0;
  setpauseworld(0);
  level flag::clear("world_is_paused");
}