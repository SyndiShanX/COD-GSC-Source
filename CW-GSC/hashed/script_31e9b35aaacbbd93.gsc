/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_31e9b35aaacbbd93.gsc
***********************************************/

#using script_3dc93ca9902a9cda;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_sp;
#using scripts\cp_common\snd_utility;
#namespace namespace_a052577e;

function private event_handler[level_preinit] function_b489bb7b(eventstruct) {
  snd::function_5e69f468(&_objective);
  snd::wait_init();
}

function private event_handler[event_cc819519] function_686b88aa(eventstruct) {
  snd::wait_init();
  snd::waitforplayers();

  snd::dvar("<dev string:x38>", "<dev string:x4e>" + 3, &function_5e7cc862);
  snd::dvar("<dev string:x52>", "<dev string:x4e>" + 15, &function_5e7cc862);
}

function private _objective(objective) {
  switch (objective) {
    case # "tkdn_raid_bar":
      snd::client_msg("triton_on");
      level thread function_a20133bd();
      break;
    case # "tkdn_raid_gearup":
      snd::client_msg("triton_on");
      break;
    case # "tkdn_raid_apt":
      snd::client_msg("triton_on");
      level notify(#"hash_7ad75056b30c451a");
      level notify(#"hash_63850bb43dbc38de");
      break;
    case # "tkdn_raid_rooftops":
      snd::client_msg("triton_on");
      break;
    case # "tkdn_raid_slide":
      snd::client_msg("triton_on");
      break;
    case # "tkdn_raid_capture":
      snd::client_msg("triton_on");
      break;
    case # "hash_7db5c2bb92c102ae":
      snd::client_msg("triton_on");
      break;
    case # "tkdn_af_intro":
      snd::client_msg("triton_off");
      break;
    case # "tkdn_af_hill":
      snd::client_msg("triton_off");
      break;
    case # "tkdn_af_tarmac":
      snd::client_msg("triton_off");
      break;
    case # "tkdn_af_chase":
      snd::client_msg("triton_off");
      snd::client_msg(#"plane_chase");
      break;
    case # "tkdn_af_rc_chase":
      snd::client_msg("triton_off");
      break;
    case # "tkdn_af_skid":
      snd::client_msg("triton_off");
      break;
    case # "tkdn_af_wreck":
      snd::client_msg("triton_off");
      break;
    case # "no_game":
    case # "hash_6e531fb9475df744":
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x68>" + objective + "<dev string:x8b>");

      break;
  }
}

function xhair() {
  self endon(#"death");
  self endon(#"hash_2caeecd393c68946");

  while(isDefined(self) && isDefined(self.origin) && isDefined(self.angles)) {
    snd::debugcrosshair(self.origin, 24, self.angles, (1, 1, 1), 1, 0, 1);
    waitframe(1);
  }
}

function function_5e7cc862(key, value) {
  level notify(#"hash_63850bb43dbc38de");
  players = snd::function_da785aa8();
  player = players[0];
  assert(isPlayer(player));
  view_origin = player snd::getplayervieworigin();
  var_839b8d61 = getentitiesinradius(view_origin, 16384, 15);
  var_97d10723 = function_b6dd763(view_origin, 16384);
  ents = arraycombine(var_839b8d61, var_97d10723, 0);

  foreach(ent in ents) {
    ent.var_2de4672c = undefined;
  }

  level thread function_a20133bd();
  return value;
}

function function_c26120ff(ent) {
  type = array::random(["cough", "sniff", "throat"]);
  prefix = "male";
  head = ent.head;
  var_6c1ff08a = [# "c_t9_cp_usa_hero_adler_head1", #"c_t9_cp_usa_hero_woods_head1", #"c_t9_cp_net_civ_police_chief_head"];
  var_8243bb50 = isinarray(var_6c1ff08a, head);

  if(var_8243bb50) {
    self notify(#"hash_63850bb43dbc38de");
    return undefined;
  }

  female_heads = [# "c_t9_ger_civ_female_head01", #"c_t9_ger_civ_female_head02", #"c_t9_ger_civ_female_head03", #"c_t9_ger_civ_female_head04", #"c_t9_ger_civ_female_head05", #"c_t9_ger_civ_female_head06", #"hash_6cfa8a1eb7667b19", #"hash_6cfa931eb7668a64", #"hash_6cfa941eb7668c17", #"hash_6cfe111eb7699655", #"hash_10907c2b90e2ab7e"];
  isfemale = isinarray(female_heads, head);

  if(isfemale) {
    prefix = "female";
  }

  alias = "vox_" + prefix + "_" + type;

  if(!soundexists(alias)) {
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
  min_time = getdvarfloat(#"hash_5a9d5543cb5829b3", 3);
  max_time = getdvarfloat(#"hash_5ab96b43cb70c9cd", 15);
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

function function_e04b45ab() {}

function function_ec4a61d9() {}

function function_6b5c2a3(bustout_driver, veh) {}

function function_b9b9189c() {
  snd::client_msg(#"hash_443db59c2d746e0f");
}

function function_82bfce7c() {
  snd::play("evt_tkdn_lighter_open");
}

function function_60f59158() {}

function function_6591463() {
  wait 1;
  var_b22ada74 = snd::play("emt_tkd_police_radio_squelch_in", (19695, 18941, 69));
  var_e7139ba1 = snd::play("emt_tkd_police_radio_static_bg_lp", (19695, 18941, 69));
  wait 0.25;
  var_334e9d8b = snd::play("vox_cp_tdwn_09100_dplb_attentionallams_59", (19695, 18941, 69));
  wait 3;
  var_7e253337 = snd::play("vox_cp_tdwn_09100_dplb_allofficersinth_43", (19695, 18941, 69));
  wait 8;
  var_8fcbd684 = snd::play("vox_cp_tdwn_09100_dplb_allofficersaret_60", (19695, 18941, 69));
  level thread flag::wait_till("flag_move_on_to_alley");
  snd::play("emt_tkd_police_radio_squelch_out", (19695, 18941, 69));
  snd::stop(var_b22ada74);
  snd::stop(var_e7139ba1);
  snd::stop(var_334e9d8b);
  snd::stop(var_7e253337);
  snd::stop(var_8fcbd684);
}

function function_ddd8adc3() {}

function function_2032c91c() {
  music::setmusicstate("1.0_approach");
  snd::client_msg("unlock_all_takedownmus");
}

function function_11062617() {
  music::setmusicstate("none");
}

function function_1dc92e4f() {
  music::setmusicstate("2.0_assault");
}

function function_b26ed576() {
  snd::play("tmp_tkdn_drunk_singing_lp", (20334, 18307, 97));
}

function function_f8f5f970() {
  wait 0.7;
  snd::play("tmp_tkdn_apartment_door_breach", (20753, 17182, 66));
}

function function_bc76873() {}

function function_38a8c5b0() {
  var_8a410fc2 = snd::emitter("vox_walla_dutch_panic_male_01", (20908, 15773, 384), [9, 18]);
  var_4f6c19d9 = snd::emitter("vox_walla_dutch_panic_male_01", (21149, 15036, 431), [9, 18]);
  var_d846afb3 = snd::emitter("vox_walla_dutch_panic_male_02", (21149, 15036, 431), [8, 16]);
  var_58582fd4 = snd::emitter("vox_walla_dutch_panic_male_02", (20374, 13316, 562), [8, 16]);
  var_ad0660af = snd::emitter("vox_walla_dutch_panic_fem_01", (21090, 15610, 389), [4, 12]);
  var_44428f29 = snd::emitter("vox_walla_dutch_panic_fem_01", (20287, 15342, 293), [4, 12]);
  var_f6ad3b43 = snd::emitter("vox_walla_dutch_panic_fem_02", (20684, 13376, 562), [8, 20]);
  var_7651ba9a = snd::emitter("vox_walla_dutch_panic_fem_02", (20888, 12627, 819), [8, 20]);
  var_5774b41c = snd::emitter("emt_border_collie_barking_dist", (20799, 15776, 369), [15, 30]);
  level flag::wait_till("raid_roof_complete");
  snd::stop(var_8a410fc2);
  snd::stop(var_4f6c19d9);
  snd::stop(var_d846afb3);
  snd::stop(var_ad0660af);
  snd::stop(var_44428f29);
  snd::stop(var_f6ad3b43);
  snd::stop(var_7651ba9a);
  snd::stop(var_5774b41c);
}

function function_fd7139f4() {
  music::setmusicstate("none");
  snd::play("evt_takedown_roofjump_slowmo");
  level waittill(#"hash_35a786f9d88a2e60");
  music::setmusicstate("3.0_interrogation");
}

function function_724cb241() {
  music::setmusicstate("3.0_interrogation");
}

function function_a5d5a125() {
  music::setmusicstate("none");
}

function function_9ac81c6b() {}

function function_c2eee241() {
  snd::play("evt_tkdn_roof_slide");
}

function function_a7024b3c() {}

function function_e88f8edb() {
  wait 5;
  music::function_edda155f("3.1_throw_stinger");
}

function function_60c0a46b() {
  snd::play("evt_transition_roof_to_airfield_camera_pt1");
  snd::client_msg("cp_takedown_raid_af_transition");
}

function evt_transition_roof_to_airfield_camera_pt2() {
  snd::play("evt_transition_roof_to_airfield_camera_pt2");
  snd::client_msg("cp_takedown_raid_af_transition_complete");
}

function function_dd4c9710() {
  snd::waitforplayers();
  snd::client_msg("hit3_fadein");
  flag::wait_till("af_fade_in_complete");
  snd::client_msg("af_intro_done");
}

function function_92a6fd6a(planes) {
  foreach(plane in snd::function_f218bff5(planes)) {
    snd::client_targetname(plane, "af_flyover");
  }
}

function function_a42cfb58() {
  snd::waitforplayers();
  music::function_edda155f("b1.5_airfield_reveal");
  snd::client_msg("plane_idle");
}

function function_4074e9b1() {
  music::setmusicstate("b5.0_battle");
  snd::client_msg("plane_chase_music");
}

function function_79270d32() {
  music::setmusicstate("b5.0_battle");
}

function function_bbedb5ab() {
  wait 2.5;
  level.var_79f25ee7 = snd::play("quad_tkd_chase_ricochets_front_lp");
}

function function_7bd72cc0() {
  music::setmusicstate("mus_b6.0_rc_loop_0");
}

function function_b3b2671a(player) {
  snd::stop(level.var_79f25ee7);
  level waittill(#"hash_2b34ed034183965");
  snd::play("wpn_tkd_rcxd_start_trans");
  player waittill(#"blow_rc_car");
  snd::play("wpn_tkd_rcxd_detonate_trigger", [level.rc_car, "tag_fx_light_rear"]);
  level music::setmusicstate("none");
}

function function_1e281573() {
  while(!scene::is_ready("scene_tkd_hit3_chase_plane")) {
    waitframe(2);
  }

  flag::wait_till("af_plane_raise_gate");
  var_bfefe09c = snd::function_33ccce67("scene_tkd_hit3_chase_plane", 1);

  foreach(ent in var_bfefe09c) {
    if(isDefined(ent) && isDefined(ent.model)) {
      if(ent.model == # "p9_container_armory_crate_01_dust_dustable_fx" || ent.model == # "p9_crate_wood_01_short_fx" || ent.model == # "p9_slu_pallet_wood_01_gray_fx") {
        snd::client_targetname(ent, "cargo_debris");
      }
    }
  }
}

function function_3dbad6f5() {
  snd::client_msg("af_skid_starting");
}

function function_32f20d13(veh) {
  wait 0.15;
}

function function_fc52119f() {
  snd::client_msg("af_wreck");
}

function function_bee54a20() {
  wait 0.4;
  snd::play("evt_tkd_wreck_unconscious_whoosh", level.player);
}

function function_cbae87a2() {
  snd::client_msg("af_wreck_amb");
  level flag::wait_till("tkdn_af_wreck_completed");
  snd::client_msg("af_wreck_amb_end");
}

function function_4788a209() {
  snd::client_msg("end_fadeout");
}