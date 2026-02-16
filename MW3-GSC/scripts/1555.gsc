/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1555.gsc
**************************************/

init() {
  level._id_1FE5 = 1;

  if(!isDefined(level._id_3BD3)) {
    level._id_3BD3 = 12000;
  }
  if(!isDefined(level._id_3BD4)) {
    level._id_3BD4 = [];
  }
  level._id_3BD5 = 0 - level._id_3BD3;
  level._id_3BD6 = 0;
  precacheitem("remote_missile_detonator");

  if(isDefined(level._id_3BD7)) {
    precacheitem(level._id_3BD7);
  } else {
    precacheitem("remote_missile");
  }
  precacheshader("veh_hud_target");
  precacheshader("veh_hud_target_offscreen");
  precacheshader("veh_hud_missile_flash");
  precacheshader("ac130_overlay_grain");
  precacheshader("remotemissile_infantry_target");
  precacheshader("remotemissile_infantry_target_2plr");
  precacheshader("hud_fofbox_self_sp");
  precacheshader("dpad_killstreak_hellfire_missile_inactive");
  precachestring(&"HELLFIRE_DRONE_VIEW");
  precachestring(&"HELLFIRE_MISSILE_VIEW");
  precachestring(&"HELLFIRE_FIRE");
  level._id_3BD8 = spawnStruct();
  level._id_3BD8._id_3BD9 = 4;
  common_scripts\utility::flag_init("predator_missile_launch_allowed");
  common_scripts\utility::flag_set("predator_missile_launch_allowed");
  maps\_utility::add_hint_string("hint_predator_drone_destroyed", &"HELLFIRE_DESTROYED", ::_id_3BE4);
  maps\_utility::add_hint_string("hint_predator_drone_4", &"HELLFIRE_USE_DRONE", ::_id_3BDC);
  maps\_utility::add_hint_string("hint_predator_drone_2", &"HELLFIRE_USE_DRONE_2", ::_id_3BDC);
  maps\_utility::add_hint_string("hint_predator_drone_not_available", &"HELLFIRE_DRONE_NOT_AVAILABLE", ::_id_3BE2);

  if(isDefined(level._id_3BDA) && level._id_3BDA) {
    visionsetmissilecam("missilecam");
  } else if(!isDefined(level.vision_uav)) {
    visionsetmissilecam("missilecam");
  } else {
    visionsetmissilecam(level.vision_uav);
  }
  setsaveddvar("missileRemoteSpeedUp", "1000");
  setsaveddvar("missileRemoteSpeedTargetRange", "6000 12000");
  var_0 = getDvar("mapname");

  if(var_0 == "zzz") {} else if(var_0 == "raymetest") {
    setsaveddvar("missileRemoteSpeedUp", "500");
    setsaveddvar("missileRemoteSpeedTargetRange", "3000 6000");
  }

  maps\_utility::_id_1A5A("axis", ::_id_3C27);
  common_scripts\utility::flag_init("uav_reloading");
  common_scripts\utility::flag_init("uav_collecting_stats");
  common_scripts\utility::flag_init("uav_enabled");
  common_scripts\utility::flag_set("uav_enabled");

  foreach(var_2 in level.players) {}
  var_2 maps\_utility::_id_1402("controlling_UAV");
}

_id_3BDC() {
  var_0 = 0;

  if(isDefined(level._id_3BDD)) {
    var_0 = 1;
  }
  var_1 = _id_3C2B();

  if(!isalive(var_1)) {
    var_0 = 1;
  }
  if(isDefined(self._id_3BDE)) {
    var_0 = 1;
  }
  if(common_scripts\utility::flag_exist("wave_wiped_out") && common_scripts\utility::flag("wave_wiped_out")) {
    var_0 = 1;
  }
  if(maps\_utility::_id_133C("laststand_downed") && maps\_utility::_id_1008("laststand_downed")) {
    var_0 = 1;
  }
  if(self getcurrentweapon() == "remote_missile_detonator") {
    var_0 = 1;
  }
  if(common_scripts\utility::flag_exist("no_default_uav_hint") && common_scripts\utility::flag("no_default_uav_hint")) {
    var_0 = 1;
  }
  return var_0;
}

_id_3BDF() {
  if(!isDefined(level._id_11BB)) {
    level._id_11BB = [];
  }
  level._id_3BE0 = 1;
  level._id_11BB["uav_reloading"] = "cont_cmt_rearmhellfires";
  level._id_11BB["uav_offline"] = "cont_cmt_hellfiresoffline";
  level._id_11BB["uav_online"] = "cont_cmt_hellfireonline";
  level._id_11BB["uav_online_repeat"] = "cont_cmt_repeatonline";
  level._id_11BB["uav_down"] = "cont_cmt_uavdown";
  level._id_11BB["uav_multi_kill"] = "cont_cmt_mutlipleconfirmed";
  level._id_11BB["uav_multi_kill2"] = "cont_cmt_fivepluskias";
  level._id_11BB["uav_few_kills"] = "cont_cmt_theyredown";
  level._id_11BB["uav_3_kills"] = "cont_cmt_3kills";
  level._id_11BB["uav_1_kill"] = "cont_cmt_hesdown";
  level._id_11BB["uav_btr_kill"] = "cont_cmt_mutlipleconfirmed";
  level._id_11BB["uav_few_kills"] = "cont_cmt_theyredown";
  level._id_11BB["uav_3_kills"] = "cont_cmt_3kills";
  level._id_11BB["uav_1_kill"] = "cont_cmt_hesdown";
  level._id_11BB["uav_multi_vehicle_kill"] = "cont_cmt_goodhitvehicles";
  level._id_11BB["uav_multi_vehicle_kill2"] = "cont_cmt_goodeffectkia";
  level._id_11BB["uav_helo_kill"] = "cont_cmt_directhitshelo";
  level._id_11BB["uav_btr_kill"] = "cont_cmt_btrdestroyed";
  level._id_11BB["uav_truck_kill"] = "cont_cmt_goodkilltruck";
  level._id_11BB["uav_jeep_kill"] = "cont_cmt_directhitjeep";
  level._id_11BB["uav_direct_hit"] = "cont_cmt_directhit";
}

