main() {
  level._effect["vfx_br_zone_80000_static_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_80000_static_s.vfx");
  level._effect["vfx_br_zone_40000_static_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_40000_static_s.vfx");
  level._effect["vfx_br_zone_20000_static_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_20000_static_s.vfx");
  level._effect["vfx_br_zone_15000_static_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_15000_static_s.vfx");
  level._effect["vfx_br_zone_10500_static_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_10500_static_s.vfx");
  level._effect["vfx_br_zone_7000_static_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_7000_static_s.vfx");
  level._effect["vfx_br_zone_4500_static_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_4500_static_s.vfx");
  level._effect["vfx_br_zone_2500_static_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_2500_static_s.vfx");
  level._effect["vfx_br_zone_1000_static_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_1000_static_s.vfx");

  level._effect["vfx_br_zone_160000_80000_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_160000_80000_s.vfx");
  level._effect["vfx_br_zone_80000_40000_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_80000_40000_s.vfx");
  level._effect["vfx_br_zone_40000_20000_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_40000_20000_s.vfx");
  level._effect["vfx_br_zone_50000_20000_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_50000_20000_s.vfx");
  level._effect["vfx_br_zone_20000_15000_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_20000_15000_s.vfx");
  level._effect["vfx_br_zone_15000_7000_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_15000_7000_s.vfx");
  level._effect["vfx_br_zone_15000_10500_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_15000_10500_s.vfx");
  level._effect["vfx_br_zone_10500_7000_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_10500_7000_s.vfx");
  level._effect["vfx_br_zone_7000_4500_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_7000_4500_s.vfx");
  level._effect["vfx_br_zone_4500_2500_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_4500_2500_s.vfx");
  level._effect["vfx_br_zone_2500_1000_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_2500_1000_s.vfx");
  level._effect["vfx_br_zone_1000_0_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_1000_0_s.vfx");
  level._effect["vfx_snatch_ac130_clouds"] = LoadFX("vfx/iw8_mp/gamemode/vfx_snatch_ac130_clouds.vfx");
  level._effect["supplemental_gas"] = loadFX("vfx/iw8_br/gameplay/circle/vfx_br_circle_tut_above.vfx");

  level._effect["vfx_br_infil_ft_quarry"] = LoadFX("vfx/iw8_br/gameplay/infil/vfx_br_infil_ft_quarry.vfx");
  level._effect["vfx_br_distant_fog_main"] = LoadFx("vfx/iw8_br/gen_amb/vfx_br_distant_fog_main.vfx");

  if(getDvar("OKOLRTLORL") != "1")
    scripts\mp\maps\mp_br_quarry\gen\mp_br_quarry_fx::main();
}

CONST_MIN_MIST_DISTANCE = 2048;
CONST_MAX_MIST_DISTANCE = 9000;
CONST_MIN_MIST_HEIGHT_OFFSET = -500;
CONST_MAX_MIST_HEIGHT_OFFSET = 500;

