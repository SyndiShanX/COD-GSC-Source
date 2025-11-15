/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\asm\pamgrier\pamgrier_asm.gsc
*************************************************/

pamgrierinit(param_00, param_01, param_02, param_03) {
  scripts\asm\zombie\zombie::func_13F9A(param_00, param_01, param_02, param_03);
  var_04 = self getsafecircleradius("teleport_out", "revive_player");
}

isvalidaction(param_00) {
  switch (param_00) {
    case "teleport":
    case "melee_attack":
    case "revive_player":
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

ispamchillin(param_00, param_01, param_02, param_03) {
  return scripts\engine\utility::istrue(self.bchillin);
}

ispamdonechillin(param_00, param_01, param_02, param_03) {
  return !ispamchillin(param_00, param_01, param_02, param_03);
}

shouldplayentranceanim(param_00, param_01, param_02, param_03) {
  return 0;
}

playanimandlookatenemy(param_00, param_01, param_02, param_03) {
  thread scripts\asm\zombie\melee::func_6A6A(param_01, scripts\mp\agents\pamgrier\pamgrier_agent::getenemy());
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

isrevivedone(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.reviveplayer)) {
    return 1;
  }

  if(!scripts\engine\utility::istrue(self.reviveplayer.inlaststand)) {
    return 1;
  }

  return 0;
}

dorevive(param_00, param_01) {
  self endon(param_00 + "_finished");
  param_01 endon("disconnect");
  var_02 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
  wait(var_02.revive_wait_time);
  if(!isDefined(param_01.reviveent)) {
    return;
  }

  param_01.reviveent notify("pg_trigger", self);
}

playreviveanim(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  if(isDefined(self.reviveplayer)) {
    thread scripts\asm\zombie\melee::func_6A6A(param_01, self.reviveplayer);
    thread dorevive(param_01, self.reviveplayer);
  }

  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

meleenotehandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "hit") {
    var_04 = scripts\mp\agents\pamgrier\pamgrier_agent::getenemy();
    if(isDefined(var_04)) {
      if(distancesquared(var_04.origin, self.origin) < -25536) {
        self notify("attack_hit", var_04);
        if(isDefined(var_04.maxhealth)) {
          scripts\asm\zombie\melee::domeleedamage(var_04, var_04.maxhealth, "MOD_IMPACT");
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

  if(isDefined(param_03) && param_03 != "") {
    if(self.requested_action == param_03) {
      return 1;
    }

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

func_BEA0(param_00, param_01, param_02, param_03) {
  var_04 = _meth_81DE();
  if(abs(angleclamp180(var_04)) > self.var_129AF) {
    return 1;
  }

  return 0;
}

_meth_81DE(param_00) {
  var_01 = undefined;
  var_02 = undefined;
  var_03 = 0;
  if(isDefined(self.desiredyaw)) {
    var_03 = angleclamp180(self.desiredyaw - self.angles[1]);
  }

  if(isDefined(param_00)) {
    var_03 = scripts\engine\utility::getpredictedaimyawtoshootentorpos(0.5, param_00);
  }

  return var_03;
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
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_04, param_03);
}

choosemeleeattack(param_00, param_01, param_02) {
  var_03 = "attack_moving_";
  var_04 = _meth_81DE(scripts\mp\agents\pamgrier\pamgrier_agent::getenemy());
  if(var_04 < 0) {
    var_05 = "right";
  } else {
    var_05 = "left";
  }

  var_04 = abs(var_04);
  var_06 = 0;
  if(var_04 > 157.5) {
    var_06 = 180;
  } else if(var_04 > 112.5) {
    var_06 = 135;
  } else if(var_04 > 67.5) {
    var_06 = 90;
  } else if(var_04 > 30) {
    var_06 = 45;
  } else {
    var_06 = undefined;
  }

  if(isDefined(var_06)) {
    var_07 = "attack_moving_" + var_05 + "_" + var_06;
  } else {
    var_07 = "attack_moving";
  }

  var_08 = scripts\asm\asm::asm_lookupanimfromalias(param_01, var_07);
  return var_08;
}

func_3EE4(param_00, param_01, param_02) {
  return lib_0F3C::func_3EF4(param_00, param_01, param_02);
}

playmovingpainanim(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  if(!isDefined(self.vehicle_getspawnerarray) || self pathdisttogoal() < scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata().min_moving_pain_dist) {
    var_04 = func_3EE4(param_00, "pain_generic", param_03);
    self orientmode("face angle abs", self.angles);
    scripts\asm\asm_mp::func_2365(param_00, "pain_generic", param_02, var_04, 1);
    return;
  }

  scripts\asm\asm_mp::func_2364(param_01, param_02, param_03, var_04);
}

chooseteleportoutanim(param_00, param_01, param_02) {
  var_03 = scripts\asm\asm::asm_lookupanimfromalias(param_01, self.teleporttype);
  if(self.teleporttype == "revive_player") {
    self.reviveanimindex = var_03 - 5;
  }

  return var_03;
}

needschilltransition(param_00, param_01, param_02, param_03) {
  if(scripts\engine\utility::istrue(self.bneedschilltransition)) {
    return 1;
  }

  return 0;
}

playchillpassivetransition(param_00, param_01, param_02, param_03) {
  self.bneedschilltransition = undefined;
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

choosechillinidle(param_00, param_01, param_02) {
  if(scripts\engine\utility::istrue(self.bpassive)) {
    var_03 = scripts\asm\asm::asm_lookupanimfromalias(param_01, "passive");
  } else {
    var_03 = scripts\asm\asm::asm_lookupanimfromalias(param_02, "ready");
  }

  return var_03;
}

gopassivesoon(param_00, param_01) {
  self endon(param_00 + "_finished");
  wait(param_01);
  scripts\mp\agents\pamgrier\pamgrier_agent::setpassive();
}

shouldplaychilltwitch(param_00, param_01, param_02, param_03) {
  if(!scripts\engine\utility::istrue(self.bpassive)) {
    return 0;
  }

  if(!scripts\engine\utility::istrue(self.btimefortwitch)) {
    return 0;
  }

  self.btimefortwitch = undefined;
  return 1;
}

handletwitch(param_00) {
  self endon(param_00 + "_finished");
  var_01 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
  wait(randomfloatrange(var_01.min_wait_for_twitch_time, var_01.max_wait_for_twitch_time));
  self.btimefortwitch = 1;
}

playchillinanim(param_00, param_01, param_02, param_03) {
  if(scripts\engine\utility::istrue(self.bpassive)) {
    thread handletwitch(param_01);
  } else {
    thread gopassivesoon(param_01, scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata().chill_time_before_going_passive);
  }

  if(isDefined(self.teleportangles)) {
    self orientmode("face angle abs", (0, self.teleportangles[1], 0));
  }

  scripts\asm\asm_mp::func_235F(param_00, param_01, param_02, param_03);
}

choosereviveanim(param_00, param_01, param_02) {
  if(!isDefined(self.reviveanimindex)) {
    self.reviveanimindex = lib_0F3C::func_3EF4(param_00, param_01, param_02);
  }

  return self.reviveanimindex;
}

chooseteleportinanim(param_00, param_01, param_02) {
  if(scripts\engine\utility::istrue(self.bpassive)) {
    return scripts\asm\asm::asm_lookupanimfromalias(param_01, "passive_teleport");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, "teleport");
}

playteleportin(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = self.teleportpos - self.origin;
  var_04 = (var_04[0], var_04[1], 0);
  var_05 = vectornormalize(var_04);
  var_06 = vectortoangles(var_05);
  playanimwithplaybackrate(param_00, param_01, param_02, param_03);
}

isplayerintheway(param_00) {
  var_01 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
  foreach(var_03 in level.players) {
    if(!isalive(var_03)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_03.inlaststand)) {
      continue;
    }

    var_04 = distance2dsquared(param_00, var_03.origin);
    if(var_04 < var_01.player_too_close_teleport_dist_sq) {
      return 1;
    }
  }

  return 0;
}

isvalidteleportpos(param_00) {
  var_01 = self.teleportpos;
  self.teleportpos = getclosestpointonnavmesh(self.teleportpos);
  var_02 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
  if(distance2dsquared(var_01, self.teleportpos) > var_02.navmesh_correction_dist_sq) {
    return 0;
  }

  if(isplayerintheway(self.teleportpos)) {
    return 0;
  }

  if(isDefined(param_00)) {
    var_03 = scripts\common\trace::create_default_contents(1);
    if(!scripts\common\trace::ray_trace_passed(self.teleportpos + (0, 0, 24), param_00 + (0, 0, 24), self, var_03)) {
      return 0;
    }
  }

  return 1;
}

faceplayer(param_00, param_01) {
  self endon(param_00 + "_finished");
  for(;;) {
    if(isDefined(param_01)) {
      self orientmode("face angle abs", (0, vectortoyaw(param_01.origin - self.origin), 0));
    } else {
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

playteleportout(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = param_03;
  if(!isDefined(var_04)) {
    var_04 = 1;
  }

  var_05 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  var_06 = scripts\mp\agents\pamgrier\pamgrier_agent::getenemy();
  self setscriptablepartstate("movement", "teleport");
  self.ishidden = 1;
  wait(0.1);
  self setscriptablepartstate("movement", "neutral");
  self hide();
  if(isDefined(var_06) && self.teleporttype == "teleport_attack") {
    var_07 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
    var_08 = var_06 getvelocity();
    var_09 = length2d(var_08);
    var_0A = vectornormalize(var_06.origin - self.origin);
    self.teleportpos = var_06.origin - var_0A * var_07.teleport_attack_dist_to_target;
    if(!isvalidteleportpos(var_06.origin)) {
      if(var_09 == 0) {
        var_0B = anglesToForward(var_06.angles);
      } else {
        var_0B = vectornormalize(var_09) * -1;
      }

      self.teleportpos = var_06.origin + var_0B * var_07.teleport_behind_target_dist;
      if(!isvalidteleportpos(var_06.origin)) {
        self.teleportpos = getclosestpointonnavmesh(var_06.origin);
      }
    }

    self.teleportangles = vectortoangles(var_06.origin - self.teleportpos);
    self.teleportangles = (0, self.teleportangles[1], 0);
  }

  self dontinterpolate();
  self setorigin(self.teleportpos, 0);
  if(isDefined(self.teleportangles)) {
    self.angles = (0, self.teleportangles[1], 0);
  }

  if(isDefined(self.teleporttype)) {
    if(self.teleporttype == "teleport_attack" && isDefined(var_06)) {
      thread scripts\asm\zombie\melee::func_6A6A(param_01, var_06);
    } else if(self.teleporttype == "revive_player" && isDefined(self.reviveplayer)) {
      thread faceplayer(param_01, self.reviveplayer);
    } else {
      self orientmode("face angle abs", (0, self.teleportangles[1], 0));
    }
  } else {
    self orientmode("face angle abs", (0, self.teleportangles[1], 0));
  }

  self.teleportpos = undefined;
  self ghostskulls_complete_status(self.origin);
  self clearpath();
  thread showmelater();
  thread gibnearbyenemies(0.1);
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_05, var_04);
  if(scripts\engine\utility::istrue(self.btraversalteleport)) {
    self.is_traversing = undefined;
    self.btraversalteleport = undefined;
    self notify("traverse_end");
    scripts\asm\asm::asm_setstate("decide_idle", param_03);
  }
}

showmelater() {
  self endon("death");
  wait(0.1);
  self show();
  self setscriptablepartstate("movement", "teleport");
  self.ishidden = 0;
  wait(0.1);
  self setscriptablepartstate("movement", "neutral");
}

gibnearbyenemies(param_00) {
  if(isDefined(param_00)) {
    wait(param_00);
  }

  var_01 = scripts\mp\mp_agent::getaliveagents();
  var_02 = scripts\mp\agents\pamgrier\pamgrier_agent::getenemy();
  var_03 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
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

    if(var_05.agent_type == "ratking") {
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