_id_3BE1(var_0) {
  return isDefined(level._id_11BB[var_0]) || isDefined(level._id_11BB[var_0 + "_variant"]);
}

_id_3BE2() {
  if(isDefined(level._id_3BE3)) {
    return 0;
  } else {
    return 1;
  }
}

_id_3BE4() {
  if(isDefined(level._id_3BDD)) {
    return 0;
  } else {
    return 1;
  }
}

_id_3BE5(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }
  if(!common_scripts\utility::flag("uav_enabled")) {
    common_scripts\utility::flag_set("uav_enabled");

    if(!common_scripts\utility::flag("uav_reloading") && var_0) {
      thread _id_3BFF("uav_online");
    }
  }

  if(isDefined(var_1)) {
    _id_3BE7(var_1);
  }
}

_id_3BE6(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }
  if(common_scripts\utility::flag("uav_enabled")) {
    common_scripts\utility::flag_clear("uav_enabled");

    if(!common_scripts\utility::flag("uav_reloading") && var_0) {
      thread _id_3BFF("uav_offline");
    }
  }

  if(isDefined(var_1)) {
    _id_3BE9();
  }
}

_id_3BE7(var_0) {
  if(isDefined(level._id_3BDD)) {
    return;
  }
  if(isstring(var_0)) {
    var_1 = var_0;
  } else if(isDefined(self._id_3BE8)) {
    var_1 = self._id_3BE8;
  } else {
    return;
  }
  if(!self hasweapon(var_1)) {
    return;
  }
  self setweaponhudiconoverride("actionslot" + _id_3BEE(), "none");
  self setactionslot(_id_3BEE(), "weapon", var_1);
}

_id_3BE9() {
  self setweaponhudiconoverride("actionslot" + _id_3BEE(), "dpad_killstreak_hellfire_missile_inactive");
  self setactionslot(_id_3BEE(), "");
}

_id_3BEA(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }
  if(var_0 == "remote_missile_detonator") {
    return 1;
  }
  if(var_0 == "remote_missile_detonator_finite") {
    return 1;
  }
  return 0;
}

_id_3BEB(var_0) {
  _id_3BED();
  self setactionslot(_id_3BEE(), "weapon", var_0);
  self giveweapon(var_0);
  thread _id_0612::_id_3BEC();
}

_id_3BED() {
  if(!self hasweapon("claymore")) {
    self._id_1FB6 = 4;
  } else {
    self._id_1FB6 = 2;
  }
}

_id_3BEE() {
  return self._id_1FB6;
}

_id_3BEF() {
  if(!isDefined(self._id_3BF0)) {
    return 0;
  }
  return self._id_3BF0.size > 1;
}

_id_3BF1(var_0) {
  self._id_3B10 = 0;

  for(;;) {
    self waittill("weapon_change", var_1);

    if(_id_3BEA(var_1)) {
      self._id_3B10 = 1;

      if(isDefined(level._id_3BDD)) {
        thread _id_3BF9(0, "uav_down");
        self switchtoweapon(self._id_3BF2);
        self._id_3B10 = 0;
        continue;
      }

      if(maps\_utility::_id_133C("laststand_downed") && maps\_utility::_id_1008("laststand_downed")) {
        _id_3C3F();
        self._id_3B10 = 0;
        continue;
      }

      if(maps\_utility::_id_133C("player_has_red_flashing_overlay") && maps\_utility::_id_1008("player_has_red_flashing_overlay")) {
        _id_3C3F();
        self._id_3B10 = 0;
        continue;
      }

      if(maps\_utility::_id_12DC() && isDefined(level._id_3BF3) && level._id_3BF3 != self) {
        thread maps\_utility::_id_11F4("so_hq_uav_busy");
        _id_3C3F();
        self._id_3B10 = 0;
        continue;
      }

      self._id_3BE8 = var_1;
      thread _id_3C01();

      if(isDefined(level._id_3BF4)) {
        [[level._id_3BF4]]();
      }
      maps\_audio::aud_send_msg("player_UAV_use");
      level._id_3BF3 = self;
      level._id_3BF5 = [];
      _id_3C16(self, var_1);
      level._id_3BF3 = undefined;
      self._id_3B10 = 0;

      if(isDefined(level._id_3BF6)) {
        [[level._id_3BF6]]();
      }
      if(isDefined(var_0)) {
        thread[[var_0]]();
      }
    }
  }
}

_id_3BF7() {
  self endon("death");
  self._id_3BF2 = self getcurrentweapon();

  for(;;) {
    self waittill("weapon_change", var_0);

    if(!_id_3BEA(var_0)) {
      self._id_3BF2 = var_0;
    }
  }
}

_id_3BF8(var_0) {
  self notifyonplayercommand("switch_to_remotemissile", "+actionslot " + _id_3BEE());
  thread _id_3BF1(var_0);
  thread _id_3BF7();

  for(;;) {
    self waittill("switch_to_remotemissile");

    if(self._id_3B10) {
      continue;
    }
    if(!_id_3BEA(self getcurrentweapon())) {
      self._id_3BF2 = self getcurrentweapon();
    }
    if(isDefined(level._id_3BDD)) {
      thread _id_3BF9(0, "uav_down");
      continue;
    }

    if(common_scripts\utility::flag("uav_reloading") || !common_scripts\utility::flag("uav_enabled")) {
      thread _id_3BF9(1);
    }
  }
}

