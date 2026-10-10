/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1593390328d4b03f.gsc
*************************************************/

#using script_3d2770dc09c1243;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_util;
#namespace namespace_90fdb6fb49847e53;

function init() {
  loots = [];

  foreach(loot in getlootscriptablearray()) {
    if(issubstr(loot.type, "panel")) {
      continue;
    }

    loots[loots.size] = loot;
  }

  foreach(ent in getentitylessscriptablearray()) {
    if(issubstr(ent.classname, "cache")) {
      loots[loots.size] = ent;
    }
  }

  level.mit.loot = spawnStruct();
  level.mit.loot.loots = loots;
}

function function_5d1148bbed9fc1d7() {
  var_74510c9a259939ad = 10;
  i = 0;

  while(i < level.mit.loot.loots.size) {
    loops = min(var_74510c9a259939ad, level.mit.loot.loots.size - i);

    for(j = 0; j < loops; j++) {
      checkloot(level.mit.loot.loots[i + j]);
    }

    waitframe();
    i += var_74510c9a259939ad;
  }
}

function private checkloot(loot) {
  var_afe002bfe37369a = 250;
  var_92ae02e0013916b6 = 1024;
  var_acd7c234093147f0 = 10;
  var_5e100759d6a30ae5 = -30;
  contents = scripts\engine\trace::create_world_contents() + scripts\engine\trace::create_item_contents();
  clip = scripts\engine\utility::drop_to_ground(loot.origin, var_acd7c234093147f0, var_5e100759d6a30ae5, undefined, contents);
  noclip = floatequal(clip[2] - loot.origin[2], var_5e100759d6a30ae5, 1);

  if(noclip) {
    report("no clip", loot);
    return;
  }

  navmeshpoint = function_f8350ab882cc2439(clip);
  var_ab1a67a4635adc46 = distance2dsquared(navmeshpoint, clip);
  verticaloffset = abs(navmeshpoint[2] - clip[2]);
  comment = "";

  if(var_ab1a67a4635adc46 > var_92ae02e0013916b6 || verticaloffset > var_afe002bfe37369a) {
    report("no navmesh", loot, sqrt(var_ab1a67a4635adc46), verticaloffset, navmeshpoint, clip);
  }
}

function private report(situation, loot, hoffset, voffset, navmeshpoint, clippoint) {
  if(!istrue(level.mit.loot.var_65054b8e184ecece)) {
    header = "#time; #situation; #lootType; #lootOrigin; #hOffset; #vOffset; #navmeshPoint; #clipPoint";
    outputlog("Loot", header);
    level.mit.loot.var_65054b8e184ecece = 1;
  }

  loottype = "";

  if(isDefined(loot) && isDefined(loot.type)) {
    loottype = loot.type;
  }

  lootorigin = "";

  if(isDefined(loot) && isDefined(loot.origin)) {
    lootorigin = loot.origin;
  }

  reportstring = gettime() + "; " + situation + "; " + loottype + "; " + lootorigin + "; " + default_to(hoffset, "") + "; " + default_to(voffset, "") + "; " + default_to(navmeshpoint, "") + "; " + default_to(clippoint, "");
  outputlog("Loot", reportstring);
}