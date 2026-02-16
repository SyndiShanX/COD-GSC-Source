/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\gametypes\zombie.gsc
*************************************************/

main() {
  init_zombie_map_setting();
  thread scripts\common\telemetry::init();
  thread scripts\cp\telemetry_cp::init();
  _id_8122();
  _id_072E::init();
  level thread onplayerconnect();
  _id_7F15();
  _id_8123();
  _id_0746::init();
  level._id_A4FE = getdvarint("#x321c4c58d54d0ecd0", 0);

  if(getdvarint("#x343d5fb3e35056fbf", 0) != 0) {
    scripts\cp\utility::_id_3D1B(["pillage", "loot", "challenge", "doors", "wall_buys", "crafting"]);
  } else {
    scripts\cp\utility::_id_3D1B(["pillage", "loot", "challenge", "doors", "guided_interaction", "wall_buys", "crafting", "outline"]);
  }

  level._id_A56E = 0;
  level._id_A56D = 0;
  level._id_10C9F = 0;
  level._id_9058 = ::_id_1102F;
  level._id_4A76 = 1;
  level._id_7D75 = _id_09A4::_id_8600;
  level._id_4249 = _id_073C::_id_6F90;
  level._id_A201 = _id_073C::_id_FCCC;
  level._id_6B9A = ::_func_00B3;
  level._id_BBA5 = ::_id_45A0;
  level._id_2F4C = _id_0997::_id_2F44;
  level._id_2F4F = ::_id_1101C;
  level._id_905A = ::_id_11027;
  level._id_BBEB = ::_id_11041;
  level.damage_multiplier_callbacks = [];
  level.flat_damage_callbacks = [];
  level._id_FB8A = _id_099E::_id_FB89;
  level._id_C0E2 = _id_0983::_id_C0E1;
  level._id_9853 = _id_09A4::_id_11084;
  level._id_9855 = _id_077F::_id_FB63;
  level._id_FD9A = _id_0982::_id_FD99;
  level._id_0F34 = scripts\cp\utility::_id_85FB;
  level._id_60F2 = ::_id_1102D;
  level._id_E413 = _id_075B::_id_19F5;
  level._id_905C = ::_id_11028;
  level._id_AB63 = ::_id_11036;
  level._id_7AAA = ::_id_1106F;
  level._id_AB02 = ::_id_11070;
  level._id_6700 = ::_id_6700;
  level.outlineaxe = scripts\cp\cp_outline_utility::outlineenableforplayer;
  level._id_A529 = 1;
  level._id_11069 = 1;
  level._id_429F = 1;
  level._id_42A0 = 1;
  level.spawnedaibase = 0;
  level.spawnedaiscreamer = 0;
  level.spawnedaijuggernaut = 0;
  level.spawnedaitrickster = 0;
  level._id_BAC5 = "cp/zombies/zombie_powertable.csv";
  level._id_60AE = "cp/zombies/mode_string_tables/zombies_statstable.csv";
  level._id_60AD = "cp/zombies/zombie_attachmentmap.csv";
  var_0 = getDvar("#x36d16f02578d0ee10");
  level._id_BACC = "cp/zombies/" + var_0 + "_loot.csv";
  _id_07FD::init();
  scripts\cp\cp_weapon::_id_10DD3();
  _id_0774::_id_8114();
  _id_0718::_id_7F43();
  scripts\cp\utility::_id_7649(0);
  _id_0728::_id_7F75();
  scripts\cp\cp_killstreaks::init_killstreaks();

  if(!isDefined(level._id_BADE)) {
    level._id_BADE = [];
  }

  level._id_AD1E = [];
  level._id_74C4 = getdvarint("#x3e4489fa448896424");
  level._id_C81C = getdvarint("#x3f330246d73bb4bf3");
  level._id_3323 = getdvarint("#x3168d278d75ee4e0f");
  level._id_8F3A = 0;
  level._id_8F4E = [];
  level._id_32FF = 1;
  level._id_82F4 = 0;
  level._id_459D = "s4_ar_stango44_mp";
  level._id_AE11 = 3;
  level._id_84FE = 0;
  level._id_57D0 = 0.1;
  level._id_DA57 = 0.1;
  level._id_1B5C = 0.2;
  level._id_9C85 = 10;
  level._id_C7D2 = ::_id_11047;
  level._id_C7D5 = ::_id_11048;

  if(!isDefined(level.filtered_attachment_types)) {
    level.filtered_attachment_types = [];
    level.filtered_attachment_types = scripts\engine\utility::array_add(level.filtered_attachment_types, "extra");
    level.filtered_attachment_types = scripts\engine\utility::array_add(level.filtered_attachment_types, "gunperk");
    level.filtered_attachment_types = scripts\engine\utility::array_add(level.filtered_attachment_types, "gunperk2");
  }

  level.validate_anim_will_finish = 1;
  _id_074A::_id_ACBB();
  _id_099E::_id_8125();
  _id_BB6A();
  _id_0779::init();
  _id_090F::main();
  _id_0778::init();
  _id_099C::_id_807C();
  _id_073C::init();
  _id_0720::init();
  _id_0717::init();
  level scripts\cp\cp_hud_message::_id_7F41();
  level thread _id_077F::_id_7FE3();
  level thread _id_09A0::_id_8050();
  _id_48D6();
  level thread _id_0737::_id_3D19();
  level thread scripts\cp\utility::_id_703F();
  level thread _id_099D::init();
  level thread _id_E8AF();
  _id_06EF::_id_BB93();
  _id_0987::_id_BB93();
  level thread scripts\cp\zombies\zm_comics_pages::init();
  _id_06E5::_id_BB93();
  scripts\cp\doorbuy::init_doorbuy();
  level thread _id_0990::init();
  level thread scripts\cp\zombies\zm_hub_unlock::init();
  level thread _id_098A::init();
  _id_079F::_id_CF68();
  level thread track_players_intersection_tracker();

  if(getdvarint("#x3dee089cb49164e4e", 0)) {
    level thread scripts\cp\spawners\agent_spawner::init_agent_spawner();
    level thread scripts\cp\spawners\zone_spawner::init_zone_spawner();
    level thread scripts\cp\spawners\procedural_spawner::init_procedural_spawner();
  }

  level thread scripts\aitypes\zombie_common\ai_util::init();
  level scripts\engine\utility::_id_5C11("spawn_zombies");
  setdvarifuninitialized("#x3e6d2f40734507049", 0);
  setdvarifuninitialized("#x328b7d3017269e4fc", 9999);
  setdvarifuninitialized("#x380916358d69cbd04", 0);
  setdvarifuninitialized("#x37170982d03990277", 0);
  setdvarifuninitialized("#x38ce97d48ca2d52a", 10);
  setdvarifuninitialized("#x3b67a500c109f0689", 10);
  setdvarifuninitialized("#x38345c39401cd12c2", 10);
  setdvarifuninitialized("#x3cd85dcee89a20a09", 10);
  setdvarifuninitialized("#x3793c973bf39cbe0f", 10);
  level thread soak_control();
  setDvar("#x3a913fc7ea6721d71", 1);
  setDvar("#x37764fdd3420013f", 1);
  setDvar("#x3a5cc1f61008d141e", 1.2);
  setDvar("#x397617e5e9291ea7b", 120);
}

_id_253B() {}

