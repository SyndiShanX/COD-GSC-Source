/***********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\asm\ratking\ratking_asm.gsc
***********************************************/

ratkinginit(param_00, param_01, param_02, param_03) {
  scripts\asm\zombie\zombie::func_13F9A(param_00, param_01, param_02, param_03);
  self.var_71D0 = ::scripts\mp\agents\ratking\ratking_agent::shouldratkingplaypainanim;
  self.var_1198.requestedshieldstate = "equipped";
  self.asm.shieldstate = "equipped";
}

isvalidaction(param_00) {
  switch (param_00) {
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

setaction(param_00) {
  self.requested_action = param_00;
}

clearaction() {
  self.requested_action = undefined;
}

shouldendblock(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.requested_action) || self.requested_action != "block") {
    return 1;
  }

  return 0;
}

shouldplayentranceanim(param_00, param_01, param_02, param_03) {
  return 1;
}

playanimandlookatenemy(param_00, param_01, param_02, param_03) {
  thread scripts\asm\zombie\melee::func_6A6A(param_01, scripts\mp\agents\ratking\ratking_agent::getenemy());
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_04, 1);
}

isanimdone(param_00, param_01, param_02, param_03) {
  if(scripts\asm\asm::func_232B(param_01, "end")) {
    return 1;
  }

  if(scripts\asm\asm::func_232B(param_01, "early_end")) {
    return 1;
  }

  if(scripts\asm\asm::func_232B(param_01, "finish_early")) {
    return 1;
  }

  if(scripts\asm\asm::func_232B(param_01, "code_move")) {
    return 1;
  }

  return 0;
}

playtauntanim(param_00, param_01, param_02, param_03) {
  self notify("taunt");
  thread scripts\asm\zombie\melee::func_6A6A(param_01, scripts\mp\agents\ratking\ratking_agent::getenemy());
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

dosummonspawn() {
  var_00 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
  foreach(var_02 in self.spawnpoints) {
    var_03 = scripts\cp\zombies\zombies_spawning::func_13F53(var_00.summon_agent_type, var_02, self.angles, "axis");
    if(!isDefined(var_03)) {
      break;
    }

    var_03 thread scripts\cp\zombies\zombies_spawning::func_64E7(var_00.summon_agent_type);
  }
}

damagezombies(param_00, param_01) {
  var_02 = scripts\mp\mp_agent::getactiveagentsoftype("generic_zombie");
  var_03 = param_01 * param_01;
  foreach(var_05 in var_02) {
    var_06 = distancesquared(var_05.origin, param_00);
    if(var_06 > var_03) {
      continue;
    }

    var_05 dodamage(var_05.health * 10, param_00, self, self, "MOD_IMPACT");
  }
}

dostaffstompdamage(param_00, param_01) {
  if(isDefined(param_00)) {
    self endon(param_00 + "_finished");
  }

  if(isDefined(param_01)) {
    wait(param_01);
  }

  var_02 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
  self setscriptablepartstate("attacks", "staff_stomp");
  self radiusdamage(self.origin, var_02.staff_stomp_damage_radius, var_02.staff_stomp_max_damage, var_02.staff_stomp_min_damage, self, "MOD_IMPACT");
  if(scripts\engine\utility::istrue(self.battackzombies)) {
    damagezombies(self.origin, var_02.staff_stomp_damage_radius);
  }
}

staffstompnotehandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "hit") {
    dostaffstompdamage(param_01);
  }
}

dostaffstomp(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  thread scripts\asm\zombie\melee::func_6A6A(param_01, scripts\mp\agents\ratking\ratking_agent::getenemy());
  self notify("stomp");
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

summonnotehandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "start_summon_zombies") {
    self notify("summon");
    dosummonspawn();
  }
}

