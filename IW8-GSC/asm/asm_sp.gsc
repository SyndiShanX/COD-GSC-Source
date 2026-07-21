/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\asm_sp.gsc
***********************************************/

asm_init(var_0, var_1) {
  if(var_1 == "hero_salter" || var_1 == "farah" || var_1 == "soldier_female")
    scripts\asm\asm_bb::bb_setshort(1);

  self.asm = spawnStruct();
  self.asm.archetype = var_1;
  self.asm.animoverrides = [];
  self.asm.frantic = 0;
  self.asmname = var_0;
  self setanimset(var_1);
  self.fnasm_init = ::asm_init;
  self.fnasm_setupaim = ::asm_setupaim_sp;
  self.fnasm_setupgesture = ::asm_setupgesture;
  self.fnasm_playfacialanim = ::asm_playfacialanim_sp;
  self.fnasm_handlenotetrack = scripts\anim\notetracks_sp.gsc::handlenotetrack;
  self.fnasm_playadditiveanimloopstate = ::asm_playadditiveanimloopstate_sp;
  self.fnasm_clearfingerposes = ::asm_clearfingerposes;
  self.fnplaceweaponon = scripts\anim\shared.gsc::placeweaponon;
  self.fndooropen = ::open_door;
  self.fndoorclose = ::close_door;
  self.fndoorneedstoclose = ::door_needs_to_close;
  self.fngetdoorcenter = ::get_door_center;
  self.fndooralreadyopen = ::is_door_already_open;
  asmregistergenerichandler(var_0, scripts\asm\asm::asm_generichandler);
  self asminstantiate(var_0);
}

updatepainvars(var_0) {
  if(self.damageshield && !isDefined(self.disabledamageshieldpain)) {
    var_1 = 1500;

    if(!isDefined(self.a.lastpaintime))
      self.a.lastpaintime = 0;

    if(!isDefined(self.damageshieldcounter) || gettime() - self.a.lastpaintime > var_1)
      self.damageshieldcounter = randomintrange(2, 3);

    if(isDefined(self.lastattacker) && distancesquared(self.origin, self.lastattacker.origin) < squared(512))
      self.damageshieldcounter = 0;

    if(self.damageshieldcounter > 0)
      self.damageshieldcounter--;
  }

  if(isDefined(var_0))
    self.damagedsubpart = var_0;
  else
    self.damagedsubpart = undefined;
}

shouldplaypainanim() {
  if(isDefined(self.fnshouldplaypainanim))
    return self[[self.fnshouldplaypainanim]]();

  return shouldplaypainanimdefault();
}

shouldplaypainanimdefault() {
  var_0 = 4096;

  if(self.a.disablepain)
    return 0;

  if(isDefined(self.pathgoalpos) && self pathdisttogoal() < var_0)
    return 0;

  return 1;
}

deletehandler() {
  self endon("terminate_ai_threads");
  self waittill("entitydeleted");
  self notify("terminate_ai_threads");
}

paininternal() {
  if(1) {
    updatepainvars();

    if(!shouldplaypainanim()) {
      if(isDefined(self.script) && self.script == "pain")
        self notify("killanimscript");

      return;
    }

    var_0 = 0;
    var_1 = self asmevalpaintransition(self.asmname);

    if(isDefined(var_1) && var_1)
      var_0 = 1;

    if(!var_0 && self.script == "pain")
      self notify("killanimscript");
  }

  self endon("killanimscript");
  self waittill("Hellfreezesover");
}

subparthandler() {
  self endon("death");
  self endon("terminate_ai_threads");
}

asm_animhasfacialoverride(var_0) {
  if(!animisleaf(var_0))
    return 0;

  return animhasnotetrack(var_0, "facial_override");
}

asm_playfacialanim_sp(var_0, var_1, var_2) {
  if(var_0 != self.asmname) {
    return;
  }
  var_3 = self asmgetfacialstate();

  if(isDefined(var_3))
    asm_playfacialaniminternal(var_2, var_3);
  else {
    scripts\asm\asm::asm_clearfacialanim();
    self.asm.facial_state = "";
  }
}