_id_3BF9(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "uav_offline";
  }
  var_2 = gettime();

  if(var_0 && level._id_3BD5 + level._id_3BD3 - var_2 < 2000 || level._id_3BD3 < 5000) {
    if(!isDefined(level._id_3BDD) && (isDefined(self._id_3BE8) && self getweaponammoclip(self._id_3BE8) > 0)) {
      return;
    }
  }

  if(common_scripts\utility::flag("uav_reloading")) {
    if(isDefined(level._id_11BB["uav_reloading"])) {
      var_1 = "uav_reloading";
    }
  }

  if(!common_scripts\utility::flag("uav_collecting_stats") && !level._id_3BD6) {
    level._id_3BD6 = 1;
    _id_3BFF(var_1);
    level._id_3BD6 = 0;
  }
}

_id_3BFA() {
  level notify("stop_remotemissile_radio_reminder");
  level endon("special_op_terminated");
  level endon("starting_predator_drone_control");
  level endon("stop_remotemissile_radio_reminder");

  for(;;) {
    wait(7 + randomint(4));

    if(common_scripts\utility::flag_exist("special_op_terminated") && common_scripts\utility::flag("special_op_terminated")) {
      return;
    }
    if(isDefined(level._id_3BDD)) {
      return;
    }
    if(common_scripts\utility::flag("uav_reloading")) {
      return;
    }
    if(!common_scripts\utility::flag("uav_enabled")) {
      return;
    }
    _id_3BFF("uav_online_repeat");
    wait(15 + randomint(10));

    if(common_scripts\utility::flag_exist("special_op_terminated") && common_scripts\utility::flag("special_op_terminated")) {
      return;
    }
    if(isDefined(level._id_3BDD)) {
      return;
    }
    if(isDefined(level._id_3BFB)) {
      return;
    }
    _id_3BFF("uav_online");
    thread maps\_utility::_id_1823("hint_predator_drone_" + _id_3BEE(), 6);
  }
}

_id_3BFC() {
  if(isDefined(level._id_3BFD)) {
    return;
  }
  if(!isDefined(level._id_3BE0)) {
    return;
  }
  var_0 = undefined;
  var_1 = 0;

  if(isDefined(level._id_3BF5["ai"])) {
    var_1 = level._id_3BF5["ai"];
  }
  if(var_1 > 5) {
    var_0 = "uav_multi_kill";

    if(_id_3BE1("uav_multi_kill2") && common_scripts\utility::cointoss()) {
      var_0 = "uav_multi_kill2";
    }
  } else if(var_1 >= 3) {
    var_0 = "uav_3_kills";
  } else if(var_1 > 1) {
    var_0 = "uav_few_kills";
  } else if(var_1 > 0) {
    var_0 = "uav_1_kill";
  }
  var_2 = undefined;
  var_3 = 0;
  var_4 = 0;
  var_3 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;

  foreach(var_10, var_9 in level._id_3BF5) {
    if(var_10 == "ai") {
      continue;
    }
    if(var_9 > 0) {
      var_4 = var_4 + var_9;

      if(var_10 == "btr") {
        var_3 = var_9;
        continue;
      }

      if(var_10 == "helo") {
        var_5 = var_9;
        continue;
      }

      if(var_10 == "jeep") {
        var_6 = var_9;
        continue;
      }

      if(var_10 == "truck") {
        var_7 = var_9;
      }
    }
  }

  var_11 = var_0;

  if(var_3 > 0) {
    var_11 = "uav_btr_kill";
  } else if(var_5 > 0) {
    var_11 = "uav_helo_kill";
  } else if(var_4 > 1) {
    var_11 = "uav_multi_vehicle_kill";

    if(_id_3BE1("uav_multi_vehicle_kill2") && common_scripts\utility::cointoss()) {
      var_11 = "uav_multi_vehicle_kill2";
    }
  } else if(var_6 > 0) {
    var_11 = "uav_jeep_kill";

    if(var_1 > 2 && var_1 <= 5 && _id_3BE1("uav_direct_hit") && common_scripts\utility::cointoss()) {
      var_11 = "uav_direct_hit";
    }
  } else if(var_7 > 0) {
    var_11 = "uav_truck_kill";

    if(var_1 > 2 && var_1 <= 5 && _id_3BE1("uav_direct_hit") && common_scripts\utility::cointoss()) {
      var_11 = "uav_direct_hit";
    }
  }

  if(!isDefined(var_11)) {
    return;
  }
  if(common_scripts\utility::flag_exist("special_op_terminated") && common_scripts\utility::flag("special_op_terminated")) {
    return;
  }
  _id_3BFF(var_11);
  level notify("remote_missile_kill_dialogue");
}

_id_3BFE(var_0) {
  if(isDefined(level._id_11BB[var_0 + "_variant"]) && isarray(level._id_11BB[var_0 + "_variant"])) {
    level._id_11BB[var_0] = level._id_11BB[var_0 + "_variant"][randomint(level._id_11BB[var_0 + "_variant"].size)];
  }
}

_id_3BFF(var_0) {
  if(!isDefined(level._id_3BE0)) {
    return;
  }
  if(isDefined(level._id_3C00) && level._id_3C00) {
    return;
  }
  if(!_id_3BE1(var_0)) {
    return;
  }
  if(common_scripts\utility::flag_exist("special_op_terminated") && common_scripts\utility::flag("special_op_terminated")) {
    return;
  }
  _id_3BFE(var_0);
  maps\_utility::_id_11F4(var_0);
}

_id_3C01() {
  self endon("exiting_uav_control");
  self._id_3C02 = 0;

  if(maps\_utility::_id_12DC()) {
    common_scripts\utility::waittill_any("player_has_red_flashing_overlay", "player_downed", "dtest", "force_out_of_uav");
  } else {
    common_scripts\utility::waittill_any("damage", "dtest", "force_out_of_uav");
  }
  self._id_3C02 = 1;
  maps\_audio::aud_send_msg("abort_UAV_control");
}

