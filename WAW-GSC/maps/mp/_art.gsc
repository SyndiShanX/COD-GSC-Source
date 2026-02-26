/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_art.gsc
**************************************/

#include common_scripts\utility;
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

  thread tweakart();

  if(!isDefined(level.script)) {
    level.script = tolower(getDvar("mapname"));
  }
}

artfxprintln(file, string) {
  if(file == -1) {
    return;
  }
  fprintln(file, string);
}

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
  fogall = strtok_loc(getDvar("g_fogColorReadOnly"), " ");
  red = fogall[0];
  green = fogall[1];
  blue = fogall[2];
  halfplane = getDvar("g_fogHalfDistReadOnly");
  nearplane = getDvar("g_fogStartDistReadOnly");

  if(!isDefined(red) {
      || !isDefined(green)
    } || !isDefined(blue) || !isDefined(halfplane) || !isDefined(halfplane)) {
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

  if(getDvar("scr_fog_red") == "") {
    setDvar("scr_fog_exp_halfplane", "500");
    setDvar("scr_fog_exp_halfheight", "500");
    setDvar("scr_fog_nearplane", "0");
    setDvar("scr_fog_baseheight", "0");
    setDvar("scr_fog_red", "0.5");
    setDvar("scr_fog_green", "0.5");
    setDvar("scr_fog_blue", "0.5");
  }

  setDvar("scr_fog_fraction", "1.0");
  setDvar("scr_art_dump", "0");

  setDvar("scr_dof_nearStart", level.dofDefault["nearStart"]);
  setDvar("scr_dof_nearEnd", level.dofDefault["nearEnd"]);
  setDvar("scr_dof_farStart", level.dofDefault["farStart"]);
  setDvar("scr_dof_farEnd", level.dofDefault["farEnd"]);
  setDvar("scr_dof_nearBlur", level.dofDefault["nearBlur"]);
  setDvar("scr_dof_farBlur", level.dofDefault["farBlur"]);

  level.fogfraction = 1.0;

  file = undefined;
  filename = undefined;

  for(;;) {
    while(GetDvarint("scr_art_tweak") == 0) {
      assertex(getDvar("scr_art_dump") == "0", "Must Enable Art Tweaks to export _art file.");
      wait .05;
      if(!GetDvarint("scr_art_tweak") == 0) {
        setfogsliders();
      }
    }

    if(GetDvarint("scr_art_tweak_message")) {
      setDvar("scr_art_tweak_message", "0");
      iprintlnbold("ART TWEAK ENABLED");
    }

    tweakfog_fraction();

    level.fogexphalfplane = GetDvarfloat("scr_fog_exp_halfplane");
    level.fogexphalfheight = GetDvarfloat("scr_fog_exp_halfheight");
    level.fognearplane = GetDvarfloat("scr_fog_nearplane");
    level.fogred = GetDvarfloat("scr_fog_red");
    level.foggreen = GetDvarfloat("scr_fog_green");
    level.fogblue = GetDvarfloat("scr_fog_blue");
    level.fogbaseheight = GetDvarfloat("scr_fog_baseheight");

    fovslidercheck();

    dump = dumpsettings();

    if(!GetDvarint("scr_fog_disable")) {
      setVolFog(level.fognearplane, level.fogexphalfplane, level.fogexphalfheight, level.fogbaseheight, level.fogred, level.foggreen, level.fogblue, 0);
    } else {
      setExpFog(100000000000, 100000000001, 0, 0, 0, 0);
    }

    if(dump) {
      iprintlnbold("Art settings dumped success!");
      addstring = "maps\\createart\\" + level.script + "_art::main(); ";
      if(level.bScriptgened) {}
      setDvar("scr_art_dump", "0");
    }
    wait .1;
  }
}

fovslidercheck() {
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

  artfxprintln(file, "");
  artfxprintln(file, "\t//************************************** Fog section * ");
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
    if(self buttonPressed("BUTTON_X")) {
      offset += offsetinc;
    }

    if(self buttonPressed("BUTTON_Y")) {
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