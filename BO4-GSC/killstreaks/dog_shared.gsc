/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\dog_shared.gsc
***********************************************/

#include scripts\abilities\ability_player;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\gestures;
#include scripts\core_common\globallogic\globallogic_score;
#include scripts\core_common\influencers_shared;
#include scripts\core_common\scoreevents_shared;
#include scripts\killstreaks\ai\dog;
#include scripts\killstreaks\ai\escort;
#include scripts\killstreaks\ai\leave;
#include scripts\killstreaks\ai\patrol;
#include scripts\killstreaks\ai\state;
#include scripts\killstreaks\ai\tracking;
#include scripts\killstreaks\killstreak_bundles;
#include scripts\killstreaks\killstreakrules_shared;
#include scripts\killstreaks\killstreaks_shared;

#namespace dog;

init_shared() {
  if(!isDefined(level.dog_shared)) {
    level.dog_shared = {};
    archetypempdog::init();
    clientfield::register("clientuimodel", "hudItems.dogState", 1, 2, "int");
    clientfield::register("actor", "dogState", 1, 1, "int");
    ability_player::function_92292af6(34, undefined, &deployed_off);
    level thread function_8d543b98();
  }
}

function_8d543b98() {
  level waittill(#"game_ended");
  corpses = getcorpsearray();

  foreach(corpse in corpses) {
    if(isactorcorpse(corpse) && corpse.archetype === #"mp_dog") {
      corpse delete();
    }
  }
}

deployed_off(slot, weapon) {
  self gadgetpowerset(slot, 0);

  if(isDefined(self.pers[#"held_gadgets_power"]) && isDefined(self._gadgets_player[slot]) && isDefined(self.pers[#"held_gadgets_power"][self._gadgets_player[slot]])) {
    self.pers[#"held_gadgets_power"][self._gadgets_player[slot]] = 0;
  }
}

spawned(type) {
  assert(isplayer(self));
  playsoundatposition(#"hash_7245f25f5953631c", self.origin);
  player = self;
  bundle = level.killstreaks[type].script_bundle;

  if(player isplayerswimming()) {
    if(isDefined(bundle) && isDefined(level.var_228e8cd6)) {
      player[[level.var_228e8cd6]](bundle.ksweapon);
    }

    if(isDefined(bundle.var_502a0e23)) {
      player iprintlnbold(bundle.var_502a0e23);
    }

    return false;
  }

  if(!player killstreakrules::iskillstreakallowed(type, player.team)) {
    if(isDefined(bundle) && isDefined(level.var_228e8cd6)) {
      player[[level.var_228e8cd6]](bundle.ksweapon);
    }

    return false;
  }

  player tracking::track(2);
  dog = spawn_dog(bundle, player);

  if(!isDefined(dog)) {
    if(isDefined(bundle) && isDefined(level.var_228e8cd6)) {
      player[[level.var_228e8cd6]](bundle.ksweapon);
    }

    return false;
  }

  dog killstreak_bundles::spawned(bundle);
  dog influencers::create_entity_enemy_influencer("dog", player.team);
  ability_player::function_c22f319e(bundle.ksweapon);
  dog clientfield::set("enemyvehicle", 1);
  return true;
}

function_a38d2d73(tacpoint) {
  players = getplayers();

  foreach(player in players) {
    if(distancesquared(tacpoint.origin, player.origin) <= 150 * 150) {
      return true;
    }
  }

  return false;
}

function_4670789f(tacpoint) {
  players = getplayers();

  foreach(player in players) {
    if(function_96c81b85(tacpoint, player.origin)) {
      return true;
    }
  }

  return false;
}

private function_9cb166cd(tacpoints) {
  assert(isDefined(tacpoints) && tacpoints.size);
  filteredpoints = [];

  foreach(tacpoint in tacpoints) {
    if(!function_4670789f(tacpoint) && !function_a38d2d73(tacpoint) && ai_escort::function_d15dd929(tacpoint.origin)) {
      filteredpoints[filteredpoints.size] = tacpoint;
    }
  }

  return filteredpoints;
}

private function_fb11cc0f(owner) {
  cylinder = ai::t_cylinder(owner.origin, 800, 150);
  angles = owner getplayerangles();
  forwarddir = anglesToForward(angles);
  var_84e7232 = owner.origin + vectorscale(forwarddir, 100);
  var_441c6196 = ai::t_cylinder(owner.origin, 100, 150);
  tacpoints = tacticalquery("mp_dog_spawn", owner.origin, owner, cylinder, var_441c6196, var_84e7232);

  if(isDefined(tacpoints) && tacpoints.size) {
    tacpoints = function_9cb166cd(tacpoints);

    if(tacpoints.size) {
      tacpoint = array::random(tacpoints);
      return {
        #origin: tacpoint.origin, 
        #angles: owner.angles
      };
    }
  }

  tacpoints = tacticalquery("mp_dog_spawn_fallback", owner.origin, owner, cylinder, var_441c6196, var_84e7232);

  if(isDefined(tacpoints) && tacpoints.size) {
    tacpoints = function_9cb166cd(tacpoints);

    if(tacpoints.size) {
      tacpoint = array::random(tacpoints);
      return {
        #origin: tacpoint.origin, 
        #angles: owner.angles
      };
    }
  }

  tacpoints = tacticalquery("mp_dog_spawn_fallback_2", owner.origin, owner, cylinder, var_441c6196);

  if(isDefined(tacpoints) && tacpoints.size) {
    tacpoints = function_9cb166cd(tacpoints);

    if(tacpoints.size) {
      tacpoint = array::random(tacpoints);
      return {
        #origin: tacpoint.origin, 
        #angles: owner.angles
      };
    }
  }

  closest = getclosestpointonnavmesh(owner.origin, 1200, 1);

  if(isDefined(closest)) {
    return {
      #origin: closest, 
      #angles: owner.angles
    };
  }

  return undefined;
}

spawn_dog(bundle, owner) {
  if(isDefined(level.var_560ecf29)) {
    spawn = [[level.var_560ecf29]](owner);
  }

  if(!isDefined(spawn)) {
    spawn = function_fb11cc0f(owner);
  }

  if(!isDefined(spawn)) {
    return undefined;
  }

  angles = spawn.angles;
  origin = spawn.origin;
  dog = spawnactor(bundle.var_32f64ba3, origin, angles, "", 1);
  dog ai_patrol::function_d091ff45(bundle);
  dog ai_escort::function_60415868(bundle);
  dog ai_leave::init_leave(bundle.var_cadb59a0);
  dog callback::function_d8abfc3d(#"hash_c3f225c9fa3cb25", &function_3fb68a86);
  dog.goalradius = bundle.var_a562774d;
  dog setentityowner(owner);
  dog setteam(owner.team);
  dog callback::function_d8abfc3d(#"on_ai_killed", &function_d86da2e8);
  dog callback::function_d8abfc3d(#"on_killed_player", &function_64247932);
  dog.ai.var_b1248bd1 = 1;
  dog set_state(1, 1);
  owner thread function_458bc8de(dog);
  owner thread function_2f6f43cf(dog, bundle.ksweapon);
  dog thread killstreaks::function_fff56140(owner, &abort_dog);
  dog callback::function_d8abfc3d(#"on_end_game", &function_a1b9ccf1);

  if(isDefined(bundle.ksduration)) {
    dog thread killstreaks::waitfortimeout(bundle.kstype, bundle.ksduration, &timeout, "death");
  }

  if(!ai_escort::function_d15dd929(dog.origin)) {
    cylinder = ai::t_cylinder(origin, 1500, 250);
    var_441c6196 = ai::t_cylinder(origin, 100, 250);
    tacpoints = tacticalquery("mp_dog_spawn_fallback", origin, self, cylinder, var_441c6196, self.origin);

    if(isDefined(tacpoints) && tacpoints.size) {
      tacpoints = function_9cb166cd(tacpoints);

      if(tacpoints.size) {
        tacpoint = array::random(tacpoints);
        dog forceteleport(tacpoint.origin, dog.angles);
      }
    }
  }

  if(isDefined(level.var_8d02c681)) {
    dog[[level.var_8d02c681]]();
  }

  owner.killstreak_dog = dog;

    return dog;
}

set_state(state, var_deeb4ee7) {
  self.favoriteenemy = undefined;
  self.ai.hasseenfavoriteenemy = 0;
  function_3fda709e(self.script_owner, state + 1);

  if(isDefined(level.var_c08cd9fa) && isDefined(var_deeb4ee7) && !var_deeb4ee7) {
    self[[level.var_c08cd9fa]](state, self);
  }

  if(state == 2) {
    self clientfield::set("dogState", 1);

    if(isDefined(self.script_owner)) {
      self.script_owner globallogic_score::function_d3ca3608(#"hash_28a8b95557ddc249");
    }

    wait 0.5;
  }

  self ai_state::set_state(state);
}

function_3fda709e(owner, value) {
  if(isDefined(owner)) {
    owner clientfield::set_player_uimodel("hudItems.dogState", value);
  }
}

function_8296c0eb(owner) {
  if(!isDefined(owner)) {
    return false;
  }

  if(!isalive(owner)) {
    return false;
  }

  if(!isplayer(owner)) {
    return false;
  }

  if(owner.sessionstate == "spectator") {
    return false;
  }

  if(owner.sessionstate == "intermission") {
    return false;
  }

  if(isDefined(level.intermission) && level.intermission) {
    return false;
  }

  return true;
}

toggle_state(owner) {
  if(function_8296c0eb(owner)) {
    owner gestures::function_56e00fbf(#"hash_2c75f3bef8443438", undefined, 0);
  }

  if(self ai_state::is_state(1)) {
    self set_state(0, 0);
    return;
  }

  if(self ai_state::is_state(0)) {
    self set_state(1, 0);
  }
}

function_2d96af8d() {
  self ai_patrol::function_325c6829(self.script_owner.origin);
}

function_458bc8de(dog) {
  self endon(#"disconnect");
  dog endon(#"death");
  dog notify(#"hash_27a4203e237c5098");
  dog endon(#"hash_27a4203e237c5098");
  wait 0.5;

  while(true) {
    if(!(isDefined(level.var_347a87db) && level.var_347a87db) && self offhandspecialbuttonpressed() && !self function_104d7b4d() && !self isusingoffhand()) {
      dog toggle_state(self);
      wait 0.5;
    }

    waitframe(1);
  }
}

function_a1b9ccf1() {
  self.ignoreall = 1;
  self set_state(0, 0);
}

abort_dog() {
  self.ignoreall = 1;
  self set_state(2, 0);
  self delete();
}

function_441cdbb6() {
  self.ignoreall = 1;
  self set_state(2, 0);
}

private function_e74b21de(owner) {
  if(isDefined(owner) && distancesquared(owner.origin, self.origin) < 256 * 256) {
    origin = owner.origin;
    angles = owner getplayerangles();
    forwarddir = anglesToForward(angles);
    var_84e7232 = owner.origin + vectorscale(forwarddir, 100);
  } else {
    origin = self.origin;
    angles = self.angles;
    var_84e7232 = origin;
  }

  cylinder = ai::t_cylinder(origin, 1500, 250);
  var_441c6196 = ai::t_cylinder(origin, 100, 250);

  if(isDefined(owner)) {
    tacpoints = tacticalquery("mp_dog_spawn", origin, owner, cylinder, var_441c6196, var_84e7232);
  } else {
    tacpoints = tacticalquery("mp_dog_spawn", origin, self, cylinder, var_441c6196, var_84e7232);
  }

  if(isDefined(tacpoints) && tacpoints.size) {
    tacpoints = function_9cb166cd(tacpoints);

    if(tacpoints.size) {
      tacpoint = array::random(tacpoints);
      return {
        #origin: tacpoint.origin, 
        #angles: angles
      };
    }
  }

  if(isDefined(owner)) {
    tacpoints = tacticalquery("mp_dog_spawn_fallback", origin, owner, cylinder, var_441c6196, var_84e7232);
  } else {
    tacpoints = tacticalquery("mp_dog_spawn_fallback", origin, self, cylinder, var_441c6196, var_84e7232);
  }

  if(isDefined(tacpoints) && tacpoints.size) {
    tacpoints = function_9cb166cd(tacpoints);

    if(tacpoints.size) {
      tacpoint = array::random(tacpoints);
      return {
        #origin: tacpoint.origin, 
        #angles: angles
      };
    }
  }

  var_ead7a19 = function_b777d194(self.origin);

  if(isDefined(var_ead7a19) && var_ead7a19.size) {
    leavepoint = array::random(var_ead7a19);
    return {
      #origin: leavepoint, 
      #angles: self.angles
    };
  }

  return {
    #origin: self.origin, 
    #angles: self.angles
  };
}

function_3fb68a86() {
  self.exit_spawn = function_e74b21de(self.script_owner);
  function_3fda709e(self.script_owner, 0);
}

timeout() {
  self endon(#"death");

  if(isDefined(level.var_12347bf6) && level.var_12347bf6) {
    return;
  }

  if(isDefined(self.script_owner)) {
    self.script_owner killstreaks::play_taacom_dialog("dogWeaponTimeout");
  }

  self function_441cdbb6();
}

function_2f6f43cf(dog, weapon) {
  self endon(#"disconnect");
  dog waittill(#"death");
  self ability_player::function_f2250880(weapon, 0);
}

private function_d86da2e8(params) {
  if(!isDefined(self) || !isDefined(params)) {
    return;
  }

  function_3fda709e(self.script_owner, 0);

  if(isDefined(params.eattacker) && isplayer(params.eattacker)) {
    bundle = self killstreak_bundles::function_48e9536e();

    if(isDefined(params.weapon) && params.weapon != getweapon(#"dog_ai_defaultmelee") && isplayer(params.eattacker)) {
      if(isDefined(self.script_owner)) {
        self.script_owner globallogic_score::function_5829abe3(params.eattacker, params.weapon, getweapon("dog_ai_defaultmelee"));
      }
    }

    if(isDefined(bundle.var_74711af9)) {
      if(isDefined(self.attackers)) {
        foreach(attacker in self.attackers) {
          if(attacker != params.eattacker && isDefined(self.script_owner)) {
            scoreevents::processscoreevent(#"killed_dog_assist", attacker, self.script_owner, undefined);
          }
        }
      }
    }

    if(isDefined(level.var_d2600afc)) {
      self[[level.var_d2600afc]](params.eattacker, self.script_owner, self.meleeweapon, params.weapon);
    }

    if(isDefined(self.script_owner)) {
      self.script_owner killstreaks::play_taacom_dialog("dogWeaponDestroyed");
    }
  }

  if(isDefined(self.script_owner)) {
    self.script_owner globallogic_score::function_d3ca3608(#"hash_28a8b95557ddc249");
  }
}

function_64247932() {}