track_players_intersection_tracker() {
  level endon("end_game");
  wait 5;
  var_0 = [];
  level.check_players_too_friendly = scripts\cp\utility::_id_459B(level.check_players_too_friendly, 1);
  var_1 = 15625.0;

  for(;;) {
    var_2 = 0;
    var_3 = scripts\cp\utility::_id_6C5C();
    var_7 = [];

    for(var_8 = 0; var_8 < var_3.size; var_8++) {
      if(istrue(var_3[var_8]._id_2041) || _id_073B::_id_B4EF(var_3[var_8])) {
        continue;
      }
      if(_func_0135(var_3[var_8] getvelocity()) > var_1) {
        continue;
      }
      if(istrue(var_3[var_8].b_disable_player_intersection_tracker)) {
        continue;
      }
      for(var_9 = 0; var_9 < var_3.size; var_9++) {
        if(var_8 == var_9 || istrue(var_3[var_9]._id_2041) || _id_073B::_id_B4EF(var_3[var_8])) {
          continue;
        }
        if(_func_0135(var_3[var_9] getvelocity()) > var_1) {
          continue;
        }
        if(istrue(var_3[var_9].b_disable_player_intersection_tracker)) {
          continue;
        }
        if(isDefined(level.player_intersection_tracker_override)) {
          if(var_3[var_8][[level.player_intersection_tracker_override]](var_3[var_9])) {
            continue;
          }
        }

        var_10 = var_3[var_8].origin;
        var_11 = var_3[var_9].origin;

        if(abs(var_10[2] - var_11[2]) > 60) {
          continue;
        }
        var_12 = distance2d(var_10, var_11);

        if(abs(var_12) > 9) {
          continue;
        }
        var_7 = scripts\cp\utility::_id_1B8C(var_7, var_3[var_8]);
        var_7 = scripts\cp\utility::_id_1B8C(var_7, var_3[var_9]);
      }
    }

    foreach(var_14 in var_7) {
      if(scripts\cp\utility::_id_88B7(var_0, var_14)) {
        if(isDefined(var_14.maxhealth) && var_14.maxhealth > 0) {
          var_15 = var_14.maxhealth / 3 + 1;
        } else {
          var_15 = 51;
        }

        if(isDefined(var_14) && isvector(var_14.origin)) {
          var_14 dodamage(var_15, var_14.origin);
        }
      }

      if(!var_2) {
        var_2 = 1;
      }
    }

    var_0 = var_7;
    wait 1;
  }
}

soak_test(var_0) {
  level.soak_testing = 1;
  level.soak_output_enabled = 1;
  level.soak_last_round = 1;
  level.soak_instance_objective_activated = 0;

  if(!isDefined(level.soak_num_commands)) {
    level.soak_num_commands = 0;
    level.soak_commands = [];
  }

  var_1 = getdvarint("#x38ce97d48ca2d52a");
  setDvar("#x34ceb1562bb393694", var_1);
  level.soak_thread = undefined;
  level thread soak_start(var_0);
}

soak_wait_for_players() {
  var_0 = undefined;

  for(;;) {
    if(isDefined(level.players)) {
      var_0 = level.players[0];
      break;
    } else
      waitframe();
  }

  return var_0;
}

soak_choose_random_portal() {
  var_0 = scripts\cp\zombies\zm_hub_portals::get_active_portals(1);
  var_1 = undefined;
  var_2 = undefined;

  if(var_0.size > 0) {
    var_2 = randomintrange(0, var_0.size);
    var_1 = var_0[var_2];
  }

  if(isDefined(var_2)) {
    soak_debug_output("Portal " + scripts\engine\utility::_id_EA52(var_2) + "/" + scripts\engine\utility::_id_EA52(var_0.size));
  } else {
    soak_debug_output("Portal undefined!!");
  }

  return var_1;
}

soak_teleport_player_to_portal(var_0, var_1) {
  if(!_func_0458(var_1)) {
    var_2 = var_0.origin;
    var_3 = var_0.angles;
    var_4 = var_1.origin;
    var_0 setorigin(var_4);
  }
}

soak_finish_objective() {
  _id_071C::zombie_complete_objective();
}

soak_activate_portal(var_0, var_1) {
  var_2 = undefined;

  foreach(var_4 in scripts\cp\zombies\zm_hub_portals::get_all_portal_structs()) {
    if(var_1.hub_portal == var_4._id_0481) {
      var_2 = var_4;
      break;
    }
  }

  var_6 = 0;

  if(isDefined(var_2)) {
    var_7 = var_1._id_82FC;

    if(isDefined(var_7)) {
      var_8 = 0;
      var_9 = var_7._id_0481 == "objective_basement_north_orb_follow" || var_7._id_0481 == "objective_apartment_top_orb_follow" || var_7._id_0481 == "objective_royal_hotel_west_orb_follow" || var_7._id_0481 == "objective_royal_hotel_clock_orb_follow";

      if(!istrue(var_8) || !istrue(var_9)) {
        var_6 = var_1 scripts\cp\zombies\zm_hub_portals::_id_AA6A(var_0);
      } else {
        var_10 = scripts\cp\zombies\zm_hub_portals::get_active_portals(1);

        if(var_10.size > 1) {
          soak_debug_output("Ignoring " + var_7._id_0481);
          wait 3;
        } else {
          soak_debug_output("No more portals active. We can't ignore " + var_7._id_0481);
          var_6 = var_1 scripts\cp\zombies\zm_hub_portals::_id_AA6A(var_0);
        }
      }
    }
  }

  return var_6;
}

soak_control() {
  for(;;) {
    wait 1;
    var_0 = 0;

    if(getdvarint("#x37170982d03990277") != 0) {
      setDvar("#x37170982d03990277", 0);
      setDvar("#x380916358d69cbd04", 0);
      setDvar("#x3e6d2f40734507049", 1);
      level.soak_testing = 0;
    } else {
      if(isDefined(level.soak_thread)) {
        if(_func_0458(level.soak_thread.portal)) {
          if(isDefined(level.soak_thread.finishing_state)) {
            if(level.soak_thread.finishing_state == 0) {
              wait 60;

              if(_func_0458(level.soak_thread.portal)) {
                if(isDefined(level.soak_thread.finishing_state)) {
                  if(level.soak_thread.finishing_state == 0) {
                    soak_debug_output("SOAK: restarting dead thread");
                    level.soak_instance_objective_activated = 0;
                    wait 5;
                    setDvar("#x380916358d69cbd04", 1);
                    var_0 = 1;
                    soak_add_command("Force Restart");
                  }
                }
              }
            }
          }
        }
      }

      var_1 = getdvarint("#x380916358d69cbd04");

      if(var_1) {
        soak_debug_output("Soak Reset");
        level.soak_testing = 0;

        if(var_0) {
          setDvar("#x3e6d2f40734507049", 1);
          setDvar("#x380916358d69cbd04", 0);
        } else {
          setDvar("#x3e6d2f40734507049", 0);
          setDvar("#x380916358d69cbd04", 0);
        }
      }
    }

    var_2 = getdvarint("#x3e6d2f40734507049");

    if(var_2 && !istrue(level.soak_testing)) {
      var_3 = getdvarint("#x328b7d3017269e4fc");
      soak_test(var_3);
    }
  }
}

soak_add_command(var_0) {
  level.soak_num_commands++;
  var_1 = scripts\engine\utility::_id_EA52(scripts\cp\utility::_id_6871()) + ": " + var_0;
  level.soak_commands[level.soak_num_commands - 1] = var_1;
  soak_debug_output(var_1);
}

soak_debug_output(var_0) {
  if(level.soak_output_enabled) {
    iprintln(var_0);
  }
}

soak_wait(var_0, var_1) {
  for(var_2 = var_1; var_2 >= 0; var_2--) {
    soak_debug_output(var_0 + ": " + scripts\engine\utility::_id_EA52(var_2));
    wait 1;
  }
}

soak_play_time(var_0, var_1) {
  switch (var_0) {
    case "holdout":
      var_2 = getdvarint("#x38ce97d48ca2d52a");
      break;
    case "soul_capture":
      var_2 = getdvarint("#x38345c39401cd12c2");
      break;
    case "orb_follow":
      var_2 = getdvarint("#x3b67a500c109f0689");
      break;
    case "exfil":
      var_2 = getdvarint("#x3cd85dcee89a20a09");
      break;
    case "domination":
      var_2 = getdvarint("#x3793c973bf39cbe0f");
      break;
    default:
      var_2 = 0;
      break;
  }

  soak_wait("playing for " + var_1, var_2);
}

