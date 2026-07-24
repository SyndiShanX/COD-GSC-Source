/**************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_wounded\sa_wounded_lighting.gsc
**************************************************************/

main() {
  _id_ACB8();
  thread _id_13468();
  thread _id_13469();
  thread _id_13463();
  thread _id_13464();
  thread _id_1346A();
  thread _id_1346B();
  thread _id_13465();
  thread _id_13466();
  thread _id_13467();
  thread _id_1346C();
  thread _id_8880();
  thread _id_1346D();
  thread _id_13460();
  thread _id_13461();
  thread _id_13462();
  thread _id_13471();
  thread _id_DC77();
  thread _id_DC78();
}

_id_ACB8() {
  scripts\engine\utility::flag_init("set_visionset_hatch_enter");
  scripts\engine\utility::flag_init("set_visionset_hatch_exit");
  scripts\engine\utility::flag_init("set_visionset_hallway_01_enter");
  scripts\engine\utility::flag_init("set_visionset_hallway_01_exit");
  scripts\engine\utility::flag_init("set_visionset_hub_enter");
  scripts\engine\utility::flag_init("set_visionset_hub_exit");
  scripts\engine\utility::flag_init("set_visionset_hallway_02_enter");
  scripts\engine\utility::flag_init("set_visionset_hallway_02_exit");
  scripts\engine\utility::flag_init("set_visionset_hallway_02_exit_armory");
  scripts\engine\utility::flag_init("set_visionset_infirmary_enter");
  scripts\engine\utility::flag_init("set_visionset_infirmary_exit");
  scripts\engine\utility::flag_init("set_visionset_armory_enter");
  scripts\engine\utility::flag_init("set_visionset_armory_enter_02");
  scripts\engine\utility::flag_init("set_visionset_armory_exit");
  scripts\engine\utility::flag_init("set_visionset_vault_enter");
}

_id_13468() {
  level endon("death");
  level endon("explosion_kicked_off");

  for(;;) {
    scripts\engine\utility::flag_wait("set_visionset_hatch_enter");
    scripts\engine\utility::flag_clear("set_visionset_hatch_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_01_enter");
    scripts\engine\utility::flag_clear("set_visionset_hallway_01_exit");
    scripts\engine\utility::flag_clear("set_visionset_hub_enter");
    scripts\engine\utility::flag_clear("set_visionset_hub_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_enter");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_exit");
    scripts\engine\utility::flag_clear("set_visionset_infirmary_enter");
    scripts\engine\utility::flag_clear("set_visionset_infirmary_exit");
    scripts\engine\utility::flag_clear("set_visionset_armory_enter");
    scripts\engine\utility::flag_clear("set_visionset_armory_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_exit_armory");
    scripts\engine\utility::flag_clear("set_visionset_armory_enter_02");
    visionsetalternate(1, 1);
    wait 0.05;
  }
}

_id_13469() {
  level endon("death");
  level endon("nextmission");

  for(;;) {
    scripts\engine\utility::flag_wait("set_visionset_hatch_exit");
    scripts\engine\utility::flag_clear("set_visionset_hatch_enter");
    scripts\engine\utility::flag_clear("set_visionset_hallway_01_enter");
    scripts\engine\utility::flag_clear("set_visionset_hallway_01_exit");
    scripts\engine\utility::flag_clear("set_visionset_hub_enter");
    scripts\engine\utility::flag_clear("set_visionset_hub_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_enter");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_exit");
    scripts\engine\utility::flag_clear("set_visionset_infirmary_enter");
    scripts\engine\utility::flag_clear("set_visionset_infirmary_exit");
    scripts\engine\utility::flag_clear("set_visionset_armory_enter");
    scripts\engine\utility::flag_clear("set_visionset_armory_exit");
    scripts\engine\utility::flag_clear("set_visionset_vault_enter");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_exit_armory");
    scripts\engine\utility::flag_clear("set_visionset_armory_enter_02");
    visionsetalternate(0, 1);
    wait 0.05;
  }
}