_id_3C03() {
  level._id_3C04 = maps\_hud_util::createserverclientfontstring("objective", 2.0);
  var_0 = -175;

  if(maps\_utility::_id_12DC()) {
    var_0 = -150;

    if(issplitscreen()) {
      var_0 = -110;
    }
  }

  level._id_3C04 maps\_hud_util::setpoint("CENTER", undefined, 0, var_0);
}

_id_3C05(var_0) {
  level._id_3C04 settext(var_0);
}

_id_3C06() {
  level._id_3C04 fadeovertime(0.25);
  level._id_3C04.alpha = 0;
}

_id_3C07() {
  if(!isDefined(level._id_3C04)) {
    return;
  }
  level._id_3C04 destroy();
  level._id_3C04 = undefined;
}

_id_3C08(var_0) {
  _id_3C0D();
  _id_3C09(&"HELLFIRE_RELOADING_WITH_TIME", var_0);
  wait 1;
  _id_3C0D();
}

_id_3C09(var_0, var_1) {
  level._id_3C0A = maps\_hud_util::createserverclientfontstring("objective", 1.85);
  level._id_3C0A maps\_hud_util::setpoint("CENTER", undefined, 0, -120);
  level._id_3C0A.label = var_0;
  level._id_3C0A setvalue(var_1);
  level._id_3C0A.color = (0.85, 0.85, 0.85);
  level._id_3C0A.alpha = 0.75;
}

_id_3C0B(var_0) {
  level._id_3C0A = maps\_hud_util::createserverclientfontstring("objective", 1.85);
  level._id_3C0A maps\_hud_util::setpoint("CENTER", undefined, 0, -120);
  level._id_3C0A settext(var_0);
  level._id_3C0A.color = (0.85, 0.85, 0.85);
  level._id_3C0A.alpha = 0.75;
}

_id_3C0C() {
  if(!isDefined(level._id_3C0A)) {
    return;
  }
  level._id_3C0A fadeovertime(0.25);
  level._id_3C0A.alpha = 0;
}

_id_3C0D() {
  if(!isDefined(level._id_3C0A)) {
    return;
  }
  level._id_3C0A destroy();
  level._id_3C0A = undefined;
}

_id_3C0E(var_0) {
  var_1 = gettime() + var_0 * 1000;

  while(gettime() < var_1) {
    if(self._id_3C02) {
      return 0;
    }
    if(isDefined(level._id_3BDD)) {
      return 0;
    }
    if(self useButtonPressed()) {
      return 0;
    }
    if(!common_scripts\utility::flag("uav_enabled")) {
      return 0;
    }
    wait 0.05;
  }

  return 1;
}

_id_3C0F(var_0, var_1) {
  var_2 = gettime();
  level._id_3C10 = var_2;

  if(isDefined(var_0)) {
    level._id_3C11 = var_0;
    var_0 waittill("death");
  }

  var_1 maps\_utility::delaythread(0.1, ::_id_3C15, 1);
  var_1._id_3C12 = undefined;

  if(isDefined(level._id_3C10) && level._id_3C10 == var_2) {
    level notify("remote_missile_exploded");
    var_1 notify("remote_missile_exploded");
    level._id_3C11 = undefined;
  }

  level maps\_utility::delaythread(0.2, maps\_utility::_id_1DAA, "delayed_remote_missile_exploded");
}

_id_3C13(var_0) {
  var_0 maps\_utility::_id_13DE("controlling_UAV");
  var_0 notify("exiting_uav_control");
  maps\_audio::aud_send_msg("abort_UAV_control");
  var_0 visionsetnakedforplayer(level._id_13EE, 0.5);

  if(isDefined(level._id_3BDA) && level._id_3BDA) {
    var_0 visionsetthermalforplayer(level._id_1E70, 0.5);
  } else if(isDefined(maps\_utility::_id_1FC2(level._id_13EE))) {
    var_0 maps\_utility::_id_27D1(level._id_13EE, 0.5);
  }
  var_0 _id_3C3F();
  var_0 freezecontrols(0);

  if(!maps\_utility::_id_1A43(var_0)) {
    var_0 enableoffhandweapons();
  }
  var_0 maps\_utility::delaythread(0.1, ::_id_3C15, 1);
  level._id_3C14 = undefined;
  wait 0.1;
  _id_3C34();
}

_id_3C15(var_0) {
  if(!var_0) {
    var_1 = self getstance();

    if(var_1 != "prone") {
      self allowprone(var_0);
    }
    if(var_1 != "crouch") {
      self allowcrouch(var_0);
    }
    if(var_1 != "stand") {
      self allowstand(var_0);
      return;
    }
  } else {
    self allowprone(var_0);
    self allowcrouch(var_0);
    self allowstand(var_0);
  }
}

