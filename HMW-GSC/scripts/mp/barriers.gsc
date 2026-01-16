init() {
  level.barrier_maps = [];

  //add_barrier_map_entry("boneyard", ::boneyard_barriers);
  add_barrier_map_entry("cliffhanger", ::cliffhanger_barriers);
  add_barrier_map_entry("contingency", ::contingency_barriers);
  add_barrier_map_entry("dc_whitehouse", ::dc_whitehouse_barriers);
  add_barrier_map_entry("gulag", ::gulag_barriers);
  add_barrier_map_entry("oilrig", ::oilrig_barriers);
  //add_barrier_map_entry("mp_pipeline", ::mp_pipeline_barriers);
  add_barrier_map_entry("mp_terminal", ::mp_terminal_barriers);

  setup_barriers();
}

add_barrier_map_entry(map, func) {
  index = level.barrier_maps.size;
  level.barrier_maps[index] = [];
  level.barrier_maps[index]["map"] = map;
  level.barrier_maps[index]["func"] = func;
}

setup_barriers() {
  current_map = getdvar("mapname");
  foreach(barrier in level.barrier_maps) {
    if(barrier["map"] == current_map) {
      level thread[[barrier["func"]]]();
    }
  }
}

create_barrier(model, model_origin, model_angles) {
  if(!isdefined(model))
    return undefined;

  precachemodel(model);
  barrier = spawn("script_model", model_origin);
  barrier setmodel(model);
  barrier.angles = model_angles;
}

remove_barrier(entity) {
  ent = getent(entity, "targetname");
  if(isdefined(ent))
    ent delete();
}

/*
boneyard_barriers()
{
create_barrier("", vector:new(1791.65, -1950, 120), vector:new(0, 60, 0))
create_barrier("", vector:new(1791.65, -1900, 120), vector:new(0, 60, 0))
create_barrier("", vector:new(1791.65, -2000, 100), vector:new(0, 60, 0))
create_barrier("", vector:new(1791.65, -2050, 100), vector:new(0, 60, 0))
}
*/

cliffhanger_barriers() {
  create_barrier("h1_cs_container_full_red_snow", (-6545, -23700, 1115), (0, 180, 0));
  create_barrier("h1_cs_container_full_red_snow", (-6545, -23960, 1100), (0, 180, 0));

  create_barrier("h1_cs_container_full_red_snow", (-6545, -24220, 1080), (0, 180, 0));
  create_barrier("h1_cs_container_full_red_snow", (-6545, -24480, 1060), (0, 180, 0));
  create_barrier("h1_cs_container_full_red_snow", (-6545, -24740, 1050), (0, 180, 0));
  create_barrier("h1_cs_container_full_red_snow", (-6545, -25000, 1050), (0, 180, 0));
  create_barrier("h1_cs_container_full_red_snow", (-6545, -25260, 1060), (0, 180, 0));
  create_barrier("h1_cs_container_full_red_snow", (-6545, -25520, 1060), (0, 180, 0));
  create_barrier("h1_cs_container_full_red_snow", (-6450, -25780, 1060), (0, 180, 0));

  create_barrier("h1_cs_container_full_red_snow", (-6515.45, -22000, 1200), (0, 180, 0));
  create_barrier("h1_cs_container_full_red_snow", (-6450, -25780, 955), (0, 180, 0));
  create_barrier("h1_cs_container_full_red_snow", (-6450, -26040, 895), (0, 180, 0));

  create_barrier("h1_cs_container_full_red_snow", (-6450, -26040, 1000), (0, 180, 0));
  create_barrier("h1_cs_container_full_red_snow", (-6450, -26300, 895), (0, 180, 0));

  create_barrier("h1_cs_container_full_red_snow", (-6352, -26549, 905), (0, 30, 0));
  create_barrier("h1_cs_container_full_red_snow", (-6352, -26549, 1005), (0, 30, 0));

  create_barrier("h1_cs_container_full_red_snow", (-6023, -26707, 940), (0, 90, 0));
  create_barrier("h1_cs_container_full_red_snow", (-6023, -26707, 1048), (0, 90, 0));

  create_barrier("h1_cs_container_full_red_snow", (-6242, -26779.8, 975), (0, 160, 0));

  create_barrier("h1_cs_container_full_red_snow", (-5943.08, -26882.9, 890), (0, 180, 0));
  create_barrier("h1_cs_container_full_red_snow", (-5943.08, -26882.9, 998), (0, 180, 0));

  create_barrier("h1_cs_container_full_red_snow", (-5943.08, -27142.9, 890), (0, 180, 0));
  create_barrier("h1_cs_container_full_red_snow", (-5943.08, -27142.9, 998), (0, 180, 0));

  create_barrier("h1_cs_container_full_red_snow", (-5943.08, -27402.9, 890), (0, 180, 0));
  create_barrier("h1_cs_container_full_red_snow", (-5943.08, -27662.9, 890), (0, 180, 0));
  create_barrier("h1_cs_container_full_red_snow", (-5943.08, -27922.9, 890), (0, 180, 0));

  create_barrier("h1_cs_container_full_red_snow", (-5943.08, -28182.9, 890), (0, 180, 0));
  create_barrier("h1_cs_container_full_red_snow", (-5943.08, -28442.9, 890), (0, 180, 0));
  create_barrier("h1_cs_container_full_red_snow", (-5943.08, -28702.9, 890), (0, 180, 0));

  create_barrier("h1_cs_container_full_red_snow", (-5943.08, -22002.9, 890), (0, 180, 0));
}

