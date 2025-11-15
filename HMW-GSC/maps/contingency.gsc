main() {
  maps\mp\_load::main();
  maps\mp\_compass::setupminimap("compass_map_contingency");
  setdvar("r_umbra", 1);
  setdvar("r_fog", 0);
  setdvar("r_tessellation", 0);
  setdvar("compassmaxrange", "3500");
  maps\createart\contingency_art::main();
  maps\createart\contingency_fog::main();
  maps\createart\contingency_fog_hdr::main();
}