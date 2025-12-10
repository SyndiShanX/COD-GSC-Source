/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_zurich_newworld_accolades.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_accolades;
#using scripts\cp\_util;
#using scripts\cp\gametypes\_save;
#using scripts\shared\callbacks_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\util_shared;
#namespace namespace_37a1dc33;

function function_4d39a2af() {
  accolades::register("MISSION_NEWWORLD_UNTOUCHED");
  accolades::register("MISSION_NEWWORLD_SCORE");
  accolades::register("MISSION_NEWWORLD_COLLECTIBLE");
  accolades::register("MISSION_NEWWORLD_CHALLENGE3", "ch03_light_enemies_on_fire");
  accolades::register("MISSION_NEWWORLD_CHALLENGE4", "ch04_wall_run_kills");
  accolades::register("MISSION_NEWWORLD_CHALLENGE5", "ch05_penetrate_bullet_kills");
  accolades::register("MISSION_NEWWORLD_CHALLENGE6", "ch06_cybercom_robot_kills");
  accolades::register("MISSION_NEWWORLD_CHALLENGE7", "ch07_explosion_triple_kill");
  accolades::register("MISSION_NEWWORLD_CHALLENGE8", "ch08_grenade_throwback_kill");
  accolades::register("MISSION_NEWWORLD_CHALLENGE9", "ch09_icicle_kill");
  accolades::register("MISSION_NEWWORLD_CHALLENGE10", "ch10_disabled_robot_kill");
  accolades::register("MISSION_NEWWORLD_CHALLENGE11", "ch11_chase_no_reload");
  accolades::register("MISSION_NEWWORLD_CHALLENGE12", "ch12_chase_no_civilians");
  accolades::register("MISSION_NEWWORLD_CHALLENGE13", "ch13_turret_kill");
  accolades::register("MISSION_NEWWORLD_CHALLENGE14", "ch14_shotgun_kills");
  accolades::register("MISSION_NEWWORLD_CHALLENGE15", "ch15_wall_run_train");
  callback::on_spawned(&function_3a6b5b3e);
  function_89a4c66f();
  function_314eff4a();
  function_2b972244();
  function_e346bcd4();
  function_5a3da660();
  function_a87e96e();
  function_353e449e();
  function_6972c343();
  function_80820e19();
}

function function_3a6b5b3e() {
  self function_9f8d841b();
  self function_b4b1da62();
  self function_9c7144b6();
  self thread function_7e35ccbc();
}

function function_c27610f9(var_8e087689, var_70b01bd3) {
  if(self == level) {
    foreach(player in level.activeplayers) {
      player notify(var_8e087689);
    }
  } else if(isplayer(self)) {
    self notify(var_8e087689);
  }
  if(isDefined(var_70b01bd3)) {
    [[var_70b01bd3]]();
  }
}

function function_9f8d841b() {
  self.var_57582aca = 0;
  self.var_6659e536 = undefined;
}

function function_89a4c66f() {
  callback::on_actor_killed(&function_595dc718);
}

function function_595dc718(params) {
  if(isplayer(params.eattacker) && params.smeansofdeath == "MOD_BURNED") {
    if(!isDefined(params.eattacker.var_6659e536) || params.eattacker.var_6659e536 != params.einflictor) {
      params.eattacker.var_6659e536 = params.einflictor;
      params.eattacker.var_57582aca = 1;
      params.eattacker notify("hash_6daef24a");
      wait(0.05);
      if(params.eattacker.var_6659e536 == params.eattacker) {
        params.eattacker thread function_840d3bcc();
      }
    } else {
      if(params.eattacker.var_6659e536 === params.einflictor && !isDefined(self.var_93eeceb)) {
        params.eattacker.var_57582aca++;
        self.var_93eeceb = 1;
        if(params.eattacker.var_57582aca == 3) {
          params.eattacker notify("hash_38998bd8");
        }
      } else {
        params.eattacker.var_6659e536 = params.einflictor;
        params.eattacker.var_57582aca = 1;
      }
    }
  }
}

function function_840d3bcc() {
  self endon("death");
  self endon("hash_6daef24a");
  self endon("hash_38998bd8");
  wait(0.5);
  self.var_6659e536 = undefined;
  self.var_57582aca = 0;
}

function function_314eff4a() {
  callback::on_ai_killed(&function_9257e223);
}

function function_9257e223(params) {
  if(isplayer(params.eattacker)) {
    player = params.eattacker;
    if(player iswallrunning()) {
      player function_c27610f9("ch04_wall_run_kills");
    }
  }
}

