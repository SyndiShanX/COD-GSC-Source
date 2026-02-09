// This function should take care of grain and glow settings for each map, plus anything else that artists
// need to be able to tweak without bothering level designers.
/include maps\_utility;#include common_scripts\utility;
#include maps\mp\_utility;

main() {
  if(getDvar("scr_art_tweak") == "" || getDvar("scr_art_tweak") == "0") {
    setDvar("scr_art_tweak", 0);
  }

  if(getDvar("scr_dof_enable") == "") {
    setDvar("scr_dof_enable", "1");
  }

  if(getDvar("scr_cinematic_autofocus") == "") {
    setDvar("scr_cinematic_autofocus", "1");
  }

  if(getDvar("scr_art_visionfile") == "") {
    setDvar("scr_art_visionfile", level.script);
  }

  if(getDvar("debug_reflection") == "") {
    setDvar("debug_reflection", "0");
  }

  PrecacheModel("test_sphere_silver");
  level thread debug_reflection();

  if(!isDefined(level.dofDefault)) {
    level.dofDefault["nearStart"] = 0;
    level.dofDefault["nearEnd"] = 1;
    level.dofDefault["farStart"] = 8000;
    level.dofDefault["farEnd"] = 10000;
    level.dofDefault["nearBlur"] = 6;
    level.dofDefault["farBlur"] = 0;
  }

  level.curDoF = (level.dofDefault["farStart"] - level.dofDefault["nearEnd"]) / 2;

  //	if( GetDvarInt( "scr_dof_enable" ) )
  //		thread adsDoF();

  thread tweakart();

  if(!isDefined(level.script)) {
    level.script = tolower(getDvar("mapname"));
  }

  // Grain has been cut
  /*
	if( getDvar( "r_grainfilter" ) == "" )
	{
		setDvar( "r_grainfilter", "1" );
	}
	thread grain_filter();
	 */

}

//grain_filter()
//{
//// Grain has been cut.
// /*
//	//* * * * * Full screen grain filter * * * * *
//	overlay = undefined;
//	precacheShader( "overlay_grain" );
//	for( ;; )
//	{
//		if( GetDvarfloat( "r_grainfilter" ) > 0 )
//		{
//			if( !isDefined( overlay ) )
//			{
//				overlay = newHudElem();
//				overlay.x = 0;
//				overlay.y = 0;
//				overlay setshader( "overlay_grain", 640, 480 );
//				overlay.alignX = "left";
//				overlay.alignY = "top";
//				overlay.horzAlign = "fullscreen";
//				overlay.vertAlign = "fullscreen";
//			}
//		}
//		else
//		{
//			if( isDefined( overlay ) )
//				overlay destroy();
//		}
//		if( isDefined( overlay ) )
//			overlay.alpha = level.grainstrength * GetDvarfloat( "r_grainfilter" );
//		wait 0.05;
//	}
// */
//}

artfxprintln(file, string) {
  // printing to file is optional now
  if(file == -1) {
    return;
  }
  fprintln(file, string);
}

// Nate - hack Fixmed and replace with proper script command call once it's fixed.
// assumes " " as the deliiter. I'm not getting fancy.
// I would really like to go work on jeepride so here's a
// quick function that works for now untill engineering fixes strtok.

strtok_loc(string, par1) {
  stringlist = [];
  indexstring = "";
  for(i = 0; i < string.size; i++) {
    if(string[i] == " ") {
      stringlist[stringlist.size] = indexstring;
      indexstring = "";
    } else {
      indexstring = indexstring + string[i];
    }
  }
  if(indexstring.size) {
    stringlist[stringlist.size] = indexstring;
  }
  return stringlist;
}

setfogsliders() {
  //fixme.replace strtok_loc with strtok if it ever works properly.
  fogall = strtok_loc(getDvar("g_fogColorReadOnly"), " ");
  red = fogall[0];
  green = fogall[1];
  blue = fogall[2];
  halfplane = getDvar("g_fogHalfDistReadOnly");
  nearplane = getDvar("g_fogStartDistReadOnly");

  if(!isDefined(red) || !isDefined(green) || !isDefined(blue) || !isDefined(halfplane) || !isDefined(halfplane)
  ) {
    red = 1;
    green = 1;
    blue = 1;
    halfplane = 10000001;
    nearplane = 10000000;
  }
  setDvar("scr_fog_exp_halfplane", halfplane);
  setDvar("scr_fog_nearplane", nearplane);
  setDvar("scr_fog_red", red);
  setDvar("scr_fog_green", green);
  setDvar("scr_fog_blue", blue);
}

