/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\asm\pamgrier\pamgrier_asm.gsc
*************************************************/

pamgrierinit(var_0, var_1, var_2, var_3) {
  scripts\asm\zombie\zombie::func_13F9A(var_0, var_1, var_2, var_3);
  var_4 = self getsafecircleradius("teleport_out", "revive_player");
}

isvalidaction(var_0) {
  switch (var_0) {
    case "teleport":
    case "melee_attack":
    case "revive_player":
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

ispamchillin(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::istrue(self.bchillin);
}

ispamdonechillin(var_0, var_1, var_2, var_3) {
  return !ispamchillin(var_0, var_1, var_2, var_3);
}

shouldplayentranceanim(var_0, var_1, var_2, var_3) {
  return 0;
}

playanimandlookatenemy(var_0, var_1, var_2, var_3) {
  thread scripts\asm\zombie\melee::func_6A6A(var_1, scripts\mp\agents\pamgrier\pamgrier_agent::getenemy());
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

isrevivedone(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.reviveplayer)) {
    return 1;
  }

  if(!scripts\engine\utility::istrue(self.reviveplayer.inlaststand)) {
    return 1;
  }

  return 0;
}

dorevive(var_0, var_1) {
  self endon(var_0 + "_finished");
  var_1 endon("disconnect");
  var_2 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
  wait(var_2.revive_wait_time);
  if(!isDefined(var_1.reviveent)) {
    return;
  }

  var_1.reviveent notify("pg_trigger", self);
}

playreviveanim(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  if(isDefined(self.reviveplayer)) {
    thread scripts\asm\zombie\melee::func_6A6A(var_1, self.reviveplayer);
    thread dorevive(var_1, self.reviveplayer);
  }

  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

meleenotehandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "hit") {
    var_4 = scripts\mp\agents\pamgrier\pamgrier_agent::getenemy();
    if(isDefined(var_4)) {
      if(distancesquared(var_4.origin, self.origin) < -25536) {
        self notify("attack_hit", var_4);
        if(isDefined(var_4.maxhealth)) {
          scripts\asm\zombie\melee::domeleedamage(var_4, var_4.maxhealth, "MOD_IMPACT");
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

  if(isDefined(var_3) && var_3 != "") {
    if(self.requested_action == var_3) {
      return 1;
    }

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

func_BEA0(var_0, var_1, var_2, var_3) {
  var_4 = _meth_81DE();
  if(abs(angleclamp180(var_4)) > self.var_129AF) {
    return 1;
  }

  return 0;
}

_meth_81DE(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = 0;
  if(isDefined(self.desiredyaw)) {
    var_3 = angleclamp180(self.desiredyaw - self.angles[1]);
  }

  if(isDefined(var_0)) {
    var_3 = scripts\engine\utility::getpredictedaimyawtoshootentorpos(0.5, var_0);
  }

  return var_3;
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
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4, var_3);
}

choosemeleeattack(var_0, var_1, var_2) {
  var_3 = "attack_moving_";
  var_4 = _meth_81DE(scripts\mp\agents\pamgrier\pamgrier_agent::getenemy());
  if(var_4 < 0) {
    var_5 = "right";
  } else {
    var_5 = "left";
  }

  var_4 = abs(var_4);
  var_6 = 0;
  if(var_4 > 157.5) {
    var_6 = 180;
  } else if(var_4 > 112.5) {
    var_6 = 135;
  } else if(var_4 > 67.5) {
    var_6 = 90;
  } else if(var_4 > 30) {
    var_6 = 45;
  } else {
    var_6 = undefined;
  }

  if(isDefined(var_6)) {
    var_7 = "attack_moving_" + var_5 + "_" + var_6;
  } else {
    var_7 = "attack_moving";
  }

  var_8 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_7);
  return var_8;
}

func_3EE4(var_0, var_1, var_2) {
  return lib_0F3C::func_3EF4(var_0, var_1, var_2);
}

playmovingpainanim(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  if(!isDefined(self.vehicle_getspawnerarray) || self pathdisttogoal() < scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata().min_moving_pain_dist) {
    var_4 = func_3EE4(var_0, "pain_generic", var_3);
    self orientmode("face angle abs", self.angles);
    scripts\asm\asm_mp::func_2365(var_0, "pain_generic", var_2, var_4, 1);
    return;
  }

  scripts\asm\asm_mp::func_2364(var_1, var_2, var_3, var_4);
}

chooseteleportoutanim(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, self.teleporttype);
  if(self.teleporttype == "revive_player") {
    self.reviveanimindex = var_3 - 5;
  }

  return var_3;
}

needschilltransition(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::istrue(self.bneedschilltransition)) {
    return 1;
  }

  return 0;
}

playchillpassivetransition(var_0, var_1, var_2, var_3) {
  self.bneedschilltransition = undefined;
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

choosechillinidle(var_0, var_1, var_2) {
  if(scripts\engine\utility::istrue(self.bpassive)) {
    var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "passive");
  } else {
    var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_2, "ready");
  }

  return var_3;
}

gopassivesoon(var_0, var_1) {
  self endon(var_0 + "_finished");
  wait(var_1);
  scripts\mp\agents\pamgrier\pamgrier_agent::setpassive();
}

shouldplaychilltwitch(var_0, var_1, var_2, var_3) {
  if(!scripts\engine\utility::istrue(self.bpassive)) {
    return 0;
  }

  if(!scripts\engine\utility::istrue(self.btimefortwitch)) {
    return 0;
  }

  self.btimefortwitch = undefined;
  return 1;
}

handletwitch(var_0) {
  self endon(var_0 + "_finished");
  var_1 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
  wait(randomfloatrange(var_1.min_wait_for_twitch_time, var_1.max_wait_for_twitch_time));
  self.btimefortwitch = 1;
}

playchillinanim(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::istrue(self.bpassive)) {
    thread handletwitch(var_1);
  } else {
    thread gopassivesoon(var_1, scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata().chill_time_before_going_passive);
  }

  if(isDefined(self.teleportangles)) {
    self orientmode("face angle abs", (0, self.teleportangles[1], 0));
  }

  scripts\asm\asm_mp::func_235F(var_0, var_1, var_2, var_3);
}

