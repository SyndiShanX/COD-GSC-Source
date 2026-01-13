/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3411.gsc
***************************************/

applyzombiescriptablestate(var_0, var_1) {
  var_0 notify("applyZombieScriptableState");
  var_0 endon("applyZombieScriptableState");
  var_0 endon("death");
  var_2 = 1;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;

  while(var_2) {
    var_10 = scripts\engine\utility::is_true(var_0.is_afflicted);
    var_11 = scripts\engine\utility::is_true(var_0.is_burning);
    var_12 = scripts\engine\utility::is_true(var_0.stunned);
    var_13 = scripts\engine\utility::is_true(var_0.isfrozen);
    var_14 = scripts\engine\utility::is_true(var_0.is_chem_burning);
    var_15 = scripts\engine\utility::is_true(var_0.is_electrified);
    var_16 = isDefined(var_0.frozentick);

    if(var_13) {
      if(!var_5) {
        var_5 = 1;
        var_3 = 0;
        var_4 = 0;
        var_6 = 0;
        var_7 = 0;
        var_8 = 0;
        var_9 = 0;
        var_0.var_EF42 = 1;
        func_5554(var_0, "frozen");
      }
    } else if(var_16) {
      if(!var_9) {
        var_9 = 1;
        var_5 = 0;
        var_3 = 0;
        var_4 = 0;
        var_6 = 0;
        var_7 = 0;
        var_8 = 0;
        var_0.var_EF42 = 1;

        if(isalive(var_0)) {
          var_0 setscriptablepartstate("cold", "active", 1);
          func_5554(var_0, "cold");
          var_0 thread adjustmovespeed(var_0, var_1);
        }
      }
    } else if(var_10) {
      if(!var_8) {
        var_8 = 1;
        var_3 = 0;
        var_4 = 0;
        var_5 = 0;
        var_6 = 0;
        var_7 = 0;
        var_9 = 0;
        var_0.var_EF42 = 1;

        if(isalive(var_0)) {
          var_0 setscriptablepartstate("arcane_white", "active", 1);
          func_5554(var_0, "arcane_white");
        }
      }
    } else if(var_14) {
      if(!var_6) {
        var_6 = 1;
        var_3 = 0;
        var_4 = 0;
        var_5 = 0;
        var_7 = 0;
        var_8 = 0;
        var_9 = 0;
        var_0.var_EF42 = 1;

        if(isalive(var_0)) {
          var_0 setscriptablepartstate("chemburn", "active", 1);
          func_5554(var_0, "chemburn");
        }
      }
    } else if(var_11) {
      if(!var_3) {
        var_3 = 1;
        var_4 = 0;
        var_5 = 0;
        var_6 = 0;
        var_7 = 0;
        var_8 = 0;
        var_9 = 0;
        var_0.var_EF42 = 1;

        if(isalive(var_0)) {
          var_0 setscriptablepartstate("burning", "active", 1);
          func_5554(var_0, "burning");
        }
      }
    } else if(var_15) {
      if(!var_7) {
        var_7 = 1;
        var_3 = 0;
        var_4 = 0;
        var_5 = 0;
        var_6 = 0;
        var_8 = 0;
        var_9 = 0;
        var_0.var_EF42 = 1;

        if(isalive(var_0)) {
          var_0 setscriptablepartstate("shocked", "active", 1);
          func_5554(var_0, "electrified");
        }
      }
    } else if(var_12) {
      if(!var_4) {
        var_4 = 1;
        var_3 = 0;
        var_5 = 0;
        var_6 = 0;
        var_7 = 0;
        var_8 = 0;
        var_9 = 0;
        var_0.var_EF42 = 1;

        if(isalive(var_0)) {
          var_0 setscriptablepartstate("shocked", "active", 1);
          func_5554(var_0, "shocked");
        }
      }
    } else {
      var_0.var_EF42 = undefined;
      var_0 func_12973(var_0, var_5);
      var_2 = 0;
    }

    wait 0.1;
  }
}

adjustmovespeed(var_0, var_1) {
  var_0 endon("death");

  if(scripts\engine\utility::is_true(var_0.allowpain)) {
    var_0 getrandomarmkillstreak(1, var_0.origin);
    var_0.allowpain = 0;
  }

  if(scripts\engine\utility::is_true(var_0.slowed)) {
    var_0.slowed = undefined;
  } else {
    return;
  }

  if(!isDefined(var_0.asm.cur_move_mode)) {
    var_2 = self.movemode;
  } else {
    var_2 = var_0.asm.cur_move_mode;
  }

  var_2 = var_0.asm.cur_move_mode;

  switch (var_2) {
    case "slow_walk":
      break;
    case "walk":
      var_0 scripts\asm\asm_bb::bb_requestmovetype("slow_walk");
      break;
    case "run":
      var_0 scripts\asm\asm_bb::bb_requestmovetype("walk");
      break;
    case "sprint":
      var_0 scripts\asm\asm_bb::bb_requestmovetype("run");
      break;
  }

  var_0 waittill("defrosted");
  var_0 scripts\asm\asm_bb::bb_requestmovetype(var_2);
}

removefrozentickontimeout(var_0) {
  var_0 notify("frozen_tick_updated");
  var_0 endon("frozen_tick_updated");
  var_0 endon("death");
  wait 1;

  if(isDefined(var_0.frozentick)) {
    var_0.frozentick = undefined;
  }

  var_0 notify("defrosted");
  var_0 thread applyzombiescriptablestate(var_0);
}

