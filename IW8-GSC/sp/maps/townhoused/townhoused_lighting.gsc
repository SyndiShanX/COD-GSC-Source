/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\townhoused\townhoused_lighting.gsc
******************************************************/

main() {
  scripts\engine\sp\utility::post_load_precache(::post_load);
  scripts\engine\utility::flag_init("sun_enable_disable");
  scripts\engine\utility::flag_init("train_lighting_moment");
  scripts\engine\utility::flag_init("lt_kitchen_visible");
  scripts\engine\utility::flag_init("door_light_enable_disable");
  thread set_sun_enable_disable();
  thread set_train_moment_shadows();
  thread init_2ndfloor_muzzle_flash();
  thread set_front_door_light_enable_disable();
  init_touching_triggers();
  init_price_attic_lights();
}

init_2ndfloor_muzzle_flash() {
  var_0 = getEntArray("2nd_floor_muzzle_light", "targetname");

  if(getdvarint("LLQQOPKTKM") > 0) {
    foreach(var_2 in var_0)
    var_2 delete();

    return;
  }

  foreach(var_2 in var_0) {
    var_2.og_intensity = var_2 getlightintensity();
    var_2 setlightintensity(0);
    var_2 setlightradius(115);
    var_2.flash_color = (1, 0.85, 0.77);
  }
}

lt_backyard_start() {
  setsaveddvar("LKOLRONRNQ", 450);
  thread house_exterior_dof();
  thread stack_up_wooden_gate();
}

lt_kitchen_start() {
  setsaveddvar("LKOLRONRNQ", 750);
  thread house_exterior_dof();
  thread deploy_ladder();
}

lt_dining_room_start() {
  thread set_sun_disable();
}

lt_stairtrain1_start() {
  thread set_sun_disable();
}

lt_second_floor_start() {
  thread set_sun_disable();
}

lt_stairtrain2_start() {
  thread set_sun_disable();
}

lt_third_floor_start() {
  thread set_sun_disable();
}

lt_stairtrain3_start() {
  thread set_sun_disable();
}

lt_fourth_floor_start() {
  thread set_sun_disable();
}

lt_attic_start() {}

init_train_lights() {}

init_price_attic_lights() {
  level.lt_price_attic_key = getEnt("lt_price_key", "targetname");
  level.lt_price_attic_rim = getEnt("lt_price_rim", "targetname");
  level.lt_price_attic_laptop = getEnt("lt_price_laptop", "targetname");
  var_0 = [level.lt_price_attic_key, level.lt_price_attic_rim, level.lt_price_attic_laptop];

  foreach(var_2 in var_0)
  var_2 setlightintensity(0);
}

init_touching_triggers() {
  var_0 = getEntArray("light_on_touching", "targetname");

  foreach(var_2 in var_0)
  var_2 thread light_on_touching();
}

post_load() {
  thread lighting_setup_dvars();
}

start_light_intensity(var_0, var_1, var_2) {
  var_3 = getEnt(var_0, var_1);

  if(!isDefined(var_3)) {
    return;
  }
  var_3.og_intensity = var_3 getlightintensity();

  if(!isDefined(var_2))
    var_2 = 0;

  var_3 setlightintensity(var_2);
}

onflag_restore_intensity(var_0, var_1, var_2) {
  scripts\engine\utility::flag_wait(var_2);
  var_3 = getEnt(var_0, var_1);
  var_3 setlightintensity(var_3.og_intensity);
}

lighting_setup_dvars() {
  level.front_door_light = getEnt("front_door_light", "targetname");
  level.front_door_light setlightintensity(0.0);
  setsaveddvar("MPOKKOPMTN", "64 128 256 512");
  setsaveddvar("NPONLLLSPL", 0.2);
  setsaveddvar("LSNRQTOKRR", 1);
  setsaveddvar("LTQMSPKRKO", 6);
  level.spotupdatelimit = getdvarint("LTQMSPKRKO");
  setsaveddvar("MROOOROPKL", 7);
  level.roundrobinlimit = getdvarint("MROOOROPKL");

  if(getdvarint("LLQQOPKTKM") > 0) {
    return;
  }
  if(level.start_point != "backyard_intro" && level.start_point != "backyard" && level.start_point != "kitchen") {
    wait 2.0;
    setsaveddvar("LKOLRONRNQ", 375);
  }
}

