//_createart generated.modify at your own risk. Changing values should be fine.
main() {
  level.tweakfile = true;

  // *Fog section*

  //setDvar("scr_fog_exp_halfplane", "4100");
  //setDvar("scr_fog_exp_halfheight", "1360");
  //setDvar("scr_fog_nearplane", "1100");
  //setDvar("scr_fog_red", "0.62");
  //setDvar("scr_fog_green", "0.59");
  //setDvar("scr_fog_blue", "0.52");
  //setDvar("scr_fog_baseheight", "-448");

  setVolFog(757.425, 1800, 465.087, -1600, 0.74903, 0.74903, 0.74903, 0);
  // setVolFog(<startDist>, <halfwayDist>, <halfwayHeight>, <baseHeight>, <red>, <green>, <blue>, <transition time>)

  VisionSetNaked("mp_outskirts", 0);

  SetCullDist(6000);
}