/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\asm\soldier\script_funcs.gsc
***************************************************/

#using scripts\anim\combat_utility;
#using scripts\anim\notetracks;
#using scripts\anim\shared;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\death;
#using scripts\asm\soldier\melee;
#using scripts\common\gameskill;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace script_funcs;

function soldier_init(asmname, statename, params) {
  assert(isDefined(self.asm));
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.asm.customdata = spawnStruct();
  self.asm.gestures = spawnStruct();
  self.defaultturnthreshold = 59;
  self.anglelerprate = 100;

  if(!isDefined(self.var_98add129a7ecb962)) {
    self.var_98add129a7ecb962 = 1;
  }

  if(isDefined(self.fnasm_initfingerposes)) {
    self thread[[self.fnasm_initfingerposes]]();
  }

  self.fnhelmetpop = &scripts\asm\soldier\death::helmetpop;
  initaimlimits(asmname);

  if(self.animsetname == "ai_animation_sequencer" || self.animsetname == "ai_animation_sequencer_combat_loop" || self.animsetname == "ai_animation_sequencer_additive_poses") {} else {
    initanimspeedthresholds_soldier(self.basearchetype);
    initanimspeedthresholds_soldier(self.animsetname);
  }

  if(self findoverridearchetype("default") == "rebel") {
    self.maystumble = 1;
  }

  self.var_54b40088c45bf08d = 1;

  if(self isscriptable()) {
    thread initscriptable();
  }

  self function_62004d7561fd321e();
  weapclass = weaponclass(self.weapon);

  if(weapclass == "mg") {
    self.combatmode = "cover_lmg";
  }

  if(!isDefined(self findoverridearchetype("weapon"))) {
    updateweaponarchetype(weapclass);
  }

  if(!isDefined(self.var_9087e842f157d27c)) {
    self.var_9087e842f157d27c = &scripts\asm\soldier\melee::function_6cde2d3ae248271d;
  }
}

function initscriptable() {
  self endon("death");
  scripts\engine\utility::flag_wait("scriptables_ready");
  self setscriptablepartstate("notetrack_handler", "active", 0);
}

