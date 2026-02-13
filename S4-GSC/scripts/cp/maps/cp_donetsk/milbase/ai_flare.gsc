/***********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_donetsk\milbase\ai_flare.gsc
***********************************************************/

_id_95BB() {
  level._effect["vfx_flare_launch"] = loadfx("vfx/iw8/level/embassy/vfx_mortar_fire.vfx");
  level._effect["vfx_flare_trail"] = loadfx("vfx/iw8/level/embassy/vfx_illumination_flare_launch_trail.vfx");
  level._effect["vfx_mortar_trail"] = loadfx("vfx/iw8/level/highway/vfx_mortar_trail.vfx");
  level._effect["alarm_light_flash"] = loadfx("vfx/iw8_cp/level/cp_millbase/vfx_alarm_light.vfx");
  level._effect["vfx_mortar_explosion"] = loadfx("vfx/iw8/weap/_explo/mortar/vfx_mortar_explosion_bm.vfx");
  _id_CDBE();
  level._id_A475 = gettime();
  level._id_A194 = [];
}

_id_CA0C(var_0, var_1) {
  self endon("death");
  self endon("teleport_to_nearby_spawner");
  var_0._id_5B66 = 0;
  thread _id_73E4(var_0);
  self._id_709A = var_0;
  var_2 = self._id_0201;
  scripts\common\utility::_id_47A7("sprint");
  self._id_A43A = self._id_A439;
  self._id_A439 = 1;
  self._id_4D84 = self._id_4D83;
  self._id_4D83 = 1;
  _id_CA10(var_0);
  _id_54A7(var_0);
  _id_5B3F(var_0);
  _id_5750(var_0);
  self._id_0201 = var_2;
  self._id_709A = undefined;

  if(isDefined(var_1)) {
    self._id_0201 = 128;
    var_0._id_AC39 = self;
    thread _id_A171(var_0);
  }

  _id_38C1();
  scripts\common\utility::_id_38C7();

  if(isDefined(self._id_A43A)) {
    self._id_A439 = self._id_A43A;
  }

  if(isDefined(self._id_4D84)) {
    self._id_4D83 = self._id_4D84;
  }
}

_id_A171(var_0) {
  scripts\engine\utility::waittill_any_2("death", "teleport_to_nearby_spawner");
  var_0._id_AC39 = undefined;
  var_0._id_AA90 = gettime() + 45000;
}

_id_54A7(var_0) {
  _id_1230("sdr_mortar_enter", 0.7);
  var_0 _meth_82CC("emb_vm_mortar_mortar", "mortar", 0.7);
  wait 0.5;
  var_0 showpart("j_mortar_shell", "misc_wm_mortar");
  wait 0.2;
}

_id_5B3F(var_0) {
  _id_1230("sdr_mortar_launch", 0.4);

  if(var_0._id_039B == "flare") {
    var_0 thread _id_90E0();
  } else {
    var_0 thread _id_90E2(undefined, undefined, self);
  }

  var_0 hidepart("j_mortar_shell", "misc_wm_mortar");
  wait 0.4;
  self notify("launch_done");
  var_0._id_5B66 = 1;
}

_id_5750(var_0) {
  _id_1230("sdr_mortar_exit");
}

_id_C311(var_0) {
  var_0 _meth_82CC("emb_wm_mortar_reload_mortar");
  _id_1230("sdr_mortar_reload");
}

_id_CA10(var_0) {
  var_1 = _id_64AA(self, var_0);
  _id_70F1(var_1, 0);
}

_id_64AA(var_0, var_1) {
  var_2 = var_0 _id_0009::_id_1C7D("animscripted", "sdr_mortar_enter");
  var_3 = var_0 _id_0009::_id_1C6E("animscripted", var_2);
  var_4 = var_1 gettagorigin("tag_origin");
  var_5 = var_1 gettagangles("tag_origin");
  var_6 = spawnStruct();
  var_6.origin = getstartorigin(var_4, var_5, var_3) + anglesToForward(var_1.angles) * 5;
  var_6.angles = _func_00D2(var_4, var_5, var_3);
  var_6._id_18AB = var_2;
  var_6._id_10FD1 = var_3;
  return var_6;
}

