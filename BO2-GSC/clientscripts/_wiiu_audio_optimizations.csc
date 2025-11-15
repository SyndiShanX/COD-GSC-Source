/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_wiiu_audio_optimizations.csc
*********************************************************/

main() {
  mapname = getdvar(#"mapname");
  servercore = 0;
  backendcore = 2;
  mixthreadenabled = 1;
  mixthreadcore = backendcore;
  maxaxppcusage = 30;

  if(mapname == "mp_overflow") {
  }

  if(mapname == "angola")
    maxaxppcusage = 15;

  setdvarbool("sd_wiiu_mix_thread_enabled", mixthreadenabled);
  setdvarint("sd_wiiu_mix_thread_core", mixthreadcore);
  setdvarfloat("sd_wiiu_max_ppc_usage", maxaxppcusage);
}