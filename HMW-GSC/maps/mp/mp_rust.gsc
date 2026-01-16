main() {

  maps\mp\mp_rust_precache::main();
  maps\createart\mp_rust_art::main();
  maps\mp\mp_rust_fx::main();

  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_rust");

  setdvar("compassmaxrange", "1400");

  ambientPlay("ambient_mp_duststorm");

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  setdvar("r_tessellation", 0);
  setdvar("r_lodBiasRigid", -2000);
  setdvar("r_lodBiasSkinned", -2000);
  setdvar("r_drawSun", 0);
  setdvar("r_umbra", 1);
  setdvar("r_fog", 1);
  setdvar("r_filmusetweaks", 0);
}