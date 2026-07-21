/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_disguise.gsc
***********************************************/

create_state_machine_for_ai(var_0, var_1) {
  var_0.i_current_state = 0;
  var_0.i_previous_state = 69;

  if(istrue(var_1))
    var_0 thread run_scripted_state_machine_nonarc();
  else
    var_0 thread run_scripted_state_machine();
}

run_scripted_anim(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_1)) {}

  if(istrue(var_3)) {
    if(istrue(var_4)) {}

    if(istrue(var_5)) {}

    if(istrue(var_6)) {}
  } else if(istrue(var_4)) {
    if(istrue(var_3)) {}

    if(istrue(var_5)) {}

    if(istrue(var_6)) {}
  } else if(istrue(var_5)) {
    if(istrue(var_3)) {}

    if(istrue(var_4)) {}

    if(istrue(var_6)) {}
  } else if(istrue(var_6)) {
    if(istrue(var_3)) {}

    if(istrue(var_4)) {}

    if(istrue(var_5)) {}
  }

  var_7 = spawnStruct();
  var_7.animalias = var_0;
  var_7.early_return = var_1;
  var_7.looped = var_2;
  var_8 = 69;

  if(istrue(var_3))
    var_8 = 3;
  else if(istrue(var_4))
    var_8 = 2;
  else if(istrue(var_5))
    var_8 = 1;
  else if(istrue(var_6))
    var_8 = 0;

  self notify("_encstr_BDB80D30AA76EDD9AF1FFE7539B3C1", var_8, var_7);
}

run_scripted_state_machine() {
  for(;;) {
    self waittill("_encstr_BDB80D30AA76EDD9AF1FFE7539B3C1", var_0, var_1);
    var_2 = var_1.animalias;
    var_3 = var_1.early_return;
    var_4 = var_1.looped;

    if(self.i_current_state == var_0 && var_0 != 0) {
      continue;
    }
    self.i_previous_state = self.i_current_state;
    self.i_current_state = var_0;

    switch (var_0) {
      case 0:
        thread run_ai_anim(var_2);
        break;
      case 1:
        thread run_ai_anim(var_2);
        break;
      case 2:
        thread run_ai_anim(var_2);
        break;
      case 3:
        run_ai_anim(var_2);
        break;
    }
  }
}

run_scripted_state_machine_nonarc() {
  for(;;) {
    self waittill("_encstr_BDB80D30AA76EDD9AF1FFE7539B3C1", var_0, var_1);
    var_2 = var_1.animalias;
    var_3 = var_1.early_return;
    var_4 = var_1.looped;

    if(self.i_current_state == var_0 && var_0 != 0) {
      continue;
    }
    self.i_previous_state = self.i_current_state;
    self.i_current_state = var_0;

    switch (var_0) {
      case 0:
        thread run_ai_anim_nonarc(var_2);
        break;
      case 1:
        thread run_ai_anim_nonarc(var_2);
        break;
      case 2:
        thread run_ai_anim_nonarc(var_2);
        break;
      case 3:
        run_ai_anim_nonarc(var_2);
        break;
    }
  }
}

run_ai_anim_nonarc(var_0, var_1, var_2) {
  if(isDefined(var_1)) {}

  if(var_0 == "_encstr_B40101") {
    return;
  }
  if(!istrue(var_2)) {
    return;
  }
  return;
}

run_ai_anim(var_0, var_1, var_2) {
  if(isDefined(var_1)) {}

  if(var_0 == "_encstr_B40101") {
    return;
  }
  if(!istrue(var_2)) {
    if(isDefined(var_1))
      scripts\asm\shared\mp\utility::burningdown(var_0, var_1);
    else
      scripts\asm\shared\mp\utility::burndowntime(var_0);
  } else {
    self endon("_encstr_BDB80D30AA76EDD9AF1FFE7539B3C1");

    if(isDefined(var_1))
      scripts\asm\shared\mp\utility::bunkermusicstarted(var_0, var_1);
    else
      scripts\asm\shared\mp\utility::bunkerinteriorkeypads(var_0);
  }
}

clear_scripted_anim() {
  self.allowpain = 1;
  scripts\asm\shared\mp\utility::bunkercounteruav();
  self unlink();

  if(isDefined(self.scripted_anim_settings))
    self[[self.scripted_anim_settings]]();

  if(isDefined(self.anchor))
    self.anchor delete();
}

