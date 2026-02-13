/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\common\base_infil_prompts.gsc
*************************************************/

init_base_infil_prompts() {
  if(!isDefined(level.base_infil_prompts)) {
    level.base_infil_prompts = spawnStruct();
  }
}

create_base_infil_prompts() {
  var_0 = self;

  if(isDefined(var_0.infil_prompt_created) && var_0.infil_prompt_created == 1) {
    return;
  }
  var_1 = spawnStruct();
  var_0 _id_079F::_id_CF62("BaseInfilPrompts", "scripted_widget_base_infil", var_1);
  var_0 _id_079F::scripted_widget_set_position("BaseInfilPrompts", 0, 0, 1, 1);
  var_0.infil_prompt_created = 1;
}

infil_prompts_change_state(var_0) {
  var_1 = self;

  if(!isDefined(var_1.active_infil_prompt_state) || var_0 != var_1.active_infil_prompt_state) {
    _id_079F::_id_CF66("BaseInfilPrompts", var_0);
    var_1.active_infil_prompt_state = var_0;
  }
}