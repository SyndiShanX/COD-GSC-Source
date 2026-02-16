/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_art.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;

main() {
  if(getdebugdvar("replay_debug") == "1") {
    println("File: _art.gsc. Function: main()\n");
  }

  if(getDvar("scr_art_tweak") == "" || getDvar("scr_art_tweak") == "0") {
    setDvar("scr_art_tweak", 0);
  }

  if(getDvar("scr_dof_enable") == "") {
    SetSavedDvar("scr_dof_enable", "0");
  }

  if(getDvar("scr_cinematic_autofocus") == "") {
    setDvar("scr_cinematic_autofocus", "0");
  }

  if(getDvar("scr_art_visionfile") == "") {
    setDvar("scr_art_visionfile", level.script);
  }

  if(!isDefined(level.dofDefault)) {
    level.dofDefault = [];
  }

  if(!isDefined(level.dofDefault["nearStart"])) {
    level.dofDefault["nearStart"] = 0;
  }

  if(!isDefined(level.dofDefault["nearEnd"])) {
    level.dofDefault["nearEnd"] = 0;
  }

  if(!isDefined(level.dofDefault["farStart"])) {
    level.dofDefault["farStart"] = 1000;
  }

  if(!isDefined(level.dofDefault["farEnd"])) {
    level.dofDefault["farEnd"] = 7000;
  }

  if(!isDefined(level.dofDefault["nearBlur"])) {
    level.dofDefault["nearBlur"] = 4;
  }

  if(!isDefined(level.dofDefault["farBlur"])) {
    level.dofDefault["farBlur"] = 0;
  }

  level.curDoF = (level.dofDefault["farStart"] - level.dofDefault["nearEnd"]) / 2;

  if(GetDvarInt("scr_dof_enable")) {
    thread adsDoF();
  }

  thread tweakart();

  if(!isDefined(level.script)) {
    level.script = tolower(getDvar("mapname"));
  }

  if(getdebugdvar("replay_debug") == "1") {
    println("File: _art.gsc. Function: main() - COMPLETE\n");
  }
}

