/***********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombie_scriptable_states.gsc
***********************************************************/

applyzombiescriptablestate(param_00, param_01) {
  param_00 notify("applyZombieScriptableState");
  param_00 endon("applyZombieScriptableState");
  param_00 endon("death");
  var_02 = 1;
  var_03 = 0;
  var_04 = 0;
  var_05 = 0;
  var_06 = 0;
  var_07 = 0;
  var_08 = 0;
  var_09 = 0;
  while(var_02) {
    var_0A = scripts\engine\utility::istrue(param_00.is_afflicted);
    var_0B = scripts\engine\utility::istrue(param_00.is_burning);
    var_0C = scripts\engine\utility::istrue(param_00.stunned);
    var_0D = scripts\engine\utility::istrue(param_00.isfrozen);
    var_0E = scripts\engine\utility::istrue(param_00.is_chem_burning);
    var_0F = scripts\engine\utility::istrue(param_00.is_electrified);
    var_10 = isDefined(param_00.frozentick);
    if(var_0D) {
      if(!var_05) {
        var_05 = 1;
        var_03 = 0;
        var_04 = 0;
        var_06 = 0;
        var_07 = 0;
        var_08 = 0;
        var_09 = 0;
        param_00.var_EF42 = 1;
        func_5554(param_00, "frozen");
      }

      continue;
    }

    if(var_10) {
      if(!var_09) {
        var_09 = 1;
        var_05 = 0;
        var_03 = 0;
        var_04 = 0;
        var_06 = 0;
        var_07 = 0;
        var_08 = 0;
        param_00.var_EF42 = 1;
        if(isalive(param_00)) {
          param_00 setscriptablepartstate("cold", "active", 1);
          func_5554(param_00, "cold");
          param_00 thread adjustmovespeed(param_00, param_01);
        }
      }

      continue;
    }

    if(var_0A) {
      if(!var_08) {
        var_08 = 1;
        var_03 = 0;
        var_04 = 0;
        var_05 = 0;
        var_06 = 0;
        var_07 = 0;
        var_09 = 0;
        param_00.var_EF42 = 1;
        if(isalive(param_00)) {
          param_00 setscriptablepartstate("arcane_white", "active", 1);
          func_5554(param_00, "arcane_white");
        }
      }

      continue;
    }

    if(var_0E) {
      if(!var_06) {
        var_06 = 1;
        var_03 = 0;
        var_04 = 0;
        var_05 = 0;
        var_07 = 0;
        var_08 = 0;
        var_09 = 0;
        param_00.var_EF42 = 1;
        if(isalive(param_00)) {
          param_00 setscriptablepartstate("chemburn", "active", 1);
          func_5554(param_00, "chemburn");
        }
      }

      continue;
    }

    if(var_0B) {
      if(!var_03) {
        var_03 = 1;
        var_04 = 0;
        var_05 = 0;
        var_06 = 0;
        var_07 = 0;
        var_08 = 0;
        var_09 = 0;
        param_00.var_EF42 = 1;
        if(isalive(param_00)) {
          param_00 setscriptablepartstate("burning", "active", 1);
          func_5554(param_00, "burning");
        }
      }

      continue;
    }

    if(var_0F) {
      if(!var_07) {
        var_07 = 1;
        var_03 = 0;
        var_04 = 0;
        var_05 = 0;
        var_06 = 0;
        var_08 = 0;
        var_09 = 0;
        param_00.var_EF42 = 1;
        if(isalive(param_00)) {
          param_00 setscriptablepartstate("shocked", "active", 1);
          func_5554(param_00, "electrified");
        }
      }

      continue;
    }

    if(var_0C) {
      if(!var_04) {
        var_04 = 1;
        var_03 = 0;
        var_05 = 0;
        var_06 = 0;
        var_07 = 0;
        var_08 = 0;
        var_09 = 0;
        param_00.var_EF42 = 1;
        if(isalive(param_00)) {
          param_00 setscriptablepartstate("shocked", "active", 1);
          func_5554(param_00, "shocked");
        }
      }

      continue;
    }

    param_00.var_EF42 = undefined;
    param_00 func_12973(param_00, var_05);
    var_02 = 0;
    wait(0.1);
  }
}

