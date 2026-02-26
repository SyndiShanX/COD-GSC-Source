/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_platinum_vo.gsc
***********************************************/

#using script_56731c09a921b64e;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_zonemgr;
#namespace zm_platinum_vo;

function init() {
  level callback::on_ai_spawned(&function_57138f33);
  level callback::on_ai_spawned(&function_fd4567c1);
  level callback::on_actor_killed(&function_cc68dd0b);
  function_9df8f6e2();
  level thread function_303e39b2();
  level thread function_6fc38155();
  level thread function_bb2a9e07();
  level thread function_8d30b29b();
  level thread function_a607218b();
  level thread function_fc9df79c();
  level thread function_d0bf9b31();
  level thread function_8fe3724e();
  level thread function_9b61eb65();
  level thread function_838bf43a();
  level thread function_689f8691();
  level thread function_3d7931b9();
  level thread function_aa08591f();
  level thread function_db70569d();
  level thread function_5cdffd1d();
  level callback::function_74872db6(&function_33d554e1);
  callback::on_item_pickup(&function_60ef20d8);
  level thread function_7d38bcc1();
  level.var_9f4fcdec = "none";
  level.var_f9d84559 = "zber_xfl_fail";
  level.var_3537dbe0 = &function_5a98963a;
  level.var_89b98dd4 = 0;
  level.var_524c7848 = 0;
}

function private function_9df8f6e2() {
  var_a15a626c = randomintrange(0, 3);

  switch (var_a15a626c) {
    case 0:
      level.var_114b6e35 = "peck";
      break;
    case 1:
      level.var_114b6e35 = "jagr";
      break;
    case 2:
      level.var_114b6e35 = "gorv";
      break;
  }
}

