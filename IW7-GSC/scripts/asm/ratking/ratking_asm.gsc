/***********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\asm\ratking\ratking_asm.gsc
***********************************************/

ratkinginit(var_0, var_1, var_2, var_3) {
  scripts\asm\zombie\zombie::func_13F9A(var_0, var_1, var_2, var_3);
  self.var_71D0 = ::scripts\mp\agents\ratking\ratking_agent::shouldratkingplaypainanim;
  self._blackboard.requestedshieldstate = "equipped";
  self.asm.shieldstate = "equipped";
}

isvalidaction(var_0) {
  switch (var_0) {
    case "shield_throw":
    case "shield_throw_at_spot":
    case "teleport":
    case "staff_projectile":
    case "block":
    case "summon":
    case "staff_stomp":
    case "melee_attack":
      return 1;
  }

  return 0;
}

setaction(var_0) {
  self.requested_action = var_0;
}

clearaction() {
  self.requested_action = undefined;
}

shouldendblock(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.requested_action) || self.requested_action != "block") {
    return 1;
  }

  return 0;
}

shouldplayentranceanim(var_0, var_1, var_2, var_3) {
  return 1;
}

playanimandlookatenemy(var_0, var_1, var_2, var_3) {
  thread scripts\asm\zombie\melee::func_6A6A(var_1, scripts\mp\agents\ratking\ratking_agent::getenemy());
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4, 1);
}

isanimdone(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm::func_232B(var_1, "end")) {
    return 1;
  }

  if(scripts\asm\asm::func_232B(var_1, "early_end")) {
    return 1;
  }

  if(scripts\asm\asm::func_232B(var_1, "finish_early")) {
    return 1;
  }

  if(scripts\asm\asm::func_232B(var_1, "code_move")) {
    return 1;
  }

  return 0;
}

playtauntanim(var_0, var_1, var_2, var_3) {
  self notify("taunt");
  thread scripts\asm\zombie\melee::func_6A6A(var_1, scripts\mp\agents\ratking\ratking_agent::getenemy());
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

dosummonspawn() {
  var_0 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
  foreach(var_2 in self.spawnpoints) {
    var_3 = scripts\cp\zombies\zombies_spawning::func_13F53(var_0.summon_agent_type, var_2, self.angles, "axis");
    if(!isDefined(var_3)) {
      break;
    }

    var_3 thread scripts\cp\zombies\zombies_spawning::func_64E7(var_0.summon_agent_type);
  }
}

damagezombies(var_0, var_1) {
  var_2 = scripts\mp\mp_agent::getactiveagentsoftype("generic_zombie");
  var_3 = var_1 * var_1;
  foreach(var_5 in var_2) {
    var_6 = distancesquared(var_5.origin, var_0);
    if(var_6 > var_3) {
      continue;
    }

    var_5 dodamage(var_5.health * 10, var_0, self, self, "MOD_IMPACT");
  }
}

dostaffstompdamage(var_0, var_1) {
  if(isDefined(var_0)) {
    self endon(var_0 + "_finished");
  }

  if(isDefined(var_1)) {
    wait(var_1);
  }

  var_2 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
  self setscriptablepartstate("attacks", "staff_stomp");
  self radiusdamage(self.origin, var_2.staff_stomp_damage_radius, var_2.staff_stomp_max_damage, var_2.staff_stomp_min_damage, self, "MOD_IMPACT");
  if(scripts\engine\utility::istrue(self.battackzombies)) {
    damagezombies(self.origin, var_2.staff_stomp_damage_radius);
  }
}

staffstompnotehandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "hit") {
    dostaffstompdamage(var_1);
  }
}

dostaffstomp(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  thread scripts\asm\zombie\melee::func_6A6A(var_1, scripts\mp\agents\ratking\ratking_agent::getenemy());
  self notify("stomp");
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

summonnotehandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "start_summon_zombies") {
    self notify("summon");
    dosummonspawn();
  }
}

ratkingturnnotehandler(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0)) {
    switch (var_0) {
      case "right":
        self setscriptablepartstate("turns", "right");
        break;

      case "left":
        self setscriptablepartstate("turns", "left");
        break;

      default:
        self setscriptablepartstate("turns", "forward");
        break;
    }
  }
}

meleenotehandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "hit") {
    var_4 = scripts\mp\agents\ratking\ratking_agent::getenemy();
    if(isDefined(var_4)) {
      if(distancesquared(var_4.origin, self.origin) < -25536) {
        self notify("attack_hit", var_4);
        if(var_4.team == "axis" && scripts\engine\utility::istrue(self.battackzombies)) {
          scripts\asm\zombie\melee::domeleedamage(var_4, var_4.health * 10, "MOD_IMPACT");
        } else {
          scripts\asm\zombie\melee::domeleedamage(var_4, self.var_B601, "MOD_IMPACT");
        }
      } else {
        self notify("attack_miss", var_4);
      }
    }

    if(!scripts\engine\utility::istrue(self.bmovingmelee)) {
      self notify("stop_melee_face_enemy");
    }
  }
}

shieldthrowatspotnotehandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "hit") {
    var_4 = scripts\mp\agents\ratking\ratking_agent::getstructpos();
    if(!isDefined(var_4)) {
      return;
    }

    var_5 = self gettagorigin("J_Shield_LE");
    var_6 = var_4.origin;
    var_7 = magicbullet("iw7_ratking_shield_projectile", var_5, var_6, self);
    self setscriptablepartstate("shield", "neutral");
    thread scripts\aitypes\ratking\behaviors::throwandrecovershield(1);
  }
}

shieldthrownotehandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "hit") {
    var_4 = scripts\mp\agents\ratking\ratking_agent::getenemy();
    if(!isDefined(var_4)) {
      return;
    }

    var_5 = self gettagorigin("J_Shield_LE");
    var_6 = var_4 getEye() - (0, 0, 12);
    magicbullet("iw7_ratking_shield_projectile", var_5, var_6, self);
    self setscriptablepartstate("shield", "neutral");
    thread scripts\aitypes\ratking\behaviors::throwandrecovershield(5);
  }
}

shieldthrowatspothack(var_0) {
  self endon(var_0 + "_finished");
  wait(0.8);
  shieldthrowatspotnotehandler("hit", var_0, 1, 0);
}

doshieldthrowatspot(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\mp\agents\ratking\ratking_agent::getstructpos();
  if(isDefined(var_4)) {
    self.setplayerignoreradiusdamage = var_4.origin;
  }

  scripts\mp\agents\ratking\ratking_agent::lookatspot();
  self notify("shield_throw");
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
  self.setplayerignoreradiusdamage = undefined;
}

aimatenemy(var_0, var_1) {
  self endon(var_0 + "_finished");
  while(isDefined(var_1) && isalive(var_1)) {
    self.setplayerignoreradiusdamage = var_1 getshootatpos();
    scripts\engine\utility::waitframe();
  }
}

clearlooktarget(var_0, var_1, var_2) {
  self.setplayerignoreradiusdamage = undefined;
}

doshieldthrow(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  scripts\mp\agents\ratking\ratking_agent::lookatenemy();
  thread aimatenemy(var_1, scripts\mp\agents\ratking\ratking_agent::getenemy());
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
  self.setplayerignoreradiusdamage = undefined;
}

shouldabortaction(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::istrue(self.btraversalteleport)) {
    return 0;
  }

  if(!isDefined(self.requested_action)) {
    return 1;
  }

  if(isDefined(var_3)) {
    if(self.requested_action != var_3) {
      return 1;
    }
  }

  return 0;
}

shoulddoaction(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.requested_action)) {
    return 0;
  }

  if(self.requested_action == var_2) {
    return 1;
  }

  return 0;
}

playanimwithplaybackrate(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = var_3;
  var_5 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_5, var_4);
}

