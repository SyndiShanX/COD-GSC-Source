/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3b037cef6d23090b.gsc
*************************************************/

#using script_100adcc1cc11d2fa;
#using script_10c0558c277bd286;
#using script_11451148597ea1fb;
#using script_118c3165d7948d8b;
#using script_143ad6d9c2b4c721;
#using script_1c2de7c18b07b05c;
#using script_249b0a9054ceb230;
#using script_29b50ff5f1477a5d;
#using script_2d400da2610fe542;
#using script_2e177f1d7a5b9456;
#using script_3129b02e8d9d3650;
#using script_35832c8f24f352a6;
#using script_3dd78271adfa603d;
#using script_3f9c618c4c35ed2;
#using script_41387eecc35b88bf;
#using script_4469d6c09568a93e;
#using script_462db6a275eae8d8;
#using script_4a113d5cd94995bb;
#using script_4e6e58ab5d96c2b0;
#using script_538e86ab07059e0b;
#using script_5bd9dcc961d899b2;
#using script_5d02d8723d456015;
#using script_609bf2ebee0114b7;
#using script_793f5fa29ca62c00;
#using script_7d3e27aa82b5d70b;
#using script_7e41e37180e554f;
#using script_7e681eb8fbdc4f5e;
#using script_7edf952f8921aa6b;
#using script_9b15bb9518db222;
#using script_bee418c8d4a317c;
#using script_c6b9e8fb3a7de37;
#using scripts\common\callbacks;
#using scripts\common\powerups;
#using scripts\common\utility;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\overlord;
#using scripts\engine\utility;
#using scripts\mp\gametypes\ob;
#namespace namespace_e3cd258123bea07c;

function function_2dcca6d862cc31d5(params) {
  utility::function_3677f2be30fdd581("jup_ob_fx", "jup_ob_rift_run_fx");
  namespace_9866a4bced571f95::function_6ec786f1f9fa181f(self);
  self.rift_run = 1;
  difficulty = "normal";

  if(getdvarint(@ "hash_73cfb77eb49c943", 0)) {
    difficulty = "hard";
  }

  self dlog_recordplayerevent("dlog_event_ob_player_rift_run", ["started", 1, "difficulty", difficulty]);
  level thread ob_ambient_zombie_waves_setup(difficulty);
}

function infil_music() {
  level waittill_any_2("match_start_real_countdown", "match_start_timer_skip");
  level thread namespace_b3f32c8cb80b8124::function_aadc1c81b3fd1dd2(level.players);

  foreach(player in level.players) {
    player clearsoundsubmix("jup_ob_prematch", 2);
  }
}

function function_88d1cace9dd87631() {
  thread namespace_b000de497fab9bf4::function_ccde446fe7425514();
  level flag_wait("ai_spawn_director_initialized");
  namespace_22b8ba12655bf3f2::function_d589c49c4b9b50a0(&scripts\mp\gametypes\ob::function_91d032246bb24684);
  level.var_a3605064bf81a95c = 0;
  scripts\common\callbacks::add("ob_locked_space_unlocked", &function_c30596883f5589b7);
  thread namespace_f6368c72597c6d90::function_2a56c656879dbf63();
  thread function_aeffb58fd21fde6();
  thread function_5d906cfe90e803f8();
  thread function_e51a7059f5a08979();
  thread function_f86a7718dec2e17();
  thread intro_vo();
  thread namespace_88d9f8b28d831818::function_ecd079f7925cc275();
  thread function_d6be862ee76f002c();
  namespace_b000de497fab9bf4::function_a13799ae222a8b48("exit_portal");

  if(!getdvarint(@ "hash_ddb4d91aab18be79", 0)) {
    thread function_8b8e4dc85fba34ca();
  }

  level.var_e345b15591192b73 = 0;
}

function get_perk_machines() {
  level flag::flag_wait("ob_infil_completed");
  var_3c3122af5c02bd7 = getStructArray("content_struct", "variantname");
  a_spawn_points = [];

  if(!isDefined(level.var_b49b509b2d9ca1b6)) {
    level.var_b49b509b2d9ca1b6 = [];
  }

  if(!isDefined(level.var_b49b509b2d9ca1b6)) {
    level.var_b49b509b2d9ca1b6 = [];
  }

  foreach(struct in var_3c3122af5c02bd7) {
    if(isDefined(struct.content_key) && struct.content_key == "perk_machine_region_spawn") {
      a_spawn_points = array_add(a_spawn_points, struct);
    }
  }

  foreach(machine in a_spawn_points) {
    if(isDefined(machine.script_currency)) {
      level.var_b49b509b2d9ca1b6[level.var_b49b509b2d9ca1b6.size] = machine;
      a_spawn_points = array_remove(a_spawn_points, machine);
    }
  }

  level.var_9ec1877bce168538 = a_spawn_points;
}

function function_61aea37385c298a9(params) {
  self endon("death_or_disconnect");
  scripts\cp_mp\overlord::playevent("s2_rr_portal_exit", [self], 0.5);
}

