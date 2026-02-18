/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\killstreak_bundles.csc
***********************************************/

#using script_4daa124bc391e7ed;
#using scripts\core_common\renderoverridebundle;
#using scripts\killstreaks\killstreak_detect;
#namespace killstreak_bundles;

function spawned(local_client_num, bundle) {
  self.var_22a05c26 = bundle;

  if(isDefined(bundle.var_7249d50f) && bundle.var_7249d50f > 0) {
    self enablevisioncircle(local_client_num, bundle.var_7249d50f);
  }

  if(bundle.var_101cf227 === 1) {
    self enableonradar();
  }

  if(bundle.var_101cf227 === 1) {
    self enableonradar();
  }

  if(bundle.var_bea37bdc === 1) {
    self namespace_9bcd7d72::function_bdda909b();
  }

  killstreak_detect::function_8ac48939(bundle);
}

function function_48e9536e() {
  return self.var_22a05c26;
}