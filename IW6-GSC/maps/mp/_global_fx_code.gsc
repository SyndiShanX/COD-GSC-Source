/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_global_fx_code.gsc
***************************************/

#include common_scripts\utility;

global_FX(targetname, fxFile, delay, fxName, soundalias) {
  ents = getStructArray(targetname, "targetname");
  if(ents.size <= 0) {
    return;
  }
  if(!isDefined(delay))
    delay = RandomFloatRange(-20, -15);

  if(!isDefined(fxName))
    fxName = fxFile;

  foreach(fxEnt in ents) {
    if(!isDefined(level._effect))
      level._effect = [];
    if(!isDefined(level._effect[fxName]))
      level._effect[fxName] = LoadFX(fxFile);

    if(!isDefined(fxEnt.angles))
      fxEnt.angles = (0, 0, 0);

    ent = createOneshotEffect(fxName);
    ent.v["origin"] = (fxEnt.origin);
    ent.v["angles"] = (fxEnt.angles);
    ent.v["fxid"] = fxName;
    ent.v["delay"] = delay;
    if(isDefined(soundalias))
      ent.v["soundalias"] = soundalias;
  }
}