soak_start(var_0) {
  soak_debug_output("Soak Start Begin");
  level.soak_thread = thisthread;
  var_1 = soak_wait_for_players();
  var_2 = 1;
  var_3 = scripts\cp\utility::_id_6871();

  while(istrue(level.soak_testing) && scripts\cp\utility::_id_6871() < var_3 + var_0 - 1) {
    soak_debug_output("Loop Begin");
    var_4 = undefined;

    if(var_2 && !isDefined(level._id_3BE9._id_0F51)) {
      var_4 = soak_choose_random_portal();
    } else {
      soak_debug_output("Not in Hub or active objective not completely finished");
      wait 1;
    }

    if(isDefined(var_4) && !_func_0458(var_4)) {
      var_5 = soak_activate_portal(var_1, var_4);
      var_6 = 0;

      if(level.soak_testing && istrue(var_5)) {
        level.soak_instance_objective_activated = 1;
        var_7 = var_4._id_82FC.target + " " + var_4._id_82FC._id_0481 + " " + var_4._id_82FC._id_FFC5 + " " + var_4._id_82FC._id_3BE5;
        var_8 = var_4._id_82FC._id_3BE5;
        var_9 = var_4._id_82FC._id_0481;
        soak_add_command("activatedPortal " + var_7);
        var_2 = 0;
        soak_debug_output("Hub Left");
        level.soak_last_round = scripts\cp\utility::_id_6871();
        soak_play_time(var_8, var_7);

        if(level.soak_testing) {
          if(var_8 != "holdout") {
            soak_finish_objective();
          }

          while(level.soak_instance_objective_activated) {
            wait 1;
          }

          var_6 = 1;
          soak_add_command("finishedObjective ");
          var_2 = 1;
          soak_debug_output("In Hub");
        }
      } else
        wait 1;

      continue;
    }

    soak_debug_output("Not in Hub yet. Portal not chosen");
    wait 1;
  }

  level.soak_testing = 0;
  setDvar("#x3e6d2f40734507049", 0);
  soak_debug_output("Soak Start End");
  setDvar("#x34ceb1562bb393694", 0);
  level.soak_thread = undefined;
}

_id_1081D() {
  while(!isDefined(level.players)) {
    wait 0.1;
  }
}

_id_11028(var_0) {
  var_0 _id_0753::_id_C702(var_0, var_0._id_BB4A);
  var_0._id_5D22 = undefined;
  var_0 setclientomnvar("zm_ui_player_in_laststand", 0);
  var_0 _meth_8078(0.3);

  if(_func_0205("deaths_door_out")) {
    var_0 playlocalsound("deaths_door_out");
  }

  if(_func_0205("deaths_door_in")) {
    var_0 _meth_83EF("deaths_door_in");
  }

  if(isDefined(level._id_1041F)) {
    var_0 thread _id_C5CE(0.2);
  }

  var_0 visionsetnakedforplayer("", 0.1);
  var_1 = randomintrange(1, 5);
  var_2 = "zmb_revive_music_lr_0" + var_1;

  if(_func_0205(var_2)) {
    var_0 playlocalsound(var_2);
  }

  if(var_0 scripts\cp\utility::_id_88B5()) {
    var_0 scripts\cp\utility::_id_1566(0);
  }
}

_id_C5CE(var_0) {
  wait(var_0);

  if(isDefined(level._id_1041F)) {
    self visionsetnakedforplayer(level._id_1041F, 0.1);
  }
}

init_zombie_map_setting() {
  var_0 = getDvar("#x36d16f02578d0ee10");

  switch (var_0) {
    case "cp_sumpf":
    case "cp_zm_oasis":
      setDvar("#x3dee089cb49164e4e", 1);
      break;
    default:
      setDvar("#x3dee089cb49164e4e", 0);
  }
}

_id_8122() {
  scripts\engine\utility::_id_5C11("insta_kill");
  scripts\engine\utility::_id_5C11("introscreen_over");
  scripts\engine\utility::_id_5C11("intro_gesture_done");
  scripts\engine\utility::_id_5C11("pre_game_over");
  scripts\engine\utility::_id_5C11("interactions_initialized");
}

_id_8123() {
  level._effect["goon_spawn_bolt"] = loadfx("vfx/iw7/_requests/coop/vfx_clown_spawn.vfx");
  level._effect["goon_spawn_bolt_underground"] = loadfx("vfx/iw7/_requests/coop/vfx_clown_spawn_indoor.vfx");
  level._effect["brute_spawn_bolt"] = loadfx("vfx/iw7/_requests/coop/vfx_brute_spawn.vfx");
  level._effect["brute_spawn_bolt_indoor"] = loadfx("vfx/iw7/_requests/coop/vfx_brute_spawn_indoor.vfx");
  level._effect["corpse_pop"] = loadfx("vfx/iw7/_requests/mp/vfx_body_expl");
  level._effect["bloody_death"] = loadfx("vfx/iw7/core/zombie/cards/vfx_zmb_card_headshot_exp.vfx");
  level._effect["gore"] = loadfx("vfx/iw7/core/impact/flesh/vfx_flesh_hit_body_meatbag_large.vfx");
  level._effect["stun_attack"] = loadfx("vfx/iw7/core/zombie/vfx_zmb_geotrail_tesla_01.vfx");
  level._effect["stun_shock"] = loadfx("vfx/iw7/core/zombie/vfx_zmb_shock_flash.vfx");
}

_id_7F15() {
  level._id_ABAD = ::_id_11039;
  level._id_ABA4 = ::_id_11038;
  level._id_AB7F = ::_id_11037;
}

_id_11039() {
  setDvar("#x3d870c876050f3466", 1);
  _id_0770::init();
  _id_074E::_id_C1E2();

  if(isDefined(level._id_33A7)) {
    [[level._id_33A7]]();
  } else {
    _id_06F0::_id_7F34();
  }

  _id_0995::init();
  _id_073B::_id_D38A(3000, 5000);
  level._id_56D9 = [];
  level._id_D28B = ::_id_D341;
  _id_074E::_id_C022();
  level._id_430D = 20;
  scripts\cp\utility::_id_1450();
  _id_06EF::_id_5A9A();
  _id_0987::_id_5A9A();
  _id_095C::_id_C287(::_id_B674);
  level thread _id_098A::_id_F028();
  _id_092E::init();
  _id_073D::init();
  _id_070C::init();

  if(scripts\cp\utility::_id_3D1D("pillage")) {
    thread _id_09A0::_id_B0BF();
  }

  level thread _id_7404();
  level thread _id_C7CD();
  level._id_FD0F = ::_id_FD0E;
  level scripts\engine\utility::delaythread(0.2, _id_0999::_id_8121);
  scripts\cp\zombies\perks\zm_perks::init();
  _id_0949::_id_8124();
  thread _id_0981::_id_7F2F();

  if(isDefined(level._id_E242)) {
    level thread[[level._id_E242]]();
  }

  _id_0993::init();
  _id_099C::_id_E636();
  level thread _id_7F71();
  level thread _id_0737::init();
  level thread _id_0998::_id_8120();
  level thread _id_099B::_id_806F();
  level thread _id_06FA::init_achievements();
  level thread _id_FF39();

  if(scripts\cp\utility::_id_3D1D("wall_buys")) {
    level thread _id_0770::_id_1D12();
  } else {
    _id_0737::_id_4A68();
  }

  if(isDefined(level._id_D7F5)) {
    level[[level._id_D7F5]]();
  } else {
    _id_D7F4();
  }

  level thread _id_C5FA();
  level thread reset_zombie_emissive();
  level thread scripts\aitypes\zombie_common\ai_util::_id_5A9A();
}

_id_B674(var_0, var_1) {
  if(var_0 == "bink_complete") {
    self notify("bink_complete");
  }
}

_id_D7F4() {
  level._id_AC5A = [];
}

_id_7F71() {
  _id_09A3::_id_11050();
  _id_09A4::_id_53E6();
}

_id_C5FA() {
  level endon("game_ended");

  for(;;) {
    level waittill("wave_starting");

    foreach(var_1 in level.players) {
      var_1._id_30CC = 1;
    }
  }
}

reset_zombie_emissive() {
  level endon("game_ended");
  scripts\engine\utility::_id_5C24("introscreen_over");
  reenable_zombie_emissive();
}

_id_11037() {}

_id_11038(var_0) {
  _id_ABA4();
  thread _id_09A5::_id_1101B();
}

