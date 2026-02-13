/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2468.gsc
*************************************************/

_id_53E6() {
  _id_07F7::_id_7EB6("mp/iw8_default_agent_definition.csv");
  level._id_11057 = "base";
  level._id_1105B = "screamer";
  level.zombie_type_juggernaut = "juggernaut";
  level.zombie_type_trickster = "trickster";
  level._id_11025["enemy_base_zombie_cp"] = level._id_11057;
  level._id_11025["enemy_base_zombie_skorpion_cp"] = level._id_11057;
  level._id_11025["enemy_base_zombie_sumpf_cp"] = level._id_11057;
  level._id_11025["enemy_zombie_soldier_cp"] = level._id_11057;
  level._id_11025["enemy_zombie_screamer_cp"] = level._id_1105B;
  level._id_11025["enemy_zombie_juggernaut_cp"] = level.zombie_type_juggernaut;
  level._id_11025["enemy_zombie_trickster_cp"] = level.zombie_type_trickster;
  _id_8127();
  _id_811D();
  _id_8126();
  level thread zone_monitor();
}

_id_8127() {}

_id_8126() {
  level._effect["drone_ground_spawn"] = loadfx("vfx/old/_requests/cp_titan/vfx_alien_drone_ground_spawn_titan.vfx");
  level._effect["zmb_ai_crawling_out_of_ground"] = loadfx("vfx/s4/zombie_ai/vfx_zai_portal_spawn_ground.vfx");
  level._effect["zmb_ai_crawling_out_of_vent"] = loadfx("vfx/s4/zombie_ai/vfx_zai_spawn_vent.vfx");
  level._effect["zmb_ai_base_death"] = loadfx("vfx/iw8/weap/_impact/flesh/vfx_imp_flesh_fatal_med.vfx");
  level._effect["zmb_ai_explosion_death"] = loadfx("vfx/s4/zombie_ai/vfx_zai_explode_death.vfx");
  level._effect["zmb_ai_teleport_spawn_in"] = loadfx("vfx/s4/zombie_ai/vfx_zai_portal_spawn.vfx");
  level._effect["zmb_ai_spawn_rise"] = loadfx("vfx/s4/level/cp_sumpf/vfx_mud_body_splash.vfx");
  level._effect["zmb_ai_spawn_under_water"] = loadfx("vfx/s4/level/cp_sumpf/vfx_water_body_splash.vfx");
}

_id_811D() {}

overrideaitype(var_0, var_1) {
  if(!isDefined(level.zombieaitypeoverrides)) {
    level.zombieaitypeoverrides = [];
  }

  level.zombieaitypeoverrides[var_0] = var_1;
}