playblockanim(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = vectortoangles(self.damageaccumulator.lastdir * -1);
  var_4 = (0, var_4[1], 0);
  self orientmode("face angle abs", var_4);
  self ghostlaunched("anim deltas");
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

func_BEA0(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = scripts\mp\agents\ratking\ratking_agent::getenemy();
  if(isDefined(self._blackboard.shootparams) && isDefined(self._blackboard.shootparams.ent)) {
    var_4 = self._blackboard.shootparams.ent.origin;
  } else if(isDefined(self._blackboard.shootparams) && isDefined(self._blackboard.shootparams.pos)) {
    var_4 = self._blackboard.shootparams.pos;
  } else if(isDefined(var_5)) {
    var_4 = var_5.origin;
  }

  if(!isDefined(var_4)) {
    return 0;
  }

  var_6 = self.angles[1] - vectortoyaw(var_4 - self.origin);
  var_7 = distancesquared(self.origin, var_4);
  if(var_7 < 65536) {
    var_8 = sqrt(var_7);
    if(var_8 > 3) {
      var_6 = var_6 + asin(-3 / var_8);
    }
  }

  if(abs(angleclamp180(var_6)) > self.var_129AF) {
    return 1;
  }

  return 0;
}

_meth_81DE() {
  var_0 = 0.25;
  var_1 = undefined;
  var_2 = undefined;
  if(isDefined(self._blackboard.shootparams)) {
    if(isDefined(self._blackboard.shootparams.ent)) {
      var_1 = self._blackboard.shootparams.ent;
    } else if(isDefined(self._blackboard.shootparams.pos)) {
      var_2 = self._blackboard.shootparams.pos;
    }
  }

  var_3 = scripts\mp\agents\ratking\ratking_agent::getenemy();
  if(isDefined(var_3)) {
    if(!isDefined(var_1) && !isDefined(var_2)) {
      var_1 = var_3;
    }
  }

  if(isDefined(var_1) && !issentient(var_1)) {
    var_0 = 1.5;
  }

  var_4 = scripts\engine\utility::getpredictedaimyawtoshootentorpos(var_0, var_1, var_2);
  return var_4;
}

choosestaffornostaffanim(var_0, var_1, var_2) {
  if(scripts\engine\utility::istrue(self.nostaff)) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "nostaff");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "staff");
}

chooseshieldornoshieldanim(var_0, var_1, var_2) {
  if(self.asm.shieldstate == "equipped") {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "shield");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "noshield");
}

func_3F0A(var_0, var_1, var_2) {
  var_3 = _meth_81DE();
  if(var_3 < 0) {
    var_4 = "right";
  } else {
    var_4 = "left";
  }

  var_3 = abs(var_3);
  var_5 = 0;
  if(var_3 > 157.5) {
    var_5 = 180;
  } else if(var_3 > 112.5) {
    var_5 = 135;
  } else if(var_3 > 67.5) {
    var_5 = 90;
  } else {
    var_5 = 45;
  }

  var_6 = var_4 + "_" + var_5;
  var_7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_6);
  var_8 = self _meth_8101(var_1, var_7);
  return var_7;
}

func_D56A(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_5 = self.vehicle_getspawnerarray;
  self orientmode("face angle abs", self.angles);
  self ghostlaunched("anim deltas");
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4);
  if(!isDefined(var_5) && isDefined(self.vehicle_getspawnerarray)) {
    self clearpath();
  }

  scripts\asm\asm_mp::func_237F("face current");
  scripts\asm\asm_mp::func_237E("code_move");
}

playmeleeattack(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  thread scripts\asm\zombie\melee::func_6A6A(var_1, self.curmeleetarget);
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  self notify("melee");
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4);
}

choosemeleeattack(var_0, var_1, var_2) {
  if(scripts\asm\asm_bb::bb_moverequested()) {
    var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "attack_moving");
  } else {
    var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_2, "attack");
  }

  return var_3;
}

func_3EE4(var_0, var_1, var_2) {
  return lib_0F3C::func_3EF4(var_0, var_1, var_2);
}

playmovingpainanim(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  if(!isDefined(self.vehicle_getspawnerarray) || self pathdisttogoal() < scripts\mp\agents\ratking\ratking_tunedata::gettunedata().min_moving_pain_dist) {
    var_4 = func_3EE4(var_0, "pain_generic", var_3);
    self orientmode("face angle abs", self.angles);
    self notify("pain");
    scripts\asm\asm_mp::func_2365(var_0, "pain_generic", var_2, var_4, 1);
    return;
  }

  self notify("pain");
  scripts\asm\asm_mp::func_2364(var_1, var_2, var_3, var_4);
}