_id_7404() {
  wait 5;
  level notify("spawn_nondeterministic_entities");

  if(isDefined(level._id_BA38)) {
    level thread[[level._id_BA38]]();
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isDefined(level._id_E3C0)) {
      level._id_E3C0 = 0;
    }

    var_0 thread watchthrowingweaponusage();

    if(!isai(var_0)) {
      var_0 _id_0705::_id_AA5D();
      var_0 _meth_867F("cp_default_mix", 0, 1);
      var_0 thread _id_10B25(var_0);

      if(isDefined(var_0._id_3B86)) {
        var_0._id_3B7F = var_0._id_3B86;
      } else {
        var_0._id_3B7F = gettime();
      }

      if(scripts\cp\utility::_id_3D1D("outline")) {
        var_0 thread _id_074A::_id_ACBC();
      }

      var_0._id_10FD9 = getdvarint("#x38b8293622375bc2e");
      var_0._id_10DEF = getdvarint("#x31ad1fea7dfa1f60a");

      if(var_0 scripts\cp\utility::rankingenabled()) {
        var_1 = getdvarint("#x3557cab9e43791d7f");
        var_2 = getdvarint("#x3e07a5858344e09c8");
        var_3 = var_0 getprivatepartysize() > 1;

        if(isDefined(var_1)) {
          if(var_3 && var_1 > 1) {
            var_0._id_10DEF = var_1;
          }
        }

        if(isDefined(var_2)) {
          if(var_3 && var_2 > 1) {
            var_0._id_10FD9 = var_2;
          }
        }
      }

      var_0 thread _id_072E::_id_B4FD();
      var_0 _id_072C::_id_8064();
      var_0 _id_074E::_id_D12A();
      var_0 _id_075A::_id_826C();
      var_0 scripts\cp\cp_sacrificial_heart::initplayersacrificialheart();
      var_0._id_A759 = [];
      var_0._id_A491 = 0;
      var_0._id_F35F = 0;
      var_0._id_30CC = 1;

      if(!isDefined(var_0._id_AE0A)) {
        var_0._id_AE0A = [];
      }

      if(!isDefined(var_0._id_BB26)) {
        var_0._id_BB26 = [];
      }

      if(!isDefined(var_0._id_BADE)) {
        var_0._id_BADE = [];
      }

      if(!isDefined(var_0._id_BADF)) {
        var_0._id_BADF = [];
      }

      if(!isDefined(var_0._id_4A8B)) {
        var_0._id_4A8B = [];
      }

      if(!isDefined(var_0._id_AB1B)) {
        var_0._id_AB1B = [];
      }

      if(!isDefined(var_0._id_ABD5)) {
        var_0._id_ABD5 = [];
      }

      if(!isDefined(var_0._id_AAA1)) {
        var_0._id_AAA1 = [];
      }

      var_0 thread _id_1103B();
      var_0._id_4AAD = 0;
      var_0._id_4A9F = 0;
      var_0 scripts\cp\utility::_id_156C(0);
      var_0._id_BA9B = 0;
      var_0._id_F1DC = 0;
      var_0._id_F201 = gettime();
      var_0._id_D080 = 0;
      var_0._id_9C31 = 3;
      var_0._id_32FF = 1;
      var_0._id_C0F3 = 0;
      var_0.enabledignoreme = 0;
      var_0._id_7E8C = 0;
      var_0 _id_0994::_id_80B2(var_0);

      if(scripts\engine\utility::_id_5C00("introscreen_over")) {
        if(isDefined(level._id_425A)) {
          var_0 thread[[level._id_425A]]();
        } else {
          var_0 thread _id_B4E1();
        }

        if(_id_06F0::_id_4159() && scripts\cp\utility::_id_3D1D("challenge")) {
          if(isDefined(level._id_33A6)) {
            var_0 thread[[level._id_33A6]]();
          }
        }
      }

      var_0 _id_0994::_id_B4FA(var_0);
      var_0 _id_074E::_id_911C("waveNum", level._id_10C9F, 1);
      var_0 _id_0980::_id_B4F9(var_0);
      var_0 _id_0770::_id_D80A(var_0);
      var_0 _id_074E::_id_B576();
      var_0 thread _id_0995::_id_8111(var_0);
      var_0 thread _id_EA21(var_0);

      if(isDefined(level._id_4257)) {
        [[level._id_4257]](var_0);
      }

      if(getdvarint("#x3f098ca0f028b08b", 0) != 1 && getdvarint("#x32cca64f8f4e7c65b") == 0) {
        if(!isDefined(level._id_8CDE)) {
          level thread _id_8CDF();
        }

        var_0 thread _id_8CDD(var_0);
      }

      if(!getdvarint("#x3eef4e390f811e19", 0)) {
        var_0 thread _id_072E::_id_AC0E();
        var_0 notify("open_loadout_menu");
      }
    }
  }
}

_id_10B25(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("weaponplayerdatafinished");
  var_1 = "cp/cp_wall_buy_models.csv";

  if(scripts\cp\utility::_id_9A9E(3)) {
    var_1 = "cp/cp_town_wall_buy_models.csv";
  } else if(scripts\cp\utility::_id_9A9E(2)) {
    var_1 = "cp/cp_disco_wall_buy_models.csv";
  }

  for(;;) {
    var_0 waittill("luinotifyserver", var_2, var_3);

    if(isDefined(var_2)) {
      if(var_2 == "reset_weapon_player_data") {
        var_4 = tablelookupbyrow(var_1, var_3, 1);

        if(isDefined(var_4)) {
          var_5 = _func_0222(var_1, 0, var_3, 2);

          if(isDefined(var_5) && var_5 != "") {
            var_0 setplayerdata("cp", "zombiePlayerLoadout", "zombiePlayerWeaponModels", var_5, "variantID", -1);
          }
        }

        continue;
      }

      if(var_2 == "weaponplayerdatafinished") {
        var_0 notify("weaponplayerdatafinished");
      }
    }
  }
}

_id_EA21(var_0) {
  var_0 endon("disconnect");
  var_0 endon("kill_weapon_stream");
  level endon("game_ended");
  var_0 scripts\engine\utility::_id_108A7(10, "player_spawned");
  scripts\engine\utility::_id_5C24("wall_buy_setup_done");
  var_1 = [];
  var_2 = scripts\engine\utility::getStructArray("interaction", "targetname");

  foreach(var_4 in var_2) {
    if(isDefined(var_4._id_FFC5) && var_4._id_FFC5 == "wall_buy") {
      var_1[var_1.size] = var_4;
    }
  }

  var_6 = 1;

  for(;;) {
    var_7 = 0;
    var_8 = 0;
    var_9 = [self._id_8F65];

    for(var_10 = scripts\engine\utility::_id_6369(var_0.origin, var_1, undefined, 10, 5000, 0); var_7 <= var_6 && var_8 < var_10.size; var_8++) {
      var_11 = scripts\cp\utility::_id_6CE3(var_10[var_8]._id_039B);

      if(isDefined(var_0._id_10CEA[var_11])) {
        var_12 = var_0._id_10CEA[var_11];
      } else {
        var_12 = var_10[var_8]._id_039B;
      }

      var_9[var_9.size] = makeweaponfromstring(var_12);
      var_9 = scripts\engine\utility::_id_1BC1(var_9);
      var_7 = var_9.size;
    }

    var_9 = scripts\engine\utility::_id_1BD1(var_9);

    if(var_9.size) {
      var_0 loadweaponsforplayer(var_9);
    }

    wait 1;
  }
}