_id_110AD(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(level.zombieaitypeoverrides)) {
    var_7 = level.zombieaitypeoverrides[var_0];

    if(isDefined(var_7)) {
      var_0 = var_7;
    }
  }

  if(!isDefined(var_5)) {
    var_5 = level._id_11025[var_0];

    if(!isDefined(var_5)) {
      return;
    }
  }

  var_0 = "actor_" + var_0;

  if(!isDefined(level._id_11ED[var_0])) {
    return undefined;
  }

  if(!isDefined(var_3) || !isDefined(var_3._id_CC9D)) {
    var_3 = spawnStruct();

    if(var_5 != "base" || !getdvarint("#x3dee089cb49164e4e", 0)) {
      var_3._id_CC9D = "spawn_teleport";
    }

    var_3._id_0481 = "spawnStruct";
    var_3.origin = var_1;
  }

  var_8 = _id_07F7::_id_E32A(var_0, var_1, var_2);

  if(isDefined(var_8)) {
    var_8 _id_06CB::_id_2F23("on_ai_spawned");

    if(isDefined(var_6)) {
      switch (var_6) {
        case 0:
          var_8.base_model = "c_s4_zmb_screamer_1_wholebody_xmas";
          var_8.frozen_model = "c_s4_zmb_screamer_1_wholebody_xmas_frost";
          break;
        case 1:
          var_8.base_model = "c_s4_zmb_screamer_1_wholebody_hanukka";
          var_8.frozen_model = "c_s4_zmb_screamer_1_wholebody_hanukka_frost";
          break;
        case 2:
          var_8.base_model = "zom_juggernaut_wholebody_xmas";
          var_8.frozen_model = "zom_juggernaut_wholebody_xmas_frost";
          break;
      }

      var_8 setModel(var_8.base_model);
    }

    var_8._id_03E9 = var_3;
    var_8._id_106A1 = var_4;
    var_8 thread _id_08EA::_id_11068();
    var_8._id_110B0 = var_5;
    var_8 _meth_8361("specialty_radarblip", 1);

    if(var_5 == "base" && randomint(100) < 70) {
      var_8 thread _id_08EA::equiphelmet();
    }

    if(!istrue(level.b_disable_special_intro_vo)) {
      if(var_5 == "screamer" && !isDefined(level.screamer_has_spawned)) {
        level.screamer_has_spawned = 1;

        if(getDvar("#x36d16f02578d0ee10") != "cp_zm_oasis") {
          thread _id_0720::play_narration("zm_cmcp_obhb_krft_hscr");
        }
      }

      if(var_5 == "juggernaut" && !isDefined(level.juggernaut_has_spawned)) {
        level.juggernaut_has_spawned = 1;

        if(getDvar("#x36d16f02578d0ee10") != "cp_zm_oasis") {
          thread _id_0720::play_narration("zm_cmcp_obhb_krft_hjg1");
        }
      }
    }

    var_9 = var_5;

    if(var_9 == "base") {
      var_9 = "standard";
    }

    var_8 _meth_84A8("zombietype", var_9, 0.1);

    if(!isDefined(var_3._id_11081)) {
      var_3._id_11081 = _func_02AB(var_3.origin);
    }

    if(isDefined(var_3._id_CC9D)) {
      switch (var_3._id_CC9D) {
        case "spawn_teleport":
          if(isDefined(var_8.spawn_teleport_fx)) {
            playFX(var_8.spawn_teleport_fx, var_8.origin);
          } else {
            playFX(level._effect["zmb_ai_teleport_spawn_in"], var_8.origin);
          }

          var_8 thread playsupplementalzombiespawnfx();

          if(var_5 == "base") {
            playsoundatpos(var_8.origin, "zmb_spawn_portal");
          } else if(var_0 == "actor_enemy_zombie_screamer_cp") {
            playsoundatpos(var_8.origin, "zmb_screamer_spawn_portal");
          } else if(var_0 == "actor_enemy_zombie_juggernaut_cp") {
            playsoundatpos(var_8.origin, "zmb_juggernaut_spawn_portal");
          }

          break;
        case "spawn_ground":
          if(isDefined(var_8.spawn_ground_fx)) {
            playFX(var_8.spawn_ground_fx, var_8.origin);
          } else {
            playFX(level._effect["zmb_ai_crawling_out_of_ground"], var_8.origin);
          }

          var_8 thread playsupplementalzombiespawnfx();

          if(var_5 == "base") {
            playsoundatpos(var_8.origin, "zmb_spawn_ground");
          } else if(var_0 == "actor_enemy_zombie_screamer_cp") {
            playsoundatpos(var_8.origin, "zmb_screamer_spawn_ground");
          } else if(var_0 == "actor_enemy_zombie_juggernaut_cp") {
            playsoundatpos(var_8.origin, "zmb_juggernaut_spawn_ground");
          }

          break;
        case "spawn_wall_low":
          playFX(level._effect["zmb_ai_crawling_out_of_vent"], var_8.origin);
          break;
        case "spawn_base_rise":
          if(isDefined(var_8.spawn_rise_fx)) {
            playFX(var_8.spawn_rise_fx, var_8.origin);
          } else {
            playFX(scripts\engine\utility::getfx("zmb_ai_spawn_" + scripts\cp\utility::_id_459B(var_3._id_CD99, "rise")), var_8.origin);
          }

          if(isDefined(var_3._id_CD99) && var_3._id_CD99 == "under_water") {
            playsoundatpos(var_8.origin, "zmb_spawn_orig_water");
          } else {
            playsoundatpos(var_8.origin, "zmb_spawn_orig_ground");
          }

          break;
        case "spawn_crawl_out":
          if(isDefined(var_8.spawn_crawl_fx)) {
            playFX(var_8.spawn_crawl_fx, var_8.origin);
          } else {
            var_10 = scripts\engine\utility::getstruct(var_3.target2, "targetname");

            if(isDefined(var_10)) {
              playFX(scripts\engine\utility::getfx("zmb_ai_spawn_" + scripts\cp\utility::_id_459B(var_3._id_CD99, "rise")), var_10.origin);
            }
          }

          playsoundatpos(var_8.origin, "zmb_spawn_orig_ground");
          break;
        default:
          if(isDefined(var_8.spawn_teleport_fx)) {
            playFX(var_8.spawn_teleport_fx, var_8.origin + (0, 0, 52));
          } else {
            playFX(level._effect["zmb_ai_teleport_spawn_in"], var_8.origin + (0, 0, 52));
          }

          if(var_5 == "base") {
            playsoundatpos(var_8.origin, "zmb_spawn_portal");
          } else if(var_0 == "actor_enemy_zombie_screamer_cp") {
            playsoundatpos(var_8.origin, "zmb_screamer_spawn_portal");
          } else if(var_0 == "actor_enemy_zombie_juggernaut_cp") {
            playsoundatpos(var_8.origin, "zmb_juggernaut_spawn_portal");
          }

          break;
      }
    }

    var_8 _id_08EA::_id_110A8(var_5);
    var_8 _id_08EA::_id_110A6(var_5);
    var_8 _id_08EA::_id_110A7(var_5);
    var_8 thread enableemissiveonspawn();

    if(var_5 == "base") {
      if(!isDefined(level.spawnedaibase)) {
        level.spawnedaibase = 1;
      } else {
        level.spawnedaibase++;
      }
    } else if(var_0 == "actor_enemy_zombie_screamer_cp") {
      if(!isDefined(level.spawnedaiscreamer)) {
        level.spawnedaiscreamer = 1;
      } else {
        level.spawnedaiscreamer++;
      }
    } else if(var_0 == "actor_enemy_zombie_juggernaut_cp") {
      if(!isDefined(level.spawnedaijuggernaut)) {
        level.spawnedaijuggernaut = 1;
      } else {
        level.spawnedaijuggernaut++;
      }
    } else if(var_0 == "actor_enemy_zombie_trickster_cp") {
      if(!isDefined(level.spawnedaitrickster)) {
        level.spawnedaitrickster = 1;
      } else {
        level.spawnedaitrickster++;
      }
    }
  }

  return var_8;
}

