//_createart generated.modify at your own risk. Changing values should be fine.
main() {
  level.tweakfile = true;

  // *Fog section*

  setDvar("scr_fog_exp_halfplane", "1496.71");
  setDvar("scr_fog_exp_halfheight", "384.096");
  setDvar("scr_fog_nearplane", "0");
  setDvar("scr_fog_red", "0.40");
  setDvar("scr_fog_green", "0.52");
  setDvar("scr_fog_blue", "0.60");
  setDvar("scr_fog_baseheight", "-932.654");

  //	// *depth of field section*
  //	level.do_not_use_dof = true;
  //	level.dofDefault["nearStart"] = 0;
  //	level.dofDefault["nearEnd"] = 60;
  //	level.dofDefault["farStart"] = 2000;
  //	level.dofDefault["farEnd"] = 10000;
  //	level.dofDefault["nearBlur"] = 6;
  //	level.dofDefault["farBlur"] = 2;
  //
  //	players = maps\_utility::get_players();
  //	for( i = 0; i < players.size; i++ )
  //	{
  //		players[i] maps\_art::setdefaultdepthoffield();
  //	}

  setDvar("visionstore_glowTweakEnable", "1");
  setDvar("visionstore_glowTweakRadius0", "5");
  setDvar("visionstore_glowTweakRadius1", "0");
  setDvar("visionstore_glowTweakBloomCutoff", "0.260564");
  setDvar("visionstore_glowTweakBloomDesaturation", "0");
  setDvar("visionstore_glowTweakBloomIntensity0", "1.41192");
  setDvar("visionstore_glowTweakBloomIntensity1", "0");
  setDvar("visionstore_glowTweakSkyBleedIntensity0", "0");
  setDvar("visionstore_glowTweakSkyBleedIntensity1", "0");

  //* Fog section *
  level thread fog_settings();

  level thread maps\_utility::set_all_players_visionset("oki2", 0.1);
}

fog_settings() {
  start_dist = 0;
  halfway_dist = 1496;
  halfway_height = 384;
  base_height = -932;
  red = 0.40;
  green = 0.52;
  blue = 0.60;
  trans_time = 0;

  if(IsSplitScreen()) {
    start_dist = 1500;
    halfway_dist = 200;
    halfway_height = 0;
    cull_dist = 4000;
    maps\_utility::set_splitscreen_fog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, trans_time, cull_dist);
  } else {
    SetVolFog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, trans_time);
  }
}
//	setDvar( "scr_fog_disable", "0" );
//
//	setVolFog(0, 1496.71, 384.096, -932.654, 0.501525, 0.498348, 0.506539, 0);
//	maps\_utility::set_vision_set( "oki2", 0 );
//
//}