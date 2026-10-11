/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1c6e50e1bfd8faaa.gsc
*************************************************/

#using script_100adcc1cc11d2fa;
#using script_118c3165d7948d8b;
#using script_143ad6d9c2b4c721;
#using script_249b0a9054ceb230;
#using script_25d5af9df677cbe;
#using script_260b46e6d2ece28a;
#using script_29b50ff5f1477a5d;
#using script_2ac1abaaff251be6;
#using script_2d400da2610fe542;
#using script_2e177f1d7a5b9456;
#using script_2f1eb9e550fc34a8;
#using script_337e3ff7ad8cf996;
#using script_3f9c618c4c35ed2;
#using script_41387eecc35b88bf;
#using script_46c7c73b1a7e4773;
#using script_4e6e58ab5d96c2b0;
#using script_51f24f75eec1f8a7;
#using script_528320cb3630530d;
#using script_5a5fd0c909da7dac;
#using script_6633a5b5b878ff12;
#using script_685207987fef2bdc;
#using script_793f5fa29ca62c00;
#using script_7d3e27aa82b5d70b;
#using script_7e41e37180e554f;
#using script_7edf952f8921aa6b;
#using script_c6b9e8fb3a7de37;
#using scripts\common\callbacks;
#using scripts\common\powerups;
#using scripts\common\utility;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\overlord;
#using scripts\engine\utility;
#using scripts\mp\gametypes\ob;
#using scripts\ob\ob_rift_gate;
#namespace namespace_6f390e4fde2064d;

function function_2dcca6d862cc31d5(params) {
  utility::function_3677f2be30fdd581("jup_ob_fx", "jup_ob_rift_run_fx");
  scripts\ob\ob_rift_gate::function_9075c9a5985b8ac0(self);
  self.rift_run = 1;
  difficulty = "normal";

  if(getdvarint(@ "hash_73cfb77eb49c943", 0)) {
    difficulty = "hard";
  }

  self dlog_recordplayerevent("dlog_event_ob_player_rift_run", ["started", 1, "difficulty", difficulty]);

  if(isPlayer(self)) {
    foreach(weapon in self.primaryweapons) {
      self givemaxammo(weapon);
    }
  }
}

function function_4dd5d69d550c0999() {
  level endon("game_ended");
  scrambler = spawn("script_model", function_dc80e43dced96932());
  n_radius = int(default_to(function_868dda939525d6dd(), 10000));

  while(true) {
    if(!isDefined(level.players) || level.players.size < 1) {
      waitframe();
      continue;
    }

    owner = random(level.players);
    scrambler.team = owner.team;
    scrambler makescrambler(owner, undefined, n_radius, 1);
    owner waittill("disconnect");
    scrambler clearscrambler();
  }
}

function private function_dc80e43dced96932() {
  a_corners = getStructArray("minimap_corner", "targetname");
  v_loc = (0, 0, 0);

  if(a_corners.size) {
    foreach(corner in a_corners) {
      v_loc += corner.origin;
    }

    v_loc /= a_corners.size;
  }

  return v_loc;
}

function private function_868dda939525d6dd() {
  a_corners = getStructArray("minimap_corner", "targetname");

  if(a_corners.size > 1) {
    return (distance2d(a_corners[0].origin, a_corners[1].origin) / 1.9);
  }
}

function infil_music() {
  level waittill_any_2("match_start_real_countdown", "match_start_timer_skip");
  level thread namespace_b3f32c8cb80b8124::function_aadc1c81b3fd1dd2(level.players);

  foreach(player in level.players) {
    player clearsoundsubmix("jup_ob_prematch", 2);
  }
}

