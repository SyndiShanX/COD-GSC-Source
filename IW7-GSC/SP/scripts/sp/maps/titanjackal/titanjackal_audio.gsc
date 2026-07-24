/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\titanjackal\titanjackal_audio.gsc
*************************************************************/

main() {
  thread _id_25AC();
  thread _id_1198B();
  thread init_lighting_dvars();
}

_id_25AC() {
  scripts\engine\utility::flag_init("stop_turbine_emitter");
  wait 4;
  soundsettimescalefactor("music_lr", 0);
  soundsettimescalefactor("music_lsrs", 0);
  soundsettimescalefactor("weap_plr_fire_1_2d", 0.7);
  soundsettimescalefactor("weap_plr_fire_2_2d", 0.0);
  soundsettimescalefactor("weap_plr_fire_3_2d", 0.3);
  soundsettimescalefactor("weap_plr_fire_4_2d", 0.0);
  soundsettimescalefactor("weap_plr_fire_overlap_2d", 0.7);
  soundsettimescalefactor("scn_fx_unres_2d", 0.0);
  soundsettimescalefactor("scn_fx_res_3d", 0);
  soundsettimescalefactor("scn_fx_unres_3d", 0);
}

init_lighting_dvars() {
  thread _id_ACE2("emt_titanjackal_waterfall_lrg_dist_lp", (40401, 67113, -66242), (31916, 70068, -66242));
  thread _id_ACE2("emt_titanjackal_waterfall_lrg_dist_lp", (31201, 70601, -66242), (30212, 79184, -66245));
  thread _id_ACE2("emt_titanjackal_waterfall_lrg_dist_lp", (30611, 80226, -66245), (37538, 83742, -66247));
  thread _id_ACE2("emt_titanjackal_waterfall_lrg_dist_lp", (38385, 83972, -66248), (45337, 79477, -66250));
  thread _id_ACE2("emt_titanjackal_waterfall_lrg_dist_lp", (45884, 78462, -66251), (44931, 70764, -66253));
  thread _id_ACE2("emt_titanjackal_waterfall_lrg_dist_lp", (44631, 70191, -66254), (40000, 67518, -66254));
  thread _id_ACE2("emt_titanjackal_waterfall_lrg_center_dist_lp", (41465, 74569, -67992), (35341, 72185, -67991));
  thread _id_ACE2("emt_titanjackal_waterfall_lrg_center_dist_lp", (34651, 73600, -67992), (37119, 79462, -67991));
  thread _id_ACE2("emt_titanjackal_waterfall_lrg_center_dist_lp", (38786, 79623, -67995), (42072, 75625, -67991));
  thread _id_ACE2("emt_titan_methane_turbine", (38355, 77280, -64683), (38355, 77280, -70000), "stop_turbine_emitter", 1.0);
  thread _id_ACE2("emt_room_shake_lp_lr", (40455, 75831, -64567), (40460, 75831, -64567), "stop_turbine_emitter", 1.0);
}

_id_1198B() {
  wait 2;

  for(;;) {
    if(scripts\engine\utility::player_is_in_jackal()) {
      level.player _meth_82C0("jackal_cockpit", 2);
      level waittill("jackal_landing");
      level.player playSound("jackal_landing_plr");
      level._id_D127 waittill("jackal_touchdown");
      level.player playSound("jackal_landed");
      level.player clearclienttriggeraudiozone(2.0);
      wait 2;
    } else
      level waittill("jackal_enter");

    wait 0.1;
  }
}

_id_BAF1() {
  var_0 = spawn("script_origin", (-26669, -36593, -64380));
  var_0 _meth_8278(0.5);
  wait 0.05;
  var_0 playSound("scn_monsintro_thruster_debris");
  var_0 _meth_8278(1, 2);
  var_0 moveTo(level.player.origin, 3);
  scripts\engine\utility::flag_wait("mons_intro_wave_hit_player");
  level.player playSound("scn_monsintro_knockdown");
  var_0 scripts\sp\utility::_id_10460(2);
}

_id_ACE2(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_origin", (0, 0, 0));
  var_6 = 0;
  wait 0.05;

  for(;;) {
    if(isDefined(var_3) && scripts\engine\utility::flag(var_3)) {
      break;
    }

    var_7 = pointonsegmentnearesttopoint(var_1, var_2, level.player.origin);
    var_5 moveTo(var_7, 0.05);

    if(var_6 == 0) {
      var_5 playLoopSound(var_0);
      var_6 = 1;
    }

    wait 0.1;
  }

  var_5 _meth_8278(0.0, var_4);
  wait(var_4);
  var_5 stoploopsound(var_0);
  var_5 delete();
}