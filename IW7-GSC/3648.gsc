/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3648.gsc
**************************************/

_id_F9B6() {
  precacheitem("magic_spaceship_20mm_bullet");
  precacheitem("iw7_jackal_support_designator");
  precachemodel("viewmodel_base_viewhands_iw7_noleftarm");
  precacheshader("veh_hud_diamond");
  precacheshader("overlay_static");
  precacheshader("blank");
  _id_F9B4();
  _id_A072();
  scripts\engine\utility::flag_init("streak_cooling_down");
  scripts\engine\utility::flag_init("special_jackal_streak_path");
  scripts\engine\utility::flag_init("change_jackal_direction");
  scripts\engine\utility::flag_init("bugging_out");
  scripts\engine\utility::flag_init("jackal_shooting");
  scripts\engine\utility::flag_init("jackal_successful_call");
  scripts\engine\utility::flag_init("stop_jackal_call");
  scripts\engine\utility::flag_init("player_has_used_designator");
  scripts\engine\utility::flag_init("jackal_cooldown_updated");
  scripts\engine\utility::flag_init("jackal_streak_spawned");
  thread _id_A353();
  level._id_110E2 = getEnt("jackal_streak_spawner", "targetname");
  level._id_110E2._id_ED17 = 0;
  createthreatbiasgroup("streak_jackal");
  level._effect["jackal_streak_ring"] = loadfx("vfx/iw7/core/ui/vfx_ui_ring_radius_marker.vfx");
  level._id_1093E = getEntArray("special_case_volume", "targetname");
  scripts\sp\utility::_id_9187("jackalStreakTargeting", 50);
  scripts\sp\utility::_id_9187("jackalStreakFiring", -1, ::_id_A1C6);
}

_id_F9B4() {
  level._id_A29E = [];
  level._id_A29E["cooldown"] = undefined;
  level._id_A29E["FOV"] = undefined;
  level._id_A29E["max_enemies"] = undefined;
  level._id_A29E["accuracy"] = undefined;
  level._id_A29E["max_time_up"] = undefined;
  level._id_A29E["max_target_dist"] = undefined;
  level._id_A29E["min_target_dist"] = undefined;
  level._id_A29E["bDontFindMore"] = undefined;
}

#using_animtree("jackal");

_id_A072() {
  level._id_EC85["jackal"]["streak_arrive"] = % ph_hill400_jackal_support_jackal;
  scripts\sp\anim::_id_17F6("jackal", "start_fire", ::_id_A0CE);
}

_id_A0CE(var_0) {
  scripts\engine\utility::flag_set("jackal_shooting");

  if(!isDefined(level._id_A0BB)) {
    level._id_A0BB = 0;
  }

  var_0 scripts\sp\utility::_id_9196(6, 0, 1, "jackalStreakFiring");

  if(level._id_A0BB == 0) {
    level.player scripts\sp\utility::_id_10350("dps_s31_shotsoutshotsou");
  } else {
    level.player scripts\sp\utility::_id_10350("dps_s31_gunsgunsguns");
  }

  var_0 _id_0BDC::_id_19AE("shoot_now");
  wait 0.1;
  var_0 thread _id_0BDC::_id_B155(60, undefined, undefined, 0.05);
  var_1 = "jackal_streak_gatling_fire";
  var_0 thread scripts\sp\utility::play_loop_sound_on_tag(var_1, "tag_spotlight", 1, 1, "jackal_streak_gatling_release");
}

_id_1074A() {
  scripts\engine\utility::flag_set("jackal_streak_spawned");
  scripts\engine\utility::flag_set("streak_cooling_down");
  _id_4162();
  _id_6C92();
  setomnvar("ui_jackal_cooldown_done", 2);

  if(!isDefined(level._id_A0BB)) {
    level._id_A0BB = 0;
  }

  if(level._id_A0BB == 0) {
    level.player scripts\sp\utility::_id_10350("phstreets_plr_requestforfiret");
    level.player thread scripts\sp\utility::_id_10350("dps_s31_rogertargetacqu");
  } else {
    level.player scripts\sp\utility::_id_10350("phstreets_plr_31targetmarked");
    level.player thread scripts\sp\utility::_id_10350("dps_s31_rogerinboundfor");
  }

  setomnvar("ui_active_targets", 0);
  level._id_A351 = level._id_110E2 scripts\sp\utility::_id_10808();
  level._id_A351 scripts\sp\vehicle::_id_8441();
  level._id_A351 setCanDamage(0);
  level._id_A351 scripts\sp\utility::_id_F2A8(0);
  level._id_A351 thread _id_A225();
  level._id_A351._id_1FBB = "jackal";
  thread _id_A352();
  scripts\sp\vehicle_build::_id_31C6("script_vehicle_jackal_friendly", "default", "vfx/iw7/core/vehicle/jackal/vfx_jackal_wash_metal.vfx", 1);

  if(scripts\engine\utility::flag("special_jackal_streak_path")) {
    level._id_A351 thread _id_110E3();
    level._id_A351 thread _id_1093D();
    level._id_A351 thread _id_A12C();
    return;
  }

  level._id_A351 thread _id_110E3();
  level._id_A351 thread _id_110DD();
  level._id_A351 thread _id_A12C();
  level._id_A351 setthreatbiasgroup("streak_jackal");
  setthreatbias("axis", "streak_jackal", 1000);
}

_id_A352() {
  level._id_A351 endon("death");

  while(isDefined(level.player._id_20F8)) {
    wait 0.15;
  }

  level._id_A351 scripts\sp\utility::_id_918B("ar_callouts_unsa_jackal", 1, (0, 0, 0));
  level._id_A351 scripts\sp\utility::_id_9196(6, 1, 0, "default");
}

