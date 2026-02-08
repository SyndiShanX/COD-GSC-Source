/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\pby_fly.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\_vehicle;

main() {
  clientscripts\_load::main();

  clientscripts\pby_fly_fx::main();
  thread clientscripts\_audio::audio_init(0);

  thread clientscripts\pby_fly_amb::main();

  clientscripts\_vehicle::build_treadfx("pby_blackcat");
  clientscripts\_vehicle::build_treadfx("zero");
  clientscripts\_vehicle::build_treadfx("corsair");

  thread waitforclient(0);

  thread manage_water_sheeting_fx();
  println("*** Client : pby_fly running...");
}

manage_water_sheeting_fx() {
  EnableWaterSheetFX(0);
  thread turn_water_sheeting_on();
  thread turn_water_sheeting_off();
}

turn_water_sheeting_on() {
  while(1) {
    level waittill("water fx on");
    EnableWaterSheetFX(1);
  }
}

turn_water_sheeting_off() {
  while(1) {
    level waittill("water fx off");
    EnableWaterSheetFX(0);
  }
}
build_ptboat_gear() {
  build_gear("jap_ptboat", "vehicle_jap_ship_ptboat_setb", "origin_animate_jnt");
  build_gear("jap_ptboat", "vehicle_jap_ship_ptboat_setc", "origin_animate_jnt");
}

build_fletcher_init() {
  init_function = ::fletcher_client_init;
  build_clientinit("fletcher_destroyer", init_function);
}

