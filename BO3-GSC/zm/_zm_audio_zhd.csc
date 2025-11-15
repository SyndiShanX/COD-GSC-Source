/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_audio_zhd.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\audio_shared;
#using scripts\shared\beam_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace zm_audio_zhd;

function autoexec __init__sytem__() {
  system::register("zm_audio_zhd", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "snd_zhdegg", 21000, 2, "int", & function_97d247be, 0, 0);
  clientfield::register("scriptmover", "snd_zhdegg_arm", 21000, 1, "counter", & function_e312f684, 0, 0);
  level._effect["zhdegg_ballerina_appear"] = "dlc3/stalingrad/fx_main_impact_success";
  level._effect["zhdegg_ballerina_disappear"] = "dlc3/stalingrad/fx_main_impact_success";
  level._effect["zhdegg_arm_appear"] = "dlc3/stalingrad/fx_dirt_hand_burst_challenges";
  level thread setup_personality_character_exerts();
}

function function_97d247be(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(newval == 1) {
      playFX(localclientnum, level._effect["zhdegg_ballerina_appear"], self.origin);
      playSound(0, "zmb_sam_egg_appear", self.origin);
    }
  } else {
    playFX(localclientnum, level._effect["zhdegg_ballerina_disappear"], self.origin);
    playSound(0, "zmb_sam_egg_disappear", self.origin);
  }
}

function function_e312f684(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playFX(localclientnum, level._effect["zhdegg_arm_appear"], self.origin, (0, 0, 1));
  }
}

function setup_personality_character_exerts() {
  util::waitforclient(0);
  level.exert_sounds[1]["meleeswipesoundplayer"][0] = "vox_plr_0_exert_knife_swipe_0";
  level.exert_sounds[1]["meleeswipesoundplayer"][1] = "vox_plr_0_exert_knife_swipe_1";
  level.exert_sounds[1]["meleeswipesoundplayer"][2] = "vox_plr_0_exert_knife_swipe_2";
  level.exert_sounds[1]["meleeswipesoundplayer"][3] = "vox_plr_0_exert_knife_swipe_3";
  level.exert_sounds[1]["meleeswipesoundplayer"][4] = "vox_plr_0_exert_knife_swipe_4";
  level.exert_sounds[2]["meleeswipesoundplayer"][0] = "vox_plr_1_exert_knife_swipe_0";
  level.exert_sounds[2]["meleeswipesoundplayer"][1] = "vox_plr_1_exert_knife_swipe_1";
  level.exert_sounds[2]["meleeswipesoundplayer"][2] = "vox_plr_1_exert_knife_swipe_2";
  level.exert_sounds[2]["meleeswipesoundplayer"][3] = "vox_plr_1_exert_knife_swipe_3";
  level.exert_sounds[2]["meleeswipesoundplayer"][4] = "vox_plr_1_exert_knife_swipe_4";
  level.exert_sounds[3]["meleeswipesoundplayer"][0] = "vox_plr_2_exert_knife_swipe_0";
  level.exert_sounds[3]["meleeswipesoundplayer"][1] = "vox_plr_2_exert_knife_swipe_1";
  level.exert_sounds[3]["meleeswipesoundplayer"][2] = "vox_plr_2_exert_knife_swipe_2";
  level.exert_sounds[3]["meleeswipesoundplayer"][3] = "vox_plr_2_exert_knife_swipe_3";
  level.exert_sounds[3]["meleeswipesoundplayer"][4] = "vox_plr_2_exert_knife_swipe_4";
  level.exert_sounds[4]["meleeswipesoundplayer"][0] = "vox_plr_3_exert_knife_swipe_0";
  level.exert_sounds[4]["meleeswipesoundplayer"][1] = "vox_plr_3_exert_knife_swipe_1";
  level.exert_sounds[4]["meleeswipesoundplayer"][2] = "vox_plr_3_exert_knife_swipe_2";
  level.exert_sounds[4]["meleeswipesoundplayer"][3] = "vox_plr_3_exert_knife_swipe_3";
  level.exert_sounds[4]["meleeswipesoundplayer"][4] = "vox_plr_3_exert_knife_swipe_4";
  level.exert_sounds[1]["playerbreathinsound"][0] = "vox_plr_0_exert_inhale_0";
  level.exert_sounds[2]["playerbreathinsound"][0] = "vox_plr_1_exert_inhale_0";
  level.exert_sounds[3]["playerbreathinsound"][0] = "vox_plr_2_exert_inhale_0";
  level.exert_sounds[4]["playerbreathinsound"][0] = "vox_plr_3_exert_inhale_0";
  level.exert_sounds[1]["playerbreathoutsound"][0] = "vox_plr_0_exert_exhale_0";
  level.exert_sounds[2]["playerbreathoutsound"][0] = "vox_plr_1_exert_exhale_0";
  level.exert_sounds[3]["playerbreathoutsound"][0] = "vox_plr_2_exert_exhale_0";
  level.exert_sounds[4]["playerbreathoutsound"][0] = "vox_plr_3_exert_exhale_0";
  level.exert_sounds[1]["playerbreathgaspsound"][0] = "vox_plr_0_exert_exhale_0";
  level.exert_sounds[2]["playerbreathgaspsound"][0] = "vox_plr_1_exert_exhale_0";
  level.exert_sounds[3]["playerbreathgaspsound"][0] = "vox_plr_2_exert_exhale_0";
  level.exert_sounds[4]["playerbreathgaspsound"][0] = "vox_plr_3_exert_exhale_0";
}