playsupplementalzombiespawnfx() {
  if(!isDefined(level.zombie_spawn_supplemental_fx)) {
    return;
  }
  self endon("death");
  wait 0.3;

  if(isDefined(level.zombie_spawn_supplemental_fx)) {
    playFXOnTag(level._effect[level.zombie_spawn_supplemental_fx], self, "j_spine4");
  }
}

enableemissiveonspawn() {
  self endon("death");
  scripts\cp\utility::wait_network_frame(2);
  self _meth_80C6(0, 1);
}

zombiegethealthroundscale(var_0) {
  var_1 = 1;

  if(!isDefined(level._id_11049)) {
    level._id_11049 = 1;
  }

  if(!isDefined(level._id_0DF8)) {
    level._id_0DF8 = [];
    var_2 = tablelookupgetnumrows("cp/zombies/cp_ai_zombie_health_scaling.csv");

    for(var_3 = 0; var_3 < var_2; var_3++) {
      level._id_0DF8[var_3] = tablelookupbyrow("cp/zombies/cp_ai_zombie_health_scaling.csv", var_3, 0);
    }
  }

  var_4 = level._id_11049 - 1;

  if(isDefined(var_0)) {
    var_4 = var_0 - 1;
  }

  if(var_4 >= level._id_0DF8.size) {
    var_4 = level._id_0DF8.size - 1;
  }

  var_1 = float(level._id_0DF8[var_4]);
  return var_1;
}