function function_b74088644ee18731() {
  thread function_4dd5d69d550c0999();
  thread namespace_b000de497fab9bf4::function_ccde446fe7425514();
  thread infil_music();
  level flag_wait("ai_spawn_director_initialized");
  namespace_22b8ba12655bf3f2::function_d589c49c4b9b50a0(&scripts\mp\gametypes\ob::function_91d032246bb24684);
  level.var_a3605064bf81a95c = 0;
  scripts\common\callbacks::add("ob_locked_space_unlocked", &function_c30596883f5589b7);
  thread namespace_f6368c72597c6d90::function_2a56c656879dbf63();
  thread function_d20174d63594a712();
  thread function_95484dc1fa0e07fc();
  thread function_61cd13522a6c6045();
  thread function_f86a7718dec2e17();
  thread intro_vo();
  thread namespace_88d9f8b28d831818::function_ecd079f7925cc275();
  thread function_d6be862ee76f002c();
  namespace_b000de497fab9bf4::function_a13799ae222a8b48("exit_portal");
  level.var_e345b15591192b73 = 0;
  function_8b5b2a3392fc7e2a("ActivitySuccess", &function_83d43ec21f04f972, "REV_OB_OUTLAST");
  function_8b5b2a3392fc7e2a("ActivitySuccess", &function_83d43ec21f04f972, "REV_OB_SABOTAGE");
  function_8b5b2a3392fc7e2a("ActivitySuccess", &function_83d43ec21f04f972, "REV_OB_ESCORT_ZOMBIES");
}

function function_61aea37385c298a9(params) {
  self endon("death_or_disconnect");
  scripts\cp_mp\overlord::playevent("rift_run_s1_exit", [self], 0.5);
}

function function_83d43ec21f04f972(relevantinfostruct) {
  level.var_e345b15591192b73++;

  foreach(player in level.players) {
    player namespace_838b439602b3acc7::function_9db4c37d4f1415f("rift_run_contract_completed");

    if(getdvarint(@ "hash_73cfb77eb49c943", 0)) {
      player namespace_838b439602b3acc7::function_9db4c37d4f1415f("rift_run_hard_contract_completed");
    }
  }

  if(randomint(100) < 33) {
    level endon("game_ended");
    scripts\cp_mp\overlord::playevent("rift_run_s1_contract_complete", level.players, 4.5);
  }
}

function intro_vo() {
  level endon("game_ended");
  level utility::flag_wait("ob_infil_completed");
  scripts\cp_mp\overlord::playevent("rift_run_s1_arrive", level.players, 7);
}