tweakart() {
  if(!isDefined(level.tweakfile)) {
    level.tweakfile = false;
  }

  // blah scriptgen stuff ignore this.
  //	if( level.tweakfile && level.bScriptgened )
  //		script_gen_dump_addline( "maps\\createart\\" + level.script + "_art::main(); ", level.script + "_art" ); // adds to scriptgendump
  //
  // Default values

  if(getDvar("scr_fog_red") == "") {
    setDvar("scr_fog_exp_halfplane", "500");
    setDvar("scr_fog_exp_halfheight", "500");
    setDvar("scr_fog_nearplane", "0");
    setDvar("scr_fog_baseheight", "0");
    setDvar("scr_fog_red", "0.5");
    setDvar("scr_fog_green", "0.5");
    setDvar("scr_fog_blue", "0.5");
  }

  // not in DEVGUI
  setDvar("scr_fog_fraction", "1.0");
  setDvar("scr_art_dump", "0");

  // update the devgui variables to current settings
  setDvar("scr_dof_nearStart", level.dofDefault["nearStart"]);
  setDvar("scr_dof_nearEnd", level.dofDefault["nearEnd"]);
  setDvar("scr_dof_farStart", level.dofDefault["farStart"]);
  setDvar("scr_dof_farEnd", level.dofDefault["farEnd"]);
  setDvar("scr_dof_nearBlur", level.dofDefault["nearBlur"]);
  setDvar("scr_dof_farBlur", level.dofDefault["farBlur"]);

  // not in DEVGUI
  level.fogfraction = 1.0;

  file = undefined;
  filename = undefined;

  // set dofvars from < levelname > _art.gsc
  //	dofvarupdate();


  for(;;) {
    while(GetDvarint("scr_art_tweak") == 0) {
      assertex(getDvar("scr_art_dump") == "0", "Must Enable Art Tweaks to export _art file.");
      wait .05;
      if(!GetDvarint("scr_art_tweak") == 0) {
        setfogsliders(); //sets the sliders to whatever the current fog value is
      }
    }


    if(GetDvarint("scr_art_tweak_message")) {
      setDvar("scr_art_tweak_message", "0");
      iprintlnbold("ART TWEAK ENABLED");
    }

    // OLD functions cuts the fog values by a fraction. not in menus
    tweakfog_fraction();

    //translate the slider values to script variables

    level.fogexphalfplane = GetDvarfloat("scr_fog_exp_halfplane");
    level.fogexphalfheight = GetDvarfloat("scr_fog_exp_halfheight");
    level.fognearplane = GetDvarfloat("scr_fog_nearplane");
    level.fogred = GetDvarfloat("scr_fog_red");
    level.foggreen = GetDvarfloat("scr_fog_green");
    level.fogblue = GetDvarfloat("scr_fog_blue");
    level.fogbaseheight = GetDvarfloat("scr_fog_baseheight");

    //		dofvarupdate();

    // catch all those cases where a slider can be pushed to a place of conflict
    fovslidercheck();

    dump = dumpsettings(); // dumps and returns true if the dump dvar is set

    // updates fog to the variables

    if(!GetDvarint("scr_fog_disable")) {
      setVolFog(level.fognearplane, level.fogexphalfplane, level.fogexphalfheight, level.fogbaseheight, level.fogred, level.foggreen, level.fogblue, 0);
    } else {
      setExpFog(100000000000, 100000000001, 0, 0, 0, 0); // couldn't find discreet fog disabling other than to never set it in the first place
    }

    //		level.player setDefaultDepthOfField();
    if(dump) {
      iprintlnbold("Art settings dumped success!");
      addstring = "maps\\createart\\" + level.script + "_art::main(); ";
      if(level.bScriptgened) {
        //				script_gen_dump_addline( addstring, level.script + "_art" ); // adds to scriptgendump
        //				maps\_load::script_gen_dump(); // dump scriptgen link
      }
      //			else
      //				assertex( level.tweakfile, "remove all art setting in " + level.script + ".gsc and add the following line before _load: " + addstring );
      setDvar("scr_art_dump", "0");
    }
    wait .1;
  }

}

