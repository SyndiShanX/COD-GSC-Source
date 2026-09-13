/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5d0fd18631cb8a6a.gsc
***********************************************/

_id_99D8918F3450CC39(objectivestruct) {
  _id_382959D7794736CC::_id_D68D0E8E5202A02A("pristine");
  level thread _id_01B1A46EFB26E5A9::_id_E00BA90C8FAF1451();
  scripts\engine\utility::flag_wait("subarea_ready");
  scripts\engine\utility::flag_clear("spawning_reinforcements");
  scripts\engine\utility::flag_set("p1_finished");

  if(!scripts\engine\utility::flag_exist("explosivespickedup"))
    scripts\engine\utility::flag_init("explosivespickedup");

  level thread _id_382959D7794736CC::_id_0C735D60735EDA5F();
  level thread _id_63325153465F8869::_id_FFEC324BD5085987();
  level thread _id_24D3D5C5A0521C72::_id_8CE8975F5D76A5CF();
  setomnvar("requires_scriptmover_ladder_checks", 1);
  level._id_912C14C780D793DE = [];
  level._id_CC86627703B86AF5["subpen2"] = getEnt("area2_elec_trigger", "targetname");
  level._id_51FBA2BBD80629D9["subpen2"] = scripts\engine\utility::getStructArray("electic_fx_p2", "targetname");
  _id_2C20A33CD30EEE5F::_id_59AE7C32A14BDA75();
  _id_6E32188470E934C0::_id_82CD563E25B04A17();
  thread _id_95285D829BB54583();
  thread _id_7DC007ABFF95BD68();
  thread _id_6A06C8F7D335A8BC();
  thread _id_323248A3057C390F::_id_9168E4D97136F379("subpen2");
  thread _id_6E32188470E934C0::_id_5734778D7F1B6E6F();
  level._id_E2958F412A7425C0 thread _id_13FFCCF97A3E3294::_id_D686CFE6F2435D1F("reach_catwalks", "p2_finished");
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:0 / Level / Skip Breach Plant Step\" \"set scr_skipcharges 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A92B3F0D35A775B4 = getEnt("water_pump_needle_left", "targetname");
  _id_A92AE50D35A6AFC6 = getEnt("water_pump_needle_right", "targetname");
  _id_A92B260D35A73EB9 = [_id_A92B3F0D35A775B4, _id_A92AE50D35A6AFC6];

  foreach(_id_633CAFA47D2991FE in _id_A92B260D35A73EB9)
  _id_633CAFA47D2991FE rotateroll(135, 0.05);

  _id_29B359C42D27501C = getEntArray("left_needle_indicator", "targetname");
  _id_29B30FC42D26AD5E = getEntArray("right_needle_indicator", "targetname");
  lights = scripts\engine\utility::array_combine(_id_29B359C42D27501C, _id_29B30FC42D26AD5E);

  foreach(light in lights)
  light setModel("electronics_elevator_security_lock_console_a_green_light_on");

  while(level._id_912C14C780D793DE.size < 2 && getdvarint("dvar_FBDC6C5FEB786F35", 0) < 1)
    wait 0.1;

  level waittill("catwalk_explode");
  _id_AD812E258BA77550();
  scripts\engine\utility::flag_set("p2_finished");
  trigger = getEnt("catwalk_player_trig", "targetname");

  for(;;) {
    trigger waittill("trigger", ent);

    if(!isPlayer(ent)) {
      continue;
    }
    break;
  }

  scripts\cp\cp_checkpoint::checkpoint_set("b1_p3");
}

_id_AD812E258BA77550() {
  playsoundatpos((14679, 8909, 522), "bcharge_raid3_expl_trans_catwalk");
  playsoundatpos((14679, 8909, 301), "bcharge_raid3_expl_debris_catwalk_water");

  foreach(charge in level._id_912C14C780D793DE) {
    playFX(level._effect["catwalk_section_explode"], charge.origin);
    earthquake(0.35, 2, charge.origin, 2000);
    radiusdamage(charge.origin + (0, 0, 20), 250, 1000, 1000);
    charge delete();
  }

  _id_382959D7794736CC::_id_D68D0E8E5202A02A("destroyed");
}

_id_95285D829BB54583() {
  struct = scripts\engine\utility::getStruct("c4_interact", "targetname");
  struct.useobj = scripts\cp\utility::createhintobject(struct.origin, "HINT_BUTTON", undefined, &"CP_RAID1_BOSS1/TAKE_C4", undefined, "duration_none", "show", 256, 35, 150, 45);

  for(;;) {
    struct.useobj waittill("trigger", ent);
    scripts\engine\utility::flag_set("explosivespickedup");
    level notify("vo_explosives_grabbed", ent);
    ent._id_32B0ED2944E08A31 = 4;
    ent forceplaygestureviewmodel("ges_swipe", struct.useobj);
    ent playlocalsound("weap_ammo_pickup");

    if(!isDefined(ent._id_667D46926516E09D)) {
      ent._id_667D46926516E09D = newclienthudelem(ent);
      ent._id_667D46926516E09D.alignx = "left";
      ent._id_667D46926516E09D.location = 0;
      ent._id_667D46926516E09D.foreground = 1;
      ent._id_667D46926516E09D.fontscale = 0.8;
      ent._id_667D46926516E09D.sort = 20;
      ent._id_667D46926516E09D.alpha = 1;
      ent._id_667D46926516E09D.x = 550;
      ent._id_667D46926516E09D.y = 400;
      ent._id_667D46926516E09D settext(&"CP_RAID1_BOSS1/BREACH_CHARGES_4");
    }
  }
}

