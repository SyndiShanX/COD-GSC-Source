/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\titan\titan_audio.gsc
*************************************************/

main() {
  thread _id_25AC();
  thread _id_1198B();
  thread _id_11959();
  thread init_lighting_dvars();
  thread _id_11999();
}

_id_25AC() {
  scripts\engine\utility::flag_init("stop_wind_emitters");
  level._id_3571 = 0;
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
  thread _id_ACE2("emt_titan_waterfall_med_flow_lp", (-60812, -32055, -64877), (-60709, -32066, -64213));
  thread _id_ACE2("emt_titan_waterfall_med_flow_lp", (-60343, -32544, -64172), (-60305, -32499, -64456));
  thread _id_ACE2("emt_titan_waterfall_sml_flow_lp", (-59355, -34733, -64126), (-59350, -34747, -64393));
  thread _id_ACE2("emt_titan_waterfall_sml_flow_lp", (-59589, -34070, -64315), (-59589, -34070, -64019));
  thread _id_ACE2("emt_titan_waterfall_sml_flow_lp", (-59179, -34877, -64285), (-59158, -34867, -64408));
  thread _id_ACE2("emt_titan_waterfall_sml_flow_lp", (-58565, -57594, -64550), (-58565, -57594, -64384));
  thread _id_ACE2("emt_titan_waterfall_lrg_flow_lp", (-58525, -36795, -64404), (-58525, -36795, -64826));
  thread _id_ACE2("emt_titan_waterfall_sml_flow_lp", (-58071, -36591, -64718), (-58071, -36591, -64451));
  thread _id_ACE2("emt_titan_waterfall_sml_flow_lp", (-58105, -36317, -64602), (-58105, -36317, -64436));
  thread _id_ACE2("emt_titan_waterfall_sml_flow_lp", (-57687, -35548, -64436), (-57687, -35548, -64320));
  thread _id_ACE2("emt_titan_waterfall_sml_flow_lp", (-58196, -35460, -64427), (-58196, -35460, -64243));
  thread _id_ACE2("emt_titan_waterfall_canyon_med_flow_lp", (-57585, -35942, -63948), (-57582, -35942, -64435));
  thread _id_ACE2("emt_titan_stream_canyon_lp", (-57590, -36177, -64688), (-57637, -36725, -64764));
  thread _id_ACE2("emt_titan_stream_canyon_lp", (-57637, -36761, -64784), (-57150, -37912, -64772));
  thread _id_ACE2("emt_titan_rain_vs_window_lrg_int_lp", (-47452, -40812, -64073), (-47298, -40851, -64073));
  thread _id_ACE2("emt_titan_rain_vs_window_lrg_int_lp", (-47283, -40876, -64073), (-47350, -41131, -64073));
  thread _id_ACE2("emt_titan_rain_vs_window_int_lp", (-47017, -41448, -64097), (-47097, -41746, -64086));
  thread _id_ACE2("emt_titan_rain_vs_window_int_lp", (-47290, -41259, -64098), (-47085, -41314, -64097));
  thread _id_ACE2("emt_titan_supercell_storm_door_line_emt_lp", (-47029, -41501, -64316), (-47094, -41744, -64316), "stop_wind_emitters", 2.0);
  thread _id_ACE2("emt_titan_supercell_storm_door_line_emt_lp", (-47339, -40999, -64297), (-47355, -41047, -64297), "stop_wind_emitters", 2.0);
  thread _id_ACE2("emt_titan_supercell_storm_door_line_emt_lp", (-47504, -41737, -64297), (-47559, -41729, -64297), "stop_wind_emitters", 2.0);
  thread _id_ACE2("emt_titan_supercell_storm_roof_hole_lp", (-47289, -41586, -64073), (-47382, -41452, -64073), "stop_wind_emitters", 2.0);
}

_id_11999() {
  var_0 = getEnt("sfx_titan_dropship_jumpout", "targetname");
  var_0 thread _id_1199A();
}

_id_1199A() {
  level endon("boggs_sfx_takeoff");

  for(;;) {
    self waittill("trigger");
    level.player clearclienttriggeraudiozone(0.75);

    while(level.player istouching(self))
      wait 0.5;
  }
}

