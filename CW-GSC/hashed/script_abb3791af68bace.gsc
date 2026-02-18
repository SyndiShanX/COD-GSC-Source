/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_abb3791af68bace.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_350cffecd05ef6cf;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_74a56359b7d02ab6;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_dcd37093;

function function_d28e9b17() {
  if(isPlayer(self)) {
    self endon(#"disconnect");
  }

  self notify(#"hash_562d458e34274132");
  waitframe(1);
  self endon(#"hash_1e2c098e8231a30f", #"hash_562d458e34274132");
  org = namespace_ec06fe4a::spawnmodel(self.origin, "tag_origin");

  if(isDefined(org)) {
    org.targetname = "boxingPickupUpdate";
    org.angles = (0, randomint(180), 0);
    org setModel("tag_origin");
    self.doa.var_c3159deb = org;
  } else {
    return;
  }

  leftglove = namespace_ec06fe4a::spawnmodel(self.origin + (0, 60, 32), "zombietron_boxing_gloves_lt");

  if(isDefined(leftglove)) {
    leftglove.targetname = "leftglove";
    leftglove setplayercollision(0);
    leftglove linkto(org, "tag_origin", (0, 60, 32), (90, 0, 0));
    trigger = namespace_ec06fe4a::spawntrigger("trigger_radius", leftglove.origin, 1 | 512 | 8, 40, 50);

    if(isDefined(trigger)) {
      trigger.targetname = "leftGlove";
      trigger enablelinkto();
      trigger linkto(leftglove);
      trigger thread function_7c757878(self, "MOD_IMPACT", &function_c2d94d61);
    }
  }

  org.var_f9c2f48c = leftglove;
  org.trigger1 = trigger;
  rightglove = namespace_ec06fe4a::spawnmodel(self.origin + (0, -60, 32), "zombietron_boxing_gloves_rt");

  if(isDefined(rightglove)) {
    rightglove.targetname = "rightGlove";
    rightglove setplayercollision(0);
    rightglove linkto(org, "tag_origin", (0, -60, 32), (90, 0, 0));
    trigger = namespace_ec06fe4a::spawntrigger("trigger_radius", rightglove.origin, 1 | 512 | 8, 40, 50);

    if(isDefined(trigger)) {
      trigger.targetname = "rightGlove";
      trigger enablelinkto();
      trigger linkto(rightglove);
      trigger thread function_7c757878(self, "MOD_IMPACT", &function_c2d94d61);
    }
  }

  org.var_b981836 = rightglove;
  org.trigger2 = trigger;
  org linkto(self, "", (0, 0, 10), (0, 0, 0));
  self thread function_61888137(org);
  self thread function_f0855523(org);
  self waittill(#"hash_6733dfa48ff87a81");
  leftglove setModel("zombietron_boxing_gloves_expiring_lt");
  rightglove setModel("zombietron_boxing_gloves_expiring_rt");
}

function function_c2d94d61() {
  self namespace_83eb6304::function_3ecfde67("boxing_stars");
  waitresult = self waittilltimeout(2, #"actor_corpse", #"entitydeleted");

  if(isDefined(waitresult.corpse)) {
    waitresult.corpse namespace_83eb6304::function_3ecfde67("boxing_stars");
  }
}

function private function_7c757878(player, mod = "MOD_UNKNOWN", var_70c63791) {
  player endon(#"hash_1e2c098e8231a30f");

  if(isPlayer(player)) {
    player endon(#"disconnect");
  }

  self endon(#"death");

  while(true) {
    result = self waittill(#"trigger");
    guy = result.activator;

    if(!isDefined(guy)) {
      continue;
    }

    if(isPlayer(guy)) {
      continue;
    }

    if(is_true(guy.var_b88e74c3) || is_true(guy.boss)) {
      continue;
    }

    if(isalive(guy) == 0) {
      continue;
    }

    if(self namespace_ec06fe4a::function_22d11b92()) {
      continue;
    }

    curtime = gettime();

    if(isDefined(guy.var_f84f4372) && curtime - guy.var_f84f4372 < 500) {
      continue;
    }

    guy.var_f84f4372 = curtime;
    guy namespace_e32bb68::function_3a59ec34("evt_doa_pickup_boxers_active_impact");
    guy namespace_83eb6304::function_3ecfde67("boxing_pow");

    if(isDefined(var_70c63791)) {
      guy thread[[var_70c63791]]();
    }

    if(isactor(guy)) {
      dir = guy.origin - self.origin;
      guy thread namespace_ec06fe4a::function_b4ff2191(dir, 50, undefined, player);
    } else {
      guy dodamage(guy.health + 1, guy.origin, player, player, "none", mod, 0, level.doa.default_weapon);
    }

    player playrumbleonentity("damage_light");
  }
}

function private function_61888137(org) {
  self endon(#"hash_1e2c098e8231a30f", #"hash_562d458e34274132");

  if(isPlayer(self)) {
    self endon(#"disconnect");
  }

  timeout = max(max(30, self namespace_1c2a96f9::function_4808b985(30)), self namespace_1c2a96f9::function_2ce61fb9(30));

  while(!namespace_dfc652ee::function_f759a457()) {
    waitframe(1);
  }

  wait timeout - 3;

  if(isDefined(self)) {
    self notify(#"hash_6733dfa48ff87a81");
  }

  wait 3;
  self namespace_e32bb68::function_3a59ec34("evt_doa_pickup_boxers_active_end");
  self notify(#"hash_1e2c098e8231a30f");
}

function private function_f0855523(org) {
  result = self waittill(#"hash_1e2c098e8231a30f", #"entering_last_stand", #"kill_shield", #"hash_df25520ab279dff", #"hash_562d458e34274132", #"player_died", #"disconnect", #"enter_vehicle", #"death", #"clone_shutdown");
  self notify(#"hash_1e2c098e8231a30f");

  if(isDefined(org) && isDefined(org.trigger1)) {
    org.trigger1 delete();
  }

  if(isDefined(org) && isDefined(org.trigger2)) {
    org.trigger2 delete();
  }

  if(isDefined(org) && isDefined(org.var_f9c2f48c)) {
    org.var_f9c2f48c unlink();
  }

  if(isDefined(org) && isDefined(org.var_b981836)) {
    org.var_b981836 unlink();
  }

  if(isDefined(self)) {
    if(isDefined(org) && isDefined(org.var_f9c2f48c)) {
      vel = org.var_f9c2f48c.origin - self.origin;
      org.var_f9c2f48c physicslaunch(org.var_f9c2f48c.origin, vel);
    }

    if(isDefined(org) && isDefined(org.var_b981836)) {
      vel = org.var_b981836.origin - self.origin;
      org.var_b981836 physicslaunch(org.var_b981836.origin, vel);
    }

    self.doa.var_c3159deb = undefined;
  }

  wait 5;

  if(isDefined(org) && isDefined(org.var_f9c2f48c)) {
    org.var_f9c2f48c delete();
  }

  if(isDefined(org) && isDefined(org.var_b981836)) {
    org.var_b981836 delete();
  }

  if(isDefined(org)) {
    org delete();
  }
}