/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_takedown_af_hill.gsc
***********************************************/

#using script_2d443451ce681a;
#using script_31e9b35aaacbbd93;
#using script_35ae72be7b4fec10;
#using script_37f9ff47f340fbe8;
#using script_3dc93ca9902a9cda;
#using script_61cfc2ab8e60625;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp\cp_takedown_af_chase;
#using scripts\cp\cp_takedown_fx;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snipercam;
#using scripts\cp_common\util;
#using scripts\weapons\cp\spy_camera;
#namespace tkdn_af_hill;

function starting(var_d3440450) {
  function_a2015343(var_d3440450);
  plane = namespace_b100dd86::function_5431431d();
  namespace_b100dd86::function_c8381339(plane, 0);
  exploder::stop_exploder("airfield_assault_lighting_noplane");
  exploder::exploder("airfield_assault_lighting");
  namespace_b100dd86::function_5aabc3fb();
  exploder::exploder("hit3_prop_mist");
  player = getplayers()[0];
  player cp_takedown_fx::function_c8bc54e4();
  exploder::activate_radiant_exploder("airfield_intro_lights");
  thread namespace_a052577e::function_a42cfb58();
  plane_flyover = vehicle::simple_spawn_and_drive("plane_flyover");
  level thread scene::play_from_time("scene_tkd_hit3_intro", "shot 1", undefined, 1, 1, 1, 0, 0);
}