_id_13463() {
  level endon("death");
  level endon("explosion_kicked_off");

  for(;;) {
    scripts\engine\utility::flag_wait("set_visionset_hallway_01_enter");
    scripts\engine\utility::flag_clear("set_visionset_hatch_enter");
    scripts\engine\utility::flag_clear("set_visionset_hatch_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_01_exit");
    scripts\engine\utility::flag_clear("set_visionset_hub_enter");
    scripts\engine\utility::flag_clear("set_visionset_hub_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_enter");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_exit");
    scripts\engine\utility::flag_clear("set_visionset_infirmary_enter");
    scripts\engine\utility::flag_clear("set_visionset_infirmary_exit");
    scripts\engine\utility::flag_clear("set_visionset_armory_enter");
    scripts\engine\utility::flag_clear("set_visionset_armory_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_exit_armory");
    scripts\engine\utility::flag_clear("set_visionset_armory_enter_02");
    visionsetalternate(2, 1);
    wait 0.05;
  }
}

_id_13464() {
  level endon("death");
  level endon("explosion_kicked_off");

  for(;;) {
    scripts\engine\utility::flag_wait("set_visionset_hallway_01_exit");
    scripts\engine\utility::flag_clear("set_visionset_hatch_enter");
    scripts\engine\utility::flag_clear("set_visionset_hatch_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_01_enter");
    scripts\engine\utility::flag_clear("set_visionset_hub_enter");
    scripts\engine\utility::flag_clear("set_visionset_hub_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_enter");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_exit");
    scripts\engine\utility::flag_clear("set_visionset_infirmary_enter");
    scripts\engine\utility::flag_clear("set_visionset_infirmary_exit");
    scripts\engine\utility::flag_clear("set_visionset_armory_enter");
    scripts\engine\utility::flag_clear("set_visionset_armory_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_exit_armory");
    scripts\engine\utility::flag_clear("set_visionset_armory_enter_02");
    visionsetalternate(2, 2);
    wait 0.05;
  }
}

_id_1346A() {
  level endon("death");
  level endon("explosion_kicked_off");

  for(;;) {
    scripts\engine\utility::flag_wait("set_visionset_hub_enter");
    scripts\engine\utility::flag_clear("set_visionset_hatch_enter");
    scripts\engine\utility::flag_clear("set_visionset_hatch_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_01_enter");
    scripts\engine\utility::flag_clear("set_visionset_hallway_01_exit");
    scripts\engine\utility::flag_clear("set_visionset_hub_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_enter");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_exit");
    scripts\engine\utility::flag_clear("set_visionset_infirmary_enter");
    scripts\engine\utility::flag_clear("set_visionset_infirmary_exit");
    scripts\engine\utility::flag_clear("set_visionset_armory_enter");
    scripts\engine\utility::flag_clear("set_visionset_armory_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_exit_armory");
    scripts\engine\utility::flag_clear("set_visionset_armory_enter_02");
    visionsetalternate(3, 1.5);
    wait 0.05;
  }
}

_id_1346B() {
  level endon("death");
  level endon("explosion_kicked_off");

  for(;;) {
    scripts\engine\utility::flag_wait("set_visionset_hub_exit");
    scripts\engine\utility::flag_clear("set_visionset_hatch_enter");
    scripts\engine\utility::flag_clear("set_visionset_hatch_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_01_enter");
    scripts\engine\utility::flag_clear("set_visionset_hallway_01_exit");
    scripts\engine\utility::flag_clear("set_visionset_hub_enter");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_enter");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_exit");
    scripts\engine\utility::flag_clear("set_visionset_infirmary_enter");
    scripts\engine\utility::flag_clear("set_visionset_infirmary_exit");
    scripts\engine\utility::flag_clear("set_visionset_armory_enter");
    scripts\engine\utility::flag_clear("set_visionset_armory_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_exit_armory");
    scripts\engine\utility::flag_clear("set_visionset_armory_enter_02");
    visionsetalternate(2, 1.5);
    wait 0.05;
  }
}

