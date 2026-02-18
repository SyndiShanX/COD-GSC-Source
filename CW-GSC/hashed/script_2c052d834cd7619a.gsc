/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2c052d834cd7619a.gsc
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
#namespace namespace_52ba5a8a;

function function_124c1a34(player, model, note) {
  blade = namespace_ec06fe4a::spawnmodel(self.origin, model);

  if(!isDefined(blade)) {
    return false;
  }

  blade.targetname = "blade";
  blade setplayercollision(0);
  blade enablelinkto();
  blade linkto(self, undefined, (0, -70, 0));
  trigger = namespace_ec06fe4a::spawntrigger("trigger_radius", blade.origin, 1 | 512 | 8, 30, 50);

  if(!isDefined(trigger)) {
    blade delete();
    return false;
  }

  trigger.targetname = "blade";
  trigger enablelinkto();
  trigger linkto(blade);
  trigger thread function_7daf5356(player, note);
  blade namespace_e32bb68::function_3a59ec34("evt_doa_pickup_sawblade_active_lp");
  self.blade = blade;
  self.trigger = trigger;
  return true;
}

function sawbladeupdate(model = "zombietron_sawblade") {
  note = namespace_ec06fe4a::function_7fcca25d("end_sawblad_pickup");
  self endon(note);

  if(isPlayer(self)) {
    self endon(#"disconnect");
  }

  waitframe(1);
  self endon(#"blades_done");

  if(!isDefined(self.doa.var_1739bd8e)) {
    self.doa.var_1739bd8e = [];
  }

  org = namespace_ec06fe4a::spawnmodel(self.origin, "tag_origin");

  if(!isDefined(org)) {
    return;
  }

  org.targetname = "sawbladeUpdate";
  org.angles = (0, randomint(180), 0);
  org enablelinkto();
  self.doa.var_1739bd8e[self.doa.var_1739bd8e.size] = org;
  org linkto(self, undefined, (0, 0, 32));
  self thread function_40fc311d(org, note);
  self thread function_20139eee(org, note);
  result = org function_124c1a34(self, model, note);

  if(result == 0) {
    self notify(note);
  }

  while(isDefined(org)) {
    org rotateto(org.angles + (0, 180, 0), 0.4);
    wait 0.4;
  }
}

function private function_7daf5356(player, endnote) {
  player endon(endnote);

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

    guy namespace_e32bb68::function_3a59ec34("evt_doa_pickup_sawblade_active_impact");

    if(isactor(guy)) {
      vel = vectorscale(self.origin - player.origin, 0.2);

      if(!is_true(guy.no_gib)) {
        guy namespace_ed80aead::function_1f275794(vel, player);
        guy thread namespace_ec06fe4a::function_570729f0(randomintrange(5, 10), player);
        guy dodamage(guy.maxhealth >> 1, guy.origin, player, player, "none", "MOD_UNKNOWN");
      } else {
        guy dodamage(guy.health + 1, guy.origin, player, player, "none", "MOD_UNKNOWN");
      }

      continue;
    }

    guy dodamage(guy.health + 1, guy.origin, player, player, "none", "MOD_UNKNOWN");
  }
}

function private function_40fc311d(org, endnote) {
  self endon(endnote);

  if(isPlayer(self)) {
    self endon(#"disconnect");
  }

  timeout = max(max(40, self namespace_1c2a96f9::function_4808b985(40)), self namespace_1c2a96f9::function_2ce61fb9(40));

  while(!namespace_dfc652ee::function_f759a457()) {
    waitframe(1);
  }

  wait timeout;
  self notify(endnote);
}

function private function_20139eee(org, endnote) {
  self waittill(endnote, #"player_died", #"kill_shield", #"disconnect", #"death", #"enter_vehicle", #"hash_df25520ab279dff", #"clone_shutdown");

  if(isDefined(self)) {
    self notify(endnote);
  }

  util::wait_network_frame();

  if(isDefined(org.trigger)) {
    org.trigger delete();
  }

  if(isDefined(org.blade)) {
    org.blade unlink();
    vel = (0, 0, 20);

    if(isDefined(self)) {
      vel = org.blade.origin - self.origin;
    }

    org.blade physicslaunch(org.blade.origin, vel);
    org.blade namespace_e32bb68::function_ae271c0b("evt_doa_pickup_sawblade_active_lp");
    org.blade namespace_e32bb68::function_3a59ec34("evt_doa_pickup_sawblade_lose_blade");
    wait 5;
    org.blade delete();
  }

  if(isDefined(self)) {
    arrayremovevalue(self.doa.var_1739bd8e, org);
  }

  org delete();
}