_id_6C92() {
  if(!isDefined(level._id_1093E) || level._id_1093E.size == 0) {
    return;
  }
  var_0 = 0;

  foreach(var_2 in level._id_1093E) {
    var_2._id_63A2 = 0;
  }

  var_4 = level._id_1312F;
  var_4 = _id_110DE(var_4);

  foreach(var_6 in var_4) {
    var_7 = 0;

    foreach(var_2 in level._id_1093E) {
      if(isalive(var_6) && var_6 istouching(var_2)) {
        var_2._id_63A2++;
        var_7 = 1;
        break;
      }
    }

    if(var_7 == 0) {
      var_0++;
    }
  }

  var_11 = scripts\engine\utility::array_sort_with_func(level._id_1093E, ::_id_1041C);

  if(var_11[0]._id_63A2 > var_0) {
    scripts\engine\utility::flag_set("special_jackal_streak_path");
    level._id_10949 = scripts\engine\utility::getStruct(var_11[0].target, "targetname");
    return;
  } else {
    scripts\engine\utility::flag_clear("special_jackal_streak_path");
    level._id_10949 = undefined;
    return;
  }
}

_id_1041C(var_0, var_1) {
  return var_0._id_63A2 > var_1._id_63A2;
}

_id_A232() {
  self endon("death");
  self endon("bugging_out");
  _id_0BDC::_id_19B0("fly");
  self.goalradius = 96;
  _id_0BDC::_id_19AB(110, 200, 200, 200);
  var_0 = scripts\engine\utility::getStructArray("jackal_streak_node", "targetname");
  var_1 = scripts\engine\utility::spawn_tag_origin();
  var_0 = var_1 _id_6CA2(var_0);
  scripts\engine\utility::delaycall(0.6, ::playsound, "jackal_un_streak_sfx_start");
  scripts\engine\utility::delaycall(1.6, ::playloopsound, "jackal_un_streak_sfx_lp");
  level.player setsoundsubmix("jackal_strafe");
  var_1 scripts\sp\anim::_id_1F35(self, "streak_arrive");
  thread _id_A0CE(self);
  _id_0BDC::_id_19B0("hover");
  _id_0BDC::_id_19AB(40, 40, 200, 200);
  scripts\engine\utility::delaycall(0.85, ::playsound, "jackal_un_streak_sfx_stop");
  scripts\engine\utility::delaycall(1.35, ::stoploopsound, "jackal_un_streak_sfx_lp");
  level.player scripts\engine\utility::delaycall(0.1, ::clearsoundsubmix);
  _id_0BDC::_id_A1EC(var_0[0].origin, 0);
  var_1 delete();
  return var_0;
}

_id_6CA2(var_0) {
  self.angles = level.player.angles;
  self.origin = anglesToForward(level.player.angles) * 512;

  if(scripts\engine\utility::cointoss()) {
    self.origin = anglestoleft(self.angles) * 2048;
    self.origin = self.origin + (0, 0, 512);
  } else {
    self.origin = anglestoright(self.angles) * 2048;
    self.origin = self.origin + (0, 0, 512);
  }

  var_0 = sortbydistance(var_0, self.origin);
  self.origin = var_0[0].origin;
  level._id_1312F = sortbydistance(level._id_1312F, self.origin);
  var_1 = level._id_1312F[0].origin;
  var_2 = (var_1[0], var_1[1], self.origin[2]) - self.origin;
  var_3 = vectortoangles(var_2);
  self.angles = var_3;
  return var_0;
}

_id_A12C() {
  level.player endon("remove_jackal_weapon");
  level.player thread _id_10FD5();
  scripts\engine\utility::waittill_any("death", "bugging_out");
  level._id_1312F = [];
  setomnvar("ui_jackal_cooldown_done", 0);

  if(isDefined(level._id_A29E["cooldown"])) {
    _id_110DF(level._id_A29E["cooldown"]);
  } else {
    _id_110DF(30);
  }

  scripts\engine\utility::flag_clear("streak_cooling_down");
  level.player notify("jackal_ready");

  if(getdvarint("e3", 0)) {
    if(!isDefined(level._id_A354)) {
      level.player thread scripts\sp\utility::_id_10350("dps_s31_31onstationavai");
      level._id_A354 = 1;
    }
  } else
    level.player thread scripts\sp\utility::_id_10350("dps_s31_31onstationavai");
}

_id_110DF(var_0) {
  var_1 = var_0 / 0.05;
  var_2 = 0.05;
  var_3 = 0;
  var_4 = 0;
  setomnvar("ui_jackal_meter", 0);

  for(var_5 = 1; var_5 < var_1; var_5++) {
    if(scripts\engine\utility::flag("jackal_cooldown_updated")) {
      scripts\engine\utility::flag_clear("jackal_cooldown_updated");
      var_6 = level._id_A29E["cooldown"] / 0.05;
      var_7 = var_1 - var_5;

      if(var_7 < var_6) {} else
        var_1 = var_6;
    }

    var_3 = scripts\sp\math::_id_6A8E(0, 1, scripts\sp\math::_id_C097(0, var_1, var_5));
    wait(var_2);
    var_4 = var_4 + var_2;

    if(var_3 >= 1) {
      setomnvar("ui_jackal_meter", 1);
      break;
    } else
      setomnvar("ui_jackal_meter", var_3);
  }
}

_id_A2D6() {
  while(!scripts\engine\utility::flag("stop_jackal_call")) {
    scripts\engine\utility::flag_waitopen("streak_cooling_down");
    thread _id_A234();
    thread _id_418D();
    scripts\engine\utility::flag_wait("streak_cooling_down");
    level.player _meth_8497();
  }
}

_id_418D() {
  level endon("streak_cooling_down");
  level.player waittill("death");
  wait 0.1;
  level.player _meth_8497();
  visionsetnaked("", 1);
  setomnvar("ui_jackal_call_down_active", 0);
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    var_2 scripts\sp\utility::_id_9193("jackalStreakTargeting");
  }
}