function initaimlimits(asmname) {
  if(!isDefined(level.combataimlimits)) {
    level.combataimlimits = [];
    level.franticaimlimits = [];
    level.aimlimitstatemappings = [];
  }

  if(!isDefined(level.combataimlimits[asmname])) {
    combataimlimits = [];
    franticaimlimits = [];
    aimlimit = [];
    combataimlimits["exposed_idle"] = aimlimit;
    aimlimit = [];
    franticaimlimits["exposed_idle"] = aimlimit;
    aimlimit = [];
    aimlimit["down"] = 15;
    combataimlimits["cover_crouch_lean"] = aimlimit;
    aimlimit = [];
    aimlimit["down"] = 15;
    franticaimlimits["cover_crouch_lean"] = aimlimit;
    aimlimit = [];
    franticaimlimits["cover_crouch_aim"] = aimlimit;
    aimlimit = [];
    aimlimit["right"] = -15;
    combataimlimits["cover_left_lean"] = aimlimit;
    aimlimit = [];
    aimlimit["right"] = -15;
    franticaimlimits["cover_left_lean"] = aimlimit;
    aimlimit = [];
    aimlimit["right"] = -15;
    combataimlimits["cover_left_crouch_lean"] = aimlimit;
    aimlimit = [];
    aimlimit["right"] = -15;
    franticaimlimits["cover_left_crouch_lean"] = aimlimit;
    aimlimit = [];
    aimlimit["left"] = 15;
    combataimlimits["cover_right_lean"] = aimlimit;
    aimlimit = [];
    aimlimit["down"] = 37;
    aimlimit["left"] = 24;
    franticaimlimits["cover_right_lean"] = aimlimit;
    aimlimit = [];
    aimlimit["left"] = 25;
    combataimlimits["cover_right_crouch_lean"] = aimlimit;
    aimlimit = [];
    aimlimit["left"] = 15;
    franticaimlimits["cover_right_crouch_lean"] = aimlimit;
    level.combataimlimits[asmname] = combataimlimits;
    level.franticaimlimits[asmname] = franticaimlimits;
  }

  if(!isDefined(level.aimlimitstatemappings[asmname])) {
    var_26893ce84a67261 = [];
    var_26893ce84a67261["cover_stand_exposed"] = "cover_stand_exposed";
    var_26893ce84a67261["cover_stand_hide_to_exposed"] = "cover_stand_exposed";
    var_26893ce84a67261["cover_stand_full_exposed"] = "exposed_idle";
    var_26893ce84a67261["cover_stand_hide_to_full_exposed"] = "exposed_idle";
    var_26893ce84a67261["cover_stand_to_exposed_idle"] = "exposed_idle";
    var_26893ce84a67261["wall_run_exit"] = "exposed_idle";
    var_26893ce84a67261["wall_run_continue"] = "exposed_idle";
    var_26893ce84a67261["wall_run_left_shoot"] = "exposed_idle";
    var_26893ce84a67261["wall_run_right_shoot"] = "exposed_idle";
    var_26893ce84a67261["wall_run_attach_left_shoot"] = "exposed_idle";
    var_26893ce84a67261["wall_run_attach_right_shoot"] = "exposed_idle";
    var_26893ce84a67261["cover_crouch_hide_to_stand"] = "exposed_idle";
    var_26893ce84a67261["cover_crouch_hide_to_aim"] = "cover_crouch_aim";
    var_26893ce84a67261["cover_crouch_hide_to_right"] = "cover_crouch_aim";
    var_26893ce84a67261["cover_crouch_hide_to_left"] = "cover_crouch_aim";
    var_26893ce84a67261["cover_crouch_hide_to_lean"] = "cover_crouch_lean";
    var_26893ce84a67261["cover_crouch_aim"] = "cover_crouch_aim";
    var_26893ce84a67261["cover_crouch_lean"] = "cover_crouch_lean";
    var_26893ce84a67261["cover_crouch_exposed_left"] = "cover_crouch_aim";
    var_26893ce84a67261["cover_crouch_exposed_right"] = "cover_crouch_aim";
    var_26893ce84a67261["cover_crouch_stand"] = "exposed_idle";
    var_26893ce84a67261["cover_crouch_to_exposed_idle"] = "exposed_idle";
    var_26893ce84a67261["cover_right_exposed_a"] = "exposed_idle";
    var_26893ce84a67261["cover_right_hide_to_a"] = "exposed_idle";
    var_26893ce84a67261["cover_right_exposed_b"] = "exposed_idle";
    var_26893ce84a67261["cover_right_hide_to_b"] = "exposed_idle";
    var_26893ce84a67261["cover_right_a_to_b"] = "exposed_idle";
    var_26893ce84a67261["cover_right_b_to_a"] = "exposed_idle";
    var_26893ce84a67261["cover_right_crouch_exposed_a"] = "exposed_idle";
    var_26893ce84a67261["cover_right_crouch_exposed_b"] = "exposed_idle";
    var_26893ce84a67261["cover_right_crouch_hide_to_a"] = "exposed_idle";
    var_26893ce84a67261["cover_right_crouch_hide_to_b"] = "exposed_idle";
    var_26893ce84a67261["cover_right_crouch_a_to_b"] = "exposed_idle";
    var_26893ce84a67261["cover_right_crouch_b_to_a"] = "exposed_idle";
    var_26893ce84a67261["cover_right_lean"] = "cover_right_lean";
    var_26893ce84a67261["cover_right_hide_to_lean"] = "cover_right_lean";
    var_26893ce84a67261["cover_right_crouch_hide_to_lean"] = "cover_right_crouch_lean";
    var_26893ce84a67261["cover_right_crouch_lean"] = "cover_right_crouch_lean";
    var_26893ce84a67261["cover_right_to_exposed_idle"] = "exposed_idle";
    var_26893ce84a67261["cover_left_exposed_a"] = "exposed_idle";
    var_26893ce84a67261["cover_left_exposed_b"] = "exposed_idle";
    var_26893ce84a67261["cover_left_hide_to_a"] = "exposed_idle";
    var_26893ce84a67261["cover_left_hide_to_b"] = "exposed_idle";
    var_26893ce84a67261["cover_left_a_to_b"] = "exposed_idle";
    var_26893ce84a67261["cover_left_b_to_a"] = "exposed_idle";
    var_26893ce84a67261["cover_left_hide_to_lean"] = "cover_left_lean";
    var_26893ce84a67261["cover_left_lean"] = "cover_left_lean";
    var_26893ce84a67261["cover_left_crouch_hide_to_lean"] = "cover_left_crouch_lean";
    var_26893ce84a67261["cover_left_crouch_lean"] = "cover_left_crouch_lean";
    var_26893ce84a67261["cover_left_to_exposed_idle"] = "exposed_idle";
    var_26893ce84a67261["cqb_idle"] = "exposed_idle";
    var_26893ce84a67261["cqb_stand_loop"] = "exposed_idle";
    var_26893ce84a67261["cqb_stand_strafe_loop"] = "exposed_idle";
    var_26893ce84a67261["stand_run_strafe_loop"] = "exposed_idle";
    var_26893ce84a67261["exposed_reload"] = "exposed_idle";
    var_26893ce84a67261["exposed_weaponswitch"] = "exposed_idle";
    var_26893ce84a67261["exposed_stand_turn"] = "exposed_idle";
    var_26893ce84a67261["exposed_idle"] = "exposed_idle";
    var_26893ce84a67261["exposed_prone"] = "exposed_idle";
    var_26893ce84a67261["exposed_stand_infantry_reaction"] = "exposed_idle";
    level.aimlimitstatemappings[asmname] = var_26893ce84a67261;
  }
}

