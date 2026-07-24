/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_vips\sa_vips_lighting.gsc
********************************************************/

main() {
  thread _id_E9EB();
  thread _id_E9ED();
  thread _id_E9EC();
  thread _id_E9EE();
}

_id_E9EF() {
  setsaveddvar("sm_sunSampleSizeNear", 0.65);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 2.0);
  setsaveddvar("sm_spotUpdateLimit", 16);
  setsaveddvar("sm_roundRobinPrioritySpotShadows", 8);
}

_id_E9ED() {
  var_0 = getEnt("vips_entrance_vision", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_0 waittill("trigger");
  visionsetalternate(1, 4.0);
  setsaveddvar("sm_sunSampleSizeNear", 0.45);
}

_id_E9EC() {
  var_0 = getEnt("vips_interior_vision", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_0 waittill("trigger");
  visionsetalternate(2, 8.0);
}

_id_E9F0() {
  var_0 = getEnt("rr_bink_light", "targetname");
  wait 1;
  var_0 setlightintensity(12);
  scripts\engine\utility::flag_wait("access_denied");
  wait 3.0;
  var_0 _meth_82FC((1, 0.19, 0.07));
  var_0 setlightintensity(20);
  wait 4.0;
  var_0 _meth_82FC((1, 1, 1));
  var_0 setlightintensity(16);
  wait 11.0;
  var_0 _meth_82FC((1, 0.19, 0.07));
  var_0 setlightintensity(14);
}

_id_E70A() {
  scripts\engine\utility::flag_wait("breach_started");
  var_0 = getEntArray("vips_emergency_spin", "targetname");
  scripts\engine\utility::array_thread(var_0, ::_id_E70B);
}

_id_E70B() {
  self endon("interior_begin");

  for(;;) {
    self rotatepitch(360, 1);
    wait 0.5;
  }
}

_id_E9EE() {
  var_0 = getEnt("vips_exit_vision", "targetname");
  var_0 waittill("trigger");
  visionsetalternate(0, 1.5);
  setsaveddvar("sm_sunSampleSizeNear", 0.65);
}

_id_E9EB() {
  level endon("flashing_light_end");
  level endon("death");
  var_0 = getEntArray("emerg_light_strobe", "targetname");
  var_1 = 2;
  var_2 = 360 / var_1;
  var_3 = 0;
  var_4 = 55;
  var_5 = 500;

  foreach(var_7 in var_0) {
    for(;;) {
      var_7 setlightintensity(0);
      var_7 _meth_8300(12);
      var_7 _meth_82FC((1, 1, 1));
      wait 1;
      var_8 = sin(var_3 * var_2) * 0.5 + 0.5;
      var_7 setlightintensity(var_4 + (var_5 - var_4) * var_8);
      wait 0.05;
      var_3 = var_3 + 0.05;

      if(var_3 > var_1)
        var_3 = var_3 - var_1;

      wait 0.05;
      var_7 setlightintensity(1000);
      var_7 _meth_8300(120);
      wait 0.05;
    }
  }
}