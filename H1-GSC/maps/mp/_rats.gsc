/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\_rats.gsc
********************************/

main() {
  if(getdvar("r_reflectionProbeGenerate") == "1") {
    return;
  }
  level._effect["animated_rat_death"] = loadfx("vfx\blood\dlc_blood_splash_sm");
  var_0 = getentarray("animated_rat", "targetname");
  common_scripts\utility::array_thread(var_0, ::init_rats);
}

init_rats() {
  if(!isdefined(self.script_noteworthy)) {
    return;
  }
  switch (self.script_noteworthy) {
    case "frantic":
      thread run_rat("h1_mp_rat_frantic_idle", ["h1_mp_rat_death_01", "h1_mp_rat_death_01"]);
      break;
    case "run":
      thread run_rat("h1_mp_rat_run_01", ["h1_mp_rat_death_03"]);
      break;
    default:
  }
}

run_rat(var_0, var_1) {
  precachempanim(var_0);

  foreach(var_3 in var_1)
  precachempanim(var_3);

  self setcandamage(1);
  self.health = 1;
  self scriptmodelplayanimdeltamotion(var_0);
  self waittill("damage", var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  playfx(common_scripts\utility::getfx("animated_rat_death"), self.origin, (0, 0, 1));
  self scriptmodelplayanimdeltamotion(common_scripts\utility::random(var_1));
}