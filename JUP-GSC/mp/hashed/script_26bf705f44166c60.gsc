/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_26bf705f44166c60.gsc
*************************************************/

#using script_405d05c89e998922;
#using scripts\common\callbacks;
#namespace namespace_960978fc5a7ce390;

function function_a8d762b7f47cf728() {
  callback::get_template(self.animsetname) callback::add("on_is_crawling_changed", &function_3ba2fe8330d232b5);
}

function init_traverse() {
  self.var_db44b0ed0f52e2b = [];
  self.var_db44b0ed0f52e2b["is_crawling"] = namespace_9e6ef02d993a7eba::is_crawling();
}

function private function_3ba2fe8330d232b5(params) {
  self.var_db44b0ed0f52e2b["is_crawling"] = int(namespace_9e6ef02d993a7eba::is_crawling());
}