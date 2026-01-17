/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_art.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;

main() {
  if(GetDvar("scr_art_tweak") == "" || GetDvar("scr_art_tweak") == "0") {
    SetDvar("scr_art_tweak", 0);
  }
  if(GetDvar("scr_dof_enable") == "") {
    SetDvar("scr_dof_enable", "1");
  }
  if(GetDvar("scr_cinematic_autofocus") == "") {
    SetDvar("scr_cinematic_autofocus", "1");
  }
  if(GetDvar("scr_art_visionfile") == "") {
    SetDvar("scr_art_visionfile", level.script);
  }
  if(GetDvar("debug_reflection") == "") {
    SetDvar("debug_reflection", "0");
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
    level.script = tolower(GetDvar("mapname"));
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
  fogall = strtok_loc(GetDvar("g_fogColorReadOnly"), " ");
  red = fogall[0];
  green = fogall[1];
  blue = fogall[2];
  halfplane = GetDvar("g_fogHalfDistReadOnly");
  nearplane = GetDvar("g_fogStartDistReadOnly");
  if(!isDefined(red) ||
    !isDefined(green) ||
    !isDefined(blue) ||
    !isDefined(halfplane) ||
    !isDefined(halfplane)
  ) {
    red = 1;
    green = 1;
    blue = 1;
    halfplane = 10000001;
    nearplane = 10000000;
  }
  SetDvar("scr_fog_exp_halfplane", halfplane);
  SetDvar("scr_fog_nearplane", nearplane);
  SetDvar("scr_fog_red", red);
  SetDvar("scr_fog_green", green);
  SetDvar("scr_fog_blue", blue);
}

tweakart() {
  if(!isDefined(level.tweakfile)) {
    level.tweakfile = false;
  }
  if(GetDvar("scr_fog_red") == "") {
    SetDvar("scr_fog_exp_halfplane", "500");
    SetDvar("scr_fog_exp_halfheight", "500");
    SetDvar("scr_fog_nearplane", "0");
    SetDvar("scr_fog_baseheight", "0");
    SetDvar("scr_fog_red", "0.5");
    SetDvar("scr_fog_green", "0.5");
    SetDvar("scr_fog_blue", "0.5");
  }
  SetDvar("scr_fog_fraction", "1.0");
  SetDvar("scr_art_dump", "0");
  SetDvar("scr_dof_nearStart", level.dofDefault["nearStart"]);
  SetDvar("scr_dof_nearEnd", level.dofDefault["nearEnd"]);
  SetDvar("scr_dof_farStart", level.dofDefault["farStart"]);
  SetDvar("scr_dof_farEnd", level.dofDefault["farEnd"]);
  SetDvar("scr_dof_nearBlur", level.dofDefault["nearBlur"]);
  SetDvar("scr_dof_farBlur", level.dofDefault["farBlur"]);
  level.fogfraction = 1.0;
  file = undefined;
  filename = undefined;
  for(;;) {
    while(GetDvarint("scr_art_tweak") == 0) {
      assertex(GetDvar("scr_art_dump") == "0", "Must Enable Art Tweaks to export _art file.");
      wait .05;
      if(!GetDvarint("scr_art_tweak") == 0) {
        setfogsliders();
      }
    }
    if(GetDvarint("scr_art_tweak_message")) {
      SetDvar("scr_art_tweak_message", "0");
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
      SetDvar("scr_art_dump", "0");
    }
    wait .1;
  }
}

fovslidercheck() {
  if(level.dofDefault["nearStart"] >= level.dofDefault["nearEnd"]) {
    level.dofDefault["nearStart"] = level.dofDefault["nearEnd"] - 1;
    SetDvar("scr_dof_nearStart", level.dofDefault["nearStart"]);
  }
  if(level.dofDefault["nearEnd"] <= level.dofDefault["nearStart"]) {
    level.dofDefault["nearEnd"] = level.dofDefault["nearStart"] + 1;
    SetDvar("scr_dof_nearEnd", level.dofDefault["nearEnd"]);
  }
  if(level.dofDefault["farStart"] >= level.dofDefault["farEnd"]) {
    level.dofDefault["farStart"] = level.dofDefault["farEnd"] - 1;
    SetDvar("scr_dof_farStart", level.dofDefault["farStart"]);
  }
  if(level.dofDefault["farEnd"] <= level.dofDefault["farStart"]) {
    level.dofDefault["farEnd"] = level.dofDefault["farStart"] + 1;
    SetDvar("scr_dof_farEnd", level.dofDefault["farEnd"]);
  }
  if(level.dofDefault["farBlur"] >= level.dofDefault["nearBlur"]) {
    level.dofDefault["farBlur"] = level.dofDefault["nearBlur"] - .1;
    SetDvar("scr_dof_farBlur", level.dofDefault["farBlur"]);
  }
  if(level.dofDefault["farStart"] <= level.dofDefault["nearEnd"]) {
    level.dofDefault["farStart"] = level.dofDefault["nearEnd"] + 1;
    SetDvar("scr_dof_farStart", level.dofDefault["farStart"]);
  }
}

dumpsettings() {
    if(GetDvar("scr_art_dump") == "0") {
      return false;
    }
    dump = true;
    filename = "createart/" + GetDvar("scr_art_visionfile") + "_art.gsc";
    file = openfile(filename, "write");
    assertex(file != -1, "File not writeable( maybe you should check it out ): " + filename);
    if(file == -1) {
      dump = false;
    }
    artfxprintln(file, "
        artfxprintln(file, "main()"); artfxprintln(file, "{"); artfxprintln(file, ""); artfxprintln(file, "\tlevel.tweakfile = true; "); artfxprintln(file, " "); artfxprintln(file, ""); artfxprintln(file, "\t
          artfxprintln(file, ""); artfxprintln(file, "\tSetDvar( \"scr_fog_exp_halfplane\"" + ", " + "\"" + level.fogexphalfplane + "\"" + " ); "); artfxprintln(file, "\tSetDvar( \"scr_fog_exp_halfheight\"" + ", " + "\"" + level.fogexphalfheight + "\"" + " ); "); artfxprintln(file, "\tSetDvar( \"scr_fog_nearplane\"" + ", " + "\"" + level.fognearplane + "\"" + " ); "); artfxprintln(file, "\tSetDvar( \"scr_fog_red\"" + ", " + "\"" + level.fogred + "\"" + " ); "); artfxprintln(file, "\tSetDvar( \"scr_fog_green\"" + ", " + "\"" + level.foggreen + "\"" + " ); "); artfxprintln(file, "\tSetDvar( \"scr_fog_blue\"" + ", " + "\"" + level.fogblue + "\"" + " ); "); artfxprintln(file, "\tSetDvar( \"scr_fog_baseheight\"" + ", " + "\"" + level.fogbaseheight + "\"" + " ); "); artfxprintln(file, "");
          if(!GetDvarint("scr_fog_disable")) {
            artfxprintln(file, "\tsetVolFog( " + level.fognearplane + ", " + level.fogexphalfplane + ", " + level.fogexphalfheight + ", " + level.fogbaseheight + ", " + level.fogred + ", " + level.foggreen + ", " + level.fogblue + ", 0 ); ");
          }
          artfxprintln(file, "\tVisionSetNaked( \"" + level.script + "\", 0 ); "); artfxprintln(file, ""); artfxprintln(file, "}"); saved = closefile(file); assertex((saved == 1), "File not saved( see above message? ): " + filename);
          if(!saved) {
            dump = false;
          }
          visionFilename = "vision/" + GetDvar("scr_art_visionfile") + ".vision"; file = openfile(visionFilename, "write"); assertex((file != -1), "File not writeable( may need checked out of P4 ): " + filename); artfxprintln(file, "r_glow\"" + GetDvar("r_glowTweakEnable") + "\""); artfxprintln(file, "r_glowRadius0 \"" + GetDvar("r_glowTweakRadius0") + "\""); artfxprintln(file, "r_glowRadius1 \"" + GetDvar("r_glowTweakRadius1") + "\""); artfxprintln(file, "r_glowBloomCutoff \"" + GetDvar("r_glowTweakBloomCutoff") + "\""); artfxprintln(file, "r_glowBloomDesaturation \"" + GetDvar("r_glowTweakBloomDesaturation") + "\""); artfxprintln(file, "r_glowBloomIntensity0 \"" + GetDvar("r_glowTweakBloomIntensity0") + "\""); artfxprintln(file, "r_glowBloomIntensity1 \"" + GetDvar("r_glowTweakBloomIntensity1") + "\""); artfxprintln(file, "r_glowSkyBleedIntensity0\"" + GetDvar("r_glowTweakSkyBleedIntensity0") + "\""); artfxprintln(file, "r_glowSkyBleedIntensity1\"" + GetDvar("r_glowTweakSkyBleedIntensity1") + "\""); artfxprintln(file, " "); artfxprintln(file, "r_filmEnable\"" + GetDvar("r_filmTweakEnable") + "\""); artfxprintln(file, "r_filmContrast\"" + GetDvar("r_filmTweakContrast") + "\""); artfxprintln(file, "r_filmBrightness\"" + GetDvar("r_filmTweakBrightness") + "\""); artfxprintln(file, "r_filmDesaturation\"" + GetDvar("r_filmTweakDesaturation") + "\""); artfxprintln(file, "r_filmInvert\"" + GetDvar("r_filmTweakInvert") + "\""); artfxprintln(file, "r_filmLightTint \"" + GetDvar("r_filmTweakLightTint") + "\""); artfxprintln(file, "r_filmDarkTint\"" + GetDvar("r_filmTweakDarkTint") + "\""); saved = closefile(file); assertex((saved == 1), "File not saved( see above message? ): " + visionFilename);
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
          SetDvar("scr_fog_fraction", 1);
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
          SetDvar("scr_fog_red", fc[0]);
          SetDvar("scr_fog_green", fc[1]);
          SetDvar("scr_fog_blue", fc[2]);
        }
        debug_reflection() {
          level.debug_reflection = 0;
          while(1) {
            wait(0.1);
            if((GetDvar("debug_reflection") == "2" && level.debug_reflection != 2) || (GetDvar("debug_reflection") == "3" && level.debug_reflection != 3)) {
              remove_reflection_objects();
              if(GetDvar("debug_reflection") == "2") {
                create_reflection_objects();
                level.debug_reflection = 2;
              } else {
                create_reflection_objects();
                create_reflection_object();
                level.debug_reflection = 3;
              }
            } else if(GetDvar("debug_reflection") == "1" && level.debug_reflection != 1) {
              remove_reflection_objects();
              create_reflection_object();
              level.debug_reflection = 1;
            } else if(GetDvar("debug_reflection") == "0" && level.debug_reflection != 0) {
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
          while(GetDvar("debug_reflection") == "1" || GetDvar("debug_reflection") == "3") {
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
            line(level.debug_reflectionobject.origin,
              getreflectionorigin(level.debug_reflectionobject.origin),
              (1, 0, 0),
              true,
              1);
            wait(0.05);
          }
        }