_id_1230(var_0, var_1) {
  _id_ED7F();

  if(isDefined(var_1)) {
    _id_0AED::_id_18C9(var_0, var_1);
  } else {
    _id_0AED::_id_18C7(var_0);
  }

  _id_C6F5();
}

_id_1232(var_0, var_1) {
  _id_ED7F();
  _id_0AED::_id_18CA(var_0, var_1);
  _id_C6F5();
}

_id_70F1(var_0, var_1) {
  self._id_CF4A = 1;
  self._id_B85C = 1;
  self._id_0201 = 8;
  self._id_03A0 = 8;
  self _meth_8326(var_0.origin);
  _id_108ED(var_0.origin, _func_0219(384));
  self._id_0229 = 1;
  self._id_0043 = 0;
  self waittill("goal");

  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  self setplayerangles(var_0.angles);
  self _meth_80F9(var_0.origin, var_0.angles);

  if(istrue(var_1)) {
    self._id_1772 = spawn("script_origin", var_0.origin);
    self._id_1772.angles = var_0.angles;
    self linkto(self._id_1772);
  }
}

_id_90E0(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = self gettagorigin("j_shaft_top");
  }

  if(!isDefined(var_1)) {
    var_1 = self.origin + anglesToForward(self.angles) * 2000 + (0, 0, 1000);
  }

  var_2 = scripts\engine\utility::spawn_tag_origin(self gettagorigin("j_shaft_top"), (0, 0, 0));
  playFX(scripts\engine\utility::getfx("vfx_flare_launch"), self.origin + (0, 0, 3) + anglesToForward(self.angles) * 8, anglesToForward(self.angles));
  playsoundatpos(self gettagorigin("j_shaft_top"), "weap_mortar_flare_launch");
  var_2 show();
  var_3 = 2.25;
  thread _id_A23F(var_2, var_0, var_1, var_3, 400);
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_flare_trail"), var_2, "tag_origin");
  var_2 _meth_827E("weap_mortar_flare_whistle");
  wait(var_3);
  playFXOnTag(scripts\engine\utility::getfx("vfx_flare"), var_2, "tag_origin");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_flare_trail"), var_2, "tag_origin");
  var_2 thread _id_5C63(var_1);
  var_2 playSound("weap_mortar_flare_burst");
  var_2 playSound("weap_mortar_flare_phosphorus_start");
  wait 0.1;
  var_2 playLoopSound("weap_mortar_flare_phosphorus_lp");
  wait 8;
  var_2 playSound("weap_mortar_flare_phosphorus_end");
  wait 2;
  var_2 delete();
}

_id_90E2(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    var_0 = self gettagorigin("j_shaft_top");
  }

  if(isDefined(level._id_65B6)) {
    var_1 = var_2[[level._id_65B6]](self);
  }

  if(!isDefined(var_1)) {
    var_1 = getgroundposition(self.origin + anglesToForward(self.angles) * 2000, 8, 1000);
  }

  thread _id_10575(var_1);
  var_4 = scripts\engine\utility::spawn_tag_origin(self gettagorigin("j_shaft_top"), (0, 0, 0));
  playFX(scripts\engine\utility::getfx("vfx_flare_launch"), self.origin + (0, 0, 3) + anglesToForward(self.angles) * 8, anglesToForward(self.angles));
  playsoundatpos(self gettagorigin("j_shaft_top"), "weap_mortar_fire_dist");
  var_4 show();
  level._id_A194 = scripts\engine\utility::array_add(level._id_A194, var_4);
  var_5 = 5;
  var_6 = 1200;

  if(isDefined(var_3)) {
    var_6 = var_3;
  }

  thread _id_A23F(var_4, var_0, var_1, var_5, var_6);
  _id_107C5(var_4, var_5);

  if(isDefined(var_4)) {
    stopFXOnTag(scripts\engine\utility::getfx("vfx_mortar_trail"), var_4, "tag_origin");
    var_4 stoploopsound();
    var_1 = var_4.origin;
    var_7 = (0, 0, 40);

    if(isalive(var_2)) {
      _func_01BA(var_1 + var_7, 256, 200, 150, var_2, "MOD_EXPLOSIVE", "c4_mp_p");
    } else {
      _func_01BA(var_1 + var_7, 256, 200, 150, var_4, "MOD_EXPLOSIVE", "c4_mp_p");
    }

    playFX(scripts\engine\utility::getfx("vfx_mortar_explosion"), var_1);
    earthquake(0.25, 3, var_1, 2048);
    playrumbleonposition("cp_chopper_rumble", var_1);
    magicgrenademanual("mortar_mp", var_1 + (0, 0, 5), (0, 0, 0), 0.05);
    level._id_A194 = scripts\engine\utility::array_remove(level._id_A194, var_4);
    var_4 delete();
  } else
    level._id_A194 = scripts\engine\utility::_id_1BD1(level._id_A194);
}