adjustmovespeed(param_00, param_01) {
  param_00 endon("death");
  if(scripts\engine\utility::istrue(param_00.allowpain)) {
    param_00 dodamage(1, param_00.origin);
    param_00.allowpain = 0;
  }

  if(scripts\engine\utility::istrue(param_00.slowed)) {
    param_00.slowed = undefined;
  } else {
    return;
  }

  if(!isDefined(param_00.asm.cur_move_mode)) {
    var_02 = self.synctransients;
  } else {
    var_02 = param_01.asm.cur_move_mode;
  }

  var_02 = param_00.asm.cur_move_mode;
  switch (var_02) {
    case "slow_walk":
      break;

    case "walk":
      param_00 scripts\asm\asm_bb::bb_requestmovetype("slow_walk");
      break;

    case "run":
      param_00 scripts\asm\asm_bb::bb_requestmovetype("walk");
      break;

    case "sprint":
      param_00 scripts\asm\asm_bb::bb_requestmovetype("run");
      break;
  }

  param_00 waittill("defrosted");
  param_00 scripts\asm\asm_bb::bb_requestmovetype(var_02);
}

removefrozentickontimeout(param_00) {
  param_00 notify("frozen_tick_updated");
  param_00 endon("frozen_tick_updated");
  param_00 endon("death");
  wait(1);
  if(isDefined(param_00.frozentick)) {
    param_00.frozentick = undefined;
  }

  param_00 notify("defrosted");
  param_00 thread applyzombiescriptablestate(param_00);
}

freeze_zombie(param_00) {
  param_00 endon("death");
  param_00.isfrozen = 1;
  param_00.precacheleaderboards = 1;
  param_00.nocorpse = 1;
  param_00.full_gib = 1;
  param_00.noturnanims = 1;
  if(isDefined(param_00.var_7387) && issubstr(param_00.var_7387, "window")) {
    param_00 setscriptablepartstate("frozen", "frozen_traverse");
  } else if(scripts\engine\utility::istrue(param_00.dismember_crawl)) {
    param_00 setscriptablepartstate("frozen", "frozen_crawl");
  } else {
    param_00 setscriptablepartstate("frozen", "frozen", 1);
  }

  wait(10.1);
  param_00.isfrozen = undefined;
}

unfreeze_zombie(param_00) {
  param_00 endon("death");
  param_00 setscriptablepartstate("frozen", "unfrozen", 1);
  if(!isalive(param_00)) {
    return;
  }

  param_00 playSound("forge_freeze_shatter");
  param_00.precacheleaderboards = 0;
  param_00.nocorpse = undefined;
  param_00.full_gib = undefined;
  param_00.noturnanims = undefined;
}