lt_backyard_intro_start() {
  wait 0;
  setsaveddvar("LKOLRONRNQ", 450);
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(2.0, 50, 20, 20);
  wait 0.5;
  level.player setphysicaldepthoffield(2.0, 60, 1, 1);
  wait 2;
  level.kyle thread scripts\engine\sp\utility::dof_enable_autofocus(2.0, 10, undefined, undefined, "tag_eye");
  wait 3;
  level.price thread scripts\engine\sp\utility::dof_enable_autofocus(3.0, 8, undefined, undefined, "tag_eye");
  wait 4.25;
  level.gatelock thread scripts\engine\sp\utility::dof_enable_autofocus(1.8, 15, undefined, undefined, "tag_origin");
  wait 1.25;
  level.price thread scripts\engine\sp\utility::dof_enable_autofocus(1.8, 8, undefined, undefined, "tag_eye");
  wait 3.75;
  scripts\engine\sp\utility::dof_enable(6, 30, 5.0, 5.0, undefined, undefined);
  wait 3.75;
  scripts\engine\sp\utility::dof_enable(12, 100, 2.0, 2.0, undefined, undefined);
  wait 1;
  thread house_exterior_dof();
  thread stack_up_wooden_gate();
}

stack_up_wooden_gate() {
  scripts\engine\utility::flag_wait("lt_wooden_gate");
  setsaveddvar("LKOLRONRNQ", 750);
  thread deploy_ladder();
}

deploy_ladder() {
  scripts\engine\utility::flag_wait("player_deploying_kitchen_ladder");
  setsaveddvar("LKOLRONRNQ", 350);
  scripts\engine\sp\utility::dof_enable(2, 15, 5.0, 5.0, undefined, undefined);
  wait 3.25;
  thread house_exterior_dof();
  scripts\engine\utility::flag_wait("lt_kitchen_visible");
  setsaveddvar("LKOLRONRNQ", 375);
  scripts\engine\utility::flag_wait("player_in_kitchen");
  thread set_sun_disable();
  level thread scripts\engine\sp\utility::dof_disable_autofocus();
}

player_offkitchenladder() {
  thread house_exterior_dof();
}

player_onkitchenladder() {
  scripts\engine\sp\utility::dof_enable(8, 25, 5.0, 5.0, undefined, undefined);
}

house_exterior_dof() {
  level thread scripts\engine\sp\utility::dof_enable_autofocus(4.5, 6.0, 2.0, undefined);
}

light_on_touching() {
  var_0 = getEntArray(self.target, "targetname");

  foreach(var_2 in var_0) {
    var_2.og_intensity = var_2 getlightintensity();
    var_2 setlightintensity(0);
  }

  self endon("death");

  for(;;) {
    self waittill("trigger", var_4);

    foreach(var_2 in var_0)
    var_2 setlightintensity(var_2.og_intensity);

    while(var_4 istouching(self))
      wait 0.1;

    foreach(var_2 in var_0)
    var_2 setlightintensity(0);
  }
}

price_ending_cinematic() {
  thread price_lighting();
  setsaveddvar("MPOKKOPMTN", "32 64 128 256");
  setsaveddvar("LKOLRONRNQ", 100);
  visionsetnaked("townhoused_int_attic_price", 1.5);
  level.player enablephysicaldepthoffieldscripting();

  while(!isDefined(level.clacker))
    waitframe();

  level.clacker thread scripts\engine\sp\utility::dof_enable_autofocus(2.0, 30, undefined, undefined, "trigger");
  wait 5.5;

  while(!isDefined(level.price))
    waitframe();

  level.price thread scripts\engine\sp\utility::dof_enable_autofocus(2.2, 3, undefined, undefined, "j_eyeball_le");
  wait 8.5;
  level thread scripts\engine\sp\utility::dof_enable_autofocus(1.8, 2, undefined);
  wait 0.5;
  visionsetnaked("townhoused_int_attic_price_laptop", 0.5);
}