asm_playfacialaniminternal(var_0, var_1) {
  if(!scripts\asm\shared\utility::isfacialstateallowed("asm")) {
    return;
  }
  if(isDefined(var_0) && asm_animhasfacialoverride(var_0)) {
    return;
  }
  var_2 = scripts\asm\asm::asm_lookupanimfromaliasifexists("knobs", "head");

  if(!isDefined(var_2)) {
    return;
  }
  if(!isDefined(self.asm.facial_state))
    self.asm.facial_state = "";

  scripts\asm\shared\utility::setfacialstate("asm");

  if(isai(self))
    self setfacialindex(var_1);
  else
    scripts\asm\shared\utility::setfacialindexfornonai(var_1);
}

asm_playfacialanimfromnotetrack(var_0) {
  var_1 = "";

  if(isDefined(self.asm))
    var_1 = self.asm.archetype;

  if(isDefined(self.animationarchetype))
    var_1 = self.animationarchetype;

  if(!scripts\asm\shared\utility::isfacialstateallowed("asm") && var_0 != "death") {
    return;
  }
  if(var_1 != "") {
    scripts\asm\shared\utility::setfacialstate("asm");

    if(isai(self))
      self setfacialindex(var_0);
    else
      scripts\asm\shared\utility::setfacialindexfornonai(var_0);
  }
}

asm_playfacialanimsingleframedeath(var_0) {
  if(isai(self))
    self setfacialindex("death");
  else
    scripts\asm\shared\utility::setfacialindexfornonai("death");
}

asm_initfingerposes() {
  self endon("death");
  var_0 = 0;
  var_1 = 0;
  var_2 = scripts\asm\asm::asm_lookupanimfromalias("knobs", "inner_root");
  var_3 = scripts\asm\asm::asm_getxanim("knobs", var_2);
  var_4 = 0;
  var_5 = 0;

  for(;;) {
    var_6 = self getanimikweights(var_3);
    var_7 = var_6[0] - var_0;
    var_8 = (var_7 > 0.001) - (var_7 < -0.001);

    if(var_8 != var_4) {
      if(var_8 > 0) {
        var_0 = var_6[0];
        var_4 = var_8;
        wait 0.1;
        asm_ikfingeranim("left");
        continue;
      }

      if(var_8 < 0) {
        var_0 = var_6[0];
        var_4 = var_8;
        asm_clearikfingeranim("left");
        continue;
      }
    }

    var_0 = var_6[0];
    var_4 = var_8;
    var_9 = var_6[1] - var_1;
    var_10 = (var_9 > 0.001) - (var_9 < -0.001);

    if(var_10 != var_5) {
      if(var_10 > 0) {
        var_1 = var_6[1];
        var_5 = var_10;
        wait 0.1;
        asm_ikfingeranim("right");
        continue;
      }

      if(var_10 < 0) {
        var_1 = var_6[1];
        var_5 = var_10;
        asm_clearikfingeranim("right");
        continue;
      }
    }

    var_1 = var_6[1];
    var_5 = var_10;
    wait 0.05;
  }
}

asm_clearfingerposes() {
  asm_clearikfingeranim("left");
  asm_clearikfingeranim("right");
}

asm_ikfingeranim(var_0) {
  var_1 = scripts\anim\utility.gsc::getaicurrentweapon();

  if(nullweapon(var_1))
    asm_clearikfingeranim(var_0);

  asm_playikfingeranim(var_0);
}

asm_playikfingeranim(var_0) {
  var_1 = scripts\anim\utility.gsc::getaicurrentweapon();

  if(nullweapon(var_1)) {
    return;
  }
  var_2 = "ik_finger_pose_r";
  var_3 = "ik_fingers_r";
  var_4 = getweaponbasename(var_1);

  if(var_0 == "left") {
    var_2 = "ik_finger_pose_l";
    var_3 = "ik_fingers_l";
    var_5 = getweaponattachments(var_1);

    if(isDefined(var_5)) {
      foreach(var_7 in var_5) {
        var_8 = getsubstr(var_7, 0, 7);

        if(var_8 == "ub_mike")
          var_4 = "iw8_ub_mike";

        if(var_8 == "ub_golf")
          var_4 = "iw8_ub_golf";

        if(var_8 == "gripang")
          var_4 = "iw8_gripang";

        if(var_8 == "gripver")
          var_4 = "iw8_gripver";
      }
    }
  }

  if(!asm_hasstatesp(self.asm.archetype, var_2)) {
    return;
  }
  if(!isDefined(var_4) || !scripts\asm\asm::asm_hasalias(var_2, var_4)) {
    if(!isDefined(var_4))
      var_4 = "UNDEFINED";

    return;
  }

  var_10 = scripts\asm\asm::asm_getxanim(var_2, scripts\asm\asm::asm_lookupanimfromalias(var_2, var_4));
  var_11 = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", var_3));
  self setanim(var_11, 1, 0.3, 1.0);
  self setanim(var_10, 1, 0.3, 1.0);
}

