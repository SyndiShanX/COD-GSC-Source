/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\dialog_tree.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\easing;
#using scripts\core_common\load_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\util;
#namespace dialog_tree;

function private autoexec __init__system__() {
  system::register("dialog_tree", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("toplayer", "dt_set_fov", 1, 3, "int", &set_fov, 0, 0);
  clientfield::register("toplayer", "dt_set_dof", 1, 3, "int", &set_dof, 0, 0);
  clientfield::register("toplayer", "dt_set_hide_reticle_dot", 1, 1, "int", &function_356192f3, 0, 0);
}

function set_fov(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  n_time = 2;

  switch (bwastimejump) {
    case 1:
      self function_9298adaf(1);
      break;
    case 2:
      self easing::function_f95cb457(undefined, 17, n_time, #"linear");
      break;
    case 3:
      self easing::function_f95cb457(undefined, 20, n_time, #"linear");
      break;
    case 4:
      self easing::function_f95cb457(undefined, 25, n_time, #"linear");
      break;
    case 5:
      self easing::function_f95cb457(undefined, 30, n_time, #"linear");
      break;
  }
}

function private function_356192f3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_baa65467 = function_1df4c3b0(fieldname, #"cp_hud_data");
  var_b3a126ea = getuimodel(var_baa65467, "hideNoReticleDot");

  if(isDefined(var_b3a126ea)) {
    setuimodelvalue(var_b3a126ea, bwastimejump);
  }
}

function set_dof(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  n_time = 2;

  switch (bwastimejump) {
    case 1:
      self function_9e574055(0);
      self function_3c54e2b8(n_time);
      self function_9ea7b4eb(n_time);
      break;
    case 2:
      self function_9e574055(2);
      self function_1816c600(1.5, n_time);
      self function_d7be9a9f(50, n_time);
      break;
    case 3:
      self function_9e574055(2);
      self function_1816c600(1.5, n_time);
      self function_d7be9a9f(90, n_time);
      break;
  }
}