/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3411.gsc
***************************************/

applyzombiescriptablestate(var_00, var_01) {
  var_00 notify("applyZombieScriptableState");
  var_00 endon("applyZombieScriptableState");
  var_00 endon("death");
  var_02 = 1;
  var_03 = 0;
  var_04 = 0;
  var_05 = 0;
  var_06 = 0;
  var_07 = 0;
  var_08 = 0;
  var_09 = 0;

  while(var_02) {
    var_10 = scripts\engine\utility::is_true(var_0.is_afflicted);
    var_11 = scripts\engine\utility::is_true(var_0.is_burning);
    var_12 = scripts\engine\utility::is_true(var_0.stunned);
    var_13 = scripts\engine\utility::is_true(var_0.isfrozen);
    var_14 = scripts\engine\utility::is_true(var_0.is_chem_burning);
    var_15 = scripts\engine\utility::is_true(var_0.is_electrified);
    var_16 = isDefined(var_0.frozentick);

    if(var_13) {
      if(!var_05) {
        var_05 = 1;
        var_03 = 0;
        var_04 = 0;
        var_06 = 0;
        var_07 = 0;
        var_08 = 0;
        var_09 = 0;
        var_0.func_EF42 = 1;
        func_5554(var_00, "frozen");
      }
    } else if(var_16) {
      if(!var_09) {
        var_09 = 1;
        var_05 = 0;
        var_03 = 0;
        var_04 = 0;
        var_06 = 0;
        var_07 = 0;
        var_08 = 0;
        var_0.func_EF42 = 1;

        if(isalive(var_00)) {
          var_00 setscriptablepartstate("cold", "active", 1);
          func_5554(var_00, "cold");
          var_00 thread adjustmovespeed(var_00, var_01);
        }
      }
    } else if(var_10) {
      if(!var_08) {
        var_08 = 1;
        var_03 = 0;
        var_04 = 0;
        var_05 = 0;
        var_06 = 0;
        var_07 = 0;
        var_09 = 0;
        var_0.func_EF42 = 1;

        if(isalive(var_00)) {
          var_00 setscriptablepartstate("arcane_white", "active", 1);
          func_5554(var_00, "arcane_white");
        }
      }
    } else if(var_14) {
      if(!var_06) {
        var_06 = 1;
        var_03 = 0;
        var_04 = 0;
        var_05 = 0;
        var_07 = 0;
        var_08 = 0;
        var_09 = 0;
        var_0.func_EF42 = 1;

        if(isalive(var_00)) {
          var_00 setscriptablepartstate("chemburn", "active", 1);
          func_5554(var_00, "chemburn");
        }
      }
    } else if(var_11) {
      if(!var_03) {
        var_03 = 1;
        var_04 = 0;
        var_05 = 0;
        var_06 = 0;
        var_07 = 0;
        var_08 = 0;
        var_09 = 0;
        var_0.func_EF42 = 1;

        if(isalive(var_00)) {
          var_00 setscriptablepartstate("burning", "active", 1);
          func_5554(var_00, "burning");
        }
      }
    } else if(var_15) {
      if(!var_07) {
        var_07 = 1;
        var_03 = 0;
        var_04 = 0;
        var_05 = 0;
        var_06 = 0;
        var_08 = 0;
        var_09 = 0;
        var_0.func_EF42 = 1;

        if(isalive(var_00)) {
          var_00 setscriptablepartstate("shocked", "active", 1);
          func_5554(var_00, "electrified");
        }
      }
    } else if(var_12) {
      if(!var_04) {
        var_04 = 1;
        var_03 = 0;
        var_05 = 0;
        var_06 = 0;
        var_07 = 0;
        var_08 = 0;
        var_09 = 0;
        var_0.func_EF42 = 1;

        if(isalive(var_00)) {
          var_00 setscriptablepartstate("shocked", "active", 1);
          func_5554(var_00, "shocked");
        }
      }
    } else {
      var_0.func_EF42 = undefined;
      var_00 func_12973(var_00, var_05);
      var_02 = 0;
    }

    wait 0.1;
  }
}

adjustmovespeed(var_00, var_01) {
  var_00 endon("death");

  if(scripts\engine\utility::is_true(var_0.allowpain)) {
    var_00 getrandomarmkillstreak(1, var_0.origin);
    var_0.allowpain = 0;
  }

  if(scripts\engine\utility::is_true(var_0.slowed))
    var_0.slowed = undefined;
  else
    return;

  if(!isDefined(var_0.asm.cur_move_mode))
    var_02 = self.movemode;
  else
    var_02 = var_0.asm.cur_move_mode;

  var_02 = var_0.asm.cur_move_mode;

  switch (var_02) {
    case "slow_walk":
      break;
    case "walk":
      var_00 scripts\asm\asm_bb::bb_requestmovetype("slow_walk");
      break;
    case "run":
      var_00 scripts\asm\asm_bb::bb_requestmovetype("walk");
      break;
    case "sprint":
      var_00 scripts\asm\asm_bb::bb_requestmovetype("run");
      break;
  }

  var_00 waittill("defrosted");
  var_00 scripts\asm\asm_bb::bb_requestmovetype(var_02);
}

removefrozentickontimeout(var_00) {
  var_00 notify("frozen_tick_updated");
  var_00 endon("frozen_tick_updated");
  var_00 endon("death");
  wait 1;

  if(isDefined(var_0.frozentick))
    var_0.frozentick = undefined;

  var_00 notify("defrosted");
  var_00 thread applyzombiescriptablestate(var_00);
}

