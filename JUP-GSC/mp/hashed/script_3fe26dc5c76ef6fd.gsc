/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3fe26dc5c76ef6fd.gsc
*************************************************/

#using script_100adcc1cc11d2fa;
#using script_1099060c8d7e015c;
#using script_16c63a7997e1925e;
#using script_249b0a9054ceb230;
#using script_24df7ce3375db729;
#using script_2afbecd35eb577a4;
#using script_2d400da2610fe542;
#using script_2d97f962290079c2;
#using script_3a753ae1e37c67ea;
#using script_3f9c618c4c35ed2;
#using script_3fe26dc5c76ef6fd;
#using script_41387eecc35b88bf;
#using script_4b420d99dc5faf0b;
#using script_4e6e58ab5d96c2b0;
#using script_4ebb51058f1954b2;
#using script_528320cb3630530d;
#using script_793f5fa29ca62c00;
#using script_7d3e27aa82b5d70b;
#using script_7e41e37180e554f;
#using script_c6b9e8fb3a7de37;
#using scripts\common\callbacks;
#using scripts\common\powerups;
#using scripts\common\utility;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\ob;
#using scripts\mp\maps\mp_jup_tower\mp_jup_tower_ob;
#namespace namespace_73708c3d842bf72e;

function function_2dcca6d862cc31d5(params) {
  utility::function_3677f2be30fdd581("jup_ob_fx", "jup_ob_rift_run_fx");
  self.rift_run = 1;
  difficulty = "normal";

  if(getdvarint(@ "hash_73cfb77eb49c943", 0)) {
    difficulty = "hard";
  }

  self dlog_recordplayerevent("dlog_event_ob_player_rift_run", ["started", 1, "difficulty", difficulty]);

  if(getdvarint(@ "hash_1feb217517503155", 0)) {
    scripts\mp\maps\mp_jup_tower\mp_jup_tower_ob::function_b60de1b748c7230f();
  }

  if(getdvarint(@ "ob_s5_rift_run", 0)) {
    thread function_b2082fcbe629a6f();
    thread function_a97f2a99c94cc22f();
  }
}

function private function_4dd5d69d550c0999() {
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
    scrambler forcenetfieldhighlod(1);
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
    return (distance2d(a_corners[0].origin, a_corners[1].origin) / 1.1);
  }
}

