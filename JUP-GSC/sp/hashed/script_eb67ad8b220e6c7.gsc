/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_eb67ad8b220e6c7.gsc
************************************************/

#using scripts\engine\utility;
#namespace lighting_dvars;

function init() {
  wait 0.05;
  flag_wait("player_spawned_with_loadout");

  if(level.player isps4player() || level.player isxb3player()) {
    setDvar(@ "hash_8adcf05d62fe94fd", 0);
    setDvar(@ "hash_1d03444cd52cc348", 0);
    setDvar(@ "hash_6d194d6c7f21172e", 1);
    setDvar(@ "hash_2d74914ecc30bb62", 16);
    setDvar(@ "hash_4778772d83d5a997", "8 0 1 0");
    setDvar(@ "hash_8dfe778be90d1cbc", 0);
    setDvar(@ "hash_e3f56fe404e467cb", 2);
    setDvar(@ "hash_5b73c78e77a0a6d5", 1);
    setDvar(@ "hash_6e3f8cef6be16b33", 0);
    setDvar(@ "hash_1ea8544d78048529", 0);
    setDvar(@ "hash_ea4c44a08cd23d5d", 0.2);
    setDvar(@ "hash_dacffbfd52c2fdc5", 8);
    setDvar(@ "hash_5d66c2ef5a9612e0", 1);
    setDvar(@ "hash_eca4b727b01fd254", 8);
    setDvar(@ "hash_63eb1893f96ac98d", 4);
    setDvar(@ "hash_e08232af8b8b695c", 2);
    setDvar(@ "hash_5a83a561cb4970b2", "2176");
    setDvar(@ "sm_sunsamplesizenear", 0.25);
    setDvar(@ "hash_4c14e16355aa5cb0", 2);
    setDvar(@ "hash_4c14e46355aa6349", 2);
    setDvar(@ "hash_63b517de4ccc57cd", 0);
    setDvar(@ "hash_8667c0bb90c5bfc3", 0);
    setDvar(@ "r_spotlightentityshadows", 0);
    setDvar(@ "hash_1dde331a8e0153d8", 4);
    setDvar(@ "hash_a083dfcc7a54f85f", 1);
    setDvar(@ "hash_f1d740f1f4306d8f", 1);
    setDvar(@ "hash_898c20905541cb73", 1);
    setDvar(@ "hash_633e1a62bb5ceeb2", 1);
    setDvar(@ "hash_1fc47d6f68e1faf", 0);
    setDvar(@ "hash_5b1b5bd738a5436f", 0);
    setDvar(@ "hash_93b4b56b615317b9", 999999);
    setDvar(@ "hash_6af4238b48dd61c", 0);
    setDvar(@ "hash_9dae7d2931a373dd", 1);
    setDvar(@ "hash_68f03c897f2ed29e", 2);
    setDvar(@ "hash_924d46a5bf2c1f5d", 1.5);
    setDvar(@ "hash_a32719b6bbd25f1e", 1.5);
    setDvar(@ "hash_55f8fe20a6ed10b5", 1);
    return;
  }

  if(level.player ispcplayer()) {
    setDvar(@ "hash_8adcf05d62fe94fd", 0);
    setDvar(@ "hash_1d03444cd52cc348", 0);
    setDvar(@ "hash_6d194d6c7f21172e", 1);
    setDvar(@ "hash_5b73c78e77a0a6d5", 1);
    setDvar(@ "hash_2d74914ecc30bb62", 16);
    setDvar(@ "hash_4778772d83d5a997", "8 0 1 0");
    setDvar(@ "hash_6e3f8cef6be16b33", 1);
    setDvar(@ "hash_1ea8544d78048529", 1);
    setDvar(@ "hash_ea4c44a08cd23d5d", 0.2);
    setDvar(@ "hash_dacffbfd52c2fdc5", 8);
    setDvar(@ "hash_5d66c2ef5a9612e0", 1);
    setDvar(@ "hash_eca4b727b01fd254", 8);
    setDvar(@ "hash_63eb1893f96ac98d", 4);
    setDvar(@ "hash_e08232af8b8b695c", 2);
    setDvar(@ "hash_5a83a561cb4970b2", "2176");
    setDvar(@ "sm_sunsamplesizenear", 0.25);
    setDvar(@ "hash_4c14e16355aa5cb0", 2);
    setDvar(@ "hash_4c14e46355aa6349", 2);
    setDvar(@ "hash_63b517de4ccc57cd", 0);
    setDvar(@ "hash_8667c0bb90c5bfc3", 0);
    setDvar(@ "r_spotlightentityshadows", 0);
    setDvar(@ "hash_1dde331a8e0153d8", 4);
    setDvar(@ "hash_a083dfcc7a54f85f", 1);
    setDvar(@ "hash_f1d740f1f4306d8f", 1);
    setDvar(@ "hash_898c20905541cb73", 1);
    setDvar(@ "hash_633e1a62bb5ceeb2", 1);
    setDvar(@ "hash_1fc47d6f68e1faf", 0);
    setDvar(@ "hash_5b1b5bd738a5436f", 0);
    setDvar(@ "hash_93b4b56b615317b9", 999999);
    setDvar(@ "hash_6af4238b48dd61c", 0);
    setDvar(@ "hash_9dae7d2931a373dd", 1);
    setDvar(@ "hash_68f03c897f2ed29e", 2);
    setDvar(@ "hash_924d46a5bf2c1f5d", 1.5);
    setDvar(@ "hash_a32719b6bbd25f1e", 1.5);
    setDvar(@ "hash_55f8fe20a6ed10b5", 1);
    return;
  }

  setDvar(@ "hash_8adcf05d62fe94fd", 0);
  setDvar(@ "hash_1d03444cd52cc348", 0);
  setDvar(@ "hash_6d194d6c7f21172e", 1);
  setDvar(@ "hash_5b73c78e77a0a6d5", 1);
  setDvar(@ "hash_2d74914ecc30bb62", 16);
  setDvar(@ "hash_4778772d83d5a997", "8 0 1 0");
  setDvar(@ "hash_6e3f8cef6be16b33", 1);
  setDvar(@ "hash_1ea8544d78048529", 1);
  setDvar(@ "hash_ea4c44a08cd23d5d", 0.2);
  setDvar(@ "hash_dacffbfd52c2fdc5", 8);
  setDvar(@ "hash_5d66c2ef5a9612e0", 1);
  setDvar(@ "hash_eca4b727b01fd254", 8);
  setDvar(@ "hash_63eb1893f96ac98d", 4);
  setDvar(@ "hash_e08232af8b8b695c", 2);
  setDvar(@ "hash_5a83a561cb4970b2", "2176");
  setDvar(@ "sm_sunsamplesizenear", 0.25);
  setDvar(@ "hash_4c14e16355aa5cb0", 2);
  setDvar(@ "hash_4c14e46355aa6349", 2);
  setDvar(@ "hash_63b517de4ccc57cd", 0);
  setDvar(@ "hash_8667c0bb90c5bfc3", 0);
  setDvar(@ "r_spotlightentityshadows", 0);
  setDvar(@ "hash_1dde331a8e0153d8", 4);
  setDvar(@ "hash_a083dfcc7a54f85f", 1);
  setDvar(@ "hash_f1d740f1f4306d8f", 1);
  setDvar(@ "hash_898c20905541cb73", 1);
  setDvar(@ "hash_633e1a62bb5ceeb2", 1);
  setDvar(@ "hash_1fc47d6f68e1faf", 0);
  setDvar(@ "hash_5b1b5bd738a5436f", 0);
  setDvar(@ "hash_93b4b56b615317b9", 999999);
  setDvar(@ "hash_6af4238b48dd61c", 0);
  setDvar(@ "hash_9dae7d2931a373dd", 1);
  setDvar(@ "hash_68f03c897f2ed29e", 2);
  setDvar(@ "hash_924d46a5bf2c1f5d", 1.5);
  setDvar(@ "hash_a32719b6bbd25f1e", 1.5);
  setDvar(@ "hash_55f8fe20a6ed10b5", 1);
  setDvar(@ "hash_8dfe778be90d1cbc", 1);
  setDvar(@ "hash_e3f56fe404e467cb", 2);
}