ratkingturnnotehandler(param_00, param_01, param_02, param_03) {
  if(isDefined(param_00)) {
    switch (param_00) {
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

meleenotehandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "hit") {
    var_04 = scripts\mp\agents\ratking\ratking_agent::getenemy();
    if(isDefined(var_04)) {
      if(distancesquared(var_04.origin, self.origin) < -25536) {
        self notify("attack_hit", var_04);
        if(var_04.team == "axis" && scripts\engine\utility::istrue(self.battackzombies)) {
          scripts\asm\zombie\melee::domeleedamage(var_04, var_04.health * 10, "MOD_IMPACT");
        } else {
          scripts\asm\zombie\melee::domeleedamage(var_04, self.var_B601, "MOD_IMPACT");
        }
      } else {
        self notify("attack_miss", var_04);
      }
    }

    if(!scripts\engine\utility::istrue(self.bmovingmelee)) {
      self notify("stop_melee_face_enemy");
    }
  }
}

shieldthrowatspotnotehandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "hit") {
    var_04 = scripts\mp\agents\ratking\ratking_agent::getstructpos();
    if(!isDefined(var_04)) {
      return;
    }

    var_05 = self gettagorigin("J_Shield_LE");
    var_06 = var_04.origin;
    var_07 = magicbullet("iw7_ratking_shield_projectile", var_05, var_06, self);
    self setscriptablepartstate("shield", "neutral");
    thread scripts\aitypes\ratking\behaviors::throwandrecovershield(1);
  }
}

shieldthrownotehandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "hit") {
    var_04 = scripts\mp\agents\ratking\ratking_agent::getenemy();
    if(!isDefined(var_04)) {
      return;
    }

    var_05 = self gettagorigin("J_Shield_LE");
    var_06 = var_04 getEye() - (0, 0, 12);
    magicbullet("iw7_ratking_shield_projectile", var_05, var_06, self);
    self setscriptablepartstate("shield", "neutral");
    thread scripts\aitypes\ratking\behaviors::throwandrecovershield(5);
  }
}

shieldthrowatspothack(param_00) {
  self endon(param_00 + "_finished");
  wait(0.8);
  shieldthrowatspotnotehandler("hit", param_00, 1, 0);
}

doshieldthrowatspot(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = scripts\mp\agents\ratking\ratking_agent::getstructpos();
  if(isDefined(var_04)) {
    self.setplayerignoreradiusdamage = var_04.origin;
  }

  scripts\mp\agents\ratking\ratking_agent::lookatspot();
  self notify("shield_throw");
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
  self.setplayerignoreradiusdamage = undefined;
}

aimatenemy(param_00, param_01) {
  self endon(param_00 + "_finished");
  while(isDefined(param_01) && isalive(param_01)) {
    self.setplayerignoreradiusdamage = param_01 getshootatpos();
    scripts\engine\utility::waitframe();
  }
}

clearlooktarget(param_00, param_01, param_02) {
  self.setplayerignoreradiusdamage = undefined;
}

doshieldthrow(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  scripts\mp\agents\ratking\ratking_agent::lookatenemy();
  thread aimatenemy(param_01, scripts\mp\agents\ratking\ratking_agent::getenemy());
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
  self.setplayerignoreradiusdamage = undefined;
}

shouldabortaction(param_00, param_01, param_02, param_03) {
  if(scripts\engine\utility::istrue(self.btraversalteleport)) {
    return 0;
  }

  if(!isDefined(self.requested_action)) {
    return 1;
  }

  if(isDefined(param_03)) {
    if(self.requested_action != param_03) {
      return 1;
    }
  }

  return 0;
}

shoulddoaction(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.requested_action)) {
    return 0;
  }

  if(self.requested_action == param_02) {
    return 1;
  }

  return 0;
}

playanimwithplaybackrate(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = param_03;
  var_05 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_05, var_04);
}

