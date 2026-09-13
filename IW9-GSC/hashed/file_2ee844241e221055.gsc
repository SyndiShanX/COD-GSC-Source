/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2ee844241e221055.gsc
***********************************************/

main() {
  _id_2FEFE88FA12AC091::main();
  _id_161F9595DFC9ADA6::main();
  _id_0978473EB1F8A26E::main();
  _id_1C6417E9FEDDAD34::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_bounty");
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "mexico";
  thread _id_B385569E197AE59B();
  thread scripts\mp\animation_suite::animationsuite();

  if(getdvarint("dvar_8610CCD25560C117") == 0)
    thread play_movie("mp_bounty_tv_screens_01");
}

_id_1498753406CC184A() {
  _id_611B2AE6C73BA6FD = [];
  _id_611B2AE6C73BA6FD[_id_611B2AE6C73BA6FD.size] = "emt_bounty_thunder_a";
  _id_611B2AE6C73BA6FD[_id_611B2AE6C73BA6FD.size] = "emt_bounty_thunder_b";
  _id_611B2AE6C73BA6FD[_id_611B2AE6C73BA6FD.size] = "emt_bounty_thunder_c";
  _id_611B2AE6C73BA6FD[_id_611B2AE6C73BA6FD.size] = "emt_bounty_thunder_d";
  _id_611B2AE6C73BA6FD[_id_611B2AE6C73BA6FD.size] = "emt_bounty_thunder_e";
  _id_611B2AE6C73BA6FD[_id_611B2AE6C73BA6FD.size] = "emt_bounty_thunder_f";
  _id_C690B1270B7752F0 = [];
  _id_C690B1270B7752F0[_id_C690B1270B7752F0.size] = -1;
  _id_C690B1270B7752F0[_id_C690B1270B7752F0.size] = -1;
  _id_C690B1270B7752F0[_id_C690B1270B7752F0.size] = -1;

  for(;;) {
    wait(randomintrange(30, 60));

    for(_id_057BFDD29E55F96A = randomint(_id_611B2AE6C73BA6FD.size); _id_057BFDD29E55F96A == _id_C690B1270B7752F0[0] || _id_057BFDD29E55F96A == _id_C690B1270B7752F0[1] || _id_057BFDD29E55F96A == _id_C690B1270B7752F0[2]; _id_057BFDD29E55F96A = randomint(_id_611B2AE6C73BA6FD.size)) {}

    _id_C690B1270B7752F0[0] = _id_C690B1270B7752F0[1];
    _id_C690B1270B7752F0[1] = _id_C690B1270B7752F0[2];
    _id_C690B1270B7752F0[2] = _id_057BFDD29E55F96A;
    playsoundatpos((-2739, 1232, 2061), _id_611B2AE6C73BA6FD[_id_057BFDD29E55F96A]);
  }
}

play_movie(bink) {
  if(getdvarint("r_reflectionprobegenerate") == 1) {
    return;
  }
  for(;;) {
    _func_CE942237D1ECA7D8(bink);
    wait 10;
  }
}

_id_B385569E197AE59B() {
  scripts\engine\utility::flag_wait("rockable_cars_init");

  foreach(car in level.rockablecars.cars) {
    if(car getscriptableparthasstate("Window_Blast", "hide")) {
      car setscriptablepartstate("Window_Blast", "hide");
      continue;
    }

    car setscriptablepartstate("Window_Blast", "destroyed");
  }
}