fovslidercheck() {
  // catch all those cases where a slider can be pushed to a place of conflict
  if(level.dofDefault["nearStart"] >= level.dofDefault["nearEnd"]) {
    level.dofDefault["nearStart"] = level.dofDefault["nearEnd"] - 1;
    setDvar("scr_dof_nearStart", level.dofDefault["nearStart"]);
  }
  if(level.dofDefault["nearEnd"] <= level.dofDefault["nearStart"]) {
    level.dofDefault["nearEnd"] = level.dofDefault["nearStart"] + 1;
    setDvar("scr_dof_nearEnd", level.dofDefault["nearEnd"]);
  }
  if(level.dofDefault["farStart"] >= level.dofDefault["farEnd"]) {
    level.dofDefault["farStart"] = level.dofDefault["farEnd"] - 1;
    setDvar("scr_dof_farStart", level.dofDefault["farStart"]);
  }
  if(level.dofDefault["farEnd"] <= level.dofDefault["farStart"]) {
    level.dofDefault["farEnd"] = level.dofDefault["farStart"] + 1;
    setDvar("scr_dof_farEnd", level.dofDefault["farEnd"]);
  }
  if(level.dofDefault["farBlur"] >= level.dofDefault["nearBlur"]) {
    level.dofDefault["farBlur"] = level.dofDefault["nearBlur"] - .1;
    setDvar("scr_dof_farBlur", level.dofDefault["farBlur"]);
  }
  if(level.dofDefault["farStart"] <= level.dofDefault["nearEnd"]) {
    level.dofDefault["farStart"] = level.dofDefault["nearEnd"] + 1;
    setDvar("scr_dof_farStart", level.dofDefault["farStart"]);
  }
}

