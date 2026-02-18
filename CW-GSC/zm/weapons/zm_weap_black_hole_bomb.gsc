/**************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_black_hole_bomb.gsc
**************************************************/

#using script_24c32478acf44108;
#using script_4dc6a9b234b838e1;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_vortex;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_world;
#using scripts\core_common\item_world_util;
#using scripts\core_common\spawning_squad;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\weapons\weaponobjects;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#namespace zm_weap_black_hole_bomb;

function private autoexec __init__system__() {
  system::register(#"zm_weap_black_hole_bomb", &preinit, &postinit, undefined, "zm_weapons");
}

function private preinit() {
  clientfield::register("actor", "" + # "hash_399ab6541d717dc7", 1, 1, "int");
  level.var_2e1abf5f = getweapon(#"hash_6a4dd5ed56f6e3f6");
  weaponobjects::function_e6400478(#"hash_6a4dd5ed56f6e3f6", &function_54881ba1, 1);
  zm_weapons::function_404c3ad5(level.var_2e1abf5f, &function_995359b9);
  zm_weapons::function_76403f51(level.var_2e1abf5f);
  callback::add_callback(#"on_ai_killed", &function_ca505fd3);
  namespace_9ff9f642::register_slowdown(#"hash_2c88ef7895dccf65", 0.7, 1);
  namespace_9ff9f642::register_slowdown(#"bhb_slowdown", 0.6, 1);
}

function function_995359b9(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, modelindex, surfacetype, vsurfacenormal) {
  if(isentity(surfacetype) && isPlayer(vsurfacenormal)) {
    self.var_22e8a925 = surfacetype.origin;
    self.var_87b962fc = gettime() + 1000;
  }
}

function function_ca505fd3(params) {
  if(params.weapon === level.var_2e1abf5f && isPlayer(params.eattacker) && params.smeansofdeath === "MOD_GRENADE_SPLASH" && isDefined(self.var_87b962fc) && gettime() < self.var_87b962fc) {
    self namespace_cc411409::ragdoll_launch(isDefined(self.var_22e8a925) ? self.var_22e8a925 : params.einflictor.origin, 2);
  }
}

function postinit() {}

function function_54881ba1(watcher) {
  watcher.onspawn = &function_e38ab081;
}

function function_e38ab081(watcher, player) {
  player endon(#"death");
  level endon(#"end_game");
  self thread function_93a73145(player);
}

function function_93a73145(owner) {
  self endon(#"death");
  self waittill(#"stationary");
  self resetmissiledetonationtime();
  successful = 0;

  if(zm_utility::is_point_inside_enabled_zone(self.origin)) {
    self.var_acdc8d71 = getclosestpointonnavmesh(self.origin, 100, 15.1875);

    if(isDefined(self.var_acdc8d71)) {
      level thread function_f576c273(self);
      self thread zombie_vortex::start_timed_vortex(1, self.var_acdc8d71, 275, level.var_2e1abf5f.explosionradius, owner, level.var_2e1abf5f, &function_9c0c8ac3, &vortex_explosion);
      successful = 1;
    }
  }

  if(!successful && isPlayer(owner) && !is_true(owner.var_9e3339e2)) {
    owner thread function_600a82c(owner);
    self deletedelay();
  }
}

function private function_600a82c(player) {
  player endon(#"death");
  self notify("1d0aad1ca52c5f89");
  self endon("1d0aad1ca52c5f89");
  waitframe(1);
  item = function_4ba8fde(#"black_hole_bomb_item_t9_sr");

  if(isDefined(item)) {
    item.amount = 1;
    var_fa3df96 = player item_inventory::function_e66dcff5(item);

    if(isDefined(var_fa3df96)) {
      if(!item_world_util::function_db35e94f(item.networkid)) {
        item.networkid = item_world_util::function_970b8d86(var_fa3df96);
      }

      for(var_ddeb881e = item_inventory::function_2e711614(var_fa3df96); var_ddeb881e.itementry === item.itementry; var_ddeb881e = item_inventory::function_2e711614(var_fa3df96)) {
        waitframe(1);
      }

      if(var_ddeb881e.networkid === 32767) {
        player item_world::function_de2018e3(item, player, var_fa3df96, 0);
      }
    }
  }
}

function function_f576c273(var_a495cbed) {
  if(!isDefined(var_a495cbed)) {
    return;
  }

  level endon(#"game_ended");
  var_a495cbed endon(#"death");

  while(!mayspawnfakeentity()) {
    waitframe(1);
  }

  teleport_trigger = spawn("trigger_radius", var_a495cbed.var_acdc8d71, 0, 64, 70);
  var_a495cbed thread function_c2f76b45(teleport_trigger);
  var_a495cbed waittill(#"explode");
  teleport_trigger notify(#"hash_5e52043e21f343d7");
  wait 0.1;
  teleport_trigger delete();
}

function function_7ceb96bf(player, endon_condition) {
  endon_condition endon(#"death");

  if(!bullettracepassed(endon_condition getEye(), self.origin + (0, 0, 65), 0, endon_condition)) {
    return;
  }

  new_origin = undefined;

  if(isDefined(level.var_5816975b)) {
    new_origin = endon_condition[[level.var_5816975b]](endon_condition);
  }

  if(isDefined(level.var_8179368e)) {
    new_origin = endon_condition[[level.var_8179368e]](endon_condition, 1);
  }

  if(isDefined(level.var_dbf9c70d)) {
    new_origin = endon_condition[[level.var_dbf9c70d]](endon_condition);
  }

  if(!isDefined(new_origin)) {
    new_origin = endon_condition zm_player::check_for_valid_spawn_near_team(endon_condition, 1);
  }

  if(!isDefined(new_origin)) {
    if(isDefined(endon_condition.var_f4710251)) {
      targetplayer = getentbynum(endon_condition.var_f4710251);

      if(isDefined(targetplayer) && isPlayer(targetplayer) && isalive(targetplayer)) {
        new_origin = endon_condition squad_spawn::function_e402b74e(endon_condition, targetplayer);
      }
    }
  }

  if(isDefined(new_origin)) {
    angles = isDefined(new_origin.angles) ? new_origin.angles : (0, 0, 0);
    origin = isDefined(new_origin.origin) ? new_origin.origin : origin;
  }

  if(!isvec(origin) || !isvec(angles)) {
    return;
  }

  endon_condition function_13fce2b({
    #origin: origin, #angles: angles
  });
}

function function_c2f76b45(var_69cf75ad) {
  var_69cf75ad endon(#"hash_5e52043e21f343d7");

  while(true) {
    waitresult = var_69cf75ad waittill(#"trigger");
    ent_player = waitresult.activator;

    if(is_true(level.var_b54157cf)) {
      continue;
    }

    if(isPlayer(ent_player) && !ent_player isonground() && !is_true(ent_player.lander) && !ent_player function_b4813488() && !ent_player isonladder() && !ent_player isziplining()) {
      var_69cf75ad thread function_f6b48774(ent_player, &function_7ceb96bf, &function_a0b4dce9);
    }

    wait 0.1;
  }
}

function function_a0b4dce9(ent_player) {}

function function_f6b48774(ent, on_enter_payload, on_exit_payload) {
  ent endon(#"death");
  self endon(#"hash_5e52043e21f343d7");

  if(ent function_fa82badd(self)) {
    return;
  }

  self function_8658dbc9(ent);
  endon_condition = "leave_trigger_" + self getentitynumber();

  if(isDefined(on_enter_payload)) {
    self thread[[on_enter_payload]](ent, endon_condition);
  }

  while(isDefined(ent) && ent istouching(self) && isDefined(self)) {
    waitframe(1);
  }

  ent notify(endon_condition);

  if(isDefined(ent) && isDefined(on_exit_payload)) {
    self thread[[on_exit_payload]](ent);
  }

  if(isDefined(ent)) {
    self function_570c993c(ent);
  }
}

function function_fa82badd(trig) {
  if(!isDefined(self._triggers)) {
    return false;
  }

  if(!isDefined(self._triggers[trig getentitynumber()])) {
    return false;
  }

  if(!self._triggers[trig getentitynumber()]) {
    return false;
  }

  return true;
}

function function_8658dbc9(ent) {
  if(!isDefined(ent._triggers)) {
    ent._triggers = [];
  }

  ent._triggers[self getentitynumber()] = 1;
}

function function_570c993c(ent) {
  if(!isDefined(ent._triggers)) {
    return;
  }

  if(!isDefined(ent._triggers[self getentitynumber()])) {
    return;
  }

  ent._triggers[self getentitynumber()] = 0;
}

function function_13fce2b(var_9e4b7aff) {
  self endon(#"death");

  if(!isDefined(var_9e4b7aff)) {
    return;
  }

  prone_offset = (0, 0, 49);
  crouch_offset = (0, 0, 20);
  var_3334a329 = (0, 0, 0);
  destination = undefined;
  playsoundatposition(#"hash_89afcb430026d5c", self.origin + (0, 0, 50));

  if(self getstance() == "prone") {
    destination = var_9e4b7aff.origin + prone_offset;
  } else if(self getstance() == "crouch") {
    destination = var_9e4b7aff.origin + crouch_offset;
  } else {
    destination = var_9e4b7aff.origin + var_3334a329;
  }

  if(isDefined(level.var_6ca5d247)) {
    level[[level.var_6ca5d247]](self);
  }

  function_16713f43(var_9e4b7aff.origin);
  self val::set(#"bhb_teleport", "freezecontrols", 1);
  self val::set(#"bhb_teleport", "disable_offhand_weapons", 1);
  self val::set(#"bhb_teleport", "disable_weapons", 1);
  self playSound(#"hash_2bdcf53469acd60d");
  self dontinterpolate();
  self setorigin(destination);
  self setplayerangles(var_9e4b7aff.angles);
  self val::reset(#"bhb_teleport", "freezecontrols");
  self val::reset(#"bhb_teleport", "disable_offhand_weapons");
  self val::reset(#"bhb_teleport", "disable_weapons");
  self zm_stats::increment_challenge_stat(#"hash_5a6d38dd5c5f950d");
  self thread function_e788f77();
}

function function_16713f43(pos) {
  var_d3d9d70c = spawn("script_model", pos);
  var_d3d9d70c setModel("tag_origin");
  playFXOnTag(#"hash_78a8b7d254316482", var_d3d9d70c, "tag_origin");
  var_d3d9d70c playSound(#"hash_2f24566e72d6e2ab");
  var_d3d9d70c playLoopSound(#"hash_172aa3c3eb38f9a7");
  var_d3d9d70c thread function_f7e9dfd7();
}

function function_e788f77() {
  wait 1;
}

function function_f7e9dfd7() {
  wait 2;
  playsoundatposition("wpn_bhbomb_exit_end", self.origin);
  self delete();
}

function function_9c0c8ac3(v_vortex_origin, n_vortex_radius, n_start_time, n_vortex_time, svortex, eattacker, weapon) {
  team = isDefined(level.zombie_team) ? level.zombie_team : # "axis";

  for(n_currtime = 0; n_currtime <= n_vortex_time; n_currtime = gettime() - n_start_time) {
    a_ai_zombies = function_72d3bca6(getaiteamarray(team), v_vortex_origin, undefined, undefined, n_vortex_radius);
    a_ai_zombies = arraycombine(a_ai_zombies, zombie_vortex::vortex_z_extension(a_ai_zombies, v_vortex_origin, n_vortex_radius), 0, 0);
    svortex.zombies = a_ai_zombies;
    time = gettime();

    foreach(ai_zombie in a_ai_zombies) {
      if(!isDefined(ai_zombie.zm_ai_category)) {
        continue;
      }

      if(isvehicle(ai_zombie)) {
        if(isalive(ai_zombie) && isDefined(ai_zombie vehicle_ai::get_state_callbacks("idgun_death")) && ai_zombie vehicle_ai::get_current_state() != "idgun_death" && !ai_zombie.ignorevortices) {
          params = spawnStruct();
          params.vpoint = v_vortex_origin;
          params.attacker = eattacker;
          params.weapon = weapon;
          ai_zombie vehicle_ai::set_state("idgun_death", params);
        }

        continue;
      }

      ai_zombie clientfield::set("" + # "hash_399ab6541d717dc7", 1);
      ai_zombie.blockingpain = 1;
      ai_zombie thread function_fb7c4f41();

      switch (ai_zombie.zm_ai_category) {
        case # "normal":
          if(ai_zombie.archetype === # "zombie_dog") {
            ai_zombie thread namespace_9ff9f642::slowdown(#"bhb_slowdown");

            if(!isDefined(ai_zombie.var_56912e22) || time >= ai_zombie.var_56912e22) {
              var_34e3b3f7 = ai_zombie.maxhealth * 0.4;
              ai_zombie dodamage(var_34e3b3f7, v_vortex_origin, eattacker, svortex, undefined, "MOD_DOT", 0, weapon);
              ai_zombie.var_56912e22 = gettime() + 1000;
            }

            break;
          }

          ai_zombie.var_db490292 = "blackholebomb_pull_fast";
          ai_zombie.var_92b78660 = 1024;

          if(is_true(ai_zombie._black_hole_bomb_collapse_death) && !zm_utility::is_magic_bullet_shield_enabled(ai_zombie)) {
            ai_zombie.skipautoragdoll = 1;
            ai_zombie kill(ai_zombie.origin + (0, 0, 50), ai_zombie.interdimensional_gun_attacker, undefined, weapon, 0, 1);
            level thread hud::function_c9800094(eattacker, ai_zombie.origin + (0, 0, 50), ai_zombie.maxhealth, 1);

            if(is_true(ai_zombie.allowdeath)) {
              gibserverutils::annihilate(ai_zombie);
            }
          }

          if(!is_true(ai_zombie.interdimensional_gun_kill) && !ai_zombie.ignorevortices) {
            ai_zombie.var_ecd5b1b9 = svortex;
            ai_zombie.damageorigin = v_vortex_origin;
            ai_zombie.interdimensional_gun_kill = 1;
            ai_zombie.interdimensional_gun_attacker = eattacker;
            ai_zombie.interdimensional_gun_inflictor = eattacker;
            ai_zombie.interdimensional_gun_weapon = weapon;
          }

          break;
        case # "special":
          ai_zombie thread namespace_9ff9f642::slowdown(#"hash_2c88ef7895dccf65");

          if(!isDefined(ai_zombie.var_56912e22) || time >= ai_zombie.var_56912e22) {
            var_34e3b3f7 = ai_zombie.maxhealth * 0.05;
            ai_zombie dodamage(var_34e3b3f7, v_vortex_origin, eattacker, svortex, undefined, "MOD_DOT", 0, weapon);
            ai_zombie.var_56912e22 = gettime() + 1000;
          }

          if(!is_true(ai_zombie.interdimensional_gun_kill) && !ai_zombie.ignorevortices) {
            ai_zombie.var_ecd5b1b9 = svortex;
            ai_zombie.damageorigin = v_vortex_origin;
            ai_zombie.interdimensional_gun_kill = 1;
            ai_zombie.interdimensional_gun_attacker = eattacker;
            ai_zombie.interdimensional_gun_inflictor = eattacker;
            ai_zombie.interdimensional_gun_weapon = weapon;
          }

          break;
        case # "elite":
          if(is_true(ai_zombie.var_8576e0be)) {
            ai_zombie namespace_9ff9f642::function_520f4da5(#"hash_2c88ef7895dccf65");
          } else {
            ai_zombie thread namespace_9ff9f642::slowdown(#"hash_2c88ef7895dccf65");
          }

          if(!isDefined(ai_zombie.var_56912e22) || time >= ai_zombie.var_56912e22) {
            var_34e3b3f7 = ai_zombie.maxhealth * 0.02;
            ai_zombie dodamage(var_34e3b3f7, v_vortex_origin, eattacker, svortex, undefined, "MOD_DOT", 0, weapon);
            ai_zombie.var_56912e22 = gettime() + 1000;
          }

          if(!is_true(ai_zombie.interdimensional_gun_kill) && !ai_zombie.ignorevortices) {
            ai_zombie.var_ecd5b1b9 = svortex;
            ai_zombie.damageorigin = v_vortex_origin;
            ai_zombie.interdimensional_gun_kill = 1;
            ai_zombie.interdimensional_gun_attacker = eattacker;
            ai_zombie.interdimensional_gun_inflictor = eattacker;
            ai_zombie.interdimensional_gun_weapon = weapon;
          }

          break;
        default:
          break;
      }
    }

    waitframe(1);
  }
}

function private function_fb7c4f41() {
  self notify(#"affected_fx");
  self endon(#"death", #"affected_fx");
  wait 0.25;
  self clientfield::set("" + # "hash_399ab6541d717dc7", 0);
  self.blockingpain = 0;
}

function private vortex_explosion(v_vortex_explosion_origin, eattacker, n_vortex_radius) {
  self.origin += (0, 0, 50);
  self detonate(n_vortex_radius);

  recordstar(self.origin, (1, 0, 1), "<dev string:x38>");
}

function function_1a6605b0(string) {
  if(!getdvarint(#"hash_4fd011a8151f574c", 0)) {
    return;
  }

  println(string);
}