_id_B4E1() {
  self endon("disconnect");
  self notify("intro_done");
  self notify("stop_intro");
  self waittill("spawned");

  if(!istrue(self.is_rbz_hot_join)) {
    thread _id_7ABA();
  }

  self.pers["hotjoined"] = 1;

  if(isDefined(level._id_10C9F)) {
    self._id_10CA1 = level._id_10C9F;
  }

  var_0 = getDvar("#x36d16f02578d0ee10");

  if(var_0 == "cp_rave") {
    _func_0055("pa_speaker_stage_2");
    _func_0055("pa_speaker_path");

    if(!istrue(level._id_DDE0)) {
      _func_0055("pa_super_slasher");
    }
  }

  if(var_0 == "cp_disco") {
    if(istrue(level._id_C04B)) {
      _func_0055("pa_punk_alley_1");
      _func_0055("pa_punk_subway_1");
      _func_0055("pa_punk_subway_2");
      _func_0055("pa_punk_rooftops_2");
      _func_0055("pa_punk_rooftops_3");
      _func_0055("pa_disco_street_1");
      _func_0055("pa_disco_street_3");
      _func_0055("pa_disco_subway_2");
      _func_0055("pa_disco_subway_1");
      _func_0055("pa_park_1");
    } else {
      _func_0055("pa_punk_alley_1");
      _func_0055("pa_punk_subway_1");
      _func_0055("pa_punk_subway_2");
      _func_0055("pa_punk_rooftops_2");
      _func_0055("pa_punk_rooftops_3");
      _func_0055("pa_disco_street_1");
      _func_0055("pa_disco_street_3");
      _func_0055("pa_disco_subway_2");
      _func_0055("pa_disco_subway_1");
      _func_0055("pa_park_1");
      _func_0055("pa_disco_club");
      _func_0055("pa_punk_club");
      _func_0055("pa_rk_arena");
    }
  }

  if(isDefined(self._id_84DB)) {
    self._id_84DB.alpha = 1;
    wait 3;
    self._id_84DB fadeovertime(3);
    self._id_84DB.alpha = 0;
    wait 3;

    if(isDefined(self._id_84DB)) {
      self._id_84DB destroy();
    }
  }

  self setclientomnvar("ui_hide_hud", 0);
  self._id_C0DD = 0;
  wait 3;
  _id_0981::_id_805A();
  _id_0994::_id_80B2(self);

  if(getDvar("#x3a30c33efc8281eb1") == "zombie") {}

  if(isDefined(level._id_33F4)) {
    self[[level._id_33F4]]();
  }

  level thread reenable_zombie_emissive();
}

reenable_zombie_emissive() {
  var_0 = _id_07F7::_id_68A1("axis");

  foreach(var_2 in var_0) {
    if(istrue(var_2._id_86D9)) {
      continue;
    } else if(istrue(var_2._id_86F2)) {
      continue;
    }
    var_2 _meth_80C6(0.1, 1);
    wait 0.05;
  }
}

_id_7ABA() {
  self endon("disconnect");
  self.ignoreme = 1;
  self._id_0E05 = 1;
  wait 8;
  self.ignoreme = 0;
  self._id_0E05 = undefined;
}

_id_ABA4() {
  self.pers["gamemodeLoadout"] = level._id_1452;
  self setclientomnvar("ui_refresh_hud", 1);
  self._id_4F4F = 1.0;
  self._id_5B8E = 0;
  self._id_8A07 = 0;
  self._id_89FE = 0;
  self._id_87A7 = 0;
  self._id_8789 = undefined;
  self._id_8893 = undefined;
  self._id_2D86 = undefined;
  self._id_D9E5 = undefined;
  self._id_B39F = undefined;
  self._id_A536 = 0;
  self._id_A521 = 0;
  self._id_4AAD = 0;
  self._id_4A9F = 0;
  self._id_30FD = 1;
  self.enabledignoreme = 0;
  self.ignoreme = 0;
  self._id_78DC = 1;
  self._id_5D22 = undefined;
  self._id_85F4 = 0;
  self._id_7521 = 0;
  self._id_9000 = gettime();
  self._id_901A = gettime();
  self._id_0358 = _func_00E0();
  self.killswithoutgettinghit = 0;
  self.killswithoutgettinghit_ar = 0;
  self._id_2D30 = 0;
  self.explosivekillsinaframecount = 0;
  self.recentscoreeventkills = [];
  self setclientomnvar("zm_ui_player_in_laststand", 0);
  _id_8267();
  thread _id_0948::_id_10AB2();

  if(isDefined(level._id_4258)) {
    self[[level._id_4258]]();
  }

  _id_072E::_id_B4FE();
  _id_072E::_id_B4FB();
  var_0 = _id_6788(self);
  thread _id_074E::_id_107B7(var_0);
  _id_D341(999999);

  if(getdvarint("#x3dee089cb49164e4e", 0) == 1) {
    if(istrue(self.needinitializeheart)) {
      thread scripts\cp\zombies\zm_rbz_utility::wait_to_set_player_starting_heart();
    }

    thread scripts\cp\zombies\zm_rbz_utility::wait_to_set_player_starting_salvage();
  }

  thread _id_10B6C();
  thread scripts\cp\utility::_id_B6D4();
  thread _id_09A4::_id_B54C();
  thread _id_FBAE();
  thread scripts\cp\cp_hud_util::_id_11014();
  thread _id_0993::_id_10D25();
  thread _id_0993::_id_1FD5();

  if(isDefined(level._id_8CAD)) {
    thread[[level._id_8CAD]]();
  }

  if(getDvar("#x36d16f02578d0ee10") == "cp_zmb") {
    thread _id_84FE();
  }

  thread _id_100B();
  thread scripts\cp\cp_weapon::_id_10C32();
  thread scripts\cp\cp_weapon::_id_10C2B();
  thread scripts\cp\cp_weapon::_id_10C2D();

  if(scripts\cp\utility::_id_89AE() || level._id_AB30) {
    thread scripts\cp\cp_hud_message::_id_80EA();
  }

  if(isDefined(self._id_1772)) {
    self._id_1772 delete();
  }

  scripts\cp\utility::_id_5E70();
}

watchthrowingweaponusage() {
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    watchthrowingweaponthrows();
  }
}

watchthrowingweaponthrows() {
  var_0 = scripts\cp_mp\utility\throwing_weapon::_id_108DD();

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0.weapon_name)) {
    return;
  }
  if(scripts\cp\utility::_id_8774(var_0.weapon_name)) {
    var_0 thread scripts\cp_mp\utility\throwing_weapon::_id_10B6D(self);
    return;
  }
}

_id_8267() {
  self setclientomnvar("zombie_arcade_game_time", -1);
  self setclientomnvar("zombie_arcade_game_ticket_earned", 0);
}

_id_100B() {
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    if(self == level.players[var_0]) {
      var_1 = var_0 + 1;

      if(var_1 == 5) {
        return;
      }
      self _meth_8390("player" + var_1);
    }
  }
}

_id_96A6(var_0) {
  var_1 = [];

  if(isDefined(var_0._id_034C)) {
    var_1[var_1.size] = var_0._id_034C;
  }

  if(isDefined(var_0._id_03B5)) {
    var_1[var_1.size] = var_0._id_03B5;
  }

  if(var_1.size > 0) {
    self loadweaponsforplayer(var_1);
  }
}

_id_6788(var_0) {
  var_1 = var_0._id_E6BF;

  if(isDefined(var_1)) {
    var_0._id_E6BF = undefined;
    return var_1;
  } else if(isDefined(level.get_rbz_starting_currency))
    return [[level.get_rbz_starting_currency]]();
  else {
    return _id_074E::_id_6788();
  }
}

_id_D341(var_0) {
  var_0 = int(var_0);
  self._id_9C61 = var_0;
}

_id_FBAE() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("faux_spawn");
  self endon("game_ended");

  for(;;) {
    scripts\cp\utility::_id_FCF9();
    wait 0.1;
  }
}

_id_C554() {
  level endon("game_ended");

  foreach(var_1 in level.players) {
    thread _id_C555(var_1);
  }
}

_id_C555(var_0) {
  if(istrue(var_0._id_8E55)) {
    var_0._id_C191 = 1;
    return;
  }

  var_1 = getarraykeys(var_0._id_BADE);

  foreach(var_3 in var_1) {
    if(var_0._id_BADE[var_3]._id_DDEF == "secondary") {
      continue;
    }
    if(_id_073B::_id_B4EF(var_0)) {
      var_0 thread _id_10721();
      continue;
    }

    var_0 thread scripts\cp\utility::_id_C107(var_3);
  }

  if(isDefined(var_0._id_BB37) && isDefined(var_0._id_BB38)) {
    var_0._id_BB38 = level._id_BADE[var_0._id_BB37]._id_9C5C;
  }
}

_id_10721() {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("spawned_player");
  wait 1.0;
  var_0 = getarraykeys(self._id_BADE);

  if(var_0.size < 1) {
    return;
  }
  foreach(var_2 in var_0) {
    if(self._id_BADE[var_2]._id_DDEF == "secondary") {
      continue;
    }
    thread scripts\cp\utility::_id_C107(var_2);
  }
}

