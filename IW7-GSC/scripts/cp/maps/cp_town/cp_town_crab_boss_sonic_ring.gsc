/********************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_town\cp_town_crab_boss_sonic_ring.gsc
********************************************************************/

do_sonic_ring() {
  enable_linkto_on_all_triggers();
  level thread crab_boss_sonic_ring_logic();
  var_00 = level scripts\engine\utility::waittill_any_return("sonic_ring_fail", "sonic_ring_success");
  terminate_sonic_ring();
  scripts\cp\maps\cp_town\cp_town_crab_boss_fight::remove_icon_on_escort_vehicle();
  if(var_00 == "sonic_ring_fail") {
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

  var_00 = scripts\engine\utility::getstructarray("sonic_ring_controlling_struct", "targetname");
  foreach(var_02 in var_00) {
    var_03 = getent(var_02.target, "targetname");
    var_03 enablelinkto();
  }

  level.sonic_beam_trigger_enable_link_to = 1;
}

prepare_for_sonic_ring_attack(param_00) {
  var_01 = scripts\engine\utility::getstructarray("sonic_ring_controlling_struct", "targetname");
  var_02 = scripts\engine\utility::random(var_01);
  var_03 = spawn("script_model", var_02.origin);
  var_03 setModel("tag_origin");
  var_03.angles = var_02.angles;
  param_00.sonic_ring_controlling_struct = var_02;
  param_00.sonic_ring_controlling_ent = var_03;
  param_00 thread activate_vfx_ent(var_02, var_03);
}

activate_sonic_ring(param_00) {
  scripts\cp\cp_vo::try_to_play_vo_on_all_players("boss_phase_5_attack_sonic_ring");
  level thread start_sonic_ring_timer();
  level thread sonic_ring_wail_all_player_trigger_teleporter("sonic_ring_fail", "sonic_ring_success");
  func_15F1(param_00.sonic_ring_controlling_struct, param_00.sonic_ring_controlling_ent);
  activate_controlling_ent(param_00.sonic_ring_controlling_ent, param_00);
}

sonic_ring_wail_all_player_trigger_teleporter(param_00, param_01) {
  if(isDefined(param_00)) {
    level endon(param_00);
  }

  if(!scripts\engine\utility::istrue(level.escort_vehicle.teleporter_activated)) {
    return;
  }

  var_02 = 160000;
  for(;;) {
    var_03 = 1;
    foreach(var_05 in level.players) {
      if(scripts\engine\utility::istrue(var_05.inlaststand)) {
        var_03 = 0;
        break;
      }

      if(scripts\engine\utility::istrue(var_05.iscarrying)) {
        var_03 = 0;
        break;
      }

      if(distancesquared(var_05.origin, level.escort_vehicle.origin) > var_02) {
        var_03 = 0;
        break;
      }

      if(!var_05 usebuttonpressed()) {
        var_03 = 0;
        break;
      }
    }

    wait(0.25);
    if(var_03) {
      var_03 = 1;
      foreach(var_05 in level.players) {
        if(scripts\engine\utility::istrue(var_05.inlaststand)) {
          var_03 = 0;
          break;
        }

        if(scripts\engine\utility::istrue(var_05.iscarrying)) {
          var_03 = 0;
          break;
        }

        if(distancesquared(var_05.origin, level.escort_vehicle.origin) > var_02) {
          var_03 = 0;
          break;
        }

        if(!var_05 usebuttonpressed()) {
          var_03 = 0;
          break;
        }
      }
    }

    if(var_03) {
      if(isDefined(param_01)) {
        level notify(param_01);
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
  for(var_00 = 5; var_00 > 0; var_00--) {
    if(scripts\engine\utility::istrue(level.escort_vehicle.teleporter_activated)) {
      iprintln(var_00);
    }

    wait(1);
  }

  level notify("sonic_ring_fail");
}

terminate_sonic_ring() {
  level notify("stop_sonic_ring");
}

func_15F1(param_00, param_01) {
  var_02 = getent(param_00.target, "targetname");
  var_02.original_pos = var_02.origin;
  param_01.sonic_ring_trigger = var_02;
  var_02 linkto(param_01);
  var_02 thread player_touch_monitor(var_02);
}

activate_vfx_ent(param_00, param_01) {
  var_02 = [];
  var_03 = scripts\engine\utility::getstructarray(param_00.target, "targetname");
  foreach(var_05 in var_03) {
    var_06 = spawn("script_model", var_05.origin);
    var_06 setModel("crab_boss_origin");
    var_06.activation_order = int(var_05.script_noteworthy);
    var_06 linkto(param_01);
    var_02[var_02.size] = var_06;
    scripts\engine\utility::waitframe();
  }

  param_01.vfx_ent_list = var_02;
}

player_touch_monitor(param_00) {
  param_00 endon("stop_sonic_ring_trigger_monitor");
  for(;;) {
    param_00 waittill("trigger", var_01);
    if(isplayer(var_01)) {
      var_01 dodamage(40, var_01.origin);
    }
  }
}

activate_controlling_ent(param_00, param_01) {
  var_02 = scripts\engine\utility::getstruct("sonic_ring_start", "targetname");
  var_03 = var_02.origin;
  param_00 dontinterpolate();
  param_00.origin = var_03;
  sonic_ring_activation_vfx_sequence(param_01, param_00);
  level waittill("stop_sonic_ring");
  clean_up_controlling_ent(param_00);
}

clean_up_controlling_ent(param_00) {
  param_00.sonic_ring_trigger notify("stop_sonic_ring_trigger_monitor");
  param_00.sonic_ring_trigger unlink();
  param_00.sonic_ring_trigger dontinterpolate();
  param_00.sonic_ring_trigger.origin = param_00.sonic_ring_trigger.original_pos;
  foreach(var_02 in param_00.vfx_ent_list) {
    var_02 delete();
  }

  level notify("cleanup_beam_sfx");
  param_00 delete();
}

load_sonic_ring_vfx() {
  level._effect["sonic_beam_ricochet_laser"] = loadfx("vfx\iw7\levels\cp_town\crog\vfx_lure_laser_sonic_beam.vfx");
}

sonic_ring_cleanup() {}

sonic_ring_activation_vfx_sequence(param_00, param_01) {
  level thread sonic_ring_beam_sfx();
  var_02 = param_00 gettagorigin("tag_laser");
  var_03 = [(3025, 956, 1), (2545, 1132, -71), (3123, 1468, -80), (2386, 1652, -48), (3916, 2068, -26), (2334, 2128, -12), (3885, 2188, -4), (2280, 2244, 6), (3926, 2296, 20), (2445, 2360, -94), (3675, 2628, -167), (2641, 2676, -168), (3689, 2724, -169)];
  var_04 = [(2436, 956, 1), (2988, 1132, -71), (2659, 1468, -80), (3360, 1652, -48), (2312, 2068, -26), (3913, 2128, -12), (2278, 2188, -4), (3893, 2244, 6), (2147, 2296, 19), (3688, 2360, -94), (2626, 2628, -167), (3658, 2676, -168), (2560, 2724, -169)];
  level thread activate_vfx_along_path(var_02, var_03);
  level thread activate_vfx_along_path(var_02, var_04);
  level thread activate_vfx_on_beam(param_01);
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

activate_vfx_along_path(param_00, param_01) {
  param_01 = scripts\engine\utility::array_combine([param_00], param_01);
  for(var_02 = 0; var_02 <= param_01.size - 2; var_02++) {
    param_00 = param_01[var_02];
    var_03 = param_01[var_02 + 1];
    playfxbetweenpoints(level._effect["sonic_beam_ricochet_laser"], param_00, vectortoangles(var_03 - param_00), var_03);
    wait(0.4);
  }
}

activate_vfx_on_beam(param_00) {
  for(var_01 = 1; var_01 <= 13; var_01++) {
    var_02 = get_vfx_ents_with_order_number(var_01, param_00);
    foreach(var_04 in var_02) {
      var_04 setscriptablepartstate("sonic_ring_laser", "on");
    }

    wait(0.4);
  }
}

get_vfx_ents_with_order_number(param_00, param_01) {
  var_02 = [];
  foreach(var_04 in param_01.vfx_ent_list) {
    if(var_04.activation_order == param_00) {
      var_02[var_02.size] = var_04;
    }
  }

  return var_02;
}