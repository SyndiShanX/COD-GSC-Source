/********************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_town\cp_town_crab_boss_sonic_ring.gsc
********************************************************************/

do_sonic_ring() {
  enable_linkto_on_all_triggers();
  level thread crab_boss_sonic_ring_logic();
  var_0 = level scripts\engine\utility::waittill_any_return("sonic_ring_fail", "sonic_ring_success");
  terminate_sonic_ring();
  scripts\cp\maps\cp_town\cp_town_crab_boss_fight::remove_icon_on_escort_vehicle();
  if(var_0 == "sonic_ring_fail") {
    scripts\cp\maps\cp_town\cp_town_crab_boss_fight::replay_final_sequence();
    return;
  }

  level thread scripts\cp\maps\cp_town\cp_town_crab_boss_bomb::start_detonate_bomb();
}

crab_boss_sonic_ring_logic() {
  level.crab_boss prepare_for_sonic_ring_attack(level.crab_boss);
  level.crab_boss scripts\aitypes\crab_boss\behaviors::startroarattack(1);
  level.crab_boss waittill("roar_done");
  level.crab_boss scripts\cp\maps\cp_town\cp_town_crab_boss_death_wall::do_taunt();
}

enable_linkto_on_all_triggers() {
  if(scripts\engine\utility::istrue(level.sonic_beam_trigger_enable_link_to)) {
    return;
  }

  var_0 = scripts\engine\utility::getstructarray("sonic_ring_controlling_struct", "targetname");
  foreach(var_2 in var_0) {
    var_3 = getent(var_2.target, "targetname");
    var_3 enablelinkto();
  }

  level.sonic_beam_trigger_enable_link_to = 1;
}

prepare_for_sonic_ring_attack(var_0) {
  var_1 = scripts\engine\utility::getstructarray("sonic_ring_controlling_struct", "targetname");
  var_2 = scripts\engine\utility::random(var_1);
  var_3 = spawn("script_model", var_2.origin);
  var_3 setModel("tag_origin");
  var_3.angles = var_2.angles;
  var_0.sonic_ring_controlling_struct = var_2;
  var_0.sonic_ring_controlling_ent = var_3;
  var_0 thread activate_vfx_ent(var_2, var_3);
}

activate_sonic_ring(var_0) {
  scripts\cp\cp_vo::try_to_play_vo_on_all_players("boss_phase_5_attack_sonic_ring");
  level thread start_sonic_ring_timer();
  level thread sonic_ring_wail_all_player_trigger_teleporter("sonic_ring_fail", "sonic_ring_success");
  func_15F1(var_0.sonic_ring_controlling_struct, var_0.sonic_ring_controlling_ent);
  activate_controlling_ent(var_0.sonic_ring_controlling_ent, var_0);
}

sonic_ring_wail_all_player_trigger_teleporter(var_0, var_1) {
  if(isDefined(var_0)) {
    level endon(var_0);
  }

  if(!scripts\engine\utility::istrue(level.escort_vehicle.teleporter_activated)) {
    return;
  }

  var_2 = 160000;
  for(;;) {
    var_3 = 1;
    foreach(var_5 in level.players) {
      if(scripts\engine\utility::istrue(var_5.inlaststand)) {
        var_3 = 0;
        break;
      }

      if(scripts\engine\utility::istrue(var_5.iscarrying)) {
        var_3 = 0;
        break;
      }

      if(distancesquared(var_5.origin, level.escort_vehicle.origin) > var_2) {
        var_3 = 0;
        break;
      }

      if(!var_5 usebuttonpressed()) {
        var_3 = 0;
        break;
      }
    }

    wait(0.25);
    if(var_3) {
      var_3 = 1;
      foreach(var_5 in level.players) {
        if(scripts\engine\utility::istrue(var_5.inlaststand)) {
          var_3 = 0;
          break;
        }

        if(scripts\engine\utility::istrue(var_5.iscarrying)) {
          var_3 = 0;
          break;
        }

        if(distancesquared(var_5.origin, level.escort_vehicle.origin) > var_2) {
          var_3 = 0;
          break;
        }

        if(!var_5 usebuttonpressed()) {
          var_3 = 0;
          break;
        }
      }
    }

    if(var_3) {
      if(isDefined(var_1)) {
        level notify(var_1);
      }

      return;
    }

    scripts\engine\utility::waitframe();
  }
}

start_sonic_ring_timer() {
  level endon("sonic_ring_success");
  level notify("sonic_ring_start");
  wait(7);
  for(var_0 = 5; var_0 > 0; var_0--) {
    if(scripts\engine\utility::istrue(level.escort_vehicle.teleporter_activated)) {
      iprintln(var_0);
    }

    wait(1);
  }

  level notify("sonic_ring_fail");
}

terminate_sonic_ring() {
  level notify("stop_sonic_ring");
}

func_15F1(var_0, var_1) {
  var_2 = getent(var_0.target, "targetname");
  var_2.original_pos = var_2.origin;
  var_1.sonic_ring_trigger = var_2;
  var_2 linkto(var_1);
  var_2 thread player_touch_monitor(var_2);
}

activate_vfx_ent(var_0, var_1) {
  var_2 = [];
  var_3 = scripts\engine\utility::getstructarray(var_0.target, "targetname");
  foreach(var_5 in var_3) {
    var_6 = spawn("script_model", var_5.origin);
    var_6 setModel("crab_boss_origin");
    var_6.activation_order = int(var_5.script_noteworthy);
    var_6 linkto(var_1);
    var_2[var_2.size] = var_6;
    scripts\engine\utility::waitframe();
  }

  var_1.vfx_ent_list = var_2;
}

