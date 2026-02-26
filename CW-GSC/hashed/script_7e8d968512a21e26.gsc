/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7e8d968512a21e26.gsc
***********************************************/

#using script_3b7c3b99b28b21b7;
#using script_3c70d86dfe255354;
#using script_3dc93ca9902a9cda;
#using script_6f92dbd09c4e8204;
#using script_758226507b1afa11;
#using script_86ebb5dd573a003;
#using script_bd3bf54a93a5a3b;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flashlight;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\threat_sight;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\teleport_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#namespace namespace_3aaa42f7;

function init_flags() {
  level flag::init("start_berlin_wall_lighting");
  level flag::init("manhole_guards_dead");
  level flag::init("ghost_station_done");
  level flag::init("ghost_station_exit_done");
  level flag::init("player_put_hands_down");
}

function start(var_1c513c79) {
  util::function_268bdf4f("adler", &namespace_11998b8f::function_2f0f0a84);
  level thread scene::skipto_end("p9_fxanim_cp_stakeout_subway_door_breach_bundle");
  level thread scene::play("aib_vign_stakeout_ghost_station_guard_station_adler", "ladder_wait");
  level flag::set("flag_adler_at_ladder");
}

function main(str_objective, var_50cc0d4f) {
  level endon(#"mission_failed");
  player = getplayers()[0];
  player endon(#"death");

  if(var_50cc0d4f) {
    namespace_5ceacc03::music("2.0_tracks");
    player setmovespeedscale(0.72);
    level namespace_979752dc::function_2324f175(0);
    level thread namespace_a613430e::function_a6dfa615(1);
    level thread namespace_a613430e::function_b3b12f9a(1);
    level thread namespace_11998b8f::function_81fce913();
  }

  player namespace_979752dc::set_disguised(1);
  setDvar(#"hash_71717d5ec94ac60", 650);
  setDvar(#"hash_22565811a3cacb35", 750);
  level thread function_cd2bffd4();
  function_bb36c113();
  scene::add_scene_func("aib_vign_stakeout_wall_gl", &namespace_acaa3a2e::function_a23963d2, "init");
  level scene::init("aib_vign_stakeout_wall_gl");
  level flag::set("ghost_station_done");
  level flag::set("start_berlin_wall_lighting");
  level.adler.var_ce38a488 = undefined;
  level.adler val::set("ghost_station_exit", "ignoreme", 1);
  level.adler val::set("ghost_station_exit", "ignoreall", 1);
  level.adler ai::set_behavior_attribute("demeanor", "cqb");
  player val::set("ghost_station_exit", "show_weapon_hud", 0);
  player allowcrouch(0);
  player allowprone(0);
  player setstance("stand");
  level thread function_8931e2a4();
  level thread function_7d2c6c13();
  level flag::wait_till("manhole_guards_dead");
  player allowcrouch(1);
  player allowprone(1);
  player util::blend_movespeedscale(0.72, 1);
  snd::play("amb_thunder_rumble");
  level flag::wait_till("ghost_station_exit_done");
  namespace_979752dc::function_740dbf99();
  skipto::function_4e3ab877("ghost_station_exit");
}

function cleanup(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  if(isDefined(level.var_91ee8248) && level.var_91ee8248.size > 0) {
    foreach(guy in level.var_91ee8248) {
      if(isDefined(guy)) {
        guy delete();
      }
    }
  }
}

function function_cd2bffd4() {
  if(level flag::get("flag_sewer_exit_ladder")) {
    return;
  }

  level flag::wait_till_all(array("flag_adler_at_ladder", "ladder_vo_player"));
  var_38d138fb = [];
  var_38d138fb[var_38d138fb.size] = "vox_cp_stkt_03070_adlr_taketheladder_a0";
  level.adler thread namespace_11998b8f::function_ec76072d(10, var_38d138fb, 25, "flag_sewer_exit_ladder");
}

function function_bb36c113() {
  scene::add_scene_func("cin_stakeout_wall_sewer", &function_78a49053, "init");
  scene::add_scene_func("cin_stakeout_wall_sewer", &function_ffe1ec0d, "sewer_exit");
  scene::add_scene_func("cin_stakeout_wall_sewer", &function_5010c6ad, "player_sewer_kill");
  scene::add_scene_func("cin_stakeout_wall_sewer", &function_5010c6ad, "sewer_kill");
  player = getplayers()[0];
  clientfield::set("force_stream_sewer_exit", 1);
  player forcestreambundle("cin_stakeout_wall_sewer");
  level scene::init("cin_stakeout_wall_sewer");
  var_27e33204 = struct::get("ghost_station_open_manhole_anim_org");
  var_27e33204 util::create_cursor_hint(undefined, (0, 0, -8), #"hash_24b92cc9c8f3144e");
  var_27e33204 waittill(#"trigger");
  var_27e33204 util::remove_cursor_hint();
  level thread namespace_5ceacc03::function_b2633ff9();
  level flag::set("climbed_out_of_sewer");
  level scene::stop("aib_vign_stakeout_ghost_station_guard_station_adler");
}

function function_78a49053(a_ents) {
  level.var_7f69cef1 = a_ents[#"hash_475ee55621b83ca0"];
  ghost_station_exit_sewer_cover = getent("ghost_station_exit_sewer_cover", "targetname");
  ghost_station_exit_sewer_cover linkto(level.var_7f69cef1, "j_prop_1", (0, 0, 0), (0, 0, 0));
  level.var_7f69cef1 ghost();
}

function function_ffe1ec0d(a_ents) {
  level.var_85b94361 = util::spawn_model(#"weapon_wm_m1911_composite", level.adler.origin);
  level.var_85b94361 hidepart("j_mag2", "weapon_wm_m1911_composite");
  level.var_85b94361 linkto(a_ents[#"hash_7e7c435b4c0eec16"], "j_prop_2", (0, 0, 0), (0, 0, 0));
  level.var_657b5876 = a_ents[#"hash_7e7c435b4c0eec16"];
  level.var_4c0e9fb8 = util::spawn_model(#"com_flashlight_on_xforward", level.adler.origin);
  level.var_4c0e9fb8 linkto(a_ents[#"hash_7e7c435b4c0eec16"], "j_prop_1", (0, 0, 0), (0, 0, 0));
  level.var_4c0e9fb8 thread function_c439c1a(a_ents[#"hash_7e7c435b4c0eec16"]);
  level.var_527ee575 = util::spawn_model(#"weapon_vm_ar_akilo47_brprop", level.adler.origin);
  level.var_527ee575 linkto(a_ents[#"hash_7e7c435b4c0eec16"], "j_prop_3", (0, 0, 0), (0, 0, 0));
  level.var_8d300d6a = a_ents[#"enemy1"];
  level.var_aff752f8 = a_ents[#"enemy2"];
  level.var_8d300d6a battlechatter::function_2ab9360b(0);
  level.var_8d300d6a.var_5b22d53 = 0;
  level.var_8d300d6a.var_c681e4c1 = 1;
  level.var_aff752f8 battlechatter::function_2ab9360b(0);
  level.var_aff752f8.var_c681e4c1 = 1;
  level.player endon(#"death");
  level.var_aff752f8 waittill(#"death");
  level flag::set("manhole_guards_dead");
  level thread function_d438a0a5();

  if(isDefined(level.var_8d300d6a)) {
    level.var_8d300d6a val::set("sewer_exit", "ignoreall", 1);
  }

  level flag::wait_till("move_wall_allies_01a");

  if(isDefined(level.var_8d300d6a)) {
    level.var_8d300d6a delete();
  }
}

function function_d438a0a5() {
  level flag::wait_till("player_not_on_sewer");
  getent("sewer_cover_clip", "targetname") delete();
}

function function_5010c6ad(a_ents) {
  waitframe(1);

  if(isDefined(a_ents[#"hash_7e7c435b4c0eec16"])) {
    if(isDefined(level.var_85b94361)) {
      level.var_85b94361 linkto(a_ents[#"hash_7e7c435b4c0eec16"], "j_prop_2", (0, 0, 0), (0, 0, 0));
    }

    level.var_4c0e9fb8 linkto(a_ents[#"hash_7e7c435b4c0eec16"], "j_prop_1", (0, 0, 0), (0, 0, 0));
    level.var_527ee575 linkto(a_ents[#"hash_7e7c435b4c0eec16"], "j_prop_3", (0, 0, 0), (0, 0, 0));
  }
}

function function_1ac3c612(var_243d9caf, str_tag) {
  if(!isDefined(str_tag)) {
    str_tag = "<dev string:x38>";
  }

  self endon(#"death");
  level endon(#"manhole_guards_dead");

  while(true) {
    var_a272d6b0 = var_243d9caf gettagorigin(str_tag);
    print3d(self.origin, function_9e72a96(self.model), (1, 0, 0), 1, 0.5);
    circle(self.origin, 30, (1, 0, 0));
    print3d(var_a272d6b0, function_9e72a96(str_tag), (0, 1, 0), 1, 0.5);
    circle(var_a272d6b0, 15, (0, 1, 0));
    line(var_a272d6b0, self.origin, (1, 1, 0));
    waitframe(1);
  }
}

function function_c439c1a(var_b3ea46c) {
  self endon(#"death");
  self.flashlightfxoverridetag = "tag_light";
  self setModel(#"com_flashlight_on_xforward_off");
  self clientfield::set("sewer_exit_flashlight_fx", 1);
  var_b3ea46c waittill(#"hash_747ad1efcb8b89d9");
  self clientfield::set("sewer_exit_flashlight_fx", 0);
  wait 0.1;
  self clientfield::set("sewer_exit_flashlight_fx", 1);
  var_b3ea46c waittill(#"hash_5873836b3d218a02", #"hash_bafe4ef8ff3636a");
  self clientfield::set("sewer_exit_flashlight_fx", 0);
  wait 0.1;
  self clientfield::set("sewer_exit_flashlight_fx", 1);
  wait 0.4;
  self clientfield::set("sewer_exit_flashlight_fx", 0);
  wait 0.1;
  self clientfield::set("sewer_exit_flashlight_fx", 1);
  wait 0.2;
  self clientfield::set("sewer_exit_flashlight_fx", 0);
  wait 0.1;
  self clientfield::set("sewer_exit_flashlight_fx", 1);
  wait 0.1;
  self clientfield::set("sewer_exit_flashlight_fx", 0);
}

function function_6d74acf3() {
  var_bd1c473f = getweapon(#"hash_5dbab0bd6a78c6e5");
  self giveweapon(var_bd1c473f);
  self switchtoweaponimmediate(var_bd1c473f);
  self disableweaponcycling();
  level.player.takedown.disabled = 1;
  self val::set("ghost_station_exit", "allow_melee", 0);
}

function function_8931e2a4() {
  level endon(#"save_restore");
  player = getplayers()[0];
  player endon(#"death");
  player util::blend_movespeedscale(0.33, 0.1);
  player util::delay(1.5, undefined, &function_6d74acf3);
  level.adler setModel(#"hash_623250ac982bd24e");
  level.adler endon(#"death");
  level thread namespace_5ceacc03::function_c7ac1381();
  namespace_5ceacc03::music("3.0_combat_stinger");
  level thread scene::play("cin_stakeout_wall_sewer", "sewer_exit");
  player thread function_1bc1ba1b();
  waitframe(1);
  level.var_aff752f8.skipscenedeath = 1;
  level.var_aff752f8 thread function_eaa6ba4b();
  level.var_aff752f8 thread function_e64b290f();
  level.var_aff752f8 thread function_32025022(level.adler, level.var_8d300d6a);
  wait 8;
  level thread function_89cc1ce9();
  level thread function_a1bbfb0d();
  level.adler function_fb2fdf91();
  level.var_657b5876 util::create_cursor_hint("j_prop_2", (0, 0, 3), #"hash_404bf8747b474e11", 60, undefined, &function_6dcf574b, undefined, undefined, 30, 0);
  s_waitresult = undefined;

  if(!level flag::get("alley_shootout") && !level flag::get("alley_takedown")) {
    s_waitresult = level waittill(#"grab_gun", #"alley_shootout", #"alley_takedown");
  }

  var_926c54bf = isDefined(s_waitresult._notify) && s_waitresult._notify == "grab_gun";
  level.adler stopsounds();
  level.adler dialogue::function_47b06180();
  level.var_8d300d6a stopsounds();
  level.var_8d300d6a dialogue::function_47b06180();
  player thread function_36ce47ac(var_926c54bf);
  player val::reset_all("ghost_station_exit");
  player.takedown.disabled = 0;

  if(var_926c54bf) {
    level.adler util::delay(1.4, undefined, &setmodel, #"hash_67fc87ce1ed1b2c0");
    level flag::set("sewer_player_grabbed_gun");
    level flag::set("alley_shootout");
    player setstance("stand");
    player enableweaponcycling();
    level flag::wait_till("player_put_hands_down");
    level thread function_b1bcf436("cin_stakeout_wall_sewer", "player_sewer_kill");
    playsoundatposition("evt_gstationexit_player_grab_pistol_2d", (0, 0, 0));
    player waittill(#"hash_44400b1acca183b8");
  } else {
    level.var_657b5876 util::remove_cursor_hint();
    level.var_85b94361 linkto(level.adler, "tag_sync", (0, 0, 0), (0, 0, 0));
    player enableweaponcycling();
    level thread function_b1bcf436("cin_stakeout_wall_sewer", "alt_sewer_kill");
  }

  if(isDefined(s_waitresult._notify) && (s_waitresult._notify == "alley_shootout" || s_waitresult._notify == "alley_takedown")) {
    wait 0.4;
  }

  var_bd1c473f = getweapon(#"hash_5dbab0bd6a78c6e5");
  var_2922a5d = getweapon(#"pistol_semiauto_t9", "suppressed");

  if(player hasweapon(var_2922a5d)) {
    player switchtoweapon(var_2922a5d, 1);
    player takeweapon(var_bd1c473f);
  } else {
    player takeweapon(var_bd1c473f);
    a_weapons = player getweaponslistprimaries();

    if(a_weapons.size > 1) {
      for(i = 1; i < a_weapons.size; i++) {
        player takeweapon(a_weapons[i]);
      }
    }

    player giveweapon(var_2922a5d);
    player givemaxammo(var_2922a5d);
    player seteverhadweaponall(1);
    player switchtoweapon(var_2922a5d, 1);
  }

  level.adler val::reset("ghost_station_exit", "ignoreall");
  level.adler val::reset("ghost_station_exit", "ignoreme");

  if(isDefined(s_waitresult._notify) && s_waitresult._notify == "grab_gun") {
    vec = vectornormalize(level.var_aff752f8.origin - player.origin);
    org = util::spawn_model("tag_origin", player.origin, vectortoangles(vec));
    org.angles = (org.angles[0] + 6, org.angles[1], org.angles[2]);
    player playerlinktoblend(org, "tag_origin", 0.3, 0.1, 0.1);
    org thread util::delayed_delete(0.3);
    level.var_85b94361 delete();
  }

  level.var_527ee575 thread util::auto_delete(undefined, undefined, 500);
  level.var_4c0e9fb8 thread util::auto_delete(undefined, undefined, 500);
  level waittill(#"hash_30944d8d1cbe5cf");
  namespace_5ceacc03::music("4.0_rooftops");
  level thread function_edef7e4c();
}

function function_fb2fdf91() {
  level endon(#"alley_takedown", #"alley_shootout");
  self waittill(#"start_weapon");
}

function function_b1bcf436(scene_name, shot_name) {
  self scene::play(scene_name, shot_name);
  level notify(#"hash_30944d8d1cbe5cf");
}

function function_1bc1ba1b() {
  self endon(#"death");
  self waittill(#"hash_594975e0c9056402");
  self val::set("ghost_station_exit", "allow_prone", 0);
  self val::set("ghost_station_exit", "allow_sprint", 0);
  n_result = self gestures::function_b6cc48ed(#"hash_52949ea8be198bd1", undefined, 1, undefined, undefined, undefined, 1);
}

function function_32025022(adler, var_2f8a0c3a) {
  level endon(#"save_restore");
  self endon(#"death", #"takedown_begin");
  player = getplayers()[0];

  if(!isalive(player)) {
    return;
  }

  player endon(#"death");
  level.adler waittill(#"kill_player");
  adler animation::stop();
  adler util::unmake_hero("adler");
  adler kill();

  if(isalive(var_2f8a0c3a)) {
    var_2f8a0c3a animation::stop();
    var_2f8a0c3a kill();
  }

  self.perfectaim = 1;
  self.script_accuracy = 1000;

  if(isalive(player)) {
    if(self cansee(player)) {
      v_org = self gettagorigin("tag_flash");
    } else {
      v_org = player.origin + anglesToForward(player getplayerangles()) + (0, -128, 56);
    }

    player util::stop_magic_bullet_shield();
    player disableinvulnerability();
    v_dest = player.origin + (0, 0, 50);
    magicbullet(getweapon("ar_accurate_t9"), v_org, v_dest);

    if(!player util::function_a1d6293()) {
      player flag::set("death_gesture_skip_mod_check");

      while(player.allowdeath === 0) {
        waitframe(1);
      }

      player kill();
    }
  }
}

function function_a1bbfb0d() {
  level endon(#"alley_shootout");
  level flag::wait_till_clear("near_manhole");
  trig = getent("sewer_area", "targetname");
  trig delete();
  level flag::clear("near_manhole");
  level flag::set("alley_shootout");
}

function function_89cc1ce9() {
  level endon(#"alley_shootout");
  level waittill(#"hash_7ab609d3ca8d2321");
  level flag::set("alley_shootout");
}

function function_e64b290f() {
  self endon(#"death");
  level endon(#"alley_shootout");
  player = getplayers()[0];
  player endon(#"death");

  while(distance(self.origin, player.origin) > 100) {
    waitframe(1);
  }

  level util::delay(0.7, "alley_shootout", &flag::set, "alley_takedown");

  if(level flag::get("sewer_enemy_2_can_react")) {
    self scene::play("cin_stakeout_wall_sewer_react", "shot 1", self);
  } else {
    self scene::play("cin_stakeout_wall_sewer_react", "shot 2", self);
  }

  self.favoriteenemy = player;
}

function function_36ce47ac(var_31f9ea91 = 1) {
  self endon(#"death");
  self val::set("grab_gun", "freezecontrols_allowlook", 1);
  self stopgestureviewmodel(#"hash_52949ea8be198bd1", 0.25, 0);

  if(var_31f9ea91) {
    wait 0.1;
  }

  self val::reset("grab_gun", "freezecontrols_allowlook");
  level flag::set("player_put_hands_down");
}

function function_eaa6ba4b() {
  level endon(#"alley_takedown");
  level waittill(#"alley_shootout");

  if(level flag::get("sewer_enemy_2_can_react")) {
    self scene::play("cin_stakeout_wall_sewer_react", "shot 1", self);
  } else {
    self scene::play("cin_stakeout_wall_sewer_react", "shot 2", self);
  }

  self.favoriteenemy = getplayers()[0];
}

function function_7d2c6c13() {
  level.player endon(#"death");
  level.adler endon(#"death");
  level.adler waittill(#"hash_22a38ee9f518a3cd");
  level thread namespace_11998b8f::function_23f254a8();
  level thread namespace_11998b8f::function_d81925f5("vol_wall_body_drop", "street_done");
}

function function_edef7e4c() {
  level.adler endon(#"death");

  if(!level flag::get("sewer_player_grabbed_gun")) {
    level thread function_31306fa8();
    level scene::play("cin_stakeout_wall_sewer", "alt_sewer_cleanup");
  } else {
    level scene::play("cin_stakeout_wall_sewer", "sewer_cleanup");
  }

  if(!level flag::get("go_in_roof_door")) {
    level scene::init("aib_vign_stakeout_wall_alley_door");
    level flag::wait_till("go_in_roof_door");
  }

  level flag::set("ghost_station_exit_done");
  player = getplayers()[0];

  if(isPlayer(player)) {
    player function_66b6e720("cin_stakeout_wall_sewer");
  }

  clientfield::set("force_stream_sewer_exit", 0);
}

function function_31306fa8() {
  level.adler waittill(#"model_swap");
  old_model = # "c_t9_usa_hero_adler_undercover_berlin_pistol_body1";
  new_model = # "c_t9_usa_hero_adler_undercover_berlin_body1";
  level.adler detach(old_model);
  level.adler attach(new_model);

  if(isDefined(level.var_85b94361)) {
    level.var_85b94361 delete();
  }
}

function function_d1bc79a0(door_name, var_2202211f) {
  var_3707ab7 = getent(door_name, "targetname");
  var_5d4c31a5 = getent(var_3707ab7.target, "targetname");
  var_3707ab7.original_origin = var_3707ab7.origin;
  var_3707ab7.original_angles = var_3707ab7.angles;

  if(isDefined(var_2202211f.var_44732bb0)) {
    var_2202211f.var_44732bb0 unlink();
  }

  var_5d4c31a5 linkto(var_3707ab7);
  waitframe(1);
  var_3707ab7 linkto(var_2202211f, "j_prop_1", (0, 0, 0), (0, 0, 0));
  var_5d4c31a5 connectpaths();
  var_2202211f.var_44732bb0 = var_3707ab7;
  return var_2202211f;
}

function function_6dcf574b(prompt_struct) {
  level notify(#"grab_gun");
}