price_lighting() {
  var_0 = 1.0;
  var_1 = 0.004;
  var_2 = 0.25;
  var_3 = 0.005;
  level.lt_price_attic_key thread lerp_value_up_key(0, var_1, var_0);
  level.lt_price_attic_key setlightradius(60);
  level.lt_price_attic_key setlightfovrange(50, 35);
  level.lt_price_attic_rim thread lerp_value_up_rim(0, var_2, var_0);
  level.lt_price_attic_rim setlightradius(80);
  level.lt_price_attic_rim setlightfovrange(90, 35);
  level.lt_price_attic_laptop thread lerp_value_up_laptop(0, var_3, var_0);
  level.lt_price_attic_laptop setlightradius(60);
  level.lt_price_attic_laptop setlightfovrange(120, 50);

  while(!isDefined(level.price.laptop))
    waitframe();

  level.lt_price_attic_laptop linkTo(level.price.laptop, "tag_origin", (-6, 0, 9), (-30, 0, 0));
  scripts\engine\utility::exploder("lensflare_price");
}

lerp_value_up_key(var_0, var_1, var_2) {
  var_3 = var_1 - var_0;
  var_4 = 0.02;
  var_5 = int(var_2 / var_4);

  if(var_5 > 0) {
    for(var_6 = var_3 / var_5; var_5; var_5--) {
      var_0 = var_0 + var_6;
      level.lt_price_attic_key setlightintensity(var_0);
      wait(var_4);
    }
  }
}

lerp_value_up_rim(var_0, var_1, var_2) {
  var_3 = var_1 - var_0;
  var_4 = 0.02;
  var_5 = int(var_2 / var_4);

  if(var_5 > 0) {
    for(var_6 = var_3 / var_5; var_5; var_5--) {
      var_0 = var_0 + var_6;
      level.lt_price_attic_rim setlightintensity(var_0);
      wait(var_4);
    }
  }
}

lerp_value_up_laptop(var_0, var_1, var_2) {
  var_3 = var_1 - var_0;
  var_4 = 0.02;
  var_5 = int(var_2 / var_4);

  if(var_5 > 0) {
    for(var_6 = var_3 / var_5; var_5; var_5--) {
      var_0 = var_0 + var_6;
      level.lt_price_attic_laptop setlightintensity(var_0);
      wait(var_4);
    }
  }
}

set_sun_enable_disable() {
  for(;;) {
    scripts\engine\utility::flag_wait("sun_enable_disable");
    level.velocity_increase = "foobar";
    thread set_sun_enable();
    scripts\engine\utility::flag_waitopen("sun_enable_disable");

    if(level.velocity_increase == "foobar")
      thread set_sun_disable();
  }
}

set_sun_enable() {
  setsaveddvar("MQRQQONQSL", 1);
  setsaveddvar("NPONLLLSPL", 0.175);
  setsaveddvar("LSNRQTOKRR", 1);
  setsuncolorandintensity(0.002);
}

set_sun_disable() {
  setsuncolorandintensity(0.0);
  waitframe();
  waitframe();
  setsaveddvar("MQRQQONQSL", 0);
  setsaveddvar("LSNRQTOKRR", 2);
}

set_train_moment_shadows() {
  for(;;) {
    scripts\engine\utility::flag_wait("train_lighting_moment");
    level.velocity_increase = "foobar";
    thread set_train_lighting_enable();
    scripts\engine\utility::flag_waitopen("train_lighting_moment");

    if(level.velocity_increase == "foobar")
      thread set_train_lighting_disable();
  }
}

set_front_door_light_enable_disable() {
  for(;;) {
    scripts\engine\utility::flag_wait("door_light_enable_disable");
    level.front_door_light setlightintensity(3.0);
    scripts\engine\utility::flag_waitopen("door_light_enable_disable");
    level.front_door_light setlightintensity(0.0);
    waitframe();
  }
}

set_train_lighting_enable() {}

set_train_lighting_disable() {}