function function_83d43ec21f04f972(relevantinfostruct) {
  if(isDefined(level.var_e345b15591192b73)) {
    level.var_e345b15591192b73++;
  }

  if(randomint(100) < 40) {
    level endon("game_ended");
    scripts\cp_mp\overlord::playevent("s2_rr_success", level.players, 4.5);
  }
}

function function_8b8e4dc85fba34ca() {
  level endon("disconnect");
  level endon("game_ended");
  get_perk_machines();
  var_2dd917debee8cd1 = 4;
  var_90defe985e778197 = 3;
  var_4a17182d2923b0af = 75;

  for(i = 0; i < var_2dd917debee8cd1; i++) {
    if(istrue(level.var_9ec1877bce168538.size > 0)) {
      if(percent_chance(var_4a17182d2923b0af)) {
        level.var_9ec1877bce168538 = array_randomize(level.var_9ec1877bce168538);
        namespace_9669c43b34f7a964::function_431bcc26c1ddfa0e(level.var_9ec1877bce168538[0]);
        level.var_9ec1877bce168538[0] = undefined;
        level.var_9ec1877bce168538 = array_removeundefined(level.var_9ec1877bce168538);
      }
    }
  }
}

function intro_vo() {
  level endon("game_ended");
  level utility::flag_wait("ob_infil_completed");
  scripts\cp_mp\overlord::playevent("s2_rr_arrive", level.players, 2);
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

        if(s_contract.script_noteworthy == "OUTLAST_SIRA") {
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
        if(isalive(ai)) {
          ai namespace_dd16d65e824b8e9::function_f1e5805da192a1ef("walk", "walker_ee", 99);
          var_f032fbbe85ac8203 = 1;
        }
      }

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
  level flag_wait("rift_contracts_setup");
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

function function_aeffb58fd21fde6() {
  var_29a3db0499a2874 = array_randomize(getStructArray("ob_locked_space_loot", "targetname"));

  foreach(loot_spawn in var_29a3db0499a2874) {
    scripts\cp_mp\loot\common_item::function_cd45408bd44fab07("ob_jup_items_rift_run_locked_spaces_loot", 1, loot_spawn.origin, loot_spawn.angles + (0, 90, 0), 1, 1);
  }
}

function function_5d906cfe90e803f8() {
  var_4bd4a641e714664d = getStructArray("ob_locked_space_key", "targetname");

  foreach(key_spawn in var_4bd4a641e714664d) {
    itembundle = getscriptbundle("itemspawnentry:" + key_spawn.script_noteworthy);

    if(isDefined(itembundle)) {
      scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(itembundle, key_spawn.origin, key_spawn.angles, 1, 1);
    }
  }
}

function function_e51a7059f5a08979() {
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

function function_9699376ba1b63be0(params) {
  namespace_98c7625238714297::function_447c6ab4bea16b52("global", "REV_OB_AETHERTEAR", &namespace_5d8c3870222947b5::function_483ef1bf0c76bedc, &namespace_42a5ee9cd7bde0c::function_fd69cf02ba4d90a2);
  namespace_98c7625238714297::function_447c6ab4bea16b52("global", "REV_OB_TURRET_TRAP", &namespace_47d96238dd467828::function_3d88cdeba8222b15, &namespace_d5588bc70d7254d2::function_fd69cf02ba4d90a2);
  namespace_98c7625238714297::function_447c6ab4bea16b52("activity", "REV_OB_AETHERNEST", &namespace_b45a9c6ad5a91687::function_cf070c7d20b69e36, &namespace_6cb1f7e723b3d806::function_fd69cf02ba4d90a2);
  namespace_98c7625238714297::function_447c6ab4bea16b52("global", "REV_OB_DOGHOUSE", &namespace_f82e883a38a92b9a::function_58fb23fc08762d69, &namespace_5a3652d54134c056::function_fd69cf02ba4d90a2);
  namespace_98c7625238714297::function_447c6ab4bea16b52("activity", "REV_OB_HARVESTERORB", &namespace_74c17ccb56a8563f::function_28cb7cb9dd6c20c2, &namespace_12c3c25237b02a9a::function_fd69cf02ba4d90a2);
  namespace_98c7625238714297::function_447c6ab4bea16b52("startup", "REV_OB_ZOMBIE_STRONGHOLD", &namespace_f8638ef0be82c4bd::function_1cf627178cf6bee, &namespace_76ad7cb87360f921::function_fd69cf02ba4d90a2);
  namespace_5f5dcf804b7dd2bc::main();
  namespace_bd43c0a67aaafe9e::main();
}

function function_c39c32c2d636eac0(params) {
  namespace_98c7625238714297::function_447c6ab4bea16b52("global", "REV_OB_AETHERTEAR", &namespace_5d8c3870222947b5::function_483ef1bf0c76bedc, &namespace_42a5ee9cd7bde0c::function_fd69cf02ba4d90a2);
  namespace_98c7625238714297::function_447c6ab4bea16b52("global", "REV_OB_TURRET_TRAP", &namespace_47d96238dd467828::function_3d88cdeba8222b15, &namespace_d5588bc70d7254d2::function_fd69cf02ba4d90a2);
  namespace_5f5dcf804b7dd2bc::main();
  namespace_bd43c0a67aaafe9e::main();
}

function function_8590c1ef54dc93cf(params) {
  namespace_98c7625238714297::function_447c6ab4bea16b52("contract", "REV_OB_BIGBOUNTY", &namespace_1b69156531898c9d::function_d745018e64b6b902, &namespace_fc6e6dfba50ded41::function_fd69cf02ba4d90a2);
  namespace_70aa82e7f409bc33::function_8b5b2a3392fc7e2a("ActivitySuccess", &function_83d43ec21f04f972, "REV_OB_BIGBOUNTY");
  namespace_98c7625238714297::function_447c6ab4bea16b52("contract", "REV_OB_OUTLAST", &namespace_edd624734aa27359::function_42696fef39309a29, &namespace_132af1548678fcbe::function_fd69cf02ba4d90a2, ["OUTLAST_S2_5_MISSION_STADIUM"]);
  namespace_70aa82e7f409bc33::function_8b5b2a3392fc7e2a("ActivitySuccess", &function_83d43ec21f04f972, "REV_OB_OUTLAST");
  namespace_98c7625238714297::function_447c6ab4bea16b52("contract", "REV_OB_SABOTAGE", &namespace_ea045e2c848ddf3c::function_923e85d3bf0ec24b, &namespace_d37a374d1497bd7c::function_fd69cf02ba4d90a2);
  namespace_70aa82e7f409bc33::function_8b5b2a3392fc7e2a("ActivitySuccess", &function_83d43ec21f04f972, "REV_OB_SABOTAGE");
  level flag_set("rift_contracts_setup");
}

function function_8f4bf0e19a5adf56(params) {
  namespace_5d55c039a3139c2d::main();
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

function ob_ambient_zombie_waves_setup(difficulty) {
  level endon("game_ended");
  level endon("end_ambient_zombie_wave_spawn");
  level flag_wait("ob_infil_completed");
  level flag_wait("ai_spawn_director_ambient_setup_done");
  wait getdvarint(@ "hash_8734ed2381b42dcc", 30);
  circle_struct = getStruct("ob_circle_start", "targetname");

  if(isDefined(circle_struct) && !isDefined(level.var_c9f71ccc98610c37)) {
    level.var_c9f71ccc98610c37 = scripts\cp_mp\agents\ai_spawn_director::spawn_request("ai_encounter:enc_ob_s25_sira_rift_run_ambient_zombie_waves", circle_struct.origin, circle_struct.radius, 1, 0, 0);
    ai_spawn_director::function_e4a67fe4ddca7ed5(level.var_c9f71ccc98610c37, &function_b6ac8ea8edc4fd12);
    ai_spawn_director::function_f0cc0f2e6e1d085e(level.var_c9f71ccc98610c37, &function_5b07f0df3762790f);
    level thread function_9a38b0d80b42e271();
    function_c27c2d10a4d56c3c(difficulty);
  }
}

function function_b6ac8ea8edc4fd12(requestid, instance, agent, ai_data) {
  circle_struct = getStruct("ob_circle_start", "targetname");

  if(isDefined(circle_struct)) {
    agent function_65cdab0fc78aba8f(circle_struct.origin, circle_struct.radius);
    return;
  }

  agent function_65cdab0fc78aba8f(agent.origin, getdvarint(@ "hash_436fc10ebca82d41", 2048));
}

function function_5b07f0df3762790f(requestid, userdata) {
  requestinfo = function_9a39e23c3c52c2af(requestid);

  if(isDefined(requestinfo.var_a0e7c1e4fa26235e)) {
    if(isDefined(level.var_85a85964b56787d8)) {
      foreach(weakpoint in level.var_85a85964b56787d8) {
        weakpoint setscriptablepartstate("wave_spawn", "wave_anim");
      }
    }
  }

  function_a39e9894083f4513(requestid);
}

function function_c27c2d10a4d56c3c(difficulty) {
  if(isDefined(difficulty)) {
    switch (difficulty) {
      case #"hash_84fcf5e68d7230b2":
      case #"hash_9cecba889d9c8a92":
        if(isDefined(level.var_c9f71ccc98610c37)) {
          function_d37068aac7785c04(level.var_c9f71ccc98610c37, "ob_rift_run_normal", 1);
          function_d37068aac7785c04(level.var_c9f71ccc98610c37, "ob_rift_run_hard", 0);
        }

        break;
      case #"hash_2cf581a0a28b81c":
      case #"hash_cc9157548a55043c":
        if(isDefined(level.var_c9f71ccc98610c37)) {
          function_d37068aac7785c04(level.var_c9f71ccc98610c37, "ob_rift_run_normal", 0);
          function_d37068aac7785c04(level.var_c9f71ccc98610c37, "ob_rift_run_hard", 1);
        }

        break;
      default:
        break;
    }
  }
}

function function_bdeae19c34b2be71() {
  if(isDefined(level.var_c9f71ccc98610c37)) {
    function_9950e6e485bf5261(level.var_c9f71ccc98610c37, 0);
  }
}

function function_9a38b0d80b42e271() {
  level waittill("heart_destroyed");
  function_bdeae19c34b2be71();
}