/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\killstreak_bundles.csc
***********************************************/

#include script_4daa124bc391e7ed;
#include scripts\core_common\renderoverridebundle;
#include scripts\killstreaks\killstreak_detect;

#namespace killstreak_bundles;

spawned(local_client_num, bundle) {
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
  renderoverridebundle::function_c8d97b8e(local_client_num, #"friendly", #"hash_ebb37dab2ee0ae3");
}

function_48e9536e() {
  return self.var_22a05c26;
}