/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_zodt8_narrative.csc
***********************************************/

#include scripts\core_common\audio_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\zm\zm_zodt8_gamemodes;
#include scripts\zm\zm_zodt8_sound;
#include scripts\zm_common\load;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_audio_sq;
#include scripts\zm_common\zm_characters;
#include scripts\zm_common\zm_fasttravel;
#include scripts\zm_common\zm_pack_a_punch;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zodt8_narrative;

init() {
  init_clientfields();
  level thread init_decals();
}

init_decals() {
  wait 0.1;

  if(!zm_utility::is_ee_enabled()) {
    var_c85b91c4 = findvolumedecalindexarray("freerangeanimalcrackers");

    foreach(n_index in var_c85b91c4) {
      hidevolumedecal(n_index);
    }
  }
}

init_clientfields() {
  clientfield::register("scriptmover", "" + #"morse_star", 1, 1, "int", &function_3653f153, 0, 0);
}

function_3653f153(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self util::waittill_dobj(localclientnum);

    while(true) {
      wait 10;
      function_d11e8e8d(localclientnum);
      function_5200214e(localclientnum);
      function_5200214e(localclientnum);
      function_bbf9723b();
      function_d11e8e8d(localclientnum);
      function_d11e8e8d(localclientnum);
      function_d11e8e8d(localclientnum);
      function_d11e8e8d(localclientnum);
      function_bbf9723b();
      function_5200214e(localclientnum);
      function_d11e8e8d(localclientnum);
      function_5200214e(localclientnum);
      function_5200214e(localclientnum);
      function_ca7f5c75();
      function_5200214e(localclientnum);
      function_d11e8e8d(localclientnum);
      function_d11e8e8d(localclientnum);
      function_bbf9723b();
      function_5200214e(localclientnum);
      function_5200214e(localclientnum);
      function_5200214e(localclientnum);
      function_ca7f5c75();
      function_5200214e(localclientnum);
      function_d11e8e8d(localclientnum);
      function_5200214e(localclientnum);
      function_5200214e(localclientnum);
      function_bbf9723b();
      function_5200214e(localclientnum);
      function_5200214e(localclientnum);
      function_5200214e(localclientnum);
      function_bbf9723b();
      function_d11e8e8d(localclientnum);
      function_d11e8e8d(localclientnum);
      function_5200214e(localclientnum);
      function_ca7f5c75();
      function_d11e8e8d(localclientnum);
      function_5200214e(localclientnum);
      function_5200214e(localclientnum);
      function_bbf9723b();
      function_d11e8e8d(localclientnum);
      function_d11e8e8d(localclientnum);
      function_bbf9723b();
      function_d11e8e8d(localclientnum);
      function_d11e8e8d(localclientnum);
      function_d11e8e8d(localclientnum);
      function_bbf9723b();
      function_d11e8e8d(localclientnum);
      function_d11e8e8d(localclientnum);
      function_d11e8e8d(localclientnum);
      function_d11e8e8d(localclientnum);
      function_ca7f5c75();
      function_5200214e(localclientnum);
      function_bbf9723b();
      function_5200214e(localclientnum);
      function_5200214e(localclientnum);
      function_5200214e(localclientnum);
      function_ca7f5c75();
      function_d11e8e8d(localclientnum);
      function_d11e8e8d(localclientnum);
      function_d11e8e8d(localclientnum);
      function_bbf9723b();
      function_d11e8e8d(localclientnum);
      function_5200214e(localclientnum);
      function_bbf9723b();
      function_d11e8e8d(localclientnum);
      function_d11e8e8d(localclientnum);
      function_d11e8e8d(localclientnum);
      function_5200214e(localclientnum);
      function_bbf9723b();
      function_d11e8e8d(localclientnum);
      function_ca7f5c75();
      function_5200214e(localclientnum);
      function_bbf9723b();
      function_d11e8e8d(localclientnum);
      function_d11e8e8d(localclientnum);
      function_d11e8e8d(localclientnum);
      function_d11e8e8d(localclientnum);
      function_bbf9723b();
      function_d11e8e8d(localclientnum);
      function_ca7f5c75();
      function_5200214e(localclientnum);
      function_5200214e(localclientnum);
      function_5200214e(localclientnum);
      function_bbf9723b();
      function_5200214e(localclientnum);
      function_d11e8e8d(localclientnum);
      function_bbf9723b();
      function_d11e8e8d(localclientnum);
      function_ca7f5c75();
      function_d11e8e8d(localclientnum);
      function_5200214e(localclientnum);
      function_5200214e(localclientnum);
      function_bbf9723b();
      function_d11e8e8d(localclientnum);
      function_d11e8e8d(localclientnum);
      function_d11e8e8d(localclientnum);
      function_d11e8e8d(localclientnum);
      function_bbf9723b();
      function_5200214e(localclientnum);
      function_5200214e(localclientnum);
      function_5200214e(localclientnum);
      function_ca7f5c75();
      function_d11e8e8d(localclientnum);
      function_5200214e(localclientnum);
      function_bbf9723b();
      function_5200214e(localclientnum);
      function_d11e8e8d(localclientnum);
      function_d11e8e8d(localclientnum);
      function_d11e8e8d(localclientnum);
      function_bbf9723b();
      function_d11e8e8d(localclientnum);
      function_5200214e(localclientnum);
      function_bbf9723b();
      function_5200214e(localclientnum);
      function_d11e8e8d(localclientnum);
      function_bbf9723b();
      function_5200214e(localclientnum);
      function_d11e8e8d(localclientnum);
      function_d11e8e8d(localclientnum);
      function_bbf9723b();
      function_5200214e(localclientnum);
      function_5200214e(localclientnum);
      function_5200214e(localclientnum);
      function_bbf9723b();
      function_5200214e(localclientnum);
      function_d11e8e8d(localclientnum);
      function_bbf9723b();
      function_d11e8e8d(localclientnum);
      function_bbf9723b();
      function_5200214e(localclientnum);
      function_d11e8e8d(localclientnum);
      function_d11e8e8d(localclientnum);
      function_ca7f5c75();
      function_5200214e(localclientnum);
      function_d11e8e8d(localclientnum);
      function_5200214e(localclientnum);
      function_5200214e(localclientnum);
      function_bbf9723b();
      function_5200214e(localclientnum);
      function_5200214e(localclientnum);
      function_5200214e(localclientnum);
      function_bbf9723b();
      function_d11e8e8d(localclientnum);
      function_d11e8e8d(localclientnum);
      function_5200214e(localclientnum);
    }
  }
}

function_d11e8e8d(localclientnum) {
  var_a4f5395a = util::playFXOnTag(localclientnum, #"hash_431dfa76576eb899", self, "tag_origin");
  wait 0.25;

  if(isDefined(var_a4f5395a)) {
    killfx(localclientnum, var_a4f5395a);
  }

  wait 0.25;
}

function_5200214e(localclientnum) {
  var_a4f5395a = util::playFXOnTag(localclientnum, #"hash_431dfa76576eb899", self, "tag_origin");
  wait 0.75;

  if(isDefined(var_a4f5395a)) {
    killfx(localclientnum, var_a4f5395a);
  }

  wait 0.25;
}

function_bbf9723b() {
  wait 0.5;
}

function_ca7f5c75() {
  wait 1.5;
}