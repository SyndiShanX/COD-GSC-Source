/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1351b3cdb6539f9b.gsc
***********************************************/

#using script_5a7c9cfbe3d9580c;
#using script_5d2b67be820bed1a;
#using script_61fee52bb750ac99;
#using script_93de924cdc949f;
#using scripts\abilities\ability_util;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\districts;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp\cp_nam_prisoner_fx;
#using scripts\cp_common\arcade_machine;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\smart_bundle;
#using scripts\cp_common\util;
#namespace namespace_d9b153b9;

function function_ad9087cb() {}

function function_179cab4a() {}

function function_744492ec() {}

function function_49b8435c() {}

function function_1a8b3140() {}

function function_eab02ceb() {}

function function_821d8772() {}

function function_8d5f7d63() {}

function function_57eac84a() {}

function function_8229554e() {
  level clientfield::set("streamer_handler", 13);
}

function function_1b1c6dee() {
  level clientfield::set("streamer_handler", 14);
}

function function_a57f6629(var_c79d614f) {
  level flag::wait_till(var_c79d614f + "_exited");
  level notify(var_c79d614f + "_end");
}

function start_outro(str_objective) {
  if(!level flag::get("visit_start")) {
    level flag::set("visit_start");
  }

  level flag::wait_till("start_outro");
  skipto::function_4e3ab877(str_objective);
}

