/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_30f76d9e797e166f.gsc
*****************************************************/

#using script_77873e194e406c6d;
#using scripts\common\system;
#using scripts\engine\utility;
#namespace namespace_ab134bde53cb99cb;

function private autoexec __init__system__() {
  system::register(#"hash_eacae4cf72992476", undefined, &function_a5a4ffb3b5b4c0e1, undefined);
}

function private function_a5a4ffb3b5b4c0e1() {
  utility::registersharedfunc(#"hash_61266e374b6a4978", #"hash_2c771489de24ca63", &function_a06c67b188973c68);
  utility::registersharedfunc(#"hash_61266e374b6a4978", #"hash_a9dac899f49dbbe", &function_bcc186cf46d08629);
  utility::registersharedfunc(#"hash_61266e374b6a4978", #"hash_32b413eabeba80ce", &function_90f55f6a60659af9);
  utility::registersharedfunc(#"hash_61266e374b6a4978", #"hash_cfba68776eb6b6d1", &function_2a50aafffcac399);
  utility::registersharedfunc(#"hash_61266e374b6a4978", #"hash_82d433365dffce54", &function_663f16fde692c958);
}

function function_a06c67b188973c68(player) {
  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x24>", @ "hash_ee2680c4a8804012", self, [player], 0);
}

function function_bcc186cf46d08629(player) {
  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x8f>", @ "hash_ee2680c4a8804012", self, [player], 0);
}

function function_90f55f6a60659af9() {}

function private function_2a50aafffcac399(activityinstance) {
  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:xfa>", @ "hash_ee2680c4a8804012", activityinstance, undefined, 3);
}

function private function_663f16fde692c958(activityinstance) {
  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x15c>", @ "hash_ee2680c4a8804012", activityinstance, undefined, 0);
}