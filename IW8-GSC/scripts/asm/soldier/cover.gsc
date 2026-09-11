/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\cover.gsc
***********************************************/

function shouldcoverexpose() {
  return scripts\asm\asm_bb::bb_getrequestedcoverstate() == "exposed" && isDefined(self.enemy) && isDefined(self.node);
}

function shouldcoverexposedreload(var0, var1, var2, var3) {
  if(isDefined(self.bt.cover) && isDefined(self.balwayscoverexposed)) {
    return scripts\asm\asm_bb::bb_reloadrequested();
  }

  return 0;
}

function playcoveraniminternal(var0, var1, var2, var3) {
  if(var3 == "alignToNode") {
    if(isDefined(var1)) {
      if(scripts\engine\utility::actor_is3d()) {
        var4 = getangledelta3d(var2);
        var5 = scripts\asm\shared\utility::getnodeforwardangles(var1, 0);
        var6 = combineangles(var5, -1 * var4);
        self orientmode("face angle 3d", var6);
        return;
      }

      var4 = getangledelta3d(var5);
      var5 = (0, scripts\asm\shared\utility::getnodeforwardyaw(var4), 0);
      var6 = var5 - var4;
      self orientmode("face angle", var6[1]);
      return;
    }

    return;
  }

  if(var6 == "stickToNode") {
    var7 = getmovedelta(var5);

    if(distancesquared(var4.origin, self.origin) < 16) {
      self safeteleport(var4.origin);
      return;
    }

    thread lerpto(var4, 4, var6 + "_finished");
    return;
  }
}

function choosetransitiontoexposedanim(var0, var1, var2) {
  var3 = scripts\engine\utility::ter_op(scripts\asm\soldier\script_funcs::shouldreacttonewenemy(var0, var1, var2), "react_newenemy_", "");
  var4 = scripts\asm\asm::asm_lookupanimfromalias(var1, var3 + "2");
  var5 = scripts\asm\asm::asm_getxanim(var1, var4);
  var6 = getangledelta(var5, 0, 1);
  var7 = angleclamp180(180 - var6);

  if(isDefined(self.pathgoalpos) && self.facemotion) {
    var8 = vectortoangles(self.lookaheaddir);
    var9 = var8[1] - self.angles[1];
    var10 = angleclamp180(var9 + var7);
  } else if(isDefined(self.pathgoalpos) && !self.facemotion && isDefined(self.enemy) && !scripts\anim\utility_common::canseeenemy()) {
    var9 = 0;
    var10 = var10;
  } else {
    jumpiffalse(isDefined(self.smartfacingpos)) LOC_000000ed;
    var9 = angleclamp180(vectortoyaw(self.smartfacingpos - self.origin) - self.angles[1]);
    var10 = angleclamp180(var9 + var10);
    goto LOC_00000110;
  }

  LOC_00000110:
    var12 = isDefined(var9) && var9 == "Cover Left";
  var13 = isDefined(var9) && var9 == "Cover Right";
  var14 = spawnStruct();

  if(var12 && var10 < 0 && var10 > -90) {
    var14.turnanim = scripts\asm\asm::asm_lookupanimfromalias(var7, var10 + "8");
  } else if(var13 && var10 > 0 && var10 < 90) {
    var14.turnanim = scripts\asm\asm::asm_lookupanimfromalias(var7, var10 + "8");
  } else if(abs(var10) > 135) {
    var14.turnanim = scripts\asm\asm::asm_lookupanimfromalias(var7, var10 + "2");
  } else if(var10 < 0) {
    var14.turnanim = scripts\asm\asm::asm_lookupanimfromalias(var7, var10 + "6");
  } else {
    var14.turnanim = scripts\asm\asm::asm_lookupanimfromalias(var7, var10 + "4");
  }

  var14.predictedaimyaw = var9;
  return var14;
}

function playtransitiontoexposedanim(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = 1;
  self isguest();

  if((scripts\asm\asm_bb::bb_meleechargerequested() || scripts\asm\asm_bb::bb_meleerequested()) && isDefined(self.melee.target) && isPlayer(self.melee.target)) {
    var4 = 2;
  }

  var5 = scripts\asm\asm::asm_getxanim(var1, var3.turnanim);
  self aisetanim(var1, var3.turnanim, var4);
  scripts\asm\asm::asm_playfacialanim(var0, var1, var5);
  thread playtransitiontoexposedanimanglefixup(var5, var1);
  var6 = scripts\asm\asm::asm_donotetracks(var0, var1, scripts\asm\asm::asm_getnotehandler(var0, var1));
}

