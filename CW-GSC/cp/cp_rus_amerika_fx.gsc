/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_rus_amerika_fx.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#namespace namespace_f942705d;

function init() {
  level._effect[#"hash_7fa91cf654f23aa0"] = # "hash_6d6d720fe18d9609";
  level._effect[#"hash_5b89c053ca995f2f"] = # "hash_33fdff3e87fa64b4";
  level._effect[#"hash_6d7d7fc52e3d089c"] = # "hash_28d281c14272a9cd";
  level._effect[#"hash_33a7ded5abb15e2b"] = # "hash_309f11c8106ebbc6";
  level._effect[#"hash_5a96efa94d14bb1b"] = # "hash_2968d00b5a3428f1";
  level._effect[#"hash_2689de7e0f62fef7"] = # "hash_67a6f898a474531";
  level._effect[#"hash_6776d1a3fe644a1a"] = # "hash_3eef109ab292c434";
  level._effect[#"hash_1353437066721699"] = # "hash_53e00831c89bcfc5";
  level._effect[#"hash_396a280777c51385"] = # "hash_649722cf7aba77c9";
  level._effect[#"hash_2c6db681efaf0c6b"] = # "hash_3467e5faf9e92e87";
  level._effect[#"hash_3433cf34371352a3"] = # "hash_514eaf7ea4b4e35f";
  level._effect[#"hash_c7555fc4847ded0"] = # "hash_1e99c517397630c";
  level._effect[#"hash_66b948607d788a86"] = # "hash_2db2ddc4dd22eaf7";
  level._effect[#"hash_3dc2bb118ce21336"] = # "hash_28f2e0713c7c421a";
  level._effect[#"hash_3e4b172e1a13831"] = # "hash_742173d8965dbd2d";
  level._effect[#"hash_4bfe81be0f573831"] = # "hash_1d1febc8adca56a2";
  level._effect[#"hash_7e2939ab74146e9c"] = # "hash_2a68807b03ca679e";
  level._effect[#"hash_a767caa536ae153"] = # "hash_65772c671a08a53d";
  level._effect[#"hash_21e18442856e385d"] = # "hash_21673967be33f09f";
  level._effect[#"hash_3a3d33740ee21144"] = # "hash_283ca4f498518c3e";
  level._effect[#"hash_7a068d4f89c57a66"] = # "hash_46f901c092141c78";
  level._effect[#"hash_7a068c4f89c578b3"] = # "hash_46f904c092142191";
  level._effect[#"hash_7a068b4f89c57700"] = # "hash_46f903c092141fde";
  level._effect[#"hash_6443b9e270c9cc88"] = # "hash_84461a8fbb50d12";
  level._effect[#"hash_6443bce270c9d1a1"] = # "hash_84460a8fbb50b5f";
  level._effect[#"hash_6443bbe270c9cfee"] = # "hash_8445fa8fbb509ac";
  level._effect[#"fx9_impact_mannequin_sm"] = # "maps/cp_rus_amerika/fx9_impact_mannequin_sm";
  level._effect[#"hash_5cefba84bf717346"] = # "hash_67616d3d04a146b0";
}

function preload() {
  clientfield::register("scriptmover", "play_coin_fx", 1, 1, "counter");
  clientfield::register("scriptmover", "kill_coin_fx", 1, 1, "counter");
}

function play_coin_fx() {
  self clientfield::increment("play_coin_fx");
}

function kill_coin_fx() {
  self clientfield::increment("kill_coin_fx");
}