fletcher_client_init() {
  x_forward = anglesToForward(self.angles);
  x_right = AnglesToRight(self.angles);
  x_up = AnglesToUp(self.angles);

  self.oerlikon_1 = spawn(0, (0, 0, 0), "script_model");
  self.oerlikon_1 setModel("vehicle_usa_ship_fletcher_oerlikon");
  self.oerlikon_1.origin = self.origin + (-858.02 * x_forward) + (190.36 * x_right) + (144.93 * x_up);
  self.oerlikon_1.angles = self.angles;
  self.oerlikon_1_barrel = spawn(0, (0, 0, 0), "script_model");
  self.oerlikon_1_barrel setModel("vehicle_usa_ship_fletcher_oerlikon_barrel");
  self.oerlikon_1_barrel.origin = self.origin + (-857.17 * x_forward) + (171.91 * x_right) + (193.15 * x_up);
  self.oerlikon_1_barrel.angles = self.angles;

  self.oerlikon_2 = spawn(0, (0, 0, 0), "script_model");
  self.oerlikon_2 setModel("vehicle_usa_ship_fletcher_oerlikon");
  self.oerlikon_2.origin = self.origin + (-915.51 * x_forward) + (190.36 * x_right) + (144.93 * x_up);
  self.oerlikon_2.angles = self.angles;
  self.oerlikon_2_barrel = spawn(0, (0, 0, 0), "script_model");
  self.oerlikon_2_barrel setModel("vehicle_usa_ship_fletcher_oerlikon_barrel");
  self.oerlikon_2_barrel.origin = self.origin + (-914.67 * x_forward) + (171.91 * x_right) + (193.15 * x_up);
  self.oerlikon_2_barrel.angles = self.angles;

  self.oerlikon_3 = spawn(0, (0, 0, 0), "script_model");
  self.oerlikon_3 setModel("vehicle_usa_ship_fletcher_oerlikon");
  self.oerlikon_3.origin = self.origin + (-1109.75 * x_forward) + (190.36 * x_right) + (144.93 * x_up);
  self.oerlikon_3.angles = self.angles;
  self.oerlikon_3_barrel = spawn(0, (0, 0, 0), "script_model");
  self.oerlikon_3_barrel setModel("vehicle_usa_ship_fletcher_oerlikon_barrel");
  self.oerlikon_3_barrel.origin = self.origin + (-1108.9 * x_forward) + (171.91 * x_right) + (193.15 * x_up);
  self.oerlikon_3_barrel.angles = self.angles;

  self.oerlikon_4 = spawn(0, (0, 0, 0), "script_model");
  self.oerlikon_4 setModel("vehicle_usa_ship_fletcher_oerlikon");
  self.oerlikon_4.origin = self.origin + (-858.41 * x_forward) + (-190.13 * x_right) + (144.93 * x_up);
  self.oerlikon_4.angles = self.angles;
  self.oerlikon_4_barrel = spawn(0, (0, 0, 0), "script_model");
  self.oerlikon_4_barrel setModel("vehicle_usa_ship_fletcher_oerlikon_barrel");
  self.oerlikon_4_barrel.origin = self.origin + (-859.34 * x_forward) + (-171.68 * x_right) + (193.15 * x_up);
  self.oerlikon_4_barrel.angles = self.angles;

  self.oerlikon_6 = spawn(0, (0, 0, 0), "script_model");
  self.oerlikon_6 setModel("vehicle_usa_ship_fletcher_oerlikon");
  self.oerlikon_6.origin = self.origin + (-1109.46 * x_forward) + (-190.14 * x_right) + (144.93 * x_up);
  self.oerlikon_6.angles = self.angles;
  self.oerlikon_6_barrel = spawn(0, (0, 0, 0), "script_model");
  self.oerlikon_6_barrel setModel("vehicle_usa_ship_fletcher_oerlikon_barrel");
  self.oerlikon_6_barrel.origin = self.origin + (-1110.31 * x_forward) + (-171.68 * x_right) + (193.15 * x_up);
  self.oerlikon_6_barrel.angles = self.angles;

  self.oerlikon_7 = spawn(0, (0, 0, 0), "script_model");
  self.oerlikon_7 setModel("vehicle_usa_ship_fletcher_oerlikon");
  self.oerlikon_7.origin = self.origin + (-1872.5 * x_forward) + (-92.95 * x_right) + (171.15 * x_up);
  self.oerlikon_7.angles = self.angles;
  self.oerlikon_7_barrel = spawn(0, (0, 0, 0), "script_model");
  self.oerlikon_7_barrel setModel("vehicle_usa_ship_fletcher_oerlikon_barrel");
  self.oerlikon_7_barrel.origin = self.origin + (-1854.05 * x_forward) + (-92.101 * x_right) + (219.36 * x_up);
  self.oerlikon_7_barrel.angles = self.angles;

  self.oerlikon_8 = spawn(0, (0, 0, 0), "script_model");
  self.oerlikon_8 setModel("vehicle_usa_ship_fletcher_oerlikon");
  self.oerlikon_8.origin = self.origin + (-1872.5 * x_forward) + (93.129 * x_right) + (171.14 * x_up);
  self.oerlikon_8.angles = self.angles;
  self.oerlikon_8_barrel = spawn(0, (0, 0, 0), "script_model");
  self.oerlikon_8_barrel setModel("vehicle_usa_ship_fletcher_oerlikon_barrel");
  self.oerlikon_8_barrel.origin = self.origin + (-1854.05 * x_forward) + (93.9777 * x_right) + (219.367 * x_up);
  self.oerlikon_8_barrel.angles = self.angles;

  self.oerlikon_9 = spawn(0, (0, 0, 0), "script_model");
  self.oerlikon_9 setModel("vehicle_usa_ship_fletcher_oerlikon");
  self.oerlikon_9.origin = self.origin + (-1963.65 * x_forward) + (0.35 * x_right) + (171.14 * x_up);
  self.oerlikon_9.angles = self.angles;
  self.oerlikon_9_barrel = spawn(0, (0, 0, 0), "script_model");
  self.oerlikon_9_barrel setModel("vehicle_usa_ship_fletcher_oerlikon_barrel");
  self.oerlikon_9_barrel.origin = self.origin + (-1945.2 * x_forward) + (1.2 * x_right) + (219.367 * x_up);
  self.oerlikon_9_barrel.angles = self.angles;
}