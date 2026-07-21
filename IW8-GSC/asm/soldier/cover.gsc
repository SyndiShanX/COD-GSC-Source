/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\soldier\cover.gsc
***********************************************/

shouldcoverexpose() {
  return scripts\asm\asm_bb::bb_getrequestedcoverstate() == "exposed" && isDefined(self.enemy) && isDefined(self.node);
}

shouldcoverexposedreload(var_0, var_1, var_2, var_3) {
  if(isDefined(self.bt.cover) && isDefined(self.balwayscoverexposed))
    return scripts\asm\asm_bb::bb_reloadrequested();

  return 0;
}

playcoveraniminternal(var_0, var_1, var_2, var_3) {
  if(var_3 == "alignToNode") {
    if(isDefined(var_1)) {
      if(scripts\engine\utility::actor_is3d()) {
        var_4 = getangledelta3d(var_2);
        var_5 = scripts\asm\shared\utility::getnodeforwardangles(var_1, 0);
        var_6 = combineangles(var_5, -1 * var_4);
        self orientmode("face angle 3d", var_6);
      } else {
        var_4 = getangledelta3d(var_2);
        var_5 = (0, scripts\asm\shared\utility::getnodeforwardyaw(var_1), 0);
        var_6 = var_5 - var_4;
        self orientmode("face angle", var_6[1]);
      }
    }
  } else if(var_3 == "stickToNode") {
    var_7 = getmovedelta(var_2);

    if(distancesquared(var_1.origin, self.origin) < 16)
      self safeteleport(var_1.origin);
    else
      thread lerpto(var_1, 4, var_0 + "_finished");
  }
}

choosetransitiontoexposedanim(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::ter_op(scripts\asm\soldier\script_funcs::shouldreacttonewenemy(var_0, var_1, var_2), "react_newenemy_", "");
  var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3 + "2");
  var_5 = scripts\asm\asm::asm_getxanim(var_1, var_4);
  var_6 = getangledelta(var_5, 0.0, 1.0);
  var_7 = angleclamp180(180 - var_6);

  if(isDefined(self.pathgoalpos) && self.facemotion) {
    var_8 = vectortoangles(self.lookaheaddir);
    var_9 = var_8[1] - self.angles[1];
    var_10 = angleclamp180(var_9 + var_7);
  } else if(isDefined(self.pathgoalpos) && !self.facemotion && isDefined(self.enemy) && !scripts\anim\utility_common.gsc::canseeenemy()) {
    var_9 = 0;
    var_10 = var_7;
  } else if(isDefined(self.smartfacingpos)) {
    var_9 = angleclamp180(vectortoyaw(self.smartfacingpos - self.origin) - self.angles[1]);
    var_10 = angleclamp180(var_9 + var_7);
  } else {
    var_11 = self.enemy;
    var_9 = scripts\engine\utility::getpredictedaimyawtoshootentorpos(0.25, var_11, undefined);
    var_10 = angleclamp180(var_9 + var_7);
  }

  var_12 = isDefined(var_2) && var_2 == "Cover Left";
  var_13 = isDefined(var_2) && var_2 == "Cover Right";
  var_14 = spawnStruct();

  if(var_12 && var_10 < 0 && var_10 > -90)
    var_14.turnanim = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3 + "8");
  else if(var_13 && var_10 > 0 && var_10 < 90)
    var_14.turnanim = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3 + "8");
  else if(abs(var_10) > 135)
    var_14.turnanim = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3 + "2");
  else if(var_10 < 0)
    var_14.turnanim = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3 + "6");
  else
    var_14.turnanim = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3 + "4");

  var_14.predictedaimyaw = var_9;
  return var_14;
}

