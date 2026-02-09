main() {
  maps\mp\mp_rust_precache::main();
  maps\createart\mp_rust_art::main();
  maps\mp\mp_rust_fx::main();

  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_rust");

  setDvar("compassmaxrange", "1400");

  ambientPlay("ambient_mp_duststorm");

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  setDvar("r_tessellation", 0);
  setDvar("r_lodBiasRigid", -2000);
  setDvar("r_lodBiasSkinned", -2000);
  setDvar("r_drawSun", 0);
  setDvar("r_umbra", 1);
  setDvar("r_fog", 1);
  setDvar("r_filmusetweaks", 0);
}