/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\zombie_dlc1\zombie_dlc1.gsc
***************************************************/

playtraverseanimz_dlc1(var_0, var_1, var_2, var_3) {
  scripts\anim\notetracks_mp::setstatelocked(1, "DoTraverse");
  var_4 = self.do_immediate_ragdoll;
  self.do_immediate_ragdoll = 1;
  dotraverseanim_dlc1(var_0, var_1, var_2, var_3);
  self.do_immediate_ragdoll = var_4;
  self scragentsetanimscale(1, 1);
  scripts\anim\notetracks_mp::setstatelocked(0, "Traverse end_script");
  self.hastraversed = 1;
  self.traversalvector = undefined;
}

removezfromvec(var_0) {
  return (var_0[0], var_0[1], 0);
}

dotraverseanim_dlc1(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_4 = self _meth_8148();
  var_5 = self _meth_8146();
  self.endnode_pos = var_5;

  if(!isDefined(var_4)) {
    return;
  }
  if(!isDefined(var_5)) {
    return;
  }
  self._id_6378 = var_5;
  self.traversalvector = vectorNormalize(var_5 - var_4.origin);
  var_6 = undefined;
  var_6 = var_4.animscript;

  if(var_1 == "traverse_external")
    var_6 = var_1;

  if(needscrawlinganimstate_dlc1(var_6))
    var_6 = "crawling_" + var_6;

  if(self.agent_type == "lumberjack")
    var_6 = var_6 + "_norestart";

  if(!isDefined(var_6)) {
    return;
  }
  self.is_traversing = 1;
  var_7 = scripts\asm\asm_mp::asm_getanim(var_0, var_6);
  var_8 = var_5 - var_4.origin;
  var_9 = (var_8[0], var_8[1], 0);
  var_10 = vectortoangles(var_9);
  var_11 = issubstr(var_6, "jump_across");
  var_12 = var_6 == "traverse_boost" && (self.species == "humanoid" || self.species == "zombie");
  self orientmode("face angle abs", var_10);
  self _meth_8281("anim deltas");
  var_13 = self getanimentry(var_6, var_7);
  var_14 = "flex_height_up_start";
  var_15 = getnotetracktimes(var_13, var_14);

  if(var_15.size == 0) {
    var_14 = "flex_height_start";
    var_15 = getnotetracktimes(var_13, var_14);

    if(var_15.size == 0) {
      var_14 = "traverse_jump_start";
      var_15 = getnotetracktimes(var_13, var_14);
    }
  }

  var_16 = "flex_height_up_end";
  var_17 = getnotetracktimes(var_13, var_16);

  if(var_17.size == 0) {
    var_16 = "flex_height_end";
    var_17 = getnotetracktimes(var_13, var_16);

    if(var_17.size == 0) {
      var_16 = "traverse_jump_end";
      var_17 = getnotetracktimes(var_13, var_16);
    }
  }

  var_18 = "highest_point";
  var_19 = getnotetracktimes(var_13, var_18);
  var_20 = "flex_height_down_start";
  var_21 = getnotetracktimes(var_13, var_20);
  var_22 = "flex_height_down_end";
  var_23 = getnotetracktimes(var_13, var_22);
  var_24 = "crawler_early_stop";
  var_25 = getnotetracktimes(var_13, var_24);
  var_26 = getnotetracktimes(var_13, "code_move");

  if(var_26.size > 0)
    var_27 = getmovedelta(var_13, 0, var_26[0]);
  else
    var_27 = getmovedelta(var_13, 0, 1);

  var_28 = scripts\anim\notetracks_mp::_id_7DC9(var_8, var_27);
  var_29 = animhasnotetrack(var_13, "ignoreanimscaling");

  if(var_29)
    var_28._id_13E2B = 1.0;

  self scragentsetphysicsmode("noclip");
  var_30 = self _meth_8145();

  if(isDefined(var_30) && isDefined(var_30.target)) {
    self.endnode = var_30;
    var_31 = scripts\engine\utility::getStruct(self.endnode.target, "targetname");

    if(var_19.size > 0) {
      scripts\anim\notetracks_mp::_id_5AC1(var_6, var_7, var_13, "traverse", var_14, var_18, 0, ::zombietraversenotetrackhandler_dlc1);
      var_31 = scripts\engine\utility::getStruct(self.endnode.target, "targetname");

      if(isDefined(var_31.script_noteworthy) && var_31.script_noteworthy == "continue_flex_height")
        scripts\anim\notetracks_mp::_id_5AC1(var_6, var_7, var_13, "traverse", var_18, var_16, 1, ::zombietraversenotetrackhandler_dlc1);

      self scragentsetanimscale(1.0, 1.0);
      scripts\anim\notetracks_mp::_id_CED5(var_6, var_7, "traverse", "end", ::zombietraversenotetrackhandler_dlc1);
    } else if(var_21.size == 0) {
      scripts\anim\notetracks_mp::_id_5AC1(var_6, var_7, var_13, "traverse", var_14, var_16, 0, ::zombietraversenotetrackhandler_dlc1);
      self scragentsetanimscale(1.0, 1.0);
      scripts\anim\notetracks_mp::_id_CED5(var_6, var_7, "traverse", "end", ::zombietraversenotetrackhandler_dlc1);
    } else if(var_15.size == 0) {
      scripts\anim\notetracks_mp::_id_CED5(var_6, var_7, "traverse", "flex_height_down_start", ::zombietraversenotetrackhandler_dlc1);
      scripts\anim\notetracks_mp::_id_5AC1(var_6, var_7, var_13, "traverse", var_20, var_22, 0, ::zombietraversenotetrackhandler_dlc1);
      self scragentsetanimscale(1.0, 1.0);
      scripts\anim\notetracks_mp::_id_CED5(var_6, var_7, "traverse", "end", ::zombietraversenotetrackhandler_dlc1);
    } else {
      var_32 = scripts\engine\utility::getStruct(self.endnode.target, "targetname");
      var_31 = var_32.origin;
      var_33 = var_17[0];
      scripts\anim\notetracks_mp::_id_5AC2(var_6, var_7, "traverse", var_13, var_14, var_16, var_31, var_33, ::zombietraversenotetrackhandler_dlc1);
      var_34 = getanimlength(var_13);

      if(var_21[0] - var_17[0] >= 0.05 / var_34) {
        self scragentsetanimscale(1.0, 1.0);
        scripts\anim\notetracks_mp::_id_CED5(var_6, var_7, "traverse", var_20, ::zombietraversenotetrackhandler_dlc1);
      }

      var_31 = self.endnode.origin;
      var_33 = var_23[0];
      scripts\anim\notetracks_mp::_id_5AC2(var_6, var_7, "traverse", var_13, var_20, var_22, var_31, var_33, ::zombietraversenotetrackhandler_dlc1);
      self scragentsetanimscale(1.0, 1.0);

      if(var_25.size == 0 || !scripts\engine\utility::is_true(self.dismember_crawl))
        scripts\anim\notetracks_mp::_id_CED5(var_6, var_7, "traverse", "end", ::zombietraversenotetrackhandler_dlc1);
    }

    self.endnode = undefined;
  } else if(var_21.size > 0 && var_23.size > 0 && self.agent_type != "zombie_brute") {
    self scragentsetanimscale(1.0, 1.0);
    scripts\anim\notetracks_mp::_id_CED5(var_6, var_7, "traverse", var_20, ::zombietraversenotetrackhandler_dlc1);
    var_33 = var_23[0];

    if(!isDefined(var_30))
      var_31 = var_5;
    else
      var_31 = var_30.origin;

    scripts\anim\notetracks_mp::_id_5AC2(var_6, var_7, "traverse", var_13, var_20, var_22, var_31, var_33, ::zombietraversenotetrackhandler_dlc1);

    if(var_25.size == 0 || !scripts\engine\utility::is_true(self.dismember_crawl))
      scripts\anim\notetracks_mp::_id_CED5(var_6, var_7, "traverse", "end", ::zombietraversenotetrackhandler_dlc1);
  } else if(var_11 && abs(var_8[2]) < 64) {
    if(var_15.size != 1)
      var_15 = getnotetracktimes(var_13, "flex_across_start");

    if(var_17.size != 1)
      var_17 = getnotetracktimes(var_13, "flex_across_end");

    var_34 = getanimlength(var_13);
    var_35 = var_15[0] * var_34;
    var_36 = var_17[0] * var_34;
    self scragentsetanimscale(1, 1);
    scripts\anim\notetracks_mp::_id_CED3(var_6, var_7, self.traverseratescale, "traverse", "flex_across_start");
    var_37 = removezfromvec(getmovedelta(var_13, var_15[0], var_17[0]));
    var_38 = distance2d(self.origin, var_5);
    var_39 = getmovedelta(var_13, var_15[0], 1);
    var_40 = length2d(var_39);
    var_41 = var_38 - var_40;
    var_42 = length2d(var_37);

    if(var_42 < 0.01)
      var_42 = 1.0;

    var_43 = (var_41 + var_42) / var_42;
    self scragentsetanimscale(var_43, 0);
    childthread traverse_lerp_z_over_time_dlc1(var_4.origin[2], var_5[2], (var_36 - var_35) / self.traverseratescale);
    scripts\anim\notetracks_mp::_id_CED3(var_6, var_7, self.traverseratescale, "traverse", "flex_across_end");
    self scragentsetanimscale(1, 1);
    scripts\anim\notetracks_mp::_id_CED3(var_6, var_7, self.traverseratescale, "traverse");
  } else if(var_8[2] > 16) {
    if(var_27[2] > 0) {
      if(var_12) {
        self scragentsetanimscale(var_28._id_13E2B, var_28.z);
        var_44 = clamp(2 / var_28.z, 0.5, 1);

        if(var_17.size > 0) {
          scripts\anim\notetracks_mp::_id_CED3(var_6, var_7, var_44 * self.traverseratescale, "traverse", var_16);
          scripts\anim\notetracks_mp::setstatelocked(0, "DoTraverse");
          scripts\anim\notetracks_mp::_id_F2B1(var_6, var_7, self.traverseratescale);
          scripts\anim\notetracks_mp::_id_1384D("traverse", "code_move");
        } else
          scripts\anim\notetracks_mp::_id_CED3(var_6, var_7, self.traverseratescale, "traverse");

        self scragentsetanimscale(1, 1);
      } else if(var_15.size > 0) {
        var_28._id_13E2B = 1;
        var_28.z = 1;

        if(!var_29 && length2dsquared(var_9) < 0.64 * length2dsquared(var_27))
          var_28._id_13E2B = 0.4;

        self scragentsetanimscale(var_28._id_13E2B, var_28.z);
        scripts\anim\notetracks_mp::_id_CED3(var_6, var_7, self.traverseratescale, "traverse", var_14);
        var_45 = getmovedelta(var_13, 0, var_15[0]);
        var_46 = getmovedelta(var_13, 0, var_17[0]);
        var_28._id_13E2B = 1;
        var_28.z = 1;
        var_47 = var_5 - self.origin;
        var_48 = var_27 - var_45;

        if(!var_29 && length2dsquared(var_47) < 0.5625 * length2dsquared(var_48))
          var_28._id_13E2B = 0.75;

        var_49 = var_27 - var_46;
        var_50 = (var_49[0] * var_28._id_13E2B, var_49[1] * var_28._id_13E2B, var_49[2] * var_28.z);
        var_51 = rotatevector(var_50, var_10);
        var_52 = var_5 - var_51;
        var_53 = var_46 - var_45;
        var_54 = rotatevector(var_53, var_10);
        var_55 = var_52 - self.origin;
        var_56 = var_28;
        var_28 = scripts\anim\notetracks_mp::_id_7DC9(var_55, var_54, 1);

        if(var_29)
          var_28._id_13E2B = 1.0;

        if(var_55[2] <= 0)
          var_28.z = 0.0;

        self scragentsetanimscale(var_28._id_13E2B, var_28.z);
        scripts\anim\notetracks_mp::_id_1384D("traverse", var_16);
        scripts\anim\notetracks_mp::setstatelocked(0, "DoTraverse");
        var_28 = var_56;
        self scragentsetanimscale(var_28._id_13E2B, var_28.z);
        scripts\anim\notetracks_mp::_id_1384D("traverse", "code_move");
      } else {
        self scragentsetanimscale(var_28._id_13E2B, var_28.z);
        scripts\anim\notetracks_mp::_id_CED3(var_6, var_7, self.traverseratescale, "traverse");
      }
    } else
      scripts\anim\notetracks_mp::_id_5AC1(var_6, var_7, var_13, "traverse", "flex_height_start", "flex_height_end", 1, ::zombietraversenotetrackhandler_dlc1);
  } else if(abs(var_8[2]) < 16 || var_27[2] == 0) {
    self scragentsetanimscale(var_28._id_13E2B, var_28.z);
    var_44 = clamp(2 / var_28.z, 0.5, 1);

    if(var_17.size > 0) {
      scripts\anim\notetracks_mp::_id_CED3(var_6, var_7, var_44 * self.traverseratescale, "traverse", var_16);
      scripts\anim\notetracks_mp::setstatelocked(0, "DoTraverse");
      scripts\anim\notetracks_mp::_id_F2B1(var_6, var_7, self.traverseratescale);
      scripts\anim\notetracks_mp::_id_1384D("traverse", "code_move");
    } else
      scripts\anim\notetracks_mp::_id_CED3(var_6, var_7, self.traverseratescale, "traverse");

    self scragentsetanimscale(1, 1);
  } else if(var_27[2] < 0) {
    self scragentsetanimscale(var_28._id_13E2B, var_28.z);
    var_44 = clamp(2 / var_28.z, 0.5, 1);

    if(var_15.size > 0)
      scripts\anim\notetracks_mp::_id_CED3(var_6, var_7, self.traverseratescale, "traverse", var_14);

    if(var_17.size > 0) {
      scripts\anim\notetracks_mp::_id_CED3(var_6, var_7, var_44 * 1.0, "traverse", var_16);
      scripts\anim\notetracks_mp::_id_F2B1(var_6, var_7, self.traverseratescale);

      if(animhasnotetrack(var_13, "removestatelock"))
        scripts\anim\notetracks_mp::_id_1384D("traverse", "removestatelock");

      scripts\anim\notetracks_mp::setstatelocked(0, "DoTraverse");
      scripts\anim\notetracks_mp::_id_1384D("traverse", "code_move");
    } else
      scripts\anim\notetracks_mp::_id_CED3(var_6, var_7, 1.0, "traverse");

    self scragentsetanimscale(1, 1);
  } else {}

  lerptoabovegrounddlc1();
  self scragentsetphysicsmode("gravity");
  self.is_traversing = undefined;
  self notify("traverse_end");
  terminatetraverse_dlc1(var_0, var_1);
}