playtransitiontoexposedanim(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = 1.0;
  self isguest();

  if((scripts\asm\asm_bb::bb_meleechargerequested() || scripts\asm\asm_bb::bb_meleerequested()) && isDefined(self.melee.target) && isPlayer(self.melee.target))
    var_4 = 2.0;

  var_5 = scripts\asm\asm::asm_getxanim(var_1, var_3.turnanim);
  self aisetanim(var_1, var_3.turnanim, var_4);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_5);
  thread playtransitiontoexposedanimanglefixup(var_5, var_1);
  var_6 = scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1));
}

playtransitiontoexposedanimanglefixup(var_0, var_1) {
  self endon("death");
  self endon(var_1 + "_finished");

  if(!isDefined(self.enemy)) {
    return;
  }
  var_2 = self.enemy;
  var_2 endon("death");
  var_3 = getanimlength(var_0);

  if(animhasnotetrack(var_0, "start_aim")) {
    var_4 = getnotetracktimes(var_0, "start_aim");
    var_3 = var_3 * var_4[0];
  } else if(animhasnotetrack(var_0, "finish")) {
    var_4 = getnotetracktimes(var_0, "finish");
    var_3 = var_3 * var_4[0];
  }

  var_5 = int(var_3 * 20);
  var_6 = var_5;

  while(var_6 > 0) {
    var_7 = 1 / var_6;
    var_8 = scripts\engine\utility::getyawtospot(var_2.origin);
    self.stepoutyaw = angleclamp180(self.angles[1] + var_8);
    var_9 = self aigetanimtime(var_0);
    var_10 = getangledelta(var_0, var_9, 1.0);
    var_11 = angleclamp180(var_8 - var_10);
    self orientmode("face angle", angleclamp(self.angles[1] + var_11 * var_7));
    var_6--;
    wait 0.05;
  }
}

cleanuptransitiontocoverhide(var_0) {
  self waittill(var_0 + "_finished");

  if(isDefined(self))
    self finishcoverarrival();
}

playtransitiontocoverhide(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1, var_2);

  if(isstruct(var_3)) {
    var_4 = var_3.stopanim;
    var_5 = var_3.node;
    var_6 = scripts\asm\asm::asm_getxanim(var_1, var_4);
    thread cleanuptransitiontocoverhide(var_1);
    var_7 = var_3.finalangles;
    var_8 = var_3.startpos;
    var_9 = angleclamp180(var_7 - var_3.angledelta);
    self.keepclaimednodeifvalid = 1;
    self animmode("zonly_physics", 0);
    self orientmode("face angle", self.angles[1]);
    scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_6);
    self aisetanim(var_1, var_3.stopanim, self.animplaybackrate);
    var_10 = int(1000 * getanimlength(var_6) - 200);
    self startcoverarrival();
    self motionwarpwithanim(var_8, (0, var_9, 0), var_5.origin, (0, var_7, 0), var_10);
    scripts\asm\asm::asm_donotetracks(var_0, var_1);
    self.a.movement = "stop";
  } else {
    var_11 = var_3;
    var_6 = scripts\asm\asm::asm_getxanim(var_1, var_11);
    self.keepclaimednodeifvalid = 1;
    childthread scripts\asm\shared\utility::setuseanimgoalweight(var_1, 0.2);
    self orientmode("face current");
    self aisetanim(var_1, var_11);
    scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_6);
    scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1));
  }
}

chooseanim_tocoverhide(var_0, var_1, var_2) {
  var_3 = getstopdatafortransition(var_0, var_1, ::chooseanim_tocoverhide_helper);
  return var_3;
}

cleanup_transitiontocoverhide(var_0, var_1, var_2) {
  self motionwarpcancel();
}

calcanimstartpos(var_0, var_1, var_2, var_3) {
  var_4 = var_1 - var_3;
  var_5 = (0, var_4, 0);
  var_6 = rotatevector(var_2, var_5);
  return var_0 - var_6;
}

