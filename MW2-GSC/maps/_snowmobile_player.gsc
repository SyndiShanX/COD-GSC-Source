/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_snowmobile_player.gsc
********************************************************/

#include maps\_vehicle;
#include maps\_vehicle_aianim;
#using_animtree("vehicles");

main(model, type) {
  build_template("snowmobile_player", model, type);
  build_localinit(::init_local);
  build_deathmodel("vehicle_snowmobile", "vehicle_snowmobile_static");
  build_deathfx("explosions/large_vehicle_explosion", undefined, "explo_metal_rand");
  build_treadfx();
  build_life(999, 500, 1500);
  build_aianims(::setanims, ::set_vehicle_anims);
  build_compassicon("automobile", false);
  build_team("allies");
}

init_local() {}

set_vehicle_anims(positions) {
  return positions;
}

#using_animtree("generic_human");
setanims() {
  positions = [];
  for(i = 0; i < 2; i++)
    positions[i] = spawnStruct();

  positions[0].getout_delete = true;

  positions[0].sittag = "tag_driver";
  positions[1].sittag = "tag_passenger";

  return positions;
}