freeze_zombie(var_0) {
  var_0 endon("death");
  var_0.isfrozen = 1;
  var_0.ignoreall = 1;
  var_0.nocorpse = 1;
  var_0.full_gib = 1;
  var_0.noturnanims = 1;

  if(isDefined(var_0.var_7387) && issubstr(var_0.var_7387, "window")) {
    var_0 setscriptablepartstate("frozen", "frozen_traverse");
  } else if(scripts\engine\utility::is_true(var_0.dismember_crawl)) {
    var_0 setscriptablepartstate("frozen", "frozen_crawl");
  } else {
    var_0 setscriptablepartstate("frozen", "frozen");
  }

  wait 10.1;
  var_0.isfrozen = undefined;
}

unfreeze_zombie(var_0) {
  var_0 endon("death");
  var_0 setscriptablepartstate("frozen", "unfrozen");

  if(!isalive(var_0)) {
    return;
  }
  var_0 playSound("forge_freeze_shatter");
  var_0.ignoreall = 0;
  var_0.nocorpse = undefined;
  var_0.full_gib = undefined;
  var_0.noturnanims = undefined;
}

func_5554(var_0, var_1) {
  switch (var_1) {
    case "frozen":
      var_0 setscriptablepartstate("cold", "inactive", 1);
      var_0 setscriptablepartstate("burning", "inactive", 1);
      var_0 setscriptablepartstate("shocked", "inactive", 1);
      var_0 setscriptablepartstate("chemburn", "inactive", 1);
      var_0 setscriptablepartstate("arcane_white", "inactive", 1);
      var_0 setscriptablepartstate("eyes", "eye_glow_off", 1);
      break;
    case "cold":
      var_0 setscriptablepartstate("burning", "inactive", 1);
      var_0 setscriptablepartstate("shocked", "inactive", 1);
      var_0 setscriptablepartstate("chemburn", "inactive", 1);
      var_0 setscriptablepartstate("arcane_white", "inactive", 1);
      var_0 setscriptablepartstate("eyes", "eye_glow_off", 1);
      break;
    case "arcane_white":
      var_0 setscriptablepartstate("cold", "inactive", 1);
      var_0 setscriptablepartstate("burning", "inactive", 1);
      var_0 setscriptablepartstate("shocked", "inactive", 1);
      var_0 setscriptablepartstate("chemburn", "inactive", 1);
      var_0 setscriptablepartstate("eyes", "eye_glow_off", 1);
      break;
    case "chemburn":
      var_0 setscriptablepartstate("cold", "inactive", 1);
      var_0 setscriptablepartstate("burning", "inactive", 1);
      var_0 setscriptablepartstate("shocked", "inactive", 1);
      var_0 setscriptablepartstate("arcane_white", "inactive", 1);
      var_0 setscriptablepartstate("eyes", "eye_glow_off", 1);
      break;
    case "burning":
      var_0 setscriptablepartstate("cold", "inactive", 1);
      var_0 setscriptablepartstate("shocked", "inactive", 1);
      var_0 setscriptablepartstate("chemburn", "inactive", 1);
      var_0 setscriptablepartstate("arcane_white", "inactive", 1);
      var_0 setscriptablepartstate("eyes", "eye_glow_off", 1);
      break;
    case "shocked":
    case "electrified":
      var_0 setscriptablepartstate("cold", "inactive", 1);
      var_0 setscriptablepartstate("burning", "inactive", 1);
      var_0 setscriptablepartstate("chemburn", "inactive", 1);
      var_0 setscriptablepartstate("arcane_white", "inactive", 1);
      var_0 setscriptablepartstate("eyes", "eye_glow_off", 1);
      break;
    default:
      break;
  }
}

func_12973(var_0, var_1) {
  if(isDefined(var_0.agent_type) && var_0.agent_type == "c6") {
    return;
  }
  if(!func_FFAA(var_0)) {
    return;
  }
  if(isalive(var_0)) {
    var_0 setscriptablepartstate("burning", "inactive", 1);
    var_0 setscriptablepartstate("shocked", "inactive", 1);
    var_0 setscriptablepartstate("chemburn", "inactive", 1);
    var_0 setscriptablepartstate("arcane_white", "inactive", 1);
    var_0 setscriptablepartstate("cold", "inactive", 1);
  }

  if(scripts\engine\utility::is_true(var_1)) {
    var_0.isfrozen = undefined;
  }
}

turn_off_states_on_death(var_0) {
  if(isDefined(var_0.agent_type) && (var_0.agent_type == "c6" || var_0.agent_type == "zombie_brute" || var_0.agent_type == "zombie_grey" || var_0.agent_type == "zombie_ghost")) {
    return;
  }
  if(!func_FFAA(var_0)) {
    return;
  }
  var_0 setscriptablepartstate("burning", "inactive", 1);
  var_0 setscriptablepartstate("pet", "inactive", 1);
  var_0 setscriptablepartstate("shocked", "inactive", 1);
  var_0 setscriptablepartstate("corrosive", "inactive", 1);
  var_0 setscriptablepartstate("chemburn", "inactive", 1);
  var_0 setscriptablepartstate("arcane_white", "inactive", 1);
  var_0 setscriptablepartstate("cold", "inactive", 1);

  if(isDefined(var_0.has_backpack)) {
    var_0 setscriptablepartstate("backpack", "hide", 1);
  }

  var_0 getrandomhovernodesaroundtargetpos(2, 0);
}

func_FFAA(var_0) {
  if(!isDefined(var_0.species)) {
    return 0;
  }

  if(isDefined(level.the_hoff) && var_0 == level.the_hoff) {
    return 0;
  }

  if(isDefined(var_0.electrocuted)) {
    return 0;
  }

  switch (var_0.species) {
    case "zombie_grey":
    case "zombie_brute":
      return 0;
    default:
      return 1;
  }
}