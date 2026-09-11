/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\mortar_launcher.gsc
***********************************************/

function mortar_launcher_init() {
  load_fx();
  var0 = getEntArray("player_mortar", "targetname");

  if(isDefined(var0) && var0.size > 0) {
    setupmortarmodelanimscripts();
    setupmortarplayeranimscripts();
  } else {
    return;
  }

  foreach(var2 in var0) {
    if(istrue(level.ismp)) {
      if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) || isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(var2.script_noteworthy) && var2.script_noteworthy != level.localeid) {
        var2 delete();
        continue;
      }
    }

    thread mortar_test(var2);
  }
}

function load_fx() {
  level._effect["vfx_flare_launch"] = loadfx("vfx/iw8/level/embassy/vfx_mortar_fire.vfx");
  level._effect["vfx_mortar_trail"] = loadfx("vfx/iw8/level/highway/vfx_mortar_trail.vfx");
  level._effect["vfx_mortar_explosion"] = loadfx("vfx/iw8/weap/_explo/mortar/vfx_mortar_explosion_bm.vfx");
}

#using_animtree("");

function setupmortarplayeranimscripts() {
  level.scr_animtree["player_mortar"] = #animtree;
  level.scr_anim["player_mortar"]["player_mortar_fire"] = $emb_vm_mortar_player;
  level.scr_animname["player_mortar"]["player_mortar_fire"] = "emb_vm_mortar_player";
  level.scr_eventanim["player_mortar"]["player_mortar_fire"] = "player_mortar_fire";
  level.scr_viewmodelanim["player_mortar"]["player_mortar_fire"] = "emb_vm_mortar_player";
}

function setupmortarmodelanimscripts() {
  level.scr_animtree["mortar"] = #animtree;
  level.scr_model["mortar"] = "misc_wm_mortar";
  level.scr_anim["mortar"]["player_mortar_fire"] = % emb_vm_mortar_mortar;
  level.scr_animname["mortar"]["player_mortar_fire"] = "emb_vm_mortar_mortar";
  level.scr_viewmodelanim["mortar"]["player_mortar_fire"] = "emb_vm_mortar_mortar";
}

