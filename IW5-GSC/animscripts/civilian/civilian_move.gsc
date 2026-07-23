/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\civilian\civilian_move.gsc
**************************************************/

main() {
  animscripts\move::main();
}

civilian_noncombatmoveturn(var_0) {
  var_1 = undefined;

  if(var_0 < -60 && var_0 > -120) {
    var_1 = level.scr_anim[self.animname]["turn_left_90"];
  }
  if(var_0 > 60 && var_0 < 120) {
    var_1 = level.scr_anim[self.animname]["turn_right_90"];
  }
  if(isDefined(var_1) && animscripts\move::pathchange_candoturnanim(var_1)) {
    return var_1;
  } else {
    return undefined;
  }
}

#using_animtree("generic_human");

civilian_combatmoveturn(var_0) {
  var_1 = undefined;

  if(var_0 < -22.5) {
    if(var_0 > -45) {
      var_1 = % civilian_run_upright_turnl45;
    } else if(var_0 > -112.5) {
      var_1 = % civilian_run_upright_turnl90;
    } else if(var_0 > -157.5) {
      var_1 = % civilian_run_upright_turnl135;
    } else {
      var_1 = % civilian_run_upright_turn180;
    }
  } else if(var_0 > 22.5) {
    if(var_0 < 45) {
      var_1 = % civilian_run_upright_turnr45;
    } else if(var_0 < 112.5) {
      var_1 = % civilian_run_upright_turnr90;
    } else if(var_0 < 157.5) {
      var_1 = % civilian_run_upright_turnr135;
    } else {
      var_1 = % civilian_run_upright_turn180;
    }
  }

  if(isDefined(var_1) && animscripts\move::pathchange_candoturnanim(var_1)) {
    return var_1;
  } else {
    return undefined;
  }
}

civilian_combathunchedmoveturn(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  if(var_0 < -22.5) {
    if(var_0 > -45) {
      var_1 = % civilian_run_hunched_turnl45;
    } else if(var_0 > -112.5) {
      var_1 = % civilian_run_hunched_turnl90;
      var_2 = animscripts\utility::randomanimoftwo(%civilian_run_hunched_turnl90_slide, %civilian_run_hunched_turnl90_stumble);
    } else if(var_0 > -157.5) {
      var_1 = % civilian_run_upright_turnl135;
    } else {
      var_1 = % civilian_run_upright_turn180;
    }
  } else if(var_0 > 22.5) {
    if(var_0 < 45) {
      var_1 = % civilian_run_hunched_turnr45;
    } else if(var_0 < 112.5) {
      var_1 = % civilian_run_hunched_turnr90;
      var_2 = animscripts\utility::randomanimoftwo(%civilian_run_hunched_turnr90_slide, %civilian_run_hunched_turnr90_stumble);
    } else if(var_0 < 157.5) {
      var_1 = % civilian_run_upright_turnr135;
    } else {
      var_1 = % civilian_run_upright_turn180;
    }
  }

  if(isDefined(var_2) && randomint(3) < 2 && animscripts\move::pathchange_candoturnanim(var_2)) {
    return var_2;
  }
  if(isDefined(var_1) && animscripts\move::pathchange_candoturnanim(var_1)) {
    return var_1;
  } else {
    return undefined;
  }
}