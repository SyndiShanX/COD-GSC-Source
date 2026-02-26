/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_196ed2508fd0fd9d.csc
***********************************************/

#using script_1cd690a97dfca36e;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_utility;
#namespace namespace_5ceacc03;

function event_handler[level_preinit] function_b489bb7b(eventstruct) {
  snd::function_d4ec748e(&function_f2a2832d);
  snd::function_ce78b33b(&function_32ab045);
  snd::trigger_init(&_trigger);
  snd::function_5e69f468(&_objective);
  level.var_81065eb = [];
  level.var_f49d7de7 = 0;
  level.var_fcc804e = [];
  level.var_fcc804e[#"$default"] = "exterior";
  level.var_fcc804e[#"hash_3c9de9e174a1f135"] = "exterior";
  level.var_fcc804e[#"hash_518b3efa37b8a021"] = "partial";
  level.var_fcc804e[#"hash_79390a23c1ba4e9"] = "partial";
  level.var_fcc804e[#"hash_7cd1406b6fff34fc"] = "exterior";
  level.var_fcc804e[#"hash_89ecb8b7103ae4f"] = "interior";
  level.var_fcc804e[#"interior"] = "interior";
  level.var_fcc804e[#"hash_6093da13c6946b3c"] = "interior";
  level.var_fcc804e[#"hash_2214a39f32953d12"] = "interior";
  level.var_fcc804e[#"hash_1247ef0df6bdec86"] = "interior";
  level.var_fcc804e[#"hash_2d7a442e3b81b941"] = "interior";
  level.var_fcc804e[#"hash_5f36a7b103c5e73"] = "interior";
  level.var_fcc804e[#"hash_14ce099dab27f97b"] = "interior";
  level.var_fcc804e[#"hash_221ca84e4f537477"] = "interior";
  level.var_fcc804e[#"hash_411d880f42c49416"] = "interior";
  level.var_fcc804e[#"hash_7720a25f1e57b4ba"] = "interior";
  level.var_fcc804e[#"hash_35fddf07b040ef25"] = "interior";
  level.var_fcc804e[#"hash_3b879280dd0810a7"] = "interior";
  level.var_fcc804e[#"hash_1d13e973071b6add"] = "interior";
  level.var_fcc804e[#"hash_18312b3a201af00c"] = "interior";
  level.var_fcc804e[#"hash_78aaeca159ea1921"] = "interior";
  level.var_fcc804e[#"hash_386821aec53b1665"] = "interior";
  level.var_fcc804e[#"hash_1d13e973071b6add"] = "partial";
  level.var_fcc804e[#"hash_6c4907a1cdd20f4e"] = "interior";
  level.var_fcc804e[#"hash_304e1e4e8e4b37c3"] = "partial";
  level.var_fcc804e[#"hash_53d96923d8b6fe97"] = "interior";
  level.var_fcc804e[#"hash_298d7dd4f9de95ae"] = "interior";
  level.var_fcc804e[#"hash_7b5b0ff491893e3b"] = "interior";
  level.var_fcc804e[#"hash_75c761e13a5376bb"] = "interior";
  level.var_fcc804e[#"hash_7653453e97d91868"] = "partial";
  level.var_fcc804e[#"hash_729ef74d34a9dcfc"] = "partial";
  level.var_fcc804e[#"hash_42cefca9ced49356"] = "interior";
  level.var_fcc804e[#"hash_2f17839ed5ce619c"] = "interior";
  level.var_fcc804e[#"hash_33546d8e70f4aebe"] = "interior";
  level.var_fcc804e[#"hash_2af67058f30f9a7a"] = "interior";
  level.var_fcc804e[#"hash_e2369e15044a00a"] = "interior";
  level.var_fcc804e[#"hash_d4428d6d3e159a9"] = "interior";
  level.var_fcc804e[#"hash_eb17c50a622449e"] = "interior";
  level.var_fcc804e[#"hash_49b03c7c4557ad22"] = "exterior";
  level.var_fcc804e[#"hash_72d7f5a7e6339511"] = "exterior";
  level.var_fcc804e[#"hash_49a0ef561b09b7f9"] = "exterior";
  level.var_fcc804e[#"hash_3dd3f5f36d38c9c5"] = "exterior";
  level.var_fcc804e[#"hash_2efada4491df359c"] = "exterior";
  level.var_fcc804e[#"hash_6b04acbbe73735df"] = "exterior";
  level.var_fcc804e[#"hash_13d13a59dcbe03a2"] = "interior";
}

function event_handler[event_cc819519] function_686b88aa(eventstruct) {
  snd::wait_init();
  snd::waitforplayers();
  function_5ac4dc99("snd_scrOcclusionFadeInTime", "1");
  function_5ac4dc99("snd_scrOcclusionFadeOutTime", "1");
  audio::function_21f8b7c3();
  level thread element_init();
  level thread function_73ed916e();
  level notify(#"hash_2712b72478766d1c");
}

function private _objective(objective) {
  switch (objective) {
    case # "train":
      level thread function_87b5665d();
      break;
    case # "hash_b4bf1467425eafa":
      break;
    case # "ghost_station":
      break;
    case # "ghost_station_exit":
      thread function_1d10f78a();
      break;
    case # "wall":
      break;
    case # "rooftop":
      break;
    case # "street":
      level thread function_1591cb13();
      snd::stop(level.var_d9f8cee);
      break;
    case # "bar":
      level thread function_1591cb13();
      break;
    case # "hash_7c9606c7fc0bc2c6":
      break;
    case # "hash_7c9605c7fc0bc113":
      break;
    case # "alley_3":
      break;
    case # "meetup":
      break;
    case # "apt_street":
      break;
    case # "hash_5316a2a443ccd594":
      break;
    case # "hash_5316a5a443ccdaad":
      break;
    case # "hash_6af30f974bc8ee0d":
      break;
    case # "warehouse_intro":
      break;
    case # "warehouse":
      break;
    case # "hash_48642c08eff0a94c":
      break;
    case # "hash_1596768e81a01481":
      break;
    case # "hash_787e1dfef8598bc8":
      break;
    case # "no_game":
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x38>" + objective + "<dev string:x5b>");

      break;
  }
}

function private function_32ab045(ent, name) {
  if(strstartswith(name, "_door")) {
    ent thread door_init(name);
    return;
  }

  switch (name) {
    case # "adler":
      level.adler = ent;
      ent waittill(#"death");
      level.adler = undefined;
      break;
    case # "park":
      level.park = ent;
      ent waittill(#"death");
      level.park = undefined;
      break;
    case # "hash_6b987b161b43f18c":
      level thread function_50e92688(ent);
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x60>" + snd::function_783b69(name, "<dev string:x5b>"));

      break;
  }
}

function private _trigger(player, trigger, var_ec80d14b) {
  trigger_name = snd::function_ea2f17d1(var_ec80d14b.script_ambientroom, "$default");
  function_8b3df454(trigger, trigger_name);

  switch (trigger_name) {
    case # "$default":
      snd::set_element(trigger, []);
      break;
    case # "hash_7720a25f1e57b4ba":
      snd::set_element(trigger, []);
      break;
    case # "hash_18312b3a201af00c":
    case # "hash_1d13e973071b6add":
    case # "hash_386821aec53b1665":
    case # "hash_3b879280dd0810a7":
      snd::set_element(trigger, "ghost_station");
      level thread function_1a1fd87a();
      break;
    case # "interior":
      break;
    case # "hash_49b03c7c4557ad22":
      snd::set_element(trigger, []);

      if(isarray(level.var_20f9858b)) {
        snd::stop(level.var_20f9858b, 2);
        level.var_20f9858b = undefined;
      }

      break;
    case # "hash_6c4907a1cdd20f4e":
      level notify(#"hash_2712b72478766d1c");
      break;
    case # "hash_49a0ef561b09b7f9":
      function_1fb9d5d6();
      break;
    case # "hash_3dd3f5f36d38c9c5":
      function_2794abbe();
      break;
    case # "hash_53d96923d8b6fe97":
      level notify(#"hash_2712b72478766d1c");
      level flag::set("snd_bar_started");
      break;
    case # "hash_7b5b0ff491893e3b":
      break;
    case # "hash_729ef74d34a9dcfc":
    case # "hash_75c761e13a5376bb":
    case # "hash_7653453e97d91868":
      break;
    case # "hash_d4428d6d3e159a9":
      if(isalive(trigger)) {
        snd::set_element(trigger, trigger_name);
      }

      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x85>" + trigger_name + "<dev string:x5b>");

      break;
  }
}

function private function_f2a2832d(player, msg) {
  switch (msg) {
    case # "hash_75509e6e5815431c":
      thread function_d516219();
      break;
    case # "hash_3f35a4573ca691d":
      thread train_fade_up_from_black();
      break;
    case # "hash_56ddda8ab2517d7":
      thread function_a6b9fbbd();
      break;
    case # "hash_2b77f5a80ef76375":
      level notify(#"hash_2b77f5a80ef76375");
      break;
    case # "hash_56ddea8ab25198a":
      level notify(#"hash_56ddea8ab25198a");
      break;
    case # "inside_train_car_02":
      level notify(#"inside_train_car_02");
      break;
    case # "prep_teleport_train_player":
      level notify(#"prep_teleport_train_player");
      break;
    case # "hash_19e230299ea7fcb3":
      level notify(#"hash_19e230299ea7fcb3");
      break;
    case # "hash_1fe344e4d4f0967c":
      level notify(#"hash_1fe344e4d4f0967c");
      break;
    case # "hash_dd68c60c003c4d9":
      level notify(#"hash_dd68c60c003c4d9");
      break;
    case # "hash_2b77f2a80ef75e5c":
      level notify(#"hash_2b77f2a80ef75e5c");
      break;
    case # "hash_790fd3997d6d47b3":
      level notify(#"hash_790fd3997d6d47b3");
      break;
    case # "hash_5a65194efa8dcb0f":
      thread function_1d10f78a();
      break;
    case # "hash_72a9efcd706dc730":
      level thread function_c3e35066();
      break;
    case # "hash_63b7485b7ad71c1":
      level notify(#"hash_22c61e589a1f98c0");
      break;
    case # "hash_6ba35d4654d272bb":
      thread guard_room_train_occlusion();
      break;
    case # "duck_ghost_station":
      thread duck_ghost_station();
      break;
    case # "ghost_station_done":
      level notify(#"ghost_station_done");
      break;
    case # "hash_6c4907a1cdd20f4e":
      break;
    case # "hash_1c2409ba51713f11":
      break;
    case # "hash_744849b8a754841b":
      function_828e41f5();
      break;
    case # "hash_dc63434f653d0f2":
      thread function_7c0ea595();
      break;
    case # "hash_208adbd58bcd8ca5":
      thread function_dceebb0a();
      break;
    case # "street":
      thread function_7d3ac608();
      break;
    case # "hash_41e362c76ad6bdb7":
      level notify(#"hash_41e362c76ad6bdb7");
      thread bar_incoming();
      break;
    case # "hash_769a83dab4c363e6":
      thread police_build_up_bar();
      break;
    case # "hash_7c97bbd19494725c":
      level notify(#"hash_7c97bbd19494725c");
      break;
    case # "hash_230cd5b99068d083":
      level notify(#"hash_230cd5b99068d083");
      break;
    case # "hash_7ed1851bd0d35b68":
      thread function_6bd221d6();
      break;
    case # "hash_16f04daa5e7c81f9":
      thread function_4edfeefa();
      break;
    case # "hash_339e89b26927c83":
      function_5ea2c6e3("cp_ger_stakeout_knockout_fade", 4, 1);
      level notify(#"hash_2712b72478766d1c");
      level notify(#"snd_emitter_stop");
      break;
    case # "warehouse_intro":
      function_ed62c9c2("cp_ger_stakeout_knockout_fade", 1);
      function_5ea2c6e3("cp_ger_stakeout_warehouse_wake", 0, 1);
      function_5ea2c6e3("cp_ger_stakeout_warehouse_intro", 0, 1);
      snd::play("evt_warehouse_plr_wakeup_roar");
      break;
    case # "hash_66c35acc4e563e17":
      snd::play([0.05, "evt_warehouse_plr_wakeup_vo", 1]);
      break;
    case # "hash_77f64a1836abd196":
      function_ed62c9c2("cp_ger_stakeout_warehouse_wake", 1);
      break;
    case # "hash_49a7e5cf5c7d07f9":
      function_5ea2c6e3("cp_ger_stakeout_warehouse_wake", 2, 1);
      break;
    case # "hash_77f6491836abcfe3":
      function_ed62c9c2("cp_ger_stakeout_warehouse_wake", 3);
      break;
    case # "warehouse_guns_start":
      var_5f84d7d4 = snd::play("evt_rescue_gunfight_backg", (10053, -13199, 321));
      snd::play("evt_rescue_gunfight_foregr");
      wait 2;
      snd::set_volume(var_5f84d7d4, 0.12589, 3);
      wait 25;
      snd::stop(var_5f84d7d4, 10);
      break;
    case # "warehouse":
      function_552fe77();
      break;
    case # "musictrack_cp_stakeout_1":
    case # "musictrack_cp_stakeout_2":
    case # "musictrack_cp_stakeout_3":
    case # "musictrack_cp_stakeout_4":
      function_2cca7b47(0, msg);
      break;
    default:
      break;
  }
}

function element_init() {
  plr = undefined;
  ghost_station = [["env_stk_tunnel_train_dist", (-6075, 10670, -350), [12, 24]], ["env_stk_tunnel_train_dist", (-10175, 10368, -350), [12, 24]]];
  snd::element_init("ghost_station", ghost_station);
}

function function_8b3df454(player, trigger_name) {
  var_8419e080 = getdvarfloat(#"snd_scrOcclusionFadeInTime", 0);
  var_b0e9c7f5 = getdvarfloat(#"snd_scrOcclusionFadeOutTime", 0);

  if(!isDefined(trigger_name)) {
    trigger_name = "$default";
  }

  occlusion = level.var_fcc804e[trigger_name];

  if(!isDefined(occlusion)) {
    return;
  }

  switch (occlusion) {
    case # "exterior":
    default:
      function_ed62c9c2("cp_ger_stakeout_occl_ext", var_b0e9c7f5);
      function_5ea2c6e3("cp_ger_stakeout_occl_int", var_8419e080);
      player notify(#"hash_194cb194c067a625", {
        #state: "exterior"});
      break;
    case # "partial":
      function_5ea2c6e3("cp_ger_stakeout_occl_ext", var_b0e9c7f5, 0.0625);
      function_5ea2c6e3("cp_ger_stakeout_occl_int", var_8419e080, 0.9375);
      player notify(#"hash_194cb194c067a625", {
        #state: "partial"});
      break;
    case # "interior":
      function_5ea2c6e3("cp_ger_stakeout_occl_ext", var_b0e9c7f5);
      function_ed62c9c2("cp_ger_stakeout_occl_int", var_8419e080);
      player notify(#"hash_194cb194c067a625", {
        #state: "interior"});
      break;
  }
}

function function_9a87c2ea(ent) {
  var_9ba2a2c = getxmodelcenteroffset(ent.model, 1);
  var_9998d3ec = rotatepoint(var_9ba2a2c, ent.angles);
  return ent.origin + (var_9998d3ec[0], var_9998d3ec[1], 55);
}

function function_74132496(angles, diff) {
  var_e17e8d14 = angles - diff;
  var_e17e8d14 = angleclamp180(var_e17e8d14);
  angle_diff = var_e17e8d14[0] + var_e17e8d14[1] + var_e17e8d14[2];
  return angle_diff;
}

function function_570acc94(door, pos, angle, var_9528975d, var_695f85a3) {
  if(!isDefined(angle)) {
    angle = 0;
  }

  if(!isDefined(var_9528975d)) {
    var_9528975d = 0;
  }

  if(!isDefined(var_695f85a3)) {
    var_695f85a3 = 0;
  }

  if(!isDefined(door) || !isvec(pos)) {
    return;
  }

  debugtext = "<dev string:xa9>" + snd::function_d6053a8f(angle, 1) + "<dev string:xb4>" + snd::function_d6053a8f(var_9528975d, 2);
  debugcolor = getdvarvector(#"hash_3b9f89c8082a9915", (1, 1, 1));
  debugalpha = 0.9;
  var_74500ef = debugalpha * debugalpha;
  debugscale = getdvarfloat(#"hash_182296346d138cf8");
  colorscale = getdvarfloat(#"hash_3944b771315157c1", 1);
  debugcolor = snd::function_2677a7e2(debugcolor, colorscale * 10);
  debugframes = 1;
  debugoffset = (0, 0, 0 - 1 * debugscale);
  snd::print3dplus(debugtext, pos + debugoffset, 0.25 * debugscale, "<dev string:xc5>", debugcolor, debugalpha, (0, 0, 0), var_74500ef, (1, 1, 1), var_74500ef, debugframes);
}

function function_8cdd2834() {
  level notify(#"hash_1578fafa85d6a2dd");
  level endon(#"hash_1578fafa85d6a2dd");
  self endon(#"death");

  while(true) {
    player = snd::getplayerssafe()[0];
    debuglevel = snd::function_95c9af4b();

    if(debuglevel >= 2 && snd::isplayersafe(player)) {
      playervieworg = player snd::getplayervieworigin();
      playerangles = player snd::getplayerviewangles();
      playerforward = anglesToForward(playerangles);
      playerfov = player snd::getplayerfov();
      distance = level._snd._debug.distance_max;

      if(distance <= 0) {
        distance = undefined;
      }

      var_17f47c08 = function_ada64c98(level.var_81065eb, playervieworg, playerforward, playerfov, distance);

      foreach(door in var_17f47c08) {
        if(isDefined(door)) {
          function_570acc94(door, door.var_f50c2aae, door.var_c58b6b63, door.var_9528975d, door.var_695f85a3);
        }
      }
    }

    waitframe(1);
  }
}

function function_ab91c6bd(max_angle, var_172ec4a2, center, var_56dde451, var_edbba9) {
  self notify(#"hash_df103b3a3cae8ba");
  self endon(#"hash_df103b3a3cae8ba");
  self endon(#"death");
  door = self;
  assert(isint(max_angle) || isfloat(max_angle));
  assert(isvec(var_172ec4a2));
  assert(isvec(center));
  door.var_f50c2aae = center;
  door.var_c58b6b63 = 0;
  door.var_9528975d = 0;
  door.var_695f85a3 = 0;
  closed_pos = center + (0, 0, -6);
  var_cf42e01d = center + (0, 0, 6);
  var_c5cdd961 = undefined;
  var_60e98817 = [];
  var_695f85a3 = 1;
  var_9528975d = 0;
  var_5a37621d = -0.1;

  if(!array::contains(level.var_81065eb, door)) {
    level.var_81065eb[level.var_81065eb.size] = door;
  }

  level.var_f49d7de7 += 1;
  var_95416eea = level.var_f49d7de7 % 3;

  if(var_95416eea > 0) {
    waitframe(var_95416eea);
  }

  level thread function_8cdd2834();

  while(isDefined(door)) {
    wait 0.05;
    door_angles = door gettagangles("j_prop_1");

    if(!isvec(door_angles)) {
      door_angles = door.angles;
    }

    angle = function_74132496(door_angles, var_172ec4a2);
    angle = abs(angle);

    if(angle == var_5a37621d) {
      continue;
    }

    var_9528975d = snd::scalerp(angle, 0, max_angle, 0, 1);
    var_695f85a3 = 1 - var_9528975d;
    door.var_c58b6b63 = angle;
    door.var_9528975d = var_9528975d;
    door.var_695f85a3 = var_695f85a3;

    if(isstring(var_56dde451) && !snd::function_a6779cbd(var_c5cdd961) && var_695f85a3 >= 0.01) {
      var_c5cdd961 = snd::play([var_56dde451, 0.05], closed_pos);
      snd::function_f4f3a2a(var_c5cdd961, door);
    }

    if(snd::function_a6779cbd(var_c5cdd961)) {
      if(var_695f85a3 >= 0.01) {
        snd::set_volume(var_c5cdd961, var_695f85a3, 0.05);
      } else {
        snd::stop(var_c5cdd961, 0.05);
        var_c5cdd961 = undefined;
      }
    }

    if(isarray(var_edbba9)) {
      for(i = 0; i < var_edbba9.size; i++) {
        var_61524dce = var_edbba9[i];

        if(isstring(var_61524dce) && !snd::function_a6779cbd(var_60e98817[i]) && var_9528975d >= 0.01) {
          var_60e98817[i] = snd::play([var_61524dce, 0.05], var_cf42e01d);
          snd::function_f4f3a2a(var_60e98817[i], door);
        }

        if(snd::function_a6779cbd(var_60e98817[i])) {
          if(var_9528975d >= 0.01) {
            snd::set_volume(var_60e98817[i], var_9528975d, 0.05);
            continue;
          }

          snd::stop(var_60e98817[i], 0.05);
          var_60e98817[i] = undefined;
        }
      }
    }

    var_5a37621d = angle;
  }
}

function door_init(name) {
  door = self;
  door.var_5e64aa58 = name;
  var_d6db10aa = strreplace(name, "_door ", "");
  var_cd15714a = strtok(var_d6db10aa, " ");

  if(isarray(var_cd15714a) && var_cd15714a.size >= 3) {
    x = float(var_cd15714a[0]);
    y = float(var_cd15714a[1]);
    z = float(var_cd15714a[2]);
    var_172ec4a2 = (x, y, z);
    center = function_9a87c2ea(door);
    var_56dde451 = "emt_rain_door_wood_int_closed_lp";
    var_edbba9 = ["emt_rain_door_ext_open_lp", "env_rain_light_doorway_splatty_noduck", "amb_scr_rain_cement_alley_doorway_noduck"];

    if(isDefined(door.model)) {
      switch (door.model) {
        default:
          break;
        case # "stk_door_apt_wood_02":
          var_56dde451 = "emt_rain_door_wood_int_closed_lp";
          break;
      }
    }

    door thread function_ab91c6bd(60, var_172ec4a2, center, var_56dde451, var_edbba9);
  }
}

function function_73ed916e() {}

function function_f62c29d2(alias, locs, time_min, time_max, var_628a89ce, var_b441b64b) {
  thread function_53eb8f80(alias, locs, time_min, time_max, var_628a89ce, var_b441b64b);
}

function function_53eb8f80(alias, locs, time_min, time_max, var_628a89ce, var_b441b64b) {
  level endon(#"hash_2712b72478766d1c");

  if(!isarray(locs)) {
    locs = array(locs);
  }

  if(isDefined(var_628a89ce) && isDefined(var_b441b64b)) {
    wait randomfloatrange(var_628a89ce, var_b441b64b);
  }

  while(true) {
    snd::play(alias, locs[randomint(locs.size)]);
    wait randomfloatrange(time_min, time_max);
  }
}

function function_5d1af70e(alias, loc) {
  thread function_9f75b544(alias, loc);
}

function function_9f75b544(alias, loc) {
  ent = snd::play(alias, loc);
  level waittill(#"hash_2712b72478766d1c");
  snd::stop(ent, 0.25);
}

function function_5c579972(sndobjects, vol, time) {
  foreach(snd in snd::function_f218bff5(sndobjects)) {
    snd::set_volume(snd, vol, time);
  }
}

function function_74ebb152() {
  player = self;
  player endon(#"death");
  player notify(#"hash_1c4455ba87deaa81");
  player endon(#"hash_1c4455ba87deaa81");
  state = "exterior";

  while(isalive(player)) {
    result = player waittill(#"hash_194cb194c067a625");
    new_state = result.state;

    if(!isDefined(new_state)) {
      new_state = "exterior";
    }

    if(new_state != state) {
      state = new_state;

      switch (state) {
        case # "exterior":
        default:
          function_5c579972(level.var_79931c6, 1, 1);
          break;
        case # "partial":
          function_5c579972(level.var_79931c6, 0.5011, 1);
          break;
        case # "interior":
          function_5c579972(level.var_79931c6, 0.1, 1);
          break;
      }
    }
  }
}

function function_c3e35066() {
  if(isarray(level.var_79931c6)) {
    return;
  }

  var_c40cc8e9 = snd::play(["emt_rain_quad_nw_lp", 1], (-16384, 16384, 16384));
  var_c1f93de6 = snd::play(["emt_rain_quad_sw_lp", 1], (-16384, -16384, 16384));
  var_528a660e = snd::play(["emt_rain_quad_ne_lp", 1], (16384, 16384, 16384));
  var_27ba0aaa = snd::play(["emt_rain_quad_se_lp", 1], (16384, -16384, 16384));
  level.var_79931c6 = [var_c40cc8e9, var_c1f93de6, var_528a660e, var_27ba0aaa];
  players = snd::function_da785aa8();
  player = players[0];
  player thread function_74ebb152();
}

function function_d516219() {
  function_5ea2c6e3("cp_ger_stakeout_fadein", 0, 1);
  function_5ea2c6e3("cp_ger_stakeout_intro_black", 0, 1);
  waitframe(1);
  function_ed62c9c2("cp_ger_stakeout_fadein", 1);
}

function train_fade_up_from_black() {
  function_ed62c9c2("cp_ger_stakeout_intro_black", 2);
  level thread function_c56d39dc();
  level thread function_7aad0c65(1.25);
}

function private function_c56d39dc() {
  var_1feac42a = snd::play([3, "amb_train_intro_passenger_foley_lp"], (-9469, 8605, -129));
  level waittill(#"prep_teleport_train_player");
  snd::stop(var_1feac42a);
}

function private function_7aad0c65(initialwait) {
  level endon(#"hash_1fe344e4d4f0967c");
  players = snd::function_da785aa8();
  player = players[0];
  initialwait = snd::function_ea2f17d1(initialwait, 0);
  var_a89400b9 = (-9734, 8608, -82);
  var_9a4e642e = (-8958, 8608, -82);
  var_11b585be = [var_a89400b9, var_9a4e642e];
  var_9634044d = [];
  var_9634044d[#"vox_cp_stkt_02005_gmc1_pleasekeepallba_11"] = "vox_cp_stkt_02005_gmc1_pleasekeepallba_11";
  var_9634044d[#"vox_cp_stkt_02005_gmc1_drinkingalcohol_5d"] = "vox_cp_stkt_02005_gmc1_drinkingalcohol_5d";
  var_9634044d[#"vox_cp_stkt_02005_gmc1_haveyourpapersr_f9"] = "vox_cp_stkt_02005_gmc1_haveyourpapersr_f9";
  wait initialwait;

  while(true) {
    var_d5e2a244 = array::randomize(var_9634044d);
    var_d69bee61 = undefined;

    if(isDefined(var_d69bee61) && isDefined(var_d5e2a244[var_d69bee61])) {
      var_d5e2a244[var_d69bee61] = undefined;
    }

    foreach(var_83eb1f22 in var_d5e2a244) {
      waittime = 0.05;
      var_d69bee61 = var_83eb1f22;
      snd = snd::play(var_83eb1f22);
      snd::function_2fdc4fb(snd);
      wait randomfloatrange(15, 30);
    }
  }
}

function function_50e92688(ent) {
  assert(isDefined(ent));
  players = snd::function_da785aa8();
  player = players[0];
  var_f29db55e = (96, -96, 0);
  var_305bf397 = snd::play("emt_train_ext_alcove_whoosh_lp", [ent, var_f29db55e]);

  if(snd::function_a6779cbd(var_305bf397)) {
    var_305bf397 linkto(ent);
    level waittill(#"hash_19e230299ea7fcb3");
    snd::stop(var_305bf397, 2);
  }
}

function function_87b5665d() {
  players = snd::function_da785aa8();
  player = players[0];
  fadeintime = snd::function_ea2f17d1(fadeintime, 2);
  var_ca51e68c = snd::play("amb_train_int");
  var_72f53060 = snd::play("evt_stk_ghost_station_train_int_clack_lp", (-9007, 8608, -188));
  var_916fc49b = snd::play("evt_stk_train_int_vibrations_back_car_lp_01", (-9720, 8608, -88));
  var_811a23f0 = snd::play("evt_stk_train_int_vibrations_back_car_lp_02", (-8948, 8608, -88));
  var_d5e1b4de = snd::play("evt_stk_train_int_vibrations_rear_exit_lp", (-8276, 8608, -88));
  var_577a69e9 = snd::play("emt_train_intro_window_wind_lp_01", (-8738, 8668, -105));
  var_ef941a1e = snd::play("emt_train_intro_window_wind_lp_02", (-8618, 8667, -105));
  var_ee5a8f04 = snd::play("emt_train_intro_window_wind_lp_01", (-8616, 8547, -105));
  var_1c996b81 = snd::play("emt_train_intro_window_wind_lp_02", (-8495, 8548, -105));
  var_1f266b59 = snd::play(["emt_train_int_caboose_clacks_lp"], (-8283, 8610, -135));
  wait fadeintime + 0.5;
  level thread function_bd19eb7f();
  var_a206411d = 9;
  snd::set_volume(var_ca51e68c, snd::function_359f7bac(-7), var_a206411d);
  snd::set_volume(var_72f53060, snd::function_359f7bac(-10), var_a206411d);
  level waittill(#"inside_train_car_02");
  wait 6;
  var_4a6d4f6 = snd::play([1, "emt_train_intro_slowdown_brakes"], (-8425, 8603, -122));
  snd::set_pitch(var_ca51e68c, snd::function_d8b24901(-24), 20);
  snd::set_pitch(var_72f53060, snd::function_d8b24901(-4), 20);
  snd::set_pitch(var_916fc49b, snd::function_d8b24901(-6), 20);
  snd::set_pitch(var_811a23f0, snd::function_d8b24901(-6), 20);
  snd::set_pitch(var_d5e1b4de, snd::function_d8b24901(-6), 20);
  snd::set_pitch(var_577a69e9, snd::function_d8b24901(-6), 20);
  snd::set_pitch(var_ef941a1e, snd::function_d8b24901(-6), 20);
  snd::set_pitch(var_ee5a8f04, snd::function_d8b24901(-6), 20);
  snd::set_pitch(var_1c996b81, snd::function_d8b24901(-6), 20);
  var_6f062276 = [var_ca51e68c, var_72f53060, var_916fc49b, var_811a23f0, var_d5e1b4de, var_577a69e9, var_ef941a1e, var_ee5a8f04, var_1c996b81, var_4a6d4f6];
  level waittill(#"prep_teleport_train_player");
  wait 0.35;
  snd::stop(var_1f266b59, 0.1);
  arrayremovevalue(var_6f062276, undefined);

  foreach(snd in var_6f062276) {
    if(isDefined(snd)) {
      players = snd::function_da785aa8();
      player = players[0];
      snd linkto(player);
    }
  }

  level waittill(#"hash_19e230299ea7fcb3");
  wait 1;
  arrayremovevalue(var_6f062276, undefined);

  foreach(snd in var_6f062276) {
    if(isDefined(snd)) {
      snd unlink();
    }
  }

  wait 1;
  fadeouttime = 2;
  arrayremovevalue(var_6f062276, undefined);
  snd::stop(var_6f062276, fadeouttime);
  level thread function_1a1fd87a();
}

function function_a6b9fbbd() {
  level.var_f875cead = snd::play(["emt_train_intro_between_cars_lp_1", 1.2], (-9007, 8608, -180));
  level.var_38ad6843 = 1;
  level waittill(#"hash_2b77f5a80ef76375");
  snd::stop(level.var_f875cead, 0.5);
  level.var_38ad6843 = 0;
  level waittill(#"hash_56ddea8ab25198a");
  level.var_bf81dcc6 = snd::play(["emt_train_intro_between_cars_lp_2", 1.2], (-9007, 8608, -180));
  level.var_38ad6843 = 1;
  level waittill(#"hash_dd68c60c003c4d9");
  snd::set_volume(level.var_bf81dcc6, 0.3, 0.5);
  level waittill(#"hash_2b77f2a80ef75e5c");
  snd::stop(level.var_bf81dcc6, 0.5);
  level.var_38ad6843 = 0;
}

function function_bd19eb7f() {
  thread function_876b47e1("emt_train_ext_whoosh_lp", 0.2, 3);
  thread function_876b47e1("emt_train_between_cars_screech_lp", 0.2, 3);
}

function function_876b47e1(alias, time_min, time_max) {
  level endon(#"hash_790fd3997d6d47b3");
  players = snd::function_da785aa8();
  player = players[0];
  player endon(#"death");

  while(true) {
    playerview = player snd::getplayervieworigin();
    offset_x = randomintrange(1000, 2000) * -1;
    offset_y = randomintrange(0, 550) - 275 + 30;
    start_point = playerview + (offset_x, offset_y, -12);
    end_point = start_point + (3000, 0, 0);
    snd = snd::play(alias, start_point);
    snd thread function_39b2a7f0(end_point);
    wait randomfloatrange(time_min, time_max);
  }
}

function function_39b2a7f0(end_point) {
  speed = 5;
  self moveto(end_point, speed);
  wait speed;
  snd::stop(self);
}

function function_1a1fd87a() {
  if(isarray(level.var_20f9858b)) {
    return;
  }

  var_2c8a60fd = snd::play(["quad_stk_tunnel_int_front_lp", 2]);
  var_86594ee8 = snd::play(["quad_stk_tunnel_int_rear_lp", 2]);
  var_760715a2 = snd::play(["quad_stk_tunnel_int_air_lp", 2]);
  level.var_20f9858b = [var_2c8a60fd, var_86594ee8, var_760715a2];
  level waittill(#"ghost_station_done");
  snd::stop(var_2c8a60fd, 2);
  snd::stop(var_86594ee8, 2);
  snd::stop(var_760715a2, 2);
}

function guard_room_train_occlusion() {
  self thread function_3c2a62a3();
  players = snd::function_da785aa8();
  player = players[0];
  player endon(#"death");
  self.var_cbb87055 = 1;
  var_3598c02f = (-5206, 11111, -177);
  function_5ea2c6e3("cp_ger_stakeout_sewer_exit", 0, 0);

  while(self.var_cbb87055 == 1) {
    players = snd::function_da785aa8();
    player = players[0];
    dist = distance(player.origin, var_3598c02f);
    scale = snd::scalerp(dist, 0, 1300, 1, 0);
    function_672403ca("cp_ger_stakeout_sewer_exit", 0, scale);
    waitframe(1);
  }

  wait 30;
  function_ed62c9c2("cp_ger_stakeout_sewer_exit", 5);
}

function function_3c2a62a3() {
  level waittill(#"ghost_station_done");
  self.var_cbb87055 = 0;
}

function function_1fb9d5d6() {
  level notify(#"hash_2712b72478766d1c");
  var_83b0306c = (1189, 10490, 254);
  var_73e92e1e = (-2592, 8310, 619);
  var_fed91287 = (-1689, 15907, 596);
  var_a1fc9acd = (-2667, 16169, 252);
  function_f62c29d2("amb_thunder_rumble", [var_83b0306c, var_73e92e1e], 38, 74, 6, 11);
  function_f62c29d2("amb_thunder_rumble", [var_fed91287], 20, 74, 20, 74);
  function_f62c29d2("amb_traffic", [var_fed91287, var_a1fc9acd], 15, 20, 4, 6);
  function_f62c29d2("emt_dist_traffic", [var_83b0306c, var_fed91287, var_a1fc9acd], 20, 30, 10, 13);
  function_f62c29d2("emt_dist_dog_bark", [var_83b0306c, var_73e92e1e], 15, 25, 3, 5);
}

function function_7c0ea595() {
  snd::play(["env_rain_light_doorway_splatty", 1.5], (-4172, 11422, 359));
  snd::play(["env_rain_light_doorway_splatty2", 1.5], (-4173, 11711, 277));
  function_828e41f5();
}

function function_828e41f5() {
  level.var_9dd5b8ca = snd::play("amb_rooftop_distant_amb_lp", (-2804, 14811, 425));
  level.var_8542faf = snd::play("amb_rooftop_door_amb_lp_2", (-3082, 10819, 370));
  level.var_a43fc5cf = snd::play("amb_rooftop_door_amb_lp", (-4171, 11400, 337));
}

function function_dceebb0a() {
  wait 1.2;
  snd::stop(level.var_9dd5b8ca);
  snd::stop(level.var_8542faf);
  snd::stop(level.var_a43fc5cf);
  level.var_d9f8cee = snd::play("amb_street_distant_amb_lp", (474, 1044, 149));
  level.var_81acfd3f = snd::play("amb_street_start_door_lp", (-3079, 10792, 52));
  snd::play("env_rain_light_doorway_splatty", (-3059, 10794, 48));
  snd::play("amb_drain_ext_splat_close_01", (-3055, 10745, 9));
  snd::play("env_rain_light_splatty_lp_01", (-3061, 10800, 59));
  snd::play("env_rain_light_splatty_lp_01", (-2895, 10806, 9));
  snd::play("env_rain_light_street_narrow_lp_02", (-2883, 10832, 9));
  snd::play("env_rain_light_street_lp_02", (-3068, 10649, 68));
  snd::play("env_rain_light_street_main_lp", (-2555, 10818, 110));
  snd::play("env_rain_light_street_narrow_lp_02", (-2883, 10832, 9));
  snd::play("env_rain_light_street_main_lp", (-2555, 10818, 110));
  snd::play("env_rain_light_street_narrow_lp_02", (-2883, 10832, 9));
  snd::play("env_rain_light_doorway_splatty", (-2633, 10659, 78));
}

function police_build_up_bar() {
  players = snd::function_da785aa8();
  player = players[0];
  police_build_up_bar = snd::play([0, "amb_stk_police_build_up_lp", 20], (-1069, 9690, 60));
  snd::line_attach(police_build_up_bar, player, (-1069, 9690, 60), (-1078, 10173, 60));
  level waittill(#"hash_7c97bbd19494725c");
  snd::stop(police_build_up_bar, 5);
  wait 5;
  snd::line_detach(police_build_up_bar);
}

function function_7d3ac608() {
  car1 = snd::play("veh_street_searched_lp_01", (-2493, 9458, 58));
  car2 = snd::play("veh_street_searched_lp_02", (-1967, 11722, 75));
  level flag::wait_till("snd_bar_started");
  snd::stop(car1, 0.5);
  snd::stop(car2, 0.5);
}

function function_2794abbe() {
  level notify(#"hash_2712b72478766d1c");
  var_83b0306c = (1189, 10490, 254);
  var_73e92e1e = (-2592, 8310, 619);
  var_fed91287 = (-1689, 15907, 596);
  var_a1fc9acd = (-2667, 16169, 252);
  function_f62c29d2("emt_euro_siren_dist", [var_83b0306c, var_fed91287, var_a1fc9acd], 12, 20, 8, 10);
  function_f62c29d2("amb_thunder_rumble", [var_83b0306c, var_73e92e1e], 38, 74, 6, 11);
  function_f62c29d2("amb_thunder_rumble", [var_fed91287], 20, 74, 20, 74);
  function_f62c29d2("amb_traffic", [var_83b0306c, var_fed91287, var_a1fc9acd], 15, 20, 4, 6);
  function_f62c29d2("emt_dist_traffic", [var_83b0306c, var_fed91287, var_a1fc9acd], 25, 35, 10, 13);
  function_f62c29d2("emt_dist_dog_bark", [var_83b0306c, var_73e92e1e], 15, 25, 3, 5);
  function_5d1af70e("amb_traffic_dist_occluded_lp", var_83b0306c);
  function_5d1af70e("amb_traffic_multi_car", var_fed91287);
}

function function_1591cb13() {
  if(is_true(level.var_ba067910)) {
    return;
  }

  level.var_ba067910 = 1;
  level flag::wait_till("snd_bar_started");
  wait 1;
  music = snd::play("mus_bar", (-1559, 9838, 123));
  level waittill(#"hash_41e362c76ad6bdb7");
  wait 3;
  snd::stop(music, 30);
}

function bar_incoming() {
  snd = snd::play("amb_stk_police_build_up_bar_door_lp", (-1902, 9880, 90));
  snd::set_volume(snd, 0);
  wait 2;
  snd::set_volume(snd, 1, 1.5);
  wait 2;
  snd::set_volume(snd, 0.2, 1.5);
  wait 14;
  snd::set_volume(snd, 1, 1.5);
  wait 5;
  snd::set_volume(snd, 0.2, 1.5);
  level waittill(#"hash_230cd5b99068d083");
  snd::stop(snd, 3);
}

function function_6bd221d6() {
  players = snd::function_da785aa8();
  player = players[0];

  if(snd::function_81fac19d(!isPlayer(player), "alley_dynamic_emitters no player!!")) {
    if(snd::function_d78e3644()) {
      debugbreak();
    }
  } else {
    snd::emitter("emt_euro_siren_dist2", player, [35, 50], [1000, 4000]);
    snd::emitter("emt_dist_dog_bark", player, [15, 25], [3000, 5000]);
    snd::emitter("amb_thunder_rumble", player, [20, 74], [3000, 5000]);
    snd::emitter("amb_thunder_rumble", player, [38, 74], [3000, 5000]);
    snd::emitter("amb_alley_glass_break", player, [25, 40], [3000, 5000]);
  }

  snd::emitter("amb_alley_traffic", (-2568, 7930, 118), [12, 22]);
  snd::play("evt_police_intro", (-927, 8304, 143));
  siren = snd::play("amb_police_siren_intro", (-1376, 8118, 128));
  siren moveto((-787, 8113, 134), 1.5);
  var_d36489ab = snd::play("amb_police_siren_lp", (-787, 8113, 134));
  wait 5;
  snd::play("evt_police_intro_lp_01", (-933, 8326, 93));
  snd::play("evt_police_intro_lp_02", (-877, 8111, 92));
  snd::play("evt_police_intro_lp_03", (-1239, 8148, 81));
  snd::play("evt_police_intro_lp_02", (-621, 8933, 110));
  wait 15;
  snd::stop(var_d36489ab, 0.1);
  var_d36489ab = undefined;
}

function function_4edfeefa() {
  players = snd::function_da785aa8();
  player = players[0];

  if(snd::function_81fac19d(!isPlayer(player), "alley_dynamic_emitters no player!!")) {
    if(snd::function_d78e3644()) {
      debugbreak();
    }
  } else {
    thread function_f62c29d2("emt_euro_siren_dist3", (-1167, 1883, 149), 15, 25);
    snd::emitter("emt_dist_dog_bark", player, [15, 25], [3000, 5000]);
    snd::emitter("amb_thunder_rumble", player, [20, 74], [3000, 5000]);
    snd::emitter("amb_thunder_rumble", player, [38, 74], [3000, 5000]);
  }

  snd::emitter("amb_alley_traffic", (-2568, 7930, 118), [12, 22]);
}

function function_1d10f78a() {
  var_ca1e0a0b = snd::play("amb_scr_rain_on_manhole_closed", (-5239, 11115, -78));
  var_4b169aaf = snd::play("env_scr_drips_manhole_close_lp_01", (-5225, 11114, -40));
  var_283c9ebc = snd::play("amb_scr_heavy_on_plr_splat_lp", (-5226, 11110, -93));
  level waittill(#"hash_22c61e589a1f98c0");
  snd::stop(var_ca1e0a0b, 2);
  snd::stop(var_4b169aaf, 2);
  snd::stop(var_283c9ebc, 2);
  snd::play("amb_scr_manhole_open_2d_wide", (-5229, 11106, 128));
  var_f6084355 = snd::play("amb_scr_rain_on_manhole_open", (-5239, 11115, -78));
  wait 4;
  snd::play([0, "amb_stk_subway_manhole_exterior_lp", 2], (-5230, 11113, -27));
}

function function_552fe77() {
  function_ed62c9c2("cp_ger_stakeout_warehouse_intro");
}

function duck_ghost_station() {
  players = snd::function_da785aa8();
  player = players[0];
  var_16f8cca9 = player getlocalclientnumber();
  var_2534b9f9 = getEntArray(var_16f8cca9, "duck_ghost_station", "targetname");

  foreach(var_9a11ae59 in var_2534b9f9) {
    var_9a11ae59 thread function_5def1caf();
  }
}

function function_5def1caf() {
  players = snd::function_da785aa8();
  player = players[0];
  player endon(#"death");
  var_eee381c9 = 0;

  while(true) {
    players = snd::function_da785aa8();
    player = players[0];

    if(isDefined(self) && player istouching(self)) {
      if(var_eee381c9 == 0) {
        function_5ea2c6e3("cp_ger_stakeout_duck_ghost_station", 1, 1);
        var_eee381c9 = 1;
      }
    } else if(var_eee381c9 == 1) {
      function_ed62c9c2("cp_ger_stakeout_duck_ghost_station", 0.5);
      var_eee381c9 = 0;
    }

    waitframe(1);
  }
}