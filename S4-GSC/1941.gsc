/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1941.gsc
*************************************************/

_id_A182() {
  _id_95BB();
  var_0 = getEntArray("player_mortar", "targetname");

  if(isDefined(var_0) && var_0.size > 0) {
    _id_D891();
    _id_D892();
  } else
    return;

  foreach(var_2 in var_0) {
    if(istrue(level.ismp)) {
      if(!isDefined(scripts\cp_mp\utility\game_utility::_id_6B18()) || isDefined(scripts\cp_mp\utility\game_utility::_id_6B18()) && isDefined(var_2._id_039B) && var_2._id_039B != level._id_96CC) {
        var_2 delete();
        continue;
      }
    }

    var_2 thread _id_A18C(var_2);
  }
}

_id_95BB() {
  level._effect["vfx_flare_launch"] = loadfx("vfx/iw8/level/embassy/vfx_mortar_fire.vfx");
  level._effect["vfx_mortar_trail"] = loadfx("vfx/iw8/level/highway/vfx_mortar_trail.vfx");
  level._effect["vfx_mortar_explosion"] = loadfx("vfx/iw8/weap/_explo/mortar/vfx_mortar_explosion_bm.vfx");
}

#using_animtree("script_model");

_id_D892() {
  level._id_CC34["player_mortar"] = #animtree;
  level._id_CC31["player_mortar"]["player_mortar_fire"] = % emb_vm_mortar_player;
  level._id_CC32["player_mortar"]["player_mortar_fire"] = "emb_vm_mortar_player";
  level._id_CC3B["player_mortar"]["player_mortar_fire"] = "player_mortar_fire";
  level._id_CC49["player_mortar"]["player_mortar_fire"] = "emb_vm_mortar_player";
}

_id_D891() {
  level._id_CC34["mortar"] = #animtree;
  level._id_CC42["mortar"] = "misc_wm_mortar";
  level._id_CC31["mortar"]["player_mortar_fire"] = % emb_vm_mortar_mortar;
  level._id_CC32["mortar"]["player_mortar_fire"] = "emb_vm_mortar_mortar";
  level._id_CC49["mortar"]["player_mortar_fire"] = "emb_vm_mortar_mortar";
}