asm_clearikfingeranim(var_0) {
  var_1 = "ik_fingers_l";

  if(var_0 == "right")
    var_1 = "ik_fingers_r";

  if(!scripts\asm\asm::asm_hasalias("knobs", var_1)) {
    return;
  }
  var_2 = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", var_1));
  self clearanim(var_2, 0.3, 1.0);
}

asm_playvisorraise(var_0) {
  if(isDefined(var_0))
    var_1 = 1;
  else {
    var_1 = 0;
    var_0 = "";
  }

  asm_trynvgmodelswap();
  asm_clearvisoranim();
  var_2 = scripts\asm\asm::asm_getxanim("visor", scripts\asm\asm::asm_lookupanimfromalias("visor", "helmet_visor_up" + var_0));

  if(self.visor_down == 0) {
    if(var_1)
      return;
    else
      self setanim(var_2, 1, 0, 1.0);
  } else {
    var_3 = scripts\asm\asm::asm_getxanim("visor", scripts\asm\asm::asm_lookupanimfromalias("visor", "helmet_visor_down" + var_0));
    self setanim(var_3, 1, 0, 1.0);

    if(!var_1)
      wait(getanimlength(var_3) - 0.1);
  }
}

asm_trynvgmodelswap() {
  if(!isDefined(self.nvgmodel_on)) {
    return;
  }
  var_0 = self.headmodel;

  if(isDefined(self.hatmodel))
    var_0 = self.hatmodel;

  if(self.visor_down == 0 && var_0 == self.nvgmodel_on) {
    if(isDefined(self.hatmodel)) {
      self detach(self.hatmodel);
      self.hatmodel = self.nvgmodel_off;
      self attach(self.hatmodel);
    } else {
      self detach(self.headmodel);
      self.headmodel = self.nvgmodel_off;
      self attach(self.headmodel);
    }
  } else if(var_0 == self.nvgmodel_off) {
    if(isDefined(self.hatmodel)) {
      self detach(self.hatmodel);
      self.hatmodel = self.nvgmodel_on;
      self attach(self.hatmodel);
    } else {
      self detach(self.headmodel);
      self.headmodel = self.nvgmodel_on;
      self attach(self.headmodel);
    }
  }
}

asm_clearvisoranim() {
  asm_trynvgmodelswap();
  var_0 = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", "visor"));
  self clearanim(var_0, 0);
}

asm_hasstatesp(var_0, var_1) {
  if(archetypeassetloaded(var_0))
    return archetypehasstate(var_0, var_1);
  else
    return 0;
}

asm_playadditiveanimloopstate_sp(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = scripts\asm\asm::asm_getbodyknob();
  var_4 = 0;
  var_5 = 0.2;

  for(;;) {
    var_6 = scripts\asm\asm::asm_getxanim(var_1, scripts\asm\asm::asm_getanim(var_0, var_1));

    if(var_3 != var_6) {
      if(var_4)
        self setflaggedanimknoblimitedrestart(var_1, var_6, 1.0, var_5, 1.0);
      else
        self setflaggedanimknobrestart(var_1, var_6, 1.0, var_5, 1.0);

      var_3 = var_6;
    }

    thread asm_playadditiveanimloopstate_helper(var_1, var_6, var_4);
    scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_6);
    scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1));
    self notify(var_1 + "additive_cancel");
  }
}

asm_playadditiveanimloopstate_helper(var_0, var_1, var_2) {
  self endon(var_0 + "_finished");
  self endon(var_0 + "additive_cancel");

  while(isDefined(var_1)) {
    wait 0.2;

    if(var_2) {
      self setflaggedanimlimited(var_0, var_1, 1.0, 0, 1.0);
      continue;
    }

    self setflaggedanim(var_0, var_1, 1.0, 0, 1.0);
  }
}

