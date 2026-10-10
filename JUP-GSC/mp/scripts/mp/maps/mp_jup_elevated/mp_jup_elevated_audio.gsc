/************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_elevated\mp_jup_elevated_audio.gsc
************************************************************************/

#using scripts\engine\utility;
#namespace mp_jup_elevated_audio;

function main() {
  thread function_76d63eb8f9f0f0a6();
}

function function_76d63eb8f9f0f0a6() {
  level endon("game_ended");
  level scripts\engine\utility::waittill_notify_or_timeout("matchStartTimer_done", 8);

  while(true) {
    var_325034ce6851bd17 = randomfloatrange(36, 40);
    wait var_325034ce6851bd17;
    playsoundatpos((556.1, -2428.9, 60), "amb_emt_subway_passby_l");
    playsoundatpos((339.7, -2424, 60), "amb_emt_subway_passby_r");
    var_325034ce6851bd17 = randomfloatrange(7, 7.5);
    wait var_325034ce6851bd17;
    playsoundatpos((341.9, -2426.3, 75), "amb_emt_subway_fence_rattle_r");
    var_325034ce6851bd17 = randomfloatrange(1, 1.1);
    wait var_325034ce6851bd17;
    playsoundatpos((554.7, -2422.7, 75), "amb_emt_subway_fence_rattle_l");
  }
}