function function_2b972244() {
  callback::on_ai_killed(&function_9d5a87b1);
}

function function_9d5a87b1(params) {
  if(self.team !== "axis") {
    return;
  }
  if(isplayer(params.eattacker)) {
    player = params.eattacker;
    var_3d9e461f = !bullettracepassed(player getEye(), self getEye(), 0, self);
    if(util::isbulletimpactmod(params.smeansofdeath) && var_3d9e461f) {
      player function_c27610f9("ch05_penetrate_bullet_kills");
    }
  }
}

function function_b4b1da62() {
  self.var_c81126e8 = 0;
  self.s_timer = util::new_timer(2);
}

function function_5a3da660() {
  spawner::add_archetype_spawn_function("robot", &function_f9a5c6a1);
}

function function_f9a5c6a1() {
  self waittill("hash_f8c5dd60", weapon, eattacker);
  if(isplayer(eattacker)) {
    if(eattacker.var_c81126e8 == 0) {
      eattacker.s_timer = util::new_timer(2);
      eattacker.var_c81126e8++;
    } else {
      eattacker.var_c81126e8++;
      if(eattacker.var_c81126e8 >= 5 && eattacker.s_timer util::get_time_left() > 0) {
        eattacker notify("hash_d28bfcb4");
      } else if(eattacker.s_timer util::get_time_left() <= 0) {
        eattacker.s_timer = util::new_timer(2);
        eattacker.var_c81126e8 = 1;
      }
    }
  }
}

function function_9c7144b6() {
  self.var_b2c73b97 = 0;
  self.var_b5385d9d = undefined;
}

function function_e346bcd4() {
  callback::on_ai_killed(&function_1b6f43c5);
}

function function_1b6f43c5(params) {
  if(self.team !== "axis") {
    return;
  }
  if(isplayer(params.eattacker) && (params.smeansofdeath == "MOD_GRENADE" || params.smeansofdeath == "MOD_GRENADE_SPLASH" || params.smeansofdeath == "MOD_EXPLOSIVE" || params.smeansofdeath == "MOD_EXPLOSIVE_SPLASH" || params.smeansofdeath == "MOD_PROJECTILE" || params.smeansofdeath == "MOD_PROJECTILE_SPLASH")) {
    if(!isDefined(params.eattacker.var_b5385d9d)) {
      params.eattacker.var_b5385d9d = params.einflictor;
      params.eattacker.var_b2c73b97 = 1;
    } else {
      if(params.eattacker.var_b5385d9d === params.einflictor) {
        params.eattacker.var_b2c73b97++;
        if(params.eattacker.var_b2c73b97 >= 3) {
          params.eattacker notify("hash_f60a0b85");
        }
      } else {
        params.eattacker.var_b5385d9d = params.einflictor;
        params.eattacker.var_b2c73b97 = 1;
      }
    }
  }
}

function function_7e35ccbc() {
  self endon("death");
  self.var_c6c262e8 = 0;
  while(true) {
    self waittill("grenade_throwback", tosser, grenade);
    if(tosser.team == "axis") {
      self.var_fc30fc22 = grenade;
      self thread function_23ad043b();
    }
  }
}

function function_23ad043b() {
  self endon("death");
  self.var_fc30fc22 waittill("explode");
  self.var_fc30fc22 = undefined;
  wait(0.5);
  self.var_c6c262e8 = 0;
}

function function_a87e96e() {
  callback::on_ai_killed(&function_ee3272c2);
}

function function_ee3272c2(params) {
  if(isplayer(params.eattacker)) {
    if(isDefined(params.eattacker.var_fc30fc22)) {
      if(params.einflictor == params.eattacker.var_fc30fc22) {
        params.eattacker.var_c6c262e8++;
        if(params.eattacker.var_c6c262e8 == 3) {
          params.eattacker notify("hash_8fa9da82");
        }
      }
    }
  }
}

function function_353e449e() {
  callback::on_ai_killed(&function_3867e45c);
}

function function_3867e45c(params) {
  if(isplayer(params.eattacker) && params.eattacker.weap === "icicle") {
    params.eattacker notify("hash_c347271c");
  }
}

function function_6972c343() {
  spawner::add_archetype_spawn_function("robot", &function_deb99e6);
  callback::on_ai_killed(&function_c008ffe2);
}

function function_deb99e6() {
  self endon("death");
  while(true) {
    self.b_disabled = 0;
    self waittill("emp_fx_start");
    self.b_disabled = 1;
    self waittill("emp_shutdown_end");
    self.b_disabled = 0;
  }
}