_id_13465() {
  level endon("death");
  level endon("explosion_kicked_off");

  for(;;) {
    scripts\engine\utility::flag_wait("set_visionset_hallway_02_enter");
    scripts\engine\utility::flag_clear("set_visionset_hatch_enter");
    scripts\engine\utility::flag_clear("set_visionset_hatch_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_01_enter");
    scripts\engine\utility::flag_clear("set_visionset_hallway_01_exit");
    scripts\engine\utility::flag_clear("set_visionset_hub_enter");
    scripts\engine\utility::flag_clear("set_visionset_hub_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_exit");
    scripts\engine\utility::flag_clear("set_visionset_infirmary_enter");
    scripts\engine\utility::flag_clear("set_visionset_infirmary_exit");
    scripts\engine\utility::flag_clear("set_visionset_armory_enter");
    scripts\engine\utility::flag_clear("set_visionset_armory_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_exit_armory");
    scripts\engine\utility::flag_clear("set_visionset_armory_enter_02");
    visionsetalternate(4, 1.5);
    wait 0.05;
  }
}

_id_13466() {
  level endon("death");
  level endon("explosion_kicked_off");

  for(;;) {
    scripts\engine\utility::flag_wait("set_visionset_hallway_02_exit");
    scripts\engine\utility::flag_clear("set_visionset_hatch_enter");
    scripts\engine\utility::flag_clear("set_visionset_hatch_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_01_enter");
    scripts\engine\utility::flag_clear("set_visionset_hallway_01_exit");
    scripts\engine\utility::flag_clear("set_visionset_hub_enter");
    scripts\engine\utility::flag_clear("set_visionset_hub_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_enter");
    scripts\engine\utility::flag_clear("set_visionset_infirmary_enter");
    scripts\engine\utility::flag_clear("set_visionset_infirmary_exit");
    scripts\engine\utility::flag_clear("set_visionset_armory_enter");
    scripts\engine\utility::flag_clear("set_visionset_armory_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_exit_armory");
    scripts\engine\utility::flag_clear("set_visionset_armory_enter_02");
    visionsetalternate(3, 1.5);
    wait 0.05;
  }
}

_id_13467() {
  level endon("death");
  level endon("explosion_kicked_off");

  for(;;) {
    scripts\engine\utility::flag_wait("set_visionset_hallway_02_exit_armory");
    scripts\engine\utility::flag_clear("set_visionset_hatch_enter");
    scripts\engine\utility::flag_clear("set_visionset_hatch_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_01_enter");
    scripts\engine\utility::flag_clear("set_visionset_hallway_01_exit");
    scripts\engine\utility::flag_clear("set_visionset_hub_enter");
    scripts\engine\utility::flag_clear("set_visionset_hub_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_enter");
    scripts\engine\utility::flag_clear("set_visionset_infirmary_enter");
    scripts\engine\utility::flag_clear("set_visionset_infirmary_exit");
    scripts\engine\utility::flag_clear("set_visionset_armory_enter");
    scripts\engine\utility::flag_clear("set_visionset_armory_exit");
    scripts\engine\utility::flag_clear("set_visionset_armory_enter_02");
    visionsetalternate(6, 1.5);
    wait 0.05;
  }
}

_id_1346C() {
  level endon("death");
  level endon("explosion_kicked_off");

  for(;;) {
    scripts\engine\utility::flag_wait("set_visionset_infirmary_enter");
    scripts\engine\utility::flag_clear("set_visionset_hatch_enter");
    scripts\engine\utility::flag_clear("set_visionset_hatch_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_01_enter");
    scripts\engine\utility::flag_clear("set_visionset_hallway_01_exit");
    scripts\engine\utility::flag_clear("set_visionset_hub_enter");
    scripts\engine\utility::flag_clear("set_visionset_hub_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_enter");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_exit");
    scripts\engine\utility::flag_clear("set_visionset_infirmary_exit");
    scripts\engine\utility::flag_clear("set_visionset_armory_enter");
    scripts\engine\utility::flag_clear("set_visionset_armory_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_exit_armory");
    scripts\engine\utility::flag_clear("set_visionset_armory_enter_02");
    visionsetalternate(5, 1);
    wait 0.05;
  }
}

