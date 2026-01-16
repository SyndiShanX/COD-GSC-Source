/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_ray_gun_mk2v.gsc
***********************************************/

#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\throttle_shared;
#include scripts\core_common\util_shared;
#include scripts\zm\zm_lightning_chain;
#include scripts\zm_common\callbacks;
#include scripts\zm_common\zm_utility;

#namespace zm_weap_ray_gun_mk2v;

autoexec __init__system__() {
  system::register(#"ray_gun_mk2v", &__init__, undefined, undefined);
}

__init__() {
  level.var_477ad229 = getweapon("ray_gun_mk2v");
  level.var_5bda3938 = getweapon("ray_gun_mk2v_upgraded");
  level.var_f3d38af6 = lightning_chain::create_lightning_chain_params();
  level.var_f3d38af6.max_arcs = 6;
  level.var_f3d38af6.max_enemies_killed = 7;
  level.var_f3d38af6.radius_start = 160;
  level.var_f3d38af6.head_gib_chance = 0;
  level.var_f3d38af6.network_death_choke = 4;
  level.var_f3d38af6.should_kill_enemies = 0;
  level.var_f3d38af6.no_fx = 1;
  level.var_f3d38af6.clientside_fx = 0;
  level.var_f3d38af6.str_mod = "MOD_ELECTROCUTED";
  callback::add_weapon_fired(level.var_477ad229, &on_weapon_fired);
  callback::add_weapon_fired(level.var_5bda3938, &on_weapon_fired);
  callback::function_4b58e5ab(&function_ae5c4e8b);
  callback::on_ai_killed(&on_ai_killed);
  clientfield::register("allplayers", "" + #"ray_gun_mk2v_beam_fire", 20000, 2, "int");
  clientfield::register("allplayers", "" + #"ray_gun_mk2v_beam_flash", 20000, 1, "int");
  clientfield::register("actor", "" + #"hash_784061e6c2684e58", 20000, 1, "int");
  clientfield::register("actor", "" + #"hash_3b193ae69f9f4fac", 20000, 1, "counter");
  clientfield::register("actor", "" + #"ray_gun_mk2v_death", 20000, 1, "int");
  clientfield::register("scriptmover", "" + #"ray_gun_mk2v_stun_arc", 20000, 1, "int");

  if(!isDefined(level.var_46a7950a)) {
    level.var_46a7950a = new throttle();
    [[level.var_46a7950a]] - > initialize(3, 0.1);
  }
}

on_weapon_fired(weapon) {
  if(self.var_1de56cc8 !== 1) {
    self.var_1de56cc8 = 1;

    if(weapon == level.var_5bda3938) {
      self clientfield::set("" + #"ray_gun_mk2v_beam_fire", 2);
    } else {
      self clientfield::set("" + #"ray_gun_mk2v_beam_fire", 1);
    }

    self clientfield::set("" + #"ray_gun_mk2v_beam_flash", 1);
    self thread function_8d93c592(weapon);
    self thread function_f8fdc6ad(weapon);
  }
}

on_ai_killed(s_params) {
  if(function_4e923311(s_params.weapon)) {
    self clientfield::set("" + #"ray_gun_mk2v_death", 1);
  }
}

function_4e923311(weapon) {
  return isDefined(weapon) && (weapon == level.var_477ad229 || weapon == level.var_5bda3938);
}

function_8d93c592(w_curr) {
  self endon(#"death", #"stop_damage");

  while(true) {
    v_position = self getweaponmuzzlepoint();
    v_forward = self getweaponforwarddir();
    a_trace = beamtrace(v_position, v_position + v_forward * 20000, 1, self);
    var_1c218ece = a_trace[#"position"];

    function_7067b673(v_position, var_1c218ece, (1, 1, 0));
    render_debug_sphere(v_position, (1, 1, 0));
    render_debug_sphere(var_1c218ece, (1, 0, 0));

      if(isDefined(a_trace[#"entity"])) {
        e_last_target = a_trace[#"entity"];

        if(isDefined(e_last_target.zm_ai_category) && e_last_target.team !== #"allies" || isDefined(e_last_target.male_head)) {
          self thread function_5c035588(e_last_target, var_1c218ece, w_curr);
        }
      }

    e_last_target = undefined;
    waitframe(1);
  }
}

function_f8fdc6ad(w_curr) {
  self endoncallback(&stop_beam, #"death");
  wait 0.1;

  while(zm_utility::is_player_valid(self) && self isfiring() && self getweaponammoclip(w_curr) > 0 && !self ismeleeing() && !self isswitchingweapons()) {
    waitframe(1);
  }

  self stop_beam();
}

stop_beam(s_notify) {
  self clientfield::set("" + #"ray_gun_mk2v_beam_fire", 0);
  self clientfield::set("" + #"ray_gun_mk2v_beam_flash", 0);
  self.var_1de56cc8 = undefined;
  self notify(#"stop_damage");
}

private get_closest_tag(v_pos) {
  if(!isDefined(level.gib_tags)) {
    zombie_utility::init_gib_tags();
  }

  tag_closest = undefined;
  var_9aabd9de = arraycopy(level.gib_tags);

  if(!isDefined(var_9aabd9de)) {
    var_9aabd9de = [];
  } else if(!isarray(var_9aabd9de)) {
    var_9aabd9de = array(var_9aabd9de);
  }

  if(!isinarray(var_9aabd9de, "j_head")) {
    var_9aabd9de[var_9aabd9de.size] = "j_head";
  }

  for(i = 0; i < var_9aabd9de.size; i++) {
    if(!isDefined(tag_closest)) {
      tag_closest = var_9aabd9de[i];
      continue;
    }

    var_abe265db = self gettagorigin(var_9aabd9de[i]);
    var_2cd7818f = self gettagorigin(tag_closest);

    if(!isDefined(var_abe265db) || !isDefined(var_2cd7818f)) {
      continue;
    }

    if(distancesquared(v_pos, var_abe265db) < distancesquared(v_pos, var_2cd7818f)) {
      tag_closest = var_9aabd9de[i];
    }
  }

  return tolower(tag_closest);
}

private function_5c035588(e_target, v_target_pos, w_curr, b_launched = 0, var_9a119ceb = 0) {
  e_target endon(#"death");
  self endon(#"disconnect");

  if(!var_9a119ceb) {
    [[level.var_46a7950a]] - > waitinqueue(e_target);
  }

  if(e_target.archetype === #"zombie") {
    str_hitloc = "torso_lower";
    str_tag = e_target get_closest_tag(v_target_pos);

    if(str_tag === "j_head") {
      str_hitloc = "head";
    }
  } else {
    str_hitloc = "head";
  }

  if(isDefined(level.headshots_only) && level.headshots_only && str_hitloc !== "head") {
    return;
  }

  n_damage = 250;

  if(w_curr == level.var_5bda3938) {
    n_damage = 500;
  }

  if(isalive(e_target)) {
    if(isai(e_target)) {
      e_target function_3ac73c92(self, w_curr == level.var_5bda3938);
    }

    e_target dodamage(n_damage, v_target_pos, self, self, str_hitloc, "MOD_UNKNOWN", 0, w_curr);
  }

  if(b_launched && (e_target.zm_ai_category === #"basic" || e_target.zm_ai_category === #"enhanced")) {
    n_random_x = randomfloatrange(-3, 3);
    n_random_y = randomfloatrange(-3, 3);
    v_fling = 200 * vectornormalize(e_target.origin - v_target_pos + (n_random_x, n_random_y, 100));
    e_target zm_utility::function_ffc279(v_fling, self, undefined, w_curr);
  }
}

function_3ac73c92(e_player, b_upgraded) {
  if(!isDefined(self.var_a8f3f795)) {
    self.var_a8f3f795 = 0;
  }

  self.var_a8f3f795++;

  if(self.var_a8f3f795 >= 5) {
    self thread function_58fb8f5e(e_player, b_upgraded);
    self.var_a8f3f795 = 0;
    self notify(#"hash_3def847106434aab");
    return;
  }

  self thread function_3821f26e();
}

function_3821f26e() {
  self notify(#"hash_3def847106434aab");
  self endon(#"death", #"hash_3def847106434aab");
  wait 1;
  self.var_a8f3f795 = 0;
}

function_58fb8f5e(e_player, b_upgraded = 0) {
  self endon(#"death");

  if(gettime() === self.spawn_time) {
    waitframe(1);
  }

  if(isDefined(self)) {
    self clientfield::increment("" + #"hash_3b193ae69f9f4fac", 1);
  }

  if(!b_upgraded) {
    self function_2c08b6ac(e_player);
  } else {
    a_e_zombies = getaiteamarray(level.zombie_team);
    a_e_zombies = arraysortclosest(a_e_zombies, self getcentroid(), level.var_f3d38af6.max_arcs, 0, level.var_f3d38af6.radius_start);

    foreach(e_zombie in a_e_zombies) {
      e_zombie function_2c08b6ac(e_player);

      if(self != e_zombie) {
        level thread function_6f9fb9d7(self, e_zombie);
      }
    }
  }

  level notify(#"ray_gun_mk2v_stun_hit", {
    #e_player: e_player
  });
}

function_2c08b6ac(e_player) {
  if(!isalive(self)) {
    return;
  }

  if(self ai::is_stunned() || isDefined(self.var_6ee03e9a) && self.var_6ee03e9a) {
    return;
  }

  self.var_6ee03e9a = 1;
  self thread function_57f0555a(e_player);
}

function_57f0555a(e_player) {
  self endon(#"death");
  self clientfield::set("" + #"hash_784061e6c2684e58", 1);
  self lightning_chain::arc_damage_ent(e_player, 2, level.var_f3d38af6);
  wait 6;
  self thread function_ae5c4e8b();
}

function_ae5c4e8b() {
  if(self.var_6ee03e9a === 1) {
    self.var_6ee03e9a = 0;
    self clientfield::set("" + #"hash_784061e6c2684e58", 0);
  }
}

function_6f9fb9d7(e_source, e_target) {
  level endon(#"game_ended");
  v_source = e_source getcentroid();
  v_target = e_target getcentroid();

  if(distancesquared(v_source, v_target) >= 4096) {
    e_fx = util::spawn_model("tag_origin", v_source);
    e_fx clientfield::set("" + #"ray_gun_mk2v_stun_arc", 1);
    e_fx moveto(v_target, 0.11);
    e_fx waittill(#"movedone");
    e_fx delete();
  }
}

render_debug_sphere(origin, color) {
  if(getdvarint(#"turret_debug_server", 0)) {

    sphere(origin, 2, color, 0.75, 1, 10, 100);

  }
}

function_7067b673(origin1, origin2, color) {
  if(getdvarint(#"turret_debug_server", 0)) {

    line(origin1, origin2, color, 0.75, 1, 100);

  }
}