asm_setaimlimits(var_0) {
  if(isDefined(var_0["left"]))
    self.leftaimlimit = var_0["left"];
  else if(scripts\engine\utility::actor_is3d())
    self.leftaimlimit = 56;
  else
    self.leftaimlimit = 45;

  if(isDefined(var_0["right"]))
    self.rightaimlimit = var_0["right"];
  else if(scripts\engine\utility::actor_is3d())
    self.rightaimlimit = -56;
  else
    self.rightaimlimit = -45;

  if(isDefined(var_0["up"]))
    self.upaimlimit = var_0["up"];
  else if(scripts\engine\utility::actor_is3d())
    self.upaimlimit = -65;
  else
    self.upaimlimit = -45;

  if(isDefined(var_0["down"]))
    self.downaimlimit = var_0["down"];
  else if(scripts\engine\utility::actor_is3d())
    self.downaimlimit = 65;
  else
    self.downaimlimit = 45;
}

asm_getaimlimitset(var_0, var_1) {
  if(!isDefined(level.aimlimitstatemappings[var_0]))
    return "default";

  if(!isDefined(level.aimlimitstatemappings[var_0][var_1]))
    return "default";

  return level.aimlimitstatemappings[var_0][var_1];
}

asm_setstateaimlimits(var_0, var_1) {
  if(isDefined(self.ignoreaimsets) && self.ignoreaimsets) {
    return;
  }
  var_2 = asm_getaimlimitset(var_0, var_1);

  if(!isDefined(level.combataimlimits[var_0])) {
    asm_setaimlimits([]);
    return;
  }

  var_3 = scripts\asm\asm::asm_isfrantic();

  if(var_3 && isDefined(level.franticaimlimits[var_0][var_2])) {
    asm_setaimlimits(level.franticaimlimits[var_0][var_2]);
    return;
  } else if(isDefined(level.combataimlimits[var_0][var_2])) {
    asm_setaimlimits(level.combataimlimits[var_0][var_2]);
    return;
  }

  asm_setaimlimits([]);
}

asm_setupaim_sp(var_0, var_1, var_2, var_3) {
  if(self asmcurrentstatehasaimset(var_0)) {
    return;
  }
  if(istrue(self.runngun)) {
    return;
  }
  var_4 = weaponclass(self.weapon);

  if(var_4 == "none") {
    return;
  }
  if(scripts\asm\asm::asm_hasalias(var_1, "aim_1")) {
    return;
  }
  if(!scripts\asm\asm::asm_hasalias(var_1, var_4 + "_aim_8"))
    var_4 = "rifle";

  asm_setstateaimlimits(var_0, var_1);
  var_5 = scripts\asm\asm::asm_isfrantic();
  var_6 = self.asm.archetype;
  var_7 = undefined;

  if(!isDefined(var_3) || var_3) {
    var_8 = var_4 + "_aim_5";
    var_9 = scripts\asm\asm::asm_lookupanimfromaliasifexists(var_1, var_8);

    if(isDefined(var_9))
      var_7 = scripts\asm\asm::asm_getxanim(var_1, var_9);
  }

  self setanimknoblimited(scripts\asm\asm::asm_getxanim(var_1, archetypegetrandomalias(var_6, var_1, var_4 + "_aim_8", var_5)), 1, var_2);
  self setanimknoblimited(scripts\asm\asm::asm_getxanim(var_1, archetypegetrandomalias(var_6, var_1, var_4 + "_aim_2", var_5)), 1, var_2);
  self setanimknoblimited(scripts\asm\asm::asm_getxanim(var_1, archetypegetrandomalias(var_6, var_1, var_4 + "_aim_4", var_5)), 1, var_2);
  self setanimknoblimited(scripts\asm\asm::asm_getxanim(var_1, archetypegetrandomalias(var_6, var_1, var_4 + "_aim_6", var_5)), 1, var_2);

  if(isDefined(var_7))
    self setanimlimited(var_7, 1, var_2);

  var_10 = scripts\asm\asm::asm_lookupanimfromaliasifexists(var_1, "aim_root");

  if(isDefined(var_10))
    self setanim(scripts\asm\asm::asm_getxanim(var_1, var_10), 1, var_2);
  else {
    var_10 = scripts\asm\asm::asm_lookupanimfromaliasifexists("knobs", "aim_root");

    if(isDefined(var_10))
      self setanim(scripts\asm\asm::asm_getxanim("knobs", var_10), 1, var_2);
  }

  var_11 = scripts\asm\asm::asm_hasalias(var_1, "aim_knob_2");

  if(var_11) {
    self notify("StopCleanupAimKnobs");
    self.asm.track.aim_2 = scripts\asm\asm::asm_getxanim(var_1, archetypegetrandomalias(var_6, var_1, "aim_knob_2", var_5));
    self.asm.track.aim_4 = scripts\asm\asm::asm_getxanim(var_1, archetypegetrandomalias(var_6, var_1, "aim_knob_4", var_5));
    self.asm.track.aim_6 = scripts\asm\asm::asm_getxanim(var_1, archetypegetrandomalias(var_6, var_1, "aim_knob_6", var_5));
    self.asm.track.aim_8 = scripts\asm\asm::asm_getxanim(var_1, archetypegetrandomalias(var_6, var_1, "aim_knob_8", var_5));

    if(isDefined(var_7))
      self.asm.track.aim_5 = scripts\asm\asm::asm_getxanim(var_1, archetypegetrandomalias(var_6, var_1, "aim_knob_5", var_5));

    thread asm_cleanupaimknobsonterminate(var_1);
  }

  scripts\asm\track::trackloop_restoreaim();
}

