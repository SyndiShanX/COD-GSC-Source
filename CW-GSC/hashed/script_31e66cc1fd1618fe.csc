/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_31e66cc1fd1618fe.csc
***********************************************/

#using script_140d5347de8af85c;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\easing;
#using scripts\core_common\system_shared;
#namespace action_utility;

function private autoexec __init__system__() {
  system::register(#"action_utility", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("scriptmover", "link_to_camera", 1, 2, "int", &link_to_camera, 0, 0);
  clientfield::register("actor", "link_to_camera", 1, 2, "int", &link_to_camera, 0, 0);
  clientfield::register("toplayer", "fake_ads", 1, 1, "int", &fake_ads, 0, 0);
}

function private link_to_camera(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  player = function_5c10bd79(binitialsnap);

  if(bwastimejump) {
    self thread function_bd9c7275(fieldname, bwastimejump);
    return;
  }

  self notify(#"hash_97425a408a077df");
  self function_a052b638();
}

function private fake_ads(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify("2e682ee9f9b29c84");
  self endon("2e682ee9f9b29c84");

  if(bwastimejump && bwastimejump != fieldname) {
    self easing::function_f95cb457(undefined, 20.64, 0.2, #"sine");
    return;
  }

  if(!bwastimejump && bwastimejump != fieldname) {
    self easing::function_f95cb457(undefined, 14.64, 0.2, #"sine");

    while(true) {
      result = self waittill(#"ease_done");

      if(result.target_value === 14.64) {
        self function_9298adaf(binitialsnap);
        break;
      }
    }
  }
}

function private function_bd9c7275(oldtype, newtype) {
  self notify(#"hash_97425a408a077df");
  self endon(#"hash_97425a408a077df");

  if(is_true(oldtype) && is_true(newtype) && oldtype != newtype) {
    self function_a052b638();
  }

  if((isDefined(newtype) ? newtype : 1) == 2) {
    self linktocamera(4, (0, 0, 0));
  } else {
    self linktocamera(4, (0, 0, -60));
  }

  self waittill(#"death", #"entitydeleted");
  self function_a052b638();
}