_id_A234() {
  level.player endon("remove_jackal_weapon");
  level.player endon("death");
  level endon("streak_cooling_down");
  var_0 = 12;
  var_1 = 15;
  scripts\engine\utility::flag_waitopen("stop_jackal_call");
  thread _id_A0B2();
  var_2 = ["phstreets_s31_thisis31waitin", "phstreets_s31_inpositionforgun", "phstreets_s31_readyforreattack", "phstreets_s31_scar1therestoomuch"];
  wait 1;

  for(;;) {
    foreach(var_4 in var_2) {
      if(isDefined(level.player._id_9E1C) && level.player._id_9E1C) {
        scripts\sp\utility::_id_DBF5();
        level waittill("unpause_jackal_streak_message");
        wait 3;
        continue;
      }

      if(!scripts\engine\utility::flag("player_has_used_designator")) {
        thread _id_12FC1();
        level.player thread scripts\sp\utility::_id_10350(var_4);
        wait(randomfloatrange(var_0, var_1));
        continue;
      }

      level.player thread scripts\sp\utility::_id_10350(var_4);
      wait(randomfloatrange(var_0, var_1));
    }
  }
}

_id_12FC1() {
  level.player endon("remove_jackal_weapon");
  level.player endon("death");
  level endon("streak_cooling_down");
  wait 1;

  if(!scripts\engine\utility::flag("player_has_used_designator")) {
    level.player _meth_8496(&"PHSTREETS_USE_JACKAL_TARGETING");
    level scripts\engine\utility::waittill_any_timeout(4, "player_has_used_designator", "pause_jackal_streak_message");
    level.player _meth_8497();
  }
}

_id_A0B2() {
  level.player endon("remove_jackal_weapon");
  level.player endon("death");
  level endon("streak_cooling_down");

  for(;;) {
    scripts\engine\utility::flag_wait("player_has_used_designator");
    level.player _meth_8497();
    wait 1;

    while(scripts\engine\utility::flag("player_has_used_designator")) {
      if(level._id_1312F.size <= 0) {
        level.player _meth_8497();
      } else {
        level.player _meth_8496(&"PHSTREETS_JACKAL_TARGET_FIRE");
      }

      wait 0.1;
    }

    scripts\engine\utility::flag_waitopen("player_has_used_designator");
    level.player _meth_8497();
  }
}

_id_10FD5() {
  while(scripts\engine\utility::flag("streak_cooling_down") || scripts\engine\utility::flag("stop_jackal_call")) {
    scripts\engine\utility::waittill_any("weapon_change", "weapon_dropped", "jackal_ready");

    if(issubstr(self getcurrentweapon(), "iw7_jackal_support_designator") && (scripts\engine\utility::flag("streak_cooling_down") || scripts\engine\utility::flag("stop_jackal_call"))) {
      level.player switchtoweapon(level.player._id_4C14);
      level.player playSound("jackal_support_not_ready");
    }
  }

  setomnvar("ui_jackal_cooldown_done", 1);
}

_id_110DD() {
  self endon("death");
  self endon("bugging_out");
  var_0 = 16;
  thread _id_10D33(var_0);
  _id_0BDC::_id_19AA("spaceship_cannon_projectile");
  var_1 = _id_A232();
  self notify("arrived");

  if(isDefined(level._id_A29E["max_time_up"])) {
    thread _id_0BDC::_id_B155(level._id_A29E["max_time_up"], undefined, undefined, 0.05);
  } else {
    thread _id_0BDC::_id_B155(8, undefined, undefined, 0.05);
  }

  var_2 = "jackal_streak_gatling_fire";
  thread scripts\sp\utility::play_loop_sound_on_tag(var_2, "tag_spotlight", 1, 1, "jackal_streak_gatling_release");
  var_3 = 1;

  if(scripts\engine\utility::cointoss()) {
    var_3 = 0;
  }

  _id_0BDC::_id_19AB(20, 20, 25, 5);
  var_4 = 96;

  for(;;) {
    if(var_3) {
      var_5 = _id_6C97(1, var_1);
      _id_0BDC::_id_A1EC(var_5.origin + (0, 0, var_4), 0);
    } else {
      var_5 = _id_6C97(0, var_1);
      _id_0BDC::_id_A1EC(var_5.origin + (0, 0, var_4), 0);
    }

    var_1 = sortbydistance(var_1, var_5.origin);
  }
}

_id_1093D() {
  self endon("death");
  self endon("bugging_out");
  self.goalradius = 500;
  var_0 = level._id_10949;
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  _id_0BDC::_id_19AB(20, 20, 25, 5);
  _id_0BDC::_id_19B0("hover");
  scripts\engine\utility::delaycall(0.6, ::playsound, "jackal_un_streak_sfx_start");
  scripts\engine\utility::delaycall(1.6, ::playloopsound, "jackal_un_streak_sfx_lp");
  level.player setsoundsubmix("jackal_strafe");
  var_0 scripts\sp\anim::_id_1F35(self, "streak_arrive");
  thread _id_A0CE(self);
  self notify("arrived");

  if(isDefined(level._id_A29E["max_time_up"])) {
    thread _id_10D33(level._id_A29E["max_time_up"]);
  } else {
    thread _id_10D33(8);
  }

  while(scripts\engine\utility::flag("special_jackal_streak_path")) {
    _id_0BDC::_id_A1EC(var_1.origin, 0);

    if(!isDefined(var_1.target)) {
      break;
    }

    var_1 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  }

  thread bufferedweapons();
}

find_closest_path_struct() {
  var_0 = sortbydistance(level._id_1312F, level.player.origin);
  return var_0[0].origin;
}