function playtransitiontoexposedanimanglefixup(var0, var1) {
  self endon("death");
  self endon(var1 + "_finished");

  if(!isDefined(self.enemy)) {
    return;
  }

  var2 = self.enemy;
  var2 endon("death");
  var3 = getanimlength(var0);

  if(animhasnotetrack(var0, "start_aim")) {
    var4 = getnotetracktimes(var0, "start_aim");
    var3 *= var4[0];
  } else if(animhasnotetrack(var0, "finish")) {
    var4 = getnotetracktimes(var0, "finish");
    var3 *= var4[0];
  }

  var5 = int(var3 * 20);
  var6 = var5;

  while(var6 > 0) {
    var7 = 1 / var6;
    var8 = scripts\engine\utility::getyawtospot(var2.origin);
    self.stepoutyaw = angleclamp180(self.angles[1] + var8);
    var9 = self aigetanimtime(var0);
    var10 = getangledelta(var0, var9, 1);
    var11 = angleclamp180(var8 - var10);
    self orientmode("face angle", angleclamp(self.angles[1] + var11 * var7));
    var6--;
    wait 0.05;
  }
}

function cleanuptransitiontocoverhide(var0) {
  self waittill(var0 + "_finished");

  if(isDefined(self)) {
    self finishcoverarrival();
    return;
  }
}

function playtransitiontocoverhide(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = scripts\asm\asm::asm_getanim(var0, var1, var2);
  jumpiffalse(isstruct(var3)) LOC_000000ee;
  var4 = var3.stopanim;
  var5 = var3.node;
  var6 = scripts\asm\asm::asm_getxanim(var1, var4);
  thread cleanuptransitiontocoverhide(var1);
  var7 = var3.finalangles;
  var8 = var3.startpos;
  var9 = angleclamp180(var7 - var3.angledelta);
  self.keepclaimednodeifvalid = 1;
  self animmode("zonly_physics", 0);
  self orientmode("face angle", self.angles[1]);
  scripts\asm\asm::asm_playfacialanim(var0, var1, var6);
  self aisetanim(var1, var3.stopanim, self.animplaybackrate);
  var10 = int(1000 * getanimlength(var6) - 200);
  self startcoverarrival();
  self motionwarpwithanim(var8, (0, var9, 0), var5.origin, (0, var7, 0), var10);
  scripts\asm\asm::asm_donotetracks(var0, var1);
  self.a.movement = "stop";
  return;
}

function chooseanim_tocoverhide(var0, var1, var2) {
  var3 = getstopdatafortransition(var0, var1, &chooseanim_tocoverhide_helper);
  return var3;
}

function cleanup_transitiontocoverhide(var0, var1, var2) {
  self motionwarpcancel();
}

function calcanimstartpos(var0, var1, var2, var3) {
  var4 = var1 - var3;
  var5 = (0, var4, 0);
  var6 = rotatevector(var2, var5);
  return var0 - var6;
}

function getclosesttocoverhideindex(var0) {
  var1 = angleclamp180(self.angles[1] - var0);

  if(var1 >= -45 && var1 < 45) {
    return 8;
  }

  if(var1 >= 45 && var1 < 135) {
    return 4;
  }

  if(var1 >= 135 || var1 < -135) {
    return 2;
  }

  if(var1 >= -135 && var1 < -45) {
    return 6;
  }
}

function chooseanim_tocoverhide_helper(var0, var1, var2, var3) {
  var4 = isDefined(self.currentpose) && self.currentpose == "crouch";
  var5 = undefined;

  if(isDefined(var3)) {
    var6 = getclosesttocoverhideindex(var3[1]);

    if(var4) {
      var7 = var6 + "_crouch";
      var5 = scripts\asm\asm::asm_lookupanimfromaliasifexists(var1, var7);
    }

    if(!isDefined(var5)) {
      var7 = "" + var6;
      var5 = scripts\asm\asm::asm_lookupanimfromaliasifexists(var1, var7);
    }
  }

  if(!isDefined(var5)) {
    var7 = "trans_to_hide";

    if(var4 && scripts\asm\asm::asm_hasalias(var1, "trans_to_hide_crouch")) {
      var7 = "trans_to_hide_crouch";
    }

    var5 = scripts\asm\asm::asm_lookupanimfromalias(var1, var7);
  }

  return var5;
}

