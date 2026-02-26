/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_70b6424f429d140.gsc
***********************************************/

#using script_31e9b35aaacbbd93;
#using script_37f9ff47f340fbe8;
#using script_3dc93ca9902a9cda;
#using script_6b47294865dc34b5;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\easing;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp\cp_takedown;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_sp;
#using scripts\cp_common\snd_utility;
#namespace tkdn_heli_intro;

function starting(var_d3440450) {}

function main(var_d3440450, var_50cc0d4f) {
  level thread globallogic_ui::function_7bc0e4b9();
  level.var_aece851d = [];
  level.var_fc514951 = 0;
  player = getplayers()[0];
  player val::set("takedown_hit1_intro", "show_weapon_hud", 0);

  if(is_true(level.var_fc514951)) {
    wait 0.1;
    snd::client_msg("intro_mockup");
    thread function_c6662dbb("intro_enemy_trucks", 1);
    scene::play("scene_tkd_hit1_intro_pre_fly_in");
    level lui::screen_fade_out(0, "black");
    level util::delay(0.4, undefined, &lui::screen_fade_in, 0.5);
  } else {
    wait 3.5;
    thread function_c6662dbb("intro_enemy_trucks", 1);
    wait 0.5;
  }

  snd::client_msg("intro_trans_out");
  thread flyin();
  level flag::wait_till("heli_intro_complete");

  if(isDefined(var_50cc0d4f)) {
    skipto::function_4e3ab877(var_50cc0d4f);
  }
}

function function_77438329() {
  player = getplayers()[0];

  while(!player isstreamerready()) {
    waitframe(1);
  }
}

function cleanup(name, starting, direct, player) {}

function init_flags() {}

function init_clientfields() {
  clientfield::register("vehicle", "hit1_helispotlight", 1, 1, "int");
  clientfield::register("vehicle", "hit1_track_vehicle", 1, 1, "int");
  clientfield::register("scriptmover", "hit1_track_ent", 1, 1, "int");
  clientfield::register("scriptmover", "hit1_tracking", 1, 1, "int");
  clientfield::register("scriptmover", "hit1_light", 1, 1, "int");
}

function function_22b7fffd() {}