_id_110E3() {
  self endon("death");
  self endon("bugging_out");
  var_0 = getaiarray("axis");

  foreach(var_3, var_2 in var_0) {
    if(var_2 scripts\sp\vehicle::_id_9FEF()) {
      continue;
    }
    var_2 thread _id_A360(self, var_3);

    if(var_2.classname != "actor_enemy_c6_ar") {
      var_2 thread _id_A2CF(self);
    }
  }

  var_4 = "tag_flash";
  var_5 = anglesToForward(self gettagangles(var_4)) * 250;
  var_6 = self gettagorigin(var_4) + var_5;
  self._id_11531 = scripts\engine\utility::spawn_tag_origin(var_6);
  self._id_11531 linkTo(self);
  self._id_11531.team = "axis";
  _id_0BDC::_id_19B5(self._id_11531);
  var_7 = undefined;
  level._id_1312F = _id_110DE(level._id_1312F);
  level._id_1312F = sortbydistance(level._id_1312F, self.origin);

  if(isDefined(level._id_A29E["accuracy"])) {
    var_8 = level._id_A29E["accuracy"];
  } else {
    var_8 = 0.1;
  }

  level._id_1312F = _id_10428(level._id_1312F);
  thread _id_6D3D();

  foreach(var_10 in level._id_1312F) {
    if(isDefined(var_10.model) && var_10.model == "veh_mil_air_ca_dropship") {
      var_7 = var_10.origin;
      self._id_4BC7 = var_10;
      thread _id_A38B(var_10);
      _id_A38A(var_10);
    } else if(isalive(var_10)) {
      var_7 = var_10.origin;
      self._id_4BC7 = var_10;
      self notify("new_missile_target");

      while(isalive(var_10)) {
        var_7 = var_10.origin + (0, 0, 80);
        var_11 = var_10.origin + (0, 0, 80) - self.origin;
        var_12 = vectortoangles(var_11);
        _id_0BDC::_id_19B2("face angle", var_12);
        wait(var_8);
      }
    }

    if(isDefined(level._id_A29E["bDontFindMore"])) {
      continue;
    }
    if(!isDefined(var_7)) {
      var_7 = level._id_114F0;
    }

    thread _id_6CBB(var_7);
  }

  thread bufferedweapons();
}

_id_A38A(var_0) {
  self endon("death");
  self endon("bugging_out");
  self notify("fighting_dropship");
  level notify("jackal_v_dropship");
  self waittill("arrived");

  if(!isDefined(var_0._id_110E4)) {
    var_1 = ["j_wing_front_le", "j_wing_mid_le", "j_wing_front_ri", "j_wing_mid_ri"];
    var_2 = [];

    foreach(var_4 in var_1) {
      var_5 = scripts\engine\utility::spawn_tag_origin(var_0 gettagorigin(var_4));
      var_5 linkTo(var_0, var_4);
      var_5.script_noteworthy = var_4;
      var_2[var_2.size] = var_5;
    }

    var_0._id_110E4 = var_2;
    var_0 thread _id_4031();
  } else
    var_2 = var_0._id_110E4;

  self notify("new_missile_target");
  self notify("stop soundjackal_streak_gatling_fire");
  self notify("stop_MG_magic");

  while(isalive(var_0)) {
    var_2 = sortbydistance(var_2, self.origin);
    _id_0B76::_id_1992("TAG_FLASH_right", var_2[0]);
    var_7 = scripts\engine\utility::waittill_any_timeout(2, "missile_explode");

    if(var_7 == "missile_explode") {
      var_0 _id_0BBD::_id_D973(var_2[0].script_noteworthy, 750, undefined);
    }

    wait(randomfloatrange(0.7, 1));
  }

  bufferedweapons();
}

_id_4031() {
  var_0 = self._id_110E4;
  scripts\engine\utility::waittill_any("death", "delete");

  foreach(var_2 in var_0) {
    var_2 delete();
  }
}

_id_A38B(var_0) {
  self endon("death");
  self endon("bugging_out");
  var_1 = 0.1;

  while(isalive(var_0)) {
    var_2 = var_0.origin + (0, 0, 80);
    var_3 = var_0.origin + (0, 0, 80) - self.origin;
    var_4 = vectortoangles(var_3);
    _id_0BDC::_id_19B2("face angle", var_4);
    wait(var_1);
  }
}

_id_10428(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = [];

  foreach(var_5 in var_0) {
    if(var_5 scripts\sp\vehicle::_id_9FEF()) {
      var_2[var_2.size] = var_5;
      continue;
    }

    var_1[var_1.size] = var_5;
  }

  foreach(var_8 in var_2) {
    var_3[var_3.size] = var_8;
  }

  foreach(var_11 in var_1) {
    var_3[var_3.size] = var_11;
  }

  return var_3;
}

_id_6CBB(var_0) {
  self endon("death");
  self endon("bugging_out");
  level._id_1312F = [];
  var_1 = getaiarray("axis");
  var_1 = _id_110DE(var_1);
  var_2 = scripts\sp\utility::_id_81FF();
  var_2 = _id_10432(var_2);
  var_1 = scripts\sp\utility::_id_22A2(var_1, var_2);
  var_1 = sortbydistance(var_1, var_0);
  var_3 = 1024;

  foreach(var_5 in var_1) {
    if(isDefined(var_5.model) && var_5.model == "veh_mil_air_ca_dropship") {
      continue;
    }
    var_6 = distance2d(var_5.origin, var_0);

    if(distance2d(var_5.origin, var_0) <= var_3) {
      level._id_1312F[level._id_1312F.size] = var_5;
      continue;
    }

    break;
  }

  if(level._id_1312F.size > 0) {
    thread _id_110E3();
  } else {
    self notify("no_more_targets");
  }
}