playteleportin(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  if(!scripts\aitypes\ratking\behaviors::rk_isonplatform()) {
    self setscriptablepartstate("movement", "dematerialize");
  }

  playanimwithplaybackrate(var_0, var_1, var_2, var_3);
}

terminate_teleportout(var_0, var_1, var_2) {}

shouldconsiderabortingteleport(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::istrue(self.ishidden)) {
    return 0;
  }

  return shouldabortaction(var_0, var_1, var_2, "teleport");
}

playteleportout(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self endon("death");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_5 = scripts\mp\agents\ratking\ratking_agent::getenemy();
  self.ishidden = 1;
  wait(0.1);
  self dontinterpolate();
  self hide();
  if(scripts\engine\utility::istrue(self.fake_death)) {
    scripts\mp\agents\ratking\ratking_agent::executefakedeath();
  }

  scripts\aitypes\ratking\behaviors::setplatformstate();
  var_6 = undefined;
  if(!scripts\aitypes\ratking\behaviors::rk_isonplatform()) {
    var_6 = spawnfx(level._effect["rk_tele_spot"], self.teleportpos);
    triggerfx(var_6);
  }

  self setorigin(self.teleportpos, 0);
  if(isDefined(var_5)) {
    self.angles = vectortoangles(var_5.origin - self.origin);
  }

  self.teleportpos = undefined;
  self ghostskulls_complete_status(self.origin);
  self clearpath();
  thread showmelater(var_6);
  if(!scripts\engine\utility::istrue(self.btraversalteleport)) {
    scripts\mp\agents\ratking\ratking_agent::lookatenemy();
  }

  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4, 1);
  if(scripts\engine\utility::istrue(self.btraversalteleport)) {
    self.is_traversing = undefined;
    self.btraversalteleport = undefined;
    self notify("traverse_end");
    scripts\asm\asm::asm_setstate("decide_idle", var_3);
  }
}

showmelater(var_0) {
  if(scripts\aitypes\ratking\behaviors::rk_isonplatform()) {
    self setscriptablepartstate("rat_skirt", "platform");
  } else {
    self setscriptablepartstate("movement", "materialize");
    self setscriptablepartstate("rat_skirt", "active");
  }

  wait(0.1);
  self show();
  self.ishidden = 0;
  thread gibnearbyzombies(0.1);
  wait(1);
  if(isDefined(var_0)) {
    var_0 delete();
  }

  if(scripts\aitypes\ratking\behaviors::rk_isonplatform()) {
    self setscriptablepartstate("movement", "neutral");
  }
}

gibnearbyzombies(var_0) {
  if(isDefined(var_0)) {
    wait(var_0);
  }

  var_1 = scripts\mp\mp_agent::getaliveagents();
  var_2 = scripts\mp\agents\ratking\ratking_agent::getenemy();
  var_3 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
  foreach(var_5 in var_1) {
    if(var_5 == self) {
      continue;
    }

    if(var_5.team == "allies") {
      continue;
    }

    if(isDefined(var_2) && var_5 == var_2) {
      continue;
    }

    var_6 = distancesquared(self.origin, var_5.origin);
    if(var_6 > var_3.telefrag_dist_sq) {
      continue;
    }

    var_5 gibthyself();
  }
}

gibthyself() {
  self.nocorpse = 1;
  self.full_gib = 1;
  self dodamage(self.health + -15536, self.origin);
}

play_teleport_sound_to_players(var_0) {
  foreach(var_2 in level.players) {
    if(!self isethereal() || scripts\engine\utility::istrue(var_2.rave_mode)) {
      self playsoundtoplayer(var_0, var_2);
    }
  }
}

ontraversalteleport(var_0, var_1, var_2, var_3) {
  self.teleportpos = self _meth_8146();
  self.btraversalteleport = 1;
  return 1;
}

platformfaceenemy(var_0) {
  self endon(var_0 + "_finished");
  for(;;) {
    var_1 = scripts\mp\agents\ratking\ratking_agent::getenemy();
    if(isDefined(var_1) && isalive(var_1)) {
      self orientmode("face angle abs", (0, vectortoyaw(var_1.origin - self.origin), 0));
    }

    scripts\engine\utility::waitframe();
  }
}