function initanimspeedthresholds_soldier(animsetname) {
  if(istrue(anim.var_432836e99816347c[animsetname])) {
    return;
  }

  if(animspeedthresholdsexist(animsetname)) {
    return;
  }

  if(animsetname == "boss" || animsetname == "boss2") {
    setspeedthreshold(animsetname, "shuffle", 30);
  } else {
    setspeedthreshold(animsetname, "shuffle", 23);
  }

  if(animsetname == "guard_01" || animsetname == "guard_02") {
    setspeedthreshold(animsetname, "walk", 36);
  } else {
    setspeedthreshold(animsetname, "walk", 65);
  }

  setspeedthreshold(animsetname, "fast", 104);
  setspeedthreshold(animsetname, "jog", 178);
  setspeedthreshold(animsetname, "run", 210);
  setspeedthreshold(animsetname, "sprint", 250);
  anim.var_432836e99816347c[animsetname] = 1;
}

function needtoturn3d(asmname, statename, tostatename, params) {
  if(istrue(self.matchexposednodeorientation) && isDefined(self.node)) {
    return false;
  }

  yaw = getturndesiredyaw3d();

  if(abs(yaw) > self.turnthreshold) {
    return true;
  }

  pitch = getturndesiredpitch3d();

  if(abs(pitch) > self.pitchturnthreshold) {
    return true;
  }

  return false;
}

function getturndesiredyaw() {
  if(isDefined(self.desiredturnyaw)) {
    return self.desiredturnyaw;
  }

  predicttime = 0.25;
  shootent = undefined;
  shootpos = undefined;

  if(self bb_shootparamsvalid()) {
    if(isDefined(self._blackboard.shootparams_pos)) {
      shootpos = self._blackboard.shootparams_pos;
    } else if(isDefined(self._blackboard.shootparams_ent)) {
      shootent = self._blackboard.shootparams_ent;
    }
  } else if(isDefined(self.smartfacingpos)) {
    shootpos = self.smartfacingpos;
  }

  if(!isDefined(shootpos) && isDefined(self.node) && self.node.type == "Exposed" && distancesquared(self.node.origin, self.origin) < 36) {
    return angleclamp180(self.node.angles[1] - self.angles[1]);
  }

  if(isDefined(shootent) && !issentient(shootent)) {
    predicttime = 1.5;
  }

  desiredyaw = getpredictedaimyawtoshootentorpos(predicttime, shootent, shootpos);
  return desiredyaw;
}

