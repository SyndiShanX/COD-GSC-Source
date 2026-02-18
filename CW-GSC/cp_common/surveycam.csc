/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\surveycam.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace surveycam;

function private autoexec __init__system__() {
  system::register(#"surveycam", &_preload, undefined, undefined, undefined);
}

function private _preload() {
  function_bc948200();
}

function function_bc948200() {
  clientfield::register("toplayer", "surveycam_state", 1, 1, "int", &function_52917166, 0, 0);
  clientfield::register("toplayer", "surveycam_min_focal_length", 1, 6, "int", undefined, 0, 0);
  clientfield::register("toplayer", "surveycam_max_focal_length", 1, 6, "int", undefined, 0, 0);
}

function private function_52917166(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    if(self postfx::function_556665f2("pstfx_t9_cp_surveycam")) {
      self postfx::stoppostfxbundle("pstfx_t9_cp_surveycam");
    }

    self postfx::playpostfxbundle("pstfx_t9_cp_surveycam");
    function_32cdd3ef();
    return;
  }

  if(self postfx::function_556665f2("pstfx_t9_cp_surveycam")) {
    self postfx::stoppostfxbundle("pstfx_t9_cp_surveycam");
  }

  self notify(#"survey_equipment_completed");
}

function private function_80847fa6() {
  return getuimodel(function_5c2e399f(), "ScriptedWidgetData.widgetModels." + # "hash_71351bf35e6d6353");
}

function private function_32cdd3ef() {
  self endon(#"survey_equipment_completed", #"death");

  while(true) {
    rootmodel = function_80847fa6();

    if(isDefined(rootmodel)) {
      var_80281af = getuimodel(rootmodel, "pitch");
      var_f9349c37 = getuimodel(rootmodel, "yaw");
      var_24d6df4b = getuimodel(rootmodel, "zoom");
      v_angles = self getplayerangles();
      n_pitch = v_angles[0];
      n_yaw = v_angles[1];
      zoom = 1;
      var_cbcfc238 = self function_82f1cbd2();
      var_11f00a95 = clientfield::get_to_player("surveycam_min_focal_length");
      var_8dd70933 = clientfield::get_to_player("surveycam_max_focal_length");

      if(var_11f00a95 > 0 && var_8dd70933 > 0 && var_11f00a95 != var_8dd70933) {
        var_85dc940 = var_8dd70933 / var_11f00a95;
        var_73024e3b = (var_cbcfc238 - var_11f00a95) / (var_8dd70933 - var_11f00a95);

        if(var_73024e3b < 0) {
          var_73024e3b = 0;
        } else if(var_73024e3b > 1) {
          var_73024e3b = 1;
        }

        zoom = (var_85dc940 - 1) * var_73024e3b + 1;
      }

      if(isDefined(var_80281af)) {
        setuimodelvalue(var_80281af, n_pitch);
      }

      if(isDefined(var_f9349c37)) {
        setuimodelvalue(var_f9349c37, n_yaw);
      }

      if(isDefined(var_24d6df4b)) {
        setuimodelvalue(var_24d6df4b, zoom);
      }
    }

    waitframe(1);
  }
}