getclosesttocoverhideindex(var_0) {
  var_1 = angleclamp180(self.angles[1] - var_0);

  if(var_1 >= -45 && var_1 < 45)
    return 8;
  else if(var_1 >= 45 && var_1 < 135)
    return 4;
  else if(var_1 >= 135 || var_1 < -135)
    return 2;
  else if(var_1 >= -135 && var_1 < -45)
    return 6;
}

chooseanim_tocoverhide_helper(var_0, var_1, var_2, var_3) {
  var_4 = isDefined(self.currentpose) && self.currentpose == "crouch";
  var_5 = undefined;

  if(isDefined(var_3)) {
    var_6 = getclosesttocoverhideindex(var_3[1]);

    if(var_4) {
      var_7 = var_6 + "_crouch";
      var_5 = scripts\asm\asm::asm_lookupanimfromaliasifexists(var_1, var_7);
    }

    if(!isDefined(var_5)) {
      var_7 = "" + var_6;
      var_5 = scripts\asm\asm::asm_lookupanimfromaliasifexists(var_1, var_7);
    }
  }

  if(!isDefined(var_5)) {
    var_7 = "trans_to_hide";

    if(var_4 && scripts\asm\asm::asm_hasalias(var_1, "trans_to_hide_crouch"))
      var_7 = "trans_to_hide_crouch";

    var_5 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_7);
  }

  return var_5;
}

getstopdatafortransition(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm_bb::bb_getcovernode();

  if(!isDefined(var_3)) {
    if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 4096)
      var_3 = self.node;
  }

  var_4 = undefined;

  if(!isDefined(var_3))
    return self[[var_2]](var_0, var_1);

  var_4 = var_3.origin;
  var_5 = scripts\asm\shared\utility::nodeshouldfaceangles(var_3);
  var_6 = undefined;
  var_7 = undefined;

  if(var_5) {
    var_8 = undefined;

    if(scripts\engine\utility::isnodecoverleft(var_3) && scripts\asm\shared\utility::isarrivaltype(var_0, var_1, undefined, "Cover Left Crouch") || scripts\engine\utility::isnodecoverright(var_3) && scripts\asm\shared\utility::isarrivaltype(var_0, var_1, undefined, "Cover Right Crouch"))
      var_8 = "crouch";

    var_6 = scripts\asm\shared\utility::getnodeforwardyaw(var_3, var_8);
    var_7 = var_3.angles;
  }

  var_9 = self[[var_2]](var_0, var_1, undefined, var_7);
  var_10 = spawnStruct();
  var_11 = scripts\asm\asm::asm_getxanim(var_1, var_9);
  var_10.stopanim = var_9;
  var_10.node = var_3;
  var_10.movedelta = getmovedelta(var_11, 0.0, 1.0);
  var_10.angledelta = getangledelta(var_11, 0.0, 1.0);
  var_10.startpos = calcanimstartpos(var_4, var_6, var_10.movedelta, var_10.angledelta);
  var_10.angles = var_7;
  var_10.finalangles = var_6;
  return var_10;
}

ishighnode(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(var_0 scripts\engine\utility::isvalidpeekoutdir("over"))
    return 0;

  return 1;
}

choosecoverstandlookorpeekanim(var_0, var_1, var_2) {
  var_3 = var_2;

  if(ishighnode(self.node))
    var_3 = var_3 + "_high";

  var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
  return var_4;
}

