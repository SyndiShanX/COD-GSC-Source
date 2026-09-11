/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\asm_sp.gsc
***********************************************/

function asm_init(var0, var1) {
  if(var1 == "hero_salter" || var1 == "farah" || var1 == "soldier_female") {
    scripts\asm\asm_bb::bb_setshort(1);
  }

  self.asm = spawnStruct();
  self.asm.archetype = var1;
  self.asm.animoverrides = [];
  self.asm.frantic = 0;
  self.asmname = var0;
  self setanimset(var1);
  self.fnasm_init = &asm_init;
  self.fnasm_setupaim = &asm_setupaim_sp;
  self.fnasm_setupgesture = &asm_setupgesture;
  self.fnasm_playfacialanim = &asm_playfacialanim_sp;
  self.fnasm_handlenotetrack = &scripts\anim\notetracks_sp::handlenotetrack;
  self.fnasm_playadditiveanimloopstate = &asm_playadditiveanimloopstate_sp;
  self.fnasm_clearfingerposes = &asm_clearfingerposes;
  self.fnplaceweaponon = &scripts\anim\shared::placeweaponon;
  self.fndooropen = &open_door;
  self.fndoorclose = &close_door;
  self.fndoorneedstoclose = &door_needs_to_close;
  self.fngetdoorcenter = &get_door_center;
  self.fndooralreadyopen = &is_door_already_open;
  asmregistergenerichandler(var0, &scripts\asm\asm::asm_generichandler);
  self asminstantiate(var0);
}

function updatepainvars(var0) {
  if(self.damageshield && !isDefined(self.disabledamageshieldpain)) {
    var1 = 1500;

    if(!isDefined(self.a.lastpaintime)) {
      self.a.lastpaintime = 0;
    }

    if(!isDefined(self.damageshieldcounter) || gettime() - self.a.lastpaintime > var1) {
      self.damageshieldcounter = randomintrange(2, 3);
    }

    if(isDefined(self.lastattacker) && distancesquared(self.origin, self.lastattacker.origin) < squared(512)) {
      self.damageshieldcounter = 0;
    }

    if(self.damageshieldcounter > 0) {
      self.damageshieldcounter--;
    }
  }

  if(isDefined(var0)) {
    self.damagedsubpart = var0;
    return;
  }

  self.damagedsubpart = undefined;
}

function shouldplaypainanim() {
  if(isDefined(self.fnshouldplaypainanim)) {
    return self[[self.fnshouldplaypainanim]]();
  }

  return shouldplaypainanimdefault();
}

function shouldplaypainanimdefault() {
  var0 = 4096;

  if(self.a.disablepain) {
    return false;
  }

  if(isDefined(self.pathgoalpos) && self pathdisttogoal() < var0) {
    return false;
  }

  return true;
}

function deletehandler() {
  self endon("terminate_ai_threads");
  self waittill("entitydeleted");
  self notify("terminate_ai_threads");
}

function paininternal() {
  if(true) {
    updatepainvars();

    if(!shouldplaypainanim()) {
      if(isDefined(self.script) && self.script == "pain") {
        self notify("killanimscript");
      }

      return;
    }

    var0 = 0;
    var1 = self asmevalpaintransition(self.asmname);

    if(isDefined(var1) && var1) {
      var0 = 1;
    }

    if(!var0 && self.script == "pain") {
      self notify("killanimscript");
    }
  }

  self endon("killanimscript");
  self waittill("Hellfreezesover");
}

function subparthandler() {
  self endon("death");
  self endon("terminate_ai_threads");
}

function asm_animhasfacialoverride(var0) {
  if(!animisleaf(var0)) {
    return 0;
  }

  return animhasnotetrack(var0, "facial_override");
}

function asm_playfacialanim_sp(var0, var1, var2) {
  if(var0 != self.asmname) {
    return;
  }

  var3 = self asmgetfacialstate();

  if(isDefined(var3)) {
    asm_playfacialaniminternal(var2, var3);
    return;
  }

  scripts\asm\asm::asm_clearfacialanim();
  self.asm.facial_state = "";
}