function getstopdatafortransition(var0, var1, var2) {
  var3 = scripts\asm\asm_bb::bb_getcovernode();

  if(!isDefined(var3)) {
    if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 4096) {
      var3 = self.node;
    }
  }

  var4 = undefined;

  if(!isDefined(var3)) {
    return self[[var2]](var0, var1);
  }

  var4 = var3.origin;
  var5 = scripts\asm\shared\utility::nodeshouldfaceangles(var3);
  var6 = undefined;
  var7 = undefined;

  if(var5) {
    var8 = undefined;

    if(scripts\engine\utility::isnodecoverleft(var3) && scripts\asm\shared\utility::isarrivaltype(var0, var1, undefined, "Cover Left Crouch") || scripts\engine\utility::isnodecoverright(var3) && scripts\asm\shared\utility::isarrivaltype(var0, var1, undefined, "Cover Right Crouch")) {
      var8 = "crouch";
    }

    var6 = scripts\asm\shared\utility::getnodeforwardyaw(var3, var8);
    var7 = var3.angles;
  }

  var9 = self[[var2]](var0, var1, undefined, var7);
  var10 = spawnStruct();
  var11 = scripts\asm\asm::asm_getxanim(var1, var9);
  var10.stopanim = var9;
  var10.node = var3;
  var10.movedelta = getmovedelta(var11, 0, 1);
  var10.angledelta = getangledelta(var11, 0, 1);
  var10.startpos = calcanimstartpos(var4, var6, var10.movedelta, var10.angledelta);
  var10.angles = var7;
  var10.finalangles = var6;
  return var10;
}

function ishighnode(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(var0 scripts\engine\utility::isvalidpeekoutdir("over")) {
    return false;
  }

  return true;
}

function choosecoverstandlookorpeekanim(var0, var1, var2) {
  var3 = var2;

  if(ishighnode(self.node)) {
    var3 += "_high";
  }

  var4 = scripts\asm\asm::asm_lookupanimfromalias(var1, var3);
  return var4;
}

function playcoveranim(var0, var1, var2) {
  self endon(var1 + "_finished");
  self.keepclaimednodeifvalid = 1;
  childthread scripts\asm\shared\utility::setuseanimgoalweight(var1, 0.2);
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);
  self orientmode("face current");
  var5 = scripts\asm\asm_bb::bb_getcovernode();

  if(isDefined(var2)) {
    if(isarray(var2)) {
      foreach(var7 in var2) {
        playcoveraniminternal(var1, var5, var4, var7);
      }
    } else {
      playcoveraniminternal(var1, var5, var4, var2);
    }
  }

  if(scripts\asm\asm::asm_currentstatehasflag(var0, "notetrackAim")) {
    var9 = getangledelta(var4, 0, 1);
    self.stepoutyaw = self.angles[1] + var9;
  }

  self aisetanim(var1, var3);
  scripts\asm\asm::asm_playfacialanim(var0, var1, var4);

  if(!isagent(self)) {
    var10 = scripts\asm\asm::asm_lookupanimfromaliasifexists(var1, "conceal_add");
    var5 = scripts\asm\asm_bb::bb_getcovernode();

    if(isDefined(var10) && isDefined(var5) && (var5.type == "Conceal Crouch" || var5.type == "Conceal Stand")) {
      var11 = scripts\asm\asm::asm_getxanim(var1, var10);
      var12 = getanimlength(var4);
      thread start_conceal_add(var1, var11, var12 * 0.3);
    }
  }

  scripts\asm\asm::asm_donotetracks(var0, var1, scripts\asm\asm::asm_getnotehandler(var0, var1));
  self orientmode("face current");
}

function start_conceal_add(var0, var1, var2) {
  self endon(var0 + "_finished");
  var2 = max(var2, 0.05);
  wait var2;
  self setanim(var1, 1, 0.4, 1, 1);
  thread conceal_add_cleanup(var0);
}

function playexposedcoveranim(var0, var1, var2) {
  playcoveranimloop(var0, var1, var2);
}

function transitionedfromrun(var0) {
  var1 = self asmgetstatetransitioningfrom(var0);

  if(isDefined(var1)) {
    if(var1 == "stand_run_loop") {
      return true;
    } else if(scripts\engine\utility::actor_is3d() && var1 == "stand_run_strafe_loop") {
      return true;
    }
  }

  return false;
}

function playcoveranimloop3d(var0, var1, var2) {
  if(!isDefined(self.asm.lastcovernode)) {
    var3 = [scripts\asm\asm_bb::bb_getcovernode(), self.node];

    for(var4 = 0; !isDefined(self.asm.lastcovernode) && var4 < var3.size; var4++) {
      if(isDefined(var3[var4]) && distancesquared(self.origin, var3[var4].origin) < 256) {
        self.asm.lastcovernode = var3[var4];
      }
    }
  }

  playcoveranimloop(var0, var1, 0.2, var2);
}