contingency_barriers() {
  create_barrier("h2_con_road_gate", (-17614.5, -1300.49, 980), (0, 120, 0));
  create_barrier("h2_con_road_gate", (-17614.5, -1104.17, 900), (0, 120, 0));
  create_barrier("h2_con_road_gate", (-17614.5, -1104.17, 900), (0, 120, 0));
  create_barrier("h2_con_road_gate", (-17614.5, -1104.17, 900), (0, 120, 0));
  create_barrier("h2_con_road_gate", (-17614.5, -1104.17, 900), (0, 120, 0));
  create_barrier("h2_con_road_gate", (-17614.5, -1104.17, 900), (0, 120, 0));
  create_barrier("h2_con_road_gate", (-17614.5, -1104.17, 900), (0, 120, 0));

  create_barrier("h2_con_road_gate", (-11766, 530.503, 400), (0, 120, 0));
  create_barrier("h2_con_road_gate", (-11766, 530.503, 400), (0, 120, 0));
  create_barrier("h2_con_road_gate", (-11766, 530.503, 400), (0, 120, 0));
  create_barrier("h2_con_road_gate", (-11766, 530.503, 400), (0, 120, 0));
  create_barrier("h2_con_road_gate", (-11766, 530.503, 400), (0, 120, 0));
  create_barrier("h2_con_road_gate", (-11766, 530.503, 400), (0, 120, 0));
  create_barrier("h2_con_road_gate", (-11766, 530.503, 400), (0, 120, 0));
  create_barrier("h2_con_road_gate", (-11766, 530.503, 400), (0, 120, 0));

  create_barrier("h2_con_road_gate", (-11166.4, 3312.88, 610), (0, 270, 0));
  create_barrier("h2_con_road_gate", (-11166.4, 3312.88, 500), (0, 270, 0));
  create_barrier("h2_con_road_gate", (-11166.4, 3312.88, 500), (0, 270, 0));
  create_barrier("h2_con_road_gate", (-11166.4, 3312.88, 500), (0, 270, 0));
  create_barrier("h2_con_road_gate", (-11166.4, 3312.88, 500), (0, 270, 0));
  create_barrier("h2_con_road_gate", (-11166.4, 3112.88, 610), (0, 270, 0));
  create_barrier("h2_con_road_gate", (-11166.4, 3112.88, 500), (0, 270, 0));
  create_barrier("h2_con_road_gate", (-11166.4, 3112.88, 500), (0, 270, 0));
  create_barrier("h2_con_road_gate", (-11166.4, 3112.88, 500), (0, 270, 0));
  create_barrier("h2_con_road_gate", (-11166.4, 3112.88, 500), (0, 270, 0));
  create_barrier("h2_con_road_gate", (-11166.4, 2912.88, 610), (0, 270, 0));
  create_barrier("h2_con_road_gate", (-11166.4, 2912.88, 500), (0, 270, 0));
  create_barrier("h2_con_road_gate", (-11166.4, 2912.88, 500), (0, 270, 0));
  create_barrier("h2_con_road_gate", (-11166.4, 2912.88, 500), (0, 270, 0));
  create_barrier("h2_con_road_gate", (-11166.4, 2912.88, 500), (0, 270, 0));

  create_barrier("h2_con_road_gate", (-11166.4, 2712.88, 610), (0, 270, 0));
  create_barrier("h2_con_road_gate", (-11166.4, 2712.88, 590), (0, 270, 0));
  create_barrier("h2_con_road_gate", (-11166.4, 2672.88, 500), (0, 270, 0));
  create_barrier("h2_con_road_gate", (-11166.4, 2672.88, 500), (0, 270, 0));
  create_barrier("h2_con_road_gate", (-11166.4, 2672.88, 500), (0, 270, 0));
  create_barrier("h2_con_road_gate", (-11166.4, 2672.88, 500), (0, 270, 0));
  create_barrier("h2_con_road_gate", (-11166.4, 2672.88, 500), (0, 270, 0));
  create_barrier("h2_con_road_gate", (-11166.4, 2672.88, 500), (0, 270, 0));
  create_barrier("h2_con_road_gate", (-11166.4, 2672.88, 500), (0, 270, 0));
  create_barrier("h2_con_road_gate", (-11166.4, 2672.88, 500), (0, 270, 0));
}