function asm_playfacialaniminternal(var0, var1) {
  if(!scripts\asm\shared\utility::isfacialstateallowed("asm")) {
    return;
  }

  if(isDefined(var0) && asm_animhasfacialoverride(var0)) {
    return;
  }

  var2 = scripts\asm\asm::asm_lookupanimfromaliasifexists("knobs", "head");

  if(!isDefined(var2)) {
    return;
  }

  if(!isDefined(self.asm.facial_state)) {
    self.asm.facial_state = "";
  }

  scripts\asm\shared\utility::setfacialstate("asm");

  if(isai(self)) {
    self setfacialindex(var1);
    return;
  }

  scripts\asm\shared\utility::setfacialindexfornonai(var1);
}

function asm_playfacialanimfromnotetrack(var0) {
  var1 = "";

  if(isDefined(self.asm)) {
    var1 = self.asm.archetype;
  }

  if(isDefined(self.animationarchetype)) {
    var1 = self.animationarchetype;
  }

  if(!scripts\asm\shared\utility::isfacialstateallowed("asm") && var0 != "death") {
    return;
  }

  if(var1 != "") {
    scripts\asm\shared\utility::setfacialstate("asm");

    if(isai(self)) {
      self setfacialindex(var0);
      return;
    }

    scripts\asm\shared\utility::setfacialindexfornonai(var0);
    return;
  }
}

function asm_playfacialanimsingleframedeath(var0) {
  if(isai(self)) {
    self setfacialindex("death");
    return;
  }

  scripts\asm\shared\utility::setfacialindexfornonai("death");
}

function asm_initfingerposes() {
  self endon("death");
  var0 = 0;
  var1 = 0;
  var2 = scripts\asm\asm::asm_lookupanimfromalias("knobs", "inner_root");
  var3 = scripts\asm\asm::asm_getxanim("knobs", var2);
  var4 = 0;
  var5 = 0;

  for(;;) {
    var6 = self getanimikweights(var3);
    var7 = var6[0] - var0;
    var8 = (var7 > 0.001) - (var7 < -0.001);

    if(var8 != var4) {
      if(var8 > 0) {
        var0 = var6[0];
        var4 = var8;
        wait 0.1;
        asm_ikfingeranim("left");
        continue;
      }

      if(var8 < 0) {
        var0 = var6[0];
        var4 = var8;
        asm_clearikfingeranim("left");
        continue;
      }
    }

    var0 = var6[0];
    var4 = var8;
    var9 = var6[1] - var1;
    var10 = (var9 > 0.001) - (var9 < -0.001);

    if(var10 != var5) {
      if(var10 > 0) {
        var1 = var6[1];
        var5 = var10;
        wait 0.1;
        asm_ikfingeranim("right");
        continue;
      }

      if(var10 < 0) {
        var1 = var6[1];
        var5 = var10;
        asm_clearikfingeranim("right");
        continue;
      }
    }

    var1 = var6[1];
    var5 = var10;
    wait 0.05;
  }
}

function asm_clearfingerposes() {
  asm_clearikfingeranim("left");
  asm_clearikfingeranim("right");
}

function asm_ikfingeranim(var0) {
  var1 = scripts\anim\utility::getaicurrentweapon();

  if(nullweapon(var1)) {
    asm_clearikfingeranim(var0);
  }

  asm_playikfingeranim(var0);
}

function asm_playikfingeranim(var0) {
  var1 = scripts\anim\utility::getaicurrentweapon();

  if(nullweapon(var1)) {
    return;
  }

  var2 = "ik_finger_pose_r";
  var3 = "ik_fingers_r";
  var4 = getweaponbasename(var1);

  if(var0 == "left") {
    var2 = "ik_finger_pose_l";
    var3 = "ik_fingers_l";
    var5 = getweaponattachments(var1);

    if(isDefined(var5)) {
      foreach(var7 in var5) {
        var8 = getsubstr(var7, 0, 7);

        if(var8 == "ub_mike") {
          var4 = "iw8_ub_mike";
        }

        if(var8 == "ub_golf") {
          var4 = "iw8_ub_golf";
        }

        if(var8 == "gripang") {
          var4 = "iw8_gripang";
        }

        if(var8 == "gripver") {
          var4 = "iw8_gripver";
        }
      }
    }
  }

  if(!asm_hasstatesp(self.asm.archetype, var2)) {
    return;
  }

  if(!isDefined(var4) || !scripts\asm\asm::asm_hasalias(var2, var4)) {
    if(!isDefined(var4)) {
      var4 = "UNDEFINED";
    }

    return;
  }

  var10 = scripts\asm\asm::asm_getxanim(var2, scripts\asm\asm::asm_lookupanimfromalias(var2, var4));
  var11 = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", var3));
  self setanim(var11, 1, 0.3, 1);
  self setanim(var10, 1, 0.3, 1);
}

