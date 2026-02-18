/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\note_display.gsc
***********************************************/

#using script_13114d8a31c6152a;
#using script_35ae72be7b4fec10;
#using script_4937c6974f43bb71;
#using scripts\core_common\values_shared;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\ui\prompts;
#namespace note_display;

function function_97c69304(var_e1ab1198, var_ad825676 = 1, var_4d757ace = 2, var_34c6a562 = # "hash_7cf7750cf3228d3f", var_5d0591d = # "hash_5f8dea2ec57cdca9", var_ec9a3f05 = 0) {
  if(!namespace_61e6d095::exists(#"note_display")) {
    namespace_61e6d095::create(#"note_display", #"hash_3ddadc19cc3c44ad");
  }

  self val::set(#"note_display", "show_crosshair", 0);
  self val::set(#"note_display", "freezecontrols_allowlook", 1);
  self val::set(#"note_display", "disable_weapon_cycling", 1);

  if(var_ad825676) {
    prompts::function_86eedc();
  }

  var_6fdd3a3a = getscriptbundle(var_e1ab1198);
  assert(isDefined(var_6fdd3a3a), "<dev string:x38>" + var_e1ab1198);
  len = var_6fdd3a3a.var_df2d0a90.size;
  namespace_61e6d095::function_9ade1d9b(#"note_display", "priority", 1);
  namespace_61e6d095::set_state(#"note_display", var_ec9a3f05);
  line_num = 0;

  for(i = line_num; i < len; i++) {
    line_num = i + 1;
    var_c1deb575 = var_6fdd3a3a.var_df2d0a90[i];
    namespace_61e6d095::function_f2a9266(#"note_display", line_num, "index", i);
    namespace_61e6d095::function_f2a9266(#"note_display", line_num, "translate", -1);
    namespace_61e6d095::function_f2a9266(#"note_display", line_num, "text_untranslated", var_c1deb575.var_f49bdf40);
    namespace_61e6d095::function_f2a9266(#"note_display", line_num, "text_translated", var_c1deb575.var_c9d25687);
  }

  namespace_82bfe441::fade(1, "FadeImmediate");
  namespace_61e6d095::function_9ade1d9b(#"note_display", "image", var_6fdd3a3a.var_85ca818b);
  self playSound(var_34c6a562);
  wait var_4d757ace;
  self thread function_50f1b098(len);
  namespace_c8e236da::function_ebf737f8(#"hash_1aefb4de625039be");
  self thread function_f432e1fd(var_5d0591d);
}

function private function_50f1b098(num_lines) {
  self endon(#"note_display_closed");
  linenum = 0;

  for(i = linenum; i < num_lines; i++) {
    linenum = i + 1;
    namespace_61e6d095::function_f2a9266(#"note_display", linenum, "translate", 1);
  }
}

function private function_f432e1fd(var_5d0591d) {
  self endon(#"note_display_closed");
  self namespace_61e6d095::function_b0bad5ff("note_display_closed", undefined, 1);
  function_62296e85(var_5d0591d);
}

function function_62296e85(var_5d0591d) {
  self playSound(var_5d0591d);
  prompts::function_d675f5a4();
  namespace_c8e236da::removelist();
  namespace_61e6d095::function_9ade1d9b(#"note_display", "priority", 0);

  if(namespace_61e6d095::exists(#"note_display")) {
    namespace_61e6d095::remove(#"note_display");
  }

  namespace_82bfe441::fade(0, "FadeImmediate");
  val::reset_all(#"note_display");
  self showcrosshair(1);
  self notify(#"note_display_closed");
}