function function_e106e062(var_c79d614f, count) {
  if(!isDefined(count) && isDefined(level.var_731c10af.paths[var_c79d614f].count)) {
    count = level.var_731c10af.paths[var_c79d614f].count + 1;
  }

  if(isDefined(level.var_731c10af.paths[var_c79d614f].count) && level.var_731c10af.paths[var_c79d614f].count != count) {
    level.var_731c10af.paths[var_c79d614f].count = count;
  }

  if(issubstr(var_c79d614f, "caves") || issubstr(var_c79d614f, "village") || issubstr(var_c79d614f, "sniper_overlook") || issubstr(var_c79d614f, "rat_tunnels")) {
    if(count == 0) {
      arrayremovevalue(level.var_731c10af.var_e53f209f, var_c79d614f);
    } else if(!array::contains(level.var_731c10af.var_e53f209f, var_c79d614f)) {
      if(!isDefined(level.var_731c10af.var_e53f209f)) {
        level.var_731c10af.var_e53f209f = [];
      } else if(!isarray(level.var_731c10af.var_e53f209f)) {
        level.var_731c10af.var_e53f209f = array(level.var_731c10af.var_e53f209f);
      }

      level.var_731c10af.var_e53f209f[level.var_731c10af.var_e53f209f.size] = var_c79d614f;
    }

    if(level.var_731c10af.var_e53f209f.size == 0) {
      if(isDefined(level.var_731c10af.path_end_1)) {
        level.var_731c10af.path_end_1 = undefined;
      }

      if(isDefined(level.var_731c10af.path_end_2)) {
        level.var_731c10af.path_end_2 = undefined;
      }

      if(isDefined(level.var_731c10af.path_end_3)) {
        level.var_731c10af.path_end_3 = undefined;
      }

      if(isDefined(level.var_731c10af.path_end_4)) {
        level.var_731c10af.path_end_4 = undefined;
      }
    } else if(level.var_731c10af.var_e53f209f.size == 1) {
      if(!isDefined(level.var_731c10af.path_end_1)) {
        level.var_731c10af.path_end_1 = var_c79d614f;
      }

      if(isDefined(level.var_731c10af.path_end_2)) {
        level.var_731c10af.path_end_2 = undefined;
      }

      if(isDefined(level.var_731c10af.path_end_3)) {
        level.var_731c10af.path_end_3 = undefined;
      }

      if(isDefined(level.var_731c10af.path_end_4)) {
        level.var_731c10af.path_end_4 = undefined;
      }
    } else if(level.var_731c10af.var_e53f209f.size == 2) {
      if(!isDefined(level.var_731c10af.path_end_2)) {
        level.var_731c10af.path_end_2 = var_c79d614f;
      }

      if(isDefined(level.var_731c10af.path_end_3)) {
        level.var_731c10af.path_end_3 = undefined;
      }

      if(isDefined(level.var_731c10af.path_end_4)) {
        level.var_731c10af.path_end_4 = undefined;
      }
    } else if(level.var_731c10af.var_e53f209f.size == 3) {
      if(!isDefined(level.var_731c10af.path_end_3)) {
        level.var_731c10af.path_end_3 = var_c79d614f;
      }

      if(isDefined(level.var_731c10af.path_end_4)) {
        level.var_731c10af.path_end_4 = undefined;
      }
    }
  }

  if(!isDefined(level.var_baa7cf92)) {
    level function_7887d445();
  }

  if(issubstr(var_c79d614f, "memory")) {
    if(count == 0) {
      arrayremovevalue(level.var_731c10af.var_e15e5b51, var_c79d614f);
    } else if(!array::contains(level.var_731c10af.var_e15e5b51, var_c79d614f)) {
      if(!isDefined(level.var_731c10af.var_e15e5b51)) {
        level.var_731c10af.var_e15e5b51 = [];
      } else if(!isarray(level.var_731c10af.var_e15e5b51)) {
        level.var_731c10af.var_e15e5b51 = array(level.var_731c10af.var_e15e5b51);
      }

      level.var_731c10af.var_e15e5b51[level.var_731c10af.var_e15e5b51.size] = var_c79d614f;
    }

    new_count = 0;

    foreach(struct in level.var_731c10af.paths) {
      if(array::contains(level.var_731c10af.var_e15e5b51, struct.str)) {
        new_count += struct.count;
      }
    }

    level.var_731c10af.var_42659717 = new_count;

    if(level.var_731c10af.var_e15e5b51.size == 0) {
      if(isDefined(level.var_731c10af.var_6930d65d)) {
        level.var_731c10af.var_6930d65d = undefined;
      }

      if(isDefined(level.var_731c10af.var_319cffdd)) {
        level.var_731c10af.var_904e0f7b = undefined;
      }

      if(isDefined(level.var_731c10af.var_f0deb45a)) {
        level.var_731c10af.var_f0deb45a = undefined;
      }

      if(isDefined(level.var_731c10af.var_de9c117a)) {
        level.var_731c10af.var_de9c117a = undefined;
      }
    } else if(level.var_731c10af.var_e15e5b51.size == 1) {
      if(!isDefined(level.var_731c10af.var_6930d65d)) {
        if(isDefined(level.var_731c10af.path_end_1) && level.var_731c10af.path_end_1 == level.var_baa7cf92) {
          level.var_731c10af.var_6930d65d = "obey";
          function_19580b0c();
        } else {
          level.var_731c10af.var_6930d65d = "disobey";
          function_723dc7fc();
        }
      }

      if(isDefined(level.var_731c10af.var_319cffdd)) {
        level.var_731c10af.var_319cffdd = undefined;
      }

      if(isDefined(level.var_731c10af.var_f0deb45a)) {
        level.var_731c10af.var_f0deb45a = undefined;
      }

      if(isDefined(level.var_731c10af.var_de9c117a)) {
        level.var_731c10af.var_de9c117a = undefined;
      }
    } else if(level.var_731c10af.var_e15e5b51.size == 2) {
      if(!isDefined(level.var_731c10af.var_319cffdd)) {
        if(isDefined(level.var_731c10af.path_end_2) && level.var_731c10af.path_end_2 == level.var_baa7cf92) {
          level.var_731c10af.var_319cffdd = "obey";
          function_19580b0c();
        } else {
          level.var_731c10af.var_319cffdd = "disobey";
          function_723dc7fc();
        }
      }

      if(isDefined(level.var_731c10af.var_f0deb45a)) {
        level.var_731c10af.var_f0deb45a = undefined;
      }

      if(isDefined(level.var_731c10af.var_de9c117a)) {
        level.var_731c10af.var_de9c117a = undefined;
      }
    } else if(level.var_731c10af.var_e15e5b51.size == 3) {
      if(!isDefined(level.var_731c10af.var_f0deb45a)) {
        if(isDefined(level.var_731c10af.path_end_3) && level.var_731c10af.path_end_3 == level.var_baa7cf92) {
          level.var_731c10af.var_f0deb45a = "obey";
          function_19580b0c();
        } else {
          level.var_731c10af.var_f0deb45a = "disobey";
          function_723dc7fc();
        }
      }

      if(isDefined(level.var_731c10af.memory_4)) {
        level.var_731c10af.var_de9c117a = undefined;
      }
    } else if(level.var_731c10af.var_e15e5b51.size == 4) {
      if(!isDefined(level.var_731c10af.var_de9c117a)) {
        if(isDefined(level.var_731c10af.path_end_4) && level.var_731c10af.path_end_4 == level.var_baa7cf92) {
          level.var_731c10af.var_de9c117a = "obey";
        } else {
          level.var_731c10af.var_de9c117a = "disobey";
        }
      }
    }

    if(level.var_731c10af.var_e15e5b51.size >= 3) {
      level flag::set("exit_ready");

      if(!isDefined(level.var_731c10af.var_d8a772da) || isDefined(level.var_731c10af.var_d8a772da) && level.var_731c10af.var_d8a772da != "exit") {
        level.var_731c10af.var_d8a772da = "exit";
      }
    }

    level function_7887d445();

    if(level.var_731c10af.var_e15e5b51.size == 0) {
      if(!level flag::get("flag_mem_count_1")) {
        level flag::set("flag_mem_count_1");
      }
    } else if(level.var_731c10af.var_e15e5b51.size == 1) {
      if(!level flag::get("flag_mem_count_2")) {
        level flag::set("flag_mem_count_2");
      }
    } else if(level.var_731c10af.var_e15e5b51.size == 2) {
      if(!level flag::get("flag_mem_count_3")) {
        level flag::set("flag_mem_count_3");
      }
    } else if(level.var_731c10af.var_e15e5b51.size == 3) {
      if(!level flag::get("flag_mem_count_4")) {
        level flag::set("flag_mem_count_4");
      }
    }
  }

  level notify(#"hash_49baa21ba98c2f0");
}

function function_19580b0c() {
  if(!isDefined(level.var_731c10af.var_526c7422)) {
    level.var_731c10af.var_526c7422 = 0;
    return;
  }

  level.var_731c10af.var_526c7422++;
}

function function_723dc7fc() {
  if(!isDefined(level.var_731c10af.var_58ca484f)) {
    level.var_731c10af.var_58ca484f = 0;
    return;
  }

  level.var_731c10af.var_58ca484f++;
}

function function_7887d445() {
  if(!isDefined(level.var_baa7cf92)) {
    level.var_baa7cf92 = "caves";
  }

  if(level.var_731c10af.var_42659717 == 0) {
    level.var_baa7cf92 = "caves";
    return;
  }

  if(level.var_731c10af.var_42659717 == 1) {
    if(!array::contains(level.var_731c10af.var_e53f209f, "caves")) {
      level.var_baa7cf92 = "caves";
    } else {
      level.var_baa7cf92 = "village";
    }

    return;
  }

  if(level.var_731c10af.var_42659717 == 2) {
    if(!array::contains(level.var_731c10af.var_e53f209f, "caves")) {
      level.var_baa7cf92 = "caves";
    } else if(!array::contains(level.var_731c10af.var_e53f209f, "village")) {
      level.var_baa7cf92 = "village";
    } else {
      level.var_baa7cf92 = "sniper_overlook";
    }

    return;
  }

  if(level.var_731c10af.var_42659717 == 3) {
    level.var_baa7cf92 = "exit";
  }
}

function function_7933659() {
  level.sniper_overlook_blocker = getEntArray("sniper_overlook_blocker", "targetname");

  foreach(item in level.sniper_overlook_blocker) {
    item hide();
    item notsolid();
  }

  level.village_blocker = getEntArray("village_blocker", "targetname");

  foreach(item in level.village_blocker) {
    item hide();
    item notsolid();
  }
}

function function_2d527091(var_a4084657) {
  level endon(#"visit_restart");
  level endon(#"start_outro");
  a_flags = [];
  a_flags[0] = "flag_caves_backtrack_blocker";
  a_flags[1] = "flag_village_backtrack_blocker";
  a_flags[2] = "flag_sniper_overlook_backtrack_blocker";
  a_flags[3] = "flag_rat_tunnels_backtrack_blocker";

  if(!isDefined(var_a4084657)) {
    result = level flag::wait_till_any(a_flags);
    var_a4084657 = result._notify;
  }

  switch (var_a4084657) {
    case # "flag_caves_backtrack_blocker":
      level flag::set("flag_backtrack_blocker_caves");
      break;
    case # "flag_village_backtrack_blocker":
      foreach(item in level.village_blocker) {
        item show();
        item solid();
      }

      level flag::set("flag_backtrack_blocker_village");
      break;
    case # "flag_sniper_overlook_backtrack_blocker":
      foreach(item in level.sniper_overlook_blocker) {
        item show();
        item solid();
      }

      level flag::set("flag_backtrack_blocker_sniper_overlook");
      break;
    case # "flag_rat_tunnels_backtrack_blocker":
      a_ents = [];
      a_ents[#"hatch"] = getent("rat_tunnel_hatch", "targetname");
      level thread scene::play("scene_pri_rat_tunnel_hatch_close", a_ents);
      break;
  }
}

function function_3642c497() {
  level flag::clear("flag_sniper_overlook_backtrack_blocker");
  level flag::clear("flag_village_backtrack_blocker");
  level flag::clear("flag_caves_backtrack_blocker");
  level flag::clear("flag_rat_tunnels_backtrack_blocker");
}

function function_fa427f65(location) {
  level thread namespace_8589bd1a::function_554199a0(location);
  level thread namespace_b6fe1dbe::function_62dfea3e(location);
}

function function_47e52704(flag_name, var_4462b697, vo_array) {
  level endon(#"visit_restart");
  level endon(#"start_outro");
  var_4f1752ba = 0;

  while(true) {
    function_c66297e0(flag_name, var_4462b697, vo_array, var_4f1752ba);
  }
}

function function_c66297e0(flag_name, var_4462b697, vo_array, var_4f1752ba) {
  if(flag::exists(flag_name)) {
    level flag::wait_till(flag_name);
  }

  level.player enableinvulnerability();
  level thread pstfx_teleport(1, 0, "door");

  if(flag::exists(flag_name + "_teleport")) {
    level flag::wait_till_timeout(0.15, flag_name + "_teleport");
  } else {
    wait 0.15;
  }

  teleport_struct = struct::get(var_4462b697, "targetname");

  if(!isDefined(level.var_76b555e0)) {
    level.var_76b555e0 = util::spawn_model("tag_origin", teleport_struct.origin, teleport_struct.angles);
  } else {
    level.var_76b555e0.origin = teleport_struct.origin;
    level.var_76b555e0.angles = teleport_struct.angles;
  }

  level.player playerlinktoabsolute(level.var_76b555e0, "tag_origin");
  var_4f1752ba = function_77cfda19(var_4f1752ba, vo_array);
  wait 1;
  level flag::set("flag_clear_teleport_fx");
  level flag::clear(flag_name);
  level flag::clear(flag_name + "_teleport");
  level.player unlink();
  level.player disableinvulnerability();
}

function function_ab3b4aa5(flag_name) {
  level flag::wait_till(flag_name);
  level notify(#"hash_7533f961cdbec9ae");
}

function function_77cfda19(var_4f1752ba, vo_array) {
  if(isDefined(vo_array[var_4f1752ba])) {
    level thread dialogue::radio(vo_array[var_4f1752ba]);
  }

  if(isDefined(vo_array) && isDefined(var_4f1752ba) && var_4f1752ba < vo_array.size) {
    var_4f1752ba += 1;
  } else {
    var_4f1752ba = 0;
  }

  return var_4f1752ba;
}

function player_teleport(var_2cb02b2f, var_880840af = 1, var_b9a81537 = 0.5) {
  var_6d10ff71 = function_87bd340();

  if(!isDefined(var_6d10ff71) || !var_6d10ff71) {
    return;
  }

  org = level.var_7121e70a;
  assert(isDefined(org));

  if(is_true(var_880840af)) {
    lui::screen_fade_out(var_b9a81537, (0, 0, 0));
  }

  self freezecontrols(1);
  self setstance("stand");
  self dontinterpolate();
  self setorigin(org.origin);
  self setplayerangles(org.angles);

  if(is_true(var_880840af)) {
    self thread lui::screen_fade_in(var_b9a81537, (0, 0, 0));
  }

  self freezecontrols(0);
}

function function_87bd340() {
  if(isDefined(level.var_28c22d88)) {
    if(array::contains(level.var_28c22d88, "path_end_1")) {
      if(isDefined(level.var_731c10af.var_d8a772da)) {
        level.var_7121e70a = struct::get(level.var_731c10af.var_d8a772da + "_teleport", "targetname");
      } else {
        level.var_7121e70a = struct::get("caves_teleport", "targetname");
      }

      return 1;
    }

    if(array::contains(level.var_28c22d88, "path_end_2")) {
      if(isDefined(level.var_731c10af.var_d8a772da)) {
        level.var_7121e70a = struct::get(level.var_731c10af.var_d8a772da + "_teleport", "targetname");
      } else {
        level.var_7121e70a = struct::get("village_teleport", "targetname");
      }

      return 1;
    }

    if(array::contains(level.var_28c22d88, "path_end_3")) {
      if(isDefined(level.var_731c10af.var_d8a772da)) {
        level.var_7121e70a = struct::get(level.var_731c10af.var_d8a772da + "_teleport", "targetname");
      } else {
        level.var_7121e70a = struct::get("sniper_overlook_teleport", "targetname");
      }

      return 1;
    }

    if(array::contains(level.var_28c22d88, "path_end_4")) {
      if(isDefined(level.var_731c10af.var_d8a772da)) {
        level.var_7121e70a = struct::get(level.var_731c10af.var_d8a772da + "_teleport", "targetname");
      } else {
        level.var_7121e70a = struct::get("rat_tunnels_teleport", "targetname");
      }

      return 1;
    }

    if(array::contains(level.var_28c22d88, "memory_1")) {
      if(isDefined(level.var_731c10af.path_end_1) && level.var_731c10af.path_end_1 == level.var_baa7cf92) {
        level.var_7121e70a = struct::get("bunker_1_teleport", "targetname");
      } else {
        level.var_7121e70a = struct::get("memory_1_disobey_teleport", "targetname");
      }

      return 1;
    }

    if(array::contains(level.var_28c22d88, "memory_2")) {
      if(isDefined(level.var_731c10af.path_end_2) && level.var_731c10af.path_end_2 == level.var_baa7cf92) {
        level.var_7121e70a = struct::get("bunker_2_teleport", "targetname");
      } else {
        level.var_7121e70a = struct::get("memory_2_disobey_teleport", "targetname");
      }

      return 1;
    }

    if(array::contains(level.var_28c22d88, "memory_3") || array::contains(level.var_28c22d88, "dev_memory_3_disobey_end") || array::contains(level.var_28c22d88, "dev_memory_3_end")) {
      if(array::contains(level.var_28c22d88, "dev_memory_3_disobey_end")) {
        level.var_7121e70a = struct::get("memory_3_disobey_end_teleport", "targetname");
      } else if(array::contains(level.var_28c22d88, "dev_memory_3_end")) {
        level.var_7121e70a = struct::get("memory_3_end_teleport", "targetname");
      } else {
        level.var_7121e70a = struct::get("dev_infinite_hallway_loop_2", "script_objective");
      }

      return 1;
    }

    if(array::contains(level.var_28c22d88, "memory_4")) {
      level.var_7121e70a = struct::get("bunker_1_teleport", "targetname");
      return 1;
    }

    return 0;
  }
}

function pstfx_teleport(short, fade, sound_type) {
  if(isDefined(getDvar(#"hash_116c017a4800cfcf")) && getDvar(#"hash_116c017a4800cfcf") != 0) {
    return;
  }

  thread namespace_b6fe1dbe::function_ee033aa(short, sound_type);

  if(is_true(short) && is_true(fade)) {
    level.player clientfield::set_to_player("pstfx_teleport", 2);
    level thread lui::screen_fade_out(0.5, "white", undefined, 1);
    level.player val::set(#"hash_3a1cea25b89b4a66", "show_hud", 0);
  } else if(is_true(short)) {
    level.player clientfield::set_to_player("pstfx_teleport", 2);
    wait 0.3;
    level.player clientfield::set_to_player("set_player_pbg_bank", 1);
  } else if(is_true(fade)) {
    level.player clientfield::set_to_player("pstfx_teleport", 1);
    wait 0.75;
    level.player clientfield::set_to_player("set_player_pbg_bank", 1);
    level thread lui::screen_fade_out(0.25, "white", undefined, 1);
    level.player val::set(#"hash_3a1cea25b89b4a66", "show_hud", 0);
  } else {
    level.player clientfield::set_to_player("pstfx_teleport", 1);
    wait 0.75;
    level.player clientfield::set_to_player("set_player_pbg_bank", 1);
  }

  level notify(#"hash_35bc1cd22912ce5c");
  level flag::wait_till("flag_clear_teleport_fx");

  if(is_true(fade)) {
    level thread lui::screen_fade_in(0.1, "white");
    level.player val::set(#"hash_3a1cea25b89b4a66", "show_hud", 1);
  }

  level.player clientfield::set_to_player("set_player_pbg_bank", 0);
  wait 0.15;
  level.player clientfield::set_to_player("pstfx_teleport", 0);
  level flag::clear("flag_clear_teleport_fx");
}

function function_4b72557e() {
  self clientfield::set_to_player("pstfx_napalm_dirt", 1);
}

function function_19540c8c() {
  self clientfield::set_to_player("pstfx_napalm_dirt", 0);
}

function function_c1e6a263() {
  if(isDefined(getDvar(#"hash_7c47b0df779cebb2")) && getDvar(#"hash_7c47b0df779cebb2") != 0) {
    return;
  }

  self thread function_b0ea272(#"c_t9_usa_hero_adler_civ_amsterdam_body", #"c_t9_cp_usa_hero_adler_head1");

  if(isDefined(self.destructibledef)) {
    self.destructibledef = undefined;
  }
}

function function_6b921cdd() {
  while(!isDefined(level.player_connected)) {
    wait 0.05;
  }

  var_199e42f2 = ["flag_mem_count_1", "flag_mem_count_2", "flag_mem_count_3", "flag_mem_count_4"];

  while(var_199e42f2.size > 0) {
    level flag::wait_till_any(var_199e42f2);
    level function_82e5e0c2();
    temp_array = [];

    foreach(flag in var_199e42f2) {
      if(!level flag::get(flag)) {
        if(!isDefined(temp_array)) {
          temp_array = [];
        } else if(!isarray(temp_array)) {
          temp_array = array(temp_array);
        }

        if(!isinarray(temp_array, flag)) {
          temp_array[temp_array.size] = flag;
        }
      }
    }

    var_199e42f2 = temp_array;
    wait 0.1;
  }
}

function function_82e5e0c2() {
  level util::function_bfa9c188("mdl_mem_desk_dyn", 1);
  level util::function_bfa9c188("mdl_mem_desk_right_dyn", 1);
  level util::function_bfa9c188("mdl_mem_desk_left_dyn", 1);
  level util::function_bfa9c188("mdl_mem_scarecrow_overlook_dyn", 1);
  level util::function_bfa9c188("mdl_mem_scarecrow_dyn", 1);
  level util::function_bfa9c188("mdl_mem_scarecrow_rat_dyn", 1);
  level util::function_bfa9c188("mdl_mem_scarecrow_right_dyn", 1);
  level util::function_bfa9c188("mdl_mem_scarecrow_left_dyn", 1);

  if(level flag::get("flag_mem_count_1") && !isDefined(level.flag_mem_count_1)) {
    level.flag_mem_count_1 = 1;
    level util::function_bfa9c188("mdl_mem_scarecrow_dyn");

    if(level.var_baa7cf92 == "caves" || level.var_baa7cf92 == "rat_tunnels") {
      level flag::set("flag_mem_scarecrow");
      level util::function_bfa9c188("mdl_mem_scarecrow_left_dyn");
      level thread function_fe844d54("jungle_torch_fire_left");
      level thread function_33ffe083("jungle_torch_fire_right");
      level thread function_a45a0347("light_jungle_torch_fire_left_day");
      level thread function_c318ce4a("light_jungle_torch_fire_left_night");
      level thread function_c318ce4a("light_jungle_torch_fire_right_day");
      level thread function_c318ce4a("light_jungle_torch_fire_right_night");
    } else if(level.var_baa7cf92 == "sniper_overlook" || level.var_baa7cf92 == "village") {
      level flag::set("flag_mem_scarecrow");
      level util::function_bfa9c188("mdl_mem_scarecrow_right_dyn");
      level thread function_fe844d54("jungle_torch_fire_right");
      level thread function_33ffe083("jungle_torch_fire_left");
      level thread function_a45a0347("light_jungle_torch_fire_left_day");
      level thread function_c318ce4a("light_jungle_torch_fire_left_night");
      level thread function_c318ce4a("light_jungle_torch_fire_right_day");
      level thread function_c318ce4a("light_jungle_torch_fire_right_night");
    }
  }

  if(level flag::get("flag_mem_count_2") && !isDefined(level.flag_mem_count_2)) {
    level.flag_mem_count_2 = 1;

    if(isDefined(level.var_731c10af.var_526c7422)) {
      level flag::set("flag_mem_2_obj_obey");
      util::delay(1, undefined, &districts::function_a7d79fcb, "memory_2_obey");
    }

    if(isDefined(level.var_731c10af.var_58ca484f)) {
      level flag::set("flag_mem_2_obj_disobey");
      util::delay(1, undefined, &districts::function_a7d79fcb, "memory_2_disobey");
    }

    level flag::clear("flag_mem_scarecrow");
    level flag::set("flag_mem_tvs");
    level util::function_bfa9c188("mdl_mem_scarecrow_dyn", 1);
    level util::function_bfa9c188("mdl_mem_scarecrow_right_dyn", 1);
    level util::function_bfa9c188("mdl_mem_scarecrow_left_dyn", 1);

    if(level.var_baa7cf92 == "caves" || level.var_baa7cf92 == "rat_tunnels") {
      util::delay(1, undefined, &districts::function_a7d79fcb, "memory_2_jungle_path_fork_left");
      scene::add_scene_func("scene_pri_red_light_swing", &function_4ad393d5);
      level thread scene::play("scene_pri_red_light_swing_left", "targetname");
      level thread function_33ffe083("jungle_torch_fire_left");
      level thread function_33ffe083("jungle_torch_fire_right");
      level thread function_c318ce4a("light_jungle_torch_fire_left_day");
      level thread function_c318ce4a("light_jungle_torch_fire_left_night");
      level thread function_c318ce4a("light_jungle_torch_fire_right_day");
      level thread function_c318ce4a("light_jungle_torch_fire_right_night");
      level thread function_fe844d54("lgt_temple_left");
    } else if(level.var_baa7cf92 == "village" || level.var_baa7cf92 == "sniper_overlook") {
      util::delay(1, undefined, &districts::function_a7d79fcb, "memory_2_jungle_path_fork_right");
      scene::add_scene_func("scene_pri_red_light_swing", &function_4ad393d5);
      level thread scene::play("scene_pri_red_light_swing_right", "targetname");
      level thread function_33ffe083("jungle_torch_fire_left");
      level thread function_33ffe083("jungle_torch_fire_right");
      level thread function_c318ce4a("light_jungle_torch_fire_left_day");
      level thread function_c318ce4a("light_jungle_torch_fire_left_night");
      level thread function_c318ce4a("light_jungle_torch_fire_right_day");
      level thread function_c318ce4a("light_jungle_torch_fire_right_night");
      level thread function_fe844d54("lgt_temple_right");
    }
  }

  if(level flag::get("flag_mem_count_3") && !isDefined(level.flag_mem_count_3)) {
    level.flag_mem_count_3 = 1;
    var_4ddb3cd5 = [];

    if(isDefined(level.var_731c10af.var_526c7422)) {
      level flag::set("flag_mem_2_obj_obey");

      if(!isDefined(var_4ddb3cd5)) {
        var_4ddb3cd5 = [];
      } else if(!isarray(var_4ddb3cd5)) {
        var_4ddb3cd5 = array(var_4ddb3cd5);
      }

      if(!isinarray(var_4ddb3cd5, "memory_2_obey")) {
        var_4ddb3cd5[var_4ddb3cd5.size] = "memory_2_obey";
      }
    }

    if(isDefined(level.var_731c10af.var_58ca484f)) {
      level flag::set("flag_mem_2_obj_disobey");

      if(!isDefined(var_4ddb3cd5)) {
        var_4ddb3cd5 = [];
      } else if(!isarray(var_4ddb3cd5)) {
        var_4ddb3cd5 = array(var_4ddb3cd5);
      }

      if(!isinarray(var_4ddb3cd5, "memory_2_disobey")) {
        var_4ddb3cd5[var_4ddb3cd5.size] = "memory_2_disobey";
      }
    }

    if(!isDefined(var_4ddb3cd5)) {
      var_4ddb3cd5 = [];
    } else if(!isarray(var_4ddb3cd5)) {
      var_4ddb3cd5 = array(var_4ddb3cd5);
    }

    if(!isinarray(var_4ddb3cd5, "memory_3")) {
      var_4ddb3cd5[var_4ddb3cd5.size] = "memory_3";
    }

    util::delay(1, undefined, &districts::function_a7d79fcb, var_4ddb3cd5);
    level flag::clear("flag_mem_tvs");
    level flag::set("flag_mem_desk");
    level util::function_bfa9c188("mdl_mem_desk_dyn");
    util::delay(1, undefined, &districts::function_930f8c81, "memory_2_jungle_path_fork_left");
    util::delay(1, undefined, &districts::function_930f8c81, "memory_2_jungle_path_fork_right");

    if(flag::get("flag_rat_tunnels") && flag::get("flag_caves")) {
      var_cc739c00 = 1;
    }

    if(flag::get("flag_village") && flag::get("flag_sniper_overlook")) {
      var_8df5a3a = 1;
    }

    level thread function_33ffe083("lgt_temple_left");
    level thread function_33ffe083("lgt_temple_right");

    if(isDefined(var_cc739c00)) {
      function_323334e2();

      if(flag::get("flag_rat_tunnels") && flag::get("flag_caves") && level.var_baa7cf92 == "village") {
        level flag::set("flag_mem_scarecrow_overlook");
        level util::function_bfa9c188("mdl_mem_scarecrow_overlook_dyn");
      }
    } else if(isDefined(var_8df5a3a)) {
      function_3f1dd09e();

      if(flag::get("flag_village") && flag::get("flag_sniper_overlook") && level.var_baa7cf92 == "caves") {
        level flag::set("flag_mem_scarecrow_rat");
        level util::function_bfa9c188("mdl_mem_scarecrow_rat_dyn");
      }
    } else if(level.var_baa7cf92 == "village" || level.var_baa7cf92 == "sniper_overlook") {
      function_3f1dd09e();
    } else if(level.var_baa7cf92 == "caves" || level.var_baa7cf92 == "rat_tunnels") {
      function_323334e2();
    }
  }

  if(level flag::get("flag_mem_count_4") && !isDefined(level.flag_mem_count_4)) {
    level.flag_mem_count_4 = 1;
    var_4ddb3cd5 = [];

    if(isDefined(level.var_731c10af.var_526c7422)) {
      level flag::set("flag_mem_2_obj_obey");

      if(!isDefined(var_4ddb3cd5)) {
        var_4ddb3cd5 = [];
      } else if(!isarray(var_4ddb3cd5)) {
        var_4ddb3cd5 = array(var_4ddb3cd5);
      }

      if(!isinarray(var_4ddb3cd5, "memory_2_obey")) {
        var_4ddb3cd5[var_4ddb3cd5.size] = "memory_2_obey";
      }
    }

    if(isDefined(level.var_731c10af.var_58ca484f)) {
      level flag::set("flag_mem_2_obj_disobey");

      if(!isDefined(var_4ddb3cd5)) {
        var_4ddb3cd5 = [];
      } else if(!isarray(var_4ddb3cd5)) {
        var_4ddb3cd5 = array(var_4ddb3cd5);
      }

      if(!isinarray(var_4ddb3cd5, "memory_2_disobey")) {
        var_4ddb3cd5[var_4ddb3cd5.size] = "memory_2_disobey";
      }
    }

    if(!isDefined(var_4ddb3cd5)) {
      var_4ddb3cd5 = [];
    } else if(!isarray(var_4ddb3cd5)) {
      var_4ddb3cd5 = array(var_4ddb3cd5);
    }

    if(!isinarray(var_4ddb3cd5, "memory_3")) {
      var_4ddb3cd5[var_4ddb3cd5.size] = "memory_3";
    }

    level thread function_f8c7740b("flag_rice_paddies", var_4ddb3cd5, 1);
    level flag::clear("flag_mem_scarecrow_overlook");
    level flag::clear("flag_mem_scarecrow_rat");
    level util::function_bfa9c188("mdl_mem_scarecrow_overlook_dyn", 1);
    level util::function_bfa9c188("mdl_mem_scarecrow_rat_dyn", 1);
    level flag::clear("flag_mem_desk");
    level util::function_bfa9c188("mdl_mem_desk_dyn", 1);
    level util::function_bfa9c188("mdl_mem_desk_left_dyn", 1);
    level util::function_bfa9c188("mdl_mem_desk_right_dyn", 1);
    level thread namespace_1bc068e2::function_9fbac7d();
    level thread function_fe844d54("jungle_torch_fire_left");
    level thread function_fe844d54("jungle_torch_fire_right");
    level thread function_c318ce4a("light_jungle_torch_fire_left_night");
    level thread function_c318ce4a("light_jungle_torch_fire_right_night");
    level function_b96db417("light_jungle_torch_fire_left_day");
    level thread function_a45a0347("light_jungle_torch_fire_left_day");
    level function_b96db417("light_jungle_torch_fire_right_day");
    level thread function_a45a0347("light_jungle_torch_fire_right_day");
  }
}

function function_4ad393d5(a_ents) {
  level.red_light = a_ents[#"red_light"];

  if(isDefined(level.red_light)) {
    if(isDefined(level.red_light._scene_object._o_scene._e_root.targetname)) {
      if(level.red_light._scene_object._o_scene._e_root.targetname == "scene_pri_red_light_swing_right") {
        level exploder::exploder("Ambfx_Red_Light_Right");
      } else {
        level exploder::exploder("Ambfx_Red_Light_Left");
      }

      level thread function_5f210295(level.red_light._scene_object._o_scene._e_root.targetname);
    }
  }
}

function function_5f210295(var_e2d1add6) {
  level flag::wait_till_any(array("flag_in_end_path", "flag_mem_count_3", "middle_paths_2_completed"));
  level thread scene::stop("scene_pri_red_light_swing");

  if(isDefined(level.red_light)) {
    if(isDefined(var_e2d1add6) && var_e2d1add6 == "scene_pri_red_light_swing_right") {
      level exploder::stop_exploder("Ambfx_Red_Light_Right");
    } else {
      level exploder::stop_exploder("Ambfx_Red_Light_Left");
    }

    level.red_light util::delay(1, undefined, &ent_cleanup);
  }
}

function function_323334e2() {
  level util::function_bfa9c188("mdl_mem_desk_left_dyn");
  level thread function_fe844d54("jungle_torch_fire_left");
  level thread function_33ffe083("jungle_torch_fire_right");
  level thread function_c318ce4a("light_jungle_torch_fire_left_night");
  level thread function_c318ce4a("light_jungle_torch_fire_right_day");
  level thread function_c318ce4a("light_jungle_torch_fire_right_night");
  level function_b96db417("light_jungle_torch_fire_left_day");
  level thread function_a45a0347("light_jungle_torch_fire_left_day");
}

function function_3f1dd09e() {
  level util::function_bfa9c188("mdl_mem_desk_right_dyn");
  level thread function_33ffe083("jungle_torch_fire_left");
  level thread function_fe844d54("jungle_torch_fire_right");
  level thread function_c318ce4a("light_jungle_torch_fire_left_day");
  level thread function_c318ce4a("light_jungle_torch_fire_left_night");
  level thread function_c318ce4a("light_jungle_torch_fire_right_night");
  level function_b96db417("light_jungle_torch_fire_right_day");
  level thread function_a45a0347("light_jungle_torch_fire_right_day");
}

function function_fe844d54(var_88db8fbc) {
  wait 1;
  level thread exploder::exploder(var_88db8fbc);
}

function function_33ffe083(var_88db8fbc) {
  wait 1;
  level thread exploder::stop_exploder(var_88db8fbc);
}

function door_setup(struct_targetname, struct, var_9409066b, var_f1096822, var_17716e4f) {
  if(isDefined(struct_targetname)) {
    door_struct = struct::get(struct_targetname, "targetname");
  } else if(isDefined(struct)) {
    door_struct = struct;
  }

  if(!isDefined(door_struct)) {
    return;
  }

  if(isDefined(door_struct.linkto)) {
    door_struct.linked_structs = struct::get_array(door_struct.linkto, "linkname");

    if(isDefined(door_struct.linked_structs) && door_struct.linked_structs.size > 0 && !isDefined(door_struct.var_408c6332)) {
      foreach(struct in door_struct.linked_structs) {
        if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "door_interact" && isDefined(var_9409066b)) {
          continue;
        }

        if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "door_fx" && !isDefined(var_17716e4f)) {
          continue;
        }

        ent = spawn("script_model", struct.origin);
        ent.angles = struct.angles;

        if(isDefined(struct.script_parameters)) {
          ent setModel(struct.script_parameters);
        }

        if(isDefined(struct.script_noteworthy)) {
          ent.script_noteworthy = struct.script_noteworthy;
        }

        ent.linkname = struct.linkname;

        if(!isDefined(door_struct.var_408c6332)) {
          door_struct.var_408c6332 = 1;
        }
      }
    }

    door_struct.linked_ents = getEntArray(door_struct.linkto, "linkname");

    foreach(ent in door_struct.linked_ents) {
      if(isDefined(ent.script_noteworthy)) {
        switch (ent.script_noteworthy) {
          case # "door_left":
            door_struct.door_left = ent;
            break;
          case # "door_right":
            door_struct.door_right = ent;
            break;
          case # "hash_474cd81e3615d473":
            door_struct.door_frame = ent;
            break;
          case # "hash_7d5f05ba8b4de0a4":
            door_struct.var_113d9d43 = ent;
            break;
          case # "hash_1d188472b888f844":
            if(isDefined(var_f1096822)) {
              if(isDefined(ent.script_parameters) && ent.script_parameters == "door_light_script_model") {
                ent delete();
                break;
              }
            }

            if(!isDefined(door_struct.var_cb5b8c95)) {
              door_struct.var_cb5b8c95 = [];
            }

            if(!isDefined(door_struct.var_cb5b8c95)) {
              door_struct.var_cb5b8c95 = [];
            } else if(!isarray(door_struct.var_cb5b8c95)) {
              door_struct.var_cb5b8c95 = array(door_struct.var_cb5b8c95);
            }

            if(!isinarray(door_struct.var_cb5b8c95, ent)) {
              door_struct.var_cb5b8c95[door_struct.var_cb5b8c95.size] = ent;
            }

            break;
          case # "door_interact":
            door_struct.door_interact = ent;
            door_struct thread function_736b8a03(1);
            break;
          case # "hash_4e931f37285562af":
            if(isDefined(var_f1096822)) {
              if(isDefined(ent)) {
                ent delete();
              }
            } else {
              if(!isDefined(door_struct.var_2c0374ca)) {
                door_struct.var_2c0374ca = [];
              }

              if(!isDefined(door_struct.var_2c0374ca)) {
                door_struct.var_2c0374ca = [];
              } else if(!isarray(door_struct.var_2c0374ca)) {
                door_struct.var_2c0374ca = array(door_struct.var_2c0374ca);
              }

              if(!isinarray(door_struct.var_2c0374ca, ent)) {
                door_struct.var_2c0374ca[door_struct.var_2c0374ca.size] = ent;
              }
            }

            break;
        }
      }
    }
  }

  door_struct.door_setup = 1;
  return door_struct;
}

function function_736b8a03(on) {
  if(isDefined(on)) {
    if(isDefined(self.door_interact) && !isDefined(self.door_interact.var_3e95b88f)) {
      self.door_interact util::create_cursor_hint("tag_origin", (0, 0, 0), #"hash_4aba34f692d535a6", 64);
    }

    return;
  }

  if(isDefined(self.door_interact) && isDefined(self.door_interact.var_3e95b88f)) {
    self.door_interact util::remove_cursor_hint();
  }
}

function ent_cleanup(var_c35279ad, time_to_wait) {
  if(isDefined(var_c35279ad)) {
    level flag::wait_till(var_c35279ad);
  }

  if(isDefined(time_to_wait)) {
    wait time_to_wait;
  }

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.linked_ents)) {
    foreach(ent in self.linked_ents) {
      if(isDefined(ent.script_noteworthy) && ent.script_noteworthy == "door_interact") {
        self thread function_736b8a03();
      }

      if(isDefined(ent)) {
        ent delete();
      }
    }

    return;
  }

  self delete();
}

function function_5f3438c4() {
  items = getitemarray();
  ai_array = getaiteamarray();

  foreach(ai in ai_array) {
    if(isDefined(ai)) {
      ai delete();
    }
  }

  wait 1;
  corpses = getcorpsearray();

  foreach(corpse in corpses) {
    if(isactorcorpse(corpse)) {
      corpse delete();
    }
  }
}

function function_feb24b1d() {
  mapname = util::get_map_name();
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x49>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x95>");

  if(!isDefined(getDvar(#"hash_3ccd60d85ae08cb5"))) {
    setDvar(#"hash_3ccd60d85ae08cb5", "<dev string:xe2>");
  }

  struct = {
    #name: # "hash_3ccd60d85ae08cb5", #value: getDvar(#"hash_3ccd60d85ae08cb5")
  };
  function_83641a8a(struct);
  function_cd140ee9("<dev string:xe7>", &function_83641a8a);
}

function function_83641a8a(dvar) {
  switch (dvar.value) {
    case # "0":
      if(isDefined(level.var_86275d63)) {
        function_2ff69488();
      }

      break;
    case # "1":
      if(!isDefined(level.var_86275d63)) {
        thread function_dcd92707();
      }

      break;
    default:
      return;
  }
}

function function_2ff69488() {
  level notify(#"hash_5061224bb406d9a0");
  wait 0.1;

  foreach(hud_elem in level.var_86275d63) {
    if(isDefined(hud_elem)) {
      hud_elem destroy();
    }
  }

  level.var_86275d63 = undefined;
}

function function_dcd92707() {
  level endon(#"hash_5061224bb406d9a0");
  level flag::wait_till(#"level_intro_complete");
  xoffset = 15;
  yoffset = 175;
  var_981bb6ec = 15;
  level.var_86275d63 = [];
  function_6c8fccf2("<dev string:x104>", xoffset, yoffset + var_981bb6ec);
  function_6c8fccf2("<dev string:x127>", xoffset, yoffset + var_981bb6ec * 2);
  function_6c8fccf2("<dev string:x149>", xoffset, yoffset + var_981bb6ec * 3);
  function_6c8fccf2("<dev string:x16a>", xoffset, yoffset + var_981bb6ec * 4);
  function_6c8fccf2("<dev string:x18c>", xoffset, yoffset + var_981bb6ec * 5);
  function_6c8fccf2("<dev string:x1b1>", xoffset, yoffset + var_981bb6ec * 6);
  function_6c8fccf2("<dev string:x1d2>", xoffset, yoffset + var_981bb6ec * 7);
  function_6c8fccf2("<dev string:x1f8>", xoffset, yoffset + var_981bb6ec * 8);
  function_6c8fccf2("<dev string:x216>", xoffset, yoffset + var_981bb6ec * 9);
  function_6c8fccf2("<dev string:x232>", xoffset, yoffset + var_981bb6ec * 10);
  function_6c8fccf2("<dev string:x254>", xoffset, yoffset + var_981bb6ec * 11);
  function_6c8fccf2("<dev string:x262>", xoffset, yoffset + var_981bb6ec * 12);
  function_6c8fccf2("<dev string:x270>", xoffset, yoffset + var_981bb6ec * 13);
  function_6c8fccf2("<dev string:x27e>", xoffset, yoffset + var_981bb6ec * 14);

  while(true) {
    foreach(var_86275d63 in level.var_86275d63) {
      if(issubstr(tolower(var_86275d63.str), "<dev string:x28c>")) {
        var_86275d63 settext(var_86275d63.str + level.var_731c10af.paths[#"rice_paddies"].count);
        continue;
      }

      if(issubstr(tolower(var_86275d63.str), "<dev string:x294>")) {
        var_86275d63 settext(var_86275d63.str + level.var_731c10af.paths[#"jungle_path"].count);
        continue;
      }

      if(issubstr(tolower(var_86275d63.str), "<dev string:x29e>")) {
        var_86275d63 settext(var_86275d63.str + level.var_731c10af.paths[#"hash_37049c08cb142cc7"].count);
        continue;
      }

      if(issubstr(tolower(var_86275d63.str), "<dev string:x2a7>")) {
        var_86275d63 settext(var_86275d63.str + level.var_731c10af.paths[#"hash_40947083f371555e"].count);
        continue;
      }

      if(issubstr(tolower(var_86275d63.str), "<dev string:x2b1>")) {
        var_86275d63 settext(var_86275d63.str + level.var_731c10af.paths[#"waterfall_path"].count);
        continue;
      }

      if(issubstr(tolower(var_86275d63.str), "<dev string:x2be>")) {
        var_86275d63 settext(var_86275d63.str + level.var_731c10af.paths[#"hash_5a141a81a5112819"].count);
        continue;
      }

      if(issubstr(tolower(var_86275d63.str), "<dev string:x2c7>")) {
        var_86275d63 settext(var_86275d63.str + level.var_731c10af.paths[#"sniper_overlook"].count);
        continue;
      }

      if(issubstr(tolower(var_86275d63.str), "<dev string:x2d1>")) {
        var_86275d63 settext(var_86275d63.str + level.var_731c10af.paths[#"village"].count);
        continue;
      }

      if(issubstr(tolower(var_86275d63.str), "<dev string:x2dc>")) {
        var_86275d63 settext(var_86275d63.str + level.var_731c10af.paths[#"caves"].count);
        continue;
      }

      if(issubstr(tolower(var_86275d63.str), "<dev string:x2e5>")) {
        var_86275d63 settext(var_86275d63.str + level.var_731c10af.paths[#"rat_tunnels"].count);
        continue;
      }

      if(issubstr(tolower(var_86275d63.str), "<dev string:x2ec>")) {
        if(isDefined(level.var_731c10af.path_end_1) && isDefined(level.var_731c10af.var_6930d65d)) {
          var_86275d63 settext(var_86275d63.str + level.var_731c10af.path_end_1 + "<dev string:x2f8>" + level.var_731c10af.var_6930d65d);
        }

        continue;
      }

      if(issubstr(tolower(var_86275d63.str), "<dev string:x2ff>")) {
        if(isDefined(level.var_731c10af.path_end_2) && isDefined(level.var_731c10af.var_319cffdd)) {
          var_86275d63 settext(var_86275d63.str + level.var_731c10af.path_end_2 + "<dev string:x2f8>" + level.var_731c10af.var_319cffdd);
        }

        continue;
      }

      if(issubstr(tolower(var_86275d63.str), "<dev string:x30b>")) {
        if(isDefined(level.var_731c10af.path_end_3) && isDefined(level.var_731c10af.var_f0deb45a)) {
          var_86275d63 settext(var_86275d63.str + level.var_731c10af.path_end_3 + "<dev string:x2f8>" + level.var_731c10af.var_f0deb45a);
        }
      }
    }

    result = level waittilltimeout(5, #"hash_49baa21ba98c2f0", #"visit_restart");
  }
}

function function_6c8fccf2(str, xoffset, yoffset) {
  var_86275d63 = newdebughudelem();
  var_86275d63.alignx = "<dev string:x317>";
  var_86275d63.horzalign = "<dev string:x317>";
  var_86275d63.x = xoffset;
  var_86275d63.y = yoffset;
  var_86275d63.fontscale = 1;
  var_86275d63.color = (1, 1, 1);
  var_86275d63.str = str;

  if(!isDefined(level.var_86275d63)) {
    level.var_86275d63 = [];
  } else if(!isarray(level.var_86275d63)) {
    level.var_86275d63 = array(level.var_86275d63);
  }

  level.var_86275d63[level.var_86275d63.size] = var_86275d63;
}

function function_d20966e6() {
  mapname = util::get_map_name();
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x31f>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x364>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x3a9>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x3ee>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x433>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x478>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x4bb>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x4fe>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x541>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x584>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x5c7>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x608>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x649>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x68a>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x6cb>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x70c>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x74f>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x792>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x7d5>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x818>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x85b>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x8a4>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x8ed>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x936>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x97f>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x9c8>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xa09>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xa4a>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xa8b>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xacc>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xb0d>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xb58>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xba3>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xbee>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xc39>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xc84>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xcbf>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xcfa>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xd35>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xd70>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xdab>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xde2>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xe19>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xe50>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xe87>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xebe>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xf02>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xf46>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xf8a>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xfce>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x1012>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x105a>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x10b3>");

  if(!isDefined(getDvar(#"hash_127da39afb1a835c")) && !isDefined(world.var_7f7d3c51)) {
    setDvar(#"hash_127da39afb1a835c", "<dev string:xe2>");
  } else if(isDefined(world.var_7f7d3c51)) {
    setDvar(#"hash_127da39afb1a835c", "<dev string:x110f>");
    level.var_5d170909 = 1;
  } else {
    level.var_2bcc3c68 = getDvar(#"hash_127da39afb1a835c");
  }

  struct = {
    #name: # "hash_127da39afb1a835c", #value: getDvar(#"hash_127da39afb1a835c")
  };
  function_df5f0267(struct);
  function_cd140ee9("<dev string:x1114>", &function_df5f0267);
  function_ad51e9d4();
  function_cd140ee9("<dev string:x1123>", &function_7826a351);
}

function function_ad51e9d4() {
  if(!isDefined(world.var_94e99af)) {
    world.var_94e99af = [];
    world.var_220b9b08 = [];

    foreach(struct in level.var_731c10af.paths) {
      world.var_94e99af[struct.str] = struct.count;
      world.var_220b9b08[struct.str] = struct.count;
    }
  }

  if(!isDefined(getDvar(#"hash_74ce220f2ffe031d")) || isDefined(getDvar(#"hash_74ce220f2ffe031d")) && getDvar(#"hash_74ce220f2ffe031d") == 0) {
    setDvar(#"hash_74ce220f2ffe031d", "<dev string:xe2>");
    return;
  }

  if(isDefined(getDvar(#"hash_74ce220f2ffe031d")) && getDvar(#"hash_74ce220f2ffe031d") == 2) {
    level.var_5d170909 = 1;
    struct = {
      #name: # "hash_74ce220f2ffe031d", #value: getDvar(#"hash_74ce220f2ffe031d")
    };
    function_7826a351(struct);
  }
}

function function_7826a351(dvar) {
  setDvar(#"hash_74ce220f2ffe031d", "<dev string:x1143>");

  switch (dvar.value) {
    case # "0":
      world.var_7f7d3c51 = undefined;

      if(isDefined(level.var_28c22d88[0])) {
        setDvar(#"skipto_jump", level.var_28c22d88[0]);
      }

      break;
    case # "1":
      world.var_7f7d3c51 = 1;

      foreach(struct in level.var_731c10af.paths) {
        world.var_94e99af[struct.str] = struct.count;
      }

      if(isDefined(level.var_28c22d88[0])) {
        setDvar(#"skipto_jump", level.var_28c22d88[0]);
      }

      break;
    case # "2":
      world.var_7f7d3c51 = 1;

      foreach(struct in level.var_731c10af.paths) {
        world.var_94e99af[struct.str] = struct.count;
      }

      break;
    case # "3":
      break;
    default:
      break;
  }
}

function function_df5f0267(dvar) {
  setDvar(#"hash_127da39afb1a835c", "<dev string:xe2>");

  switch (dvar.value) {
    case # "0":
      break;
    case # "1":
      if(isDefined(world.var_7f7d3c51) && world.var_7f7d3c51 == 1) {
        foreach(struct in level.var_731c10af.paths) {
          function_e106e062(struct.str, world.var_94e99af[struct.str]);
        }
      }

      break;
    default:
      tokens = strtok(dvar.value, "<dev string:x1148>");

      foreach(token in tokens) {
        value = strtok(token, "<dev string:x114d>");

        if(isDefined(value[0]) && isDefined(value) && isDefined(value[1])) {
          foreach(struct in level.var_731c10af.paths) {
            if(value[0] == struct.str) {
              function_e106e062(value[0], int(value[1]));
            }
          }
        }
      }

      break;
  }
}

function function_b08684ac(event) {
  if(isPlayer(event.entity) && event.typeorig === "projectile_impact" && event.entity getcurrentweapon().name === # "hash_165cf52ce418f5a1") {
    return true;
  }

  return false;
}

function function_a45a0347(var_8ad1a02d) {
  var_c9d32439 = getEntArray(var_8ad1a02d, "targetname");

  if(var_c9d32439.size <= 0) {
    return;
  }

  foreach(e_light in var_c9d32439) {
    e_light endon(#"hash_69cb2ef2271e2e99");
    e_light.intensity = e_light getlightintensity();

    if(!isDefined(e_light.original_intensity)) {
      e_light.original_intensity = e_light getlightintensity();
    }

    childthread function_778f9b05(e_light);
  }
}

function function_778f9b05(e_light) {
  while(true) {
    var_30377111 = randomfloatrange(500000, e_light.intensity + 0.1);
    e_light setlightintensity(var_30377111);
    var_889232f6 = randomfloatrange(0.05, 0.25);
    wait var_889232f6;
    e_light setlightintensity(e_light.intensity);
    var_889232f6 = randomfloatrange(0.05, 0.25);
    wait var_889232f6;
  }
}

function function_c318ce4a(var_8ad1a02d) {
  var_c9d32439 = getEntArray(var_8ad1a02d, "targetname");

  if(var_c9d32439.size <= 0) {
    return;
  }

  foreach(e_light in var_c9d32439) {
    if(isDefined(e_light)) {
      e_light notify(#"hash_69cb2ef2271e2e99");

      if(!isDefined(e_light.original_intensity)) {
        e_light.original_intensity = e_light getlightintensity();
      }
    }
  }

  waitframe(1);

  foreach(e_light in var_c9d32439) {
    if(isDefined(e_light)) {
      e_light setlightintensity(0);
    }
  }
}

function function_b96db417(var_8ad1a02d) {
  var_c9d32439 = getEntArray(var_8ad1a02d, "targetname");

  if(var_c9d32439.size <= 0) {
    return;
  }

  foreach(e_light in var_c9d32439) {
    if(isDefined(e_light)) {
      e_light notify(#"hash_61d965f7baa57e7d");

      if(!isDefined(e_light.original_intensity)) {
        e_light.original_intensity = e_light getlightintensity();
      }
    }
  }

  waitframe(1);

  foreach(e_light in var_c9d32439) {
    if(isDefined(e_light)) {
      if(isDefined(e_light.original_intensity)) {
        e_light setlightintensity(e_light.original_intensity);
        continue;
      }

      e_light setlightintensity(1);
    }
  }
}

function function_cf0f5dc6(ent_array, hide) {
  if(isDefined(hide)) {
    foreach(ent in ent_array) {
      if(isDefined(ent)) {
        ent hide();
      }
    }

    return;
  }

  foreach(ent in ent_array) {
    if(isDefined(ent)) {
      ent show();
    }
  }
}

function force_weapon_loadout(area, visit) {
  level.killstreaksenabled = 0;

  if(!isDefined(visit)) {
    visit = 0;
  }

  weapon = undefined;
  weapon2 = undefined;
  grenade = getweapon(#"frag_grenade");
  var_1262a1ad = getweapon(#"gadget_health_regen");
  var_c41ecc2d = getweapon(#"null_offhand_primary");

  switch (area) {
    case # "rice_paddies":
      if(visit == 0) {
        weapon = getweapon(#"hash_32454fc6213eedd6");
      }

      if(visit == 1) {
        weapon = getweapon(#"pistol_semiauto_t9", "suppressed");
        weapon2 = getweapon(#"hash_165cf52ce418f5a1");
      } else if(visit == 2) {
        weapon = getweapon(#"hash_4ff481a4f55ed901");
        weapon2 = getweapon(#"special_grenadelauncher_t9");
      } else if(visit >= 3) {
        weapon = getweapon(#"pistol_semiauto_t9");
        weapon2 = getweapon(#"hash_4ff481a4f55ed901");
      }

      break;
    case # "rice_paddies_4":
    case # "rice_paddies_2":
    case # "rice_paddies_3":
    case # "rice_paddies_1":
    case # "intro":
      weapon = getweapon(#"hash_32454fc6213eedd6");
      break;
    case # "jungle_path":
    case # "middle_paths_1":
    case # "middle_paths_2":
    case # "middle_paths_3":
    case # "jungle_path_3":
    case # "jungle_path_2":
    case # "jungle_path_1":
      if(isDefined(world.mapdata[level.missionid][#"transient"].var_2e7c022f) && !function_9e730655()) {
        savegame::function_7396472d();
        weapons = level.player getweaponslist();

        foreach(weapon in weapons) {
          level.player givemaxammo(weapon);
        }

        return;
      } else {
        weapon = getweapon(#"pistol_semiauto_t9");
        weapon2 = getweapon(#"hash_4ff481a4f55ed901");
      }

      break;
    case # "sniper_overlook":
      weapon = getweapon(#"hash_4ff481a4f55ed901");
      weapon2 = getweapon(#"hash_74399c5b0d6971e1");
      thread function_36b02bca();
      break;
    case # "village":
      weapon = getweapon(#"pistol_semiauto_t9");
      weapon2 = getweapon(#"hash_4ff481a4f55ed901");
      thread function_36b02bca();
      break;
    case # "caves":
      weapon = getweapon(#"hash_165cf52ce418f5a1");
      weapon2 = getweapon(#"shotgun_pump_t9");
      thread function_36b02bca();
      break;
    case # "hash_1758bde589c2e32c":
      weapon = getweapon(#"hash_32454fc6213eedd6");
      var_3054232d = 1;
      break;
    case # "rat_tunnels":
      weapon = getweapon(#"pistol_semiauto_t9");
      thread function_36b02bca();
      var_3054232d = 1;
      break;
    case # "dev_memory_2_disobey":
    case # "dev_memory_3_end":
    case # "dev_infinite_hallway_loop_2":
    case # "hash_38adaaa11a0b5b61":
    case # "hash_38adaba11a0b5d14":
    case # "dev_memory_3_disobey":
    case # "memory_3":
    case # "memory_2":
    case # "memory_1":
    case # "memory_4":
    case # "dev_memory_1_disobey":
    case # "dev_memory_3_disobey_end":
      weapon = getweapon(#"hash_32454fc6213eedd6");
      var_3054232d = 1;
      break;
    default:
      weapon = getweapon(#"pistol_semiauto_t9");
      weapon2 = getweapon(#"hash_4ff481a4f55ed901");
      break;
  }

  current_weapon = level.player getcurrentweapon();

  if(isDefined(current_weapon.name) && current_weapon.name == # "hash_165cf52ce418f5a1") {
    level.player val::set("force_weapon_loadout", "disable_weapons", 1);
    wait 0.5;
  }

  var_fa673a5a = level.player getweaponslist();
  var_6f103a3e = 0;
  var_5d3a1692 = 0;
  var_f8bec9ac = 0;

  if(isDefined(var_fa673a5a) && var_fa673a5a.size > 0) {
    foreach(w_player in var_fa673a5a) {
      var_cea85d10 = 0;
      var_4ec0dd3f = 0;
      var_c410d531 = 0;
      var_1170d6ba = 0;
      b_grenade = 0;

      if(isDefined(weapon) && w_player == weapon) {
        var_6f103a3e = 1;
        var_cea85d10 = 1;
      }

      if(isDefined(weapon2) && w_player == weapon2) {
        var_5d3a1692 = 1;
        var_4ec0dd3f = 1;
      }

      if(isDefined(grenade) && w_player == grenade) {
        var_f8bec9ac = 1;
        b_grenade = 1;
      }

      if(isDefined(var_1262a1ad) && w_player == var_1262a1ad) {
        var_c410d531 = 1;
      }

      if(isDefined(var_c41ecc2d) && w_player == var_c41ecc2d) {
        var_1170d6ba = 1;
      }

      if(!(var_cea85d10 || var_4ec0dd3f || b_grenade || var_c410d531 || var_1170d6ba)) {
        level.player takeweapon(w_player);
      }
    }
  }

  if(!var_6f103a3e) {
    level.player giveweapon(weapon);
  }

  level.player givemaxammo(weapon);

  if(isDefined(grenade)) {
    if(!isDefined(var_3054232d)) {
      if(!var_f8bec9ac) {
        level.player giveweapon(grenade);
      }

      level.player givemaxammo(grenade);
    } else {
      level.player takeweapon(grenade);
    }
  }

  if(isDefined(weapon2)) {
    if(!var_5d3a1692) {
      level.player giveweapon(weapon2);
    }

    level.player switchtoweaponimmediate(weapon2);
    level.player givemaxammo(weapon2);
  } else {
    level.player switchtoweaponimmediate(weapon);
  }

  level.player val::reset("force_weapon_loadout", "disable_weapons");
}

function function_36b02bca() {
  level thread namespace_b6fe1dbe::function_36b02bca();
  level.player pstfx_injection(1);
  wait 0.5;
  level.player pstfx_injection(0);
}

function function_9e730655() {
  if(isDefined(world.mapdata[level.missionid][#"transient"].var_2e7c022f)) {
    if(world.mapdata[level.missionid][#"transient"].var_2e7c022f.size == 1 && array::contains(world.mapdata[level.missionid][#"transient"].var_2e7c022f, #"hash_32454fc6213eedd6")) {
      return 1;
    }

    if(world.mapdata[level.missionid][#"transient"].var_2e7c022f.size == 2 && array::contains(world.mapdata[level.missionid][#"transient"].var_2e7c022f, #"hash_32454fc6213eedd6") && array::contains(world.mapdata[level.missionid][#"transient"].var_2e7c022f, #"frag_grenade")) {
      return 1;
    }

    return 0;
  }
}

function function_f76551eb(var_42ff3045, var_d47e50e, var_97085828) {
  util::function_c76fa9e1(var_42ff3045, var_d47e50e, var_97085828);
}

function function_d683b544(var_fa4801bb, var_c9c9b346, var_84669fca, var_681fad52, var_9b306a26) {
  if(!isalive(self)) {
    return;
  }

  level endon(#"hash_1f837bb9f35957d9");
  self endon(#"death");

  if(!isDefined(var_681fad52)) {
    var_681fad52 = 250000;
  }

  if(!isDefined(var_9b306a26)) {
    var_9b306a26 = 0.86;
  }

  if(!isDefined(var_84669fca)) {
    var_84669fca = 10;
  }

  var_f88f169 = spawnStruct();
  var_f88f169.b_play_vo = 0;
  self function_3c0cf60a(var_f88f169, var_c9c9b346, var_84669fca, var_681fad52, var_9b306a26);

  if(!var_f88f169.b_play_vo) {
    var_f88f169 delete();
    return;
  }

  self[[var_fa4801bb]]();
  var_f88f169 struct::delete();
}

function function_3c0cf60a(var_f88f169, var_c9c9b346, var_84669fca, var_681fad52, var_9b306a26) {
  level endon(#"hash_67372f2f5ba3038a");
  self endon(#"death");

  while(true) {
    if(self function_e4ca0454(var_c9c9b346, var_681fad52, var_9b306a26)) {
      function_17a2c708(var_f88f169, var_c9c9b346, var_84669fca, var_681fad52, var_9b306a26);

      if(var_f88f169.b_play_vo) {
        return;
      }
    }

    waitframe(1);
  }
}

function function_17a2c708(var_f88f169, var_c9c9b346, var_84669fca, var_681fad52, var_9b306a26) {
  self endon(#"death");
  self childthread function_d5e5a282(var_f88f169, var_84669fca);

  while(true) {
    if(!self function_e4ca0454(var_c9c9b346, var_681fad52, var_9b306a26)) {
      level notify(#"hash_365d43e4e1dd2e7d");
      return;
    }

    if(var_f88f169.b_play_vo) {
      return;
    }

    waitframe(1);
  }
}

function function_d5e5a282(var_f88f169, var_84669fca) {
  level endon(#"hash_365d43e4e1dd2e7d");
  wait var_84669fca;
  var_f88f169.b_play_vo = 1;
}

function function_e4ca0454(var_c9c9b346, var_681fad52, var_9b306a26) {
  var_bdfc75d9 = self util::point_in_fov(var_c9c9b346, var_9b306a26, 1);
  var_fde83952 = distance2dsquared(var_c9c9b346, self.origin);

  if(var_bdfc75d9 && var_fde83952 < var_681fad52) {
    return true;
  }

  return false;
}

function function_f6cbf7fd(var_fa4801bb, var_50cd8cb9, var_2ae278fd, str_endon) {
  level endon(#"hash_39f79162a63bad6e");

  if(isDefined(str_endon)) {
    level endon(str_endon);
  }

  if(isDefined(var_50cd8cb9)) {
    wait var_50cd8cb9;
  }

  if(isDefined(var_2ae278fd)) {
    if(!flag::exists("check_input_handle_timeout")) {
      level flag::init("check_input_handle_timeout");
    } else {
      level flag::clear("check_input_handle_timeout");
    }

    level.player function_c4792623(var_2ae278fd);

    if(level flag::get("check_input_handle_timeout") == 0) {
      return;
    }
  }

  self[[var_fa4801bb]]();
}

function function_c4792623(var_2ae278fd) {
  level notify(#"hash_3cec4d4aad210a5d");
  level endon(#"hash_3cec4d4aad210a5d");
  level endon(#"check_input_handle_timeout");

  while(true) {
    if(!self check_input()) {
      function_2c078988(var_2ae278fd);
    }

    waitframe(1);
  }
}

function function_2c078988(var_2ae278fd) {
  self childthread function_7c268746(var_2ae278fd);

  while(true) {
    if(self check_input()) {
      level notify(#"hash_5d773e33d0f71bb6");
      return;
    }

    waitframe(1);
  }
}

function function_7c268746(var_2ae278fd) {
  level endon(#"hash_5d773e33d0f71bb6");
  wait var_2ae278fd;
  level flag::set("check_input_handle_timeout");
}

function check_input() {
  v_norm = self getnormalizedmovement();

  if(v_norm[0] > 0 || v_norm[1] > 0 || v_norm[2] > 0) {
    return true;
  }

  if(self secondaryoffhandbuttonPressed()) {
    return true;
  }

  if(self actionbuttonPressed()) {
    return true;
  }

  if(self stancebuttonPressed()) {
    return true;
  }

  if(self useButtonPressed()) {
    return true;
  }

  if(self weaponswitchbuttonPressed()) {
    return true;
  }

  if(self sprintbuttonPressed()) {
    return true;
  }

  if(self meleeButtonPressed()) {
    return true;
  }

  if(self attackButtonPressed()) {
    return true;
  }

  if(self adsButtonPressed()) {
    return true;
  }

  if(self actionslotonebuttonPressed()) {
    return true;
  }

  if(self actionslottwobuttonPressed()) {
    return true;
  }

  if(self actionslotthreebuttonPressed()) {
    return true;
  }

  if(self actionslotfourbuttonPressed()) {
    return true;
  }

  return false;
}

function vo_death(params) {
  if(!isDefined(level.var_3f5c80c8)) {
    return;
  }

  wait 0.5;
  vo_array = [];
  vo_array[0] = "vox_cp_prsn_14900_adlr_bellyouwerentki_ea";
  vo_array[1] = "vox_cp_prsn_14900_adlr_givebellanother_ae";
  vo_array[2] = "vox_cp_prsn_14900_adlr_bellineedtoknow_9f";
  vo_array[3] = "vox_cp_prsn_14900_adlr_stopfuckingarou_27";
  vo_array[4] = "vox_cp_prsn_14900_adlr_thatdidnthappen_80";
  vo_array[5] = "vox_cp_prsn_14900_adlr_youregettingcon_5d";
  vo_array[6] = "vox_cp_prsn_14900_adlr_thatsnotwhathap_ad";
  vo_array[7] = "vox_cp_prsn_14800_adlr_reallybellyoure_99";
  var_e0179bc6 = randomint(vo_array.size);
  dialogue::radio(vo_array[var_e0179bc6]);
}

function function_48926a5f(var_142cfe56) {
  var_ee8d70e4 = [];

  switch (var_142cfe56) {
    case # "hash_464e4a9fe80d039b":
      var_ee8d70e4[0] = "vox_cp_prsn_15000_adlr_thisbetterfucki_56";
      var_ee8d70e4[1] = util::function_a1a0fe0c("vox_cp_prsn_15000_park_weredefinitelyi_e2", util::function_3ac6fa36("vox_cp_prsn_15000_lazr_doyouthinkhesus_b6", "vox_cp_prsn_15000_lazr_doyouthinkshesu_29", "vox_cp_prsn_15000_lazr_doyouthinktheys_30"), util::function_3ac6fa36("vox_cp_prsn_15000_sims_iwonderifheshav_b8", "vox_cp_prsn_15000_sims_iwonderifshesha_26", "vox_cp_prsn_15000_sims_iwonderiftheyre_0d"));
      var_ee8d70e4[2] = util::function_3ac6fa36("vox_cp_prsn_15000_adlr_forhissakeisure_2e", "vox_cp_prsn_15000_adlr_fortheirsakeisu_06", "vox_cp_prsn_15000_adlr_fortheirsakeisu_06");
      break;
    case # "hash_464e4b9fe80d054e":
      var_ee8d70e4[0] = util::function_3ac6fa36("vox_cp_prsn_15100_adlr_howmanyinjectio_de", "vox_cp_prsn_15100_adlr_howmanyinjectio_d9", "vox_cp_prsn_15100_adlr_howmanyinjectio_b6");
      var_ee8d70e4[1] = util::function_a1a0fe0c("vox_cp_prsn_15100_park_theprimatetrial_d3", "vox_cp_prsn_15100_lazr_hereaccordingto_fe", "vox_cp_prsn_15100_sims_idontknowiguess_42");
      var_ee8d70e4[2] = "vox_cp_prsn_15100_adlr_wehavetogetbell_5a";
      break;
    case # "hash_464e4c9fe80d0701":
      var_ee8d70e4[0] = "vox_cp_prsn_15200_sims_ibroughtyouacof_40";
      var_ee8d70e4[1] = util::function_a1a0fe0c("vox_cp_prsn_15200_park_thankyou_a1", "vox_cp_prsn_15200_lazr_thanks_97", "vox_cp_prsn_15200_adlr_thanks_97");
      var_ee8d70e4[2] = util::function_a1a0fe0c("vox_cp_prsn_15200_park_bellsstablestro_95", "vox_cp_prsn_15200_lazr_bellstoughquite_22", "vox_cp_prsn_15200_adlr_bellsholdingupw_06");
      break;
    case # "hash_464e4d9fe80d08b4":
      var_ee8d70e4[0] = util::function_a1a0fe0c("vox_cp_prsn_15300_adlr_parkyouseethat_a4", "vox_cp_prsn_15300_adlr_lazaryouseethat_10", "vox_cp_prsn_15300_adlr_simsyouseethat_b2");
      var_ee8d70e4[1] = util::function_a1a0fe0c("vox_cp_prsn_15300_park_what_d3", "vox_cp_prsn_15300_lazr_what_d3", "vox_cp_prsn_15300_sims_what_d3");
      var_ee8d70e4[2] = "vox_cp_prsn_15300_adlr_bellseyeskeepop_88";
      var_ee8d70e4[3] = util::function_3ac6fa36("vox_cp_prsn_15300_adlr_bellseyeskeepop_88", "vox_cp_prsn_15300_adlr_idontthinksheca_f1", "vox_cp_prsn_15300_adlr_idontthinktheyc_6b");
      break;
  }

  function_6257f572(var_142cfe56, var_ee8d70e4);
}

function function_6257f572(var_142cfe56, var_ee8d70e4) {
  var_66067e2b = struct::get(var_142cfe56, "targetname");
  var_321897b4 = spawn("script_origin", var_66067e2b.origin);
  e_trigger = spawn("trigger_radius", var_66067e2b.origin, 0, 256, 256);
  util::waittill_any_ents(e_trigger, "trigger", level, "flag_in_end_path");

  if(!level flag::get("flag_in_end_path")) {
    if(!isDefined(level.var_71cc355e)) {
      level.var_71cc355e = [];
    }

    if(!isDefined(level.var_71cc355e)) {
      level.var_71cc355e = [];
    } else if(!isarray(level.var_71cc355e)) {
      level.var_71cc355e = array(level.var_71cc355e);
    }

    level.var_71cc355e[level.var_71cc355e.size] = var_142cfe56;

    foreach(var_ad21edf7 in var_ee8d70e4) {
      var_321897b4 playsoundwithnotify(var_ad21edf7, "sounddone");
      util::waittill_any_ents(var_321897b4, "sounddone", level, "flag_in_end_path");
      wait 0.25;
    }
  }

  if(isDefined(var_321897b4)) {
    var_321897b4 delete();
  }
}

function function_1e281213(var_82da1fa, var_d7eceb3f, var_3adcb96b, var_920349e, var_541da9d7, var_5d1e73d5) {
  if(isDefined(var_3adcb96b)) {
    level flag::wait_till(var_3adcb96b);
  }

  if(isDefined(var_5d1e73d5)) {
    level flag::set(var_5d1e73d5);
    waitframe(1);
  }

  thread function_6bbc2f6f(var_82da1fa, var_d7eceb3f, var_3adcb96b, var_920349e);
  level flag::wait_till(var_541da9d7);
  level notify(#"hash_eca3a855e732f7f");
}

function function_6bbc2f6f(var_d9ea8d27, var_d7eceb3f, str_flagname, rob) {
  if(isDefined(str_flagname)) {
    level flag::wait_till(str_flagname);
  }

  var_1da2a9b2 = getEntArray(var_d9ea8d27, "targetname");

  foreach(var_63151ff2 in var_1da2a9b2) {
    var_63151ff2 clientfield::set(rob, var_d7eceb3f);
    thread function_cf08dc6f(var_63151ff2, var_d7eceb3f, rob);
  }
}

function function_cf08dc6f(var_63151ff2, var_d7eceb3f, rob) {
  level waittill(#"hash_eca3a855e732f7f");
  var_63151ff2 clientfield::set(rob, var_d7eceb3f + 1);
}

function function_58c94625(str_targetname, var_a2ffefce) {
  level endon(#"flag_in_end_path");
  wait 1;
  script_models = getEntArray(str_targetname, "targetname");
  level flag::clear("flag_jungle_path_ROBs_off");
  level flag::clear("flag_jungle_path_ROBs_on");

  while(true) {
    level flag::wait_till("flag_jungle_path_ROBs_off");
    level flag::clear(var_a2ffefce);
    waitframe(1);
    level flag::wait_till("flag_jungle_path_ROBs_on");
    level flag::set(var_a2ffefce);
    waitframe(1);
  }
}

function pstfx_injection(state = 0) {
  level.player clientfield::set_to_player("pstfx_injection", state);
}

function function_7428d519() {
  self disableaimassist();
  self setteam(#"none");
  self.propername = # "hash_7f6eed032db2f3ba";
}

function function_be6f6790(var_7bd31922, flag) {
  scene_structs = struct::get_array(var_7bd31922, "script_noteworthy");

  foreach(struct in scene_structs) {
    wait randomfloatrange(0.5, 1);
    level thread scene::play(struct.targetname, "init");
  }

  damage_trigger = getent(var_7bd31922 + "_damage_trigger", "targetname");

  if(isDefined(flag)) {
    util::waittill_any_ents(level, flag, level, "flag_in_end_path", damage_trigger, "trigger");
  } else {
    util::waittill_any_ents(level, "flag_in_end_path", damage_trigger, "trigger");
  }

  foreach(struct in scene_structs) {
    level thread function_8d61c862(struct);
  }
}

function function_8d61c862(struct) {
  if(!level flag::get("flag_in_end_path")) {
    level scene::play(struct.targetname, "Shot 1");
  }

  level scene::stop(struct.targetname, 1);
}

function function_f8c7740b(flag, var_4ddb3cd5, var_1650361d, delay) {
  level flag::wait_till(flag);

  if(isDefined(delay)) {
    wait delay;
  }

  if(isDefined(var_1650361d)) {
    if(var_1650361d == 1) {
      level.player districts::function_a7d79fcb(var_4ddb3cd5);
      return;
    }

    if(var_1650361d == 0) {
      level.player districts::function_930f8c81(var_4ddb3cd5);
    }
  }
}

function function_34961864(ai) {
  if(isalive(ai) && math::cointoss()) {
    ai.animname = "generic";

    if(math::cointoss()) {
      if(math::cointoss()) {
        ai animation::play("t9_pri_celebrating_cheer_01_soldier1");
      } else {
        ai animation::play("t9_pri_soldier_celebrate_01");
      }
    } else if(math::cointoss()) {
      ai animation::play("t9_pri_soldier_celebrate_02");
    } else {
      ai animation::play("t9_pri_soldier_celebrate_03");
    }

    return;
  }

  if(isalive(ai)) {
    e_origin = spawn("script_model", ai.origin);
    e_origin.angles = ai.angles;
    ai.animname = "generic";
    ai animation::play("t9_pri_soldier_celebrate_04_enter", e_origin);

    if(isalive(ai)) {
      ai thread animation::play("t9_pri_soldier_celebrate_04_loop", e_origin);
    }

    wait randomfloatrange(1, 3);

    if(isalive(ai)) {
      ai animation::play("t9_pri_soldier_celebrate_04_end", e_origin);
    }

    e_origin delete();
  }
}

function function_c9fa31e() {
  self waittill(#"death", #"set_alert_level");

  if(isDefined(self)) {
    self dialogue::function_47b06180();
  }
}

function function_7ad4f5cb() {
  level flag::wait_till("all_players_connected");
  a_s_interacts = struct::get_array(#"hash_3dd86258529972ca");
  array::thread_all(a_s_interacts, &function_f78628e6);
}

function private function_f78628e6() {
  level.player endon(#"death", #"hash_2b62b2990144ebf6");
  level endon(#"memory_3_completed");

  if(level flag::get("memory_3_completed")) {
    return;
  }

  e_interact = util::spawn_model(#"tag_origin", self.origin, self.angles);
  e_interact thread function_96d56c7d("memory_3_completed");

  while(true) {
    gameRef = self.script_noteworthy;
    var_ae865aeb = getscriptbundle(gameRef);
    var_3b88de0c = # "hash_6ffbe136c9ac4c4e";

    if(isDefined(var_ae865aeb) && isDefined(var_ae865aeb.var_303ce84a)) {
      var_3b88de0c = var_ae865aeb.var_303ce84a;
    }

    e_interact util::create_cursor_hint("tag_origin", (0, 0, 0), var_3b88de0c, 40, undefined, undefined, undefined, 150);
    e_interact thread arcade_machine::function_bafc791c();
    e_interact waittill(#"trigger");
    e_interact util::delay(0.2, undefined, &util::remove_cursor_hint);
    wait 0.5;
    thread namespace_b6fe1dbe::arcade_start();
    self arcade_machine::play();
    self arcade_machine::function_71510186();
    thread namespace_b6fe1dbe::arcade_exit();
    self arcade_machine::exit();
  }

  e_interact util::remove_cursor_hint();
  e_interact delete();
}

function function_96d56c7d(str_flag) {
  level flag::wait_till(str_flag);

  if(isDefined(self)) {
    self util::remove_cursor_hint();
    self delete();
  }
}

function function_b0ea272(body_model, head_model, var_fa254989) {
  if(isDefined(head_model) || isDefined(var_fa254989)) {
    if(isDefined(self.hatmodel)) {
      self detach(self.hatmodel);
    }

    if(isDefined(self.head)) {
      self detach(self.head);
    }

    if(isDefined(head_model)) {
      self attach(head_model);
      self.head = head_model;
    }
  }

  if(isDefined(body_model)) {
    self setModel(body_model);
  }
}

function function_e361b981(weapon_name) {
  if(isDefined(self.weapon.name) && self.weapon.name != weapon_name) {
    weapon = getweapon(weapon_name);
    self aiutility::setcurrentweapon(weapon);
    self aiutility::setprimaryweapon(weapon);
    self ai::gun_switchto(weapon, "right");
  }
}

function function_dac4d056() {
  var_a72f81d9 = ["flag_jungle_path", "flag_in_end_path", "flag_in_memory"];
  level thread function_27efd762(1, var_a72f81d9, ["visit_restart"]);
}

function function_27efd762(var_fb96a72d, var_a72f81d9, var_6edc7af2) {
  level flag::wait_till_any(var_a72f81d9);
  level thread function_f9acbd1e(var_fb96a72d, 1);
  level flag::wait_till_any(var_6edc7af2);
  level thread function_f9acbd1e(var_fb96a72d);
}

function function_f9acbd1e(var_fb96a72d, hide) {
  if(isDefined(hide) && is_true(hide)) {
    level clientfield::set("toggle_occluder", var_fb96a72d);
    return;
  }

  if(!isDefined(hide)) {
    level clientfield::set("toggle_occluder", var_fb96a72d + 1);
  }
}