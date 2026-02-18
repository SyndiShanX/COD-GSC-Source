/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_8831f23e914a136.csc
***********************************************/

#using scripts\core_common\system_shared;
#namespace namespace_131517b7;

function private autoexec __init__system__() {
  system::register(#"hash_26735a31c43bda52", undefined, undefined, &function_5b164bbc, undefined);
}

function function_5b164bbc() {
  foreach(dynent in function_dc7f007()) {
    dynent.ondestroyed = &function_61fb9b33;
    bundle = function_489009c1(dynent);

    if(isDefined(bundle) && isDefined(bundle.var_e32432cf)) {
      switch (bundle.var_e32432cf) {
        case # "hash_3c27aafc8cd27c4":
          dynent.start_origin = dynent.origin;
          dynent.start_angles = dynent.angles;
          dynent thread function_733e5314();
          break;
      }
    }
  }
}

function function_61fb9b33(eventstruct) {
  function_27b5ddff(eventstruct.ent);
  launchdynent(eventstruct.ent, eventstruct.dir * 5, eventstruct.position);
  eventstruct.ent notify(#"hash_4874aa76b9c9cda5");
  bundle = function_489009c1(eventstruct.ent);

  if(isDefined(bundle) && isDefined(bundle.dynentstates)) {
    stateindex = isDefined(bundle.destroyed) ? bundle.destroyed : 0;

    if(isDefined(bundle.dynentstates[stateindex])) {
      setdynentstate(0, eventstruct.ent, stateindex);
    }
  }
}

function function_2ec27175(var_391ae5) {
  if(isDefined(var_391ae5.var_ee13df27)) {
    var_c01b1f44 = {
      #sound_name: var_391ae5.var_ee13df27, #var_9b95a335: isDefined(var_391ae5.var_6dae19be) ? var_391ae5.var_6dae19be : 1, #var_bffcadab: isDefined(var_391ae5.var_f4fffb24) ? var_391ae5.var_f4fffb24 : 1
    };
  }

  return var_c01b1f44;
}

function function_be87aa71(var_c01b1f44) {
  self notify("1851f5a51d00bb86");
  self endon("1851f5a51d00bb86");
  self endon(#"hash_4874aa76b9c9cda5", #"state_changed");

  if(!isDefined(var_c01b1f44)) {
    return;
  }

  while(true) {
    if(self.var_ade25cfe === var_c01b1f44.sound_name && isDefined(self.var_6039cf61) && self.var_6039cf61 > getservertime(0)) {
      wait float(self.var_6039cf61 - getservertime(0)) / 1000;
    }

    var_c9823318 = function_5c10bd79(0);

    if(isPlayer(var_c9823318) && distancesquared(var_c9823318.origin, self.origin) < sqr(1000)) {
      playSound(0, var_c01b1f44.sound_name, self.origin);

      if(getdvarint(#"hash_5bbf0a73200999f9", 0)) {
        debugstar(self.origin, int(62.5), (1, 0, 1));
      }
    }

    wait_time = var_c01b1f44.var_9b95a335 != var_c01b1f44.var_bffcadab ? randomfloatrange(var_c01b1f44.var_9b95a335, var_c01b1f44.var_bffcadab) : var_c01b1f44.var_9b95a335;
    self.var_6039cf61 = getservertime(0) + int(wait_time * 1000);
    self.var_ade25cfe = var_c01b1f44.sound_name;
    wait wait_time;
    self.var_6039cf61 = undefined;
  }
}

function function_733e5314() {
  self endon(#"state_changed");
  var_25dac1e7 = randomfloatrange(30, 90);
  bundle = function_489009c1(self);
  var_2828eabf = isDefined(bundle.destroyed) ? bundle.destroyed : 0;
  var_d3b6e91d = isDefined(bundle.idlestate) ? bundle.idlestate : 0;
  var_60138ede = isDefined(bundle.var_7320b70a) ? bundle.var_7320b70a : 0;
  var_5f94b69b = isDefined(bundle.var_49caaddf) ? bundle.var_49caaddf : 0;
  var_de89d793 = bundle.dynentstates[var_60138ede];

  if(!isDefined(var_de89d793) || !isDefined(var_de89d793.stateanim)) {
    return;
  }

  var_381de367 = var_de89d793.stateanim;
  var_931fd54a = is_true(var_de89d793.var_3f644836);
  var_efcac2fa = bundle.dynentstates[var_d3b6e91d];
  idle_anim = var_efcac2fa.stateanim;
  var_881752fb = function_2ec27175(var_de89d793);
  var_fe69fc89 = function_2ec27175(var_efcac2fa);
  bundle = undefined;
  self.var_621ee87d = 1;
  state = 0;

  for(waitresult = undefined; self.health > 0; waitresult = self waittilltimeout(randomfloatrange(3, 5), #"hash_2b397aad1337c105", #"wall_detected")) {
    angles = undefined;
    turn_rate = var_25dac1e7;

    if(!isDefined(waitresult) || waitresult._notify !== "wall_detected") {
      timeout = getrealtime();
    }

    if(self.origin[2] < -10000 || getrealtime() - timeout > 3000) {
      setdynentstate(0, self, var_5f94b69b);
      self notify(#"hash_4874aa76b9c9cda5");
      wait 1;
      self.origin = self.start_origin;
      self.angles = self.start_angles;
      wait 5;
      setdynentstate(0, self, var_d3b6e91d);
      self thread function_733e5314();
      return;
    }

    if(!isDefined(waitresult) || waitresult._notify === "timeout") {
      if(state === 2 || state === 1) {
        var_116c2a14 = function_76904e7f();
        angles = vectortoangles(var_116c2a14);

        if(state === 1) {
          function_27b5ddff(self);
        }

        state = 0;
        anim_rate = 1;
      } else {
        function_1e23c01f(self, idle_anim);
        self.last_anim = idle_anim;
        function_d380c9a3(self);
        state = 2;
        self thread function_be87aa71(var_fe69fc89);
      }
    } else if(isDefined(waitresult) && waitresult._notify === "wall_detected") {
      if(lengthsquared(waitresult.normal) == 0) {
        self notify(#"hash_4874aa76b9c9cda5");
        setdynentstate(0, self, var_5f94b69b);
        wait 1;
        self.origin = self.start_origin;
        self.angles = self.start_angles;
        wait 5;
        setdynentstate(0, self, var_d3b6e91d);
        self thread function_733e5314();
        return;
      }

      right = vectorcross(waitresult.normal, (0, 0, 1));
      angles = vectortoangles(right);

      if(absangleclamp360(angles[1] - self.angles[1]) < 0.001) {
        angles = (angles[0], angles[1] * -1, angles[2]);
      }

      turn_rate = 90;
    } else {
      var_21a930c2 = self.origin - waitresult.var_6be223c2;
      angles = vectortoangles(var_21a930c2);

      if(state === 0) {
        function_27b5ddff(self);
      }

      state = 1;
      anim_rate = 1;
      turn_rate = 240;
    }

    if(isDefined(angles)) {
      if(self.last_anim !== var_381de367 || self.var_51b1adce !== anim_rate) {
        function_1ef41caa(self, var_381de367, undefined, anim_rate, var_931fd54a);

        if(isDefined(var_881752fb)) {
          self thread function_be87aa71(var_881752fb);
        }

        self.last_anim = var_381de367;
        self.var_51b1adce = anim_rate;
      }

      function_64303428(self, angles[1], turn_rate);
    }

    if(waitresult._notify === "wall_detected") {
      wait 1;
    }
  }
}

function function_76904e7f() {
  theta = randomfloatrange(0, 360);
  x = sin(theta);
  y = cos(theta);
  return (x, y, 0);
}