playcoveranim(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self.keepclaimednodeifvalid = 1;
  childthread scripts\asm\shared\utility::setuseanimgoalweight(var_1, 0.2);
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);
  self orientmode("face current");
  var_5 = scripts\asm\asm_bb::bb_getcovernode();

  if(isDefined(var_2)) {
    if(isarray(var_2)) {
      foreach(var_7 in var_2)
      playcoveraniminternal(var_1, var_5, var_4, var_7);
    } else
      playcoveraniminternal(var_1, var_5, var_4, var_2);
  }

  if(scripts\asm\asm::asm_currentstatehasflag(var_0, "notetrackAim")) {
    var_9 = getangledelta(var_4, 0.0, 1.0);
    self.stepoutyaw = self.angles[1] + var_9;
  }

  self aisetanim(var_1, var_3);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_4);

  if(!isagent(self)) {
    var_10 = scripts\asm\asm::asm_lookupanimfromaliasifexists(var_1, "conceal_add");
    var_5 = scripts\asm\asm_bb::bb_getcovernode();

    if(isDefined(var_10) && isDefined(var_5) && (var_5.type == "Conceal Crouch" || var_5.type == "Conceal Stand")) {
      var_11 = scripts\asm\asm::asm_getxanim(var_1, var_10);
      var_12 = getanimlength(var_4);
      thread start_conceal_add(var_1, var_11, var_12 * 0.3);
    }
  }

  scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1));
  self orientmode("face current");
}

start_conceal_add(var_0, var_1, var_2) {
  self endon(var_0 + "_finished");
  var_2 = max(var_2, 0.05);
  wait(var_2);
  self setanim(var_1, 1.0, 0.4, 1.0, 1);
  thread conceal_add_cleanup(var_0);
}

playexposedcoveranim(var_0, var_1, var_2) {
  playcoveranimloop(var_0, var_1, var_2);
}

transitionedfromrun(var_0) {
  var_1 = self asmgetstatetransitioningfrom(var_0);

  if(isDefined(var_1)) {
    if(var_1 == "stand_run_loop")
      return 1;
    else if(scripts\engine\utility::actor_is3d() && var_1 == "stand_run_strafe_loop")
      return 1;
  }

  return 0;
}

playcoveranimloop3d(var_0, var_1, var_2) {
  if(!isDefined(self.asm.lastcovernode)) {
    var_3 = [scripts\asm\asm_bb::bb_getcovernode(), self.node];

    for(var_4 = 0; !isDefined(self.asm.lastcovernode) && var_4 < var_3.size; var_4++) {
      if(isDefined(var_3[var_4]) && distancesquared(self.origin, var_3[var_4].origin) < 256)
        self.asm.lastcovernode = var_3[var_4];
    }
  }

  playcoveranimloop(var_0, var_1, 0.2, var_2);
}

playcoveranimloop(var_0, var_1, var_2) {
  self.keepclaimednodeifvalid = 1;

  if(isDefined(var_2)) {
    if(var_2 == "stickToNode") {
      var_3 = scripts\asm\asm_bb::bb_getcovernode();

      if(isDefined(var_3)) {
        if(distancesquared(var_3.origin, self.origin) < 16)
          self safeteleport(var_3.origin);
        else
          thread lerpto(var_3, 4, var_1 + "_finished");
      }

      self.keepclaimednodeifvalid = 0;

      if(transitionedfromrun(var_0))
        childthread scripts\asm\shared\utility::setuseanimgoalweight(var_1, 0.2);
    }
  }

  if(!isagent(self)) {
    var_4 = archetypegetalias(self.asm.archetype, var_1, "conceal_add", 0);
    var_3 = scripts\asm\asm_bb::bb_getcovernode();

    if(isDefined(var_4) && isDefined(var_3) && (var_3.type == "Conceal Crouch" || var_3.type == "Conceal Stand")) {
      self setanim(var_4.anims, 1.0, 0.2, 1.0, 1);
      thread conceal_add_cleanup(var_1);
    }
  }

  scripts\asm\asm::asm_loopanimstate(var_0, var_1, 1);
}

conceal_add_cleanup(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self notify("conceal_add_cleanup");
  self endon("conceal_add_cleanup");
  self waittill(var_0 + "_finished");
  var_1 = archetypegetalias(self.asm.archetype, "knobs", "conceal_add", 0);
  self clearanim(var_1.anims, 0.4);
}

lerpto(var_0, var_1, var_2) {
  self endon(var_2);

  for(;;) {
    var_3 = var_0.origin - self.origin;
    var_4 = length(var_3);

    if(var_4 < var_1) {
      self safeteleport(var_0.origin);
      break;
    }

    var_3 = var_3 / var_4;
    var_5 = self.origin + var_3 * var_1;
    self safeteleport(var_5);
    wait 0.05;
  }
}