player_touch_monitor(var_0) {
  var_0 endon("stop_sonic_ring_trigger_monitor");
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(isPlayer(var_1)) {
      var_1 dodamage(40, var_1.origin);
    }
  }
}

activate_controlling_ent(var_0, var_1) {
  var_2 = scripts\engine\utility::getstruct("sonic_ring_start", "targetname");
  var_3 = var_2.origin;
  var_0 dontinterpolate();
  var_0.origin = var_3;
  sonic_ring_activation_vfx_sequence(var_1, var_0);
  level waittill("stop_sonic_ring");
  clean_up_controlling_ent(var_0);
}

clean_up_controlling_ent(var_0) {
  var_0.sonic_ring_trigger notify("stop_sonic_ring_trigger_monitor");
  var_0.sonic_ring_trigger unlink();
  var_0.sonic_ring_trigger dontinterpolate();
  var_0.sonic_ring_trigger.origin = var_0.sonic_ring_trigger.original_pos;
  foreach(var_2 in var_0.vfx_ent_list) {
    var_2 delete();
  }

  level notify("cleanup_beam_sfx");
  var_0 delete();
}

load_sonic_ring_vfx() {
  level._effect["sonic_beam_ricochet_laser"] = loadfx("vfx\iw7\levels\cp_town\crog\vfx_lure_laser_sonic_beam.vfx");
}

sonic_ring_cleanup() {}

sonic_ring_activation_vfx_sequence(var_0, var_1) {
  level thread sonic_ring_beam_sfx();
  var_2 = var_0 gettagorigin("tag_laser");
  var_3 = [(3025, 956, 1), (2545, 1132, -71), (3123, 1468, -80), (2386, 1652, -48), (3916, 2068, -26), (2334, 2128, -12), (3885, 2188, -4), (2280, 2244, 6), (3926, 2296, 20), (2445, 2360, -94), (3675, 2628, -167), (2641, 2676, -168), (3689, 2724, -169)];
  var_4 = [(2436, 956, 1), (2988, 1132, -71), (2659, 1468, -80), (3360, 1652, -48), (2312, 2068, -26), (3913, 2128, -12), (2278, 2188, -4), (3893, 2244, 6), (2147, 2296, 19), (3688, 2360, -94), (2626, 2628, -167), (3658, 2676, -168), (2560, 2724, -169)];
  level thread activate_vfx_along_path(var_2, var_3);
  level thread activate_vfx_along_path(var_2, var_4);
  level thread activate_vfx_on_beam(var_1);
}

sonic_ring_beam_sfx() {
  level endon("death");
  level.sonic_beam_sfx_5 = thread scripts\engine\utility::play_loopsound_in_space("boss_crog_lasers_lp", (2764, 2668, -171));
  level.sonic_beam_sfx_6 = thread scripts\engine\utility::play_loopsound_in_space("boss_crog_lasers_lp", (3138, 2686, -171));
  wait(0.25);
  level.sonic_beam_sfx_3 = thread scripts\engine\utility::play_loopsound_in_space("boss_crog_lasers_lp", (2687, 2198, -52));
  level.sonic_beam_sfx_4 = thread scripts\engine\utility::play_loopsound_in_space("boss_crog_lasers_lp", (3368, 1974, -51));
  wait(0.25);
  level.sonic_beam_sfx_2 = thread scripts\engine\utility::play_loopsound_in_space("boss_crog_lasers_lp", (2839, 1444, -50));
  wait(0.25);
  level.sonic_beam_sfx_1 = thread scripts\engine\utility::play_loopsound_in_space("boss_crog_lasers_lp", (2744, 1043, 17));
  level waittill("cleanup_beam_sfx");
  level.sonic_beam_sfx_1 stoploopsound();
  level.sonic_beam_sfx_2 stoploopsound();
  level.sonic_beam_sfx_3 stoploopsound();
  level.sonic_beam_sfx_4 stoploopsound();
  level.sonic_beam_sfx_5 stoploopsound();
  level.sonic_beam_sfx_6 stoploopsound();
  wait(0.2);
  level.sonic_beam_sfx_1 delete();
  level.sonic_beam_sfx_2 delete();
  level.sonic_beam_sfx_3 delete();
  level.sonic_beam_sfx_4 delete();
  level.sonic_beam_sfx_5 delete();
  level.sonic_beam_sfx_6 delete();
}

activate_vfx_along_path(var_0, var_1) {
  var_1 = scripts\engine\utility::array_combine([var_0], var_1);
  for(var_2 = 0; var_2 <= var_1.size - 2; var_2++) {
    var_0 = var_1[var_2];
    var_3 = var_1[var_2 + 1];
    playfxbetweenpoints(level._effect["sonic_beam_ricochet_laser"], var_0, vectortoangles(var_3 - var_0), var_3);
    wait(0.4);
  }
}

activate_vfx_on_beam(var_0) {
  for(var_1 = 1; var_1 <= 13; var_1++) {
    var_2 = get_vfx_ents_with_order_number(var_1, var_0);
    foreach(var_4 in var_2) {
      var_4 setscriptablepartstate("sonic_ring_laser", "on");
    }

    wait(0.4);
  }
}

get_vfx_ents_with_order_number(var_0, var_1) {
  var_2 = [];
  foreach(var_4 in var_1.vfx_ent_list) {
    if(var_4.activation_order == var_0) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}