asm_setupgesture(var_0, var_1) {
  var_2 = scripts\asm\asm::asm_getdemeanor();
  var_3 = scripts\asm\asm::asm_isfrantic();
  var_4 = self.asm.gestures;
  var_5 = self.asm.archetype;
  var_4.gesture_moveup_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var_5, "gesture_old", "gesture_move_up", var_3));
  var_4.gesture_armup_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var_5, "gesture_old", "gesture_armup", var_3));
  var_4.gesture_onme_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var_5, "gesture_old", "gesture_on_me", var_3));
  var_4.gesture_hold_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var_5, "gesture_old", "gesture_hold", var_3));
  var_4.gesture_fallback_up_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var_5, "gesture_old", "gesture_fallback_up", var_3));
  var_4.gesture_fallback_down_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var_5, "gesture_old", "gesture_fallback_down", var_3));

  if(var_2 == "casual") {
    var_4.gesture_point_center = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var_5, "gesture_point", "gesture_point_center", var_3));
    var_4.gesture_point_left = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var_5, "gesture_point", "gesture_point_left", var_3));
    var_4.gesture_point_right = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var_5, "gesture_point", "gesture_point_right", var_3));
    var_4.gesture_point_up = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var_5, "gesture_point", "gesture_point_up", var_3));
    var_4.gesture_point_down = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var_5, "gesture_point", "gesture_point_down", var_3));
    var_4.gesture_shrug_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var_5, "gesture_old", "gesture_shrug_anim", var_3));
    var_4.gesture_cross_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var_5, "gesture_old", "gesture_cross_anim", var_3));
    var_4.gesture_nod_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var_5, "gesture_old", "gesture_nod_anim", var_3));
    var_4.gesture_shake_head_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var_5, "gesture_old", "gesture_shake_head_anim", var_3));
    var_4.gesture_salute_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var_5, "gesture_old", "gesture_salute_anim", var_3));
    var_4.gesture_wave_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var_5, "gesture_old", "gesture_wave_anim", var_3));
    var_4.gesture_wait_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var_5, "gesture_old", "gesture_wait_anim", var_3));
  } else if(var_2 == "casual_gun") {
    var_4.gesture_point_center = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var_5, "gesture_point", "gesture_casual_gun_point_center", var_3));
    var_4.gesture_point_left = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var_5, "gesture_point", "gesture_casual_gun_point_left", var_3));
    var_4.gesture_point_right = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var_5, "gesture_point", "gesture_casual_gun_point_right", var_3));
    var_4.gesture_point_up = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var_5, "gesture_point", "gesture_casual_gun_point_up", var_3));
    var_4.gesture_point_down = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var_5, "gesture_point", "gesture_casual_gun_point_down", var_3));
    var_4.gesture_shrug_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var_5, "gesture_old", "gesture_gun_shrug_anim", var_3));
    var_4.gesture_cross_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var_5, "gesture_old", "gesture_gun_cross_anim", var_3));
    var_4.gesture_nod_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var_5, "gesture_old", "gesture_gun_nod_anim", var_3));
    var_4.gesture_shake_head_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var_5, "gesture_old", "gesture_gun_shake_head_anim", var_3));
    var_4.gesture_salute_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var_5, "gesture_old", "gesture_gun_salute_anim", var_3));
    var_4.gesture_wave_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var_5, "gesture_old", "gesture_gun_wave_anim", var_3));
    var_4.gesture_wait_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var_5, "gesture_old", "gesture_gun_wait_anim", var_3));
  } else {
    var_4.gesture_point_center = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var_5, "gesture_point", "gesture_gun_point_center", var_3));
    var_4.gesture_point_left = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var_5, "gesture_point", "gesture_gun_point_left", var_3));
    var_4.gesture_point_right = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var_5, "gesture_point", "gesture_gun_point_right", var_3));
    var_4.gesture_point_up = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var_5, "gesture_point", "gesture_gun_point_up", var_3));
    var_4.gesture_point_down = scripts\asm\asm::asm_getxanim("gesture_point", archetypegetrandomalias(var_5, "gesture_point", "gesture_gun_point_down", var_3));
    var_4.gesture_shrug_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var_5, "gesture_old", "gesture_gun_shrug_anim", var_3));
    var_4.gesture_cross_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var_5, "gesture_old", "gesture_gun_cross_anim", var_3));
    var_4.gesture_nod_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var_5, "gesture_old", "gesture_gun_nod_anim", var_3));
    var_4.gesture_shake_head_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var_5, "gesture_old", "gesture_gun_shake_head_anim", var_3));
    var_4.gesture_salute_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var_5, "gesture_old", "gesture_gun_salute_anim", var_3));
    var_4.gesture_wave_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var_5, "gesture_old", "gesture_gun_wave_anim", var_3));
    var_4.gesture_wait_anim = scripts\asm\asm::asm_getxanim("gesture_old", archetypegetrandomalias(var_5, "gesture_old", "gesture_gun_wait_anim", var_3));
  }
}

