/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_hulk.csc
***********************************************/

#using script_20fe86d43b7f18f1;
#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\footsteps_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace zm_ai_hulk;

function private autoexec __init__system__() {
  system::register(#"zm_ai_hulk", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("scriptmover", "dog_launcher_explode_fx", 1, 1, "counter", &dog_launcher_explode_fx, 0, 0);
  clientfield::register("scriptmover", "hs_swarm_state", 1, 3, "int", &function_440e968, 0, 0);
  clientfield::register("allplayers", "hs_swarm_damage", 1, 3, "int", &function_64d1f09b, 1, 0);
  clientfield::register("scriptmover", "dog_projectile_fx", 1, 1, "int", &dog_projectile_fx, 0, 0);
  clientfield::register("scriptmover", "hs_summon_cf", 1, 2, "int", &function_e54f99c7, 0, 0);
  clientfield::register("actor", "hs_melee_wander_heal_cf", 1, 1, "int", &function_492b47af, 0, 0);
  clientfield::register("actor", "hs_hound_actor_cf", 1, 1, "int", &function_fa6b2c4a, 0, 0);
  clientfield::register("actor", "hs_dissolve_cf", 1, 1, "int", &function_326d6c4, 0, 0);
  clientfield::register("actor", "hs_stomp_cf", 1, 1, "counter", &function_58f13478, 0, 0);
  clientfield::register("actor", "hs_melee_smash_cf", 1, 1, "counter", &function_dbb5ee92, 0, 0);
  clientfield::register("toplayer", "hulk_melee_shake", 1, 1, "counter", &function_d61b9cf2, 0, 0);
  footsteps::registeraitypefootstepcb(#"hulk", &function_fc70d505);
  ai::add_archetype_spawn_function(#"hulk", &function_2a4100e7);
}

function private function_fc70d505(localclientnum, pos, surface, notetrack, bone) {
  function_16f54168(notetrack, bone, 1500, 1, 0.2, 0.5);
}

function private function_16f54168(localclientnum, point, radius, duration, var_ef084468, var_f1f3557f, var_23b3962) {
  if(!(isDefined(point) && isDefined(radius)) || radius <= 0) {
    return;
  }

  if(!isDefined(duration)) {
    duration = 0.5;
  }

  if(!isDefined(var_ef084468)) {
    var_ef084468 = 0.1;
  }

  if(!isDefined(var_f1f3557f)) {
    var_f1f3557f = 0.5;
  }

  if(!isDefined(var_23b3962)) {
    var_23b3962 = 0.25;
  }

  e_player = function_5c10bd79(localclientnum);
  n_dist = distance(point, e_player.origin);
  n_scale = (radius - n_dist) / radius;

  if(n_scale < 0 || n_scale > 1) {
    return;
  }

  rumble = "zm_hulk_screenshake_light";

  if(n_scale > 1 - var_ef084468) {
    rumble = "zm_hulk_screenshake_heavy";
  } else if(n_scale > 1 - var_f1f3557f) {
    rumble = "zm_hulk_screenshake";
  }

  earthquake(localclientnum, max(n_scale * var_23b3962, 0.02), 0.1, point, radius);
  function_36e4ebd4(localclientnum, rumble);
}

function dog_projectile_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  if(bwastimejump == 1) {
    self.var_e65311fc = util::playFXOnTag(fieldname, #"hash_901b71115b1cd3f", self, "j_spine4");
    return;
  }

  if(isDefined(self.var_e65311fc)) {
    stopfx(fieldname, self.var_e65311fc);
    self.var_e65311fc = undefined;
  }
}

function private dog_launcher_explode_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self.fx = playFX(fieldname, #"hash_1a93b9b31b5d1d3b", self.origin + (0, 0, 18), anglestoup(self.angles));
    self playSound(fieldname, #"hash_6a76932cce379c66");
    function_16f54168(fieldname, self.origin, 750, 0.75, 0.3, 0.75, 0.5);
  }
}

function private function_440e968(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(isDefined(self.var_d61d7100)) {
    stopfx(fieldname, self.var_d61d7100);
  }

  fx = undefined;

  switch (bwastimejump) {
    case 1:
      fx = # "hash_470d346ff9631146";
      break;
    case 2:
      fx = # "hash_40bf4040b66f2027";
      break;
    case 3:
      fx = # "hash_6c502dd4772c1198";
      break;
    case 4:
      fx = # "hash_ba0e31960f1b3db";
      break;
  }

  self.var_9e8d031c = bwastimejump;

  if(!isDefined(fx)) {
    return;
  }

  if(!isDefined(self.var_af4484a7)) {
    self.var_af4484a7 = 1;
    self callback::on_shutdown(&function_95dc19b0);
  }

  self.var_d61d7100 = util::playFXOnTag(fieldname, fx, self, "tag_origin");
}

function private function_95dc19b0(localclientnum) {
  if(isDefined(self) && isvec(self.origin)) {
    fx = # "hash_470d346ff9631146";
    playFX(localclientnum, fx, self.origin);
  }
}

function private function_64d1f09b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isalive(self) || self !== function_5c10bd79(fieldname)) {
    return;
  }

  fx = undefined;

  switch (bwastimejump) {
    case 2:
      fx = # "hash_3a6de80e2a03ffd1";
      break;
    case 3:
      fx = # "hash_736dc8868c980f5a";
      break;
    case 4:
      fx = # "hash_45ae173e6c1708dd";
      break;
  }

  if(!isDefined(fx)) {
    return;
  }

  viewmodelfx = playfxoncamera(fieldname, fx, (0, 0, 0), (1, 0, 0), (0, 0, 1));
  wait 0.5;
  stopfx(fieldname, viewmodelfx);
}

function private function_2a4100e7(localclientnum) {
  self util::waittill_dobj(localclientnum);
  self namespace_14ee8104::function_54d0d2d1(localclientnum);

  if(isDefined(self) && isDefined("rob_orda_dissolve_sr")) {
    self playrenderoverridebundle("rob_orda_dissolve_sr");
  }

  if(isDefined(self.var_553a42c)) {
    foreach(zombie in self.var_553a42c) {
      if(isDefined(zombie) && isDefined("rob_orda_dissolve_sr")) {
        zombie playrenderoverridebundle("rob_orda_dissolve_sr");
      }
    }
  }

  if(isDefined(self.fxdef)) {
    fxclientutils::playfxbundle(localclientnum, self, self.fxdef);
    self thread function_7622c629(localclientnum);
  }
}

function private function_7622c629(localclientnum) {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"hs_turn_off_fx");

    switch (waitresult._notify) {
      case # "hs_turn_off_fx":
        if(isDefined(self.fxdef)) {
          fxclientutils::stopfxbundle(localclientnum, self, self.fxdef);
        }

        break;
    }
  }
}

