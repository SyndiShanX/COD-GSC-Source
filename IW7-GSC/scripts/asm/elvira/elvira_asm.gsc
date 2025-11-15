/*********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\asm\elvira\elvira_asm.gsc
*********************************************/

elvirainit(param_00, param_01, param_02, param_03) {
  self.var_FFEF = 1;
  scripts\asm\zombie\zombie::func_13F9A(param_00, param_01, param_02, param_03);
}

isvalidaction(param_00) {
  switch (param_00) {
    case "cast_return_spell":
    case "cast_reveal_spell":
    case "cast_revive_spell":
    case "cast_spell":
    case "revive_player":
    case "reload":
    case "melee":
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
  var_02 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
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

func_3EE4(param_00, param_01, param_02) {
  return lib_0F3C::func_3EF4(param_00, param_01, param_02);
}

playmovingpainanim(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  if(!isDefined(self.vehicle_getspawnerarray) || self pathdisttogoal() < scripts\mp\agents\elvira\elvira_tunedata::gettunedata().min_moving_pain_dist) {
    var_04 = func_3EE4(param_00, "pain_generic", param_03);
    self orientmode("face angle abs", self.angles);
    scripts\asm\asm_mp::func_2365(param_00, "pain_generic", param_02, var_04, 1);
    return;
  }

  scripts\asm\asm_mp::func_2364(param_01, param_02, param_03, var_04);
}

choosereviveanim(param_00, param_01, param_02) {
  if(!isDefined(self.reviveanimindex)) {
    self.reviveanimindex = lib_0F3C::func_3EF4(param_00, param_01, param_02);
  }

  return self.reviveanimindex;
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

playcastspellanim(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = param_03;
  var_05 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  playFXOnTag(level._effect["vfx_spell_tornado"], self, "j_wrist_le");
  self playSound("elvira_fire_spell_cast");
  thread scripts\cp\maps\cp_town\cp_town_elvira::elvira_timely_torrent();
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_05, var_04);
}

playrevealspellanim(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = param_03;
  var_05 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  playFXOnTag(level._effect["vfx_spell_anom"], self, "j_wrist_le");
  self playSound("elvira_portal_spell_cast");
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_05, var_04);
}

playteleportfx(param_00, param_01) {
  self endon(param_00 + "_finished");
  wait(param_01);
  playFX(level._effect["elvira_stand_smoke"], self.origin);
}

terminate_traverseexternal(param_00, param_01, param_02) {
  self.earlytraversalteleportpos = undefined;
  self.ishidden = undefined;
  self.is_traversing = undefined;
}

dotraverseteleport(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  thread scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
  thread playteleportfx(param_01, 0.75);
  var_04 = undefined;
  if(isDefined(self.earlytraversalteleportpos)) {
    var_04 = self.earlytraversalteleportpos;
  } else {
    var_04 = self _meth_8146();
  }

  var_05 = vectornormalize(var_04 - self.origin * (1, 1, 0));
  var_06 = vectortoangles(var_05);
  self orientmode("face angle abs", var_06);
  wait(0.9);
  self hide();
  self.ishidden = 1;
  self setorigin(var_04, 0);
  playFX(level._effect["elvira_stand_smoke"], var_04);
  wait(0.25);
  self show();
  self.ishidden = undefined;
  self.is_traversing = undefined;
  self notify("traverse_end");
  thread scripts\asm\asm::asm_setstate("exposed_idle", param_03);
}