_id_3C16(var_0, var_1) {
  if(var_1 == "remote_missile_detonator") {
    var_0 givemaxammo(var_1);
  }
  level notify("starting_predator_drone_control");
  var_0 notify("starting_predator_drone_control");
  var_2 = 0;
  var_3 = 0;
  level._id_3C17 = "black_bw";

  if(!isDefined(level.vision_uav)) {
    level.vision_uav = "ac130";
  }
  level._id_3C18 = "missilecam";
  var_0 disableoffhandweapons();
  var_0 freezecontrols(1);
  var_0 _id_3C15(0);
  var_0 maps\_utility::_id_13DC("controlling_UAV");
  var_4 = var_0 _id_3C0E(1.0);

  if(!var_4) {
    _id_3C13(var_0);
  } else {
    var_5 = 0.25;
    var_0 visionsetnakedforplayer(level._id_3C17, var_5);

    if(isDefined(level._id_3BDA) && level._id_3BDA) {
      var_0 visionsetthermalforplayer(level._id_3C17, var_5);
    }
    _id_3C33();
    var_4 = _id_3C0E(var_5);

    if(!var_4) {
      _id_3C13(var_0);
      return;
    }

    var_0._id_2259 = 1;
    level notify("player_is_controlling_UAV");
    var_0 notify("player_is_controlling_UAV");
    var_6 = var_0 _id_3C2B();

    if(isDefined(var_6)) {
      if(maps\_utility::_id_0A36()) {
        var_6 hideonclient(self);
      } else {
        var_6 hide();
      }
    }

    var_7 = _id_0612::_id_3C19();

    if(!_id_0612::_id_3C1A()) {
      var_0 playerlinkweaponviewtodelta(var_7, "tag_player", 1.0, level._id_3BD8._id_3BD9, level._id_3BD8._id_3BD9, level._id_3BD8._id_3BD9, level._id_3BD8._id_3BD9);
      var_8 = var_7 gettagangles("tag_origin");
      var_0 setplayerangles(var_8);
    } else {
      var_0.old_origin = var_0.origin;
      var_0._id_3C1B = var_0 getplayerangles();
      var_0 playerlinktodelta(_id_0612::_id_3C19(), "tag_player", 1.0, level._id_3BD8._id_3BD9, level._id_3BD8._id_3BD9, level._id_3BD8._id_3BD9, level._id_3BD8._id_3BD9);
      var_0 playerlinktodelta(_id_0612::_id_3C19(), "tag_player", 1.0, 0, 0, 0, 0);
      var_0 maps\_utility::delaythread(0.1, ::_id_3C48);
    }

    var_0 freezecontrols(0);
    var_0 hideviewmodel();
    wait 0.05;

    if(isDefined(level._id_3C1C)) {
      var_0[[level._id_3C1C]]();
    } else {
      var_0 _id_3C03();
      _id_3C05(&"HELLFIRE_DRONE_VIEW");
    }

    if(isDefined(level._id_3BDA) && level._id_3BDA) {
      maps\_load::_id_1FB1();
      var_0 thermalvisionon();
      var_0 visionsetthermalforplayer(level.vision_uav, 0.25);
      var_0 visionsetnakedforplayer(level._id_13EE, 0.25);
    } else {
      if(isDefined(maps\_utility::_id_1FC2(level.vision_uav))) {
        var_0 maps\_utility::_id_27D1(level.vision_uav, 0.25);
      }
      var_0 visionsetnakedforplayer(level.vision_uav, 0.25);
    }

    thread _id_3C3A();
    wait 0.2;
    var_9 = _id_3C30(var_0);

    if(!var_9) {
      _id_3C2E(var_0, var_0._id_3C02);
      return;
    }

    level._id_3BD5 = gettime();
    thread _id_3C21();
    level notify("player_fired_remote_missile");
    var_0 notify("player_fired_remote_missile");
    var_10 = _id_3C35(var_0);
    var_10 thread _id_3C23(var_0);
    var_10 thread _id_3C22(var_0);

    if(var_2) {
      var_0 _id_3C0B(&"HELLFIRE_FIRE");
      var_4 = _id_3C0E(1.2);

      if(!var_4) {
        _id_3C2E(var_0, 1);
        return;
      }

      _id_3C0C();
      _id_3C3E();
      wait 0.25;
    }

    var_0._id_3BDE = 1;

    if(isDefined(level._id_3C1D)) {
      var_0[[level._id_3C1D]](0);
    } else {
      _id_3C05(&"HELLFIRE_MISSILE_VIEW");
      _id_3C0D();
    }

    _id_3C40();
    var_0 remotecamerasoundscapeon();
    var_0 unlink();
    var_0 disableweapons();

    if(isDefined(level._id_3C1E)) {
      var_0 cameralinkto(var_10, level._id_3C1E);
    } else {
      var_0 cameralinkto(var_10, "tag_origin");
    }
    var_0 controlslinkto(var_10);
    var_4 = _id_3C0E(0.2);

    if(!var_4) {
      _id_3C2D(var_0, 1);
      return;
    }

    if(isDefined(level._id_3C1F)) {
      var_0[[level._id_3C1F]](var_10);
    }
    thread _id_3C3A();

    while(isDefined(level._id_3C11)) {
      wait 0.05;

      if(isDefined(level._id_3BDD)) {
        _id_3C2D(var_0, 1);
        return;
      }

      if(var_0._id_3C02) {
        _id_3C2D(var_0, 1);
        return;
      }

      if(!common_scripts\utility::flag("uav_enabled")) {
        _id_3C2D(var_0, 1);
        return;
      }
    }

    if(!isDefined(var_6)) {
      _id_3C2D(var_0, 0);
      return;
    }

    if(var_3) {
      setsaveddvar("cg_fov", 26);
      var_0._id_3C20 = 1;
      var_0._id_3BDE = undefined;
      var_0 controlsunlink();
      var_0 cameraunlink();
      var_0 remotecamerasoundscapeoff();
      var_0 playerlinkweaponviewtodelta(_id_0612::_id_3C19(), "tag_player", 1.0, level._id_3BD8._id_3BD9, level._id_3BD8._id_3BD9, level._id_3BD8._id_3BD9, level._id_3BD8._id_3BD9);
      var_0 setplayerangles(_id_0612::_id_3C19() gettagangles("tag_origin"));
      var_4 = _id_3C0E(2);

      if(!var_4) {
        _id_3C2E(var_0, var_0._id_3C02);
        return;
      }

      _id_3C2E(var_0, 0);
      return;
    }

    _id_3C2D(var_0, 0);
  }
}

_id_3C21() {
  level endon("stop_uav_reload");
  common_scripts\utility::flag_set("uav_reloading");
  wait(level._id_3BD3 * 0.001);
  common_scripts\utility::flag_clear("uav_reloading");
}

_id_3C22(var_0) {
  var_0 waittill("predicted_projectile_impact", var_1, var_2);
  var_0 visionsetnakedforplayer("coup_sunblind", 0);
}

