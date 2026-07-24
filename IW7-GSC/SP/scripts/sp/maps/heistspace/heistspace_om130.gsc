/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\heistspace\heistspace_om130.gsc
***********************************************************/

_id_C453() {
  precacheitem("om130_jackal_missile");
  precacheitem("om130_missile_missile");
  precachemodel("veh_mil_air_ca_olympus_mons_gun_rig");
  precacherumble("om130_cannon");
  precacherumble("steady_rumble");
  precacheshader("radar_targeting_cursor");
  precacheshader("radar_targeting_icon_missile");
  precacheshader("radar_targeting_icon_carrier");
  precacheshader("radar_targeting_icon_destroyer");
  precacheshader("radar_targeting_icon_jackal_closed_wings");
  precacheshader("radar_targeting_icon_jackal_open_wings");
  precacheshader("radar_targeting_icon_brackets");
  precacheshader("hud_om130_frame");
  precacheshader("hud_om130_frame_gradient");
  precacheshader("hud_om130_reticle_dot");
  precacheshader("hud_om130_reticle_crosshair");
  precacheshader("hud_om130_reticle_circle");
  precacheshader("hud_om130_reticle_circle_fill");
  precacheshader("hud_om130_reticle_circle_fill_glow");
  precacheshader("hud_om130_fspar_bar");
  precacheshader("hud_om130_ready_bg");
  precachestring(&"HEIST_TUTORIAL_OM130_FSPAR_CHARGE");
  precachestring(&"HEIST_TUTORIAL_OM130_FSPAR_FIRE");
  precacheturret("om130_turret_fspar");
  precacheturret("om130_turret_fspar_fast");
}

_id_3B85() {
  level thread scripts\sp\maps\heistspace\heistspace_audio::_id_3B3A();
  level thread scripts\sp\maps\heistspace\heistspace_util::_id_8D2A("stage1");
  var_0 = getEntArray("intro_satellite", "targetname");
  scripts\sp\utility::_id_228A(var_0);
  scripts\engine\utility::flag_set("heistspace_start_objectives");
  scripts\engine\utility::flag_set("om130_fired_first_time");
  scripts\engine\utility::flag_set("player_on_bridge");
  var_1 = 1;
  level thread scripts\sp\maps\heistspace\heistspace_util::_id_1078B(var_1);
  var_2 = getEnt("bridge_capt_screen", "targetname");
  var_2 delete();

  if(scripts\sp\utility::_id_93A6()) {
    scripts\sp\specialist_MAYBE::_id_8E06();
    scripts\sp\specialist_MAYBE::_id_F53C(0);
  }
}

_id_C461() {
  scripts\sp\utility::_id_F5AF("jumpto_mons_130", [level.player]);
  scripts\sp\maps\heistspace\heistspace_util::_id_10733(1, 1, 1, undefined, 1);
  scripts\sp\hud_util::_id_6AA3(0, "black");
}

_id_C442() {
  level._id_C41A = spawnStruct();
  level._id_C41A._id_13CC3 = [];
  level._id_C41A._id_A8F3 = 0;
  level._id_C41A._id_B42A = 21;
  level._id_C41A._id_745A = 7.0;
  level._id_C41A._id_745F = 0.0;
  level._id_C41A._id_7461 = 3.0;
  level._id_C413 scripts\sp\vehicle::_id_8441();
  level thread scripts\sp\maps\heistspace\heistspace_audio::_id_25EC("jumpto_mons_130");
  level._id_C41A._id_A35B = _id_96A7();
  scripts\sp\utility::_id_9187("OM130", 1, ::_id_C44D);
  scripts\engine\utility::flag_init("om130_fspar_firing");
  scripts\engine\utility::flag_init("om130_ending");
  scripts\engine\utility::flag_init("om130_danger_zone");
  _id_C443();
}

_id_C44D() {
  var_0 = [];
  var_0["r_hudoutlineFillColor0"] = "0 0 0 0";
  var_0["r_hudoutlineFillColor1"] = "0 0 0 0";
  var_0["r_hudoutlineOccludedInlineColor"] = ".7 .7 .7 0.25";
  var_0["r_hudoutlineOccludedInteriorColor"] = ".7 .7 .7 0.25";
  return var_0;
}

_id_C443() {
  level._id_C41A._id_6505 = 0;
  level._id_C41A._id_6504 = [ &"HEIST_SDS_VALIANT", &"HEIST_SDS_NEMESIS", &"HEIST_SDS_PHOBOS", &"HEIST_SDS_THARSIS", &"HEIST_SDS_NEREIDUM", &"HEIST_SDS_ASCRAEUS", &"HEIST_SDS_ELYSIUM", &"HEIST_SDS_UTOPIA", &"HEIST_SDS_ANSERIS", &"HEIST_SDS_ARSIA", &"HEIST_SDS_ARGYRE", &"HEIST_SDS_ISIDIS", &"HEIST_SDS_PERAEA", &"HEIST_SDS_DEADALIA", &"HEIST_SDS_DEIMOS", &"HEIST_SDS_LUNAE_PALUS", &"HEIST_SDS_ERIDANIA", &"HEIST_SDS_ALBOR_THOLUS", &"HEIST_SDS_HECATES", &"HEIST_SDS_URANIUS", &"HEIST_SDS_VALLES_MARINERIS", &"HEIST_SDS_TITHONIUM", &"HEIST_SDS_HORARUM_MONS", &"HEIST_SDS_ELECTRIS_MONS"];
}

