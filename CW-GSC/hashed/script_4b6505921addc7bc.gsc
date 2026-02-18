/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4b6505921addc7bc.gsc
***********************************************/

#using script_3dc93ca9902a9cda;
#using script_758226507b1afa11;
#using script_86ebb5dd573a003;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\teleport_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;
#namespace namespace_c80e7f5f;

function init() {}

function function_e526c584() {
  self waittill(#"hash_22afaac46a93db1");
  dialogue::radio("vox_cp_stkt_02025_park_adlerthebackcar_6b");
}

function function_28def7d4() {
  level thread function_921afb87();
  level thread function_8af8d6fd();
  level flag::wait_till("flag_park_vo_street");
  level.var_b9661e24 = 1;
  dialogue::radio("vox_cp_stkt_10100_park_thestasiarestop_01");
  level.var_b9661e24 = undefined;
  level flag::wait_till("flag_park_vo_street_2");
  level.var_b9661e24 = 1;
  dialogue::radio("vox_cp_stkt_10100_park_bellisawkrauswr_e9");
  level.var_b9661e24 = undefined;
  level flag::wait_till("flag_inside_lobby");
  level.var_b9661e24 = 1;
  dialogue::radio("vox_cp_stkt_10500_park_bellifyourespot_12");
  level.var_b9661e24 = undefined;
  level flag::wait_till("flag_tranq_vo");
  level.var_b9661e24 = 1;
  level thread dialogue::radio("vox_cp_stkt_10500_park_youcantranqthew_6b");
  level.var_b9661e24 = undefined;
  wait 2.5;
  level flag::set("flag_dart_gun_ready");
}

function function_921afb87() {
  level endon(#"flag_inside_lobby");
  level flag::wait_till("flag_apt_st_stasi_approach");
  e_vol = getent("vol_near_lobby_door", "targetname");
  player = getplayers()[0];

  if(player istouching(e_vol)) {
    if(!is_true(level.var_b9661e24)) {
      dialogue::radio("vox_cp_stkt_10100_park_theresstasihead_93");
    }
  }
}

function function_8af8d6fd() {
  level endon(#"lobby_door_opened");
  var_38d138fb = [];
  var_38d138fb[var_38d138fb.size] = "vox_cp_stkt_10100_park_bellyouneedtogo_ba";
  var_38d138fb[var_38d138fb.size] = "vox_cp_stkt_10100_park_wedonthavealoto_20";
  var_38d138fb[var_38d138fb.size] = "vox_cp_stkt_10100_park_bellwhereareyou_3c";
  e_vol = getent("vol_apt_street_main_path", "targetname");
  player = getplayers()[0];

  while(true) {
    if(player istouching(e_vol)) {
      level notify(#"stop_street_vo_nag");

      while(player istouching(e_vol)) {
        waitframe(1);
      }

      continue;
    }

    level thread namespace_11998b8f::function_ec76072d(1, var_38d138fb, 15, "stop_street_vo_nag", "lobby_door_opened");

    while(!player istouching(e_vol)) {
      waitframe(1);
    }
  }
}

function function_a9c3a1f0() {
  level endon(#"apt_street_done");
  level flag::wait_till_any(array("apt_street_lobby_entry", "flag_inside_lobby"));

  while(!isDefined(level.var_17d88287) || isDefined(level.var_17d88287) && level.var_17d88287.size < 2) {
    waitframe(1);
  }

  var_e140e85b = undefined;
  var_b0aa872f = undefined;
  male = undefined;

  foreach(guy in level.var_17d88287) {
    if(guy.script_noteworthy === "lobby_police_01") {
      var_e140e85b = guy;
    }

    if(guy.script_noteworthy === "lobby_police_02") {
      var_b0aa872f = guy;
    }
  }

  foreach(guy in level.var_41aba0f0) {
    if(guy.script_noteworthy === "lobby_civ_male") {
      male = guy;
    }
  }

  party = [];
  party[party.size] = ["mgc1", male];
  party[party.size] = ["sts2", var_b0aa872f];
  convo = [];
  convo[convo.size] = "vox_cp_stkt_10600_gmc1_theywereamerica_d9";
  convo[convo.size] = 0.25;
  convo[convo.size] = "vox_cp_stkt_10600_gms2_whatisthemansna_e7";
  convo[convo.size] = 0.15;
  convo[convo.size] = "vox_cp_stkt_10600_gmc1_wolfgangbeckerh_a8";
  convo[convo.size] = 0.25;
  convo[convo.size] = "vox_cp_stkt_10600_gms2_howdoyouknowhim_1a";
  convo[convo.size] = 0.15;
  convo[convo.size] = "vox_cp_stkt_10600_gmc1_idontwerejustli_bd";
  convo[convo.size] = 0.25;
  convo[convo.size] = "vox_cp_stkt_10600_gms2_whatdoeshedofor_0f";
  convo[convo.size] = 0.15;
  convo[convo.size] = "vox_cp_stkt_10600_gmc1_hesaprofessorof_ce";
  convo[convo.size] = 3;
  level waittill(#"hash_771e5ca058e26261");
  level waittill(#"apt_street_done");
  wait 3;
  var_99d73dab = undefined;
}

function function_a1d5baeb() {
  level flag::wait_till("flag_apt_near_front_door");
  dialogue::radio("vox_cp_stkt_10500_park_imabouttophonek_a0");
  wait 0.75;
  level thread namespace_5ceacc03::function_81b3f069();
}

function function_84378e8a() {
  dialogue::radio("vox_cp_stkt_11050_park_niceworknowfind_16");
}

function function_ba5c6b95() {
  level flag::wait_till("flag_wife_is_darted");
  wait 5;
  level flag::set("flag_wife_darted_vo");
  dialogue::radio("vox_cp_stkt_11375_park_shellbeoutforho_6b");
  level flag::set("flag_wife_darted_vo_done");
}

function function_e1af55d1() {
  level waittill(#"hash_341edafabf8168e4");
  vol = getent("apt_downstairs_bedroom_vol", "targetname");

  if(getplayers()[0] istouching(vol)) {
    dialogue::radio("vox_cp_stkt_11210_park_krausiscomingge_cd");
    wait 0.5;
    dialogue::radio("vox_cp_stkt_11210_park_ifkrausseesyout_d7");
  }
}

function function_c60ce98d() {
  level endon(#"apartment_explosive_placed");
  level flag::wait_till("flag_player_near_lower_bedroom");
  dialogue::radio("vox_cp_stkt_11250_park_bellkrausisinth_47");
}

function function_74581093() {
  self endon(#"death");
  level endon(#"flag_wife_is_darted", #"flag_edda_umbrella", #"edda_reacting");

  if(level flag::get("flag_wife_is_darted") || level flag::get("flag_edda_umbrella")) {
    return;
  }

  if(is_true(self.spotted)) {
    return;
  }

  level waittill(#"hash_7676a54c41c55288");
  wait 0.4;
  self.nofacialfiller = 1;
  self dialogue::queue("vox_cp_stkt_11075_edda_hello_33");
  wait 1.5;
  self dialogue::queue("vox_cp_stkt_11075_edda_imsorrytheresno_52");
  wait 1.75;
  self dialogue::queue("vox_cp_stkt_11075_edda_wellyesthatsmyn_36");
  wait 2.25;
  self dialogue::queue("vox_cp_stkt_11075_edda_lookimcertainyo_81");
  wait 1.75;
  self dialogue::queue("vox_cp_stkt_11075_edda_ofcourseitsnopr_1b");
  wait 1.25;
  self dialogue::queue("vox_cp_stkt_11075_edda_andagoodevening_89");
  self.nofacialfiller = undefined;
  level flag::set("flag_apt_wife_phone_call_done");
}

function function_b2659110() {
  level waittill(#"hash_57ae395a5970261f");
  self dialogue::queue("vox_cp_stkt_11200_edda_yesfranzitsrigh_5e");
  level notify(#"start_child_vo");
}

function function_74866b7c(wait_notify) {
  level endon(#"flag_kraus_spotted_player");
  level waittill(wait_notify);
  level.child dialogue::queue("vox_cp_stkt_11200_will_mamaicantfindmy_c8");

  if(!flag::get("flag_wife_is_darted")) {
    level.var_3559e9e dialogue::function_47b06180();
    wait 1;
    level.var_3559e9e dialogue::queue("vox_cp_stkt_11200_edda_illbeupinafewmi_50");
  }

  wait 1;
  dialogue::radio("vox_cp_stkt_11200_park_shitwemissedthe_4c");
}

function function_70af88ce() {
  level endon(#"flag_kraus_spotted_player");
  wait 1;
  player = getplayers()[0];
  a_vols = getEntArray("vol_apt_lower_level", "targetname");

  foreach(e_vol in a_vols) {
    if(player istouching(e_vol)) {
      level flag::set("apt_player_downstairs");
    }
  }

  wait 0.5;

  if(level flag::get("apt_player_downstairs")) {
    dialogue::radio("vox_cp_stkt_11210_park_krausisheadingd_a7");
  } else {
    dialogue::radio("vox_cp_stkt_11210_park_krausisleavingh_d4");
  }

  wait 5;
  var_e4be5170 = getEntArray("vol_apt_hiding", "targetname");

  foreach(e_vol in var_e4be5170) {
    if(player istouching(e_vol)) {
      dialogue::radio("vox_cp_stkt_11210_park_dontletkraussee_23");
    }
  }
}

function function_952d90b5() {
  wait 3;
  self dialogue::queue("vox_cp_stkt_11225_krus_shouldhaveknown_88");
}

function function_ed37b989() {
  wait 3;
  self dialogue::queue("vox_cp_stkt_11225_krus_eddahmmm_84");
}

function function_6589b125() {
  level endon(#"apartment_2_done", #"flag_kraus_spotted_player");
  vo_array = ["vox_cp_stkt_11110_park_krausisouronlyl_fa", "vox_cp_stkt_11110_park_dontkillkraus_b0"];

  while(true) {
    if(level.player adsButtonPressed()) {
      eye = level.player getEye();
      pos = level.var_49a292bb getshootatpos(level.player);
      trace = bullettracepassed(eye, pos, 0, level.var_49a292bb);

      if(trace) {
        if(vo_array.size > 0) {
          vo_alias = array::random(vo_array);
          level dialogue::function_9e580f95();
          wait 0.1;
          level dialogue::radio(vo_alias);
          arrayremovevalue(vo_array, vo_alias);

          if(vo_array.size > 0) {
            wait 5;
          } else {
            break;
          }
        } else {
          break;
        }
      }
    }

    wait 0.1;
  }
}

function function_96de90a7() {
  level endon(#"flag_briefcase_found");
  dialogue::radio("vox_cp_stkt_11500_park_ivelostsightofk_ec");
  level flag::set("flag_give_blacklight");
  wait 8;
  dialogue::radio("vox_cp_stkt_11325_park_yourerunningout_8e");
  wait 8;

  if(isalive(level.child)) {
    level.child dialogue::queue("vox_cp_stkt_11500_will_dadisthatyou_be");
  }
}

function function_4b72e85() {
  level flag::wait_till("flag_briefcase_found");
  wait 1.5;
  dialogue::radio("vox_cp_stkt_11500_park_ivelostyourvisu_d2");
  level waittill(#"hash_6a03e5dcd38585c8");
  dialogue::radio("vox_cp_stkt_11500_park_bellhaveyoufoun_8c");
  level flag::wait_till("flag_close_briefcase");
  wait 0.25;
  dialogue::radio("vox_cp_stkt_11500_park_understoodjustp_4d");
}

function function_f29bdbdf(party, convo, islooping = 0, levelnotify) {
  assert(isarray(party), "<dev string:x38>");
  assert(isarray(convo), "<dev string:x67>");
  level endon(#"hash_c09417d2f88858b");

  if(isstring(levelnotify)) {
    level endon(levelnotify);
  }

  foreach(member in party) {
    assert(isentity(member[1]), "<dev string:x96>");
    member[1] endon(#"hash_17ed2687a4e410ba");
  }

  while(islooping) {
    foreach(vo in convo) {
      if(isfloat(vo) || isint(vo)) {
        wait vo;
        continue;
      }

      assert(isstring(vo), "<dev string:xca>");

      if(!soundexists(vo)) {
        text = "<dev string:xfa>" + vo + "<dev string:x11e>";
        iprintlnbold(text);
        println(text);

        continue;
      }

      talker = undefined;

      foreach(member in party) {
        assert(isarray(member) && member.size == 2, "<dev string:x123>");
        var_3c49e075 = member[0];
        var_1ed8f16a = member[1];
        assert(isstring(var_3c49e075), "<dev string:x14b>");
        assert(isentity(var_1ed8f16a), "<dev string:x96>");

        if(issubstr(vo, var_3c49e075)) {
          talker = var_1ed8f16a;
        }
      }

      if(isDefined(talker) && isalive(talker)) {
        talker dialogue::queue(vo);
      }
    }
  }
}