freeze_zombie(var_00) {
  var_00 endon("death");
  var_0.isfrozen = 1;
  var_0.ignoreall = 1;
  var_0.nocorpse = 1;
  var_0.full_gib = 1;
  var_0.noturnanims = 1;

  if(isDefined(var_0.func_7387) && issubstr(var_0.func_7387, "window"))
    var_00 setscriptablepartstate("frozen", "frozen_traverse");
  else if(scripts\engine\utility::is_true(var_0.dismember_crawl))
    var_00 setscriptablepartstate("frozen", "frozen_crawl");
  else
    var_00 setscriptablepartstate("frozen", "frozen");

  wait 10.1;
  var_0.isfrozen = undefined;
}

unfreeze_zombie(var_00) {
  var_00 endon("death");
  var_00 setscriptablepartstate("frozen", "unfrozen");

  if(!isalive(var_00)) {
    return;
  }
  var_00 playSound("forge_freeze_shatter");
  var_0.ignoreall = 0;
  var_0.nocorpse = undefined;
  var_0.full_gib = undefined;
  var_0.noturnanims = undefined;
}

func_5554(var_00, var_01) {
  switch (var_01) {
    case "frozen":
      var_00 setscriptablepartstate("cold", "inactive", 1);
      var_00 setscriptablepartstate("burning", "inactive", 1);
      var_00 setscriptablepartstate("shocked", "inactive", 1);
      var_00 setscriptablepartstate("chemburn", "inactive", 1);
      var_00 setscriptablepartstate("arcane_white", "inactive", 1);
      var_00 setscriptablepartstate("eyes", "eye_glow_off", 1);
      break;
    case "cold":
      var_00 setscriptablepartstate("burning", "inactive", 1);
      var_00 setscriptablepartstate("shocked", "inactive", 1);
      var_00 setscriptablepartstate("chemburn", "inactive", 1);
      var_00 setscriptablepartstate("arcane_white", "inactive", 1);
      var_00 setscriptablepartstate("eyes", "eye_glow_off", 1);
      break;
    case "arcane_white":
      var_00 setscriptablepartstate("cold", "inactive", 1);
      var_00 setscriptablepartstate("burning", "inactive", 1);
      var_00 setscriptablepartstate("shocked", "inactive", 1);
      var_00 setscriptablepartstate("chemburn", "inactive", 1);
      var_00 setscriptablepartstate("eyes", "eye_glow_off", 1);
      break;
    case "chemburn":
      var_00 setscriptablepartstate("cold", "inactive", 1);
      var_00 setscriptablepartstate("burning", "inactive", 1);
      var_00 setscriptablepartstate("shocked", "inactive", 1);
      var_00 setscriptablepartstate("arcane_white", "inactive", 1);
      var_00 setscriptablepartstate("eyes", "eye_glow_off", 1);
      break;
    case "burning":
      var_00 setscriptablepartstate("cold", "inactive", 1);
      var_00 setscriptablepartstate("shocked", "inactive", 1);
      var_00 setscriptablepartstate("chemburn", "inactive", 1);
      var_00 setscriptablepartstate("arcane_white", "inactive", 1);
      var_00 setscriptablepartstate("eyes", "eye_glow_off", 1);
      break;
    case "shocked":
    case "electrified":
      var_00 setscriptablepartstate("cold", "inactive", 1);
      var_00 setscriptablepartstate("burning", "inactive", 1);
      var_00 setscriptablepartstate("chemburn", "inactive", 1);
      var_00 setscriptablepartstate("arcane_white", "inactive", 1);
      var_00 setscriptablepartstate("eyes", "eye_glow_off", 1);
      break;
    default:
      break;
  }
}

func_12973(var_00, var_01) {
  if(isDefined(var_0.agent_type) && var_0.agent_type == "c6") {
    return;
  }
  if(!func_FFAA(var_00)) {
    return;
  }
  if(isalive(var_00)) {
    var_00 setscriptablepartstate("burning", "inactive", 1);
    var_00 setscriptablepartstate("shocked", "inactive", 1);
    var_00 setscriptablepartstate("chemburn", "inactive", 1);
    var_00 setscriptablepartstate("arcane_white", "inactive", 1);
    var_00 setscriptablepartstate("cold", "inactive", 1);
  }

  if(scripts\engine\utility::is_true(var_01))
    var_0.isfrozen = undefined;
}

turn_off_states_on_death(var_00) {
  if(isDefined(var_0.agent_type) && (var_0.agent_type == "c6" || var_0.agent_type == "zombie_brute" || var_0.agent_type == "zombie_grey" || var_0.agent_type == "zombie_ghost")) {
    return;
  }
  if(!func_FFAA(var_00)) {
    return;
  }
  var_00 setscriptablepartstate("burning", "inactive", 1);
  var_00 setscriptablepartstate("pet", "inactive", 1);
  var_00 setscriptablepartstate("shocked", "inactive", 1);
  var_00 setscriptablepartstate("corrosive", "inactive", 1);
  var_00 setscriptablepartstate("chemburn", "inactive", 1);
  var_00 setscriptablepartstate("arcane_white", "inactive", 1);
  var_00 setscriptablepartstate("cold", "inactive", 1);

  if(isDefined(var_0.has_backpack))
    var_00 setscriptablepartstate("backpack", "hide", 1);

  var_00 getrandomhovernodesaroundtargetpos(2, 0);
}

func_FFAA(var_00) {
  if(!isDefined(var_0.species))
    return 0;

  if(isDefined(level.the_hoff) && var_00 == level.the_hoff)
    return 0;

  if(isDefined(var_0.electrocuted))
    return 0;

  switch (var_0.species) {
    case "zombie_grey":
    case "zombie_brute":
      return 0;
    default:
      return 1;
  }
}