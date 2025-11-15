/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\gadgets\gadget_cymbal_monkey.gsc
******************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace gadget_cymbal_monkey;

autoexec __init__system__() {
  system::register(#"cymbal_monkey", &__init__, &__main__, undefined);
}

private __init__() {
  level.var_7d95e1ed = [];
  level.var_7c5c96dc = &function_4f90c4c2;
  level thread function_a23699fe();
  callback::on_finalize_initialization(&function_1c601b99);
}

function_1c601b99() {
  if(isDefined(level.var_a5dacbea)) {
    [[level.var_a5dacbea]](getweapon(#"cymbal_monkey"), &function_127fb8f3);
  }
}

private __main__() {
  level._effect[#"monkey_glow"] = #"zm_weapons/fx8_cymbal_monkey_light";
}

private function_a23699fe() {
  level endon(#"game_ended");
  sticker_iw9_512 = 250;

  while(true) {
    for(i = 0; i < level.var_7d95e1ed.size; i++) {
      monkey = level.var_7d95e1ed[i];

      if(!isDefined(monkey) || isDefined(monkey.fuse_lit) && monkey.fuse_lit) {
        continue;
      }

      if(!isDefined(monkey.var_38af96b9)) {
        monkey delete();
        continue;
      }

      if(function_7e60533f(monkey, sticker_iw9_512)) {
        monkey thread function_b9934c1d();
      }

      waitframe(1);
    }

    level.var_7d95e1ed = array::remove_undefined(level.var_7d95e1ed);
    waitframe(1);
  }
}

private function_7e60533f(monkey, radius) {
  nearby_players = getentitiesinradius(monkey.origin, radius, 1);

  foreach(player in nearby_players) {
    if(function_17c51c94(monkey, player)) {
      return true;
    }
  }

  var_b1de6a06 = getentitiesinradius(monkey.origin, radius, 15);

  foreach(actor in var_b1de6a06) {
    if(function_17c51c94(monkey, actor)) {
      return true;
    }
  }

  return false;
}

private function_17c51c94(monkey, ent) {
  if(!isDefined(ent)) {
    return false;
  }

  if((isplayer(ent) || isactor(ent)) && util::function_fbce7263(ent.team, monkey.team)) {
    return true;
  }

  return false;
}

private event_handler[grenade_fire] function_4776caf4(eventstruct) {
  if(eventstruct.weapon.name == #"cymbal_monkey") {
    e_grenade = eventstruct.projectile;
    e_grenade ghost();
    e_grenade.angles = self.angles;
    mdl_monkey = util::spawn_model(e_grenade.model, e_grenade.origin, e_grenade.angles);
    e_grenade.mdl_monkey = mdl_monkey;
    e_grenade.mdl_monkey linkto(e_grenade);
    e_grenade.mdl_monkey.var_38af96b9 = e_grenade;
    e_grenade.mdl_monkey.team = e_grenade.team;
    e_grenade.mdl_monkey clientfield::set("enemyequip", 1);
    e_grenade waittill(#"stationary", #"death");

    if(!isDefined(e_grenade) && isDefined(mdl_monkey)) {
      mdl_monkey delete();
    }

    if(isDefined(self) && isDefined(e_grenade) && isDefined(e_grenade.mdl_monkey)) {
      e_grenade.mdl_monkey.var_acdc8d71 = getclosestpointonnavmesh(e_grenade.mdl_monkey.origin, 360, 15.1875);
      array::add(level.var_7d95e1ed, e_grenade.mdl_monkey);
      self callback::callback(#"hash_3c09ead7e9d8a968", e_grenade.mdl_monkey);
    }
  }
}

function_b9934c1d() {
  self endon(#"death");

  if(isDefined(level.var_2746aef8)) {
    [[level.var_2746aef8]](self);
  }

  self.fuse_lit = 1;
  self playSound(#"hash_4509539f9e7954e2");
  playFXOnTag(level._effect[#"monkey_glow"], self, "tag_weapon");
  self thread scene::play(#"cin_t8_monkeybomb_dance", self);
  self thread util::delay(6.5, "death", &function_4e61e1d);
  var_de3026af = gettime() + int(8 * 1000);

  while(gettime() < var_de3026af) {
    if(!isDefined(self.var_38af96b9)) {
      break;
    }

    waitframe(1);
  }

  self function_4f90c4c2();
}

function_4e61e1d() {
  self playSound(#"zmb_vox_monkey_explode");
}

function_4f90c4c2() {
  if(isDefined(self.var_38af96b9)) {
    self callback::callback(#"hash_6aa0232dd3c8376a");
    playsoundatposition(#"wpn_claymore_alert", self.origin);
    self.var_38af96b9 detonate();
  }

  self delete();
}

function_4a5dff80(zombie) {
  var_2d9e38fc = 360 * 360;
  var_128c12c9 = undefined;
  best_monkey = undefined;

  foreach(monkey in level.var_7d95e1ed) {
    if(!isDefined(monkey)) {
      continue;
    }

    dist_sq = distancesquared(zombie.origin, monkey.origin);

    if(isDefined(monkey) && isDefined(monkey.fuse_lit) && monkey.fuse_lit && dist_sq < var_2d9e38fc) {
      if(!isDefined(var_128c12c9) || dist_sq < var_128c12c9) {
        var_128c12c9 = dist_sq;
        best_monkey = monkey;
      }
    }
  }

  return best_monkey;
}

function_127fb8f3(cymbal_monkey, attackingplayer) {
  cymbal_monkey endon(#"death");
  randangle = randomfloat(360);

  if(isDefined(level._equipment_emp_destroy_fx)) {
    playFX(level._equipment_emp_destroy_fx, cymbal_monkey.origin + (0, 0, 5), (cos(randangle), sin(randangle), 0), anglestoup(cymbal_monkey.angles));
  }

  wait 1.1;
  playFX(#"hash_65c5042becfbaa7d", cymbal_monkey.origin);
  cymbal_monkey function_4f90c4c2();
}