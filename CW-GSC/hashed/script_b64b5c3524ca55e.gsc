/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_b64b5c3524ca55e.gsc
***********************************************/

#using script_3a88f428c6d8ef90;
#using script_42b13e9404382f56;
#using script_56731c09a921b64e;
#using script_58860a35d0555f74;
#using script_63b5c2449d0e2f48;
#using script_72401f526ba71638;
#using script_76a8f964e4309959;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\armor;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\zm\ai\zm_ai_avogadro;
#using scripts\zm\ai\zm_ai_mechz;
#using scripts\zm\ai\zm_ai_soa;
#using scripts\zm\zm_ai_raz;
#using scripts\zm\zm_platinum;
#using scripts\zm\zm_platinum_main_quest;
#using scripts\zm\zm_platinum_vo;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_fasttravel;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_sq;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_weapons;
#namespace namespace_4e8d47b1;

function init() {
  clientfield::register("toplayer", "" + # "hash_529b556128a8587d", 24000, 1, "int");
  clientfield::register("scriptmover", "" + # "hash_4a3af1d46621f069", 24000, 1, "int");
  clientfield::register("scriptmover", "" + # "hash_45d9cedaf4fb4aa2", 24000, 1, "int");
  clientfield::register("scriptmover", "" + # "hash_4a7733d2f4b25e81", 24000, 1, "int");
  clientfield::register("scriptmover", "" + # "hash_41ba39a474a3503f", 24000, getminbitcountfornum(2), "int");
  clientfield::register("scriptmover", "" + # "hash_2951f2625695bd6b", 24000, getminbitcountfornum(2), "int");
  clientfield::register("world", "" + # "hash_74c14ea3fcc781ea", 24000, getminbitcountfornum(2), "int");
  clientfield::register("actor", "" + # "hash_636aa4e3dd50512a", 24000, 1, "counter");
  clientfield::register("actor", "" + # "hash_498f233d25448db3", 24000, 1, "int");
  clientfield::register("actor", "" + # "hash_5f6e0119d9eee00c", 24000, getminbitcountfornum(2), "int");
  clientfield::register("scriptmover", "" + # "hash_78efd0fabb77e1ea", 24000, 1, "int");
  clientfield::register("scriptmover", "" + # "hash_7006a5e1e75527f3", 24000, 1, "int");
  clientfield::register("toplayer", "" + # "hash_45456ed33ab0037a", 24000, getminbitcountfornum(2), "int");
  clientfield::register("scriptmover", "" + # "hash_bae11639a0dd182", 24000, 1, "int");
  clientfield::register("scriptmover", "" + # "hash_57e0dbfd7a91b69d", 24000, 1, "int");
  clientfield::register("scriptmover", "" + # "hash_7cd1cb3f455a77cf", 24000, 1, "int");
  clientfield::register("world", "" + # "hash_4b15b3ade2772206", 24000, getminbitcountfornum(2), "int");
  clientfield::register("toplayer", "" + # "hash_7857b61586fd957b", 24000, 1, "int");
  clientfield::register("scriptmover", "" + # "hash_765ec7ef8a874f2a", 24000, 1, "int");
  clientfield::register("world", "" + # "hash_3c1773045b663eac", 24000, 1, "counter");
  level.var_ecc60e04 = zm_corrupted_health_bar::register();
  level.var_75a7d6 = spawnStruct();
  var_75a7d6 = level.var_75a7d6;
  scene::add_scene_func(#"hash_101bc318d4a72a81", &function_771ae7ab, "play");

  foreach(s_loc in struct::get_array(#"corrupted")) {
    if(isDefined(s_loc.loc)) {
      var_75a7d6.a_s_locations[s_loc.loc] = s_loc;
    }

    foreach(ent in getEntArray(s_loc.target, "targetname")) {
      if(isDefined(ent.var_5744d1ac)) {
        switch (ent.var_5744d1ac) {
          case # "player_block":
            if(!isDefined(s_loc.var_ae9d791b)) {
              s_loc.var_ae9d791b = [];
            } else if(!isarray(s_loc.var_ae9d791b)) {
              s_loc.var_ae9d791b = array(s_loc.var_ae9d791b);
            }

            s_loc.var_ae9d791b[s_loc.var_ae9d791b.size] = ent;
            ent notsolid();
            break;
          case # "space":
            s_loc.vol_arena = ent;
            break;
        }
      }
    }

    foreach(struct in struct::get_array(s_loc.target)) {
      if(isDefined(struct.var_5744d1ac)) {
        switch (struct.var_5744d1ac) {
          case # "float":
            s_loc.var_9c98cb64[struct.script_int] = struct;

            foreach(boss_struct in struct::get_array(struct.target)) {
              if(isDefined(boss_struct.var_5744d1ac)) {
                switch (boss_struct.var_5744d1ac) {
                  case # "vacuum":
                    if(!isDefined(struct.var_4ad75699)) {
                      struct.var_4ad75699 = [];
                    } else if(!isarray(struct.var_4ad75699)) {
                      struct.var_4ad75699 = array(struct.var_4ad75699);
                    }

                    struct.var_4ad75699[struct.var_4ad75699.size] = boss_struct;
                    break;
                }
              }
            }

            break;
          case # "warp":
            if(!isDefined(s_loc.var_a9cc7c2)) {
              s_loc.var_a9cc7c2 = [];
            } else if(!isarray(s_loc.var_a9cc7c2)) {
              s_loc.var_a9cc7c2 = array(s_loc.var_a9cc7c2);
            }

            s_loc.var_a9cc7c2[s_loc.var_a9cc7c2.size] = struct;
            break;
          case # "hash_629346df19c15129":
            if(!isDefined(s_loc.var_1619fc2f)) {
              s_loc.var_1619fc2f = [];
            } else if(!isarray(s_loc.var_1619fc2f)) {
              s_loc.var_1619fc2f = array(s_loc.var_1619fc2f);
            }

            s_loc.var_1619fc2f[s_loc.var_1619fc2f.size] = struct;
            break;
          case # "leave":
            if(!isDefined(s_loc.var_cafd3f7e)) {
              s_loc.var_cafd3f7e = [];
            } else if(!isarray(s_loc.var_cafd3f7e)) {
              s_loc.var_cafd3f7e = array(s_loc.var_cafd3f7e);
            }

            s_loc.var_cafd3f7e[s_loc.var_cafd3f7e.size] = struct;
            break;
        }
      }
    }
  }

  if(!zm_utility::is_ee_enabled()) {
    return;
  }

  if(getdvarint(#"zm_debug_ee", 0) == 1) {
    level thread function_37597f29();
  }
}

function function_79868b3b(b_skipped) {
  if(b_skipped) {
    return;
  }

  level flag::set("power_on");
  level function_671424c7();
  level function_79ae7b73();
}

function function_ec198408(b_skipped, var_19e802fa) {
  var_75a7d6 = level.var_75a7d6;

  if(isDefined(var_75a7d6)) {
    var_75a7d6 flag::set(#"defeated");
  }

  foreach(e_player in getplayers()) {
    e_player clientfield::set_to_player("" + # "hash_45456ed33ab0037a", 0);

    if(level.var_ecc60e04 zm_corrupted_health_bar::is_open(e_player)) {
      level.var_ecc60e04 zm_corrupted_health_bar::close(e_player);
    }
  }

  var_c6454bbe = var_75a7d6.var_c6454bbe;

  if(isDefined(var_c6454bbe)) {
    foreach(var_68351b5a in var_c6454bbe) {
      if(isDefined(var_68351b5a)) {
        var_68351b5a clientfield::set("" + # "hash_78efd0fabb77e1ea", 0);
        var_68351b5a thread util::delayed_delete(1);
      }
    }
  }

  var_b6ef5059 = var_75a7d6.var_b6ef5059;

  if(isDefined(var_b6ef5059)) {
    foreach(var_e236b5ff in var_b6ef5059) {
      if(isDefined(var_e236b5ff)) {
        var_e236b5ff scene::stop(1);

        if(isDefined(var_e236b5ff)) {
          var_e236b5ff delete();
        }
      }
    }
  }

  var_a12bf98c = var_75a7d6.var_a12bf98c;

  if(isDefined(var_a12bf98c)) {
    function_761d8ea1(var_75a7d6, var_a12bf98c, 0);
  }

  var_fa2af647 = var_75a7d6.var_fa2af647;

  if(isDefined(var_fa2af647)) {
    var_fa2af647 clientfield::set("" + # "hash_4a3af1d46621f069", 0);
    var_fa2af647 thread util::delayed_delete(1);
  }

  level clientfield::set("" + # "hash_228f0acdd4255cb", 0);
  callback::remove_on_ai_spawned(&function_17c70260);
  level flag::clear(#"hash_5fff608f0c23a53f");
  level flag::clear(#"hash_14ac8b5a5e403984");
  level.var_43fb4347 = undefined;
  level.var_ea32773 = var_75a7d6.var_7b123964;
  util::setclientsysstate("platMusUnlock", "unlockShatter");
  music::setmusicstate("endfight_outro");
  level clientfield::set("" + # "hash_2a93d12c263f2d68", 6);
  zm_sq::objective_complete(#"corrupted");
  level notify(#"hash_7c60044f6a90f7f5");
  level notify(#"hash_3f335a51cee1c293");

  if(isDefined(level.klaus)) {
    level.klaus.var_8dd8140a = 1;
  }

  if(!var_19e802fa) {
    level thread zm_utility::function_9ad5aeb1(0, 1, 0, 0);
    mdl_shield = var_75a7d6.mdl_shield;

    if(isDefined(mdl_shield)) {
      mdl_shield clientfield::set("" + # "hash_4a7733d2f4b25e81", 0);
      mdl_shield notsolid();
      mdl_shield thread util::delayed_delete(1);
    }

    level thread scene::init_streamer(#"hash_101bc318d4a72a81", getplayers(), 0, 0);

    if(isDefined(var_a12bf98c)) {
      var_a12bf98c hidepart("throne_hide_jnt", "", 1);
      var_a12bf98c thread scene::play(#"hash_4ace6ee6fbaf17bd", "explode", var_a12bf98c);
    }

    var_b39864d6 = var_75a7d6.var_b39864d6;

    if(isDefined(var_b39864d6)) {
      var_b39864d6 clientfield::set("" + # "hash_bae11639a0dd182", 0);
      var_b39864d6 setteam(#"none");
      level thread function_23bd7b36(var_75a7d6, var_b39864d6);
      var_75a7d6 flag::wait_till(#"can_pickup");
      zm_sq::objective_set(#"hash_311658a8c916ad2a", undefined, 0, #"hash_750bc1dc48fa1700", #"hash_135e0bc539d7b383");
      level thread function_3eca6bba(var_75a7d6);
      var_c0b8a81 = struct::get(#"hash_1b73aed44cfa9929");
      s_pickup = var_c0b8a81 zm_unitrigger::create(#"hash_35b201f27cdd4f8e", 96, &function_6830c3a2);
      var_75a7d6 flag::wait_till(#"pick_up");
      zm_unitrigger::unregister_unitrigger(s_pickup);
      zm_sq::objective_complete(#"hash_135e0bc539d7b383");
    }

    foreach(e_player in getplayers()) {
      e_player val::set(#"mid_igc", "takedamage", 0);
      e_player val::set(#"mid_igc", "allowdeath", 0);
      e_player val::set(#"mid_igc", "ignoreme", 1);
      e_player.var_f4e33249 = 1;
    }

    level lui::screen_fade_out(1, (0, 0, 0));
    wait 0.1;

    foreach(e_player in getplayers()) {
      e_player val::set(#"mid_igc", "show_hud", 0);
      e_player val::set(#"hash_56f04d51d074718d", "freezecontrols", 1);
    }

    level clientfield::set("" + # "hash_763dd8035e80f7c", 1);
    function_4477afe1();
    function_f73d1f26();
    wait 2;
    level thread function_1a3e352c();
    level thread function_4c4f2d71();

    if(isDefined(level.klaus)) {
      if(!level flag::get(#"hash_504c8d65e27d0216")) {
        if(level.klaus haspart("J_Wrist_LE", "c_t9_zmb_dlc4_battle_klaus_body")) {
          level.klaus showpart("J_Wrist_LE", "c_t9_zmb_dlc4_battle_klaus_body", 1);
        }

        if(level.klaus haspart("J_Wrist_RI", "c_t9_zmb_dlc4_battle_klaus_body")) {
          level.klaus showpart("J_Wrist_RI", "c_t9_zmb_dlc4_battle_klaus_body", 1);
        }
      }

      level.klaus clientfield::set("" + # "hash_703543ca871a0f75", 1);
    }

    level thread zm_platinum_main_quest::function_abb25db(0.15, (0, 0, 0), "mid_igc_screen_fade_to_black");
    level thread zm_platinum_main_quest::function_542224cc(0.5, (0, 0, 0), "mid_igc_screen_fade_in_black", 1);
    level thread zm_utility::function_9ad5aeb1(0, 1, 1, 0);
    a_ents[#"klaus"] = level.klaus;
    scene::add_scene_func(#"hash_101bc318d4a72a81", &function_f81bfa93, "play");
    level scene::play(#"hash_101bc318d4a72a81", a_ents);
    level clientfield::set("" + # "hash_763dd8035e80f7c", 0);

    foreach(e_player in getplayers()) {
      e_player val::reset(#"hash_56f04d51d074718d", "freezecontrols");
      e_player val::reset_all(#"mid_igc");
      e_player.var_f4e33249 = undefined;
    }
  } else {
    function_4477afe1();
    function_f73d1f26();
    level thread zm_platinum_main_quest::function_abb25db(0, (0, 0, 0));
    level thread zm_platinum_main_quest::function_542224cc(0.5, (0, 0, 0), "mid_igc_screen_fade_in_black", 1);
    e_volume = getent("portal_damage_volume", "script_noteworthy");

    if(isarray(level.var_3b115519) && isDefined(e_volume) && isinarray(level.var_3b115519, e_volume)) {
      arrayremovevalue(level.var_3b115519, e_volume, 0);
    }

    level clientfield::set("" + # "hash_74c14ea3fcc781ea", 2);
    var_f2b1e478 = struct::get("klaus_carry_start");

    if(isDefined(level.klaus) && level.klaus.aitype != "spawner_zm_mannequin_ally") {
      aitype = level.klaus.aitype;
    } else {
      aitype = "spawner_zm_mannequin_ally_upgraded";
    }

    level.klaus = spawnactor(aitype, var_f2b1e478.origin, var_f2b1e478.angles);
    level.klaus showpart("J_Helm");
    waitframe(1);
  }

  if(isDefined(var_75a7d6.var_419e6251)) {
    level.overrideplayerdamage = var_75a7d6.var_419e6251;
  }

  foreach(e_player in getplayers()) {
    e_player clientfield::set_to_player("" + # "hash_529b556128a8587d", 0);
  }

  if(isDefined(var_75a7d6.var_1213d07)) {
    level.var_11350584 = var_75a7d6.var_1213d07;
  }
}

function function_4477afe1() {
  hidemiscmodels("hide_scene_models");
  level clientfield::increment("" + # "hash_3c1773045b663eac");
  var_539110f3 = struct::get(#"s_placed_nuke");
  var_1275e46b = var_539110f3.mdl;

  if(isDefined(var_1275e46b)) {
    var_1275e46b clientfield::set("" + # "hash_62ea9298804bdde2", 0);
    var_1275e46b hide();
  }
}

function function_f73d1f26() {
  mdl_conversion_machine = getent("mdl_conversion_machine", "targetname");

  if(isDefined(mdl_conversion_machine)) {
    mdl_conversion_machine setModel(#"hash_3f4d9e901bbb54b6");
  }
}

function function_23bd7b36(var_75a7d6, var_b39864d6) {
  if(!(isDefined(var_75a7d6) && isDefined(var_b39864d6))) {
    return;
  }

  level endon(#"end_game");
  var_b39864d6 endon(#"death");
  scene::add_scene_func(#"hash_63636406a7a2326", &function_b1365812, "boss_defeat");
  var_b39864d6 scene::play(#"hash_63636406a7a2326", "boss_defeat", var_b39864d6);
  var_b39864d6 thread scene::play(#"hash_63636406a7a2326", "boss_defeat_loop", var_b39864d6);
}

function function_b1365812(a_ents) {
  scene::remove_scene_func(#"hash_63636406a7a2326", &function_b1365812, "boss_defeat");
  var_75a7d6 = level.var_75a7d6;
  var_b39864d6 = var_75a7d6.var_b39864d6;

  if(isDefined(var_b39864d6)) {
    var_b39864d6 endon(#"death");
    var_b39864d6 stoploopsound();
    wait 0.5;
    level zm_vo::function_7622cb70(#"hash_17fe96f75c962f2d", 0, 0, undefined, 1);
    wait 2;
    var_75a7d6 flag::set(#"can_pickup");
  }
}

function function_3eca6bba(var_75a7d6) {
  if(!isDefined(var_75a7d6)) {
    return;
  }

  level endon(#"end_game");
  level zm_vo::function_7622cb70(#"hash_234d7fd9f78df07");
  wait 2;
  a_str_vo = [#"hash_47de96985959bc49", #"hash_47de95985959ba96", #"hash_47de98985959bfaf", #"hash_47de97985959bdfc", #"hash_47de9a985959c315"];

  foreach(str_vo in a_str_vo) {
    if(var_75a7d6 flag::get(#"pick_up")) {
      return;
    }

    level zm_vo::function_7622cb70(str_vo);
    wait randomfloatrange(5, 10);
  }

  var_75a7d6 flag::wait_till_timeout(20, #"pick_up");
  var_75a7d6 flag::set(#"pick_up");
}

function function_6830c3a2() {
  var_75a7d6 = level.var_75a7d6;

  if(!isDefined(var_75a7d6)) {
    return;
  }

  level endon(#"end_game");
  self endon(#"death");

  while(true) {
    s_waitresult = self waittill(#"trigger");

    if(zm_utility::is_player_valid(s_waitresult.activator)) {
      var_75a7d6 flag::set(#"pick_up");
      return;
    }
  }
}

function function_1a3e352c() {
  var_a83358f8 = level.klaus;

  if(isDefined(var_a83358f8)) {
    var_a83358f8 endon(#"death");
    var_a83358f8.var_c0d80964 = 1;
    level waittill(#"hash_79260c5dc1e40601");
    var_a83358f8 clientfield::set("" + # "hash_703543ca871a0f75", 2);
    var_a83358f8 zm_vo::function_d6f8bbd9(#"hash_4aad09dafd530a04");
    var_a83358f8 clientfield::set("" + # "hash_703543ca871a0f75", 1);
    var_a83358f8.var_c0d80964 = undefined;
  }
}

function function_4c4f2d71() {
  mdl_conversion_machine = getent("mdl_conversion_machine", "targetname");

  if(isDefined(mdl_conversion_machine)) {
    mdl_conversion_machine endon(#"death");
    level waittill(#"hash_1549bc53a986e991");
    mdl_conversion_machine clientfield::set("" + # "hash_765ec7ef8a874f2a", 1);
    level waittill(#"hash_960fb3637aa5630");
    mdl_conversion_machine clientfield::set("" + # "hash_765ec7ef8a874f2a", 0);
  }
}

function function_f81bfa93(a_ents) {
  scene::remove_scene_func(#"hash_101bc318d4a72a81", &function_f81bfa93, "play");

  foreach(e_player in getplayers()) {
    e_player val::reset(#"hash_56f04d51d074718d", "freezecontrols");
  }

  var_b39864d6 = level.var_75a7d6.var_b39864d6;

  if(isDefined(var_b39864d6)) {
    var_b39864d6 clientfield::set("" + # "hash_45d9cedaf4fb4aa2", 0);
    var_b39864d6 scene::stop(1);

    if(isDefined(var_b39864d6)) {
      var_b39864d6 delete();
    }
  }

  level notify(#"hash_7c60044f6a90f7f5");
  level thread lui::screen_fade_in(1, (0, 0, 0));
}

function function_671424c7() {
  level flag::clear("spawn_zombies");
  level flag::clear(#"hash_21921ed511559aa3");
  level flag::set(#"pause_round_timeout");
  level flag::set("hold_round_end");
  level thread zm_utility::function_9ad5aeb1(0, 1, 0, 0);
}

function function_79ae7b73() {
  level flag::set(#"boss_fight_started");
  level flag::clear(#"rbz_exfil_beacon_active");
  level flag::clear(#"rbz_exfil_allowed");
  level flag::clear(#"hash_25372b8b89ab540c");

  if(isDefined(level.var_6103ecd9)) {
    zm_round_spawning::function_d36196b1(level.var_6103ecd9);
  }

  level clientfield::set("" + # "hash_228f0acdd4255cb", 0);
  var_75a7d6 = level.var_75a7d6;
  b_teleporting = function_14a35d6f(var_75a7d6, #"lab");
  function_ff441bfb(var_75a7d6, #"lab");
  level thread namespace_99d0d95e::function_8f85d169(1);
  var_75a7d6.var_2a940370 = 0;
  level clientfield::set("" + # "hash_2a93d12c263f2d68", 5);
  level clientfield::set("" + # "hash_74c14ea3fcc781ea", 2);
  e_volume = getent("portal_damage_volume", "script_noteworthy");

  if(isarray(level.var_3b115519) && isDefined(e_volume) && isinarray(level.var_3b115519, e_volume)) {
    arrayremovevalue(level.var_3b115519, e_volume, 0);
  }

  n_wait = 1;

  if(b_teleporting) {
    n_wait = 5;
  }

  wait n_wait;
  level flag::clear(#"in_dark_side");
  s_portal = struct::get(#"hash_76f411fef07a9cb5");
  playFX(#"sr/fx9_hvt_aether_portal_exp", s_portal.origin + (0, 0, 32), anglesToForward(s_portal.angles), anglestoup(s_portal.angles));
  var_75a7d6.var_fa2af647 = util::spawn_model(#"tag_origin", s_portal.origin, s_portal.angles);
  var_fa2af647 = var_75a7d6.var_fa2af647;
  var_fa2af647 clientfield::set("" + # "hash_4a3af1d46621f069", 1);
  s_dest = struct::get(s_portal.target);
  level thread function_235a6cd4(var_75a7d6, var_fa2af647, s_dest);
  wait 3;
  var_75a7d6.var_7b123964 = level.var_ea32773;
  level.var_ea32773 = &function_ea32773;
  level zm_vo::function_7622cb70(#"hash_63c9f49151520cdc");
  var_75a7d6 flag::wait_till_timeout(10, #"hash_39574ac4c3767448");
  var_75a7d6.var_419e6251 = level.overrideplayerdamage;
  level.overrideplayerdamage = &function_86c6df86;
  var_75a7d6.str_loc = # "lab";
  var_75a7d6.var_1213d07 = level.var_11350584;
  level.var_11350584 = &function_f1d7560a;
  n_players = getplayers().size;

  if(n_players < 1) {
    n_players = 1;
  } else if(n_players > 4) {
    n_players = 4;
  }

  switch (n_players) {
    case 1:
      var_de4a9f7a = 20;
      break;
    case 2:
      var_de4a9f7a = 22;
      break;
    case 3:
      var_de4a9f7a = 24;
      break;
    case 4:
      var_de4a9f7a = 26;
      break;
  }

  var_75a7d6.var_de4a9f7a = var_de4a9f7a;
  var_75a7d6.var_6359299f = [];
  var_75a7d6.var_b53352fa = 0;
  var_75a7d6.var_25a3af6b = [#"hash_24f8b14e0d7981e2", #"hash_56100f3e34a790d", #"hash_2d3075d74e2da3a8"];
  var_75a7d6.s_boss = function_2954a39(var_75a7d6, #"lab", 1);
  s_boss = var_75a7d6.s_boss;
  var_75a7d6.var_b39864d6 = util::spawn_model(#"hash_381fb9506ce008a0");
  var_b39864d6 = var_75a7d6.var_b39864d6;
  var_b39864d6 clientfield::set("" + # "hash_45d9cedaf4fb4aa2", 1);
  var_add9efd6 = struct::get(#"hash_44cafed41be284f0");
  var_75a7d6.var_a12bf98c = util::spawn_model(#"p9_fxanim_zm_platinum_throne_mod", var_add9efd6.origin, var_add9efd6.angles);
  var_a12bf98c = var_75a7d6.var_a12bf98c;
  var_75a7d6 flag::set(#"spawned");
  var_75a7d6.var_b6ef5059 = [];
  level thread function_de5d28c1(var_75a7d6, var_b39864d6, var_a12bf98c);
  wait 1;
  music::setmusicstate("endfight_intro");
  level zm_vo::function_7622cb70(#"hash_63c9f791515211f5");
  var_75a7d6 flag::wait_till(#"hash_551f8269c93eb9f9");
  var_75a7d6.var_8d31700f = function_5f36e356(800000, 1920000);
  var_75a7d6.var_3f956940 = var_75a7d6.var_8d31700f;
  var_75a7d6.n_threshold = var_75a7d6.var_8d31700f;
  var_75a7d6.var_4fb7caaf = int(var_75a7d6.var_8d31700f * 0.2);
  var_75a7d6.var_1847f53d = var_75a7d6.n_threshold - var_75a7d6.var_4fb7caaf;
  var_75a7d6.var_f65dc5e1 = int(var_75a7d6.var_8d31700f * 0.5);
  var_75a7d6.var_fa625236 = int(var_75a7d6.var_8d31700f * 0.1);
  var_75a7d6.var_63b86490 = int(var_75a7d6.var_8d31700f * 0.05);
  level thread function_223f7204(var_75a7d6, var_b39864d6);
  var_75a7d6.var_200c676a = function_5f36e356(40000, 96000);
  var_75a7d6.var_9428def3 = var_75a7d6.var_200c676a;
  level thread function_ab3592be(var_75a7d6, var_b39864d6);
  zm_sq::objective_set(#"hash_311658a8c916ad2a", undefined, 0, #"hash_1dee736b2c540de8", #"corrupted");

  foreach(e_player in getplayers()) {
    level.var_ecc60e04 zm_corrupted_health_bar::set_armor(e_player, 1);
    level.var_ecc60e04 zm_corrupted_health_bar::function_74adcd8a(e_player, 1);
    level.var_ecc60e04 zm_corrupted_health_bar::set_health(e_player, 1);

    if(!level.var_ecc60e04 zm_corrupted_health_bar::is_open(e_player)) {
      level.var_ecc60e04 zm_corrupted_health_bar::open(e_player);
    }
  }

  callback::on_ai_spawned(&function_17c70260);
  level flag::set(#"hash_5fff608f0c23a53f");
  level flag::set(#"hash_14ac8b5a5e403984");
  level.var_43fb4347 = "sprint";
  var_75a7d6 flag::increment(#"hash_1e2734204ab845a2");
  level thread function_51be2da(var_75a7d6);
  var_75a7d6 flag::set(#"mechz_disabled");
  var_75a7d6 flag::set(#"tempest_disabled");
  var_75a7d6 flag::set(#"hash_88667c18a4cff07");
  level thread function_5c1c7b14(var_75a7d6);
  level thread function_60c68651(var_75a7d6);
  level thread function_c0c7140f(var_75a7d6);
  var_75a7d6.var_b689f2ee[#"vampirism"] = 0;
  var_75a7d6.var_b689f2ee[#"hash_6a3f96f46648766d"] = 0;
  var_75a7d6.var_b689f2ee[#"hash_477a7859bae6c69c"] = 0;
  var_75a7d6.var_b689f2ee[#"hash_9754b045afe5254"] = 0;
  var_75a7d6 flag::set(#"hash_3948a1aa982807f2");
  var_75a7d6 flag::set(#"hash_2d61f4f9fee67c9a");
  level thread function_73ef29bf(var_75a7d6);
  var_75a7d6 flag::wait_till(#"defeated");
}

function function_ea32773(s_waitresult) {
  if(s_waitresult.reason === # "hash_4e5756202af6ae94" || s_waitresult.reason === # "last_player_died") {
    foreach(e_player in getplayers()) {
      if(isPlayer(e_player)) {
        e_player thread zm_vo::function_7622cb70(#"hash_b28b35a5978f9a5", 0, 0, undefined, 1);
      }
    }
  }
}

function function_235a6cd4(var_75a7d6, mdl_portal, s_dest) {
  if(!(isDefined(mdl_portal) && isDefined(var_75a7d6) && isDefined(s_dest))) {
    return;
  }

  level endon(#"end_game");
  var_75a7d6 endon(#"defeated");
  mdl_portal endon(#"death");
  mdl_portal moveto(s_dest.origin, 7, 0, 1);
  mdl_portal rotateto(s_dest.angles, 7, 0, 1);
  mdl_portal waittill(#"movedone");
  mdl_portal.origin = s_dest.origin;
  mdl_portal.angles = s_dest.angles;
  var_75a7d6 flag::set(#"hash_39574ac4c3767448");
}

function function_de5d28c1(var_75a7d6, var_b39864d6, var_a12bf98c) {
  if(!(isDefined(var_b39864d6) && isDefined(var_75a7d6) && isDefined(var_a12bf98c))) {
    return;
  }

  level endon(#"end_game");
  var_75a7d6 endon(#"defeated");
  var_b39864d6 endon(#"death");
  var_a12bf98c endon(#"death");
  scene::add_scene_func(#"hash_4ace6ee6fbaf17bd", &function_876d602, "rise");
  a_ents = [];
  a_ents[#"boss"] = var_b39864d6;
  a_ents[#"throne"] = var_a12bf98c;
  var_a12bf98c scene::play(#"hash_4ace6ee6fbaf17bd", "rise", a_ents);
  var_b39864d6 scene::stop();
  var_a12bf98c scene::stop();
  var_b39864d6 thread scene::play(#"hash_63636406a7a2326", "boss_sit_idle", var_b39864d6);
  var_a12bf98c thread scene::play(#"hash_4ace6ee6fbaf17bd", "loop", var_a12bf98c);
  waitframe(1);
  var_75a7d6 flag::set(#"hash_551f8269c93eb9f9");
}

function function_876d602(a_ents) {
  scene::remove_scene_func(#"hash_4ace6ee6fbaf17bd", &function_876d602, "rise");
  var_75a7d6 = level.var_75a7d6;

  if(isDefined(var_75a7d6)) {
    level endon(#"end_game");
    var_75a7d6 endon(#"defeated");
    var_fa2af647 = var_75a7d6.var_fa2af647;

    if(isDefined(var_fa2af647)) {
      playFX(#"sr/fx9_hvt_aether_portal_exp", var_fa2af647.origin + (0, 0, 32), anglesToForward(var_fa2af647.angles), anglestoup(var_fa2af647.angles));
      var_fa2af647 playSound(#"hash_1412afc9788c5421");
    }

    foreach(str_step in [#"step_01", #"step_02", #"step_03", #"step_04", #"step_05", #"step_06", #"step_07"]) {
      var_e236b5ff = a_ents[str_step];

      if(isDefined(var_e236b5ff)) {
        if(!isDefined(var_75a7d6.var_b6ef5059)) {
          var_75a7d6.var_b6ef5059 = [];
        } else if(!isarray(var_75a7d6.var_b6ef5059)) {
          var_75a7d6.var_b6ef5059 = array(var_75a7d6.var_b6ef5059);
        }

        var_75a7d6.var_b6ef5059[var_75a7d6.var_b6ef5059.size] = var_e236b5ff;
        level thread function_3a27a710(var_75a7d6, var_e236b5ff);
      }
    }

    wait 3;

    if(isDefined(var_fa2af647)) {
      var_fa2af647 clientfield::set("" + # "hash_4a3af1d46621f069", 0);
      var_fa2af647 thread util::delayed_delete(1);
    }
  }
}

function function_3a27a710(var_75a7d6, var_e236b5ff) {
  if(!(isDefined(var_75a7d6) && isDefined(var_e236b5ff))) {
    return;
  }

  level endon(#"end_game");
  var_75a7d6 endon(#"defeated");
  var_e236b5ff endon(#"death");
  var_e236b5ff waittilltimeout(30, #"hash_5ebb5e3febd0998b");
  var_e236b5ff hide();
}

function function_17c70260() {
  self endon(#"death");

  if(level.round_number < 20) {
    self.maxhealth = self zm_ai_utility::function_b5fe98(20);
    self.health = self.maxhealth;
  }
}

function function_c0c7140f(var_75a7d6) {
  if(!isDefined(var_75a7d6)) {
    return;
  }

  level endon(#"end_game");
  var_75a7d6 endon(#"defeated");
  wait 2;
  level zm_vo::function_7622cb70(#"hash_63c9f69151521042");
  wait 0.5;
  zm_platinum_vo::function_d137d6a0(#"hash_6a3c2b16f9b14049", #"hash_1d28a188911484ab", #"hash_1630afbf9f79a2e5");
  var_75a7d6 flag::set(#"intro_vo_done");
  music::setmusicstate("endfight_intro_wave");
}

function function_51be2da(var_75a7d6) {
  if(!isDefined(var_75a7d6)) {
    return;
  }

  level endon(#"end_game");
  var_75a7d6 endon(#"defeated");
  a_s_spawns = struct::get_array(#"hash_5054a81cee760c30");
  var_ca4db1e2 = level.zombie_spawners[6];

  for(i = 0; i < 32; i++) {
    if(a_s_spawns.size <= 0) {
      a_s_spawns = struct::get_array(#"hash_5054a81cee760c30");
    }

    s_spawn = array::random(a_s_spawns);
    var_134535fe = zombie_utility::spawn_zombie(var_ca4db1e2, undefined, s_spawn);

    if(isDefined(var_134535fe)) {
      var_134535fe clientfield::increment("" + # "hash_636aa4e3dd50512a");
      arrayremovevalue(a_s_spawns, s_spawn);

      if(!isDefined(var_75a7d6.var_6359299f)) {
        var_75a7d6.var_6359299f = [];
      } else if(!isarray(var_75a7d6.var_6359299f)) {
        var_75a7d6.var_6359299f = array(var_75a7d6.var_6359299f);
      }

      var_75a7d6.var_6359299f[var_75a7d6.var_6359299f.size] = var_134535fe;
    }

    wait 0.5;
  }

  var_75a7d6 flag::decrement(#"hash_1e2734204ab845a2");
}

function function_60c68651(var_75a7d6) {
  var_75a7d6.var_a6d734ec = [];

  foreach(str_id in [#"vampirism", #"hash_6a3f96f46648766d", #"hash_477a7859bae6c69c", #"hash_9754b045afe5254", #"hash_60af5025b12d8632", #"player_teleport", #"new_stage", #"damage_light", #"damage_medium", #"throw", #"laugh_short", #"laugh_long", #"roar", #"no"]) {
    switch (str_id) {
      case # "hash_9754b045afe5254":
        a_str_vo = [#"hash_51ad5c339f77cd75", #"hash_51ad59339f77c85c", #"hash_51ad5a339f77ca0f", #"hash_51ad57339f77c4f6", #"hash_51ad58339f77c6a9"];
        break;
      case # "hash_6a3f96f46648766d":
        a_str_vo = [#"hash_3c8f024226212542", #"hash_3c8f01422621238f", #"hash_3c8f0042262121dc", #"hash_3c8eff4226212029", #"hash_3c8efe4226211e76"];
        break;
      case # "hash_477a7859bae6c69c":
        a_str_vo = [#"hash_73b5f09f00741c93", #"hash_73b5f19f00741e46", #"hash_73b5f29f00741ff9", #"hash_73b5f39f007421ac", #"hash_73b5f49f0074235f"];
        break;
      case # "vampirism":
        a_str_vo = [#"hash_16cba1f9b1bbbd44", #"hash_16cba4f9b1bbc25d", #"hash_16cba3f9b1bbc0aa", #"hash_16cb9ef9b1bbb82b", #"hash_16cb9df9b1bbb678"];
        break;
      case # "hash_60af5025b12d8632":
        a_str_vo = [#"hash_e6c5cf563e1288f", #"hash_e6c5df563e12a42", #"hash_e6c5ef563e12bf5", #"hash_e6c57f563e12010", #"hash_e6c58f563e121c3"];
        break;
      case # "player_teleport":
        a_str_vo = [#"hash_1477c5d7a170020d", #"hash_1477c2d7a16ffcf4", #"hash_1477c3d7a16ffea7", #"hash_1477c0d7a16ff98e", #"hash_1477c1d7a16ffb41"];
        break;
      case # "new_stage":
        a_str_vo = [#"hash_84460d980b60b43", #"hash_84461d980b60cf6", #"hash_84462d980b60ea9", #"hash_84463d980b6105c", #"hash_84464d980b6120f"];
        break;
      case # "damage_light":
        a_str_vo = [#"hash_6b212dd79f25ef8b", #"hash_6b212cd79f25edd8", #"hash_6b212fd79f25f2f1", #"hash_6b212ed79f25f13e", #"hash_6b2131d79f25f657"];
        break;
      case # "damage_medium":
        a_str_vo = [#"hash_d0bd340a4220651", #"hash_d0bd240a422049e", #"hash_d0bd140a42202eb", #"hash_d0bd040a4220138", #"hash_d0bd740a4220d1d"];
        break;
      case # "throw":
        a_str_vo = [#"hash_1bdb833d450231b3", #"hash_1bdb823d45023000", #"hash_1bdb853d45023519", #"hash_1bdb843d45023366", #"hash_1bdb873d4502387f"];
        break;
      case # "laugh_short":
        a_str_vo = [#"hash_2aea19ac94d00280", #"hash_2aea1aac94d00433", #"hash_2aea1bac94d005e6", #"hash_2aea1cac94d00799", #"hash_2aea1dac94d0094c"];
        break;
      case # "laugh_long":
        a_str_vo = [#"hash_45357b5ef4a7f519", #"hash_45357a5ef4a7f366", #"hash_4535795ef4a7f1b3", #"hash_4535785ef4a7f000", #"hash_45357f5ef4a7fbe5"];
        break;
      case # "roar":
        a_str_vo = [#"hash_33fe4a8db4887c05", #"hash_33fe498db4887a52", #"hash_33fe488db488789f", #"hash_33fe478db48876ec", #"hash_33fe468db4887539"];
        break;
      case # "no":
        a_str_vo = [#"hash_70a5f453859a54bc", #"hash_70a5f553859a566f", #"hash_70a5f653859a5822", #"hash_70a5f753859a59d5", #"hash_70a5f053859a4df0"];
        break;
    }

    if(isDefined(a_str_vo)) {
      var_75a7d6.a_str_vo[str_id][#"all"] = array::randomize(a_str_vo);
      var_75a7d6.a_str_vo[str_id][#"remaining"] = arraycopy(var_75a7d6.a_str_vo[str_id][#"all"]);
    }
  }
}

function function_f83c329c(var_75a7d6, str_id, var_a78cf3d4 = 1, n_delay = 0.5, a_e_players, var_591caa3e) {
  if(!(isDefined(str_id) && isDefined(var_75a7d6) && isDefined(var_75a7d6.a_str_vo[str_id]))) {
    return;
  }

  level endon(#"end_game");
  var_75a7d6 endon(#"defeated");

  if(!var_75a7d6 flag::get(#"intro_vo_done")) {
    return;
  }

  if(n_delay > 0) {
    wait n_delay;
  }

  if(!var_a78cf3d4 && var_75a7d6 flag::get(#"priority_vo")) {
    return;
  }

  if(var_75a7d6.a_str_vo[str_id][#"remaining"].size <= 0) {
    var_75a7d6.a_str_vo[str_id][#"remaining"] = arraycopy(var_75a7d6.a_str_vo[str_id][#"all"]);
  }

  str_vo = var_75a7d6.a_str_vo[str_id][#"remaining"][0];
  arrayremoveindex(var_75a7d6.a_str_vo[str_id][#"remaining"], 0);
  var_cb85d3b5 = var_591caa3e.str_id;
  n_cooldown = var_591caa3e.n_time;
  b_cooldown = isDefined(var_cb85d3b5) && isDefined(n_cooldown);

  if(b_cooldown) {
    if(is_true(var_75a7d6.var_a6d734ec[var_cb85d3b5])) {
      return;
    }

    var_75a7d6.var_a6d734ec[var_cb85d3b5] = 1;
  }

  if(var_a78cf3d4) {
    var_75a7d6 flag::increment(#"priority_vo");

    if(!isarray(a_e_players)) {
      level zm_vo::function_7622cb70(str_vo, 0, 0);
    } else {
      arrayremovevalue(a_e_players, undefined);

      foreach(i, e_player in a_e_players) {
        if(isDefined(e_player)) {
          if(i + 1 < a_e_players.size) {
            e_player thread zm_vo::function_7622cb70(str_vo, 0, 0);
            continue;
          }

          e_player zm_vo::function_7622cb70(str_vo, 0, 0);
        }
      }
    }

    var_75a7d6 flag::decrement(#"priority_vo");
  } else {
    var_b39864d6 = var_75a7d6.var_b39864d6;

    if(isDefined(var_b39864d6)) {
      var_b39864d6 zm_vo::function_d6f8bbd9(str_vo, 0, a_e_players, 0);
    }
  }

  if(b_cooldown) {
    level thread function_dbbcebc8(var_75a7d6, var_cb85d3b5, n_cooldown);
  }
}

function function_dbbcebc8(var_75a7d6, var_cb85d3b5, n_cooldown) {
  wait n_cooldown;
  var_75a7d6.var_a6d734ec[var_cb85d3b5] = 0;
}

function function_4e595107(var_75a7d6, var_4e75ce60) {
  if(!(isDefined(var_75a7d6) && isDefined(var_4e75ce60))) {
    return;
  }

  level endon(#"end_game");
  var_75a7d6 endon(#"defeated");

  if(var_4e75ce60 == # "vampirism" || math::cointoss()) {
    function_f83c329c(var_75a7d6, var_4e75ce60);
    wait 2;
    level thread function_50dded47(var_75a7d6);
  }
}

function function_e5dc0d0d(var_75a7d6) {
  if(!isDefined(var_75a7d6) || var_75a7d6 flag::get_any([#"defeated", #"transition", #"teleport"])) {
    return;
  }

  level endon(#"end_game");
  var_75a7d6 endon(#"defeated", #"transition", #"teleport");
  n_wait = 3;

  if(isDefined(var_75a7d6.var_b53352fa)) {
    switch (var_75a7d6.var_b53352fa) {
      case 1:
        n_wait = 2;
        break;
      case 2:
        n_wait = 1;
        break;
    }
  }

  if(isDefined(n_wait) && n_wait > 0) {
    wait n_wait;
  }

  level thread function_50dded47(var_75a7d6);
}

function function_86c6df86(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime) {
  if(weapon === getweapon(#"hash_4c8d32da0a4944b9")) {
    if(self flag::get(#"hash_19b5cea3c8abadc")) {
      return 0;
    } else {
      self flag::set(#"hash_19b5cea3c8abadc");
      level thread function_dca799af(self);

      if(self armor::has_armor()) {
        self armor::apply_damage(level.weaponnone, 125, "MOD_EXPLOSIVE");

        if(self clientfield::get_to_player("" + # "hash_529b556128a8587d") < 1) {
          self clientfield::set_to_player("" + # "hash_529b556128a8587d", 1);
        }

        self addtodamageindicator(125, vdir);
        str_sound = # "mpl_hit_alert_armor_hit";
        str_rumble = # "damage_light";

        if(!self armor::has_armor()) {
          str_sound = # "mpl_hit_alert_armor_broke";
          str_rumble = # "damage_heavy";
        }

        self playsoundtoplayer(str_sound, self);
        self function_bc82f900(str_rumble);
        return 0;
      }
    }
  }

  if(self clientfield::get_to_player("" + # "hash_529b556128a8587d") > 0) {
    self clientfield::set_to_player("" + # "hash_529b556128a8587d", 0);
  }

  return self[[level.var_75a7d6.var_419e6251]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime);
}

function function_f1d7560a() {
  if(self flag::get(#"hash_28a7976f46b038e")) {
    return false;
  }

  return true;
}

function function_efebb093(var_75a7d6, str_loc = var_75a7d6.str_loc) {
  return var_75a7d6.a_s_locations[str_loc];
}

function function_223f7204(var_75a7d6, var_b39864d6) {
  level endon(#"end_game");
  var_b39864d6 endon(#"death");
  var_b39864d6 setteam(level.zombie_team);
  var_b39864d6 val::set(#"hash_33b8059f5b3f18b1", "allowdeath", 0);
  var_b39864d6 val::set(#"hash_33b8059f5b3f18b1", "takedamage", 1);
  var_b39864d6.health = 1;
  var_b39864d6.var_95ee6823 = 0.3;
  var_b39864d6.var_4165b2d7 = 1;

  while(true) {
    s_waitresult = var_b39864d6 waittill(#"damage");
    e_attacker = s_waitresult.attacker;

    if(var_75a7d6 flag::get(#"shield_down") && isPlayer(e_attacker)) {
      var_75a7d6 notify(#"boss_damage", s_waitresult);
      damage = s_waitresult.amount;
      weapon = s_waitresult.weapon;
      inflictor = s_waitresult.inflictor;
      flags = s_waitresult.flags;
      meansofdeath = s_waitresult.mod;
      var_fd90b0bb = s_waitresult.var_fd90b0bb;
      vpoint = s_waitresult.position;
      vdir = s_waitresult.direction;
      shitloc = s_waitresult.shitloc;
      psoffsettime = s_waitresult.psoffsettime;
      boneindex = s_waitresult.boneindex;
      surfacetype = s_waitresult.surfacetype;

      if(damage <= 1 && namespace_1e7573ec::function_5885758(weapon)) {
        continue;
      }

      var_db2a8c7a = 1;

      if(var_75a7d6 flag::get_any([#"vampirism", #"transition", #"teleport"])) {
        var_db2a8c7a = 4;
        damage = 0;
      } else {
        damage = var_b39864d6 get_weapon_damage(inflictor, e_attacker, damage, flags, meansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);

        if(!is_wonder_weapon(weapon)) {
          var_6e859516 = function_51846e52(meansofdeath, weapon);

          if(isDefined(var_6e859516) && damage > var_6e859516) {
            damage = var_6e859516;
          }
        }
      }

      var_51de3a6c = 0;
      var_d4fd9284 = var_75a7d6.var_3f956940 - damage;

      if(!var_75a7d6 flag::get(#"transition_started") && var_d4fd9284 <= var_75a7d6.var_f65dc5e1) {
        var_75a7d6 flag::set(#"transition_started");
        level thread function_1db59d97(var_75a7d6);
        var_75a7d6.var_3f956940 = var_75a7d6.var_f65dc5e1;
      } else if(!var_75a7d6 flag::get(#"should_die") && var_d4fd9284 <= var_75a7d6.var_1847f53d) {
        level thread function_b2871ce6(var_75a7d6);
        var_75a7d6.var_3f956940 = var_75a7d6.var_1847f53d;
        var_75a7d6.n_threshold = var_75a7d6.var_1847f53d;
        var_75a7d6.var_1847f53d = var_75a7d6.n_threshold - var_75a7d6.var_4fb7caaf;
      } else {
        var_75a7d6.var_3f956940 -= damage;

        if(var_75a7d6.var_3f956940 <= 0) {
          var_51de3a6c = 1;
        }
      }

      level thread hud::function_c9800094(e_attacker, vpoint, damage, var_db2a8c7a);

      if(damage > 0) {
        e_attacker thread damagefeedback::update(meansofdeath, e_attacker, undefined, weapon, var_b39864d6, psoffsettime, shitloc, var_51de3a6c, flags, 0);
        str_vo = # "damage_light";

        if(var_75a7d6 flag::get(#"hash_482d5322e3bb32d3") && damage >= 1500) {
          str_vo = # "damage_medium";
        }

        level thread function_f83c329c(var_75a7d6, str_vo, 0, 0, undefined, {
          #str_id: # "damage", #n_time: randomfloatrange(6, 9)
        });
      }

      function_73f95a0c(var_75a7d6);

      if(var_51de3a6c) {
        break;
      }
    }
  }

  var_75a7d6 flag::set(#"defeated");
}

function is_wonder_weapon(w_weapon) {
  if(isDefined(w_weapon)) {
    if(zm_weapons::is_wonder_weapon(w_weapon)) {
      return true;
    }

    w_root = zm_weapons::function_386dacbc(w_weapon);
    w_ray_gun = getweapon(#"ray_gun");
    var_294057a4 = getweapon(#"ray_gun_upgraded");

    if(w_root === w_ray_gun || w_root === var_294057a4) {
      return true;
    }
  }

  return false;
}

function function_73f95a0c(var_75a7d6) {
  var_3f956940 = var_75a7d6.var_3f956940;
  var_8d31700f = var_75a7d6.var_8d31700f;

  if(!(isDefined(var_3f956940) && isDefined(var_8d31700f))) {
    return;
  }

  n_health_percent = var_3f956940 / var_8d31700f;

  if(n_health_percent < 0) {
    n_health_percent = 0;
  } else if(n_health_percent > 1) {
    n_health_percent = 1;
  }

  if(isint(n_health_percent) || isfloat(n_health_percent)) {
    foreach(e_player in getplayers()) {
      if(level.var_ecc60e04 zm_corrupted_health_bar::is_open(e_player)) {
        level.var_ecc60e04 zm_corrupted_health_bar::set_health(e_player, n_health_percent);
      }
    }
  }
}

function function_ab3592be(var_75a7d6, var_b39864d6) {
  level endon(#"end_game");
  var_75a7d6 endon(#"defeated", #"shield_delete");
  var_b39864d6 endon(#"death");

  while(true) {
    var_75a7d6.mdl_shield = spawncollision(#"collision_bullet_128x128x128", "mdl_showdown_block", var_b39864d6.origin + (0, 0, 28), var_b39864d6.angles);

    if(isDefined(var_75a7d6.mdl_shield)) {
      break;
    }

    waitframe(1);
  }

  mdl_shield = var_75a7d6.mdl_shield;
  mdl_shield clientfield::set("" + # "hash_4a7733d2f4b25e81", 1);
  mdl_shield setteam(level.zombie_team);
  mdl_shield val::set(#"hash_367879f79a1812c9", "allowdeath", 0);
  mdl_shield val::set(#"hash_367879f79a1812c9", "takedamage", 1);
  mdl_shield.health = 1;
  mdl_shield.var_95ee6823 = 0.3;
  mdl_shield.var_4165b2d7 = 1;

  while(true) {
    while(true) {
      s_waitresult = mdl_shield waittill(#"damage");
      e_attacker = s_waitresult.attacker;

      if(isPlayer(e_attacker)) {
        var_75a7d6 notify(#"shield_damage", s_waitresult);
        damage = s_waitresult.amount;
        weapon = s_waitresult.weapon;
        inflictor = s_waitresult.inflictor;
        flags = s_waitresult.flags;
        meansofdeath = s_waitresult.mod;
        var_fd90b0bb = s_waitresult.var_fd90b0bb;
        vpoint = s_waitresult.position;
        vdir = s_waitresult.direction;
        shitloc = s_waitresult.shitloc;
        psoffsettime = s_waitresult.psoffsettime;
        boneindex = s_waitresult.boneindex;
        surfacetype = s_waitresult.surfacetype;

        if(damage <= 1 && namespace_1e7573ec::function_5885758(weapon)) {
          continue;
        }

        var_db2a8c7a = 3;

        if(var_75a7d6 flag::get_any([#"vampirism", #"transition", #"teleport"])) {
          var_db2a8c7a = 4;
          damage = 0;
        } else {
          damage = var_b39864d6 get_weapon_damage(inflictor, e_attacker, damage, flags, meansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);

          if(!is_wonder_weapon(weapon)) {
            var_6e859516 = function_51846e52(meansofdeath, weapon);

            if(isDefined(var_6e859516) && damage > var_6e859516) {
              damage = var_6e859516;
            }
          }
        }

        var_75a7d6.var_9428def3 -= damage;
        var_5f752cb0 = var_75a7d6.var_9428def3 <= 0;
        function_f3ac29fc(var_75a7d6);
        level thread hud::function_c9800094(e_attacker, vpoint, damage, var_db2a8c7a);

        if(var_5f752cb0) {
          mdl_shield.var_426947c4 = 1;
        } else {
          mdl_shield.var_426947c4 = undefined;
        }

        if(damage > 0) {
          var_fe886504 = "armor";

          if(var_5f752cb0) {
            var_fe886504 = "armorBroke";
          }

          e_attacker thread damagefeedback::update(meansofdeath, e_attacker, var_fe886504, weapon, mdl_shield, psoffsettime, shitloc, var_5f752cb0, 2048, 0);
        }

        if(isDefined(vpoint) && isDefined(vdir)) {
          playFX(#"hash_3e61e24b62e33593", vpoint, anglesToForward(vdir), anglestoup(vdir));
        }

        if(var_5f752cb0) {
          break;
        }
      }
    }

    level thread shield_break(var_75a7d6);
    level thread function_f83c329c(var_75a7d6, #"no", 0);
    var_75a7d6 flag::wait_till_clear(#"shield_down");
  }
}

function shield_break(var_75a7d6) {
  if(!var_75a7d6 flag::get_any([#"transition", #"teleport"])) {
    mdl_shield = var_75a7d6.mdl_shield;

    if(isDefined(mdl_shield)) {
      mdl_shield playSound(#"hash_39abfdd8403c8edd");
    }

    function_1798a522(var_75a7d6);
    var_75a7d6 flag::increment(#"hash_1e2734204ab845a2");
    var_75a7d6 flag::wait_till_any_timeout(10, [#"transition", #"teleport"]);
    var_75a7d6 flag::decrement(#"hash_1e2734204ab845a2");

    if(!var_75a7d6 flag::get_any([#"transition", #"teleport"])) {
      function_38e49607(var_75a7d6, 1);
    }
  }
}

function function_f3ac29fc(var_75a7d6) {
  var_9428def3 = var_75a7d6.var_9428def3;
  var_200c676a = var_75a7d6.var_200c676a;

  if(!(isDefined(var_9428def3) && isDefined(var_200c676a))) {
    return;
  }

  var_c776ac13 = var_9428def3 / var_200c676a;

  if(var_c776ac13 < 0) {
    var_c776ac13 = 0;
  } else if(var_c776ac13 > 1) {
    var_c776ac13 = 1;
  }

  if(isint(var_c776ac13) || isfloat(var_c776ac13)) {
    foreach(e_player in getplayers()) {
      if(level.var_ecc60e04 zm_corrupted_health_bar::is_open(e_player)) {
        level.var_ecc60e04 zm_corrupted_health_bar::set_armor(e_player, var_c776ac13);
      }
    }
  }
}

function function_1798a522(var_75a7d6 = level.var_75a7d6, var_5749d3fa = 1) {
  if(!isDefined(var_75a7d6) || var_75a7d6 flag::get_any([#"transition", #"teleport"])) {
    return;
  }

  b_first = !var_75a7d6 flag::get(#"shield_down");
  var_75a7d6 flag::increment(#"shield_down");

  if(b_first) {
    if(var_5749d3fa) {
      foreach(e_player in getplayers()) {
        if(level.var_ecc60e04 zm_corrupted_health_bar::is_open(e_player)) {
          level.var_ecc60e04 zm_corrupted_health_bar::function_74adcd8a(e_player, 0);
        }
      }
    }

    mdl_shield = var_75a7d6.mdl_shield;

    if(isDefined(mdl_shield)) {
      mdl_shield clientfield::set("" + # "hash_4a7733d2f4b25e81", 0);
      mdl_shield notsolid();
    }
  }
}

function function_38e49607(var_75a7d6 = level.var_75a7d6, var_352159a3 = 0) {
  if(!isDefined(var_75a7d6) || !var_75a7d6 flag::get(#"shield_down") || var_75a7d6 flag::get_any([#"transition", #"teleport", #"defeated"])) {
    return;
  }

  var_75a7d6 flag::decrement(#"shield_down");

  if(var_352159a3) {
    var_75a7d6 flag::set(#"hash_38dc6934b44dba09");
  }

  if(!var_75a7d6 flag::get(#"shield_down")) {
    if(var_75a7d6 flag::get(#"hash_38dc6934b44dba09")) {
      var_75a7d6 flag::clear(#"hash_38dc6934b44dba09");
      var_75a7d6.var_9428def3 = var_75a7d6.var_200c676a;
      function_f3ac29fc(var_75a7d6);
    }

    foreach(e_player in getplayers()) {
      if(level.var_ecc60e04 zm_corrupted_health_bar::is_open(e_player)) {
        level.var_ecc60e04 zm_corrupted_health_bar::function_74adcd8a(e_player, 1);
      }
    }

    mdl_shield = var_75a7d6.mdl_shield;

    if(isDefined(mdl_shield)) {
      mdl_shield clientfield::set("" + # "hash_4a7733d2f4b25e81", 1);
      mdl_shield solid();
    }
  }
}

function function_5f36e356(n_health_min, n_health_max) {
  n_round = level.round_number;

  if(!isDefined(n_round)) {
    n_round = 20;
  }

  if(n_round < 20) {
    n_round = 20;
  } else if(n_round > 50) {
    n_round = 50;
  }

  n_percent = 1 - (50 - n_round) / 30;

  if(n_percent < 0) {
    n_percent = 0;
  } else if(n_percent > 1) {
    n_percent = 1;
  }

  n_players = getplayers().size;

  if(n_players < 1) {
    n_players = 1;
  } else if(n_players > 4) {
    n_players = 4;
  }

  var_1bb081d7 = 1 + (n_players - 1) * 0.5;

  if(n_health_min < n_health_max) {
    var_c835c552 = int(lerpfloat(n_health_min, n_health_max, n_percent) * var_1bb081d7);
  } else {
    var_c835c552 = int(n_health_min * var_1bb081d7);
  }

  return var_c835c552;
}

function get_weapon_damage(inflictor, attacker, damage, flags, meansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(weapon.offhandslot === "Tactical grenade" || weapon.offhandslot === "Lethal grenade" || weapon.offhandslot === "Special" || killstreaks::is_killstreak_weapon(weapon)) {
    if(!zm_equipment::function_4f51b6ea(weapon, meansofdeath) && meansofdeath !== "MOD_MELEE") {
      damage = zm_equipment::function_379f6b5d(damage);

      if(killstreaks::is_killstreak_weapon(weapon)) {
        damage *= 0.5;

        if(weapon.firetype === "Minigun") {
          damage *= 0.5;
        }
      } else {
        damage *= 0.1;
      }
    }
  }

  item = attacker item_inventory::function_230ceec4(weapon);

  if(isDefined(item)) {
    var_528363fd = self namespace_b61a349a::function_b3496fde(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
    damage += var_528363fd;

    if(meansofdeath != "MOD_MELEE") {
      var_4d1602de = zm_weapons::function_d85e6c3a(item.itementry);
      damage *= var_4d1602de;

      if(isDefined(item.paplv)) {
        var_645b8bb = zm_weapons::function_896671d5(item.itementry.weapon, item.paplv);
        damage *= var_645b8bb;
      }
    }
  } else {
    var_fd72ea28 = self namespace_b61a349a::function_b3496fde(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
    damage += var_fd72ea28;
  }

  damage = namespace_1b527536::actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);

  if(is_wonder_weapon(weapon)) {
    damage *= 0.3;
  }

  return int(damage);
}

function function_51846e52(meansofdeath, weapon) {
  if(meansofdeath === "MOD_HEAD_SHOT" || meansofdeath === "MOD_RIFLE_BULLET" || meansofdeath === "MOD_PISTOL_BULLET") {
    var_6e859516 = 1500;
  } else if(weapon.guidedmissiletype === "Ballistic") {
    var_6e859516 = 1500;
  } else {
    var_6e859516 = 3000;
  }

  return var_6e859516;
}

function teleport_players(var_a347ab1) {
  a_players = getplayers();

  for(i = 0; i < a_players.size; i++) {
    a_players[i] setorigin(var_a347ab1[i].origin);
    a_players[i] setplayerangles(var_a347ab1[i].angles);
  }
}

function function_2954a39(var_75a7d6, str_loc, script_int) {
  s_loc = function_efebb093(var_75a7d6, str_loc);

  if(!isDefined(s_loc)) {
    return;
  }

  var_9c98cb64 = s_loc.var_9c98cb64;

  if(!isDefined(script_int)) {
    return array::random(var_9c98cb64);
  }

  return var_9c98cb64[script_int];
}

function function_4e3080f5(s_loc) {
  return isDefined(s_loc.var_ae9d791b) ? s_loc.var_ae9d791b : [];
}

function function_edac342b(s_loc) {
  return isDefined(s_loc.var_1619fc2f) ? s_loc.var_1619fc2f : [];
}

function function_c3d468b5(s_loc) {
  return isDefined(s_loc.var_cafd3f7e) ? s_loc.var_cafd3f7e : [];
}

function function_ff441bfb(var_75a7d6, str_loc) {
  s_loc = function_efebb093(var_75a7d6, str_loc);

  if(!isDefined(s_loc)) {
    return;
  }

  foreach(var_a793a9c7 in function_4e3080f5(s_loc)) {
    var_a793a9c7 solid();
  }

  foreach(s_fx in function_edac342b(s_loc)) {
    s_fx.mdl_fx = util::spawn_model(#"tag_origin", s_fx.origin, s_fx.angles);
    n_cf = 1;

    if(is_true(s_fx.single)) {
      n_cf = 2;
    }

    s_fx.mdl_fx clientfield::set("" + # "hash_2951f2625695bd6b", n_cf);
  }

  switch (str_loc) {
    case # "hash_24f8b14e0d7981e2":
      level clientfield::set("" + # "hash_4b15b3ade2772206", 1);
      break;
    case # "hash_56100f3e34a790d":
      level clientfield::set("" + # "hash_4b15b3ade2772206", 2);
      break;
  }

  function_9551a49a(var_75a7d6);

  foreach(s_fx in function_c3d468b5(s_loc)) {
    s_fx.mdl_fx = util::spawn_model(#"tag_origin", s_fx.origin, s_fx.angles);
    s_fx.mdl_fx clientfield::set("" + # "hash_7cd1cb3f455a77cf", 1);
  }

  vol_arena = s_loc.vol_arena;
  namespace_1fd59e39::function_4a05e25f(vol_arena);
  level.var_22a21403 = vol_arena;
  level.var_fe1757e7 = function_8b2a124(s_loc);
}

function function_9551a49a(var_75a7d6) {
  if(!isDefined(var_75a7d6) || var_75a7d6 flag::get(#"hash_50fbdf41e8f4ac1c")) {
    return;
  }

  var_75a7d6 flag::set(#"hash_50fbdf41e8f4ac1c");
  var_464f7d1e = arraycopy(isDefined(level.var_8e1ba65f) ? level.var_8e1ba65f : []);
  var_de56fc3d = arraycopy(isDefined(level.ascendstructs) ? level.ascendstructs : []);
  var_307e1fc6 = arraycombine(var_464f7d1e, var_de56fc3d);

  foreach(var_74edb1d5 in var_307e1fc6) {
    t_trigger = var_74edb1d5.trigger;

    if(isDefined(t_trigger)) {
      t_trigger.origin -= (0, 0, 5000);
    }
  }
}

function function_f4cfe3a3(var_75a7d6) {
  if(!isDefined(var_75a7d6) || !var_75a7d6 flag::get(#"hash_50fbdf41e8f4ac1c")) {
    return;
  }

  var_75a7d6 flag::clear(#"hash_50fbdf41e8f4ac1c");
  var_464f7d1e = arraycopy(isDefined(level.var_8e1ba65f) ? level.var_8e1ba65f : []);
  var_de56fc3d = arraycopy(isDefined(level.ascendstructs) ? level.ascendstructs : []);
  var_307e1fc6 = arraycombine(var_464f7d1e, var_de56fc3d);

  foreach(var_74edb1d5 in var_307e1fc6) {
    t_trigger = var_74edb1d5.trigger;

    if(isDefined(t_trigger)) {
      t_trigger.origin += (0, 0, 5000);
    }
  }
}

function function_c860cfeb(var_75a7d6, str_loc) {
  s_loc = function_efebb093(var_75a7d6, str_loc);

  if(!isDefined(s_loc)) {
    return;
  }

  foreach(s_fx in function_edac342b(s_loc)) {
    if(isDefined(s_fx.mdl_fx)) {
      s_fx.mdl_fx clientfield::set("" + # "hash_2951f2625695bd6b", 0);
      s_fx.mdl_fx thread util::delayed_delete(1);
      s_fx.mdl_fx = undefined;
    }
  }

  foreach(var_a793a9c7 in function_4e3080f5(s_loc)) {
    var_a793a9c7 notsolid();
  }

  level clientfield::set("" + # "hash_4b15b3ade2772206", 0);
  function_f4cfe3a3(var_75a7d6);

  foreach(s_fx in function_c3d468b5(s_loc)) {
    if(isDefined(s_fx.mdl_fx)) {
      s_fx.mdl_fx clientfield::set("" + # "hash_7cd1cb3f455a77cf", 0);
      s_fx.mdl_fx thread util::delayed_delete(1);
      s_fx.mdl_fx = undefined;
    }
  }

  namespace_1fd59e39::function_faa74262(s_loc.vol_arena);
  level.var_22a21403 = undefined;
  level.var_fe1757e7 = undefined;
}

function function_5c1c7b14(var_75a7d6) {
  level endon(#"end_game");
  var_75a7d6 endon(#"defeated", #"stop_spawns");

  while(true) {
    var_1c869e1 = getaicount();

    if(!var_75a7d6 flag::get(#"hash_1e2734204ab845a2") && var_1c869e1 < getailimit() && var_1c869e1 < level.zombie_ai_limit && var_1c869e1 < var_75a7d6.var_de4a9f7a) {
      var_949e9e59 = function_544d0383(var_75a7d6);

      if(isstruct(var_949e9e59)) {
        str_ai = var_949e9e59.str_ai;
        s_spawn = var_949e9e59.s_spawn;

        if(isDefined(str_ai) && isDefined(s_spawn)) {
          switch (str_ai) {
            case # "mechz":
              ai_spawned = zm_ai_mechz::spawn_single(1, s_spawn);
              break;
            case # "disciple":
              ai_spawned = zm_ai_soa::function_e803632f(1, s_spawn);
              break;
            case # "tempest":
              ai_spawned = zm_ai_avogadro::spawn_single(1, s_spawn);
              break;
            case # "raz":
              ai_spawned = zm_ai_raz::spawn_single(1, s_spawn);
              break;
            case # "zombie":
              sp_zombie = zm_platinum::function_ddc13fd6();

              if(isDefined(sp_zombie)) {
                ai_spawned = zombie_utility::spawn_zombie(sp_zombie, undefined, s_spawn);
              }

              break;
          }

          if(isDefined(ai_spawned)) {
            level thread function_6ea14df0(var_75a7d6, str_ai);

            if(str_ai == # "zombie") {
              if(!isDefined(var_75a7d6.var_6359299f)) {
                var_75a7d6.var_6359299f = [];
              } else if(!isarray(var_75a7d6.var_6359299f)) {
                var_75a7d6.var_6359299f = array(var_75a7d6.var_6359299f);
              }

              var_75a7d6.var_6359299f[var_75a7d6.var_6359299f.size] = ai_spawned;
            }
          }
        }
      }
    }

    wait 1;
  }
}

function function_a831c582(str_ai) {
  if(!isDefined(str_ai)) {
    return;
  }

  n_players = getplayers().size;

  if(n_players < 1) {
    n_players = 1;
  } else if(n_players > 4) {
    n_players = 4;
  }

  switch (str_ai) {
    case # "mechz":
      switch (n_players) {
        case 1:
          n_time = 120;
          break;
        case 2:
          n_time = 120;
          break;
        case 3:
          n_time = 90;
          break;
        case 4:
          n_time = 90;
          break;
      }

      return {
        #str_flag: # "mechz_disabled", #n_time: n_time
      };
    case # "disciple":
      switch (n_players) {
        case 1:
          n_time = 20;
          break;
        case 2:
          n_time = 20;
          break;
        case 3:
          n_time = 10;
          break;
        case 4:
          n_time = 10;
          break;
      }

      return {
        #str_flag: # "hash_25f8eaaceeb93d67", #n_time: n_time
      };
    case # "tempest":
      switch (n_players) {
        case 1:
          n_time = 20;
          break;
        case 2:
          n_time = 20;
          break;
        case 3:
          n_time = 10;
          break;
        case 4:
          n_time = 10;
          break;
      }

      return {
        #str_flag: # "tempest_disabled", #n_time: n_time
      };
    case # "raz":
      switch (n_players) {
        case 1:
          n_time = 20;
          break;
        case 2:
          n_time = 20;
          break;
        case 3:
          n_time = 10;
          break;
        case 4:
          n_time = 10;
          break;
      }

      return {
        #str_flag: # "hash_88667c18a4cff07", #n_time: n_time
      };
  }
}

function function_6ea14df0(var_75a7d6, str_ai) {
  level endon(#"end_game");
  var_591caa3e = function_a831c582(str_ai);
  str_flag = var_591caa3e.str_flag;
  n_time = var_591caa3e.n_time;

  if(!(isDefined(str_flag) && isDefined(n_time))) {
    return;
  }

  var_75a7d6 flag::set(str_flag);
  wait n_time;
  var_75a7d6 flag::clear(str_flag);
}

function function_544d0383(var_75a7d6) {
  n_players = getplayers().size;

  if(n_players < 1) {
    n_players = 1;
  } else if(n_players > 4) {
    n_players = 4;
  }

  if(math::cointoss(5)) {
    var_591caa3e = function_a831c582(#"mechz");
    str_flag = var_591caa3e.str_flag;

    if(!isDefined(str_flag) || !var_75a7d6 flag::get(str_flag)) {
      switch (n_players) {
        case 1:
          var_5211199d = 1;
          break;
        case 2:
          var_5211199d = 1;
          break;
        case 3:
          var_5211199d = 2;
          break;
        case 4:
          var_5211199d = 2;
          break;
      }

      if(isDefined(var_5211199d) && getaiarchetypearray(#"mechz").size < var_5211199d) {
        s_spawn = zm_platinum::function_65c98960(0);

        if(isstruct(s_spawn)) {
          return {
            #str_ai: # "mechz", #s_spawn: s_spawn
          };
        }
      }
    }
  }

  if(math::cointoss(5)) {
    var_591caa3e = function_a831c582(#"disciple");
    str_flag = var_591caa3e.str_flag;

    if(!isDefined(str_flag) || !var_75a7d6 flag::get(str_flag)) {
      switch (n_players) {
        case 1:
          var_1010e70f = 2;
          break;
        case 2:
          var_1010e70f = 2;
          break;
        case 3:
          var_1010e70f = 3;
          break;
        case 4:
          var_1010e70f = 3;
          break;
      }

      if(isDefined(var_1010e70f) && getaiarchetypearray(#"soa").size < var_1010e70f) {
        s_spawn = zm_platinum::function_41a4961d(0);

        if(isstruct(s_spawn)) {
          return {
            #str_ai: # "disciple", #s_spawn: s_spawn
          };
        }
      }
    }
  }

  if(math::cointoss(5)) {
    var_591caa3e = function_a831c582(#"tempest");
    str_flag = var_591caa3e.str_flag;

    if(!isDefined(str_flag) || !var_75a7d6 flag::get(str_flag)) {
      switch (n_players) {
        case 1:
          var_73489a82 = 2;
          break;
        case 2:
          var_73489a82 = 2;
          break;
        case 3:
          var_73489a82 = 3;
          break;
        case 4:
          var_73489a82 = 3;
          break;
      }

      if(isDefined(var_73489a82) && getaiarchetypearray(#"avogadro").size < var_73489a82) {
        s_spawn = zm_platinum::function_d9f5ec34(0);

        if(isstruct(s_spawn)) {
          return {
            #str_ai: # "tempest", #s_spawn: s_spawn
          };
        }
      }
    }
  }

  if(math::cointoss(5)) {
    var_591caa3e = function_a831c582(#"raz");
    str_flag = var_591caa3e.str_flag;

    if(!isDefined(str_flag) || !var_75a7d6 flag::get(str_flag)) {
      switch (n_players) {
        case 1:
          var_cd1a1fde = 1;
          break;
        case 2:
          var_cd1a1fde = 1;
          break;
        case 3:
          var_cd1a1fde = 2;
          break;
        case 4:
          var_cd1a1fde = 2;
          break;
      }

      if(isDefined(var_cd1a1fde) && getaiarchetypearray(#"raz").size < var_cd1a1fde) {
        s_spawn = zm_platinum::function_d9f5ec34(0);

        if(isstruct(s_spawn)) {
          return {
            #str_ai: # "raz", #s_spawn: s_spawn
          };
        }
      }
    }
  }

  a_s_spawns = level.zm_loc_types[#"zombie_location"];

  if(isarray(a_s_spawns)) {
    s_spawn = array::random(a_s_spawns);

    if(isstruct(s_spawn)) {
      return {
        #str_ai: # "zombie", #s_spawn: s_spawn
      };
    }
  }
}

function function_4cc9e609(var_75a7d6 = level.var_75a7d6) {
  if(isDefined(var_75a7d6)) {
    var_75a7d6.var_de4a9f7a--;
    function_886e403b(var_75a7d6);
  }
}

function function_a0f1fc1d(var_75a7d6 = level.var_75a7d6) {
  if(isDefined(var_75a7d6)) {
    var_75a7d6.var_de4a9f7a++;
  }
}

function function_886e403b(var_75a7d6) {
  if(getaicount() >= var_75a7d6.var_de4a9f7a) {
    var_d83a65d4 = 0;
    function_1eaaceab(var_75a7d6.var_6359299f);

    foreach(ai_zombie in var_75a7d6.var_6359299f) {
      if(isalive(ai_zombie)) {
        b_can_see = 0;

        foreach(e_player in function_a1ef346b()) {
          if(e_player zm_utility::is_player_looking_at(ai_zombie.origin, undefined, 0, e_player)) {
            b_can_see = 1;
            break;
          }
        }

        if(!b_can_see) {
          ai_cleanup = ai_zombie;
          break;
        }

        var_d83a65d4++;

        if(var_d83a65d4 % 5 == 0) {
          waitframe(1);
        }
      }
    }

    if(!isDefined(ai_cleanup)) {
      function_1eaaceab(var_75a7d6.var_6359299f);
      ai_cleanup = array::random(var_75a7d6.var_6359299f);
    }

    if(isDefined(ai_cleanup)) {
      ai_cleanup deletedelay();

      while(isDefined(ai_cleanup)) {
        waitframe(1);
      }
    }
  }
}

function function_73ef29bf(var_75a7d6, var_9161d39c = # "", var_b6ada9ed = 0) {
  level endon(#"end_game");
  var_75a7d6 endon(#"transition", #"teleport", #"defeated");

  if(var_75a7d6 flag::get_any([#"transition", #"teleport", #"defeated"])) {
    return;
  }

  n_wait = 6;

  if(var_b6ada9ed) {
    wait 3;
  } else {
    if(isDefined(var_75a7d6.var_b53352fa)) {
      switch (var_75a7d6.var_b53352fa) {
        case 1:
          n_wait = 5;
          break;
        case 2:
          n_wait = 4;
          break;
      }
    }

    switch (var_9161d39c) {
      case # "teleport":
        n_wait = 1;
        break;
    }
  }

  if(isDefined(n_wait) && n_wait > 0) {
    wait n_wait;
  }

  if(var_9161d39c != # "") {
    var_75a7d6 flag::set(#"hash_53f03da53102f4ff");
    var_75a7d6 flag::set(#"hash_3948a1aa982807f2");
    var_75a7d6 flag::set(#"hash_2d61f4f9fee67c9a");
  }

  if(var_75a7d6 flag::get(#"hash_53f03da53102f4ff") && !var_75a7d6 flag::get_any([#"hash_39316cd070ab8069", #"shield_down"]) && math::cointoss(100) && var_75a7d6.var_3f956940 <= var_75a7d6.n_threshold - var_75a7d6.var_63b86490) {
    if(var_9161d39c != # "vampirism" || var_75a7d6.var_b689f2ee[#"vampirism"] < 0) {
      var_75a7d6 flag::set(#"hash_39316cd070ab8069");
      level thread function_a094b1fc(var_75a7d6);

      if(var_9161d39c == # "vampirism") {
        var_75a7d6.var_b689f2ee[#"vampirism"]++;
      }

      return;
    }
  }

  var_75a7d6.var_b689f2ee[#"vampirism"] = 0;

  if(var_75a7d6 flag::get(#"hash_61acfc7a3e200ce3") && var_75a7d6.str_loc !== # "hash_24f8b14e0d7981e2" && !var_75a7d6 flag::get(#"hash_3b3cca2339e6043d") && math::cointoss(75)) {
    if(var_9161d39c != # "hash_6a3f96f46648766d" || var_75a7d6.var_b689f2ee[#"hash_6a3f96f46648766d"] < 0) {
      var_75a7d6 flag::set(#"hash_3b3cca2339e6043d");
      level thread function_101fd34c(var_75a7d6);

      if(var_9161d39c == # "hash_6a3f96f46648766d") {
        var_75a7d6.var_b689f2ee[#"hash_6a3f96f46648766d"]++;
      }

      return;
    }
  }

  var_75a7d6.var_b689f2ee[#"hash_6a3f96f46648766d"] = 0;

  if(var_75a7d6 flag::get(#"hash_3948a1aa982807f2") && !var_75a7d6 flag::get(#"hash_137c7612417b56ec") && math::cointoss(75)) {
    if(var_9161d39c != # "hash_477a7859bae6c69c" || var_75a7d6.var_b689f2ee[#"hash_477a7859bae6c69c"] < 1) {
      e_target = function_975a5a48(var_75a7d6);

      if(isPlayer(e_target)) {
        var_75a7d6 flag::set(#"hash_137c7612417b56ec");
        level thread function_5e042438(var_75a7d6, e_target);

        if(var_9161d39c == # "hash_477a7859bae6c69c") {
          var_75a7d6.var_b689f2ee[#"hash_477a7859bae6c69c"]++;
        }

        return;
      }
    }
  }

  var_75a7d6.var_b689f2ee[#"hash_477a7859bae6c69c"] = 0;

  if(var_75a7d6 flag::get(#"hash_2d61f4f9fee67c9a") && !var_75a7d6 flag::get(#"hash_5b18d00f994c17a4") && math::cointoss(100)) {
    if(var_9161d39c != # "hash_9754b045afe5254" || var_75a7d6.var_b689f2ee[#"hash_9754b045afe5254"] < 0) {
      var_75a7d6 flag::set(#"hash_5b18d00f994c17a4");
      level thread function_8f60088e(var_75a7d6);

      if(var_9161d39c == # "hash_9754b045afe5254") {
        var_75a7d6.var_b689f2ee[#"hash_9754b045afe5254"]++;
      }

      return;
    }
  }

  var_75a7d6.var_b689f2ee[#"hash_9754b045afe5254"] = 0;
  level thread function_50dded47(var_75a7d6);
  level thread function_73ef29bf(var_75a7d6, var_9161d39c, 1);
}

function function_50dded47(var_75a7d6) {
  if(!isDefined(var_75a7d6) || !math::cointoss(30) || !var_75a7d6 flag::get(#"attacking") && var_75a7d6 flag::get(#"shield_down")) {
    return;
  }

  str_vo = # "laugh_short";

  if(math::cointoss()) {
    str_vo = # "laugh_long";
  }

  level thread function_f83c329c(var_75a7d6, str_vo, 0, 0);
}

function function_84f9cc2e(var_75a7d6, str_flag = # "", n_cooldown = 0) {
  level endon(#"end_game");

  if(!isDefined(var_75a7d6) || str_flag == # "") {
    return;
  }

  var_75a7d6 endon(#"defeated");

  if(n_cooldown > 0) {
    wait n_cooldown;
  }

  var_75a7d6 flag::clear(str_flag);
}

function function_1db59d97(var_75a7d6) {
  level endon(#"end_game");
  var_75a7d6 flag::set(#"transition");
  var_75a7d6 flag::increment(#"hash_1e2734204ab845a2");
  var_a12bf98c = var_75a7d6.var_a12bf98c;
  function_761d8ea1(var_75a7d6, var_a12bf98c, 1);
  var_75a7d6 notify(#"shield_delete");
  mdl_shield = var_75a7d6.mdl_shield;

  if(isDefined(mdl_shield)) {
    mdl_shield clientfield::set("" + # "hash_4a7733d2f4b25e81", 0);
    mdl_shield notsolid();
    mdl_shield thread util::delayed_delete(1);
  }

  if(var_75a7d6 flag::get(#"shield_down")) {
    var_75a7d6.var_9428def3 = var_75a7d6.var_200c676a;
    function_f3ac29fc(var_75a7d6);
  }

  var_75a7d6 flag::function_c58ecb49(#"shield_down");
  var_75a7d6 flag::set(#"shield_down");

  foreach(e_player in getplayers()) {
    if(level.var_ecc60e04 zm_corrupted_health_bar::is_open(e_player)) {
      level.var_ecc60e04 zm_corrupted_health_bar::function_74adcd8a(e_player, 1);
    }
  }

  wait 1;

  if(var_75a7d6 flag::get(#"attacking")) {
    var_75a7d6 flag::wait_till_clear(#"attacking");
    wait 1;
  }

  var_b39864d6 = var_75a7d6.var_b39864d6;
  level thread function_b03f9b73(var_75a7d6, var_a12bf98c, var_b39864d6);
  var_b39864d6 scene::play(#"hash_63636406a7a2326", "phase_transition", var_b39864d6);
  var_b39864d6 thread scene::play(#"hash_63636406a7a2326", "stand_idle", var_b39864d6);
  function_761d8ea1(var_75a7d6, var_a12bf98c, 0);
  var_75a7d6 flag::function_c58ecb49(#"shield_down");
  var_75a7d6 flag::clear(#"transition");
  level thread function_ab3592be(var_75a7d6, var_b39864d6);

  if(isDefined(var_a12bf98c)) {
    var_a12bf98c hidepart("throne_hide_jnt", "", 1);
  }

  var_75a7d6 flag::set(#"hash_482d5322e3bb32d3");
  var_75a7d6 flag::decrement(#"hash_1e2734204ab845a2");
  var_75a7d6 flag::clear(#"hash_137c7612417b56ec");
  var_75a7d6 flag::clear(#"hash_5b18d00f994c17a4");
  level thread function_73ef29bf(var_75a7d6, #"transition");
}

function function_b03f9b73(var_75a7d6, var_a12bf98c, var_b39864d6) {
  if(!(isDefined(var_a12bf98c) && isDefined(var_75a7d6) && isDefined(var_b39864d6))) {
    return;
  }

  level endon(#"end_game");
  var_75a7d6 endon(#"defeated", #"hash_482d5322e3bb32d3");
  var_a12bf98c endon(#"death");
  var_b39864d6 endon(#"death");
  level waittill(#"hash_1e4fb5bd4a9d21cf");
  level thread function_f83c329c(var_75a7d6, #"roar", 0, 0);
  level thread function_4f440b0(var_75a7d6, 1);
  var_a12bf98c hidepart("throne_hide_jnt", "", 1);
  var_a12bf98c playSound(#"hash_20b2dcab06a36a51");
}

function function_4f440b0(var_75a7d6, var_7ca1e76e = 0) {
  var_b39864d6 = var_75a7d6.var_b39864d6;
  var_a12bf98c = var_75a7d6.var_a12bf98c;

  if(!(isDefined(var_b39864d6) && isDefined(var_a12bf98c))) {
    return;
  }

  level endon(#"end_game");
  var_75a7d6 endon(#"defeated");
  var_b39864d6 endon(#"death");
  var_a12bf98c endon(#"death");
  var_75a7d6 notify(#"area_clear");
  var_75a7d6 notify(#"hash_46e30440174c1da4");
  level clientfield::set("" + # "hash_228f0acdd4255cb", 0);
  n_height = 32;
  str_fx = # "zombie/fx9_player_shockwave_retrieval";

  if(var_7ca1e76e) {
    n_height = 32;
    str_fx = # "hash_6348600dc108894b";
  }

  playFX(str_fx, var_a12bf98c.origin + (0, 0, n_height), anglesToForward(var_a12bf98c.angles), anglestoup(var_a12bf98c.angles));
  playsoundatposition(#"hash_1412afc9788c5421", var_a12bf98c.origin);
  playrumbleonposition(#"hash_41054017b6b786b8", var_a12bf98c.origin);
  function_e8799ac6(var_b39864d6.origin, 1000);
  level thread zm_utility::function_9ad5aeb1(0, 1, 0, 0);
}

function function_b2871ce6(var_75a7d6) {
  level endon(#"end_game");
  var_75a7d6 flag::set(#"teleport");
  var_75a7d6 flag::increment(#"hash_1e2734204ab845a2");
  var_75a7d6.var_2a940370++;
  var_a12bf98c = var_75a7d6.var_a12bf98c;
  function_761d8ea1(var_75a7d6, var_a12bf98c, 1);
  music::setmusicstate("endfight_between_waves");
  level clientfield::set("" + # "hash_2a93d12c263f2d68", 6);
  var_75a7d6 notify(#"shield_delete");
  mdl_shield = var_75a7d6.mdl_shield;

  if(isDefined(mdl_shield)) {
    mdl_shield clientfield::set("" + # "hash_4a7733d2f4b25e81", 0);
    mdl_shield notsolid();
    mdl_shield thread util::delayed_delete(1);
  }

  if(var_75a7d6 flag::get(#"shield_down")) {
    var_75a7d6.var_9428def3 = var_75a7d6.var_200c676a;
    function_f3ac29fc(var_75a7d6);
  }

  var_75a7d6 flag::function_c58ecb49(#"shield_down");
  var_75a7d6 flag::set(#"shield_down");

  foreach(e_player in getplayers()) {
    if(level.var_ecc60e04 zm_corrupted_health_bar::is_open(e_player)) {
      level.var_ecc60e04 zm_corrupted_health_bar::function_74adcd8a(e_player, 1);
    }
  }

  wait 1;

  if(var_75a7d6 flag::get(#"attacking")) {
    var_75a7d6 flag::wait_till_clear(#"attacking");
    wait 1;
  }

  switch (var_75a7d6.var_b53352fa) {
    case 0:
      str_vo = # "hash_184c91473c4bb97f";
      break;
    case 1:
      str_vo = # "hash_184c92473c4bbb32";
      break;
    case 2:
      str_vo = # "hash_184c93473c4bbce5";
      break;
    case 3:
      str_vo = # "hash_184c8c473c4bb100";
      break;
  }

  if(isDefined(str_vo)) {
    level thread zm_vo::function_7622cb70(str_vo, 0.5);
  }

  str_shot = "sit_teleport_in";

  if(var_75a7d6 flag::get(#"hash_482d5322e3bb32d3")) {
    str_shot = "stand_teleport_in";
  }

  var_b39864d6 = var_75a7d6.var_b39864d6;
  var_b39864d6 thread scene::play(#"hash_63636406a7a2326", str_shot, var_b39864d6);
  level waittilltimeout(10, #"hash_72fd671796d8756f");
  level thread function_4f440b0(var_75a7d6);
  mdl_fx = util::spawn_model(#"tag_origin", var_b39864d6.origin - (0, 0, 8), var_b39864d6.angles);
  mdl_fx clientfield::set("" + # "hash_57e0dbfd7a91b69d", 1);
  function_761d8ea1(var_75a7d6, var_a12bf98c, 0);
  var_b39864d6 clientfield::set("" + # "hash_45d9cedaf4fb4aa2", 0);
  var_b39864d6 hide();

  if(isDefined(var_a12bf98c)) {
    var_a12bf98c hide();
  }

  var_b39864d6 flag::wait_till_clear_timeout(10, #"scene");
  var_b39864d6 scene::stop();

  if(isDefined(var_a12bf98c)) {
    var_a12bf98c scene::stop();
  }

  function_c860cfeb(var_75a7d6);

  if(var_75a7d6.var_b53352fa < 3) {
    str_loc = array::random(var_75a7d6.var_25a3af6b);
    arrayremovevalue(var_75a7d6.var_25a3af6b, str_loc);
  } else {
    str_loc = # "lab";
    var_75a7d6 flag::set(#"should_die");
  }

  var_75a7d6.str_loc = str_loc;
  var_75a7d6.var_b53352fa++;

  switch (var_75a7d6.var_b53352fa) {
    case 1:
      var_75a7d6 flag::set(#"hash_53f03da53102f4ff");
      var_75a7d6 flag::set(#"hash_3948a1aa982807f2");
      var_75a7d6 flag::set(#"hash_61acfc7a3e200ce3");
      var_75a7d6 flag::set(#"hash_2d61f4f9fee67c9a");
      var_75a7d6 flag::clear(#"mechz_disabled");
      var_75a7d6 flag::clear(#"tempest_disabled");
      break;
  }

  var_3d2df074 = function_2954a39(var_75a7d6, str_loc, 1);
  var_6976f577 = util::spawn_model(#"tag_origin", var_b39864d6.origin, var_b39864d6.angles);
  var_b39864d6 linkto(var_6976f577);

  if(isDefined(var_a12bf98c)) {
    var_a12bf98c linkto(var_6976f577);
  }

  var_6976f577 moveto(var_3d2df074.origin, 0.01);
  var_6976f577 rotateto(var_3d2df074.angles, 0.01);
  var_6976f577 waittill(#"movedone");
  var_6976f577.origin = var_3d2df074.origin;
  var_6976f577.angles = var_3d2df074.angles;
  wait 2;
  var_6976f577 delete();
  zm_sq::objective_set(#"hash_311658a8c916ad2a", mdl_fx, 0, undefined, #"teleport");
  var_9207bb3a = distance(mdl_fx.origin, var_3d2df074.origin) / 700;

  if(var_9207bb3a > 0) {
    playFX(#"sr/fx9_hvt_aether_portal_exp", mdl_fx.origin, anglesToForward(mdl_fx.angles), anglestoup(mdl_fx.angles));
    playrumbleonposition(#"hash_41054017b6b786b8", mdl_fx.origin);
    mdl_fx playSound(#"hash_292cc4273f4c0161");
    mdl_fx moveto(var_3d2df074.origin, var_9207bb3a);
    mdl_fx rotateto(var_3d2df074.angles, var_9207bb3a);
    mdl_fx waittill(#"movedone");
  }

  mdl_fx.origin = var_3d2df074.origin;
  mdl_fx.angles = var_3d2df074.angles;
  mdl_fx clientfield::set("" + # "hash_57e0dbfd7a91b69d", 0);
  mdl_fx thread util::delayed_delete(1);
  zm_sq::objective_complete(#"teleport");
  var_b39864d6 show();
  var_b39864d6 clientfield::set("" + # "hash_45d9cedaf4fb4aa2", 1);

  if(isDefined(var_a12bf98c)) {
    var_a12bf98c show();
    var_a12bf98c thread scene::play(#"hash_4ace6ee6fbaf17bd", "loop", var_a12bf98c);
  }

  function_761d8ea1(var_75a7d6, var_a12bf98c, 1);
  var_75a7d6 flag::clear(#"hash_2e1cda199112392f");
  level thread function_10ed1a0d(var_75a7d6, var_b39864d6);
  level thread function_6c1ea28c(var_75a7d6);
  s_loc = function_efebb093(var_75a7d6, str_loc);
  vol_arena = s_loc.vol_arena;

  if(!function_ec35f21(var_75a7d6, str_loc)) {
    zm_sq::objective_set(#"hash_311658a8c916ad2a", var_b39864d6, 0, undefined, #"teleport");

    if(isDefined(vol_arena)) {
      level thread function_e6cfd3a8(var_75a7d6, vol_arena);
    }

    s_waitresult = var_75a7d6 waittilltimeout(53, #"shield_damage", #"boss_damage", #"arena_entered");
  }

  var_75a7d6 notify(#"next_battle");
  b_teleporting = function_14a35d6f(var_75a7d6, str_loc);
  zm_sq::objective_complete(#"teleport");

  switch (str_loc) {
    default:
      var_75a7d6 flag::clear(#"tempest_disabled");
      var_75a7d6 flag::set(#"hash_88667c18a4cff07");
      break;
    case # "hash_56100f3e34a790d":
      var_75a7d6 flag::set(#"tempest_disabled");
      var_75a7d6 flag::clear(#"hash_88667c18a4cff07");
      break;
  }

  function_ff441bfb(var_75a7d6, str_loc);

  if(var_75a7d6.var_2a940370 > 2) {
    music::setmusicstate("endfight_wave_2");
  } else {
    music::setmusicstate("endfight_wave_1");
  }

  level clientfield::set("" + # "hash_2a93d12c263f2d68", 5);
  n_wait = 1;

  if(b_teleporting) {
    n_wait = 5;
  }

  wait n_wait;
  var_75a7d6 flag::wait_till_timeout(5, #"hash_2e1cda199112392f");
  level flag::clear(#"in_dark_side");
  var_75a7d6 flag::set(#"hash_5af51c7c3fde832e");
  level thread function_af1dd8ec(var_75a7d6);
  function_761d8ea1(var_75a7d6, var_a12bf98c, 0);
  var_75a7d6 flag::function_c58ecb49(#"shield_down");
  var_75a7d6 flag::clear(#"teleport");
  level thread function_ab3592be(var_75a7d6, var_b39864d6);
  var_75a7d6 flag::clear(#"hash_137c7612417b56ec");
  var_75a7d6 flag::clear(#"hash_5b18d00f994c17a4");
  level thread function_73ef29bf(var_75a7d6, #"teleport");
}

function function_ec35f21(var_75a7d6, str_loc) {
  s_loc = function_efebb093(var_75a7d6, str_loc);
  vol_arena = s_loc.vol_arena;

  if(isDefined(vol_arena)) {
    foreach(e_player in function_a1ef346b()) {
      if(e_player istouching(vol_arena)) {
        return true;
      }
    }
  }

  return false;
}

function function_14a35d6f(var_75a7d6, str_loc, b_play_vo = 1) {
  level endon(#"end_game");
  s_loc = function_efebb093(var_75a7d6, str_loc);
  vol_arena = s_loc.vol_arena;

  if(isDefined(vol_arena)) {
    var_a347ab1 = function_8b2a124(s_loc);

    if(var_a347ab1.size > 0) {
      b_teleporting = 0;
      var_f6671a7d = [];

      foreach(e_player in function_a1ef346b()) {
        if(e_player isonladder() || !e_player istouching(vol_arena)) {
          b_teleporting = 1;
          e_player clientfield::set_to_player("" + # "hash_7857b61586fd957b", 1);
          e_player playsoundtoplayer(#"hash_4a2101ba821730fb", e_player);

          if(!isDefined(var_f6671a7d)) {
            var_f6671a7d = [];
          } else if(!isarray(var_f6671a7d)) {
            var_f6671a7d = array(var_f6671a7d);
          }

          var_f6671a7d[var_f6671a7d.size] = e_player;
        }
      }

      if(b_teleporting) {
        if(b_play_vo) {
          level thread function_f83c329c(var_75a7d6, #"player_teleport", 1, undefined, var_f6671a7d);
        }

        level thread zm_platinum::function_4cc5fca6();
        level flag::set(#"in_dark_side");
        wait 6;
        function_9551a49a(var_75a7d6);
        wait 1;
        b_teleporting = 0;
        var_3bd5e8ce = var_a347ab1;

        foreach(e_player in function_a1ef346b()) {
          e_player clientfield::set_to_player("" + # "hash_7857b61586fd957b", 0);

          if(e_player isonladder() || !e_player istouching(vol_arena)) {
            b_teleporting = 1;
            var_5f1812e0 = arraygetclosest(e_player.origin, var_3bd5e8ce);
            arrayremovevalue(var_3bd5e8ce, var_5f1812e0);
            level thread player_teleport(e_player, vol_arena, var_5f1812e0);
          }
        }

        if(b_teleporting) {
          return true;
        }
      }
    }
  }

  return false;
}

function player_teleport(e_player, vol_arena, var_5f1812e0) {
  level endon(#"end_game");

  if(!isalive(e_player)) {
    return;
  }

  e_player endon(#"death");

  while(e_player isziplining() || e_player function_b4813488()) {
    waitframe(1);
  }

  if(e_player isonladder() || !e_player istouching(vol_arena)) {
    e_player thread zm_fasttravel::function_66d020b0(undefined, undefined, undefined, undefined, var_5f1812e0, undefined, #"hash_5c9e57cec1f8655b");
  }
}

function function_af1dd8ec(var_75a7d6) {
  function_f83c329c(var_75a7d6, #"new_stage");

  if(isDefined(var_75a7d6)) {
    var_75a7d6 flag::clear(#"hash_5af51c7c3fde832e");
  }
}

function function_761d8ea1(var_75a7d6, var_a12bf98c, b_enable = 1) {
  if(!(isDefined(var_75a7d6) && isDefined(var_a12bf98c))) {
    return;
  }

  level endon(#"end_game");
  var_75a7d6 endon(#"defeated");
  var_a12bf98c endon(#"death");

  if(b_enable) {
    if(!isDefined(var_a12bf98c.var_1440b452)) {
      var_a12bf98c.var_1440b452 = util::spawn_model(#"tag_origin", var_a12bf98c.origin + (0, 0, 40), var_a12bf98c.angles);

      if(isDefined(var_a12bf98c.var_1440b452)) {
        var_a12bf98c.var_1440b452 clientfield::set("" + # "hash_41ba39a474a3503f", 1);
      }
    }

    return;
  }

  if(isDefined(var_a12bf98c.var_1440b452)) {
    var_a12bf98c.var_1440b452 clientfield::set("" + # "hash_41ba39a474a3503f", 0);
    var_a12bf98c.var_1440b452 thread util::delayed_delete(1);
    var_a12bf98c.var_1440b452 = undefined;
  }
}

function function_6c1ea28c(var_75a7d6) {
  if(!isDefined(var_75a7d6)) {
    return;
  }

  level endon(#"end_game");
  var_75a7d6 endon(#"defeated");
  var_75a7d6 waittilltimeout(15, #"next_battle");
  var_75a7d6 flag::decrement(#"hash_1e2734204ab845a2");
}

function function_10ed1a0d(var_75a7d6, var_b39864d6) {
  if(!(isDefined(var_75a7d6) && isDefined(var_b39864d6))) {
    return;
  }

  level endon(#"end_game");
  var_75a7d6 endon(#"defeated");
  var_b39864d6 endon(#"death");
  var_dee0396e = "sit_teleport_out";
  var_ec892790 = "boss_sit_idle";

  if(var_75a7d6 flag::get(#"hash_482d5322e3bb32d3")) {
    var_dee0396e = "stand_teleport_out";
    var_ec892790 = "stand_idle";
  }

  var_b39864d6 scene::play(#"hash_63636406a7a2326", var_dee0396e, var_b39864d6);
  var_b39864d6 thread scene::play(#"hash_63636406a7a2326", var_ec892790, var_b39864d6);
  waitframe(1);
  var_75a7d6 flag::set(#"hash_2e1cda199112392f");
}

function function_e6cfd3a8(var_75a7d6, vol_arena) {
  level endon(#"end_game");

  if(!(isDefined(var_75a7d6) && isDefined(vol_arena))) {
    return;
  }

  var_75a7d6 endon(#"defeated", #"next_battle");
  vol_arena endon(#"death");

  while(true) {
    foreach(e_player in function_a1ef346b()) {
      if(e_player istouching(vol_arena)) {
        var_75a7d6 notify(#"arena_entered");
        break;
      }
    }

    wait 1;
  }
}

function function_8b2a124(s_loc) {
  return isDefined(s_loc.var_a9cc7c2) ? s_loc.var_a9cc7c2 : [];
}

function function_a094b1fc(var_75a7d6) {
  level endon(#"end_game");
  var_75a7d6 endon(#"defeated");
  var_75a7d6 flag::set(#"attacking");
  var_75a7d6 flag::set(#"vampirism");
  var_a12bf98c = var_75a7d6.var_a12bf98c;

  if(!var_75a7d6 flag::get_any([#"transition", #"teleport"])) {
    function_761d8ea1(var_75a7d6, var_a12bf98c, 1);
  }

  function_1798a522(var_75a7d6, 0);

  if(!var_75a7d6 flag::get(#"hash_5af51c7c3fde832e")) {
    level thread function_4e595107(var_75a7d6, #"vampirism");
  }

  var_504cdb19 = "sit_vamp_in";
  var_70c303e9 = "sit_vamp_loop";

  if(var_75a7d6 flag::get(#"hash_482d5322e3bb32d3")) {
    var_504cdb19 = "stand_vamp_in";
    var_70c303e9 = "stand_vamp_loop";
  }

  var_b39864d6 = var_75a7d6.var_b39864d6;
  var_b39864d6 scene::play(#"hash_63636406a7a2326", var_504cdb19, var_b39864d6);
  var_b39864d6 thread scene::play(#"hash_63636406a7a2326", var_70c303e9, var_b39864d6);
  s_loc = function_2954a39(var_75a7d6);
  a_s_spawns = array::randomize(function_96175ff7(s_loc));
  var_4c2ab3d4 = [{
    #str_idle: "idle_1", #var_6ab5a6dc: "vacuum_1"}, {
    #str_idle: "idle_2", #var_6ab5a6dc: "vacuum_2"}, {
    #str_idle: "idle_3", #var_6ab5a6dc: "vacuum_3"}, {
    #str_idle: "idle_4", #var_6ab5a6dc: "vacuum_4"}, {
    #str_idle: "idle_5", #var_6ab5a6dc: "vacuum_5"}, {
    #str_idle: "idle_6", #var_6ab5a6dc: "vacuum_6"}, {
    #str_idle: "idle_7", #var_6ab5a6dc: "vacuum_7"}, {
    #str_idle: "idle_8", #var_6ab5a6dc: "vacuum_8"}, {
    #str_idle: "idle_9", #var_6ab5a6dc: "vacuum_9"}];

  if(!var_75a7d6 flag::get(#"hash_651c5658ad51d9a2")) {
    foreach(var_fdc796b6 in var_4c2ab3d4) {
      scene::add_scene_func(#"hash_10db0519c12e6719", &function_8b73a6d3, var_fdc796b6.str_idle);
    }

    var_75a7d6 flag::set(#"hash_651c5658ad51d9a2");
  }

  var_4822a1cb = arraycopy(var_4c2ab3d4);
  var_9c205520 = undefined;
  var_748cf9be = [];
  var_ca4db1e2 = level.zombie_spawners[6];

  foreach(s_spawn in a_s_spawns) {
    function_4cc9e609(var_75a7d6);
    s_rise = struct::get(s_spawn.target);

    while(true) {
      ai_zombie = var_ca4db1e2 spawnfromspawner(undefined, 1, 1, 1);

      if(isDefined(ai_zombie)) {
        break;
      }

      waitframe(1);
    }

    if(var_4822a1cb.size <= 0) {
      var_4822a1cb = arraycopy(var_4c2ab3d4);
      arrayremovevalue(var_4822a1cb, var_9c205520);
    }

    var_fdc796b6 = array::random(var_4822a1cb);
    arrayremovevalue(var_4822a1cb, var_fdc796b6);
    level thread function_cbdf02c2(ai_zombie, s_spawn, s_rise, var_fdc796b6);

    if(!isDefined(var_748cf9be)) {
      var_748cf9be = [];
    } else if(!isarray(var_748cf9be)) {
      var_748cf9be = array(var_748cf9be);
    }

    var_748cf9be[var_748cf9be.size] = ai_zombie;
    var_9c205520 = var_fdc796b6;
    wait 0.1;
  }

  function_1eaaceab(var_748cf9be);
  var_748cf9be = array::randomize(var_748cf9be);
  var_6f822da4 = 0;
  var_5059345b = 0;

  while(var_748cf9be.size > 0) {
    var_756c01dd = var_748cf9be[0];

    if(isalive(var_756c01dd)) {
      var_756c01dd clientfield::set("" + # "hash_498f233d25448db3", 1);
      var_86cfd484 = var_756c01dd.var_836ab086;
      var_6ab5a6dc = var_756c01dd.var_99c4ce87.var_6ab5a6dc;

      if(isDefined(var_86cfd484) && isDefined(var_6ab5a6dc)) {
        var_86cfd484 thread scene::play(#"hash_10db0519c12e6719", var_6ab5a6dc, var_756c01dd);
      }

      var_756c01dd clientfield::set("" + # "hash_5f6e0119d9eee00c", 2);
      s_waitresult = var_756c01dd waittilltimeout(4.5, #"death");

      if(isalive(var_756c01dd) && s_waitresult._notify == # "timeout") {
        gibserverutils::annihilate(var_756c01dd);
        var_756c01dd deletedelay();

        if(isDefined(var_75a7d6.n_threshold) && isDefined(var_75a7d6.var_3f956940) && isDefined(var_75a7d6.var_fa625236)) {
          var_75a7d6.var_3f956940 = int(min(var_75a7d6.n_threshold, var_75a7d6.var_3f956940 + var_75a7d6.var_fa625236));
          function_73f95a0c(var_75a7d6);
        }

        if(var_75a7d6.var_3f956940 >= var_75a7d6.n_threshold) {
          var_6f822da4 = 1;
          level thread function_6aa88764(var_748cf9be);
          var_748cf9be = [];
        }
      } else {
        var_5059345b = 1;
      }

      wait 1;
    }

    function_1eaaceab(var_748cf9be);
  }

  level thread function_84f9cc2e(var_75a7d6, #"hash_39316cd070ab8069", 120);

  if(!var_75a7d6 flag::get(#"hash_5af51c7c3fde832e") && var_5059345b && !var_6f822da4) {
    level thread function_f83c329c(var_75a7d6, #"hash_60af5025b12d8632");
  }

  var_dee0396e = "sit_vamp_out";
  var_ec892790 = "boss_sit_idle";

  if(var_75a7d6 flag::get(#"hash_482d5322e3bb32d3")) {
    var_dee0396e = "stand_vamp_out";
    var_ec892790 = "stand_idle";
  }

  var_b39864d6 scene::play(#"hash_63636406a7a2326", var_dee0396e, var_b39864d6);
  var_b39864d6 thread scene::play(#"hash_63636406a7a2326", var_ec892790, var_b39864d6);
  var_75a7d6 flag::clear(#"vampirism");

  if(!var_75a7d6 flag::get_any([#"transition", #"teleport"])) {
    function_761d8ea1(var_75a7d6, var_a12bf98c, 0);
  }

  function_38e49607(var_75a7d6);
  var_75a7d6 flag::clear(#"attacking");
  level thread function_e5dc0d0d(var_75a7d6);
  level thread function_73ef29bf(var_75a7d6, #"vampirism");
}

function function_96175ff7(s_loc) {
  return isDefined(s_loc.var_4ad75699) ? s_loc.var_4ad75699 : [];
}

function function_cbdf02c2(ai_zombie, s_spawn, s_rise, var_fdc796b6) {
  if(!isalive(ai_zombie) || !(isDefined(s_rise) && isDefined(s_spawn) && isDefined(var_fdc796b6))) {
    return;
  }

  ai_zombie endon(#"death");
  ai_zombie flag::set(#"hash_28a7976f46b038e");
  ai_zombie setplayercollision(0);
  ai_zombie.start_inert = 1;
  ai_zombie.ignore_find_flesh = 1;
  ai_zombie.favoriteenemy = undefined;
  ai_zombie unlink();
  ai_zombie pathmode("move allowed");
  ai_zombie.completed_emerging_into_playable_area = 1;
  ai_zombie.zombie_think_done = 1;
  ai_zombie.b_ignore_cleanup = 1;
  ai_zombie.var_126d7bef = 1;
  ai_zombie.ignore_round_spawn_failsafe = 1;
  ai_zombie.no_powerups = 1;
  ai_zombie.var_98f1f37c = 1;
  ai_zombie callback::function_d8abfc3d(#"death", &function_14251f2b);
  ai_zombie.var_99c4ce87 = {
    #s_spawn: s_spawn, #s_rise: s_rise, #str_idle: var_fdc796b6.str_idle, #var_6ab5a6dc: var_fdc796b6.var_6ab5a6dc
  };
  ai_zombie.var_836ab086 = util::spawn_model(#"tag_origin", s_rise.origin, s_rise.angles);
  var_86cfd484 = ai_zombie.var_836ab086;

  if(isDefined(var_86cfd484)) {
    var_86cfd484 thread scene::play(#"hash_10db0519c12e6719", var_fdc796b6.str_idle, ai_zombie);
  }
}

function function_8b73a6d3(a_ents) {
  var_51bad3e3 = a_ents[#"victim"];
  var_86cfd484 = var_51bad3e3.var_836ab086;
  var_99c4ce87 = var_51bad3e3.var_99c4ce87;
  s_rise = var_99c4ce87.s_rise;
  s_spawn = var_99c4ce87.s_spawn;

  if(isalive(var_51bad3e3) && isDefined(s_rise) && isDefined(var_86cfd484) && isDefined(s_spawn)) {
    var_51bad3e3 endon(#"death");
    var_86cfd484 endon(#"death");
    playFX(#"zombie/fx9_onslaught_spawn_sm", s_rise.origin);
    var_51bad3e3 clientfield::set("" + # "hash_5f6e0119d9eee00c", 1);
    var_86cfd484 moveto(s_spawn.origin, 3, 0, 1);
    var_86cfd484 rotateto(s_spawn.angles, 3, 0, 1);
    var_86cfd484 waittill(#"movedone");
    var_86cfd484.origin = s_spawn.origin;
    var_86cfd484.angles = s_spawn.angles;
  }
}

function function_14251f2b(s_params) {
  self callback::function_52ac9652(#"death", &function_14251f2b);
  self clientfield::set("" + # "hash_498f233d25448db3", 0);
  self clientfield::set("" + # "hash_5f6e0119d9eee00c", 0);

  if(isDefined(self.var_836ab086)) {
    self.var_836ab086 delete();
  }

  self scene::stop();
  function_a0f1fc1d();
}

function function_6aa88764(var_1198d407) {
  wait 0.2;
  function_1eaaceab(var_1198d407);
  var_1198d407 = array::randomize(var_1198d407);

  foreach(var_756c01dd in var_1198d407) {
    if(isalive(var_756c01dd)) {
      gibserverutils::annihilate(var_756c01dd);
      var_756c01dd deletedelay();
    }

    wait 0.2;
  }
}

function function_101fd34c(var_75a7d6) {
  level endon(#"end_game");
  var_75a7d6 endon(#"defeated");
  var_75a7d6 flag::set(#"attacking");
  function_1798a522(var_75a7d6);

  if(!var_75a7d6 flag::get(#"hash_5af51c7c3fde832e")) {
    level thread function_f83c329c(var_75a7d6, #"hash_6a3f96f46648766d");
  }

  foreach(e_player in getplayers()) {
    e_player clientfield::set_to_player("" + # "hash_45456ed33ab0037a", 1);
  }

  var_b39864d6 = var_75a7d6.var_b39864d6;
  var_b39864d6 clientfield::set("" + # "hash_bae11639a0dd182", 1);
  var_8fc81e63 = gettime();
  var_b39864d6 = var_75a7d6.var_b39864d6;
  var_504cdb19 = "sit_blast_in";
  var_70c303e9 = "sit_blast_loop";

  if(var_75a7d6 flag::get(#"hash_482d5322e3bb32d3")) {
    var_504cdb19 = "stand_blast_in";
    var_70c303e9 = "stand_blast_loop";
  }

  var_b39864d6 scene::play(#"hash_63636406a7a2326", var_504cdb19, var_b39864d6);
  var_b39864d6 thread scene::play(#"hash_63636406a7a2326", var_70c303e9, var_b39864d6);
  n_time_left = 6 - (gettime() - var_8fc81e63) / 1000;

  if(n_time_left > 0) {
    wait n_time_left;
  }

  var_b39864d6 clientfield::set("" + # "hash_bae11639a0dd182", 0);
  level thread function_79af2068(var_75a7d6, var_b39864d6);
  v_fx_origin = var_b39864d6 gettagorigin("j_spine4");
  ex_elevator_overlight_indicator_ = var_b39864d6 gettagangles("j_spine4");
  playFX(#"hash_414926335698e2a1", v_fx_origin, anglesToForward(ex_elevator_overlight_indicator_), anglestoup(ex_elevator_overlight_indicator_));
  var_b39864d6 playrumbleonentity(#"hash_3ac7a3a36eff1604");
  var_b39864d6 playSound(#"hash_662fe32e9eb3309d");
  var_1979248a = var_b39864d6.origin;

  foreach(e_player in getplayers()) {
    e_player clientfield::set_to_player("" + # "hash_45456ed33ab0037a", 2);
  }

  level thread function_f83c329c(var_75a7d6, #"roar", 0, 0);
  level thread function_e8799ac6(var_1979248a, 1000);
  wait 0.5;
  v_trace_start = var_b39864d6 gettagorigin("tag_eye");

  foreach(e_player in function_a1ef346b(undefined, var_1979248a, 5000)) {
    if(zm_utility::is_player_valid(e_player)) {
      v_player = e_player getcentroid();

      if(!isDefined(v_player)) {
        v_player = e_player.origin;
      }

      if(isvec(v_player) && bullettracepassed(v_trace_start, v_player, 0, e_player, var_b39864d6)) {
        e_player dodamage(666, var_1979248a);
      }
    }
  }

  wait 3;
  level thread function_84f9cc2e(var_75a7d6, #"hash_3b3cca2339e6043d", 90);
  function_38e49607(var_75a7d6);
  var_75a7d6 flag::clear(#"attacking");
  level thread function_50dded47(var_75a7d6);
  level thread function_e5dc0d0d(var_75a7d6);
  level thread function_73ef29bf(var_75a7d6, #"hash_6a3f96f46648766d");
}

function function_79af2068(var_75a7d6, var_b39864d6) {
  if(!(isDefined(var_75a7d6) && isDefined(var_b39864d6))) {
    return;
  }

  level endon(#"end_game");
  var_75a7d6 endon(#"defeated");
  var_b39864d6 endon(#"death");
  var_dee0396e = "sit_blast_out";
  var_70c303e9 = "boss_sit_idle";

  if(var_75a7d6 flag::get(#"hash_482d5322e3bb32d3")) {
    var_dee0396e = "stand_blast_out";
    var_70c303e9 = "stand_idle";
  }

  var_b39864d6 scene::play(#"hash_63636406a7a2326", var_dee0396e, var_b39864d6);
  var_b39864d6 thread scene::play(#"hash_63636406a7a2326", var_70c303e9, var_b39864d6);
}

function function_e8799ac6(v_center, n_radius = 512) {
  if(!isvec(v_center)) {
    return;
  }

  var_17c7dbe6 = arraysortclosest(zombie_utility::get_zombie_array(), v_center, undefined, 0, n_radius);

  foreach(var_ccea7dbf in var_17c7dbe6) {
    if(isalive(var_ccea7dbf)) {
      if(math::cointoss()) {
        gibserverutils::gibhead(var_ccea7dbf);
      }

      if(math::cointoss()) {
        if(math::cointoss()) {
          gibserverutils::gibleftarm(var_ccea7dbf);
        } else {
          gibserverutils::gibrightarm(var_ccea7dbf);
        }
      }

      if(math::cointoss()) {
        if(math::cointoss()) {
          gibserverutils::gibleftleg(var_ccea7dbf);
        } else {
          gibserverutils::gibrightleg(var_ccea7dbf);
        }
      }

      n_random_x = randomfloatrange(-3, 3);
      n_random_y = randomfloatrange(-3, 3);
      v_fling = 200 * vectornormalize(var_ccea7dbf.origin - v_center + (n_random_x, n_random_y, 100));
      var_ccea7dbf.var_d45ca662 = 1;
      var_ccea7dbf.var_98f1f37c = 1;
      var_ccea7dbf thread zm_utility::function_ffc279(v_fling, var_ccea7dbf);
    }
  }
}

function function_975a5a48(var_75a7d6) {
  var_b39864d6 = var_75a7d6.var_b39864d6;

  if(!isDefined(var_b39864d6)) {
    return 0;
  }

  a_e_players = [];

  foreach(e_player in function_a1ef346b()) {
    if(zm_utility::is_player_valid(e_player) && !is_true(e_player.ignoreme) && distance2dsquared(e_player.origin, var_b39864d6.origin) <= sqr(1500)) {
      if(!isDefined(a_e_players)) {
        a_e_players = [];
      } else if(!isarray(a_e_players)) {
        a_e_players = array(a_e_players);
      }

      a_e_players[a_e_players.size] = e_player;
    }
  }

  n_players = a_e_players.size;

  if(n_players <= 0) {
    return 0;
  }

  mdl_shield = var_75a7d6.mdl_shield;
  var_11384e2c = var_b39864d6.origin + (0, 0, 128);

  if(n_players <= 1) {
    e_player = a_e_players[0];

    if(!isPlayer(e_player) || !bullettracepassed(var_11384e2c, e_player.origin + (0, 0, 16), 0, mdl_shield, var_b39864d6)) {
      return 0;
    }

    e_target = e_player;
  } else {
    var_5737bcb9 = 0;
    var_a10acf3c = [];

    foreach(e_player in a_e_players) {
      if(isPlayer(e_player) && bullettracepassed(var_11384e2c, e_player.origin + (0, 0, 16), 0, mdl_shield, var_b39864d6)) {
        if(!isDefined(var_a10acf3c)) {
          var_a10acf3c = [];
        } else if(!isarray(var_a10acf3c)) {
          var_a10acf3c = array(var_a10acf3c);
        }

        var_a10acf3c[var_a10acf3c.size] = e_player;
        var_b500b370 = arraysortclosest(a_e_players, e_player.origin, undefined, 0, 100);
        arrayremovevalue(var_b500b370, e_player);
        var_40d42a6e = var_b500b370.size;

        if(var_40d42a6e > var_5737bcb9) {
          e_target = e_player;
          var_5737bcb9 = var_40d42a6e;
        }
      }
    }
  }

  if(!isPlayer(e_target)) {
    if(isDefined(var_a10acf3c)) {
      e_target = array::random(var_a10acf3c);
    }

    if(!isPlayer(e_target)) {
      return 0;
    }
  }

  return e_target;
}

function function_5e042438(var_75a7d6, e_target) {
  level endon(#"end_game");
  var_75a7d6 endon(#"defeated");
  var_75a7d6 flag::set(#"attacking");
  var_b39864d6 = var_75a7d6.var_b39864d6;
  level thread function_970fa9cd(var_75a7d6, var_b39864d6);
  level waittilltimeout(5, #"hash_48966a0d10100b16");
  var_1979248a = var_b39864d6.origin;
  a_s_spawns = [];
  var_75a7d6.var_c6454bbe = [];
  v_center = var_1979248a + (0, 0, 128);
  v_spacing = anglestoright(vectortoangles(e_target.origin - var_1979248a)) * 64;

  for(i = 0; i < 3; i++) {
    level thread function_9da5eeca(var_75a7d6, i, e_target, v_center);
  }

  function_1798a522(var_75a7d6);

  if(!var_75a7d6 flag::get(#"hash_5af51c7c3fde832e")) {
    level thread function_4e595107(var_75a7d6, #"hash_477a7859bae6c69c");
  }

  var_b39864d6 playsoundontag(#"hash_2c26cf8f03624b0a", "tag_eye");
  wait 0.5;
  var_b39864d6 playLoopSound(#"hash_1dd9dd7126ae7f9e");
  wait 1;
  level thread function_d3bbbc22(var_75a7d6);
  wait 6;
  level thread function_84f9cc2e(var_75a7d6, #"hash_137c7612417b56ec", 0);
  var_75a7d6 notify(#"hash_4c1f5a1219db67d");

  foreach(var_9a08bf56 in var_75a7d6.var_c6454bbe) {
    if(isDefined(var_9a08bf56)) {
      var_9a08bf56 clientfield::set("" + # "hash_78efd0fabb77e1ea", 0);
      var_9a08bf56 thread util::delayed_delete(1);
    }
  }

  function_38e49607(var_75a7d6);
  var_dee0396e = "sit_shards_out";
  var_ec892790 = "boss_sit_idle";

  if(var_75a7d6 flag::get(#"hash_482d5322e3bb32d3")) {
    var_dee0396e = "stand_shards_out";
    var_ec892790 = "stand_idle";
  }

  var_b39864d6 stoploopsound();
  var_b39864d6 playsoundontag(#"hash_65fc0ad4c7938c2a", "tag_eye");
  var_b39864d6 scene::play(#"hash_63636406a7a2326", var_dee0396e, var_b39864d6);
  var_b39864d6 thread scene::play(#"hash_63636406a7a2326", var_ec892790, var_b39864d6);
  var_75a7d6 flag::clear(#"attacking");
  level thread function_e5dc0d0d(var_75a7d6);
  level thread function_73ef29bf(var_75a7d6, #"hash_477a7859bae6c69c");
}

function function_970fa9cd(var_75a7d6, var_b39864d6) {
  if(!(isDefined(var_75a7d6) && isDefined(var_b39864d6))) {
    return;
  }

  level endon(#"end_game");
  var_75a7d6 endon(#"defeated");
  var_b39864d6 endon(#"death");
  var_504cdb19 = "sit_shards_in";
  var_70c303e9 = "sit_shards_loop";

  if(var_75a7d6 flag::get(#"hash_482d5322e3bb32d3")) {
    var_504cdb19 = "stand_shards_in";
    var_70c303e9 = "stand_shards_loop";
  }

  var_b39864d6 scene::play(#"hash_63636406a7a2326", var_504cdb19, var_b39864d6);
  var_b39864d6 thread scene::play(#"hash_63636406a7a2326", var_70c303e9, var_b39864d6);
}

function function_9da5eeca(var_75a7d6, n_spawn, e_target, v_center) {
  level endon(#"end_game");
  var_75a7d6 endon(#"defeated", #"hash_4c1f5a1219db67d");
  var_b39864d6 = var_75a7d6.var_b39864d6;
  var_9a08bf56 = undefined;
  v_target = e_target.origin;
  var_8af6101c = 0;

  if(isvec(v_target) && distance2dsquared(v_target, v_center) <= sqr(1500)) {
    while(true) {
      if(is_true(e_target.ignoreme)) {
        var_8af6101c = 1;
      }

      if(!var_8af6101c && isvec(e_target.origin) && distance2dsquared(e_target.origin, v_center) <= sqr(1500)) {
        v_target = e_target.origin;
      }

      v_spacing = anglestoright(vectortoangles(v_target - v_center)) * 64;

      switch (n_spawn) {
        case 0:
          v_spawn = var_b39864d6 gettagorigin("j_head") + anglesToForward(var_b39864d6.angles) * 8;
          v_dest = v_center;
          break;
        case 1:
          v_spawn = var_b39864d6 gettagorigin("j_wrist_ri");
          v_dest = v_center + v_spacing;
          break;
        case 2:
          v_spawn = var_b39864d6 gettagorigin("j_wrist_le");
          v_dest = v_center - v_spacing;
          break;
      }

      if(!isDefined(var_9a08bf56)) {
        var_9a08bf56 = util::spawn_model(#"tag_origin", v_spawn, vectortoangles(v_target - v_dest));

        if(!isDefined(var_75a7d6.var_c6454bbe)) {
          var_75a7d6.var_c6454bbe = [];
        } else if(!isarray(var_75a7d6.var_c6454bbe)) {
          var_75a7d6.var_c6454bbe = array(var_75a7d6.var_c6454bbe);
        }

        var_75a7d6.var_c6454bbe[var_75a7d6.var_c6454bbe.size] = var_9a08bf56;

        if(isDefined(var_9a08bf56)) {
          var_9a08bf56 clientfield::set("" + # "hash_78efd0fabb77e1ea", 1);
          var_9a08bf56 moveto(v_dest, 0.5);
          var_9a08bf56 waittill(#"death", #"movedone");

          if(isDefined(var_9a08bf56)) {
            level thread function_a511bfce(var_75a7d6, n_spawn, var_9a08bf56);
          }
        }

        continue;
      }

      var_9a08bf56 moveto(v_dest, 0.2);
      var_9a08bf56 rotateto(vectortoangles(v_target - v_dest), 0.2);
      wait 0.1;
    }
  }
}

function function_a511bfce(var_75a7d6, n_spawn, var_3e5ed63d) {
  var_b39864d6 = var_75a7d6.var_b39864d6;

  if(!(isDefined(var_3e5ed63d) && isDefined(n_spawn) && isDefined(var_75a7d6) && isDefined(var_b39864d6))) {
    return;
  }

  level endon(#"end_game");
  var_75a7d6 endon(#"defeated", #"hash_4c1f5a1219db67d");
  var_b39864d6 endon(#"death");
  var_3e5ed63d endon(#"death");
  wait 0.5;

  while(true) {
    switch (n_spawn) {
      case 0:
        v_spawn = var_b39864d6 gettagorigin("j_head") - anglesToForward(var_b39864d6.angles) * 8;
        break;
      case 1:
        v_spawn = var_b39864d6 gettagorigin("j_wrist_ri");
        break;
      case 2:
        v_spawn = var_b39864d6 gettagorigin("j_wrist_le");
        break;
    }

    if(isDefined(v_spawn)) {
      level thread function_ce715c05(v_spawn, var_3e5ed63d);
    }

    wait 1;
  }
}

function function_ce715c05(v_spawn, var_3e5ed63d) {
  var_8300eedb = util::spawn_model(#"tag_origin", v_spawn);
  var_8300eedb clientfield::set("" + # "hash_7006a5e1e75527f3", 1);

  if(isDefined(var_3e5ed63d)) {
    var_8300eedb moveto(var_3e5ed63d.origin, 0.5);
    var_8300eedb waittill(#"death", #"movedone");
  }

  if(isDefined(var_8300eedb)) {
    var_8300eedb clientfield::set("" + # "hash_7006a5e1e75527f3", 0);
    var_8300eedb thread util::delayed_delete(1);
  }
}

function function_d3bbbc22(var_75a7d6) {
  level endon(#"end_game");
  var_75a7d6 endon(#"defeated", #"hash_4c1f5a1219db67d");
  var_b39864d6 = var_75a7d6.var_b39864d6;

  if(!(isDefined(var_b39864d6) && isDefined(var_75a7d6.var_c6454bbe))) {
    return;
  }

  var_b39864d6 endon(#"death");
  var_7295c85a = arraycopy(var_75a7d6.var_c6454bbe);
  var_cd775a0f = undefined;

  while(isDefined(var_b39864d6) && isDefined(var_75a7d6.var_c6454bbe)) {
    if(var_7295c85a.size <= 0) {
      var_7295c85a = arraycopy(var_75a7d6.var_c6454bbe);
      arrayremovevalue(var_7295c85a, var_cd775a0f);
    }

    arrayremovevalue(var_7295c85a, undefined);
    var_cd775a0f = array::random(var_7295c85a);
    arrayremovevalue(var_7295c85a, var_cd775a0f);
    v_spawn = var_cd775a0f.origin;
    v_angles = var_cd775a0f.angles;

    if(isvec(v_spawn) && isvec(v_angles)) {
      v_spawn += anglestoup(v_angles) * randomfloatrange(-8, 8);
      v_spawn += anglestoright(v_angles) * randomfloatrange(-8, 8);
      e_shard = var_b39864d6 magicmissile(getweapon(#"hash_4c8d32da0a4944b9"), v_spawn, anglesToForward(v_angles) * 900);

      if(isDefined(e_shard)) {
        e_shard setteam(level.zombie_team);
      }
    }

    wait 0.1;
  }
}

function function_dca799af(e_player) {
  if(isDefined(e_player)) {
    wait 0.25;

    if(isDefined(e_player)) {
      e_player flag::clear(#"hash_19b5cea3c8abadc");
    }
  }
}

function function_8f60088e(var_75a7d6) {
  level endon(#"end_game");
  var_75a7d6 endon(#"defeated");
  var_75a7d6 flag::set(#"attacking");
  function_1798a522(var_75a7d6);
  var_b39864d6 = var_75a7d6.var_b39864d6;
  level thread function_ba5b8f59(var_75a7d6, var_b39864d6);
  level thread function_14725fe(var_75a7d6);

  if(!var_75a7d6 flag::get(#"hash_5af51c7c3fde832e")) {
    level thread function_4e595107(var_75a7d6, #"hash_9754b045afe5254");
  }

  level thread function_56818238(var_75a7d6);
  wait 7;
  level thread function_84f9cc2e(var_75a7d6, #"hash_5b18d00f994c17a4", 0);
  function_38e49607(var_75a7d6);
  var_dee0396e = "sit_tormen_out";
  var_ec892790 = "boss_sit_idle";

  if(var_75a7d6 flag::get(#"hash_482d5322e3bb32d3")) {
    var_dee0396e = "stand_tormen_out";
    var_ec892790 = "stand_idle";
  }

  var_b39864d6 scene::play(#"hash_63636406a7a2326", var_dee0396e, var_b39864d6);
  var_b39864d6 thread scene::play(#"hash_63636406a7a2326", var_ec892790, var_b39864d6);
  var_75a7d6 flag::clear(#"attacking");
  level thread function_e5dc0d0d(var_75a7d6);
  level thread function_73ef29bf(var_75a7d6, #"hash_9754b045afe5254");
}

function function_ba5b8f59(var_75a7d6, var_b39864d6) {
  if(!(isDefined(var_75a7d6) && isDefined(var_b39864d6))) {
    return;
  }

  level endon(#"end_game");
  var_75a7d6 endon(#"defeated");
  var_b39864d6 endon(#"death");
  var_504cdb19 = "sit_tormen_in";
  var_70c303e9 = "sit_tormen_loop";

  if(var_75a7d6 flag::get(#"hash_482d5322e3bb32d3")) {
    var_504cdb19 = "stand_tormen_in";
    var_70c303e9 = "stand_tormen_loop";
  }

  var_b39864d6 scene::play(#"hash_63636406a7a2326", var_504cdb19, var_b39864d6);
  var_b39864d6 thread scene::play(#"hash_63636406a7a2326", var_70c303e9, var_b39864d6);
}

function function_14725fe(var_75a7d6) {
  if(!isDefined(var_75a7d6)) {
    return;
  }

  level endon(#"end_game");
  var_75a7d6 notify(#"hash_709bc5d9b6b5feeb");
  var_75a7d6 endon(#"defeated", #"hash_709bc5d9b6b5feeb", #"hash_46e30440174c1da4");
  level clientfield::set("" + # "hash_228f0acdd4255cb", 1);
  wait 20;
  level clientfield::set("" + # "hash_228f0acdd4255cb", 0);
}

function function_56818238(var_75a7d6) {
  if(!isDefined(var_75a7d6)) {
    return;
  }

  level endon(#"end_game");
  var_75a7d6 endon(#"area_clear", #"defeated");
  n_players = function_a1ef346b().size;

  if(n_players < 1) {
    n_players = 1;
  } else if(n_players > 4) {
    n_players = 4;
  }

  switch (n_players) {
    case 1:
      var_4d36bf1b = 5;
      var_eff81ec3 = 7;
      n_delay = 0.2;
      break;
    case 2:
      var_4d36bf1b = 6;
      var_eff81ec3 = 8;
      n_delay = 0.2;
      break;
    case 3:
      var_4d36bf1b = 7;
      var_eff81ec3 = 9;
      n_delay = 0.2;
      break;
    case 4:
      var_4d36bf1b = 8;
      var_eff81ec3 = 11;
      n_delay = 0.2;
      break;
  }

  if(isDefined(var_eff81ec3) && isDefined(var_4d36bf1b) && isDefined(n_delay)) {
    n_spawns = randomintrangeinclusive(var_4d36bf1b, var_eff81ec3);

    for(i = 0; i < n_spawns; i++) {
      function_4cc9e609(var_75a7d6);

      while(true) {
        var_cdf231ac = namespace_abfee9ba::function_dfa96d1f();

        if(isDefined(var_cdf231ac)) {
          break;
        }

        waitframe(1);
      }

      var_cdf231ac callback::function_d8abfc3d(#"death", &function_48173b9b);
    }

    wait n_delay;
  }
}

function function_48173b9b(s_params) {
  self callback::function_52ac9652(#"death", &function_48173b9b);
  function_a0f1fc1d();
}

function function_771ae7ab(a_ents) {
  music::setmusicstate("cin_mid");
}

function function_37597f29() {}

function cmd(cmd) {
  switch (cmd) {
    case # "hash_213591a3df24967d":
      level.var_cc4817d7 = "<dev string:x38>";
      break;
    case # "hash_7b914ebf5b57c696":
      level.var_cc4817d7 = "<dev string:x40>";
      break;
    case # "hash_f72e94a26490fd7":
      level.var_cc4817d7 = "<dev string:x49>";
      break;
    case # "hash_12274633230d3eb4":
      level.var_cc4817d7 = "<dev string:x55>";
      break;
    case # "hash_5de2ff5967070ea8":
      level.var_cc4817d7 = "<dev string:x5d>";
      break;
    case # "hash_6ee66ab56d6217f6":
      level.var_cc4817d7 = undefined;
      break;
    case # "hash_264ec163f16c435b":
      level notify(#"hash_38f29f9cb03586ea");
      level notify(#"hash_3807e7b1086e4aa0");
      break;
    default:
      break;
  }
}