function asm_clearikfingeranim(var0) {
  var1 = "ik_fingers_l";

  if(var0 == "right") {
    var1 = "ik_fingers_r";
  }

  if(!scripts\asm\asm::asm_hasalias("knobs", var1)) {
    return;
  }

  var2 = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", var1));
  self clearanim(var2, 0.3, 1);
}

function asm_playvisorraise(var0) {
  if(isDefined(var0)) {
    var1 = 1;
  } else {
    var1 = 0;
    var1 = "";
  }

  asm_trynvgmodelswap();
  asm_clearvisoranim();
  var2 = scripts\asm\asm::asm_getxanim("visor", scripts\asm\asm::asm_lookupanimfromalias("visor", "helmet_visor_up" + var1));

  if(self.visor_down == 0) {
    if(var1) {
      return;
    }

    self setanim(var2, 1, 0, 1);
    return;
  }

  var3 = scripts\asm\asm::asm_getxanim("visor", scripts\asm\asm::asm_lookupanimfromalias("visor", "helmet_visor_down" + var1));
  self setanim(var3, 1, 0, 1);

  if(!var1) {
    wait getanimlength(var3) - 0.1;
    return;
  }
}

function asm_trynvgmodelswap() {
  if(!isDefined(self.nvgmodel_on)) {
    return;
  }

  var0 = self.headmodel;

  if(isDefined(self.hatmodel)) {
    var0 = self.hatmodel;
  }

  if(self.visor_down == 0 && var0 == self.nvgmodel_on) {
    if(isDefined(self.hatmodel)) {
      self detach(self.hatmodel);
      self.hatmodel = self.nvgmodel_off;
      self attach(self.hatmodel);
      return;
    }

    self detach(self.headmodel);
    self.headmodel = self.nvgmodel_off;
    self attach(self.headmodel);
    return;
  }

  if(var0 == self.nvgmodel_off) {
    if(isDefined(self.hatmodel)) {
      self detach(self.hatmodel);
      self.hatmodel = self.nvgmodel_on;
      self attach(self.hatmodel);
      return;
    }

    self detach(self.headmodel);
    self.headmodel = self.nvgmodel_on;
    self attach(self.headmodel);
    return;
  }
}

function asm_clearvisoranim() {
  asm_trynvgmodelswap();
  var0 = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", "visor"));
  self clearanim(var0, 0);
}

function asm_hasstatesp(var0, var1) {
  if(archetypeassetloaded(var0)) {
    return archetypehasstate(var0, var1);
  }

  return 0;
}

function asm_playadditiveanimloopstate_sp(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = scripts\asm\asm::asm_getbodyknob();
  var4 = 0;
  var5 = 0.2;

  for(;;) {
    var6 = scripts\asm\asm::asm_getxanim(var1, scripts\asm\asm::asm_getanim(var0, var1));

    if(var3 != var6) {
      if(var4) {
        self setflaggedanimknoblimitedrestart(var1, var6, 1, var5, 1);
      } else {
        self setflaggedanimknobrestart(var1, var6, 1, var5, 1);
      }

      var3 = var6;
    }

    thread asm_playadditiveanimloopstate_helper(var1, var6, var4);
    scripts\asm\asm::asm_playfacialanim(var0, var1, var6);
    scripts\asm\asm::asm_donotetracks(var0, var1, scripts\asm\asm::asm_getnotehandler(var0, var1));
    self notify(var1 + "additive_cancel");
  }
}

function asm_playadditiveanimloopstate_helper(var0, var1, var2) {
  self endon(var0 + "_finished");
  self endon(var0 + "additive_cancel");

  while(isDefined(var1)) {
    wait 0.2;

    if(var2) {
      self setflaggedanimlimited(var0, var1, 1, 0, 1);
      continue;
    }

    self setflaggedanim(var0, var1, 1, 0, 1);
  }
}