runMistEffects() {
  level.numMistClusters = GetDvarInt("scr_mist_cluster_num", 13);

  if(level.numMistClusters <= 0) {
    return;
  }
  mistLocCenters = [];
  mistLoccenters[0] = (-17431, 26586, 500); //Dam marsh higher;
  mistLoccenters[1] = (-22668, 36629, 2600); //Top of dam
  mistLoccenters[2] = (-38816, 50972, 7200); //Side of volcano
  mistLoccenters[3] = (-18276, 45104, 4285); //Dam radio tower;
  mistLoccenters[4] = (5900, 26084, 790); //Airplane crash near mil base;
  mistLoccenters[5] = (-41485, 338, 2100); //West of Storage;
  mistLoccenters[6] = (22452, -27194, 1500); //Skn Comm Downtown;
  mistLoccenters[7] = (5050, 31027, 1300); //Forest Near Mil Base;
  mistLoccenters[8] = (-39730, 12701, 3115); //Tunnel;
  mistLoccenters[9] = (50871, -47452, 400); //Gulag bridge;
  mistLoccenters[10] = (57555, 3350, 1000); //Lumber Forest;
  mistLoccenters[11] = (-3316, 30454, 3000); //Hills near dam;
  mistLoccenters[12] = (-48791, 46074, 11207); //Top of volcano;
  mistLoccenters[13] = (100, 23546, 1800); //Mountains Across from Layover;
  mistLoccenters[14] = (-9558, -13090, 1100); //Torez;
  mistLoccenters[15] = (20953, 12360, 1800); //Hills above TV;
  mistLoccenters[16] = (12220, 20486, 1600); //Hotel on the Hill;
  mistLoccenters[17] = (-28397, -23638, 860); //Boneyard;
  mistLoccenters[18] = (-31228, -52488, 1600); //City Entrance;
  mistLoccenters[19] = (5491, -41903, 800); //Wheel;
  mistLoccenters[20] = (21263, -43266, 500); //SODO Park;
  mistLoccenters[21] = (34000, -45441, 100); //Port Tenches;
  mistLoccenters[22] = (54616, -31712, 900); //Farms;
  mistLoccenters[23] = (34600, 7013, 1300); //Medical Forest;
  mistLoccenters[24] = (57412, 29600, 4200); //Quarry Outskirt Hills;
  mistLoccenters[25] = (11766, 45690, 2147); //Mil Base North;
  mistLoccenters[26] = (-4331, 40541, 2400); //Mil Base West;
  mistLoccenters[27] = (34702, 18568, 1100); //East Quarry;
  mistLoccenters[28] = (5851, -14938, 1100); //Hospital Hill;
  mistLoccenters[29] = (-14690, -26183, 400); //Train station;
  mistLoccenters[30] = (-18244, -46482, 400); //Construction Hills;
  mistLoccenters[31] = (-39043, -25359, 400); //Construction Hills;
  mistLoccenters[32] = (54615, 15943, 2500); //Quarry Outskirt Hills;	

  if(level.numMistClusters > mistLocCenters.size)
    level.numMistClusters = mistLocCenters.size;

  for(i = 0; i < level.numMistClusters; i++) {
    location = mistLocCenters[i];

    playFX(level._effect["vfx_br_distant_fog_main"], location);

    effectPosition = RotatePointAroundVector((0, 0, 1), (1, 0, 0), RandomFloatRange(0, 90));
    effectPosition = effectPosition * RandomFloatRange(CONST_MIN_MIST_DISTANCE, CONST_MAX_MIST_DISTANCE) + location + (0, 0, RandomFloatRange(CONST_MIN_MIST_HEIGHT_OFFSET, CONST_MAX_MIST_HEIGHT_OFFSET));
    playFX(level._effect["vfx_br_distant_fog_main"], effectPosition);

    effectPosition = RotatePointAroundVector((0, 0, 1), (1, 0, 0), RandomFloatRange(90, 180));
    effectPosition = effectPosition * RandomFloatRange(CONST_MIN_MIST_DISTANCE, CONST_MAX_MIST_DISTANCE) + location + (0, 0, RandomFloatRange(CONST_MIN_MIST_HEIGHT_OFFSET, CONST_MAX_MIST_HEIGHT_OFFSET));
    playFX(level._effect["vfx_br_distant_fog_main"], effectPosition);

    effectPosition = RotatePointAroundVector((0, 0, 1), (1, 0, 0), RandomFloatRange(180, 270));
    effectPosition = effectPosition * RandomFloatRange(CONST_MIN_MIST_DISTANCE, CONST_MAX_MIST_DISTANCE) + location + (0, 0, RandomFloatRange(CONST_MIN_MIST_HEIGHT_OFFSET, CONST_MAX_MIST_HEIGHT_OFFSET));
    playFX(level._effect["vfx_br_distant_fog_main"], effectPosition);

    effectPosition = RotatePointAroundVector((0, 0, 1), (1, 0, 0), RandomFloatRange(270, 359));
    effectPosition = effectPosition * RandomFloatRange(CONST_MIN_MIST_DISTANCE, CONST_MAX_MIST_DISTANCE) + location + (0, 0, RandomFloatRange(CONST_MIN_MIST_HEIGHT_OFFSET, CONST_MAX_MIST_HEIGHT_OFFSET));
    playFX(level._effect["vfx_br_distant_fog_main"], effectPosition);

    waitframe;
  }
}