_id_C448() {
  _id_C442();
  level thread scripts\sp\maps\heistspace\heistspace_util::_id_8D2A("stage1");
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D3(1);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132B0(1);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132BB(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132CC(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132B4(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D4(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132CB(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132C6(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D2(0);

  if(scripts\sp\utility::_id_93A6()) {
    scripts\sp\specialist_MAYBE::_id_8E06();
    scripts\sp\specialist_MAYBE::_id_F53C(0);
  }

  thread scripts\sp\hud_util::_id_6A99(3.0, "black");
  level thread _id_C46D();
  thread scripts\sp\maps\heistspace\heistspace_audio::_id_9158();
  level.player thread _id_C459();
  level.player thread _id_C470();
  level.player thread _id_C43B();
  level thread _id_C40E();
  level.player thread _id_C439();
  level thread _id_C421();
  level thread _id_B394();
  level thread _id_EB49();
  level thread _id_C420();
  level.player thread _id_C46F();
  scripts\engine\utility::flag_set("heistspace_start_objectives");
  scripts\engine\utility::flag_set("player_on_bridge");
  var_0 = getEntArray("rotate_debris", "targetname");

  foreach(var_2 in var_0) {
    var_2 hide();
    var_2 notsolid();
  }

  level thread scripts\sp\maps\heistspace\heistspace_util::_id_7657();
  level scripts\engine\utility::delaythread(5, scripts\sp\utility::_id_12641, "heistspace_base_tr");
  level scripts\engine\utility::delaythread(40, scripts\sp\utility::_id_12641, "heistspace_om_halls_tr");
  scripts\engine\utility::flag_wait("mons_130_end");

  while(!istransientloaded("heistspace_om_halls_tr")) {
    wait 0.05;
    waitforalltransients();
  }

  foreach(var_2 in var_0) {
    var_2 show();
    var_2 solid();
  }
}

_id_C46D() {
  var_0 = getEnt("bridge_capt_screen", "targetname");
  var_0 hide();
  wait 0.5;
  setsaveddvar("bg_cinematicfullscreen", "0");
  setsaveddvar("bg_cinematicCanPause", "1");
  cinematicingame("heistspace_fspar_connect");

  while(cinematicgetframe() <= 1) {
    scripts\engine\utility::waitframe();
  }

  pausecinematicingame(1);
  scripts\engine\utility::flag_wait("om130_activating");
  pausecinematicingame(0);
  wait 2.85;
  var_0 show();
  scripts\engine\utility::flag_wait("om130_ending");
  var_0 delete();
}

_id_C459() {
  level thread scripts\sp\maps\heistspace\heistspace_audio::_id_BA44();
  level._id_C413 show();
  thread _id_C45C();
  scripts\engine\utility::flag_wait("om130_activating");
  target_alloc(level._id_C413);
  target_setradarcenter(level._id_C413, 1);
  target_hidefromplayer(level._id_C413, level.player);
  target_flush(level._id_C413);
  wait 3;
  thread _id_C45D();
}

_id_C45C() {
  self disableweapons();
  var_0 = scripts\engine\utility::getStruct("om_leave_bridge_animnode", "targetname");
  level._id_D267 = scripts\sp\utility::_id_10639("player_rig");
  level.player playerlinktodelta(level._id_D267, "tag_player", 1, 10, 10, 5, 5);
  var_0 thread scripts\sp\anim::_id_1F35(level._id_D267, "bridge_intro");
  wait 0.15;
  self allowmovement(0);
  scripts\engine\utility::allow_jump(0);
  scripts\engine\utility::allow_prone(0);
  scripts\engine\utility::allow_crouch(0);
  self _meth_80D1();
  level thread scripts\sp\maps\heistspace\heistspace_audio::_id_BAF8();
  level._id_D267 waittillmatch("single anim", "end");
  scripts\engine\utility::flag_set("move_mars");
  level.player playerlinktodelta(level._id_D267, "tag_player", 0, 50, 60, 38, 30);
}

_id_C43B() {
  self waittill("om130_ending");
  level.player lerpviewangleclamp(1.5, 0.5, 0, 20, 20, 20, 20);
  scripts\engine\utility::flag_waitopen("om130_fspar_firing");
  screenshake(level.player.origin, 0.8, 0.8, 0.1, 6.0, 0, 2.5, 1000, 14, 14, 4);
  var_0 = scripts\sp\utility::_id_7C23();
  var_0 thread scripts\sp\utility::_id_E7C8(0.1);
  var_0 scripts\engine\utility::delaythread(3.5, scripts\sp\utility::_id_E7C7, 2.5);
  var_0 scripts\engine\utility::delaycall(7.0, ::delete);
  setomnvar("ui_olympus_mons_overlay", 2);
  setomnvar("ui_olympus_mons_out_of_range", 0);
  setomnvar("ui_jackal_ship_callout_0", undefined);
  setomnvar("ui_jackal_ship_callout_type_0", 0);
  self _meth_8578(&"", 0);
  setomnvar("ui_jackal_ship_callout_changed_0", int(getomnvar("ui_jackal_ship_callout_changed_0") + 1));
  self _meth_8497(1);
  level thread scripts\sp\maps\heistspace\heistspace_util::_id_1078B();
  scripts\engine\utility::flag_set("om130_ending");
  level thread scripts\sp\utility::_id_C12D("om130_ending_delayed", 20);
  level.player playSound("hud_disconnect");

  while(level._id_C41A._id_745F > 0.0) {
    wait 0.05;
  }

  level._id_C41A._id_FE37._id_C368 delete();
  level._id_C41A._id_FE37._id_C368 = undefined;
  level._id_C413 notsolid();

  if(isDefined(level._id_C41A._id_E7C2)) {
    level._id_C41A._id_E7C2 scripts\sp\utility::_id_F581(0.0);
    level._id_C41A._id_E7C2 scripts\engine\utility::delaycall(0.1, ::_meth_81D0);
    level._id_C41A._id_E7C2 = undefined;
  }

  if(isDefined(level._id_C41A._id_7470)) {
    level._id_C41A._id_7470 scripts\sp\utility::_id_9193("OM130");
  }

  var_1 = getEnt("olympus_mons_fspar", "targetname");
  var_1 show();

  if(isDefined(level._id_C41A._id_7458)) {
    var_1.angles = level._id_C41A._id_7458.angles;
    var_1 dontinterpolate();

    if(isDefined(level._id_C41A._id_7458._id_11512)) {
      level._id_C41A._id_7458._id_11512 delete();
    }

    stopFXOnTag(scripts\engine\utility::getfx("vfx_mons_steeldragon_chargeup"), level._id_C41A._id_7458, "tag_weapon");
    stopFXOnTag(scripts\engine\utility::getfx("vfx_mons_steeldragon_chargeup_muzzle"), level._id_C41A._id_7458, "tag_fx");
    level._id_C41A._id_7458 delete();
    level._id_C41A._id_7458 = undefined;
  }

  if(isDefined(level._id_C41A._id_7465)) {
    level._id_C41A._id_7465 delete();
    level._id_C41A._id_7465 = undefined;
  }

  thread _id_C463();
  target_remove(level._id_C413);
  var_2 = target_getarray();

  foreach(var_4 in var_2) {
    var_4 notify("remove_target");
  }

  scripts\engine\utility::flag_wait("mons_130_vo_end");
  thread _id_C452();
  scripts\engine\utility::flag_wait("mons_130_end");

  foreach(var_7 in level._id_63E6) {
    if(isDefined(var_7)) {
      var_7 _meth_8585((0, 0, 0));

      if(scripts\engine\utility::is_true(var_7._id_5F97)) {
        var_8 = randomfloatrange(1.0, 3.0);
        var_7 scripts\engine\utility::delaythread(var_8, _id_0BB8::_id_3991);
        var_7 scripts\engine\utility::delaythread(var_8 + 5, _id_0BA9::_id_397B);
      }
    }
  }

  level waittill("end_random_jackal_deployments");
  scripts\engine\utility::waitframe();
  level._id_C41A = undefined;
}

_id_C452() {
  setomnvar("ui_hide_weapon_info", 0);
  setsaveddvar("actionslotshide", "0");
  setsaveddvar("hud_showStance", "1");
  setomnvar("ui_olympus_mons_overlay", 3);
  wait 2.0;
  setomnvar("ui_olympus_mons_overlay", 0);
  scripts\engine\utility::flag_set("mons_130_end");
}

_id_C45D() {
  setomnvar("ui_hide_weapon_info", 1);
  setsaveddvar("actionslotshide", "1");
  setsaveddvar("hud_showStance", "0");
  setomnvar("ui_olympus_mons_overlay", 1);
  thread _id_C46B();
  thread _id_C43E();
  thread _id_C454();
  thread _id_C438();
  level.player _meth_8496(&"HEIST_TUTORIAL_OM130_FSPAR_CHARGE");
  level.player thread _id_C429(30);
  level notify("om130_ui_initialized");
}

_id_C429(var_0) {
  self notify("om130_clear_hint_with_delay");
  self endon("om130_clear_hint_with_delay");
  level endon("om130_ending");
  wait(var_0);
  self _meth_8497(0);
}

_id_C46B() {
  level._id_C41A._id_A6F8 = 7289;
  var_0 = 3;
  var_1 = 0.333;

  for(var_2 = 25; !scripts\engine\utility::flag("mons_130_end") && level._id_C41A._id_A6F8 > 0; level._id_C41A._id_A6F8 = level._id_C41A._id_A6F8 - var_0 * var_3) {
    setomnvar("ui_olympus_mons_distance", int(level._id_C41A._id_A6F8));
    var_3 = max(0.05, 1 / var_0);
    wait(var_3);
    var_0 = var_0 + var_1 * var_3;
    var_0 = min(var_0, var_2);
  }
}

_id_C46C() {
  var_0 = 3937;
  level waittill("om130_ui_initialized");

  while(!scripts\engine\utility::flag("om130_ending")) {
    var_1 = self.origin + anglestoup(self.angles) * self.offset;
    self._id_C368.origin = level.player getEye() + vectorNormalize(var_1 - level.player getEye()) * level._id_C41A._id_A6F8 * var_0;
    wait 0.05;
  }
}

_id_C43E() {
  level endon("om130_ending");
  var_0 = 0;
  var_1 = (8000, 0, 0);
  var_2 = (-6500, 0, 0);
  var_3 = [var_1, var_2];
  var_4 = [var_1 * 0.5, var_2 * 0.5];
  var_5 = [var_1 * 0.25, var_2 * 0.25, var_1 * 0.75, var_2 * 0.75];

  for(;;) {
    var_6 = undefined;
    var_7 = -1;

    foreach(var_9 in vehicle_getarray()) {
      var_10 = 0;

      if(scripts\engine\utility::is_true(var_9._id_7470)) {
        var_11 = distance(self getEye(), var_9.origin);

        if(self worldpointinreticle_circle(var_9.origin, 65, 20)) {
          var_10 = 1;
        } else {
          var_12 = anglestoaxis(var_9.angles);
          var_13 = var_3;

          if(var_11 < 100000) {
            var_13 = scripts\engine\utility::array_combine(var_13, var_4);
          }

          if(var_11 < 60000) {
            var_13 = scripts\engine\utility::array_combine(var_13, var_5);
          }

          foreach(var_15 in var_13) {
            var_16 = var_9.origin + var_12["forward"] * var_15[0] + var_12["right"] * var_15[1] + var_12["up"] * var_15[2];

            if(self worldpointinreticle_circle(var_16, 65, 20)) {
              var_10 = 1;
              break;
            }
          }
        }

        if(var_10) {
          if(!isDefined(var_6) || var_11 < var_7) {
            var_6 = var_9;
            var_7 = var_11;
          }
        }
      }
    }

    if(!isDefined(var_6) && isDefined(level._id_C41A._id_FE37)) {
      if(self worldpointinreticle_circle(level._id_C41A._id_FE37._id_C368.origin, 65, 30)) {
        var_6 = level._id_C41A._id_FE37;
      }
    }

    if(isDefined(var_6)) {
      if(!scripts\engine\utility::is_true(var_6.painted)) {
        var_0 = 1;
        _id_C44E(var_6);
        setomnvar("ui_olympus_mons_have_target", 1);
      }
    } else if(var_0) {
      _id_C44E();
      var_0 = 0;
      setomnvar("ui_olympus_mons_have_target", 0);
    }

    wait 0.05;
  }
}

_id_C44E(var_0) {
  level._id_C41A._id_A91C = var_0;

  if(!scripts\engine\utility::flag("om130_fspar_firing")) {
    var_1 = target_getarray();

    foreach(var_3 in var_1) {
      if(scripts\engine\utility::is_true(var_3.painted)) {
        var_3.painted = 0;
        var_3 notify("painted");
        var_3 scripts\sp\utility::_id_9193("OM130");
      }
    }

    if(isDefined(level._id_C41A._id_FE37) && (!isDefined(var_0) || var_0 != level._id_C41A._id_FE37) && scripts\engine\utility::is_true(level._id_C41A._id_FE37.painted)) {
      level._id_C41A._id_FE37.painted = 0;
      level._id_C41A._id_FE37 notify("painted");
      level._id_C41A._id_FE37 scripts\sp\utility::_id_9193("OM130");
      setomnvar("ui_olympus_mons_out_of_range", 0);
    }

    level._id_C41A._id_7470 = undefined;

    if(!isDefined(var_0) || !isDefined(var_0.vehicletype) && (!isDefined(level._id_C41A._id_FE37) || var_0 != level._id_C41A._id_FE37)) {
      setomnvar("ui_jackal_ship_callout_0", undefined);
      setomnvar("ui_jackal_ship_callout_type_0", 0);
      level.player _meth_8578(&"", 0);
      setomnvar("ui_jackal_ship_callout_changed_0", int(getomnvar("ui_jackal_ship_callout_changed_0") - 1));
      return;
    }

    level._id_C41A._id_7470 = var_0;
    var_0.painted = 1;
    var_0 notify("painted");

    if(isDefined(level._id_C41A._id_FE37) && var_0 == level._id_C41A._id_FE37) {
      var_0 scripts\sp\utility::_id_9196(1, 0, 1, "OM130");
      setomnvar("ui_olympus_mons_out_of_range", 1);
      var_0 = level._id_C41A._id_FE37._id_C368;
    } else
      var_0 scripts\sp\utility::_id_9196(4, 0, 1, "OM130");

    setomnvar("ui_jackal_ship_callout_0", var_0);
    setomnvar("ui_jackal_ship_callout_type_0", 5);
    level.player _meth_8578(var_0.name, 0);
    setomnvar("ui_jackal_ship_callout_changed_0", int(getomnvar("ui_jackal_ship_callout_changed_0") + 1));
  }
}

_id_C454() {
  self endon("om130_ending");
  var_0 = 1;

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if(var_1 == "radar_targeted") {
      var_3 = undefined;

      if(var_2 >= 0) {
        var_3 = target_gettargetatindex(var_2);
      }

      _id_C44E(var_3);
    }
  }
}

_id_C438() {
  level endon("om130_ending");
  var_0 = [];

  for(var_1 = 0; var_1 < level._id_C41A._id_B42A; var_1++) {
    var_0[var_1] = var_1;
  }

  level waittill("om130_capital_ships_attacking");
  level._id_C42A = 0;
  var_2 = 0;

  while(var_0.size > 0) {
    level._id_C413 waittill("missile_damage", var_3);

    if(var_3 == "om130_jackal_missile" || var_3 == "om130_missile_missile") {
      if(var_3 == "om130_missile_missile") {
        var_2 = var_2 + 3;
      } else {
        var_2 = var_2 + 2;
      }

      if(var_2 >= 20) {
        var_2 = 0;
        screenshake(self getEye(), randomfloatrange(1.0, 2.0), randomfloatrange(1.0, 2.0), 0.0, randomfloatrange(1.5, 2.0), 0, -1, 0, randomfloatrange(5.0, 10.0), randomfloatrange(5.0, 10.0), 1.0);
        self playRumbleOnEntity("om130_cannon");
        var_4 = randomint(var_0.size);
        thread _id_C436(var_0[var_4]);
        var_0 = scripts\sp\utility::array_remove_index(var_0, var_4);
        level._id_C42A++;
        level notify("olympus_damaged");

        if(var_0.size == 4) {
          scripts\engine\utility::flag_set("om130_danger_zone");
        }

        continue;
      }

      screenshake(self getEye(), randomfloatrange(0.1, 0.2), randomfloatrange(0.1, 0.2), 0.0, randomfloatrange(0.25, 0.5), 0, -1, 0, randomfloatrange(5.0, 10.0), randomfloatrange(5.0, 10.0), 1.0);
      self playRumbleOnEntity("om130_cannon");
    }
  }

  wait 1.25;
  level.player notify("om130_ending");
  scripts\engine\utility::flag_set("fspar_down");
}

_id_C436(var_0) {
  level endon("om130_ending");

  for(var_1 = 0; var_1 < 10; var_1++) {
    setomnvarbit("ui_olympus_mons_damage_state", var_0, 1);
    wait 0.25;
    setomnvarbit("ui_olympus_mons_damage_state", var_0, 0);
    wait 0.25;
  }

  setomnvarbit("ui_olympus_mons_damage_state", var_0, 1);
}

_id_C470() {
  self endon("om130_ending");
  thread _id_C44B();
}

_id_C44B() {
  level endon("om130_ending_delayed");
  scripts\engine\utility::flag_wait("om130_intro_vo_done");
  level._id_C41A._id_E7C2 = scripts\engine\utility::spawn_tag_origin();
  level._id_C41A._id_E7C2._id_99E5 = 0;
  level._id_C41A._id_E7C2 thread scripts\sp\utility_code::_id_12E1F(self, "steady_rumble");
  level._id_C41A._id_E7C2 _meth_8291(0.2, 0, 0, 999999, 0, 0, 1000, 10, 0, 0);
  var_0 = getEnt("olympus_mons_fspar", "targetname");
  var_0 hide();
  level._id_C41A._id_7458 = spawnturret("misc_turret", var_0.origin, "om130_turret_fspar", 0);
  level._id_C41A._id_7458 setModel("veh_mil_air_ca_olympus_mons_gun_rig");
  level._id_C41A._id_7458 setmode("manual");
  level._id_C41A._id_7458.playing = 0;
  level._id_C41A._id_7458._id_11512 = scripts\engine\utility::spawn_tag_origin(self getEye() + anglesToForward(self getplayerangles()) * 50000, (0, 0, 0));
  level._id_C41A._id_7458 settargetentity(level._id_C41A._id_7458._id_11512, (0, 0, 0));
  level._id_C41A._id_7465 = spawnturret("misc_turret", var_0.origin, "om130_turret_fspar_fast", 0);
  level._id_C41A._id_7465 setModel("veh_mil_air_ca_olympus_mons_gun_rig");
  level._id_C41A._id_7465 setmode("manual");
  level._id_C41A._id_7465 settargetentity(level._id_C41A._id_7458._id_11512, (0, 0, 0));
  level._id_C41A._id_7465 hide();

  while(!scripts\engine\utility::flag("om130_ending") || level._id_C41A._id_745F > 0.0) {
    if(!scripts\engine\utility::flag("om130_ending") && self attackButtonPressed() && self adsButtonPressed(1)) {
      _id_C426();
    } else if(!scripts\engine\utility::flag("om130_ending") && level._id_C41A._id_745F >= 1.0 && isDefined(level._id_C41A._id_7470) && (!isDefined(level._id_C41A._id_FE37) || level._id_C41A._id_FE37 != level._id_C41A._id_7470)) {
      _id_C435();
    } else {
      _id_C430();
    }

    if(!scripts\engine\utility::flag("om130_ending")) {
      if(isDefined(level._id_C41A._id_7470)) {
        level._id_C41A._id_7458._id_11512.origin = level._id_C41A._id_7470.origin;
      } else {
        level._id_C41A._id_7458._id_11512.origin = self getEye() + anglesToForward(self getplayerangles()) * 50000;
      }
    }

    if(level._id_C41A._id_745F > 0.0) {
      if(isDefined(level._id_C41A) && isDefined(level._id_C41A._id_E7C2)) {
        level._id_C41A._id_E7C2 scripts\sp\utility::_id_F581(clamp(pow(level._id_C41A._id_745F, 0.5), 0.25, 0.5));
      }
    } else if(isDefined(level._id_C41A) && isDefined(level._id_C41A._id_E7C2))
      level._id_C41A._id_E7C2 scripts\sp\utility::_id_F581(0.0);

    wait 0.05;
  }
}

_id_C426() {
  level._id_C41A._id_745F = level._id_C41A._id_745F + 0.05 / level._id_C41A._id_745A;
  level._id_C41A._id_745F = min(level._id_C41A._id_745F, 1.0);
  setomnvar("ui_olympus_mons_weapon_status", level._id_C41A._id_745F);
  level._id_C41A._id_745C = 1;

  if(level._id_C41A._id_745F < 1.0) {
    _id_C450("charging");
    level._id_C41A._id_7466 = 0;
  } else {
    _id_C450("charged");

    if(!scripts\engine\utility::is_true(level._id_C41A._id_7467)) {
      level.player _meth_8496(&"HEIST_TUTORIAL_OM130_FSPAR_FIRE");
      level.player thread _id_C429(30);
      level._id_C41A._id_7467 = 1;
    }

    if(!scripts\engine\utility::is_true(level._id_C41A._id_7466)) {
      playFXOnTag(scripts\engine\utility::getfx("vfx_mons_steeldragon_fullcharge_muzzle"), level._id_C41A._id_7458, "tag_fx");
      level.player playRumbleOnEntity("artillery_rumble");
      level._id_C41A._id_7466 = 1;
    }
  }

  if(!scripts\engine\utility::is_true(level._id_C41A._id_7458.playing)) {
    level._id_C41A._id_7458.playing = 1;
    playFXOnTag(scripts\engine\utility::getfx("vfx_mons_steeldragon_chargeup"), level._id_C41A._id_7458, "tag_weapon");
    playFXOnTag(scripts\engine\utility::getfx("vfx_mons_steeldragon_chargeup_muzzle"), level._id_C41A._id_7458, "tag_fx");
  }
}

_id_C435() {
  self notify("om130_fire_weapons");
  scripts\engine\utility::flag_set("om130_fired_first_time");
  scripts\engine\utility::flag_set("om130_fspar_firing");
  var_0 = level._id_C41A._id_7470;
  level._id_C41A._id_E7C2 scripts\sp\utility::_id_F581(1.0);
  setomnvar("ui_olympus_mons_fspar_target_index", target_getindexoftarget(var_0));
  level._id_C41A._id_7458._id_11512.origin = var_0.origin;
  level._id_C41A._id_7458._id_11512 dontinterpolate();
  level._id_C41A._id_7458._id_11512 linkTo(var_0, "tag_origin");
  wait 0.05;
  level._id_C41A._id_7458 hide();
  level._id_C41A._id_7465 show();
  var_1 = playfxontagsbetweenclients(scripts\engine\utility::getfx("fspar_beam"), level._id_C41A._id_7465, "tag_fx", level._id_C41A._id_7458._id_11512, "tag_origin");

  if(var_0 vehicle_getspeed() > 100) {
    var_0 vehicle_setspeedimmediate(100, 200, 200);
  }

  var_0 _meth_8585((0, 0, 0));
  screenshake(self getEye(), 0.4, 0.0, 0.0, 0.5, 0.0, 0.5, 0, 8, 0, 0);
  setomnvar("ui_olympus_mons_weapon_status", 0);
  level.player _meth_8497(1);
  level._id_C41A._id_745C = 0;
  _id_C450("fire");
  var_2 = scripts\engine\utility::spawn_tag_origin((-57306, 12721, 5500), (0, 0, 0));
  var_2 thread scripts\sp\maps\heistspace\heistspace_fx::_id_D6FD(0.1, -0.2, 0.5, 0.75, 0.75, 0.25, 0.5, "tag_origin", "vfx_fspar_flash");
  var_3 = 0.0;
  var_4 = 0.25;
  var_5 = level._id_C41A._id_7458 gettagorigin("tag_fx");

  while(level._id_C41A._id_745F > 0.0) {
    _id_C430(1.0, 1);

    if(isDefined(level._id_C41A._id_E7C2) && level._id_C41A._id_745F < 0.25) {
      level._id_C41A._id_E7C2 scripts\sp\utility::_id_F581(level._id_C41A._id_745F / 0.25);
    }

    if(var_3 <= 0.0) {
      var_6 = scripts\common\trace::ray_trace(var_5 + vectorNormalize(var_0.origin - var_5) * 2000, var_0.origin);

      if(isDefined(var_6["entity"]) && var_6["entity"] == var_0) {
        playFX(scripts\engine\utility::getfx("fspar_impact"), var_6["position"], var_6["normal"]);
      }

      var_3 = var_4;
    } else
      var_3 = var_3 - 0.05;

    wait 0.05;
  }

  if(isDefined(level._id_C41A._id_A91C)) {
    _id_C44E(level._id_C41A._id_A91C);
  }

  level._id_C41A._id_7458._id_11512 unlink();
  var_0 notify("fspar");
  scripts\engine\utility::flag_clear("om130_fspar_firing");
  wait 0.2;
  var_1 delete();

  if(!scripts\engine\utility::flag("om130_ending")) {
    level._id_C41A._id_7465 hide();
    level._id_C41A._id_7458 show();
  }

  setomnvar("ui_olympus_mons_fspar_target_index", -1);
  var_2 delete();
}

_id_C430(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 1.0;
  }

  level._id_C41A._id_745F = level._id_C41A._id_745F - 0.05 / (level._id_C41A._id_745A / (level._id_C41A._id_7461 * var_0));
  level._id_C41A._id_745F = max(0.0, level._id_C41A._id_745F);

  if(!scripts\engine\utility::is_true(var_1)) {
    setomnvar("ui_olympus_mons_weapon_status", level._id_C41A._id_745F);

    if(scripts\engine\utility::is_true(level._id_C41A._id_745C)) {
      _id_C450("discharge");
      level._id_C41A._id_745C = 0;
    }
  }

  if(isDefined(level._id_C41A._id_7458) && scripts\engine\utility::is_true(level._id_C41A._id_7458.playing)) {
    level._id_C41A._id_7458.playing = 0;
    stopFXOnTag(scripts\engine\utility::getfx("vfx_mons_steeldragon_chargeup"), level._id_C41A._id_7458, "tag_weapon");
    stopFXOnTag(scripts\engine\utility::getfx("vfx_mons_steeldragon_chargeup_muzzle"), level._id_C41A._id_7458, "tag_fx");
  }
}

_id_C450(var_0) {
  if(var_0 == "charging") {
    if(!isDefined(level._id_C41A._id_745D)) {
      level._id_C41A._id_745D = scripts\engine\utility::spawn_tag_origin(self getEye(), self getplayerangles());
      level._id_C41A._id_745D playSound("heistspace_fspar_spool_up", "om130_fspar_sound", 1);
      level._id_C41A._id_745D thread _id_C42F();
    }
  } else if(var_0 == "charged") {
    if(!isDefined(level._id_C41A._id_745B)) {
      level._id_C41A._id_745B = scripts\engine\utility::spawn_tag_origin(self getEye(), self getplayerangles());
      level._id_C41A._id_745B playLoopSound("heistspace_fspar_charged_lp");
      level._id_C41A._id_745B thread _id_C42F();
    }
  } else if(var_0 == "discharge") {
    if(!isDefined(level._id_C41A._id_7462)) {
      level._id_C41A._id_7462 = scripts\engine\utility::spawn_tag_origin(self getEye(), self getplayerangles());
      level._id_C41A._id_7462 playSound("heistspace_fspar_powerdown", "om130_fspar_sound", 1);
      level._id_C41A._id_7462 thread _id_C42F();
    }

    if(isDefined(level._id_C41A._id_745D)) {
      level._id_C41A._id_745D notify("om130_fspar_sound");
    }

    if(isDefined(level._id_C41A._id_745B)) {
      level._id_C41A._id_745B notify("om130_fspar_sound");
    }
  } else if(var_0 == "fire") {
    self playSound("heistspace_fspar_fire");

    if(isDefined(level._id_C41A._id_745D)) {
      level._id_C41A._id_745D notify("om130_fspar_sound");
    }

    if(isDefined(level._id_C41A._id_745B)) {
      level._id_C41A._id_745B notify("om130_fspar_sound");
    }
  }
}

_id_C42F() {
  self waittill("om130_fspar_sound");
  self stopsounds();
  wait 0.05;
  self delete();
}

_id_C463() {
  if(isDefined(level._id_C41A._id_745D)) {
    level._id_C41A._id_745D notify("om130_fspar_sound");
  }

  if(isDefined(level._id_C41A._id_745B)) {
    level._id_C41A._id_745B notify("om130_fspar_sound");
  }
}

_id_C40E() {
  scripts\engine\utility::flag_wait("om_ambient_fire_starting");
  wait 2;
  level._id_C413 thread _id_C40F();
  level._id_C413 thread _id_C410();
  level._id_C413 thread _id_C40D();
}

_id_C410() {
  while(!scripts\engine\utility::flag("om130_ending")) {
    var_0 = level._id_C41A._id_A35B.littoral_ship_lights;
    var_0 = scripts\engine\utility::array_removeundefined(var_0);
    var_0 = scripts\engine\utility::array_randomize(var_0);
    var_1 = var_0[0];
    var_2 = var_0[1];

    if(isDefined(var_1)) {
      var_3 = var_1.origin - self.origin;
      var_4 = vectorNormalize(var_3);
      var_5 = vectordot(var_4, anglestoleft(self.angles));

      if(var_5 > cos(90)) {
        thread _id_0BB6::_id_39E5("phalanx_left", var_1);
      } else {
        var_6 = self._id_129F5["phalanx_left"];

        foreach(var_8 in self.turrets) {
          foreach(var_10 in var_8) {
            if(!isDefined(var_10)) {
              continue;
            }
            if(!scripts\engine\utility::array_contains(var_6, var_10._id_AD42)) {
              continue;
            }
            var_10._id_AF58 = self._id_12A09;
            var_11 = var_10 scripts\engine\utility::spawn_tag_origin();
            var_12 = anglesToForward(self gettagangles(var_10._id_AD42)) * randomintrange(1500, 3500);
            var_13 = anglestoright(self gettagangles(var_10._id_AD42)) * randomintrange(-1000, 1000);
            var_14 = anglestoup(self gettagangles(var_10._id_AD42)) * randomintrange(100, 4000);
            var_15 = (var_12[0], var_13[1], var_14[2]);
            var_11.origin = self gettagorigin(var_10._id_AD42) + var_15;
            var_16 = 0;

            if(scripts\engine\utility::cointoss()) {
              var_16 = randomfloatrange(0, 2.5);
            }

            var_17 = randomfloatrange(2, 4);
            var_10 scripts\engine\utility::delaythread(var_16, _id_0BB6::_id_39ED, var_11, !self._id_12A09);
            var_10 thread scripts\sp\utility::_id_C12D("stop_shooting", var_17);
            var_11 scripts\engine\utility::delaycall(var_17, ::delete);
            wait 0.05;
          }
        }
      }
    }

    if(isDefined(var_2)) {
      var_3 = var_2.origin - self.origin;
      var_4 = vectorNormalize(var_3);
      var_5 = vectordot(var_4, anglestoright(self.angles));

      if(var_5 > cos(90)) {
        thread _id_0BB6::_id_39E5("phalanx_right", var_2);
      } else {
        var_6 = self._id_129F5["phalanx_right"];

        foreach(var_8 in self.turrets) {
          foreach(var_10 in var_8) {
            if(!isDefined(var_10)) {
              continue;
            }
            if(!scripts\engine\utility::array_contains(var_6, var_10._id_AD42)) {
              continue;
            }
            var_10._id_AF58 = self._id_12A09;
            var_11 = var_10 scripts\engine\utility::spawn_tag_origin();
            var_12 = anglesToForward(self gettagangles(var_10._id_AD42)) * randomintrange(1500, 3500);
            var_13 = anglestoleft(self gettagangles(var_10._id_AD42)) * randomintrange(-1000, 1000);
            var_14 = anglestoup(self gettagangles(var_10._id_AD42)) * randomintrange(1000, 4000);
            var_15 = (var_12[0], var_13[1], var_14[2]);
            var_11.origin = self gettagorigin(var_10._id_AD42) + var_15;
            var_16 = 0;

            if(scripts\engine\utility::cointoss()) {
              var_16 = randomfloatrange(0, 2.5);
            }

            var_17 = randomfloatrange(2, 4);
            var_10 scripts\engine\utility::delaythread(var_16, _id_0BB6::_id_39ED, var_11, !self._id_12A09);
            var_10 thread scripts\sp\utility::_id_C12D("stop_shooting", var_17);
            var_11 scripts\engine\utility::delaycall(var_17, ::delete);
            wait 0.05;
          }
        }
      }
    }

    wait(randomfloatrange(2, 4));
    self notify("phalanx_left_stop_attacking");
    self notify("phalanx_right_stop_attacking");
    wait(randomfloatrange(2, 4.5));
  }
}

_id_C40D() {
  while(!scripts\engine\utility::flag("om130_ending")) {
    var_0 = level._id_63E6;
    var_0 = scripts\engine\utility::array_removeundefined(var_0);
    var_0 = scripts\engine\utility::array_randomize(var_0);
    var_1 = var_0[0];
    var_2 = var_0[1];
    var_3 = [];
    var_4 = [];

    foreach(var_6 in var_0) {
      var_7 = var_6.origin - self.origin;
      var_8 = vectorNormalize(var_7);
      var_9 = vectordot(var_8, anglestoleft(self.angles));
      var_10 = vectordot(var_8, anglestoright(self.angles));

      if(var_9 > cos(90)) {
        var_3 = scripts\engine\utility::add_to_array(var_3, var_6);
        continue;
      }

      if(var_10 > cos(90)) {
        var_4 = scripts\engine\utility::add_to_array(var_4, var_6);
      }
    }

    if(isDefined(var_3[0]) && isDefined(var_3[1]) && var_3[0].health > 0 && var_3[1].health > 0) {
      thread _id_0BB6::_id_39E5("cannon_left", var_3[0], var_3[1]);
      thread _id_0BB6::_id_39E5("flak_left", var_3[0], var_3[1]);
    } else if(isDefined(var_3[0]) && var_3[0].health > 0) {
      thread _id_0BB6::_id_39E5("cannon_left", var_3[0]);
      thread _id_0BB6::_id_39E5("flak_left", var_3[0]);
    }

    if(isDefined(var_4[0]) && isDefined(var_4[1]) && var_4[0].health > 0 && var_4[1].health > 0) {
      thread _id_0BB6::_id_39E5("cannon_right", var_4[0], var_4[1]);
      thread _id_0BB6::_id_39E5("flak_right", var_4[0], var_4[1]);
    } else if(isDefined(var_4[0]) && var_4[0].health > 0) {
      thread _id_0BB6::_id_39E5("cannon_right", var_4[0]);
      thread _id_0BB6::_id_39E5("flak_right", var_4[0]);
    }

    wait(randomfloatrange(2, 4));
    self notify("cannon_left_stop_attacking");
    self notify("cannon_right_stop_attacking");
    self notify("flak_left_stop_attacking");
    self notify("flak_right_stop_attacking");
    wait(randomfloatrange(2, 4.5));
  }
}

_id_C40F() {
  while(!scripts\engine\utility::flag("om130_ending")) {
    var_0 = scripts\engine\utility::random(level._id_63E6);

    if(isDefined(var_0)) {
      var_1 = var_0.origin - self.origin;
      var_2 = length(var_1);

      if(var_2 < 75000) {
        var_3 = vectorNormalize(var_1);
        var_4 = vectordot(var_3, anglestoleft(self.angles));

        if(var_4 > cos(75)) {
          var_5 = randomintrange(1, 4);
          thread _id_0BB6::_id_399C("left_" + var_5, var_0);
        }
      }

      wait 1.0;
    }

    wait 0.05;
  }
}

_id_C439() {
  level._id_63E6 = [];
  var_0 = getEnt("om130_enemy_capital_ship_1", "targetname");
  var_1 = getEnt("om130_enemy_capital_ship_2", "targetname");
  var_2 = getEnt("om130_enemy_capital_ship_3", "targetname");
  var_3 = getEnt("om130_enemy_capital_ship_4", "targetname");
  var_0 scripts\sp\utility::_id_1747(::_id_C45F);
  var_1 scripts\sp\utility::_id_1747(::_id_C45F);
  var_2 scripts\sp\utility::_id_1747(::_id_C45F);
  var_3 scripts\sp\utility::_id_1747(::_id_C45F);
  var_0 scripts\sp\utility::_id_10808();
  var_1 scripts\sp\utility::_id_10808();
  var_2 scripts\sp\utility::_id_10808();
  var_3 scripts\sp\utility::_id_10808();
  level thread _id_6DD0();
  level thread _id_C43D();
  scripts\engine\utility::flag_wait_any("om130_fired_first_time", "player_never_shot_fspar");
  thread _id_10BD9();
}

_id_10BD9() {
  level endon("om130_ending");

  for(var_0 = 1; var_0 < 4; var_0++) {
    var_1 = getEnt("om130_enemy_capital_ship_danger_zone_" + var_0, "targetname");
    var_1._id_DF26 = 1;
    var_1 scripts\sp\utility::_id_1747(::_id_C45F);
    var_1 thread _id_C42B();
  }

  while(level._id_63E6.size > 2 && !scripts\engine\utility::flag("om130_danger_zone")) {
    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_set("start_capital_reinforcements");
}

_id_C42B() {
  scripts\engine\utility::flag_wait("om130_danger_zone");
  wait(randomfloatrange(0.05, 5.0));
  var_0 = _id_0BB8::_id_398E(self.targetname, "off", "heavy", "low");
  var_0._id_DF26 = 1;
  var_0._id_5F97 = 1;
  var_0.script_noteworthy = self.target;
  var_0.script_parameters = self.target;
  var_0._id_10CBA = getvehiclenode(self.target, "targetname");
  var_0 notify("ftl_finished");
}

_id_C45F() {
  var_0 = self;
  level._id_63E6 = scripts\engine\utility::add_to_array(level._id_63E6, var_0);
  var_0 _id_0BB8::_id_39D0("off");
  var_0 _id_0BB8::_id_39CD("idle");
  var_0 _id_0BB8::_id_39CE("low");
  var_0.name = level._id_C41A._id_6504[level._id_C41A._id_6505];
  level._id_C41A._id_6505++;

  if(level._id_C41A._id_6505 >= level._id_C41A._id_6504.size) {
    level._id_C41A._id_6505 = 0;
  }

  var_0 _id_0BB6::_id_39E1();
  var_0._id_EEF9 = "missile_tube_ca ";
  var_0._id_12FBA = 1;
  var_0 _id_0BB6::_id_39E8();
  var_1 = level._id_39DD["missile_tube_ca"];
  var_1._id_10241._id_6CF8 = ::_id_6D0D;
  var_0._id_B904 = "veh_mil_air_ca_destroyer";
  var_0._id_7470 = 1;
  var_0 dontcastshadows();
  var_0 dontcastdistantshadows();
  var_0.health = 20000 + var_0._id_8CB6;
  var_0.team = "axis";
  wait 0.1;

  if(scripts\engine\utility::is_true(var_0._id_1323C._id_DF26)) {
    var_0 waittill("ftl_finished");
  }

  var_0 thread _id_C43A();
  var_0 thread _id_C425();
  var_0._id_1323C thread _id_C458(var_0);
  var_0 thread _id_C423();
  var_0 thread _id_C457();
  var_0 thread _id_C422();
  var_0 thread _id_0BB6::_id_39E9(0);
  var_0 _meth_84BE("capitalship");
  var_2 = 0.257143;
  var_3 = 150;
  var_0 thread _id_C41B("radar_targeting_icon_destroyer", var_3 * var_2, var_3, (0.75, 0.75, 0.75), "radar_targeting_icon_brackets", (1, 1, 1));
  level.player scripts\engine\utility::waittill_notify_or_timeout("om130_fire_weapons", randomfloatrange(10.0, 20.0));
  wait 2.5;
  level notify("om130_capital_ships_attacking");
  var_0 _id_0BB8::_id_39CD("heavy");
}

_id_C425() {
  self endon("death");
  level endon("end_random_jackal_deployments");
  var_0 = getarraykeys(level._id_C413.turrets);
  scripts\engine\utility::flag_wait_any("om130_fired_first_time", "player_never_shot_fspar");

  for(;;) {
    if(distance2d(self.origin, level._id_C413.origin) < 110000 || scripts\engine\utility::is_true(self._id_5F97)) {
      var_1 = 6;

      for(var_2 = 0; var_2 < var_1; var_2++) {
        var_3 = self._id_8B4F["cap_missile_tube_ca"];
        var_4 = "vfx_hspace_seeking_missile_trail";
        thread _id_0BB6::_id_3989(level._id_C413, var_4, undefined, 1, 0);
        wait(randomfloatrange(0.15, 0.25));
      }
    }

    if(!scripts\engine\utility::is_true(self._id_5F97)) {
      wait(randomfloatrange(2.0, 4.0));
      continue;
    }

    wait 1;
  }
}

_id_6D0D(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(1) {
    var_7 = scripts\engine\utility::random(var_0);

    if(!isDefined(var_7)) {
      return;
    }
    var_8 = (0, 0, 0);
    var_9 = (0, 0, 0);
    var_10 = _id_0B76::_id_A26D(0.1, 0.15, 15, 0.1, 0.15, 15);
    var_11 = 750;
    var_12 = 1.5;
    var_13 = 0;

    foreach(var_15 in var_1) {
      var_0 = _id_0BA9::_id_DFE9(var_0);

      if(var_0.size == 0) {
        return;
      }
      var_7 = scripts\engine\utility::random(var_0);

      if(isDefined(var_7._id_24C4)) {
        var_16 = scripts\engine\utility::random(var_7._id_24C4);
        var_8 = var_7 gettagorigin(var_16);
        var_9 = var_8 - var_7.origin;
      }

      var_17 = self gettagangles(var_15.tag);
      var_17 = invertangles(var_17);
      var_18 = scripts\engine\utility::spawn_tag_origin();
      var_18.origin = self gettagorigin(var_15.tag);
      var_18.angles = var_17;

      if(isDefined(self._id_B80E)) {
        var_18.origin = var_18.origin + self._id_B80E;
      }

      var_19 = 0;

      if(isDefined(var_5) && !var_5) {
        var_19 = 1;
      }

      var_20 = 0;

      if(isDefined(var_6) && !var_6) {
        var_20 = 1;
      }

      if(isDefined(level._id_39B6) && !level._id_39B6) {
        var_20 = 1;
      }

      if(isDefined(self._id_12FB8) && self._id_12FB8) {
        var_18._id_C180 = 1;
      }

      var_18._id_AA99 = "capitalship_missile_launch";
      var_18._id_69E9 = "capitalship_missile_impact";
      var_18._id_BFEC = var_20;
      var_18._id_01CF = 16;
      var_18 thread _id_C44A();
      var_18 thread _id_0B76::_id_A332(var_7, 1, self, var_3, var_11, undefined, 0, var_4, 500, 1, var_12, var_19, var_9, var_10, 500);
      var_13 = var_13 + 1;

      if(var_13 >= var_2._id_B46E) {
        break;
      }

      if(var_13 % 4 == 0) {
        wait 0.85;
      }

      wait(var_2._id_6D20);
    }
  }

  wait(randomfloatrange(var_2._id_13535[0], var_2._id_13535[1]));
}

_id_C44A() {
  level endon("om130_ending");
  self waittill("missile_explode");
  level._id_C413 notify("missile_damage", "om130_jackal_missile");
}

_id_C423() {
  level.player endon("om130_ending");
  self waittill("death");
  level._id_63E6 = scripts\engine\utility::array_remove(level._id_63E6, self);
}

_id_C458(var_0) {
  level.player endon("om130_ending");
  level endon("om130_danger_zone");
  var_0 waittill("death");
  level._id_63E6 = scripts\engine\utility::array_remove(level._id_63E6, var_0);

  if(!scripts\engine\utility::flag("start_capital_reinforcements")) {
    scripts\engine\utility::flag_wait_or_timeout("start_capital_reinforcements", 15.0);
  }

  wait(randomfloatrange(0.5, 1.5));

  while(level._id_63E6.size > 3) {
    wait 0.5;
  }

  var_1 = getvehiclenodearray(self.script_parameters, "targetname");
  var_2 = scripts\engine\utility::random(var_1);
  self.origin = var_2.origin;
  self.angles = var_2.angles;
  scripts\engine\utility::waitframe();
  self._id_DF26 = 1;
  var_3 = _id_0BB8::_id_398E(self.targetname, "off", "heavy", "low");
  var_3._id_DF26 = 1;
  var_3.script_noteworthy = var_2.script_noteworthy;
  var_3.script_parameters = var_2.script_parameters;
  var_3._id_10CBA = var_2;
  var_3 notify("ftl_finished");
}

_id_C422() {
  self endon("death");
  self endon("entitydeleted");
  scripts\engine\utility::flag_wait("elevator_done");

  if(isDefined(self)) {
    _id_0BA9::_id_397B();
  }
}

_id_C449(var_0) {
  level endon("om130_ending");
  self waittill("explode", var_1);
  level._id_C413 notify("missile_damage", var_0);
}

_id_C41B(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  self endon("entitydeleted");
  self endon("remove_target");
  target_alloc(self);
  target_setshader(self, var_0);
  target_setminsize(self, int(var_1), 0);
  target_setmaxsize(self, int(var_2));
  target_setcolor(self, var_3, 1.0);
  target_drawonradar(self, 1);
  target_hidefromplayer(self, level.player);
  target_flush(self);
  thread _id_C456();

  if(isDefined(var_4)) {
    while(isDefined(self)) {
      self waittill("painted");

      if(scripts\engine\utility::is_true(self.painted)) {
        target_setoffscreenshader(self, var_4);
        target_setcolor(self, var_5, 1.0);
        continue;
      }

      target_setoffscreenshader(self, "");
      target_setcolor(self, var_3, 1.0);
    }
  }
}

_id_C456() {
  scripts\engine\utility::waittill_any("death", "remove_target", "entitydeleted");

  if(isDefined(self) && target_istarget(self)) {
    target_remove(self);
  }
}

_id_C457() {
  level.player waittill("om130_ending");
  self notify("remove_target");
}

_id_C43A() {
  self endon("death");
  thread _id_C437();
  var_0 = undefined;

  if(isDefined(self._id_1323C.target)) {
    var_0 = getvehiclenode(self._id_1323C.target, "targetname");
  } else if(isDefined(self._id_10CBA)) {
    var_0 = self._id_10CBA;
  } else {}

  self._id_5971 = 1;
  scripts\sp\utility::_id_65E0("reached_front");
  scripts\sp\utility::_id_65E0("reached_back");
  scripts\sp\vehicle::_id_2471(var_0);
  self _meth_8585(anglesToForward(level._id_C413.angles) * -100.0);

  if(!scripts\engine\utility::flag("om130_fired_first_time") || !scripts\engine\utility::flag("player_never_shot_fspar")) {
    self vehicle_setspeedimmediate(10, 100);
    scripts\engine\utility::flag_wait_any("om130_fired_first_time", "player_never_shot_fspar");
    wait(randomfloatrange(1.0, 3.0));
    self resumespeed(100);
  }

  for(;;) {
    self waittill("reached_dynamic_path_end");
    self notify("remove_target");
    _id_0BB8::_id_3991();
    var_1 = getvehiclenode(self.script_noteworthy, "targetname");
    self _meth_8586((0, 0, 0));
    self vehicle_teleport(var_1.origin, var_1.angles);
    _id_0BB8::_id_398C("off", "heavy", "low");
    scripts\sp\vehicle::_id_2471(var_1);
    var_2 = 0.257143;
    var_3 = 150;
    thread _id_C41B("radar_targeting_icon_destroyer", var_3 * var_2, var_3, (0.75, 0.75, 0.75), "radar_targeting_icon_brackets", (1, 1, 1));
    scripts\sp\utility::_id_65DD("reached_front");
    scripts\sp\utility::_id_65DD("reached_back");
  }
}

_id_C437() {
  level endon("om130_ending_delayed");

  for(;;) {
    self waittill("fspar");

    if(!isDefined(level._id_6DD3)) {
      level._id_6DD3 = self.script_parameters;
    } else if(!isDefined(level._id_F0A6)) {
      level._id_F0A6 = self.script_parameters;
    }

    self._id_4E09 = "destroyer_explode";
    _id_0BB6::_id_39E1();
    scripts\sp\utility::_id_9193("OM130");
    setomnvar("ui_jackal_ship_callout_0", undefined);
    setomnvar("ui_jackal_ship_callout_type_0", 0);
    level.player _meth_8578(&"", 0);
    self _meth_81D0();
    level._id_C41A._id_7470 = undefined;
    scripts\engine\utility::waitframe();

    if(isDefined(self)) {
      _id_0BA9::_id_397B();
    }
  }
}

_id_96A7() {
  var_0 = spawnStruct();
  var_0.spawner = scripts\sp\utility::_id_8200("om130_jackal_spawner", "targetname");
  var_0.attack = getcsplineidarray("om130_jackal_attack");
  var_0._id_E899 = getcsplineidarray("om130_jackal_run");
  var_0.littoral_ship_lights = [];
  var_0._id_13D88 = [];

  foreach(var_2 in var_0.spawner scripts\sp\utility::_id_7A97()) {
    var_0._id_13D88[var_0._id_13D88.size] = (var_2.origin - var_0.spawner.origin) * 6.0;
  }

  return var_0;
}

_id_C43D() {
  var_0 = getEntArray("om130_jackal_patrol_spawner", "targetname");

  foreach(var_2 in var_0) {
    if(vehicle_getarray().size < 26) {
      var_3 = 2 + randomint(2);
      var_2 thread _id_8938(var_3);
    }
  }

  scripts\engine\utility::flag_wait_any("om130_fired_first_time", "player_never_shot_fspar");
  var_5 = level._id_C41A._id_A35B.littoral_ship_lights;

  foreach(var_7 in var_5) {
    if(isDefined(var_7._id_A420)) {
      var_8 = getcsplineid(var_7.script_noteworthy);
      var_7 thread _id_0BDC::_id_A1EF(var_8);
      var_7 scripts\engine\utility::delaythread(3.0, ::_id_8937);
    }
  }

  thread _id_DC8C();
}

_id_DC8C() {
  level endon("end_random_jackal_deployments");

  for(;;) {
    if(vehicle_getarray().size < 26) {
      var_0 = 2 + randomint(2);
      level._id_C41A._id_A35B thread _id_520A(randomint(9), var_0);
    }

    wait(3 + randomfloat(3));
  }
}

_id_8938(var_0) {
  level endon("om130_fired_first_time");
  level endon("player_never_shot_fspar");
  self._id_13D88 = [];

  foreach(var_2 in scripts\sp\utility::_id_7A97()) {
    self._id_13D88[self._id_13D88.size] = (var_2.origin - self.origin) * 6.0;
  }

  var_4 = getcsplineid(self.target);
  self.origin = getcsplinepointposition(var_4, 0);
  self dontinterpolate();
  var_5 = scripts\sp\utility::_id_10808();
  var_5 _id_0BDC::_id_19A0(1);
  var_5 thread _id_C41B("radar_targeting_icon_jackal_closed_wings", 40, 40, (0.75, 0.75, 0.75), "radar_targeting_icon_brackets", (1, 1, 1));
  var_5 thread _id_0BDC::_id_A342(var_4);
  var_5 thread _id_C445(level._id_C41A._id_A35B);
  level._id_C41A._id_A35B.littoral_ship_lights[level._id_C41A._id_A35B.littoral_ship_lights.size] = var_5;

  if(var_0 > 0) {
    if(var_0 > 4) {
      var_0 = 4;
    }

    self._id_13D88 = scripts\engine\utility::array_randomize(self._id_13D88);
    var_6 = self.origin;

    for(var_7 = 0; var_7 < var_0; var_7++) {
      while(isDefined(self._id_1323B)) {
        scripts\engine\utility::waitframe();
      }

      self.origin = var_5.origin - rotatevector(self._id_13D88[var_7], (0, var_5.angles[1], 0));
      self.origin = (self.origin[0], self.origin[1], var_5.origin[2]);
      self dontinterpolate();
      var_8 = scripts\sp\utility::_id_10808();
      var_8 thread _id_C41B("radar_targeting_icon_jackal_closed_wings", 20, 20, (0.75, 0.75, 0.75), "radar_targeting_icon_brackets", (1, 1, 1));
      var_8 _id_0BDC::_id_199E(var_5);
      level._id_C41A._id_A35B.littoral_ship_lights[level._id_C41A._id_A35B.littoral_ship_lights.size] = var_8;
    }
  }

  var_5 thread _id_4C5A();
}

_id_4C5A() {
  while(!scripts\engine\utility::flag("om130_fired_first_time") && !scripts\engine\utility::flag("player_never_shot_fspar")) {
    self waittill("near_goal");
    thread _id_0C24::loop_or_delete();
  }
}

_id_8937() {
  self waittill("near_goal");
  var_0 = level._id_C41A._id_A35B.attack[randomint(level._id_C41A._id_A35B.attack.size)];
  thread _id_0BDC::_id_A1EF(var_0);
  thread _id_C446();
}

_id_520A(var_0, var_1) {
  level endon("end_random_jackal_deployments");
  var_2 = self._id_E899[var_0];
  scripts\engine\utility::flag_set("om130_first_jackals_on_radar");
  self.spawner.origin = getcsplinepointposition(var_2, 0);
  self.spawner.angles = vectortoangles(level._id_C413.origin - self.spawner.origin);
  self.spawner dontinterpolate();

  while(isDefined(self.spawner._id_1323B)) {
    scripts\engine\utility::waitframe();
  }

  var_3 = self.spawner scripts\sp\utility::_id_10808();
  var_3 thread _id_C41B("radar_targeting_icon_jackal_closed_wings", 40, 40, (0.75, 0.75, 0.75), "radar_targeting_icon_brackets", (1, 1, 1));
  var_3 thread _id_C444();
  var_3 thread _id_0BDC::_id_A342(var_2);
  var_3 thread _id_C445(self);
  self.littoral_ship_lights[self.littoral_ship_lights.size] = var_3;

  if(var_1 > 0) {
    if(var_1 > 4) {
      var_1 = 4;
    }

    self._id_13D88 = scripts\engine\utility::array_randomize(self._id_13D88);
    var_4 = self.spawner.origin;

    for(var_5 = 0; var_5 < var_1; var_5++) {
      while(isDefined(self.spawner._id_1323B)) {
        scripts\engine\utility::waitframe();
      }

      self.spawner.origin = var_3.origin - rotatevector(self._id_13D88[var_5], (0, var_3.angles[1], 0));
      self.spawner.origin = (self.spawner.origin[0], self.spawner.origin[1], var_3.origin[2]);
      self.spawner dontinterpolate();
      var_6 = self.spawner scripts\sp\utility::_id_10808();
      var_6 thread _id_C41B("radar_targeting_icon_jackal_closed_wings", 20, 20, (0.75, 0.75, 0.75), "radar_targeting_icon_brackets", (1, 1, 1));
      var_6 thread _id_C444();
      var_6 _id_0BDC::_id_199E(var_3);
      var_6 thread _id_C445(self);
      self.littoral_ship_lights[self.littoral_ship_lights.size] = var_6;
    }
  }

  var_3 scripts\engine\utility::delaythread(3.0, ::_id_8937);
}

_id_C444() {
  self endon("death");
  level endon("end_random_jackal_deployments");
  var_0 = [];
  var_0[var_0.size] = "tag_flash_right";
  var_0[var_0.size] = "tag_flash_left";
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = getarraykeys(level._id_C413.turrets);
  var_2 = 600000000;
  var_3 = 1;

  for(;;) {
    if(distance2dsquared(self.origin, level._id_C413.origin) < var_2) {
      if(var_3) {
        var_3 = 0;
        var_2 = 400000000;

        if(target_istarget(self)) {
          target_setshader(self, "radar_targeting_icon_jackal_open_wings");
        }
      } else {
        var_4 = undefined;

        if(!scripts\engine\utility::flag("fspar_down")) {
          var_5 = level._id_C413.turrets[var_1[randomint(var_1.size)]];
          var_4 = var_5[randomint(var_5.size)];
        } else if(isDefined(level._id_C413._id_24C4)) {
          var_6 = scripts\engine\utility::random(level._id_C413._id_24C4);
          var_4 = scripts\engine\utility::spawn_tag_origin(level._id_C413 gettagorigin(var_6));
          var_4 scripts\engine\utility::delaycall(6, ::delete);
        }

        if(!isDefined(var_4)) {
          wait 0.05;
          continue;
        }

        if(vectordot(anglesToForward(self.angles), var_4.origin - self.origin) <= 0.0) {
          if(scripts\engine\utility::flag("fspar_down")) {
            var_4 delete();
          }

          wait 0.05;
          continue;
        }

        if(scripts\engine\utility::cointoss()) {
          var_7 = thread _id_0B76::_id_1992("TAG_FLASH", var_4);
          var_7 thread _id_C44A();
          wait(randomfloatrange(0.5, 3.0));
        } else {
          _id_0BDC::_id_B155(6, var_4);
          wait 6;
        }
      }
    }

    wait 0.05;
  }
}

_id_E45E(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isDefined(var_3)) {
    var_5 = var_3 / var_1;
    var_4 = var_1 - var_1 * randomfloat(var_5);
  } else
    var_4 = var_1 * randomfloat(1.0);

  var_6 = randomfloat(360.0);
  var_7 = sin(var_6);
  var_8 = cos(var_6);
  var_9 = var_4 * var_8;
  var_10 = var_4 * var_7;
  var_11 = 0;

  if(isDefined(var_2)) {
    var_11 = randomfloatrange(0, var_2);
  }

  var_9 = var_9 + var_0[0];
  var_10 = var_10 + var_0[1];
  var_11 = var_11 + var_0[2];
  return (var_9, var_10, var_11);
}

_id_C446() {
  level endon("om130_ending");
  self endon("death");

  for(;;) {
    wait(randomintrange(8, 16));

    if(scripts\engine\utility::cointoss()) {
      self _meth_81D0();
    }
  }
}

_id_C445(var_0) {
  self waittill("death");
  var_0.littoral_ship_lights = scripts\engine\utility::array_remove(var_0.littoral_ship_lights, self);

  if(isDefined(self._id_A420)) {
    foreach(var_2 in self._id_A420) {
      var_2 thread _id_A62E();
    }
  }
}

_id_A62E() {
  self endon("death");
  wait 2;

  if(isDefined(self)) {
    self _meth_81D0();
  }
}

_id_5163(var_0) {
  self endon("death");

  if(isDefined(var_0)) {
    var_0 waittill("end_spline");
  } else {
    self waittill("end_spline");
  }

  self delete();
}

_id_C46F() {
  level waittill("start_ui");
  scripts\engine\utility::flag_set("om130_activating");
  wait 4.15;
  setmusicstate("mx_268_heistspace_targeting");

  while(!istransientloaded("heistspace_base_tr")) {
    wait 0.05;
    waitforalltransients();
  }

  level._id_6754 scripts\sp\utility::_id_10346("heistspace_eth_targetingisinyo");
  level thread _id_C45E();
  level thread _id_C451();
  scripts\engine\utility::flag_set("om130_intro_vo_done");
  wait 0.75;
  scripts\sp\utility::_id_1034D("heistspace_plr_gomissilesloose");
  level._id_6754 scripts\sp\utility::_id_10346("heistspace_eth_ayesir");
  level._id_EA2C scripts\sp\utility::_id_10346("heistspace_slt_weaponsaway");
  scripts\engine\utility::flag_set("om_ambient_fire_starting");
  scripts\engine\utility::flag_wait_any("om130_fired_first_time", "player_never_shot_fspar");
  level thread _id_C432();
  level thread _id_C41D();
  wait 0.75;
  thread _id_C455();
  level thread _id_C447();
  level.player waittill("om130_ending");
  scripts\engine\utility::flag_set("om130_ending");
  level._id_EA2C scripts\sp\utility::_id_10346("heistspace_slt_weaponssourhang");
  level._id_EA2C scripts\sp\utility::_id_65E1("om130_move_to_pcap");
  scripts\sp\utility::_id_1034D("heistspace_plr_ethanstatus");
  level._id_6754 thread scripts\sp\utility::_id_10346("heistspace_eth_remainingweapon");
  var_0 = lookupsoundlength("heistspace_eth_remainingweapon");
  var_0 = var_0 / 1000;
  wait(var_0 * 0.5);
  scripts\engine\utility::flag_set("mons_130_vo_end");
}

_id_C45E() {
  level endon("om130_fired_first_time");
  wait 10;
  level._id_6754 scripts\sp\utility::_id_10346("heistspace_eth_siryourefreeto");
}

_id_C451() {
  level endon("player_charging_fspar");
  wait 20;
  level._id_6754 scripts\sp\utility::_id_10346("heistspace_eth_sdfforcesareres");
  scripts\engine\utility::flag_set("player_never_shot_fspar");
}

_id_387B() {
  level endon("om130_ending");

  while(!scripts\engine\utility::is_true(level._id_C41A._id_745C)) {
    wait 0.05;
  }

  level notify("player_charging_fspar");
}

_id_C455() {
  level endon("om130_ending");

  while(level._id_C41A._id_745F < 1.0) {
    wait 0.05;
  }

  level._id_6754 scripts\sp\utility::_id_10346("heistspace_eth_cannonfullychar");
}

_id_C432() {
  level endon("om130_ending");
  wait 4;
  _id_10344("heistspace_nem_wereunderattack");
  _id_10344("heistspace_ssc_wearedetectingl");
  _id_10344("heistspace_ssc_olympusstanddow");
  _id_10344("heistspace_nem_shotsarecomingf");
  _id_10344("heistspace_ssc_allstationsolym");
  _id_10344("heistspace_val_controlweretrac");
  _id_10344("heistspace_val_multiplehullbre");
  _id_10344("heistspace_ssc_allstationsdesi");
  _id_10344("heistspace_nem_weretakingdamag");
  _id_10344("heistspace_ssc_scramblealertfi");
  _id_10344("heistspace_val_arcadiasquadron");
  _id_10344("heistspace_nem_controlweneedcl");
  _id_10344("heistspace_val_ourtargetingsys");
  _id_10344("heistspace_tha_emergencychanne");
  _id_10344("heistspace_sf1_maydaymaydaymay");
  _id_10344("heistspace_sf2_itstoobigtostop");
  _id_10344("heistspace_sf3_fireontargetisi");
  _id_10344("heistspace_sf1_sabeus21circlin");
  _id_10344("heistspace_sf2_sabeus22cannotc");
}

_id_C447() {
  wait 10;
  scripts\engine\utility::flag_set("om130_vital_vo");
  scripts\sp\utility::_id_10352("heistspace_ssc_olympusrequesti");
  level._id_EA2C scripts\sp\utility::_id_65E1("om130_chatter_01");
  level._id_EA2C scripts\sp\utility::_id_10346("heistspace_slt_theywantkotch");
  scripts\sp\utility::_id_1034D("heistspace_plr_toweractualisun");
  scripts\engine\utility::flag_clear("om130_vital_vo");
}

_id_C41D() {
  level endon("om130_ending");

  if(scripts\engine\utility::flag("om130_fired_first_time")) {
    scripts\engine\utility::flag_waitopen("om130_vital_vo");
  }

  while(level._id_C42A < 1) {
    wait 0.05;
  }

  level thread _id_1CD5();

  while(level._id_C42A < 5) {
    wait 0.05;
  }

  level._id_30F6 scripts\sp\utility::_id_65E1("om130_move_to_pcap");
  level notify("end_chatter_01");
  level thread _id_1CD6();

  while(level._id_C42A < 9) {
    wait 0.05;
  }

  level._id_A54E scripts\sp\utility::_id_65E1("om130_move_to_pcap");
  level notify("end_chatter_02");
  level thread _id_C471();
}

_id_1CD5() {
  level endon("om130_ending");
  level endon("end_chatter_01");
  level._id_6754 _id_10343("heistspace_eth_wevelostaftstar");
  level._id_A54E scripts\sp\utility::_id_65E1("om130_chatter_01");
  level._id_A54E _id_10343("heistspace_ksh_enemywarshipclo");
  level._id_6754 _id_10343("heistspace_eth_fireinbulkheads");
  level._id_30F6 scripts\sp\utility::_id_65E1("om130_chatter_01");
  level._id_30F6 _id_10343("heistspace_brk_hitsontopsidehe");
  level._id_EA2C _id_10343("heistspace_slt_theyretargeting");
  level._id_30F6 scripts\sp\utility::_id_65E1("om130_chatter_02");
  level._id_30F6 _id_10343("heistspace_brk_starboardturret");
  level._id_6754 _id_10343("heistspace_eth_switchingtoseco");
  level._id_EA2C _id_10343("heistspace_slt_secondarycicisu");
  level._id_A54E _id_10343("heistspace_ksh_setdefdefenseis");
  level._id_EA2C _id_10343("heistspace_slt_wevegottamakeou");
}

_id_1CD6() {
  level endon("om130_ending");
  level endon("end_chatter_02");
  level._id_6754 scripts\sp\utility::_id_65E1("om130_chatter_01");
  level._id_6754 _id_10343("heistspace_eth_weaponscapacity");
  level._id_EA2C _id_10343("heistspace_slt_portengineroomi");
  level._id_A54E _id_10343("heistspace_ksh_incomingskelter");
  level._id_30F6 _id_10343("heistspace_brk_criticalfailure");
  level._id_EA2C _id_10343("heistspace_slt_theyretargeting");
  level._id_30F6 _id_10343("heistspace_brk_starboardturret");
  level._id_6754 _id_10343("heistspace_eth_switchingtoseco");
  level._id_EA2C _id_10343("heistspace_slt_secondarycicisu");
  level._id_A54E _id_10343("heistspace_ksh_setdefdefenseis");
  level._id_EA2C _id_10343("heistspace_slt_wevegottamakeou");
  level._id_A54E _id_10343("heistspace_ksh_threatseast5");
  level._id_30F6 _id_10343("heistspace_brk_cannonchargeisw");
  level._id_6754 _id_10343("heistspace_eth_portsidebatteri");
  level._id_A54E _id_10343("heistspace_ksh_bandits240atone");
  level._id_30F6 _id_10343("heistspace_brk_hullintegrityis");
  level._id_A54E _id_10343("heistspace_ksh_refsouthincomin");
  level._id_6754 _id_10343("heistspace_eth_bigsignature");
  level._id_EA2C _id_10343("heistspace_slt_brace");
}

_id_C471() {
  level endon("om130_ending");
  scripts\engine\utility::flag_set("om130_vital_vo");
  level._id_6754 scripts\sp\utility::_id_65E1("om130_chatter_02");
  level._id_6754 scripts\sp\utility::_id_10346("heistspace_eth_captainweaponsc");
  level._id_EA2C scripts\sp\utility::_id_65E1("om130_chatter_02");
  level._id_EA2C scripts\sp\utility::_id_10346("heistspace_slt_shitwellneedeve");
  scripts\engine\utility::flag_clear("om130_vital_vo");

  while(level._id_C42A < 12) {
    wait 0.05;
  }

  scripts\engine\utility::flag_set("om130_vital_vo");
  level._id_30F6 scripts\sp\utility::_id_10346("heistspace_brk_ordnanceat30");
  scripts\engine\utility::flag_clear("om130_vital_vo");

  while(level._id_C42A < 14) {
    wait 0.05;
  }

  scripts\engine\utility::flag_set("om130_vital_vo");
  level._id_6754 scripts\sp\utility::_id_10346("heistspace_eth_sirshipisinrese");
  scripts\sp\utility::_id_1034D("heistspace_plr_exhausteverythi");
  scripts\engine\utility::flag_clear("om130_vital_vo");
}

_id_10344(var_0) {
  wait(randomfloatrange(3.5, 6.5));

  if(scripts\engine\utility::flag("om130_vital_vo")) {
    scripts\engine\utility::flag_waitopen("om130_vital_vo");
  }

  scripts\sp\utility::_id_10350(var_0);
}

_id_10343(var_0) {
  wait(randomfloatrange(2.5, 4.5));

  if(scripts\engine\utility::flag("om130_vital_vo")) {
    scripts\engine\utility::flag_waitopen("om130_vital_vo");
  }

  scripts\sp\utility::_id_10346(var_0);
}

_id_C420() {
  var_0 = scripts\engine\utility::getStruct("om_leave_bridge_animnode", "targetname");
  level._id_EA2C thread _id_1CD1(var_0, 1);
  level._id_6754 thread _id_1CD1(var_0, 1, 1);
  level._id_30F6 thread _id_1CD1(var_0);
  level._id_A54E thread _id_1CD1(var_0);
}

_id_1CD1(var_0, var_1, var_2) {
  self endon("move_to_pcap");
  thread scripts\sp\utility::_id_DC45("raise");
  scripts\sp\utility::_id_F415(1);
  scripts\sp\utility::_id_F416(1);
  self setgoalpos(self.origin);
  scripts\sp\utility::_id_65E0("om130_chatter_01");
  scripts\sp\utility::_id_65E0("om130_chatter_02");
  scripts\sp\utility::_id_65E0("om130_move_to_pcap");

  if(!isDefined(var_2)) {
    thread _id_1CD2(var_0);
  }

  if(scripts\engine\utility::is_true(var_1)) {
    var_0 scripts\sp\anim::_id_1F35(self, "bridge_intro");
  }

  var_0 thread scripts\sp\anim::_id_1EEA(self, "bridge_intro_loop", "end_" + self._id_1FBB + "_bridge_loop");
  scripts\engine\utility::flag_wait_any("om130_fired_first_time", "player_never_shot_fspar");

  if(scripts\engine\utility::flag("om130_fired_first_time")) {
    scripts\engine\utility::flag_set("om130_vital_vo");
    var_0 notify("end_" + self._id_1FBB + "_bridge_loop");
    var_0 scripts\sp\anim::_id_1F35(self, "bridge_fspar_react");
    scripts\engine\utility::flag_clear("om130_vital_vo");
    var_0 thread scripts\sp\anim::_id_1EEA(self, "bridge_intro_loop", "end_" + self._id_1FBB + "_bridge_loop");
  }

  scripts\sp\utility::_id_65E3("om130_chatter_01");
  var_0 notify("end_" + self._id_1FBB + "_bridge_loop");
  var_0 scripts\sp\anim::_id_1F35(self, "bridge_chatter_01");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "bridge_intro_loop", "end_" + self._id_1FBB + "_bridge_loop");
  scripts\sp\utility::_id_65E3("om130_chatter_02");
  var_0 notify("end_" + self._id_1FBB + "_bridge_loop");
  var_0 scripts\sp\anim::_id_1F35(self, "bridge_chatter_02");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "bridge_intro_loop", "end_" + self._id_1FBB + "_bridge_loop");
}

_id_1CD2(var_0) {
  scripts\sp\utility::_id_65E3("om130_move_to_pcap");
  self notify("move_to_pcap");
  var_0 notify("end_" + self._id_1FBB + "_bridge_loop");
  var_0 scripts\sp\anim::_id_1F35(self, "bridge_move_to_pcap");
  var_0 scripts\sp\anim::_id_1EC3(self, "bridge_pcap");
}

_id_C421(var_0) {
  if(!scripts\engine\utility::is_true(var_0)) {
    level waittill("olympus_damaged");
  }

  scripts\engine\utility::exploder("vfx_amb_bridge_damage");

  if(!scripts\engine\utility::is_true(var_0)) {
    while(!isDefined(level._id_C42A)) {
      wait 0.05;
    }

    while(level._id_C42A < 11) {
      wait 0.05;
    }
  }

  scripts\engine\utility::exploder("vfx_amb_bridge_damage_2");

  if(!scripts\engine\utility::is_true(var_0)) {
    while(level._id_C42A < 19) {
      wait 0.05;
    }

    scripts\engine\utility::exploder("vfx_ord_expl");
  }

  scripts\engine\utility::flag_wait("elevator_can_move");
  scripts\sp\utility::_id_10FEC("vfx_amb_bridge_damage");
  scripts\sp\utility::_id_10FEC("vfx_amb_bridge_damage_2");
}

_id_6DD0() {
  level endon("om130_ending");
  scripts\engine\utility::flag_wait("om130_fired_first_time");
  scripts\engine\utility::exploder("vfx_dest_debris");
}

_id_B394() {
  var_0 = getEntArray("heistspace_stage1", "targetname");
  var_1 = scripts\engine\utility::getStruct("heistspace_mars_start", "targetname");
  var_2 = scripts\engine\utility::getStruct("heistspace_mars_end", "targetname");
  var_3 = scripts\engine\utility::getStruct("heistspace_shipyard_start", "targetname");
  var_4 = scripts\engine\utility::getStruct("heistspace_shipyard_end", "targetname");
  var_5 = undefined;
  var_6 = undefined;

  foreach(var_8 in var_0) {
    if(isDefined(var_8.script_noteworthy) && var_8.script_noteworthy == "mars") {
      var_5 = var_8 scripts\engine\utility::spawn_tag_origin();
    }

    if(isDefined(var_8.script_noteworthy) && var_8.script_noteworthy == "shipyard_model") {
      var_6 = var_8 scripts\engine\utility::spawn_tag_origin();
    }
  }

  foreach(var_8 in var_0) {
    if(isDefined(var_8.script_noteworthy)) {
      switch (var_8.script_noteworthy) {
        case "mars":
          var_8 linkTo(var_5);
          break;
        case "mars_glow":
          var_8 linkTo(var_5);
          break;
        case "shipyard_model":
          level._id_C41A._id_FE37 = var_8;
          level._id_C41A._id_FE37.offset = 10000;
          level._id_C41A._id_FE37._id_C368 = scripts\engine\utility::spawn_tag_origin(level._id_C41A._id_FE37.origin + anglestoup(level._id_C41A._id_FE37.angles) * level._id_C41A._id_FE37.offset, level._id_C41A._id_FE37.angles);
          level._id_C41A._id_FE37._id_C368.name = &"HEIST_SDF_SHIPYARD";
          level._id_C41A._id_FE37 thread _id_C46C();
          var_8 linkTo(var_6);
          break;
        case "shipyard_capitalship":
          var_8 linkTo(var_6);
          break;
        default:
          break;
      }
    }
  }

  scripts\engine\utility::waitframe();
  var_5 moveTo(var_1.origin, 0.05);
  var_6 moveTo(var_3.origin, 0.05);
  var_6 rotateTo(var_3.angles, 0.05);
  scripts\engine\utility::flag_wait("move_mars");
  var_5 moveTo(var_2.origin, 45);
  var_6 moveTo(var_4.origin, 45);
  var_6 rotateTo(var_4.angles, 45);
  wait 50;
  var_5 delete();
  var_6 delete();
}

_id_EB49() {
  var_0 = getEntArray("intro_satellite", "targetname");
  var_1 = undefined;
  var_2 = scripts\engine\utility::getStruct("intro_satellite_start", "targetname");
  var_3 = scripts\engine\utility::getStruct("intro_satellite_end", "targetname");

  foreach(var_5 in var_0) {
    if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == "body") {
      var_1 = var_5 scripts\engine\utility::spawn_tag_origin();
    }
  }

  foreach(var_5 in var_0) {
    var_5 linkTo(var_1);
  }

  wait 0.05;
  var_1 moveTo(var_2.origin, 0.05);
  var_1 rotateTo(var_2.angles, 0.05);
  wait 0.25;
  var_1 moveTo(var_3.origin, 10);
  var_1 rotateTo(var_3.angles, 10);
  wait 15;
  var_1 delete();
  scripts\sp\utility::_id_228A(var_0);
}