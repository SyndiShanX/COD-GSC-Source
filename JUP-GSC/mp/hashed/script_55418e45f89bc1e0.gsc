/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_55418e45f89bc1e0.gsc
*************************************************/

#using scripts\asm\asm;
#using scripts\asm\shared\variant_asm;
#using scripts\common\callbacks;
#using scripts\engine\utility;
#namespace namespace_ae9d35285f2a2d94;

function function_a40873f83b05ce3c() {
  callback::function_e7fddda1f0b46b5e(self.animsetname) callback::add("on_is_crawling_changed", &function_a74672983ef7a645);
}

function private function_a74672983ef7a645(params) {
  asm_fireevent_internal(self.asmname, "loop_reroll_anim");
}