grain_filter() {}

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

  if(!isDefined(red) || !isDefined(green) || !isDefined(blue) || !isDefined(halfplane) || !isDefined(halfplane)) {
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
  if(getdebugdvar("replay_debug") == "1") {
    println("File: _art.gsc. Function: tweakart()\n");
  }

  if(!isDefined(level.tweakfile)) {
    level.tweakfile = false;
  }

  if(level.tweakfile && level.bScriptgened) {
    script_gen_dump_addline("maps\\createart\\" + level.script + "_art::main();", level.script + "_art");
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

  dofvarupdate();

  wait_for_first_player();
  players = get_players();

  for(;;) {
    if(getdebugdvar("replay_debug") == "1") {
      println("File: _art.gsc. Function: tweakart() - INNER LOOP START\n");
    }

    while(getDvarint("scr_art_tweak") == 0) {
      if(getdebugdvar("replay_debug") == "1") {
        println("File: _art.gsc. Function: tweakart() - INNER INNER LOOP START\n");
      }

      if(getdebugdvar("replay_debug") == "1") {
        println("File: _art.gsc. Function: tweakart() - INNER INNER LOOP START WAIT\n");
      }

      wait .05;

      if(getdebugdvar("replay_debug") == "1") {
        println("File: _art.gsc. Function: tweakart() - INNER INNER LOOP STOP WAIT\n");
      }

      if(!getDvarint("scr_art_tweak") == 0) {
        setfogsliders();
      }

      if(getdebugdvar("replay_debug") == "1") {
        println("File: _art.gsc. Function: tweakart() - INNER INNER LOOP END\n");
      }
    }

    if(getDvarint("scr_art_tweak_message")) {
      setDvar("scr_art_tweak_message", "0");
      println("ART TWEAK ENABLED");
    }

    tweakfog_fraction();

    level.fogexphalfplane = getdvarfloat("scr_fog_exp_halfplane");
    level.fogexphalfheight = getdvarfloat("scr_fog_exp_halfheight");
    level.fognearplane = getdvarfloat("scr_fog_nearplane");
    level.fogred = getdvarfloat("scr_fog_red");
    level.foggreen = getdvarfloat("scr_fog_green");
    level.fogblue = getdvarfloat("scr_fog_blue");
    level.fogbaseheight = getdvarfloat("scr_fog_baseheight");

    dofvarupdate();

    fovslidercheck();

    dump = dumpsettings();

    if(!getdvarint("scr_fog_disable")) {
      setVolFog(level.fognearplane, level.fogexphalfplane, level.fogexphalfheight, level.fogbaseheight, level.fogred, level.foggreen, level.fogblue, 0);
    } else {
      setExpFog(100000000000, 100000000001, 0, 0, 0, 0);
    }

    players[0] setDefaultDepthOfField();

    if(dump) {
      println("Art settings dumped success!");
      addstring = "maps\\createart\\" + level.script + "_art::main();";
      if(level.bScriptgened) {
        script_gen_dump_addline(addstring, level.script + "_art");
        maps\_load::script_gen_dump();
      } else
        assertex(level.tweakfile, "remove all art setting in " + level.script + ".gsc and add the following line before _load: " + addstring);
      setDvar("scr_art_dump", "0");
    }

    if(getdebugdvar("replay_debug") == "1") {
      println("File: _art.gsc. Function: tweakart() - INNER LOOP END\n");
    }

    wait .1;
  }

  if(getdebugdvar("replay_debug") == "1") {
    println("File: _art.gsc. Function: tweakart() - COMPLETE\n");
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

  assertex(file != -1, "File not writeable (maybe you should check it out): " + filename);
  if(file == -1) {
    dump = false;
  }

  artfxprintln(file, "//_createart generated.modify at your own risk. Changing values should be fine.");
  artfxprintln(file, "main()");
  artfxprintln(file, "{");

  artfxprintln(file, "");
  artfxprintln(file, "\tlevel.tweakfile = true;");
  artfxprintln(file, " ");

  artfxprintln(file, "\t// *Fog section* ");
  artfxprintln(file, "");

  artfxprintln(file, "\tsetDvar(\"scr_fog_exp_halfplane\"" + ", " + "\"" + level.fogexphalfplane + "\"" + ");");
  artfxprintln(file, "\tsetDvar(\"scr_fog_exp_halfheight\"" + ", " + "\"" + level.fogexphalfheight + "\"" + ");");
  artfxprintln(file, "\tsetDvar(\"scr_fog_nearplane\"" + ", " + "\"" + level.fognearplane + "\"" + ");");
  artfxprintln(file, "\tsetDvar(\"scr_fog_red\"" + ", " + "\"" + level.fogred + "\"" + ");");
  artfxprintln(file, "\tsetDvar(\"scr_fog_green\"" + ", " + "\"" + level.foggreen + "\"" + ");");
  artfxprintln(file, "\tsetDvar(\"scr_fog_blue\"" + ", " + "\"" + level.fogblue + "\"" + ");");
  artfxprintln(file, "\tsetDvar(\"scr_fog_baseheight\"" + ", " + "\"" + level.fogbaseheight + "\"" + ");");

  artfxprintln(file, "");
  artfxprintln(file, "\t// *depth of field section* ");
  artfxprintln(file, "");

  artfxprintln(file, "\tlevel.dofDefault[\"nearStart\"] = " + getdvarint("scr_dof_nearStart") + ";");
  artfxprintln(file, "\tlevel.dofDefault[\"nearEnd\"] = " + getdvarint("scr_dof_nearEnd") + ";");
  artfxprintln(file, "\tlevel.dofDefault[\"farStart\"] = " + getdvarint("scr_dof_farStart") + ";");
  artfxprintln(file, "\tlevel.dofDefault[\"farEnd\"] = " + getdvarint("scr_dof_farEnd") + ";");
  artfxprintln(file, "\tlevel.dofDefault[\"nearBlur\"] = " + getdvarfloat("scr_dof_nearBlur") + ";");
  artfxprintln(file, "\tlevel.dofDefault[\"farBlur\"] = " + getdvarfloat("scr_dof_farBlur") + ";");

  artfxprintln(file, "");
  artfxprintln(file, "\tplayers = maps\\_utility::get_players();");
  artfxprintln(file, "\tfor( i = 0; i < players.size; i++ )");
  artfxprintln(file, "\t{");
  artfxprintln(file, "\t\tplayers[i] maps\\_art::setdefaultdepthoffield();");
  artfxprintln(file, "\t}");
  artfxprintln(file, "");

  if(getDvar("r_glowUseTweaks") == "0") {
    getvar = "visionstore";
  } else {
    getvar = "r";
  }

  if(getDvar("visionstore_glowTweakEnable") == "") {
    getvar = "r";
  }

  artfxprintln(file, "\tsetDvar(\"visionstore_glowTweakEnable\"" + ", " + "\"" + getDvar(getvar + "_glowTweakEnable") + "\"" + ");");
  artfxprintln(file, "\tsetDvar(\"visionstore_glowTweakRadius0\"" + ", " + "\"" + getDvar(getvar + "_glowTweakRadius0") + "\"" + ");");
  artfxprintln(file, "\tsetDvar(\"visionstore_glowTweakRadius1\"" + ", " + "\"" + getDvar(getvar + "_glowTweakRadius1") + "\"" + ");");
  artfxprintln(file, "\tsetDvar(\"visionstore_glowTweakBloomCutoff\"" + ", " + "\"" + getDvar(getvar + "_glowTweakBloomCutoff") + "\"" + ");");
  artfxprintln(file, "\tsetDvar(\"visionstore_glowTweakBloomDesaturation\"" + ", " + "\"" + getDvar(getvar + "_glowTweakBloomDesaturation") + "\"" + ");");
  artfxprintln(file, "\tsetDvar(\"visionstore_glowTweakBloomIntensity0\"" + ", " + "\"" + getDvar(getvar + "_glowTweakBloomIntensity0") + "\"" + ");");
  artfxprintln(file, "\tsetDvar(\"visionstore_glowTweakBloomIntensity1\"" + ", " + "\"" + getDvar(getvar + "_glowTweakBloomIntensity1") + "\"" + ");");
  artfxprintln(file, "\tsetDvar(\"visionstore_glowTweakSkyBleedIntensity0\"" + ", " + "\"" + getDvar(getvar + "_glowTweakSkyBleedIntensity0") + "\"" + ");");
  artfxprintln(file, "\tsetDvar(\"visionstore_glowTweakSkyBleedIntensity1\"" + ", " + "\"" + getDvar(getvar + "_glowTweakSkyBleedIntensity1") + "\"" + ");");

  artfxprintln(file, "");
  artfxprintln(file, "\t//************************************** Fog section * ");
  artfxprintln(file, "");
  artfxprintln(file, "\tsetDvar( \"scr_fog_disable\"" + ", " + "\"" + getdvarint("scr_fog_disable") + "\"" + " );");

  artfxprintln(file, "");
  if(!getdvarint("scr_fog_disable")) {
    artfxprintln(file, "\tsetVolFog(" + level.fognearplane + ", " + level.fogexphalfplane + ", " + level.fogexphalfheight + ", " + level.fogbaseheight + ", " + level.fogred + ", " + level.foggreen + ", " + level.fogblue + ", 0);");
  }

  artfxprintln(file, "\tmaps\\_utility::set_vision_set( \"" + level.script + "\", 0 );");

  artfxprintln(file, "");
  artfxprintln(file, "}");

  saved = closefile(file);
  assertex((saved == 1), "File not saved (see above message?): " + filename);
  if(!saved) {
    dump = false;
  }

  visionFilename = "vision/" + getDvar("scr_art_visionfile") + ".vision";
  file = openfile(visionFilename, "write");

  assertex((file != -1), "File not writeable (may need checked out of P4): " + filename);

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
  assertex((saved == 1), "File not saved (see above message?): " + visionFilename);

  setVolFog(level.fognearplane, level.fogexphalfplane, level.fogexphalfheight, level.fogbaseheight, level.fogred, level.foggreen, level.fogblue, 0);

  players = get_players();
  players[0] setDefaultDepthOfField();

  if(dump) {
    println("ART DUMPED SUCCESSFULLY");
  }
  return dump;
}

tweakfog_fraction() {
  fogfraction = getdvarfloat("scr_fog_fraction");
  if(fogfraction != level.fogfraction) {
    level.fogfraction = fogfraction;
  } else {
    return;
  }

  color = [];
  color[0] = getdvarfloat("scr_fog_red");
  color[1] = getdvarfloat("scr_fog_green");
  color[2] = getdvarfloat("scr_fog_blue");

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

cloudlight(sunlight_bright, sunlight_dark, diffuse_high, diffuse_low) {
  level.sunlight_bright = sunlight_bright;
  level.sunlight_dark = sunlight_dark;
  level.diffuse_high = diffuse_high;
  level.diffuse_low = diffuse_low;

  setDvar("r_lighttweaksunlight", level.sunlight_dark);
  setDvar("r_lighttweakdiffusefraction", level.diffuse_low);
  direction = "up";

  for(;;) {
    sunlight = getdvarFloat("r_lighttweaksunlight");
    jitter = scale(1 + randomint(21));

    flip = randomint(2);
    if(flip) {
      jitter = jitter * -1;
    }

    if(direction == "up") {
      next_target = sunlight + scale(30) + jitter;
    } else {
      next_target = sunlight - scale(30) + jitter;
    }

    if(next_target >= level.sunlight_bright) {
      next_target = level.sunlight_bright;
      direction = "down";
    }

    if(next_target <= level.sunlight_dark) {
      next_target = level.sunlight_dark;
      direction = "up";
    }

    if(next_target > sunlight) {
      brighten(next_target, (3 + randomint(3)), .05);
    } else {
      darken(next_target, (3 + randomint(3)), .05);
    }
  }
}

brighten(target_sunlight, time, freq) {
  sunlight = getdvarFloat("r_lighttweaksunlight");

  totalchange = target_sunlight - sunlight;
  changeamount = totalchange / (time / freq);

  while(time > 0) {
    time = time - freq;

    sunlight = sunlight + changeamount;
    setDvar("r_lighttweaksunlight", sunlight);

    frac = (sunlight - level.sunlight_dark) / (level.sunlight_bright - level.sunlight_dark);
    diffuse = level.diffuse_high + (level.diffuse_low - level.diffuse_high) * frac;
    setDvar("r_lighttweakdiffusefraction", diffuse);

    wait freq;
  }
}

darken(target_sunlight, time, freq) {
  sunlight = getdvarFloat("r_lighttweaksunlight");

  totalchange = sunlight - target_sunlight;
  changeamount = totalchange / (time / freq);

  while(time > 0) {
    time = time - freq;

    sunlight = sunlight - changeamount;
    setDvar("r_lighttweaksunlight", sunlight);

    frac = (sunlight - level.sunlight_dark) / (level.sunlight_bright - level.sunlight_dark);
    diffuse = level.diffuse_high + (level.diffuse_low - level.diffuse_high) * frac;
    setDvar("r_lighttweakdiffusefraction", diffuse);

    wait freq;
  }
}

scale(percent) {
  frac = percent / 100;
  return (level.sunlight_dark + frac * (level.sunlight_bright - level.sunlight_dark)) - level.sunlight_dark;
}

adsDoF() {
  if(getdebugdvar("replay_debug") == "1") {
    println("File: _art.gsc. Function: adsDoF()\n");
  }

  level.dof = level.dofDefault;
  art_tweak = false;

  for(;;) {
    wait(0.05);

    if(getdebugdvar("replay_debug") == "1") {
      println("File: _art.gsc. Function: adsDoF() - INNER LOOP START\n");
    }

    if(level.level_specific_dof) {
      if(getdebugdvar("replay_debug") == "1") {
        println("File: _art.gsc. Function: adsDoF() - INNER LOOP END EARLY 1\n");
      }

      continue;
    }
    if(getDvarInt("scr_cinematic")) {
      updateCinematicDoF();

      if(getdebugdvar("replay_debug") == "1") {
        println("File: _art.gsc. Function: adsDoF() - INNER LOOP END EARLY 2\n");
      }

      continue;
    }

    art_tweak = getDvarInt("scr_art_tweak");

    if(getDvarInt("scr_dof_enable") && !art_tweak) {
      updateDoF();

      if(getdebugdvar("replay_debug") == "1") {
        println("File: _art.gsc. Function: adsDoF() - INNER LOOP END EARLY 3\n");
      }

      continue;
    }

    players = get_players();

    for(i = 0; i < players.size; i++) {
      players[i] setDefaultDepthOfField();
    }

    if(getdebugdvar("replay_debug") == "1") {
      println("File: _art.gsc. Function: adsDoF() - INNER LOOP END\n");
    }

    wait(0.05);
  }

  if(getdebugdvar("replay_debug") == "1") {
    println("File: _art.gsc. Function: adsDoF() - COMPLETE\n");
  }
}

updateCinematicDoF() {
  players = get_players();

  if(players.size == 0) {
    return;
  }
  for(i = 0; i < players.size; i++) {
    adsFrac = players[i] playerADS();
    if(adsFrac == 1 && getDvarInt("scr_cinematic_autofocus")) {
      traceDir = vectorNormalize(anglesToForward(players[i] getPlayerAngles()));
      trace = bulletTrace(players[i] getEye(), players[i] getEye() + vectorscale(traceDir, 100000), true, players[i]);

      enemies = getAIArray();
      nearEnd = 10000;
      farStart = -1;
      start_origin = players[i] getEye();
      start_angles = players[i] getPlayerAngles();
      bestDot = 0;
      bestFocalPoint = undefined;
      for(index = 0; index < enemies.size; index++) {
        end_origin = enemies[index].origin;
        normal = vectorNormalize(end_origin - start_origin);
        forward = anglesToForward(start_angles);
        dot = vectorDot(forward, normal);

        if(dot > bestDot) {
          bestDot = dot;
          bestFocalPoint = enemies[index].origin;
        }
      }

      if(bestDot < 0.923) {
        scrDoF = distance(start_origin, trace["position"]);
      } else {
        scrDoF = distance(start_origin, bestFocalPoint);
      }

      changeDoFValue("nearStart", 1, 200);
      changeDoFValue("nearEnd", scrDoF, 200);
      changeDoFValue("farStart", scrDoF + 196, 200);
      changeDoFValue("farEnd", (scrDoF + 196) * 2, 200);
      changeDoFValue("nearBlur", 6, 0.1);
      changeDoFValue("farBlur", 3.6, 0.1);
    } else {
      scrDoF = getDvarInt("scr_cinematic_doffocus") * 39;

      if(level.curDoF != scrDoF) {
        changeDoFValue("nearStart", 1, 100);
        changeDoFValue("nearEnd", scrDoF, 100);
        changeDoFValue("farStart", scrDoF + 196, 100);
        changeDoFValue("farEnd", (scrDoF + 196) * 2, 100);
        changeDoFValue("nearBlur", 6, 0.1);
        changeDoFValue("farBlur", 3.6, 0.1);
      }
    }

    level.curDoF = (level.dof["farStart"] - level.dof["nearEnd"]) / 2;

    players[i] setDepthOfField(
      level.dof["nearStart"], level.dof["nearEnd"], level.dof["farStart"], level.dof["farEnd"], level.dof["nearBlur"], level.dof["farBlur"]
    );
  }
}

updateDoF() {
  players = get_players();

  if(players.size == 0) {
    return;
  }
  for(i = 0; i < players.size; i++) {
    if(players[i] playerADS() == 0.0) {
      players[i] setDefaultDepthOfField();
      continue;
    }

    playerEye = players[i] getEye();
    playerAngles = players[i] getPlayerAngles();
    playerForward = vectorNormalize(anglesToForward(playerAngles));

    trace = bulletTrace(playerEye, playerEye + vectorscale(playerForward, 8192), true, players[i]);

    enemies = getAIArray("axis");
    nearEnd = 10000;
    farStart = -1;

    for(index = 0; index < enemies.size; index++) {
      enemyDir = vectorNormalize(enemies[index].origin - playerEye);

      dot = vectorDot(playerForward, enemyDir);
      if(dot < 0.923) {
        continue;
      }
      distFrom = distance(playerEye, enemies[index].origin);

      if(distFrom - 30 < nearEnd) {
        nearEnd = distFrom - 30;
      }

      if(distFrom + 30 > farStart) {
        farStart = distFrom + 30;
      }
    }

    if(nearEnd > farStart) {
      nearEnd = 256;
      farStart = 2500;
    } else {
      if(nearEnd < 50) {
        nearEnd = 50;
      } else if(nearEnd > 512) {
        nearEnd = 512;
      }

      if(farStart > 2500) {
        farStart = 2500;
      } else if(farStart < 1000) {
        farStart = 1000;
      }
    }

    traceDist = distance(playerEye, trace["position"]);

    if(nearEnd > traceDist) {
      nearEnd = traceDist - 30;
    }

    if(nearEnd < 1) {
      nearEnd = 1;
    }

    if(farStart < traceDist) {
      farSTart = traceDist;
    }

    setDoFTarget(i, 1, nearEnd, farStart, farStart * 4, 6, 1.8);
  }
}

setDoFTarget(player, nearStart, nearEnd, farStart, farEnd, nearBlur, farBlur) {
  players = get_players();
  adsFrac = players[player] playerADS();
  if(adsFrac == 1) {
    changeDoFValue("nearStart", nearStart, 50);
    changeDoFValue("nearEnd", nearEnd, 50);
    changeDoFValue("farStart", farStart, 400);
    changeDoFValue("farEnd", farEnd, 400);
    changeDoFValue("nearBlur", nearBlur, 0.1);
    changeDoFValue("farBlur", farBlur, 0.1);
  } else {
    lerpDoFValue("nearStart", nearStart, adsFrac);
    lerpDoFValue("nearEnd", nearEnd, adsFrac);
    lerpDoFValue("farStart", farStart, adsFrac);
    lerpDoFValue("farEnd", farEnd, adsFrac);
    lerpDoFValue("nearBlur", nearBlur, adsFrac);
    lerpDoFValue("farBlur", farBlur, adsFrac);
  }

  players[player] setDepthOfField(
    level.dof["nearStart"], level.dof["nearEnd"], level.dof["farStart"], level.dof["farEnd"], level.dof["nearBlur"], level.dof["farBlur"]
  );
}

changeDoFValue(valueName, targetValue, maxChange) {
  if(level.dof[valueName] > targetValue) {
    changeVal = (level.dof[valueName] - targetValue) * 0.5;
    if(changeVal > maxChange) {
      changeVal = maxChange;
    } else if(changeVal < 1) {
      changeVal = 1;
    }

    if(level.dof[valueName] - changeVal < targetValue) {
      level.dof[valueName] = targetValue;
    } else {
      level.dof[valueName] -= changeVal;
    }
  } else if(level.dof[valueName] < targetValue) {
    changeVal = (targetValue - level.dof[valueName]) * 0.5;
    if(changeVal > maxChange) {
      changeVal = maxChange;
    } else if(changeVal < 1) {
      changeVal = 1;
    }

    if(level.dof[valueName] + changeVal > targetValue) {
      level.dof[valueName] = targetValue;
    } else {
      level.dof[valueName] += changeVal;
    }
  }
}

lerpDoFValue(valueName, targetValue, lerpAmount) {
  level.dof[valueName] = level.dofDefault[valueName] + ((targetValue - level.dofDefault[valueName]) * lerpAmount);
}

dofvarupdate() {
  level.dofDefault["nearStart"] = getdvarint("scr_dof_nearStart");
  level.dofDefault["nearEnd"] = getdvarint("scr_dof_nearEnd");
  level.dofDefault["farStart"] = getdvarint("scr_dof_farStart");
  level.dofDefault["farEnd"] = getdvarint("scr_dof_farEnd");
  level.dofDefault["nearBlur"] = getdvarfloat("scr_dof_nearBlur");
  level.dofDefault["farBlur"] = getdvarfloat("scr_dof_farBlur");
}

setdefaultdepthoffield() {
  if(isDefined(level.do_not_use_dof)) {
    return;
  }

  self setDepthOfField(
    level.dofDefault["nearStart"], level.dofDefault["nearEnd"], level.dofDefault["farStart"], level.dofDefault["farEnd"], level.dofDefault["nearBlur"], level.dofDefault["farBlur"]
  );
}

isDoFDefault() {
  if(level.dofDefault["nearStart"] != getDvarInt("scr_dof_nearStart")) {
    return false;
  }

  if(level.dofDefault["nearEnd"] != getDvarInt("scr_dof_nearEnd")) {
    return false;
  }

  if(level.dofDefault["farStart"] != getDvarInt("scr_dof_farStart")) {
    return false;
  }

  if(level.dofDefault["farEnd"] != getDvarInt("scr_dof_farEnd")) {
    return false;
  }

  if(level.dofDefault["nearBlur"] != getDvarInt("scr_dof_nearBlur")) {
    return false;
  }

  if(level.dofDefault["farBlur"] != getDvarInt("scr_dof_farBlur")) {
    return false;
  }

  return true;
}