/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: common_scripts\_wind.gsc
*****************************************************/

wind(var_0, var_1, var_2, var_3) {
  level notify("wind changed");
  level endon("wind changed");

  if(!isDefined(var_1)) {
    wind_internal_blendovertime(var_0, 2);
    return;
  }

  if(!isDefined(var_2)) {
    var_2 = 3;
  }

  if(!isDefined(var_3)) {
    var_3 = 0.4;
  }

  var_4 = randomfloat(1);

  for(;;) {
    var_4 = var_4 + randomfloatrange(-1 * var_3, var_3);

    if(var_4 < 0) {
      var_4 = var_4 * -1;
    }
    else if(var_4 > 1) {
      var_4 = 2 - var_4;
    }

    var_5 = pow(var_4, var_2);
    var_5 = var_0 * (1 - var_5) + var_1 * var_5;

    if(getdvarint("interactives_debug", 0)) {
      iprintln("wind n: " + var_4 + ", strength: " + var_5);
    }

    wind_internal_blendovertime(var_5, 1.2);
  }
}

wind_blendtonewvalue(var_0, var_1) {
  level notify("wind changed");
  level endon("wind changed");
  wind_internal_blendovertime(var_0, var_1);
}

wind_internal_blendovertime(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = var_1 / 0.05;
  }

  if(!isDefined(var_3)) {
    var_3 = var_0 * 5;
  }

  if(isDefined(var_4)) {
    var_5 = var_2 * var_4 / var_1;
  }
  else {
    var_5 = var_2 * 0.5;
  }

  var_6 = getdvarfloat("r_reactiveMotionWindStrength");
  var_7 = getdvarfloat("r_reactiveMotionWindAmplitudeScale");
  var_8 = (var_0 - var_7) / var_2;
  var_9 = (var_3 - var_6) / var_5;

  for(var_10 = 0; var_10 < var_2; var_10 = var_10 + 1) {
    var_7 = var_7 + var_8;
    var_6 = var_6 + var_9;
    setsaveddvar("r_reactiveMotionWindAmplitudeScale", var_7);

    if(var_10 < var_5) {
      setsaveddvar("r_reactiveMotionWindStrength", var_6);
    }

    wait(var_1 / var_2);
  }

  setsaveddvar("r_reactiveMotionWindAmplitudeScale", var_0);
  setsaveddvar("r_reactiveMotionWindStrength", var_3);
}