function getturndesiredyaw3d() {
  predicttime = 0.25;
  shootent = undefined;
  shootpos = undefined;

  if(self bb_shootparamsvalid()) {
    if(isDefined(self._blackboard.shootparams_ent)) {
      shootent = self._blackboard.shootparams_ent;
    } else if(isDefined(self._blackboard.shootparams_pos)) {
      shootpos = self._blackboard.shootparams_pos;
    }
  } else if(isDefined(self.enemy)) {
    shootent = self.enemy;
  }

  if(isDefined(shootent) && !issentient(shootent)) {
    predicttime = 1.5;
  }

  desiredyaw = getpredictedaimyawtoshootentorpos3d(predicttime, shootent, shootpos);
  return desiredyaw;
}

function getturndesiredpitch3d() {
  predicttime = 0.25;
  shootent = undefined;
  shootpos = undefined;

  if(self bb_shootparamsvalid()) {
    if(isDefined(self._blackboard.shootparams_ent)) {
      shootent = self._blackboard.shootparams_ent;
    } else if(isDefined(self._blackboard.shootparams_pos)) {
      shootpos = self._blackboard.shootparams_pos;
    }
  } else if(isDefined(self.enemy)) {
    shootent = self.enemy;
  }

  if(isDefined(shootent) && !issentient(shootent)) {
    predicttime = 1.5;
  }

  desiredpitch = getpredictedaimpitchtoshootentorpos3d(predicttime, shootent, shootpos);
  return desiredpitch;
}

function chooseturnanim3d(asmname, statename, params) {
  desiredyaw = getturndesiredyaw3d();
  desiredpitch = getturndesiredpitch3d();

  if(abs(desiredyaw) > self.turnthreshold && abs(desiredyaw) > abs(desiredpitch)) {
    if(desiredyaw < 0) {
      direction = "right";
    } else {
      direction = "left";
    }

    desiredyaw = abs(desiredyaw);
    angle = 0;

    if(desiredyaw > 157.5) {
      angle = 180;
    } else if(desiredyaw > 112.5) {
      angle = 135;
    } else if(desiredyaw > 67.5) {
      angle = 90;
    } else {
      angle = 45;
    }

    animalias = direction + "_" + angle;
    turnanim = asm_lookupanimfromalias(statename, animalias);
    return turnanim;
  }

  if(desiredpitch < 0) {
    direction = "up";
  } else {
    direction = "down";
  }

  desiredpitch = abs(desiredpitch);
  angle = 0;

  if(desiredpitch > 157.5) {
    angle = 180;
  } else if(desiredpitch > 112.5) {
    angle = 135;
  } else if(desiredpitch > 67.5) {
    angle = 90;
  } else {
    angle = 45;
  }

  animalias = direction + "_" + angle;
  turnanim = asm_lookupanimfromalias(statename, animalias);
  return turnanim;
}

function choosecrouchturnanim(asmname, statename, params) {
  desiredyaw = getturndesiredyaw();

  if(desiredyaw < -135) {
    alias = "2r";
  } else if(desiredyaw > 135) {
    alias = "2l";
  } else if(desiredyaw < 0) {
    alias = "6";
  } else {
    alias = "4";
  }

  turnanim = asm_lookupanimfromalias(statename, alias);
  return turnanim;
}

function reload_cleanup(asmname, statename, params) {
  nullweapon = nullweapon();
  weap = self.var_1e61bb39def2d99d;
  self.var_1e61bb39def2d99d = nullweapon;

  if(!isDefined(self.weaponinfo)) {
    return;
  }

  var_78e527f9f68f891e = weap != nullweapon && isDefined(self.weapon) && weap == self.weapon;

  if(weap == nullweapon) {
    weap = self.weapon;
  }

  weaponname = getcompleteweaponname(weap);

  if(!isDefined(self.weaponinfo[weaponname])) {
    return;
  }

  if(!asm_eventfired(asmname, "drop clip")) {
    return;
  }

  if(self.weaponinfo[weaponname].useclip) {
    clipmodel = getweaponclipmodel(weap);

    if(isDefined(clipmodel)) {
      battached = asm_eventfired(asmname, "attach clip left") || asm_eventfired(asmname, "attach clip right");
      var_7cb5a062f767fb6f = asm_eventfired(asmname, "detach clip left") || asm_eventfired(asmname, "detach clip right") || asm_eventfired(asmname, "detach clip nohand");

      if(!battached) {
        self notify("abort_reload");
        return;
      }

      if(battached && !var_7cb5a062f767fb6f) {
        if(asm_eventfired(asmname, "attach clip left")) {
          tagname = "tag_accessory_left";
        } else {
          tagname = "tag_accessory_right";
        }

        self detach(clipmodel, tagname);
        self notify("clip_detached");

        if(var_78e527f9f68f891e) {
          showweaponmagattachment(weaponname);
        }
      }
    }
  }
}

