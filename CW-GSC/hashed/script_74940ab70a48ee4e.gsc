/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_74940ab70a48ee4e.gsc
***********************************************/

#using script_35ae72be7b4fec10;
#using scripts\core_common\values_shared;
#using scripts\cp_common\gametypes\globallogic_ui;
#namespace namespace_29a279dd;

function set_display(state, text, desc) {
  getplayers()[0] val::set(#"hash_6420a4a05af52d6e", "show_crosshair", 0);

  if(!namespace_61e6d095::exists(#"hash_767355dc5e1cddfb")) {
    namespace_61e6d095::create(#"hash_767355dc5e1cddfb", #"hash_6420a4a05af52d6e");
  }

  if(isDefined(text)) {
    namespace_61e6d095::set_text(#"hash_767355dc5e1cddfb", text);
  }

  if(isDefined(desc)) {
    namespace_61e6d095::function_bfdab223(#"hash_767355dc5e1cddfb", desc);
  }

  waitframe(1);
  namespace_61e6d095::set_state(#"hash_767355dc5e1cddfb", state);
}

function remove() {
  if(namespace_61e6d095::exists(#"hash_767355dc5e1cddfb")) {
    namespace_61e6d095::remove(#"hash_767355dc5e1cddfb");
  }

  getplayers()[0] val::reset_all();
}