_id_3C23(var_0) {
  var_0._id_3C24 = 1;
  var_0 waittill("projectile_impact", var_1, var_2, var_3);
  level thread _id_3C26(var_0);
  level._id_3C25 = var_2;
  var_4 = 1000;
  var_5 = 6.0;
  earthquake(0.3, 1.4, var_2, 8000);
  maps\_audio::aud_send_msg("remote_missle_impact", var_2);
  wait 0.1;
  physicsexplosionsphere(var_2, var_4, var_4 / 2, var_5);
  wait 2;
  level._id_3C25 = undefined;
  var_0._id_3C24 = undefined;
}

_id_3C26(var_0) {
  common_scripts\utility::flag_set("uav_collecting_stats");
  var_1 = maps\_utility::_id_27BA();

  foreach(var_3 in var_1) {}
  var_3 thread _id_3C28(var_0);

  wait 1;
  common_scripts\utility::flag_clear("uav_collecting_stats");
}

_id_3C27(var_0) {
  if(!isDefined(level._id_3BE0)) {
    return;
  }
  self waittill("death", var_0, var_1);

  if(!isDefined(level._id_3BF3)) {
    return;
  }
  if(!isDefined(level._id_3BF5["ai"])) {
    level._id_3BF5["ai"] = 0;
  }
  if(isDefined(var_0) && isDefined(level._id_3BF3)) {
    if(var_0 == level._id_3BF3 || isDefined(var_0.attacker) && var_0.attacker == level._id_3BF3) {
      level._id_3BF5["ai"]++;
    }
  }
}

_id_3C28(var_0) {
  if(!isDefined(level._id_3BE0)) {
    return;
  }
  level endon("delayed_remote_missile_exploded");
  var_1 = undefined;

  switch (self.vehicletype) {
    case "btr80_physics":
    case "btr80":
      var_1 = "btr";
      break;
    case "mi17_bulletdamage":
    case "ucav":
    case "mi17_noai":
    case "mi17":
    case "hind":
      var_1 = "helo";
      break;
    case "uaz_physics":
    case "uaz":
      var_1 = "jeep";
      break;
    case "bm21_drivable":
    case "bm21":
    case "bm21_troops":
      var_1 = "truck";
      break;
    default:
      var_1 = "vehicle";
      break;
  }

  if(!isDefined(level._id_3BF5[var_1])) {
    level._id_3BF5[var_1] = 0;
  }
  self waittill("death", var_2, var_3);

  if(var_1 == "helo" || var_1 == "btr" || isDefined(self._id_0A39) && self._id_0A39.size > 0) {
    if(isDefined(var_2) && var_2 == var_0) {
      level._id_3BF5[var_1]++;
    }
  }
}

_id_3C29() {
  var_0 = self._id_3BF0[self._id_3C2A];
  return var_0;
}

_id_3C2B() {
  if(!isDefined(self._id_3BF0)) {
    return level._id_3C2C;
  }
  if(!isDefined(self._id_3C2A)) {
    self._id_3C2A = 0;
  }
  var_0 = _id_3C29();
  return var_0._id_3C2C;
}

_id_3C2D(var_0, var_1) {
  var_0._id_3BDE = undefined;

  if(isDefined(level._id_3C1D)) {
    var_0[[level._id_3C1D]](1);
  } else {
    _id_3C07();
  }
  _id_3C3E();

  if(isDefined(level._id_3BDD)) {
    thread staticeffect(0.5);
  }
  var_0 controlsunlink();
  var_0 cameraunlink();

  if(isDefined(level._id_3BDA) && level._id_3BDA) {
    maps\_load::_id_1FB3();
    var_0 thermalvisionoff();
    var_0 visionsetthermalforplayer(level._id_1E70, 0);
  }

  var_0 remotecamerasoundscapeoff();
  var_2 = var_0 _id_3C2B();

  if(isDefined(var_2)) {
    if(maps\_utility::_id_0A36()) {
      var_2 showonclient(self);
    } else {
      var_2 show();
    }
  }

  if(var_1) {
    var_0 visionsetnakedforplayer(level._id_3C17, 0);
    wait 0.05;
    var_0 visionsetnakedforplayer(level._id_13EE, 0.4);

    if(!(isDefined(level._id_3BDA) && level._id_3BDA)) {
      if(isDefined(maps\_utility::_id_1FC2(level._id_13EE))) {
        var_0 maps\_utility::_id_27D1(level._id_13EE, 0.4);
      }
    }

    if(!maps\_utility::_id_1A43(var_0)) {
      var_0 enableweapons();
    }
    var_0 freezecontrols(0);
    var_0 showviewmodel();
    wait 0.2;
    _id_3C34();

    if(!maps\_utility::_id_1A43(var_0)) {
      var_0 enableoffhandweapons();
    }
  } else {
    var_0 visionsetnakedforplayer("coup_sunblind", 0);
    var_0 freezecontrols(1);
    wait 0.05;
    var_0 visionsetnakedforplayer(level._id_13EE, 1.0);

    if(!(isDefined(level._id_3BDA) && level._id_3BDA)) {
      if(isDefined(maps\_utility::_id_1FC2(level._id_13EE))) {
        var_0 maps\_utility::_id_27D1(level._id_13EE, 1.0);
      }
    }

    if(!maps\_utility::_id_1A43(var_0)) {
      var_0 enableweapons();
    }
    var_0 showviewmodel();
    wait 0.5;
    _id_3C34();

    if(!maps\_utility::_id_1A43(var_0)) {
      var_0 enableoffhandweapons();
    }
    var_0 freezecontrols(0);
  }

  var_0 notify("exiting_uav_control");
  var_0._id_2259 = undefined;
  level._id_3C14 = undefined;
}

