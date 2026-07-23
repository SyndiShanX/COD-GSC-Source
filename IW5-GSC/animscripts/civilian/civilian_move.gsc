/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\civilian\civilian_move.gsc
**************************************************/

main() {
  animscripts\move::main();
}

_id_407C(var_0) {
  var_1 = undefined;

  if(var_0 < -60 && var_0 > -120) {
    var_1 = level._id_0C59[self._id_1032]["turn_left_90"];
  }
  if(var_0 > 60 && var_0 < 120) {
    var_1 = level._id_0C59[self._id_1032]["turn_right_90"];
  }
  if(isDefined(var_1) && animscripts\move::_id_10C4(var_1)) {
    return var_1;
  } else {
    return undefined;
  }
}

#using_animtree("generic_human");

_id_407D(var_0) {
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

  if(isDefined(var_1) && animscripts\move::_id_10C4(var_1)) {
    return var_1;
  } else {
    return undefined;
  }
}

_id_407E(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  if(var_0 < -22.5) {
    if(var_0 > -45) {
      var_1 = % civilian_run_hunched_turnl45;
    } else if(var_0 > -112.5) {
      var_1 = % civilian_run_hunched_turnl90;
      var_2 = animscripts\utility::_id_0F26(%civilian_run_hunched_turnl90_slide, %civilian_run_hunched_turnl90_stumble);
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
      var_2 = animscripts\utility::_id_0F26(%civilian_run_hunched_turnr90_slide, %civilian_run_hunched_turnr90_stumble);
    } else if(var_0 < 157.5) {
      var_1 = % civilian_run_upright_turnr135;
    } else {
      var_1 = % civilian_run_upright_turn180;
    }
  }

  if(isDefined(var_2) && randomint(3) < 2 && animscripts\move::_id_10C4(var_2)) {
    return var_2;
  }
  if(isDefined(var_1) && animscripts\move::_id_10C4(var_1)) {
    return var_1;
  } else {
    return undefined;
  }
}