choosereviveanim(var_0, var_1, var_2) {
  if(!isDefined(self.reviveanimindex)) {
    self.reviveanimindex = lib_0F3C::func_3EF4(var_0, var_1, var_2);
  }

  return self.reviveanimindex;
}

chooseteleportinanim(var_0, var_1, var_2) {
  if(scripts\engine\utility::istrue(self.bpassive)) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "passive_teleport");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "teleport");
}

playteleportin(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = self.teleportpos - self.origin;
  var_4 = (var_4[0], var_4[1], 0);
  var_5 = vectornormalize(var_4);
  var_6 = vectortoangles(var_5);
  playanimwithplaybackrate(var_0, var_1, var_2, var_3);
}

isplayerintheway(var_0) {
  var_1 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
  foreach(var_3 in level.players) {
    if(!isalive(var_3)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_3.inlaststand)) {
      continue;
    }

    var_4 = distance2dsquared(var_0, var_3.origin);
    if(var_4 < var_1.player_too_close_teleport_dist_sq) {
      return 1;
    }
  }

  return 0;
}

isvalidteleportpos(var_0) {
  var_1 = self.teleportpos;
  self.teleportpos = getclosestpointonnavmesh(self.teleportpos);
  var_2 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
  if(distance2dsquared(var_1, self.teleportpos) > var_2.navmesh_correction_dist_sq) {
    return 0;
  }

  if(isplayerintheway(self.teleportpos)) {
    return 0;
  }

  if(isDefined(var_0)) {
    var_3 = scripts\common\trace::create_default_contents(1);
    if(!scripts\common\trace::ray_trace_passed(self.teleportpos + (0, 0, 24), var_0 + (0, 0, 24), self, var_3)) {
      return 0;
    }
  }

  return 1;
}

faceplayer(var_0, var_1) {
  self endon(var_0 + "_finished");
  for(;;) {
    if(isDefined(var_1)) {
      self orientmode("face angle abs", (0, vectortoyaw(var_1.origin - self.origin), 0));
    } else {
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

playteleportout(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = var_3;
  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  var_5 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_6 = scripts\mp\agents\pamgrier\pamgrier_agent::getenemy();
  self setscriptablepartstate("movement", "teleport");
  self.ishidden = 1;
  wait(0.1);
  self setscriptablepartstate("movement", "neutral");
  self hide();
  if(isDefined(var_6) && self.teleporttype == "teleport_attack") {
    var_7 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
    var_8 = var_6 getvelocity();
    var_9 = length2d(var_8);
    var_0A = vectornormalize(var_6.origin - self.origin);
    self.teleportpos = var_6.origin - var_0A * var_7.teleport_attack_dist_to_target;
    if(!isvalidteleportpos(var_6.origin)) {
      if(var_9 == 0) {
        var_0B = anglesToForward(var_6.angles);
      } else {
        var_0B = vectornormalize(var_9) * -1;
      }

      self.teleportpos = var_6.origin + var_0B * var_7.teleport_behind_target_dist;
      if(!isvalidteleportpos(var_6.origin)) {
        self.teleportpos = getclosestpointonnavmesh(var_6.origin);
      }
    }

    self.teleportangles = vectortoangles(var_6.origin - self.teleportpos);
    self.teleportangles = (0, self.teleportangles[1], 0);
  }

  self dontinterpolate();
  self setorigin(self.teleportpos, 0);
  if(isDefined(self.teleportangles)) {
    self.angles = (0, self.teleportangles[1], 0);
  }

  if(isDefined(self.teleporttype)) {
    if(self.teleporttype == "teleport_attack" && isDefined(var_6)) {
      thread scripts\asm\zombie\melee::func_6A6A(var_1, var_6);
    } else if(self.teleporttype == "revive_player" && isDefined(self.reviveplayer)) {
      thread faceplayer(var_1, self.reviveplayer);
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
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_5, var_4);
  if(scripts\engine\utility::istrue(self.btraversalteleport)) {
    self.is_traversing = undefined;
    self.btraversalteleport = undefined;
    self notify("traverse_end");
    scripts\asm\asm::asm_setstate("decide_idle", var_3);
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

gibnearbyenemies(var_0) {
  if(isDefined(var_0)) {
    wait(var_0);
  }

  var_1 = scripts\mp\mp_agent::getaliveagents();
  var_2 = scripts\mp\agents\pamgrier\pamgrier_agent::getenemy();
  var_3 = scripts\mp\agents\pamgrier\pamgrier_tunedata::gettunedata();
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

    if(var_5.agent_type == "ratking") {
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