function asm_setaimlimits(var0) {
  if(isDefined(var0["left"])) {
    self.leftaimlimit = var0["left"];
  } else if(scripts\engine\utility::actor_is3d()) {
    self.leftaimlimit = 56;
  } else {
    self.leftaimlimit = 45;
  }

  if(isDefined(var0["right"])) {
    self.rightaimlimit = var0["right"];
  } else if(scripts\engine\utility::actor_is3d()) {
    self.rightaimlimit = -56;
  } else {
    self.rightaimlimit = -45;
  }

  if(isDefined(var0["up"])) {
    self.upaimlimit = var0["up"];
  } else if(scripts\engine\utility::actor_is3d()) {
    self.upaimlimit = -65;
  } else {
    self.upaimlimit = -45;
  }

  if(isDefined(var0["down"])) {
    self.downaimlimit = var0["down"];
    return;
  }

  if(scripts\engine\utility::actor_is3d()) {
    self.downaimlimit = 65;
    return;
  }

  self.downaimlimit = 45;
}

function asm_getaimlimitset(var0, var1) {
  if(!isDefined(level.aimlimitstatemappings[var0])) {
    return "default";
  }

  if(!isDefined(level.aimlimitstatemappings[var0][var1])) {
    return "default";
  }

  return level.aimlimitstatemappings[var0][var1];
}

function asm_setstateaimlimits(var0, var1) {
  if(isDefined(self.ignoreaimsets) && self.ignoreaimsets) {
    return;
  }

  var2 = asm_getaimlimitset(var0, var1);

  if(!isDefined(level.combataimlimits[var0])) {
    asm_setaimlimits([]);
    return;
  }

  var3 = scripts\asm\asm::asm_isfrantic();

  if(var3 && isDefined(level.franticaimlimits[var0][var2])) {
    asm_setaimlimits(level.franticaimlimits[var0][var2]);
    return;
  } else if(isDefined(level.combataimlimits[var0][var2])) {
    asm_setaimlimits(level.combataimlimits[var0][var2]);
    return;
  }

  asm_setaimlimits([]);
}

function asm_setupaim_sp(var0, var1, var2, var3) {
  if(self asmcurrentstatehasaimset(var0)) {
    return;
  }

  if(istrue(self.runngun)) {
    return;
  }

  var4 = weaponclass(self.weapon);

  if(var4 == "none") {
    return;
  }

  if(scripts\asm\asm::asm_hasalias(var1, "aim_1")) {
    return;
  }

  if(!scripts\asm\asm::asm_hasalias(var1, var4 + "_aim_8")) {
    var4 = "rifle";
  }

  asm_setstateaimlimits(var0, var1);
  var5 = scripts\asm\asm::asm_isfrantic();
  var6 = self.asm.archetype;
  var7 = undefined;

  if(!isDefined(var3) || var3) {
    var8 = var4 + "_aim_5";
    var9 = scripts\asm\asm::asm_lookupanimfromaliasifexists(var1, var8);

    if(isDefined(var9)) {
      var7 = scripts\asm\asm::asm_getxanim(var1, var9);
    }
  }

  self setanimknoblimited(scripts\asm\asm::asm_getxanim(var1, archetypegetrandomalias(var6, var1, var4 + "_aim_8", var5)), 1, var2);
  self setanimknoblimited(scripts\asm\asm::asm_getxanim(var1, archetypegetrandomalias(var6, var1, var4 + "_aim_2", var5)), 1, var2);
  self setanimknoblimited(scripts\asm\asm::asm_getxanim(var1, archetypegetrandomalias(var6, var1, var4 + "_aim_4", var5)), 1, var2);
  self setanimknoblimited(scripts\asm\asm::asm_getxanim(var1, archetypegetrandomalias(var6, var1, var4 + "_aim_6", var5)), 1, var2);

  if(isDefined(var7)) {
    self setanimlimited(var7, 1, var2);
  }

  var10 = scripts\asm\asm::asm_lookupanimfromaliasifexists(var1, "aim_root");

  if(isDefined(var10)) {
    self setanim(scripts\asm\asm::asm_getxanim(var1, var10), 1, var2);
  } else {
    var10 = scripts\asm\asm::asm_lookupanimfromaliasifexists("knobs", "aim_root");

    if(isDefined(var10)) {
      self setanim(scripts\asm\asm::asm_getxanim("knobs", var10), 1, var2);
    }
  }

  var11 = scripts\asm\asm::asm_hasalias(var1, "aim_knob_2");

  if(var11) {
    self notify("StopCleanupAimKnobs");
    self.asm.track.aim_2 = scripts\asm\asm::asm_getxanim(var1, archetypegetrandomalias(var6, var1, "aim_knob_2", var5));
    self.asm.track.aim_4 = scripts\asm\asm::asm_getxanim(var1, archetypegetrandomalias(var6, var1, "aim_knob_4", var5));
    self.asm.track.aim_6 = scripts\asm\asm::asm_getxanim(var1, archetypegetrandomalias(var6, var1, "aim_knob_6", var5));
    self.asm.track.aim_8 = scripts\asm\asm::asm_getxanim(var1, archetypegetrandomalias(var6, var1, "aim_knob_8", var5));

    if(isDefined(var7)) {
      self.asm.track.aim_5 = scripts\asm\asm::asm_getxanim(var1, archetypegetrandomalias(var6, var1, "aim_knob_5", var5));
    }

    thread asm_cleanupaimknobsonterminate(var1);
  }

  scripts\asm\track::trackloop_restoreaim();
}

