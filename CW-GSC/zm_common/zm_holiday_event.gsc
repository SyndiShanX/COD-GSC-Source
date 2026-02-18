/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_holiday_event.gsc
***********************************************/

#using script_340a2e805e35f7a2;
#using script_34ab99a4ca1a43d;
#using script_3a704cbcf4081bfb;
#using script_3b2abb7986f4ae7c;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\content_manager;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\math_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\gametypes\zm_gametype;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_maptable;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_transformation;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;
#namespace zm_holiday_event;

function private autoexec __init__system__() {
  system::register(#"zm_holiday_event", &preinit, &postinit, undefined, #"zm_loadout");
}

function private preinit() {
  if(is_true(getgametypesetting(#"hash_4751990deae37e66"))) {
    callback::on_ai_spawned(&function_3ba5772b);
    callback::on_ai_killed(&function_7d47c6f7);
    callback::on_item_pickup(&function_5da12481);
    zm::register_actor_damage_callback(&function_cb059f82);
    clientfield::register("actor", "" + # "hash_477ed992854f5645", 28000, 1, "counter");
    level thread function_cf4230c2();
  }
}

function private postinit() {
  if(is_true(getgametypesetting(#"hash_4751990deae37e66"))) {
    util::add_debug_command("<dev string:x38>");
    util::add_debug_command("<dev string:x93>");
    util::add_debug_command("<dev string:xeb>");
    zm_devgui::add_custom_devgui_callback(&function_33572994);

    level thread function_5837bf72();
  }
}

function function_5837bf72() {
  if(!isDefined(level.var_e0b4bcdf)) {
    level.var_e0b4bcdf = [];
  }

  if(zm_utility::is_survival()) {
    level flag::wait_till_all([# "hash_5aca8d24a1f56ee1", "start_zombie_round_logic", "intro_scene_done"]);
    util::wait_network_frame();
    var_f79418e = [];

    if(isDefined(level.contentmanager.currentdestination)) {
      foreach(location in level.contentmanager.currentdestination.locations) {
        instances = array::randomize(content_manager::get_children(location));

        foreach(instance in instances) {
          if(instance.content_script_name === "explore_chests_large") {
            if(!isDefined(var_f79418e)) {
              var_f79418e = [];
            } else if(!isarray(var_f79418e)) {
              var_f79418e = array(var_f79418e);
            }

            if(!isinarray(var_f79418e, instance)) {
              var_f79418e[var_f79418e.size] = instance;
            }
          }
        }
      }

      foreach(instance in var_f79418e) {
        var_842cdacd = instance.contentgroups[# "chest_spawn"];

        if(isarray(var_842cdacd)) {
          level.var_e0b4bcdf = arraycombine(level.var_e0b4bcdf, var_842cdacd);
        }
      }
    }

    var_de4a9f7a = randomintrangeinclusive(2, 3);
    level.var_e0b4bcdf = array::randomize(level.var_e0b4bcdf);
    var_c6e3f0a = 0;

    foreach(var_6f531d9b in level.var_e0b4bcdf) {
      if(isDefined(var_6f531d9b.scriptmodel)) {
        var_6f531d9b.scriptmodel delete();
      }

      if(isDefined(var_6f531d9b.trigger)) {
        var_6f531d9b.trigger delete();
      }

      var_cc1fb2d0 = namespace_58949729::function_fd5e77fa(#"hash_716f17fde963d0ae");
      var_3a053962 = # "hash_12e47c6c01f2ff59";
      var_6f531d9b.angles += (0, -90, 0);
      namespace_58949729::function_4ec9fc99(var_6f531d9b, var_cc1fb2d0, var_3a053962, #"p9_fxanim_mp_care_package_bundle", 3);
      var_6f531d9b.scriptmodel.var_11428995 = -1 * (0, -90, 0);
      var_6f531d9b.var_738dfc81 = randomintrangeinclusive(2, 3);
      var_6f531d9b.scriptmodel.var_cad1f913 = &function_fb4c0780;
      var_6f531d9b.scriptmodel.var_f2f6db96 = # "hash_6b51d18944db0abc";
      var_6f531d9b.scriptmodel.var_30dd81f6 = # "hash_1e149ca0cc921d74";
      var_6f531d9b.scriptmodel.var_46e0d8c8 = # "hash_44b7c85c36f077f7";
      var_6f531d9b.scriptmodel.var_d3256432 = # "hash_40541819515012be";
      var_c6e3f0a++;

      if(var_c6e3f0a >= var_de4a9f7a) {
        break;
      }
    }

    return;
  }

  if(zm_utility::is_classic()) {
    if(!level.var_e0b4bcdf.size) {
      a_s_player_spawns = zm_gametype::get_player_spawns_for_gametype();

      foreach(var_6f531d9b in a_s_player_spawns) {
        var_49089e5b = {
          #origin: groundtrace(var_6f531d9b.origin + (0, 0, 8), var_6f531d9b.origin + (0, 0, -100000), 0, undefined)[# "position"], #angles: var_6f531d9b.angles, #str_zone: var_6f531d9b.script_noteworthy
        };

        if(ispointonnavmesh(var_49089e5b.origin, 50)) {
          if(!isDefined(level.var_e0b4bcdf)) {
            level.var_e0b4bcdf = [];
          } else if(!isarray(level.var_e0b4bcdf)) {
            level.var_e0b4bcdf = array(level.var_e0b4bcdf);
          }

          if(!isinarray(level.var_e0b4bcdf, var_49089e5b)) {
            level.var_e0b4bcdf[level.var_e0b4bcdf.size] = var_49089e5b;
          }

          if(level.script === "zm_tungsten" && var_49089e5b.str_zone === "zone_helipads_portal_room") {
            var_49089e5b.angles = (var_49089e5b.angles[0], var_49089e5b.angles[1] + 180, var_49089e5b.angles[2]);
          }

          continue;
        }

        var_49089e5b struct::delete();
      }
    }

    if(!isDefined(level.var_165a2af4)) {
      level.var_165a2af4 = [];
    }

    if(!isDefined(level.var_165a2af4)) {
      level.var_165a2af4 = [];
    } else if(!isarray(level.var_165a2af4)) {
      level.var_165a2af4 = array(level.var_165a2af4);
    }

    if(!isinarray(level.var_165a2af4, "zone_proto_roof_center")) {
      level.var_165a2af4[level.var_165a2af4.size] = "zone_proto_roof_center";
    }

    if(!isDefined(level.var_165a2af4)) {
      level.var_165a2af4 = [];
    } else if(!isarray(level.var_165a2af4)) {
      level.var_165a2af4 = array(level.var_165a2af4);
    }

    if(!isinarray(level.var_165a2af4, "zone_helipads_4")) {
      level.var_165a2af4[level.var_165a2af4.size] = "zone_helipads_4";
    }

    if(!isDefined(level.var_7fe5d501)) {
      level.var_7fe5d501 = 5;
    }

    zm_utility::function_fdb0368(level.var_7fe5d501);
    var_de4a9f7a = randomintrangeinclusive(2, 3);
    var_c6e3f0a = 0;
    level.var_e0b4bcdf = array::randomize(level.var_e0b4bcdf);

    foreach(var_6f531d9b in level.var_e0b4bcdf) {
      var_18fc05c = var_6f531d9b.str_zone;

      if(!isDefined(var_18fc05c)) {
        var_18fc05c = zm_zonemgr::get_zone_from_position(var_6f531d9b.origin, 1);
      }

      if(!isDefined(var_18fc05c) || is_true(level.zones[var_18fc05c].is_active) || isinarray(level.var_165a2af4, var_18fc05c)) {
        continue;
      }

      var_4e2b2217 = 0;
      a_ai = getaiteamarray(level.zombie_team);

      foreach(ai in a_ai) {
        if(distance2dsquared(ai.origin, var_6f531d9b.origin) <= 160) {
          var_4e2b2217 = 1;
          break;
        }
      }

      if(var_4e2b2217) {
        continue;
      }

      if(isDefined(var_6f531d9b.scriptmodel)) {
        var_6f531d9b.scriptmodel delete();
      }

      if(isDefined(var_6f531d9b.trigger)) {
        var_6f531d9b.trigger delete();
      }

      level thread function_367f9f86(var_6f531d9b);
      var_c6e3f0a++;

      if(var_c6e3f0a >= var_de4a9f7a) {
        break;
      }
    }

    level.var_7fe5d501 += 5;
    level thread function_5837bf72();
  }
}

function function_367f9f86(var_6f531d9b) {
  var_cc1fb2d0 = namespace_58949729::function_fd5e77fa(#"hash_716f17fde963d0ae");
  var_3a053962 = # "hash_12e47c6c01f2ff59";
  var_6f531d9b.angles += (0, -90, 0);

  if(!is_true(var_6f531d9b.var_a30438e5)) {
    var_6f531d9b.var_a4fadd7e = var_6f531d9b.origin;
    var_6f531d9b.origin += (0, 0, 32);
    var_6f531d9b.var_a30438e5 = 1;
  }

  namespace_58949729::function_4ec9fc99(var_6f531d9b, var_cc1fb2d0, var_3a053962, #"p9_fxanim_mp_care_package_bundle", 3, 0, 1);

  if(isDefined(var_6f531d9b.scriptmodel)) {
    var_6f531d9b.scriptmodel.var_11428995 = -1 * (0, -90, 0);
    var_6f531d9b.var_738dfc81 = randomintrangeinclusive(2, 3);
    var_6f531d9b.scriptmodel.var_cad1f913 = &function_fb4c0780;
    var_6f531d9b.scriptmodel.var_f2f6db96 = # "hash_6b51d18944db0abc";
    var_6f531d9b.scriptmodel.var_30dd81f6 = # "hash_1e149ca0cc921d74";
    var_6f531d9b.scriptmodel.var_46e0d8c8 = # "hash_44b7c85c36f077f7";
    var_6f531d9b.scriptmodel.var_d3256432 = # "hash_40541819515012be";
    var_6f531d9b thread function_54188cef();
  }
}

function private function_54188cef() {
  self.scriptmodel endon(#"death");
  self.scriptmodel endon(#"hash_20d5ae218d7c2b33");
  wait 180;

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  self.scriptmodel thread function_fb4c0780();
}

function function_3ba5772b() {
  self endon(#"death");

  if(isDefined(self.archetype)) {
    switch (self.archetype) {
      case # "raz":
      case # "mimic":
      case # "tormentor":
      case # "zombie_dog":
      case # "mechz":
      case # "zombie":
      case # "avogadro":
      case # "hash_7c0d83ac1e845ac2":
        self.var_4356b0bd = 1;
        break;
      case # "soa":
        wait 1.4 + float(function_60d95f53()) / 1000;
        self.var_4356b0bd = 1;
        break;
    }
  }
}

function private function_cb059f82(inflictor, attacker, damage, flags, meansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(is_true(self.var_4356b0bd) && (shitloc === "neck" || shitloc === "head" || shitloc === "helmet" || shitloc === "torso_upper")) {
    self.var_4356b0bd = undefined;
    self clientfield::increment("" + # "hash_477ed992854f5645");

    if(isPlayer(attacker)) {
      level thread scoreevents::doscoreeventcallback("scoreEventZM", {
        #attacker: attacker, #scoreevent: "haunting_destroyed_pumpkin"});
      attacker zm_stats::function_17ee4529(#"hash_513bce963a91dd34", 1, #"hash_735ace6b22542a65");
    }

    if(damage >= self.health) {
      damage = self.health - 1;
      self thread function_9f5a8125(inflictor, attacker, damage, flags, meansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
      return damage;
    }
  }

  return -1;
}

function function_9f5a8125(inflictor, attacker, damage, flags, meansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  self endon(#"death");
  util::wait_network_frame();
  self dodamage(vpoint, boneindex, var_fd90b0bb, weapon, surfacetype, shitloc, vdir, psoffsettime);
}

function private function_7d47c6f7(params) {
  if(zm_utility::is_survival()) {
    if(is_true(level.var_53bc31ad)) {
      n_chance = 3;
    } else {
      n_chance = 3;
    }
  } else {
    n_chance = 2;
  }

  if(isPlayer(params.eattacker) && (math::cointoss(n_chance) || level flag::get(#"hash_69ca47ce3a408f31")) && self.archetype !== # "mimic") {
    if(zm_utility::is_classic() && !zm_utility::check_point_in_playable_area(self.origin)) {
      return;
    }

    if(self.targetname === "zombie_eaten") {
      return;
    }

    point = function_4ba8fde(#"item_zm_ltm_halloween_jackolantern_01");

    if(isDefined(point)) {
      item_drop::drop_item(0, undefined, 1, 0, point.id, self.origin, self.angles, 2);
    }
  }
}

function private function_5da12481(params) {
  item = params.item;

  if(isPlayer(self)) {
    if(isDefined(item.itementry.name)) {
      switch (item.itementry.name) {
        case # "item_zm_ltm_halloween_jackolantern_01":
          if(math::cointoss(15) || level flag::get(#"hash_6ef5c2fd97dfb8ba")) {
            ai_mimic = spawnactor(#"spawner_bo5_mimic", item.origin, item.angles, "mimic_jackolantern_spawn", 1);

            if(isDefined(ai_mimic)) {
              playFX(#"zm_ai/fx9_mimic_prop_spawn_out", ai_mimic.origin);
              ai_mimic playSound(#"hash_408f33e5cf20df9d");
            } else {
              item function_933708f2();
            }
          } else {
            item function_933708f2();
          }

          break;
      }
    }
  }
}

function private function_933708f2() {
  var_7580ce3e = spawnStruct();
  var_7580ce3e.origin = self.origin;
  var_7580ce3e.angles = self.angles;
  var_7580ce3e.var_738dfc81 = 2;
  var_7580ce3e.scriptmodel = self;
  var_9b2da190 = namespace_58949729::function_257d7203(#"hash_716f17fde963d0ae");
  level namespace_58949729::function_f82f361c(var_7580ce3e, var_9b2da190, 2);
  var_7580ce3e struct::delete();
}

function private function_fb4c0780(player) {
  self notify(#"hash_20d5ae218d7c2b33");
  self thread helicopter_escape::function_960ea519(player);
}

function function_cf4230c2() {
  level.var_f546b995 = "halloween";
  zm_audio::musicstate_create("round_start_first_halloween", 3, "round_start_first_hallow_00");
  zm_audio::musicstate_create("round_start_halloween", 3, "round_start_hallow_00", "round_start_hallow_01");
  zm_audio::musicstate_create("round_end_halloween", 3, "round_end_hallow_00", "round_end_hallow_01");
  zm_audio::musicstate_create("game_over_halloween", 5, "gameover_hallow");
}

function private function_33572994(cmd) {
  switch (cmd) {
    case # "hash_e41021f4d82e571":
      level flag::toggle(#"hash_69ca47ce3a408f31");

      if(level flag::get(#"hash_69ca47ce3a408f31")) {
        iprintlnbold("<dev string:x147>");
      } else {
        iprintlnbold("<dev string:x170>");
      }

      break;
    case # "hash_68f2deafb75d0499":
      level flag::toggle(#"hash_6ef5c2fd97dfb8ba");

      if(level flag::get(#"hash_6ef5c2fd97dfb8ba")) {
        iprintlnbold("<dev string:x19a>");
      } else {
        iprintlnbold("<dev string:x1c6>");
      }

      break;
    case # "hash_3d3ef40bc9791d4b":
      if(level flag::get("<dev string:x1f3>")) {
        level flag::clear("<dev string:x1f3>");
      } else {
        level flag::set("<dev string:x1f3>");
        level thread function_50567097();
      }

      break;
  }
}

function private function_50567097() {
  self notify("<dev string:x213>");
  self endon("<dev string:x213>");

  while(level flag::get("<dev string:x1f3>")) {
    foreach(var_6f531d9b in level.var_e0b4bcdf) {
      if(isDefined(level.var_165a2af4) && isDefined(var_6f531d9b.str_zone) && isinarray(level.var_165a2af4, var_6f531d9b.str_zone)) {
        continue;
      }

      if(var_6f531d9b.scriptmodel.model === # "hash_12e47c6c01f2ff59") {
        v_color = (0, 1, 0);
        circle(var_6f531d9b.origin, 50, (0, 1, 0));
      } else {
        v_color = (1, 0, 0);
        circle(var_6f531d9b.origin, 50, (1, 0, 0));
      }

      if(isDefined(var_6f531d9b.str_zone) && isDefined(v_color)) {
        print3d(var_6f531d9b.origin, "<dev string:x227>" + var_6f531d9b.str_zone, v_color, 1, 0.5);
      }
    }

    waitframe(1);
  }
}