lerptoabovegrounddlc1() {
  var_0 = 0.1;
  var_1 = self._id_6378;
  var_2 = var_1[2];
  var_3 = self.origin[2];

  if(var_3 < var_2)
    self setOrigin((self.origin[0], self.origin[1], var_2 + var_0), 0);
}

terminatetraverse_dlc1(var_0, var_1) {
  var_2 = anim.asm[var_0].states[var_1];
  var_3 = undefined;

  if(isDefined(var_2._id_116FB)) {
    if(isarray(var_2._id_116FB[0]))
      var_3 = var_2._id_116FB[0];
    else
      var_3 = var_2._id_116FB;
  }

  scripts\asm\asm::_id_2388(var_0, var_1, var_2, var_2._id_116FB);
  scripts\asm\asm::_id_238A(var_0, var_3, 0.2, undefined, undefined, undefined);
  self notify("killanimscript");
}

traverse_lerp_z_over_time_dlc1(var_0, var_1, var_2) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_3 = gettime();

  for(;;) {
    var_4 = (gettime() - var_3) / 1000.0;
    var_5 = var_4 / var_2;

    if(var_5 > 1.0) {
      break;
    }

    var_6 = scripts\mp\agents\zombie\zombie_util::_id_AB6F(var_5, var_0, var_1);
    self setOrigin((self.origin[0], self.origin[1], var_6), 0);
    wait 0.05;
  }
}