_id_3F5D(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0._id_18AF = var_1;
  var_0 _meth_8282(var_0.origin);
  var_4 = spawn("script_arms", var_0.origin, 0, 0, var_0);
  var_4.player = var_0;
  var_0._id_B5A4 = var_4;
  var_0._id_B5A4 hide();
  var_0._id_B5A4._id_18AF = var_1;
  var_0._id_B5A4 useanimtree(#animtree);
}

_id_BE67(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_6 scripts\common\utility::_id_151F(0);
  var_6 scripts\common\utility::_id_1570(0);
  var_6 scripts\common\utility::_id_1530(0);
  var_6 scripts\common\utility::_id_1593(0);

  if(var_1 > 0.0) {
    var_6 playerlinktoblend(var_0, "tag_player", var_1, 0, 0);
    wait(var_1);
  }

  var_6 playerlinktodelta(var_0, "tag_player", 1, var_2, var_3, var_4, var_5, 1);
}

_id_ED98(var_0) {
  var_0 scripts\common\utility::_id_158D(1, "mortar");
  var_0 scripts\common\utility::_id_151F(1);
  var_0 scripts\common\utility::_id_1570(1);
  var_0 scripts\common\utility::_id_1530(1);
  var_0 scripts\common\utility::_id_1593(1);
  var_0 unlink();
  var_0._id_B5A4 delete();
}

_id_A180(var_0, var_1) {
  if(!istrue(level.ismp)) {
    var_1 playSound("weap_mortar_load");
  }

  wait 2.2;
  var_0 playrumbleonentity("damage_bullet");
  earthquake(0.24, 1, var_1.origin, 256);
  var_1 hidepart(var_1._id_D9C4, "misc_wm_mortar");
}

_id_A23F(var_0, var_1, var_2, var_3, var_4) {
  setdvarifuninitialized("#x31179d49416712061", "0 ");

  if(getdvarint("#x31179d49416712061")) {
    var_0.origin = var_1;
    var_5 = getdvarint("#x33c01342f08fa6256");
    var_6 = distance(var_1, var_2);
    var_7 = var_2 - var_1;
    var_8 = 0.5 * var_5 * _func_0219(var_3) * -1;
    var_9 = (var_7[0] / var_3, var_7[1] / var_3, (var_7[2] - var_8) / var_3);
    var_0 movegravity(var_9, var_3);
    var_10 = gettime() + var_3 * 1000;

    while(gettime() < var_10) {
      var_0 _id_1790();
      waitframe();
    }
  } else {
    var_11 = 1200;

    if(isDefined(var_4)) {
      var_11 = var_4;
    }

    var_12 = 1 / (var_3 / 0.05);
    var_13 = 0;

    while(var_13 < 1) {
      var_0.origin = scripts\engine\math::_id_66AE(var_1, var_2, var_11, var_13);
      var_0 _id_1790();
      var_13 = var_13 + var_12;
      wait 0.05;
    }

    var_0.origin = var_2;
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

_id_A18C(var_0) {
  if(!istrue(level.ismp)) {
    var_0._id_832C = _id_A193(var_0.origin + (0, 0, 40), "HINT_BUTTON", undefined, &"CP_DWN_TWN_OBJECTIVES/ROOF_DEFEND", undefined, undefined, "show", 50, 160, 32, 120);
  } else {
    var_0._id_832C = _id_A193(var_0.origin + (0, 0, 40), "HINT_BUTTON", undefined, &"MP_INGAME_ONLY/USE_MORTAR", undefined, undefined, "show", 256, 160, 128, 160);
  }

  var_0._id_01C5 = "j_shaft_top";
  var_0._id_D9C4 = "j_mortar_shell";
  var_0 hidepart(var_0._id_D9C4, "misc_wm_mortar");
  var_0._id_18AF = "mortar";
  var_0 useanimtree(#animtree);
  var_0._id_A988 = var_0.angles;

  for(;;) {
    var_0._id_832C makeuseable();
    var_0._id_832C waittill("trigger", var_1);
    var_1 scripts\common\utility::_id_158A(0);
    var_0._id_832C makeunusable();
    _id_B533(var_1, var_0);
    wait 5;
    var_0 rotateto(var_0._id_A988, 0.1);
    wait 1;
  }
}

_id_B533(var_0, var_1) {
  self endon("death_or_disconnect");
  var_0 setorigin(var_1.origin);
  var_0 setplayerangles(var_1.angles);
  var_0 _id_3F5D(var_0, "player_mortar");
  var_0._id_B5A4.angles = var_1.angles;
  _id_BE67(var_0._id_B5A4, 0.5, 0, 0, 0, 0, var_0);
  var_0 scripts\common\utility::_id_158D(0, "mortar");
  var_2 = var_0 _id_A18A(var_1);

  if(isDefined(var_2)) {
    var_0 playerlinktodelta(var_0._id_B5A4, "tag_player", 1, 0, 0, 0, 0, 1);
    var_3 = vectortoangles(var_2 - var_1.origin);
    var_1.angles = (0, var_3[1], 0);
    var_1 showpart(var_1._id_D9C4, "misc_wm_mortar");
    var_0._id_B5A4 show();
    var_1 scripts\engine\utility::delaythread(2.25, ::_id_90E2, var_2, var_0);
    thread _id_A180(var_0, var_1);
    var_1 thread _id_06C6::_id_183B([var_1, var_0._id_B5A4], "player_mortar_fire");
    var_0._id_B5A4 waittillmatch("single anim", "end");
    var_1 notify("mortar_fired");
  }

  var_0 scripts\common\utility::_id_158A(1);
  var_1 hidepart(var_1._id_D9C4, "misc_wm_mortar");
  _id_ED98(var_0);

  if(isDefined(var_1._id_BC49)) {
    var_1._id_BC49 delete();
  }
}

_id_A18A(var_0) {
  self endon("death_or_disconnect");
  thread _id_A186(var_0);
  var_1 = undefined;
  self playerlinktodelta(self._id_B5A4, "tag_player", 0, 45, 45, 60, 60, 1);

  if(isDefined(var_0._id_BC49)) {
    var_0._id_BC49 setscriptablepartstate("target", "active");
  }

  for(;;) {
    if(self stancebuttonPressed() || self attackButtonPressed()) {
      if(self attackButtonPressed()) {
        while(self attackButtonPressed()) {
          wait 0.05;
        }

        return var_1;
      }

      while(self stancebuttonPressed()) {
        wait 0.05;
      }

      return undefined;
    }

    var_2 = scripts\engine\trace::ray_trace(self getEye() + (0, 0, 128), self getEye() + anglesToForward(self getplayerangles()) * 16000);
    var_1 = getgroundposition(var_2["position"], 8, 0, 1500);
    var_3 = vectortoangles(var_1 - var_0.origin);
    var_0.angles = (0, var_3[1], 0);

    if(!isDefined(var_0._id_BC49)) {
      var_0._id_BC49 = spawn("script_model", var_1);
      var_0._id_BC49 setModel("mortar_target");
      var_0._id_BC49.angles = (-90, 0, 0);
      var_0._id_BC49 setscriptablepartstate("target", "active");

      foreach(var_5 in level.players) {
        var_0._id_BC49 hidefromplayer(var_5);
      }

      var_0._id_BC49 showtoplayer(self);
    }

    var_0._id_BC49 moveto(var_1 + (0, 0, 10), 0.1);
    wait 0.05;
  }
}

_id_A186(var_0) {
  var_0 endon("mortar_fired");
  self waittill("death_or_disconnect");

  if(isDefined(var_0._id_BC49)) {
    var_0._id_BC49 delete();
  }
}

_id_90E2(var_0, var_1) {
  var_2 = self gettagorigin("j_shaft_top");
  var_3 = getgroundposition(self.origin + anglesToForward(self.angles) * 8000, 8, 1000);

  if(isDefined(var_0)) {
    var_3 = var_0;
  }

  var_4 = scripts\engine\utility::spawn_tag_origin(self gettagorigin("j_shaft_top"), (0, 0, 0));
  var_4 setModel("equipment_mortar_shell_improvised_01_mp");
  playFX(scripts\engine\utility::getfx("vfx_flare_launch"), self.origin + (0, 0, 3) + anglesToForward(self.angles) * 8, anglesToForward(self.angles));

  if(!istrue(level.ismp)) {
    playsoundatpos(self gettagorigin("j_shaft_top"), "weap_mortar_flare_launch");
  } else {
    playsoundatpos(self gettagorigin("j_shaft_top"), "weap_mortar_flare_launch");
  }

  var_4 show();
  var_5 = 5;
  thread _id_A23F(var_4, var_2, var_3, var_5, 1200);
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_mortar_trail"), var_4, "tag_origin");

  if(!istrue(level.ismp)) {
    var_4 playLoopSound("weap_mortar_fly_lp");
  } else {
    var_4 playLoopSound("weap_mortar_fly_lp");
  }

  wait(var_5 - 1.7);

  if(!istrue(level.ismp)) {
    var_4 playSound("weap_mortar_incoming");
  }

  wait 1.7;
  stopFXOnTag(scripts\engine\utility::getfx("vfx_mortar_trail"), var_4, "tag_origin");
  var_4 stoploopsound();
  playFX(scripts\engine\utility::getfx("vfx_mortar_explosion"), var_3);
  earthquake(0.25, 3, var_3, 2048);

  if(!istrue(level.ismp)) {
    playrumbleonposition("cp_chopper_rumble", var_3);
  } else {
    playrumbleonposition("grenade_rumble", var_3);
    playsoundatpos(var_3, "weap_mortar_expl_trans");
  }

  magicgrenademanual("mortar_mp", var_3 + (0, 0, 5), (0, 0, 0), 0.05);

  if(!istrue(level.ismp)) {
    _func_01BA(var_3 + (0, 0, 5), 512, 250, 250, var_1, "MOD_EXPLOSIVE", "s4_c4_mp");
  } else {
    _func_01BA(var_3 + (0, 0, 5), 512, 1000, 250, var_1, "MOD_EXPLOSIVE", "s4_c4_mp");
  }

  var_4 delete();
}

_id_8D37() {
  self._id_BC49 setscriptablepartstate("target", "neutral");
}

_id_A193(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = undefined;

  if(isDefined(var_11)) {
    var_12 = var_11;
  } else {
    var_12 = spawn("script_model", var_0);
  }

  var_12 makeuseable();

  if(isDefined(var_11) && isDefined(var_0)) {
    var_12 _meth_84D7(var_0);
  }

  if(isDefined(var_1)) {
    var_12 setcursorhint(var_1);
  } else {
    var_12 setcursorhint("HINT_NOICON");
  }

  if(isDefined(var_2)) {
    var_12 _meth_84DA(var_2);
  }

  if(isDefined(var_3)) {
    var_12 sethintstring(var_3);
  }

  if(isDefined(var_4)) {
    var_12 _meth_83A1(var_4);
  } else {
    var_12 _meth_83A1(0);
  }

  if(isDefined(var_5)) {
    var_12 setuseholdduration(var_5);
  } else {
    var_12 setuseholdduration("duration_short");
  }

  if(isDefined(var_6)) {
    var_12 _meth_84D9(var_6);
  } else {
    var_12 _meth_84D9("hide");
  }

  if(isDefined(var_7)) {
    var_12 _meth_84D4(var_7);
  } else {
    var_12 _meth_84D4(200);
  }

  if(isDefined(var_8)) {
    var_12 sethintdisplayfov(var_8);
  } else {
    var_12 sethintdisplayfov(160);
  }

  if(isDefined(var_9)) {
    var_12 setuserange(var_9);
  } else {
    var_12 setuserange(50);
  }

  if(isDefined(var_10)) {
    var_12 setusefov(var_10);
  } else {
    var_12 setusefov(120);
  }

  if(!isDefined(var_11)) {
    return var_12;
  }
}