function private function_303e39b2() {
  level endon(#"end_game");
  level flag::wait_till("initial_blackscreen_passed");

  if(isDefined(level.var_dfee7fc2) && !getdvarint(#"hash_39af51993585a73e", 0)) {
    level thread zm_vo::function_7622cb70(#"hash_1c80b5cb9894342c", 5.5);
  }
}

function function_689f8691() {
  level flag::wait_till("power_on");
  level thread zm_vo::function_7622cb70("zber_eg_pwr_on");
}

function function_33d554e1() {
  if(level.round_number == 2) {
    var_46e76b4b = randomintrangeinclusive(0, 2);

    switch (level.var_114b6e35) {
      case # "peck":
        switch (var_46e76b4b) {
          case 0:
            level zm_vo::function_7622cb70("zber_eg_r1_kp1");
            break;
          case 1:
            level zm_vo::function_7622cb70("zber_eg_r1_kp2");
            break;
          case 2:
            level zm_vo::function_7622cb70("zber_eg_r1_kp3");
            break;
        }

        break;
      case # "gorv":
        switch (var_46e76b4b) {
          case 0:
            level zm_vo::function_7622cb70("zber_eg_r1_kg1");
            break;
          case 1:
            level zm_vo::function_7622cb70("zber_eg_r1_kg2");
            break;
          case 2:
            level zm_vo::function_7622cb70("zber_eg_r1_kg3");
            break;
        }

        break;
      case # "jagr":
        switch (var_46e76b4b) {
          case 0:
            level zm_vo::function_7622cb70("zber_eg_r1_kj1");
            break;
          case 1:
            level zm_vo::function_7622cb70("zber_eg_r1_kj2");
            break;
          case 2:
            level zm_vo::function_7622cb70("zber_eg_r1_kj3");
            break;
        }

        break;
    }
  }
}

function function_9b61eb65() {
  level endon(#"end_game");
  level flag::wait_till("fuse_box_exploded");

  if(!level flag::get(#"player_has_both_fuse")) {
    wait 1;
    var_46e76b4b = randomintrangeinclusive(0, 2);

    switch (level.var_114b6e35) {
      case # "peck":
        switch (var_46e76b4b) {
          case 0:
            level zm_vo::function_7622cb70("zber_eg_pwr_fndfs_p1");
            break;
          case 1:
            level zm_vo::function_7622cb70("zber_eg_pwr_fndfs_p2");
            break;
          case 2:
            level zm_vo::function_7622cb70("zber_eg_pwr_fndfs_p3");
            break;
        }

        break;
      case # "gorv":
        switch (var_46e76b4b) {
          case 0:
            level zm_vo::function_7622cb70("zber_eg_pwr_fndfs_g1");
            break;
          case 1:
            level zm_vo::function_7622cb70("zber_eg_pwr_fndfs_g2");
            break;
          case 2:
            level zm_vo::function_7622cb70("zber_eg_pwr_fndfs_g3");
            break;
        }

        break;
      case # "jagr":
        switch (var_46e76b4b) {
          case 0:
            level zm_vo::function_7622cb70("zber_eg_pwr_fndfs_j1");
            break;
          case 1:
            level zm_vo::function_7622cb70("zber_eg_pwr_fndfs_j2");
            break;
          case 2:
            level zm_vo::function_7622cb70("zber_eg_pwr_fndfs_j3");
            break;
        }

        break;
    }
  }
}

function function_60ef20d8(params) {
  item = params.item;

  if(isPlayer(self)) {
    if(isDefined(item.itementry) && item.itementry.name == # "item_zmquest_platinum_power_quest_fuse") {
      if(level flag::get(#"hash_1d6357b2512a35e5")) {
        var_46e76b4b = randomintrangeinclusive(0, 2);

        switch (level.var_114b6e35) {
          case # "peck":
            switch (var_46e76b4b) {
              case 0:
                level zm_vo::function_7622cb70("zber_eg_pwr_pufs_p1");
                break;
              case 1:
                level zm_vo::function_7622cb70("zber_eg_pwr_pufs_p2");
                break;
              case 2:
                level zm_vo::function_7622cb70("zber_eg_pwr_pufs_p3");
                break;
            }

            break;
          case # "gorv":
            switch (var_46e76b4b) {
              case 0:
                level zm_vo::function_7622cb70("zber_eg_pwr_pufs_g1");
                break;
              case 1:
                level zm_vo::function_7622cb70("zber_eg_pwr_pufs_g2");
                break;
              case 2:
                level zm_vo::function_7622cb70("zber_eg_pwr_pufs_g3");
                break;
            }

            break;
          case # "jagr":
            switch (var_46e76b4b) {
              case 0:
                level zm_vo::function_7622cb70("zber_eg_pwr_pufs_j1");
                break;
              case 1:
                level zm_vo::function_7622cb70("zber_eg_pwr_pufs_j2");
                break;
              case 2:
                level zm_vo::function_7622cb70("zber_eg_pwr_pufs_j3");
                break;
            }

            break;
        }
      } else {
        var_46e76b4b = randomintrangeinclusive(0, 2);

        switch (level.var_114b6e35) {
          case # "peck":
            switch (var_46e76b4b) {
              case 0:
                level zm_vo::function_7622cb70("zber_eg_pwr_pufsa_p1");
                break;
              case 1:
                level zm_vo::function_7622cb70("zber_eg_pwr_pufsa_p2");
                break;
              case 2:
                level zm_vo::function_7622cb70("zber_eg_pwr_pufsa_p3");
                break;
            }

            break;
          case # "gorv":
            switch (var_46e76b4b) {
              case 0:
                level zm_vo::function_7622cb70("zber_eg_pwr_pufsa_g1");
                break;
              case 1:
                level zm_vo::function_7622cb70("zber_eg_pwr_pufsa_g2");
                break;
              case 2:
                level zm_vo::function_7622cb70("zber_eg_pwr_pufsa_g3");
                break;
            }

            break;
          case # "jagr":
            switch (var_46e76b4b) {
              case 0:
                level zm_vo::function_7622cb70("zber_eg_pwr_pufsa_j1");
                break;
              case 1:
                level zm_vo::function_7622cb70("zber_eg_pwr_pufsa_j2");
                break;
              case 2:
                level zm_vo::function_7622cb70("zber_eg_pwr_pufsa_j3");
                break;
            }

            break;
        }
      }

      callback::remove_callback(#"on_item_pickup", &function_60ef20d8);
    }
  }
}

function private function_838bf43a() {
  var_63a065c3 = struct::get("pap_machine_pos", "targetname");
  var_3f62b7db = spawn("script_origin", var_63a065c3.origin);
  var_336c9e35 = array::random([#"hash_72caef16ec479729", #"hash_72caee16ec479576", #"hash_72caed16ec4793c3"]);
  level flag::wait_till(#"hash_434bc775e67b7233");
  wait 4;
  var_3f62b7db zm_vo::function_d6f8bbd9(var_336c9e35);
}

function private function_6fc38155() {
  level endon(#"end_game");
  level waittill(#"hash_69bc64a0ea76c1b9");
  wait 11;
  level thread zm_vo::function_7622cb70("zber_env_ghstrn");
}

function private function_70aa9a2e() {
  level endon(#"end_game");
  level flag::wait_till(#"start_zombie_round_logic");
  players = getplayers();

  foreach(e_player in players) {
    e_player thread function_53882e5e();
  }
}

function private function_53882e5e() {
  self endon(#"death");
  var_78e9af0f = getEntArray("spotlight_top", "script_noteworthy");
  level flag::wait_till(#"power_on");

  while(true) {
    foreach(tower in var_78e9af0f) {
      if(isDefined(tower)) {
        if(self zm_utility::is_player_looking_at(tower.origin) && distance(self.origin, tower.origin) < 1700) {
          var_bb833ea = 1;
        }
      }
    }

    if(self.cached_zone.name === "zone_no_mans_land_2" || self.cached_zone.name === "zone_no_mans_land_3" || is_true(var_bb833ea)) {
      self thread zm_vo::function_7622cb70("zber_env_grdtwr");
      break;
    }

    waitframe(1);
  }
}

function private function_bb2a9e07() {
  level endon(#"end_game");
  level flag::wait_till(#"hash_476d3c9ecf4a21de");
  wait 2;
  level thread zm_vo::function_7622cb70("zber_env_usetrrt");
}

function private function_8d30b29b() {
  level endon(#"end_game");
  level flag::wait_till(#"connect_no_mans_land_to_east_berlin_street");
  wait 4;
  level thread zm_vo::function_7622cb70("zber_env_chkptdst");
}

function private function_a607218b() {
  level endon(#"end_game");
  level waittill(#"hash_4f9fb4cb9a1c3158");
  var_46e76b4b = randomintrangeinclusive(0, 2);

  switch (level.var_114b6e35) {
    case # "peck":
      switch (var_46e76b4b) {
        case 0:
          level zm_vo::function_7622cb70("zber_kq_klsrct_p1_peck");
          break;
        case 1:
          level zm_vo::function_7622cb70("zber_kq_klsrct_p2_peck");
          break;
        case 2:
          level zm_vo::function_7622cb70("zber_kq_klsrct_p3_peck");
          break;
      }

      break;
    case # "jagr":
      switch (var_46e76b4b) {
        case 0:
          level zm_vo::function_7622cb70("zber_kq_klsrct_j1_jagr");
          break;
        case 1:
          level zm_vo::function_7622cb70("zber_kq_klsrct_j2_jagr");
          break;
        case 2:
          level zm_vo::function_7622cb70("zber_kq_klsrct_j3_jagr");
          break;
      }

      break;
    case # "gorv":
      switch (var_46e76b4b) {
        case 0:
          level zm_vo::function_7622cb70("zber_kq_klsrct_g1_gorv");
          break;
        case 1:
          level zm_vo::function_7622cb70("zber_kq_klsrct_g2_gorv");
          break;
        case 2:
          level zm_vo::function_7622cb70("zber_kq_klsrct_g3_gorv");
          break;
      }

      break;
  }
}

function private function_fc9df79c() {
  level endon(#"end_game");
  level waittill(#"hash_57f2c29e7e96eda7");
  var_46e76b4b = randomintrangeinclusive(0, 2);

  if(level flag::get(#"hash_4f9fb4cb9a1c3158")) {
    switch (level.var_114b6e35) {
      case # "peck":
        switch (var_46e76b4b) {
          case 0:
            level zm_vo::function_7622cb70("zber_kq_puhnd_p1_peck");
            break;
          case 1:
            level zm_vo::function_7622cb70("zber_kq_puhnd_p2_peck");
            break;
          case 2:
            level zm_vo::function_7622cb70("zber_kq_puhnd_p3_peck");
            break;
        }

        break;
      case # "jagr":
        switch (var_46e76b4b) {
          case 0:
            level zm_vo::function_7622cb70("zber_kq_puhnd_j1_jagr");
            break;
          case 1:
            level zm_vo::function_7622cb70("zber_kq_puhnd_j2_jagr");
            break;
          case 2:
            level zm_vo::function_7622cb70("zber_kq_puhnd_j3_jagr");
            break;
        }

        break;
      case # "gorv":
        switch (var_46e76b4b) {
          case 0:
            level zm_vo::function_7622cb70("zber_kq_puhnd_g1_gorv");
            break;
          case 1:
            level zm_vo::function_7622cb70("zber_kq_puhnd_g2_gorv");
            break;
          case 2:
            level zm_vo::function_7622cb70("zber_kq_puhnd_g3_gorv");
            break;
        }

        break;
    }

    return;
  }

  switch (level.var_114b6e35) {
    case # "peck":
      switch (var_46e76b4b) {
        case 0:
          level zm_vo::function_7622cb70("zber_kq_puhndalt_p1_peck");
          break;
        case 1:
          level zm_vo::function_7622cb70("zber_kq_puhndalt_p2_peck");
          break;
        case 2:
          level zm_vo::function_7622cb70("zber_kq_puhndalt_p3_peck");
          break;
      }

      break;
    case # "jagr":
      switch (var_46e76b4b) {
        case 0:
          level zm_vo::function_7622cb70("zber_kq_puhndalt_j1_jagr");
          break;
        case 1:
          level zm_vo::function_7622cb70("zber_kq_puhndalt_j2_jagr");
          break;
        case 2:
          level zm_vo::function_7622cb70("zber_kq_puhndalt_j3_jagr");
          break;
      }

      break;
    case # "gorv":
      switch (var_46e76b4b) {
        case 0:
          level zm_vo::function_7622cb70("zber_kq_puhndalt_g1_gorv");
          break;
        case 1:
          level zm_vo::function_7622cb70("zber_kq_puhndalt_g2_gorv");
          break;
        case 2:
          level zm_vo::function_7622cb70("zber_kq_puhndalt_g3_gorv");
          break;
      }

      break;
  }
}

function private function_d0bf9b31() {
  level endon(#"end_game");
  level waittill(#"hash_20e3ef55ace43370");
  var_46e76b4b = randomintrangeinclusive(0, 2);

  switch (level.var_114b6e35) {
    case # "peck":
      switch (var_46e76b4b) {
        case 0:
          level zm_vo::function_7622cb70("zber_kq_pubatt_p1_peck");
          break;
        case 1:
          level zm_vo::function_7622cb70("zber_kq_pubatt_p2_peck");
          break;
        case 2:
          level zm_vo::function_7622cb70("zber_kq_pubatt_p3_peck");
          break;
      }

      break;
    case # "jagr":
      switch (var_46e76b4b) {
        case 0:
          level zm_vo::function_7622cb70("zber_kq_pubatt_j1_jagr");
          break;
        case 1:
          level zm_vo::function_7622cb70("zber_kq_pubatt_j2_jagr");
          break;
        case 2:
          level zm_vo::function_7622cb70("zber_kq_pubatt_j3_jagr");
          break;
      }

      break;
    case # "gorv":
      switch (var_46e76b4b) {
        case 0:
          level zm_vo::function_7622cb70("zber_kq_pubatt_g1_gorv");
          break;
        case 1:
          level zm_vo::function_7622cb70("zber_kq_pubatt_g2_gorv");
          break;
        case 2:
          level zm_vo::function_7622cb70("zber_kq_pubatt_g3_gorv");
          break;
      }

      break;
  }
}

function private function_8fe3724e() {
  level endon(#"end_game");
  level flag::wait_till(#"hash_19be6db4d7ab2200");
  var_46e76b4b = randomintrangeinclusive(0, 2);

  switch (level.var_114b6e35) {
    case # "peck":
      switch (var_46e76b4b) {
        case 0:
          level zm_vo::function_7622cb70("zber_kq_vigrct_p1_peck");
          break;
        case 1:
          level zm_vo::function_7622cb70("zber_kq_vigrct_p2_peck");
          break;
        case 2:
          level zm_vo::function_7622cb70("zber_kq_vigrct_p3_peck");
          break;
      }

      break;
    case # "jagr":
      switch (var_46e76b4b) {
        case 0:
          level zm_vo::function_7622cb70("zber_kq_vigrct_j1_jagr");
          break;
        case 1:
          level zm_vo::function_7622cb70("zber_kq_vigrct_j2_jagr");
          break;
        case 2:
          level zm_vo::function_7622cb70("zber_kq_vigrct_j3_jagr");
          break;
      }

      break;
    case # "gorv":
      switch (var_46e76b4b) {
        case 0:
          level zm_vo::function_7622cb70("zber_kq_vigrct_g1_gorv");
          break;
        case 1:
          level zm_vo::function_7622cb70("zber_kq_vigrct_g2_gorv");
          break;
        case 2:
          level zm_vo::function_7622cb70("zber_kq_vigrct_g3_gorv");
          break;
      }

      break;
  }
}

function function_2a5a3ef4() {
  if(is_true(self.var_c0d80964) && isDefined(level.klaus.leader.origin) && distance2d(self.origin, level.klaus.leader.origin) < 300) {
    return;
  }

  level flag::set(#"hash_7ddb901c2b09aeaa");
  self clientfield::set("" + # "hash_703543ca871a0f75", 2);
  level zm_vo::function_7622cb70(#"hash_4786036bfc148c46");

  if(isDefined(self)) {
    self clientfield::set("" + # "hash_703543ca871a0f75", 1);
  }

  level flag::clear(#"hash_7ddb901c2b09aeaa");
}

function function_cc3eb0e8() {
  if(is_true(self.isspeaking)) {
    return;
  }

  self clientfield::set("" + # "hash_703543ca871a0f75", 2);
  level zm_vo::function_7622cb70(#"hash_14a83a45f51bf71a");

  if(isDefined(self)) {
    self clientfield::set("" + # "hash_703543ca871a0f75", 1);
  }
}

function function_b4b07ee0() {
  if(!zm_vo::function_c10c4064(function_a1ef346b()[0])) {
    str_vo_alias = array::random([#"hash_1bcf33f758a0c296", #"hash_1bcf34f758a0c449", #"hash_1bcf31f758a0bf30", #"hash_1bcf32f758a0c0e3", #"hash_1bcf37f758a0c962", #"hash_1bcf38f758a0cb15", #"hash_1bcf35f758a0c5fc", #"hash_1bcf36f758a0c7af", #"hash_1bcf3bf758a0d02e", #"hash_1bcf3cf758a0d1e1"]);
    self clientfield::set("" + # "hash_703543ca871a0f75", 2);
    self zm_vo::function_d6f8bbd9(str_vo_alias, 0, undefined, 1);

    if(isDefined(self)) {
      self clientfield::set("" + # "hash_703543ca871a0f75", 1);
    }

    level flag::clear(#"hash_535517e75a9e59ca");
  }
}

function function_b6999bc7() {
  self endoncallback(&zm_vo::vo_clear, #"death", #"hash_28114ffa1168ced9");
  level endon(#"end_game");
  level waittill(#"hash_7b92449e6f0dea42");
  self clientfield::set("" + # "hash_703543ca871a0f75", 2);
  self zm_vo::function_d6f8bbd9("vox_zber_vig_klaus_awake_klau_0", 0, undefined, 1);
  self clientfield::set("" + # "hash_703543ca871a0f75", 1);
  level waittill(#"hash_7b92439e6f0de88f");
  self clientfield::set("" + # "hash_703543ca871a0f75", 2);
  self zm_vo::function_d6f8bbd9("vox_zber_vig_klaus_awake_klau_1", 0, undefined, 1);
  self zm_vo::function_d6f8bbd9("vox_zber_vig_klaus_awake_klau_2", 0, undefined, 1);
  self zm_vo::function_d6f8bbd9("vox_zber_vig_klaus_awake_klau_3", 0, undefined, 1);
  self zm_vo::function_d6f8bbd9("vox_zber_vig_klaus_awake_klau_4", 0, undefined, 1);
  self zm_vo::function_d6f8bbd9("vox_zber_vig_klaus_awake_klau_5", 0, undefined, 1);
  self clientfield::set("" + # "hash_703543ca871a0f75", 1);
}

function function_37c7631f() {
  if(!level flag::get(#"hash_12b8597c686caf6b") && !zm_vo::function_c10c4064(function_a1ef346b()[0])) {
    str_vo_alias = array::random([#"hash_236208613957d462", #"hash_236209613957d615", #"hash_236206613957d0fc", #"hash_236207613957d2af", #"hash_236204613957cd96", #"hash_236205613957cf49"]);
    self clientfield::set("" + # "hash_703543ca871a0f75", 2);
    self zm_vo::function_d6f8bbd9(str_vo_alias, 0, undefined, 1);

    if(isDefined(self)) {
      self clientfield::set("" + # "hash_703543ca871a0f75", 1);
    }

    level thread function_bd4ee705();
  }
}

function private function_bd4ee705() {
  level endon(#"end_game");
  level thread flag::set_for_time(10, #"hash_12b8597c686caf6b");
}

function function_6a1fe73a() {
  if(math::cointoss(25) && !level flag::get(#"hash_4c4ab309f734048b") && !level flag::get(#"hash_5b98233c3cce07d5") && !level flag::get(#"hash_7ddb901c2b09aeaa") && !zm_vo::function_c10c4064(function_a1ef346b()[0])) {
    level thread function_d1e90182();
    var_e823bd96 = [#"hash_3d172af7ccf92751", #"hash_3d1729f7ccf9259e", #"hash_3d1728f7ccf923eb", #"hash_3d1727f7ccf92238", #"hash_3d172ef7ccf92e1d", #"hash_3d172df7ccf92c6a"];

    if(level.var_524c7848 < var_e823bd96.size) {
      str_vo_alias = var_e823bd96[level.var_524c7848];
      level.var_524c7848++;
    } else {
      str_vo_alias = array::random(var_e823bd96);
    }

    self clientfield::set("" + # "hash_703543ca871a0f75", 2);
    self zm_vo::function_d6f8bbd9(str_vo_alias, 0, undefined, 1);

    if(isDefined(self)) {
      self clientfield::set("" + # "hash_703543ca871a0f75", 1);
    }
  }
}

function private function_d1e90182() {
  level endon(#"end_game");
  level thread flag::set_for_time(12, #"hash_4c4ab309f734048b");
}

function function_63803452() {
  if(math::cointoss(15) && !level flag::get(#"hash_5b98233c3cce07d5") && !level flag::get(#"hash_4c4ab309f734048b") && !level flag::get(#"hash_7ddb901c2b09aeaa") && !zm_vo::function_c10c4064(function_a1ef346b()[0])) {
    level thread function_9af4005();
    var_e823bd96 = [#"hash_15671a0e7f85fa91", #"hash_1567190e7f85f8de", #"hash_1567180e7f85f72b", #"hash_1567170e7f85f578", #"hash_15671e0e7f86015d", #"hash_15671d0e7f85ffaa", #"hash_15671c0e7f85fdf7", #"hash_15671b0e7f85fc44"];

    if(level.var_89b98dd4 < var_e823bd96.size) {
      str_vo_alias = var_e823bd96[level.var_89b98dd4];
      level.var_89b98dd4++;
    } else {
      str_vo_alias = array::random(var_e823bd96);
    }

    self clientfield::set("" + # "hash_703543ca871a0f75", 2);
    self zm_vo::function_d6f8bbd9(str_vo_alias, 0, undefined, 1);

    if(isDefined(self)) {
      self clientfield::set("" + # "hash_703543ca871a0f75", 1);
    }
  }
}

function private function_9af4005() {
  level endon(#"end_game");
  level thread flag::set_for_time(12, #"hash_5b98233c3cce07d5");
}

function function_57138f33(params) {
  if(self.archetype === # "mechz" && self.team === level.zombie_team && !level flag::get(#"hash_1e1634794b3aab52")) {
    level flag::set(#"hash_1e1634794b3aab52");
    var_773dbbf2 = 0;

    while(!var_773dbbf2) {
      if(!isDefined(self)) {
        level flag::clear(#"hash_1e1634794b3aab52");
        return;
      }

      var_fa75f521 = zm_zonemgr::get_zone_from_position(self.origin);
      a_players = function_a1ef346b();

      foreach(player in a_players) {
        if(var_fa75f521 === player.cached_zone_name) {
          var_46e76b4b = randomintrangeinclusive(0, 2);

          switch (var_46e76b4b) {
            case 0:
              level thread zm_vo::function_7622cb70("zber_ai_krsny_1_krav");
              break;
            case 1:
              level thread zm_vo::function_7622cb70("zber_ai_krsny_2_krav");
              break;
            case 2:
              level thread zm_vo::function_7622cb70("zber_ai_krsny_3_krav");
              break;
          }

          var_773dbbf2 = 1;
          break;
        }
      }

      wait 1;
    }

    level callback::remove_on_ai_spawned(&function_57138f33);
  }
}

function function_fd4567c1(params) {
  if(self.archetype === # "avogadro" && self.team === level.zombie_team && !level flag::get(#"hash_34e667966f6e9ab1")) {
    level flag::set(#"hash_34e667966f6e9ab1");
    var_773dbbf2 = 0;

    while(!var_773dbbf2) {
      if(!isDefined(self)) {
        level flag::clear(#"hash_34e667966f6e9ab1");
        return;
      }

      var_fa75f521 = zm_zonemgr::get_zone_from_position(self.origin);
      a_players = function_a1ef346b();

      foreach(player in a_players) {
        if(var_fa75f521 === player.cached_zone_name) {
          var_46e76b4b = randomintrangeinclusive(0, 2);

          switch (var_46e76b4b) {
            case 0:
              level thread zm_vo::function_7622cb70("zber_ai_tmpst_1_krav");
              break;
            case 1:
              level thread zm_vo::function_7622cb70("zber_ai_tmpst_2_krav");
              break;
            case 2:
              level thread zm_vo::function_7622cb70("zber_ai_tmpst_3_krav");
              break;
          }

          var_773dbbf2 = 1;
        }
      }

      wait 1;
    }

    level callback::remove_on_ai_spawned(&function_fd4567c1);
  }
}

function function_cc68dd0b(params) {
  if(self.archetype === # "soa" && self.team === level.zombie_team) {
    wait 1.5;
    var_46e76b4b = randomintrangeinclusive(0, 2);

    switch (var_46e76b4b) {
      case 0:
        level thread zm_vo::function_7622cb70("zber_ai_dscpl_1_krav");
        break;
      case 1:
        level thread zm_vo::function_7622cb70("zber_ai_dscpl_2_krav");
        break;
      case 2:
        level thread zm_vo::function_7622cb70("zber_ai_dscpl_3_krav");
        break;
    }

    level callback::remove_on_actor_killed(&function_cc68dd0b);
  }
}

function function_c5fed573(var_41117948, var_80e90d4a, var_e9c89033) {
  switch (level.var_114b6e35) {
    case # "peck":
      vo_string = array::random(var_41117948);
      return vo_string;
    case # "jagr":
      vo_string = array::random(var_80e90d4a);
      return vo_string;
    case # "gorv":
      vo_string = array::random(var_e9c89033);
      return vo_string;
  }
}

function function_d137d6a0(var_e33b1e9e, var_fe38b8d, var_f5afb036) {
  switch (level.var_114b6e35) {
    case # "peck":
      level zm_vo::function_7622cb70(var_e33b1e9e);
      break;
    case # "jagr":
      level zm_vo::function_7622cb70(var_fe38b8d);
      break;
    case # "gorv":
      level zm_vo::function_7622cb70(var_f5afb036);
      break;
  }
}

function function_b7e4011() {
  level endon(#"end_game");
  level notify(#"hash_1ca30bf3bc01d214");
  level zm_vo::function_7622cb70("zber_hvt_fire_seq_1_orqc");
  var_462905d9 = getEntArray("pl_street_com", "script_noteworthy");

  if(!isDefined(var_462905d9)) {
    var_462905d9 = [];
  } else if(!isarray(var_462905d9)) {
    var_462905d9 = array(var_462905d9);
  }

  var_462905d9[var_462905d9.size] = getent("computer_in_safe", "targetname");

  foreach(e_computer in var_462905d9) {
    e_computer playSound(#"hash_4970b7fd84d4afea");
  }

  wait 0.5;
  level zm_vo::function_7622cb70("zber_hvt_fire_seq_2_orqc");
  wait 0.25;
  level zm_vo::function_7622cb70("zber_hvt_fire_seq_3_orqc");
  wait 0.25;
  level zm_vo::function_7622cb70("zber_hvt_fire_seq_4_orqc");

  foreach(e_computer in var_462905d9) {
    e_computer playSound(#"hash_5849d9bbaffa605a");
  }

  wait 1;
  level flag::wait_till(#"hvt_event_steiner_spawned");
  level zm_vo::function_7622cb70("zber_hvt_fire_seq_5_orqc");
}

function function_7d38bcc1() {
  level endon(#"end_game");
  level waittill(#"hash_2386c39d37af74e3");
  wait 0.5;

  switch (level.var_114b6e35) {
    case # "peck":
      level zm_vo::function_7622cb70("zber_mq3_usetlur_p_peck");
      break;
    case # "jagr":
      level zm_vo::function_7622cb70("zber_mq3_usetlur_j_jagr");
      break;
    case # "gorv":
      level zm_vo::function_7622cb70("zber_mq3_usetlur_g_gorv");
      break;
  }
}

function private function_aa08591f() {
  level endon(#"end_game");
  level thread function_7608148();
  level thread function_a1c4a0a3();
  level thread function_c6e4a904();
  level thread function_a465a7b3();
  level waittill(#"hash_220ba0e612fb8706");

  switch (level.var_114b6e35) {
    case # "peck":
      level zm_vo::function_7622cb70("zber_mq5_cmpacs_p_peck");
      break;
    case # "jagr":
      level zm_vo::function_7622cb70("zber_mq5_cmpacs_j_jagr");
      break;
    case # "gorv":
      level zm_vo::function_7622cb70("zber_mq5_cmpacs_g_gorv");
      break;
  }

  level flag::wait_till(#"hash_5292b6ef8216e686");

  switch (level.var_114b6e35) {
    case # "peck":
      level zm_vo::function_7622cb70("zber_mq5_acsdny_p_peck");
      break;
    case # "jagr":
      level zm_vo::function_7622cb70("zber_mq5_acsdny_j_jagr");
      break;
    case # "gorv":
      level zm_vo::function_7622cb70("zber_mq5_acsdny_g_gorv");
      break;
  }

  if(level flag::get(#"klaus_helm_crafted")) {
    level zm_vo::function_7622cb70("zber_mq5_dnyresp2_klau");
  } else {
    level zm_vo::function_7622cb70("zber_mq5_dnyresp1_klau");
    level flag::set(#"hash_6cbfffe3a19f4f23");
  }

  level waittill(#"hash_416a2700f2b2ba76");
  wait 3;
  level zm_vo::function_7622cb70("zber_mq5_endstep_vlnt");
}

function private function_bf502b25() {
  if(isDefined(level.klaus)) {
    var_8b274988 = zm_zonemgr::get_zone_from_position(level.klaus.origin);

    if(var_8b274988 == "zone_safe_house") {
      return true;
    } else {
      return false;
    }
  }

  return false;
}

function private function_7608148() {
  level endon(#"end_game", #"hash_1a6711afd0c82794", #"klaus_helm_crafted");
  level flag::wait_till(#"hash_6cbfffe3a19f4f23");

  while(true) {
    waitresult = level waittill(#"hash_2f350a6796478d3a");
    e_player = waitresult.e_activator;

    if(!isDefined(level.klaus)) {
      break;
    }

    if(isDefined(e_player) && level flag::get(#"hash_279a97271de2b7e1") && distance2dsquared(e_player.origin, level.klaus.origin) <= 65536) {
      level.klaus zm_vo::function_d6f8bbd9("vox_zber_mq5_ant_hint_klau_0", 0, undefined, 1);
      break;
    }
  }
}

function function_5603f220() {
  var_b3535269 = self namespace_1e7573ec::function_d0aeb094();

  switch (var_b3535269) {
    case 0:
      self namespace_1e7573ec::function_1340d9d6("vox_zber_mq5_dstant_cs_cstr_0");
      break;
    case 1:
      self namespace_1e7573ec::function_1340d9d6("vox_zber_mq5_dstant_cg_cgry_0");
      break;
    case 2:
      self namespace_1e7573ec::function_1340d9d6("vox_zber_mq5_dstant_cc_ccrv_0");
      break;
  }
}

function private function_a1c4a0a3() {
  level endon(#"end_game", #"hash_33dc9c7e0eb8e450", #"klaus_helm_crafted");
  level flag::wait_till(#"hash_6cbfffe3a19f4f23");

  while(true) {
    waitresult = level waittill(#"hash_1b22030e8582373");
    e_player = waitresult.e_activator;

    if(!isDefined(level.klaus)) {
      break;
    }

    if(isDefined(e_player) && level flag::get(#"hash_279a97271de2b7e1") && distance2dsquared(e_player.origin, level.klaus.origin) <= 65536) {
      level.klaus zm_vo::function_d6f8bbd9("vox_zber_mq5_wrebrd_hint_klau_0", 0, undefined, 1);
      break;
    }
  }
}

function function_165032c1() {
  var_b3535269 = self namespace_1e7573ec::function_d0aeb094();

  switch (var_b3535269) {
    case 0:
      self namespace_1e7573ec::function_1340d9d6("vox_zber_mq5_mltctrl_cs_cstr_0");
      break;
    case 1:
      self namespace_1e7573ec::function_1340d9d6("vox_zber_mq5_mltctrl_cg_cgry_0");
      break;
    case 2:
      self namespace_1e7573ec::function_1340d9d6("vox_zber_mq5_mltctrl_cc_ccrv_0");
      self namespace_1e7573ec::function_1340d9d6("vox_zber_mq5_mltctrl_cc_ccrv_1");
      break;
  }
}

function private function_c6e4a904() {
  level endon(#"end_game", #"hash_724f7a255c955ed1", #"klaus_helm_crafted");
  level flag::wait_till(#"hash_6cbfffe3a19f4f23");

  while(true) {
    waitresult = level waittill(#"hash_710553010563fce0");
    e_player = waitresult.e_activator;

    if(!isDefined(level.klaus)) {
      break;
    }

    if(isDefined(e_player) && level flag::get(#"hash_279a97271de2b7e1") && distance2dsquared(e_player.origin, level.klaus.origin) <= 65536) {
      level.klaus zm_vo::function_d6f8bbd9("vox_zber_mq5_trns_hint_klau_0", 0, undefined, 1);
      break;
    }
  }
}

function function_20f55498() {
  var_b3535269 = self namespace_1e7573ec::function_d0aeb094();

  switch (var_b3535269) {
    case 0:
      self namespace_1e7573ec::function_1340d9d6("vox_zber_mq5_bmbx_cs_cstr_0");
      break;
    case 1:
      self namespace_1e7573ec::function_1340d9d6("vox_zber_mq5_bmbx_cg_cgry_0");
      break;
    case 2:
      self namespace_1e7573ec::function_1340d9d6("vox_zber_mq5_bmbx_cc_ccrv_0");
      break;
  }
}

function private function_3d7931b9() {
  level endon(#"end_game");
  level waittill(#"klaus_helm_crafted");

  if(level flag::get(#"hash_9a22ba9db480002")) {
    level zm_vo::function_7622cb70("zber_mq5_hckhlm1_klau");
    return;
  }

  level zm_vo::function_7622cb70("zber_mq5_hckhlm2_klau");
}

function private function_a465a7b3() {
  level endon(#"end_game", #"hash_4e66662af9746f4f");
  level waittill(#"hash_9a22ba9db480002");
  level waittill(#"hash_6d16c284cbb301d1");

  if(isDefined(level.klaus)) {
    level.klaus zm_vo::function_d6f8bbd9("vox_zber_mq5_dsrpt_hint_klau_0", 0, undefined, 1);
  }
}

function private function_db70569d() {
  level endon(#"end_game");
  level thread function_4efae2fa();
  level thread function_fd4b1bd2();
  level waittill(#"hash_32cdc77246645d55");
  wait 25;

  switch (level.var_114b6e35) {
    case # "peck":
      level zm_vo::function_7622cb70("zber_mq6_drptsat_p_peck");
      break;
    case # "jagr":
      level zm_vo::function_7622cb70("zber_mq6_drptsat_j_jagr");
      break;
    case # "gorv":
      level zm_vo::function_7622cb70("zber_mq6_drptsat_g_gorv");
      break;
  }

  level waittill(#"hash_a9907d2116d8d9e");

  switch (level.var_114b6e35) {
    case # "peck":
      level zm_vo::function_7622cb70("zber_mq6_pucru92_p_peck");
      break;
    case # "jagr":
      level zm_vo::function_7622cb70("zber_mq6_pucru92_j_jagr");
      break;
    case # "gorv":
      level zm_vo::function_7622cb70("zber_mq6_pucru92_g_gorv");
      break;
  }

  level waittill(#"hash_1d35d96ca4443a91");

  switch (level.var_114b6e35) {
    case # "peck":
      level zm_vo::function_7622cb70("zber_mq6_purkt_p_peck");
      break;
    case # "jagr":
      level zm_vo::function_7622cb70("zber_mq6_purkt_j_jagr");
      break;
    case # "gorv":
      level zm_vo::function_7622cb70("zber_mq6_purkt_g_gorv");
      break;
  }

  level waittill(#"hash_45622788b333b1f6");

  switch (level.var_114b6e35) {
    case # "peck":
      level zm_vo::function_7622cb70("zber_mq6_puclnu92_p_peck");
      break;
    case # "jagr":
      level zm_vo::function_7622cb70("zber_mq6_puclnu92_j_jagr");
      break;
    case # "gorv":
      level zm_vo::function_7622cb70("zber_mq6_puclnu92_g_gorv");
      break;
  }

  level thread function_4d5b7c53();
  level waittill(#"hash_3c1a16f8a03fa789");

  switch (level.var_114b6e35) {
    case # "peck":
      level zm_vo::function_7622cb70("zber_mq6_plcu92_p_peck");
      break;
    case # "jagr":
      level zm_vo::function_7622cb70("zber_mq6_plcu92_j_jagr");
      break;
    case # "gorv":
      level zm_vo::function_7622cb70("zber_mq6_plcu92_g_gorv");
      break;
  }

  level waittill(#"hash_3c1a16f8a03fa789");

  switch (level.var_114b6e35) {
    case # "peck":
      level zm_vo::function_7622cb70("zber_mq6_cpltiwh_p_peck");
      break;
    case # "jagr":
      level zm_vo::function_7622cb70("zber_mq6_cpltiwh_g_gorv");
      break;
    case # "gorv":
      level zm_vo::function_7622cb70("zber_mq6_cpltiwh_j_jagr");
      break;
  }
}

function private function_4efae2fa() {
  level endon(#"end_game");
  level waittill(#"hash_747aa3dbac4ca7f1");

  switch (level.var_114b6e35) {
    case # "peck":
      level zm_vo::function_7622cb70("zber_mq6_3min_p_peck");
      break;
    case # "jagr":
      level zm_vo::function_7622cb70("zber_mq6_3min_j_jagr");
      break;
    case # "gorv":
      level zm_vo::function_7622cb70("zber_mq6_3min_g_gorv");
      break;
  }

  level waittill(#"hash_6c454492dd434df5");

  switch (level.var_114b6e35) {
    case # "peck":
      level zm_vo::function_7622cb70("zber_mq6_1min_p_peck");
      break;
    case # "jagr":
      level zm_vo::function_7622cb70("zber_mq6_1min_j_jagr");
      break;
    case # "gorv":
      level zm_vo::function_7622cb70("zber_mq6_1min_g_gorv");
      break;
  }

  level waittill(#"hash_7351994164ae60");
  level thread zm_vo::function_7622cb70("zber_mq6_10sec_klau");
  level waittill(#"hash_5a63eeb221823928");
  level thread zm_vo::function_7622cb70("zber_mq6_tmrexp_krav");
}

function private function_4d5b7c53() {
  level endon(#"end_game");
  level flag::wait_till(#"hash_78033190338d11c3");
  level waittill(#"hash_a9907d2116d8d9e");
  level zm_vo::function_7622cb70("zber_mq6_preendstep_vlnt");
}

function private function_c105ec04() {
  level endon(#"end_game", #"hash_38d220d3c8dc4c29");
  level waittill(#"hash_4e66662af9746f4f");
  level waittill(#"hash_6d16c284cbb301d1");
  level thread zm_vo::function_7622cb70("zber_mq6_decru92_klau");
  level flag::set(#"hash_38d220d3c8dc4c29");
}

function private function_fd4b1bd2() {
  level endon(#"end_game", #"hash_38d220d3c8dc4c29");
  level waittill(#"hash_4e66662af9746f4f");

  while(true) {
    if(level flag::get(#"hash_6d16c284cbb301d1")) {
      a_players = function_a1ef346b();

      foreach(player in a_players) {
        player_zone = player.cached_zone_name;

        if((player_zone === "zone_korber_roof" || player_zone === "zone_destroyed_upper_floors2") && isDefined(level.klaus) && distance2dsquared(player.origin, level.klaus.origin) <= 65536 && !level flag::get(#"hash_7ddb901c2b09aeaa")) {
          level.klaus.var_c0d80964 = 1;
          level.klaus zm_vo::function_d6f8bbd9("vox_zber_mq6_decru92_klau_0", 0, undefined, 1);
          level.klaus.var_c0d80964 = 0;
          level flag::set(#"hash_38d220d3c8dc4c29");
          break;
        }
      }
    }

    wait 0.5;
  }
}

function function_5cdffd1d() {
  level endon(#"end_game");
  s_audiolog = struct::get("s_omega_audiolog_3");
  var_a4318688 = struct::get(s_audiolog.target);
  var_6de806b5 = getent(s_audiolog.target, "targetname");
  var_9e87f151 = util::spawn_model(s_audiolog.model, s_audiolog.origin, s_audiolog.angles);

  while(true) {
    waitresult = var_6de806b5 waittill(#"damage");

    if(isPlayer(waitresult.attacker)) {
      var_9e87f151 notsolid();
      n_power = length(s_audiolog.origin - var_a4318688.origin);
      n_wait = var_9e87f151 zm_utility::fake_physicslaunch(var_a4318688.origin, n_power);
      wait n_wait;
      level flag::set(#"hash_20358ab23ce11015");
      break;
    }
  }

  wait 0.5;

  if(isDefined(var_9e87f151)) {
    var_9e87f151 delete();
  }

  if(isDefined(var_6de806b5)) {
    var_6de806b5 delete();
  }
}

function function_e250a72f(str_vo, var_385ce850 = level.klaus, var_19e310da = 0) {
  level endon(#"end_game");

  if(!isDefined(var_385ce850)) {
    return;
  }

  var_385ce850 endon(#"death");

  if(!var_19e310da) {
    if(!isDefined(var_385ce850) || zm_vo::function_c10c4064(function_a1ef346b()[0])) {
      return;
    }
  }

  var_385ce850 clientfield::set("" + # "hash_703543ca871a0f75", 2);
  var_385ce850 zm_vo::function_d6f8bbd9(str_vo, 0, undefined, 1);
  var_385ce850 clientfield::set("" + # "hash_703543ca871a0f75", 1);
}

function function_5a98963a(v_location) {
  if(!isDefined(v_location)) {
    return false;
  }

  var_db1c83a1 = getEntArray("klaus_interact", "script_noteworthy");

  foreach(interact in var_db1c83a1) {
    dist = distance2dsquared(v_location, interact.origin);

    if(is_true(interact.is_active) && dist <= sqr(200)) {
      return true;
    }
  }

  foreach(var_67fbb89d in level.var_44ff9e2) {
    dist = distance2dsquared(v_location, var_67fbb89d.origin);

    if(is_true(interact.is_active) && dist <= 4096) {
      return true;
    }
  }

  var_96611cee = getent("stop_train_check_volume", "targetname");

  if(istouching(v_location, var_96611cee)) {
    return true;
  }

  return false;
}