playplatformidle(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self clearpath();
  thread platformfaceenemy(var_1);
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

dostaffprojectile(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  thread scripts\asm\zombie\melee::func_6A6A(var_1, scripts\mp\agents\ratking\ratking_agent::getenemy());
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

dostaffprojectiledamage(var_0, var_1, var_2, var_3) {
  var_4 = var_1 * var_1;
  var_5 = scripts\common\trace::create_default_contents(1);
  var_6 = scripts\common\trace::ray_trace(var_0 + (0, 0, var_2), var_0 - (0, 0, var_2), self, var_5);
  var_0 = getgroundposition(var_0, 8);
  foreach(var_8 in level.players) {
    if(!isalive(var_8)) {
      continue;
    }

    if(var_8.ignoreme || isDefined(var_8.triggerportableradarping) && var_8.triggerportableradarping.ignoreme) {
      continue;
    }

    if(scripts\mp\agents\zombie\zombie_util::shouldignoreent(var_8)) {
      continue;
    }

    var_9 = distance2dsquared(var_0, var_8.origin);
    if(var_9 > var_4) {
      continue;
    }

    if(abs(var_0[2] - var_8.origin[2]) > var_2) {
      continue;
    }

    var_8 dodamage(var_3, var_0, self, self, "MOD_IMPACT");
  }
}

handlestaffprojectile() {
  var_0 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
  var_1 = anglesToForward(self.angles);
  var_2 = var_0.staff_projectile_range / var_0.staff_projectile_speed;
  var_3 = var_0.staff_projectile_speed * var_0.staff_projectile_interval;
  var_4 = var_3 / 2;
  var_5 = self.origin + var_1 * var_4;
  var_6 = gettime() + var_2 * 1000;
  var_7 = spawn("script_model", var_5);
  var_7 setModel("tag_origin_staff_proj");
  var_7 show();
  var_7.angles = var_1;
  playsoundatpos(var_5, "rk_fissure_deploy_lr");
  thread delayprojectileloopsound(var_7, var_0.staff_projectile_interval);
  while(gettime() < var_6) {
    dostaffprojectiledamage(var_5, var_4, var_0.staff_projectile_z_delta, var_0.staff_projectile_damage);
    var_7 moveto(var_5, var_0.staff_projectile_interval);
    wait(var_0.staff_projectile_interval);
    var_5 = var_5 + var_1 * var_3;
    var_7.angles = vectortoangles(var_5 - var_7.origin);
  }

  var_7 stoploopsound();
  var_7 delete();
}

delayprojectileloopsound(var_0, var_1) {
  level endon("game_ended");
  wait(var_1);
  var_0 scripts\engine\utility::play_loop_sound_on_entity("rk_fissure_ground_lp", (0, 0, 12));
}

staffprojectilenotehandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "hit") {
    handlestaffprojectile();
  }
}

lostorfoundstaff(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::istrue(self.bstaffchanged)) {
    self.bstaffchanged = undefined;
    return 1;
  }

  return 0;
}

lostorfoundshield(var_0, var_1, var_2, var_3) {
  if(self._blackboard.requestedshieldstate == self.asm.shieldstate) {
    return 0;
  }

  if(self._blackboard.requestedshieldstate == "equipped" && self.asm.shieldstate != "equipped") {
    return 1;
  }

  if(self._blackboard.requestedshieldstate == "dropped" && self.asm.shieldstate == "equipped") {
    return 1;
  }

  self.asm.shieldstate = self._blackboard.requestedshieldstate;
  return 0;
}

playshieldlostandfound(var_0, var_1, var_2, var_3) {
  switch (self._blackboard.requestedshieldstate) {
    case "equipped":
      self setscriptablepartstate("shield", "shield_activate");
      break;

    case "dropped":
      self setscriptablepartstate("shield", "shield_dissolve");
      break;

    default:
      break;
  }

  self.asm.shieldstate = self._blackboard.requestedshieldstate;
  lib_0F3C::func_CEA8(var_0, var_1, var_2, var_3);
}

ratking_chooseanim_exit(var_0, var_1, var_2) {
  var_3 = lib_0F3B::func_53CA(var_1);
  return var_3;
}