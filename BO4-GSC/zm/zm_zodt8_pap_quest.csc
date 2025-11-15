/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_zodt8_pap_quest.csc
***********************************************/

#include script_54a67b7ed7b385e6;
#include scripts\core_common\audio_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\zm\weapons\zm_weap_riotshield;
#include scripts\zm\zm_zodt8_eye;
#include scripts\zm\zm_zodt8_gamemodes;
#include scripts\zm\zm_zodt8_sentinel_trial;
#include scripts\zm\zm_zodt8_side_quests;
#include scripts\zm\zm_zodt8_sound;
#include scripts\zm\zm_zodt8_tutorial;
#include scripts\zm_common\load;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_audio_sq;
#include scripts\zm_common\zm_characters;
#include scripts\zm_common\zm_fasttravel;
#include scripts\zm_common\zm_pack_a_punch;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zodt8_pap_quest;

init() {
  level._effect[#"hash_711cbb6b36694a2a"] = #"hash_76b535da68eacfe5";
  level._effect[#"hash_2ad6c6017f084d7a"] = #"hash_4e58e9dad90ada6d";
  level._effect[#"hash_23bb6df1e8d8a032"] = #"hash_4f8332385445d967";
  level._effect[#"hash_14d2dc2c31e6dab9"] = #"hash_37e114058b86991a";
  level._effect[#"hash_79b06b6af34ac1ab"] = #"hash_1e30126e06b4956";
  clientfield::register("zbarrier", "pap_chunk_small_rune", 1, getminbitcountfornum(16), "int", &pap_chunk_small_rune, 0, 0);
  clientfield::register("zbarrier", "pap_chunk_big_rune", 1, getminbitcountfornum(5), "int", &pap_chunk_big_rune, 0, 0);
  clientfield::register("zbarrier", "pap_machine_rune", 1, getminbitcountfornum(5), "int", &pap_machine_rune, 0, 0);
}

pap_chunk_big_rune(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.var_86adf17d)) {
    self.var_86adf17d = [];
  }

  var_d7b20a11 = self zbarriergetpiece(0);
  v_forward = anglestoright(self.angles);
  var_d7b20a11 hidepart(localclientnum, "j_map_rune_loc_001");
  var_d7b20a11 hidepart(localclientnum, "j_map_rune_loc_003");
  var_d7b20a11 hidepart(localclientnum, "j_map_rune_loc_002");
  var_d7b20a11 hidepart(localclientnum, "j_map_rune_loc_004");

  switch (newval) {
    case 2:
      self.var_86adf17d[localclientnum] = playFX(localclientnum, level._effect[#"hash_711cbb6b36694a2a"], self.origin, v_forward);
      audio::playloopat("zmb_pap_plinth_symbol_lp", self.origin + (0, 0, 70));
      break;
    case 3:
      self.var_86adf17d[localclientnum] = playFX(localclientnum, level._effect[#"hash_2ad6c6017f084d7a"], self.origin, v_forward);
      audio::playloopat("zmb_pap_plinth_symbol_lp", self.origin + (0, 0, 70));
      break;
    case 4:
      self.var_86adf17d[localclientnum] = playFX(localclientnum, level._effect[#"hash_23bb6df1e8d8a032"], self.origin, v_forward);
      audio::playloopat("zmb_pap_plinth_symbol_lp", self.origin + (0, 0, 70));
      break;
    case 5:
      self.var_86adf17d[localclientnum] = playFX(localclientnum, level._effect[#"hash_14d2dc2c31e6dab9"], self.origin, v_forward);
      audio::playloopat("zmb_pap_plinth_symbol_lp", self.origin + (0, 0, 70));
      break;
    case 1:
      audio::stoploopat("zmb_pap_plinth_symbol_lp", self.origin + (0, 0, 70));

      if(isDefined(self.var_86adf17d[localclientnum])) {
        killfx(localclientnum, self.var_86adf17d[localclientnum]);
        self.var_86adf17d[localclientnum] = undefined;
        playFX(localclientnum, level._effect[#"hash_79b06b6af34ac1ab"], self.origin, v_forward);
      }

      break;
  }
}

pap_chunk_small_rune(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_d7b20a11 = self zbarriergetpiece(0);
  sndorigin = var_d7b20a11 gettagorigin("j_map_rune_003");

  switch (newval) {
    case 1:
      var_d7b20a11 function_a2c01e49(localclientnum, 0, 1);
      var_d7b20a11 function_a2c01e49(localclientnum, 1, 1);
      var_d7b20a11 function_a2c01e49(localclientnum, 2, 1);
      var_d7b20a11 function_a2c01e49(localclientnum, 3, 1);
      playSound(localclientnum, #"hash_3e22cef1a7b16893", var_d7b20a11 gettagorigin("j_map_rune_004"));
      break;
    case 2:
      var_d7b20a11 function_a2c01e49(localclientnum, 0, 0);
      var_d7b20a11 function_a2c01e49(localclientnum, 1, 1);
      var_d7b20a11 function_a2c01e49(localclientnum, 2, 1);
      var_d7b20a11 function_a2c01e49(localclientnum, 3, 1);
      break;
    case 3:
      var_d7b20a11 function_a2c01e49(localclientnum, 0, 0);
      var_d7b20a11 function_a2c01e49(localclientnum, 1, 0);
      var_d7b20a11 function_a2c01e49(localclientnum, 2, 1);
      var_d7b20a11 function_a2c01e49(localclientnum, 3, 1);
      break;
    case 4:
      var_d7b20a11 function_a2c01e49(localclientnum, 0, 0);
      var_d7b20a11 function_a2c01e49(localclientnum, 1, 0);
      var_d7b20a11 function_a2c01e49(localclientnum, 2, 0);
      var_d7b20a11 function_a2c01e49(localclientnum, 3, 1);
      break;
    case 5:
      var_d7b20a11 function_a2c01e49(localclientnum, 0, 0);
      var_d7b20a11 function_a2c01e49(localclientnum, 1, 0);
      var_d7b20a11 function_a2c01e49(localclientnum, 2, 1);
      var_d7b20a11 function_a2c01e49(localclientnum, 3, 0);
      break;
    case 6:
      var_d7b20a11 function_a2c01e49(localclientnum, 0, 0);
      var_d7b20a11 function_a2c01e49(localclientnum, 1, 1);
      var_d7b20a11 function_a2c01e49(localclientnum, 2, 0);
      var_d7b20a11 function_a2c01e49(localclientnum, 3, 1);
      break;
    case 7:
      var_d7b20a11 function_a2c01e49(localclientnum, 0, 0);
      var_d7b20a11 function_a2c01e49(localclientnum, 1, 1);
      var_d7b20a11 function_a2c01e49(localclientnum, 2, 0);
      var_d7b20a11 function_a2c01e49(localclientnum, 3, 0);
      break;
    case 8:
      var_d7b20a11 function_a2c01e49(localclientnum, 0, 0);
      var_d7b20a11 function_a2c01e49(localclientnum, 1, 1);
      var_d7b20a11 function_a2c01e49(localclientnum, 2, 1);
      var_d7b20a11 function_a2c01e49(localclientnum, 3, 0);
      break;
    case 9:
      var_d7b20a11 function_a2c01e49(localclientnum, 0, 1);
      var_d7b20a11 function_a2c01e49(localclientnum, 1, 0);
      var_d7b20a11 function_a2c01e49(localclientnum, 2, 1);
      var_d7b20a11 function_a2c01e49(localclientnum, 3, 1);
      break;
    case 10:
      var_d7b20a11 function_a2c01e49(localclientnum, 0, 1);
      var_d7b20a11 function_a2c01e49(localclientnum, 1, 0);
      var_d7b20a11 function_a2c01e49(localclientnum, 2, 0);
      var_d7b20a11 function_a2c01e49(localclientnum, 3, 1);
      break;
    case 11:
      var_d7b20a11 function_a2c01e49(localclientnum, 0, 1);
      var_d7b20a11 function_a2c01e49(localclientnum, 1, 0);
      var_d7b20a11 function_a2c01e49(localclientnum, 2, 0);
      var_d7b20a11 function_a2c01e49(localclientnum, 3, 0);
      break;
    case 12:
      var_d7b20a11 function_a2c01e49(localclientnum, 0, 1);
      var_d7b20a11 function_a2c01e49(localclientnum, 1, 0);
      var_d7b20a11 function_a2c01e49(localclientnum, 2, 1);
      var_d7b20a11 function_a2c01e49(localclientnum, 3, 0);
      break;
    case 13:
      var_d7b20a11 function_a2c01e49(localclientnum, 0, 1);
      var_d7b20a11 function_a2c01e49(localclientnum, 1, 1);
      var_d7b20a11 function_a2c01e49(localclientnum, 2, 0);
      var_d7b20a11 function_a2c01e49(localclientnum, 3, 1);
      break;
    case 14:
      var_d7b20a11 function_a2c01e49(localclientnum, 0, 1);
      var_d7b20a11 function_a2c01e49(localclientnum, 1, 1);
      var_d7b20a11 function_a2c01e49(localclientnum, 2, 0);
      var_d7b20a11 function_a2c01e49(localclientnum, 3, 0);
      break;
    case 15:
      var_d7b20a11 function_a2c01e49(localclientnum, 0, 1);
      var_d7b20a11 function_a2c01e49(localclientnum, 1, 1);
      var_d7b20a11 function_a2c01e49(localclientnum, 2, 1);
      var_d7b20a11 function_a2c01e49(localclientnum, 3, 0);
      break;
    case 16:
      var_d7b20a11 function_a2c01e49(localclientnum, 0, 0);
      var_d7b20a11 function_a2c01e49(localclientnum, 1, 0);
      var_d7b20a11 function_a2c01e49(localclientnum, 2, 0);
      var_d7b20a11 function_a2c01e49(localclientnum, 3, 0);
      break;
  }

  if(newval != 1) {
    playSound(localclientnum, #"hash_291ff1a1ce5cc02f", sndorigin);
  }
}

function_a2c01e49(localclientnum, var_705d414e, n_state) {
  switch (var_705d414e) {
    case 0:
      var_73df2d96 = "j_map_rune_003";
      var_f9d2e2e2 = "j_map_rune_off_003";
      break;
    case 1:
      var_73df2d96 = "j_map_rune_004";
      var_f9d2e2e2 = "j_map_rune_off_004";
      break;
    case 2:
      var_73df2d96 = "j_map_rune_001";
      var_f9d2e2e2 = "j_map_rune_off_001";
      break;
    case 3:
      var_73df2d96 = "j_map_rune_002";
      var_f9d2e2e2 = "j_map_rune_off_002";
      break;
  }

  switch (n_state) {
    case 0:
      self showpart(localclientnum, var_73df2d96);
      self hidepart(localclientnum, var_f9d2e2e2);
      break;
    case 1:
      self hidepart(localclientnum, var_73df2d96);
      self showpart(localclientnum, var_f9d2e2e2);
      break;
  }
}

pap_machine_rune(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_d7b20a11 = self zbarriergetpiece(4);

  switch (newval) {
    case 1:
      var_d7b20a11 function_c976f028(localclientnum, 0, 2);
      var_d7b20a11 function_c976f028(localclientnum, 1, 2);
      var_d7b20a11 function_c976f028(localclientnum, 2, 2);
      var_d7b20a11 function_c976f028(localclientnum, 3, 2);
      break;
    case 2:
      var_d7b20a11 function_c976f028(localclientnum, 0, 0);
      var_d7b20a11 function_c976f028(localclientnum, 1, 1);
      var_d7b20a11 function_c976f028(localclientnum, 2, 1);
      var_d7b20a11 function_c976f028(localclientnum, 3, 1);
      break;
    case 3:
      var_d7b20a11 function_c976f028(localclientnum, 0, 1);
      var_d7b20a11 function_c976f028(localclientnum, 1, 0);
      var_d7b20a11 function_c976f028(localclientnum, 2, 1);
      var_d7b20a11 function_c976f028(localclientnum, 3, 1);
      break;
    case 4:
      var_d7b20a11 function_c976f028(localclientnum, 0, 1);
      var_d7b20a11 function_c976f028(localclientnum, 1, 1);
      var_d7b20a11 function_c976f028(localclientnum, 2, 0);
      var_d7b20a11 function_c976f028(localclientnum, 3, 1);
      break;
    case 5:
      var_d7b20a11 function_c976f028(localclientnum, 0, 1);
      var_d7b20a11 function_c976f028(localclientnum, 1, 1);
      var_d7b20a11 function_c976f028(localclientnum, 2, 1);
      var_d7b20a11 function_c976f028(localclientnum, 3, 0);
      break;
  }
}

function_c976f028(localclientnum, var_705d414e, n_state) {
  switch (var_705d414e) {
    case 0:
      var_73df2d96 = "j_machine_rune_003";
      var_f9d2e2e2 = "j_machine_rune_off_003";
      break;
    case 1:
      var_73df2d96 = "j_machine_rune_004";
      var_f9d2e2e2 = "j_machine_rune_off_004";
      break;
    case 2:
      var_73df2d96 = "j_machine_rune_001";
      var_f9d2e2e2 = "j_machine_rune_off_001";
      break;
    case 3:
      var_73df2d96 = "j_machine_rune_002";
      var_f9d2e2e2 = "j_machine_rune_off_002";
      break;
  }

  switch (n_state) {
    case 0:
      self showpart(localclientnum, var_73df2d96);
      self hidepart(localclientnum, var_f9d2e2e2);
      break;
    case 1:
      self hidepart(localclientnum, var_73df2d96);
      self showpart(localclientnum, var_f9d2e2e2);
      break;
    case 2:
      self hidepart(localclientnum, var_73df2d96);
      self hidepart(localclientnum, var_f9d2e2e2);
      break;
  }
}