function function_f86a7718dec2e17() {
  level._effect["mrpeeks_intro_glow"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_activity_mrpeeks_amb.vfx");
  level._effect["mrpeeks_launch_glow"] = loadfx("vfx/s4/gamemode/vfx_alps_spotlight_glow_blue.vfx");
  a_spawns = getStructArray("mrpeeks_intro", "targetname");
  a_contracts = [];
  a_models = [];

  while(a_contracts.size < 3) {
    waitframe();
    a_contracts = getStructArray("activity_nexus_instance_joiner", "targetname");
  }

  for(i = 0; i < a_spawns.size; i++) {
    v_target = undefined;

    foreach(s_contract in a_contracts) {
      if(s_contract.script_noteworthy == a_spawns[i].script_noteworthy) {
        v_target = s_contract.origin;

        if(s_contract.script_noteworthy == "OUTLAST_FORT") {
          b_invert = 1;
          s_trigger = a_spawns[i];
        } else {
          b_invert = 0;
        }

        break;
      }
    }

    if(isDefined(v_target)) {
      e_model = utility::spawn_model("ob_mrp", a_spawns[i].origin, a_spawns[i].angles);
      e_model thread function_786907b8e0e31227(v_target, b_invert);
      playFXOnTag(level._effect["mrpeeks_intro_glow"], e_model, "tag_origin");
      a_models[a_models.size] = e_model;

      if(b_invert) {
        e_audio = e_model;
      }
    }
  }

  if(!a_models.size) {
    return;
  }

  e_audio playLoopSound("evt_ob_rr_bunny_attract_lp");
  trigger = getEnt("mrpeeks_intro_trigger", "targetname");

  while(isDefined(trigger)) {
    trigger waittill("trigger", ent);

    if(isPlayer(ent)) {
      e_audio stoploopsound();
      playsoundatpos(e_audio.origin, "evt_ob_rr_bunny_flyaway");

      foreach(e_model in a_models) {
        playFXOnTag(level._effect["mrpeeks_launch_glow"], e_model, "tag_origin");
        e_model notify("bunny_launch_time");
        wait 0.4;
      }

      return;
    }
  }
}

function private function_786907b8e0e31227(v_target, b_invert) {
  self endon("death");
  thread function_e6dbdae3069edce4(b_invert);
  self waittill("bunny_launch_time");
  time = 4;
  v_start = self.origin;
  gravity = getdvarint(@ "bg_gravity", 0) * -1;
  dist = distance(v_start, v_target);
  power = dist / time;
  delta = v_target - v_start;
  drop = 0.5 * gravity * time * time;
  velocity = (delta[0] / time, delta[1] / time, (delta[2] - drop) / time);
  self movegravity(velocity, time);
  wait time;
  self delete();
}

function private function_e6dbdae3069edce4(b_invert) {
  self endon("death");
  self endon("bunny_launch_time");
  n_move_time = 1.25;
  n_dist = 32;

  if(b_invert) {
    n_dist *= -1;
  }

  while(true) {
    self moveTo(self.origin - (0, 0, n_dist), n_move_time);
    wait n_move_time;
    self moveTo(self.origin + (0, 0, n_dist), n_move_time);
    wait n_move_time;
  }
}

function function_c30596883f5589b7(params) {
  level.var_a3605064bf81a95c++;

  if(level.var_a3605064bf81a95c > 6) {
    iprintlnbold("<dev string:x1c>");

    level endon("game_ended");
    level scripts\common\callbacks::remove("ob_locked_space_unlocked", &function_c30596883f5589b7);
    level scripts\common\callbacks::add("on_zombie_ai_spawned", &function_29ed201ad0740f4e);
    a_ai = getaiarray();
    var_f032fbbe85ac8203 = 0;

    if(isDefined(a_ai) && isarray(a_ai) && a_ai.size > 0) {
      foreach(ai in a_ai) {
        if(isDefined(ai) && isalive(ai)) {
          ai namespace_dd16d65e824b8e9::function_f1e5805da192a1ef("walk", "walker_ee", 99);
        }
      }

      var_f032fbbe85ac8203 = 1;
      wait 60;
    }

    level scripts\common\callbacks::remove("on_zombie_ai_spawned", &function_29ed201ad0740f4e);

    if(istrue(var_f032fbbe85ac8203)) {
      a_ai = getaiarray();

      if(isDefined(a_ai) && isarray(a_ai) && a_ai.size > 0) {
        foreach(ai in a_ai) {
          if(isDefined(ai) && isalive(ai)) {
            if(isDefined(ai.var_caeb5ca53668812c) && isarray(ai.var_caeb5ca53668812c) && ai.var_caeb5ca53668812c.size > 0) {
              for(i = 0; i < ai.var_caeb5ca53668812c.size; i++) {
                current = ai.var_caeb5ca53668812c[i];

                if(isDefined(current) && current.id == "walker_ee") {
                  ai.var_caeb5ca53668812c = array_remove_index(ai.var_caeb5ca53668812c, i);
                  break;
                }
              }
            }

            ai namespace_dd16d65e824b8e9::function_f1e5805da192a1ef();
          }
        }
      }
    }
  }
}

function function_c0ec711e1ca76fd7(params) {
  if(self.aicategory == "elite") {
    self._blackboard.var_2af8408672f2a570 = 250;
    self._blackboard.var_2ad5368672cc47ba = 300;
  }
}

function function_d6be862ee76f002c() {
  level flag_wait("ob_infil_completed");
  var_3ba758145a58afe0 = getentitylessscriptablearray(undefined, undefined, undefined, undefined, "nexus_activity_joiner_phone");

  foreach(scriptable in var_3ba758145a58afe0) {
    if(scriptable getscriptablehaspart("nexus_activity_joiner_phone")) {
      scriptable setscriptablepartstate("nexus_activity_joiner_phone", "visible_rift_run");
    }
  }
}

function function_3b588416e348d52a(player) {
  self setscriptablepartstate("nexus_activity_joiner_phone", "hidden");
}

function function_d20174d63594a712() {
  var_29a3db0499a2874 = array_randomize(getStructArray("ob_locked_space_loot", "targetname"));

  foreach(loot_spawn in var_29a3db0499a2874) {
    scripts\cp_mp\loot\common_item::function_cd45408bd44fab07("ob_jup_items_rift_run_locked_spaces_loot", 1, loot_spawn.origin, loot_spawn.angles + (0, 90, 0), 1, 1);
  }
}

function function_95484dc1fa0e07fc() {
  var_4bd4a641e714664d = getStructArray("ob_locked_space_key", "targetname");

  foreach(key_spawn in var_4bd4a641e714664d) {
    itembundle = getscriptbundle("itemspawnentry:" + key_spawn.script_noteworthy);

    if(isDefined(itembundle)) {
      scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(itembundle, key_spawn.origin, key_spawn.angles, 1, 1);
    }
  }
}

function function_61cd13522a6c6045() {
  level flag_wait("ob_infil_completed");
  level flag_wait("drop_powerups");
  var_f6e2fa7c17f84498 = getStructArray("ob_locked_space_powerup", "targetname");
  offset = (0, 0, scripts\common\powerups::function_edeba0070ca0709e("drop_height_offset"));

  foreach(powerup_spawn in var_f6e2fa7c17f84498) {
    if(isDefined(powerup_spawn.script_noteworthy)) {
      level thread scripts\common\powerups::function_d4be622286a198(powerup_spawn.script_noteworthy, powerup_spawn.origin + offset, powerup_spawn.angles);
      waitframe();
    }
  }
}

function function_e6dfeb25a36940f3(infostruct) {
  if(!isDefined(self.doghouse_struct)) {
    return;
  }

  scripts\cp_mp\loot\common_item::function_cd45408bd44fab07("ob_jup_items_keys_rift_run_s1", 1, self.doghouse_struct.origin, undefined, 1, 1);
}

function function_a91a31131747f347(infostruct) {
  if(!isDefined(self.orb) || !isDefined(self.orb.var_f6f7b435e792fcd4)) {
    return;
  }

  scripts\cp_mp\loot\common_item::function_cd45408bd44fab07("ob_jup_items_keys_rift_run_s1", 1, self.orb.var_f6f7b435e792fcd4, undefined, undefined, 1);
}

function function_6036b23af9df84a3(infostruct) {
  if(!isDefined(self.var_779e11fc33f215f9)) {
    return;
  }

  scripts\cp_mp\loot\common_item::function_cd45408bd44fab07("ob_jup_items_keys_rift_run_s1", 1, self.var_779e11fc33f215f9.origin + anglestoup(self.var_779e11fc33f215f9.angles) * 10, undefined, undefined, 1);
}

function function_94d29d832035af94(params) {
  namespace_98c7625238714297::function_447c6ab4bea16b52("global", "REV_OB_DOGHOUSE", &namespace_f82e883a38a92b9a::function_58fb23fc08762d69, &namespace_a73abb0dcbe359ce::function_fd69cf02ba4d90a2);
  namespace_70aa82e7f409bc33::function_8b5b2a3392fc7e2a("ActivitySuccess", &function_e6dfeb25a36940f3, "REV_OB_DOGHOUSE");
  namespace_98c7625238714297::function_447c6ab4bea16b52("activity", "REV_OB_HARVESTERORB", &namespace_74c17ccb56a8563f::function_28cb7cb9dd6c20c2, &namespace_b86da4cec945c2::function_fd69cf02ba4d90a2);
  namespace_70aa82e7f409bc33::function_8b5b2a3392fc7e2a("ActivitySuccess", &function_a91a31131747f347, "REV_OB_HARVESTERORB");
  namespace_98c7625238714297::function_447c6ab4bea16b52("global", "REV_OB_TURRET_TRAP", &namespace_47d96238dd467828::function_3d88cdeba8222b15, &namespace_9607052b3c2afb1a::function_fd69cf02ba4d90a2);
  namespace_98c7625238714297::function_447c6ab4bea16b52("global", "REV_OB_AETHERTEAR", &namespace_5d8c3870222947b5::function_483ef1bf0c76bedc, &namespace_ab27c6145201fe44::function_fd69cf02ba4d90a2);
  namespace_98c7625238714297::function_447c6ab4bea16b52("activity", "REV_OB_AETHERNEST", &namespace_b45a9c6ad5a91687::function_cf070c7d20b69e36, &namespace_3cb017699ecfb3ae::function_fd69cf02ba4d90a2);
  namespace_70aa82e7f409bc33::function_8b5b2a3392fc7e2a("ActivitySuccess", &function_6036b23af9df84a3, "REV_OB_AETHERNEST");
}

function function_5d39bca170851543(params) {
  namespace_98c7625238714297::function_447c6ab4bea16b52("contract", "REV_OB_OUTLAST", &namespace_edd624734aa27359::function_42696fef39309a29, &namespace_75285dec588fecb6::function_fd69cf02ba4d90a2);
  namespace_98c7625238714297::function_447c6ab4bea16b52("contract", "REV_OB_ESCORT_ZOMBIES", &namespace_d38a1af3e02dea2f::function_de62bc27675c1bfc, &namespace_26d7ef0567e3c3d4::function_fd69cf02ba4d90a2);
  namespace_98c7625238714297::function_447c6ab4bea16b52("contract", "REV_OB_SABOTAGE", &namespace_ea045e2c848ddf3c::function_923e85d3bf0ec24b, &namespace_6410a814a444bcf4::function_fd69cf02ba4d90a2);
}

function function_dc150a1bb8f2dfde(params) {
  namespace_3d4b3a42272925::main();
  function_79eeaeaaa71ade27();

  if(getdvarint(@ "hash_73cfb77eb49c943", 0)) {
    level flag_set("begin_floater_movement");
    return;
  }

  function_8814bf1a3819a8de();
}

function function_79eeaeaaa71ade27() {
  var_f8bf483b77217871 = getStructArray("ob_floater", "targetname");

  foreach(var_5309b78f7ad7d3c4 in var_f8bf483b77217871) {
    if(isDefined(var_5309b78f7ad7d3c4.script_noteworthy)) {
      e_floater = spawn("script_model", var_5309b78f7ad7d3c4.origin);
      e_floater.angles = var_5309b78f7ad7d3c4.angles;
      e_floater.var_fafa04e766ba2e01 = e_floater.origin;
      e_floater.var_3527bee7b3a69a0f = e_floater.angles;
      e_floater.radius = int(default_to(var_5309b78f7ad7d3c4.radius, 200));
      e_floater setModel(var_5309b78f7ad7d3c4.script_noteworthy);
      e_floater thread function_25ec394f5469ed5b();
      e_floater thread function_18954968a63cc736();
      waitframe();
    }
  }
}

function function_25ec394f5469ed5b() {
  self endon("death");
  self endon("pause_floater");
  level endon("game_ended");
  level flag_wait("begin_floater_movement");

  if(self.origin != self.var_fafa04e766ba2e01) {
    self moveTo(self.var_fafa04e766ba2e01, 8, 3, 3);
    wait 8.2;
  }

  while(true) {
    n_move = randomfloatrange(50, 150);
    n_time = randomfloatrange(8, 11);
    self movez(n_move, n_time, 3, 3);
    wait n_time + 0.2;
    n_time = randomfloatrange(8, 11);
    self movez(n_move * -1, n_time, 3, 3);
    wait n_time + 0.2;
  }
}

function function_18954968a63cc736() {
  self endon("death");
  self endon("pause_floater");
  level endon("game_ended");
  level flag_wait("begin_floater_movement");
  wait randomfloatrange(2, 5);

  while(true) {
    n_rotate = randomfloatrange(10, 25);
    n_time = randomfloatrange(8, 11);

    if(utility::cointoss()) {
      n_rotate *= -1;
    }

    self rotateby((n_rotate, n_rotate, n_rotate), n_time);
    wait n_time + 0.2;
    n_time = randomfloatrange(8, 11);
    self rotateby((n_rotate, n_rotate, n_rotate) * -1, n_time);
    wait n_time + 0.2;
  }
}

function function_8814bf1a3819a8de() {
  level flag_wait("drop_powerups");
  var_f6e2fa7c17f84498 = getStructArray("ob_floater_powerup", "targetname");
  offset = scripts\common\powerups::function_edeba0070ca0709e("drop_height_offset");

  foreach(powerup_spawn in var_f6e2fa7c17f84498) {
    if(isDefined(powerup_spawn.script_noteworthy)) {
      var_7c5f128ad799ba66 = anglestoup(powerup_spawn.angles) * offset;
      level scripts\common\powerups::function_d4be622286a198(powerup_spawn.script_noteworthy, powerup_spawn.origin + var_7c5f128ad799ba66, powerup_spawn.angles);
      waitframe();
    }
  }

  level flag_set("begin_floater_movement");
}

function function_29ed201ad0740f4e(params) {
  namespace_dd16d65e824b8e9::function_f1e5805da192a1ef("walk", "ee", 99);
}