needscrawlinganimstate_dlc1(var_0) {
  if(self.dismember_crawl)
    return 1;

  return 0;
}

zombietraversenotetrackhandler_dlc1(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "apply_physics":
      self scragentsetphysicsmode("gravity");
      break;
    default:
      break;
  }
}

choosestandingdeathanim_dlc1(var_0, var_1, var_2, var_3) {
  return _id_0C71::_id_3F00(var_0, var_1, var_2, var_3);
}

choosemovingdeathanim_dlc1(var_0, var_1, var_2) {
  return _id_0C71::_id_3EE2(var_0, var_1, var_2);
}

chooseballoongrabanim(var_0, var_1, var_2) {
  if(scripts\asm\zombie\zombie::_id_BE92())
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "prone");

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "stand");
}

handleballoonfloating() {
  self endon("death");
  wait(randomfloatrange(5, 5.9));
  self notify("reached_end");
  self unlink();
  self setvelocity((randomintrange(-10, 10), randomintrange(-10, 10), -50));
  self.do_immediate_ragdoll = 1;
  self.customdeath = 1;
  playFX(level._effect["balloon_death"], self.balloon_in_hand.origin + (0, 0, 50));
  playsoundatpos(self.origin, "craftable_balloon_zmb_explo");
  self dodamage(self.health + 100, self.origin, undefined, undefined, "MOD_EXPLOSIVE", "zmb_imsprojectile_mp");
}

balloongrabnotehandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "balloon_attach") {
    var_4 = ["decor_balloon_a_blue", "decor_balloon_a_blue_light", "decor_balloon_a_cyan", "decor_balloon_a_green", "decor_balloon_a_green_light", "decor_balloon_a_orange", "decor_balloon_a_pink", "decor_balloon_a_purple", "decor_balloon_a_purple_deep", "decor_balloon_a_red", "decor_balloon_a_yellow"];
    var_5 = self gettagorigin("j_shoulder_ri");
    self.balloon_in_hand = spawn("script_model", var_5);
    self.balloon_model = scripts\engine\utility::random(var_4);

    if(self.bholdingballooninleft)
      self attach(self.balloon_model, "tag_accessory_left");
    else
      self attach(self.balloon_model, "tag_accessory_right");

    self.balloon_in_hand.origin = var_5;
    self linkTo(self.balloon_in_hand);
    self playerlinkedoffsetenable();
    var_6 = randomintrange(-50, 50);
    var_7 = randomintrange(-50, 50);
    self.balloon_in_hand moveTo(self.origin + (var_6, var_7, self.detonate_height), 6, 3);
    self.balloon_in_hand rotateYaw(randomint(360), 6);
    thread handleballoonfloating();
  }
}

chooseballoonfloatanim(var_0, var_1, var_2) {
  if(scripts\engine\utility::is_true(self.bholdingballooninleft))
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "left");

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "right");
}

shouldballoongrableft(var_0, var_1, var_2, var_3) {
  self.bholdingballooninleft = undefined;

  if(_id_0C72::_id_9EA5())
    self.bholdingballooninleft = 1;
  else if(randomintrange(0, 100) < 50)
    self.bholdingballooninleft = 1;
  else
    self.bholdingballooninleft = 0;

  return self.bholdingballooninleft;
}

isdismembermentdisabled(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::is_true(self._id_55CF))
    return 1;

  return 0;
}