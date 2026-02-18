/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_takedown_af_chase.gsc
***********************************************/

#using script_2d443451ce681a;
#using script_31e9b35aaacbbd93;
#using script_3626f1b2cf51a99c;
#using script_3dc93ca9902a9cda;
#using script_4937c6974f43bb71;
#using script_61cfc2ab8e60625;
#using script_9bfd3d8a6a89e5e;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_death_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp\cp_takedown_af_hill;
#using scripts\cp\cp_takedown_af_tarmac;
#using scripts\cp\cp_takedown_fx;
#using scripts\cp_common\debug;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hint_tutorial;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;
#namespace tkdn_af_chase;

function starting(var_d3440450) {
  level.player = getplayers()[0];
  tkdn_af_hill::function_a2015343(var_d3440450);
  plane = namespace_b100dd86::function_5431431d();
  namespace_b100dd86::function_c8381339(plane, 1);
  exploder::stop_exploder("airfield_assault_lighting_noplane");
  exploder::exploder("airfield_assault_lighting");
  setDvar(#"hash_76c0d7e6385ee6de", 0.05);
  setDvar(#"hash_62b11f12963c68d4", 2000);
  namespace_b100dd86::function_5aabc3fb();
  level thread scene::play_from_time("scene_tkd_hit3_intro", "shot 1", undefined, 1, 1, 1, 0, 0);
  trigger::use("approach_airstrip", "targetname", undefined, 0);
  thread namespace_b100dd86::function_19919872();
  thread namespace_a052577e::function_79270d32();
  thread function_9d8f5cd3();
  level clientfield::set("prop_wash", 1);
}

function function_614083bb(var_d3440450) {
  thread namespace_a052577e::function_79270d32();
  namespace_b100dd86::function_5aabc3fb();
  level.player = getplayers()[0];
  thread namespace_a052577e::function_79270d32();
  tkdn_af_hill::function_a2015343(var_d3440450);
  plane = namespace_b100dd86::function_5431431d();
  namespace_b100dd86::function_c8381339(plane, 1);
  setDvar(#"hash_76c0d7e6385ee6de", 0.05);
  setDvar(#"hash_3d9a09e7ecea2271", 0);
  trigger::use("approach_airstrip", "targetname", undefined, 0);
  thread namespace_b100dd86::function_19919872();
  thread function_d9fae56b();
  function_6c9a840b();
  level.player val::set(#"chase", "allowdeath", 0);
  level flag::set("af_start_rc_car");
  level.rc_car thread function_f311ea18();
  thread function_326abc48();
  thread namespace_82bfe441::fade(1, "FadeFast");
}

function cleanup(name, starting, direct, player) {}

function function_cca97e77(name, starting, direct, player) {
  level flag::set("rc_car_on_ground");
  level flag::set("no_more_truck_chase");
}

function init_flags() {
  level flag::init("af_start_rc_car");
  level flag::init("af_chase_complete");
  level flag::init("af_pressed_rc_button");
}

function init_clientfields() {
  clientfield::register("vehicle", "le_door_en2_death_fallout", 1, 1, "int");
  clientfield::register("vehicle", "ri_door_en2_death_fallout", 1, 1, "int");
  clientfield::register("vehicle", "4x4_getin_door", 1, 1, "int");
  clientfield::register("vehicle", "4x4_getin_door_woods", 1, 1, "int");
  clientfield::register("vehicle", "af_rc_deploy1", 1, 1, "int");
  clientfield::register("vehicle", "af_rc_deploy2", 1, 1, "int");
  clientfield::register("vehicle", "af_rc_deploy3", 1, 1, "int");
}

function function_22b7fffd() {
  animation::add_notetrack_func("le_door_en2_death_fallout_server", &le_door_en2_death_fallout_server);
  animation::add_notetrack_func("ri_door_en2_death_fallout_server", &ri_door_en2_death_fallout_server);
  scene::add_scene_func("scene_tkd_hit3_chase", &function_192e7a1, "loop");
}

function le_door_en2_death_fallout_server(params) {
  self.vehicle clientfield::set("le_door_en2_death_fallout", 1);
  self.vehicle setanim(#"hash_55c97e9bf41cf070", 1, 0, 1);
}

function ri_door_en2_death_fallout_server(params) {
  self.vehicle clientfield::set("ri_door_en2_death_fallout", 1);
  self.vehicle setanim(#"hash_7ed3204394a2ff5e", 1, 0, 1);
}

function main(var_d3440450, var_50cc0d4f) {
  player = getplayers()[0];
  player endon(#"death");

  if(var_50cc0d4f) {
    util::delay(0.2, undefined, &tkdn_af_tarmac::function_565588e1);
  }

  level.adler dialogue::function_47b06180();
  level.adler.script_accuracy = 100;
  level.woods.script_accuracy = 100;
  setDvar(#"hash_3d9a09e7ecea2271", 0);
  level.af_plane cp_takedown_fx::function_c5bbfcb8();
  level.af_plane cp_takedown_fx::function_b6cccb8();
  level.af_plane cp_takedown_fx::function_8e4c996d();
  level.af_plane thread function_3a97edf();
  spawner::add_spawn_function_group("af_vh_enemy", "targetname", &function_db378ce0);
  vehicle::add_spawn_function_group("af_enemy_chase_veh_r", "script_noteworthy", &function_40c45b6);
  vehicle::add_spawn_function_group("af_enemy_chase_veh_l", "script_noteworthy", &function_40c45b6);
  function_d9fae56b();
  thread function_dcc35e0b();
  thread function_4c87c5cf(var_50cc0d4f);
  thread function_b90ebd9a();
  thread function_9555ada1();
  wait 2;
  level flag::wait_till("af_start_ride");
  namespace_b100dd86::function_c8381339(level.af_plane, 1);
  thread function_35bf824f();
  player thread function_6e899b0e();
  player thread function_e90d5c1();
  thread function_326abc48();
  level flag::wait_till("af_start_rc_car");
  thread function_761593b3();
  thread function_9509c87f();
  thread function_7730c3f4();
  level waittill(#"hash_2c1821278dd7ecb1");
  wait 2;
  level notify(#"hash_351eb749d2c8fa9c");

  if(isDefined(var_d3440450)) {
    skipto::function_4e3ab877(var_d3440450);
  }

  level.woods ai::gun_recall();
}

function function_95f6d250(var_d36613f6) {
  is_gamepad = self gamepadusedlast();
  var_719ad9bc = !is_gamepad && self function_afbfaf58();

  if(var_719ad9bc) {
    self flag::set(var_d36613f6);
  } else {
    self flag::clear(var_d36613f6);
  }

  self thread function_269adc62(var_d36613f6);
}

function function_269adc62(var_d36613f6) {
  self endon(#"death", #"close_hint");
  isusinggamepad = self gamepadusedlast();
  var_b04af81c = self function_afbfaf58();

  while(true) {
    var_288becd = self gamepadusedlast();
    var_b86dfa19 = self function_afbfaf58();

    if(var_288becd != isusinggamepad || var_b86dfa19 != var_b04af81c) {
      isusinggamepad = var_288becd;
      var_b04af81c = var_b86dfa19;

      if(!isusinggamepad && var_b04af81c) {
        self flag::set(var_d36613f6);
      } else {
        self flag::clear(var_d36613f6);
      }
    }

    waitframe(1);
  }
}

function function_2ccc781e(var_d3440450, var_50cc0d4f) {
  vehicle::add_spawn_function_group("challenge_truck", "script_noteworthy", &function_2016824f);
  spawner::add_spawn_function_group("af_vh_rc_enemy", "targetname", &function_db378ce0);
  player = getplayers()[0];
  setDvar(#"hash_3d9a09e7ecea2271", 0);
  util::function_323d3227();
  player endon(#"death");
  level.player val::set(#"chase", "allowdeath", 0);
  player linkto(level.chase_truck);
  level.chase_truck vehicle::get_off_path();
  pathnode = getvehiclenode("rc_chase_start", "targetname");
  level.chase_truck thread vehicle::get_on_and_go_path(pathnode);
  player unlink();
  thread function_3c7a908d(var_50cc0d4f);
  thread function_9535c641();
  thread function_e585ec0d();
  thread function_1ce84183();
  thread function_bc4a48ea();
  thread function_31c124f2();
  waitframe(1);
  org = getent("rpg_guy_plane_spot", "script_noteworthy");
  level.plane_rpg_guy = spawner::simple_spawn_single("plane_rpg_guy");
  level.plane_rpg_guy linkto(org, undefined, (0, 0, 0), (0, 180, 0));
  level.plane_rpg_guy val::set(#"af_chase", "ignoreall", 1);
  level waittill(#"car_on_ground");
  level thread dialogue::radio("vox_cp_tdwn_07400_masn_ontheground_ee", undefined, 1);
  player ghost();
  level.player val::reset(#"chase", "allow_prone");
  hint_data = [hint_tutorial::function_f0104b5([# "hash_7aca54ffec0ead0c", #"hash_2b29cb97f3659ab5", #"hash_4b6208b00403f13f"], undefined, [# "hash_7aca54ffec0ead0c", #"hash_2477ad1395a6639e", #"hash_4b6208b00403f13f"], "alt_controls_activated")];
  level.player function_95f6d250("alt_controls_activated");
  wait 1;
  level.player val::reset(#"rc_launch", "freezecontrols");
  level.player setnoncheckpointdata("SeenRCCarTutorial", 1);
  hint_tutorial::function_4c2d4fc4(#"", #"hash_449406a42e97953e", undefined, undefined, undefined, 5, undefined, 1, hint_data);
  hint_tutorial::pause();
  player thread function_8bbbfc85();
  thread function_afa87bfc(player);
  wait 1;
  thread function_1c4bdba5();
  level flag::wait_till("af_start_crash");
  level.chase_truck sethighdetail(1);
  player enableweapons();
  namespace_82bfe441::fade(0, "FadeSlow");
  level objectives::complete("af_chase_plane_rc", level.var_c7b3a621);
  level.player notifyonplayercommand("blow_rc_car", "+vehicleattack");
  thread function_7766538b();
  player waittill(#"blow_rc_car");
  player show();
  level notify(#"starting_crash_seq");
  player prompts::remove(#"vehicle_attack");
  level music::setmusicstate("none");
  level.player cp_takedown_fx::function_6539055f();

  if(!level flag::get("af_start_crash") && !level flag::get("failed_chase")) {
    level flag::set("failed_chase");
    level thread util::missionfailedwrapper(#"hash_4efe29bbbdba2730", #"hash_4d4c51db77bea4d0");
  }

  if(level flag::get("failed_chase")) {
    level waittill(#"forever");
  }

  level.player notifyonplayercommandremove("blow_rc_car", "+vehicleattack");
  level.rc_car makevehicleusable();
  level.rc_car useby(player);
  level.rc_car makevehicleunusable();
  level.rc_car linkto(level.af_plane);
  setDvar(#"hash_252e699c41531f1a", 2);
  array::add(level.var_2e151cca, level.plane_rpg_guy);

  foreach(guy in level.var_2e151cca) {
    if(isalive(guy)) {
      guy kill();
    }
  }

  vehs = arraycombine(getvehiclearray("af_enemy_chase_veh_r", "script_noteworthy"), getvehiclearray("af_enemy_chase_veh_l", "script_noteworthy"));
  vehs = arraycombine(vehs, getvehiclearray("af_enemy_deploy_veh_f", "targetname"));
  vehs = arraycombine(vehs, getvehiclearray("af_enemy_deploy_veh_l", "targetname"));
  vehs = arraycombine(vehs, getvehiclearray("af_enemy_deploy_veh_r", "targetname"));

  foreach(veh in vehs) {
    veh vehicle_death::death_cleanup_riders();
    veh delete();
  }

  vehs = getvehiclearray();
  vehs = array::exclude(vehs, [level.chase_truck, level.rc_car]);
  array::delete_all(vehs);
  vehs = getvehiclearray();

  if(isDefined(var_d3440450)) {
    skipto::function_4e3ab877(var_d3440450);
  }
}

function function_8bbbfc85() {
  thread function_cc5078c1();

  while(length(self getnormalizedmovement()) < 0.1) {
    waitframe(1);
  }

  level.player notify(#"player_driving");
  wait 1;

  if(!level flag::get("rc_boosted")) {
    level.player thread util::show_hint_text(#"hash_4b6208b00403f13f", 0, ["rc_detonate", "rc_boosted", "blow_rc_car"], -1);
    level.player waittill(#"rc_boosted");
  }

  level.player endon(#"blow_rc_car");
  var_727f982c = 20;
  var_727f982c *= 39.3701;

  while(true) {
    old_dist = distance2d(level.rc_car.origin, level.af_plane.origin);
    wait 5;
    new_dist = distance2d(level.rc_car.origin, level.af_plane.origin);

    if(new_dist > old_dist || abs(old_dist - new_dist) < var_727f982c) {
      level.player thread util::show_hint_text(#"hash_4b6208b00403f13f", 0, ["rc_detonate", "rc_boosted", "blow_rc_car"], -1);
      thread function_cc5078c1();
      level.player waittill(#"rc_boosted");
    }
  }
}

function function_cc5078c1() {
  level.player endon(#"blow_rc_car");

  while(true) {
    if(self boostbuttonPressed()) {
      level.player notify(#"rc_boosted");
      level flag::set("rc_boosted");
      break;
    }

    waitframe(1);
  }
}

function function_1ce84183() {
  level.player endon(#"blow_rc_car");
  level.player endon(#"death");
  level.rc_car waittill(#"death", #"killed");

  if(!level flag::get("failed_chase")) {
    level flag::set("failed_chase");
    level util::missionfailedwrapper(#"hash_4efe29bbbdba2730", #"hash_2f0e469c0a45ac0");
  }
}

function function_9509c87f() {
  level.woods dialogue::queue("vox_cp_tdwn_07400_wood_goddamnittheyre_69");
  level util::delay_notify(2.5, "show_rc_hint");
  level.adler dialogue::queue("vox_cp_tdwn_07400_adlr_werenotdoneyetb_2d");
}

function function_761593b3() {
  level endon(#"hash_1177fa275536c828");
  level waittill(#"show_rc_hint");
  player = getplayers()[0];
  player thread util::show_hint_text(#"hash_102900bc26caa616", undefined, "rcxd_stop_hint_controller", -1);

  while(true) {
    if(player actionslotfourbuttonPressed()) {
      player notify(#"rcxd_stop_hint_controller");
      break;
    }

    waitframe(1);
  }

  thread namespace_82bfe441::fade(1, "FadeFast");
  level notify(#"hash_2c1821278dd7ecb1");
  level flag::set("af_pressed_rc_button");
  level music::setmusicstate("b6.0_rc");
  level objectives::complete("af_chase_plane", level.af_plane);
  controller = getweapon(#"hash_1a8252eba901e734");
  player giveweapon(controller);
  player switchtoweapon(controller);
  player val::set(#"chase", "disable_weapon_cycling", 1);
  level waittill(#"hash_2000b4f0550d06a6");
  player val::reset(#"chase", "disable_weapon_cycling");
  player takeweapon(controller);
}

function function_7766538b() {
  level endon(#"rc_detonate");
  level flag::wait_till("af_start_crash");
  player = getplayers()[0];
  player prompts::create(#"vehicle_attack", #"hash_6e490c4cf7210a63");

  while(true) {
    level flag::wait_till("af_start_crash");
    level flag::wait_till_clear("af_start_crash");
  }
}

function function_afa87bfc(player) {
  level endon(#"af_doing_crash");
  wait 3;
  level thread util::function_27f5f662(["vox_cp_tdwn_07500_adlr_takeoutthelandi_3b", "vox_cp_tdwn_07500_adlr_getundertheplan_10", "vox_cp_tdwn_07500_adlr_hurrybeforeitta_8a", "vox_cp_tdwn_07500_adlr_wererunningouto_0c", "vox_cp_tdwn_07500_adlr_getnearoneofthe_67"], "af_start_crash", 4);
  level flag::wait_till("af_plane_raise_gate");
  level notify(#"hash_4cd47970be99bc1b");
  snd::client_msg(#"hash_1bdccb03a5e24d52");
  clips = getEntArray("plane_floor_clip", "targetname");
  array::delete_all(clips);
  level.af_plane scene::play("scene_tkd_hit3_chase_plane", "close_doors");

  if(!level flag::get("af_plane_takeoff")) {
    level.af_plane thread scene::play("scene_tkd_hit3_chase_plane", "doorup");
  }

  level flag::wait_till("af_plane_takeoff");

  if(!level flag::get("af_doing_crash")) {
    level.af_plane thread scene::play("scene_tkd_hit3_chase_plane", "takeoff");
    thread function_ecef49a4();
    level waittill(#"hash_1aef226070f83b0b");
    thread function_b46ef638(0.1, "starting_crash_seq");
  }
}

function function_ecef49a4() {
  level waittill(#"hash_495d3e750229a2a");
  ents = getEntArray("plane_cargo", "targetname");
  ents = array::filter_classname(ents, 0, "script_model");

  foreach(ent in ents) {
    ent notsolid();
  }
}

function function_9555ada1() {
  level endon(#"hash_2c1821278dd7ecb1");
  level thread function_2205d3f9();
  level flag::wait_till("af_chase_fire_rpg");
  weapon = getweapon("launcher_standard_t9_takedown_chase");
  org = level.af_plane gettagorigin("tag_body_ramp_rear_lower_animate") + (0, 0, 60);
  trucks = getvehiclearray("af_enemy_chase_veh_l", "script_noteworthy");
  truck = array::get_all_closest(level.player.origin, trucks, undefined, 1, 5000)[0];

  if(isDefined(truck)) {
    debugaxis(truck.origin, truck.angles, 36);

    var_d5843701 = vectornormalize(truck.origin + (0, 0, 200) - org);
    var_9441d79a = anglesToForward(truck.angles);
    missile = level.player magicmissile(weapon, org, var_d5843701);
    missile missile_settarget(truck, (0, 0, 30));
  }

  level flag::wait_till("af_start_rc_car");

  while(!flag::get("af_start_crash")) {
    org = level.af_plane gettagorigin("tag_body_ramp_rear_lower_animate") + (0, 0, 60);
    var_d5843701 = vectornormalize(level.player.origin + (0, 0, 100) - org);
    missile = level.player magicmissile(weapon, org, var_d5843701);
    wait randomfloatrange(3, 5);
  }
}

function function_2205d3f9() {
  level waittill(#"hash_6526e39540234e50");
  trucks = getvehiclearray("af_enemy_chase_veh_l", "script_noteworthy");
  truck = array::get_all_closest(level.player.origin, trucks, undefined, 1, 5000)[0];

  if(isDefined(truck)) {
    snd::play("veh_tkd_chase_jeepbump_rev", truck);
    truck callback::on_vehicle_collision(&function_bfd50c68);
    truck waittill(#"death");
    snd::play("veh_tkd_chase_jeepbump_explo_01", truck);
  }
}

function function_f8223b2e() {
  self endon(#"death");
  level endon(#"hash_2b1bc16a2395a69d", #"hash_351eb749d2c8fa9c");
  var_93eeb60a = "shake_med";
  max_speed = 1000;

  while(true) {
    scalar = 1;

    if(level.rc_car.active === 1) {
      scalar = level.rc_car.vehspeed / max_speed;
      scalar = max(0, min(1, scalar));
    }

    source = self.origin;
    pitch = randomfloatrange(0, 0.15) * scalar;
    yaw = randomfloatrange(0, 0.15) * scalar;
    roll = 0;
    duration = randomfloatrange(0.25, 1);
    freqpitch = randomfloatrange(2.5, 3.5);
    freqyaw = randomfloatrange(2.5, 3.5);

    if(var_93eeb60a == "shake_med") {
      pitch = randomfloatrange(0.02, 0.35) * scalar;
      yaw = randomfloatrange(0.02, 0.25) * scalar;
      roll = randomfloatrange(0.02, 0.1) * scalar;
      duration = 1;
      freqpitch = 10;
      freqyaw = 7;
    }

    if(pitch + yaw > 0.025) {
      screenshake(source, pitch, yaw, roll, duration, 0, 0, 0, freqpitch, freqyaw);
    }

    wait duration;
  }
}

function function_9d8f5cd3() {
  level endon(#"skip_grenade");
  level flag::wait_till("af_grenade_toss");
  player = getplayers()[0];
  var_12ded760 = level.player.origin + vectornormalize(anglesToForward(level.player.angles)) * 12;
  var_99c3222f = getaiteamarray("axis");

  if(var_99c3222f.size > 0) {
    nade = var_99c3222f[0] magicgrenadetype(getweapon(#"frag_grenade"), var_12ded760, (0, 0, 0), 0.05);
  }

  player dodamage(player.health * 0.8, player.origin);
  player setstance("prone");
  player playrumbleonentity("damage_heavy");
  screenshake(player.origin, 4, 2, 3, 2.5, 0, -1, 0, 5, 3, 5, 2);
  player freezecontrolsallowlook(1);
  player val::set(#"af_knockdown", "allowdeath", 0);
  player val::set(#"af_knockdown", "disable_weapons", 1);
  wait 3;
  player setstance("crouch");
  player val::reset_all(#"af_knockdown");
  level.players[0] freezecontrolsallowlook(0);
}

function function_4c87c5cf(starting) {
  level.player endon(#"death");
  plane = level.af_plane;
  org = level.plane_mover;
  org thread function_3bbaf145();
  thread namespace_b100dd86::function_1c77193b(plane);
  start_pos = struct::get("plane_chase_start_pos", "targetname");
  plane clientfield::set("clf_cargoplane_door_sparks", 1);
  level thread function_e234cffa(plane);
  exploder::exploder_stop("hit3_prop_mist");
  accel_time = 0;

  if(starting) {
    accel_time = 3;
  }

  org moveto(start_pos.origin, 20, accel_time, 0);
  org rotateto(start_pos.angles, 20, accel_time, 0);
  thread function_b46ef638(20, "af_player_start_ride");
  snd::client_targetname(level.chase_truck, "af_truck_plr");
  snd::client_targetname(level.af_plane, "cargo_plane");
  snd::client_targetname(level.plane_mover, "cargo_plane_mover");
  level waittill(#"hash_6d8d592b136c4266");
  org moveto(start_pos.origin, 3.5, 0, 1);
  org rotateto(start_pos.angles, 3.5, 0, 1);
  flag::wait_till("af_start_ride");
  level notify(#"skip_grenade");
  end_pos = struct::get("plane_chase_end_pos", "targetname");
  var_bf626e36 = 53.5;
  var_e973bd14 = 6.5;
  org moveto(end_pos.origin, var_bf626e36 + var_e973bd14, 10, 0);
  org rotateto(end_pos.angles, var_bf626e36 + var_e973bd14, 10, 0);
  level endon(#"hash_2c1821278dd7ecb1");
  wait var_bf626e36;

  if(!flag::get("af_pressed_rc_button")) {
    level notify(#"hash_1177fa275536c828");
    level.af_plane thread scene::play("scene_tkd_hit3_chase_plane", "takeoff_fail");
    wait 1;

    if(!level flag::get("failed_chase")) {
      level flag::set("failed_chase");
      level util::missionfailedwrapper(#"hash_4efe29bbbdba2730", #"hash_4d4c51db77bea4d0");
    }
  }
}

function function_e585ec0d() {
  level.player endon(#"death");
  level endon(#"starting_crash_seq");
  org = level.plane_mover;
  end_pos = struct::get("plane_chase_end_pos", "targetname");
  start_pos = struct::get("rc_car_plane_start_pos", "targetname");
  org moveto(start_pos.origin, 0.01);
  org rotateto(start_pos.angles, 0.01);
  org waittilltimeout(0.2, #"movedone");
  var_bf626e36 = 30;
  var_e973bd14 = 12;
  org moveto(end_pos.origin, var_bf626e36 + var_e973bd14, 1);
  org rotateto(end_pos.angles, var_bf626e36 + var_e973bd14, 1);
  wait var_bf626e36;
  level flag::set("af_plane_raise_gate");
  level flag::set("af_plane_takeoff");
  thread function_b46ef638(var_e973bd14, "starting_crash_seq");
}

function function_b46ef638(time, end_notify) {
  level.player endon(#"death");

  if(isDefined(end_notify)) {
    level endon(end_notify);
  }

  if(isDefined(time)) {
    wait time;
  }

  level flag::set("failed_chase");
  level util::missionfailedwrapper(#"hash_4efe29bbbdba2730", #"hash_4d4c51db77bea4d0");
}

function function_3bbaf145() {
  level.player endon(#"death");
  level endon(#"af_plane_raise_gate");

  while(!level flag::get("af_start_rc_car")) {
    self thread scene::play("scene_tkd_hit3_chase_plane", "idle_drive");
    wait randomfloatrange(5, 10);

    if(!level flag::get("af_start_rc_car")) {
      if(randomint(2)) {
        self scene::play("scene_tkd_hit3_chase_plane", "swerve");
      } else {
        self scene::play("scene_tkd_hit3_chase_plane", "swerve2");
      }

      continue;
    }

    self thread scene::play("scene_tkd_hit3_chase_plane", "idle_drive");
  }
}

function function_3a97edf() {
  player = getplayers()[0];
  level waittill(#"rc_detonate");
  function_41c091de(player.origin);
  self waittill(#"hash_474a6dde316a444d");
  function_c716afe1(player.origin);
  self waittill(#"hash_1780176f9d302d25");
  function_9547ba99(player.origin);
  self waittill(#"hash_75c2a1c8e3b8b7f1");
  function_43cc6136(player.origin);
  self waittill(#"hash_474a6dde316a444d");
  function_c716afe1(player.origin);
  self waittill(#"hash_474a6dde316a444d");
  function_41c091de(player.origin);
  self waittill(#"hash_a71dd4f0ea1a311");
  function_46d1f44(player.origin);
  self waittill(#"hash_a71dd4f0ea1a311");
  function_46d1f44(player.origin);
  self waittill(#"hash_474a6dde316a444d");
  function_c716afe1(player.origin);
  self waittill(#"hash_474a6dde316a444d");
  function_c716afe1(player.origin);
  self waittill(#"hash_474a6dde316a444d");
  function_41c091de(player.origin);
  self waittill(#"hash_474a6dde316a444d");
  function_c716afe1(player.origin);
  self waittill(#"hash_474a6dde316a444d");
  function_c716afe1(player.origin);
  self waittill(#"hash_474a6dde316a444d");
  function_41c091de(player.origin);
}

function function_41c091de(origin) {
  screenshake(origin, 4, 0, 2, 0.66, 0, 0.66, 0, 10, 0, 20, 2);
}

function function_c716afe1(origin) {
  screenshake(origin, 2, 0, 0, 0.5, 0, 0.5, 0, 10, 0, 20, 2);
}

function function_9547ba99(origin) {
  screenshake(origin, 4, 0, 0, 1, 0, 1, 0, 5, 0, 0, 2);
}

function function_43cc6136(origin) {
  screenshake(origin, 2, 1, 1, 1, 0.2, 0.75, 0, 4, 2, 2, 4);
}

function function_46d1f44(origin) {
  screenshake(origin, 0, 5, 1, 1, 0, 1, 0, 0, 4, 2, 2);
}

function function_cd9b97a8() {
  level flag::wait_till("af_start_crash");
  self delete();
}

function function_e234cffa(plane) {
  level waittill(#"hash_2c1821278dd7ecb1");
  wait 4;
  plane clientfield::set("clf_cargoplane_door_sparks", 0);
}

function function_d9fae56b() {
  vehs = getvehiclearray("af_chase_veh", "targetname");
  chase_truck = vehs[0];
  trigs = getEntArray("get_in_truck_trig", "targetname");

  foreach(trig in trigs) {
    trig enablelinkto();
    trig linkto(chase_truck);
  }

  level.chase_truck = chase_truck;
  level.chase_truck val::set(#"chase", "allowdeath", 0);
  snd::client_targetname(level.chase_truck, "af_truck_plr");
  waitframe(1);
  var_87816bd7 = getent("bronco_probe", "targetname");

  if(isDefined(var_87816bd7)) {
    var_87816bd7 linkto(level.chase_truck, "tag_body_animate", (0, 0, 44), (0, 0, 0));
  }

  var_c4042c90 = getent("bronco_bed_probe", "targetname");

  if(isDefined(var_c4042c90)) {
    var_c4042c90 linkto(level.chase_truck, "tag_body_animate", (-48, 0, 56), (0, 0, 0));
  }

  level.chase_truck vehicle::lights_on();
  level.chase_truck vehicle::toggle_force_driver_taillights(1);
  level.chase_truck cp_takedown_fx::function_4c265dee();
  level.chase_truck thread function_c0061b42();
  level.chase_truck setmovingplatformenabled(1, 0);
}

function function_b90ebd9a() {
  util::magic_bullet_shield(level.woods);
  level.woods thread util::function_27f5f662(["vox_cp_tdwn_07200_wood_letsgomoveit_7f", "vox_cp_tdwn_07200_wood_hopin_3f", "vox_cp_tdwn_07200_wood_getinwecancatch_96"], "af_player_start_ride", 3);
  level objectives::complete("af_follow_adler", level.adler);
  objectives::function_4eb5c04a("af_get_in_truck", level.chase_truck gettagorigin("tag_bed") + (0, 0, 24));
  level flag::wait_till_any(["af_player_get_in_back", "af_player_get_in_left", "af_player_get_in_right"]);
  level.player thread actions::function_202ab848(0);
  level.player thread actions::function_b0868791("takedown", 0);
  level.player namespace_6cecf2d8::function_9fa1a484();
  level.player flag::wait_till_clear("in_action");
  level.player setstance("stand");
  level.player val::set(#"chase", "allow_crouch", 0);
  level.player val::set(#"chase", "allow_prone", 0);
  snd::client_msg("af_truck_plr_in");
  level flag::set("af_player_start_ride");
  level battlechatter::function_2ab9360b(0);
  level objectives::complete("af_get_in_truck");
  level.player = level.players[0];
  level.player cp_takedown_fx::function_ec0a577();
  thread function_d3cdf2a7();
  a_ar = getweapon(#"ar_accurate_t9");
  level.adler setweapon(a_ar);
  level.player.fakeplayer = util::spawn_player_clone(level.player);
  level.player.fakeplayer.targetname = "FakePlayer 2";
  level.player.fakeplayer ghost();
  level.player.fakeplayer dontinterpolate();
  util::nvidiaansel_scriptdisable(1);
  shot = undefined;

  if(level flag::get("af_player_get_in_back")) {
    shot = "get_in";
    anim = # "hash_5916909863e780a8";
  } else if(level flag::get("af_player_get_in_right")) {
    shot = "get_in_right";
    anim = # "hash_139b3208e93b39f5";
  } else {
    shot = "get_in_left";
    anim = # "hash_697f6a68b0ce4e60";
  }

  level.player val::set(#"getin", "allowdeath", 0);
  savegame::checkpoint_save(1);
  level.chase_truck thread scene::play("scene_tkd_hit3_chase_getin", "get_in");
  level.chase_truck clientfield::set("4x4_getin_door", 1);
  level.chase_truck setanim(#"hash_7e2b806a227352d0", 1, 0, 1);
  level thread function_db746914(shot);
  wait 0.05;
  var_1ae5ba85 = 0.2;
  var_84ce1e3d = 0.5;
  velocity = level.player getvelocity();
  speed = length(velocity);
  normalized_speed = math::normalize_value(179, 324, speed);
  blendtime = lerpfloat(var_84ce1e3d, var_1ae5ba85, normalized_speed);
  var_9c329e3d = lerpfloat(0.5, 0, normalized_speed);
  var_1f85a945 = lerpfloat(0.5, 0, normalized_speed);

  if(blendtime < 0.4) {
    var_3bf4cdb7 = 2;
  } else {
    var_3bf4cdb7 = 1;
  }

  level.player val::set(#"chase", "disable_weapons", var_3bf4cdb7);
  level.player val::set(#"chase", "freezecontrols", 1);
  level.player playerlinktoblend(level.player.fakeplayer, "tag_player", blendtime, blendtime * var_9c329e3d, 0, blendtime, blendtime * var_1f85a945, 0, 1);
  wait blendtime;
  level.player.fakeplayer show();
  level waittill(#"raise_gun");
  level.player val::reset(#"getin", "allowdeath");
  thread namespace_a052577e::function_bbedb5ab();
  level.player allowjump(0);
  level.player val::set(#"rc_chase", "allow_mantle", 0);
  level.player val::reset(#"chase", "freezecontrols");
  level.player val::reset(#"chase", "disable_weapons");
  util::nvidiaansel_scriptdisable(0);
  level flag::set("af_start_ride");
  level.chase_truck thread vehicle::go_path();
  objectives::function_4eb5c04a("af_chase_plane", level.af_plane);
  objectives::function_67f87f80("af_chase_plane", [level.af_plane], #"hash_2b84cc72687b168a");
  level.player thread function_f8223b2e();
  level waittill(#"hash_7dd48b5765cd3020");
  level.woods stopanimscripted();
  level.chase_truck thread scene::play("scene_tkd_hit3_chase");
  level.chase_truck thread function_8d9f9fd7();
  waitframe(1);
  function_6c9a840b();
  level.adler thread dialogue::queue("vox_cp_tdwn_07200_adlr_gogo_ef");
}

function function_192e7a1(a_ents) {
  var_9af87fb8 = a_ents[# "hash_11cd06b03a240cf3"];
  var_9af87fb8 notsolid();
  level flag::wait_till("af_start_rc_car");
  var_9af87fb8 hide();
}

function function_db746914(shot) {
  level.chase_truck scene::play("scene_tkd_hit3_chase_getin_player", shot, level.player.fakeplayer);
  level.player unlink();
  level.woods notsolid();
  level.adler notsolid();
  level.player val::reset(#"chase", "allow_crouch");
  level.player.overrideplayerdamage = &function_132b6d19;

  if(isDefined(level.player.fakeplayer)) {
    level.player.fakeplayer delete();
  }
}

function function_132b6d19(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex) {
  if(isDefined(boneindex) && boneindex == level.chase_truck) {
    return 0;
  }
}

function function_6c9a840b() {
  level.rc_car = vehicle::simple_spawn("player_rc_car")[0];
  level.rc_car makevehicleunusable();
  level.rc_car notsolid();
}

function function_dcc35e0b() {
  level flag::wait_till("woods_get_in_truck");

  if(!flag::get("woods_waiting_at_truck")) {
    level flag::wait_till_any(["af_player_get_in_back", "af_player_get_in_left", "af_player_get_in_right"]);
    level waittill(#"hash_6d8d592b136c4266");
  }

  level.chase_truck thread scene::play("scene_tkd_hit3_pre_chase", "exit", [level.woods]);
  level.chase_truck clientfield::set("4x4_getin_door_woods", 1);
  level.chase_truck setanim(#"hash_7310b4167a3dbe5f", 1, 0, 1);

  if(!flag::get_any(["af_player_get_in_back", "af_player_get_in_left", "af_player_get_in_right"])) {
    level waittill(#"hash_17a948f941d73226");

    if(!flag::get_any(["af_player_get_in_back", "af_player_get_in_left", "af_player_get_in_right"])) {
      level flag::wait_till_any(["af_player_get_in_back", "af_player_get_in_left", "af_player_get_in_right"]);
      level.chase_truck thread scene::play("scene_tkd_hit3_pre_chase", "chase_start", [level.woods]);
    }
  }
}

function function_8d9f9fd7() {
  level endon(#"af_start_rc_car");

  for(skip_idle = 0; true; skip_idle = 1) {
    if(!skip_idle) {
      self thread scene::play("scene_tkd_hit3_chase_adler", "loop");
    }

    wait randomfloatrange(1, 5);
    vehs = getvehiclearray("af_enemy_chase_veh_r", "script_noteworthy");

    if(vehs.size > 0) {
      vehs = array::get_all_closest(level.adler.origin, vehs);
      dot = level.chase_truck math::get_dot_forward(vehs[0].origin, 1, 1);
      shot = "shoot_right_";

      if(dot > 0.2) {
        shot = "shoot_forward_";
      } else if(dot < -0.2) {
        shot = "shoot_behind_";
      }

      shot += string(randomint(2) + 1);
      self scene::play("scene_tkd_hit3_chase_adler", shot);
      skip_idle = 0;
      continue;
    }
  }
}

function function_c0061b42() {
  self endon(#"death");

  while(true) {
    self waittill(#"hash_1bab4b4669295d55");
    self cp_takedown_fx::function_4b711786();
    self waittill(#"hash_26c4e6fedc0c9799");
    self cp_takedown_fx::function_b21aeabe();
  }
}

function function_d4dfd1df() {
  self endon(#"death");

  while(true) {
    util::debug_line(self.origin, self.origin + (0, 0, 5000), (0, 1, 0), undefined, undefined, 1);
    waitframe(1);
  }
}

function function_d3cdf2a7() {
  level flag::wait_till("af_player_start_ride");
  level waittill(#"hash_6d8d592b136c4266");
  thread function_142791a7();
  vehs = vehicle::simple_spawn("af_enemy_chase_veh");
  level.var_57c220b5 = 0;

  foreach(veh in vehs) {
    snd::client_targetname(veh, "af_enemy_chase_veh");
  }

  snd::client_msg(#"hash_706ce4bbfd6f3342");
  snd::client_msg(#"hash_754239f68f68db30");
}

function function_142791a7() {
  level.var_d18d2af9 = [];
  level.var_d18d2af9[# "af_enemy_chase_veh_r"] = 0;
  level.var_d18d2af9[# "af_enemy_chase_veh_l"] = 0;
  sides = ["af_enemy_chase_veh_l", "af_enemy_chase_veh_r"];

  foreach(side in sides) {
    level.var_d18d2af9[side] = 0;
    level flag::set(side);
  }

  while(!level flag::get("af_start_rc_car")) {
    foreach(side in sides) {
      if(level.var_d18d2af9[side] <= 0 && !level flag::get(side)) {
        level.var_d18d2af9[side] = 0;
        level flag::set(side);
      }

      if(level.var_d18d2af9[side] > 0 && level flag::get(side)) {
        level flag::clear(side);
        trigs = getEntArray(side + "_trig", "targetname");

        foreach(trig in trigs) {
          trig triggerenable(0);
        }
      }
    }

    wait 0.1;
  }
}

function function_3683d2e8(truck) {
  level.var_d18d2af9[truck.script_noteworthy]++;
  truck waittill(#"death", #"kill_self", #"hash_38e103e482582e7f");
  level.var_d18d2af9[truck.script_noteworthy]--;
}

function function_bfd50c68(params) {
  var_53c5484a = 500;

  if(!isDefined(self.var_4810ca3e)) {
    self.var_4810ca3e = 0;
  }

  if(isalive(self) && isDefined(params.entity) && params.entity == level.chase_truck && gettime() > self.var_4810ca3e) {
    self.var_4810ca3e = gettime() + var_53c5484a;
    self notify(#"crunch");
    snd::play("veh_tkd_chase_jeepbump_impact", self);
  }
}

function function_35bf824f() {
  level endon(#"af_start_rc_car");
  var_be9333bc = ["vox_cp_tdwn_07300_adlr_lookright_f4", "vox_cp_tdwn_07300_adlr_enemytotheright_c1", "vox_cp_tdwn_07300_adlr_truckontheright_c6"];
  var_539f7582 = ["vox_cp_tdwn_07300_adlr_totheleft_10", "vox_cp_tdwn_07300_adlr_trucktotheleft_59", "vox_cp_tdwn_07300_adlr_lookleft_81"];
  var_ea3f660f = 0;
  var_fb6cba84 = 0;

  while(true) {
    ret = level waittill(#"truck_spawned");
    wait randomfloatrange(3, 6);

    if(isDefined(ret.veh) && isalive(ret.veh)) {
      switch (ret.veh.script_noteworthy) {
        case # "af_enemy_chase_veh_r":
          level.adler dialogue::queue(var_be9333bc[var_fb6cba84]);
          var_fb6cba84++;

          if(var_fb6cba84 >= var_be9333bc.size) {
            var_fb6cba84 = 0;
          }

          break;
        case # "af_enemy_chase_veh_l":
          level.adler dialogue::queue(var_539f7582[var_ea3f660f]);
          var_ea3f660f++;

          if(var_ea3f660f >= var_539f7582.size) {
            var_ea3f660f = 0;
          }

          break;
      }
    }
  }
}

function function_40c45b6() {
  self endon(#"death");
  level notify(#"truck_spawned", {
    #veh: self
  });
  snd::client_targetname(self, "af_enemy_chase_veh");
  thread function_3683d2e8(self);
  self.takedamage = 1;

  while(!isDefined(self.var_761c973.riders[# "driver"])) {
    wait 0.1;
  }

  self thread monitor_death();
  driver = self.var_761c973.riders[# "driver"];
  self thread function_b5d668a4(driver);
  player = getplayers()[0];
  self thread function_367b3229(player);
  waitframe(1);
  self vehicle::lights_on();
  self vehicle::toggle_force_driver_taillights(1);
  self thread function_afa8ab9f();
  self waittill(#"kill_self");
  self flag::set("fake_dying");
  snd::play("veh_tkd_chase_npc_jeeps_skid_stop", self);
  self thread function_149a7584(level.chase_truck);
  var_b8ef2e = 0;

  if(math::get_dot_right(player.origin, 1, 1) >= 0) {
    var_b8ef2e = 1;
  }

  if(isDefined(driver) && isalive(driver) && randomfloat(1) >= 0.25) {
    wait 0.5;
    self function_ba23e9b(level.player, var_b8ef2e);
  }
}

function function_ba23e9b(player, var_b8ef2e) {
  self vehicle::get_off_path();
  wait 0.1;
  right_vec = anglestoright(self.angles);
  fwd_vec = anglesToForward(self.angles);
  var_43939108 = (-6, 0, 0);
  var_5fb21670 = (0, 0, 0);

  if(!var_b8ef2e) {
    var_43939108 += right_vec * 24;
    var_5fb21670 = -1 * right_vec;
  } else {
    var_43939108 -= right_vec * 24;
    var_5fb21670 = right_vec;
  }

  var_5fb21670 = vectornormalize(var_5fb21670);
  var_5fb21670 += (0, 0, 1);
  var_5fb21670 *= 100;
  self launchvehicle(var_5fb21670, var_43939108, 1, 1);
  self delete_riders(1);
  wait randomfloatrange(0.75, 1.5);

  if(self.takedamage) {
    self kill();
  }
}

function function_afa8ab9f() {
  self endon(#"death");
  self endon(#"delete");
  self waittill(#"hash_38e103e482582e7f");
  self vehicle::get_off_path();
}

function function_367b3229(target) {
  self endon(#"death");
  self endon(#"kill_self");
  self endon(#"delete");

  while(isalive(self)) {
    self.var_135dba79 = self math::get_dot_forward(target.origin, 1);
    waitframe(1);
    waitframe(1);
  }
}

function function_b5d668a4(passenger) {
  self endon(#"death");
  level endon(#"af_start_rc_car");
  passenger endon(#"death");
  passenger.dontdropweapon = 1;
  passenger.var_ec30f5da.ridedeathanim = undefined;
  passenger notify(#"new_death_anim");
  self thread function_868edfac(passenger);

  while(passenger.health > 1) {
    ret = passenger waittill(#"damage");

    if(passenger.health > 1) {
      level.player playhitmarker(undefined, 5, undefined, 0, 0, 0);
    }
  }

  level.player playhitmarker(undefined, 5, undefined, 1);
  passenger notify(#"fake_death");
  passenger stopanimscripted();

  if(isalive(self)) {
    self thread scene::play("scene_tkd_hit3_chase_jeep_driver", "death", [passenger]);
  }

  self notify(#"kill_self");
}

function function_868edfac(passenger) {
  self endon(#"death");
  self endon(#"hash_2b34ed034183965");
  passenger endon(#"fake_death");
  passenger endon(#"death");

  while(isalive(self)) {
    self childthread scene::play("scene_tkd_hit3_chase_jeep_driver", "idle", [passenger]);
    wait randomfloatrange(3, 5);

    while(self.var_135dba79 > 0) {
      wait randomfloatrange(1, 3);
    }

    if(isalive(self)) {
      if(self.script_noteworthy == "af_enemy_chase_veh_r") {
        self scene::play("scene_tkd_hit3_chase_jeep_driver", "Look_Back_Left", [passenger]);
        continue;
      }

      self scene::play("scene_tkd_hit3_chase_jeep_driver", "Look_Back_Right", [passenger]);
    }
  }
}

function delete_riders(launch = 0) {
  if(isDefined(self.var_761c973) && isDefined(self.var_761c973.riders)) {
    foreach(rider in self.var_761c973.riders) {
      if(isDefined(rider)) {
        rider notify(#"fake_death");

        if(launch) {
          rider stopanimscripted();
          rider val::set("chase_enemy", "allowdeath", 1);
          rider unlink();
          rider startragdoll(1);
          launch_force = rider.origin - self.origin;
          launch_force = (vectornormalize(launch_force) + anglestoup(self.angles)) * 50;
          rider launchragdoll(launch_force);
          continue;
        }

        rider deletedelay();
      }
    }

    self.var_761c973.riders = [];
  }
}

function monitor_death() {
  level endon(#"death");
  self waittill(#"death");
  self delete_riders(1);
  level.var_57c220b5++;
  level notify(#"hash_25795a7707b10909");
}

function function_9535c641() {
  level.var_55e62e4f = vehicle::simple_spawn_and_drive("af_enemy_deploy_veh_r");
  level.var_55e62e4f = arraycombine(level.var_55e62e4f, vehicle::simple_spawn_and_drive("af_enemy_deploy_veh_l"));
  level.var_55e62e4f = arraycombine(level.var_55e62e4f, vehicle::simple_spawn_and_drive("af_enemy_deploy_veh_f"));
  level.var_57c220b5 = 0;

  foreach(veh in level.var_55e62e4f) {
    veh.script_noteworthy = "rc_enemy";
    level.var_d18d2af9[veh.script_noteworthy] = 0;
    veh thread function_40c45b6();
    veh thread function_e6320cb3();
    veh vehicle::lights_on();
    veh vehicle::toggle_force_driver_taillights(1);
    veh thread function_6b9d341b();

    if(getdvarint(#"hash_1d23302b87198714", 0) == 1) {
      veh vehicle::god_on();
      veh val::set(#"rc_chase", "allowdeath", 0);
    }
  }
}

function function_6b9d341b() {
  self endon(#"death");
  self waittill(#"lights_off");
  self vehicle::lights_off();
  self vehicle::toggle_force_driver_taillights(0);
}

function function_7730c3f4() {
  level.rc_car thread function_f311ea18(1);
  level.player = level.players[0];
  level.chase_truck clientfield::set("af_rc_deploy1", 1);
  level.chase_truck setanim(#"hash_65fb765a66b27ef1", 1, 0, 1);
  level scene::play("scene_tkd_hit3_chase_deploy_rc", "enter");
  level thread scene::play("scene_tkd_hit3_chase_deploy_rc", "loop");
  level.chase_truck setanim(#"hash_77cbdb56c22e71f", 1, 0, 1);
  level.chase_truck clientfield::set("af_rc_deploy2", 1);
  level waittill(#"hash_32caebf20e289c77");
  waitframe(1);
  wait 2;
}

function function_3c7a908d(var_50cc0d4f) {
  thread namespace_a052577e::function_b3b2671a(level.player);
  snd::client_targetname(level.af_plane, "cargo_plane");
  snd::client_targetname(level.plane_mover, "cargo_plane_mover");
  snd::client_targetname(level.chase_truck, "af_truck_plr");
  snd::client_targetname(level.rc_car, "rc_car_plr");
  thread namespace_a052577e::function_1e281573();
  level.chase_truck clientfield::set("af_rc_deploy3", 1);
  level.chase_truck setanim(#"hash_3be8472c6114d6b6", 1, 0, 1);
  level thread scene::play("scene_tkd_hit3_chase_deploy_rc", "exit");
  level.player cp_takedown_fx::function_701c25a5();
  level.player util::delay(0.5, undefined, &cp_takedown_fx::function_a31136d8);
  level waittill(#"hash_2b34ed034183965");
  level flag::set("no_more_truck_chase");
  vehs = arraycombine(getvehiclearray("af_enemy_chase_veh_l", "script_noteworthy"), getvehiclearray("af_enemy_chase_veh_r", "script_noteworthy"));

  foreach(veh in vehs) {
    veh vehicle_death::death_cleanup_riders();
    veh delete();
  }

  guys = getaiarray("af_vh_enemy", "targetname");
  array::delete_all(guys);
  level notify(#"rcxd_stop_hint_controller");
  guys = getaiteamarray("axis");
  guys = array::exclude(level.var_2e151cca);
  array::delete_all(guys);
  corpses = ai::function_4f84c3ed();
  array::delete_all(corpses);
  level.player cp_takedown_fx::function_2be1d5b0();
  self thread scene::play("scene_tkd_hit3_chase_adler", "loop");
  level.chase_truck thread scene::play("scene_tkd_hit3_chase", "loop");
  waitframe(1);
  level.player enableweapons();
  level.player stopanimscripted(0, 1);
  level.rc_car solid();
  level.rc_car unlink();
  level.rc_car stopanimscripted(0, 1);
  level.player setplayerangles((0, 0, 0));
  level.rc_car makevehicleusable();
  waitframe(1);
  level.player val::set(#"rc_launch", "freezecontrols", 1);
  var_a00e7b18 = level.chase_truck.angles - (0, 3, 0);
  level.rc_car.angles = var_a00e7b18;
  push = 42;

  if(var_50cc0d4f) {
    push = 36;
  }

  level.rc_car launchvehicle(vectornormalize(anglesToForward(var_a00e7b18)) * push);
  wait 0.5;
  waitframe(1);

  if(!level.player vehicle::player_is_driver()) {
    level notify(#"rcxd_stop_hint_controller");
    level.rc_car makevehicleusable();
    level.rc_car usevehicle(level.player, 0);
  }

  level.rc_car makevehicleunusable();
  waitframe(1);
  level notify(#"car_on_ground");
  level flag::set("rc_car_on_ground");
  level notify(#"hash_6f65948492627624");
  level.rc_car thread function_c6a4d54b();
  wait 0.5;
  n_current_speed = level.chase_truck getspeedmph();
  level.chase_truck setspeed(n_current_speed * 0.8);
  level objectives::function_4eb5c04a("af_chase_plane_rc", level.var_c7b3a621);
  level objectives::function_67f87f80("af_chase_plane_rc", [level.var_c7b3a621], #"hash_2b84cc72687b168a");
}

function function_53e16f01(params) {
  if(getdvarint(#"hash_72994415c8ecf806", 0) > 0) {
    return;
  }

  if(!isDefined(self.damage_timer)) {
    self.damage_timer = 0;
  }

  var_d1148f2f = 1000;
  screenshake(self.origin, 2, 2, 6, 1, 0, -1, 0, 8, 4, 2, 2);
  level.player playrumbleonentity("damage_heavy");

  if(isDefined(params.entity) && !(isDefined(params.entity.targetname) && params.entity.targetname == "crater_clip")) {
    fwd_vec = anglesToForward(self.angles);
    dot = vectordot(fwd_vec, params.normal);
    var_9602c3bf = params.normal;

    if(dot < 0) {
      var_9602c3bf = vectornormalize(params.normal + fwd_vec);
    }

    knockback = -5;
    self launchvehicle(params.normal * knockback, (0, 0, 0), 1, 0);
  }

  if(isDefined(params.entity) && gettime() > self.damage_timer) {
    self cp_takedown_fx::function_6bd3950d(25);
    self.damage_timer = gettime() + var_d1148f2f;
  }
}

function function_bc4a48ea() {
  level endon(#"death");
  level waittill(#"car_on_ground");
  wait 5;
  weapon = getweapon("launcher_standard_t9_takedown_chase");

  while(!level flag::get("af_plane_raise_gate") && isalive(level.plane_rpg_guy)) {
    org = level.plane_rpg_guy gettagorigin("tag_flash");
    var_b26e76e3 = level.rc_car.origin + (vectornormalize(anglesToForward(level.rc_car.angles)) + vectornormalize(org - level.rc_car.origin) * 0.5) * 750;
    var_b26e76e3 = (var_b26e76e3[0], var_b26e76e3[1], level.rc_car.origin[2]);

    if(distancesquared(var_b26e76e3, org) < 40000) {
      var_b26e76e3 = level.rc_car.origin;
    }

    var_d5843701 = vectornormalize(var_b26e76e3 - org);
    missile = level.player magicmissile(weapon, org, var_d5843701);
    playFXOnTag(#"hash_338c0ef8c7e88199", level.plane_rpg_guy, "tag_flash");
    missile thread function_e652a247();
    wait randomfloatrange(3, 6);
  }
}

function function_e652a247() {
  level endon(#"death");
  level endon(#"af_plane_raise_gate");
  getplayers()[0] endon(#"death");
  var_74fc3359 = struct::get("runway_center", "targetname");
  self waittill(#"death");

  crater = spawn("script_model", (self.origin[0], self.origin[1], var_74fc3359.origin[2]));
  crater hide();
  crater.angles = (0, randomfloatrange(0, 360), 0);
  crater setModel("p8_zm_esc_spawn_cap_crater");
  snd::play("wpn_tkd_chase_rpg_imp", self);
  crater setscale(0.15);
  crater show();
  clip = getent("crater_clip", "targetname");

  if(isDefined(clip) && isDefined(crater)) {
    clip.origin = crater.origin;
    clip.angles = crater.angles;
    level waittill(#"starting_crash_seq");
    crater delete();
    clip.origin -= (0, 0, 20);
  }
}

function function_c6a4d54b() {
  level endon(#"af_plane_raise_gate");
  level flag::wait_till("af_enemy_skid");

  while(level.rc_car.angles[1] > 10 && level.rc_car.angles[1] < 180) {
    waitframe(1);
  }

  var_4a0d7a89 = level.rc_car getspeedmph();

  if(var_4a0d7a89 < 63) {
    wait 2;
  }

  thread function_f92dfd2c();
  y_offset = 500;

  if(level.rc_car.origin[1] > level.af_plane.origin[1]) {
    y_offset = 100 + level.rc_car.origin[1] - level.af_plane.origin[1];
  }

  org = util::spawn_model("tag_origin", level.af_plane.origin, (0, 0, 0));
  org linkto(level.af_plane, undefined, (500, y_offset, -15), (0, 0, 0));
  veh = vehicle::simple_spawn_single_and_drive("skid_veh");
  snd::client_targetname(veh, "skid_veh");
  thread namespace_a052577e::function_32f20d13(veh);
  wait 0.1;
  veh vehicle::lights_on();
  veh vehicle::toggle_force_driver_taillights(1);
  org scene::play("scene_tkd_hit3_chase_jeep_deaths", "runway_skid", [veh]);
}

function function_f92dfd2c() {
  var_ba5c0429 = 2000;

  for(i = 1; i <= 5; i++) {
    foreach(truck in level.var_55e62e4f) {
      if(isDefined(truck) && isalive(truck) && !truck flag::get("fake_dying")) {
        if(level.af_plane.origin[0] - truck.origin[0] < var_ba5c0429) {
          truck setspeed(50, 20, 20);
        }
      }
    }

    wait 1;
  }
}

function function_f311ea18(var_bbe56cd4 = 0) {
  self notify("15baf9de2b6ce26f");
  self endon("15baf9de2b6ce26f");
  self endon(#"death");

  if(var_bbe56cd4) {
    level waittill(#"hash_32caebf20e289c77");
  }

  self cp_takedown_fx::function_f0ecd8();
  self cp_takedown_fx::function_3419411b();
  level waittill(#"car_on_ground");
  self.active = 1;
  self thread function_2682a954();
  wait 2;
  level.rc_car callback::on_vehicle_collision(&function_53e16f01);
  level waittill(#"rc_detonate");
  self.active = undefined;
  self cp_takedown_fx::function_fe8be1e0();
}

function function_2682a954() {
  self endon(#"death");
  level endon(#"rc_detonate");

  while(true) {
    self cp_takedown_fx::function_323b6e10();
    level flag::wait_till("af_start_crash");
    self cp_takedown_fx::function_53bd0317();
    level flag::wait_till_clear("af_start_crash");
  }
}

function function_db378ce0() {
  self endon(#"death");
  self endon(#"fake_death");
  self val::set("chase_enemy", "allowdeath", 0);
  self.dontdropweapon = 1;

  if(isDefined(level.var_89cb0a79) && !level flag::get("af_pressed_rc_button")) {
    curtime = gettime();
    var_76fc2ac9 = curtime - level.var_89cb0a79;

    if(var_76fc2ac9 > 10000) {
      self thread function_a75da416();
    }
  }

  if(isDefined(self.script_noteworthy)) {
    while(!isDefined(self.vehicle)) {
      wait 0.1;
    }

    self.var_ec30f5da.ridedeathanim = undefined;
    self notify(#"new_death_anim");

    if(!isDefined(self.vehicle.var_349e69c4)) {
      self.vehicle.var_349e69c4 = 0;
    }

    self.vehicle.var_349e69c4++;
    anim_scene = "scene_tkd_hit3_chase_jeep_rollbar_le_en2";
    var_fa4b90bc = "roll_r1";

    switch (self.script_noteworthy) {
      case # "hash_1326aeed0f386d94":
        var_fa4b90bc = "tag_passenger2";
        anim_scene = "scene_tkd_hit3_chase_jeep_rollbar_le_en2";
        break;
      case # "roll_l2":
        var_fa4b90bc = "tag_passenger3";
        anim_scene = "scene_tkd_hit3_chase_jeep_rollbar_le_en3";
        break;
      case # "hash_1326b0ed0f3870fa":
        var_fa4b90bc = "tag_passenger1";
        anim_scene = "scene_tkd_hit3_chase_jeep_rollbar_le_en4";
        break;
      case # "roll_r1":
        var_fa4b90bc = "tag_passenger2";
        anim_scene = "scene_tkd_hit3_chase_jeep_rollbar_ri_en2";
        break;
      case # "hash_12c099ed0ee196b3":
        var_fa4b90bc = "tag_passenger3";
        anim_scene = "scene_tkd_hit3_chase_jeep_rollbar_ri_en3";
        break;
      case # "hash_12c098ed0ee19500":
        var_fa4b90bc = "tag_passenger1";
        anim_scene = "scene_tkd_hit3_chase_jeep_rollbar_ri_en4";
        break;
      case # "hash_48024b666fce275a":
        var_fa4b90bc = "tag_passenger2";
        anim_scene = "scene_tkd_hit3_chase_jeep_hardtop_le_en2";
        break;
      case # "hard_l2":
        var_fa4b90bc = "tag_passenger3";
        anim_scene = "scene_tkd_hit3_chase_jeep_hardtop_le_en3";
        break;
      case # "hash_480249666fce23f4":
        var_fa4b90bc = "tag_passenger1";
        anim_scene = "scene_tkd_hit3_chase_jeep_hardtop_le_en4";
        break;
      case # "hash_47e02f666fb11160":
        var_fa4b90bc = "tag_passenger2";
        anim_scene = "scene_tkd_hit3_chase_jeep_hardtop_ri_en2";
        break;
      case # "hash_47e032666fb11679":
        var_fa4b90bc = "tag_passenger3";
        anim_scene = "scene_tkd_hit3_chase_jeep_hardtop_ri_en3";
        break;
      case # "hash_47e031666fb114c6":
        var_fa4b90bc = "tag_passenger1";
        anim_scene = "scene_tkd_hit3_chase_jeep_hardtop_ri_en4";
        break;
    }

    self.vehicle thread scene::play(anim_scene, "idle", [self]);
    org = util::spawn_model("tag_origin", self.vehicle.origin, self.vehicle.angles);
    org linkto(self.vehicle, var_fa4b90bc, (0, 0, 0), (0, 0, 0));
    self thread function_f6fcf011(org, anim_scene);
  }

  self thread function_ebfff762();

  if(isDefined(self.script_noteworthy)) {
    idle_shots = 1;

    if(scene::function_9730988a(anim_scene, "idle3")) {
      idle_shots = 3;
    }

    while(!level flag::get("af_start_crash")) {
      var_6eeb49c8 = "firing";

      if(isDefined(self.vehicle.var_135dba79)) {
        if(self.vehicle.var_135dba79 > -0.36) {
          var_6eeb49c8 = "firing_side";
        }

        if(self.vehicle.var_135dba79 < -0.98) {
          var_6eeb49c8 = "firing_rear";
        }
      }

      self stopanimscripted();
      org scene::play(anim_scene, var_6eeb49c8, [self]);

      if(self.health > 1) {
        var_ae72f23a = randomintrange(1, idle_shots + 1);
        var_27e1b0d4 = "idle";

        if(var_ae72f23a > 1) {
          var_27e1b0d4 += string(var_ae72f23a);
        }

        org thread scene::play(anim_scene, var_27e1b0d4, [self]);
        level notify(#"chase_walla", {
          #enemy: self
        });
        wait randomfloatrange(0.2 * self.vehicle.var_349e69c4, 0.5 * self.vehicle.var_349e69c4);
      }

      waitframe(1);
    }
  }

  level flag::wait_till("af_start_crash");

  if(isDefined(org)) {
    org delete();
  }

  if(isDefined(self) && isalive(self)) {
    self deletedelay();
  }
}

function function_ebfff762() {
  self endon(#"death");
  self endon(#"fake_death");
  level endon(#"af_start_rc_car");

  while(true) {
    self waittill(#"damage");
    level.player playhitmarker(undefined, 5, undefined, 0, 0, 0);
  }
}

function function_f6fcf011(org, scene) {
  level endon(#"hash_2b34ed034183965");
  level endon(#"af_start_crash");
  self endon(#"death");
  self endon(#"delete");
  self.vehicle endon(#"death");

  while(self.health > 2) {
    wait 0.1;
  }

  waitframe(1);
  self.vehicle.var_349e69c4--;

  if(self.vehicle.var_349e69c4 == 0) {
    if(true) {
      self.vehicle notify(#"kill_self");
    } else {
      self.vehicle notify(#"hash_38e103e482582e7f");
    }
  }

  level.player playhitmarker(undefined, 5, undefined, 1);
  self notify(#"fake_death");

  if(isDefined(self.script_noteworthy)) {
    var_f1fd7a1c = "death";

    if(randomfloat(1) >= 0.25) {
      var_f1fd7a1c = "death2";
    }

    org scene::play(scene, var_f1fd7a1c, [self]);

    if(isalive(self)) {
      self stopanimscripted();
      self val::set("chase_enemy", "allowdeath", 1);
      self deletedelay();
    }
  }
}

function function_149a7584(var_ba735fae) {
  self endon(#"crash_done", #"crash_move_done", #"death");
  self thread vehicle_death::monitor_ground_vehicle_crash_collision();
  self.crashing = 1;
  n_current_speed = self getspeedmph();

  if(n_current_speed > 0 || is_true(self.b_stopped_crash)) {
    if(self vehicle_death::is_crash_detour_nearby()) {
      self notify(#"crashpath", {
        #path: self.nd_crash_path
      });
      self.nd_crash_path.derailed = 1;
      self notify(#"newpath");
      nd_switch = self.currentnode vehicle_death::get_switch_node(self.nd_crash_path);
      self setswitchnode(nd_switch, self.nd_crash_path);
      self thread vehicle_death::watch_for_crash_detour_scene(self.nd_crash_path);

      if(n_current_speed == 0) {
        n_current_speed = 5;
        self setbrake(0);
        self vehicle::resume_path();
        self resumespeed(5);
      }

      n_set_speed = n_current_speed * 3;
      self setspeed(n_set_speed, n_set_speed / 2);
      self waittilltimeout(15, #"reached_end_node");
    } else {
      self vehicle::detach_path();

      if(self math::get_dot_right(var_ba735fae.origin, 1, 1) > 0) {
        n_modifier = 1;
      } else {
        n_modifier = -1;
      }

      if(n_current_speed == 0) {
        n_current_speed = 5;
        self setbrake(0);
        self vehicle::resume_path();
        self resumespeed(5);
      }

      v_goal = self.origin + anglesToForward(self.angles + (0, n_modifier * 35, 0)) * 600;
      a_trace = physicstraceex(v_goal + (0, 0, 200), v_goal - (0, 0, 1000));
      n_set_speed = n_current_speed * 3;
      self setspeed(n_set_speed, n_set_speed / 2);
      self function_a57c34b7(a_trace[# "position"], 0);
      self waittilltimeout(15, #"near_goal");
      self vehicle_ai::clearallmovement(1);
      self vehicle_ai::clearalllookingandtargeting();
    }
  }

  self notify(#"crash_done");
}

function function_326abc48() {
  level endon(#"starting_crash_seq");
  var_8bd12fb4 = 2;
  var_1d542590 = 1;
  level.var_e37c1d1 = 0;

  while(true) {
    waitresult = level waittill(#"chase_walla");

    if(level.var_e37c1d1 < var_8bd12fb4) {
      waitresult.enemy thread function_e4f900a2(var_1d542590);
    }
  }
}

function function_e4f900a2(var_effc03f2) {
  level.var_e37c1d1++;
  wait var_effc03f2;
  level.var_e37c1d1--;
}

function function_1c4bdba5() {
  level.player endon(#"blow_rc_car");
  var_b2462917 = 30;
  var_b2462917 *= 12;

  while(true) {
    var_72f2834e = level.rc_car.origin + anglesToForward(level.rc_car.angles) * 150;

    if(var_72f2834e[0] - level.chase_truck.origin[0] > var_b2462917) {
      level notify(#"hash_4a8efa61ddc01361");
      break;
    }

    waitframe(1);
  }
}

function function_e6320cb3() {
  level.player endon(#"blow_rc_car");
  level.player endon(#"death");
  level endon(#"failed_chase");
  self endon(#"death");
  var_908eb0a2 = 50;
  var_908eb0a2 *= 12;
  var_908eb0a2 *= var_908eb0a2;
  var_5d248f34 = -1 * cos(25);
  level waittill(#"hash_4a8efa61ddc01361");

  while(!level flag::get("failed_chase")) {
    var_72f2834e = level.rc_car.origin + anglesToForward(level.rc_car.angles) * 150;
    var_51fb6d83 = distance2dsquared(self.origin, var_72f2834e);

    if(var_51fb6d83 <= var_908eb0a2) {
      var_25e859c2 = self math::get_dot_forward(var_72f2834e, 1, 1);

      if(var_25e859c2 < 0 && var_25e859c2 > var_5d248f34) {
        right_dot = self math::get_dot_right(var_72f2834e, 1, 1);

        if(right_dot > 0) {
          self function_b9613eb(1);
        } else {
          self function_b9613eb(0);
        }
      }
    }

    waitframe(1);
  }
}

function function_b9613eb(right = 1, speed_pct = 1, var_4c7dbda9 = 10, var_6466f659 = 100, var_28ec8367 = 2000) {
  level.player endon(#"death");
  level endon(#"failed_chase");
  self endon(#"death");
  level.player endon(#"blow_rc_car");
  n_modifier = 1;

  if(right) {
    n_modifier = -1;
  }

  var_6466f659 *= 12;
  var_28ec8367 = sqr(var_28ec8367);
  cur_node = self.currentnode;

  if(!isDefined(cur_node.target)) {
    return;
  }

  next_node = getvehiclenode(cur_node.target, "targetname");
  self vehicle::detach_path();
  n_current_speed = self getspeedmph();
  v_goal = self.origin + anglesToForward(self.angles + (0, n_modifier * var_4c7dbda9, 0)) * var_6466f659;
  a_trace = physicstraceex(v_goal + (0, 0, 200), v_goal - (0, 0, 200));
  self setspeed(n_current_speed * speed_pct);

  self function_a57c34b7(a_trace[# "position"], 0);
  self waittilltimeout(3, #"near_goal");
  var_56b3db36 = math::get_dot_forward(next_node.origin, 1, 1);
  var_26b9354a = cos(var_4c7dbda9);

  while(isDefined(next_node) && distance2dsquared(next_node.origin, self.origin) < var_28ec8367) {
    cur_node = next_node;
    next_node = getvehiclenode(cur_node.target, "targetname");
  }

  if(isDefined(next_node)) {
    self function_a57c34b7(next_node.origin, 0);
    self waittill(#"near_goal");
    self vehicle::get_on_path(cur_node.target, "targetname");
    self thread vehicle::go_path();
  }
}

function function_6e899b0e() {
  level endon(#"hash_2c1821278dd7ecb1");

  while(!isDefined(self.groundentity)) {
    waitframe(1);
  }

  var_a997b436 = 0;

  while(!level flag::get("failed_chase") && !level flag::get("af_pressed_rc_button")) {
    if(!isDefined(self.groundentity)) {
      var_a997b436++;

      if(var_a997b436 >= 8) {
        level.player allowcrouch(0);
        level.player setstance("stand");
        waitframe(1);
        level.player dontinterpolate();
        level.player playerlinkto(level.chase_truck, "tag_bed");
        level.player allowcrouch(1);
        return;
      }
    } else {
      var_a997b436 = 0;
    }

    waitframe(1);
  }
}

function function_e90d5c1() {
  level endon(#"hash_2c1821278dd7ecb1");
  player = self;
  level.var_89cb0a79 = gettime();
  tag_time = 10;

  for(var_c500345d = player function_ab88cc4(); var_c500345d > 0; var_c500345d = player function_ab88cc4()) {
    ret = player waittilltimeout(tag_time, #"weapon_fired");

    if(ret._notify == # "timeout") {
      guys = getaiarray("af_vh_enemy", "targetname");
      array::thread_all(guys, &function_a75da416);
      player waittill(#"weapon_fired");
    }

    level.var_89cb0a79 = gettime();
    level notify(#"hash_7fa2ac712408ddb9");
  }
}

function function_a75da416() {
  level endon(#"hash_7fa2ac712408ddb9");
  level endon(#"hash_2c1821278dd7ecb1");
  self endon(#"death");
  var_f4ba5757 = getweapon("ar_standard_t9_noballistics");
  player = getplayers()[0];

  while(!isDefined(level.var_89cb0a79)) {
    waitframe(1);
  }

  while(!level flag::get("af_pressed_rc_button")) {
    self waittill(#"fire");
    curtime = gettime();
    var_76fc2ac9 = curtime - level.var_89cb0a79;
    var_4e1914bc = var_76fc2ac9 / 20000;
    rand = randomfloat(1);

    if(rand < var_4e1914bc) {
      org = self gettagorigin("tag_flash");
      dest = player gettagorigin("tag_eye");
      magicbullet(var_f4ba5757, org, dest, self, player);
    }
  }
}

function function_ab88cc4() {
  var_12078aec = self getweaponslist();
  ammo = 0;

  foreach(weap in var_12078aec) {
    ammo += self getammocount(weap);
  }

  return ammo;
}

function function_2016824f() {
  trig = getent(self.linkto, "linkname");

  if(isDefined(trig)) {
    trig enablelinkto();
    trig linkto(self);
  }
}

function function_31c124f2() {
  var_87d63211 = ["truck_challenge1", "truck_challenge2", "truck_challenge3", "truck_challenge4", "truck_challenge5"];
  var_5dc5c128 = 0;

  while(var_5dc5c128 < 3) {
    ret = flag::wait_till_any(var_87d63211);
    var_87d63211 = array::exclude(var_87d63211, ret._notify);
    var_5dc5c128++;
    waitframe(1);
  }

  if(level.player stats::get_stat_global(#"hash_6cf378bf26dccb10") == 0) {
    level.player stats::function_dad108fa(#"hash_6cf378bf26dccb10", 1);
  }
}