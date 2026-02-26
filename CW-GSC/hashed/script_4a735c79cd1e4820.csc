/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4a735c79cd1e4820.csc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\util;
#namespace namespace_845d1a97;

function private autoexec __init__() {
  function_5ac4dc99("<dev string:x38>", 0);
  function_5ac4dc99("<dev string:x56>", 0);
  function_5ac4dc99("<dev string:x74>", -1);
}

function function_80d28d77(localclientnum, impactfx, var_4b30f907, var_9cb23c3, endnotify, tracenormal, tracedist, var_b6a0baae, culldist, var_1d1675b, var_d500b38d, var_d06c0cef, var_434f3a56, var_740a6a07, var_17e9e56c, var_40f7123c) {
  self endon(#"death", #"hash_63c6fa848f448e22");

  if(isDefined(endnotify)) {
    self endon(endnotify);
  }

  if(!isDefined(tracedist)) {
    tracedist = 500;
  }

  if(!isDefined(tracenormal)) {
    tracenormal = (0, 0, -1);
  } else {
    tracenormal = vectornormalize(tracenormal);
  }

  var_1daf2286 = tracenormal * tracedist;

  if(!isDefined(var_b6a0baae)) {
    if(isDefined(self.vehicletype)) {
      var_b6a0baae = 0.866025;
    } else {
      var_b6a0baae = 0.5;
    }
  } else {
    var_b6a0baae = cos(var_b6a0baae);
  }

  if(!isDefined(culldist)) {
    culldist = 1000;
  }

  if(!isDefined(var_1d1675b)) {
    var_1d1675b = 1;
  }

  if(!isDefined(var_d500b38d)) {
    var_d500b38d = 1;
  }

  if(!isDefined(var_d06c0cef)) {
    var_d06c0cef = -1;
  }

  if(!isDefined(var_434f3a56)) {
    var_434f3a56 = 1;
  }

  if(!isDefined(var_740a6a07)) {
    var_740a6a07 = -1;
  }

  if(!isDefined(var_17e9e56c)) {
    var_17e9e56c = 1;
  }

  if(!isDefined(var_40f7123c)) {
    var_40f7123c = -1;
  }

  assert(var_4b30f907 > 0);
  wait_time = 1 / var_4b30f907;
  var_70bdcaa = int(max(0.016 / wait_time, 1));
  wait_time = 0.016 * int(max(wait_time / 0.016, 1));

  while(true) {
    if(getdvarfloat(#"hash_366b9410b5385383", -1) >= 0) {
      culldist = getdvarfloat(#"hash_366b9410b5385383", -1);
    }

    playereyepos = getlocalclienteyepos(localclientnum);
    playerangles = getlocalclientangles(localclientnum);
    playerorigin = getlocalclientpos(localclientnum);
    playerfov = getlocalclientfov(localclientnum);
    halffov = playerfov * 0.5;
    bounds = function_c440d28e(self.model);
    var_a6448197 = self function_4b2f0374(playereyepos, playerangles, halffov, culldist);

    if(var_a6448197) {
      for(i = 0; i < var_70bdcaa; i++) {
        randx = randomfloatrange(var_d06c0cef, var_d500b38d);
        randy = randomfloatrange(var_740a6a07, var_434f3a56);
        var_d13bdc2a = randomfloatrange(var_40f7123c, var_17e9e56c);
        point = self getpointinbounds(randx, randy, var_d13bdc2a);
        start = point - var_1daf2286;
        end = point + var_1daf2286;
        trace = bulletTrace(start, end, 1, undefined);

        var_9207bc91 = (1, 0, 0);

        if(trace[#"entity"] === self) {
          dot = vectordot(tracenormal, trace[#"normal"]) * -1;

          if(dot >= var_b6a0baae) {
            if(isarray(impactfx)) {
              fx = impactfx[randomintrange(0, impactfx.size)];
            } else {
              fx = impactfx;
            }

            self thread function_7355defa(localclientnum, fx, var_9cb23c3, trace[#"position"], trace[#"normal"], var_1d1675b);

            var_9207bc91 = (0, 1, 1);
          }
        }

        if(getdvarint(#"hash_8d6bf09ce80eeff", 0)) {
          line(start, trace[#"position"], var_9207bc91, 1, 1, 60);
        }
      }
    }

    if(getdvarint(#"hash_22fbca6d98944c80", 0)) {
      function_f63efb32(var_d500b38d, var_d06c0cef, var_434f3a56, var_740a6a07, var_17e9e56c, var_40f7123c);
    }

    wait wait_time;
  }
}

function function_adb04672() {
  self notify(#"hash_63c6fa848f448e22");
}

function private function_7355defa(localclientnum, impactfx, var_9cb23c3, hitposition, hitnormal, var_1d1675b) {
  if(!isDefined(self)) {
    return;
  }

  if(!is_true(var_1d1675b)) {
    playFX(localclientnum, impactfx, hitposition, hitnormal);
    return;
  }

  impact = util::spawn_model(localclientnum, "tag_origin", hitposition, vectortoangles(hitnormal));

  if(!isDefined(impact)) {
    return;
  }

  impact linkto(self);
  waitframe(1);
  util::playFXOnTag(localclientnum, impactfx, impact, "tag_origin");
  wait var_9cb23c3;
  impact delete();
}

function private function_f63efb32(var_d500b38d, var_d06c0cef, var_434f3a56, var_740a6a07, var_17e9e56c, var_40f7123c) {
  bounds = function_c440d28e(self.model);
  box(self.origin, bounds.mins, bounds.maxs, absangleclamp360(self.angles[1]), (0, 0.25, 0), 1, 1, 1);
  var_4fe68d11 = bounds.maxs - bounds.mins;
  halfsize = var_4fe68d11 * 0.5;
  midpoint = bounds.mins + halfsize;
  var_276e4d7e = midpoint + halfsize * (var_d06c0cef, var_740a6a07, var_40f7123c);
  var_f106b31 = midpoint + halfsize * (var_d500b38d, var_434f3a56, var_17e9e56c);
  box(self.origin, var_276e4d7e, var_f106b31, absangleclamp360(self.angles[1]), (0, 1, 0), 1, 1, 1);
}