function function_1bf53eccbaaa61d3() {
  level._effect["PND_explosion_vfx"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_escort_destroyed_pulse.vfx");
  level.var_81a37cf6a3d42cfb = 0;
  thread function_4dd5d69d550c0999();
  thread namespace_b000de497fab9bf4::function_ccde446fe7425514();
  thread infil_music();
  level flag_wait("ai_spawn_director_initialized");
  namespace_22b8ba12655bf3f2::function_d589c49c4b9b50a0(&scripts\mp\gametypes\ob::function_91d032246bb24684);
  level.var_a3605064bf81a95c = 0;
  scripts\common\callbacks::add("ob_locked_space_unlocked", &function_c30596883f5589b7);
  thread namespace_f6368c72597c6d90::function_2a56c656879dbf63();
  thread function_9f909024d825be2c();
  thread function_550e38b033de778e();
  thread function_97d209693a217b2a();
  thread function_6cc40d3169958476();

  if(getdvarint(@ "hash_8d1e2f0ed9358a43", 0)) {
    if(getdvarint(@ "hash_73cfb77eb49c943", 0)) {
      namespace_a48a03691c42355c::function_d173c46fc772d2cb();
    }
  } else {
    namespace_a48a03691c42355c::function_d173c46fc772d2cb();
  }

  thread activate_beams();
  thread function_37a680e171e980b();
  thread function_d6be862ee76f002c();
  scripts\mp\maps\mp_jup_tower\mp_jup_tower_ob::function_2e656805e9a5c512();
  namespace_b000de497fab9bf4::function_a13799ae222a8b48("exit_portal");
  activity_common::function_8b5b2a3392fc7e2a("ActivityBegin", &_contract_started, "REV_OB_OUTLAST");
  activity_common::function_8b5b2a3392fc7e2a("ActivityBegin", &_contract_started, "REV_OB_ESCORT_ZOMBIES");
  activity_common::function_8b5b2a3392fc7e2a("ActivityBegin", &_contract_started, "REV_OB_ZOMBIE_CONTROL");
  activity_common::function_8b5b2a3392fc7e2a("ActivitySuccess", &_contract_complete, "REV_OB_OUTLAST");
  activity_common::function_8b5b2a3392fc7e2a("ActivitySuccess", &_contract_complete, "REV_OB_ESCORT_ZOMBIES");
  activity_common::function_8b5b2a3392fc7e2a("ActivitySuccess", &_contract_complete, "REV_OB_ZOMBIE_CONTROL");
  function_f881f5cb77a4ddb8();
  thread namespace_7380e30e250d5b2f::ob_ambient_zombie_waves_setup();

  childthread function_2476244023968f4b();

  function_3ca7c1eaca8ca4d();
  function_4f167fa913c22d5f();
  function_94cd831ae1709ca8();
  function_fa385a911a09e912();
  function_c2cf00669fdd0197();
  flag_set("oop_scattered_or_skipped_obj_oop_a");
  flag_set("oop_scattered_or_skipped_obj_oop_c");
  flag_wait("ob_infil_completed");
  function_285709c1872a4efa();
}

function function_f881f5cb77a4ddb8() {
  level flag_wait("ai_spawn_director_initialized");
  function_9b8829ab4092a7d7("ob_rift_run", 0);
  function_9b8829ab4092a7d7("ob_s5_rift_run", 1);
  function_9b8829ab4092a7d7("ob_rift_run_zombie_waves", 1);
  function_9b8829ab4092a7d7("ob_zombie_ambient", 0);
  setDvar(@ "hash_f1d095735ac37f33", 1);
  level thread function_906a7ed74b4bc73e();
  level notify("ai_spawn_director_ambient_setup_done");
  level flag_set("ai_spawn_director_ambient_setup_done");
}

function function_906a7ed74b4bc73e() {
  level utility::flag_wait("ob_infil_completed");
  encounters = function_46ded7ce925b0c64(1, 0);

  foreach(encounter in encounters) {
    data = function_9a39e23c3c52c2af(encounter);

    if(!isDefined(data)) {
      continue;
    }

    if(is_equal(data.encounterbundle, "ai_encounter:s5_rift_run_rooftop_ambient")) {
      scripts\cp_mp\agents\ai_spawn_director::function_9950e6e485bf5261(encounter, 0);
    }
  }
}

function function_285709c1872a4efa() {
  var_d9d4a6cb965a1c8e = getentitylessscriptablearray("scriptable_ob_redeploy_drone", "classname");

  if(isDefined(var_d9d4a6cb965a1c8e)) {
    foreach(redeploy_drone in var_d9d4a6cb965a1c8e) {
      redeploy_drone setscriptablepartstate("redeploy_drone", "unavailable");
    }
  }
}

function function_fa385a911a09e912() {
  var_d4f5b652e54c4b97 = getEntArray("mysterybox", "script_noteworthy");

  if(isDefined(var_d4f5b652e54c4b97)) {
    foreach(mysterybox in var_d4f5b652e54c4b97) {
      mysterybox setscriptablepartstate("beam", "off");
    }
  }
}

function function_c2cf00669fdd0197() {
  var_2aa3942b5cbb9ec6 = getStruct("zombie_setdressing_01", "script_noteworthy");
  var_2aa3932b5cbb9c93 = getStruct("zombie_setdressing_02", "script_noteworthy");
  var_2aa3922b5cbb9a60 = getStruct("zombie_setdressing_03", "script_noteworthy");

  if(isDefined(var_2aa3942b5cbb9ec6)) {
    var_1c750a613963f432 = spawnscriptable(var_2aa3942b5cbb9ec6.targetname, var_2aa3942b5cbb9ec6.origin, var_2aa3942b5cbb9ec6.angles);
    var_1c750a613963f432 setscriptablepartstate("base", "enabled");
  }

  if(isDefined(var_2aa3932b5cbb9c93)) {
    var_1c750a613963f432 = spawnscriptable(var_2aa3932b5cbb9c93.targetname, var_2aa3932b5cbb9c93.origin, var_2aa3932b5cbb9c93.angles);
    var_1c750a613963f432 setscriptablepartstate("base", "enabled");
  }

  if(isDefined(var_2aa3922b5cbb9a60)) {
    var_1c750a613963f432 = spawnscriptable(var_2aa3922b5cbb9a60.targetname, var_2aa3922b5cbb9a60.origin, var_2aa3922b5cbb9a60.angles);
    var_1c750a613963f432 setscriptablepartstate("base", "enabled");
  }
}

function function_61aea37385c298a9(params) {
  self endon("death_or_disconnect");
}

function function_37a680e171e980b(skip_setup) {
  level endon("game_ended");
  level flag::flag_wait("ob_infil_completed");
  level.extratime = 0;

  if(getdvarint(@ "hash_376091fb6ebcd20b", 0)) {
    return;
  }

  skip_setup = default_to(skip_setup, 0);

  if(!skip_setup) {
    level.var_b164efcf13fc79b8 = getStruct("ob_circle_start", "targetname");
    level.ring_radius = 5000;

    if(isDefined(level.players) && level.players.size > 0) {
      v_average = namespace_88d9f8b28d831818::function_19cc82eefa6754b5();
    } else {
      v_average = (0, 0, 0);
    }

    level.ob_circle = spawnbrcircle(v_average[0], v_average[1], 10000);
    level.ob_circle show();
    level.start_time = gettime();
    level.circle_duration = getdvarint(@ "hash_73cfb77eb49c943", 0) ? 900 : 1800;
    setomnvar("ui_hardpoint_timer", level.start_time + int(level.circle_duration * 1000));
    setomnvar("ui_br_circle_state", 5);
    level.var_eb1e1026f86571fd = 9;
    level.ob_circle thread namespace_88d9f8b28d831818::circledamagetick();
    level.var_afe0e659397387a7 = 33.3333 * 1;
    level.new_radius = 10000;
    level.alerted = 0;
    level.alert_time = 600;
    level.var_1ee97ececec31cf3 = 300;
  }

  while(true) {
    if(level.alerted == 0 && 1000 * (level.circle_duration - level.alert_time) < gettime() - level.start_time) {
      setomnvar("ui_br_circle_state", 9);
      level.alerted = 1;
    }

    if(1000 * (level.circle_duration - level.var_1ee97ececec31cf3) < gettime() - level.start_time) {
      level.new_radius -= level.var_afe0e659397387a7;
    }

    if(level.new_radius < 0) {
      v_average = namespace_88d9f8b28d831818::function_19cc82eefa6754b5();
      circle_move(v_average, 0);
      setomnvar("ui_br_circle_state", 4);
      thread namespace_88d9f8b28d831818::function_b6c284a8a98ae76f();
      return;
    }

    v_average = namespace_88d9f8b28d831818::function_19cc82eefa6754b5();

    if(flag("boss_circle_no_move")) {
      circle_move(level.var_b164efcf13fc79b8.origin, level.new_radius);
    } else {
      circle_move(v_average, level.new_radius);
    }

    wait 1;
  }
}

function circle_move(v_center, var_1cee67764fdc54de, f_movetime) {
  if(!isDefined(f_movetime)) {
    f_movetime = 1;
  }

  level.ob_circle brcirclemoveTo(v_center[0], v_center[1], var_1cee67764fdc54de, f_movetime);
}

function function_818349e75a7a365c() {
  flag_set("boss_circle_no_move");
  var_fdd945d04f056ba6 = 0;

  if(level.new_radius <= 0) {
    level notify("tower_boss_time_added");
    var_fdd945d04f056ba6 = 1;
  }

  level.var_b164efcf13fc79b8 = getStruct("ob_circle_boss", "targetname");
  level.ring_radius = 2000;
  level.new_radius = 10000;
  level.alerted = 0;
  level.alert_time = 60;
  level.var_1ee97ececec31cf3 = 60;
  level.var_afe0e659397387a7 = 8000 / level.var_1ee97ececec31cf3 * 1;
  circle_move(level.var_b164efcf13fc79b8.origin, level.new_radius, 0.05);

  if(1000 * (level.circle_duration - 900) < gettime() - level.start_time) {
    level.extratime += 900;
    setomnvar("ui_br_circle_state", 4);
    wait 1;
    level.circle_duration = 900;
    level.start_time = gettime();
    setomnvar("ui_hardpoint_timer", level.start_time + int(level.circle_duration * 1000));
    setomnvar("ui_br_circle_state", 5);

    if(var_fdd945d04f056ba6) {
      thread namespace_7380e30e250d5b2f::function_37a680e171e980b(1);
    }
  }

  var_836c63dfa3760ff = 2000 / 30;

  while(level.new_radius > 8000) {
    level.new_radius -= var_836c63dfa3760ff;
    wait 1;
  }
}

function _contract_started(var_b6d035b4e3489246) {
  self.var_17a2361aa0beabb2[0] notify("contract_started");
  var_e1ebfe00b575d6c6 = undefined;
  beams = getEntArray("contractbeam", "targetname");

  switch (self.type) {
    case #"hash_40d422a1ae5ecf0f":
      var_e1ebfe00b575d6c6 = "escort";
      break;
    case #"hash_17b1c4f2de901a59":
      var_e1ebfe00b575d6c6 = "outlast";
      thread function_16dbd4fb39684d89();
      break;
    case #"hash_427820bb3395e2bf":
      var_e1ebfe00b575d6c6 = "spore";
      break;
  }

  foreach(beam in beams) {
    if(beam.script_noteworthy == var_e1ebfe00b575d6c6) {
      beam setscriptablepartstate("beam", "off");
    }
  }
}

function _contract_complete(var_6f8af5eb76deac21) {}

function function_16dbd4fb39684d89() {
  self endon("activity_ended");
  self endon("instance_destroyed");
  level.var_fbb9f03952513155 = getStruct("s5rr_outlast_boss_encounter_spawn", "targetname");

  while(true) {
    if(isDefined(self.analysis_progress) && self.analysis_progress >= 50) {
      if(!istrue(self.var_d2b773de97960edb)) {
        self.var_d2b773de97960edb = 1;
        var_c53e564294d01961 = 2000;
        var_2e5d36dbe0e4cffd = self.pnd_device.origin;
        playFX(level._effect["PND_explosion_vfx"], var_2e5d36dbe0e4cffd);
        playsoundatpos(var_2e5d36dbe0e4cffd, "iw9_emp_blast");
        wait 0.25;
        var_81d7b361c6e05959 = getaiarrayinradius(var_2e5d36dbe0e4cffd, var_c53e564294d01961, "team_two_hundred");
        thread function_5f684837e5288b1e(var_2e5d36dbe0e4cffd, var_c53e564294d01961, var_81d7b361c6e05959);
        wait 2.5;
        var_17d6270e00b876fc = ai_spawn_director::spawn_request("ai_encounter:" + "s5_rift_run_outlast_boss", level.var_fbb9f03952513155.origin, level.var_fbb9f03952513155.radius, 1, 1);
        break;
      }
    }

    wait 0.1;
  }
}

function private function_5f684837e5288b1e(location, radius, zombies) {
  level endon("game_ended");
  waitframe();

  foreach(zombie in zombies) {
    if(isalive(zombie)) {
      zombie.marked_for_death = 1;
      zombie.nuked = 1;
      zombie.full_gib = 1;
      zombie.var_745cd904c1ec804c = 1;
      zombie kill();
    }
  }
}

function intro_vo() {
  level endon("game_ended");
  level utility::flag_wait("ob_infil_completed");
  scripts\cp_mp\overlord::playevent("rift_run_s1_arrive", level.players, 7);
}

function infil_music() {
  level waittill_any_2("match_start_real_countdown", "match_start_timer_skip");
  level thread namespace_b3f32c8cb80b8124::function_aadc1c81b3fd1dd2(level.players);
}

function activate_beams() {
  if(!getdvarint(@ "hash_73cfb77eb49c943", 0)) {
    beams = getscriptablearray("contractbeam", "targetname");

    foreach(beam in beams) {
      beam setscriptablepartstate("beam", "on");
    }
  }
}

function function_f86a7718dec2e17() {
  level._effect["mrpeeks_intro_glow"] = loadfx("vfx/s4/gamemode/vfx_alps_spotlight_glow_blue.vfx");
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

        if(s_contract.script_noteworthy == "OUTLAST_TOWER") {
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

    level scripts\common\callbacks::remove("ob_locked_space_unlocked", &function_c30596883f5589b7);
  }
}

function function_4afe89cc48518762() {
  self endon("death");
  level endon("game_ended");
  random_wait_time = randomfloatrange(2, 3);

  while(true) {
    if(self.origin[2] <= 400) {
      if(!self.obscured) {
        self.obscured = 1;
        self function_d493e7fe15e5eaf4("zombie_default_fog");
      }
    } else if(self.obscured) {
      self.obscured = 0;
      self function_d493e7fe15e5eaf4("zombie_default");
    }

    wait random_wait_time;
  }
}

function function_9d13ff1a109b9164(params) {
  function_61472c4f08246917(params);
  function_903fe1a080f35364(params);
}

function function_61472c4f08246917(params) {
  if(self.aicategory == "elite") {
    self._blackboard.var_2af8408672f2a570 = 250;
    self._blackboard.var_2ad5368672cc47ba = 300;
  }
}

function function_903fe1a080f35364(params) {
  if(!getdvarint(@ "hash_59607ab5ab54dddd", 0)) {
    return;
  }

  if(is_equal(self.basearchetype, "zombie_mimic")) {
    self.var_858ebdfa6952957a = 700;
    self.var_57f944bef3fa055f = 0.64;
  }
}

function function_d6be862ee76f002c() {
  level flag_wait("ob_infil_completed");
  var_3ba758145a58afe0 = getentitylessscriptablearray(undefined, undefined, undefined, undefined, "nexus_activity_joiner_phone");

  foreach(scriptable in var_3ba758145a58afe0) {
    if(scriptable getscriptablehaspart("nexus_activity_joiner_phone")) {
      scriptable setscriptablepartstate("nexus_activity_joiner_phone", "visible_rift_run");
      scripts\cp_mp\interaction::function_32645103f7520635(scriptable, &function_3b588416e348d52a);
    }
  }
}

function function_3b588416e348d52a(player) {
  self setscriptablepartstate("nexus_activity_joiner_phone", "hidden");
}

function function_97d209693a217b2a() {
  var_3f06b4ec56e5119 = getStructArray("ob_s5rr_extra_loot", "targetname");

  foreach(var_6540852fe2570bf0 in var_3f06b4ec56e5119) {
    scripts\cp_mp\loot\common_item::function_cd45408bd44fab07("ob_jup_items_rift_run_locked_spaces_loot", 1, var_6540852fe2570bf0.origin, var_6540852fe2570bf0.angles + (0, 90, 0), 1, 1);
  }
}

function function_9f909024d825be2c() {
  var_29a3db0499a2874 = getStructArray("ob_s5rr_locked_space_loot", "targetname");

  foreach(loot_spawn in var_29a3db0499a2874) {
    scripts\cp_mp\loot\common_item::function_cd45408bd44fab07("ob_jup_items_rift_run_locked_spaces_loot", 1, loot_spawn.origin, loot_spawn.angles + (0, 90, 0), 1, 1);
  }
}

function function_550e38b033de778e() {
  var_4bd4a641e714664d = getStructArray("ob_s5rr_locked_space_key", "targetname");

  foreach(key_spawn in var_4bd4a641e714664d) {
    itembundle = getscriptbundle("itemspawnentry:" + key_spawn.script_noteworthy);

    if(isDefined(itembundle)) {
      scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(itembundle, key_spawn.origin, key_spawn.angles, 1, 1);
    }
  }
}

function function_6cc40d3169958476() {
  level endon("game_ended");
  flag_wait("ob_infil_completed");

  while(!isDefined(level.lockedspaces)) {
    wait 1;
  }

  level.var_568aaaec752815f6 = [];

  foreach(lockedspace in level.lockedspaces) {
    if(!isDefined(lockedspace.lockeddoors)) {
      continue;
    }

    foreach(door in lockedspace.lockeddoors) {
      if(istrue(door.doubledoor)) {
        level.var_568aaaec752815f6 = array_add(level.var_568aaaec752815f6, door);
      }
    }
  }

  flag_set("flag_tower_double_doors_generated");
}

function function_a97f2a99c94cc22f() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  flag_wait("flag_tower_double_doors_generated");

  foreach(door in level.var_568aaaec752815f6) {
    door disablescriptableplayeruse(self);
  }
}