playblockanim(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = vectortoangles(self.damageaccumulator.lastdir * -1);
  var_04 = (0, var_04[1], 0);
  self orientmode("face angle abs", var_04);
  self ghostlaunched("anim deltas");
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

func_BEA0(param_00, param_01, param_02, param_03) {
  var_04 = undefined;
  var_05 = scripts\mp\agents\ratking\ratking_agent::getenemy();
  if(isDefined(self.var_1198.shootparams) && isDefined(self.var_1198.shootparams.ent)) {
    var_04 = self.var_1198.shootparams.ent.origin;
  } else if(isDefined(self.var_1198.shootparams) && isDefined(self.var_1198.shootparams.pos)) {
    var_04 = self.var_1198.shootparams.pos;
  } else if(isDefined(var_05)) {
    var_04 = var_05.origin;
  }

  if(!isDefined(var_04)) {
    return 0;
  }

  var_06 = self.angles[1] - vectortoyaw(var_04 - self.origin);
  var_07 = distancesquared(self.origin, var_04);
  if(var_07 < 65536) {
    var_08 = sqrt(var_07);
    if(var_08 > 3) {
      var_06 = var_06 + asin(-3 / var_08);
    }
  }

  if(abs(angleclamp180(var_06)) > self.var_129AF) {
    return 1;
  }

  return 0;
}

_meth_81DE() {
  var_00 = 0.25;
  var_01 = undefined;
  var_02 = undefined;
  if(isDefined(self.var_1198.shootparams)) {
    if(isDefined(self.var_1198.shootparams.ent)) {
      var_01 = self.var_1198.shootparams.ent;
    } else if(isDefined(self.var_1198.shootparams.pos)) {
      var_02 = self.var_1198.shootparams.pos;
    }
  }

  var_03 = scripts\mp\agents\ratking\ratking_agent::getenemy();
  if(isDefined(var_03)) {
    if(!isDefined(var_01) && !isDefined(var_02)) {
      var_01 = var_03;
    }
  }

  if(isDefined(var_01) && !issentient(var_01)) {
    var_00 = 1.5;
  }

  var_04 = scripts\engine\utility::getpredictedaimyawtoshootentorpos(var_00, var_01, var_02);
  return var_04;
}

choosestaffornostaffanim(param_00, param_01, param_02) {
  if(scripts\engine\utility::istrue(self.nostaff)) {
    return scripts\asm\asm::asm_lookupanimfromalias(param_01, "nostaff");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, "staff");
}

chooseshieldornoshieldanim(param_00, param_01, param_02) {
  if(self.asm.shieldstate == "equipped") {
    return scripts\asm\asm::asm_lookupanimfromalias(param_01, "shield");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, "noshield");
}

func_3F0A(param_00, param_01, param_02) {
  var_03 = _meth_81DE();
  if(var_03 < 0) {
    var_04 = "right";
  } else {
    var_04 = "left";
  }

  var_03 = abs(var_03);
  var_05 = 0;
  if(var_03 > 157.5) {
    var_05 = 180;
  } else if(var_03 > 112.5) {
    var_05 = 135;
  } else if(var_03 > 67.5) {
    var_05 = 90;
  } else {
    var_05 = 45;
  }

  var_06 = var_04 + "_" + var_05;
  var_07 = scripts\asm\asm::asm_lookupanimfromalias(param_01, var_06);
  var_08 = self _meth_8101(param_01, var_07);
  return var_07;
}

func_D56A(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  var_05 = self.vehicle_getspawnerarray;
  self orientmode("face angle abs", self.angles);
  self ghostlaunched("anim deltas");
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_04);
  if(!isDefined(var_05) && isDefined(self.vehicle_getspawnerarray)) {
    self clearpath();
  }

  scripts\asm\asm_mp::func_237F("face current");
  scripts\asm\asm_mp::func_237E("code_move");
}

playmeleeattack(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  thread scripts\asm\zombie\melee::func_6A6A(param_01, self.curmeleetarget);
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  self notify("melee");
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_04);
}

choosemeleeattack(param_00, param_01, param_02) {
  if(scripts\asm\asm_bb::bb_moverequested()) {
    var_03 = scripts\asm\asm::asm_lookupanimfromalias(param_01, "attack_moving");
  } else {
    var_03 = scripts\asm\asm::asm_lookupanimfromalias(param_02, "attack");
  }

  return var_03;
}

func_3EE4(param_00, param_01, param_02) {
  return lib_0F3C::func_3EF4(param_00, param_01, param_02);
}

playmovingpainanim(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  if(!isDefined(self.vehicle_getspawnerarray) || self pathdisttogoal() < scripts\mp\agents\ratking\ratking_tunedata::gettunedata().min_moving_pain_dist) {
    var_04 = func_3EE4(param_00, "pain_generic", param_03);
    self orientmode("face angle abs", self.angles);
    self notify("pain");
    scripts\asm\asm_mp::func_2365(param_00, "pain_generic", param_02, var_04, 1);
    return;
  }

  self notify("pain");
  scripts\asm\asm_mp::func_2364(param_01, param_02, param_03, var_04);
}