_id_11959() {
  var_0 = spawn("script_origin", (-36036.2, -43033.1, -64257));
  wait 1;
  var_0 playLoopSound("emt_titan_dist_fact_lp");
  scripts\engine\utility::flag_wait("base_alerted");
  var_0 scripts\sp\utility::_id_10460(10);
}

_id_1198B() {
  wait 2;

  for(;;) {
    if(scripts\engine\utility::player_is_in_jackal()) {
      level.player _meth_82C0("jackal_cockpit", 2);
      level.player setsoundsubmix("temp_titan_jackal_duck");
      level waittill("jackal_landing");
      level.player playSound("jackal_landing_plr");
      level._id_D127 waittill("jackal_touchdown");
      level.player playSound("jackal_landed");
      level.player clearclienttriggeraudiozone(2.0);
      level.player clearsoundsubmix();
      wait 2;
    } else {
      level waittill("jackal_enter");
      wait 1;
      level.player scripts\sp\utility::_id_65E3("flag_player_is_flying");
      level.player playSound("jackal_vtol_takeoff_plr");
      wait 2;
    }

    wait 0.1;
  }
}

_id_1194A() {
  self _meth_83E8();

  if(!isDefined(self._id_2096)) {
    self._id_2096 = spawn("script_origin", self.origin);
    self._id_2096 linkTo(self);
  }

  if(!isDefined(self._id_2073)) {
    self._id_2073 = spawn("script_origin", self.origin);
    self._id_2073 linkTo(self);
  }

  if(!isDefined(self._id_207C)) {
    self._id_207C = spawn("script_origin", self.origin);
    self._id_207C linkTo(self);
  }

  thread _id_2063();
}

_id_2063() {
  self waittill("death");

  if(isDefined(self._id_207C))
    self._id_207C delete();

  if(isDefined(self._id_2073))
    self._id_2073 delete();

  if(isDefined(self._id_2096))
    self._id_2096 delete();
}

_id_1194B() {
  self endon("death");
  self endon("stop_move_along_struct_path");
  self endon("apc_sfx_stop");
  self endon("apc_stopped");
  var_0 = "";
  var_1 = 0.2;
  var_2 = 0.2;
  self._id_2073 scripts\sp\utility::_id_10461("veh_apc_slow_lp", 0.5, 0.5, 1);
  self._id_2096 scripts\sp\utility::_id_10461("veh_apc_tires_lp", 0.5, 0.5, 1);
  self._id_207C _meth_8278(0, 3);

  for(;;) {
    var_3 = self vehicle_getspeed();
    var_4 = var_3 / 8;

    if(var_1 < var_4)
      var_2 = var_1 + (var_4 - var_1) / 30;

    if(var_1 > var_4)
      var_2 = var_1 - (var_1 - var_4) / 30;

    if(var_2 > 1)
      var_2 = 1;

    var_1 = var_2;
    self._id_2096 _meth_8278(var_1, 0.1);

    if(var_3 > 8) {
      if(var_0 == "med") {
        var_0 = "fast";
        self playSound("veh_apc_upshift_to_fast");
        self._id_2073 _meth_8278(0, 0.5);
        wait 0.5;
        self._id_2073 playLoopSound("veh_apc_fast_lp");
        self._id_207C stoploopsound();
        self._id_2073 _meth_8278(1, 1);
      }

      if(var_0 == "slow") {
        var_0 = "fast";
        self playSound("veh_apc_quick_accel_to_fast");
        self._id_2073 _meth_8278(0, 0.5);
        wait 0.5;
        self._id_2073 playLoopSound("veh_apc_fast_lp");
        self._id_207C stoploopsound();
        self._id_2073 _meth_8278(1, 1);
      }
    } else if(var_3 > 4) {
      if(var_0 == "fast") {
        var_0 = "med";
        self playSound("veh_apc_downshift_to_med");
        self._id_2073 _meth_8278(0, 0.5);
        wait 0.5;
        self._id_2073 playLoopSound("veh_apc_med_lp");
        self._id_207C stoploopsound();
        self._id_2073 _meth_8278(1, 1);
      }

      if(var_0 == "slow") {
        var_0 = "med";
        self playSound("veh_apc_upshift_to_med");
        self._id_2073 _meth_8278(0, 0.5);
        wait 0.5;
        self._id_2073 playLoopSound("veh_apc_med_lp");
        self._id_207C stoploopsound();
        self._id_2073 _meth_8278(1, 1);
      }
    } else if(var_3 > 1) {
      if(var_0 == "med") {
        var_0 = "slow";
        self playSound("veh_apc_downshift_to_slow");
        self._id_2073 _meth_8278(0, 0.5);
        wait 0.5;
        self._id_2073 playLoopSound("veh_apc_slow_lp");
        self._id_207C stoploopsound();
        self._id_2073 _meth_8278(1, 1);
      } else if(var_0 == "fast") {
        var_0 = "slow";
        self playSound("veh_apc_downshift_to_slow");
        self._id_2073 _meth_8278(0, 0.5);
        wait 0.5;
        self._id_2073 playLoopSound("veh_apc_slow_lp");
        self._id_207C stoploopsound();
        self._id_2073 _meth_8278(1, 1);
      } else if(var_0 != "slow") {
        var_0 = "slow";
        self playSound("veh_apc_upshift_to_slow");
        self._id_2073 playLoopSound("veh_apc_slow_lp");
        self._id_207C stoploopsound();
        self._id_2073 _meth_8278(1, 1);
        wait 0.1;
      }
    }

    wait 0.1;
  }
}