function terminateexposedprone(asmname, statename, params) {
  self.pushable = 1;
}

function terminateexposedidleaimdown(asmname, statename, params) {
  self.aimingdown = 0;
}

function terminateexposedcrouchaimdown(asmname, statename, params) {
  self.aimingdown = 0;
}

function shouldfaceenemyinexposed() {
  if(isDefined(self.pathgoalpos)) {
    return false;
  }

  return isDefined(self.enemy) && isPlayer(self.enemy) && self cansee(self.enemy);
}

function playanim_weaponswitch(asmname, statename, params) {
  self endon(statename + "_finished");
  weapclass = bb_getrequestedweapon();
  animname = asm_getanim(asmname, statename);
  animrate = scripts\anim\combat_utility::fasteranimspeed();
  self aisetanim(statename, animname, animrate);
  asm_playfacialanim(asmname, statename, asm_getxanim(statename, animname));
  asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename));
  self notify("switched_to_sidearm");
  scripts\common\gameskill::didsomethingotherthanshooting();
}

function terminate_weaponswitch(asmname, statename, params) {
  weapclass = weaponclass(self.weapon);
  updateweaponarchetype(weapclass);
}

function playturnanim_turnanimanglefixup(turnxanim, statename) {
  self endon("death");
  self endon(statename + "_finished");
  enemy = self.enemy;
  enemy endon("death");
  animlength = getanimlength(turnxanim);

  if(animhasnotetrack(turnxanim, "start_aim")) {
    finish_time = getnotetracktimes(turnxanim, "start_aim");
    animlength *= finish_time[0];
  } else if(animhasnotetrack(turnxanim, "finish")) {
    finish_time = getnotetracktimes(turnxanim, "finish");
    animlength *= finish_time[0];
  }

  numframes = int(animlength * 20);
  remainingframes = numframes;

  while(remainingframes > 0) {
    lerpfraction = 1 / remainingframes;
    yawtoenemy = getyawtospot(enemy.origin);
    self.stepoutyaw = angleclamp180(self.angles[1] + yawtoenemy);
    currentanimtime = self aigetanimtime(turnxanim);
    var_993a8f9635e274cf = getangledelta(turnxanim, currentanimtime, 1);
    remainingyaw = angleclamp180(yawtoenemy - var_993a8f9635e274cf);
    self orientmode("face angle", angleclamp(self.angles[1] + remainingyaw * lerpfraction));
    remainingframes--;
    wait 0.05;
  }
}

function shouldsnaptocover_checktype(asmname, statename, tostatename, params) {
  if(bb_moverequested()) {
    return 0;
  }

  if(!isatcovernode()) {
    return 0;
  }

  if(!isDefined(self.node)) {
    return 0;
  }

  if(isDefined(self.primaryweapon) && scripts\anim\utility_common::isusingsidearm() && weaponclass(self.primaryweapon) != "mg") {
    return 0;
  }

  assert(isDefined(params));
  return isarrivaltype(asmname, statename, tostatename, params);
}

function reloadnotehandler(note) {
  scripts\anim\notetracks::notetrack_prefix_handler(note);
  return undefined;
}

function assesscleanup(asmname, statename, params) {
  self._blackboard.var_74f8f2b8eff7c7f = 0;
}

function function_9d9a4c83d3a8b338(asmname, statename, tostatename, params) {
  if(!isDefined(self.assesslength)) {
    return true;
  }

  if(gettime() < self.assesslength) {
    return false;
  }

  return true;
}