playteleportin(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  if(!scripts\aitypes\ratking\behaviors::rk_isonplatform()) {
    self setscriptablepartstate("movement", "dematerialize");
  }

  playanimwithplaybackrate(param_00, param_01, param_02, param_03);
}

terminate_teleportout(param_00, param_01, param_02) {}

shouldconsiderabortingteleport(param_00, param_01, param_02, param_03) {
  if(scripts\engine\utility::istrue(self.ishidden)) {
    return 0;
  }

  return shouldabortaction(param_00, param_01, param_02, "teleport");
}

playteleportout(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self endon("death");
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  var_05 = scripts\mp\agents\ratking\ratking_agent::getenemy();
  self.ishidden = 1;
  wait(0.1);
  self dontinterpolate();
  self hide();
  if(scripts\engine\utility::istrue(self.fake_death)) {
    scripts\mp\agents\ratking\ratking_agent::executefakedeath();
  }

  scripts\aitypes\ratking\behaviors::setplatformstate();
  var_06 = undefined;
  if(!scripts\aitypes\ratking\behaviors::rk_isonplatform()) {
    var_06 = spawnfx(level._effect["rk_tele_spot"], self.teleportpos);
    triggerfx(var_06);
  }

  self setorigin(self.teleportpos, 0);
  if(isDefined(var_05)) {
    self.angles = vectortoangles(var_05.origin - self.origin);
  }

  self.teleportpos = undefined;
  self ghostskulls_complete_status(self.origin);
  self clearpath();
  thread showmelater(var_06);
  if(!scripts\engine\utility::istrue(self.btraversalteleport)) {
    scripts\mp\agents\ratking\ratking_agent::lookatenemy();
  }

  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_04, 1);
  if(scripts\engine\utility::istrue(self.btraversalteleport)) {
    self.is_traversing = undefined;
    self.btraversalteleport = undefined;
    self notify("traverse_end");
    scripts\asm\asm::asm_setstate("decide_idle", param_03);
  }
}

showmelater(param_00) {
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
  if(isDefined(param_00)) {
    param_00 delete();
  }

  if(scripts\aitypes\ratking\behaviors::rk_isonplatform()) {
    self setscriptablepartstate("movement", "neutral");
  }
}

gibnearbyzombies(param_00) {
  if(isDefined(param_00)) {
    wait(param_00);
  }

  var_01 = scripts\mp\mp_agent::getaliveagents();
  var_02 = scripts\mp\agents\ratking\ratking_agent::getenemy();
  var_03 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
  foreach(var_05 in var_01) {
    if(var_05 == self) {
      continue;
    }

    if(var_05.team == "allies") {
      continue;
    }

    if(isDefined(var_02) && var_05 == var_02) {
      continue;
    }

    var_06 = distancesquared(self.origin, var_05.origin);
    if(var_06 > var_03.telefrag_dist_sq) {
      continue;
    }

    var_05 gibthyself();
  }
}

gibthyself() {
  self.nocorpse = 1;
  self.full_gib = 1;
  self dodamage(self.health + -15536, self.origin);
}

play_teleport_sound_to_players(param_00) {
  foreach(var_02 in level.players) {
    if(!self isethereal() || scripts\engine\utility::istrue(var_02.rave_mode)) {
      self playsoundtoplayer(param_00, var_02);
    }
  }
}

ontraversalteleport(param_00, param_01, param_02, param_03) {
  self.teleportpos = self _meth_8146();
  self.btraversalteleport = 1;
  return 1;
}

platformfaceenemy(param_00) {
  self endon(param_00 + "_finished");
  for(;;) {
    var_01 = scripts\mp\agents\ratking\ratking_agent::getenemy();
    if(isDefined(var_01) && isalive(var_01)) {
      self orientmode("face angle abs", (0, vectortoyaw(var_01.origin - self.origin), 0));
    }

    scripts\engine\utility::waitframe();
  }
}