_id_1194E() {
  self endon("death");
  self endon("stop_move_along_struct_path");
  var_0 = self vehicle_getspeed();

  if(var_0 < 4)
    self playSound("veh_apc_slow_stop_from_slow");
  else if(var_0 < 8)
    self playSound("veh_apc_slow_stop_from_med");
  else
    self playSound("veh_apc_slow_stop_from_fast");

  self._id_207C scripts\sp\utility::_id_10461("veh_apc_idle_lp", 1, 2, 1);
  self._id_2096 _meth_8278(0, 3);
  self._id_2073 _meth_8278(0, 2);
}

_id_1194D() {
  self endon("death");
  self endon("stop_move_along_struct_path");
  self endon("apc_sfx_stop");
  self waittill("apc_sfx_slowing");
  var_0 = 1;
  var_1 = 1;

  while(self vehicle_getspeed() > 0.2) {
    var_2 = self vehicle_getspeed();
    var_3 = var_2 / 15;

    if(var_0 < var_3)
      var_1 = var_0 + (var_3 - var_0) / 30;

    if(var_0 > var_3)
      var_1 = var_0 - (var_0 - var_3) / 30;

    if(var_1 > 1)
      var_1 = 1;

    var_0 = var_1;
    self._id_2073 _meth_8278(var_0, 0.1);
    wait 0.1;
  }

  self notify("apc_sfx_stop");
}

_id_1194C() {
  self endon("death");
  self endon("stop_move_along_struct_path");
  self playSound("veh_apc_ignition");
  self._id_207C scripts\sp\utility::_id_10461("veh_apc_idle_lp", 1, 2, 1);

  for(;;) {
    while(!self vehicle_getspeed() > 0)
      wait 0.1;

    thread _id_1194B();
    thread _id_1194D();
    self waittill("apc_sfx_stop");
    thread _id_1194E();

    while(self vehicle_getspeed() != 0)
      wait 0.1;

    self notify("apc_stopped");
    self._id_2073 stoploopsound();
    self._id_2096 stoploopsound();
  }
}

_id_FB55() {
  self playLoopSound("weap_c12_minigun_fire");
}

_id_FB56() {
  self stoploopsound("weap_c12_minigun_fire");
  self playSound("weap_c12_minigun_release");
}

_id_11989() {
  level.player playSound("scn_titan_jackal_takeoff_plr");
  wait 0.5;
  level.player playSound("scn_titan_jackal_takeoff_npcs");
  level.player _meth_82C2("titan_jackal_launch", "mix");
  wait 25;
  setglobalsoundcontext("atmosphere", "space", 4);
  wait 1;
  level.player clearclienttriggeraudiozone(0);
  level.player _meth_82C0("jackal_cockpit", 4);
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
  wait 5;
  level.player playSound("scn_monsintro_squibs_01");
}

_id_11990() {
  level._id_D127 waittill("jackal_touchdown");
  wait 2;
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