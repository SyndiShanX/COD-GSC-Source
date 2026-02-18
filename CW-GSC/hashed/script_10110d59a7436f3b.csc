/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_10110d59a7436f3b.csc
***********************************************/

#using script_140d5347de8af85c;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\easing;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_7b8a8e22;

function private autoexec __init__system__() {
  system::register(#"hash_5bc761d26eb100ef", &preload, undefined, undefined, undefined);
}

function preload() {
  clientfield::register("toplayer", "set_camera_state", 1, 1, "int", &set_camera_state, 0, 0);
  clientfield::register("toplayer", "swap_camera", 1, 1, "counter", &swap_camera, 0, 0);
  clientfield::register("toplayer", "block_zoom_input", 1, 1, "int", &function_b9114b6e, 0, 0);
}

function set_camera_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(bwastimejump > 0) {
    self thread function_38401b6f(fieldname);
    return;
  }

  self function_c2856ebd(0);
}

function swap_camera(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_c2856ebd(0);
  self thread function_38401b6f(bwastimejump);
}

function function_b9114b6e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump > 0) {
    self.var_37246819 = 1;
    return;
  }

  self.var_37246819 = undefined;
}

function private function_38401b6f(localclientnum) {
  self endon(#"death", #"disconnected", #"deactivate_camera_lens_overrides");
  var_8dd70933 = 200;
  var_11f00a95 = 14.64;
  var_73024e3b = 0;
  zoom_frac = 0;
  zoom_rate = 0.004;
  var_76c1719d = 8;
  var_27033013 = 0.5;
  self function_49cdf043(var_11f00a95, 0);
  var_e99a5258 = 4608;
  var_4f64fb6b = 6;
  var_c5e00469 = (var_4f64fb6b * -1, var_4f64fb6b * -1, var_4f64fb6b * -1);
  var_43ac2595 = (var_4f64fb6b, var_4f64fb6b, var_4f64fb6b);
  var_b4e0311b = 0.2;
  var_cbcfc238 = self function_82f1cbd2();
  var_e17c45e2 = self function_78bf7752();
  var_58cb5a30 = 0;
  var_b0ea9e6d = 2;
  self function_1816c600(5, 0);
  self function_9e574055(1);

  while(true) {
    if(isDefined(self.var_37246819)) {
      waitframe(1);
      continue;
    }

    var_546112ef = self util::function_ca4b4e19(localclientnum, 0)[# "move"];
    zoom_frac = lerpfloat(zoom_frac, util::function_b5338ccb(var_546112ef[1], var_b4e0311b), 0.5);

    if(zoom_frac != 0 && (zoom_frac < 0 && var_cbcfc238 > var_11f00a95 || zoom_frac > 0 && var_cbcfc238 < var_8dd70933)) {
      var_73024e3b += zoom_frac * zoom_rate;

      if(var_73024e3b < 0) {
        var_73024e3b = 0;
      } else if(var_73024e3b > 1) {
        var_73024e3b = 1;
      }

      var_cbcfc238 = easing::ease_cubic(var_11f00a95, var_8dd70933, var_73024e3b, 1, 1);
      self function_49cdf043(var_cbcfc238, 0);
      var_14b2798 = (var_cbcfc238 - var_11f00a95) / var_76c1719d * var_27033013;
      function_4238734d(localclientnum, "pstfx_t9_cp_crt_camera_fx", "Cubic Distortion", max(0, var_27033013 - var_14b2798));
    }

    eye = self getEye();
    fwd = anglesToForward(self getplayerangles());
    trace = physicstrace(eye, eye + fwd * var_e99a5258, var_c5e00469, var_43ac2595, self, 1);
    var_de79cd4c = distance(eye, trace[# "position"] + fwd * var_43ac2595[0]);

    if(var_58cb5a30 < self getclienttime() && abs(var_de79cd4c - var_e17c45e2) < 100) {
      var_e17c45e2 = lerpfloat(var_e17c45e2, var_de79cd4c, 0.5);
      self function_d7be9a9f(var_e17c45e2, 0);
    } else if(var_58cb5a30 < self getclienttime() || abs(var_de79cd4c - var_e17c45e2) >= 100) {
      var_58cb5a30 = self getclienttime() + int(var_b0ea9e6d * 1000);
      var_e17c45e2 = var_de79cd4c;
      self easing::function_b6f1c993(undefined, var_e17c45e2, var_b0ea9e6d, #"back", 0, 1);
    }

    waitframe(1);
  }
}