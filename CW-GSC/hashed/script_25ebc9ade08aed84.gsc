/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_25ebc9ade08aed84.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;

#namespace namespace_47809ab2;

function init() {
  zm_player::register_player_damage_callback(&function_6f03042);
  clientfield::register("toplayer", "" + #"flinger_pad_fling", 1, 1, "int");
  clientfield::register("allplayers", "" + #"hash_31c153af499657fd", 1, 1, "int");
  clientfield::register("scriptmover", "" + #"hash_5822132672ad230f", 1, 1, "int");
  clientfield::register("scriptmover", "" + #"hash_6219dce209d171ed", 1, 2, "int");
  level.var_d99df9f9 = 500;
  var_97d7f69d = [];
  var_867ebaba = getEntArray("flinger_pad_aimer", "targetname");

  foreach(entity in var_867ebaba) {
    if(entity.script_noteworthy === "jump_pad") {
      if(!isDefined(var_97d7f69d)) {
        var_97d7f69d = [];
      } else if(!isarray(var_97d7f69d)) {
        var_97d7f69d = array(var_97d7f69d);
      }

      if(!isinarray(var_97d7f69d, entity)) {
        var_97d7f69d[var_97d7f69d.size] = entity;
      }

      entity pingable();
    }
  }

  array::thread_all(var_97d7f69d, &function_cc21ae2e);
  callback::on_spawned(&function_c10ae9f9);

  level thread devgui_setup();
}

function function_c10ae9f9() {
  self endon(#"death");

  while(true) {
    self flag::clear(#"flinger_disabled");

    while(!self zm_laststand::function_c3249e8c() && !(self laststand::player_is_in_laststand() && self zm_laststand::function_30b9cdd5())) {
      waitframe(1);
    }

    self flag::set(#"flinger_disabled");

    while(self zm_laststand::function_c3249e8c() || self laststand::player_is_in_laststand() && self zm_laststand::function_30b9cdd5() || self useButtonPressed()) {
      waitframe(1);
    }
  }
}

function function_cc21ae2e() {
  level flag::wait_till("start_zombie_round_logic");
  self.var_43032f5e = util::spawn_model("tag_origin", self.origin, self.angles);
  self.var_63c8edf4 = util::spawn_model("tag_origin", self.origin, self.angles);
  self.var_6f3293fb = util::spawn_model(#"p9_zm_gold_jumppads_machine_main_lights", self.origin, self.angles);
  self.var_6f3293fb clientfield::set("" + #"hash_6219dce209d171ed", 1);
  self.var_63c8edf4 linkTo(self);
  self.var_6f3293fb linkTo(self);
  var_b0c3aec3 = getEntArray("flinger_landing_pad", "targetname");

  foreach(flinger_landing_pad in var_b0c3aec3) {
    if(flinger_landing_pad.script_noteworthy === "landing_pad" && self.script_int === flinger_landing_pad.script_int) {
      flinger_landing_pad thread function_b4913776();
      self.landing_pad = flinger_landing_pad;
      self.var_803f2038 = "landing_pad_active" + flinger_landing_pad.script_int;
      flinger_landing_pad.var_90ddceac = self;
      flinger_landing_pad pingable();
      break;
    }
  }

  self.vol_fling = getEnt("flinger_vol" + self.script_int, "targetname");
  var_948355ad = self zm_unitrigger::create(&function_679a29cd, 100, &function_23ef27c);
  var_948355ad.origin = self.origin + (0, 0, 30);
  var_948355ad.cost = 500;
  var_948355ad.var_90ddceac = self;
  var_948355ad.var_b555f02e = self.var_b555f02e;
  var_948355ad.var_803f2038 = self.var_803f2038;
  var_948355ad.var_90ddceac.var_37db5cf = 1;
  self.var_2ddd9b0c = getvehiclenode("flinger_vehicle_startnode" + self.script_int, "targetname");
  self thread function_b2a2cce8();
}

function function_b2a2cce8() {
  while(true) {
    level flag::wait_till("captured_control_point" + self.var_b555f02e);
    self clientfield::set("" + #"hash_5822132672ad230f", 1);
    level flag::wait_till_clear("captured_control_point" + self.var_b555f02e);
    self clientfield::set("" + #"hash_5822132672ad230f", 0);
  }
}

function function_679a29cd(player) {
  if(self.stub.var_90ddceac flag::get("jump_pad_quest_start")) {
    self setHintString("");
    return 0;
  }

  if(isPlayer(player)) {
    player globallogic::function_d96c031e();

    if(player flag::get(#"flinger_disabled")) {
      return 0;
    } else if(isDefined(self.stub.var_b555f02e) && !level flag::get("power_on" + self.stub.var_b555f02e)) {
      self sethintstringforplayer(player, #"hash_693242528304c52d");
      return 1;
    } else if(isDefined(self.stub.var_803f2038) && !level flag::get(self.stub.var_803f2038)) {
      self sethintstringforplayer(player, #"hash_6a411ebcdb1ae4b4");
      return 1;
    } else if(!is_true(self.stub.var_90ddceac.var_37db5cf)) {
      self sethintstringforplayer(player, #"hash_6b9dfd4a8ab2a386");
      return 1;
    } else if(level flag::get(#"satellite_moving")) {
      self sethintstringforplayer(player, #"hash_344777202de67020");
      return 1;
    } else {
      switch (self.stub.var_90ddceac.script_string) {
        case #"napalm_strike":
          hint_string = player zm_utility::function_d6046228(#"hash_1c38e0fdb20ef055", #"hash_52a497d7fdd2698b");
          self sethintstringforplayer(player, hint_string, level.var_d99df9f9);

          if(!player zm_score::can_player_purchase(level.var_d99df9f9)) {
            player globallogic::function_d1924f29(#"hash_6e3ae7967dc5d414");
          }

          break;
        case #"data_center":
          hint_string = player zm_utility::function_d6046228(#"hash_306dab4c836b1026", #"hash_2771ace3aa8dfe02");
          self sethintstringforplayer(player, hint_string, level.var_d99df9f9);

          if(!player zm_score::can_player_purchase(level.var_d99df9f9)) {
            player globallogic::function_d1924f29(#"hash_6e3ae7967dc5d414");
          }

          break;
        case #"chopper_gunner":
          hint_string = player zm_utility::function_d6046228(#"hash_61ac30cb1d0b9c0", #"hash_6d2d30daf8cd1ec");
          self sethintstringforplayer(player, hint_string, level.var_d99df9f9);

          if(!player zm_score::can_player_purchase(level.var_d99df9f9)) {
            player globallogic::function_d1924f29(#"hash_6e3ae7967dc5d414");
          }

          break;
        default:
          break;
      }

      return 1;
    }

    return 0;
  }
}

function function_23ef27c() {
  level endon(#"end_game");

  while(true) {
    waitresult = self waittill(#"trigger");
    player = waitresult.activator;

    if(!is_true(self.stub.var_90ddceac.var_37db5cf)) {
      continue;
    }

    if(!level flag::get(self.stub.var_803f2038)) {
      continue;
    }

    if(!level flag::get("power_on" + self.stub.var_b555f02e)) {
      continue;
    }

    if(level flag::get(#"satellite_moving")) {
      continue;
    }

    if(!isPlayer(player)) {
      continue;
    }

    if(player flag::get(#"flinger_disabled")) {
      continue;
    }

    if(!player zm_score::can_player_purchase(level.var_d99df9f9)) {
      continue;
    } else {
      player zm_score::minus_to_player_score(level.var_d99df9f9);
    }

    playSoundAtPosition(#"evt_landingpad_activate", self.origin);
    player thread function_d9e25369(self.stub.var_90ddceac);
    level notify(#"hash_cb2d8c59ec2fc84", {
      #var_b8e13043: self.stub.var_90ddceac.script_int
    });
    self.stub.var_90ddceac thread function_f626ab3d();
    waitframe(1);
  }
}

function function_f626ab3d() {
  self endon(#"jump_pad_quest_start");
  self.var_37db5cf = 0;
  wait 5;
  self function_7c7f1e12();
  wait 30;
  self.var_37db5cf = 1;
  self function_b858693f(self.var_b555f02e);
}

function function_d9e25369(var_90ddceac) {
  level endon(#"end_game");
  var_90ddceac endon(#"jump_pad_quest_start");
  a_players = function_a1ef346b();
  var_d044a2f0 = self;
  var_945f1b6c = 5;

  while(var_945f1b6c > 0) {
    if(isalive(var_d044a2f0)) {
      var_d044a2f0 thread do_fling(var_90ddceac.var_2ddd9b0c, var_90ddceac.landing_pad);
      arrayremovevalue(a_players, var_d044a2f0);

      if(a_players.size == 0) {
        return;
      }

      var_d044a2f0 = undefined;
      var_bea2fd38 = 0.25;
    } else {
      var_bea2fd38 = 0.05;
    }

    var_945f1b6c -= var_bea2fd38;
    wait var_bea2fd38;

    foreach(player in a_players) {
      if(isalive(player) && player istouching(var_90ddceac.vol_fling)) {
        var_d044a2f0 = player;
        break;
      }
    }
  }
}

function function_a23af398() {
  self endon(#"flinger_landed");
  level waittill(#"end_game");

  if(isDefined(self)) {
    self.var_62b63681 = 1;
  }
}

function function_c9e3b586(str_notify) {
  self val::reset_all(#"fling_player");
  self.is_flung = undefined;
  self.var_16735873 = 0;
  self notify(#"flinger_landed");
  self clientfield::set_to_player("" + #"flinger_pad_fling", 0);
  self clientfield::set("" + #"hash_31c153af499657fd", 0);
  self solid();

  if(isDefined(self.var_dc3c3330)) {
    self.var_dc3c3330 delete();
  }

  self zm_utility::clear_streamer_hint();
}

function do_fling(nd_start, var_b338b8ed) {
  self endoncallback(&function_c9e3b586, #"death");

  if(isPlayer(self)) {
    self thread function_a23af398();
    self val::set(#"fling_player", "takedamage", 0);
    self function_bc82f900(#"hash_37581512bae8abf3");
    self.is_flung = 1;
    self.var_16735873 = 1;

    while(self isslamming()) {
      util::wait_network_frame();
    }

    self zm_utility::create_streamer_hint(var_b338b8ed.origin, self.angles, 1);
    self notsolid();

    if(!self inlaststand()) {
      self val::set(#"fling_player", "allow_crouch", 0);
      self val::set(#"fling_player", "allow_prone", 0);
      self val::set(#"fling_player", "allow_stand", 1);

      if(self getstance() != "stand") {
        self setstance("stand");
      }
    }

    self clientfield::set_to_player("" + #"flinger_pad_fling", 1);
    self clientfield::set("" + #"hash_31c153af499657fd", 1);
    playSoundAtPosition(#"evt_jumppad_fling", self.origin);
    self.var_dc3c3330 = vehicle::spawn(undefined, "player_vehicle", "fake_vehicle", nd_start.origin, nd_start.angles);
    self function_648c1f6(self.var_dc3c3330, undefined, 0, 180, 180, 180, 180, 1, 1);
    self.var_dc3c3330 setignorepauseworld(1);
    self.var_dc3c3330 vehicle::get_on_and_go_path(nd_start);
    self.var_dc3c3330 waittill(#"reached_end_node");
    self thread function_695ec0(var_b338b8ed);
    self solid();
    self thread function_b7e924cf();

    if(!self inlaststand()) {
      self val::reset(#"fling_player", "allow_crouch");
      self val::reset(#"fling_player", "allow_prone");
      self val::reset(#"fling_player", "allow_stand");
    }

    waitframe(1);
    self.is_flung = undefined;
    self.var_16735873 = 0;
    self notify(#"flinger_landed");
    self clientfield::set_to_player("" + #"flinger_pad_fling", 0);
    self clientfield::set("" + #"hash_31c153af499657fd", 0);
    playSoundAtPosition(#"evt_jumppad_land", self.origin);
    self.var_dc3c3330 delete();
    self zm_utility::clear_streamer_hint();
  }
}

function function_b7e924cf() {
  wait 0.5;
  self val::reset(#"fling_player", "takedamage");
}

function function_695ec0(var_b338b8ed) {
  if(isPlayer(self)) {
    var_14ddabc6 = var_b338b8ed function_a5df8834(self);

    for(var_15316677 = var_14ddabc6.origin; positionwouldtelefrag(var_15316677); var_15316677 = var_14ddabc6.origin + (randomfloatrange(-24, 24), randomfloatrange(-24, 24), 0)) {
      waitframe(1);
    }

    if(isPlayer(self)) {
      self unlink();
      self setOrigin(var_15316677);
    }

    if(is_true(self.var_62b63681)) {
      self val::set(#"fling_player", "freezecontrols", 1);
    }

    wait 3;
    var_14ddabc6.occupied = undefined;
  }
}

function function_a5df8834(player) {
  a_s_spots = struct::get_array(self.target, "targetname");

  foreach(spot in a_s_spots) {
    player_id = player getentitynumber();

    if(spot.script_int === player_id) {
      var_3cb2df83 = spot;
      break;
    }
  }

  return var_3cb2df83;
}

function function_6f03042(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
  if(is_true(self.is_flung)) {
    return 0;
  }

  return -1;
}

function function_b4913776() {
  level endon(#"end_game");
  self.mdl = util::spawn_model(#"p9_zm_gold_jumppads_machine_sub_off", self.origin, self.angles);
  self.mdl.targetname = "landing_pad";
  self.var_43032f5e = util::spawn_model("tag_origin", self.origin, self.angles);
  self.var_63c8edf4 = util::spawn_model("tag_origin", self.origin, self.angles);
  self.var_43032f5e linkTo(self);
  self.var_63c8edf4 linkTo(self);
  level flag::wait_till("power_on" + self.var_b555f02e);
  level flag::set("landing_pad_active" + self.script_int);
  self function_726d8f3a();
}

function function_726d8f3a(var_fd713d4b = 1) {
  if(!isDefined(self.var_43032f5e) || !isDefined(self.var_63c8edf4)) {
    return;
  }

  if(var_fd713d4b) {
    self.var_43032f5e setModel(#"hash_487c692b572bc449");
    wait 0.3;
    self.var_43032f5e setModel(#"hash_487c662b572bbf30");
    wait 0.3;
    self.var_43032f5e setModel(#"hash_487c672b572bc0e3");
    wait 0.3;
  }

  self.var_63c8edf4 setModel(#"p9_zm_gold_jumppads_machine_sub_screen_green");

  switch (self.script_int) {
    case 1:
      self.var_43032f5e setModel(#"p9_zm_gold_jumppads_machine_sub_number_green_01");
      break;
    case 2:
      self.var_43032f5e setModel(#"p9_zm_gold_jumppads_machine_sub_number_green_02");
      break;
    case 3:
      self.var_43032f5e setModel(#"p9_zm_gold_jumppads_machine_sub_number_green_03");
      break;
    case 4:
      self.var_43032f5e setModel(#"p9_zm_gold_jumppads_machine_sub_number_green_04");
      break;
    case 5:
      self.var_43032f5e setModel(#"p9_zm_gold_jumppads_machine_sub_number_green_05");
      break;
    case 6:
      self.var_43032f5e setModel(#"p9_zm_gold_jumppads_machine_sub_number_green_06");
      break;
    default:
      break;
  }

  if(level flag::get("power_on" + self.var_90ddceac.var_b555f02e)) {
    function_b858693f(self.var_90ddceac.var_b555f02e);
  }
}

function function_b858693f(index) {
  var_1c9a65cd = getEntArray("flinger_pad_aimer", "targetname");

  foreach(var_90ddceac in var_1c9a65cd) {
    if(var_90ddceac.var_b555f02e == index) {
      if(!isDefined(var_90ddceac.var_43032f5e) || !isDefined(var_90ddceac.var_63c8edf4) || !isDefined(var_90ddceac.var_6f3293fb)) {
        break;
      }

      switch (var_90ddceac.script_int) {
        case 1:
          var_b4fbcdc9 = #"p9_zm_gold_jumppads_machine_main_number_green_01";
          break;
        case 2:
          var_b4fbcdc9 = #"p9_zm_gold_jumppads_machine_main_number_green_02";
          break;
        case 3:
          var_b4fbcdc9 = #"p9_zm_gold_jumppads_machine_main_number_green_03";
          break;
        case 4:
          var_b4fbcdc9 = #"p9_zm_gold_jumppads_machine_main_number_green_04";
          break;
        case 5:
          var_b4fbcdc9 = #"p9_zm_gold_jumppads_machine_main_number_green_05";
          break;
        case 6:
          var_b4fbcdc9 = #"p9_zm_gold_jumppads_machine_main_number_green_06";
          break;
        default:
          break;
      }

      if(level flag::get(var_90ddceac.var_803f2038)) {
        var_90ddceac.var_43032f5e setModel(#"p9_zm_gold_jumppads_machine_main_number_green_arrow");
        var_90ddceac.var_63c8edf4 setModel(#"p9_zm_gold_jumppads_machine_main_screen_green");
        var_90ddceac.var_63c8edf4 stoploopsound();
        var_90ddceac.var_63c8edf4 playSound(#"hash_56bfe731349ae3ce");
      } else {
        var_90ddceac.var_43032f5e setModel(var_b4fbcdc9);
        var_90ddceac.var_63c8edf4 setModel(#"hash_16fb2319be7e56c7");
      }

      var_90ddceac.var_6f3293fb clientfield::set("" + #"hash_6219dce209d171ed", 2);

      if(!var_90ddceac scene::is_playing(#"p9_fxanim_zm_gold_jumppads_machine_bundle", "play")) {
        var_90ddceac thread scene::play(#"p9_fxanim_zm_gold_jumppads_machine_bundle", "play", var_90ddceac);
      }
    }
  }
}

function function_7c7f1e12() {
  if(!isDefined(self.var_43032f5e) || !isDefined(self.var_63c8edf4) || !isDefined(self.var_6f3293fb)) {
    return;
  }

  self.var_43032f5e setModel(#"p9_zm_gold_jumppads_machine_main_number_red_x");
  self.var_63c8edf4 setModel(#"p9_zm_gold_jumppads_machine_main_screen_red");
  self.var_63c8edf4 playLoopSound(#"hash_53528a3f2802b9d9");
}

function function_df6e6fce() {
  if(!isDefined(self.var_43032f5e)) {
    return;
  }

  switch (self.script_int) {
    case 1:
      self.var_43032f5e setModel(#"p9_zm_gold_jumppads_machine_sub_number_red_01");
      break;
    case 2:
      self.var_43032f5e setModel(#"p9_zm_gold_jumppads_machine_sub_number_red_02");
      break;
    case 3:
      self.var_43032f5e setModel(#"p9_zm_gold_jumppads_machine_sub_number_red_03");
      break;
    case 4:
      self.var_43032f5e setModel(#"p9_zm_gold_jumppads_machine_sub_number_red_04");
      break;
    case 5:
      self.var_43032f5e setModel(#"p9_zm_gold_jumppads_machine_sub_number_red_05");
      break;
    case 6:
      self.var_43032f5e setModel(#"p9_zm_gold_jumppads_machine_sub_number_red_06");
      break;
    default:
      break;
  }
}

function function_1f622ac(index) {
  var_97d7f69d = getEntArray("flinger_pad_aimer", "targetname");

  foreach(var_90ddceac in var_97d7f69d) {
    if(var_90ddceac.var_b555f02e == index && var_90ddceac.script_noteworthy === "jump_pad") {
      var_90ddceac.var_43032f5e setModel("tag_origin");
    }

    var_90ddceac.var_6f3293fb clientfield::set("" + #"hash_6219dce209d171ed", 1);
    var_90ddceac scene::stop(#"p9_fxanim_zm_gold_jumppads_machine_bundle");
  }

  var_b0c3aec3 = getEntArray("flinger_landing_pad", "targetname");

  foreach(landing_pad in var_b0c3aec3) {
    if(landing_pad.var_b555f02e == index && landing_pad.script_noteworthy === "landing_pad") {
      landing_pad.var_43032f5e setModel("tag_origin");
    }
  }
}

function devgui_setup() {
  util::add_debug_command("<dev string:x38>");
  util::add_debug_command("<dev string:x8b>");
  zm_devgui::add_custom_devgui_callback(&cmd);
}

function cmd(cmd) {
  switch (cmd) {
    case #"hash_3785a966b663fa40":
      function_de5992a1();
      break;
    case #"hash_627810dd51e05760":
      function_f4d4dc3b();
      break;
    default:
      break;
  }
}

function function_de5992a1() {
  var_97d7f69d = getEntArray("<dev string:xe2>", "<dev string:xf7>");

  foreach(var_90ddceac in var_97d7f69d) {
    if(isDefined(var_90ddceac.var_6f3293fb)) {
      var_90ddceac.var_6f3293fb clientfield::set("<dev string:x105>" + #"hash_6219dce209d171ed", 1);
    }
  }
}

function function_f4d4dc3b() {
  var_97d7f69d = getEntArray("<dev string:xe2>", "<dev string:xf7>");

  foreach(var_90ddceac in var_97d7f69d) {
    if(isDefined(var_90ddceac.var_6f3293fb)) {
      var_90ddceac.var_6f3293fb clientfield::set("<dev string:x105>" + #"hash_6219dce209d171ed", 0);
    }
  }
}