dumpsettings() {
  if(getDvar("scr_art_dump") == "0") {
    return false;
  }
  dump = true;

  filename = "createart/" + getDvar("scr_art_visionfile") + "_art.gsc";

  //////////////////

  file = openfile(filename, "write");

  assertex(file != -1, "File not writeable( maybe you should check it out ): " + filename);
  if(file == -1) {
    dump = false;
  }


  artfxprintln(file, "// _createart generated.modify at your own risk. Changing values should be fine.");
  artfxprintln(file, "main()");
  artfxprintln(file, "{");

  artfxprintln(file, "");
  artfxprintln(file, "\tlevel.tweakfile = true; ");
  artfxprintln(file, " ");

  //	artfxprintln( file, "\t//* depth of field section * " );
  //	artfxprintln( file, "" );

  //	artfxprintln( file, "\tlevel.dofDefault[\"nearStart\"] = " + GetDvarint( "scr_dof_nearStart" ) + "; " );
  //	artfxprintln( file, "\tlevel.dofDefault[\"nearEnd\"] = " + GetDvarint( "scr_dof_nearEnd" ) + "; " );
  //	artfxprintln( file, "\tlevel.dofDefault[\"farStart\"] = " + GetDvarint( "scr_dof_farStart" ) + "; " );
  //	artfxprintln( file, "\tlevel.dofDefault[\"farEnd\"] = " + GetDvarint( "scr_dof_farEnd" ) + "; " );
  //	artfxprintln( file, "\tlevel.dofDefault[\"nearBlur\"] = " + GetDvarfloat( "scr_dof_nearBlur" ) + "; " );
  //	artfxprintln( file, "\tlevel.dofDefault[\"farBlur\"] = " + GetDvarfloat( "scr_dof_farBlur" ) + "; " );


  //	artfxprintln( file, "\tgetent( \"player\", \"classname\" ) maps\\_art::setdefaultdepthoffield(); " );

  // vision store variables are a quick and dirty method of storing vision file values to the script so that next time we write everything they don't get interupted

  artfxprintln(file, "");
  artfxprintln(file, "\t//* Fog section * ");
  artfxprintln(file, "");

  artfxprintln(file, "\tsetDvar( \"scr_fog_exp_halfplane\"" + ", " + "\"" + level.fogexphalfplane + "\"" + " ); ");
  artfxprintln(file, "\tsetDvar( \"scr_fog_exp_halfheight\"" + ", " + "\"" + level.fogexphalfheight + "\"" + " ); ");
  artfxprintln(file, "\tsetDvar( \"scr_fog_nearplane\"" + ", " + "\"" + level.fognearplane + "\"" + " ); ");
  artfxprintln(file, "\tsetDvar( \"scr_fog_red\"" + ", " + "\"" + level.fogred + "\"" + " ); ");
  artfxprintln(file, "\tsetDvar( \"scr_fog_green\"" + ", " + "\"" + level.foggreen + "\"" + " ); ");
  artfxprintln(file, "\tsetDvar( \"scr_fog_blue\"" + ", " + "\"" + level.fogblue + "\"" + " ); ");
  artfxprintln(file, "\tsetDvar( \"scr_fog_baseheight\"" + ", " + "\"" + level.fogbaseheight + "\"" + " ); ");

  artfxprintln(file, "");
  if(!GetDvarint("scr_fog_disable")) {
    artfxprintln(file, "\tsetVolFog( " + level.fognearplane + ", " + level.fogexphalfplane + ", " + level.fogexphalfheight + ", " + level.fogbaseheight + ", " + level.fogred + ", " + level.foggreen + ", " + level.fogblue + ", 0 ); ");
  }

  artfxprintln(file, "\tVisionSetNaked( \"" + level.script + "\", 0 ); ");

  artfxprintln(file, "");
  artfxprintln(file, "}");

  saved = closefile(file);
  assertex((saved == 1), "File not saved( see above message? ): " + filename);
  if(!saved) {
    dump = false;
  }
  //////////////////////////////

  visionFilename = "vision/" + getDvar("scr_art_visionfile") + ".vision";
  file = openfile(visionFilename, "write");

  assertex((file != -1), "File not writeable( may need checked out of P4 ): " + filename);

  artfxprintln(file, "r_glow\"" + getDvar("r_glowTweakEnable") + "\"");
  artfxprintln(file, "r_glowRadius0 \"" + getDvar("r_glowTweakRadius0") + "\"");
  artfxprintln(file, "r_glowRadius1 \"" + getDvar("r_glowTweakRadius1") + "\"");
  artfxprintln(file, "r_glowBloomCutoff \"" + getDvar("r_glowTweakBloomCutoff") + "\"");
  artfxprintln(file, "r_glowBloomDesaturation \"" + getDvar("r_glowTweakBloomDesaturation") + "\"");
  artfxprintln(file, "r_glowBloomIntensity0 \"" + getDvar("r_glowTweakBloomIntensity0") + "\"");
  artfxprintln(file, "r_glowBloomIntensity1 \"" + getDvar("r_glowTweakBloomIntensity1") + "\"");
  artfxprintln(file, "r_glowSkyBleedIntensity0\"" + getDvar("r_glowTweakSkyBleedIntensity0") + "\"");
  artfxprintln(file, "r_glowSkyBleedIntensity1\"" + getDvar("r_glowTweakSkyBleedIntensity1") + "\"");
  artfxprintln(file, " ");
  artfxprintln(file, "r_filmEnable\"" + getDvar("r_filmTweakEnable") + "\"");
  artfxprintln(file, "r_filmContrast\"" + getDvar("r_filmTweakContrast") + "\"");
  artfxprintln(file, "r_filmBrightness\"" + getDvar("r_filmTweakBrightness") + "\"");
  artfxprintln(file, "r_filmDesaturation\"" + getDvar("r_filmTweakDesaturation") + "\"");
  artfxprintln(file, "r_filmInvert\"" + getDvar("r_filmTweakInvert") + "\"");
  artfxprintln(file, "r_filmLightTint \"" + getDvar("r_filmTweakLightTint") + "\"");
  artfxprintln(file, "r_filmDarkTint\"" + getDvar("r_filmTweakDarkTint") + "\"");

  saved = closefile(file);
  assertex((saved == 1), "File not saved( see above message? ): " + visionFilename);
  if(dump) {
    iprintlnbold("ART DUMPED SUCCESSFULLY");
  }
  return dump;

}

tweakfog_fraction() {
  fogfraction = GetDvarfloat("scr_fog_fraction");
  if(fogfraction != level.fogfraction) {
    level.fogfraction = fogfraction;
  } else {
    return;
  }

  color = [];
  color[0] = GetDvarfloat("scr_fog_red");
  color[1] = GetDvarfloat("scr_fog_green");
  color[2] = GetDvarfloat("scr_fog_blue");

  setDvar("scr_fog_fraction", 1);
  if(fogfraction < 0) {
    println("no negative numbers please.");
    return;
  }

  fc = [];
  larger = 1;
  for(i = 0; i < color.size; i++) {
    fc[i] = fogfraction * color[i];
    if(fc[i] > larger) {
      larger = fc[i];
    }
  }

  if(larger > 1) {
    for(i = 0; i < fc.size; i++) {
      fc[i] = fc[i] / larger;
    }
  }

  setDvar("scr_fog_red", fc[0]);
  setDvar("scr_fog_green", fc[1]);
  setDvar("scr_fog_blue", fc[2]);
}