_id_C7CD() {
  level endon("game_ended");

  for(;;) {
    level waittill("spawn_wave_done");

    foreach(var_1 in level.players) {
      if(_id_073B::_id_B4EF(var_1)) {
        _id_073B::_id_8302(var_1);
      }
    }
  }
}

_id_11041(var_0) {
  var_1 = var_0 _id_074E::_id_666A();
  var_2 = var_0 _id_074E::_id_6788();
  var_0._id_E6BF = max(var_1, var_2);
  var_0 scripts\cp\zombies\perks\zm_perks::remove_all_perks();
  _id_C7C1(var_0);
  _id_D3B1(var_0);
  _id_ED83(var_0);
  _id_0994::_id_F70B(var_0);
}

_id_C7C1(var_0) {
  var_0 scripts\cp\utility::_id_3918();
  var_1 = var_0._id_458F;
  var_2 = weaponclipsize(var_1);
  var_3 = weaponmaxammo(var_1);
  var_4 = makeweapon("super_default_zm");
  var_5 = weaponclipsize(var_4);
  var_6 = weaponmaxammo(var_4);
  var_7 = [];
  var_8 = [];
  var_9 = [];
  var_7[var_7.size] = var_1;
  var_8[var_0._id_458F.basename] = var_2;
  var_9[var_0._id_458F.basename] = var_3;
  var_7[var_7.size] = var_4;
  var_8["super_default_zm"] = var_5;
  var_9["super_default_zm"] = var_6;
  var_0 scripts\cp\utility::_id_1063(var_7, var_8, var_9, var_1);
  var_0._id_BB4B = var_1;
  var_0._id_BB4D = var_3;
  var_0._id_BB4C = var_2;
  var_0._id_90C6 = var_1;
}

_id_D3B1(var_0) {
  var_1 = _id_1102A(var_0);
  var_0._id_5EC7 = var_1.origin;
  var_0._id_5EC2 = var_1.angles;
}

_id_1102A(var_0) {
  if(isDefined(level._id_5E68)) {
    return [[level._id_5E68]](var_0);
  }

  if(!isDefined(level._id_0F26) || level._id_0F26.size == 0 || level.players.size == 0) {
    return [[level._id_6D4A]]();
  }

  if(isDefined(level._id_C682)) {
    return [[level._id_C682]](var_0);
  }

  var_1 = _id_6379(var_0);
  var_2 = _id_637A(var_1);

  if(var_2.size == 0) {
    return _id_66FF(var_0, var_1);
  }

  if(var_2.size == 1) {
    return var_2[0];
  }

  return var_0 _id_6700(var_1, var_2);
}