function playcoveranimloop(var0, var1, var2) {
  self.keepclaimednodeifvalid = 1;

  if(isDefined(var2)) {
    if(var2 == "stickToNode") {
      var3 = scripts\asm\asm_bb::bb_getcovernode();

      if(isDefined(var3)) {
        if(distancesquared(var3.origin, self.origin) < 16) {
          self safeteleport(var3.origin);
        } else {
          thread lerpto(var3, 4, var1 + "_finished");
        }
      }

      self.keepclaimednodeifvalid = 0;

      if(transitionedfromrun(var0)) {
        childthread scripts\asm\shared\utility::setuseanimgoalweight(var1, 0.2);
      }
    }
  }

  if(!isagent(self)) {
    var4 = archetypegetalias(self.asm.archetype, var1, "conceal_add", 0);
    var3 = scripts\asm\asm_bb::bb_getcovernode();

    if(isDefined(var4) && isDefined(var3) && (var3.type == "Conceal Crouch" || var3.type == "Conceal Stand")) {
      self setanim(var4.anims, 1, 0.2, 1, 1);
      thread conceal_add_cleanup(var1);
    }
  }

  scripts\asm\asm::asm_loopanimstate(var0, var1, 1);
}

function conceal_add_cleanup(var0) {
  self endon("death");
  self endon("entitydeleted");
  self notify("conceal_add_cleanup");
  self endon("conceal_add_cleanup");
  self waittill(var0 + "_finished");
  var1 = archetypegetalias(self.asm.archetype, "knobs", "conceal_add", 0);
  self clearanim(var1.anims, 0.4);
}

function lerpto(var0, var1, var2) {
  self endon(var2);

  for(;;) {
    var3 = var0.origin - self.origin;
    var4 = length(var3);

    if(var4 < var1) {
      self safeteleport(var0.origin);
      break;
    }

    var3 /= var4;
    var5 = self.origin + var3 * var1;
    self safeteleport(var5);
    wait 0.05;
  }
}

function clearcoveranim(var0, var1, var2) {
  self.keepclaimednodeifvalid = 0;
  self.stepoutyaw = undefined;
}

function terminatecoverreload(var0, var1, var2) {
  scripts\asm\asm::asm_fireephemeralevent("reload", "end");
  clearcoveranim(var0, var1, var2);
  scripts\asm\soldier\script_funcs::reload_cleanup(var0, var1, var2);
}

function playcoveranim_droprpg(var0, var1, var2) {
  self.keepclaimednodeifvalid = 1;
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);
  self orientmode("face current");
  self aisetanim(var1, var3);
  scripts\asm\asm::asm_playfacialanim(var0, var1, var4);
  scripts\asm\asm::asm_donotetracks(var0, var1, scripts\asm\asm::asm_getnotehandler(var0, var1));
}

function playshuffleloop(var0, var1, var2) {
  var3 = [];
  GscBinSkip0(0x2e, "crouch_shuffle_right", -90);
}

function shouldplayshuffleenter(var0, var1, var2, var3) {
  var4 = scripts\asm\asm::asm_getrandomanim(var0, var2);
  var5 = scripts\asm\asm::asm_getxanim(var2, var4);
  var6 = getmovedelta(var5);
  var7 = lengthsquared(var6);
  var8 = distancesquared(self.origin, self._blackboard.shufflenode.origin);
  return var7 <= var8 + 1;
}

function abortshufflecleanup(var0, var1, var2) {
  self._blackboard.shufflenode = undefined;
}

function shouldbeginshuffleexit(var0, var1, var2, var3) {
  var4 = self.prevcovernode;

  if(!isDefined(var4)) {
    var4 = self.covernode;
  }

  var5 = self._blackboard.shufflenode.type;

  if(isDefined(var5) && (var5 == "Cover Crouch" || var5 == "Cover Crouch Window" || var5 == "Conceal Crouch")) {
    var6 = getDvar("scr_ai_cover_crouch_type");

    if(isDefined(self.node.covercrouchtype)) {
      var5 = self.node.covercrouchtype;
    } else if(var6 != "") {
      var5 = var6;
    }
  }

  if(isDefined(var3) && var5 != var3) {
    return false;
  }

  var7 = scripts\asm\asm::asm_getrandomanim(var0, var1);
  var8 = scripts\asm\asm::asm_getxanim(var1, var7);
  var9 = self._blackboard.shufflenode.origin - self.origin;
  var10 = vectorNormalize(var9);
  var11 = getmovedelta(var8, 0, 1);
  var12 = length(var11);
  var13 = self._blackboard.shufflenode.origin - var10 * var12;
  var9 = var13 - self.origin;
  var14 = self._blackboard.shufflenode.origin - var4.origin;
  var14 = (var14[0], var14[1], 0);

  if(vectordot(var14, var9) <= 0) {
    return true;
  }

  if(vectordot(var10, self.velocity) <= 0) {
    return true;
  }

  return false;
}