break_out_of_disguise_loop() {
  self notify("_encstr_A7E61B90F0D83F4220FD2F01C8805867C5A77E980DF82E3F8FA035D220");
  self endon("_encstr_A7E61B90F0D83F4220FD2F01C8805867C5A77E980DF82E3F8FA035D220");
  self endon("_encstr_A66422943B90AF2B4DEE4A827394E764D093370C5908F747E583F1EAF8E0AB9DA8338572");
  self notifyonplayercommand("_encstr_AD1904291F7B", "_encstr_97120D65B983599519EB1D86C9B7EE");
  self notifyonplayercommand("_encstr_88780599B4E495", "_encstr_A9E60828803C73F11780");
  self notifyonplayercommand("_encstr_B116071BCAD186858D", "_encstr_9B0D065699E485D9");
  self notifyonplayercommand("_encstr_99C209E34FC743616118AB", "_encstr_8E5F0795E6AD7BAD2B");
  self.fired_commands = [];
  add_command_to_action_tracker("_encstr_AD1904291F7B");
  add_command_to_action_tracker("_encstr_88780599B4E495");
  add_command_to_action_tracker("_encstr_B116071BCAD186858D");
  add_command_to_action_tracker("_encstr_99C209E34FC743616118AB");

  for(;;) {
    var_0 = scripts\engine\utility::_id_143AF("_encstr_AD1904291F7B", "_encstr_88780599B4E495", "_encstr_B116071BCAD186858D", "_encstr_99C209E34FC743616118AB");

    if(scripts\engine\utility::array_contains(level.technicals[0].occupants, self)) {
      continue;
    }
    commands_requested_recently(var_0);
  }
}

add_command_to_action_tracker(var_0) {
  self.fired_commands[var_0] = 0;
}

commands_requested_recently(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_83A81DDE6035FA7130EBAB097B7038CBBBA3E78D38C2578B63A8E3F22BE010");
  self endon("_encstr_83A81DDE6035FA7130EBAB097B7038CBBBA3E78D38C2578B63A8E3F22BE010");
  self.fired_commands[var_0]++;

  if(self.fired_commands["_encstr_88780599B4E495"] > 4 || self.fired_commands["_encstr_AD1904291F7B"] > 4 || self.fired_commands["_encstr_B116071BCAD186858D"] > 4 || self.fired_commands["_encstr_99C209E34FC743616118AB"] > 4) {}

  thread reduce_command_count_after_duration(3.5, var_0);
}

reduce_command_count_after_duration(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A66422943B90AF2B4DEE4A827394E764D093370C5908F747E583F1EAF8E0AB9DA8338572");
  wait(var_0);
  self.fired_commands[var_1]--;

  if(self.fired_commands[var_1] <= 0) {
    self.fired_commands[var_1] = 0;

    if(self.fired_commands["_encstr_88780599B4E495"] <= 0)
      set_demeanor("_encstr_A9BA0823A9318F1038D1");
  }
}

set_demeanor_func() {
  set_demeanor("_encstr_820E07FAE8780B3A4C");
}

set_demeanor_for_duration(var_0) {
  self notify("_encstr_86FC1AA37D43B7DF0BD0E2BAD04712FFB9D02A17058BDBA601984A42");
  self endon("_encstr_86FC1AA37D43B7DF0BD0E2BAD04712FFB9D02A17058BDBA601984A42");
  self endon("_encstr_A66422943B90AF2B4DEE4A827394E764D093370C5908F747E583F1EAF8E0AB9DA8338572");
  set_demeanor("_encstr_820E07FAE8780B3A4C");
  wait(var_0);
  set_demeanor("_encstr_A9BA0823A9318F1038D1");
}

set_demeanor(var_0) {
  switch (var_0) {
    case "_encstr_820E07FAE8780B3A4C":
      enter_demeanor_normal();
      break;
    case "_encstr_B418059B8533CA":
      enter_demeanor_safe();
      break;
    case "_encstr_A9BA0823A9318F1038D1":
      enter_demeanor_relaxed();
      break;
  }
}

enter_demeanor_safe() {
  thread set_demeanor_code_think("_encstr_B418059B8533CA", "_encstr_A975161B174F60E8BD020E61AF6D20A7C28FA5EFAF62B4B0");
  thread demeanor_exit_func_wait(::exit_demeanor_safe);
}

exit_demeanor_safe() {}

enter_demeanor_relaxed() {
  thread set_demeanor_code_think("_encstr_A9BA0823A9318F1038D1", "_encstr_BA0E19013FFBDF3FA3C8492C9DB88F4870E0128152CFFD17883F94");
  thread demeanor_exit_func_wait(::exit_demeanor_relaxed);
}

exit_demeanor_relaxed() {}

demeanor_exit_func_wait(var_0) {
  self waittill("_encstr_92AF16EFA02B876B431E6F4790439871A158FD7541365A45");
  self[[var_0]]();
}

set_demeanor_code_think(var_0, var_1) {
  self endon("_encstr_92AF16EFA02B876B431E6F4790439871A158FD7541365A45");
  self endon("_encstr_AD75063D571AE108");
  var_2 = 0;

  for(;;) {
    if(isDefined(var_1))
      var_2 = self setdemeanorviewmodel(var_0, var_1);
    else
      var_2 = self setdemeanorviewmodel(var_0);

    if(var_2) {
      break;
    }

    wait 0.05;
  }
}

enter_demeanor_normal() {
  thread set_demeanor_code_think("_encstr_820E07FAE8780B3A4C");
  thread demeanor_exit_func_wait(::exit_demeanor_normal);
}

exit_demeanor_normal() {}

disable_features_for_disguised_player(var_0) {
  var_0 scripts\common\utility::allow_ads(0);
  var_0 scripts\common\utility::allow_fire(0);
}

enable_features_for_disguised_player(var_0) {
  var_0 scripts\common\utility::allow_ads(1);
  var_0 scripts\common\utility::allow_fire(1);
}