_id_6379(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_3 == var_0) {
      continue;
    }
    if(_id_073B::_id_B4EF(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_637A(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_0F26) {
    if(!_func_0034(var_3.origin)) {
      continue;
    }
    if(_func_01A5(var_3.origin)) {
      continue;
    }
    if(_id_869F(var_3, var_0)) {
      continue;
    }
    if(_id_869E(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_869F(var_0, var_1) {
  var_2 = 250000;

  foreach(var_4 in var_1) {
    if(distancesquared(var_4.origin, var_0.origin) < var_2) {
      return 1;
    }
  }

  return 0;
}

_id_869E(var_0) {
  var_1 = 250000;
  var_2 = _id_07F7::_id_68A1("axis");

  foreach(var_4 in var_2) {
    if(distancesquared(var_4.origin, var_0.origin) < var_1) {
      return 1;
    }
  }

  return 0;
}

_id_66FF(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;

  foreach(var_7 in var_1) {
    var_2 = var_2 + var_7.origin[0];
    var_3 = var_3 + var_7.origin[1];
    var_4 = var_4 + var_7.origin[2];
    var_5++;
  }

  var_9 = (var_2 / var_5, var_3 / var_5, var_4 / var_5);
  var_10 = _func_0204(level._id_0F26, var_9);
  return var_10[0];
}

_id_6700(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(var_0.size == 0, 1, var_0.size);
  var_3 = level._id_E2A4.size / var_2;
  var_4 = var_3 * 2;
  var_5 = -99999999;
  var_6 = undefined;

  foreach(var_8 in var_1) {
    var_9 = 0;

    foreach(var_11 in var_0) {
      if(var_11 == self) {
        continue;
      }
      if(!isalive(var_11)) {
        continue;
      }
      if(istrue(var_11.inlaststand)) {
        var_9 = var_9 - distancesquared(var_11.origin, var_8.origin) * (var_4 * 2);
        continue;
      }

      var_9 = var_9 - distancesquared(var_11.origin, var_8.origin) * var_4;
    }

    foreach(var_14 in level._id_E2A4) {
      var_9 = var_9 + distancesquared(var_14.origin, var_8.origin);
    }

    var_9 = var_9 / 1000000;

    if(var_9 > var_5) {
      var_5 = var_9;
      var_6 = var_8;
    }
  }

  return var_6;
}

_id_ED83(var_0) {
  var_0._id_E3B8 = undefined;
}

_id_45A0() {
  var_0 = 0;

  if(!istrue(level._id_84DA)) {
    var_0 = 10;
  }

  if(istrue(game["gamestarted"])) {
    var_0 = 0;
  }

  if(var_0 > 0) {
    var_1 = level _id_1070E();
    _func_01E3("match_start");
    level thread _id_DC52();

    if(!scripts\cp\utility::_id_8941() && isDefined(level._id_8450)) {
      level thread[[level._id_8450]]();
    }

    wait(var_0 - 3);

    if(isDefined(level._id_BA4F)) {
      [[level._id_BA4F]]();
    }

    scripts\engine\utility::_id_5C1B("introscreen_over");
    level._id_84DA = 1;
  } else {
    wait 1;
    level._id_84DA = 1;
    scripts\engine\utility::_id_5C1B("introscreen_over");
  }

  if(istrue(level._id_023E)) {
    return;
  }
}

_id_DC52() {
  if(scripts\cp\utility::_id_8941()) {
    return;
  }
  if(isDefined(level._id_84DC)) {
    [[level._id_84DC]]();
  }
}

_id_1070E() {
  var_0 = undefined;

  if(level.players.size == 0) {
    level waittill("connected", var_0);
  } else {
    var_0 = level.players[0];
  }

  return var_0;
}

watch_stop_intro() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("end_watch_stop_intro");
  self waittill("stop_intro");
  self setclientomnvar("ui_hide_hud", 0);
}

_id_1103B() {
  self endon("disconnect");
  self endon("stop_intro");
  thread watch_stop_intro();
  self setclientomnvar("ui_hide_hud", 1);
  self disableweapons();
  self._id_84DB = newclienthudelem(self);
  self._id_84DB.x = 0;
  self._id_84DB.y = 0;
  self._id_84DB setshader("black", 640, 480);
  self._id_84DB.alignx = "left";
  self._id_84DB.aligny = "top";
  self._id_84DB.sort = 1;
  self._id_84DB.horzalign = "fullscreen";
  self._id_84DB.vertalign = "fullscreen";
  self._id_84DB.alpha = 1;
  self._id_84DB._id_01D6 = 1;

  if(!scripts\engine\utility::_id_5C00("introscreen_over")) {
    scripts\engine\utility::_id_5C24("introscreen_over");
  }

  self._id_84DB fadeovertime(2);
  self._id_84DB.alpha = 0;
  var_0 = 2.0;
  var_1 = getDvar("#x36d16f02578d0ee10");

  if(var_1 == "cp_town" && !self _meth_81E2()) {
    wait 2.0;
    self setclientomnvar("zm_ui_dialpad_9", 1);
    var_0 = 4.0;
  }

  wait(var_0);
  self setclientomnvar("ui_hide_hud", 0);

  if(isDefined(level._id_33F5)) {
    self thread[[level._id_33F5]]();
  }

  if(var_1 != "cp_town") {
    wait 1.5;
  }

  scripts\cp\cp_destinations::wait_for_current_destination_to_load();
  self._id_84DB destroy();

  if(var_1 != "cp_town") {
    _id_B30C();
  }

  scripts\engine\utility::_id_5C1B("intro_gesture_done");
  _id_0981::_id_805A();
  self setclientomnvar("ui_hide_hud", 0);
  self notify("end_watch_stop_intro");
  wait 3.0;

  if(isDefined(level._id_33F4)) {
    self[[level._id_33F4]]();
  }

  wait 1.5;
  scripts\cp\utility::_id_5F63(0);
  self enableweapons();
}

_id_B30C() {
  self setweaponammostock("iw7_walkietalkie_zm", 1);
  self _meth_852A("iw7_walkietalkie_zm");
}

_id_9D5B() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("shock_melee_upgrade activated");
  self._id_9DA8 = 1.0;
  var_0 = 1;
  self._id_9DA8 = 0;
  var_1 = gettime();

  for(;;) {
    var_2 = gettime();

    if(var_2 - var_1 >= level._id_B71B) {
      self._id_9DA8 = 1.0;
    } else {
      self._id_9DA8 = 0;
    }

    if(self meleeButtonPressed() && !self _meth_81E0() && !self useButtonPressed()) {
      var_1 = gettime();

      if(var_0 == 1) {
        var_0 = 0;
      }
    } else if(!self meleeButtonPressed())
      var_0 = 1;
    else {
      var_0 = 0;
    }

    wait 0.05;
  }
}

_id_7568() {
  var_0 = 0;
  var_1 = self _meth_8191("primary");

  if(var_1.size > 0) {
    foreach(var_3 in var_1) {
      if(_id_887E(var_3)) {
        var_0 = 1;
        break;
      }
    }
  }

  return var_0;
}

_id_887E(var_0) {
  var_1 = getweaponbasename(var_0);

  if(!isDefined(var_1)) {
    return 0;
  }

  return var_1 == "iw7_glprox_zm";
}

_id_10B6C() {
  self endon("death");
  self endon("disconnect");
  self endon("endExpJump");
  level endon("game_ended");
  var_0 = undefined;
  self notifyonplayercommand("fired", "+attack");

  for(;;) {
    scripts\engine\utility::waittill_any_3("weapon_switch_started", "weapon_change", "weaponchange");
    self notify("stop_regen_on_weapons");
    wait 0.1;
    var_1 = self getweaponslistall();

    foreach(var_3 in var_1) {
      if(_id_887E(var_3)) {
        var_0 = 1;
        continue;
      }

      var_0 = 0;
    }
  }
}

_id_1102F(var_0) {
  var_1 = var_0 _id_074E::_id_666A();
  var_1 = var_1 * 0.05;
  var_1 = int(var_1 / 10) * 10;
  return var_1;
}

_id_1101C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  _id_0995::_id_9742(self, var_8);
  [[level._id_2F50]](var_0, var_1, var_2, var_4, var_5, var_7, var_8, var_9);
}

_id_1458() {}

_id_AA4B(var_0) {}

_id_48D6() {
  if(getdvarint("#x3aad18271ed99bff2", 0) == 1) {
    setomnvar("zm_dev_damage", 1);
  } else {
    setomnvar("zm_dev_damage", 0);
  }
}

_id_BB6A() {
  var_0 = " LB_" + getDvar("#x36d16f02578d0ee10");

  if(scripts\cp\utility::_id_89AE()) {
    var_0 = var_0 + "_SOLO";
  } else {
    var_0 = var_0 + "_COOP";
  }

  _func_01AA(var_0);
}

_id_11027(var_0, var_1) {
  var_0 _id_074E::_id_5530("downs", 1);
  var_0._id_BB34 = undefined;
  var_0._id_BB35 = undefined;
  var_0._id_BB36 = undefined;
  var_0._id_5F02 = undefined;
  var_0._id_BB4A = var_0 _id_0753::_id_6511(var_0);
  var_0 _id_0753::_id_396F();
  var_2 = var_0 getcurrentweapon();
  var_3 = getweaponbasename(var_2);
  var_4 = var_0 getcurrentweaponclipammo();

  if(!isDefined(var_0._id_4EB5[var_3])) {
    var_0._id_4EB5[var_3] = 1;
  } else {
    var_0._id_4EB5[var_3]++;
  }

  var_0 _meth_8078(0);

  if(!self _meth_81E2()) {
    var_0 _meth_82FD("last_stand_cp", 0.02, "mix", "reverb", "filter");
  }

  if(var_0 _id_751A()) {
    var_5 = (scripts\cp\utility::_id_89AE() || level._id_AB30) && var_0 scripts\cp\utility::_id_7531("perk_machine_revive");
    var_0 notify("player_has_self_revive", var_5);
  }

  if(isDefined(var_0._id_A2EF) && !istrue(var_0._id_B858)) {
    var_0._id_5F02 = var_0._id_A2EF;
  } else {
    var_0._id_5F02 = undefined;
  }

  _id_0995::_id_9721(1, var_0, var_2, var_4, var_0._id_C0E8, var_0.origin, level._id_10C9F, var_0._id_0267);
  var_0 _id_099D::_id_97AA();
  var_0 scripts\cp\utility::_id_1566(1);
  var_0 setclientomnvar("zm_ui_player_in_laststand", 1);
  var_0 _meth_82F8("player_damaged", 2, 0);

  if(isDefined(level._id_3BE9._id_0F51) && scripts\engine\utility::is_equal(level._id_3BE9._id_0F51._id_3BE5, "holdout")) {
    level.holdoutperfectdefense = 0;
  }
}

_id_84FE() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  var_0 = 0;
  var_1 = 1;

  if(!scripts\cp\utility::_id_857B()) {
    while(var_0 < 3) {
      level waittill("spawn_wave_done");

      if(0 == var_1 % 2 && var_1 > 1) {
        foreach(var_3 in level.players) {
          var_3 setclientomnvar("zm_nag_text", 1);
        }

        var_0 = var_0 + 1;
      }

      var_1 = var_1 + 1;
      wait 0.5;

      foreach(var_3 in level.players) {
        var_3 setclientomnvar("zm_nag_text", 0);
      }
    }
  }
}

_id_1102D() {
  _id_0994::_id_C1EF();
  _id_074D::_id_C1EF();
  _id_099B::_id_C1EF();
  _id_0983::_id_C1EF();
  _id_0980::_id_C1EF();
  _id_073E::_id_C1EF();
  level thread _id_0770::_id_C1EF();
  _id_0703::_id_C1EF();

  if(!istrue(level.disable_hud_portal)) {
    scripts\cp\zombies\zm_hub_portals::_id_C1EF();
  }

  _id_0717::_id_C1EF();
  _id_0989::_id_C1EF();
  scripts\cp\cp_audio_log::_id_C1EF();
  scripts\cp\cp_tome_of_rituals::_id_C1EF();
  scripts\cp\doorbuy::_id_C1EF();
}

_id_FD0E(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("updateRecentKills");
  self endon("updateRecentKills");
  self._id_C0F3++;
  var_2 = var_1.basename;

  if(var_1.basename == "zmb_fireworksprojectile_mp") {
    if(!isDefined(self._id_8DF0[self._id_8B3D])) {
      self._id_8DF0[self._id_8B3D] = 1;
    } else {
      self._id_8DF0[self._id_8B3D]++;
    }
  }

  if(!isDefined(self._id_8DA4[var_2])) {
    self._id_8DA4[var_2] = 1;
  } else {
    self._id_8DA4[var_2]++;
  }

  if(!isDefined(self._id_C0F4)) {
    self._id_C0F4 = [];
  }

  if(!isDefined(self._id_C0F4[var_2])) {
    self._id_C0F4[var_2] = 1;
  } else {
    self._id_C0F4[var_2]++;
  }

  var_3 = scripts\cp\utility::_id_6A18(var_2);
  wait 1.25;
  self._id_C0F3 = 0;
  self._id_C0F4 = undefined;
}

_id_E8AF() {
  level endon("game_ended");

  for(;;) {
    level waittill("regular_wave_starting");

    if(level._id_10C9F >= 6) {
      break;
    }
  }

  _func_01E7(1);
}

_id_11036(var_0, var_1) {
  _id_074E::_id_5534(var_0);
  _id_073C::_id_C2F4(var_0);
}

_id_11070() {
  var_0 = _id_07F7::_id_68A1("axis");

  foreach(var_2 in var_0) {
    var_3 = isDefined(var_2._id_1210) && (var_2._id_1210 == "zombie_brute" || var_2._id_1210 == "zombie_grey" || var_2._id_1210 == "superslasher" || var_2._id_1210 == "slasher" || var_2._id_1210 == "zombie_ghost");

    if(!var_3 && !var_2 scripts\cp\utility::_id_1217()) {
      if(istrue(var_2._id_CF4A)) {
        var_2._id_4982 = 1;
        var_2 suicide();
        continue;
      }

      if(istrue(var_2.ignoreme)) {
        var_2._id_4982 = 1;
        var_2 suicide();
        continue;
      }

      if(istrue(var_2._id_0229)) {
        var_2._id_4982 = 1;
        var_2 suicide();
        continue;
      }

      if(!istrue(var_2._id_54D1)) {
        var_2._id_4982 = 1;
        var_2 suicide();
        continue;
      }
    }

    var_2._id_CF4A = 1;
    var_2 _meth_8326(var_2.origin);
    var_2.ignoreme = 1;
    var_2._id_0229 = 1;
  }
}

_id_1106F() {
  reenable_zombie_emissive();
  thread _id_C630();
  var_0 = _id_07F7::_id_68A1("axis");

  foreach(var_2 in var_0) {
    var_2._id_CF4A = 0;
    var_2.ignoreme = 0;
    var_2._id_0229 = 0;
  }

  if(isDefined(level._id_4272)) {
    level thread[[level._id_4272]]();
  }
}

_id_C630() {
  level endon("game_ended");

  foreach(var_1 in level.players) {
    wait 0.1;
    wait 0.1;

    if(istrue(var_1._id_4525)) {} else {}

    wait 0.1;
  }
}

_id_FF39() {
  level endon("game_ended");
  scripts\engine\utility::_id_5C24("introscreen_over");
  var_0 = scripts\engine\utility::getStructArray("interaction", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_039B) && issubstr(var_2._id_039B, "debris")) {
      var_3 = getEntArray(var_2.target, "targetname");

      if(var_3.size < 2) {}
    }
  }
}