function asm_setupgesture(var0, var1) {
  var2 = scripts\asm\asm::asm_getdemeanor();
  var3 = scripts\asm\asm::asm_isfrantic();
  var4 = self.asm.gestures;
  var5 = self.asm.archetype;
  var4.gesture_moveup_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var5, "gesture_old", "gesture_move_up", var3));
  var4.gesture_armup_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var5, "gesture_old", "gesture_armup", var3));
  var4.gesture_onme_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var5, "gesture_old", "gesture_on_me", var3));
  var4.gesture_hold_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var5, "gesture_old", "gesture_hold", var3));
  var4.gesture_fallback_up_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var5, "gesture_old", "gesture_fallback_up", var3));
  var4.gesture_fallback_down_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var5, "gesture_old", "gesture_fallback_down", var3));

  if(var2 == "casual") {
    var4.gesture_point_center = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var5, "gesture_point", "gesture_point_center", var3));
    var4.gesture_point_left = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var5, "gesture_point", "gesture_point_left", var3));
    var4.gesture_point_right = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var5, "gesture_point", "gesture_point_right", var3));
    var4.gesture_point_up = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var5, "gesture_point", "gesture_point_up", var3));
    var4.gesture_point_down = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var5, "gesture_point", "gesture_point_down", var3));
    var4.gesture_shrug_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var5, "gesture_old", "gesture_shrug_anim", var3));
    var4.gesture_cross_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var5, "gesture_old", "gesture_cross_anim", var3));
    var4.gesture_nod_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var5, "gesture_old", "gesture_nod_anim", var3));
    var4.gesture_shake_head_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var5, "gesture_old", "gesture_shake_head_anim", var3));
    var4.gesture_salute_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var5, "gesture_old", "gesture_salute_anim", var3));
    var4.gesture_wave_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var5, "gesture_old", "gesture_wave_anim", var3));
    var4.gesture_wait_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var5, "gesture_old", "gesture_wait_anim", var3));
    return;
  }

  if(var2 == "casual_gun") {
    var4.gesture_point_center = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var5, "gesture_point", "gesture_casual_gun_point_center", var3));
    var4.gesture_point_left = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var5, "gesture_point", "gesture_casual_gun_point_left", var3));
    var4.gesture_point_right = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var5, "gesture_point", "gesture_casual_gun_point_right", var3));
    var4.gesture_point_up = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var5, "gesture_point", "gesture_casual_gun_point_up", var3));
    var4.gesture_point_down = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var5, "gesture_point", "gesture_casual_gun_point_down", var3));
    var4.gesture_shrug_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var5, "gesture_old", "gesture_gun_shrug_anim", var3));
    var4.gesture_cross_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var5, "gesture_old", "gesture_gun_cross_anim", var3));
    var4.gesture_nod_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var5, "gesture_old", "gesture_gun_nod_anim", var3));
    var4.gesture_shake_head_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var5, "gesture_old", "gesture_gun_shake_head_anim", var3));
    var4.gesture_salute_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var5, "gesture_old", "gesture_gun_salute_anim", var3));
    var4.gesture_wave_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var5, "gesture_old", "gesture_gun_wave_anim", var3));
    var4.gesture_wait_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var5, "gesture_old", "gesture_gun_wait_anim", var3));
    return;
  }

  var4.gesture_point_center = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var5, "gesture_point", "gesture_gun_point_center", var3));
  var4.gesture_point_left = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var5, "gesture_point", "gesture_gun_point_left", var3));
  var4.gesture_point_right = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var5, "gesture_point", "gesture_gun_point_right", var3));
  var4.gesture_point_up = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var5, "gesture_point", "gesture_gun_point_up", var3));
  var4.gesture_point_down = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var5, "gesture_point", "gesture_gun_point_down", var3));
  var4.gesture_shrug_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var5, "gesture_old", "gesture_gun_shrug_anim", var3));
  var4.gesture_cross_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var5, "gesture_old", "gesture_gun_cross_anim", var3));
  var4.gesture_nod_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var5, "gesture_old", "gesture_gun_nod_anim", var3));
  var4.gesture_shake_head_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var5, "gesture_old", "gesture_gun_shake_head_anim", var3));
  var4.gesture_salute_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var5, "gesture_old", "gesture_gun_salute_anim", var3));
  var4.gesture_wave_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var5, "gesture_old", "gesture_gun_wave_anim", var3));
  var4.gesture_wait_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var5, "gesture_old", "gesture_gun_wait_anim", var3));
}