_id_3C2E(var_0, var_1) {
  maps\_audio::aud_send_msg("abort_UAV_control");
  _id_3C3E();

  if(isDefined(level._id_3C2F)) {
    var_0[[level._id_3C2F]](0);
  } else {
    _id_3C06();
    _id_3C0C();
  }

  var_0 visionsetnakedforplayer(level._id_3C17, 0.25);

  if(isDefined(level._id_3BDA) && level._id_3BDA) {
    var_0 visionsetthermalforplayer(level._id_3C17, 0.25);
  }
  if(isDefined(level._id_3BDD)) {
    var_0 thread staticeffect(0.5);
  }
  wait 0.15;
  wait 0.35;

  if(isDefined(level._id_3C2F)) {
    var_0[[level._id_3C2F]](1);
  } else {
    _id_3C07();
    _id_3C0D();
  }

  var_0 unlink();

  if(isDefined(level._id_3BDA) && level._id_3BDA) {
    var_0 visionsetthermalforplayer(level._id_1E70, 0);
    maps\_load::_id_1FB3();
    var_0 thermalvisionoff();
  }

  if(isDefined(var_0._id_3C20)) {
    setsaveddvar("cg_fov", 65);
  }
  var_2 = var_0 _id_3C2B();

  if(isDefined(var_2)) {
    if(maps\_utility::_id_0A36()) {
      var_2 showonclient(self);
    } else {
      var_2 show();
    }
  }

  if(var_1) {
    var_0 _id_3C40();
    var_0 freezecontrols(1);
    wait 0.15;
    var_0 visionsetnakedforplayer(level._id_13EE, 0.4);

    if(!(isDefined(level._id_3BDA) && level._id_3BDA)) {
      if(isDefined(maps\_utility::_id_1FC2(level._id_13EE))) {
        var_0 maps\_utility::_id_27D1(level._id_13EE, 0.4);
      }
    }

    if(!maps\_utility::_id_1A43(var_0)) {
      var_0 enableweapons();
    }
    var_0 showviewmodel();
    wait 0.1;
    _id_3C34();

    if(!maps\_utility::_id_1A43(var_0)) {
      var_0 enableoffhandweapons();
    }
    var_0 freezecontrols(0);
  } else {
    var_0 freezecontrols(1);
    wait 0.05;
    var_0 visionsetnakedforplayer(level._id_13EE, 0.75);

    if(!(isDefined(level._id_3BDA) && level._id_3BDA)) {
      if(isDefined(maps\_utility::_id_1FC2(level._id_13EE))) {
        var_0 maps\_utility::_id_27D1(level._id_13EE, 0.75);
      }
    }

    if(!maps\_utility::_id_1A43(var_0)) {
      var_0 enableweapons();
    }
    var_0 showviewmodel();
    wait 0.5;
    _id_3C34();
    var_0 _id_3C3F();

    if(!maps\_utility::_id_1A43(var_0)) {
      var_0 enableoffhandweapons();
    }
    var_0 freezecontrols(0);
  }

  var_0 maps\_utility::delaythread(0.1, ::_id_3C15, 1);
  var_0 notify("exiting_uav_control");
  var_0._id_2259 = undefined;
  level._id_3C14 = undefined;
  return;
}

_id_3C30(var_0) {
  var_0 notifyonplayercommand("abort_remote_missile", "weapnext");
  var_0 notifyonplayercommand("abort_remote_missile", "+stance");

  if(!level.console) {
    var_0 notifyonplayercommand("abort_remote_missile", "+gostand");
    var_0 notifyonplayercommand("abort_remote_missile", "togglecrouch");
    var_0 notifyonplayercommand("abort_remote_missile", "toggleprone");
  }

  var_0 notifyonplayercommand("launch_remote_missile", "+attack");
  var_0 notifyonplayercommand("launch_remote_missile", "+attack_akimbo_accessible");
  var_0 thread _id_3C32();
  var_0 thread _id_3C31("abort_remote_missile", "abort");

  if(common_scripts\utility::flag("predator_missile_launch_allowed")) {
    var_0 thread _id_3C31("launch_remote_missile", "launch");
  }
  var_0 waittill("remote_missile_attack", var_1);
  var_0 maps\_utility::_id_13DE("controlling_UAV");

  if(var_1 == "launch") {
    return 1;
  } else {
    return 0;
  }
}

_id_3C31(var_0, var_1) {
  self endon("remote_missile_attack");
  self waittill(var_0);
  self notify("remote_missile_attack", var_1);
}

_id_3C32() {
  self endon("remote_missile_attack");

  for(;;) {
    wait 0.05;

    if(self._id_3C02) {
      break;
    }

    if(!common_scripts\utility::flag("uav_enabled")) {
      break;
    }

    if(isDefined(level._id_3BDD)) {
      break;
    }
  }

  self notify("remote_missile_attack", "abort");
}

_id_3C33() {
  if(level.players.size > 0) {
    for(var_0 = 0; var_0 < level.players.size; var_0++) {
      if(isDefined(level.players[var_0]._id_3B10) && level.players[var_0]._id_3B10) {
        setDvar("ui_remotemissile_playernum", var_0 + 1);
      }
    }
  } else {
    setsaveddvar("compass", "0");
    setsaveddvar("ammoCounterHide", "1");
    setsaveddvar("actionSlotsHide", "1");
  }
}

_id_3C34() {
  if(level.players.size > 0) {
    setDvar("ui_remotemissile_playernum", 0);
  } else {
    setsaveddvar("compass", "1");
    setsaveddvar("ammoCounterHide", "0");
    setsaveddvar("actionSlotsHide", "0");
  }
}