_id_8880() {
  var_0 = getEnt("hallway_flicker_light_01", "targetname");
  var_1 = randomintrange(50, 80);
  var_2 = 2;
  var_3 = getEntArray("hallway_flicker_light_model_off", "targetname");
  var_4 = getEntArray("hallway_flicker_light_model_on", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  if(!var_3.size || !var_4.size) {
    return;
  }
  scripts\engine\utility::array_thread(var_3, ::_id_8882);
  scripts\engine\utility::array_thread(var_4, ::_id_8881);
  level endon("spawn_infirmary_enforcements");

  for(;;) {
    var_5 = randomfloatrange(0.05, 1.0);
    var_0 setlightintensity(var_1);
    scripts\engine\utility::array_thread(var_3, ::_id_8881);
    scripts\engine\utility::array_thread(var_4, ::_id_8882);
    wait 0.05;
    var_0 setlightintensity(var_2);
    scripts\engine\utility::array_thread(var_3, ::_id_8882);
    scripts\engine\utility::array_thread(var_4, ::_id_8881);
    wait 0.05;
    var_0 setlightintensity(var_1);
    scripts\engine\utility::array_thread(var_3, ::_id_8881);
    scripts\engine\utility::array_thread(var_4, ::_id_8882);
    wait 0.05;
    var_0 setlightintensity(var_2);
    scripts\engine\utility::array_thread(var_3, ::_id_8882);
    scripts\engine\utility::array_thread(var_4, ::_id_8881);
    wait(var_5);
  }
}

_id_8881() {
  self hide();
}

_id_8882() {
  self show();
}

_id_1346D() {
  level endon("death");
  level endon("explosion_kicked_off");

  for(;;) {
    scripts\engine\utility::flag_wait("set_visionset_infirmary_exit");
    scripts\engine\utility::flag_clear("set_visionset_hatch_enter");
    scripts\engine\utility::flag_clear("set_visionset_hatch_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_01_enter");
    scripts\engine\utility::flag_clear("set_visionset_hallway_01_exit");
    scripts\engine\utility::flag_clear("set_visionset_hub_enter");
    scripts\engine\utility::flag_clear("set_visionset_hub_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_enter");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_exit");
    scripts\engine\utility::flag_clear("set_visionset_infirmary_enter");
    scripts\engine\utility::flag_clear("set_visionset_armory_enter");
    scripts\engine\utility::flag_clear("set_visionset_armory_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_exit_armory");
    scripts\engine\utility::flag_clear("set_visionset_armory_enter_02");
    visionsetalternate(4, 1);
    wait 0.05;
  }
}

_id_13460() {
  level endon("death");
  level endon("explosion_kicked_off");

  for(;;) {
    scripts\engine\utility::flag_wait("set_visionset_armory_enter");
    scripts\engine\utility::flag_clear("set_visionset_hatch_enter");
    scripts\engine\utility::flag_clear("set_visionset_hatch_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_01_enter");
    scripts\engine\utility::flag_clear("set_visionset_hallway_01_exit");
    scripts\engine\utility::flag_clear("set_visionset_hub_enter");
    scripts\engine\utility::flag_clear("set_visionset_hub_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_enter");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_exit");
    scripts\engine\utility::flag_clear("set_visionset_infirmary_enter");
    scripts\engine\utility::flag_clear("set_visionset_infirmary_exit");
    scripts\engine\utility::flag_clear("set_visionset_armory_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_exit_armory");
    scripts\engine\utility::flag_clear("set_visionset_armory_enter_02");
    visionsetalternate(6, 5);
    wait 0.05;
  }
}

_id_13461() {
  level endon("death");
  level endon("explosion_kicked_off");

  for(;;) {
    scripts\engine\utility::flag_wait("set_visionset_armory_enter_02");
    scripts\engine\utility::flag_clear("set_visionset_hatch_enter");
    scripts\engine\utility::flag_clear("set_visionset_hatch_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_01_enter");
    scripts\engine\utility::flag_clear("set_visionset_hallway_01_exit");
    scripts\engine\utility::flag_clear("set_visionset_hub_enter");
    scripts\engine\utility::flag_clear("set_visionset_hub_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_enter");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_exit");
    scripts\engine\utility::flag_clear("set_visionset_infirmary_enter");
    scripts\engine\utility::flag_clear("set_visionset_infirmary_exit");
    scripts\engine\utility::flag_clear("set_visionset_armory_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_exit_armory");
    visionsetalternate(6, 1);
    wait 0.05;
  }
}

_id_13462() {
  level endon("death");
  level endon("explosion_kicked_off");

  for(;;) {
    scripts\engine\utility::flag_wait("set_visionset_armory_exit");
    scripts\engine\utility::flag_clear("set_visionset_hatch_enter");
    scripts\engine\utility::flag_clear("set_visionset_hatch_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_01_enter");
    scripts\engine\utility::flag_clear("set_visionset_hallway_01_exit");
    scripts\engine\utility::flag_clear("set_visionset_hub_enter");
    scripts\engine\utility::flag_clear("set_visionset_hub_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_enter");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_exit");
    scripts\engine\utility::flag_clear("set_visionset_infirmary_enter");
    scripts\engine\utility::flag_clear("set_visionset_infirmary_exit");
    scripts\engine\utility::flag_clear("set_visionset_armory_enter");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_exit_armory");
    scripts\engine\utility::flag_clear("set_visionset_armory_enter_02");
    visionsetalternate(5, 1);
    wait 0.05;
  }
}

_id_13471() {
  level endon("death");
  level endon("explosion_kicked_off");

  for(;;) {
    scripts\engine\utility::flag_wait("set_visionset_vault_enter");
    scripts\engine\utility::flag_clear("set_visionset_hatch_enter");
    scripts\engine\utility::flag_clear("set_visionset_hatch_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_01_enter");
    scripts\engine\utility::flag_clear("set_visionset_hallway_01_exit");
    scripts\engine\utility::flag_clear("set_visionset_hub_enter");
    scripts\engine\utility::flag_clear("set_visionset_hub_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_enter");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_exit");
    scripts\engine\utility::flag_clear("set_visionset_infirmary_enter");
    scripts\engine\utility::flag_clear("set_visionset_infirmary_exit");
    scripts\engine\utility::flag_clear("set_visionset_armory_enter");
    scripts\engine\utility::flag_clear("set_visionset_armory_exit");
    scripts\engine\utility::flag_clear("set_visionset_hallway_02_exit_armory");
    scripts\engine\utility::flag_clear("set_visionset_armory_enter_02");
    visionsetalternate(6, 1);
    wait 0.05;
  }
}

_id_DC77() {
  var_0 = getEnt("high_flicker_light_01_on", "targetname");
  var_1 = getEnt("high_flicker_light_01_off", "targetname");

  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  var_1 show();
  var_0 hide();
  self endon("explosion_kicked_off");
  self endon("death");

  for(;;) {
    var_2 = randomfloatrange(0.05, 1.0);
    var_3 = randomfloatrange(0.75, 1.5);
    var_1 hide();
    var_0 show();
    wait 0.05;
    var_1 show();
    var_0 hide();
    wait 0.1;
    var_1 hide();
    var_0 show();
    wait 0.05;
    var_1 show();
    var_0 hide();
    wait 0.1;
    var_1 hide();
    var_0 show();
    wait(var_3);
    var_1 show();
    var_0 hide();
    wait(var_2);
  }
}

_id_DC78() {
  var_0 = getEnt("high_flicker_light_02", "targetname");
  var_1 = randomintrange(40, 100);
  var_2 = 1;
  var_3 = getEnt("high_flicker_light_02_on", "targetname");
  var_4 = getEnt("high_flicker_light_02_off", "targetname");

  if(!isDefined(var_3) || !isDefined(var_4)) {
    return;
  }
  var_4 show();
  var_3 hide();
  self endon("explosion_kicked_off");
  self endon("death");

  for(;;) {
    var_5 = randomfloatrange(0.05, 1.0);
    var_6 = randomfloatrange(0.75, 1.5);
    var_0 setlightintensity(var_1);
    var_4 hide();
    var_3 show();
    wait 0.05;
    var_0 setlightintensity(var_2);
    var_4 show();
    var_3 hide();
    wait 0.1;
    var_0 setlightintensity(var_1);
    var_4 hide();
    var_3 show();
    wait 0.05;
    var_0 setlightintensity(var_2);
    var_4 show();
    var_3 hide();
    wait 0.1;
    var_0 setlightintensity(var_1);
    var_4 hide();
    var_3 show();
    wait(var_6);
    var_0 setlightintensity(var_2);
    var_4 show();
    var_3 hide();
    wait(var_5);
  }
}