function asm_cleanupaimknobswithdelay(var0, var1) {
  self endon("death");
  self endon("StopCleanupAimKnobs");
  scripts\engine\utility::waittill_any_timeout(var1, var0 + "_finished");
  asm_cleanupaimknobs();
}

function asm_cleanupaimknobsonterminate(var0) {
  self endon("death");
  self endon("StopCleanupAimKnobs");
  self waittill(var0 + "_finished");
  asm_cleanupaimknobs();
}

function asm_cleanupaimknobs() {
  if(!isDefined(self.asm.track)) {
    return;
  }

  self.asm.track.aim_2 = undefined;
  self.asm.track.aim_4 = undefined;
  self.asm.track.aim_6 = undefined;
  self.asm.track.aim_8 = undefined;
  self.asm.track.aim_5 = undefined;
}

function asm_animScripted(var0, var1, var2, var3, var4, var5, var6) {
  var7 = self.asmname;
  self asmsetstate(var7, "animscripted");
}

function asm_stopanimScripted() {
  self stopanimScripted();
}

function asm_animcustom(var0, var1) {
  scripts\asm\asm_bb::bb_setanimScripted();
  self.asm.animcustomender = var1;
  self animcustom(var0, &asm_animcustom_endanimscript);
  var2 = self.asmname;
  self asmsetstate(var2, "animscripted");
}

function asm_animcustom_endanimscript() {
  scripts\asm\asm_bb::bb_clearanimScripted();

  if(!isDefined(self.asm.animcustomender)) {
    return;
  }

  self[[self.asm.animcustomender]]();
  self.asm.animcustomender = undefined;
}

function asm_stopanimcustom() {
  self notify("killanimscript");
}

function open_door(var0, var1) {
  if(istrue(var0.bashed)) {
    return;
  }

  var0 scripts\sp\utility::door_force_open_fully(self, var1);
}

function door_needs_to_close(var0) {
  if(!istrue(var0.ajar)) {
    return false;
  }

  var1 = anglestoleft(var0.true_start_angles);
  var2 = var0 scripts\sp\door::get_door_angles();

  if(angleclamp180(var2[1] - var0.true_start_angles[1]) < 0) {
    var1 = -1 * var1;
  }

  var3 = var0 scripts\sp\door_internal::get_door_bottom_center();
  var4 = self.origin - var3;
  var5 = anglesToForward(var2);
  return vectordot(var1, var5) * vectordot(var1, var4) > 0;
}

function close_door(var0) {
  self endon("opening_door");
  var0 scripts\sp\door::door_close(self, 0.5, 0.1, 0.4);
}

function get_door_center(var0) {
  return var0 scripts\sp\door_internal::get_door_bottom_center();
}

function is_door_already_open(var0) {
  if(istrue(var0.open_completely)) {
    return true;
  }

  if(var0 scripts\sp\door_internal::door_is_open_at_least(60)) {
    return true;
  }

  return false;
}