_id_10432(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(var_3.team) && var_3.team == "axis") {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

_id_A2CF(var_0) {
  var_0 endon("death");
  var_0 endon("bugging_out");
  self endon("death");
  self._id_10265 = 1;
  self.forceragdollimmediate = 1;

  while(isalive(self)) {
    self waittill("damage", var_1, var_1, var_1, var_1, var_1, var_1, var_1, var_1, var_1, var_2);

    if(isDefined(var_2) && var_2 == "magic_spaceship_20mm_bullet") {
      if(isDefined(self._id_71C8)) {
        self[[self._id_71C8]]();
      }

      if(isalive(self)) {
        self._id_4E46 = ::jackal_ragdoll_deathfunc;
        self _meth_81D0();
      }
    }
  }
}

jackal_ragdoll_deathfunc() {
  self _meth_839B("torso_lower", vectorNormalize(level._id_A351.origin - self.origin) * 1200);
  return 1;
}

_id_A360(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("bugging_out");
  thread _id_A361(var_0, var_1);

  while(isDefined(self) && isalive(self)) {
    self waittill("damage", var_2, var_2, var_2, var_2, var_2, var_2, var_2, var_2, var_2, var_3);

    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3 != "spaceship_ai_30mm_projectile" && var_3 != "spaceship_homing_missile" && var_3 != "magic_spaceship_20mm_bullet") {
      continue;
    }
    level.player thread scripts\sp\damagefeedback::updatedamagefeedback("standard", 1, 1, "high_damage", self);
  }
}

_id_A361(var_0, var_1) {
  var_0 endon("death");
  self waittill("death", var_2, var_3, var_4);

  if(!isDefined(var_4)) {
    return;
  }
  if(var_4 != "spaceship_ai_30mm_projectile" && var_4 != "spaceship_homing_missile" && var_4 != "magic_spaceship_20mm_bullet") {
    return;
  }
  level.player thread scripts\sp\damagefeedback::updatedamagefeedback("standard", 1, 1, "high_damage", self);
  var_5 = scripts\engine\utility::spawn_tag_origin();
  var_5.origin = self.origin;
  setomnvar("ui_reticles_" + var_1 + "_target_ent", var_5);
  setomnvar("ui_reticles_" + var_1 + "_lock_state", 1);
  thread _id_A362(var_0, var_5, var_1);
}

_id_A362(var_0, var_1, var_2) {
  var_0 waittill("bugging_out");
  wait(randomfloatrange(1, 2));
  setomnvar("ui_reticles_" + var_2 + "_target_ent", undefined);
  setomnvar("ui_reticles_" + var_2 + "_lock_state", 0);
  var_1 delete();
}

_id_6D3D() {
  self endon("death");
  self endon("bugging_out");
  self endon("fighting_dropship");
  self waittill("arrived");
  wait 3;

  for(;;) {
    var_0 = [];

    foreach(var_2 in level._id_1312F) {
      if(isDefined(var_2)) {
        var_0[var_0.size] = var_2;
      }
    }

    var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);
    var_0 = sortbydistance(var_0, level.player.origin);
    var_2 = var_0[var_0.size - 1];

    if(distance2d(var_2.origin, level.player.origin) > 750) {
      self notify("stop soundjackal_streak_gatling_fire");
      self notify("stop_MG_magic");
      scripts\engine\utility::waitframe();
      _id_0B76::_id_1992("TAG_FLASH_right", var_2, 1);
      self waittill("missile_explode");

      if(isDefined(level._id_A29E["max_time_up"])) {
        thread _id_0BDC::_id_B155(level._id_A29E["max_time_up"], undefined, undefined, 0.05);
      } else {
        thread _id_0BDC::_id_B155(8, undefined, undefined, 0.05);
      }

      var_4 = "jackal_streak_gatling_fire";
      thread scripts\sp\utility::play_loop_sound_on_tag(var_4, "tag_spotlight", 1, 1, "jackal_streak_gatling_release");
      wait(randomfloatrange(3, 7));
      continue;
    }

    wait 0.5;
  }
}

_id_B82D(var_0) {
  self endon("death");
  var_0 endon("death");
  var_1 = "tag_flash";

  for(;;) {
    var_2 = anglesToForward(self gettagangles(var_1)) * 250;
    var_3 = self gettagorigin(var_1) + (var_2 - (0, 0, 90));
    var_4 = var_0.origin;

    if(scripts\common\trace::ray_trace_passed(var_3, var_4)) {
      _id_0B76::_id_1992("TAG_FLASH_right", var_0);
    }

    wait(randomfloatrange(4, 7));
  }
}

_id_7CB7(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_2 == 0) {
      var_1[var_2] = var_0[0];
      continue;
    }

    var_1[var_2] = ::scripts\engine\utility::getStruct(var_1[var_2 - 1].target, "targetname");
  }

  return var_1;
}

_id_10D33(var_0) {
  self endon("death");
  self endon("bugging_out");
  scripts\engine\utility::waittill_any_timeout(var_0, "no_more_targets", "no_more_nodes");
  thread bufferedweapons();
}

bufferedweapons() {
  scripts\engine\utility::flag_clear("jackal_shooting");
  self notify("bugging_out");
  scripts\sp\utility::_id_9193("jackalStreakFiring");
  scripts\sp\utility::_id_918C();
  thread bug_out();
  var_0 = anglesToForward(level.player getplayerangles()) * 38000;
  var_1 = self gettagorigin("tag_flash") + (var_0 - (0, 0, -10000));
  self notify("stop soundjackal_streak_gatling_fire");
  self notify("stop_MG_magic");
  self._id_11531 delete();
  thread _id_0BDC::_id_19AE("dont_shoot");
  _id_0BDC::_id_198A();
  _id_0BDC::_id_19B2("face motion");
  _id_0BDC::_id_19AB(400, 100, 200, 200);
  scripts\engine\utility::flag_set("bugging_out");
  wait 0.05;
  scripts\engine\utility::delaycall(0.85, ::playsound, "jackal_un_streak_sfx_stop");
  scripts\engine\utility::delaycall(1.35, ::stoploopsound, "jackal_un_streak_sfx_lp");
  level.player scripts\engine\utility::delaycall(0.1, ::clearsoundsubmix);
  _id_0BDC::_id_A1EC(var_1, 0);
  scripts\engine\utility::flag_clear("bugging_out");

  if(isDefined(self)) {
    self delete();
  }

  scripts\engine\utility::flag_clear("jackal_streak_spawned");
}

