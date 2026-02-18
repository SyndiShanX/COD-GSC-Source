/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3890e6e179f6ed13.gsc
***********************************************/

#using script_15a7051a4ff0cf46;
#using script_30cfffd6b7b2b212;
#using script_37f9ff47f340fbe8;
#using script_3dc93ca9902a9cda;
#using script_67332a4d085a140a;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\easing;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_sp;
#using scripts\cp_common\snd_utility;
#using scripts\cp_common\util;
#namespace namespace_347b95ee;

function starting(var_d3440450) {
  level.var_aece851d = [];
  snd::client_msg("heli_intro_submix");
  level thread scene::init_streamer(#"scene_tkd_hit1_intro_fly_in", getplayers());
  level thread scene::init_streamer(#"scene_tkd_hit1_intro_fly_in_trucks", getplayers());
  level thread function_c6662dbb("intro_enemy_trucks");
  level thread function_3d66ebcc("intro_heli_player");
  namespace_42da7c51::function_ed760ecb("woods", 0);
  level.fake_player = util::spawn_player_clone(level.player);
  level.fake_player.targetname = "FakePlayer";
  actors = [];
  actors[actors.size] = level.woods;
  actors[actors.size] = level.player_heli;
  actors[actors.size] = level.fake_player;
  level thread scene::init("scene_tkd_hit1_intro_fly_in", actors);
}

function main(var_d3440450, var_50cc0d4f) {
  player = getplayers()[0];
  player val::set(#"intro", "freezecontrols", 1);
  level util::screen_fade_out(0);
  player clientfield::set_to_player("force_stream_weapons", 1);
  level thread intro_vo();
  var_4b971330 = skipto::function_99ddd76d();
  clientfield::set("stream_heli", 1);
  level globallogic_ui::function_7bc0e4b9(1, var_4b971330);
  clientfield::set("stream_heli_woods", 1);
  level thread function_6577ae08();
  level.player takeallweapons();
  wait 2;
  player val::reset(#"intro", "freezecontrols");
  level notify(#"hash_1f3766ce8880c1ab");
  level util::screen_fade_in(1);
  level flag::wait_till("heli_intro_complete");
  clientfield::set("stream_heli_woods", 0);
  clientfield::set("stream_heli", 0);
  level.woods sethighdetail(0);
  level.player_heli sethighdetail(0);

  if(isDefined(var_50cc0d4f)) {
    skipto::function_4e3ab877(var_50cc0d4f);
  }
}

function intro_vo() {
  wait 3;
  level dialogue::radio("vox_cp_chao_03000_masn_icantbelieveald_c9");
  wait 0.75;
  level notify(#"hash_7fd5da39cde7ddef");
  level dialogue::radio("vox_cp_chao_03000_wood_betrayedthewhol_39");
  level notify(#"heli_intro_vo_done");
}

function cleanup(name, starting, direct, player) {
  if(player) {
    level thread function_c9c8c2f5(level.var_28c22d88[0] === "tkdn_heli_convoy_aslt");
  }
}

function function_c9c8c2f5(var_799ecb8e = 0) {
  level.var_aece851d = [];

  if(is_true(var_799ecb8e)) {
    function_c6662dbb("intro_enemy_trucks");
    level flag::wait_till("flag_convoy_assault_started");
    level.fake_player = util::spawn_player_clone(level.player);
    level.fake_player.targetname = "FakePlayer";
    level function_3d66ebcc("intro_heli_player");
    level thread function_6577ae08(1);
    level flag::set("heli_intro_complete");
    return;
  }

  level flag::set("heli_intro_complete");
  spawner::add_spawn_function_group("intro_enemy_truck_guys", "targetname", &namespace_42da7c51::function_2afe54);
  level flag::wait_till(#"all_players_spawned");
  function_c6662dbb("intro_enemy_trucks");
  level scene::add_scene_func("scene_tkd_hit1_intro_fly_in_trucks", &function_6e628723);
  level thread scene::play_from_time("scene_tkd_hit1_intro_fly_in_trucks", level.var_abaa6487, undefined, 0.95, 1);
  level.player clientfield::set_to_player("toggle_gameplayer_character_vis", 1);
}

function function_6e628723(a_ents) {
  foreach(ent in a_ents) {
    if(isactor(ent) && !isvehicle(ent)) {
      ent delete();
    }
  }
}

function init_clientfields() {
  clientfield::register("vehicle", "hit1_helispotlight", 1, 1, "int");
  clientfield::register("vehicle", "hit1_track_vehicle", 1, 1, "int");
  clientfield::register("scriptmover", "hit1_track_ent", 1, 1, "int");
  clientfield::register("scriptmover", "hit1_tracking", 1, 1, "int");
  clientfield::register("scriptmover", "hit1_light", 1, 1, "int");
}

function function_619f168c(a_ents) {
  a_ents[# "hash_32bf1e4d7ae150d1"].script_friendname = "";
  a_ents[# "hash_32bf1b4d7ae14bb8"].script_friendname = "";
  a_ents[# "hash_32bf1c4d7ae14d6b"].script_friendname = "";
  a_ents[# "hash_32bf214d7ae155ea"].script_friendname = "";
  a_ents[# "ally_1"].script_friendname = "";
  a_ents[# "ally_2"].script_friendname = "";
  level.var_5b74d56b = [a_ents[# "hash_32bf1c4d7ae14d6b"], a_ents[# "hash_32bf214d7ae155ea"], a_ents[# "ally_1"], a_ents[# "ally_2"]];
}

function function_a3927872(heli, pos) {
  self waittill(#"hash_5cfb388ebefafba9");
  vehicle::get_in(self, heli, pos);
}

function function_7b72a44c() {
  level waittill(#"hash_6c0a0fd5bbb788ed");
  array::thread_all(level.var_abaa6487, &vehicle::function_ea0f8324);
}

function function_bff76496(f) {
  level flag::wait_till(f);

  debug2dtext((1500, 700, 0), f, (1, 1, 1), 1, (0, 0, 0), 0, 1, 40);
}

function function_3b697267() {
  level.player dontinterpolate();
  level.player playerlinktodelta(level.fake_player, "tag_player", 1, 30, 15, 15, 30, 1, 1);
  level.player util::function_749362d7(1);
  level flag::wait_till("heli_player_gets_weapon");
  level.player namespace_42da7c51::function_6154e4c2();
  level flag::wait_till("heli_intro_complete");
  level.player playerlinktoblend(level.fake_player, "tag_player", 0.5);
  level.fake_player hide();
  level.player unlink();
  level.player util::function_749362d7(0);
  wait 0.5;
  level.player val::reset_all("takedown_hit1_intro");
  level notify(#"hash_2769bf067f3ba0cb");
}

function function_3d66ebcc(tname) {
  level.var_40b02b72 = vehicle::simple_spawn(tname);
  level.var_40b02b72[level.var_40b02b72.size] = vehicle::simple_spawn_single("intro_heli_ally");
  level.player_heli = level.var_40b02b72[0];
  level.var_9a3944f4 = level.var_40b02b72[1];

  if(isDefined(level.var_40b02b72[1].script_noteworthy)) {
    level.player_heli = level.var_40b02b72[1];
    level.var_9a3944f4 = level.var_40b02b72[0];
  }

  level.player_heli sethighdetail(1);
  level.player_heli flag::init("player_heli_landing");

  foreach(chopper in level.var_40b02b72) {
    chopper thread namespace_42da7c51::function_fbb0d73f();
  }

  level.player_heli hidepart("tag_origin", "veh_t9_mil_us_helicopter_large_right_gun_mount_attach", 1);
  level.player_heli hidepart("tag_origin", "veh_t9_mil_us_helicopter_large_left_gun_mount_attach", 1);
  level.player_heli hidepart("tag_origin", "veh_t9_mil_us_helicopter_large_weapons_mount_attach", 1);
  thread namespace_42da7c51::heli_light(level.var_9a3944f4, "ally_heli_spot_light_bustout", "tag_fx_running_light_front_side_left_01", (-20, 12, 0), level.var_9a3944f4, 0, 1);
  level.var_9a3944f4 thread namespace_42da7c51::function_3cebcd1b();
  level.player_heli.probe = getent("heli_probe", "targetname");

  if(isDefined(level.player_heli.probe)) {
    level.player_heli.probe linkto(level.player_heli, "tag_body_animate", (24, 0, -48), (0, 0, 0));
  }

  level.player_heli.var_6098f318 = getent("heli_cab_probe", "targetname");

  if(isDefined(level.player_heli.var_6098f318)) {
    level.player_heli.var_6098f318 linkto(level.player_heli, "tag_body_animate", (88, 0, -48), (0, 0, 0));
  }
}

function function_6577ae08(skipto_end = 0) {
  setDvar(#"hash_3d9a09e7ecea2271", 0);
  level flag::wait_till(#"all_players_spawned");
  actors = [];
  actors[level.player_heli.targetname] = level.player_heli;
  actors[level.var_9a3944f4.targetname] = level.var_9a3944f4;
  actors[# "fakeplayer"] = level.fake_player;
  var_841e373 = getspawnerarray("intro_heli_crew", "script_noteworthy");
  crew = [];

  foreach(sp in var_841e373) {
    crew[crew.size] = sp spawner::spawn(1);
  }

  actors = arraycombine(actors, crew);
  actors[actors.size] = level.woods;
  level.woods sethighdetail(1);

  foreach(a in actors) {
    a.allowbattlechatter[# "bc"] = 0;
    a setnosunshadow();
  }

  level thread function_3b697267();
  level.player thread intro_dof();
  level.player thread function_b845ead5();
  level.player thread function_6a74bb4d();
  level.player thread function_89c972ce();
  level.player val::set("takedown_hit1_intro", "show_weapon_hud", 0);
  level.player val::set("takedown_hit1_intro", "allow_crouch", 0);
  level.player val::set("takedown_hit1_intro", "allow_prone", 0);
  level.player val::set("takedown_hit1_intro", "disable_oob", 1);
  level.player setstance("stand");
  tag = "tag_origin";
  mover = getent("intro_heli_assault_linked", "targetname");
  mover linkto(level.player_heli, tag, (0, 0, 0), (0, 0, 0));
  level scene::add_scene_func("scene_tkd_hit1_intro_fly_in", &function_619f168c);
  level.player_heli thread function_62ed011b();
  level.var_9a3944f4 turret::disable(1);
  level.var_9a3944f4 turret::disable(2);
  var_afb6d099 = 15;
  var_92d3857f = 23;

  if(skipto_end) {
    var_afb6d099 = 0.05;
    var_92d3857f = 0.05;
    level.player_heli util::delay_notify(0.2, "lights_on");
    level.var_9a3944f4 util::delay_notify(0.2, "lights_on");
  }

  level flag::delay_set(var_afb6d099, "spawn_enemy_trucks");
  level flag::delay_set(var_92d3857f, "intro_heli_lights_on");
  thread function_e826dfbb();
  level.player thread function_8227f24e();
  level.fake_player dontinterpolate();

  if(!skipto_end) {
    thread function_a01817ae();
    level thread scene::play("scene_tkd_hit1_intro_fly_in_trucks", level.var_abaa6487);
    level scene::play("scene_tkd_hit1_intro_fly_in", actors);
  } else {
    level flag::set("heli_player_gets_weapon");
    level thread scene::play_from_time("scene_tkd_hit1_intro_fly_in_trucks", level.var_abaa6487, undefined, 0.9, 1);
    level scene::play_from_time("scene_tkd_hit1_intro_fly_in", actors, undefined, 0.9, 1);
  }

  if(isDefined(level.player_heli.light)) {
    level.player_heli notify(#"hash_48aad0ddc0d9bf5d");
    level.player_heli.light unlink();
    level.player_heli.light delete();
  }

  setDvar(#"hash_3d9a09e7ecea2271", 1);
  level flag::set("heli_intro_complete");
  level flag::set("player_heli_landing");
  level flag::set("fly_in_scene_finished");
  snd::client_msg("intro_trans_out");
  level.player clientfield::set_to_player("toggle_gameplayer_character_vis", 1);
  savegame::checkpoint_save(1);
  level flag::set("intro_takeout_driver");
  level flag::set("truck_front");
  level flag::set("truck_middle_unload");
  level flag::set("truck_rear_unload");
  level flag::set("truck4_unload");
  level flag::delay_set(0.1, "heli_intro_path_ally");
  level notify(#"hit1_truck_front");
  level.var_9a3944f4 thread vehicle::get_on_and_go_path("intro_ally_heli_post_scene");
  level.var_9a3944f4 thread namespace_42da7c51::function_4c12f50();
}

function function_62ed011b() {
  self endon(#"death");
  self waittill(#"hash_39b3070c4741db14");
  self vehicle::god_off();
  self vehicle::get_on_and_go_path("nd_veh_intro_player_heli_leave_path");
}

function function_e826dfbb() {
  self endon(#"death");
  level endon(#"heli_convoy_aslt_complete");
  wait 1;
  woods = undefined;

  while(!isDefined(woods)) {
    woods = getent("woods", "targetname", 1);
    waitframe(1);
  }

  woods colors::disable();
  guys = [];
  guys[0] = getent("driver_woods_kills", "script_parameters", 1);
  guys[1] = getent("passenger_woods_kills", "script_parameters", 1);

  for(i = 0; i < 2; i++) {
    woods waittill(#"fire_gun");
    level flag::delay_set(0.05, "truck_front");
    level flag::delay_set(0.05, "heli_intro_complete");
    startpos = woods gettagorigin("tag_flash");
    endpos = startpos + vectorscale(woods getweaponforwarddir(), 100);
    color = (1, 0, 0);

    if(isDefined(guys[i])) {
      endpos = guys[i] getEye();
      color = (1, 1, 0);
      level.var_9a3944f4 thread namespace_42da7c51::function_cbe25a41(guys[i], "tag_glass_front_left_lower_d0", 1);
    }

    magicbullet(woods.weapon, startpos, endpos, woods);
  }

  woods setgoal(woods.origin);
  wait 1.5;
  level flag::set("heli_intro_path_ally");
}

function function_72dfda8f() {
  self endon(#"death");
  level endon(#"heli_intro_complete");

  while(true) {
    waitresult = level waittill(#"shake_low", #"shake_med", #"shake_high");
    level.var_8f8dc88e = waitresult._notify;
  }
}

function function_8227f24e() {
  self endon(#"death");
  level endon(#"heli_intro_complete");
  level.var_8f8dc88e = "shake_low";
  thread function_72dfda8f();

  while(true) {
    source = self.origin;
    pitch = randomfloatrange(0, 0.15);
    yaw = randomfloatrange(0, 0.15);
    roll = 0;
    duration = randomfloatrange(0.25, 1);
    freqpitch = randomfloatrange(2.5, 3.5);
    freqyaw = randomfloatrange(2.5, 3.5);

    if(level.var_8f8dc88e == "shake_med") {
      pitch = randomfloatrange(0.02, 0.35);
      yaw = randomfloatrange(0.02, 0.25);
      roll = randomfloatrange(0.02, 0.1);
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

function function_833e9642(tag) {
  self endon(#"death");
  tag = "tag_missle_target";

  while(true) {
    sphere(self gettagorigin(tag), 16, self.col_hack, 1, 0, 10, 1);

    waitframe(1);
  }
}

function function_bfad1e94() {
  level flag::wait_till("spawn_enemy_trucks");
  function_c6662dbb("intro_enemy_trucks");
}

function function_28090f23() {
  tagnames = ["tag_headlight_left_d0", "tag_headlight_right_d0"];
  tags = [];

  for(i = 0; i < 2; i++) {
    tags[i] = util::spawn_model("tag_origin", self.origin, self.angles);
    tags[i] linkto(self, tagnames[i], (0, 0, 0), (0, 0, 0));
    playFXOnTag(#"hash_45003fc29bb60a21", tags[i], "tag_origin");
  }
}

function function_c6662dbb(trucks) {
  level.var_53bd60ae = 1;
  level.var_abaa6487 = [];

  for(i = 1; i < 5; i++) {
    level.var_abaa6487[level.var_abaa6487.size] = vehicle::simple_spawn_single(trucks + i);
  }

  foreach(truck in level.var_abaa6487) {
    truck vehicle::toggle_force_driver_taillights(1);

    if(isDefined(truck.script_parameters) && truck.script_parameters == "truck_rear_unload") {
      level.var_aece851d[level.var_aece851d.size] = truck;
    }

    truck.overridevehicledamage = &function_5d6e9494;
    truck thread function_b71a77f8();
    truck thread function_8b2eeb69();
  }

  thread function_149bd557();
}

function function_5d6e9494(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(!isPlayer(partname)) {
    return 0;
  }

  return vsurfacenormal;
}

function function_149bd557() {
  if(!isDefined(level.var_abaa6487)) {
    return;
  }

  wait 0.1;

  foreach(truck in level.var_abaa6487) {
    thread function_d8f00fe0(truck);
  }
}

function function_c42508f4() {
  self endon(#"death");
  self endon(#"exited_vehicle");
  start = gettime();

  while(true) {
    print3d(self.origin + (0, 0, 72), "<dev string:x38>", (1, 0, 0), 1, 0.5, 1, 1);
    self.unload_time = int((gettime() - start) / 10) / 100;
    print3d(self.origin + (0, 0, 60), "<dev string:x45>" + self.unload_time, (1, 0, 0), 1, 0.5, 1);

    waitframe(1);
  }
}

function function_77937c90() {
  self.ignoreme = 0;
  self endon(#"death");
  self waittill(#"exited_vehicle");

  if(isDefined(self.target)) {
    to = getnode(self.target, "targetname");

    if(!isDefined(to)) {
      to = getent(self.target, "targetname");
    }

    if(isDefined(to)) {
      self setgoal(to, 1);
    }

    return;
  }

  self ai::set_goal_ent(level.player);
  self.goalradius = 1024;
}

function function_d8f00fe0(truck) {
  truck endon(#"death");
  truck thread function_7ef31767();
  level flag::wait_till(truck.script_parameters);
  arrayremovevalue(truck.var_761c973.riders, undefined, 1);
  array::thread_all(truck.var_761c973.riders, &function_77937c90);
  truck thread vehicle::unload("all");
}

function function_7ef31767() {
  self endon(#"death");
  self waittill(#"damage");
  self flag::set(self.script_parameters);
}

function function_8b2eeb69() {
  self waittill(#"hash_694d7ad74b3b0c96");

  if(self.targetname == "intro_enemy_trucks3") {
    self vehicle::toggle_force_driver_taillights(0);
    return;
  }

  self thread namespace_42da7c51::function_3958f4d7("lights_intro_truck_" + self.var_5eafe61e);
}

function function_f84603f() {
  self waittill(#"death");
  array::run_all(self.var_68f755af, &setlightintensity, 0);
}

function function_30c1067c() {
  self endon(#"death");
  var_8a46685f = ["tag_headlight_left_d0", "tag_headlight_right_d0", "tag_fx_tail_light_left", "tag_fx_tail_light_right"];

  while(var_8a46685f.size) {
    s = self waittill(#"damage");

    if(!isPlayer(s.inflictor)) {
      continue;
    }

    if(array::contains(var_8a46685f, s.part_name)) {
      arrayremovevalue(var_8a46685f, s.part_name);
      self function_b7a8db11(s.part_name);
    }

    waitframe(1);
  }

  if(isDefined(self.var_68f755af[# "loaner"])) {
    self.var_68f755af[# "loaner"] setlightintensity(0);
  }
}

function function_b7a8db11(var_6e20f48) {
  e_light = undefined;

  switch (var_6e20f48) {
    case # "tag_headlight_left_d0":
      e_light = self.var_68f755af[# "front_left"];
      break;
    case # "tag_headlight_right_d0":
      e_light = self.var_68f755af[# "front_right"];
      break;
    case # "tag_fx_tail_light_left":
      e_light = self.var_68f755af[# "back_left"];
      break;
    case # "tag_fx_tail_light_right":
      e_light = self.var_68f755af[# "back_right"];
      break;
  }

  e_light setlightintensity(0);
}

function function_b71a77f8() {
  self endon(#"death");
  self waittill(#"hash_6c0a0fd5bbb788ed");
  self vehicle::function_ea0f8324();
}

function function_a01817ae() {
  level endon(#"flag_assault_heli_1");
  woods = undefined;

  while(!isDefined(woods)) {
    woods = getent("woods", "targetname", 1);
    waitframe(1);
  }

  woods function_ccfab96();
}

function function_ccfab96() {
  level endon(#"flag_assault_heli_1");
  self endon(#"death");
  var_a77bd386 = "c_t9_cp_usa_hero_woods_head1_bandana";
  flappy_head = "c_t9_cp_usa_hero_woods_head1_bandana_flag";
  var_7e34c54c = "c_t9_cp_usa_hero_woods_head1";
  curr = var_a77bd386;
  var_35d2e273 = 0;

  while(true) {
    waitresult = self waittill(["head_swap_none", "head_swap_normal", "head_swap_flappy"]);

    switch (waitresult._notify) {
      case # "head_swap_none":
        self detach(curr);
        curr = var_7e34c54c;
        self attach(curr);
        break;
      case # "head_swap_normal":
        var_35d2e273++;

        if(var_35d2e273 == 1) {
          break;
        }

        if(curr != var_a77bd386) {
          self detach(curr);
          curr = var_a77bd386;
          self attach(curr);
        }

        if(isDefined(self.var_f0087d61)) {
          self setModel(self.var_f0087d61);
        }

        break;
      case # "head_swap_flappy":
        if(curr != flappy_head) {
          self detach(curr);
          curr = flappy_head;
          self attach(curr);
        }

        level notify(#"shake_high");
        level flag::delay_set(4, "heli_player_gets_weapon");
        self.var_f0087d61 = self.model;
        self setModel("c_t9_cp_usa_hero_woods_body_flag");
        level util::delay_notify(4, "shake_med");
        break;
    }
  }
}

function intro_dof() {
  level waittill(#"hash_1c8f4811cd421bb6");
  self clientfield::set_to_player("lerp_fov", 4);
}

function function_6a74bb4d() {
  level waittill(#"hash_75dd5aeb02d8090c");
  self clientfield::set_to_player("lerp_fov", 5);
}

function function_b845ead5() {
  level waittill(#"hash_74014d281378de58");
  self clientfield::set_to_player("lerp_fov", 7);
}

function function_89c972ce() {
  level waittill(#"hash_403596223eb5d613");
  self clientfield::set_to_player("lerp_fov", 6);
}