function create_player_rig(var0, var1, var2, var3) {
  if(!isDefined(var0)) {
    return;
  }

  var0.animname = var1;
  var0 predictstreampos(var0.origin);
  var4 = spawn("script_arms", var0.origin, 0, 0, var0);
  var4.player = var0;
  var0.player_rig = var4;
  var0.player_rig hide();
  var0.player_rig.animname = var1;
  var0.player_rig useanimtree(#animtree);
}

function put_player_into_rig(var0, var1, var2, var3, var4, var5, var6) {
  var6 scripts\common\utility::allow_ads(0);
  var6 scripts\common\utility::allow_prone(0);
  var6 scripts\common\utility::allow_crouch(0);
  var6 scripts\common\utility::allow_weapon_switch(0);

  if(var1 > 0) {
    var6 playerlinktoblend(var0, "tag_player", var1, 0, 0);
    wait var1;
  }

  var6 playerlinktodelta(var0, "tag_player", 1, var2, var3, var4, var5, 1);
}

function take_player_out_of_rig(var0) {
  var0 scripts\common\utility::allow_weapon(1, "mortar");
  var0 scripts\common\utility::allow_ads(1);
  var0 scripts\common\utility::allow_prone(1);
  var0 scripts\common\utility::allow_crouch(1);
  var0 scripts\common\utility::allow_weapon_switch(1);
  var0 unlink();
  var0.player_rig delete();
}

function mortar_launch_player_effect(var0, var1) {
  if(!istrue(level.ismp)) {
    var1 playSound("weap_mortar_load");
  }

  wait 2.2;
  var0 playRumbleOnEntity("damage_bullet");
  earthquake(0.24, 1, var1.origin, 256);
  var1 hidepart(var1.shell, "misc_wm_mortar");
}

function movemortar(var0, var1, var2, var3, var4) {
  setdvarifuninitialized("scr_mortar_gravity", "0 ");

  if(getdvarint("scr_mortar_gravity")) {
    var0.origin = var1;
    var5 = getdvarint("NPOQPMP");
    var6 = distance(var1, var2);
    var7 = var2 - var1;
    var8 = 0.5 * var5 * squared(var3) * -1;
    var9 = (var7[0] / var3, var7[1] / var3, (var7[2] - var8) / var3);
    var0 movegravity(var9, var3);
    var10 = gettime() + var3 * 1000;

    while(gettime() < var10) {
      anglemortar(var0);
      waitframe();
    }

    return;
  }

  var11 = 1200;

  if(isDefined(var4)) {
    var11 = var4;
  }

  var12 = 1 / var3 / 0.05;
  var13 = 0;

  while(var13 < 1) {
    var0.origin = scripts\engine\math::get_point_on_parabola(var1, var2, var11, var13);
    anglemortar(var0);
    var13 += var12;
    wait 0.05;
  }

  var0.origin = var2;
}

function anglemortar() {
  if(!isDefined(self.prevorigin)) {
    self.prevorigin = self.origin;
    self.roll = 0;
    return;
  }

  self.angles = vectortoangles(self.origin - self.prevorigin);
  self.prevorigin = self.origin;
}

function mortar_test(var0) {
  if(!istrue(level.ismp)) {
    var0.interact = mortarlauncher_createhintobject(var0.origin + (0, 0, 40), "HINT_BUTTON", undefined, &"CP_DWN_TWN_OBJECTIVES/ROOF_DEFEND", undefined, undefined, "show", 50, 160, 32, 120);
  } else {
    var0.interact = mortarlauncher_createhintobject(var0.origin + (0, 0, 40), "HINT_BUTTON", undefined, &"MP_INGAME_ONLY/USE_MORTAR", undefined, undefined, "show", 256, 160, 128, 160);
  }

  var0.flash = "j_shaft_top";
  var0.shell = "j_mortar_shell";
  var0 hidepart(var0.shell, "misc_wm_mortar");
  var0.animname = "mortar";
  var0 useanimtree(#animtree);
  var0.og_angles = var0.angles;

  for(;;) {
    var0.interact makeusable();
    var0.interact waittill("trigger", var1);
    var1 scripts\common\utility::allow_usability(0);
    var0.interact makeunusable();
    player_launch_mortar(var1, var0);
    wait 5;
    var0 rotateTo(var0.og_angles, 0.1);
    wait 1;
  }
}

function player_launch_mortar(var0, var1) {
  self endon("death_or_disconnect");
  var0 setOrigin(var1.origin);
  var0 setplayerangles(var1.angles);
  create_player_rig(var0, var0, "player_mortar");
  var0.player_rig.angles = var1.angles;
  put_player_into_rig(var0.player_rig, 0.5, 0, 0, 0, 0, var0);
  var0 scripts\common\utility::allow_weapon(0, "mortar");
  var2 = mortar_targetting(var0, var1);

  if(isDefined(var2)) {
    var0 playerlinktodelta(var0.player_rig, "tag_player", 1, 0, 0, 0, 0, 1);
    var3 = vectortoangles(var2 - var1.origin);
    var1.angles = (0, var3[1], 0);
    var1 showpart(var1.shell, "misc_wm_mortar");
    var0.player_rig show();
    var1 scripts\engine\utility::delaythread(2.25, &launch_mortar, var2, var0);
    thread mortar_launch_player_effect(var0, var1);
    var1 thread scripts\common\anim::anim_single([var1, var0.player_rig], "player_mortar_fire");
    var0.player_rig waittillmatch("single anim", "end");
    var1 notify("mortar_fired");
  }

  var0 scripts\common\utility::allow_usability(1);
  var1 hidepart(var1.shell, "misc_wm_mortar");
  take_player_out_of_rig(var0);

  if(isDefined(var1.previs_model)) {
    var1.previs_model delete();
    return;
  }
}

function mortar_targetting(var0) {
  self endon("death_or_disconnect");
  thread mortar_ondeathcleanup(var0);
  var1 = undefined;
  self playerlinktodelta(self.player_rig, "tag_player", 0, 45, 45, 60, 60, 1);
  jumpiffalse(isDefined(var0.previs_model)) LOC_0000004f;
  var0.previs_model setscriptablepartstate("target", "active");

  for(;;) {
    if(self stancebuttonPressed() || self attackButtonPressed()) {
      if(self attackButtonPressed()) {
        while(self attackButtonPressed()) {
          wait 0.05;
        }

        return var1;
      }

      while(self stancebuttonPressed()) {
        wait 0.05;
      }

      return undefined;
    }

    var2 = scripts\engine\trace::ray_trace(self getEye() + (0, 0, 128), self getEye() + anglesToForward(self getplayerangles()) * 16000);
    var1 = getgroundposition(var2["position"], 8, 0, 1500);
    var3 = vectortoangles(var1 - var0.origin);
    var0.angles = (0, var3[1], 0);

    if(!isDefined(var0.previs_model)) {
      var0.previs_model = spawn("script_model", var1);
      var0.previs_model setModel("mortar_target");
      var0.previs_model.angles = (-90, 0, 0);
      var0.previs_model setscriptablepartstate("target", "active");

      foreach(var5 in level.players) {
        var0.previs_model hidefromplayer(var5);
      }

      var0.previs_model showtoplayer(self);
    }

    var0.previs_model moveTo(var1 + (0, 0, 10), 0.1);
    wait 0.05;
  }
}

function mortar_ondeathcleanup(var0) {
  var0 endon("mortar_fired");
  self waittill("death_or_disconnect");

  if(isDefined(var0.previs_model)) {
    var0.previs_model delete();
    return;
  }
}

function launch_mortar(var0, var1) {
  var2 = self gettagorigin("j_shaft_top");
  var3 = getgroundposition(self.origin + anglesToForward(self.angles) * 8000, 8, 1000);

  if(isDefined(var0)) {
    var3 = var0;
  }

  var4 = scripts\engine\utility::spawn_tag_origin(self gettagorigin("j_shaft_top"), (0, 0, 0));
  var4 setModel("equipment_mortar_shell_improvised_01_mp");
  playFX(scripts\engine\utility::getfx("vfx_flare_launch"), self.origin + (0, 0, 3) + anglesToForward(self.angles) * 8, anglesToForward(self.angles));

  if(!istrue(level.ismp)) {
    playsoundatpos(self gettagorigin("j_shaft_top"), "weap_mortar_flare_launch");
  } else {
    playsoundatpos(self gettagorigin("j_shaft_top"), "weap_mortar_flare_launch");
  }

  var4 show();
  var5 = 5;
  thread movemortar(var4, var2, var3, var5, 1200);
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_mortar_trail"), var4, "tag_origin");

  if(!istrue(level.ismp)) {
    var4 playLoopSound("weap_mortar_fly_lp");
  } else {
    var4 playLoopSound("weap_mortar_fly_lp");
  }

  wait var5 - 1.7;

  if(!istrue(level.ismp)) {
    var4 playSound("weap_mortar_incoming");
  }

  wait 1.7;
  stopFXOnTag(scripts\engine\utility::getfx("vfx_mortar_trail"), var4, "tag_origin");
  var4 stoploopsound();
  playFX(scripts\engine\utility::getfx("vfx_mortar_explosion"), var3);
  earthquake(0.25, 3, var3, 2048);

  if(!istrue(level.ismp)) {
    playrumbleonposition("cp_chopper_rumble", var3);
  } else {
    playrumbleonposition("grenade_rumble", var3);
    playsoundatpos(var3, "weap_mortar_expl_trans");
  }

  magicgrenademanual("mortar_mp", var3 + (0, 0, 5), (0, 0, 0), 0.05);

  if(!istrue(level.ismp)) {
    radiusdamage(var3 + (0, 0, 5), 512, 250, 250, var1, "MOD_EXPLOSIVE", "c4_mp_p");
  } else {
    radiusdamage(var3 + (0, 0, 5), 512, 1000, 250, var1, "MOD_EXPLOSIVE", "c4_mp_p");
  }

  var4 delete();
}

function kill_mortar_target() {
  self.previs_model setscriptablepartstate("target", "neutral");
}

function mortarlauncher_createhintobject(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  var12 = undefined;

  if(isDefined(var11)) {
    var12 = var11;
  } else {
    var12 = spawn("script_model", var0);
  }

  var12 makeusable();

  if(isDefined(var11) && isDefined(var0)) {
    var12 sethinttag(var0);
  }

  if(isDefined(var1)) {
    var12 setCursorHint(var1);
  } else {
    var12 setCursorHint("HINT_NOICON");
  }

  if(isDefined(var2)) {
    var12 sethinticon(var2);
  }

  if(isDefined(var3)) {
    var12 setHintString(var3);
  }

  if(isDefined(var4)) {
    var12 setusepriority(var4);
  } else {
    var12 setusepriority(0);
  }

  if(isDefined(var5)) {
    var12 setuseholdduration(var5);
  } else {
    var12 setuseholdduration("duration_short");
  }

  if(isDefined(var6)) {
    var12 sethintonobstruction(var6);
  } else {
    var12 sethintonobstruction("hide");
  }

  if(isDefined(var7)) {
    var12 sethintdisplayrange(var7);
  } else {
    var12 sethintdisplayrange(200);
  }

  if(isDefined(var8)) {
    var12 sethintdisplayfov(var8);
  } else {
    var12 sethintdisplayfov(160);
  }

  if(isDefined(var9)) {
    var12 setuserange(var9);
  } else {
    var12 setuserange(50);
  }

  if(isDefined(var10)) {
    var12 setusefov(var10);
  } else {
    var12 setusefov(120);
  }

  if(!isDefined(var11)) {
    return var12;
  }
}