/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_56dfbea82c9ec655.gsc
*************************************************/

#using script_2b4b90647dc1d53d;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\utility\trigger;
#namespace active_env;

function function_ad6fde6a4dc38d62() {
  level waittill("prematch_done");
  var_72bf294870823f91 = getEntArray("active_env", "script_noteworthy");

  foreach(var_4c561d08d8d8ace4 in var_72bf294870823f91) {
    switch (var_4c561d08d8d8ace4.targetname) {
      case #"hash_f6ab701adbab8ee":
        var_4c561d08d8d8ace4.var_684fe18b13b38981 = 1.1;
        var_4c561d08d8d8ace4 thread diving_board();
        break;
      case #"hash_b53ae7f76fa3f3ed":
        var_4c561d08d8d8ace4 thread namespace_91faf49cc72f0b47::function_b8554b5efa2488b0();
        break;
      case #"hash_badd0faf7f7ec594":
        var_4c561d08d8d8ace4 thread firing_range_target();
        break;
      default:
        break;
    }
  }

  var_cf52733448177501 = utility::getStructArray("active_env", "script_noteworthy");

  foreach(var_3c481c9f5e43f814 in var_cf52733448177501) {
    switch (var_3c481c9f5e43f814.targetname) {
      case #"hash_badd0faf7f7ec594":
        var_3c481c9f5e43f814 thread function_9b6351833e5d2963();
        break;
      default:
        break;
    }
  }
}

function diving_board() {
  trigger::makeenterexittrigger(self, &function_d6276ad6a106ac3e, &diving_board_exit);
}

function private function_d6276ad6a106ac3e(e_player, trigger) {
  if(isPlayer(e_player) && isalive(e_player)) {
    e_player endon("diving_board_exited");
    e_player = e_player;
    e_player notifyonplayercommand("jump_pressed", "+gostand");
    e_player waittill("jump_pressed");
    v_up = (0, 0, 1);
    var_f845285c1c76f152 = e_player getvelocity();
    var_5fb47c0f02734380 = var_f845285c1c76f152 + var_f845285c1c76f152 * v_up * trigger.var_684fe18b13b38981;
    e_player setvelocity(var_5fb47c0f02734380);

    if(level.mapname == "mp_t10_pillage") {
      self playSound("emt_diving_board");
    }
  }
}

function private diving_board_exit(e_player, trigger) {
  if(isPlayer(e_player) && isalive(e_player)) {
    e_player notify("diving_board_exited");
  }
}

function function_9b6351833e5d2963() {
  if(!isDefined(level.var_d28fd03de3f84687) || isDefined(level.var_d28fd03de3f84687) && !level.var_d28fd03de3f84687) {
    return;
  }

  s_dest = utility::getStruct(self.target, "targetname");
  var_320a24896ff148ea = spawn("script_model", self.origin);
  var_320a24896ff148ea.angles = self.angles;

  if(isDefined(s_dest)) {}
}

function private firing_range_target(s_dest, var_24ad452813ef0b6f) {
  v_move_dir = vectorNormalize(s_dest.origin - self.origin);
  var_7856bbc39a600358 = 0;
  n_move_time = 3;

  if(!isDefined(s_dest)) {
    return;
  }

  var_7856bbc39a600358 = distance(self.origin, s_dest.origin);

  if(isDefined(s_dest.script_parameters)) {
    n_move_time = float(s_dest.script_parameters);
  }

  for(var_6621a39da07e6c42 = var_24ad452813ef0b6f getscriptablepartstate("pelvis", 1); isDefined(var_6621a39da07e6c42) && var_6621a39da07e6c42 == "visible"; var_6621a39da07e6c42 = var_24ad452813ef0b6f getscriptablepartstate("pelvis", 1)) {
    self moveTo(self.origin + v_move_dir * var_7856bbc39a600358, n_move_time, 0, 0);
    wait n_move_time;
    self moveTo(self.origin + v_move_dir * var_7856bbc39a600358 * -1, n_move_time, 0, 0);
    wait n_move_time;
  }
}