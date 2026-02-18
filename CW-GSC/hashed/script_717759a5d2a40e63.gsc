/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_717759a5d2a40e63.gsc
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
#namespace namespace_7da86f3c;

function function_eeb092f5(entity) {
  if(isPlayer(entity)) {
    entity endon(#"disconnect");
  }

  entity endon(#"death");

  if(!isDefined(entity.doa.var_d006e019)) {
    entity.doa.var_d006e019 = 0;
  }

  if(isDefined(entity.doa.var_c980e593)) {
    entity.doa.var_c980e593 notify(#"expired");
  }

  var_c980e593 = namespace_ec06fe4a::spawnmodel(entity.origin, "tag_origin");
  entity.doa.var_c980e593 = var_c980e593;

  if(isDefined(var_c980e593)) {
    if(!isDefined(level.doa.active_attractors)) {
      level.doa.active_attractors = [];
    } else if(!isarray(level.doa.active_attractors)) {
      level.doa.active_attractors = array(level.doa.active_attractors);
    }

    level.doa.active_attractors[level.doa.active_attractors.size] = var_c980e593;
    var_c980e593 enablelinkto();
    var_c980e593 linkto(entity, undefined, (0, 0, 60));
    var_c980e593 namespace_83eb6304::function_3ecfde67("magnet_on");
    var_c980e593 namespace_e32bb68::function_3a59ec34("evt_doa_pickup_magnet_active_lp");
    var_c980e593 thread function_85cdc313(entity);
  } else {
    return;
  }

  entity.doa.var_c980e593 endon(#"death");
  timeout = entity namespace_1c2a96f9::function_4808b985(25);

  while(!namespace_dfc652ee::function_f759a457()) {
    waitframe(1);
  }

  entity.doa.var_d006e019 = gettime() + timeout * 1000;

  while(gettime() < entity.doa.var_d006e019) {
    wait 0.5;
  }

  if(isDefined(entity.doa.var_c980e593)) {
    entity.doa.var_c980e593 notify(#"expired");
  }
}

function function_2927fa9b() {
  self notify("4e7b52fe18a9b641");
  self endon("4e7b52fe18a9b641");
  self endon(#"death");
  self waittill(#"expired");
  arrayremovevalue(level.doa.active_attractors, self);
  self namespace_83eb6304::turnofffx("magnet_on");
  self namespace_e32bb68::function_ae271c0b("evt_doa_pickup_magnet_active_lp");
  self namespace_83eb6304::function_3ecfde67("magnet_fade");
  self namespace_e32bb68::function_3a59ec34("evt_doa_pickup_magnet_active_end");
  wait 1;
  self delete();
}

function function_85cdc313(owner) {
  self notify("3e3a69962a8e5cce");
  self endon("3e3a69962a8e5cce");
  self endon(#"death", #"expired");
  self thread function_2927fa9b();
  owner waittill(#"death", #"disconnect", #"player_died", #"clone_shutdown");
  self notify(#"expired");
}

function function_77af9e81() {
  type = [[self.def]] - > gettype();

  if(!function_9ded1b6c(type)) {
    return;
  }

  self notify("1fe1535c350b9278");
  self endon("1fe1535c350b9278");
  self endon(#"picked_up");
  self endon(#"death");
  self thread function_68126677();

  if(isDefined(self.var_d438ec42)) {
    self[[self.var_d438ec42]]();
  }

  arrayremovevalue(level.doa.active_attractors, undefined);

  while(true) {
    self.attractors = [];

    if(isDefined(self.var_d7e0da8b)) {
      self[[self.var_d7e0da8b]]();
    }

    foreach(orb in level.doa.active_attractors) {
      if(!isDefined(orb)) {
        continue;
      }

      distsq = distancesquared(orb.origin, self.origin);

      if(distsq < getdvarint(#"hash_5f8a3b48d8ebee04", sqr(400))) {
        self.attractors[self.attractors.size] = orb;
      }
    }

    waitframe(1);
  }
}

function function_9ded1b6c(type) {
  if(type == 1 || type == 9 || type == 8) {
    return true;
  }

  return false;
}

function private function_68126677(var_624b8d02 = getdvarint(#"hash_5f8a3b48d8ebee04", sqr(400))) {
  self notify(#"hash_2d37cb44b7f0c612");
  self endon(#"hash_2d37cb44b7f0c612");
  self endon(#"picked_up");
  self endon(#"death");
  self.var_76d7c415 = self.origin;

  while(true) {
    waitframe(1);

    if(self.attractors.size == 0 && is_true(self.var_e48718a6)) {
      if(self.origin[0] != self.var_76d7c415[0] || self.origin[1] != self.var_76d7c415[1]) {
        trace = bulletTrace(self.origin, self.origin + (0, 0, -500), 0, undefined);
        self.groundpos = namespace_ec06fe4a::function_65ee50ba(self.origin) + (0, 0, 32);
        self moveto(self.groundpos, 1);
        self waittilltimeout(1.1, #"movedone", #"picked_up", #"hash_2d37cb44b7f0c612", #"death");
        self.var_76d7c415 = self.origin;
        self.var_e48718a6 = undefined;
      }

      continue;
    }

    forcemag = isDefined(self.forcemag) ? self.forcemag : 10;

    foreach(force in self.attractors) {
      if(!isDefined(force)) {
        continue;
      }

      distsq = distancesquared(self.origin, force.origin);

      if(distsq > var_624b8d02) {
        continue;
      }

      if(isDefined(force.var_dacf4d3f)) {
        origin = force.origin + force.var_dacf4d3f;
      } else {
        origin = force.origin;
      }

      var_58b1f132 = vectornormalize(origin - self.origin);
      scale = (var_624b8d02 - distsq) / var_624b8d02;
      movevec = vectorscale(var_58b1f132, forcemag * scale);
      self.origin += movevec;
      self.var_e48718a6 = 1;
    }
  }
}