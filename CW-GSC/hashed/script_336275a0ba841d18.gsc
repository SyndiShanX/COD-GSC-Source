/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_336275a0ba841d18.gsc
***********************************************/

#using script_335d0650ed05d36d;
#using script_34e9dd62fc371077;
#using script_3a88f428c6d8ef90;
#using script_3e196d275a6fb180;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_eye_glow;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\death_circle;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\zm\powerup\zm_powerup_nuke;
#using scripts\zm_common\gametypes\display_transition;
#using scripts\zm_common\gametypes\globallogic_score;
#using scripts\zm_common\gametypes\zonslaught;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_behavior;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_sq;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_weapons;
#namespace namespace_51f64aa9;

function function_2ce126c4() {
  death_circle::function_c156630d();
  level.wave_number = 0;
  level.var_bc2071f = 0;
  level.var_8f8a58c2 = 0;

  level.var_e63636af = &function_b293ea58;

  level.var_3e67b08d = 0.6;
  level.var_dff684cf = getgametypesetting(#"hash_cd096e90260a26b");
  level.var_2386648b = 1;

  if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") {
    level.var_d2a573c6 = 2;
    level.var_b4b52d95 = 1.5;
    level.var_f4dc118e = 2;
    level.var_fcdb4d36 = 5;
    level.var_6bb0102e = 8.5;
  } else if(is_true(level.var_dff684cf)) {
    level.var_d2a573c6 = 1;
    level.var_b4b52d95 = 0.5;
    level.var_f4dc118e = 1;
    level.var_fcdb4d36 = 2;
    level.var_6bb0102e = 4;
  } else {
    level.var_d2a573c6 = 4;
    level.var_b4b52d95 = 3;
    level.var_f4dc118e = 4;
    level.var_fcdb4d36 = 5;
    level.var_6bb0102e = 17;
  }

  level flag::init("rounds_started");
  level flag::init("onslaught_round_logic_inprogress");
  level flag::init("onslaught_round_logic_complete");
  callback::on_spawned(&function_e8535657);
  callback::on_connect(&function_8b930ad1);
  callback::on_start_gametype(&function_6071bedf);
  callback::on_game_playing(&function_bfd2a58b);
  callback::on_ai_killed(&on_ai_killed);
  callback::add_callback(#"hash_5118a91e667446ee", &function_13f485ad);
  callback::add_callback(#"on_host_migration_begin", &on_host_migration_begin);
  callback::add_callback(#"on_host_migration_end", &on_host_migration_end);
  level.var_4ea2c79a = 1;
  level.graceperiod = 0;
  level.var_b82a5c35 = 1;
  level.var_3d1e480e = 1;
  level.var_3a701785 = 1;
  level.var_d25999d7 = getdvarint(#"hash_5bc5d75f3e9a5aae", 0);
  level.var_4614c421 = &function_a3e209ba;
  level.var_2b37d0dd = 0;
  level.var_e5a890d7 = 0;
  level.var_bc79322a = 0;
  level.var_58c95941 = 0;
  level.var_9dfa1a1e = 1;
  level.var_6d24574d = 0;
  level.var_4d30a9f0 = 1;

  if(getdvarint(#"hash_4683cbe4c9d162eb", 1)) {
    if(is_true(level.var_e35c191f) || util::get_game_type() === # "hash_125fc0c0065c7dea") {
      level.var_7e2af8d5 = [# "hash_3ff43755c44e6d3d", #"hash_4a900af3fc47cdd5", #"spawner_bo5_abom", #"hash_acac3fe7a341329", #"hash_60d7855358ceb53d"];
    } else {
      level.var_7e2af8d5 = [# "spawner_zm_steiner", #"hash_3ff43755c44e6d3d", #"hash_4a900af3fc47cdd5"];
    }
  } else {
    level.var_7e2af8d5 = [# "spawner_zm_steiner", #"hash_4f87aa2a203d37d0", #"spawner_bo5_mimic"];
  }

  level.var_77805e8 = &function_77805e8;
  spawner::add_archetype_spawn_function(#"zombie", &zombiespawnsetup);
  spawner::function_89a2cd87(#"zombie", &function_a9b7dc57);
  spawner::add_archetype_spawn_function(#"zombie_dog", &function_6a89f900);
  level callback::add_callback(#"hash_4ad847c8f6c6405f", &spawn_dog);
  level.onslaught_hud = onslaught_hud::register();
  level.var_e2f95698 = # "zm_commander_onslaught";

  if(is_true(getgametypesetting(#"hash_cd096e90260a26b"))) {
    level.var_d4c0ef1a = getEntArray("gunfight_zone_center", "targetname");

    foreach(zone in level.var_d4c0ef1a) {
      zone.usecount = 0;
      othervisuals = getEntArray(zone.target, "targetname");

      for(j = 0; j < othervisuals.size; j++) {
        if(othervisuals[j].classname == "script_brushmodel") {
          othervisuals[j] notsolid();
          othervisuals[j] hide();
        }
      }
    }
  } else {
    level.var_d4c0ef1a = getEntArray("koth_zone_center", "targetname");

    foreach(zone in level.var_d4c0ef1a) {
      zone.usecount = 0;
      othervisuals = getEntArray(zone.target, "targetname");

      for(j = 0; j < othervisuals.size; j++) {
        if(othervisuals[j].classname == "script_brushmodel") {
          othervisuals[j] notsolid();
          othervisuals[j] hide();
        }
      }

      if(level.var_8de4d059 === # "mp_raid_rm" && zone.script_index === 1) {
        arrayremovevalue(level.var_d4c0ef1a, zone);
      }

      if(level.var_8de4d059 === # "mp_village_rm" && zone.script_index === 2) {
        arrayremovevalue(level.var_d4c0ef1a, zone);
      }
    }

    if(level.var_8de4d059 === # "mp_drivein_rm") {
      var_2a924a32 = [(335, -2212, 150), (-623, -2237, 152), (741, -1534, 139), (190, 1602, 138)];

      foreach(v_loc in var_2a924a32) {
        var_478072ca = util::spawn_model("tag_origin", v_loc, (0, 0, 0));
        var_478072ca.usecount = 0;

        if(!isDefined(level.var_d4c0ef1a)) {
          level.var_d4c0ef1a = [];
        } else if(!isarray(level.var_d4c0ef1a)) {
          level.var_d4c0ef1a = array(level.var_d4c0ef1a);
        }

        if(!isinarray(level.var_d4c0ef1a, var_478072ca)) {
          level.var_d4c0ef1a[level.var_d4c0ef1a.size] = var_478072ca;
        }
      }
    }

    if(level.var_8de4d059 === # "mp_paintball_rm") {
      var_111049c7 = getEntArray("flag_primary", "targetname");

      foreach(zone in var_111049c7) {
        if(zone.target === "flag_trigger_a" || zone.target === "flag_trigger_c") {
          zone.usecount = 0;

          if(!isDefined(level.var_d4c0ef1a)) {
            level.var_d4c0ef1a = [];
          } else if(!isarray(level.var_d4c0ef1a)) {
            level.var_d4c0ef1a = array(level.var_d4c0ef1a);
          }

          level.var_d4c0ef1a[level.var_d4c0ef1a.size] = zone;
        }

        zone notsolid();
        zone hide();
        othervisuals = getEntArray(zone.target, "targetname");

        foreach(visual in othervisuals) {
          if(othervisuals[j].classname == "script_brushmodel") {
            othervisuals[j] notsolid();
            othervisuals[j] hide();
          }
        }
      }

      spawncollision("collision_clip_wall_128x128x10", "collider", (7.25, -1219, 54.25), (0, 53, 0));
      spawncollision("collision_clip_wall_128x128x10", "collider", (-164.75, -1090, 54.25), (0, 53, 0));
    }
  }

  if(level.var_8de4d059 === # "mp_raid_rm") {
    glassradiusdamage((4095, 4069, 94), 64, 25, 25, "MOD_UNKNOWN");
    glassradiusdamage((4501, 3625, 99), 64, 25, 25, "MOD_UNKNOWN");
    glassradiusdamage((1000, 1416, 226), 64, 25, 25, "MOD_UNKNOWN");
    glassradiusdamage((3338, 4143, 94), 64, 25, 25, "MOD_UNKNOWN");
  }

  level._effect[# "zombie_flash"] = "zombie/fx9_onslaught_spawn_sm";
  level._effect[# "boss_flash"] = "zm_ai/fx8_dog_lightning_spawn";
  level._effect[# "boss_appear"] = "zm_ai/fx8_avo_elec_teleport_appear";
  level._effect[# "orb_nuke"] = "zombie/fx9_onslaught_orb_nuke";

  if(getdvarint(#"hash_61dfb5be7263ab36", 0) == 1) {
    level.var_2b37d0dd = 1;
    level.var_e5a890d7 = 0;
    level.var_bc79322a = 0;
    level.var_bc0b4b46 = 1;
  }

  if(getdvarint(#"hash_61dfb5be7263ab36", 0) == 2) {
    level.var_e5a890d7 = 1;
    level.var_9725eb4a = 1;
  }

  if(getdvarint(#"hash_61dfb5be7263ab36", 0) == 3) {
    level.var_e5a890d7 = 1;
    level.var_58c95941 = 1;
  }

  if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") {
    level thread function_194f33cb();
  }
}

function function_194f33cb() {
  level endon(#"end_game");

  while(true) {
    if(isDefined(level.var_51514f45) && isDefined(level.var_df7b46d1) && is_true(level.var_2b37d0dd)) {
      print3d(level.var_df7b46d1.origin + (0, 0, 40), "<dev string:x38>" + level.var_51514f45, (0, 1, 0), undefined, 0.25);
    }

    waitframe(1);
  }
}

function function_c1d511f6() {
  level endon(#"end_game");
  level flag::wait_till("rounds_started");
  wait 2;

  while(true) {
    waitresult = level waittill(#"hash_5731a6df491c37c7");
    var_c2f7b1a3 = waitresult.location;
    zm_sq::objective_set(#"hash_641e9c4d20df5950", var_c2f7b1a3);
    level waittill(#"boss_killed");
  }
}

function function_d6923f19() {
  level endon(#"end_game");
  array::thread_all(getplayers(), &function_d3379a31);
  level zm_vo::function_7622cb70(#"matchstart", 3.5);
  level waittill(#"hash_221bff60f501cbaf");
  level thread zm_vo::function_7622cb70(#"hash_7ca80ff4ecb29f8e", 1);
  level waittill(#"hash_7cd8474c6919310b");

  if(!is_true(level.var_dff684cf)) {
    level thread zm_vo::function_7622cb70(#"hash_37fac4fc5c027a69", 3);
  }
}

function private function_d3379a31() {
  self endon(#"disconnect");
  var_e418724e = 0;

  while(true) {
    if(is_true(self.outsidedeathcircle)) {
      self zm_vo::function_7622cb70(#"hash_55bd8afbd48fb16e");
      var_e418724e++;

      if(var_e418724e == 3) {
        return;
      }

      wait randomintrange(10, 20);
    }

    wait 1;
  }
}

function debug_spawns() {
  var_da0b6672 = 50;
  checkdist = 1000;

  while(true) {
    player1 = getplayers()[0];
    var_273a84a9 = [];

    if(!isDefined(var_273a84a9)) {
      var_273a84a9 = [];
    } else if(!isarray(var_273a84a9)) {
      var_273a84a9 = array(var_273a84a9);
    }

    var_273a84a9[var_273a84a9.size] = "<dev string:x4f>";

    if(!isDefined(var_273a84a9)) {
      var_273a84a9 = [];
    } else if(!isarray(var_273a84a9)) {
      var_273a84a9 = array(var_273a84a9);
    }

    var_273a84a9[var_273a84a9.size] = "<dev string:x56>";
    var_8fb1964e = spawning::function_d400d613(#"mp_spawn_point", var_273a84a9);
    spawns = var_8fb1964e[# "tdm"];

    if(!isDefined(spawns)) {
      spawns = var_8fb1964e[# "ctf"];
    }

    foreach(spawnpt in spawns) {
      var_b3dbfd56 = spawnpt.origin;
      circle(var_b3dbfd56, var_da0b6672, (1, 0, 0), 1, 1, 1);

      if(is_true(spawnpt.used)) {
        drawcross(var_b3dbfd56 + (0, 0, 10), (1, 0, 0), 1);
        drawcross(var_b3dbfd56 + (0, 0, 40), (1, 0, 0), 1);
        drawcross(var_b3dbfd56 + (0, 0, 80), (1, 0, 0), 1);
      }
    }

    waitframe(1);
  }
}

function function_ec2b3302() {
  var_8314a02e = 0;

  if(level.var_9b7bd0e8 >= 3 || level.wave_number > 9) {
    var_8314a02e = 5;
  } else {
    if(isDefined(level.var_70b6f044) && isDefined(level.var_70b6f044[# "hash_5f22ecce894282fa"])) {
      return level.var_70b6f044[# "hash_5f22ecce894282fa"];
    }

    return # "hash_5f22ecce894282fa";
  }

  rand = randomint(100);

  if(rand <= var_8314a02e && level.var_8f8a58c2 <= 15) {
    if(isDefined(level.var_70b6f044) && isDefined(level.var_70b6f044[# "hash_12a17ab3df5889eb"])) {
      return level.var_70b6f044[# "hash_12a17ab3df5889eb"];
    }

    level.var_8f8a58c2++;
    return # "hash_12a17ab3df5889eb";
  }

  if(isDefined(level.var_70b6f044) && isDefined(level.var_70b6f044[# "hash_5f22ecce894282fa"])) {
    return level.var_70b6f044[# "hash_5f22ecce894282fa"];
  }

  return # "hash_5f22ecce894282fa";
}

function function_2f6706d2() {
  if(!isDefined(level.var_6edb1cbd)) {
    level.var_6edb1cbd = [];
  }

  var_b1f8f8fc = arraycopy(level.var_7e2af8d5);
  var_b1f8f8fc = array::exclude(var_b1f8f8fc, level.var_6edb1cbd);
  spawner = array::random(var_b1f8f8fc);

  if(!isDefined(level.var_6edb1cbd)) {
    level.var_6edb1cbd = [];
  } else if(!isarray(level.var_6edb1cbd)) {
    level.var_6edb1cbd = array(level.var_6edb1cbd);
  }

  if(!isinarray(level.var_6edb1cbd, spawner)) {
    level.var_6edb1cbd[level.var_6edb1cbd.size] = spawner;
  }

  if(level.var_6edb1cbd.size >= level.var_7e2af8d5.size - 1) {
    level.var_6edb1cbd = [];

    if(!isDefined(level.var_6edb1cbd)) {
      level.var_6edb1cbd = [];
    } else if(!isarray(level.var_6edb1cbd)) {
      level.var_6edb1cbd = array(level.var_6edb1cbd);
    }

    if(!isinarray(level.var_6edb1cbd, spawner)) {
      level.var_6edb1cbd[level.var_6edb1cbd.size] = spawner;
    }
  }

  if(isDefined(level.var_70b6f044) && isDefined(level.var_70b6f044[spawner])) {
    return level.var_70b6f044[spawner];
  }

  return spawner;
}

function function_d09d6958(value) {
  level.onslaught_hud onslaught_hud::set_objectivetext(self, value);
}

function function_61c3d59c(str_text, var_a920f1d6) {
  self notify("2c24b5d157787e9d");
  self endon("2c24b5d157787e9d");
  self endon(#"disconnect", #"death");
  level.onslaught_hud onslaught_hud::function_d0a02472(self, 1);
  self function_d09d6958(str_text);
  wait var_a920f1d6;
  level.onslaught_hud onslaught_hud::function_d0a02472(self, 0);
}

function function_22d0bd07(value) {
  level.onslaught_hud onslaught_hud::function_b73d2d7c(self, value);
}

function function_f9b8bf44(str_text, var_a920f1d6) {
  self notify("70f6e4f48ac8078f");
  self endon("70f6e4f48ac8078f");
  self endon(#"disconnect", #"death");
  level.onslaught_hud onslaught_hud::function_1c28d7c2(self, 1);
  self function_22d0bd07(str_text);
  wait var_a920f1d6;
  level.onslaught_hud onslaught_hud::function_1c28d7c2(self, 0);
}

function function_f0e74135(value) {
  level.onslaught_hud onslaught_hud::function_9c1c0811(self, value);
}

function function_4b12e9e4(str_text, var_a920f1d6) {
  self notify("25b24bcbd0b50f4d");
  self endon("25b24bcbd0b50f4d");
  self endon(#"disconnect", #"death");
  level.onslaught_hud onslaught_hud::function_d6b5fdc4(self, 1);
  self function_f0e74135(str_text);
  wait var_a920f1d6;
  level.onslaught_hud onslaught_hud::function_d6b5fdc4(self, 0);
}

function function_2617d862() {
  level.onslaught_hud onslaught_hud::function_da96c24e(self, 0);
}

function function_813aaa72(value) {
  level.onslaught_hud onslaught_hud::function_2a0b1f84(self, value);
}

function function_da556d60() {
  level.onslaught_hud onslaught_hud::function_da96c24e(self, 1);
}

function function_251073e9() {
  level.onslaught_hud onslaught_hud::function_9b5f8a75(self, 0);
}

function function_cf4e42ea() {
  level.onslaught_hud onslaught_hud::function_9b5f8a75(self, 1);
}

function private function_a3e209ba() {
  if(level flag::get("rounds_started")) {
    return true;
  }

  return false;
}

function function_6071bedf() {
  level thread function_69e5b9b();
}

function function_bfd2a58b() {
  level waittill(#"initial_fade_in_complete");

  while(getplayers().size < 0) {
    wait 1;
  }

  wait 1;

  if(is_true(level.var_bc0b4b46)) {
    level thread debug_spawns();
  }

  level thread function_81c192d();
  wait 2;
  level flag::set("rounds_started");
}

function function_8b930ad1() {
  self globallogic_score::initpersstat(#"agrkills", 0);
  self.var_9a2f93bd = max(level.wave_number, 1);
}

function function_e8535657() {
  self endon(#"disconnect");

  if(!level.onslaught_hud onslaught_hud::is_open(self)) {
    level.onslaught_hud onslaught_hud::open(self);
  }
}

function function_b0eba88e(player) {
  self endon(#"death");
  player waittill(#"disconnect");
  self delete();
}

function drawcross(origin, color, duration) {
  r = 6;
  forward = (r, 0, 0);
  left = (0, r, 0);
  up = (0, 0, r);
  line(origin - forward, origin + forward, color, 1, 0, duration);
  line(origin - left, origin + left, color, 1, 0, duration);
  line(origin - up, origin + up, color, 1, 0, duration);
}

function function_b5c27e32(var_3b720eb2) {
  if(isDefined(self)) {
    self notify(#"risen");
  }
}

function function_a9b7dc57() {
  self pathmode("move allowed");
}

function setmovespeed() {
  rand = randomint(100);

  if(level.wave_number < 9) {
    rand += level.wave_number * 2;

    if(rand < 70) {
      zombie_utility::set_zombie_run_cycle("walk");
    } else {
      zombie_utility::set_zombie_run_cycle("run");
    }

    return;
  }

  if(level.wave_number < 15) {
    rand += (level.wave_number - 9) * 2;

    if(rand < 70) {
      zombie_utility::set_zombie_run_cycle("sprint");
    } else {
      zombie_utility::set_zombie_run_cycle("run");
    }

    return;
  }

  rand += (level.wave_number - 15) * 2;

  if(rand < 30) {
    zombie_utility::set_zombie_run_cycle("run");
    return;
  }

  zombie_utility::set_zombie_run_cycle("sprint");
}

function zombiespawnsetup() {
  self.overrideactordamage = &aidamage;
  self.custom_location = &function_b5c27e32;
  self zm_behavior::function_d63f6426();
  self.script_string = "find_flesh";
  self notify(#"risen", "find_flesh");
  self zm_spawner::zombie_complete_emerging_into_playable_area();
  self.zombie_think_done = 1;
  self.b_ignore_cleanup = 0;
  self.var_8d1d18aa = 0;
  self.var_2e948547 = 0;
  self enableaimassist();
}

function function_6c40ff50() {
  aiutility::addaioverridedamagecallback(self, &aidamage);
  self.zombie_think_done = 1;
  self.completed_emerging_into_playable_area = 1;
  self.var_173b6f35 = 1;
  self.b_ignore_cleanup = 1;
  self pathmode("move allowed");
  self.var_2e948547 = 1;

  if(!isDefined(level.var_2812b9f5)) {
    level.var_2812b9f5 = "";
  }

  switch (level.var_2812b9f5) {
    case # "hash_43b8d4f24851653e":
    case # "spawner_zm_steiner":
      self.var_8d1d18aa = 1;
      break;
    case # "hash_acac3fe7a341329":
    case # "hash_156c697af81feaf9":
      self.var_8d1d18aa = 1;

      if(is_true(level.var_e35c191f) || util::get_game_type() === # "hash_125fc0c0065c7dea") {
        var_e63bba0e = 0.8;
      } else {
        var_e63bba0e = 0.4;
      }

      break;
    case # "hash_60d7855358ceb53d":
      if(is_true(level.var_e35c191f) || util::get_game_type() === # "hash_125fc0c0065c7dea") {
        var_e63bba0e = 0.8;
      } else {
        var_e63bba0e = 0.4;
      }

      break;
    case # "hash_3ff43755c44e6d3d":
      if(is_true(level.var_e35c191f) || util::get_game_type() === # "hash_125fc0c0065c7dea") {
        var_e63bba0e = 0.8;
      } else {
        var_e63bba0e = 0.4;
      }

      break;
    case # "hash_4a900af3fc47cdd5":
      if(is_true(level.var_e35c191f) || util::get_game_type() === # "hash_125fc0c0065c7dea") {
        var_e63bba0e = 1;
      } else {
        var_e63bba0e = 0.66;
      }

      break;
    case # "spawner_bo5_abom":
      if(is_true(level.var_e35c191f) || util::get_game_type() === # "hash_125fc0c0065c7dea") {
        var_e63bba0e = 1.2;
      }

      break;
  }

  if(isDefined(var_e63bba0e)) {
    self.maxhealth = int(self.maxhealth * var_e63bba0e);
    self.health = self.maxhealth;
  }

  self enableaimassist();
  all_ai = getaiarray();

  foreach(ai in all_ai) {
    foreach(var_e0b78f9f in all_ai) {
      if(var_e0b78f9f != ai) {
        var_e0b78f9f setignoreent(ai, 1);
        ai setignoreent(var_e0b78f9f, 1);
      }
    }
  }
}

function aidamage(inflictor, attacker, damage, dflags, mod, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex) {
  if(isDefined(boneindex) && isactor(boneindex) && boneindex.archetype == # "zombie") {
    return 0;
  }

  if(is_true(self.var_2e948547) && is_true(self.var_8d1d18aa)) {
    if(self.health - modelindex < 1) {
      return 0;
    }
  }

  return modelindex;
}

function hide_pop() {
  self endon(#"death");
  self ghost();
  wait 0.25;

  if(isDefined(self)) {
    self show();
    waitframe(1);

    if(isDefined(self)) {
      self.create_eyes = 1;
    }
  }
}

function function_1495c8c(v_origin, v_angles, anim_name) {
  self endon(#"death");
  origin = self gettagorigin("tag_origin");
  self clientfield::set("zombie_aether_spawn_cf", 1);
  self.in_the_ground = 1;

  if(isDefined(self.anchor)) {
    self.anchor delete();
  }

  self.anchor = spawn("script_origin", self.origin);
  self.anchor.angles = self.angles;
  self linkto(self.anchor);

  if(!isDefined(v_angles)) {
    v_angles = (0, 0, 0);
  }

  anim_org = v_origin;
  anim_ang = v_angles;
  anim_org += (0, 0, 0);
  self ghost();
  self.anchor moveto(anim_org, 0.05);
  self.anchor waittill(#"movedone");
  self unlink();

  if(isDefined(self.anchor)) {
    self.anchor delete();
  }

  self thread hide_pop();
  self orientmode("face default");
  self animscripted("rise_anim", self.origin, v_angles, anim_name, "normal");

  if(self.health > 0) {
    playFX(level._effect[# "boss_appear"], origin);
    playrumbleonposition("zm_nova_phase_exit_rumble", self.origin);
  }

  self notify(#"rise_anim_finished");
  self.completed_emerging_into_playable_area = 1;
  self.var_173b6f35 = 1;
  self.in_the_ground = 0;
}

function function_3fd720cc() {
  self endon(#"death");
  origin = self.origin;
  self val::set(#"boss_spawn", "takedamage", 0);
  self val::set(#"boss_spawn", "ignoreall", 1);
  var_760da554 = 14;

  while(var_760da554 > 0) {
    if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e" || is_true(level.var_e35c191f) || util::get_game_type() === # "hash_125fc0c0065c7dea") {
      level.var_df7b46d1 fx::play(level._effect[# "boss_flash"], level.var_df7b46d1.origin, (0, 0, 0), "delete_boss_spawn_fx", 1);
      level.var_df7b46d1 playrumbleonentity("zm_nova_phase_exit_rumble");
    } else {
      playFX(level._effect[# "boss_flash"], origin);
      playrumbleonposition("zm_nova_phase_exit_rumble", origin);
    }

    wait 0.5;
    var_760da554 -= 1;
  }

  self val::reset(#"boss_spawn", "takedamage");
  self val::reset(#"boss_spawn", "ignoreall");

  if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e" || is_true(level.var_e35c191f) || util::get_game_type() === # "hash_125fc0c0065c7dea") {
    level.var_df7b46d1 notify(#"delete_boss_spawn_fx");
  }
}

function function_b5ba566b(v_origin, v_angles, anim_name) {
  self endon(#"death");

  if(self.health > 0) {
    origin = self gettagorigin("tag_origin");
    playFX(level._effect[# "boss_appear"], origin);
    playrumbleonposition("zm_nova_phase_exit_rumble", self.origin);
    playsoundatposition(#"hash_3f974bee9fb4e319", self.origin);
  }

  self notify(#"rise_anim_finished");
  self.in_the_ground = 0;
}

function function_6fcd98c5() {
  all_ai = getaiarray();

  foreach(ai in all_ai) {
    if(!is_true(ai.is_boss)) {
      ai.zombie_move_speed = "sprint";
    }
  }
}

function function_46ff5efa(var_82ea43f2 = 1, var_f91adf76 = 0) {
  playFX(level._effect[# "orb_nuke"], level.var_df7b46d1.var_48fcd26a.origin);
  playsoundatposition(#"hash_712929054f8c3fda", level.var_df7b46d1.var_48fcd26a.origin);
  wait 1;
  lui::screen_flash(0.2, 0.5, 1, 0.8, "white", undefined, 1);
  level callback::callback(#"hash_c41074e4c29158a");
  playsoundatposition(#"hash_7459371c7e21f143", level.var_df7b46d1.var_48fcd26a.origin);

  if(var_f91adf76) {
    level.var_df7b46d1.var_48fcd26a ghost();

    if(isDefined(level.var_df7b46d1.var_48fcd26a.var_7e2d3fc6)) {
      level.var_df7b46d1.var_48fcd26a.var_7e2d3fc6 ghost();
    }
  }

  if(var_82ea43f2) {
    foreach(ai in getaiarray()) {
      if(isalive(ai) && !function_3132f113(ai) && ai.team !== # "allies" && !is_true(ai.var_2e948547) && !isvehicle(ai)) {
        util::stop_magic_bullet_shield(ai);
        ai.allowdeath = 1;
        ai.takedamage = 1;
        ai.var_9a6fcc = 1;
        gibserverutils::annihilate(ai);
        ai kill(undefined, undefined, undefined, undefined, undefined, 1);
        waitframe(randomint(3) + 1);
      }
    }
  }
}

function function_d6ad49c2(params) {
  attacker = params.eattacker;

  if((is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") && is_true(self.var_d894caa2) && isPlayer(attacker) && !is_true(self.var_b70158b5)) {
    level thread function_e75baa3f();
    return;
  }

  if(!level flag::get("onslaught_round_logic_inprogress")) {
    return;
  }

  if(!isPlayer(attacker) && !is_true(self.var_b70158b5) && !isPlayer(self.killed_by)) {
    return;
  }

  level.var_d1876457 = self.origin;

  if(!is_true(self.var_d894caa2)) {
    if(self.type == # "hash_12a17ab3df5889eb") {
      level.var_bc2071f = min(100, level.var_bc2071f + level.var_74af7499);
    } else {
      level.var_bc2071f = min(100, level.var_bc2071f + level.var_3a23a27);
    }
  }

  if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") {
    level thread function_e75baa3f();
  } else {
    self clientfield::set("orb_soul_capture_fx", 1);
  }

  level notify(#"hash_221bff60f501cbaf");
}

function function_e75baa3f() {
  if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") {
    level flag::wait_till_clear(#"hash_5769afa32cc2d8b6");

    if(!isDefined(level.var_c6e7a26c)) {
      level.var_c6e7a26c = gettime();
    }

    var_cb1a403e = level.var_c6e7a26c;
    level.var_c6e7a26c = gettime();
    var_c404b563 = float(level.var_c6e7a26c - var_cb1a403e) / 1000;
    level.var_51514f45 += level.var_e2fec446;
    level.var_51514f45 = math::clamp(level.var_51514f45, 0.25, 4);
    level thread function_94f4e961();
    level thread flag::set_for_time(isDefined(level.var_12f3d2fc) ? level.var_12f3d2fc : 0.5, #"hash_5769afa32cc2d8b6");
  }
}

function function_94f4e961(n_delay = 4) {
  if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") {
    wait n_delay;
    level.var_51514f45 -= level.var_e2fec446;
    level.var_51514f45 = math::clamp(level.var_51514f45, 0.25, 4);
  }
}

function function_1e521615() {
  if(!isDefined(self.subarchetype)) {
    return 0;
  }

  var_6f8997fc = array(#"hash_5605f3a585b3ef9f", #"hash_3498fb1fbfcd0cf", #"hash_12fa854f3a7721b9");
  return isinarray(var_6f8997fc, self.subarchetype);
}

function function_33ac9c9e() {
  if(!isDefined(level.var_693d250e)) {
    level.var_693d250e = 1;
  }

  level.var_693d250e--;

  if(level.var_693d250e >= 1) {
    level.var_361db66b = self function_cb711686();
    return;
  } else if(function_50cda95()) {
    self thread zm_powerups::specific_powerup_drop("free_perk", self.origin);
  } else if(isDefined(level.var_361db66b)) {
    switch (level.var_361db66b) {
      case # "hero_weapon_power":
        self thread zm_powerups::specific_powerup_drop("full_ammo", self.origin);
        break;
      case # "full_ammo":
        self thread zm_powerups::specific_powerup_drop("insta_kill", self.origin);
        break;
      case # "insta_kill":
        self thread zm_powerups::specific_powerup_drop("hero_weapon_power", self.origin);
        break;
    }
  }

  level.var_1c376a62 = self.origin;
  level.var_9b7bd0e8++;
  level.var_bc2071f = 100;

  switch (level.var_9b7bd0e8) {
    case 3:
      break;
    case 5:
      break;
    case 8:
      break;
  }

  level.var_3a23a27 = max(level.var_3a23a27 - 2, 1);
  level.var_74af7499 = max(level.var_74af7499 - 3, 4);
  players = getplayers();

  foreach(player in players) {
    player function_a7a4f67f(level.var_9b7bd0e8);
    player zonslaught::function_e88957df(getdvarint(#"hash_4683cbe4c9d162eb", 1));
    player clientfield::set_player_uimodel("hudItems.onslaught.bosskill_count", level.var_9b7bd0e8);
  }

  level callback::callback(#"hash_7852c3cae4d4082a");
  level notify(#"boss_killed");
}

function function_c08eb1c4() {
  level endon(#"boss_killed");
  self endon(#"death");

  if(!is_true(self.var_8d1d18aa)) {
    return;
  }

  waitresult = self waittill(#"spawned_split_ai");

  if(isDefined(level.var_c42bdd1b)) {
    var_9f7c58e6 = level.var_c42bdd1b;
  } else {
    var_9f7c58e6 = # "spawner_zm_steiner_split_radiation_blast";
  }

  if(isDefined(level.var_dc38daf)) {
    var_a0024591 = level.var_dc38daf;
  } else {
    var_a0024591 = # "spawner_zm_steiner_split_radiation_bomb";
  }

  if(self function_1e521615()) {
    if(isDefined(level.var_68b26ea)) {
      var_9f7c58e6 = level.var_68b26ea;
    } else {
      var_9f7c58e6 = # "hash_7f957e36b4f6160f";
    }

    if(isDefined(level.var_887c5017)) {
      var_a0024591 = level.var_887c5017;
    } else {
      var_a0024591 = # "hash_6904f5c7bef64405";
    }
  }

  all_ai = getaiarray();

  foreach(ai in all_ai) {
    if(isDefined(ai.aitype)) {
      if(ai.aitype == var_9f7c58e6) {
        level.blast_ai = ai;
        level.blast_ai.var_2e948547 = 1;
        level.blast_ai.type = var_9f7c58e6;
        level.blast_ai.b_ignore_cleanup = 1;
        ai.var_173b6f35 = 1;
        continue;
      }

      if(ai.aitype == var_a0024591) {
        level.var_4bbd72b6 = ai;
        level.var_4bbd72b6.var_2e948547 = 1;
        level.var_4bbd72b6.type = var_a0024591;
        level.var_4bbd72b6.b_ignore_cleanup = 1;
        ai.var_173b6f35 = 1;
      }
    }
  }

  level.var_693d250e = 2;
  level.var_4bbd72b6 thread function_b33a5cf4(level.blast_ai);
  level.blast_ai thread function_b33a5cf4(level.var_4bbd72b6);
}

function function_b33a5cf4(var_ba65b6cb) {
  level endon(#"boss_killed");
  waitresult = self waittill(#"death");
  attacker = waitresult.attacker;

  if(isDefined(var_ba65b6cb) && isalive(var_ba65b6cb)) {
    level.var_361db66b = self function_cb711686();
    level.var_693d250e = 1;
    var_ba65b6cb.var_44505aa3 = 1;
    return;
  } else {
    if(function_50cda95()) {
      self thread zm_powerups::specific_powerup_drop("free_perk", self.origin);
    } else if(isDefined(level.var_361db66b)) {
      switch (level.var_361db66b) {
        case # "hero_weapon_power":
          self thread zm_powerups::specific_powerup_drop("full_ammo", self.origin);
          break;
        case # "full_ammo":
          self thread zm_powerups::specific_powerup_drop("insta_kill", self.origin);
          break;
        case # "insta_kill":
          self thread zm_powerups::specific_powerup_drop("hero_weapon_power", self.origin);
          break;
      }
    }

    if(killstreaks::is_killstreak_weapon(waitresult.weapon) && isPlayer(attacker)) {
      attacker zm_utility::give_achievement(#"hash_2deb5f76757c411d");
    }
  }

  level.var_1c376a62 = self.origin;
  level.var_693d250e = 0;
  level.var_9b7bd0e8++;
  level.var_bc2071f = 100;

  switch (level.var_9b7bd0e8) {
    case 3:
      break;
    case 5:
      break;
    case 8:
      break;
  }

  level.var_3a23a27 = max(level.var_3a23a27 - 2, 1);
  level.var_74af7499 = max(level.var_74af7499 - 3, 4);
  players = getplayers();

  foreach(player in players) {
    player function_a7a4f67f(level.var_9b7bd0e8);
    player zonslaught::function_e88957df(1);
    player clientfield::set_player_uimodel("hudItems.onslaught.bosskill_count", level.var_9b7bd0e8);
  }

  level callback::callback(#"hash_7852c3cae4d4082a");
  level notify(#"boss_killed");
}

function private function_50cda95() {
  if(is_true(level.var_e35c191f) || util::get_game_type() === # "hash_125fc0c0065c7dea") {
    if(level.wave_number % 3 != 0) {
      return false;
    }
  }

  foreach(player in function_a1ef346b()) {
    if(isarray(player.var_7341f980) && player.var_7341f980.size < level.var_b8be892e.size) {
      return true;
    }
  }

  return false;
}

function function_cb711686() {
  var_34e28de6 = randomintrange(1, 7);

  switch (var_34e28de6) {
    case 1:
    case 2:
      str_powerup = "hero_weapon_power";
      break;
    case 4:
    case 5:
      str_powerup = "full_ammo";
      break;
    case 6:
      str_powerup = "insta_kill";
      break;
    default:
      str_powerup = "full_ammo";
      break;
  }

  self thread zm_powerups::specific_powerup_drop(str_powerup, self.origin);
  return str_powerup;
}

function function_a7a4f67f(amount) {
  var_a53e72a7 = self globallogic_score::getpersstat(#"agrkills");
  self globallogic_score::incpersstat(#"agrkills", amount - var_a53e72a7, 0);
  self.agrkills = self globallogic_score::getpersstat(#"agrkills");
}

function function_a371376() {
  waitresult = self waittill(#"death");
  attacker = waitresult.attacker;

  if(is_true(self.var_8d1d18aa)) {
    self thread zm_powerups::specific_powerup_drop("full_ammo", self.origin);

    if(is_true(self.var_8576e0be)) {
      return;
    }
  }

  level.var_1c376a62 = self.origin;
  level.var_9b7bd0e8++;
  level.var_bc2071f = 100;

  switch (level.var_9b7bd0e8) {
    case 3:
      break;
    case 5:
      break;
    case 8:
      break;
  }

  level.var_3a23a27 = max(level.var_3a23a27 - 2, 1);
  level.var_74af7499 = max(level.var_74af7499 - 3, 4);
  players = getplayers();

  foreach(player in players) {
    player function_a7a4f67f(level.var_9b7bd0e8);
    player zonslaught::function_e88957df(1);
    player clientfield::set_player_uimodel("hudItems.onslaught.bosskill_count", level.var_9b7bd0e8);
  }

  level callback::callback(#"hash_7852c3cae4d4082a");
  level notify(#"boss_killed");
}

function on_ai_killed(s_params) {
  if(getDvar(#"hash_56c9b20730beeb37", 0) == 1 && isPlayer(s_params.eattacker)) {
    s_params.eattacker zm_stats::increment_challenge_stat(#"hash_2d6bcee038d7e728", undefined, 1);
  }

  if(is_true(self.is_boss)) {
    self function_33ac9c9e();
  }

  if(!isactor(self)) {
    return;
  }

  if(!isPlayer(s_params.eattacker)) {
    return;
  }

  self thread zm_powerups::function_b753385f(s_params.weapon);
}

function function_c50adb68(wave_number) {
  level.wave_number = wave_number;

  if(wave_number == 1) {
    var_d9aaf886 = getplayers().size;

    if(var_d9aaf886 > 1) {
      level.var_3a23a27 = 10 * (0.8 * var_d9aaf886 - 1);
      level.var_74af7499 = 20 * (0.8 * var_d9aaf886 - 1);
    } else {
      level.var_3a23a27 = 10;
      level.var_74af7499 = 20;
    }

    level.var_6693a0b6 = 4 * var_d9aaf886;
    level.var_569d8a24 = 2 * var_d9aaf886;
  } else {
    level.var_6693a0b6 = min(24, level.var_6693a0b6 + 2 * getplayers().size);
    level.var_569d8a24 = min(24, level.var_569d8a24);
  }

  level.var_56e32823 = 0;
  level.run_timer = 0;
  level.var_bc2071f = 0;
  level.var_8f8a58c2 = 0;
  level flag::clear("onslaught_round_logic_complete");
  level flag::clear("onslaught_accelerated_round_end");
  players = getplayers();

  foreach(player in players) {
    player clientfield::set_player_uimodel("hudItems.onslaught.wave_number", level.wave_number);
  }
}

function function_b293ea58(wave_number) {
  if(!(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e")) {
    level.var_df7b46d1.state = 1;
  }

  n_mod = (wave_number + 1) % 3;

  switch (n_mod) {
    case 0:
      level.var_cd1e3b1f = 1;
      break;
    case 1:
      level.var_cd1e3b1f = undefined;
      break;
    case 2:
      level.var_cd1e3b1f = 0;
      break;
  }

  level.var_9b7bd0e8 = int(floor((wave_number + 0.9) / 3));
  level.var_bc2071f = 100;
  level flag::clear("<dev string:x5d>");
  level flag::set("<dev string:x81>");
  level.wave_number = wave_number;
  level.var_3e67b08d = zombie_utility::set_zombie_var(#"zombie_spawn_delay", [[level.func_get_zombie_spawn_delay]](level.wave_number + 1));
}

function function_453afff4() {
  while(true) {
    var_88f09c5 = level.var_3a23a27;
    players = getplayers();

    foreach(player in players) {
      player function_813aaa72(int(level.var_bc2071f));
    }

    if(is_true(level.var_2b37d0dd)) {
      debug2dtext((670, 160, 0), "<dev string:xa3>" + level.wave_number, (1, 1, 1), 1, (0, 0, 0), 0.5, 2.8, 1);
      debug2dtext((670, 220, 0), "<dev string:xb2>" + var_88f09c5 + "<dev string:xbb>" + var_88f09c5, (1, 1, 1), 1, (0, 0, 0), 0.5, 2.8, 1);
      debug2dtext((670, 280, 0), "<dev string:xc0>" + level.total_zombies_killed, (1, 1, 1), 1, (0, 0, 0), 0.5, 2.8, 1);
      debug2dtext((670, 340, 0), "<dev string:xce>" + level.var_9b7bd0e8, (1, 1, 1), 1, (0, 0, 0), 0.5, 2.8, 1);
      debug2dtext((670, 400, 0), "<dev string:xde>" + level.var_bc2071f, (1, 1, 1), 1, (0, 0, 0), 0.5, 2.8, 1);
    }

    waitframe(1);
  }
}

function game_over() {
  level._supress_survived_screen = 1;
  level.var_ea32773 = &function_ea32773;
  level.var_94048a02 = undefined;
}

function function_77805e8(params) {
  level thread zm::function_6c369691();
  wait 10;
  level lui::screen_fade_out(1);
}

function function_ea32773(waitresult) {
  music::setmusicstate("gameover_ons");

  if(isDefined(level.deathcircle.var_5c54ab33)) {
    level.deathcircle.var_5c54ab33 delete();
  }

  players = getplayers();

  foreach(player in players) {
    player.oobdisabled = 1;
    player clientfield::set_player_uimodel("hudItems.onslaught.wave_number", level.wave_number);
    player val::set(#"gameobjects", "freezecontrols");
    player val::set(#"gameobjects", "disable_weapons");
    player thread function_2617d862();
    player val::set(#"hash_1a2b2a0d9b36043b", "show_hud", 0);
    player thread function_cf4e42ea();
  }
}

function give_match_bonus(data) {
  players = getplayers();

  foreach(player in players) {
    assert(isDefined(player.var_9a2f93bd), "<dev string:xe8>");
    var_22ba849f = getdvarint(#"hash_3f0689f4ecc2fbab", 0);
    var_900d44db = zm::function_d3113f01(level.wave_number);

    if(!isDefined(player.var_1096b5c0)) {
      player.var_1096b5c0 = 0;
    }

    var_370ac26d = player.var_1096b5c0;
    var_370ac26d += player function_ac940a26();
    var_370ac26d = int(max(var_370ac26d, 0));

    if(zm_utility::get_round_number() > 3) {
      var_370ac26d = int(max(var_370ac26d, randomintrangeinclusive(1000, 1250)));
    }

    player zm::function_78e7b549(var_370ac26d);
    player display_transition::function_d7b5082e();

    println("<dev string:x123>" + player getentnum() + "<dev string:x13c>" + player.name + "<dev string:x142>" + var_370ac26d);
    println("<dev string:x14a>" + var_22ba849f);
    println("<dev string:x157>");
  }
}

function private function_13f485ad() {
  var_370ac26d = zm::function_d3113f01(level.wave_number).var_bd588afd;
  luinotifyevent(#"hash_3e6dd0ad7b864154", 1, var_370ac26d);

  foreach(player in getplayers()) {
    if(!isDefined(player.var_1096b5c0)) {
      player.var_1096b5c0 = 0;
    }

    player addrankxpvalue("wave_end_xp", var_370ac26d, 4);
    player.var_1096b5c0 -= var_370ac26d;

    if(!isDefined(player.var_a160c21d) || player.var_a160c21d === 0) {
      println("<dev string:x17d>" + player getentitynumber() + "<dev string:x191>");
      player.var_a160c21d = 0;
    }

    player.var_1096b5c0 += player function_ac940a26();
    player.var_a160c21d = 0;
  }
}

function private function_ac940a26() {
  var_1529f18e = getdvarint(#"hash_6a8dad9b06fcd4bb", 5);
  var_6474e59d = getdvarint(#"hash_3f0689f4ecc2fbab", 0);
  var_bc57b6f5 = isDefined(self.var_a160c21d) ? self.var_a160c21d : 0;
  raw\sound\exp\ship_impact\exp_ship_impact_00.SN65.pc.snd = min(var_bc57b6f5 / 60, var_1529f18e);
  return int(var_6474e59d * raw\sound\exp\ship_impact\exp_ship_impact_00.SN65.pc.snd);
}

function function_334be69a(tacpoint) {
  navmeshpoint = getclosestpointonnavmesh(tacpoint.origin, 64, 32);

  if(!isDefined(navmeshpoint)) {
    return true;
  }

  if(!tracepassedonnavmesh(tacpoint.origin, navmeshpoint, 32)) {
    return true;
  }

  if(!ispointonnavmesh(tacpoint.origin, 32)) {
    return true;
  }

  return false;
}

function function_7f501c21() {
  level endon(#"end_game");

  while(level.var_bc2071f < 100 && (level.var_df7b46d1.state == 1 || (is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") && !level flag::get("onslaught_accelerated_round_end"))) {
    spawn_zombie(1000, 500, 400, 0);
    waitframe(1);
  }

  level flag::clear("onslaught_accelerated_round_end");
  level flag::clear("onslaught_round_logic_inprogress");
  level flag::set("onslaught_round_logic_complete");
  level.var_3e67b08d = zombie_utility::set_zombie_var(#"zombie_spawn_delay", [[level.func_get_zombie_spawn_delay]](level.wave_number + 1));
}

function function_6a89f900(params) {
  if(!isDefined(level.var_a5ab9bfb)) {
    level.var_a5ab9bfb = [];
  }
}

function spawn_dog(params) {
  if(isDefined(level.var_70b6f044) && isDefined(level.var_70b6f044[# "hash_12a17ab3df5889eb"])) {
    var_a528603 = level.var_70b6f044[# "hash_12a17ab3df5889eb"];
  } else {
    var_a528603 = # "hash_12a17ab3df5889eb";
  }

  spawn_zombie(1000, 500, 400, 0, var_a528603);
}

function spawn_zombie(outer_radius, inner_radius, duration, var_d894caa2, var_8c4dd20c) {
  ai_count = getaicount();

  if(ai_count + 1 >= getailimit()) {
    return;
  }

  alive_players = function_a1ef346b();

  if(isDefined(alive_players) && alive_players.size > 0) {
    rand_player = array::random(function_a1ef346b());

    if(!zm_utility::is_player_valid(rand_player, 0, 0)) {
      return;
    }
  } else {
    return;
  }

  var_e5c52b73 = rand_player.origin;
  player_angles = rand_player getplayerangles();
  var_c4c03968 = randomintrange(-80, 80);

  if(is_true(level.var_9725eb4a)) {
    var_c4c03968 = 0;
  }

  player_angles += (0, var_c4c03968, 0);
  player_dir = anglesToForward(player_angles);
  var_78da6163 = getclosesttacpoint(rand_player.origin);

  if(!isDefined(var_78da6163) && isDefined(rand_player.last_valid_position)) {
    if(is_true(level.var_bc79322a)) {
      circle(rand_player.last_valid_position, 150, (1, 0, 0), 1, 1, duration);
    }

    var_78da6163 = getclosesttacpoint(rand_player.last_valid_position);
  }

  if(is_true(level.var_bc79322a)) {
    circle(var_e5c52b73, inner_radius, (1, 1, 0), 1, 1, duration);
    circle(var_e5c52b73, outer_radius, (0, 1, 1), 1, 1, duration);
  }

  var_3c69a222 = tacticalquery("onslaught_tacticalquery", var_e5c52b73, rand_player);
  var_d23463ac = undefined;
  var_3ab48a16 = undefined;
  var_5bfbb8b9 = [];

  if(isDefined(var_3c69a222)) {
    var_99b8deb8 = [];
    var_c377abe7 = [];
    var_e28e2aaf = [];

    for(i = 0; i < var_3c69a222.size; i++) {
      tacpoint = var_3c69a222[i];

      if(!isDefined(tacpoint.var_356cbbd9)) {
        if(is_true(level.var_58c95941)) {
          circle(tacpoint.origin, 20, (0, 0, 1), 1, 1, duration);
        }

        tacpoint.var_356cbbd9 = function_334be69a(tacpoint);
      }

      if(is_true(level.var_58c95941)) {
        if(is_true(tacpoint.var_356cbbd9)) {
          circle(tacpoint.origin, 10, (1, 0, 0), 1, 1, duration);
        } else {
          circle(tacpoint.origin, 10, (0, 1, 0), 1, 1, duration);
        }
      }

      if(is_true(tacpoint.var_356cbbd9)) {
        continue;
      }

      var_3acd7553 = 0;

      if(is_true(tacpoint.used_time)) {
        current_time = gettime();

        if(current_time < tacpoint.used_time + 10000) {
          var_3acd7553 = 1;
        }
      }

      if(is_true(var_3acd7553)) {
        continue;
      }

      tacpoint.used_time = undefined;
      var_5bfbb8b9[var_5bfbb8b9.size] = tacpoint;
      var_99b8deb8[i] = 0;
      var_c377abe7[i] = 0;
      var_e28e2aaf[i] = 0;
      var_d32308ac = 0;

      if(isDefined(var_78da6163)) {
        if(tacpoint.region == var_78da6163.region) {
          var_d32308ac = 1;
        } else {
          var_1c28df18 = function_b507a336(var_78da6163.region);

          foreach(neighbor in var_1c28df18.neighbors) {
            if(tacpoint.region == neighbor) {
              var_d32308ac = 1;
            }
          }
        }
      }

      if(!var_d32308ac) {
        continue;
      }

      dist_sq = distancesquared(rand_player.origin, tacpoint.origin);
      var_99b8deb8[i] = dist_sq / outer_radius * outer_radius;
      var_152be849 = vectornormalize(tacpoint.origin - var_e5c52b73);
      dotproduct = vectordot(var_152be849, player_dir);
      var_c377abe7[i] = dotproduct;
      var_e28e2aaf[i] = var_99b8deb8[i] + var_c377abe7[i];

      if(!isDefined(var_d23463ac) || var_3ab48a16 < var_e28e2aaf[i]) {
        var_d23463ac = var_3c69a222[i];
        var_3ab48a16 = var_e28e2aaf[i];
      }
    }

    for(i = 0; i < var_3c69a222.size; i++) {
      tacpoint = var_3c69a222[i];

      color = (0, 1, 0);

      if(is_true(level.var_bc79322a)) {
        drawcross(tacpoint.origin, color, duration);

        if(is_true(tacpoint.used_time)) {
          sphere(tacpoint.origin + (0, 0, 10), 6, (1, 0, 0), 1, 0, 8, duration);
        }
      }

    }
  }

  if(isDefined(var_78da6163)) {
    println("<dev string:x1b7>" + var_78da6163.region);
    var_1c28df18 = function_b507a336(var_78da6163.region);

    foreach(neighbor in var_1c28df18.neighbors) {
      println("<dev string:x1cc>" + neighbor);
    }
  }

  if(!isDefined(var_d23463ac) && var_5bfbb8b9.size > 0) {
    if(var_5bfbb8b9.size === 1) {
      randindex = var_5bfbb8b9[0];
    } else if(var_5bfbb8b9.size >= 1) {
      randindex = randomintrange(0, var_5bfbb8b9.size - 1);
    } else {
      randindex = randomintrange(0, 1);
    }

    var_d23463ac = var_5bfbb8b9[randindex];
  }

  if(isDefined(var_d23463ac)) {
    if(is_true(level.var_bc79322a)) {
      sphere(var_d23463ac.origin + (0, 0, 30), 10, color, 1, 0, 8, duration);
      println("<dev string:x1da>" + var_3ab48a16 + "<dev string:x1ec>" + var_d23463ac.region);
    }

    var_d23463ac.used_time = gettime();
    var_83959d6f = vectornormalize(rand_player.origin - var_d23463ac.origin);
    spawn_angle = vectortoangles(var_83959d6f);
    var_78da6163 = getclosesttacpoint(rand_player.origin);

    if(isDefined(var_8c4dd20c)) {
      var_b434916b = var_8c4dd20c;
    } else {
      var_b434916b = function_ec2b3302();
    }

    ai = spawnactor(var_b434916b, var_d23463ac.origin + (0, 0, 10), spawn_angle);

    if(isDefined(ai)) {
      if(isDefined(var_8c4dd20c)) {
        if(!isDefined(level.var_a5ab9bfb)) {
          level.var_a5ab9bfb = [];
        } else if(!isarray(level.var_a5ab9bfb)) {
          level.var_a5ab9bfb = array(level.var_a5ab9bfb);
        }

        if(!isinarray(level.var_a5ab9bfb, ai)) {
          level.var_a5ab9bfb[level.var_a5ab9bfb.size] = ai;
        }
      }

      ai.no_powerups = 0;
      ai.type = var_b434916b;
      waitframe(1);

      if(isDefined(ai)) {
        ai enableaimassist();
        ai callback::function_d8abfc3d(#"on_ai_killed", &function_d6ad49c2);

        if(isDefined(level.var_70b6f044) && isDefined(level.var_70b6f044[# "hash_5f22ecce894282fa"]) && level.var_70b6f044[# "hash_5f22ecce894282fa"] === var_b434916b || var_b434916b === # "hash_5f22ecce894282fa") {
          ai thread function_1495c8c(ai.origin, ai.angles, "ai_t9_zm_zombie_base_traverse_ground_dugup");
        }

        if(ai.archetype === # "zombie_dog") {
          ai.zombie_move_speed = # "run";
        }

        if(var_d894caa2 === 1) {
          ai.var_d894caa2 = 1;
        }
      }
    }
  }

  if(var_d894caa2 === 1) {
    while(function_5ded2774() >= level.var_569d8a24) {
      if((is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") && (level flag::get("onslaught_round_logic_complete") || level flag::get("onslaught_accelerated_round_end"))) {
        break;
      }

      waitframe(1);
    }
  } else {
    while(function_5ded2774() >= level.var_6693a0b6) {
      if((is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") && (level flag::get("onslaught_round_logic_complete") || level flag::get("onslaught_accelerated_round_end"))) {
        break;
      }

      waitframe(1);
    }
  }

  if((is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") && (level flag::get("onslaught_round_logic_complete") || level flag::get("onslaught_accelerated_round_end"))) {
    return;
  }

  wait level.var_3e67b08d;
}

function function_6d6a276c(var_da0b6672) {
  while(true) {
    var_b3dbfd56 = level.var_d5dc0bf2;

    if(is_true(level.var_2b37d0dd)) {
      circle(var_b3dbfd56, var_da0b6672, (1, 1, 0), 1, 1, 1);
      circle(var_b3dbfd56 + (0, 0, 20), var_da0b6672, (0, 1, 1), 1, 1, 1);
      circle(var_b3dbfd56 + (0, 0, 40), var_da0b6672, (0, 1, 1), 1, 1, 1);
      circle(var_b3dbfd56 + (0, 0, 60), var_da0b6672, (0, 1, 1), 1, 1, 1);
      circle(var_b3dbfd56 + (0, 0, 80), var_da0b6672, (0, 1, 1), 1, 1, 1);
    }

    drawcross(var_b3dbfd56 + (0, 0, 10), (1, 0, 0), 1);
    drawcross(var_b3dbfd56 + (0, 0, 20), (0, 1, 0), 1);
    drawcross(var_b3dbfd56 + (0, 0, 30), (0, 0, 1), 1);

    waitframe(1);
  }
}

function function_54fc66c6() {
  while(true) {
    foreach(point in self) {
      circle(point.origin, 30, (1, 1, 0), 1, 1, 1);
    }

    waitframe(1);
  }
}

function function_33824ce9(maxpoint) {
  while(true) {
    foreach(var_d13f3ba2 in self) {
      foreach(point in var_d13f3ba2) {
        circle(point.origin, 5, (1, 0, 0), 1, 1, 1);
      }
    }

    circle(maxpoint.origin, 3, (1, 1, 0), 1, 1, 1);
    waitframe(1);
  }
}

function function_122d85c7() {
  while(true) {
    foreach(point in self) {
      circle(point.origin, 6, (0, 0, 1), 1, 1, 1);
    }

    waitframe(1);
  }
}

function function_26667466() {
  self endon(#"death");

  while(true) {
    level flag::wait_till_clear("onslaught_host_migration_active");

    switch (self.state) {
      case 0:
        level.var_a7bd1c53 = (0, 0, 0);
        players = getplayers();

        if(isDefined(players) && players.size > 0) {
          foreach(player in players) {
            if(isalive(player)) {
              level.var_a7bd1c53 += player.origin;
            }
          }

          level.var_a7bd1c53 /= players.size;
          level.var_a7bd1c53 += (0, 0, 68);
        }

        level.var_df7b46d1.var_48fcd26a clientfield::set("bot_claim_fx", 1);
        wait level.var_fcdb4d36;

        if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") {
          self.state = 3;
          level.var_679cf74b = 1;
        } else if(is_true(level.var_e35c191f) || util::get_game_type() === # "hash_125fc0c0065c7dea") {
          self.state = 5;
        } else {
          self.state = 1;
        }

        break;
      case 1:
        level notify(#"hash_4787b44eac7109dc");
        break;
      case 2:
        level.var_a7bd1c53 = (0, 0, 0);
        players = getplayers();

        if(isDefined(players) && players.size > 0) {
          foreach(player in players) {
            if(isalive(player)) {
              level.var_a7bd1c53 += player.origin;
            }
          }

          level.var_a7bd1c53 /= players.size;
          level.var_a7bd1c53 += (0, 0, 68);
        }

        var_e4547143 = vectornormalize(level.var_a7bd1c53 - self.origin);
        var_531130b2 = distance2dsquared(level.var_a7bd1c53, self.origin);
        var_bf58cac7 = level.circle_radius * 0.5;

        if(var_531130b2 > var_bf58cac7 * var_bf58cac7) {
          self.origin += var_e4547143 * 20 * (isDefined(level.var_51514f45) ? level.var_51514f45 : 1);
        }

        level notify(#"hash_7cd8474c6919310b");
        break;
      case 3:
        if(is_true(getgametypesetting(#"hash_3846b38f23c3d539"))) {
          if(!isDefined(level.var_cd1e3b1f)) {
            level.var_cd1e3b1f = 1;
          } else if(level.var_cd1e3b1f === 0) {
            level.var_cd1e3b1f = 1;
          } else if(level.var_cd1e3b1f === 1) {
            level.var_cd1e3b1f = 2;

            if(level.var_9b7bd0e8 === 0) {
              if(!is_true(level.var_dff684cf)) {
                level thread zm_vo::function_7622cb70(#"hash_534a8eea154bbf18", 0.7);
              }
            } else {
              level thread zm_vo::function_7622cb70(#"hash_22531ed3b67a2a77", 0.7);
            }
          } else {
            level.var_cd1e3b1f = 0;
          }

          if(level.var_cd1e3b1f === 0 || level.var_cd1e3b1f === 1) {
            if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") {
              level.var_df7b46d1.state = 3;
            } else if(is_true(level.var_e35c191f) || util::get_game_type() === # "hash_125fc0c0065c7dea") {
              level.var_df7b46d1.state = 5;
            } else {
              level.var_df7b46d1.state = 1;
            }
          } else if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") {
            level.var_df7b46d1.state = 3;
          } else {
            level.var_df7b46d1.state = 5;
          }

          level.var_679cf74b = 1;
          level.var_75302c0e = undefined;
          level.var_db2a4bc9 = undefined;
          level.var_bc2071f = 0;
        } else if(isDefined(level.var_75302c0e)) {
          if(isDefined(level.var_db2a4bc9)) {
            for(i = 0; i < level.var_db2a4bc9.pathpoints.size; i++) {
              circle(level.var_db2a4bc9.pathpoints[i], 6, (0, 0, 1), 1, 1, 1);
            }
          }

          var_e4547143 = vectornormalize(level.var_a7bd1c53 - self.origin);

          if(isDefined(level.var_db2a4bc9) && is_true(level.var_75302c0e)) {
            if(level.var_8c02eebd === 0) {
              var_189f09c7 = level.var_f637e029[level.var_f637e029.size - 1];
            } else if(level.var_cd1e3b1f === 0 || level.var_cd1e3b1f === 1) {
              var_189f09c7 = level.var_f637e029[0];
            } else {
              var_189f09c7 = level.var_f637e029[level.var_f637e029.size - 1];
            }

            if(var_189f09c7 > level.var_679cf74b) {
              var_481d90dc = level.var_db2a4bc9.pathpoints[level.var_679cf74b];
              var_882aca32 = vectornormalize(var_481d90dc - self.origin);
              self.origin += var_882aca32 * 10 * (isDefined(level.var_51514f45) ? level.var_51514f45 : 1);
              point2d = level.var_db2a4bc9.pathpoints[level.var_679cf74b];
              point2d = (point2d[0], point2d[1], self.origin[2]);

              if(distancesquared(point2d, self.origin) < sqr(16)) {
                if(level.var_679cf74b === var_189f09c7 - 1) {
                  if(level.var_cd1e3b1f === 0 || level.var_cd1e3b1f === 1) {
                    if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") {
                      level.var_df7b46d1.state = 3;
                    } else if(is_true(level.var_e35c191f) || util::get_game_type() === # "hash_125fc0c0065c7dea") {
                      level.var_df7b46d1.state = 5;
                    } else {
                      level.var_df7b46d1.state = 1;
                    }
                  } else if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") {
                    level.var_df7b46d1.state = 3;
                  } else {
                    level.var_df7b46d1.state = 5;
                  }

                  level.var_679cf74b = 1;
                  level.var_75302c0e = undefined;
                  level.var_db2a4bc9 = undefined;

                  if(!(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") || (is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") && level.var_bc2071f >= 100) {
                    if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") {
                      level flag::set("onslaught_accelerated_round_end");
                    }

                    level.var_bc2071f = 0;
                    level.var_8f8a58c2 = 0;
                  }
                }

                level.var_679cf74b++;
              }
            } else if(distancesquared(level.var_a7bd1c53, self.origin) < sqr(24)) {
              if(level.var_cd1e3b1f === 0 || level.var_cd1e3b1f === 1) {
                if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") {
                  level.var_df7b46d1.state = 3;
                } else if(is_true(level.var_e35c191f) || util::get_game_type() === # "hash_125fc0c0065c7dea") {
                  level.var_df7b46d1.state = 5;
                } else {
                  level.var_df7b46d1.state = 1;
                }
              } else if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") {
                level.var_df7b46d1.state = 3;
              } else {
                level.var_df7b46d1.state = 5;
              }

              level.var_679cf74b = 1;
              level.var_75302c0e = undefined;
              level.var_db2a4bc9 = undefined;

              if(!(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") || (is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") && level.var_bc2071f >= 100) {
                if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") {
                  level flag::set("onslaught_accelerated_round_end");
                }

                level.var_bc2071f = 0;
                level.var_8f8a58c2 = 0;
              }
            } else if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") {
              level.var_8c02eebd = 0;
              level.var_75302c0e = undefined;
              level.var_db2a4bc9 = undefined;
            }
          } else {
            self.origin += var_e4547143 * 10 * (isDefined(level.var_51514f45) ? level.var_51514f45 : 1);

            if(distancesquared(level.var_a7bd1c53, self.origin) < sqr(16)) {
              if(level.var_cd1e3b1f === 0 || level.var_cd1e3b1f === 1) {
                if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") {
                  level.var_df7b46d1.state = 3;
                } else if(is_true(level.var_e35c191f) || util::get_game_type() === # "hash_125fc0c0065c7dea") {
                  level.var_df7b46d1.state = 5;
                } else {
                  level.var_df7b46d1.state = 1;
                }
              } else if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") {
                level.var_df7b46d1.state = 3;
              } else {
                level.var_df7b46d1.state = 5;
              }

              level.var_679cf74b = 1;
              level.var_75302c0e = undefined;
              level.var_db2a4bc9 = undefined;
              level.var_bc2071f = 0;
              level.var_8f8a58c2 = 0;

              if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") {
                level flag::set("onslaught_accelerated_round_end");
              }
            }

            if(isDefined(level.var_30be8d70)) {
              [[level.var_30be8d70]]();
            }
          }
        } else {
          if(isDefined(level.var_75d496b5)) {
            level.var_a7bd1c53 = level.var_75d496b5;
          } else if(isDefined(level.var_15c1545d.objectiveanchor.origin)) {
            level.var_a7bd1c53 = level.var_15c1545d.objectiveanchor.origin;
          }

          if(level.var_8c02eebd === 0 && level.var_cd1e3b1f !== 2) {
            level thread function_310986be();
            level.var_a7bd1c53 = level.var_75d496b5;
          }

          if(level.var_cd1e3b1f === 1) {
            level.var_15c1545d.objectiveanchor clientfield::set("" + # "hash_56a6be021662c82e", 0);
            waitframe(1);
            level.var_15c1545d.objectiveanchor clientfield::set("" + # "hash_56a6be021662c82e", 1);
          }

          if(isDefined(level.var_a7bd1c53)) {
            start_trace = groundtrace(self.origin + (0, 0, 16), self.origin + (0, 0, -1000), 0, self);
            var_c88c2124 = start_trace[# "position"];
            var_655e0ae3 = getclosestpointonnavmesh(var_c88c2124, 204, 16);
            var_f6fe68c = groundtrace(level.var_a7bd1c53 + (0, 0, 16), level.var_a7bd1c53 + (0, 0, -1000), 0, self);
            var_eaa2511c = var_f6fe68c[# "position"];
            var_39061289 = getclosestpointonnavmesh(var_eaa2511c, 204, 16);

            if(isDefined(var_655e0ae3) && isDefined(var_39061289)) {
              level.var_db2a4bc9 = generatenavmeshpath(var_655e0ae3, var_39061289, self);
              println("<dev string:x1f8>" + var_39061289);

              if(!isDefined(level.var_db2a4bc9) || !isDefined(level.var_db2a4bc9.pathpoints) || level.var_db2a4bc9.pathpoints.size == 0) {
                recordsphere(var_39061289, 8, (0.1, 0.1, 0.1), "<dev string:x21e>");
                println("<dev string:x228>");

                level.var_75302c0e = 0;

                if(!isDefined(level.var_cd1e3b1f)) {
                  level.var_cd1e3b1f = 1;
                } else if(level.var_cd1e3b1f === 0) {
                  level.var_cd1e3b1f = 1;
                } else if(level.var_cd1e3b1f === 1) {
                  level.var_cd1e3b1f = 2;

                  if(!(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e")) {
                    if(level.var_9b7bd0e8 === 0) {
                      level thread zm_vo::function_7622cb70(#"hash_534a8eea154bbf18", 0.7);
                    } else {
                      level thread zm_vo::function_7622cb70(#"hash_22531ed3b67a2a77", 0.7);
                    }
                  }
                } else {
                  level.var_cd1e3b1f = 0;
                }
              } else {
                level.var_75302c0e = 1;
                level.var_2b577e9f = 2;

                if(!isDefined(level.var_cd1e3b1f)) {
                  level.var_cd1e3b1f = 1;
                } else if(level.var_cd1e3b1f === 0) {
                  level.var_cd1e3b1f = 1;
                } else if(level.var_cd1e3b1f === 1) {
                  level.var_cd1e3b1f = 2;

                  if(!(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e")) {
                    if(level.var_9b7bd0e8 === 0) {
                      level thread zm_vo::function_7622cb70(#"hash_534a8eea154bbf18", 0.7);
                    } else {
                      level thread zm_vo::function_7622cb70(#"hash_22531ed3b67a2a77", 0.7);
                    }
                  }
                } else {
                  level.var_8c02eebd = 0;
                  level.var_cd1e3b1f = 0;
                }

                if(level.var_cd1e3b1f !== 2 && level.var_8c02eebd === 0) {
                  var_b50dfc6a = pathdistance(level.var_a7bd1c53, level.var_df7b46d1.origin);

                  if(!isDefined(var_b50dfc6a)) {
                    var_b50dfc6a = distance(level.var_a7bd1c53, level.var_df7b46d1.origin);
                  }

                  if(var_b50dfc6a > 4896) {
                    level.var_8c02eebd = 1;
                  } else {
                    level.var_8c02eebd = 0;
                  }
                }

                if(level.var_cd1e3b1f === 0) {
                  halfway_point = int(level.var_db2a4bc9.pathpoints.size / 3);
                } else {
                  halfway_point = int(level.var_db2a4bc9.pathpoints.size / 2);
                }

                level.var_f637e029 = [halfway_point, level.var_db2a4bc9.pathpoints.size];
              }
            } else {
              if(!isDefined(level.var_cd1e3b1f)) {
                level.var_cd1e3b1f = 1;
              } else if(level.var_cd1e3b1f === 0) {
                level.var_cd1e3b1f = 1;
              } else if(level.var_cd1e3b1f === 1) {
                level.var_cd1e3b1f = 2;
              } else {
                level.var_cd1e3b1f = 0;
              }

              level.var_75302c0e = 0;
            }
          }
        }

        level notify(#"hash_7cd8474c6919310b");
        break;
      case 5:
        level.var_db2a4bc9 = undefined;
        level.var_75302c0e = undefined;
        level.var_679cf74b = 1;
        level notify(#"hash_4787b44eac7109dc");
        break;
      case 6:
        level thread function_46ff5efa();
        wait level.var_6bb0102e;
        level.var_df7b46d1.state = 3;
        break;
      default:
        break;
    }

    waitframe(1);
  }
}

function function_86d134a1() {
  level endon(#"end_game");
  var_569d5e56 = isDefined(level.var_3d9229ee) ? level.var_3d9229ee : 1000;
  var_bcce0e25 = isDefined(level.var_f35ad8f3) ? level.var_f35ad8f3 : 100;

  if((is_true(level.var_2d41db66) || util::get_game_type() === # "hash_5aa4949e75ab9d9c") && getdvarint(#"hash_d3df2c834aa1010", 1)) {
    var_bcce0e25 = 1;
  }

  level.circle_radius = var_569d5e56;
  level.deathcircle.var_5c54ab33 = death_circle::function_a8749d88(self.origin, var_569d5e56, 5, 1);
  level thread death_circle::function_dc15ad60(level.deathcircle.var_5c54ab33);

  while(true) {
    if(isDefined(level.var_aa36d14e)) {
      if(level flag::get(#"hash_2c0ce601824acdf5")) {
        var_871232e = level.var_aa36d14e * float(function_60d95f53()) / 1000 * 8;
        level.circle_radius += var_871232e;

        if(level.circle_radius < var_bcce0e25) {
          level.circle_radius = var_bcce0e25;
        } else if(level.circle_radius > var_569d5e56) {
          level.circle_radius = var_569d5e56;
        }
      } else if(level flag::get(#"hash_5acfa080039ea445") || level flag::get("cranked_pause")) {} else {
        var_b31cd2f8 = level.var_aa36d14e * float(function_60d95f53()) / 1000;
        level.circle_radius -= var_b31cd2f8;

        if(level.circle_radius < var_bcce0e25) {
          level.circle_radius = var_bcce0e25;
        } else if(level.circle_radius > var_569d5e56) {
          level.circle_radius = var_569d5e56;
        }

        if(level.circle_radius <= var_bcce0e25 && (is_true(level.var_2d41db66) || util::get_game_type() === # "hash_5aa4949e75ab9d9c") && getdvarint(#"hash_d3df2c834aa1010", 1) && level.var_bc2071f < 100) {
          level function_46ff5efa(1, 1);

          if(isDefined(level.deathcircle.var_5c54ab33)) {
            level.deathcircle.var_5c54ab33 hide();
          }

          wait 2;
          level notify(#"end_game");
        }
      }
    } else {
      level.circle_radius = var_569d5e56;
    }

    if(isDefined(level.deathcircle.var_5c54ab33)) {
      death_circle::function_9229c3b3(level.deathcircle.var_5c54ab33, level.circle_radius, self.origin, 0);

      if(is_true(level.var_2d41db66) || util::get_game_type() === # "hash_5aa4949e75ab9d9c") {
        debug2dtext((50, 600, 0), "<dev string:x253>" + level.circle_radius, undefined, undefined, undefined, 0.5);
      }
    }

    waitframe(1);
  }
}

function function_c6121618(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  return false;
}

function function_81c192d() {
  if(isDefined(level.var_df7b46d1)) {
    return;
  }

  var_20955b70 = 0;

  if(is_true(getgametypesetting(#"hash_cd096e90260a26b"))) {
    if(isDefined(level.var_d4c0ef1a[0].origin)) {
      var_20955b70 = 1;
    }
  }

  if(is_true(var_20955b70)) {
    var_37246f9a = tacticalquery("onslaught_tacticalquery", level.var_d4c0ef1a[0], level.var_d4c0ef1a[0]);
  } else {
    players = getplayers();
    var_bb96c5ab = players[0].origin;
    var_f21608fd = players[0].angles;
    player_dir = anglesToForward(var_f21608fd);
    var_37246f9a = tacticalquery("onslaught_tacticalquery", var_bb96c5ab, players[0]);
  }

  if(isDefined(var_37246f9a)) {
    var_aa93fa5f = undefined;
    var_2b0712b6 = 1;
    var_96b60b86 = 2000;
    goal_distance = 200;

    for(i = 0; i < var_37246f9a.size; i++) {
      tacpoint = var_37246f9a[i];

      if(is_true(var_20955b70)) {
        var_61c5710d = distance(level.var_d4c0ef1a[0].origin, tacpoint.origin);
        var_a7c3e3da = abs(goal_distance - var_61c5710d);

        if(var_a7c3e3da < var_96b60b86) {
          var_96b60b86 = var_a7c3e3da;
          var_aa93fa5f = tacpoint;
        }

        continue;
      }

      var_152be849 = vectornormalize(tacpoint.origin - var_bb96c5ab);
      dotproduct = vectordot(var_152be849, player_dir);

      if(dotproduct > 0.8) {
        var_d8441ed6 = distance(var_bb96c5ab, tacpoint.origin);
        var_a7c3e3da = abs(goal_distance - var_d8441ed6);

        if(var_a7c3e3da < var_96b60b86) {
          var_96b60b86 = var_a7c3e3da;
          var_2b0712b6 = dotproduct;
          var_aa93fa5f = tacpoint;
        }
      }
    }

    var_9c387409 = var_aa93fa5f.origin;
  } else {
    fwdvec = anglesToForward(var_f21608fd);
    spawnpoint = var_bb96c5ab + fwdvec * 300;
    var_56045f3b = groundtrace(spawnpoint + (0, 0, 200), spawnpoint + (0, 0, -1000), 0, undefined);
    var_9c387409 = var_56045f3b[# "position"];
  }

  if(!isDefined(var_9c387409)) {
    pos = getclosestpointonnavmesh(var_bb96c5ab, 32, 16);

    if(isDefined(pos)) {
      var_9c387409 = pos;
    } else {
      var_9c387409 = var_bb96c5ab;
    }
  }

  level.var_8c02eebd = 0;
  level.var_df7b46d1 = spawnvehicle("onslaught_orb_zm", var_9c387409, (0, 0, 0));
  level.var_df7b46d1 connectpaths();
  level.var_df7b46d1 function_d733412a(0);
  level.var_df7b46d1.var_48fcd26a = util::spawn_model("tag_origin", level.var_df7b46d1.origin);

  if(is_true(level.var_2d41db66) || util::get_game_type() === # "hash_5aa4949e75ab9d9c") {
    level.var_df7b46d1.var_48fcd26a.var_7e2d3fc6 = util::spawn_model(#"p7_zm_ctl_deathray_sphere", level.var_df7b46d1.origin);
    level.var_df7b46d1.var_48fcd26a.var_7e2d3fc6 setscale(0.2);
    level.var_df7b46d1.var_48fcd26a.var_7e2d3fc6 linkto(level.var_df7b46d1.var_48fcd26a, "tag_origin", (0, 0, -8), (0, 0, 0));
    level.var_df7b46d1.var_48fcd26a.var_7e2d3fc6 val::set("onslaught", "takedamage", 1);
    level.var_df7b46d1.var_48fcd26a.var_7e2d3fc6 val::set("onslaught", "allowdeath", 0);
    level.var_df7b46d1.var_48fcd26a.var_7e2d3fc6 thread function_48faf7bb();
  }

  level.var_df7b46d1.var_48fcd26a thread function_6362d51(level.var_df7b46d1);
  level.var_df7b46d1.var_48fcd26a clientfield::set("orb_spawn", 1);
  level.var_df7b46d1.state = 0;
  level.var_df7b46d1.takedamage = 0;
  level.var_df7b46d1.overridevehicledamage = &function_c6121618;
  level.var_df7b46d1 hide();
  level.var_df7b46d1 notsolid();
  level.var_df7b46d1 function_23a29590();
  level.var_df7b46d1 thread function_26667466();

  if(!is_true(getgametypesetting(#"hash_322e83f1e3af77c3"))) {
    level.var_df7b46d1 thread function_86d134a1();
  }

  level.var_df7b46d1 thread function_168569b2();
  level thread function_d6923f19();
}

function function_48faf7bb() {
  self endon(#"death");
  self.health = 9999;
  self.maxhealth = 9999;
  var_461a0bff = undefined;

  while(true) {
    s_waitresult = self waittill(#"damage");
    self.health = self.maxhealth;

    if(!isPlayer(s_waitresult.attacker) || s_waitresult.mod === "MOD_CRUSH") {
      continue;
    }

    n_damage = s_waitresult.amount;

    if(isDefined(s_waitresult.weapon) && s_waitresult.mod !== "MOD_AAT") {
      if(s_waitresult.weapon.offhandslot === "Tactical grenade" || s_waitresult.weapon.offhandslot === "Lethal grenade" || s_waitresult.weapon.offhandslot === "Special" || killstreaks::is_killstreak_weapon(s_waitresult.weapon)) {
        if(!zm_equipment::function_4f51b6ea(s_waitresult.weapon, s_waitresult.mod) && !is_true(self.var_88bc9ca8) && s_waitresult.mod !== "MOD_MELEE") {
          n_damage = zm_equipment::function_379f6b5d(n_damage, s_waitresult.weapon, self.zm_ai_category, self.maxhealth);
        }
      }
    }

    var_39d1c5bd = 0;

    if(s_waitresult.mod === "MOD_MELEE") {
      rootweapon = s_waitresult.weapon.rootweapon;

      if(isDefined(rootweapon) && isDefined(level.var_69acf721) && isinarray(level.var_69acf721, rootweapon)) {
        var_39d1c5bd = 1;
      }
    }

    item = s_waitresult.attacker item_inventory::function_230ceec4(s_waitresult.weapon);

    if(isDefined(item) && s_waitresult.mod != "MOD_MELEE" || var_39d1c5bd) {
      var_528363fd = self namespace_b61a349a::function_b3496fde(s_waitresult.inflictor, s_waitresult.attacker, n_damage, s_waitresult.flags, s_waitresult.mod, s_waitresult.weapon, s_waitresult.position, s_waitresult.direction);
      n_damage += var_528363fd;
      var_4d1602de = zm_weapons::function_d85e6c3a(item.itementry);
      n_damage *= var_4d1602de;

      if(isDefined(item.paplv)) {
        var_645b8bb = zm_weapons::function_896671d5(item.itementry.weapon, item.paplv);
        n_damage *= var_645b8bb;
      }
    }

    var_91d9f057 = mapfloat(1, 1000, 2, 6, n_damage);

    if(!is_true(self.var_7f0213e3)) {
      self.var_7f0213e3 = 1;
      self fx::play(#"hash_3d9456f797f0eeff", self.origin + (0, 0, 8), self.angles, "end_orb_impact_fx", 1);
    }

    self thread function_158444df(var_91d9f057);
    level thread flag::set_for_time(var_91d9f057, #"hash_5acfa080039ea445");
    self playSound(#"hash_641d6edcbf8111c1");
  }
}

function function_158444df(n_delay) {
  self notify("5aba16a43ea63d9a");
  self endon("5aba16a43ea63d9a");
  self endon(#"death");
  wait n_delay;
  self.var_7f0213e3 = undefined;
  self notify(#"end_orb_impact_fx");
}

function function_168569b2() {
  self endon(#"death");

  while(true) {
    level waittill(#"hash_4787b44eac7109dc");
    level.var_df7b46d1.var_48fcd26a playSound(#"hash_7f80b7729c2b0778");
    level waittill(#"hash_7cd8474c6919310b");
    level.var_df7b46d1.var_48fcd26a playSound(#"hash_76a949af6c568989");
  }
}

function function_6362d51(parent) {
  level endon(#"end_game");
  var_7ae0f9f6 = 1;
  var_66924182 = 1;
  x_sign = 1;
  var_71484728 = 1;
  self.origin = parent.origin + (0, 0, 68);

  while(true) {
    if(level.var_df7b46d1.state === 3 || level.var_df7b46d1.state === 1) {
      if(var_7ae0f9f6 === 1) {
        if(level.var_df7b46d1.state === 3) {
          var_d114ee3c = 20;
          var_66924182 *= -1;
          var_fe23b0e8 = (0, 0, var_d114ee3c * var_66924182);
          var_7ae0f9f6 = 0;
        } else {
          var_d114ee3c = 10;
          var_3aad51c8 = randomfloat(4);
          var_c473d11c = randomfloat(4);
          x_sign *= -1;
          var_71484728 *= -1;
          var_66924182 *= -1;
          var_fe23b0e8 = (var_3aad51c8 * x_sign, var_c473d11c * var_71484728, var_d114ee3c * var_66924182);
          var_7ae0f9f6 = 0;
        }
      }

      anchor_pos = parent.origin + (0, 0, 68);
      target_pos = anchor_pos + var_fe23b0e8;
      var_e4547143 = vectornormalize(target_pos - anchor_pos);
      dist = distancesquared(self.origin, target_pos);

      if(level.var_df7b46d1.state === 3) {
        if(dist > sqr(36)) {
          speed = 6;
        } else {
          speed = 2;
        }

        var_e2341364 = 16;
      } else {
        speed = dist / sqr(16);
        var_e2341364 = 6;
      }

      var_591f5a95 = vectornormalize(target_pos - self.origin);
      point2d = target_pos;
      point2d = (point2d[0], point2d[1], self.origin[2]);
      dist = distancesquared(target_pos, self.origin);

      if(level.var_df7b46d1.state === 3) {
        self.origin += (var_591f5a95[0], var_591f5a95[1], 0) * 20 * (isDefined(level.var_51514f45) ? level.var_51514f45 : 1);
        self.origin += (0, 0, var_591f5a95[2]) * speed;

        if(abs(self.origin[2] - target_pos[2]) < 8) {
          var_7ae0f9f6 = 1;
        }
      } else {
        self.origin += var_591f5a95 * speed;

        if(dist < sqr(var_e2341364)) {
          var_7ae0f9f6 = 1;
        }
      }
    } else {
      self.origin = parent.origin + (0, 0, 68);
    }

    waitframe(1);
  }
}

function function_3be471a2(var_78664f9a) {
  circle_radius = 1000;

  if(!level.deathcircle.enabled) {
    return;
  }

  level thread function_6d6a276c(circle_radius);

  if(is_true(var_78664f9a)) {
    if(!isDefined(level.var_d4c0ef1a) || level.var_d4c0ef1a.size > 0 || is_true(getgametypesetting(#"hash_3846b38f23c3d539"))) {
      if(level.var_df7b46d1.state !== 3 || is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") {
        level.var_df7b46d1.state = 3;
        level.var_679cf74b = 1;
        level.var_75302c0e = undefined;
        level.var_db2a4bc9 = undefined;

        if((is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") && (level flag::get("onslaught_round_logic_complete") || level flag::get("onslaught_accelerated_round_end"))) {
          level.var_bc2071f = 0;
          level.var_8f8a58c2 = 0;
          level flag::clear("onslaught_accelerated_round_end");
          var_8e368dc3 = 1;
        }
      }

      if(!is_true(var_8e368dc3)) {
        while(level.var_bc2071f > 0) {
          waitframe(1);
        }
      }
    }

    if(level.var_df7b46d1.state != 5 && level.var_df7b46d1.state != 1) {
      if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") {
        level.var_df7b46d1.state = 3;
      } else if(is_true(level.var_e35c191f) || util::get_game_type() === # "hash_125fc0c0065c7dea") {
        level.var_df7b46d1.state = 5;
      } else {
        level.var_df7b46d1.state = 1;
      }
    }

    level.var_bc2071f = 0;
  }
}

function function_6ea2e9fa() {
  level endon(#"end_game");
  color = (0, 1, 0);
  var_457e9ab8 = (1, 0, 0);
  var_3045d5d6 = (0, 0, 1);
  duration = 1;

  while(true) {
    var_d1803e09 = level.var_df7b46d1.origin;

    for(i = 0; i < 10; i++) {
      drawcross(var_d1803e09 + (0, 0, i * 10), var_3045d5d6, duration);
    }

    foreach(var_2d5745a8 in level.var_d4c0ef1a) {
      if(is_true(level.var_2b37d0dd)) {
        var_188f8bf = distance2d(var_d1803e09, var_2d5745a8.origin);
        print3d(var_2d5745a8.origin + (0, 0, 200), var_188f8bf, var_3045d5d6, 1, 4, duration, 1);
        print3d(var_2d5745a8.origin + (0, 0, 240), var_2d5745a8.usecount, var_3045d5d6, 1, 2, duration, 1);

        if(isDefined(level.var_771d8317)) {
          if(var_188f8bf > level.var_771d8317) {
            print3d(var_2d5745a8.origin + (0, 0, 300), "<dev string:x26b>", var_3045d5d6, 1, 2, duration, 1);
          }
        }

        if(is_true(var_2d5745a8.is_active)) {
          for(i = 0; i < 20; i++) {
            drawcross(var_2d5745a8.origin + (0, 0, i * 10), var_457e9ab8, duration);
          }

          continue;
        }

        for(i = 0; i < 10; i++) {
          drawcross(var_2d5745a8.origin + (0, 0, i * 10), color, duration);
        }
      }
    }

    waitframe(1);
  }
}

function setup_zones() {
  if(!isDefined(level.var_d4c0ef1a)) {
    return undefined;
  }

  for(i = 0; i < level.var_d4c0ef1a.size; i++) {
    zone = level.var_d4c0ef1a[i];
    nodes = tacticalquery("onslaught_boss_spawn_tacticalquery", zone.origin, zone);

    if(nodes.size == 0) {
      arrayremoveindex(level.var_d4c0ef1a, i);
      continue;
    }

    count = 0;

    while(true) {
      count++;
      random_index = randomintrange(0, nodes.size);
      navmesh_point = getclosestpointonnavmesh(nodes[random_index].origin, 64);

      if(isDefined(navmesh_point)) {
        break;
      }

      if(count >= nodes.size) {
        random_index = 0;
      }
    }

    zone.objectiveanchor = function_eb82ad56(nodes[random_index].origin);
    zone.objectiveanchor.var_4007e393 = zone.origin;
    zone.objectiveanchor.var_8ea4667d = nodes[random_index];

    if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") {
      zone.objectiveanchor clientfield::set("" + # "hash_56a6be021662c82e", 1);
      continue;
    }

    zone.objectiveanchor clientfield::set("" + # "hash_56a6be021662c82e", 0);
  }

  if(isDefined(level.var_d4c0ef1a) && level.var_d4c0ef1a.size > 0 || is_true(getgametypesetting(#"hash_3846b38f23c3d539"))) {
    level thread function_f19e31a2();

    level thread function_6ea2e9fa();
  }
}

function function_582988d8(zone) {
  if(isDefined(zone.objectiveanchor.var_4007e393)) {
    var_a7bd1c53 = zone.objectiveanchor.var_4007e393;
  } else {
    var_a7bd1c53 = zone.origin;
  }

  nodes = tacticalquery("onslaught_boss_spawn_tacticalquery", var_a7bd1c53, zone);

  if(nodes.size == 0) {
    return;
  }

  count = 0;
  random_index = 0;

  if(is_true(getgametypesetting(#"hash_3846b38f23c3d539"))) {
    nodes = arraysortclosest(nodes, zone.origin);
  } else {
    while(true) {
      count++;
      random_index = randomintrange(0, nodes.size);
      navmesh_point = getclosestpointonnavmesh(nodes[random_index].origin, 64);

      if(isDefined(navmesh_point)) {
        break;
      }

      if(count >= nodes.size) {
        random_index = 0;
      }
    }
  }

  if(isDefined(zone.objectiveanchor)) {
    zone.objectiveanchor.origin = nodes[random_index].origin;
  } else {
    zone.objectiveanchor = function_eb82ad56(nodes[random_index].origin);

    if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") {
      zone.objectiveanchor clientfield::set("" + # "hash_56a6be021662c82e", 1);
    } else {
      zone.objectiveanchor clientfield::set("" + # "hash_56a6be021662c82e", 0);
    }
  }

  zone.objectiveanchor.var_8ea4667d = nodes[random_index];
}

function function_10986874(var_c2f7b1a3) {
  level endon(#"end_game");
  level notify(#"hash_5731a6df491c37c7", {
    #location: var_c2f7b1a3
  });
  wait 0.5;
}

function function_f19e31a2() {
  level endon(#"end_game");
  level.var_90295a46 = -1;
  level.var_771d8317 = 512;

  if(!(is_true(level.var_e35c191f) || util::get_game_type() === # "hash_125fc0c0065c7dea")) {
    level flag::wait_till("onslaught_round_logic_complete");
  }

  while(true) {
    if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") {
      while(level.wave_number % 3 != 0) {
        waitframe(1);
      }
    }

    level thread function_310986be();

    if(!isDefined(level.var_9cf0f18d)) {
      println("<dev string:x273>" + level.var_9cf0f18d.origin);
      continue;
    }

    println("<dev string:x2b1>" + level.var_9cf0f18d.origin);
    level thread function_10986874(level.var_9cf0f18d.origin);

    if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") {
      while(level.wave_number % 3 != 0) {
        waitframe(1);
      }
    } else if(is_true(level.var_e35c191f) || util::get_game_type() === # "hash_125fc0c0065c7dea") {
      level.var_df7b46d1.state = 3;

      while(level.var_df7b46d1.state != 5) {
        waitframe(1);
      }
    } else {
      while(level.var_df7b46d1.state != 5) {
        waitframe(1);
      }
    }

    level flag::set("elite_surge_wave");

    debug2dtext((1000, 700, 0), "<dev string:x2db>", (1, 1, 1), 1, (0, 0, 0), 0.5, 2.8, 200);

    println("<dev string:x2eb>" + level.var_9cf0f18d.origin);

    debug2dtext((1000, 700, 0), "<dev string:x315>", (1, 1, 1), 1, (0, 0, 0), 0.5, 2.8, 200);

    level callback::callback(#"hash_668017ea3d415b3b");
    level flag::wait_till_clear(#"hash_554d70a6779336e1");

    if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e" || is_true(level.var_e35c191f) || util::get_game_type() === # "hash_125fc0c0065c7dea") {
      level.var_15c1545d.objectiveanchor.origin = level.var_df7b46d1.origin;
    }

    level.var_15c1545d.objectiveanchor clientfield::set("" + # "hash_56a6be021662c82e", 2);
    wait 2;

    if(level.var_9b7bd0e8 === 0) {
      level thread zm_vo::function_7622cb70(#"hash_514a3b399c691364", 0.5, 1);
    }

    level.var_2812b9f5 = function_2f6706d2();
    level.var_9cf0f18d thread function_3fd720cc();
    level.var_6d24574d = 1;

    switch (level.var_2812b9f5) {
      case # "hash_4f87aa2a203d37d0":
      case # "spawner_bo5_mimic":
        wait 2;
        break;
      default:
        wait 4;
        break;
    }

    level function_a2f55e89();

    debug2dtext((1000, 700, 0), "<dev string:x333>", (1, 1, 1), 1, (0, 0, 0), 0.5, 2.8, 200);

    zm_sq::objective_complete(#"hash_641e9c4d20df5950");
    println("<dev string:x34a>" + level.var_9cf0f18d.origin);

    if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e" || is_true(level.var_e35c191f) || util::get_game_type() === # "hash_125fc0c0065c7dea") {
      var_9f0bcfaa = getclosestpointonnavmesh(level.var_df7b46d1.origin, 64, 32);
      var_9f0bcfaa = isDefined(var_9f0bcfaa) ? var_9f0bcfaa : level.var_75d496b5;
    } else {
      var_9f0bcfaa = level.var_75d496b5;
    }

    var_67e68858 = (0, 0, 36);
    trace = groundtrace(var_9f0bcfaa + var_67e68858, var_9f0bcfaa - var_67e68858, 0, level.var_df7b46d1);

    if(trace[# "surfacetype"] !== "none" && trace[# "entity"] === undefined) {
      var_9f0bcfaa = trace[# "position"] + (0, 0, 8);
    }

    level.var_15c1545d.objectiveanchor clientfield::set("" + # "hash_56a6be021662c82e", 3);

    if(level.var_2812b9f5 == # "spawner_zm_steiner" || level.var_2812b9f5 == # "hash_acac3fe7a341329" || level.var_2812b9f5 == # "hash_43b8d4f24851653e" || level.var_2812b9f5 == # "hash_156c697af81feaf9") {
      level.boss_ai = spawnactor(level.var_2812b9f5, var_9f0bcfaa, (0, 0, 0));
      level.boss_ai function_6c40ff50();
      level.boss_ai thread function_c08eb1c4();
      level.boss_ai thread function_a371376();
    } else {
      switch (level.var_2812b9f5) {
        case # "hash_4f87aa2a203d37d0":
        case # "spawner_bo5_mimic":
          level.var_693d250e = 2;
          break;
        default:
          level.var_693d250e = 1;
          break;
      }

      for(i = 0; i < level.var_693d250e; i++) {
        ai = spawnactor(level.var_2812b9f5, var_9f0bcfaa, (0, 0, 0));
        ai.is_boss = 1;
        ai function_6c40ff50();

        if(i < level.var_693d250e - 1) {
          ai val::set("onslaught_boss", "takedamage", 0);
          wait 2;
          ai val::reset("onslaught_boss", "takedamage");
        }
      }

      level.var_15c1545d.objectiveanchor clientfield::set("" + # "hash_56a6be021662c82e", 3);
    }

    if(level.var_9b7bd0e8 > 0 || is_true(level.var_e35c191f) || util::get_game_type() === # "hash_125fc0c0065c7dea") {
      level thread function_32a5425();
    }

    if(level.var_9b7bd0e8 !== 0) {
      level thread zm_vo::function_7622cb70(#"hash_482f677bdbe28fd1", 1.7, 1);
    }

    if(level.var_2812b9f5 == # "spawner_zm_steiner" || level.var_2812b9f5 == # "hash_acac3fe7a341329" || level.var_2812b9f5 == # "hash_43b8d4f24851653e" || level.var_2812b9f5 == # "hash_156c697af81feaf9") {
      level.boss_ai thread function_b5ba566b(level.boss_ai.origin, level.boss_ai.angles, "ai_t9_zm_steiner_base_com_stn_pain_ww_idle_loop_01");
    }

    level waittill(#"boss_killed");
    level.var_6d24574d = 0;
    level function_a2f55e89();
    level.var_90295a46 = level.var_b92db9a8;
    level.var_15c1545d.is_active = 0;

    if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") {
      level.var_15c1545d.objectiveanchor clientfield::set("" + # "hash_56a6be021662c82e", 1);
    } else {
      level.var_15c1545d.objectiveanchor clientfield::set("" + # "hash_56a6be021662c82e", 0);
    }

    level.var_df7b46d1.state = 6;
    level flag::clear("elite_surge_wave");

    if(level.var_9b7bd0e8 === 1) {
      level thread zm_vo::function_7622cb70(#"hash_2e75932f6eedc934", 4, 1);
    } else {
      level zm_vo::function_7622cb70(#"hash_83f9a444e5f5963", 4);
    }

    if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") {
      while(level.wave_number % 3 === 0) {
        waitframe(1);
      }
    }

    level flag::wait_till("onslaught_round_logic_complete");
  }
}

function function_310986be() {
  if(is_true(getgametypesetting(#"hash_3846b38f23c3d539"))) {
    level.var_15c1545d = level.var_df7b46d1;
  } else {
    var_d1803e09 = level.var_df7b46d1.origin;
    var_9a582a58 = undefined;

    if(!isDefined(level.var_1eba154a) || level.var_1eba154a.size === 0) {
      level.var_1eba154a = [];

      for(i = 0; i < level.var_d4c0ef1a.size; i++) {
        if(!isDefined(level.var_1eba154a)) {
          level.var_1eba154a = [];
        } else if(!isarray(level.var_1eba154a)) {
          level.var_1eba154a = array(level.var_1eba154a);
        }

        if(!isinarray(level.var_1eba154a, level.var_d4c0ef1a[i])) {
          level.var_1eba154a[level.var_1eba154a.size] = level.var_d4c0ef1a[i];
        }
      }
    }

    if(!isDefined(level.var_6b49c914) || level.var_6b49c914.size === level.var_d4c0ef1a.size) {
      level.var_6b49c914 = [];
    }

    if(isDefined(level.var_15c1545d)) {
      level.var_15c1545d.used_recently = 0;
    }

    var_9a582a58 = randomint(level.var_1eba154a.size);
    var_2f31324d = level.var_1eba154a[var_9a582a58];

    if(!isDefined(var_2f31324d.objectiveanchor)) {
      var_2f31324d.objectiveanchor = function_eb82ad56(var_2f31324d.origin);

      if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") {
        var_2f31324d.objectiveanchor clientfield::set("" + # "hash_56a6be021662c82e", 1);
      } else {
        var_2f31324d.objectiveanchor clientfield::set("" + # "hash_56a6be021662c82e", 0);
      }
    }

    if(level.var_cd1e3b1f === 1) {
      var_b50dfc6a = pathdistance(var_d1803e09, var_2f31324d.objectiveanchor.origin);

      if(!isDefined(var_b50dfc6a)) {
        var_b50dfc6a = distance(var_d1803e09, var_2f31324d.objectiveanchor.origin);
      }

      if(var_b50dfc6a > 4896) {
        if(level.var_1eba154a.size > 1) {
          var_7a3b2fd5 = arraysortclosest(level.var_1eba154a, var_d1803e09);

          if(is_true(var_7a3b2fd5[0].used_recently) && var_7a3b2fd5.size > 1) {
            var_9a582a58 = 1;
          } else {
            var_9a582a58 = 0;
          }

          var_2f31324d = level.var_1eba154a[var_9a582a58];
        } else {
          var_24f1be34 = arraysortclosest(level.var_6b49c914, var_d1803e09);

          if(isDefined(level.var_15c1545d)) {
            arrayremovevalue(var_24f1be34, level.var_15c1545d);
          }

          if(is_true(var_24f1be34[0].used_recently) && var_24f1be34.size > 1) {
            var_2f31324d = var_24f1be34[1];
          } else {
            var_2f31324d = var_24f1be34[0];
          }
        }
      } else {
        var_2f31324d = level.var_1eba154a[var_9a582a58];
      }
    }

    if(isDefined(var_2f31324d)) {
      level.var_15c1545d = var_2f31324d;
    } else {
      level.var_15c1545d = level.var_df7b46d1;
    }

    if(!isDefined(level.var_6b49c914)) {
      level.var_6b49c914 = [];
    } else if(!isarray(level.var_6b49c914)) {
      level.var_6b49c914 = array(level.var_6b49c914);
    }

    if(!isinarray(level.var_6b49c914, level.var_15c1545d)) {
      level.var_6b49c914[level.var_6b49c914.size] = level.var_15c1545d;
    }

    if(isDefined(var_9a582a58)) {
      arrayremoveindex(level.var_1eba154a, var_9a582a58);
    }

    level.var_15c1545d.used_recently = 1;
    level.var_15c1545d.is_active = 1;

    if(!isDefined(level.var_15c1545d.usecount)) {
      level.var_15c1545d.usecount = 0;
    }

    level.var_15c1545d.usecount += 1;
  }

  level function_582988d8(level.var_15c1545d);
  level.var_9cf0f18d = level.var_15c1545d.objectiveanchor.var_8ea4667d;
  level.var_75d496b5 = level.var_9cf0f18d.origin;

  if(level.var_8de4d059 === # "mp_echelon" && level.var_15c1545d.script_index === 4) {
    var_aec0cd16 = 128;
    var_95273e9b = 100;
  } else {
    var_aec0cd16 = 64;
    var_95273e9b = 32;
  }

  var_7cd6fd7 = getclosestpointonnavmesh(level.var_15c1545d.objectiveanchor.var_8ea4667d.origin, var_aec0cd16, var_95273e9b);

  if(isDefined(var_7cd6fd7)) {
    level.var_75d496b5 = var_7cd6fd7;
  }
}

function function_32a5425() {
  level endon(#"end_game", #"boss_killed");

  while(true) {
    spawn_zombie(1000, 500, 400, 1);
    waitframe(1);
  }
}

function function_b504f826() {
  level endon(#"end_game");

  while(true) {
    wait 0.5;
  }
}

function function_31add0ec() {
  level endon(#"end_game");

  while(true) {
    wait 0.5;
  }
}

function function_69e5b9b() {
  level endon(#"end_game");
  level.total_zombies_killed = 0;
  level.var_9b7bd0e8 = 0;
  level.var_3e67b08d = isDefined(zombie_utility::get_zombie_var(#"zombie_spawn_delay")) ? zombie_utility::get_zombie_var(#"zombie_spawn_delay") : zombie_utility::get_zombie_var(#"hash_7d5a25e2463f7fc5");
  level zombie_utility::set_zombie_var(#"zombie_move_speed_multiplier", 6);
  level.var_d5dc0bf2 = (0, 0, 0);
  level thread function_b504f826();
  level thread function_31add0ec();
  music::setmusicstate("");
  level flag::wait_till("rounds_started");
  level setup_zones();

  if(is_true(level.var_dff684cf)) {
    music::setmusicstate("containment_intro");
  } else {
    music::setmusicstate("intro");
  }

  level function_a2f55e89();
  function_c50adb68(1);
  level thread function_453afff4();
  level thread game_over();
  level thread function_3be471a2(0);
  level thread function_d0d7faac();

  while(true) {
    players = getplayers();

    foreach(player in players) {
      player thread function_da556d60();
      player function_a7a4f67f(level.var_9b7bd0e8);
    }

    level callback::callback(#"hash_75d9baf9eed8610b");
    wait level.var_d2a573c6;
    level flag::wait_till_clear(#"hash_554d70a6779336e1");
    level.var_df7b46d1.var_48fcd26a playSound(#"hash_7abe3d8888674c46");
    level function_a2f55e89();

    if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") {
      if(level.wave_number % 3 === 0) {
        level flag::wait_till_clear("elite_surge_wave");
        wait level.var_6bb0102e;
      }
    } else {
      while(level.var_df7b46d1.state == 5 || level.var_df7b46d1.state == 6) {
        level.var_dc554d4b = 1;
        level.var_9520224b = 1;
        waitframe(1);
      }
    }

    level.run_timer = 1;
    level flag::set("onslaught_round_logic_inprogress");
    self thread function_7f501c21();
    level flag::wait_till("onslaught_round_logic_complete");
    level notify(#"hash_3342246739e3dfc5");
    level.run_timer = 0;
    level function_a2f55e89(1);

    if(!is_true(level.var_dc554d4b === 1)) {} else {
      level.var_dc554d4b = undefined;
    }

    if(level.var_df7b46d1.state == 1 && !(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e")) {
      level thread function_46ff5efa();
    } else if(level.var_df7b46d1.state == 3) {
      level function_3be471a2(1);
    }

    wait level.var_f4dc118e;

    if(level.var_df7b46d1.state != 3 && !(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e")) {
      level function_3be471a2(1);
    }

    wait level.var_b4b52d95;
    level notify(#"hash_5797e93787e36c6d");
    level callback::callback(#"hash_5118a91e667446ee");
    zm_round_logic::set_round_number(level.round_number + 1);
    level.var_9520224b = undefined;
    function_c50adb68(level.wave_number + 1);
  }
}

function private function_d0d7faac() {
  level endon(#"end_game");

  while(true) {
    all_ai = getaiarray();

    foreach(ai in all_ai) {
      if(is_true(ai.var_173b6f35)) {
        ai show();
        ai solid();
      }

      if(!isalive(ai) || ai isragdoll()) {
        ai.var_9a6fcc = 1;
      }
    }

    waitframe(1);
  }
}

function event_handler[bhtn_action_start] function_320145f7(eventstruct) {
  if(isDefined(self.var_b467f3a1)) {
    self thread[[self.var_b467f3a1]](eventstruct);
    return;
  }

  notify_string = eventstruct.action;

  switch (notify_string) {
    case # "death":
      if(is_true(self.bgb_tone_death)) {
        level thread zmbaivox_playvox(self, "death_whimsy", 1, 4);
      } else if(is_true(self.bgb_quacknarok)) {
        level thread zmbaivox_playvox(self, "death_quack", 1, 4);
      } else {
        level thread zmbaivox_playvox(self, notify_string, 1, 4);
      }

      break;
    case # "pain":
      level thread zmbaivox_playvox(self, notify_string, 1, 3);
      break;
    case # "behind":
      level thread zmbaivox_playvox(self, notify_string, 1, 3);
      break;
    case # "electrocute":
      level thread zmbaivox_playvox(self, notify_string, 1, 3);
      break;
    case # "attack_melee_notetrack":
      level thread zmbaivox_playvox(self, "attack_melee", 1, 2, 1);
      break;
    case # "sprint":
    case # "ambient":
    case # "crawler":
    case # "teardown":
    case # "taunt":
      level thread zmbaivox_playvox(self, notify_string, 0, 1);
      break;
    case # "attack_melee":
      break;
    default:
      level thread zmbaivox_playvox(self, notify_string, 0, 2);
      break;
  }
}

function zmbaivox_notifyconvert() {
  self endon(#"death", #"disconnect");
  level endon(#"game_ended");
  self thread zmbaivox_playdeath();
  self thread zmbaivox_playelectrocution();
}

function zmbaivox_playvox(zombie, type, override, priority, delayambientvox = 0) {
  zombie endon(#"death");

  if(!isDefined(zombie)) {
    return;
  }

  if(!isDefined(zombie.voiceprefix)) {
    return;
  }

  if(!isDefined(priority)) {
    priority = 1;
  }

  if(!isDefined(zombie.talking)) {
    zombie.talking = 0;
  }

  if(!isDefined(zombie.currentvoxpriority)) {
    zombie.currentvoxpriority = 1;
  }

  if(!isDefined(self.delayambientvox)) {
    self.delayambientvox = 0;
  }

  if(is_true(zombie.var_e8920729)) {
    return;
  }

  if((type == "ambient" || type == "sprint" || type == "crawler") && is_true(self.delayambientvox)) {
    return;
  }

  if(delayambientvox) {
    self.delayambientvox = 1;
    self thread zmbaivox_ambientdelay();
  }

  alias = "zmb_vocals_" + zombie.voiceprefix + "_" + type;

  if(sndisnetworksafe()) {
    if(is_true(override)) {
      if(isDefined(zombie.currentvox) && priority > zombie.currentvoxpriority) {
        zombie stopsound(zombie.currentvox);
        waitframe(1);
      }

      if(type == "death" || type == "death_whimsy" || type == "death_nohead") {
        zombie playSound(alias);
        return;
      }
    }

    if(zombie.talking === 1 && (priority < zombie.currentvoxpriority || priority === 1)) {
      return;
    }

    if(is_true(zombie.head_gibbed)) {
      return;
    }

    zombie.talking = 1;
    zombie.currentvox = alias;
    zombie.currentvoxpriority = priority;
    zombie playsoundontag(alias, "j_head");
    playbacktime = float(max(isDefined(soundgetplaybacktime(alias)) ? soundgetplaybacktime(alias) : 500, 500)) / 1000;
    wait playbacktime;
    zombie.talking = 0;
    zombie.currentvox = undefined;
    zombie.currentvoxpriority = 1;
  }
}

function zmbaivox_playdeath() {
  self endon(#"disconnect");
  self waittill(#"death");

  if(isDefined(self)) {
    if(is_true(self.bgb_tone_death)) {
      level thread zmbaivox_playvox(self, "death_whimsy", 1);
      return;
    }

    if(is_true(self.head_gibbed)) {
      level thread zmbaivox_playvox(self, "death_nohead", 1);
      return;
    }

    level thread zmbaivox_playvox(self, "death", 1);
  }
}

function zmbaivox_playelectrocution() {
  self endon(#"disconnect", #"death");

  while(true) {
    waitresult = self waittill(#"damage");
    weapon = waitresult.weapon;

    if(!isDefined(weapon)) {
      continue;
    }

    if(weapon.name === # "zombie_beast_lightning_dwl" || weapon.name === # "zombie_beast_lightning_dwl2" || weapon.name === # "zombie_beast_lightning_dwl3") {
      bhtnactionstartevent(self, "electrocute");
      self notify(#"bhtn_action_notify", {
        #action: "electrocute"});
    }
  }
}

function zmbaivox_ambientdelay() {
  self notify(#"sndambientdelay");
  self endon(#"sndambientdelay", #"death", #"disconnect");
  wait 2;
  self.delayambientvox = 0;
}

function networksafereset() {
  while(true) {
    level._numzmbaivox = 0;
    util::wait_network_frame();
  }
}

function sndisnetworksafe() {
  if(!isDefined(level._numzmbaivox)) {
    level thread networksafereset();
  }

  if(level._numzmbaivox >= 2) {
    return false;
  }

  level._numzmbaivox++;
  return true;
}

function get_zombie_array() {
  enemies = getaiarchetypearray(#"zombie");
  return enemies;
}

function function_4f20e746() {
  enemies = getaiarchetypearray(#"zombie_dog");
  return enemies;
}

function function_5ded2774() {
  enemies = get_zombie_array();
  var_b56897f8 = function_4f20e746();
  return var_b56897f8.size + enemies.size;
}

function is_last_zombie() {
  if(function_5ded2774() <= 1) {
    return true;
  }

  return false;
}

function getyaw(org) {
  angles = vectortoangles(org - self.origin);
  return angles[1];
}

function getyawtospot(spot) {
  pos = spot;
  yaw = self.angles[1] - getyaw(pos);
  yaw = angleclamp180(yaw);
  return yaw;
}

function zombie_behind_vox() {
  level endon(#"unloaded");
  self endon(#"death", #"disconnect");

  if(!isDefined(level._zbv_vox_last_update_time)) {
    level._zbv_vox_last_update_time = 0;
    level._audio_zbv_shared_ent_list = get_zombie_array();
  }

  while(true) {
    wait 1;
    t = gettime();

    if(t > level._zbv_vox_last_update_time + 1000) {
      level._zbv_vox_last_update_time = t;
      level._audio_zbv_shared_ent_list = get_zombie_array();
    }

    zombs = level._audio_zbv_shared_ent_list;
    played_sound = 0;

    for(i = 0; i < zombs.size; i++) {
      if(!isDefined(zombs[i])) {
        continue;
      }

      if(zombs[i].isdog) {
        continue;
      }

      dist = 150;
      z_dist = 50;
      alias = level.vox_behind_zombie;

      if(isDefined(zombs[i].zombie_move_speed)) {
        switch (zombs[i].zombie_move_speed) {
          case # "walk":
            dist = 150;
            break;
          case # "run":
            dist = 175;
            break;
          case # "sprint":
            dist = 200;
            break;
        }
      }

      if(distancesquared(zombs[i].origin, self.origin) < dist * dist) {
        yaw = self getyawtospot(zombs[i].origin);
        z_diff = self.origin[2] - zombs[i].origin[2];

        if((yaw < -95 || yaw > 95) && abs(z_diff) < 50) {
          wait 0.1;

          if(isDefined(zombs[i]) && isalive(zombs[i])) {
            bhtnactionstartevent(zombs[i], "behind");
            zombs[i] notify(#"bhtn_action_notify", {
              #action: "behind"});
            played_sound = 1;
          }

          break;
        }
      }
    }

    if(played_sound) {
      wait 2.5;
    }
  }
}

function play_ambient_zombie_vocals() {
  self endon(#"death");

  while(true) {
    type = "ambient";
    float = 3;

    if(isDefined(self.zombie_move_speed)) {
      switch (self.zombie_move_speed) {
        case # "walk":
          type = "ambient";
          float = 3;
          break;
        case # "run":
          type = "sprint";
          float = 3;
          break;
        case # "sprint":
          type = "sprint";
          float = 3;
          break;
      }
    }

    if(is_true(self.missinglegs)) {
      float = 2;
      type = "crawler";
    }

    bhtnactionstartevent(self, type);
    self notify(#"bhtn_action_notify", {
      #action: type
    });
    wait randomfloatrange(1, float);
  }
}

function function_713192b1(str_location, var_39acfdda) {
  if(!isDefined(level.var_cbcee8da)) {
    level.var_cbcee8da = [];
  }

  if(!isDefined(level.var_b2a9a8d7)) {
    level.var_b2a9a8d7 = [];
  }

  if(!isDefined(level.var_cbcee8da[var_39acfdda])) {
    level.var_cbcee8da[var_39acfdda] = 0;
  }

  if(!isDefined(level.var_b2a9a8d7[str_location])) {
    level.var_b2a9a8d7[str_location] = var_39acfdda;
  }
}

function location_vox(str_location) {
  if(!isDefined(level.var_b2a9a8d7)) {
    return;
  }

  if(!isDefined(level.var_b2a9a8d7[str_location])) {
    return;
  }

  var_39acfdda = level.var_b2a9a8d7[str_location];

  if(!isDefined(self.var_cbcee8da)) {
    self.var_cbcee8da = [];
  }

  if(!isDefined(self.var_cbcee8da[var_39acfdda])) {
    self.var_cbcee8da[var_39acfdda] = 0;
  }

  if(!level.var_cbcee8da[var_39acfdda] && !self.var_cbcee8da[var_39acfdda]) {
    self.var_cbcee8da[var_39acfdda] = 1;
    b_played = 0;

    if(is_true(b_played)) {
      level.var_cbcee8da[var_39acfdda] = 1;
    }
  }
}

function get_number_variants(aliasprefix) {
  for(i = 0; i < 20; i++) {
    if(!soundexists(aliasprefix + "_" + i)) {
      return i;
    }
  }

  assertmsg("<dev string:x374>");
}

function get_valid_lines(aliasprefix) {
  a_variants = [];

  for(i = 0; i < 20; i++) {
    str_alias = aliasprefix + "_" + i;

    if(soundexists(str_alias)) {
      if(!isDefined(a_variants)) {
        a_variants = [];
      } else if(!isarray(a_variants)) {
        a_variants = array(a_variants);
      }

      a_variants[a_variants.size] = str_alias;
      continue;
    }

    if(soundexists(aliasprefix)) {
      if(!isDefined(a_variants)) {
        a_variants = [];
      } else if(!isarray(a_variants)) {
        a_variants = array(a_variants);
      }

      a_variants[a_variants.size] = aliasprefix;
      break;
    }
  }

  return a_variants;
}

function function_a2f55e89(var_511659b1 = 0) {
  if(!isDefined(level.var_4ea64c7f)) {
    level.var_4ea64c7f = "";
  }

  var_9c1ed9ea = undefined;

  if(var_511659b1) {
    var_9c1ed9ea = "energy_low";
  } else if(is_true(level.var_6d24574d)) {
    var_9c1ed9ea = "energy_epic";
  } else if(level.wave_number >= 16) {
    var_9c1ed9ea = "energy_high";
  } else if(level.wave_number >= 6) {
    var_9c1ed9ea = "energy_med";
  } else {
    var_9c1ed9ea = "energy_low";
  }

  if(is_true(level.var_dff684cf)) {
    var_9c1ed9ea = undefined;
  }

  if(isDefined(var_9c1ed9ea)) {
    level.var_4ea64c7f = var_9c1ed9ea;
    music::setmusicstate(var_9c1ed9ea);
  }
}

function on_host_migration_begin(params) {
  level flag::set("onslaught_host_migration_active");
}

function on_host_migration_end(params) {
  level flag::clear("onslaught_host_migration_active");

  if(isDefined(level.var_4ea64c7f) && level.var_4ea64c7f != "") {
    music::setmusicstate(level.var_4ea64c7f);
  }
}

function function_eb82ad56(v_origin) {
  if(is_true(level.var_612d6a21) || util::get_game_type() === # "hash_75aa82b3ae89f54e") {
    var_6cc0acda = util::spawn_model("tag_origin", level.var_df7b46d1.origin - (0, 0, 68));
    var_6cc0acda linkto(level.var_df7b46d1);
  } else {
    var_6cc0acda = util::spawn_model("tag_origin", v_origin);
  }

  return var_6cc0acda;
}