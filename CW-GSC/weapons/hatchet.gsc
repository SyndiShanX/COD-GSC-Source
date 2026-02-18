/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\hatchet.gsc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;
#namespace hatchet;

function private autoexec __init__system__() {
  system::register(#"hatchet", &init_shared, undefined, undefined, undefined);
}

function init_shared() {
  weaponobjects::function_e6400478(#"hatchet", &function_1679806a, 1);
}

function function_1679806a(s_watcher) {
  s_watcher.onspawn = &function_16a186f;
  s_watcher.ondamage = &util::void;
  s_watcher.onspawnretrievetriggers = &weaponobjects::function_23b0aea9;
  s_watcher.pickup = &weaponobjects::function_d9219ce2;
  s_watcher.ontimeout = &function_27ae0902;
  s_watcher.onfizzleout = &function_27ae0902;

  if(isDefined(level.createhatchetwatcher)) {
    self[[level.createhatchetwatcher]](s_watcher);
  }
}

function function_27ae0902() {
  e_fx = spawn("script_model", self.origin);
  e_fx setModel(#"tag_origin");
  e_fx.angles = self.angles;
  playFXOnTag(#"hash_522eb6eca07bfe70", e_fx, "tag_origin");
  self delete();
}

function function_16a186f(s_watcher, player) {
  self notify("6ccb7151796e717a");
  self endon("6ccb7151796e717a");
  self childthread function_e95b2776();

  if(isDefined(level.playthrowhatchet)) {
    player[[level.playthrowhatchet]](self);
  }
}

function function_e95b2776() {
  self endon(#"delete", #"death");

  while(true) {
    waitresult = self waittill(#"stationary");

    if(!isDefined(waitresult.target)) {
      self.angles = angleclamp180(self.angles);
      v_right = anglestoright(self.angles);
      v_tangent = vectorcross(waitresult.normal, v_right);

      if(lengthsquared(v_tangent) < 0.1) {
        println("<dev string:x38>");
        break;
      }

      v_tangent = vectornormalize(v_tangent);
      n_angle = acos(v_tangent[2]) - 90;
      a_safe = [n_angle + 50, n_angle + 160];
      var_19e2c116 = [self.angles[0] - a_safe[0], a_safe[1] - self.angles[0]];

      if(getdvarint(#"hash_4bdc3028494aedcb", 0)) {
        line(waitresult.position, waitresult.position + waitresult.normal * 10, (1, 0, 0), 1, 0, 100);
        line(waitresult.position, waitresult.position + v_tangent * 10, (0, 1, 0), 1, 0, 100);
        var_a9f6fc6a = waitresult.position + anglesToForward(self.angles) * 10;
        line(waitresult.position, var_a9f6fc6a, (1, 0.5, 0), 1, 0, 100);
        print3d(var_a9f6fc6a, self.angles[0], (1, 0.5, 0), 1, 0.05, 100, 1);
        line(waitresult.position, waitresult.position + v_right * 10, (0, 0, 1), 1, 0, 100);
        var_d3d43ca3 = self.angles;
        var_d3d43ca3 = (a_safe[0], var_d3d43ca3[1], var_d3d43ca3[2]);
        var_a9f6fc6a = waitresult.position + anglesToForward(var_d3d43ca3) * 10;
        line(waitresult.position, var_a9f6fc6a, (1, 1, 0), 1, 0, 100);
        print3d(var_a9f6fc6a, a_safe[0], (1, 1, 0), 1, 0.05, 100, 1);
        var_d3d43ca3 = (a_safe[1], var_d3d43ca3[1], var_d3d43ca3[2]);
        var_a9f6fc6a = waitresult.position + anglesToForward(var_d3d43ca3) * 10;
        line(waitresult.position, var_a9f6fc6a, (1, 1, 0), 1, 0, 100);
        print3d(var_a9f6fc6a, a_safe[1], (1, 1, 0), 1, 0.05, 100, 1);
      }

      if(var_19e2c116[0] * var_19e2c116[1] < 0) {
        n_pitch = absangleclamp180(var_19e2c116[0]) > absangleclamp180(var_19e2c116[1]) ? a_safe[1] : a_safe[0];
        self.angles = (n_pitch, self.angles[1], self.angles[2]);
      }

      break;
    }
  }
}