playplatformidle(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self clearpath();
  thread platformfaceenemy(param_01);
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

dostaffprojectile(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  thread scripts\asm\zombie\melee::func_6A6A(param_01, scripts\mp\agents\ratking\ratking_agent::getenemy());
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

dostaffprojectiledamage(param_00, param_01, param_02, param_03) {
  var_04 = param_01 * param_01;
  var_05 = scripts\common\trace::create_default_contents(1);
  var_06 = scripts\common\trace::ray_trace(param_00 + (0, 0, param_02), param_00 - (0, 0, param_02), self, var_05);
  param_00 = getgroundposition(param_00, 8);
  foreach(var_08 in level.players) {
    if(!isalive(var_08)) {
      continue;
    }

    if(var_08.ignoreme || isDefined(var_08.triggerportableradarping) && var_08.triggerportableradarping.ignoreme) {
      continue;
    }

    if(scripts\mp\agents\zombie\zombie_util::shouldignoreent(var_08)) {
      continue;
    }

    var_09 = distance2dsquared(param_00, var_08.origin);
    if(var_09 > var_04) {
      continue;
    }

    if(abs(param_00[2] - var_08.origin[2]) > param_02) {
      continue;
    }

    var_08 dodamage(param_03, param_00, self, self, "MOD_IMPACT");
  }
}

handlestaffprojectile() {
  var_00 = scripts\mp\agents\ratking\ratking_tunedata::gettunedata();
  var_01 = anglesToForward(self.angles);
  var_02 = var_00.staff_projectile_range / var_00.staff_projectile_speed;
  var_03 = var_00.staff_projectile_speed * var_00.staff_projectile_interval;
  var_04 = var_03 / 2;
  var_05 = self.origin + var_01 * var_04;
  var_06 = gettime() + var_02 * 1000;
  var_07 = spawn("script_model", var_05);
  var_07 setModel("tag_origin_staff_proj");
  var_07 show();
  var_07.angles = var_01;
  playsoundatpos(var_05, "rk_fissure_deploy_lr");
  thread delayprojectileloopsound(var_07, var_00.staff_projectile_interval);
  while(gettime() < var_06) {
    dostaffprojectiledamage(var_05, var_04, var_00.staff_projectile_z_delta, var_00.staff_projectile_damage);
    var_07 moveto(var_05, var_00.staff_projectile_interval);
    wait(var_00.staff_projectile_interval);
    var_05 = var_05 + var_01 * var_03;
    var_07.angles = vectortoangles(var_05 - var_07.origin);
  }

  var_07 stoploopsound();
  var_07 delete();
}

delayprojectileloopsound(param_00, param_01) {
  level endon("game_ended");
  wait(param_01);
  param_00 scripts\engine\utility::play_loop_sound_on_entity("rk_fissure_ground_lp", (0, 0, 12));
}

staffprojectilenotehandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "hit") {
    handlestaffprojectile();
  }
}

lostorfoundstaff(param_00, param_01, param_02, param_03) {
  if(scripts\engine\utility::istrue(self.bstaffchanged)) {
    self.bstaffchanged = undefined;
    return 1;
  }

  return 0;
}

lostorfoundshield(param_00, param_01, param_02, param_03) {
  if(self.var_1198.requestedshieldstate == self.asm.shieldstate) {
    return 0;
  }

  if(self.var_1198.requestedshieldstate == "equipped" && self.asm.shieldstate != "equipped") {
    return 1;
  }

  if(self.var_1198.requestedshieldstate == "dropped" && self.asm.shieldstate == "equipped") {
    return 1;
  }

  self.asm.shieldstate = self.var_1198.requestedshieldstate;
  return 0;
}

playshieldlostandfound(param_00, param_01, param_02, param_03) {
  switch (self.var_1198.requestedshieldstate) {
    case "equipped":
      self setscriptablepartstate("shield", "shield_activate");
      break;

    case "dropped":
      self setscriptablepartstate("shield", "shield_dissolve");
      break;

    default:
      break;
  }

  self.asm.shieldstate = self.var_1198.requestedshieldstate;
  lib_0F3C::func_CEA8(param_00, param_01, param_02, param_03);
}

ratking_chooseanim_exit(param_00, param_01, param_02) {
  var_03 = lib_0F3B::func_53CA(param_01);
  return var_03;
}