function function_7f47a9126611e1cf() {
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

function function_9e227a1ac851b251(infostruct) {
  if(!isDefined(self.doghouse_struct)) {
    return;
  }

  scripts\cp_mp\loot\common_item::function_cd45408bd44fab07("ob_jup_items_keys_rift_run_s1", 1, self.doghouse_struct.origin, undefined, 1, 1);
}

function function_215df93d95870ff1(infostruct) {
  if(!isDefined(self.orb) || !isDefined(self.orb.var_f6f7b435e792fcd4)) {
    return;
  }

  scripts\cp_mp\loot\common_item::function_cd45408bd44fab07("ob_jup_items_keys_rift_run_s1", 1, self.orb.var_f6f7b435e792fcd4, undefined, undefined, 1);
}

function function_686a27c8ff544305(infostruct) {
  if(!isDefined(self.var_779e11fc33f215f9)) {
    return;
  }

  scripts\cp_mp\loot\common_item::function_cd45408bd44fab07("ob_jup_items_keys_rift_run_s1", 1, self.var_779e11fc33f215f9.origin + anglestoup(self.var_779e11fc33f215f9.angles) * 10, undefined, undefined, 1);
}

function function_acc57f1e237afdd6(params) {
  namespace_98c7625238714297::function_447c6ab4bea16b52("global", "REV_OB_DOGHOUSE", &namespace_f82e883a38a92b9a::function_58fb23fc08762d69, &namespace_ba2dc23ab854879a::function_fd69cf02ba4d90a2);
  namespace_70aa82e7f409bc33::function_8b5b2a3392fc7e2a("ActivitySuccess", &function_9e227a1ac851b251, "REV_OB_DOGHOUSE");
  namespace_98c7625238714297::function_447c6ab4bea16b52("global", "REV_OB_TURRET_TRAP", &namespace_47d96238dd467828::function_3d88cdeba8222b15, &namespace_bdb6a4bf87613c0e::function_fd69cf02ba4d90a2);
}

function function_105fa8046007a4a7(params) {
  namespace_98c7625238714297::function_447c6ab4bea16b52("contract", "REV_OB_OUTLAST", &namespace_edd624734aa27359::function_42696fef39309a29, &namespace_d80e89e1aa523fea::function_fd69cf02ba4d90a2);
  namespace_98c7625238714297::function_447c6ab4bea16b52("contract", "REV_OB_ESCORT_ZOMBIES", &namespace_d38a1af3e02dea2f::function_de62bc27675c1bfc, &namespace_99431eda83c9e000::function_fd69cf02ba4d90a2);
  namespace_98c7625238714297::function_447c6ab4bea16b52("contract", "REV_OB_ZOMBIE_CONTROL", &namespace_73b1231d3d62b0eb::function_7105d76c89d3fea3, &namespace_44249a7b317e6c20::function_fd69cf02ba4d90a2);
}

function function_1120fe706b433694(params) {
  namespace_f75cb0ce97149ba9::main();
  function_79eeaeaaa71ade27();

  if(getdvarint(@ "hash_73cfb77eb49c943", 0)) {
    level flag_set("begin_floater_movement");
    return;
  }

  thread function_8814bf1a3819a8de();
}

function function_79eeaeaaa71ade27() {
  var_f8bf483b77217871 = getStructArray("ob_floater", "targetname");
  level.a_floaters = [];

  thread function_766051ffd48a45ca();

  foreach(var_5309b78f7ad7d3c4 in var_f8bf483b77217871) {
    if(isDefined(var_5309b78f7ad7d3c4.script_noteworthy)) {
      e_floater = spawn("script_model", var_5309b78f7ad7d3c4.origin);
      e_floater.angles = var_5309b78f7ad7d3c4.angles;
      e_floater.var_fafa04e766ba2e01 = e_floater.origin;
      e_floater.var_3527bee7b3a69a0f = e_floater.angles;
      e_floater forcenetfieldhighlod(1);
      e_floater setmoverantilagged(1);
      e_floater function_7126c9ace48ce815(1);
      e_floater.moverdoesnotkill = 1;
      e_floater.active_mover = 1;

      if(isDefined(var_5309b78f7ad7d3c4.script_radius)) {
        e_floater.script_radius = var_5309b78f7ad7d3c4.script_radius;
      }

      if(isDefined(var_5309b78f7ad7d3c4.script_angle_max)) {
        e_floater.script_angle_max = var_5309b78f7ad7d3c4.script_angle_max;
      }

      e_floater setModel(var_5309b78f7ad7d3c4.script_noteworthy);

      if(isDefined(var_5309b78f7ad7d3c4.target)) {
        var_b92871244fbb7c1 = getEnt(var_5309b78f7ad7d3c4.target, "targetname");

        if(isDefined(var_b92871244fbb7c1)) {
          var_b92871244fbb7c1 linkTo(e_floater);
          var_b92871244fbb7c1 forcenetfieldhighlod(1);
          var_b92871244fbb7c1 setmoverantilagged(1);
          var_b92871244fbb7c1.moverdoesnotkill = 1;
          var_b92871244fbb7c1.docked = 0;
          e_floater.clip = var_b92871244fbb7c1;
        }
      }

      e_floater thread function_25ec394f5469ed5b();
      e_floater thread function_18954968a63cc736();
      level.a_floaters = array_add(level.a_floaters, e_floater);
      waitframe();
    }
  }
}

function function_25ec394f5469ed5b(custom_endon_flag) {
  self endon("death");
  self endon("pause_floater");
  level endon("game_ended");
  custom_endon_flag = default_to(custom_endon_flag, "floater_custom_endon_flag");

  if(flag(custom_endon_flag)) {
    return;
  }

  level endon(custom_endon_flag);

  if(isDefined(self.script_radius) && self.script_radius == 0) {
    self.script_radius = 0.05;
  }

  level flag_wait("begin_floater_movement");

  if(self.origin != self.var_fafa04e766ba2e01) {
    self moveTo(self.var_fafa04e766ba2e01, 7, 3, 3);
    wait 8;
  }

  while(true) {
    if(!players_within_distance(2500)) {
      if(self.active_mover) {
        self forcenetfieldhighlod(0);
        self setmoverantilagged(0);

        if(isDefined(self.clip)) {
          self.clip forcenetfieldhighlod(0);
          self.clip setmoverantilagged(0);
        }

        if(isDefined(self.clips)) {
          foreach(car_clip in self.clips) {
            car_clip forcenetfieldhighlod(0);
            car_clip setmoverantilagged(0);
          }
        }
      }

      self.active_mover = 0;

      if(getdvarint(@ "hash_3a5d91a174d0fb7f", 0)) {
        level thread scripts\cp_mp\utility\debug_utility::drawsphere(self.origin, 200, 3, (1, 0, 0));
      }

      wait 3;
      continue;
    } else if(!self.active_mover) {
      self.active_mover = 1;
      self forcenetfieldhighlod(1);
      self setmoverantilagged(1);

      if(isDefined(self.clip)) {
        self.clip forcenetfieldhighlod(1);
        self.clip setmoverantilagged(1);
      }

      if(isDefined(self.clips)) {
        foreach(car_clip in self.clips) {
          car_clip forcenetfieldhighlod(1);
          car_clip setmoverantilagged(1);
        }
      }
    }

    if(isDefined(self.script_radius)) {
      n_move = randomfloatrange(self.script_radius * 0.334, self.script_radius);
    } else {
      n_move = randomfloatrange(50, 150);
    }

    n_time = randomfloatrange(7, 10);
    self movez(n_move, n_time, 3, 3);
    wait n_time + 1;
    n_time = randomfloatrange(7, 10);
    self movez(n_move * -1, n_time, 3, 3);
    wait n_time + 1;
  }
}

function function_18954968a63cc736(custom_endon_flag) {
  self endon("death");
  self endon("pause_floater");
  level endon("game_ended");
  custom_endon_flag = default_to(custom_endon_flag, "floater_custom_endon_flag");

  if(flag(custom_endon_flag)) {
    return;
  }

  level endon(custom_endon_flag);

  if(isDefined(self.script_angle_max) && self.script_angle_max == 0) {
    self.script_angle_max = 0.05;
  }

  level flag_wait("begin_floater_movement");
  wait randomfloatrange(2, 5);

  while(true) {
    if(!self.active_mover) {
      wait 3;
      continue;
    }

    if(isDefined(self.script_angle_max)) {
      n_rotate = randomfloatrange(self.script_angle_max * 0.334, self.script_angle_max);
    } else {
      n_rotate = randomfloatrange(5, 15);
    }

    n_time = randomfloatrange(7, 10);

    if(utility::cointoss()) {
      n_rotate *= -1;
    }

    self rotateby((n_rotate, n_rotate, n_rotate), n_time);
    wait n_time + 1;
    n_time = randomfloatrange(7, 10);
    self rotateby((n_rotate, n_rotate, n_rotate) * -1, n_time);
    wait n_time + 1;
  }
}

function function_8814bf1a3819a8de() {
  level flag_wait("drop_powerups");

  while(!isDefined(level.powerups_root) || !isDefined(level.powerups_root.powerup_vars) || !isDefined(level.powerups_root.powerup_vars["drop_height_offset"])) {
    wait 1;
  }

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

function players_within_distance(dist) {
  closest_player = getclosest(self.origin, level.players, dist);
  return isDefined(closest_player);
}

function function_766051ffd48a45ca() {
  if(!getdvarint(@ "hash_3a5d91a174d0fb7f", 0)) {
    return;
  }

  while(!isDefined(level.a_floaters)) {
    wait 1;
  }

  while(true) {
    active_floaters = 0;

    foreach(var_5309b78f7ad7d3c4 in level.a_floaters) {
      if(istrue(var_5309b78f7ad7d3c4.active_mover)) {
        active_floaters++;
      }
    }

    iprintlnbold("<dev string:x32>" + active_floaters);
    wait 1;
  }
}

function function_3ca7c1eaca8ca4d() {
  level.var_9bdc7aed9af0a5d4 = getStruct("s5rr_match_start_encounter_spawn", "targetname");

  if(!istrue(self.var_fd76d1923bb8c803)) {
    self.var_fd76d1923bb8c803 = 1;
    var_df26ef1a4bdb476f = ai_spawn_director::spawn_request("ai_encounter:" + "s5_rift_run_match_start", level.var_9bdc7aed9af0a5d4.origin, level.var_9bdc7aed9af0a5d4.radius, 0, 1);
    function_fc38783a3da0bc71(var_df26ef1a4bdb476f, 1);
    return;
  }

  wait 0.1;
}

function function_4f167fa913c22d5f() {
  level.var_aa61eff511d67c2e = getStruct("s5rr_escort_boss_encounter_spawn", "targetname");
  var_d408500459e4e386 = function_f159c10d5cf8f0b4("s5rr_escort_boss_encounter_trigger", "targetname");

  if(isarray(var_d408500459e4e386) && var_d408500459e4e386.size > 0) {
    foreach(var_4a822ab5e3f7c411 in var_d408500459e4e386) {
      thread function_1fb182dd280cd8a(var_d408500459e4e386[0]);
      break;
    }
  }
}

function function_1fb182dd280cd8a(var_4a822ab5e3f7c411) {
  level endon("game_ended");
  self endon("death");

  while(true) {
    var_4a822ab5e3f7c411 waittill("trigger", ent);

    if(isPlayer(ent)) {
      if(!istrue(self.var_10f8a48333511315)) {
        self.var_10f8a48333511315 = 1;
        var_c1f77bbfaeb5d0fd = ai_spawn_director::spawn_request("ai_encounter:" + "s5_rift_run_escort_boss", level.var_aa61eff511d67c2e.origin, level.var_aa61eff511d67c2e.radius, 0, 1);
        function_fc38783a3da0bc71(var_c1f77bbfaeb5d0fd, 1);
        break;
      }
    }

    wait 0.1;
  }
}

function function_94cd831ae1709ca8() {
  level.var_4afe965b997ab16f = getStruct("s5rr_outlast_encounter_spawn", "targetname");
  level.var_1309d4dcd226e8c9 = getStruct("s5rr_escort_encounter_spawn", "targetname");
  level.var_65a553350002cdb7 = getStruct("s5rr_sporecontrol_encounter_spawn", "targetname");
  var_a37d05ccf09214fb = function_f159c10d5cf8f0b4("s5rr_outlast_encounter_trigger", "targetname");
  var_c58f0171aee3aa3d = function_f159c10d5cf8f0b4("s5rr_escort_encounter_trigger", "targetname");
  var_3c4319304269f8f3 = function_f159c10d5cf8f0b4("s5rr_sporecontrol_encounter_trigger", "targetname");

  if(isarray(var_a37d05ccf09214fb) && var_a37d05ccf09214fb.size > 0) {
    foreach(outlast_encounter_trigger in var_a37d05ccf09214fb) {
      thread function_239e2507cceca751(var_a37d05ccf09214fb[0]);
      break;
    }
  }

  if(isarray(var_c58f0171aee3aa3d) && var_c58f0171aee3aa3d.size > 0) {
    foreach(escort_encounter_trigger in var_c58f0171aee3aa3d) {
      thread function_6c2bd45f5e066d83(var_c58f0171aee3aa3d[0]);
      break;
    }
  }

  if(isarray(var_3c4319304269f8f3) && var_3c4319304269f8f3.size > 0) {
    foreach(sporecontrol_encounter_trigger in var_3c4319304269f8f3) {
      thread function_63a5040c5afb5679(var_3c4319304269f8f3[0]);
      break;
    }
  }
}

function function_239e2507cceca751(outlast_encounter_trigger) {
  level endon("game_ended");
  self endon("death");

  while(true) {
    outlast_encounter_trigger waittill("trigger", ent);

    if(isPlayer(ent)) {
      if(!istrue(self.var_518e4c5e9bca442c)) {
        self.var_518e4c5e9bca442c = 1;
        var_7897c5673cbcbe40 = ai_spawn_director::spawn_request("ai_encounter:" + "s5_rift_run_outlast", level.var_4afe965b997ab16f.origin, level.var_4afe965b997ab16f.radius, 0, 1);
        function_fc38783a3da0bc71(var_7897c5673cbcbe40, 1);
        break;
      }
    }

    wait 0.1;
  }
}

function function_6c2bd45f5e066d83(escort_encounter_trigger) {
  level endon("game_ended");
  self endon("death");

  while(true) {
    escort_encounter_trigger waittill("trigger", ent);

    if(isPlayer(ent)) {
      if(!istrue(self.var_139b92f0eff06e6e)) {
        self.var_139b92f0eff06e6e = 1;
        var_5033bf896fb4400e = ai_spawn_director::spawn_request("ai_encounter:" + "s5_rift_run_escort", level.var_1309d4dcd226e8c9.origin, level.var_1309d4dcd226e8c9.radius, 0, 1);
        function_fc38783a3da0bc71(var_5033bf896fb4400e, 1);
        break;
      }
    }

    wait 0.1;
  }
}

function function_63a5040c5afb5679(sporecontrol_encounter_trigger) {
  level endon("game_ended");
  self endon("death");

  while(true) {
    sporecontrol_encounter_trigger waittill("trigger", ent);

    if(isPlayer(ent)) {
      if(!istrue(self.var_2faacf290160ef54)) {
        self.var_2faacf290160ef54 = 1;
        var_c3f62259e0902628 = ai_spawn_director::spawn_request("ai_encounter:" + "s5_rift_run_sporecontrol", level.var_65a553350002cdb7.origin, level.var_65a553350002cdb7.radius, 0, 1);
        function_fc38783a3da0bc71(var_c3f62259e0902628, 1);
        break;
      }
    }

    wait 0.1;
  }
}

function ob_ambient_zombie_waves_setup(difficulty) {
  level notify("ob_ambient_zombie_waves_setup");
  level endon("ob_ambient_zombie_waves_setup");
  level endon("game_ended");
  level endon("end_ambient_zombie_wave_spawn");
  level flag_wait("ob_infil_completed");
  level flag_wait("ai_spawn_director_ambient_setup_done");
  level flag_wait("ob_ambient_spawn_zombie_waves");
  circle_struct = getStruct("ob_circle_start", "targetname");

  if(isDefined(circle_struct) && !isDefined(level.var_c9f71ccc98610c37)) {
    level.var_c9f71ccc98610c37 = scripts\cp_mp\agents\ai_spawn_director::spawn_request("ai_encounter:s5_rift_run_ambient_zombie_waves", circle_struct.origin, circle_struct.radius, 1, 0, 0);
    scripts\cp_mp\agents\ai_spawn_director::function_e4a67fe4ddca7ed5(level.var_c9f71ccc98610c37, &function_b6ac8ea8edc4fd12);
    scripts\cp_mp\agents\ai_spawn_director::function_f0cc0f2e6e1d085e(level.var_c9f71ccc98610c37, &function_5b07f0df3762790f);
    scripts\cp_mp\agents\ai_spawn_director::function_f81b7c3f18ef98be(level.var_c9f71ccc98610c37, &function_8894dff666d97dd4);
    function_adcc96a7d541aa36(level.var_c9f71ccc98610c37, 0);

    if(!isDefined(difficulty)) {
      difficulty = "normal";

      if(getdvarint(@ "hash_73cfb77eb49c943", 0)) {
        difficulty = "hard";
      }
    }

    function_c27c2d10a4d56c3c(difficulty);
  }
}

function function_c27c2d10a4d56c3c(difficulty) {
  if(isDefined(difficulty)) {
    switch (difficulty) {
      case #"hash_84fcf5e68d7230b2":
      case #"hash_9cecba889d9c8a92":
      default:
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
    }
  }
}

function function_bdeae19c34b2be71() {
  if(isDefined(level.var_c9f71ccc98610c37)) {
    function_9950e6e485bf5261(level.var_c9f71ccc98610c37, 0);
  }
}

function function_9a38b0d80b42e271() {
  level endon("game_ended");
  level waittill("ee_boss_tear_used");
  function_bdeae19c34b2be71();
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
      foreach(weakpoint in level.var_85a85964b56787d8) {}
    }
  }

  function_a39e9894083f4513(requestid);
}