_id_107C5(var_0, var_1) {
  var_0 endon("early_impact");
  var_0 endon("death");
  var_0 setModel("equipment_mortar_shell_improvised_01");
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_mortar_trail"), var_0, "tag_origin");
  var_0 playLoopSound("weap_mortar_fly_lp");
  wait(var_1 - 1.7);
  var_0 playSound("weap_mortar_incoming");
  wait 1.7;
}

_id_5C63(var_0) {
  self endon("death");

  while(isDefined(self)) {
    var_1 = self.origin[0] + randomintrange(-5, 5);
    var_2 = self.origin[1] + randomintrange(-5, 5);
    var_3 = self.origin[2] - 15;
    self moveto((var_1, var_2, var_3), 1);
    wait 1;
  }
}

_id_A23F(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");
  var_5 = 1200;

  if(isDefined(var_4)) {
    var_5 = var_4;
  }

  var_6 = 1 / (var_3 / 0.05);
  var_7 = 0;
  var_8 = undefined;

  while(var_7 < 1) {
    if(isDefined(var_8)) {
      if(var_7 + var_6 < 1) {
        var_0.origin = var_8;
        var_0 notify("early_impact");
        return;
      }
    }

    var_0.origin = scripts\engine\math::_id_66AE(var_1, var_2, var_5, var_7);
    var_9 = var_7 + var_6;
    var_10 = scripts\engine\math::_id_66AE(var_1, var_2, var_5, var_9);
    var_8 = _id_3452(var_0, var_10);
    var_0 _id_1790();
    var_7 = var_7 + var_6;
    wait 0.05;
  }

  var_0.origin = var_2;
}