clearcoveranim(var_0, var_1, var_2) {
  self.keepclaimednodeifvalid = 0;
  self.stepoutyaw = undefined;
}

terminatecoverreload(var_0, var_1, var_2) {
  scripts\asm\asm::asm_fireephemeralevent("reload", "end");
  clearcoveranim(var_0, var_1, var_2);
  scripts\asm\soldier\script_funcs::reload_cleanup(var_0, var_1, var_2);
}

playcoveranim_droprpg(var_0, var_1, var_2) {
  self.keepclaimednodeifvalid = 1;
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);
  self orientmode("face current");
  self aisetanim(var_1, var_3);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_4);
  scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1));
}

playshuffleloop(var_0, var_1, var_2) {
  var_3 = [];
  var_3["crouch_shuffle_right"] = -90;
  var_3["crouch_shuffle_left"] = 90;
  var_3["stand_shuffle_right"] = -90;
  var_3["stand_shuffle_left"] = 90;
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_5 = scripts\asm\asm::asm_getxanim(var_1, var_4);
  self aisetanim(var_1, var_4);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_5);

  if(isDefined(self._blackboard.shufflenode))
    var_6 = self._blackboard.shufflenode.angles[1];
  else if(isDefined(self.node))
    var_6 = self.node.angles[1];
  else
    var_6 = self.angles[1];

  if(self.unittype != "c6" && isDefined(var_3[var_1]))
    var_6 = var_6 + var_3[var_1];

  self orientmode("face angle", var_6);
  scripts\asm\asm::asm_donotetracks(var_0, var_1);
}

shouldplayshuffleenter(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm::asm_getrandomanim(var_0, var_2);
  var_5 = scripts\asm\asm::asm_getxanim(var_2, var_4);
  var_6 = getmovedelta(var_5);
  var_7 = lengthsquared(var_6);
  var_8 = distancesquared(self.origin, self._blackboard.shufflenode.origin);
  return var_7 <= var_8 + 1;
}

abortshufflecleanup(var_0, var_1, var_2) {
  self._blackboard.shufflenode = undefined;
}

shouldbeginshuffleexit(var_0, var_1, var_2, var_3) {
  var_4 = self.prevcovernode;

  if(!isDefined(var_4))
    var_4 = self.covernode;

  var_5 = self._blackboard.shufflenode.type;

  if(isDefined(var_5) && (var_5 == "Cover Crouch" || var_5 == "Cover Crouch Window" || var_5 == "Conceal Crouch")) {
    var_6 = getDvar("scr_ai_cover_crouch_type");

    if(isDefined(self.node.covercrouchtype))
      var_5 = self.node.covercrouchtype;
    else if(var_6 != "")
      var_5 = var_6;
  }

  if(isDefined(var_3) && var_5 != var_3)
    return 0;

  var_7 = scripts\asm\asm::asm_getrandomanim(var_0, var_1);
  var_8 = scripts\asm\asm::asm_getxanim(var_1, var_7);
  var_9 = self._blackboard.shufflenode.origin - self.origin;
  var_10 = vectorNormalize(var_9);
  var_11 = getmovedelta(var_8, 0, 1);
  var_12 = length(var_11);
  var_13 = self._blackboard.shufflenode.origin - var_10 * var_12;
  var_9 = var_13 - self.origin;
  var_14 = self._blackboard.shufflenode.origin - var_4.origin;
  var_14 = (var_14[0], var_14[1], 0);

  if(vectordot(var_14, var_9) <= 0)
    return 1;

  if(vectordot(var_10, self.velocity) <= 0)
    return 1;

  return 0;
}