function function_8894dff666d97dd4(requestid, userdata, var_9f82bb66fd374ef5) {
  requestdata = function_9a39e23c3c52c2af(requestid);

  if(isDefined(var_9f82bb66fd374ef5) && isDefined(requestdata)) {
    startindex = requestdata.ai.size - var_9f82bb66fd374ef5;
    var_e2a261a9687c87f0 = [];
    aitypes = [];
    currentwave = requestdata.var_a0e7c1e4fa26235e + 1;

    for(i = startindex; i < requestdata.ai.size; i++) {
      if(isDefined(requestdata.ai[i])) {
        aitype = requestdata.ai[i].subclass;

        if(!isDefined(var_e2a261a9687c87f0[aitype])) {
          aitypes[aitypes.size] = aitype;
          var_e2a261a9687c87f0[aitype] = 0;
        }

        var_e2a261a9687c87f0[aitype]++;
      }
    }

    if(!isDefined(level.var_c45e3dbe3f74f8bc)) {
      level.var_c45e3dbe3f74f8bc = spawnStruct();
    }

    level.var_c45e3dbe3f74f8bc.currentwave = currentwave;
    level.var_c45e3dbe3f74f8bc.aitypes = aitypes;
    level.var_c45e3dbe3f74f8bc.var_e2a261a9687c87f0 = var_e2a261a9687c87f0;
  }
}

