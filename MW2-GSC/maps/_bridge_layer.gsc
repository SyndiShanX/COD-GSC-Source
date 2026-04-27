/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_bridge_layer.gsc
********************************************************/

#include maps\_vehicle;
#include maps\_vehicle_aianim;
#using_animtree("vehicles");

main(model, type) {
  precacheModel("vehicle_m60a1_bridge");
  build_template("bridge_layer", model, type);
  build_localinit(::init_local);

  build_deathmodel("vehicle_bridge_layer", "vehicle_hummer_destroyed");
  build_drive(%abrams_movement, %abrams_movement_backwards, 10);

  build_deathfx("fire/firelp_med_pm", "TAG_CAB_FIRE", "fire_metal_medium", undefined, undefined, true, 0);
  build_deathfx("explosions/vehicle_explosion_hummer", "tag_deathfx", "car_explode");

  build_treadfx();
  build_life(999, 500, 1500);
  build_team("allies");
  build_compassicon("automobile", false);
}

init_local() {
  model = spawn("script_model", (0, 0, 0));
  model setModel("vehicle_m60a1_bridge");
  model linkto(self, "tag_bridge_attach", (0, 0, 0), (0, 0, 0));
  self.bridge_model = model;
}