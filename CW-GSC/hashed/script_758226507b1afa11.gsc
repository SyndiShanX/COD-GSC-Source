/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_758226507b1afa11.gsc
***********************************************/

#using script_3dc93ca9902a9cda;
#using script_758226507b1afa11;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_sp;
#using scripts\cp_common\snd_utility;
#using scripts\cp_common\util;
#namespace namespace_5ceacc03;

function private event_handler[level_preinit] function_b489bb7b(eventstruct) {
  snd::function_5e69f468(&_objective);
  level.var_81065eb = [];
}

function private event_handler[event_cc819519] function_686b88aa(eventstruct) {
  snd::wait_init();
  snd::waitforplayers();
  level thread function_e793b7d8();
  function_73158de8();

  snd::dvar("<dev string:x38>", "<dev string:x4e>" + 4, &function_5e7cc862);
  snd::dvar("<dev string:x52>", "<dev string:x4e>" + 20, &function_5e7cc862);
}

function function_73158de8() {
  animation::add_notetrack_func("cp_ger_stakeout_audio::informant_guard_death_01", &function_602188b9);
  animation::add_notetrack_func("cp_ger_stakeout_audio::informant_guard_death_02", &function_49ed1b5);
  animation::add_notetrack_func("cp_ger_stakeout_audio::informant_guard_death_03", &function_f6443500);
  animation::add_notetrack_func("cp_ger_stakeout_audio::alley_2_harass_v3_open_door", &function_8732cf25);
}

function function_602188b9(params) {
  snd::play("evt_basement_guard_death_01", (343, 7397, -124));
}

function function_49ed1b5(params) {
  snd::play("evt_basement_guard_death_02", (395, 7606, -136));
}

function function_f6443500(params) {
  snd::play("evt_basement_guard_death_03", (273, 7772, -112));
}

function function_8732cf25(params) {
  snd::play("fly_stk_alley2_door_harass_stasi_v3_door_open", (-1884, 7452, 74));
}

function anim_debug() {
  notetracks = ["z_stk_door_harass_civ_loop_stasi02", "z_stk_door_harass_civ_start_stasi02"];

  foreach(notetrack in notetracks) {
    thread function_9d0d23f0(notetrack);
  }
}

function function_9d0d23f0(notetrack) {
  while(true) {
    level waittill(notetrack);

    iprintlnbold(notetrack);
  }
}