debug_reflection() {
  level.debug_reflection = 0;

  while(1) {
    wait(0.1);

    if((getDvar("debug_reflection") == "2" && level.debug_reflection != 2) || (getDvar("debug_reflection") == "3" && level.debug_reflection != 3)) {
      remove_reflection_objects();
      if(getDvar("debug_reflection") == "2") {
        create_reflection_objects();
        level.debug_reflection = 2;
      } else {
        create_reflection_objects();
        create_reflection_object();
        level.debug_reflection = 3;
      }
    } else if(getDvar("debug_reflection") == "1" && level.debug_reflection != 1) {
      remove_reflection_objects();
      create_reflection_object();
      level.debug_reflection = 1;
    } else if(getDvar("debug_reflection") == "0" && level.debug_reflection != 0) {
      remove_reflection_objects();
      level.debug_reflection = 0;
    }
  }

}

remove_reflection_objects() {
  if((level.debug_reflection == 2 || level.debug_reflection == 3) && isDefined(level.debug_reflection_objects)) {
    for(i = 0; i < level.debug_reflection_objects.size; i++) {
      level.debug_reflection_objects[i] Delete();
    }
    level.debug_reflection_objects = undefined;
  }

  if(level.debug_reflection == 1 || level.debug_reflection == 3) {
    level.debug_reflectionobject Delete();
  }
}

create_reflection_objects() {
  reflection_locs = GetReflectionLocs();
  for(i = 0; i < reflection_locs.size; i++) {
    level.debug_reflection_objects[i] = spawn("script_model", reflection_locs[i]);
    level.debug_reflection_objects[i] setModel("test_sphere_silver");
  }
}

create_reflection_object() {
  players = get_players();
  while(players.size < 1) {
    wait(0.5);
    players = get_players();
  }

  player = players[0];

  level.debug_reflectionobject = spawn("script_model", player getEye() + (VectorScale(anglesToForward(player.angles), 100)));
  level.debug_reflectionobject setModel("test_sphere_silver");
  level.debug_reflectionobject.origin = player getEye() + (VectorScale(anglesToForward(player getplayerangles()), 100));
  player thread debug_reflection_buttons();

}

debug_reflection_buttons() {
  self endon("death");

  offset = 100;
  lastoffset = offset;
  offsetinc = 50;
  while(getDvar("debug_reflection") == "1" || getDvar("debug_reflection") == "3") {
    if(self buttonpressed("BUTTON_X")) {
      offset += offsetinc;
    }

    if(self ButtonPressed("BUTTON_Y")) {
      offset -= offsetinc;
    }

    if(offset > 1000) {
      offset = 1000;
    }

    if(offset < 64) {
      offset = 64;
    }

    level.debug_reflectionobject.origin = self getEye() + (VectorScale(anglesToForward(self GetPlayerAngles()), offset));
    lastoffset = offset;

    line(level.debug_reflectionobject.origin, getreflectionorigin(level.debug_reflectionobject.origin), (1, 0, 0), true, 1);

    wait(0.05);
  }
}