func_5554(param_00, param_01) {
  switch (param_01) {
    case "frozen":
      param_00 setscriptablepartstate("cold", "inactive", 1);
      param_00 setscriptablepartstate("burning", "inactive", 1);
      param_00 setscriptablepartstate("shocked", "inactive", 1);
      param_00 setscriptablepartstate("chemburn", "inactive", 1);
      param_00 setscriptablepartstate("arcane_white", "inactive", 1);
      param_00 setscriptablepartstate("eyes", "eye_glow_off", 1);
      break;

    case "cold":
      param_00 setscriptablepartstate("burning", "inactive", 1);
      param_00 setscriptablepartstate("shocked", "inactive", 1);
      param_00 setscriptablepartstate("chemburn", "inactive", 1);
      param_00 setscriptablepartstate("arcane_white", "inactive", 1);
      param_00 setscriptablepartstate("eyes", "eye_glow_off", 1);
      break;

    case "arcane_white":
      param_00 setscriptablepartstate("cold", "inactive", 1);
      param_00 setscriptablepartstate("burning", "inactive", 1);
      param_00 setscriptablepartstate("shocked", "inactive", 1);
      param_00 setscriptablepartstate("chemburn", "inactive", 1);
      param_00 setscriptablepartstate("eyes", "eye_glow_off", 1);
      break;

    case "chemburn":
      param_00 setscriptablepartstate("cold", "inactive", 1);
      param_00 setscriptablepartstate("burning", "inactive", 1);
      param_00 setscriptablepartstate("shocked", "inactive", 1);
      param_00 setscriptablepartstate("arcane_white", "inactive", 1);
      param_00 setscriptablepartstate("eyes", "eye_glow_off", 1);
      break;

    case "burning":
      param_00 setscriptablepartstate("cold", "inactive", 1);
      param_00 setscriptablepartstate("shocked", "inactive", 1);
      param_00 setscriptablepartstate("chemburn", "inactive", 1);
      param_00 setscriptablepartstate("arcane_white", "inactive", 1);
      param_00 setscriptablepartstate("eyes", "eye_glow_off", 1);
      break;

    case "electrified":
    case "shocked":
      param_00 setscriptablepartstate("cold", "inactive", 1);
      param_00 setscriptablepartstate("burning", "inactive", 1);
      param_00 setscriptablepartstate("chemburn", "inactive", 1);
      param_00 setscriptablepartstate("arcane_white", "inactive", 1);
      param_00 setscriptablepartstate("eyes", "eye_glow_off", 1);
      break;

    default:
      break;
  }
}

func_12973(param_00, param_01) {
  if(isDefined(param_00.agent_type) && param_00.agent_type == "c6") {
    return;
  }

  if(!func_FFAA(param_00)) {
    return;
  }

  if(isalive(param_00)) {
    param_00 setscriptablepartstate("burning", "inactive", 1);
    param_00 setscriptablepartstate("shocked", "inactive", 1);
    param_00 setscriptablepartstate("chemburn", "inactive", 1);
    param_00 setscriptablepartstate("arcane_white", "inactive", 1);
    param_00 setscriptablepartstate("cold", "inactive", 1);
  }

  if(scripts\engine\utility::istrue(param_01)) {
    param_00.isfrozen = undefined;
  }
}

turn_off_states_on_death(param_00) {
  if(isDefined(param_00.agent_type) && param_00.agent_type == "c6" || param_00.agent_type == "zombie_brute" || param_00.agent_type == "zombie_grey" || param_00.agent_type == "zombie_ghost") {
    return;
  }

  if(!func_FFAA(param_00)) {
    return;
  }

  param_00 setscriptablepartstate("burning", "inactive", 1);
  param_00 setscriptablepartstate("pet", "inactive", 1);
  param_00 setscriptablepartstate("shocked", "inactive", 1);
  param_00 setscriptablepartstate("corrosive", "inactive", 1);
  param_00 setscriptablepartstate("chemburn", "inactive", 1);
  param_00 setscriptablepartstate("arcane_white", "inactive", 1);
  param_00 setscriptablepartstate("cold", "inactive", 1);
  if(isDefined(param_00.has_backpack)) {
    param_00 setscriptablepartstate("backpack", "hide", 1);
  }

  param_00 getrandomhovernodesaroundtargetpos(2, 0);
}

func_FFAA(param_00) {
  if(!isDefined(param_00.species)) {
    return 0;
  }

  if(isDefined(level.the_hoff) && param_00 == level.the_hoff) {
    return 0;
  }

  if(isDefined(param_00.electrocuted)) {
    return 0;
  }

  switch (param_00.species) {
    case "zombie_grey":
    case "zombie_brute":
      return 0;

    default:
      return 1;
  }
}