asm_cleanupaimknobswithdelay(var_0, var_1) {
  self endon("death");
  self endon("StopCleanupAimKnobs");
  scripts\engine\utility::waittill_any_timeout(var_1, var_0 + "_finished");
  asm_cleanupaimknobs();
}

asm_cleanupaimknobsonterminate(var_0) {
  self endon("death");
  self endon("StopCleanupAimKnobs");
  self waittill(var_0 + "_finished");
  asm_cleanupaimknobs();
}

asm_cleanupaimknobs() {
  if(!isDefined(self.asm.track)) {
    return;
  }
  self.asm.track.aim_2 = undefined;
  self.asm.track.aim_4 = undefined;
  self.asm.track.aim_6 = undefined;
  self.asm.track.aim_8 = undefined;
  self.asm.track.aim_5 = undefined;
}

asm_animScripted(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = self.asmname;
  self asmsetstate(var_7, "animscripted");
}

asm_stopanimScripted() {
  self stopanimScripted();
}

asm_animcustom(var_0, var_1) {
  scripts\asm\asm_bb::bb_setanimScripted();
  self.asm.animcustomender = var_1;
  self animcustom(var_0, ::asm_animcustom_endanimscript);
  var_2 = self.asmname;
  self asmsetstate(var_2, "animscripted");
}

asm_animcustom_endanimscript() {
  scripts\asm\asm_bb::bb_clearanimScripted();

  if(!isDefined(self.asm.animcustomender)) {
    return;
  }
  self[[self.asm.animcustomender]]();
  self.asm.animcustomender = undefined;
}

asm_stopanimcustom() {
  self notify("killanimscript");
}

open_door(var_0, var_1) {
  if(istrue(var_0.bashed)) {
    return;
  }
  var_0 scripts\sp\utility::door_force_open_fully(self, var_1);
}

door_needs_to_close(var_0) {
  if(!istrue(var_0.ajar))
    return 0;

  var_1 = anglestoleft(var_0.true_start_angles);
  var_2 = var_0 scripts\sp\door::get_door_angles();

  if(angleclamp180(var_2[1] - var_0.true_start_angles[1]) < 0)
    var_1 = -1 * var_1;

  var_3 = var_0 scripts\sp\door_internal::get_door_bottom_center();
  var_4 = self.origin - var_3;
  var_5 = anglesToForward(var_2);
  return vectordot(var_1, var_5) * vectordot(var_1, var_4) > 0;
}

close_door(var_0) {
  self endon("opening_door");
  var_0 scripts\sp\door::door_close(self, 0.5, 0.1, 0.4);
}

get_door_center(var_0) {
  return var_0 scripts\sp\door_internal::get_door_bottom_center();
}

is_door_already_open(var_0) {
  if(istrue(var_0.open_completely))
    return 1;

  if(var_0 scripts\sp\door_internal::door_is_open_at_least(60))
    return 1;

  return 0;
}