dc_whitehouse_barriers() {
  create_barrier("com_barrel_blue_rust", (-2517.32, 11638.5, -244.875), (0, 90, 0));
  create_barrier("com_barrel_blue_rust", (-2567.32, 11638.5, -244.875), (0, 90, 0));
  create_barrier("com_dresser", (-2699.5, 11454.5, -200.335), (0, 90, 0));
  create_barrier("com_dresser", (-2843.9, 11438.1, -225.512), (0, 90, 0));
  create_barrier("com_dresser", (-2843.9, 11438.1, -185.512), (0, 90, 0));
  create_barrier("h2_wh_furniture_bookshelf_broken", (-2970.36, 11428.2, -220.157), (0, 180, 0));
}

gulag_barriers() {
  create_barrier("gulag_prison_door", (-3644.38, 160, 1595), (0, 55, 0));
}

oilrig_barriers() {
  create_barrier("machinery_scaffolding_end_railing01", (215, -177, -289), (0, 180, 0));
  create_barrier("machinery_scaffolding_end_railing01", (1142.4, -65, -288), (0, 180, 0));
  create_barrier("machinery_scaffolding_end_railing01", (1146.78, 18, -288), (0, 180, 0));
  remove_barrier("breach_door_volume");
  remove_barrier("breach_solid");
}

mp_terminal_barriers() {
  create_barrier("com_locker_double", (405, 4060, 192), (0, 180, 0));
  create_barrier("com_locker_double", (380, 4060, 192), (0, 170, 0));
  create_barrier("com_locker_double", (355, 4065, 192), (0, 150, 0));
  create_barrier("com_locker_double", (333, 4078, 192), (0, 132, 0));
  create_barrier("com_locker_double", (315, 4097, 192), (0, 119, 0));
  create_barrier("com_locker_double", (305, 4120, 192), (0, 110, 0));
  create_barrier("com_locker_double", (295, 4145, 192), (0, 90, 0));
}

/*
mp_pipeline_barriers()
{
create_barrier("", vector:new(5934.61, 1018.44, 201.761), vector:new(0, 90, 0))
create_barrier("", vector:new(6051.47, 1465.83, 77.5439), vector:new(0, 180, 0))
create_barrier("", vector:new(4721.31, 1685.83, 103.058), vector:new(0, 250, 0))
}
*/