//cloudlight( sunlight_bright, sunlight_dark, diffuse_high, diffuse_low )
//{
//	level.sunlight_bright = sunlight_bright;
//	level.sunlight_dark = sunlight_dark;
//	level.diffuse_high = diffuse_high;
//	level.diffuse_low = diffuse_low;
//
//	setDvar( "r_lighttweaksunlight", level.sunlight_dark );
//	setDvar( "r_lighttweakdiffusefraction", level.diffuse_low );
//	direction = "up";
//
//	for( ;; )
//	{
//		sunlight = GetDvarFloat( "r_lighttweaksunlight" );
//		jitter = scale( 1 + randomint( 21 ) );
//
//		flip = randomint( 2 );
//		if( flip )
//			jitter = jitter * - 1;
//		
//		if( direction == "up" )
//			next_target = sunlight + scale( 30 ) + jitter;
//		else
//			next_target = sunlight - scale( 30 ) + jitter;
//	
//		// iprintln( "jitter = ", jitter );
//		if( next_target >= level.sunlight_bright )
//		{
//			next_target = level.sunlight_bright;
//			direction = "down";
//		}
//		
//		if( next_target <= level.sunlight_dark )
//		{
//			next_target = level.sunlight_dark;
//			direction = "up";
//		}
//
//		if( next_target > sunlight )
//			brighten( next_target, ( 3 + randomint( 3 ) ), .05 );
//		else
//			darken( next_target, ( 3 + randomint( 3 ) ), .05 );
//	}
//}
//
//brighten( target_sunlight, time, freq )
//{
//	// iprintln( "Brightening sunlight to ", target_sunlight );
//	sunlight = GetDvarFloat( "r_lighttweaksunlight" );
//	// diffuse = GetDvarFloat( "r_lighttweakdiffusefraction" );
//	// iprintln( "sunlight = ", sunlight );
//	// iprintln( "diffuse = ", diffuse );
//		
//	totalchange = target_sunlight - sunlight;
//	changeamount = totalchange /( time / freq );
//	// iprintln( "totalchange = ", totalchange );
//	// iprintln( "changeamount = ", changeamount );
//	
//	while( time > 0 )
//	{
//		time = time - freq;
//		
//		sunlight = sunlight + changeamount;
//		setDvar( "r_lighttweaksunlight", sunlight );
//		// iprintln( "^6sunlight = ", sunlight );
//
//		frac = ( sunlight - level.sunlight_dark ) /( level.sunlight_bright - level.sunlight_dark );
//		diffuse = level.diffuse_high +( level.diffuse_low - level.diffuse_high ) * frac;
//		setDvar( "r_lighttweakdiffusefraction", diffuse );
//		// iprintln( "^6diffuse = ", diffuse );
//
//		wait freq;
//	}
//}
//
//darken( target_sunlight, time, freq )
//{
//	// iprintln( "Darkening sunlight to ", target_sunlight );
//	sunlight = GetDvarFloat( "r_lighttweaksunlight" );
//	// diffuse = GetDvarFloat( "r_lighttweakdiffusefraction" );
//	// iprintln( "sunlight = ", sunlight );
//	// iprintln( "diffuse = ", diffuse );
//		
//	totalchange = sunlight - target_sunlight;
//	changeamount = totalchange /( time / freq );
//	// iprintln( "totalchange = ", totalchange );
//	// iprintln( "changeamount = ", changeamount );
//	
//	while( time > 0 )
//	{
//		time = time - freq;
//		
//		sunlight = sunlight - changeamount;
//		setDvar( "r_lighttweaksunlight", sunlight );
//		// iprintln( "^6sunlight = ", sunlight );
//
//		frac = ( sunlight - level.sunlight_dark ) /( level.sunlight_bright - level.sunlight_dark );
//		diffuse = level.diffuse_high +( level.diffuse_low - level.diffuse_high ) * frac;
//		setDvar( "r_lighttweakdiffusefraction", diffuse );
//		// iprintln( "^6diffuse = ", diffuse );
//
//		wait freq;
//	}
//}
//
//scale( percent )
//{
//		frac = percent / 100;
//		return( level.sunlight_dark + frac *( level.sunlight_bright - level.sunlight_dark ) ) - level.sunlight_dark;
//}

//adsDoF()
//{
//	level.dof = level.dofDefault;
//	
//	for( ;; )
//	{
//		if( GetDvarInt( "scr_cinematic" ) )
//			updateCinematicDoF();
//		else if( GetDvarInt( "scr_dof_enable" ) && !GetDvarInt( "scr_art_tweak" ) )
//			updateDoF();
//		else
//			level.player setDefaultDepthOfField();
//
//		wait( 0.05 );
//	}
//}

