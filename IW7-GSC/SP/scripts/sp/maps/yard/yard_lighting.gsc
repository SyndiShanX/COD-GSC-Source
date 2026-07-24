/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\yard\yard_lighting.gsc
**************************************************/

main() {
  thread _id_10E3F();
  thread _id_3B0A();
  thread _id_12717();
  thread _id_12718();
  thread _id_12719();
  thread _id_1271A();
  thread _id_1271B();
  thread _id_1271C();
  thread _id_1271D();
}

_id_10E3F() {
  var_0 = getEntArray("arrive_door_blocker", "targetname");
  scripts\engine\utility::array_thread(var_0, ::_id_10E3E);
}

_id_10E3E() {
  wait 0.05;
  self delete();
}

_id_3B0A() {
  setsaveddvar("sm_sunCascadeSizeMultiplier1", "1");
  setsaveddvar("sm_sunCascadeSizeMultiplier2", "2");
}

_id_B130(var_0) {
  var_1 = getEntArray("light_gotcha", "targetname");

  foreach(var_3 in var_1) {
    var_3._id_C724 = var_3 _meth_8134();
    var_3 setlightintensity(0);
  }
}

_id_B131(var_0) {
  var_1 = getEntArray("light_gotcha", "targetname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_C724)) {
      var_3 setlightintensity(var_3._id_C724);
      continue;
    }

    var_3 setlightintensity(2);
  }
}

_id_12717() {
  visionsetalternate(1, 0.5);
}

_id_12718() {
  scripts\engine\utility::flag_wait("trig_01_set_yard");
  visionsetalternate(0, 0.5);
}

_id_12719() {
  scripts\engine\utility::flag_wait("trig_02_set_yard_int_defend");
  visionsetalternate(2, 1.5);
}

_id_1271A() {
  level endon("death");
  level endon("trig_05_set_yard_int_defend");

  for(;;) {
    scripts\engine\utility::flag_wait("trig_03_set_yard_int_defend");
    scripts\engine\utility::flag_clear("trig_04_set_yard_int");
    visionsetalternate(2, 0.5);
    wait 0.05;
  }
}

_id_1271B() {
  level endon("death");
  level endon("trig_05_set_yard_int_defend");

  for(;;) {
    scripts\engine\utility::flag_wait("trig_04_set_yard_int");
    scripts\engine\utility::flag_clear("trig_03_set_yard_int_defend");
    visionsetalternate(1, 0.5);
    wait 0.05;
  }
}

_id_1271C() {
  scripts\engine\utility::flag_wait("trig_05_set_yard_int_defend");
  visionsetalternate(2, 1.5);
}

_id_1271D() {
  scripts\engine\utility::flag_wait("central_hack_ethan_end");
  visionsetalternate(3, 0.5);
}

_id_4653() {
  var_0 = getEnt("core_interval_flicker", "targetname");
  self endon("core_light_stage01");

  while(isDefined(var_0)) {
    var_1 = randomintrange(15, 20);
    var_2 = randomintrange(5, 10);
    var_3 = randomfloatrange(0.05, 0.15);
    var_0 setlightintensity(var_1);
    wait(var_3);
    var_0 setlightintensity(var_2);
    wait(var_3);
  }
}

_id_4654() {
  scripts\engine\utility::flag_wait("core_light_stage01");
  self endon("core_light_stage02");
  var_0 = getEnt("core_interval_flicker", "targetname");

  while(isDefined(var_0)) {
    var_1 = randomintrange(30, 40);
    var_2 = randomintrange(10, 20);
    var_3 = randomfloatrange(0.05, 0.15);
    var_0 setlightintensity(var_1);
    wait(var_3);
    var_0 setlightintensity(var_2);
    wait(var_3);
  }
}

_id_4655() {
  scripts\engine\utility::flag_wait("core_light_stage02");
  self endon("core_light_stage03");
  var_0 = getEnt("core_interval_flicker", "targetname");

  while(isDefined(var_0)) {
    var_1 = randomintrange(80, 100);
    var_2 = randomintrange(20, 30);
    var_3 = randomfloatrange(0.05, 0.15);
    var_0 setlightintensity(var_1);
    wait(var_3);
    var_0 setlightintensity(var_2);
    wait(var_3);
  }
}

_id_4656() {
  scripts\engine\utility::flag_wait("core_light_stage02");
  var_0 = getEnt("core_interval_flicker", "targetname");

  while(isDefined(var_0)) {
    var_1 = randomintrange(120, 135);
    var_2 = randomintrange(60, 80);
    var_3 = randomfloatrange(0.05, 0.15);
    var_0 setlightintensity(var_1);
    wait(var_3);
    var_0 setlightintensity(var_2);
    wait(var_3);
  }
}