check_for_input() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("inputReceived");
    self.input_received_since_last_check = 1;
  }
}

get_inactivity_timeout_ms(var_0) {
  if(var_0 _meth_886E()) {
    return getdvarint("#x3e10174086b65e381") * 1000;
  } else {
    return getdvarint("#x3e5cdfb67371cb772") * 1000;
  }
}

_id_8CDD(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0.input_received_since_last_check = 0;
  var_1 = gettime() + get_inactivity_timeout_ms(var_0);
  var_2 = level.onlinegame && !getdvarint("#x310c28bb5d64c8c6d") || isdedicatedserver();

  if(var_2) {
    var_0 thread check_for_stick_or_pause_change();
    var_0 thread check_for_input();
    var_0 notifyonplayercommand("inputReceived", "+speed_throw");
    var_0 notifyonplayercommand("inputReceived", "+stance");
    var_0 notifyonplayercommand("inputReceived", "+goStand");
    var_0 notifyonplayercommand("inputReceived", "+usereload");
    var_0 notifyonplayercommand("inputReceived", "+activate");
    var_0 notifyonplayercommand("inputReceived", "+melee_zoom");
    var_0 notifyonplayercommand("inputReceived", "+breath_sprint");
    var_0 notifyonplayercommand("inputReceived", "+attack");
    var_0 notifyonplayercommand("inputReceived", "+frag");
    var_0 notifyonplayercommand("inputReceived", "+smoke");
    var_3 = 0.1;

    for(;;) {
      if(istrue(var_0.input_received_since_last_check)) {
        var_1 = gettime() + get_inactivity_timeout_ms(var_0);
        var_0.input_received_since_last_check = 0;
      }

      if(gettime() > var_1 && !istrue(level.soak_testing)) {
        _id_1042(var_0);
        break;
      }

      wait(var_3);
    }
  }
}

_id_1042(var_0) {
  if(!scripts\engine\utility::array_contains(level._id_8CDE, var_0)) {
    level._id_8CDE = scripts\engine\utility::_id_1B8D(level._id_8CDE, var_0);
  }
}

_id_8CDF() {
  level._id_8CDE = [];

  for(;;) {
    if(level._id_8CDE.size > 0) {
      foreach(var_1 in level._id_8CDE) {
        if(!isDefined(var_1)) {
          continue;
        }
        if(!var_1 ishost()) {
          kick(var_1 getentitynumber(), "EXE/PLAYERKICKED_INACTIVE", 1);
        }
      }

      if(level._id_8CDE.size > 0) {
        foreach(var_1 in level._id_8CDE) {
          if(!isDefined(var_1)) {
            continue;
          }
          kick(var_1 getentitynumber(), "EXE/PLAYERKICKED_INACTIVE");
        }
      }

      level._id_8CDE = [];
    }

    wait 0.1;
  }
}

get_left_stick_dir(var_0) {
  return vectornormalize((var_0 _meth_869B(), var_0 _meth_869C(), 0.0));
}

get_right_stick_dir(var_0) {
  return vectornormalize((var_0 _meth_869D(), var_0 _meth_869E(), 0.0));
}

check_for_stick_or_pause_change() {
  level endon("game_ended");
  self endon("disconnect");

  while(!isDefined(self.model)) {
    wait 0.1;
  }

  var_0 = 5;
  var_1 = cos(var_0);
  var_2 = get_left_stick_dir(self);
  var_3 = get_right_stick_dir(self);
  var_4 = self _meth_886E();

  for(;;) {
    var_5 = get_left_stick_dir(self);

    if(!are_vectors_colinear_within_range(var_2, var_5, var_1)) {
      var_2 = var_5;
      self notify("inputReceived");
    }

    var_6 = get_right_stick_dir(self);

    if(!are_vectors_colinear_within_range(var_3, var_6, var_1)) {
      var_3 = var_6;
      self notify("inputReceived");
    }

    var_7 = self _meth_886E();

    if(var_7 != var_4) {
      var_4 = var_7;
      self notify("inputReceived");
    }

    wait 0.1;
  }
}

are_vectors_colinear_within_range(var_0, var_1, var_2) {
  if(_func_0135(var_0) == 0 && _func_0135(var_1) == 0) {
    return 1;
  }

  return vectordot(var_0, var_1) >= var_2;
}

_id_11047(var_0, var_1) {
  if(var_1._id_105F0 == "p4_" && _func_0205(var_0._id_105F0 + "respawn_laststand_valleygirl")) {
    var_0 thread _id_076F::_id_F72D("respawn_laststand_valleygirl", "zmb_comment_vo", "medium", 10, 0, 0, 0, 50);
    var_1 thread _id_076F::_id_F72D("respawn_laststand", "zmb_comment_vo", "medium", 10, 0, 0, 1, 50);
  } else if(var_1._id_105F0 == "p1_" && _func_0205(var_0._id_105F0 + "respawn_laststand_aj")) {
    var_0 thread _id_076F::_id_F72D("respawn_laststand_aj", "zmb_comment_vo", "medium", 10, 0, 0, 0, 50);
    var_1 thread _id_076F::_id_F72D("respawn_laststand", "zmb_comment_vo", "medium", 10, 0, 0, 1, 50);
  } else
    var_1 thread _id_076F::_id_F72D("respawn_latstand", "zmb_comment_vo", "medium", 10, 0, 0, 1, 50);
}

_id_11048(var_0, var_1) {
  if(var_1._id_105F0 == "p1_" && _func_0205(var_0._id_105F0 + "reviving_valleygirl")) {
    var_0 thread _id_076F::_id_F72D("reviving_valleygirl", "zmb_comment_vo");
  } else if(var_1._id_105F0 == "p1_" && _func_0205(var_0._id_105F0 + "reviving_sally")) {
    var_0 thread _id_076F::_id_F72D("reviving_sally", "zmb_comment_vo");
  } else {
    var_0 thread _id_076F::_id_F72D("reviving", "zmb_comment_vo");
  }
}

_id_751A() {
  if(istrue(level.b_force_laststand_is_on)) {
    return 1;
  }

  return scripts\cp\utility::_id_7531("perk_machine_revive") || scripts\cp\utility::_id_8580("self_revive") && !istrue(self._id_4A49);
}