//updateCinematicDoF()
//{
//	adsFrac = level.player playerADS();
//	if( adsFrac == 1 && GetDvarInt( "scr_cinematic_autofocus" ) )
//	{
//		traceDir = vectorNormalize( anglesToForward( level.player getPlayerAngles() ) );
//		trace = bulletTrace( level.player getEye(), level.player getEye() + vectorscale( traceDir, 100000 ), true, level.player );
//	
//		enemies = getAIArray();
//		nearEnd = 10000;
//		farStart = -1;
//		start_origin = level.player getEye();
//		start_angles = level.player getPlayerAngles();
//		bestDot = 0;
//		bestFocalPoint = undefined;
//		for( index = 0; index < enemies.size; index ++ )
//		{
//			end_origin = enemies[index].origin;
//			normal = vectorNormalize( end_origin - start_origin );
//			forward = anglesToForward( start_angles );
//			dot = vectorDot( forward, normal );
//	
//			if( dot > bestDot )
//			{
//				bestDot = dot;
//				bestFocalPoint = enemies[index].origin;
//			}
//		}
//		
//		if( bestDot < 0.923 )
//		{
//			scrDoF = distance( start_origin, trace["position"] );
//// 			scrDoF = GetDvarInt( "scr_cinematic_doffocus" ) * 39;
//		}
//		else
//		{
//			scrDoF = distance( start_origin, bestFocalPoint );
//		}
//
//		changeDoFValue( "nearStart", 1, 200 );
//		changeDoFValue( "nearEnd", scrDoF, 200 );
//		changeDoFValue( "farStart", scrDoF + 196, 200 );
//		changeDoFValue( "farEnd", ( scrDoF + 196 ) * 2, 200 );
//		changeDoFValue( "nearBlur", 6, 0.1 );
//		changeDoFValue( "farBlur", 3.6, 0.1 );
//	}
//	else
//	{
//		scrDoF = GetDvarInt( "scr_cinematic_doffocus" ) * 39;
//		
//		if( level.curDoF != scrDoF )
//		{
//			changeDoFValue( "nearStart", 1, 100 );
//			changeDoFValue( "nearEnd", scrDoF, 100 );
//			changeDoFValue( "farStart", scrDoF + 196, 100 );
//			changeDoFValue( "farEnd", ( scrDoF + 196 ) * 2, 100 );
//			changeDoFValue( "nearBlur", 6, 0.1 );
//			changeDoFValue( "farBlur", 3.6, 0.1 );
//		}
//	}
//
//	level.curDoF = ( level.dof["farStart"] - level.dof["nearEnd"] ) / 2;
//
//	level.player setDepthOfField(
//							level.dof["nearStart"], //							level.dof["nearEnd"], //							level.dof["farStart"], //							level.dof["farEnd"], //							level.dof["nearBlur"], //							level.dof["farBlur"]
//							 );
//}

//updateDoF()
//{
//	if( level.player playerADS() == 0.0 )
//	{
//		level.player setDefaultDepthOfField();
//		return;
//	}
//
//	playerEye = level.player getEye();
//	playerAngles = level.player getPlayerAngles();
//	playerForward = vectorNormalize( anglesToForward( playerAngles ) );
//	
//	trace = bulletTrace( playerEye, playerEye + vectorscale( playerForward, 8192 ), true, level.player );
//
//	enemies = getAIArray( "axis" );
//	nearEnd = 10000;
//	farStart = -1;
//	
//	for( index = 0; index < enemies.size; index ++ )
//	{
//		enemyDir = vectorNormalize( enemies[index].origin - playerEye );
//		
//		dot = vectorDot( playerForward, enemyDir );
//		if( dot < 0.923 )// 45 degrees
//			continue;
//
//		distFrom = distance( playerEye, enemies[index].origin );
//		
//		if( distFrom - 30 < nearEnd )
//			nearEnd = distFrom - 30;
//
//		if( distFrom + 30 > farStart )
//			farStart = distFrom + 30;
//	}
//
//	if( nearEnd > farStart )
//	{
//		nearEnd = 256;
//		farStart = 2500;
//	}
//	else
//	{
//		if( nearEnd < 50 )
//			nearEnd = 50;
//		else if( nearEnd > 512 )
//			nearEnd = 512;
//		
//		if( farStart > 2500 )
//			farStart = 2500;
//		else if( farStart < 1000 )
//			farStart = 1000;
//	}
//	
//	traceDist = distance( playerEye, trace["position"] );
//	
//	if( nearEnd > traceDist )
//		nearEnd = traceDist - 30;
//		
//	if( nearEnd < 1 )
//		nearEnd = 1;
//
//	if( farStart < traceDist )
//		farSTart = traceDist;
//
//	setDoFTarget( 1, nearEnd, farStart, farStart * 4, 6, 1.8 );
//}