function private function_492b47af(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  if(bwastimejump) {
    self playrenderoverridebundle("rob_zmb_orda_body_glow");
    return;
  }

  self stoprenderoverridebundle("rob_zmb_orda_body_glow");
}

function private function_fa6b2c4a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  if(bwastimejump) {
    self playrenderoverridebundle("rob_zmb_orda_hand_weapon_glow");
    return;
  }

  self stoprenderoverridebundle("rob_zmb_orda_hand_weapon_glow");
}

function private function_326d6c4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  if(bwastimejump) {
    self stoprenderoverridebundle("rob_orda_dissolve_sr");

    if(isDefined(self.var_553a42c)) {
      foreach(torso in self.var_553a42c) {
        torso stoprenderoverridebundle("rob_orda_dissolve_sr");
      }
    }
  }
}

function private function_58f13478(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  if(bwastimejump) {
    left_foot = self gettagorigin("j_ball_le");
    right_foot = self gettagorigin("j_ball_ri");
    var_6aad4414 = left_foot[2] < right_foot[2] ? right_foot : left_foot;
    function_16f54168(fieldname, var_6aad4414, 1500, 1, 0.3, 0.95);
  }
}

function private function_dbb5ee92(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  if(bwastimejump) {
    pos = self gettagorigin("j_pocketdown4_le");
    playFX(fieldname, #"hash_4766b0f3e0d580be", pos);
    radius = 2000;
    function_16f54168(fieldname, pos, radius, 1, 0.6, 750 / radius);
  }
}

function private function_d61b9cf2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  id = earthquake(bwastimejump, 0.3, 0.4, self.origin, 1000, 0);
}

function private function_e54f99c7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(bwastimejump == 1) {
    self.fx_ent = util::spawn_model(fieldname, #"tag_origin", self.origin, (-90, 0, 0));
    self.fx_ent thread function_456a451e();
    return;
  }

  if(bwastimejump == 2) {
    if(isDefined(self.fx_ent)) {
      self.fx_ent thread function_1b79e37c(fieldname, self.origin, self.fx_ent.origin);
    }

    self.fx_ent = undefined;
  }
}

function function_456a451e() {
  self endon(#"death");
  self notify("47eb478cdbe8a440");
  self endon("47eb478cdbe8a440");
  self waittilltimeout(3, #"fx_completed");
  self delete();
}

function function_1b79e37c(localclientnum, start, end) {
  self endon(#"death");
  gravity = float(getDvar(#"hash_2748f9e519feda97", 0.004));
  distance2d = distance2d(start, end);
  dir = end - start;
  dir = (dir[0], dir[1], 0);
  dir = vectornormalize(dir);
  time = int(0.75 * 1000);
  var_199c57d2 = distance2d / time;
  var_ef97a46c = (end[2] - start[2] + 0.5 * gravity * sqr(time)) / time;
  vel = (dir[0] * var_199c57d2, dir[1] * var_199c57d2, var_ef97a46c);
  end_time = gettime() + time;
  self.origin = start;
  handle = function_239993de(localclientnum, #"hash_50b57e69b1f1837b", self, "tag_origin");
  playSound(localclientnum, #"hash_5674296fdc18f1ed", self.origin);
  start_time = gettime();
  waitframe(1);

  while(gettime() < end_time) {
    time = gettime() - start_time;
    self.origin = start + vel * time + 0.5 * (0, 0, -1) * gravity * sqr(time);
    waitframe(1);
  }

  self.origin = end;
  playFX(localclientnum, #"hash_7eba9aeb0c1d0afe", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  stopfx(localclientnum, handle);
  function_16f54168(localclientnum, end, 292);
  self notify(#"fx_completed");
}