zone_monitor() {
  level notify("stop_zone_monitor");
  level endon("stop_zone_monitor");
  level endon("game_end");

  for(;;) {
    var_0 = get_active_zones();

    if(var_0.size > 0) {
      var_1 = level.players;
      var_2 = [];

      foreach(var_4 in var_1) {
        if(!_id_0B05::_id_DB71(var_4, 1)) {
          var_2 = scripts\engine\utility::array_add(var_2, var_4);
        }
      }

      foreach(var_7 in var_0) {
        var_7.contains_player = 0;

        foreach(var_4 in var_2) {
          if(var_4 istouching(var_7)) {
            var_7.contains_player = 1;
            break;
          }
        }
      }
    }

    wait 0.5;
  }
}

get_active_zones() {
  var_0 = [];
  var_1 = _func_0070(level._id_11056);

  foreach(var_3 in var_1) {
    if(!isDefined(var_3._id_106A1)) {
      continue;
    }
    var_0 = scripts\cp\utility::_id_1B8C(var_0, var_3._id_106A1);
  }

  return var_0;
}

get_enemy_type_num() {
  var_0 = self;
  var_1 = 0;

  if(isDefined(var_0._id_110B0)) {
    switch (var_0._id_110B0) {
      case "base":
        var_1 = 1;
        break;
      case "screamer":
        var_1 = 2;
        break;
      case "juggernaut":
        if(istrue(var_0.b_is_hvt)) {
          var_1 = 6;
        } else {
          var_1 = 3;
        }

        break;
      case "trickster":
        if(istrue(var_0.b_is_final_boss)) {
          var_1 = 5;
        } else {
          var_1 = 4;
        }

        break;
      default:
        var_1 = 0;
        break;
    }
  }

  return var_1;
}

get_enemy_class_num() {
  var_0 = self;
  var_1 = 0;

  if(isDefined(var_0.zm_ai_category)) {
    switch (var_0.zm_ai_category) {
      case "normal":
        var_1 = 0;
        break;
      case "special":
        var_1 = 1;
        break;
      case "elite":
        var_1 = 2;
        break;
      case "boss":
        var_1 = 3;
        break;
      default:
        var_1 = 0;
        break;
    }
  }

  if(isDefined(var_0._id_110B0) && var_0._id_110B0 == "screamer") {
    var_1 = 5;
  }

  return var_1;
}

get_ltm_spawner_model_from_type(var_0) {
  var_1 = undefined;

  if(istrue(getdvarint("#x32499d9dc5db0430e", 0))) {
    switch (var_0) {
      case "enemy_zombie_screamer_cp":
        if(scripts\engine\utility::cointoss()) {
          var_1 = 1;
        } else {
          var_1 = 0;
        }

        break;
      case "enemy_zombie_juggernaut_cp":
        var_1 = 2;
        break;
    }
  }

  return var_1;
}

_id_0EE2() {}

_id_D131() {}

_id_8600() {
  return 0;
}

_id_8D04() {}

_id_1104F(var_0, var_1, var_2, var_3, var_4) {}

_id_53C7(var_0) {}

_id_99D3() {}

_id_E248(var_0, var_1, var_2, var_3) {}

_id_2F04(var_0) {}

_id_678C(var_0) {}

_id_6590(var_0) {}

_id_67DD(var_0) {}

_id_11084() {}

_id_B54C() {}