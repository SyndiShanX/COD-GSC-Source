/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_13204033905a2a90.gsc
*************************************************/

#using script_1c8bc690442e0123;
#using script_27af1dac0930f28e;
#using script_2f981f68661d5e1a;
#using script_32d93a194074fa6a;
#using script_35ee5e2cef30eea2;
#using script_3d3a4f9a13038759;
#using script_47a7dd805c87b33f;
#using script_49933f4f48d029a1;
#using script_4a852353eb9522f6;
#using script_4f2ec5e36fe18c11;
#using script_53fe1a91461cecb9;
#using script_54e6d1e4fb728cb8;
#using script_5a37c8d34c31ea89;
#using script_5dfa1fb6b030bdcb;
#using script_6981400abfcd765c;
#using script_781de0ee4cd5153;
#using script_79b958000e312a8;
#using script_89c4e8e66e8a360;
#using script_8cd9c937ed5832c;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#namespace namespace_d02da1a23a283ea1;

function function_b831ccf10a32a4b1() {
  return true;
}

function function_b24a36667938b8d4() {
  setDvar(@ "bg_thirdperson", 1);
  replacestep("reload", "NEW_STEP_EXAMPLE", &newstepexample);
}

function newstepexample() {}