function function_c008ffe2(params) {
  if(isplayer(params.eattacker) && self.archetype == "robot") {
    if(self.b_disabled) {
      params.eattacker notify("hash_4c313fa2");
    }
  }
}

function function_cd261d0b() {
  level flag::wait_till("all_players_spawned");
  foreach(player in level.players) {
    player thread function_af529683();
  }
  level flag::wait_till("chase_done");
  foreach(player in level.players) {
    player thread function_2d344335();
  }
}

function function_af529683() {
  self endon("death");
  level endon("hash_3d00ae0c");
  self waittill("reload");
  self savegame::set_player_data("b_nw_accolade_11_failed", 1);
}

function function_2d344335() {
  if(self savegame::get_player_data("b_nw_accolade_11_failed") !== 1 && self savegame::get_player_data("b_has_done_chase") !== 0 && self savegame::get_player_data("b_nw_accolade_11_completed") !== 1) {
    self notify("hash_b83db00b");
    self savegame::set_player_data("b_nw_accolade_11_completed", 1);
  }
}

function function_323baa37() {
  level flag::wait_till("all_players_spawned");
  callback::on_actor_killed(&function_bc7f04af);
  callback::on_ai_spawned(&function_829b12c4);
  level flag::wait_till("chase_done");
  foreach(player in level.players) {
    player thread function_8af9d448();
  }
  callback::remove_on_actor_killed(&function_bc7f04af);
  callback::remove_on_ai_spawned(&function_829b12c4);
}

function function_bc7f04af(params) {
  if(self.archetype == "civilian" || self.archetype == "allies" && isplayer(params.eattacker)) {
    params.eattacker savegame::set_player_data("b_nw_accolade_12_failed", 1);
  }
}

function function_829b12c4(params) {
  self endon("death");
  if(isDefined(self.archetype) && (self.archetype == "civilian" || self.archetype == "allies")) {
    self waittill("touch", e_toucher);
    if(isplayer(e_toucher)) {
      e_toucher savegame::set_player_data("b_nw_accolade_12_failed", 1);
    }
  }
}

function function_8af9d448() {
  if(self savegame::get_player_data("b_nw_accolade_12_failed") !== 1 && self savegame::get_player_data("b_has_done_chase") !== 0 && self savegame::get_player_data("b_nw_accolade_12_completed") !== 1) {
    self notify("hash_690d946b");
    self savegame::set_player_data("b_nw_accolade_12_completed", 1);
  }
}

function function_f7dd9b2c() {
  callback::on_ai_killed(&function_e50c8d4a);
  level waittill("hash_c37d20e3");
  callback::remove_on_ai_killed(&function_e50c8d4a);
}

function function_e50c8d4a(params) {
  if(isDefined(params.eattacker) && isplayer(params.eattacker) && isDefined(params.eattacker.hijacked_vehicle_entity) && params.eattacker.hijacked_vehicle_entity.archetype === "turret") {
    if(params.eattacker.hijacked_vehicle_entity !== self) {
      params.eattacker notify("hash_802ebfac");
    }
  }
}

function function_8bb97e0() {
  foreach(player in level.players) {
    player thread function_ee166ee8();
  }
  callback::on_spawned(&function_ee166ee8);
  callback::on_ai_killed(&function_85ed003e);
}

function function_85ed003e(params) {
  var_8c90e32b = util::getweaponclass(params.weapon);
  if(self.archetype === "robot" && var_8c90e32b === "weapon_cqb") {
    player = params.eattacker;
    player.var_89be6da0++;
    if(player.var_89be6da0 >= 8) {
      player notify("hash_c113aa12");
    }
  }
}

function function_ee166ee8() {
  self endon("death");
  self.var_89be6da0 = 0;
  self waittill("reload");
  wait(0.05);
  self thread function_ee166ee8();
}

function function_80820e19() {
  var_4fa896d4 = getent("newworld_accolade_15", "targetname");
  var_4fa896d4 thread function_14316bd1();
}

function function_14316bd1() {
  level endon("hash_f7bb45b");
  while(true) {
    self waittill("trigger", ent);
    if(isplayer(ent) && ent iswallrunning()) {
      a_trace = bulletTrace(ent.origin, ent.origin - vectorscale((0, 0, 1), 1000), 0, ent);
      if(isDefined(a_trace["entity"]) && a_trace["entity"].script_noteworthy === "chase_train") {
        ent notify("hash_fda475d4");
      }
    }
  }
}