function main(var_d3440450, var_50cc0d4f) {
  if(!isDefined(level objectives::function_285e460("af_follow_adler", level.adler))) {
    level objectives::follow("af_follow_adler", level.adler, undefined, 0, 0);
  }

  hidden = [];
  hidden[# "prone"] = 50;
  hidden[# "crouch"] = 200;
  hidden[# "stand"] = 400;
  spotted = [];
  spotted[# "prone"] = 200;
  spotted[# "crouch"] = 400;
  spotted[# "stand"] = 800;
  namespace_979752dc::set_detect_ranges(hidden, spotted);
  setDvar(#"hash_62b11f12963c68d4", 1200);
  thread function_61f33d07();
  util::function_3e65fe0b(1);
  guys = namespace_b100dd86::array_spawn("af_intro_enemies", "script_noteworthy");
  level thread scene::play("scene_tkd_hit3_intro_overlook_adler", [level.adler]);
  level thread scene::play("scene_tkd_hit3_intro_overlook_woods", [level.woods]);
  level thread scene::play("scene_tkd_hit3_intro_overlook", "initial_loop");
  level thread scene::play("scene_tkd_hit3_intro_overlook_enemy4", "initial_loop");
  level thread function_5dd4ff85();
  thread function_f7c7ce51();
  player = getplayers()[0];
  level.player = player;
  player endon(#"death");
  level.chase_truck = getvehiclearray("af_chase_veh", "targetname")[0];
  level.chase_truck val::set(#"chase_truck", "allowdeath", 0);
  thread function_cc465a2(player);
  level.player val::set(#"overlook", "ignoreme", 1);
  level.adler val::set(#"overlook", "ignoreme", 1);
  setDvar(#"hash_76c0d7e6385ee6de", 0.05);
  level.adler ai::set_behavior_attribute("demeanor", "cqb");
  level.woods ai::set_behavior_attribute("demeanor", "cqb");
  array::thread_all(guys, &namespace_979752dc::function_2324f175, 0);
  level flag::wait_till("af_start_overlook_scene");
  level flag::wait_till_all_timeout(8, ["af_woods_at_overlook", "af_adler_at_overlook"]);
  thread function_76b7bfa7();
  clips = getEntArray("plane_floor_clip", "targetname");

  foreach(clip in clips) {
    clip disconnectpaths(0, 1);
  }

  level music::setmusicstate("b2.0_recon", undefined, 6);
  snd::client_msg("snd_overlook_scene");
  waitframe(1);
  level.player val::reset(#"overlook", "ignoreme");
  player waittill(#"camera_up");
  level.af_plane sethighdetail(1);
  level.arash sethighdetail(1);
  af_enemy4 = getaiarray("af_enemy4", "targetname")[0];
  af_enemy4 sethighdetail(1);
  level notify(#"hash_186d95ebb54fca9f");
  level thread scene::play("scene_tkd_hit3_intro_overlook_arash", "overlook_shot", [level.arash]);
  level thread scene::play("scene_tkd_hit3_intro_overlook_adler", "overlook_shot", [level.woods, level.adler]);
  level thread scene::play("scene_tkd_hit3_intro_overlook", "overlook_shot");
  level thread util::delay("play_b3.0_iced_mus", undefined, &music::function_edda155f, "b3.0_iced");
  level thread util::delay("play_b3.0_iced_mus", undefined, &music::setmusicstate, "b4.0_hold_fire");
  level thread util::delay("play_b4.1_identify_mus", undefined, &music::function_edda155f, "b4.1_identify");
  level waittill(#"start_sniping", #"hash_380fe6172e5e75ed");
  level flag::set("start_sniping");
  snd::client_msg("start_sniping");
  thread function_4bc0b384(player);
  thread function_7a77e3be(player);
  thread function_84d4429e(player);
  res = player waittilltimeout(10, #"end_binocs", #"weapon_change", #"weapon_fired");

  if(res._notify != # "timeout") {
    if(res._notify != # "weapon_fired") {
      res = player waittilltimeout(10, #"weapon_fired");
    }
  }

  level flag::set("end_binocs");
  player notify(#"end_binocs");

  if(res._notify != # "timeout") {
    level music::setmusicstate("none");
    level music::function_edda155f("b4.2_shot");
    var_7810080a = level.arash waittilltimeout(0.5, #"hash_ae39942308147bf", #"damage");
  }

  level notify(#"hash_1a8ccb31e7a09c0e");
  level.arash val::set("hack", "takedamage", 0);
  player val::reset(#"overlook", "disable_weapon_cycling");
  level music::setmusicstate("b5.0_battle");
  util::delay(0.1, undefined, &function_31afa2db);

  if(level flag::get("perfect_sniper_spot") && isDefined(var_7810080a) && var_7810080a._notify == "damage") {
    function_32398bfb(player);
    thread function_4f024edb();
  } else if(isDefined(var_7810080a) && var_7810080a._notify == # "hash_ae39942308147bf") {
    level thread scene::play("scene_tkd_hit3_intro_overlook_arash", "hit", [level.arash]);
    level thread scene::play("scene_tkd_hit3_intro_overlook_enemy4", "hit");
    level.arash waittill(#"hash_3d799b8c342663fa");
    level thread scene::play("scene_tkd_hit3_intro_overlook_arash", "hit_impact", [level.arash]);
    level thread scene::play("scene_tkd_hit3_intro_overlook_enemy4", "hit_impact");
    snd::client_msg(#"hash_1797695d0ca67ad8");
    level.arash waittill(#"hash_377b8997737880e7");
    level flag::set("arash_in_plane");
    thread function_4f024edb();
  } else {
    af_enemy4 sethighdetail(0);
    level notify(#"hash_36f87644d590f542");
    level thread scene::play("scene_tkd_hit3_intro_overlook_arash", "hit_impact", [level.arash]);
    level thread scene::play("scene_tkd_hit3_intro_overlook_enemy4", "miss");
    thread function_4f024edb();
  }

  level.af_plane sethighdetail(0);
  util::function_3e65fe0b(0);
  thread function_254c9ae();
  thread tkdn_af_chase::function_9d8f5cd3();
  waitframe(1);
  savegame::function_7790f03(1);
  level flag::wait_till_any(["overlook_guys_done", "woods_to_truck"]);

  if(!level flag::get("player_break_stealth_fired")) {
    level flag::set("af_hill_complete");
  } else {
    level flag::wait_till("forever");
  }

  level flag::wait_till("arash_in_plane");

  if(isDefined(var_50cc0d4f)) {
    skipto::function_4e3ab877(var_50cc0d4f);
  }
}

function function_84d4429e(player) {
  level waittill(#"player_break_stealth_tarmac");
  player notify(#"weapon_fired");
}

function function_4f024edb() {
  level.af_enemy2 stopanimscripted();
  af_enemy3 = getaiarray("af_enemy3", "targetname")[0];

  if(isalive(af_enemy3)) {
    af_enemy3 stopanimscripted();
    af_enemy3 thread scene::play("scene_tkd_hit3_intro_overlook_guy3", "react_shot", [af_enemy3]);
  }

  level scene::play("scene_tkd_hit3_intro_overlook", "hit", [level.af_enemy2]);
  af_enemy4 = getaiarray("af_enemy4", "targetname")[0];
  function_9967d19b(af_enemy4);
}

function function_ca9dd78b() {
  level endon(#"hash_1a8ccb31e7a09c0e");

  while(true) {
    level flag::wait_till_clear("perfect_sniper_spot");
    level.arash snipercam::set_enabled(1, 1, 2);
    level flag::wait_till("perfect_sniper_spot");
    level.arash snipercam::set_enabled(0, 1, 2);
  }
}

function function_32398bfb(player) {
  guy = getaiarray("af_enemy4", "targetname")[0];
  guy stopanimscripted();
  level.arash stopanimscripted();
  player.var_35ee6252 = undefined;
  setslowmotion(1, 0.5, 0);
  player_org = player.origin;
  var_cac40761 = player.angles;
  var_ca71a1c8 = "black";
  thread namespace_61e6d095::function_28027c42(#"hash_4fe4ea6c5e05ffb7");
  exploder::exploder("airfield_sniper_bullet_light");
  level thread scene::play("scene_tkd_hit3_intro_overlook_bullet_cam", "fancy_bulletcam", [level.arash]);
  snd::client_msg(#"hash_1533b6e574c5cfe7");
  level waittill(#"hash_387a7c439d244e6b");
  screenshake(player_org, 0.2, 2, 0, 0.33, 0, -1, 0, 12.5, 40, 0, 4);
  exploder::stop_exploder("airfield_sniper_bullet_light");
  level waittill(#"hash_57e0731c62f19ce1");
  setslowmotion(0.5, 1, 0.4);
  level waittill(#"hash_43ffc7bf753fe848");
  level thread lui::screen_fade_out(0, "black");
  level util::delay(0.005, undefined, &lui::screen_fade_in, 0, "black");
  player stopanimscripted(0, 1);
  level flag::set("arash_in_plane");
  snd::client_msg(#"hash_3620fe1626778dde");
  waitframe(1);
  player setorigin(player_org);
  player setplayerangles(var_cac40761);
  namespace_61e6d095::function_4279fd02(#"hash_4fe4ea6c5e05ffb7");
  waitframe(1);
}

function function_c8a35cef() {
  setDvar(#"hash_252e699c41531f1a", 2);
  setDvar(#"r_motionblurstrength", 1);
  setDvar(#"hash_1e892dbf6ecb7caa", 0);
}

function function_b0d8b75() {
  setDvar(#"hash_252e699c41531f1a", -1);
  setDvar(#"r_motionblurstrength", 0.2);
  setDvar(#"hash_1e892dbf6ecb7caa", 0.75);
}

function function_5dd4ff85() {
  level waittill(#"hash_59132013626fbab6");
  level thread scene::play("scene_tkd_hit3_intro_overlook_enemy4", "overlook_shot");
}

function function_31afa2db() {
  primary_weapon = getweapon(#"ar_standard_t9");

  if(level.player hasweapon(primary_weapon)) {
    level.player switchtoweaponimmediate(primary_weapon, 1);
  } else {
    weaps = level.player getweaponslistprimaries();
    level.player switchtoweaponimmediate(weaps[0], 1);
  }

  level.player setmovespeedscale(1);
}

function function_254c9ae() {
  level flag::set("keep_going");
  level.player val::reset(#"overlook", "ignoreme");
  level.adler thread function_b432f86a("adler_tarmac_combat");
  level.woods thread function_b432f86a("woods_tarmac_combat");
  level scene::play("scene_tkd_hit3_intro_overlook_adler", "hit", [level.woods, level.adler]);
  waitframe(1);
  trigger::use("approach_airstrip", "targetname", undefined, 0);
  level flag::set("overlook_guys_done");
}

function function_b432f86a(nodename) {
  if(self == level.woods) {
    level endon(#"woods_to_truck");
  }

  self flag::wait_till_clear(#"scriptedanim");
  self stopanimscripted();
  self val::reset(#"overlook", "ignoreme");
  self val::reset(#"radiant", "ignoreall");
  self val::reset(#"airfield", "ignoreall");
  self ai::set_goal(nodename, "targetname", 1);
}

function function_7a77e3be(player) {
  player thread util::show_hint_text(#"hash_1e0dbfcb374f641c", 0, "end_binocs", -1);

  while(true) {
    if(player weaponswitchbuttonPressed() || player buttonbitstate("BUTTON_BIT_ANY_WEAP_CHANGE")) {
      level flag::set("end_binocs");
      player notify(#"end_binocs");
      break;
    }

    waitframe(1);
  }
}

function function_4bc0b384(player) {
  player waittill(#"end_binocs");
  player val::reset(#"overlook", "disable_weapon_cycling");
  sniper = getweapon(#"sniper_quickscope_t9");
  player seteverhadweaponall(1);
  player initialweaponraise(sniper);
  player switchtoweapon(sniper);
  waitframe(1);
  player takeweapon(level.var_42db149f);
}

function function_ef1d8a47() {
  plane = getent("cargo_plane", "targetname");

  while(plane != undefined) {
    org = plane gettagorigin("tag_origin");

    print3d(org, "<dev string:x38>", (1, 1, 1), 1, 0.25);

    wait 0.05;
  }
}

function cleanup(name, starting, direct, player) {
  level flag::set("end_binocs");
  level.chase_truck = getvehiclearray("af_chase_veh", "targetname")[0];
  level.chase_truck val::set(#"chase_truck", "allowdeath", 0);
}

function init_flags() {
  level flag::init("af_hill_complete");
  level flag::init("af_fade_in_complete");
}

function init_clientfields() {
  clientfield::register("world", "fake_snipercam_slomo", 1, 1, "int");
}

function function_22b7fffd() {
  scene::add_scene_func("scene_tkd_hit3_intro_overlook", &function_2fc20b49, "initial_loop");
  scene::add_scene_func("scene_tkd_hit3_intro_overlook", &function_309e4828, "overlook_shot");
  scene::add_scene_func("scene_tkd_hit3_intro_overlook", &function_9b3565b1, "overlook_shot");
  scene::add_scene_func("scene_tkd_hit3_intro_overlook_enemy4", &function_f0cab8f5, "overlook_shot");
}

function function_2fc20b49(a_ents) {
  thread function_94c3f34a(#"hash_2f5bf3e976fdd8ee", a_ents);
  thread function_94c3f34a(#"hash_f4e2cb35f1a71a6", a_ents);
}

function function_309e4828(a_ents) {
  if(isDefined(a_ents[# "driver"])) {
    a_ents[# "driver"] val::set(#"hash_48aa53f40d892719", "ignoreme", 1);
  }

  if(isDefined(a_ents[# "bell"])) {
    a_ents[# "bell"] val::set(#"hash_48aa53f40d892719", "ignoreme", 1);
  }
}

function function_f0cab8f5(a_ents) {
  level.var_2124e12b = a_ents[# "hash_f4e2bb35f1a6ff3"];

  if(isDefined(a_ents[# "af_enemy4"])) {
    guy = a_ents[# "af_enemy4"];
  }
}

function function_9b3565b1(a_ents) {
  level endon(#"hash_1a8ccb31e7a09c0e");
  level waittill(#"hash_4d3bb4cb42226cd8");
  level.af_enemy2 = a_ents[# "af_enemy2"];
  thread scene::play("scene_tkd_hit3_intro_overlook_guy2", "overlook_shot_part2", [level.af_enemy2, level.var_2124e12b]);
}

function function_94c3f34a(name, ents) {
  if(isDefined(ents[name])) {
    thing = ents[name];
    thing waittill(#"hash_1e6fd05dff685aca");
    thing linkto(level.af_plane, "tag_body_animate");
  }
}

function function_78bc26d5() {
  self vehicle::lights_on();
  self vehicle::toggle_force_driver_taillights(1);
}

function function_f7c7ce51() {
  level.arash = ai::array_spawn("arash")[0];
  level.arash namespace_979752dc::function_2324f175(0);
}

function function_dd77a447() {
  level endoncallback(&function_8c38a6f0, #"car_arrive");
  player = getplayers()[0];
  player util::show_hint_text(#"hash_a9076dcaa02f4e", 0, "camera_up", -1);
  waitframe(1);
  player notifyonplayercommand("binoculars", "+actionslot 4");
  player waittill(#"binoculars");
  player notifyonplayercommandremove("binoculars", "+actionslot 4");
  waitframe(1);
  player notify(#"camera_up");
  waitframe(1);
  player giveweapon(level.var_42db149f);
  var_796f04ff = level.var_42db149f;
  thread function_ca9dd78b();
  level.var_9febe810 = player getcurrentweapon();
  player switchtoweapon(var_796f04ff);
  player val::set(#"overlook", "disable_weapon_cycling", 1);

  while(player getcurrentweapon().name != "eq_binoculars" || !player adsButtonPressed()) {
    waitframe(1);
  }

  wait 2;
  thread function_d75e55a1(struct::get("cargo_bay_lookat", "targetname"), "vox_cp_tdwn_07100_adlr_anysignofarash_3c", 6);
  thread function_8c011eca();
  wait 7;
  guys = getEntArray("af_intro_enemies", "script_noteworthy", 1);
  lines = ["vox_cp_tdwn_07100_adlr_thatsnothim_fc", "vox_cp_tdwn_07100_adlr_nope_c0", "vox_cp_tdwn_07100_adlr_justaguard_88"];
  thread function_d75e55a1(guys, lines);
}

function private function_8c38a6f0(parms) {
  getplayers()[0] notifyonplayercommandremove("binoculars", "+actionslot 4");
}

function function_76b7bfa7() {
  level flag::wait_till("af_start_overlook_scene");
  level.adler thread dialogue::queue("vox_cp_tdwn_07100_adlr_masoncheckitout_eb");
  thread function_dd77a447();
}

function function_8c011eca() {
  level endon(#"hash_5663f4acce350395");
  targ = getent("car_look_point", "targetname");
  level waittill(#"hash_5a1f3e30c78ae9a2");
  thread function_d75e55a1(targ, "looked_at_car", 15);
  level waittill(#"hash_3130ba431262d090");

  if(!level flag::get("looked_at_car")) {
    level.adler dialogue::queue("vox_cp_tdwn_07100_adlr_geteyesonitmaso_68");
  }
}

function function_9f929cf3() {
  level flag::wait_till_any(["af_player_get_in_back", "af_player_get_in_left", "af_player_get_in_right"]);
  self vehicle::lights_off();
  self vehicle::toggle_force_driver_taillights(0);
}

function function_d75e55a1(targets, lines, fov = 2, var_dc8ec980 = 5) {
  level endon(#"player_break_stealth_fired");
  level endon(#"player_break_stealth_tarmac");
  level endon(#"car_arrive");

  if(!isarray(targets)) {
    targets = [targets];
  }

  if(!isarray(lines)) {
    lines = [lines];
  }

  i = 0;
  player = getplayers()[0];

  while(!isDefined(player.spy_camera)) {
    waitframe(1);
  }

  var_dd9a54cd = cos(fov);

  while(i < lines.size) {
    while(player getcurrentweapon().name != "eq_binoculars" || !player adsButtonPressed()) {
      waitframe(1);
    }

    var_32a7c3bf = undefined;

    while(!isDefined(var_32a7c3bf)) {
      eye_pos = player getplayercamerapos();
      eye_angles = player getplayerangles();
      eye_dir = anglesToForward(eye_angles);

      foreach(targ in targets) {
        if(!is_true(targ.var_181d1cf5) && targ function_e779ff3c(player, eye_pos, eye_angles, var_dd9a54cd, eye_dir, fov)) {
          var_32a7c3bf = targ;
          break;
        }
      }

      waitframe(1);
    }

    var_32a7c3bf.var_181d1cf5 = 1;

    if(soundexists(lines[i])) {
      level.adler dialogue::queue(lines[i]);
    } else {
      level flag::set(lines[i]);
    }

    wait var_dc8ec980;
    i++;
  }
}

function function_e779ff3c(player, eye_pos, eye_angles, var_dd9a54cd, eye_dir, fov) {
  level endon(#"car_arrive");
  self endon(#"death");
  target_pos = self.origin + (0, 0, 30);

  if(eye_angles getcurrentweapon().name != "eq_binoculars" || !eye_angles adsButtonPressed()) {
    return false;
  }

  if(util::within_fov(var_dd9a54cd, eye_dir, target_pos, fov)) {
    return true;
  }

  return false;
}

function function_b12fabe5(player) {
  player endon(#"death");

  while(true) {
    result = player waittill(#"weapon_fired");

    if(level flag::get("end_binocs")) {
      level flag::set("player_fired_at_arash");
      break;
    }

    if(result.weapon !== level.var_42db149f) {
      level flag::set("player_break_stealth_fired");
      break;
    }
  }
}

function function_9967d19b(var_5077b72a) {
  guys = getaiarray("af_intro_enemies", "script_noteworthy");
  guys = array::exclude(guys, level.arash);

  if(isDefined(var_5077b72a)) {
    guys = array::exclude(guys, var_5077b72a);
  }

  array::thread_all(guys, &function_f1f9011d);
}

function function_f1f9011d() {
  self endon(#"death");
  player = getplayers()[0];

  if(self flag::get("no_interrupt")) {
    self flag::wait_till_clear("no_interrupt");
  }

  self stopanimscripted();
  self function_a3fcf9e0("attack", player, player.origin);
  self ai::set_behavior_attribute("demeanor", "combat");
  self val::set(#"failed", "ignoreall", 0);
  self val::set(#"failed", "ignoreme", 0);
  waitframe(1);
  self stopanimscripted();
}

function function_cc465a2(player) {
  level endon(#"af_hill_complete");
  level endon(#"hash_1a8ccb31e7a09c0e");
  thread function_b12fabe5(player);
  ret = level flag::wait_till_any(["player_break_stealth_fired", "player_break_stealth_tarmac", "stealth_spotted"]);
  snd::client_msg(#"hash_1e58e46360c0a83b");

  if(ret._notify == "stealth_spotted" && level flag::get("player_fired_at_arash")) {
    return;
  }

  if(ret._notify == # "player_break_stealth_tarmac" && level flag::get("start_sniping")) {
    return;
  }

  wait 0.2;
  level.woods thread dialogue::queue("vox_cp_tdwn_07200_wood_masonno_1d");
  level scene::stop("scene_tkd_hit3_intro_overlook");
  level scene::stop("scene_tkd_hit3_intro_overlook_adler");
  function_9967d19b();
  wait 3;
  level util::missionfailedwrapper(#"hash_307e01d87701c37");
  level.player notifyonplayercommandremove("blow_rc_car", "+attack");
}

function function_a2015343(var_d3440450) {
  spawners = getspawnerarray("af_adler", "targetname");
  level.adler = spawners[0] spawner::spawn(1);
  level.adler val::set(#"airfield", "ignoreall", 1);
  level thread util::magic_bullet_shield(level.adler);
  a_ar = getweapon(#"ar_accurate_t9");
  level.adler hms_util::function_65d14a19(a_ar);
  spawners = getspawnerarray("af_woods", "targetname");
  level.woods = spawners[0] spawner::spawn(1);
  level.woods val::set(#"airfield", "ignoreall", 1);
  level.woods util::magic_bullet_shield(level.woods);
  a_ar = getweapon("ar_accurate_t9");
  level.woods hms_util::function_65d14a19(a_ar);
  level.adler.forcegoal = 1;
  level.adler.fixednode = 1;
  level.adler.radius = 50;
  level.adler.enableterrainik = 1;
  level.woods.forcegoal = 1;
  level.woods.fixednode = 1;
  level.woods.radius = 50;
  level.woods.enableterrainik = 1;

  if(isDefined(var_d3440450)) {
    start_spots = struct::get_array(var_d3440450 + "_start", "targetname");

    foreach(spot in start_spots) {
      if(spot.script_noteworthy == "adler") {
        level.adler forceteleport(spot.origin, spot.angles);
      }

      if(spot.script_noteworthy == "woods") {
        level.woods forceteleport(spot.origin, spot.angles);
      }
    }
  }
}

function function_61f33d07() {
  car = vehicle::simple_spawn("airport_truck_approach")[0];
  targ = getent("car_look_point", "targetname");
  targ linkto(car, "tag_origin", (0, 0, 50));
  level waittill(#"hash_186d95ebb54fca9f");
  car vehicle::lights_on();
  car vehicle::toggle_force_driver_taillights(1);
  level waittill(#"hash_f1a37977643f3f0");
  car vehicle::lights_off();
  exploder::exploder("airfield_assault_arash_car_lights");
  playFXOnTag("vehicle/fx9_light_ru_truck_light_head_source", car, "tag_fx_headlight_right");
  playFXOnTag("vehicle/fx9_light_ru_truck_light_head_source", car, "tag_fx_headlight_left");
  light = getent("light_head_arash_truck_r", "targetname");

  if(isDefined(light)) {
    light linkto(car, "tag_fx_headlight_right", (-0.5, 0, 0), (15, 0, 0));
  }

  light = getent("light_head_arash_truck_l", "targetname");

  if(isDefined(light)) {
    light linkto(car, "tag_fx_headlight_left", (-0.5, 0, 0), (15, 0, 0));
  }
}