function function_2df0e672265f272f() {
  while(true) {
    if(getomnvar(0, "winner_circle_lgt_dvars") == 1) {
      break;
    }

    waitframe();
  }

  if(isplatformxb3() || isplatformps4()) {
    setDvar(@ "hash_6e3f8cef6be16b33", 1);
    setDvar(@ "hash_1ea8544d78048529", 1);
    setDvar(@ "hash_dacffbfd52c2fdc5", "32");
    setDvar(@ "hash_63eb1893f96ac98d", 8);
    setDvar(@ "hash_e08232af8b8b695c", 6);
    setDvar(@ "hash_ea4c44a08cd23d5d", 2);
    setDvar(@ "hash_1dde331a8e0153d8", 16);
    setDvar(@ "hash_c75b193e083a0e5", 1);
    setDvar(@ "hash_503f548196f716a", 0.2);
  }

  if(function_33d2520f3f4c794() || function_8f7452209f2fa982() || isplatformpc()) {
    setDvar(@ "hash_6e3f8cef6be16b33", 1);
    setDvar(@ "hash_1ea8544d78048529", 1);
    setDvar(@ "hash_dacffbfd52c2fdc5", "32");
    setDvar(@ "hash_63eb1893f96ac98d", 8);
    setDvar(@ "hash_e08232af8b8b695c", 6);
    setDvar(@ "hash_ea4c44a08cd23d5d", 2);
    setDvar(@ "hash_1dde331a8e0153d8", 16);
    setDvar(@ "hash_c75b193e083a0e5", 1);
    setDvar(@ "hash_503f548196f716a", 0.3);
  }
}