bug_out() {
  var_0 = ["phstreets_plr_goodhits31", "phstreets_plr_goodeffectontar"];
  var_1 = scripts\engine\utility::random(var_0);
  thread scripts\sp\utility::_id_10350(var_1, 0.5);

  if(level._id_A0BB == 0) {
    level.player thread scripts\sp\utility::_id_10350("dps_s31_copyshakingband");
    level._id_A0BB = 1;
  } else {
    level.player thread scripts\sp\utility::_id_10350("dps_s31_copydisengaging");
    level._id_A0BB = 0;
  }
}

_id_5542() {
  scripts\engine\utility::flag_set("stop_jackal_call");
  level.player thread _id_10FD5();
  setomnvar("ui_jackal_cooldown_done", 0);
  level.player _meth_8497();
}

_id_6209() {
  scripts\engine\utility::flag_clear("stop_jackal_call");
  setomnvar("ui_jackal_cooldown_done", 1);
  thread _id_A2D6();
}

_id_A353() {
  level.player._id_D6E8 = level.player getcurrentprimaryweapon();
  level.player thread _id_13C5F();
  level.player thread _id_A363();
  level._id_11564 = [];
}

_id_13C5F() {
  level.player._id_4C14 = level.player getcurrentweapon();

  for(;;) {
    scripts\engine\utility::waittill_any("weapon_change", "weapon_dropped");

    if(issubstr(self getcurrentweapon(), "iw7_jackal_support_designator") == 0) {
      level.player._id_4C14 = level.player getcurrentweapon();
    }
  }
}

_id_A363() {
  self endon("death");
  self endon("remove_jackal_weapon");
  waittillframeend;
  level._id_1312F = [];

  for(;;) {
    var_0 = scripts\engine\utility::waittill_any_return("weapon_change", "weapon_dropped");

    if(issubstr(self getcurrentweapon(), "iw7_jackal_support_designator") && !scripts\engine\utility::flag("streak_cooling_down") && !scripts\engine\utility::flag("stop_jackal_call") && _id_9EF2()) {
      thread _id_11500();
      thread _id_114FD();
      thread _id_1294E();
      level.player scripts\engine\utility::allow_offhand_weapons(0);
      level.player scripts\engine\utility::allow_prone(0);
      level.player scripts\engine\utility::allow_melee(0);
      level.player scripts\engine\utility::allow_usability(0);
      level.player scripts\engine\utility::allow_slide(0);
      level.player scripts\engine\utility::allow_mantle(0);
      level.player scripts\engine\utility::allow_sprint(0);
      scripts\sp\utility::_id_9199("jackalStreakTargeting", 1);
      level.cansave = 0;
      wait 0.5;

      if(!isDefined(level._id_11505)) {
        level._id_11505 = spawn("script_origin", level.player.origin);
        level._id_11505 linkTo(level.player);
      }

      setomnvar("ui_jackal_call_down_active", 1);
      level.player playSound("jackal_targeting_hud_start_lr");
      level._id_11505 playLoopSound("jackal_targeting_hud_loop_lr");
      level.player setclienttriggeraudiozonepartialwithfade("jackal_targeting_hud", 0.5, "mix", "filter");
      visionsetnaked("jackal_streak_sp", 0.2);
      setomnvar("ui_wrist_pc", 2);
      scripts\engine\utility::flag_set("player_has_used_designator");
      setsaveddvar("r_volumetrics", 0);
    }
  }
}

_id_9EF2() {
  if(!isDefined(self.melee)) {
    return 1;
  } else if(!isDefined(self.melee._id_B5FE)) {
    return 1;
  } else {
    return 0;
  }
}

_id_1100F() {
  if(scripts\engine\utility::flag("player_has_used_designator")) {
    var_0 = level.player getweaponslistall();

    foreach(var_2 in var_0) {
      if(scripts\sp\utility::isprimaryweapon(var_2)) {
        level.player switchtoweapon(var_2);
        break;
      }
    }

    scripts\engine\utility::flag_waitopen("player_has_used_designator");
  }

  level.player notify("remove_jackal_weapon");
  wait 0.25;
  level.player _meth_8497();
}

_id_1345F() {
  var_0 = newhudelem();
  var_0.sort = 0;
  var_0.x = 0;
  var_0.y = 0;
  var_0.hidewheninmenu = 0;
  var_0.hidewhendead = 1;
  var_0.alignx = "center";
  var_0.aligny = "middle";
  var_0.horzalign = "center";
  var_0.vertalign = "middle";
  var_0.alpha = 0.0;
  var_0 setshader("overlay_static", 860, 500);
  var_0 fadeovertime(0.25);
  var_0.alpha = 0.08;
  level waittill("stop_static");
  var_0.alpha = 0;
  var_0 destroy();
}