function private _objective(objective) {
  level thread function_6fa4a52();

  switch (objective) {
    case # "train":
      level thread function_a20133bd();
      function_818cbaa9();
      level thread function_cc419f00();
      thread function_ae5a068d();
      break;
    case # "ghost_station":
      level thread function_a20133bd();
      snd::client_msg(#"hash_5a65194efa8dcb0f");
      level thread function_11cd4580();
      level thread function_47f39a4f();
      level thread function_46b43795();
      level thread function_f6a3d7df();
      level thread guard_room_train_occlusion();
      break;
    case # "ghost_station_exit":
      level thread function_a20133bd();
      break;
    case # "wall":
      level thread function_a20133bd();
      thread function_bb969e94();
      thread function_36cc557();
      thread function_c7ac1381();
      snd::client_msg("wall_interior");
      level flag::wait_till("move_wall_allies_01a");
      snd::client_msg("rooftop_start");
      break;
    case # "rooftop":
      level thread function_a20133bd();
      thread function_bb969e94();
      thread function_36cc557();
      break;
    case # "street":
      level thread function_a20133bd();
      thread function_bb969e94();
      thread function_36cc557();
      thread function_c7ac1381();
      level thread function_4e7aa055();
      thread function_115e410e();
      snd::client_msg("street");
      break;
    case # "bar":
      level thread function_a20133bd();
      level flag::wait_till("player_in_bar");
      break;
    case # "hash_7c9606c7fc0bc2c6":
      level thread function_a20133bd();
      thread function_bb969e94();
      thread function_36cc557();
      thread function_c7ac1381();
      wait 1;
      snd::client_msg("police_build_up_bar");
      break;
    case # "hash_7c9605c7fc0bc113":
      level thread function_a20133bd();
      level thread stealth_music();
      thread function_bb969e94();
      thread function_36cc557();
      doors::waittill_door_opened("alley_2_end_door");
      thread function_2ef70099();
      break;
    case # "alley_3":
      level thread function_a20133bd();
      level thread stealth_music();
      thread function_bb969e94();
      thread function_36cc557();
      thread function_2ef70099();
      break;
    case # "meetup":
      level thread function_a20133bd();
      level thread function_3eec13f8("9.0_informant_safehouse");
      thread function_bb969e94();
      thread function_36cc557();
      break;
    case # "apt_street":
      level thread function_a20133bd();
      level thread function_3eec13f8("13.0_apartment");
      thread function_bb969e94();
      thread function_36cc557();
      break;
    case # "hash_5316a2a443ccd594":
      function_4b193e02();
      break;
    case # "hash_5316a5a443ccdaad":
      function_4b193e02();
      break;
    case # "warehouse_intro":
      function_4b193e02();
      snd::client_msg("warehouse_intro");
      snd::play("evt_warehouse_wake_up");
      thread function_a4a301cb();
      thread warehouse_guns_start();
      break;
    case # "warehouse":
      function_4b193e02();
      snd::client_msg("warehouse");
      thread warehouse_guns_start();
      waitframe(1);
      level notify(#"warehouse_guns_start");
      thread function_a4a301cb();
      break;
    case # "hash_48642c08eff0a94c":
      function_4b193e02();
      thread function_a4a301cb();
      break;
    case # "no_game":
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x68>" + objective + "<dev string:x8b>");

      break;
  }
}

function music(str_msg, n_delay = 0) {
  level thread function_7edafa59(str_msg, n_delay);
  level thread function_e80c0ccf(str_msg);
}

function function_7edafa59(str_msg, n_delay) {
  switch (str_msg) {
    case # "8.0_low_profile":
    case # "9.0_informant_safehouse":
    case # "6.0_incoming":
    case # "14.0_find_briefcase":
    case # "hash_19e6ebac6ad70854":
    case # "hash_1acc529b509e310e":
    case # "hash_1e0888670e800fc6":
    case # "1.0_train":
    case # "10.0_informant_combat":
    case # "hash_2c7e72eef7c943cd":
    case # "hash_38e044116cdb55fd":
    case # "9.0_informant_safehouse_2":
    case # "6.0_incoming_skipto":
    case # "4.0_rooftops":
    case # "hash_4bcc9fef87077870":
    case # "13.0_apartment":
    case # "9.0_informant_safehouse_stinger":
    case # "hash_4f417dd0d24a9d04":
    case # "hash_51e60bc34c1efac4":
    case # "hash_5867d18cd788d96e":
    case # "hash_6bc99a264a7eb868":
    case # "12.0_company":
    case # "5.0_kraus":
      music::setmusicstate(str_msg, undefined, n_delay);
      break;
    case # "hash_13bb4e260ce73d4":
      music::function_2af5f0ec(str_msg);
      break;
    case # "4.0_rooftops_stinger_2":
    case # "4.0_rooftops_stinger_1":
    case # "13.0_apartment_stinger":
      music::function_edda155f(str_msg, n_delay);
      break;
    case # "deactivate_1.0_train":
    case # "deactivate_5.0_kraus":
    case # "deactivate_6.0_incoming":
    case # "deactivate_14.0_find_briefcase":
      music::setmusicstate("none", undefined, n_delay);
      break;
    default:

      iprintlnbold("<dev string:x90>" + str_msg + "<dev string:xa2>");

      break;
  }
}

function function_e80c0ccf(str_msg) {
  switch (str_msg) {
    case # "1.0_train":
      snd::client_msg(#"musictrack_cp_stakeout_1");
      break;
    case # "5.0_kraus":
      snd::client_msg(#"musictrack_cp_stakeout_2");
      break;
    case # "14.0_find_briefcase":
      snd::client_msg(#"musictrack_cp_stakeout_3");
      break;
    case # "hash_5867d18cd788d96e":
      snd::client_msg(#"musictrack_cp_stakeout_4");
      break;
  }
}

function function_e793b7d8() {
  players = snd::getplayerssafe();
  player = players[0];
  player thread dialogue::queue("");
  player thread dialogue::radio("");
}

function function_6fa4a52() {
  var_f72a16b8 = [];
  var_f72a16b8[var_f72a16b8.size] = "bar_front_door";
  var_f72a16b8[var_f72a16b8.size] = "alley_1_tutorial_door";
  var_f72a16b8[var_f72a16b8.size] = "alley_rooftop_door";
  var_f72a16b8[var_f72a16b8.size] = "alley_bldg_01_door_01";
  var_f72a16b8[var_f72a16b8.size] = "alley_bldg_01_door_02";
  var_f72a16b8[var_f72a16b8.size] = "alley_bldg_01_door_03";
  var_f72a16b8[var_f72a16b8.size] = "alley_bldg_02_01";
  var_f72a16b8[var_f72a16b8.size] = "alley_bldg_02_02";
  var_f72a16b8[var_f72a16b8.size] = "alley_bldg_stealth_01";
  var_f72a16b8[var_f72a16b8.size] = "alley_bldg_stealth_02";
  var_f72a16b8[var_f72a16b8.size] = "informant_door";
  var_f72a16b8[var_f72a16b8.size] = "alley_2_end_door";
  var_f72a16b8[var_f72a16b8.size] = "door_electronics_store";
  var_f72a16b8[var_f72a16b8.size] = "door_electronics_store";
  var_f72a16b8[var_f72a16b8.size] = "tgt_apt_lobby_door";
  var_f72a16b8[var_f72a16b8.size] = "warehouse_entrance_door";
  var_f72a16b8[var_f72a16b8.size] = "warehouse_door_to_outro";
  var_f72a16b8[var_f72a16b8.size] = "adler_alley_door";
  var_f72a16b8[var_f72a16b8.size] = "adler_roof_door1";
  snd::waitforplayers();

  if(!isarray(level.var_81065eb)) {
    level.var_81065eb = [];
  }

  var_a5e2ead2 = array();
  doors = doors::get_doors();
  adler_alley_door = getent("adler_alley_door", "targetname");
  doors[doors.size] = adler_alley_door;
  adler_roof_door1 = getent("adler_roof_door1", "targetname");
  doors[doors.size] = adler_roof_door1;

  foreach(door in snd::function_f218bff5(doors)) {
    name = door.targetname;

    if(isstring(name) && name != "") {
      var_e02250 = array::contains(var_f72a16b8, name);

      if(var_e02250) {
        var_a5e2ead2[var_a5e2ead2.size] = door;
      }
    }
  }

  var_79ec8125 = 0;

  foreach(door in snd::function_f218bff5(var_a5e2ead2)) {
    door_init(door);
    var_79ec8125 += 1;

    if(var_79ec8125 >= 3) {
      var_79ec8125 = 0;
      waitframe(1);
    }
  }
}

function door_init(door) {
  door_ent = undefined;
  var_172ec4a2 = (0, 0, 0);

  if(isentity(door) && isDefined(door.model)) {
    door_ent = door;
    var_172ec4a2 = door_ent gettagangles("j_prop_1");

    if(!isvec(var_172ec4a2)) {
      var_172ec4a2 = door_ent.angles;
    }

    var_eac469eb = function_9a87c2ea(door_ent);
    door_ent.var_dd9c7c9 = var_eac469eb;
  } else if(isstruct(door) && isDefined(door.c_door)) {
    door_ent = door doors::function_73f09315();
    var_172ec4a2 = door.c_door doors::get_door_angles(1);
  }

  if(isentity(door_ent)) {
    name = "_door " + var_172ec4a2[0] + " " + var_172ec4a2[1] + " " + var_172ec4a2[2];
    snd::client_targetname(door_ent, name);

    if(isarray(level.var_81065eb) && !array::contains(level.var_81065eb, door_ent)) {
      level.var_81065eb[level.var_81065eb.size] = door_ent;
    }
  }
}

function function_9a87c2ea(ent) {
  var_9ba2a2c = getxmodelcenteroffset(ent.model, 1);
  var_9998d3ec = rotatepoint(var_9ba2a2c, ent.angles);
  return ent.origin + (var_9998d3ec[0], var_9998d3ec[1], 55);
}

function private function_8ce760cb() {
  snd::waitforplayers();
  doors = doors::get_doors();
  door_ents = array();

  foreach(door in snd::function_f218bff5(doors)) {
    door_ent = door doors::function_73f09315();
    var_eac469eb = door.c_door doors::get_door_center();
    door_ent.var_dd9c7c9 = var_eac469eb;
    door_ents[door_ents.size] = door_ent;
  }

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

      var_17f47c08 = level.var_81065eb;

      if(debuglevel > 2) {
        var_17f47c08 = arraycombine(level.var_81065eb, door_ents, 0);
      }

      var_17f47c08 = function_ada64c98(var_17f47c08, playervieworg, playerforward, playerfov, distance);

      foreach(door_ent in var_17f47c08) {
        name = door_ent.targetname;

        if(!isstring(name) || name == "<dev string:x4e>") {
          name = "<dev string:xbd>" + door_ent getentitynumber();
        }

        pos = door_ent.var_dd9c7c9;

        if(!isvec(pos)) {
          pos = door_ent.origin;
        }

        debugscale = level._snd._debug.scale_3d;
        snd::print3dplus("<dev string:x4e>" + name, pos + (0, 0, -0.75 * debugscale * 24), 0.25 * debugscale, "<dev string:xcb>", (1, 1, 1), 1, (0, 0, 0), 0.9, (1, 1, 1), 0.9, 1);
        snd::debugcrosshair(pos, 12, door_ent.angles);
      }
    }

    waitframe(1);
  }
}

function function_5e7cc862(key, value) {
  function_4b193e02();
  level thread function_a20133bd();
  return value;
}

function function_4b193e02() {
  players = snd::function_da785aa8();
  player = players[0];
  assert(isPlayer(player));
  view_origin = player snd::getplayervieworigin();
  var_839b8d61 = getentitiesinradius(view_origin, 16384, 15);
  var_97d10723 = function_b6dd763(view_origin, 16384);
  ents = arraycombine(var_839b8d61, var_97d10723, 0);
  level notify(#"hash_7ad75056b30c451a");
  level notify(#"hash_63850bb43dbc38de");

  foreach(ent in ents) {
    ent.var_2de4672c = undefined;
  }
}

function function_c26120ff(ent) {
  type = array::random(["cough", "sniff", "throat"]);
  prefix = "male";
  head = ent.head;
  female_heads = [# "c_t9_base_female_nude_head", #"c_t9_eng_hero_park_head", #"c_t9_ger_civ_female_contact_head", #"c_t9_ger_civ_female_head01", #"c_t9_ger_civ_female_head01_hair_bld", #"c_t9_ger_civ_female_head01_attch_hair_a", #"c_t9_ger_civ_female_head02", #"c_t9_ger_civ_female_head02_attch_hair_a", #"c_t9_ger_civ_female_head02_b", #"c_t9_ger_civ_female_head02_b_attch_hair_b", #"c_t9_ger_civ_female_head03", #"hash_6e92bcee188ac06f", #"c_t9_ger_civ_female_head04", #"c_t9_ger_civ_female_head05", #"c_t9_ger_civ_female_head05_attch_hair_a", #"c_t9_ger_civ_female_head06", #"c_t9_ger_civ_female_head06_attch_hair_a", #"c_t9_ger_civ_female_target_edda_head", #"c_t9_ger_civ_female_target_edda_head_attch_hair_a", #"hash_10907c2b90e2ab7e", #"c_t9_net_civ_female_urban_waitress_head1_b", #"c_t9_net_civ_female_urban_waitress_head1_b_attch_hair_b"];
  isfemale = isinarray(female_heads, head);

  if(isfemale) {
    prefix = "female";
  } else if(head == # "c_t9_cp_usa_hero_adler_head1") {
    prefix = "adler";
  } else if(head == # "c_t9_cp_usa_hero_lazar_head1") {
    prefix = "lazar";
  } else if(head == # "c_t9_eng_hero_park_head") {
    prefix = "park";
  }

  alias = "vox_" + prefix + "_" + type;

  if(!soundexists(alias)) {
    if(isfemale) {
      return ("vox_female_" + type);
    }

    return ("vox_male_" + type);
  }

  return alias;
}

function function_a20133bd() {
  player = self;

  if(!snd::isplayersafe(player)) {
    players = snd::function_da785aa8();
    player = players[0];
    assert(isPlayer(player));
  }

  player notify(#"hash_7ad75056b30c451a");
  player endon(#"hash_7ad75056b30c451a", #"death", #"disconnect");
  level endon(#"hash_7ad75056b30c451a");
  min_time = getdvarfloat(#"hash_5a9d5543cb5829b3", 4);
  max_time = getdvarfloat(#"hash_5ab96b43cb70c9cd", 20);
  var_88701456 = 0;

  while(true) {
    view_origin = player snd::getplayervieworigin();
    var_839b8d61 = getentitiesinradius(view_origin, 900, 15);
    var_97d10723 = function_b6dd763(view_origin, 900);
    ents = arraycombine(var_839b8d61, var_97d10723, 0);
    var_dcf355d7 = 0;
    var_bff726ab = min(32, ents.size);

    while(ents.size > 0 && var_dcf355d7 < var_bff726ab) {
      var_88701456 %= ents.size;
      ent = ents[var_88701456];

      if(isentity(ent) && !ent ishidden()) {
        head = ent.head;

        if(isDefined(head) && head != "" && !isDefined(ent.var_2de4672c)) {
          ent thread snd::function_9299618(&function_c26120ff, [min_time, max_time]);
        }
      }

      var_dcf355d7++;
      var_88701456++;
    }

    waitframe(20);
  }
}

function stealth_music() {
  level notify(#"hash_5bea67cbe769538");
  level endon(#"hash_5bea67cbe769538");

  while(true) {
    music::setmusicstate("9.0_informant_safehouse_2");
    level flag::wait_till("stealth_spotted");
    music::setmusicstate("10.0_informant_combat");
    level flag::wait_till_clear("stealth_spotted");
  }
}

function function_3eec13f8(state = "9.0_informant_safehouse") {
  level notify(#"hash_5bea67cbe769538");
  music::setmusicstate(state);
}

function function_818cbaa9() {
  snd::waitforplayers();
  var_736a032a = getEntArray("train_tunnel_04", "targetname");

  foreach(ent in var_736a032a) {
    if(!isDefined(ent.script_noteworthy)) {
      continue;
    }

    if(ent.script_noteworthy == "train_tunnel") {
      snd::client_targetname(ent, "train_tunnel");
    }
  }
}

function function_d7739931() {
  snd::waitforplayers();
  snd::client_msg("stakeout_fade_in");
}

function function_e40ab25f() {
  level thread function_a6b9fbbd();
  snd = snd::play("vox_cp_stkt_02005_gmc1_wewillbearrivin_e4");
  level flag::wait_till("inside_train_car_02");
  thread stop_pa_voice();
}

function function_ae5a068d() {
  male_a = (-9189, 8592, -118);
  male_b = (-9466, 8645, -135);
  male_c = (-9696, 8669, -134);
  female_a = (-9368, 8652, -135);
  thread function_7a598b17(male_a, "male_a");
  thread function_7a598b17(male_b, "male_b");
  thread function_7a598b17(male_c, "male_c");
  thread function_7a598b17(female_a, "female_a");
}

function function_7a598b17(org, name) {
  level endon(#"inside_train_car_02");
  wait randomfloatrange(1, 7);

  while(true) {
    snd::play("vox_sniffs_coughs_" + name, org);
    wait randomfloatrange(6, 15);
  }
}

function train_fade_up_from_black() {
  snd::client_msg("train_fade_up_from_black");
}

function function_cc419f00() {
  level flag::wait_till("inside_train_car_02");
  snd::client_msg(#"inside_train_car_02");
  level flag::wait_till("flag_prep_teleport_train_player");
  snd::client_msg(#"prep_teleport_train_player");
  level waittill(#"hash_19e230299ea7fcb3");
  snd::client_msg(#"hash_19e230299ea7fcb3");
}

function stop_pa_voice() {
  snd::client_msg("stop_pa_voice");
}

function function_9c504c29() {
  level waittill(#"player_train_teleport");
  snd::client_msg("stop_intro_whooshes");
  players = snd::function_da785aa8();
  player = players[0];
  locs = [];

  for(i = 0; i < 5; i++) {
    locs[i] = player.origin + (randomintrange(-3000, 0), randomintrange(-100, 100), 20);
  }

  var_93408f70 = snd::play("emt_train_end_cars_screech_lp", locs);

  foreach(var_819cb54 in var_93408f70) {}

  wait 5;
  snd::stop(var_93408f70, 0.5);
}

function function_a6b9fbbd() {
  level waittill(#"hash_56ddda8ab2517d7");
  snd::client_msg(#"hash_56ddda8ab2517d7");
  level waittill(#"hash_2b77f5a80ef76375");
  snd::client_msg(#"hash_2b77f5a80ef76375");
  level waittill(#"hash_56ddea8ab25198a");
  snd::client_msg(#"hash_56ddea8ab25198a");
  level waittill(#"hash_dd68c60c003c4d9");
  snd::client_msg(#"hash_dd68c60c003c4d9");
  level waittill(#"hash_2b77f2a80ef75e5c");
  snd::client_msg(#"hash_2b77f2a80ef75e5c");
}

function function_11cd4580() {
  level flag::wait_till("ghost_station_done");
  snd::client_msg(#"ghost_station_done");
}

function function_78cda177() {
  wait 4;
  snd::play([0.05, "evt_stk_ghost_station_train_dist_approach"], (-6727, 10401, -316));
}

function guard_room_train_occlusion() {
  snd::client_msg("guard_room_train_occlusion");
}

function duck_ghost_station() {
  snd::client_msg("duck_ghost_station");
}

function function_47f39a4f() {
  level endon(#"ghost_station_done");

  while(true) {
    players = snd::function_da785aa8();
    player = players[0];
    player waittill(#"mantle_start");
    snd::play("fly_plr_stk_gs_platform_mantle");
  }
}

function function_46b43795() {}

function function_f6a3d7df() {
  level flag::wait_till_any(array("guard_station_doors_opened", "player_in_guard_room"));
  wait 1;
  var_981ab364 = snd::play([0.1, "env_stk_gs_radio_static_lp", 1], (-5750, 10945, -305));
  level flag::wait_till("ghost_station_done");
  snd::stop(var_981ab364, 1);
}

function function_60ca00d0() {
  snd::play("env_stk_tunnel_metal_door_close", (-6435, 11100, -285));
}

function function_dcaf7611() {
  wait 0.35;
  snd::play("foley_stk_gs_sts_enemy02_door_close", (-6120, 10945, -305));
}

function function_b2633ff9() {
  level thread function_bb969e94();
  level thread function_36cc557();
  snd::client_msg(#"hash_63b7485b7ad71c1");
  snd::play("evt_stk_ghost_station_manhole_open");
  wait 2;
  snd::play("amb_thunder_rumble");
}

function function_bb969e94() {
  if(is_true(level.var_5382cbbf)) {
    return;
  }

  level.var_5382cbbf = 1;
  snd::emitter("env_stk_tunnel_small_low_wind_gust", (-7241, 11051, -294), [22, 24, 4, 8], 0, 0, 0);
  snd::emitter("amb_thunder_rumble", (-2468, 61, 2660), [40, 74]);
  snd::emitter("amb_thunder_rumble", (4403, 20731, 6896), [40, 74]);
}

function function_36cc557() {
  snd::waitforplayers();
  snd::client_msg("amb_rain_quad");
}

function function_c7ac1381() {
  if(is_true(level.var_c7ac1381)) {
    return;
  }

  level.var_c7ac1381 = 1;
  var_a403643d = snd::play("amb_rain_window_med_int_01_wall", (-4169, 11378, 339));
  flag::wait_till("fade_in_rooftop_door_amb");
  snd::stop(var_a403643d, 1.5);
  snd::client_msg(#"hash_dc63434f653d0f2");
}

function function_ddb87390() {
  var_bc1e82a6 = snd::play("env_rain_light_wood_door_int_lp_01", (-4169, 11376, 365));
  flag::wait_till("fade_in_rooftop_door_amb");
  wait 0.25;
  snd::stop(var_bc1e82a6, 2);
  var_7ffe9874 = snd::play(["env_rain_light_splatty_lp_01", 1.5], (-4159, 11496, 353));
  var_ba4621a5 = snd::play(["env_rain_light_wood_partial_lp_01", 1.5], (-4172, 11448, 363));
  snd::play("amb_traffic_dist_occluded_doorway", (-4170, 11412, 321));
}

function function_bc932ea6() {
  wait 0.25;
  snd::play("amb_stk_outdoor_transition_from_inside", (-2623, 14247, 856));
  snd::play("amb_door_open_rain_city_thunder_3d", (-2623, 14247, 856));
}

function function_11e5f1bd(var_cafbbb40) {
  var_cafbbb40 endon(#"death");
  level endon(#"street_done");

  while(true) {
    wait randomfloatrange(2, 6);
    snd::play("emt_pigeons_cooing", var_cafbbb40.origin);
  }
}

function rooftop_descend() {
  snd::client_msg("rooftop_descend");
  wait 3;
}

function function_dceebb0a() {
  snd::client_msg(#"hash_208adbd58bcd8ca5");
  snd::play("evt_adler_rooftop_door_open_bottom", (-3072, 10790, 28));
}

function function_106f9fd1() {
  front_door = doors::function_73f09315("bar_front_door");
  level endon(#"Bar_Door_Close");

  if(!isDefined(level.var_597613a0)) {
    thread function_4b6fc5b8();
    level.var_a2e7ca20 = snd::play("amb_traffic_dist_occluded_doorway", (-1973, 9867, 79));
  }

  while(true) {
    front_door waittill(#"trigger");

    if(level flag::get("player_in_bar")) {
      thread function_df3c2236();
      snd::stop(level.var_a2e7ca20, 0.5);
      break;
    }
  }
}

function function_115e410e() {
  level.var_9ddb3836 = snd::play("amb_scr_rain_cement_alley_doorway2", (-2041, 9859, 56));
  level.var_acb155e2 = snd::play("env_rain_light_doorway_splatty3", (-2041, 9886, 24));
}

function Bar_Door_Close() {
  level notify(#"Bar_Door_Close");
  thread function_df3c2236();
}

function function_df3c2236() {
  wait 0.5;
  snd::stop(level.var_9ddb3836, 0.5);
  snd::stop(level.var_acb155e2, 0.5);
  snd::stop(level.var_ba70f161, 0.5);
}

function function_4b6fc5b8() {
  if(!snd::function_a6779cbd(level.var_597613a0)) {
    level.var_597613a0 = snd::play("amb_bar_amb_3d_lp", (-1734, 9929, 86));
    level waittill(#"hash_1d88dae58e39cbae");
    wait 1;
    snd::stop(level.var_597613a0, 4);
  }
}

function police_build_up_bar() {
  wait 20;
  snd::client_msg("police_build_up_bar");
}

function function_4e7aa055() {
  level flag::wait_till("flag_found_contact");
  players = snd::function_da785aa8();
  player = players[0];
  player waittill(#"hash_52a4e28df0e31dc1");
}

function bar_incoming() {
  snd::client_msg("bar_incoming");
  level notify(#"hash_1d88dae58e39cbae");
}

function end_bar_door_police_amb() {
  snd::client_msg("end_bar_door_police_amb");
}

function function_d494f15() {
  snd::play("evt_anim_bar_wall_climb");

  if(isDefined(level.var_597613a0)) {
    snd::stop(level.var_597613a0, 0.5);
  }
}

function function_7aaa5ad4() {
  thread function_151612f4();
  thread alley_walla();
}

function alley_walla() {
  level endon(#"hash_3a6d9476edb179d1");
  level endon(#"stealth_spotted");
  loc = (-773, 8111, 334);
  lines = ["vox_cp_stkt_07210_gms2_hewentthatway_ee", "vox_cp_stkt_07210_gms3_hesnotalone_dc", "vox_cp_stkt_07210_gms1_illcheckinside_f7", "vox_cp_stkt_07210_gms2_wehaveawarrant_41", "vox_cp_stkt_07210_gms3_facethewallandp_48", "vox_cp_stkt_07210_gms1_doitnow_45"];

  while(true) {
    wait randomintrange(14, 22);
    alias = get_random_array_element_no_repeat(lines, "alley_walla", 4);
    snd::play(alias, loc);
  }
}

function function_151612f4() {
  snd::client_msg("alley_2_start");
  snd::client_msg("end_police_build_up_bar");
}

function function_32ee917f() {
  snd::play("amb_alley_door_amb_lp", (-601, 9604, 91));
  snd::play("amb_rooftop_door_amb_lp", (-281, 9646, 91));
}

function function_2ef70099() {
  level notify(#"hash_3a6d9476edb179d1");

  if(is_true(level.var_2ef70099)) {
    return;
  }

  level.var_2ef70099 = 1;
  baby = snd::play("env_baby_crying", (-666, 6724, 89));
  thread function_d75cd506();
  level waittill(#"flag_go_in_store");
  snd::stop(baby, 0.25);
}

function function_d75cd506() {
  thread function_42f00d4b();
  loc = (-945, 6646, 255);
  level endon(#"flag_go_in_store");
  snd::play("env_stasi_knocking_03", loc);
  exploder::exploder("fx_exp_slice_dust");
  wait 2.8;
  snd::play("env_stasi_knocking_01", loc);
  exploder::exploder("fx_exp_slice_dust");
  wait 1;
  wait 1.8;
  snd::play("env_stasi_knocking_02", loc);
  exploder::exploder("fx_exp_slice_dust");
  wait 0.85;
  wait 1.75;
  snd::play("env_stasi_knocking_04", loc);
  exploder::exploder("fx_exp_slice_dust");
  wait 0.95;
  snd::play("env_door_open_muffled", loc);
}

function function_42f00d4b() {
  level endon(#"flag_go_in_store");
  loc = (-581, 6864, 281);
  aliases = ["env_stasi_walking_upstairs_01", "env_stasi_walking_upstairs_02", "env_stasi_walking_upstairs_03"];
  exploder::exploder("fx_exp_slice_dust");
  wait 2;

  while(true) {
    alias = get_random_array_element_no_repeat(aliases, "stasi_boots", 2);
    snd::play(alias, loc);
    wait randomintrange(6, 9);
  }
}

function function_6757a0b0() {
  level endon(#"flag_go_in_store");
  level waittill(#"hash_14fdb20a5044c32e");
  loc = (-554, 6875, 117);
  wait 6;

  while(true) {
    snd::play("env_stasi_knocking_01", loc);
    wait 1.25;
    snd::play("vox_cp_stkt_08050_gms1_openthisdoornow_57", loc);
    wait 2.2;
    snd::play("env_stasi_knocking_02", loc);
    wait 3.1;
    snd::play("env_stasi_knocking_04", loc);
    wait 2.75;
    snd::play("env_stasi_knocking_02", loc);
    wait 3;
    snd::play("env_stasi_knocking_01", loc);
    wait 1;
    snd::play("vox_cp_stkt_08050_gms1_doyouhearmeopen_88", loc);
    wait 2.4;
    snd::play("env_stasi_knocking_04", loc);
    wait 3.5;
    snd::play("env_stasi_knocking_02", loc);
    wait 2.2;
  }
}

function function_7e88a33b(waittime) {
  wait waittime;
  snd::play([0.5, "amb_scr_rain_cement_alley_doorway_noduck", 0.5], (-34, 6573, 70));
  snd::play([0.5, "env_rain_light_doorway_splatty_noduck", 0.5], (-34, 6573, 70));
  snd::play([0.5, "amb_rain_door_outside_lp_05", 0.5], (-34, 6573, 70));
  snd::play([0.5, "amb_rain_flower_pot_lp_02", 0.5], (34, 6525, 43));
  snd::play([0.5, "amb_rain_flower_pot_lp_01", 0.5], (-111, 6487, 44));
}

function function_8a2f9a04() {
  wait 1.5;
  snd::play("amb_traffic_dist_occluded_doorway", (189, 5063, 65));
}

function function_9c766945() {
  snd::client_msg("apt_street_start");
  thread function_28fe0742();
}

function function_28fe0742() {
  level endon(#"flag_inside_lobby");
  locs = [(4635, 5076, 165), (-1228, 1830, 160)];
  lines = ["vox_cp_stkt_07210_gms1_illcheckinside_f7", "vox_cp_stkt_07210_gms2_wehaveawarrant_41", "vox_cp_stkt_07210_gms3_facethewallandp_48", "vox_cp_stkt_07210_gms1_doitnow_45"];

  while(true) {
    wait randomintrange(6, 15);
    alias = get_random_array_element_no_repeat(lines, "alley_walla", 4);
    snd::play(alias, locs[randomint(2)]);
  }
}

function function_a6cbd395() {
  snd::play("evt_apt_street_train_distant_01", (3804, 4962, 349));
}

function function_26ef53da() {
  snd::play("evt_apt_street_train_distant_02", (3804, 4962, 349));
}

function function_d8a1373f() {
  snd::play("evt_apt_street_train_distant_03", (3804, 4962, 349));
}

function function_ca2a1a51() {
  snd::play("evt_apt_street_train_distant_04", (3804, 4962, 349));
}

function function_aa38f91f(car, targetname) {}

function function_81b3f069(volume) {
  level endon(#"hash_205bf17f449d4088");
  phone = getent("apt_phone", "targetname");
  thread function_db3e2ed5(phone);
  level.var_b159d30f = 0;
  level.var_2a973211 = 0.501;

  if(isDefined(volume)) {
    level.var_2a973211 = volume;
  }

  while(!level flag::get("flag_phone_receiver_picked_up")) {
    level.var_b159d30f = 1;
    level.var_9d6e61f8 = snd::play([0.05, "evt_stk_apt_phone_ring_lp"], phone);
    snd::set_volume(level.var_9d6e61f8, level.var_2a973211);
    wait 2;
    level.var_1e5c72de = snd::play([0.05, "evt_stk_apt_phone_ring_end"], phone);
    snd::set_volume(level.var_9d6e61f8, level.var_2a973211);
    snd::stop(level.var_9d6e61f8, 0.05);
    level.var_b159d30f = 0;
    wait 3;
  }
}

function function_db3e2ed5(phone) {
  level flag::wait_till_any(array("flag_apartment_door_open", "flag_1st_entry_kitchen"));
  level.var_2a973211 = 1;

  if(isDefined(level.var_9d6e61f8)) {
    snd::set_volume(level.var_9d6e61f8, level.var_2a973211, 1.5);
  }

  if(isDefined(level.var_1e5c72de)) {
    snd::set_volume(level.var_1e5c72de, level.var_2a973211);
  }

  level waittill(#"hash_205bf17f449d4088");
  level flag::set("flag_phone_receiver_picked_up");

  if(isDefined(level.var_9d6e61f8) && level.var_b159d30f == 1) {
    snd::play("evt_stk_apt_phone_ring_end", phone);
    snd::stop(level.var_9d6e61f8, 0.05);
    snd::stop(level.var_1e5c72de, 0.05);
  }
}

function function_e61f9ef4() {
  var_434a23fb = snd::play("evt_listening_device_kettle_lp", (1357, 3918, 224));
  level waittill(#"hash_5450898ce50a75ea");
  snd::stop(var_434a23fb, 2);
}

function function_c32bc34f() {
  snd::play("evt_vent_open", (1891, 4075, 190));
}

function bedroom_drawer() {
  snd::play("evt_drawer_open", (1758, 4182, 363));
}

function function_a3c35c97() {
  snd::play("evt_metal_drawer_open", (1576, 4205, 367));
}

function function_4cab7b22(var_a35b31a, time) {
  thread function_e5ae45dd(time, var_a35b31a);
  waittime = 1;
  waited = 0;

  while(waited < time) {
    wait waittime;
    waited += waittime;

    if(waittime > 0.5) {
      waittime -= 0.1;
    }

    if(level flag::get("darkroom_door_open")) {
      return;
    }
  }
}

function function_e5ae45dd(time, obj) {
  level flag::wait_till_timeout(time, "darkroom_door_open");

  if(level flag::get("darkroom_door_open")) {
    if(obj.targetname == "darkroom_door_interact_button") {
      snd::play("evt_dark_room_door_unlock", (1495, 4061, 396));
    }
  }
}

function function_271bf326() {
  wait 2;
  snd::play("evt_stk_apt_dark_room_door_close", (1495, 4061, 396));
}

function function_1a80eca8() {
  wait 1;
  radio = snd::play("evt_listening_device_tuning_lp_3d", [level.park, "j_head"]);
  wait 2;
  radio snd::set_volume(0.5, 3);
  wait 12;
  snd::stop(radio, 4);
}

function function_a4a301cb() {
  level notify(#"hash_48045d9558d58f9");
  level endon(#"hash_48045d9558d58f9");
  snd::emitter("amb_hanging_chains_rattle", (11938, -13705, 177), [4, 10]);
  snd::emitter("amb_hanging_chains_rattle", (12215, -13500, 167), [4, 10]);
  snd::emitter("amb_hanging_chains_rattle", (11201, -13832, 176), [4, 10]);
  snd::emitter("amb_hanging_chains_rattle", (9801, -12999, 114), [4, 10]);
  snd::emitter("amb_hanging_chains_rattle", (9563, -13021, 185), [4, 10]);
  snd::emitter("amb_hanging_chains_rattle", (10085, -13556, 187), [4, 10]);
  snd::emitter("amb_hanging_chains_rattle", (9555, -13828, 181), [4, 10]);
  snd::emitter("amb_hanging_chains_rattle", (9548, -13391, 188), [4, 10]);
  snd::emitter("amb_metal_stress_small", (11824, -13379, 80), [3, 7]);
  snd::emitter("amb_metal_stress_small", (11716, -13530, 100), [4, 8]);
  snd::emitter("amb_metal_stress_small", (11389, -13856, 95), [3, 7]);
  snd::emitter("amb_metal_stress_small", (11323, -13663, 100), [3, 7]);
  snd::emitter("amb_metal_stress_small", (11085, -13486, 104), [4, 7]);
  snd::emitter("amb_metal_stress_small", (11285, -13293, 100), [3, 7]);
  snd::emitter("amb_metal_stress_small", (11511, -13032, 100), [3, 7]);
  snd::emitter("amb_metal_stress_small", (10323, -12970, 100), [4, 8]);
  snd::emitter("amb_metal_stress_small", (10287, -13221, 100), [3, 7]);
  snd::emitter("amb_metal_stress_small", (10942, -13220, 100), [3, 7]);
  snd::emitter("amb_metal_stress_small", (10750, -13329, 100), [4, 7]);
  snd::emitter("amb_metal_stress_small", (10751, -13626, 100), [3, 7]);
  snd::emitter("amb_metal_stress_small", (10323, -13870, 100), [3, 7]);
  snd::emitter("amb_metal_stress_small", (10292, -13661, 100), [3, 8]);
  snd::emitter("amb_metal_stress_small", (9874, -13167, 100), [3, 7]);
  snd::emitter("amb_metal_stress_small", (9651, -13613, 100), [4, 9]);
  snd::emitter("amb_metal_stress_small", (9485, -13133, 100), [3, 7]);
  snd::emitter("amb_metal_stress_small", (9314, -13440, 100), [3, 7]);
  snd::emitter("amb_metal_stress_small", (9265, -13603, 100), [3, 7]);
  snd::emitter("amb_metal_stress_small", (9536, -13772, 100), [4, 10]);
  snd::emitter("amb_metal_stress_med_small", (10929, -13436, 111), [3, 7]);
  snd::emitter("amb_metal_stress_med_small", (10703, -13842, 111), [3, 7]);
  snd::emitter("amb_metal_stress_med_small", (10146, -13046, 111), [3, 7]);
  snd::emitter("amb_metal_stress_med_small", (9805, -13876, 170), [3, 7]);
  snd::emitter("amb_metal_stress_med_small", (9308, -13144, 142), [3, 7]);
  snd::emitter("amb_metal_stress_med", (11001, -13880, 101), [4, 8]);
  snd::emitter("amb_metal_stress_med", (11308, -12965, 101), [4, 8]);
  snd::emitter("amb_metal_stress_med", (10995, -13130, 114), [4, 8]);
  snd::emitter("amb_metal_stress_med", (9942, -13496, 100), [4, 8]);
  snd::emitter("amb_metal_stress_med", (9658, -13359, 109), [4, 8]);
  snd::emitter("amb_metal_stress_med", (9462, -13258, 105), [4, 8]);
  snd::emitter("amb_metal_stress_large", (11652, -13249, 140), [7, 15]);
  snd::emitter("amb_metal_stress_large", (11407, -13258, 140), [7, 15]);
  snd::emitter("amb_metal_stress_large", (11589, -13569, 140), [7, 15]);
  snd::emitter("amb_metal_stress_large", (11343, -13573, 140), [7, 15]);
  snd::emitter("amb_metal_stress_large", (11312, -13867, 140), [7, 15]);
  snd::emitter("amb_metal_stress_large", (10218, -13890, 140), [7, 15]);
  snd::emitter("amb_metal_stress_large", (10524, -13890, 140), [7, 15]);
  snd::emitter("amb_metal_stress_large", (10492, -13617, 140), [7, 15]);
  snd::emitter("amb_metal_stress_large", (10256, -13605, 140), [7, 15]);
  snd::emitter("amb_metal_stress_large", (10246, -13258, 140), [7, 15]);
  snd::emitter("amb_metal_stress_large", (10524, -13253, 140), [7, 15]);
  snd::emitter("amb_metal_stress_large", (10498, -12964, 140), [7, 15]);
  snd::emitter("amb_metal_stress_large", (10248, -12962, 140), [7, 15]);
  snd::emitter("amb_metal_stress_large", (10867, -13247, 140), [7, 15]);
  snd::emitter("amb_metal_stress_large", (9288, -13591, 140), [7, 15]);
  snd::emitter("amb_metal_stress_large", (9583, -13380, 119), [7, 15]);
  snd::emitter("amb_metal_stress_low", (11436, -13581, 137), [7, 15]);
  snd::emitter("amb_metal_stress_low", (10918, -13301, 137), [7, 15]);
  snd::emitter("amb_metal_stress_low", (10422, -12966, 137), [7, 15]);
  snd::emitter("amb_metal_stress_low", (10370, -13629, 137), [7, 15]);
  snd::emitter("amb_metal_stress_low", (9311, -13579, 137), [7, 15]);
  snd::emitter("amb_fence_chainlink_rattle", (9758, -13783, 109), [7, 15]);
  snd::emitter("amb_fence_chainlink_rattle", (9648, -13432, 115), [7, 15]);
  snd::emitter("amb_fence_chainlink_rattle", (9410, -13183, 115), [7, 15]);
  snd::play("amb_toilet_loop", (9035, -13861, 71));
  snd::play("amb_sink_drip", (9019, -13784, 83));
}

function warehouse_plr_breathing_start() {
  snd::client_msg("warehouse_plr_breathing_start");
}

function warehouse_wake_mix_off_1() {
  snd::client_msg("warehouse_wake_mix_off_1");
}

function warehouse_wake_mix_on_2() {
  snd::client_msg("warehouse_wake_mix_on_2");
}

function warehouse_wake_mix_off_2() {
  snd::client_msg("warehouse_wake_mix_off_2");
}

function warehouse_guns_start() {
  if(is_true(level.var_64a527f1)) {
    return;
  }

  level.var_64a527f1 = 1;
  level waittill(#"warehouse_guns_start");
  snd::client_msg("warehouse_guns_start");
}

function function_af3d3d18(victims) {
  foreach(victim in victims) {
    victim thread function_18b6b926();
  }
}

function function_18b6b926() {
  waitresult = self waittill(#"death");

  if(waitresult.mod === "MOD_BURNED") {
    result = self waittilltimeout(2, #"start_burning");

    if(result._notify === "start_burning" && isDefined(self)) {
      aliases = ["vox_burning_scream_01", "vox_burning_scream_02", "vox_burning_scream_03", "vox_burning_scream_04"];
      alias = get_random_array_element_no_repeat(aliases, "burn_victim", 3);
      snd::play(alias, self);
    }
  }
}

function function_875a6922() {
  snd::play("evt_toilet_flush", (9067, -13856, 108));
  wait 1;
  snd::play("evt_door_kick_open", (9229, -13811, 102));
}

function function_186a0635() {
  snd::play("evt_stk_apt_darkroom_light_on", (1362, 3932, 433));
  level.var_3259366f = snd::play("evt_stk_apt_darkroom_light_lp", (1362, 3932, 433));
}

function function_8fd5f0ca() {
  snd::play("evt_stk_apt_darkroom_light_on");
  snd::stop(level.var_3259366f);
}

function function_9ca60c0() {
  snd::play("evt_stk_apt_darkroom_knockout");
  wait 2;
  wait 3.9;
  exert = util::function_3ac6fa36("vox_male_darkroom_knockout", "vox_female_darkroom_knockout", "vox_classified_darkroom_knockout");
  level.player dialogue::queue(exert);
  wait 2.5;
  snd::client_msg("apartment_fade_out");
}

function get_random_array_element_no_repeat(array, label, var_7602d509 = 2) {
  if(!isDefined(level._audio_random_array_dict)) {
    level._audio_random_array_dict = [];
  }

  if(!isDefined(level._audio_random_array_dict[label])) {
    level._audio_random_array_dict[label] = array::randomize(getarraykeys(array));
  }

  if(level._audio_random_array_dict[label].size <= var_7602d509) {
    remaining = array_remove_array(getarraykeys(array), level._audio_random_array_dict[label]);
    new_list = array::randomize(remaining);
    level._audio_random_array_dict[label] = arraycombine(new_list, level._audio_random_array_dict[label]);
  }

  value = level._audio_random_array_dict[label][level._audio_random_array_dict[label].size - 1];
  level._audio_random_array_dict[label][level._audio_random_array_dict[label].size - 1] = undefined;
  return array[value];
}

function array_remove_array(ents, remover_array) {
  foreach(remover in remover_array) {
    arrayremovevalue(ents, remover);
  }

  return ents;
}