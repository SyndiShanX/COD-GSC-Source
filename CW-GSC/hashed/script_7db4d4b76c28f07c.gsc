/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7db4d4b76c28f07c.gsc
***********************************************/

#using script_13114d8a31c6152a;
#using script_1b9f100b85b7e21d;
#using script_290b454abd681dd4;
#using script_2d443451ce681a;
#using script_37f9ff47f340fbe8;
#using script_3dc93ca9902a9cda;
#using script_7409560e3a0c9884;
#using script_eb1a9e047313195;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\easing;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\manager;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\teleport_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#using scripts\weapons\cp\spy_camera;
#namespace namespace_4e717b5b;

function function_ae18fec1(var_d3440450) {}

function intro_main(var_d3440450, var_50cc0d4f) {
  while(!isDefined(level.player_connected) || isDefined(level.player_connected) && level.player_connected != 1) {
    wait 0.1;
  }

  player = getplayers()[0];
  player val::set(#"temp_intro", "show_hud", 0);
  player val::set(#"temp_intro", "freezecontrols");
  player val::set(#"temp_intro", "disable_weapons");
  player val::set(#"temp_intro", "takedamage", 0);
  player val::set(#"temp_intro", "allowdeath", 0);
  player val::set(#"temp_intro", "hide");

  while(player.origin == (0, 0, 0)) {
    wait 0.1;
  }

  level thread function_58f45d60();
  callback::on_spawned(&init);
  level thread namespace_ba979a10::setup_allies();
  level thread function_1fc6733a();
  snd::client_msg(#"hash_a6672e4b395e2b8");
  level thread function_38610863();
  level thread function_43554611();
  level thread function_1b25bb39();
  level thread function_6423e5e1();
  level thread function_a174d491();
  level thread function_2fb462dd();
  level thread function_536a482b();
  level thread function_78b6b123();
  level thread function_71b65ddf();
  level thread function_8e7c787a();
  exploder::exploder("radio_tower_lights");
  level.player util::function_749362d7(1);
  wait 7;
  var_4b971330 = skipto::function_99ddd76d();
  level thread globallogic_ui::function_7bc0e4b9(1, var_4b971330);
  snd::client_msg(#"hash_1b35e000cf122d8e");
  level flag::wait_till_clear(#"chyron_active");
  level flag::wait_till("over_black_vo_done");
  level flag::set("finish_tundra_initial_black");
  player val::reset(#"temp_intro", "show_hud");
  player val::reset(#"temp_intro", "freezecontrols");
  player val::reset(#"temp_intro", "disable_weapons");
  player val::reset(#"temp_intro", "takedamage");
  player val::reset(#"temp_intro", "allowdeath");
  player val::reset(#"temp_intro", "hide");
  level flag::wait_till("missile_strike_landed");
  level.player util::function_749362d7(0);
  savegame::checkpoint_save();
  level flag::wait_till("tundra_intro_done");
  skipto::function_4e3ab877("tundra_intro");
}

function init_flags() {}

function init() {}

function cleanup(name, starting, direct, player) {}

function function_1fc6733a() {
  wait 1.5;
  function_5cdbfdcc("vox_cp_rcir_01050_wood_rudnikbetterbei_f5");
  function_5cdbfdcc("vox_cp_rcir_01050_masn_commandsoundedc_9c");
  function_5cdbfdcc("vox_cp_rcir_01050_wood_alrighttakeusdo_63");
  level flag::set("over_black_vo_done");
}

function function_5cdbfdcc(alias) {
  soundobject = snd::play(alias);
  snd::function_2fdc4fb(soundobject);
}

function function_38610863() {
  level flag::wait_till("over_black_vo_done");
  level flag::wait_till_timeout(11, "flag_spawn_ambient_trucks");
  level.player dialogue::queue("vox_cp_rcir_01100_masn_alrightwereinpo_61");
  dialogue::radio("vox_cp_rcir_01100_cmnd_rogerthattheres_51");
  wait 1;
  dialogue::radio("vox_cp_rcir_01100_cmnd_goaheadandmarkt_65");
  level.woods dialogue::queue("vox_cp_rcir_01100_wood_masonthetowersu_fc");
  level flag::set("tundra_intro_obj_tower");
  level flag::set("give_player_binoculars");
  level flag::wait_till("launch_binoc_attack");
  level.player dialogue::queue("vox_cp_rcir_01100_masn_coordinatescomi_a6");
  dialogue::radio("vox_cp_rcir_01100_cmnd_rogerthecheckis_d1");
  level flag::wait_till("missile_strike_landed");
  level.woods dialogue::queue("vox_cp_rcir_01100_wood_thatllwakethemu_2d");
  wait 1;
  dialogue::radio("vox_cp_rcir_01100_cmnd_nowgetdownthere_0e");
  level flag::set("tundra_intro_obj_update");
  wait 1;
  level.woods dialogue::queue("vox_cp_rcir_01100_wood_wedonthavealoto_5f");
  level.woods dialogue::queue("vox_cp_rcir_01100_wood_masontakeyourli_0a");
  level flag::set("tundra_intro_vo_done");
}

function function_acbf5fe3() {}

function function_43554611() {
  level endon(#"launch_binoc_attack");
  level flag::wait_till("tundra_intro_obj_tower");
  nags = [];
  speaker = [];
  nags[nags.size] = "vox_cp_rcir_01100_wood_usethosebinocul_3a";
  speaker[speaker.size] = level.woods;
  nags[nags.size] = "vox_cp_rcir_01100_wood_masonmarkthatra_fd";
  speaker[speaker.size] = level.woods;
  nags[nags.size] = "vox_cp_rcir_01100_wood_comeonmasonmark_8b";
  speaker[speaker.size] = level.woods;
  wait 10;
  i = 0;

  while(!level flag::get("launch_binoc_attack")) {
    speaker[i] dialogue::queue("" + nags[i]);
    i++;

    if(i >= nags.size) {
      i = 0;
    }

    wait 15;
  }
}

function function_1b25bb39() {
  level endon(#"player_is_rappelling");
  level flag::wait_till("tundra_intro_obj_update");
  nags = [];
  speaker = [];
  nags[nags.size] = "vox_cp_rcir_01100_wood_attachyourlineb_bc";
  speaker[speaker.size] = level.woods;
  nags[nags.size] = "vox_cp_rcir_01100_wood_getyourassdownt_ea";
  speaker[speaker.size] = level.woods;
  wait 10;
  i = 0;

  while(!level flag::get("player_is_rappelling")) {
    speaker[i] dialogue::queue("" + nags[i]);
    i++;

    if(i >= nags.size) {
      i = 0;
    }

    wait 15;
  }
}

function function_2fb462dd() {
  level flag::wait_till("over_black_vo_done");
  level flag::wait_till("tundra_intro_obj_tower");
  var_fda2e7e6 = getent("tundra_intro_tower", "targetname");
  objectives::function_4eb5c04a("missile_obj", var_fda2e7e6.origin + (0, 0, 6300), undefined, 1, 1);
  level flag::wait_till("missile_strike_landed");
  objectives::complete("missile_obj");
  level thread namespace_ba979a10::function_cb6a2e9b();
  level flag::wait_till("tundra_intro_obj_update");
  level flag::wait_till("tundra_intro_vo_done");
  level thread namespace_ba979a10::function_ee211e0d();
}

function function_8e7c787a() {
  wait 0.5;
  level.woods val::set("intro", "ignoreall", 1);
  level.woods val::set("intro", "ignoreme", 1);
  level.woods ai::set_behavior_attribute("demeanor", "cqb");
}

function function_78b6b123() {
  level flag::wait_till("flag_spawn_ambient_trucks");
  var_86827bb9 = spawner::simple_spawn("tundra_intro_patrol_enemies", &function_d158ddb4);
  var_ff6f8c02 = spawner::simple_spawn("tundra_intro_walk_enemies", &function_a9d32145);
}

function function_71b65ddf() {
  level flag::wait_till("over_black_vo_done");
  var_b4a49886 = vehicle::simple_spawn_and_drive("intro_heli_flyby");

  foreach(heli in var_b4a49886) {
    heli vehicle::toggle_tread_fx(1);
    heli vehicle::toggle_exhaust_fx(1);
    snd::client_targetname(heli, "heli");
    heli setrotorspeed(1);
  }

  level thread function_977dbf55();
  var_8b658b90 = vehicle::simple_spawn_single("tundra_ambient_veh_1");
  snd::client_targetname(var_8b658b90, "truck");
  var_420fd09 = vehicle::simple_spawn_single_and_drive("tundra_ambient_veh_2");
  snd::client_targetname(var_420fd09, "truck");
  wait 1;
  var_8b658b90 thread vehicle::go_path();
}

function function_977dbf55() {
  var_fb168203 = getent("lookat_flyby_heli", "script_noteworthy", 1);
  var_fb168203 val::set("intro", "ignoreall", 1);
  level.ai_lookat = spawner::simple_spawn_single("lookat_flyby_ent");
  level.ai_lookat forceteleport(var_fb168203 gettagorigin("tag_driver"), var_fb168203 gettagangles("tag_driver"));
  level.ai_lookat linkto(var_fb168203, "tag_driver", (0, 0, -25), (0, 0, 0));
  level flag::wait_till("flag_heli_end_path");

  if(isDefined(level.ai_lookat)) {
    level.ai_lookat deletedelay();
  }
}

function function_d158ddb4() {
  self endon(#"death");
  self ai::set_behavior_attribute("demeanor", "patrol");
  self thread animation::enable_headlook_notorso(1);
  level flag::wait_till("missile_strike_landed");
  self ai::set_behavior_attribute("demeanor", "combat");
  self lookatpos(level.var_8ef0b331);
  wait 2;

  if(isDefined(self) && self.script_noteworthy == "radar_reaction_enemy") {
    self spawner::function_461ce3e9();
    waitframe(1);
    goalvolume = getent("radar_ext_combat_vol", "targetname");
    self setgoal(goalvolume);
    return;
  }

  if(isDefined(self) && self.script_noteworthy == "motorpool_reaction_enemy") {
    self spawner::function_461ce3e9();
    waitframe(1);
    goalvolume = getent("motor_pool_ext_combat_vol", "targetname");
    self setgoal(goalvolume);
  }
}

function function_a9d32145() {
  self endon(#"death");
  self ai::set_behavior_attribute("demeanor", "patrol");
  self thread function_f4b577e3();
  level flag::wait_till("missile_strike_landed");
  wait 2;

  if(isDefined(self) && isalive(self)) {
    self ai::set_behavior_attribute("demeanor", "combat");

    if(self.script_noteworthy == "intro_walk_radar_enemy") {
      goalvolume = getent("radar_ext_combat_vol", "targetname");
      self clearforcedgoal();
      waitframe(1);
      self setgoal(goalvolume);
      return;
    }

    if(self.script_noteworthy == "intro_walk_motorpool_enemy") {
      goalvolume = getent("motor_pool_ext_combat_vol", "targetname");
      self clearforcedgoal();
      waitframe(1);
      self setgoal(goalvolume);
    }
  }
}

function function_f4b577e3() {
  level endon(#"missile_strike_landed");
  self flag::wait_till("amb_guy_end_reached");

  if(isDefined(self) && isalive(self) && !flag::get("missile_strike_landed")) {
    self deletedelay();
  }
}

function function_6423e5e1() {
  e_missile = getent("tundra_intro_missile", "targetname");
  e_missile setscale(0.1);
  level flag::wait_till("launch_binoc_attack");
  wait 5.5;
  var_fda2e7e6 = getent("tundra_intro_tower", "targetname");
  e_missile thread function_766b93f();
  level thread function_5453503d();
  level flag::wait_till("missile_strike_landed");
  exploder::exploder("fx_exp_vista_tower");
  wait 0.2;
  exploder::kill_exploder("radio_tower_lights");
  level.player playrumbleonentity(#"hash_4250c3326e0f75e3");
  wait 1;
  var_fda2e7e6 delete();
}

function function_766b93f() {
  var_fda2e7e6 = getent("tundra_intro_tower", "targetname");
  var_15164fa0 = getent("missile_strike_mid_flight", "targetname");
  self thread function_3011ebae();
  self moveto(var_15164fa0.origin, 8);
  wait 3;
  wait 4;
  level notify(#"hash_227caa557c6d6e99");
  playFXOnTag("maps/cp_side_tundra/fx9_missile_trail", self, "tag_fx");
  self moveto(var_fda2e7e6.origin, 4, 2);
  wait 4;
  level flag::set("missile_strike_landed");
  level notify(#"hash_75e302a823ba736d");
  waitframe(1);
  self delete();
}

function function_3011ebae() {
  level endon(#"missile_scaled");
  var_e748b981 = 0;

  while(var_e748b981 < 9) {
    var_e748b981 += 0.1;
    self setscale(var_e748b981);
    waitframe(1);
  }

  level flag::set("missile_scaled");
}

function function_5453503d() {
  level.var_8ef0b331 = getent("turndra_radio_tower_lookat", "targetname");
}

function function_a174d491() {
  level.player thread function_1dc9305a();
  level.player thread function_f469a600();
  level thread namespace_ba979a10::function_d6af6077();
  level flag::wait_till("player_is_rappelling");
  level flag::set("tundra_intro_done");
}

function function_f469a600() {
  level endon(#"player_is_rappelling");
  self endon(#"death");
  self val::set("intro", "ignoreme", 1);

  while(true) {
    self waittill(#"weapon_fired");

    if(self getcurrentweapon() !== level.var_42db149f) {
      break;
    }
  }

  self val::set("intro", "ignoreme", 0);
  level.woods val::set("intro", "ignoreme", 0);
  level.woods val::set("intro", "ignoreall", 0);
}

function function_1dc9305a() {
  level.player setstance("crouch");
  level thread scene::play("scene_sm_tundra_rappel_player", "rope_loop");
  level flag::wait_till("missile_strike_landed");
  level thread function_addf1082(420);
  var_cb14744d = getent("intro_player_rappel", "targetname");
  var_cb14744d util::create_cursor_hint("tag_origin", (0, 0, 5), #"hash_6c7bb285599937ba", 100, undefined, undefined, undefined, undefined, undefined, 0, 0);
  var_cb14744d waittill(#"trigger");
  level flag::set("player_is_rappelling");
  scene::stop("scene_sm_tundra_rappel");
  level.player setstance("stand");
  waitframe(1);
  level scene::play("scene_sm_tundra_rappel_player", "player");
  level flag::set("player_rappel_done");
}

function function_536a482b() {
  level flag::wait_till("missile_strike_landed");
  wait 8;
  var_8b658b90 = vehicle::simple_spawn_and_drive("tundra_enemy_veh_1");
  var_420fd09 = vehicle::simple_spawn_single_and_drive("tundra_enemy_veh_2");

  foreach(veh in var_8b658b90) {
    snd::client_targetname(veh, "truck");
  }

  snd::client_targetname(var_420fd09, "truck");
  var_420fd09 thread function_e22580b2();
}

function function_e22580b2() {
  self endon(#"death");
  self waittill(#"damage");
  self setspeed(0);
  wait 1;
  self vehicle::unload();
  riders = getEntArray("intro_riders", "targetname", 1);

  foreach(rider in riders) {
    if(isDefined(rider) && isalive(rider)) {
      if(isDefined(self)) {
        rider setgoal(self, 1);
        continue;
      }

      goalvolume = getent("radar_ext_combat_vol", "targetname");
      rider setgoal(goalvolume);
    }
  }
}

function function_addf1082(time) {
  level endon(#"player_is_rappelling");
  wait time;
  util::function_2a8f4806(#"hash_67c0d8cb1c978161", #"hash_4bac1239d9e0e0bd");
}

function function_58f45d60() {
  level flag::wait_till("give_player_binoculars");
  player = getplayers()[0];
  player notifyonplayercommand("ability_activated_binocular", "+actionslot 4");
  level thread function_d156bb26();
  level thread function_c21ddb3d();
  player spy_camera::function_8606cd15();
  level flag::wait_till_clear(#"chyron_active");
  level thread function_d280457b();
  level thread function_975f72af();
  level thread function_71dd9e76();
  level flag::wait_till_all(array("launch_binoc_attack", "flag_player_end_binocular_ads"));
  player spy_camera::function_d9015b8c();
}

function function_71dd9e76() {
  player = getplayers()[0];

  if(!flag::get("flag_player_end_binocular_ads")) {
    level flag::wait_till("player_is_rappelling");
    player spy_camera::function_d9015b8c();
  }
}

function function_d280457b() {
  level flag::set("binoc_prompt_watch_on");
  player = getplayers()[0];

  while(level flag::get("binoc_prompt_watch_on")) {
    level flag::wait_till("binoc_attack_prompt_active");
    player thread util::show_hint_text(#"hash_68f35624af19e182", 0, "stop_binoc_attack_prompt", 25);
    level.var_4a9e9737 = gettime() + 500;
    level flag::wait_till_clear("binoc_attack_prompt_active");
    player notify(#"stop_binoc_attack_prompt");
  }
}

function function_975f72af() {
  aim_ent = struct::get("tundra_intro_binoc_loc", "targetname");
  player = getplayers()[0];
  level.height_add = (0, 0, 2000);
  level.var_4a9e9737 = 0;

  while(isDefined(aim_ent)) {
    ads = player adsButtonPressed();
    var_3333dbfa = aim_ent.origin + level.height_add;

    if(ads && player getcurrentweapon() === level.var_42db149f) {
      var_70250b99 = vectornormalize(var_3333dbfa - player getplayercamerapos());
      var_26ea01fb = anglesToForward(player getplayerangles());
      var_153ecee9 = vectordot(vectornormalize((var_70250b99[0], var_70250b99[1], 0)), vectornormalize((var_26ea01fb[0], var_26ea01fb[1], 0)));
      dot = vectordot(var_70250b99, var_26ea01fb);

      if(level.var_4a9e9737 > gettime() || var_153ecee9 >= 0.9994 && dot >= 0.997) {
        level flag::set("binoc_attack_prompt_active");

        if(player attackButtonPressed()) {
          break;
        }
      } else {
        level flag::clear("binoc_attack_prompt_active");
      }
    } else {
      level flag::clear("binoc_attack_prompt_active");
    }

    waitframe(1);
  }

  level flag::clear("binoc_prompt_watch_on");
  level flag::clear("binoc_attack_prompt_active");
  level flag::set("launch_binoc_attack");
}

function function_d156bb26() {
  player = getplayers()[0];
  level endon(#"launch_binoc_attack");
  level endon(#"player_is_rappelling");
  player endon(#"death");

  while(true) {
    level flag::clear("cancel_ability_wheel_select_binoc_hint");
    level flag::clear("cancel_binoc_up_hint");
    level flag::clear("cancel_hint_binoc_use");
    player util::show_hint_text(#"hash_13bb297b79e5adfc", undefined, undefined, 8);
    player waittill(#"ability_activated_binocular");
    level.player util::function_749362d7(0);
    level.player playrumbleonentity(#"hash_27471bde81e12116");
    level flag::set("cancel_ability_wheel_select_binoc_hint");
    wait 0.5;
    player util::show_hint_text(#"hash_4a6d69ecadd8052b", undefined, undefined, 8);
    s_waitresult = player waittill(#"hash_59b80e9e535f9788", #"ability_deactivated_camera", #"stop_binoc_attack_prompt");
    level flag::set("cancel_binoc_up_hint");

    if(s_waitresult._notify == "ability_deactivated_camera") {
      level.player util::function_749362d7(1);
      wait 0.5;
      continue;
    }

    wait 0.5;
    player util::show_hint_text(#"hash_23084045f6d25b85", undefined, undefined, 8);
    s_waitresult = player waittilltimeout(4, #"hash_5512f0799022267", #"ability_deactivated_camera", #"stop_binoc_attack_prompt");
    level flag::set("cancel_hint_binoc_use");

    if(s_waitresult._notify == "ability_deactivated_camera") {
      level.player util::function_749362d7(1);
      wait 0.5;
      continue;
    }

    s_waitresult = player waittill(#"ability_deactivated_camera");
    level.player util::function_749362d7(1);
    wait 0.5;
    continue;
  }
}

function function_c21ddb3d() {
  player = getplayers()[0];
  level spy_camera::function_f91a82ef(1, undefined);
  level flag::wait_till("launch_binoc_attack");
  player waittill(#"end_camera_ads");
  player thread util::show_hint_text(#"hash_709d9027f5d34268", undefined, "hide_camera_unequip_hint", -1);
  player waittill(#"ability_deactivated_camera");

  if(!level flag::get("missile_strike_landed")) {
    level.player util::function_749362d7(1);
  }

  level flag::set("flag_player_end_binocular_ads");
}