//setDoFTarget( nearStart, nearEnd, farStart, farEnd, nearBlur, farBlur )
//{
//	adsFrac = level.player playerADS();
//	if( adsFrac == 1 )
//	{
//		changeDoFValue( "nearStart", nearStart, 50 );
//		changeDoFValue( "nearEnd", nearEnd, 50 );
//		changeDoFValue( "farStart", farStart, 400 );
//		changeDoFValue( "farEnd", farEnd, 400 );
//		changeDoFValue( "nearBlur", nearBlur, 0.1 );
//		changeDoFValue( "farBlur", farBlur, 0.1 );
//	}
//	else
//	{
//		lerpDoFValue( "nearStart", nearStart, adsFrac );
//		lerpDoFValue( "nearEnd", nearEnd, adsFrac );
//		lerpDoFValue( "farStart", farStart, adsFrac );
//		lerpDoFValue( "farEnd", farEnd, adsFrac );
//		lerpDoFValue( "nearBlur", nearBlur, adsFrac );
//		lerpDoFValue( "farBlur", farBlur, adsFrac );
//	}
//
//	level.player setDepthOfField(
//							level.dof["nearStart"], //							level.dof["nearEnd"], //							level.dof["farStart"], //							level.dof["farEnd"], //							level.dof["nearBlur"], //							level.dof["farBlur"]
//							 );
//}

//changeDoFValue( valueName, targetValue, maxChange )
//{
//	if( level.dof[valueName] > targetValue )
//	{
//		changeVal = ( level.dof[valueName] - targetValue ) * 0.5;
//		if( changeVal > maxChange )
//			changeVal = maxChange;
//		else if( changeVal < 1 )
//			changeVal = 1;
//		
//		if( level.dof[valueName] - changeVal < targetValue )
//			level.dof[valueName] = targetValue;
//		else
//			level.dof[valueName] -= changeVal;
//	}
//	else if( level.dof[valueName] < targetValue )
//	{
//		changeVal = ( targetValue - level.dof[valueName] ) * 0.5;
//		if( changeVal > maxChange )
//			changeVal = maxChange;
//		else if( changeVal < 1 )
//			changeVal = 1;
//
//		if( level.dof[valueName] + changeVal > targetValue )
//			level.dof[valueName] = targetValue;
//		else
//			level.dof[valueName] += changeVal;
//	}
//}
//
//lerpDoFValue( valueName, targetValue, lerpAmount )
//{
//	level.dof[valueName] = level.dofDefault[valueName] +( ( targetValue - level.dofDefault[valueName] ) * lerpAmount ) ; 	
//}
//
//dofvarupdate()
//{
//		level.dofDefault["nearStart"] = GetDvarint( "scr_dof_nearStart" );
//		level.dofDefault["nearEnd"] = GetDvarint( "scr_dof_nearEnd" );
//		level.dofDefault["farStart"] = GetDvarint( "scr_dof_farStart" );
//		level.dofDefault["farEnd"] = GetDvarint( "scr_dof_farEnd" );
//		level.dofDefault["nearBlur"] = GetDvarfloat( "scr_dof_nearBlur" );
//		level.dofDefault["farBlur"] = GetDvarfloat( "scr_dof_farBlur" ); 	
//}
//
//setdefaultdepthoffield()
//{
//		self setDepthOfField(
//								level.dofDefault["nearStart"], //								level.dofDefault["nearEnd"], //								level.dofDefault["farStart"], //								level.dofDefault["farEnd"], //								level.dofDefault["nearBlur"], //								level.dofDefault["farBlur"]
//								 );
//}
//
//
//isDoFDefault()
//{
//	if( level.dofDefault["nearStart"] != GetDvarInt( "scr_dof_nearStart" ) )
//		return false;
//
//	if( level.dofDefault["nearEnd"] != GetDvarInt( "scr_dof_nearEnd" ) )
//		return false;
//
//	if( level.dofDefault["farStart"] != GetDvarInt( "scr_dof_farStart" ) )
//		return false;
//
//	if( level.dofDefault["farEnd"] != GetDvarInt( "scr_dof_farEnd" ) )
//		return false;
//
//	if( level.dofDefault["nearBlur"] != GetDvarInt( "scr_dof_nearBlur" ) )
//		return false;
//
//	if( level.dofDefault["farBlur"] != GetDvarInt( "scr_dof_farBlur" ) )
//		return false;
//		
//	return true;
//}