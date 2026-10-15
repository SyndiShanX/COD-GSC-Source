/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_74940ab70a48ee4e.gsc
***********************************************/

#using script_35ae72be7b4fec10;
#using scripts\core_common\values_shared;
#using scripts\cp_common\gametypes\globallogic_ui;

#namespace namespace_29a279dd;

function set_display(state, text, desc) {
  getPlayers()[0] val::set(#"hash_6420a4a05af52d6e", "show_crosshair", 0);

  if(!scripted_widgets::exists(#"hash_767355dc5e1cddfb")) {
    scripted_widgets::create(#"hash_767355dc5e1cddfb", #"hash_6420a4a05af52d6e");
  }

  if(isDefined(text)) {
    scripted_widgets::set_text(#"hash_767355dc5e1cddfb", text);
  }

  if(isDefined(desc)) {
    scripted_widgets::function_bfdab223(#"hash_767355dc5e1cddfb", desc);
  }

  waitframe(1);
  scripted_widgets::set_state(#"hash_767355dc5e1cddfb", state);
}

function remove() {
  if(scripted_widgets::exists(#"hash_767355dc5e1cddfb")) {
    scripted_widgets::remove(#"hash_767355dc5e1cddfb");
  }

  getPlayers()[0] val::reset_all();
}