function playshuffleanim_arrival(var0, var1, var2) {
  self.a.arrivalasmstatename = var1;
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);
  self aisetanim(var1, var3);
  scripts\asm\asm::asm_playfacialanim(var0, var1, var4);
  var5 = getmovedelta(var4);
  var6 = getangledelta3d(var4);

  if(isDefined(self._blackboard.shufflenode)) {
    var7 = self._blackboard.shufflenode;
  } else {
    var7 = self.node;
  }

  if(isDefined(var7)) {
    var8 = var7.origin;
    var9 = (0, scripts\asm\shared\utility::getnodeforwardyaw(var7), 0);
    var10 = combineangles(var9, invertangles(var7));
    var11 = var7.origin - rotatevector(var6, var10);
  } else {
    var8 = self.origin + var9;
    var9 = combineangles(self.angles, var10);
    var11 = self.origin;
    var10 = self.angles;
  }

  var12 = int(1000 * getanimlength(var8) - 200);
  self startcoverarrival();
  self motionwarpwithanim(var11, var10, var8, var9, var12);
  scripts\asm\asm::asm_donotetracks(var5, var6);
}

function playshuffleanim_terminate(var0, var1, var2) {
  self._blackboard.shufflenode = undefined;
  self._blackboard.shufflefromnode = undefined;
  self finishcoverarrival();
}

function coverreloadnotetrackhandler(var0) {
  scripts\anim\notetracks::notetrack_prefix_handler(var0);
  return undefined;
}

function coverreload(var0, var1, var2) {
  playcoveranim(var0, var1, var2);
}

function cover3dpickexposedir(var0, var1, var2, var3) {
  self.bt.cover.cover3dexposedirpicked = undefined;
  var4 = (self.enemy.origin + scripts\anim\utility_common::getenemyeyepos()) / 2;
  var5 = anim.asm[var0].states[var2];
  var6 = scripts\engine\utility::array_randomize(var5.transitions);
  var7 = undefined;

  foreach(var9 in var6) {
    var7 = var9.shouldtransitionparams;

    if(var7 == "up") {
      break;
    }

    var10 = scripts\anim\utility_common::getcover3dnodeoffset(self.node, var7);
    var11 = self.node.origin + var10;

    if(sighttracepassed(var11, var4, 0, undefined)) {
      break;
    }
  }

  self.bt.cover.cover3dexposedirpicked = var0 + "_" + var2 + "_" + var7;
  return true;
}

function cover3dcanexposedir(var0, var1, var2, var3) {
  var4 = var0 + "_" + var1 + "_" + var3;
  return var4 == self.bt.cover.cover3dexposedirpicked;
}

function iscovernodetype(var0, var1, var2, var3) {
  if(!isDefined(var3) || !isDefined(self.node) || !isDefined(self.node.type)) {
    return false;
  }

  return self.node.type == var3;
}

function iscovermultiswitchrequested(var0, var1, var2, var3) {
  if(scripts\asm\asm_bb::bb_iscovermultiswitchrequested()) {
    return true;
  }

  return false;
}

function checkcovermultichangerequest(var0, var1, var2, var3) {
  if(!scripts\asm\asm_bb::bb_iscovermultiswitchrequested()) {
    return false;
  }

  var4 = scripts\asm\asm_bb::bb_getcovernode();
  var5 = scripts\asm\asm_bb::bb_getrequestedcovermultiswitchnodetype();
  var6 = var5[0];
  var7 = var5[1];
  var5 = undefined;

  if(var7 != var3) {
    return false;
  }

  self.asm.covermultiswitchdata = spawnStruct();
  self.asm.covermultiswitchdata.requestednode = var6;
  self.asm.covermultiswitchdata.requestednodetype = var7;
  return true;
}

function finishcovermultichangerequest(var0, var1, var2) {
  var3 = self.asm.covermultiswitchdata.requestednode;
  var4 = self.asm.covermultiswitchdata.requestednodetype;
  self.asm.covermultiswitchdata.requestednode setcovermultinodetype(var4);
  self.asm.covermultiswitchdata = undefined;
  clearcoveranim(var0, var1, var2);
}