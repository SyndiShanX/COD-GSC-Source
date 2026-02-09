main() {
  maps\mp\_load::main();
  maps\mp\_compass::setupminimap("compass_map_contingency");
  setDvar("r_umbra", 1);
  setDvar("r_fog", 0);
  setDvar("r_tessellation", 0);
  setDvar("compassmaxrange", "3500");
  maps\createart\contingency_art::main();
  maps\createart\contingency_fog::main();
  maps\createart\contingency_fog_hdr::main();
}