_id_3452(var_0, var_1) {
  var_2 = physics_createcontents(["physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
  var_3 = scripts\engine\trace::ray_trace(var_0.origin, var_1, var_0, var_2);

  if(var_3["hittype"] != "hittype_none") {
    return var_1;
  }
}

_id_1790() {
  if(!isDefined(self._id_BC51)) {
    self._id_BC51 = self.origin;
    self._id_C8C6 = 0;
    return;
  }

  self.angles = vectortoangles(self.origin - self._id_BC51);
  self._id_BC51 = self.origin;
}

_id_73E4(var_0) {
  self waittill("death");
  self endon("launch_done");
  var_0 hidepart("j_mortar_shell", "misc_wm_mortar");
}

_id_CA0E(var_0) {
  self endon("death");
  var_1 = self._id_0201;

  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_2 = getent(var_0.target, "targetname");

  if(istrue(var_2._id_1414)) {
    return;
  }
  self._id_709A = var_0;
  _id_70F1(var_0, 1);
  _id_12F7(var_2);
  self._id_0201 = var_1;
  self._id_709A = undefined;
  self._id_03A0 = self._id_0201;
  _id_38C1();
}

_id_12F7(var_0) {
  var_0 _meth_82CB("wm_eq_fusebox_turn_on_prop");
  _id_1230("sdr_fusebox_on");
  _id_1413(var_0);
  var_0 scripts\engine\utility::_id_5474("switch_on");
  var_0 thread _id_1F17(60);
}

_id_1F17(var_0) {
  self endon("turned_off");
  wait(var_0);
  self makeunusable();
  self _meth_82CB("wm_eq_fusebox_prop");
  _id_1412(self);
  scripts\engine\utility::_id_5470("switch_on");
  wait 1;
  self makeuseable();
}

_id_12F6(var_0) {
  var_0 _meth_82CB("wm_eq_fusebox_prop");
  _id_1230("sdr_fusebox_off");
  _id_1412(var_0);
}

_id_140D(var_0, var_1) {
  var_0 makeuseable();
  var_0 sethintstring(&"CP_STRIKE/TURN_ON_ALARM");
  var_0 _meth_84D7("j_handle");
  var_0 _meth_84D4(128);
  var_0 setcursorhint("HINT_BUTTON");
  var_0 _meth_84DA("icon_electrical_box");
  var_0 sethintdisplayfov(120);
  var_0 _meth_84D9("hide");
  var_0 sethintrequiresholding(0);
  var_0 setuseholdduration("duration_short");
  var_0 thread _id_1419(var_0, var_1);
}

_id_F2B3(var_0) {
  var_0._id_1414 = 0;

  for(;;) {
    var_0 waittill("trigger");
    var_0 makeunusable();

    if(var_0._id_1414) {
      var_0 _meth_82CB("wm_eq_fusebox_prop");
      _id_1412(var_0);
    } else {
      _id_0AED::_id_18C7("sdr_fusebox_on");
      _id_1413(var_0);
      var_0 thread _id_1F17(60);
    }

    wait 3;
    var_0 makeuseable();
  }
}

_id_1E26(var_0, var_1) {
  var_0 endon("stop_attracting");
  var_2 = scripts\engine\utility::_id_6969(var_0.origin, getEntArray("ai_flare", "targetname"), 512);

  if(isDefined(var_2)) {
    var_2._id_1E2C = 0;
    var_2._id_5B66 = 0;
  }

  for(;;) {
    if(istrue(var_1._id_1414)) {
      while(istrue(var_1._id_1414)) {
        wait 1;
      }

      if(isDefined(var_2)) {
        var_2 notify("stop_attracting");
        var_2._id_1E2C = 0;
      }
    } else {
      if(isDefined(var_2) && !var_2._id_1E2C && !var_2._id_5B66) {
        var_2 thread _id_1E28(var_2);
        var_2._id_1E2C = 1;
      }

      var_3 = _id_1E29(var_0, 2048);

      if(isDefined(var_3)) {
        var_3 _id_CA0E(var_0);

        if(!var_1._id_1414) {
          wait 2;
        } else {
          return;
        }
      }
    }

    wait 1;
  }
}

_id_1E28(var_0, var_1, var_2) {
  var_0 endon("stop_attracting");

  for(;;) {
    var_3 = undefined;

    if(isDefined(var_0._id_AC39) && isalive(var_0._id_AC39)) {
      var_3 = var_0._id_AC39;
    } else {
      if(isDefined(var_0._id_AA90) && gettime() < var_0._id_AA90) {
        wait 1;
        continue;
      }

      var_0._id_AC39 = undefined;
      var_4 = 1024;

      if(isDefined(var_2)) {
        var_4 = var_2;
      }

      var_3 = _id_1E29(var_0, var_4);
    }

    if(isDefined(var_3)) {
      var_3 _id_CA0C(var_0, var_1);

      if(istrue(var_0._id_5B66)) {
        level notify("flare_launched");
        var_0._id_1E2C = 0;
        return;
      } else
        wait 5;
    }

    wait 1;
  }
}

_id_81C5(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = getent(var_0.target, "targetname");
  _id_140D(var_2, var_1);
  var_0._id_140C = var_2;
  var_2 scripts\engine\utility::_id_5473("switch_on");
  var_2._id_CBD0 = var_0;
}

_id_1E29(var_0, var_1) {
  var_2 = _id_07F7::_id_68A1("axis");
  var_3 = !istrue(var_0._id_7D30) && scripts\cp\utility::_id_190A(var_0.origin, _func_0219(384));

  if(!var_2.size || var_3) {
    return undefined;
  }

  var_4 = scripts\engine\utility::_id_6369(var_0.origin, var_2, undefined, 4, var_1);

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    if(isDefined(var_4[var_5]._id_709A)) {
      continue;
    }
    if(isDefined(var_4[var_5]._id_E342) && isDefined(var_4[var_5]._id_E342._id_CC8E) && var_4[var_5]._id_E342._id_CC8E == "nomortars") {
      continue;
    }
    if(!istrue(var_4[var_5]._id_54CF)) {
      continue;
    }
    if(var_4[var_5] scripts\cp\utility::_id_88DF()) {
      continue;
    }
    if(isDefined(var_4[var_5]._id_04B9) && var_4[var_5]._id_04B9 == "suicidebomber") {
      continue;
    }
    if(istrue(var_4[var_5]._id_B85C)) {
      continue;
    }
    if(var_4[var_5] _id_0743::_id_86A4()) {
      continue;
    }
    if(istrue(var_4[var_5]._id_1E07)) {
      continue;
    }
    var_6 = undefined;

    if(isDefined(var_4[var_5]._id_189C)) {
      var_6 = var_4[var_5]._id_189C;
    } else {
      var_6 = var_4[var_5]._id_1C30._id_1A35;
    }

    if(!isDefined(var_6)) {
      continue;
    }
    if(var_6 != "soldier" && var_6 != "soldier_cp") {
      continue;
    }
    return var_4[var_5];
  }

  return undefined;
}

_id_38C1() {
  self _meth_800D("stand", "prone", "crouch");
  _id_0AED::_id_18C1();

  if(!istrue(self._id_4D80)) {
    self._id_0229 = 0;
  }

  self._id_CF4A = 0;
  self._id_B85C = undefined;

  if(isDefined(self._id_1772)) {
    self unlink();
    self._id_1772 delete();
  }
}

_id_1412(var_0) {
  var_1 = getent(var_0.target, "targetname");
  var_2 = getent(var_1.target, "targetname");
  var_1 setModel("ee_light_mounted_exterior_industrial_caged_02");
  stopFXOnTag(level._effect["alarm_light_flash"], var_1, "tag_origin");
  var_2 stoploopsound();
  self._id_1414 = 0;
  self sethintstring(&"CP_STRIKE/TURN_ON_ALARM");
  var_0 notify("turned_off");
}

_id_1413(var_0) {
  var_1 = getent(var_0.target, "targetname");
  var_2 = getent(var_1.target, "targetname");
  var_1 setModel("ee_light_mounted_exterior_industrial_caged_02_on");
  playFXOnTag(level._effect["alarm_light_flash"], var_1, "tag_origin");
  var_2 playLoopSound("milbase_alarm");
  var_0 sethintstring(&"CP_STRIKE/TURN_OFF_ALARM");
  var_0._id_1414 = 1;
  level notify("alarm_on");
  level notify("weapons_free");
}

_id_CA0D(var_0) {
  self endon("death");
  var_0._id_B1C9 = 0;
  self._id_709A = var_0;
  var_1 = self._id_0201;
  _id_CA0F(self, var_0);
  _id_B19B(var_0);
  var_0._id_B1C9 = 1;
  self._id_0201 = var_1;
  self._id_709A = undefined;
  _id_38C1();
}

_id_CA0F(var_0, var_1) {
  var_2 = var_0 _id_0009::_id_1C7D("animscripted", "sdr_plant_bomb");
  var_3 = var_0 _id_0009::_id_1C6E("animscripted", var_2);
  var_4 = var_1 gettagorigin("tag_origin");
  var_5 = var_1 gettagangles("tag_origin");
  var_6 = spawnStruct();
  var_6.origin = getstartorigin(var_4, var_5, var_3);
  var_6.angles = _func_00D2(var_4, var_5, var_3);
  var_6._id_18AB = var_2;
  var_6._id_10FD1 = var_3;
  var_0._id_0229 = 1;
  var_0 _id_70F1(var_6, 0);
}

_id_B19B(var_0) {
  var_1 = spawn("script_model", self.origin);
  var_1.angles = self.angles;
  var_1 setModel("offhand_wm_c4");
  var_1 _meth_82CC("wm_equip_c4_attach_c4");
  var_0._id_33FE = var_1;
  thread _id_B19C(var_0, var_1);
  _id_1232("sdr_plant_bomb", var_0);
  self notify("bomb_planted");
}

_id_B19C(var_0, var_1) {
  self endon("bomb_planted");
  self waittill("death");

  if(isDefined(var_1)) {
    var_1 delete();
  }
}

_id_1E27(var_0) {
  var_0 endon("stop_attracting");

  for(;;) {
    var_1 = _id_1E29(var_0, 1024);

    if(isDefined(var_1)) {
      var_1 _id_CA0D(var_0);

      if(istrue(var_0._id_B1C9)) {
        var_0._id_1E2C = 0;
        return;
      } else
        wait(randomintrange(5, 10));
    }

    wait 1;
  }
}

_id_1419(var_0, var_1) {
  level endon("game_ended");
  var_0._id_1414 = 0;

  for(;;) {
    self waittill("trigger", var_2);

    if(!isPlayer(var_2)) {
      continue;
    }
    var_0 makeunusable();
    var_3 = _id_0788::_id_182C(var_2, "player_rig", 1);
    var_4 = _id_0788::_id_182C(self, "fusebox_prop");

    if(!scripts\engine\utility::_id_546E("switch_on")) {
      var_4 _id_0788::_id_182E(1, "interact_on", 1);
      var_5 = self._id_CBD0 _id_0788::_id_182B([var_4], "interact_on");
      scripts\engine\utility::_id_5474("switch_on");
      var_0._id_1414 = 1;

      if(var_5 && istrue(var_1)) {
        _id_1413(var_0);
      }
    } else {
      var_4 _id_0788::_id_182E(1, "interact", 1);
      var_5 = self._id_CBD0 _id_0788::_id_182B([var_4], "interact");
      scripts\engine\utility::_id_5470("switch_on");
      var_0._id_1414 = 0;

      if(var_5 && istrue(var_1)) {
        _id_1412(var_0);
      }
    }

    var_0 makeuseable();
    var_3 = undefined;
    var_4 = undefined;
  }
}

#using_animtree("script_model");

_id_CDBE() {
  level._id_CC34["player_rig"] = #animtree;
  level._id_CC31["player_rig"]["interact"] = % wm_eq_fusebox_plr;
  level._id_CC32["player_rig"]["interact"] = "wm_eq_fusebox_plr";
  level._id_CC3B["player_rig"]["interact"] = "wm_eq_fusebox_plr";
  level._id_CC31["player_rig"]["interact_on"] = % wm_eq_fusebox_turn_on_plr;
  level._id_CC32["player_rig"]["interact_on"] = "wm_eq_fusebox_turn_on_plr";
  level._id_CC3B["player_rig"]["interact_on"] = "wm_eq_fusebox_turn_on_plr";
  level._id_CC34["fusebox_prop"] = #animtree;
  level._id_CC31["fusebox_prop"]["interact"] = % wm_eq_fusebox_prop;
  level._id_CC32["fusebox_prop"]["interact"] = "wm_eq_fusebox_prop";
  level._id_CC31["fusebox_prop"]["interact_on"] = % wm_eq_fusebox_turn_on_prop;
  level._id_CC32["fusebox_prop"]["interact_on"] = "wm_eq_fusebox_turn_on_prop";
}

_id_10575(var_0) {
  var_1 = ["dx_cps_kama_callout_mortar_attacking_10", "dx_cps_kama_callout_mortar_attacking_20", "dx_cps_lass_callout_mortar_attacking_10", "dx_cps_lass_callout_mortar_attacking_20"];
  var_2 = scripts\cp\utility::_id_6EBD(var_0, _func_0219(512));
  var_3 = scripts\engine\utility::random(var_1);

  foreach(var_5 in var_2) {
    if(!isDefined(var_5._id_A475)) {
      var_5._id_A475 = gettime() + 30000;
    } else if(gettime() < var_5._id_A475) {
      continue;
    }
    var_5._id_A475 = gettime() + 30000;
    thread _id_076F::_id_F72E(var_3, var_5);
  }
}

_id_ED7F() {
  self._id_AA27 = self._id_04F6;
  self._id_186B = scripts\cp\cp_weapon::buildweapon("iw8_fists_mp", [], "none", "none", -1);
  self giveweapon(self._id_186B);
  self takeweapon(self._id_AA27);
  self setspawnweapon(self._id_186B);
}

_id_C6F5() {
  self giveweapon(self._id_AA27);
  self takeweapon(self._id_186B);
  self setspawnweapon(self._id_AA27);
}

_id_108ED(var_0, var_1) {
  while(distancesquared(self.origin, var_0) > var_1) {
    wait 0.1;
  }
}

_id_38EA(var_0) {
  var_0 notify("stop_attracting");
  _id_38C1();
  scripts\common\utility::_id_38C7();

  if(isDefined(self._id_A43A)) {
    self._id_A439 = self._id_A43A;
  }

  if(isDefined(self._id_4D84)) {
    self._id_4D83 = self._id_4D84;
  }
}