_id_11500() {
  self endon("weapon_change");
  self endon("weapon_dropped");
  level endon("jackal_inbound");
  level.player endon("death");
  wait 0.5;
  thread _id_11A91();
  level._id_1312F = [];

  for(;;) {
    var_0 = getaiarray("axis");
    var_0 = _id_110DE(var_0);
    var_1 = scripts\sp\utility::_id_81FF();
    var_1 = _id_10432(var_1);
    var_0 = scripts\sp\utility::_id_22A2(var_0, var_1);
    var_0 = sortbydistance(var_0, level.player.origin);
    var_2 = 0;

    foreach(var_4 in var_0) {
      if(var_4 _id_9FD9()) {
        if(isDefined(var_4._id_9E91)) {} else {
          if(isDefined(level._id_A29E["max_enemies"])) {
            var_5 = level._id_A29E["max_enemies"];
          } else {
            var_5 = 8;
          }

          for(var_6 = 0; var_6 < var_5; var_6++) {
            var_7 = 0;

            foreach(var_9 in level._id_1312F) {
              if(isDefined(var_4._id_9E91)) {
                var_7 = 1;
                break;
              }
            }

            if(!var_7 && level._id_1312F.size < var_5) {
              level._id_1312F[level._id_1312F.size] = var_4;
              level.player playSound("jackal_targeting_support_lock");
              var_4 scripts\engine\utility::delaythread(var_2, scripts\sp\utility::_id_9196, 1, 0, 1, "jackalStreakTargeting");
              var_2 = var_2 + 0.1;
              var_4._id_9E91 = 1;
              break;
            }
          }
        }

        continue;
      }

      if(isDefined(var_4._id_9E91)) {
        var_4 scripts\sp\utility::_id_9193("jackalStreakTargeting");
        var_4 notify("outline_off");

        if(var_4 _id_9FD9() == 0) {
          level._id_1312F = scripts\engine\utility::array_remove(level._id_1312F, var_4);
        }

        var_4._id_9E91 = undefined;
      }
    }

    wait 0.05;
  }
}

_id_11A91() {
  self endon("weapon_change");
  self endon("weapon_dropped");
  level endon("jackal_inbound");
  level.player endon("death");

  for(;;) {
    if(level._id_1312F.size >= 12) {
      setomnvar("ui_active_targets", 12);
    } else {
      setomnvar("ui_active_targets", level._id_1312F.size);
    }

    wait 0.1;
  }
}

_id_114FD() {
  self endon("weapon_change");
  self endon("weapon_dropped");
  level.player endon("death");

  for(;;) {
    level.player waittill("weapon_fired");

    if(level._id_1312F.size > 0) {
      level notify("jackal_inbound");
      level.player notify("jackal_inbound");
      break;
    } else {}
  }

  level.player playSound("jackal_support_confirmed");
  scripts\engine\utility::flag_set("jackal_successful_call");
  thread _id_1074A();
  wait 1.2;
  level.player switchtoweapon(level.player._id_4C14);
}

_id_4162() {
  var_0 = getaiarray("axis");
  var_1 = scripts\sp\utility::_id_81FF();
  var_0 = scripts\sp\utility::_id_22A2(var_0, var_1);

  foreach(var_3 in var_0) {
    var_3 scripts\sp\utility::_id_9193("jackalStreakTargeting");
    var_3 notify("outline_off");
    var_3._id_9E91 = undefined;
  }
}

_id_12BE1() {
  if(isDefined(self._id_54AB)) {
    level._id_11564 = scripts\engine\utility::array_remove(level._id_11564, self._id_54AB);
    self._id_54AB destroy();
  }

  self._id_9C3F = undefined;
  level._id_1312F = scripts\engine\utility::array_remove(level._id_1312F, self);
  self notify("stop_death_check");
}

_id_9FD9() {
  if(isDefined(level._id_A29E["max_target_dist"])) {
    var_0 = level._id_A29E["max_target_dist"];
  } else {
    var_0 = 2048;
  }

  if(isDefined(self.vehicletype)) {
    var_0 = var_0 * 1.3;
  }

  if(isDefined(level._id_A29E["min_target_dist"])) {
    var_1 = level._id_A29E["min_target_dist"];
  } else {
    var_1 = 100;
  }

  var_2 = distance2d(level.player.origin, self.origin);

  if(var_2 > var_0 || var_2 < var_1) {
    return 0;
  }

  var_3 = scripts\sp\utility::_id_7951(level.player.origin, level.player getplayerangles(), self.origin);

  if(isDefined(level._id_A29E["FOV"])) {
    var_4 = level._id_A29E["FOV"];
  } else {
    var_4 = 0.9;
  }

  if(var_3 <= var_4) {
    return 0;
  }

  if(scripts\sp\vehicle::_id_9FEF()) {
    if(isDefined(self.model)) {
      if(self.model == "veh_mil_air_ca_dropship" && !isDefined(self._id_65CD)) {
        return 0;
      } else if(self.model == "veh_mil_air_ca_dropship" && scripts\engine\utility::flag("hill_dropship_boss_dead")) {
        return 0;
      }
    } else
      return 0;
  }

  return 1;
}

_id_1294E() {
  scripts\engine\utility::waittill_any("weapon_change", "weapon_dropped");

  if(!issubstr(self getcurrentweapon(), "iw7_jackal_support_designator")) {
    level notify("stop_static");
    setomnvar("ui_wrist_pc", 1);
    visionsetnaked("", 0.4);
    scripts\engine\utility::flag_clear("player_has_used_designator");
    setsaveddvar("r_volumetrics", 1);
    level.player playSound("jackal_targeting_hud_end_lr");
    level.player clearclienttriggeraudiozone(0.1);
    level._id_11505 stoploopsound();
    level._id_11505 delete();
    level.player scripts\engine\utility::allow_offhand_weapons(1);
    level.player scripts\engine\utility::allow_melee(1);
    level.player scripts\engine\utility::allow_prone(1);
    level.player scripts\engine\utility::allow_usability(1);
    level.player scripts\engine\utility::allow_slide(1);
    level.player scripts\engine\utility::allow_mantle(1);
    level.player scripts\engine\utility::allow_sprint(1);
    scripts\sp\utility::_id_9199("jackalStreakTargeting", 0);
    level.cansave = undefined;

    if(!scripts\engine\utility::flag("jackal_successful_call")) {
      level._id_1312F = [];
    }

    _id_4162();
    setomnvar("ui_jackal_call_down_active", 0);

    if(isDefined(level._id_1153A)) {
      level._id_1153A delete();
    }
  }
}

