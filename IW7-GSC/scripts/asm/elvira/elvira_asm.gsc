/*********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\asm\elvira\elvira_asm.gsc
*********************************************/

elvirainit(var_0, var_1, var_2, var_3) {
  self.var_FFEF = 1;
  scripts\asm\zombie\zombie::func_13F9A(var_0, var_1, var_2, var_3);
}

isvalidaction(var_0) {
  switch (var_0) {
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

setaction(var_0) {
  self.requested_action = var_0;
}

clearaction() {
  self.requested_action = undefined;
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
  var_2 = scripts\mp\agents\elvira\elvira_tunedata::gettunedata();
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

func_3EE4(var_0, var_1, var_2) {
  return lib_0F3C::func_3EF4(var_0, var_1, var_2);
}

playmovingpainanim(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  if(!isDefined(self.vehicle_getspawnerarray) || self pathdisttogoal() < scripts\mp\agents\elvira\elvira_tunedata::gettunedata().min_moving_pain_dist) {
    var_4 = func_3EE4(var_0, "pain_generic", var_3);
    self orientmode("face angle abs", self.angles);
    scripts\asm\asm_mp::func_2365(var_0, "pain_generic", var_2, var_4, 1);
    return;
  }

  scripts\asm\asm_mp::func_2364(var_1, var_2, var_3, var_4);
}

choosereviveanim(var_0, var_1, var_2) {
  if(!isDefined(self.reviveanimindex)) {
    self.reviveanimindex = lib_0F3C::func_3EF4(var_0, var_1, var_2);
  }

  return self.reviveanimindex;
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

playcastspellanim(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = var_3;
  var_5 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  playFXOnTag(level._effect["vfx_spell_tornado"], self, "j_wrist_le");
  self playSound("elvira_fire_spell_cast");
  thread scripts\cp\maps\cp_town\cp_town_elvira::elvira_timely_torrent();
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_5, var_4);
}

playrevealspellanim(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = var_3;
  var_5 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  playFXOnTag(level._effect["vfx_spell_anom"], self, "j_wrist_le");
  self playSound("elvira_portal_spell_cast");
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_5, var_4);
}

playteleportfx(var_0, var_1) {
  self endon(var_0 + "_finished");
  wait(var_1);
  playFX(level._effect["elvira_stand_smoke"], self.origin);
}

terminate_traverseexternal(var_0, var_1, var_2) {
  self.earlytraversalteleportpos = undefined;
  self.ishidden = undefined;
  self.is_traversing = undefined;
}

dotraverseteleport(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  thread scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
  thread playteleportfx(var_1, 0.75);
  var_4 = undefined;
  if(isDefined(self.earlytraversalteleportpos)) {
    var_4 = self.earlytraversalteleportpos;
  } else {
    var_4 = self _meth_8146();
  }

  var_5 = vectornormalize(var_4 - self.origin * (1, 1, 0));
  var_6 = vectortoangles(var_5);
  self orientmode("face angle abs", var_6);
  wait(0.9);
  self hide();
  self.ishidden = 1;
  self setorigin(var_4, 0);
  playFX(level._effect["elvira_stand_smoke"], var_4);
  wait(0.25);
  self show();
  self.ishidden = undefined;
  self.is_traversing = undefined;
  self notify("traverse_end");
  thread scripts\asm\asm::asm_setstate("exposed_idle", var_3);
}