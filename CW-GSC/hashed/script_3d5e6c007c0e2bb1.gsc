/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3d5e6c007c0e2bb1.gsc
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
#namespace namespace_bf41daf8;

function barrelupdate(model_name = "zombietron_barrel") {
  self notify(#"hash_562d458e34274132");

  if(isPlayer(self)) {
    self endon(#"disconnect");
  }

  waitframe(1);
  self endon(#"barrels_done", #"hash_562d458e34274132");
  org = namespace_ec06fe4a::spawnmodel(self.origin, "tag_origin");

  if(isDefined(org)) {
    org.targetname = "barrelUpdate";
    org.angles = (0, randomint(180), 0);
    self.doa.var_ba83e9 = org;

    if(isPlayer(self)) {
      org thread namespace_ec06fe4a::function_ae010bb4(self);
    }
  } else {
    return;
  }

  barrel = namespace_ec06fe4a::spawnmodel(self.origin + (0, 90, 0), model_name);

  if(isDefined(barrel)) {
    barrel.targetname = "barrel1";
    barrel setplayercollision(0);
    barrel linkto(org, "tag_origin", (0, 90, 0));

    if(isPlayer(self)) {
      barrel thread namespace_ec06fe4a::function_ae010bb4(self);
    }

    trigger = namespace_ec06fe4a::spawntrigger("trigger_radius", barrel.origin, 1 | 512 | 8, 40, 50);

    if(isDefined(trigger)) {
      if(isPlayer(self)) {
        trigger thread namespace_ec06fe4a::function_ae010bb4(self);
      }

      trigger.targetname = "barrel1";
      trigger enablelinkto();
      trigger linkto(barrel);
      trigger thread function_7c757878(self);
    }
  }

  org.barrel1 = barrel;
  org.trigger1 = trigger;
  barrel = namespace_ec06fe4a::spawnmodel(self.origin + (0, -90, 0), model_name);

  if(isDefined(barrel)) {
    if(isPlayer(self)) {
      barrel thread namespace_ec06fe4a::function_ae010bb4(self);
    }

    barrel.targetname = "barrel2";
    barrel setModel(model_name);
    barrel setplayercollision(0);
    barrel linkto(org, "tag_origin", (0, -90, 0));
    trigger = namespace_ec06fe4a::spawntrigger("trigger_radius", barrel.origin, 1 | 512 | 8, 40, 50);

    if(isDefined(trigger)) {
      if(isPlayer(self)) {
        trigger thread namespace_ec06fe4a::function_ae010bb4(self);
      }

      trigger.targetname = "barrel2";
      trigger enablelinkto();
      trigger linkto(barrel);
      trigger thread function_7c757878(self);
    }
  }

  org.barrel2 = barrel;
  org.trigger2 = trigger;
  org linkto(self, "", (0, 0, 10), (0, 0, 0));
  self namespace_e32bb68::function_3a59ec34("evt_doa_pickup_barrel_active_lp");
  self thread function_61888137(org);
  self thread function_f0855523(org);
  org thread function_6ad92846(self);

  while(isDefined(org) && isDefined(self)) {
    org.origin = self.origin;
    org rotateto(org.angles + (0, 180, 0), 1.2);
    wait 1.2;
  }
}

function private function_7c757878(player, mod = "MOD_UNKNOWN", var_70c63791) {
  player endon(#"barrels_done");

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
    guy namespace_e32bb68::function_3a59ec34("evt_doa_pickup_barrel_active_impact");

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
  self endon(#"barrels_done", #"hash_562d458e34274132");

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
  self notify(#"barrels_done");
}

function private function_6ad92846(player) {
  self endon(#"death");

  if(isPlayer(player)) {
    player waittill(#"disconnect");
  } else {
    return;
  }

  if(isDefined(self.trigger1)) {
    self.trigger1 delete();
  }

  if(isDefined(self.trigger2)) {
    self.trigger2 delete();
  }

  if(isDefined(self.barrel1)) {
    self.barrel1 delete();
  }

  if(isDefined(self.barrel2)) {
    self.barrel2 delete();
  }

  if(isDefined(self)) {
    self delete();
  }
}

function private function_f0855523(org) {
  if(isPlayer(self)) {
    self endon(#"disconnect");
  }

  self waittill(#"barrels_done", #"entering_last_stand", #"kill_shield", #"hash_df25520ab279dff", #"hash_562d458e34274132", #"player_died", #"enter_vehicle", #"clone_shutdown", #"death");

  if(isDefined(self)) {
    self notify(#"barrels_done");
  }

  if(isDefined(org) && isDefined(org.trigger1)) {
    org.trigger1 delete();
  }

  if(isDefined(org) && isDefined(org.trigger2)) {
    org.trigger2 delete();
  }

  if(isDefined(org) && isDefined(org.barrel1)) {
    org.barrel1 unlink();
  }

  if(isDefined(org) && isDefined(org.barrel2)) {
    org.barrel2 unlink();
  }

  if(isDefined(self)) {
    if(isDefined(org) && isDefined(org.barrel1)) {
      vel = org.barrel1.origin - self.origin;
      org.barrel1 physicslaunch(org.barrel1.origin, vel);
    }

    if(isDefined(org) && isDefined(org.barrel2)) {
      vel = org.barrel2.origin - self.origin;
      org.barrel2 physicslaunch(org.barrel2.origin, vel);
    }

    self.doa.var_ba83e9 = undefined;
    self namespace_e32bb68::function_ae271c0b("evt_doa_pickup_barrel_active_lp");
    self namespace_e32bb68::function_3a59ec34("evt_doa_pickup_barrel_active_end");
  }

  wait 5;

  if(isDefined(org) && isDefined(org.barrel1)) {
    org.barrel1 delete();
  }

  if(isDefined(org) && isDefined(org.barrel2)) {
    org.barrel2 delete();
  }

  if(isDefined(org)) {
    org delete();
  }
}