_id_6C97(var_0, var_1) {
  self endon("death");
  self endon("bugging_out");
  var_2 = scripts\engine\utility::spawn_tag_origin(var_1[0].origin);

  for(;;) {
    if(var_0) {
      for(;;) {
        for(var_3 = 1; var_3 < var_1.size; var_3++) {
          var_4 = anglestoleft(self.angles);
          var_5 = vectorNormalize(self.origin - var_1[var_3].origin);
          var_6 = vectordot(var_4, var_5);
          var_7 = var_1[var_3];

          if(isDefined(self._id_4BC7.origin)) {
            var_8 = distance2d(self._id_4BC7.origin, var_7.origin);

            if(isDefined(level._id_110E0)) {
              var_2.origin = var_7.origin;
              var_9 = var_2 istouching(level._id_110E0);

              if(var_6 >= 0.2 && var_8 > 768 && var_9) {
                return var_1[var_3];
              }
            } else if(var_6 >= 0.2 && var_8 > 768)
              return var_1[var_3];

            continue;
          }

          if(isDefined(level._id_110E0)) {
            if(var_6 >= 0.2) {
              return var_1[var_3];
            }
          } else {
            var_2.origin = var_7.origin;
            var_9 = var_2 istouching(level._id_110E0);

            if(var_6 >= 0.2 && var_9) {
              return var_1[var_3];
            }
          }
        }

        var_0 = 0;
        break;
      }

      continue;
    }

    for(;;) {
      for(var_3 = 1; var_3 < var_1.size; var_3++) {
        var_4 = anglestoright(self.angles);
        var_5 = vectorNormalize(self.origin - var_1[var_3].origin);
        var_6 = vectordot(var_4, var_5);
        var_7 = var_1[var_3];

        if(isDefined(self._id_4BC7.origin)) {
          var_8 = distance2d(self._id_4BC7.origin, var_7.origin);

          if(isDefined(level._id_110E0)) {
            var_2.origin = var_7.origin;
            var_9 = var_2 istouching(level._id_110E0);

            if(var_6 >= 0.2 && var_8 > 768 && var_9) {
              return var_7;
            }
          } else if(var_6 >= 0.2 && var_8 > 768)
            return var_1[var_3];

          continue;
        }

        if(isDefined(level._id_110E0)) {
          var_2.origin = var_7.origin;
          var_9 = var_2 istouching(level._id_110E0);

          if(var_6 >= 0.2 && var_9) {
            return var_1[var_3];
          }

          continue;
        }

        if(var_6 >= 0.2) {
          return var_1[var_3];
        }
      }

      var_0 = 1;
      break;
    }
  }
}

_id_F42A(var_0) {
  if(isDefined(var_0)) {
    var_1 = getEnt(var_0, "targetname");
    level._id_110E0 = var_1;
  } else
    level._id_110E0 = undefined;
}

_id_A225() {
  var_0 = newhudelem();
  var_1 = scripts\engine\utility::spawn_tag_origin(self.origin - (0, 0, 50));
  var_1 linkTo(self);
  var_0 setshader("blank");
  var_0 setwaypoint(1, 1, 1, 0);
  var_0 settargetEnt(var_1);
  var_0.alpha = 1;
  var_0 setwaypointiconoffscreenonly();
  self waittill("bugging_out");
  var_0 destroy();
  wait 0.1;
  var_1 delete();
}

_id_110E1() {
  self endon("death");
  self endon("bugging_out");
  var_0 = 10;
  var_1 = scripts\engine\utility::getStructArray("streak_struct", "script_noteworthy");
  _id_0BDC::_id_19AA("spaceship_cannon_projectile");
  thread _id_0BDC::_id_B155(var_0, undefined, undefined, 0.05);
  var_1 = _id_7CB7(var_1);
  _id_0BDC::_id_19B0("fly");
  _id_0BDC::_id_19AE("shoot_now");
  self.goalradius = 596;
  var_2 = randomintrange(0, var_1.size);
  _id_0BDC::_id_A1EC(var_1[var_2].origin, 1);
  _id_0BDC::_id_19B0("hover");
  _id_0BDC::_id_19AB(40, 200, 200, 200);
  self _meth_8456((0, 0, 1));
  thread _id_10D33(var_0);
  var_3 = 1;

  if(scripts\engine\utility::cointoss()) {
    var_3 = -1;
  }

  for(;;) {
    if(var_3 == 1 && var_2 == var_1.size - 1) {
      var_2 = 0;
    } else if(var_3 == -1 && var_2 == 0) {
      var_2 = var_1.size;
    }

    var_2 = var_2 + var_3;
    _id_0BDC::_id_A1EC(var_1[var_2].origin, 0);
  }
}

_id_11569() {
  var_0 = [];
  var_0["r_hudoutlineWidth"] = 0;
  var_0["r_hudoutlineFillColor0"] = ".5 .5. 5 1";
  var_0["r_hudoutlineFillColor1"] = "1 1 1 .2";
  var_0["r_hudoutlineOccludedOutlineColor"] = ".5 .5 .5 1";
  var_0["r_hudoutlineOccludedInlineColor"] = ".7 .7 .7 1";
  var_0["r_hudoutlineOccludedInteriorColor"] = ".5 .5 .5 1";
  var_0["r_hudOutlineOccludedColorFromFill"] = 1;
  return var_0;
}

_id_A1C6() {
  var_0 = [];
  var_0["r_hudoutlineWidth"] = 0;
  var_0["r_hudoutlineFillColor0"] = "1 1 1 0";
  var_0["r_hudoutlineFillColor1"] = "1 1 1 0";
  var_0["cg_hud_outline_colors_2"] = "0.000 1.000 0.000 1.000";
  return var_0;
}

_id_110DE(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isai(var_3)) {
      if(!isalive(var_3)) {
        continue;
      }
      if(var_3 scripts\sp\utility::_id_58DA()) {
        continue;
      }
      var_1[var_1.size] = var_3;
      continue;
    }

    if(isDefined(var_3.vehicletype)) {
      if(isDefined(var_3.health) && var_3.health > 1) {
        var_1[var_1.size] = var_3;
      }
    }
  }

  return var_1;
}