function infil() {
  while(true) {
    if(getomnvar(0, "infil_lgt_dvars") == 1) {
      break;
    }

    waitframe();
  }

  if(isplatformxb3() || isplatformps4()) {
    setDvar(@ "hash_6e3f8cef6be16b33", 1);
    setDvar(@ "hash_1ea8544d78048529", 1);
    setDvar(@ "hash_dacffbfd52c2fdc5", "32");
    setDvar(@ "hash_63eb1893f96ac98d", 8);
    setDvar(@ "hash_e08232af8b8b695c", 6);
    setDvar(@ "hash_ea4c44a08cd23d5d", 1);
    setDvar(@ "hash_1dde331a8e0153d8", 16);
    setDvar(@ "hash_c75b193e083a0e5", 1);
    setDvar(@ "hash_503f548196f716a", 0.2);
  }

  if(function_33d2520f3f4c794() || function_8f7452209f2fa982() || isplatformpc()) {
    setDvar(@ "hash_6e3f8cef6be16b33", 1);
    setDvar(@ "hash_1ea8544d78048529", 1);
    setDvar(@ "hash_dacffbfd52c2fdc5", "32");
    setDvar(@ "hash_63eb1893f96ac98d", 8);
    setDvar(@ "hash_e08232af8b8b695c", 6);
    setDvar(@ "hash_ea4c44a08cd23d5d", 1);
    setDvar(@ "hash_1dde331a8e0153d8", 16);
    setDvar(@ "hash_c75b193e083a0e5", 1);
    setDvar(@ "hash_503f548196f716a", 0.3);
  }

  while(true) {
    if(getomnvar(0, "infil_lgt_dvars") == 0) {
      break;
    }

    waitframe();
  }

  if(isplatformxb3() || isplatformps4()) {
    setDvar(@ "hash_6e3f8cef6be16b33", 0);
    setDvar(@ "hash_1ea8544d78048529", 0);
    setDvar(@ "hash_dacffbfd52c2fdc5", "8");
    setDvar(@ "hash_63eb1893f96ac98d", 4);
    setDvar(@ "hash_e08232af8b8b695c", 2);
    setDvar(@ "hash_ea4c44a08cd23d5d", 0.2);
    setDvar(@ "hash_1dde331a8e0153d8", 4);
    setDvar(@ "hash_c75b193e083a0e5", 0);
    setDvar(@ "hash_503f548196f716a", 0);
  }

  if(function_33d2520f3f4c794() || function_8f7452209f2fa982() || isplatformpc()) {
    setDvar(@ "hash_6e3f8cef6be16b33", 1);
    setDvar(@ "hash_1ea8544d78048529", 1);
    setDvar(@ "hash_dacffbfd52c2fdc5", "32");
    setDvar(@ "hash_63eb1893f96ac98d", 4);
    setDvar(@ "hash_e08232af8b8b695c", 2);
    setDvar(@ "hash_ea4c44a08cd23d5d", 0.2);
    setDvar(@ "hash_1dde331a8e0153d8", 4);
    setDvar(@ "hash_c75b193e083a0e5", 0);
    setDvar(@ "hash_503f548196f716a", 0);
  }
}

function function_dad02d81e667c615() {
  while(true) {
    if(getomnvar(0, "lgt_ball_turret_killstreak_in_progress") == 1) {
      setDvar(@ "hash_becfcdfa654305b0", "0 0 10000");
    } else {
      setDvar(@ "hash_becfcdfa654305b0", "0 0 0");
    }

    waitframe();
  }
}