_id_7DC007ABFF95BD68() {
  _id_6CC0253AF33C6322 = scripts\engine\utility::getStructArray("plant_hint", "targetname");

  foreach(_id_13AAF746212BC225 in _id_6CC0253AF33C6322) {
    _id_13AAF746212BC225.useobj = scripts\cp\utility::createhintobject(_id_13AAF746212BC225.origin, "HINT_BUTTON", "hud_icon_c4_plant", &"CP_RAID1_BOSS1/PLANT_C4", undefined, "duration_short", "show", 350, 45, 64, 45);
    _id_13AAF746212BC225 thread _id_3DBC4AB90C8B4E6A();
  }
}

_id_3DBC4AB90C8B4E6A(_id_CED6F43DB1F44068) {
  level endon("game_ended");
  self.useobj setHintString(&"CP_RAID1_BOSS1/C4_FAIL");
  self.useobj _id_382959D7794736CC::_id_64FCFB5CB3654CBD(1);
  scripts\engine\utility::flag_wait("explosivespickedup");
  self.useobj setHintString(&"CP_RAID1_BOSS1/PLANT_C4");
  self.useobj _id_382959D7794736CC::_id_64FCFB5CB3654CBD(0);
  _id_CED6F43DB1F44068 = scripts\engine\utility::getStructArray(self.target, "targetname");
  _id_4016B1EDCC7CC493 = undefined;

  for(;;) {
    self.useobj waittill("trigger", ent);

    if(!isDefined(ent) || !ent scripts\cp\utility::is_valid_player() || !ent isonground() || ent isjumping()) {
      continue;
    }
    self.useobj _meth_DFB78B3E724AD620(0);

    if(!istrue(ent._id_32B0ED2944E08A31) || ent._id_32B0ED2944E08A31 < 1) {
      ent _id_382959D7794736CC::_id_AC901BAA09661D94(&"CP_RAID1_BOSS1/C4_FAIL", 1);
      self.useobj _meth_DFB78B3E724AD620(1);
      continue;
    }

    dir = vectorNormalize((ent.origin - self.origin) * (1, 1, 0));
    _id_3A3002B6CA1FC40D = vectordot(dir, anglesToForward(self.angles));

    if(_id_3A3002B6CA1FC40D > 0) {
      _id_4016B1EDCC7CC493 = undefined;

      foreach(struct in _id_CED6F43DB1F44068) {
        if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "fwd")
          _id_4016B1EDCC7CC493 = struct;
      }
    } else {
      _id_4016B1EDCC7CC493 = undefined;

      foreach(struct in _id_CED6F43DB1F44068) {
        if(!isDefined(struct.script_noteworthy))
          _id_4016B1EDCC7CC493 = struct;
      }
    }

    if(isDefined(_id_4016B1EDCC7CC493)) {
      _id_558A9A418B2D3405::_id_180DEE5A8E135B2A();
      _id_9651343752D44079 = _id_558A9A418B2D3405::_id_370998C9375840D6(_id_4016B1EDCC7CC493, ent);

      if(!istrue(_id_9651343752D44079)) {
        wait 1;
        self.useobj _meth_DFB78B3E724AD620(1);
        continue;
      }

      level notify("charge_planted", ent);
      return;
    }
  }
}

_id_6A06C8F7D335A8BC() {
  while(level._id_912C14C780D793DE.size < 2)
    wait 1;

  wait 1;

  foreach(player in level.players) {
    if(isDefined(player._id_667D46926516E09D))
      player._id_667D46926516E09D destroy();
  }

  level thread _id_ADE59FB3470D6D96(level._id_912C14C780D793DE[0]);
  wait 1;
  wait 1;
  wait 1;
  wait 1;
  wait 1;
  wait 1;
}

_id_ADE59FB3470D6D96(c4) {
  currenttime = gettime();
  _id_F28399727742EB23 = int(currenttime + 5000);
  _id_C301D652D9A73075 = _id_F28399727742EB23 - currenttime;
  wait 1;

  while(_id_C301D652D9A73075 > 0) {
    currenttime = gettime();
    _id_C301D652D9A73075 = _id_F28399727742EB23 - currenttime;

    if(_id_C301D652D9A73075 < 1500) {
      if(_id_C301D652D9A73075 <= 250) {
        if(soundexists("breach_warning_beep_05"))
          c4 playSound("breach_warning_beep_05");
      } else if(_id_C301D652D9A73075 < 500) {
        if(soundexists("breach_warning_beep_04"))
          c4 playSound("breach_warning_beep_04");
      } else if(_id_C301D652D9A73075 < 1500) {
        if(soundexists("breach_warning_beep_03"))
          c4 playSound("breach_warning_beep_03");
      } else if(soundexists("breach_warning_beep_02"))
        c4 playSound("breach_warning_beep_02");

      wait 0.25;
    } else if(_id_C301D652D9A73075 < 3500) {
      if(soundexists("breach_warning_beep_02"))
        c4 playSound("breach_warning_beep_02");

      wait 0.5;
    } else {
      if(soundexists("breach_warning_beep_01"))
        c4 playSound("breach_warning_beep_01");

      wait 1.0;
    }

    if(_id_C301D652D9A73075 < 0) {
      break;
    }
  }

  level notify("catwalk_explode");
}