function facegoalthread_newenemyreaction(statename, reactworldyaw) {
  self notify("FaceGoalThread");
  self endon("FaceGoalThread");
  self endon("death");
  self endon(statename + "_finished");

  while(true) {
    multiplier = 0.25;
    var_fd4e44b47427d5c6 = angleclamp180(reactworldyaw - self.angles[1]);
    self orientmode("face angle", self.angles[1] + var_fd4e44b47427d5c6 * multiplier);
    waitframe();
  }
}

function handlefacegoalnotetrack_newenemyreaction(statename, note, lastknown) {
  assert(isDefined(lastknown));

  if(note == "face_goal") {
    var_63cc85541246c7b4 = lastknown - self.origin;
    reactworldyaw = vectortoyaw(var_63cc85541246c7b4);
    thread facegoalthread_newenemyreaction(statename, reactworldyaw);
    return true;
  }

  return false;
}

function playanim_newenemyreaction(asmname, statename, params) {
  self endon(statename + "_finished");
  pushdisabledgunpose();
  reactanim = self asmgetanim(asmname, statename);
  assert(isDefined(reactanim));
  reactxanim = asm_getxanim(statename, reactanim);
  self aisetanim(statename, reactanim);
  lastknown = self lastknownpos(self.enemy);
  thread playturnanim_turnanimanglefixup(reactxanim, statename);
  asm_donotetrackswithinterceptor(asmname, statename, &handlefacegoalnotetrack_newenemyreaction, lastknown);

  if(isDefined(self.enemy) && self cansee(self.enemy)) {
    self.remainexposedendtime = gettime() + 2000;
  }
}

function chooseanim_playerpushed(asmname, statename, params) {
  movedir = asm_getephemeraleventdata("player_pushed", "player_pushed");
  movedirnormalized = vectorNormalize(movedir);
  targetangles = vectortoangles(movedirnormalized);
  targetyaw = angleclamp180(targetangles[1] - self.angles[1]);
  angleindex = scripts\asm\asm::yawdiffto2468(targetyaw);
  aliasname = "pushed_" + angleindex;
  turnanim = asm_lookupanimfromalias(statename, aliasname);
  return turnanim;
}

function terminate_casualkiller(asmname, statename, params) {
  self setbasearchetype(self findoverridearchetype("default"));
  self clearoverridearchetype("demeanor", 0, 1);
  self.newenemyreaction = 0;
  self.forcenewenemyreaction = 0;
  self notify("leaveCasualKiller");
  self.leavecasualkiller = 0;
  self.casualkiller = 0;
  self setdefaultaimlimits();
}

function pushdisabledgunpose() {
  if(isDefined(self.gunposeoverride)) {
    self.stashedgunposeoverride = self.gunposeoverride;
  }

  self.gunposeoverride = "disable";
}

function popdisabledgunpose() {
  if(isDefined(self.stashedgunposeoverride)) {
    self.gunposeoverride = self.stashedgunposeoverride;
    self.stashedgunposeoverride = undefined;
    return;
  }

  self.gunposeoverride = undefined;
}

function function_e9cdfb92cc489acb(asmname, statename, params) {
  self function_f662e31df8183bf8(self.origin, self.angles);
  loopanim(asmname, statename, params);
}

function function_33294352d1956570(asmname, statename, tostatename, params) {
  if(istrue(self.var_9dc04ef5e55f3574)) {
    self function_1c339daaba3f71db(1);
    utility::lookatentity(self.var_c7cd5e7e287a7df8);
  }

  return asm_lookupanimfromalias(statename, self.dodgedirection);
}

function function_78fcdbc229ec648c(asmname, statename, tostatename, params) {
  self function_1c339daaba3f71db(0);
  self.var_be159be38e485344 = 0;
  self.var_1f391695bca4a279 = 1;
}

function forwardpushevent(asmname, statename, tostatename, params) {
  movedir = asm_geteventdata(asmname, "player_pushed");
  asm_fireephemeralevent("player_pushed", "player_pushed", movedir);
}