_id_3C35(var_0) {
  earthquake(0.25, 0.5, _id_0612::_id_3C19().origin, 5000);
  var_1 = _id_0612::_id_3C19().origin;
  var_2 = var_0 getplayerangles();
  var_3 = anglesToForward(var_2);
  var_4 = anglestoright(var_2);

  if(!isDefined(level._id_3C36)) {
    level._id_3C36 = -300.0;
  }
  if(!isDefined(level._id_3C37)) {
    level._id_3C37 = 700.0;
  }
  var_5 = var_1 + var_4 * level._id_3C37 + var_3 * level._id_3C36;
  var_6 = var_5 + var_3 * 10.0;

  if(isDefined(level._id_3BD7)) {
    var_7 = magicbullet(level._id_3BD7, var_5, var_6, var_0);
  } else if(isDefined(level._id_3C38)) {
    var_7 = magicbullet("remote_missile_snow", var_5, var_6, var_0);
  } else if(isDefined(level._id_3C39)) {
    var_7 = magicbullet("remote_missile_invasion", var_5, var_6, var_0);
  } else {
    var_7 = magicbullet("remote_missile", var_5, var_6, var_0);
  }
  var_0._id_3C12 = var_7;
  thread _id_3C0F(var_7, var_0);
  return var_7;
}

_id_3C3A() {
  level._id_3BD8._id_3C3B = 1;
  level endon("uav_destroyed");
  level endon("draw_target_end");
  level notify("stop_prv_draw_targets");
  level endon("stop_prv_draw_targets");
  wait 0.05;
  var_0 = 4;
  var_1 = 0;
  var_2 = 0.05;

  foreach(var_4 in level._id_3BD4) {
    if(!isalive(var_4)) {
      continue;
    }
    var_4 _id_3C3C();
    var_1++;

    if(var_1 >= var_0) {
      var_1 = 0;
      wait(var_2);
    }
  }
}

_id_3C3C() {
  self._id_3C3D = 1;

  if(isDefined(self._id_28A1)) {
    target_set(self, (0, 0, -96));
  } else {
    target_set(self, (0, 0, 64));
  }
  if(isai(self)) {
    if(issplitscreen()) {
      target_setshader(self, "remotemissile_infantry_target_2plr");
    } else {
      target_setshader(self, "remotemissile_infantry_target");
    }
  } else if(isPlayer(self)) {
    if(isDefined(self._id_2259) && self._id_2259) {
      target_setshader(self, "hud_fofbox_self_sp");
    } else {}
  } else {
    target_setshader(self, "veh_hud_target");
  }
  var_0 = undefined;
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(isDefined(var_3._id_2259) && var_3._id_2259) {
      target_showtoplayer(self, var_3);
      continue;
    }

    target_hidefromplayer(self, var_3);
  }
}

_id_3C3E() {
  level notify("draw_target_end");
  level._id_3BD8._id_3C3B = undefined;
  waittillframeend;

  foreach(var_1 in level._id_3BD4) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(isDefined(var_1._id_3C3D)) {
      var_1._id_3C3D = undefined;
      target_remove(var_1);
    }
  }
}

_id_3C3F() {
  return _id_3C43(::_id_3C41);
}

_id_3C40() {
  return _id_3C43(::_id_3C42);
}

_id_3C41(var_0) {
  self switchtoweapon(var_0);
}

_id_3C42(var_0) {
  self switchtoweaponimmediate(var_0);
}

_id_3C43(var_0) {
  if(maps\_utility::_id_133C("laststand_downed") && maps\_utility::_id_1008("laststand_downed")) {
    return;
  }
  var_1 = self getweaponslist("primary", "altmode");

  foreach(var_3 in var_1) {
    if(self._id_3BF2 == var_3) {
      self[[var_0]](self._id_3BF2);
      return;
    }
  }

  if(var_1.size > 0) {
    self[[var_0]](var_1[0]);
  }
}

staticeffect(var_0) {
  var_1 = spawn("script_origin", (0, 0, 1));
  var_1.origin = self.origin;
  var_1 playSound("predator_drone_static", "sounddone");
  var_2 = newclienthudelem(self);
  var_2.horzalign = "fullscreen";
  var_2.vertalign = "fullscreen";
  var_2 setshader("ac130_overlay_grain", 640, 480);
  wait(var_0);
  var_2 destroy();
  wait 3;
  var_1 stopsounds();
  wait 1;
  var_1 delete();
}

_id_3C44() {
  self endon("controlling_UAV");
  var_0 = self attackButtonPressed();

  for(;;) {
    var_1 = self attackButtonPressed();

    if(!var_0 && var_1) {
      self._id_3C2A++;
      self._id_3C2A = self._id_3C2A % self._id_3BF0.size;
      var_2 = _id_0612::_id_3C19();
      self unlink();
      var_3 = level._id_3BD8._id_3BD9;
      self playerlinkweaponviewtodelta(var_2, "tag_player", 1, var_3, var_3, var_3, var_3, 1);
      var_4 = var_2 gettagangles("tag_origin");
      self setplayerangles(var_4);
    }

    var_0 = var_1;
    wait 0.05;
  }
}

_id_3C45() {
  if(self._id_3BF0.size <= 1) {
    return;
  }
  if(isDefined(self._id_3C46)) {
    return;
  }
  self._id_3C46 = 1;

  for(;;) {
    maps\_utility::_id_1654("controlling_UAV");
    _id_3C44();
  }
}

_id_3C47(var_0, var_1) {
  var_2 = [];
  var_2["player0"] = "cg_playerFovScale0";
  var_2["player1"] = "cg_playerFovScale1";
  var_3 = var_2[var_1.unique_id];

  for(;;) {
    var_1 maps\_utility::_id_1654("controlling_UAV");
    thread[[var_0]](var_1);
    var_1 maps\_utility::_id_13DB("controlling_UAV");
    setsaveddvar(var_3, 1);
  }
}

_id_3C48() {
  self lerpviewangleclamp(0, 0, 0, level._id_3BD8._id_3BD9, level._id_3BD8._id_3BD9, level._id_3BD8._id_3BD9 * 0.25, level._id_3BD8._id_3BD9);
}