playshuffleanim_arrival(var_0, var_1, var_2) {
  self.a.arrivalasmstatename = var_1;
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);
  self aisetanim(var_1, var_3);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_4);
  var_5 = getmovedelta(var_4);
  var_6 = getangledelta3d(var_4);

  if(isDefined(self._blackboard.shufflenode))
    var_7 = self._blackboard.shufflenode;
  else
    var_7 = self.node;

  if(isDefined(var_7)) {
    var_8 = var_7.origin;
    var_9 = (0, scripts\asm\shared\utility::getnodeforwardyaw(var_7), 0);
    var_10 = combineangles(var_9, invertangles(var_6));
    var_11 = var_7.origin - rotatevector(var_5, var_10);
  } else {
    var_8 = self.origin + var_5;
    var_9 = combineangles(self.angles, var_6);
    var_11 = self.origin;
    var_10 = self.angles;
  }

  var_12 = int(1000 * getanimlength(var_4) - 200);
  self startcoverarrival();
  self motionwarpwithanim(var_11, var_10, var_8, var_9, var_12);
  scripts\asm\asm::asm_donotetracks(var_0, var_1);
}

playshuffleanim_terminate(var_0, var_1, var_2) {
  self._blackboard.shufflenode = undefined;
  self._blackboard.shufflefromnode = undefined;
  self finishcoverarrival();
}

coverreloadnotetrackhandler(var_0) {
  scripts\anim\notetracks.gsc::notetrack_prefix_handler(var_0);
  return undefined;
}

coverreload(var_0, var_1, var_2) {
  playcoveranim(var_0, var_1, var_2);
}

cover3dpickexposedir(var_0, var_1, var_2, var_3) {
  self.bt.cover.cover3dexposedirpicked = undefined;
  var_4 = (self.enemy.origin + scripts\anim\utility_common.gsc::getenemyeyepos()) / 2;
  var_5 = anim.asm[var_0].states[var_2];
  var_6 = scripts\engine\utility::array_randomize(var_5.transitions);
  var_7 = undefined;

  foreach(var_9 in var_6) {
    var_7 = var_9.shouldtransitionparams;

    if(var_7 == "up") {
      break;
    }

    var_10 = scripts\anim\utility_common.gsc::getcover3dnodeoffset(self.node, var_7);
    var_11 = self.node.origin + var_10;

    if(sighttracepassed(var_11, var_4, 0, undefined)) {
      break;
    }
  }

  self.bt.cover.cover3dexposedirpicked = var_0 + "_" + var_2 + "_" + var_7;
  return 1;
}

cover3dcanexposedir(var_0, var_1, var_2, var_3) {
  var_4 = var_0 + "_" + var_1 + "_" + var_3;
  return var_4 == self.bt.cover.cover3dexposedirpicked;
}

iscovernodetype(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3) || !isDefined(self.node) || !isDefined(self.node.type))
    return 0;

  return self.node.type == var_3;
}

iscovermultiswitchrequested(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm_bb::bb_iscovermultiswitchrequested())
    return 1;

  return 0;
}

checkcovermultichangerequest(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\asm_bb::bb_iscovermultiswitchrequested())
    return 0;

  var_4 = scripts\asm\asm_bb::bb_getcovernode();
  [var_6, var_7] = scripts\asm\asm_bb::bb_getrequestedcovermultiswitchnodetype();

  if(var_7 != var_3)
    return 0;

  self.asm.covermultiswitchdata = spawnStruct();
  self.asm.covermultiswitchdata.requestednode = var_6;
  self.asm.covermultiswitchdata.requestednodetype = var_7;
  return 1;
}

finishcovermultichangerequest(var_0, var_1, var_2) {
  var_3 = self.asm.covermultiswitchdata.requestednode;
  var_4 = self.asm.covermultiswitchdata.requestednodetype;
  self.asm.covermultiswitchdata.requestednode setcovermultinodetype(var_4);
  self.asm.covermultiswitchdata = undefined;
  clearcoveranim(var_0, var_1, var_2);
}