function function_fbb0d73f() {
  self endon(#"death");
  self setrotorspeed(1);
  self.soundmod = "heli";
  self vehicle::toggle_tread_fx(1);
  self vehicle::toggle_exhaust_fx(1);
  self vehicle::toggle_sounds(1);
  self setrotorspeed(1);
  self vehicle::lights_on();
  params = spawnStruct();
  params.no_clear_movement = 1;
  params.var_a22ee662 = 1;
  self vehicle_ai::set_state("scripted", params);
}

function function_bff76496(f) {
  level flag::wait_till(f);

  debug2dtext((1500, 700, 0), f, (1, 1, 1), 1, (0, 0, 0), 0, 1, 40);
}

function function_50c1c92b() {
  player = getplayers()[0];
  level.fake_player = util::spawn_player_clone(player);
  level.fake_player.targetname = "FakePlayer";
  thread function_3b697267();
}

function function_3b697267() {
  player = getplayers()[0];
  player allowcrouch(0);
  waitframe(3);
  player takeallweapons();
  player playerlinktodelta(level.fake_player, "tag_player", 1, 30, 15, 15, 30, 1, 1);
  wait 0.1;
  player setlowready(1);
  level flag::wait_till("heli_player_gets_weapon");
  var_5ca6956f = getweapon(#"smg_standard_t9", array("reflex", "fastreload"));
  var_2105d8b1 = getweapon(#"sniper_quickscope_t9");
  player giveweapon(var_5ca6956f);
  player giveweapon(var_2105d8b1);
  player switchtoweapon(var_5ca6956f);
  level flag::wait_till("heli_intro_complete");
  player playerlinktodelta(level.fake_player, "tag_player", 1, 0, 0, 0, 0, 1);
  player val::set("takedown_hit1_intro", "show_weapon_hud", 1);
  wait 0.5;
  player setlowready(0);
  level.fake_player hide();
  player unlink();
  player allowcrouch(1);
  level notify(#"hash_2769bf067f3ba0cb");
}

function function_3d66ebcc(tname, var_5283a254, skipto_end = 0) {
  if(is_true(var_5283a254)) {
    level.var_40b02b72 = vehicle::simple_spawn(tname);
    level.var_40b02b72[level.var_40b02b72.size] = vehicle::simple_spawn_single("intro_heli_ally");
  } else {
    level.var_40b02b72 = vehicle::simple_spawn_and_drive(tname);
  }

  player_heli = level.var_40b02b72[0];
  level.var_9a3944f4 = level.var_40b02b72[1];

  if(isDefined(level.var_40b02b72[1].script_noteworthy)) {
    player_heli = level.var_40b02b72[1];
    level.var_9a3944f4 = level.var_40b02b72[0];
  }

  player_heli flag::init("player_heli_landing");

  foreach(chopper in level.var_40b02b72) {
    chopper thread function_fbb0d73f();
  }

  player_heli setModel("veh_t8_mil_helicopter_uh1d_cp_takedown");
  level.var_9a3944f4 setModel("veh_t8_mil_helicopter_uh1d_cp_takedown");
  player_heli hidepart("tag_gunner_barrel1", "veh_t8_mil_helicopter_uh1d_left_gun_mount_attach_grn", 1);
  thread heli_light(level.var_9a3944f4, "ally_heli_spot_light_bustout", "tag_glass_front_left_lower_d0", (-20, 12, 0), level.var_9a3944f4, 0, 1);
  level.var_9a3944f4 thread function_3cebcd1b();
  player_heli.probe = getent("heli_probe", "targetname");

  if(isDefined(player_heli.probe)) {
    player_heli.probe linkto(player_heli, "tag_fire_extinguisher_attach", (-4, 0, 12), (0, 0, 0));
  }

  player_heli.var_6098f318 = getent("heli_cab_probe", "targetname");

  if(isDefined(player_heli.var_6098f318)) {
    player_heli.var_6098f318 linkto(player_heli, "tag_fire_extinguisher_attach", (38, 0, 16), (0, 0, 0));
  }

  player = getplayers()[0];
  tag = "tag_origin";

  if(!is_true(level.var_fc514951)) {
    wait 1;
  }

  mover = getent("intro_heli_assault_linked", "targetname");
  mover linkto(player_heli, tag, (0, 0, 0), (0, 0, 0));

  if(is_true(var_5283a254)) {
    var_afb6d099 = 15;
    var_92d3857f = 23;

    if(skipto_end) {
      var_afb6d099 = 0.05;
      var_92d3857f = 0.05;
      player_heli util::delay_notify(0.2, "lights_on");
      level.var_9a3944f4 util::delay_notify(0.2, "lights_on");
    }

    level flag::delay_set(var_afb6d099, "spawn_enemy_trucks");
    level flag::delay_set(var_92d3857f, "intro_heli_lights_on");
    thread function_e826dfbb();
    player thread function_8227f24e();
    level.fake_player = player;
    function_50c1c92b();
    actors = [];
    actors[player_heli.targetname] = player_heli;
    actors[level.var_9a3944f4.targetname] = level.var_9a3944f4;
    actors[#"fakeplayer"] = level.fake_player;

    if(!skipto_end) {
      thread function_a01817ae();
      level thread scene::play("scene_tkd_hit1_intro_fly_in_trucks", level.var_abaa6487);
      level scene::play("scene_tkd_hit1_intro_fly_in", actors);
    } else {
      level flag::set("heli_player_gets_weapon");
      level flag::set("heli_intro_complete");
      level thread scene::play_from_time("scene_tkd_hit1_intro_fly_in_trucks", level.var_abaa6487, undefined, 0.85, 1);
      level scene::play_from_time("scene_tkd_hit1_intro_fly_in", actors, undefined, 0.85, 1);
    }

    if(isDefined(player_heli.light)) {
      player_heli notify(#"hash_48aad0ddc0d9bf5d");
      player_heli.light unlink();
      player_heli.light delete();
    }

    level flag::set("heli_intro_complete");
    level flag::set("player_heli_landing");
    level flag::set("fly_in_scene_finished");
    level flag::set("intro_takeout_driver");
    level flag::set("truck_front");
    level flag::delay_set(0.1, "heli_intro_path_ally");
    wait 0.2;
    level.var_9a3944f4 thread vehicle::get_on_and_go_path("intro_ally_heli_post_scene");
  }
}

function function_e826dfbb() {
  self endon(#"death");
  level endon(#"heli_convoy_aslt_complete");
  wait 1;
  woods = undefined;

  while(!isDefined(woods)) {
    woods = getent("woods_chopper_from_scene", "script_noteworthy", 1);
    waitframe(2);
  }

  wait 0.5;
  woods util::magic_bullet_shield();
  guys = [];
  guys[0] = getent("driver_woods_kills", "targetname", 1);
  guys[1] = getent("passenger_woods_kills", "targetname", 1);

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
      level.var_9a3944f4 thread function_cbe25a41(guys[i], "tag_glass_front_left_lower_d0", 1);
    }

    magicbullet(woods.weapon, startpos, endpos, woods);
  }

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

function flyin() {
  function_3d66ebcc("intro_heli_player", 1);
}

function function_3cebcd1b() {
  self endon(#"death");
  level endon(#"bustout_start_shooting_house");
  var_979d3fe0 = [#"hit1_truck_rear", #"hit1_truck_house", #"hit1_truck_mid", #"hit1_truck_front", #"heli_focus_mid_house", #"heli_focus_rear_house"];
  var_f01b798 = ["hit1_truck_rear", "hit1_truck_house", "hit1_truck_mid", "hit1_truck_front", "heli_focus_mid_house", "heli_focus_rear_house"];

  while(true) {
    ret = level waittill(#"hit1_truck_rear", #"hit1_truck_house", #"hit1_truck_mid", #"hit1_truck_front", #"heli_focus_mid_house", #"heli_focus_rear_house");
    var_87c48267 = "GetEntDislikesHashStrings";

    for(i = 0; i < var_979d3fe0.size; i++) {
      if(var_979d3fe0[i] == ret._notify) {
        var_87c48267 = var_f01b798[i];
        break;
      }
    }

    var_4cd99adc = getent(var_87c48267, "script_noteworthy", 1);

    if(!isDefined(var_4cd99adc)) {
      var_4cd99adc = struct::get(var_87c48267, "targetname");
    }

    if(isDefined(var_4cd99adc)) {
      self thread function_cbe25a41(var_4cd99adc, "tag_glass_front_left_lower_d0", 1);
      level.var_7c11765c = gettime() + 2000;
      continue;
    }

    iprintlnbold("<dev string:x38>" + var_87c48267);
  }
}

function function_f97ce389(heli, tag, var_2d65f507, var_5525c0b0) {
  heli.light = util::spawn_model("tag_origin", heli gettagorigin(tag) + (0, 0, -84), heli gettagangles(tag) + var_2d65f507);

  if(var_5525c0b0) {
    util::delay(0.3, undefined, &playfxontag, #"hash_f80473c70ea6ee3", heli.light, "tag_origin");
  } else {
    playFXOnTag(#"hash_7d057d370983507f", heli.light, "tag_origin");
  }

  heli.light linkto(heli, "tag_searchlight_fx", (0, 0, 0), (0, 0, 0));
}

function heli_light(heli, tname, tag, var_2d65f507, var_ba240678, var_fa2357fe = 0, var_1a67724f = 0, var_5525c0b0 = 0) {
  fx_light = 1;
  heli endon(#"death");
  heli waittill(#"lights_on");
  heli.col_hack = (1, 0, 0);

  if(!isDefined(level.var_eaf95d92)) {
    level.var_eaf95d92 = [];
  }

  if(!isDefined(level.var_eaf95d92[tname])) {
    if(fx_light) {
      if(!var_1a67724f) {
        function_f97ce389(heli, tag, var_2d65f507, var_5525c0b0);
      }
    } else {
      heli.light = getent(tname, "targetname");

      if(!isDefined(heli.light)) {
        heli.light = getent(tname + "_temp", "targetname");
      }
    }

    if(isDefined(heli.light)) {
      heli.light linkto(heli, tag, (0, 0, -64), var_2d65f507);
      level.var_eaf95d92[tname] = heli.light;
    }
  }

  if(isDefined(var_ba240678)) {
    heli thread function_cbe25a41(var_ba240678, tag, var_fa2357fe, var_1a67724f, var_5525c0b0);
  }
}

function function_336e9e88() {
  self endon(#"death");

  while(true) {
    sphere(self.origin + (0, 0, 12), 4, (1, 1, 0), 1, 0, 10, 1);
    sphere(self.origin, 8, (1, 1, 0), 1, 0, 10, 1);

    waitframe(1);
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

function function_cbe25a41(var_4cd99adc, tag, var_fa2357fe = 0, var_1a67724f = 0, var_5525c0b0 = 0, var_2526f86c = 0) {
  self endon(#"death");
  self endon(#"hash_48aad0ddc0d9bf5d");
  var_869cc293 = "tag_missle_target";

  if(isDefined(self.var_ba240678)) {
    self.var_ba240678.tracking = var_4cd99adc;
    self.var_9fa13062 = 0;
    self.var_c7d51a18 = 0;

    if(self.var_1a67724f || is_true(self.var_2526f86c)) {
      self.var_ba240678 unlink();
    }

    self.var_1a67724f = var_1a67724f;
    self.var_2526f86c = var_2526f86c;

    if(self.var_1a67724f) {
      self.var_ba240678 linkto(self, var_869cc293, (0, 0, 0), (0, 0, 0));
    } else if(self.var_2526f86c) {
      self.var_ba240678 linkto(var_4cd99adc, tag, (0, 0, 0), (0, 0, 0));
    }

    self sethoverparams(75, 100, 50);
    return;
  }

  if(!isDefined(tag)) {
    tag = "tag_origin";
  }

  self.var_9fa13062 = 0;
  self.var_c7d51a18 = 0;
  self.var_19a7fb91 = 32 + randomfloat(64);
  self.var_19a7fb91 = 96;
  self.var_ba240678 = util::spawn_model("tag_origin", var_4cd99adc.origin, var_4cd99adc.angles);
  self.var_113b6995 = 2;
  self.var_35f26704 = 0;
  self.var_43643137 = (0, 0, 36);
  self.forward_scalar = 128;
  self.var_1a67724f = var_1a67724f;
  self.var_ba240678 endon(#"death");

  if(self.var_1a67724f || !isDefined(self.light)) {
    self.var_ba240678 linkto(self, var_869cc293, (0, 0, 0), (0, 0, 0));
    function_f97ce389(self, tag, (0, 0, 0), var_5525c0b0);
  }

  self.light endon(#"death");
  var_61bc4e7 = 0;

  if(var_fa2357fe) {
    var_8c29c159 = getent("light_ally_helispot_bnc", "targetname");

    if(isDefined(var_8c29c159)) {
      var_8c29c159.var_6da8d78a = 1;
      var_8c29c159 linkto(self.var_ba240678, "tag_origin", (0, 0, -200), (0, 0, 0));

      if(var_61bc4e7) {
        var_8c29c159 thread function_336e9e88();
      }
    }
  }

  self.var_ba240678.tracking = var_4cd99adc;
  self clientfield::set("hit1_helispotlight", 1);
  waitframe(1);
  self.light clientfield::set("hit1_light", 1);
  waitframe(1);
  self.var_ba240678 clientfield::set("hit1_track_ent", 1);
  waitframe(1);

  if(isvehicle(self.var_ba240678.tracking)) {
    self.var_ba240678.tracking clientfield::set("hit1_track_vehicle", 1);
  } else {
    self.var_ba240678.tracking clientfield::set("hit1_tracking", 1);
  }

  var_13ad4669 = 0.05;
  self sethoverparams(75, 100, 50);
  self.var_2791e894 = 0;

  while(true) {
    if(!isDefined(self.var_ba240678.tracking) && self.var_1a67724f == 0) {
      waitframe(1);
      continue;
    }

    if(is_true(var_61bc4e7)) {
      sphere(self.var_ba240678.origin, 8, (1, 0, 0), 1, 0, 10, 1);
      sphere(self.var_ba240678.tracking.origin, 4, (0, 0, 1), 1, 0, 10, 1);
    }

    if(!(self.var_1a67724f || self.var_2526f86c)) {
      end_point = self.var_ba240678.tracking.origin + self.var_43643137 + anglesToForward(self.var_ba240678.tracking.angles) * self.forward_scalar;
      dist = distance(self.var_ba240678.origin, end_point);

      if(!self.var_9fa13062 && !self.var_c7d51a18) {
        if(dist > self.var_19a7fb91) {
          self.var_9fa13062 = 1;
          self.var_c1cda03b = 0.025;
          self.var_ab0fdcd8 = self.var_c1cda03b;
          self.var_7c772b29 = self.var_ba240678.origin;

          if(is_true(var_61bc4e7)) {
            sphere(end_point, 4, (0, 0, 1), 1, 0, 10, 40);
          }

          self.var_ba240678 thread easing::ease_origin(end_point, self.var_113b6995, #"back", undefined, 0, 1, 1, [0.35, 3.5]);
          self.var_35f26704 = gettime() + self.var_113b6995 * 1000;
          self sethoverparams(75, 100, 50);
        }
      } else if(self.var_9fa13062 && self.var_35f26704 < gettime()) {
        self.var_9fa13062 = 0;

        if(dist < self.var_19a7fb91) {
          self.var_35f26704 = gettime() + self.var_113b6995 * 1000 / 3;
          self.var_c7d51a18 = 1;
          end_point = self.var_ba240678.tracking.origin + self.var_43643137 + anglesToForward(self.var_ba240678.tracking.angles) * self.forward_scalar;

          if(is_true(var_61bc4e7)) {
            sphere(end_point, 4, (1, 0, 0), 1, 0, 10, 20);
          }

          self.var_ba240678 thread easing::ease_origin(end_point, self.var_113b6995 / 3, #"sine", undefined, 0, 1, 1);
        }
      } else if(self.var_c7d51a18) {
        if(self.var_35f26704 < gettime()) {
          self.var_c7d51a18 = 0;
        }
      }
    }

    tag_ang = self gettagangles(tag);
    org = self gettagorigin(tag) + (0, 0, -10);
    to = vectortoangles(self.var_ba240678.origin - org);
    var_172edc78 = to - tag_ang;
    waitframe(1);
  }
}

function function_bfad1e94() {
  level flag::wait_till("spawn_enemy_trucks");
  function_c6662dbb("intro_enemy_trucks", 1);
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

function function_c6662dbb(trucks, var_d9890e08) {
  level.var_53bd60ae = 1;
  level.var_abaa6487 = [];

  if(is_true(var_d9890e08)) {
    for(i = 1; i < 5; i++) {
      level.var_abaa6487[level.var_abaa6487.size] = vehicle::simple_spawn_single(trucks + i);
    }
  } else {
    level.var_abaa6487 = vehicle::simple_spawn_and_drive(trucks);
  }

  foreach(truck in level.var_abaa6487) {
    truck vehicle::toggle_force_driver_taillights(1);

    if(isDefined(truck.var_164e8194)) {
      truck setModel(truck.var_164e8194);
    }

    if(isDefined(truck.script_parameters) && truck.script_parameters == "truck_rear_unload") {
      level.var_aece851d[level.var_aece851d.size] = truck;
    }
  }

  thread tkdn_heli_convoy_aslt::function_149bd557();
}

function function_a01817ae() {
  level endon(#"intro_waittill_bustout_heli");
  woods = undefined;

  while(!isDefined(woods)) {
    woods = getent("woods_chopper_from_scene", "script_noteworthy", 1);
    waitframe(1);
  }

  woods function_ccfab96();
}

function function_ccfab96() {
  level endon(#"intro_waittill_bustout_heli");
  self endon(#"death");
  var_a77bd386 = "c_t8_bo_hero_woods_head1";
  flappy_head = "c_t9_usa_hero_woods_head1_igc_flag";
  var_7e34c54c = "c_t9_usa_hero_woods_head1_igc_no_bandana";
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