function function_b2082fcbe629a6f() {
  level endon("game_ended");
  level endon("ob_ambient_spawn_zombie_waves");
  self endon("death");
  self endon("disconnect");

  if(istrue(level.var_cd6e6c63b5805c8e)) {
    return;
  }

  flag_wait("ob_infil_completed");
  filtered_volumes = function_f159c10d5cf8f0b4("s5rr_starting_platform_trigger", "targetname");

  if(filtered_volumes.size > 0) {
    while(self istouching(filtered_volumes[0])) {
      wait 8;
    }
  }

  level flag_set("ob_ambient_spawn_zombie_waves");
  level.var_cd6e6c63b5805c8e = 1;
  level notify("ob_ambient_spawn_zombie_waves");
}

function function_6c9dbd2f5d5a6f02(msg) {
  if(!isDefined(level.var_e2216b22d5983e18)) {
    level.var_e2216b22d5983e18 = 0;
  }

  x = 10;
  y = 550;
  y += level.var_e2216b22d5983e18 * 15;
  printtoscreen2d(x, y, msg, (1, 1, 1), 1.25);
  level.var_e2216b22d5983e18++;
}

function function_f561c59516243308() {
  level.var_e2216b22d5983e18 = 0;
}

function function_2476244023968f4b() {
  level notify("<dev string:x3f>");
  level endon("<dev string:x3f>");
  level endon("<dev string:x60>");
  level endon("<dev string:x6e>");
  self endon("<dev string:x8f>");
  self endon("<dev string:x9d>");

  if(!getdvarint(@ "hash_adeb1a5eaaee08ad", 0)) {
    return;
  }

  while(true) {
    waitframe();

    if(!isDefined(level.var_c45e3dbe3f74f8bc)) {
      function_6c9dbd2f5d5a6f02("<dev string:xa6>");
      function_6c9dbd2f5d5a6f02("<dev string:xb8>");
    } else {
      function_6c9dbd2f5d5a6f02("<dev string:xa6>");
      function_6c9dbd2f5d5a6f02("<dev string:xcb>" + level.var_c45e3dbe3f74f8bc.currentwave);

      foreach(aitype in level.var_c45e3dbe3f74f8bc.aitypes) {
        function_6c9dbd2f5d5a6f02("<dev string:xdc>");
        function_6c9dbd2f5d5a6f02("<dev string:xe2>" + aitype + "<dev string:xf0>");
        function_6c9dbd2f5d5a6f02("<dev string:xf5>" + level.var_c45e3dbe3f74f8bc.var_e2a261a9687c87f0[aitype]);
      }
    }

    function_f561c59516243308();
  }
}

# /