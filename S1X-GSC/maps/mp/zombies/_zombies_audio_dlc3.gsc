/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\_zombies_audio_dlc3.gsc
***************************************************/

initdlc3audio() {
  level._zmbvoxlevelspecific = ::initleveldialog;
  level.zmbsoundlengthpath = "mp/sound/soundlength_zm_mp_dlc3.csv";
  level.zmbaudiozonetrackingdelay = 5;
  level.zmbplayersmet = 0;
  level.zmbaudioscheduleoz = randomintrange(10, 21);
  level.zmballcustomozresponsesplayed = 0;
  level.numkitingconversations = 18;
  level.zmbaudiowave1vo = ::zmbaudiowave1vo;
  level.zmbwaveintermissionvo = ::zmbwaveintermissionvo;
  level.zmbaudiowavestartvo = ::zmbaudiowavestartvo;
  level.zmbdowaveendvo = ::zmbdowaveendvo;
  level.zmaudiocustomtrapvo = ::zmaudiocustomtrapvo;
  level.zmbaudioplayaltvofunc = ::zmbaudioplayaltvofunc;
  level.zmbaudioresponsetoannounceroverridefunc = ::zmbaudioresponsetoannounceroverridefunc;
  level.zmbcustomresponsetoannouncer = ::zmbcustomresponsetoannouncer;
  level.zmbcustomsupplydropvo = ::zmbcustomsupplydropvo;
  level.zmbaudiokitingcustom = ::zmbaudiokitingcustom;
  level thread zmbspotzombiesvo();
  level thread fixupterminalattractors();
}

initleveldialog() {
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "ignore_nearby", "dlc3_open_01", "dlc3_open_01", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "ignore_nearby", "dlc3_open_02", "dlc3_open_02", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "ignore_nearby", "dlc3_open_03", "dlc3_open_03", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "ignore_nearby", "intro", "rnd_wave1", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "global_priority", "meet1", "meet_01", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "global_priority", "meet2", "meet_02", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "global_priority", "meet3", "meet_03", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "spot_first_goliath", "goliath_spot_first", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "spot_goliath", "goliath_spot", undefined, 40);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "goliath_shoot", "goliath_shoot", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "spot_first_spiked", "dlc2_spike1st", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "spot_spiked", "dlc2_spikespot", undefined, 10);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "spot_first_teleport", "dlc3_blink1st", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "spot_teleport", "dlc3_blink", undefined, 10);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "td_spot", "dlc3_td_spot", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "td_lose", "dlc3_td_lose", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "td_win", "dlc3_td_win", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "turret_trap", "trap_roomba", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "laser", "traps_pckup", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "steam", "trap_steam", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "water_floor_trap", "trap_wtr", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "zomboni", "dlc3_gtrap", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "plinko_see", "dlc3_plinko_see", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "plinko_small", "dlc3_plinko_small", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "plinko_med", "dlc3_plinko_med", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "plinko_lrg", "dlc3_plinko_lrg", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "atlas_react", "dlc3_atlas", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "atlas_conv", "atlas_conv", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "sentinel_conv", "sentinel_conv", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "teleport_use", "dlc3_teleport_use", undefined, 20);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "ss_use_disruptor", "ss_disrupt", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "chum_water", "trap_shrk", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "general", "oz_response", "oz_response", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "monologue", "oz_response", "oz_response", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "weapon_pickup", "teleport_zombies_mp", "dlc3_teleport", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "weapon_pickup", "teleport_throw_zombies_mp", "dlc3_teleport", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "weapon_pickup", "iw5_linegunzm_mp", "dlc3_linegun", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "weapon_pickup", "iw5_dlcgun2zm_mp", "dlc3_ohm", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "weapon_pickup", "iw5_dlcgun3zm_mp", "dlc3_m1i", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "weapon_pickup", "repulsor_zombie_mp", "dlc3_repulsor", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "kill", "linegun", "dlc3_linegun_kill", undefined, 7);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "kill", "ohm", "dlc3_ohm_kill", undefined, 7);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "kill", "m1irons", "dlc3_m1i_kill", undefined, 7);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "kill", "respulsor", "dlc3_repulsor_kill", undefined, 7);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "kill", "goliath_kill", "goliath_kill", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "powerup", "open_fire", "dlc3_inf_ammo", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "powerup", "ex_touch", "dlc3_overcharge", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "perk", "exo_tacticalArmor", "dlc3_exo_stck", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "monologue", "teleport_machine", "dlc3_tele", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_it_1", "it_exec_wave_intermission_ctx01", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_exec_2", "it_exec_wave_intermission_ctx02", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_it_3", "it_exec_wave_intermission_ctx03", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_it_4", "it_exec_wave_intermission_ctx04", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_it_5", "it_exec_wave_intermission_ctx05", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_exec_6", "it_exec_wave_intermission_ctx06", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_it_7", "it_exec_wave_intermission_ctx07", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_exec_1", "guard_exec_wave_intermission_ctx01", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_exec_2", "guard_exec_wave_intermission_ctx02", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_exec_3", "guard_exec_wave_intermission_ctx03", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_exec_4", "guard_exec_wave_intermission_ctx04", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_pilot_1", "pilot_exec_wave_intermission_ctx01", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_pilot_2", "pilot_exec_wave_intermission_ctx02", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_pilot_3", "pilot_exec_wave_intermission_ctx03", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_pilot_4", "pilot_exec_wave_intermission_ctx04", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "pilot_exec_5", "pilot_exec_wave_intermission_ctx05", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "pilot_exec_6", "pilot_exec_wave_intermission_ctx06", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "pilot_exec_7", "pilot_exec_wave_intermission_ctx07", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_it_1", "it_guard_wave_intermission_ctx01", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_guard_2", "it_guard_wave_intermission_ctx02", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_it_3", "it_guard_wave_intermission_ctx03", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_it_4", "it_guard_wave_intermission_ctx04", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_it_5", "it_guard_wave_intermission_ctx05", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_it_6", "it_guard_wave_intermission_ctx06", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_guard_7", "it_guard_wave_intermission_ctx07", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_guard_8", "it_guard_wave_intermission_ctx08", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_it_9", "it_guard_wave_intermission_ctx09", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_pilot_1", "it_pilot_wave_intermission_ctx01", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_pilot_2", "it_pilot_wave_intermission_ctx02", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_pilot_3", "it_pilot_wave_intermission_ctx03", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_pilot_4", "it_pilot_wave_intermission_ctx04", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_pilot_5", "it_pilot_wave_intermission_ctx05", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_pilot_6", "it_pilot_wave_intermission_ctx06", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_pilot_7", "it_pilot_wave_intermission_ctx07", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_pilot_8", "it_pilot_wave_intermission_ctx08", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "pilot_it_9", "it_pilot_wave_intermission_ctx09", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_pilot_10", "it_pilot_wave_intermission_ctx10", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_pilot_11", "it_pilot_wave_intermission_ctx11", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_pilot_1", "guard_pilot_wave_intermission_ctx01", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "pilot_guard_2", "guard_pilot_wave_intermission_ctx02", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "pilot_guard_3", "guard_pilot_wave_intermission_ctx03", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_pilot_4", "guard_pilot_wave_intermission_ctx04", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_pilot_5", "guard_pilot_wave_intermission_ctx05", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_pilot_6", "guard_pilot_wave_intermission_ctx06", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "pilot_guard_7", "guard_pilot_wave_intermission_ctx07", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "open_fire", "open_fire", "powerup,open_fire");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "ex_touch", "ex_touch", "powerup,ex_touch");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "exp_rearbay", "exp_rearbay", "general,atlas_react");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "exp_moonpool", "exp_moonpool", "general,atlas_react");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "exp_armory", "exp_armory", "general,atlas_react");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "exp_cargo_elevator", "exp_cargo_elevator", "general,atlas_react");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "exp_cargo_bay", "exp_cargo_bay", "general,atlas_react");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "exp_biomed", "exp_biomed", "general,atlas_react");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "exp_medical", "exp_medical", "general,atlas_react");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "exp_sidebay", "exp_sidebay", "general,atlas_react");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "exp_fail1", "exp_fail1", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "exp_fail2", "exp_fail2", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "exp_fail3", "exp_fail3", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "exp_win", "exp_win", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "exp_round", "exp_round", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "exp_round_gol", "exp_round_gol", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global", "power_rearbay", "pow_rearbay", "general,power_on");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global", "power_moonpool", "pow_moonpool", "general,power_on");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global", "power_armory", "pow_armory", "general,power_on");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global", "power_cargo_elevator", "pow_cargo_elevator", "general,power_on");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global", "power_cargo_01", "pow_cargo_bay", "general,power_on");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global", "power_biomed", "pow_biomed", "general,power_on");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global", "power_medbay", "pow_medical", "general,power_on");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global", "power_sidebay_01", "pow_sidebay", "general,power_on");
  var_0 = spawnStruct();
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("atlas", "atlas_", var_0, 0);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("atlas", "general", "chatter", "chatter", undefined, 30);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("atlas", "general", "trydefuse", "trydefuse", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("atlas", "general", "fail", "fail", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("atlas", "general", "goliath", "goliath", undefined);
  level.atlasdebouncevo = [];
  level.atlasdebouncevo["chatter"] = 0;
  level.atlasdebouncevo["trydefuse"] = 0;
  level.atlasdebouncevo["fail"] = 0;
  level.atlasdebouncevo["goliath"] = 0;
  var_0 = spawnStruct();
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("sentinel", "sent_", var_0, 0);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("sentinel", "general", "spawn", "spawn", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("sentinel", "general", "kill", "kill", undefined, 30);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("sentinel", "general", "chatter", "chatter", undefined, 40);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("sentinel", "general", "defuse", "defuse", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("sentinel", "general", "revive", "revive", undefined);
  level.sentineldebouncevo = [];
  level.sentineldebouncevo["spawn"] = 0;
  level.sentineldebouncevo["kill"] = 0;
  level.sentineldebouncevo["chatter"] = 0;
  level.sentineldebouncevo["revive"] = 0;
  var_1 = spawn("script_model", (0, 0, 0));
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("announcer_oz", "janitor_", var_1, 0);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "global_priority", "exo_suit_avail", "exo_suit_avail", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "global_priority", "exo_online", "exo_online", "general,thanks");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "global_priority", "hyper_dmg", "hyper_dmg", "powerup,insta_kill");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "global_priority", "dna_bomb", "dna_bomb", "powerup,apocalypse");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "global_priority", "pow_surge", "pow_surge", "powerup,pow_surge");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "global_priority", "full_reload", "full_reload", "powerup,max_ammo");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "global_priority", "multiplier", "multiplier", "powerup,2x_pts");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "global_priority", "security", "security", "powerup,traps");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "global_priority", "zombie_dog", "mongrel", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "global_priority", "zombie_host", "host", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "global_priority", "open_fire", "inf_ammo", "powerup,open_fire");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "global_priority", "ex_touch", "overcharge", "powerup,ex_touch");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "global", "door", "door", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "global", "printer", "printer_bk", "general,printer_moved");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "global", "supply", "supply", undefined, 30);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "global", "rand", "rand", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "machine_all_players", "host_cure", "cure", "general,cured");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "machine_all_players", "host_cure2", "cure2", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "machine_all_players", "laser_trap", "trap", "general,laser_traps");
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "machine_all_players", "jackpot", "cash_ee", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "machine_per_player", "specialty_fastreload", "exo_reload", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "machine_per_player", "exo_health", "exo_health", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "machine_per_player", "exo_revive", "exo_medic", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "machine_per_player", "exo_stabilizer", "exo_soldier", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "machine_per_player", "exo_slam", "exo_slam", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "machine_per_player", "wallbuy", "wallbuy", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "machine_per_player", "printer", "printer", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "machine_per_player", "weapon_upgrade", "wpn_upgd", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "machine_per_player", "power_switch", "pwr_swtich", undefined);
}

fixupterminalattractors() {
  var_0 = getEntArray("perk_terminal", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_parameters) && var_2.script_parameters == "exo_stabilizer") {
      var_2.postpowerattractorwait = 3;
    }
  }

  var_4 = getEntArray("weapon_level_box", "targetname");

  foreach(var_6 in var_4) {
    var_6.firsttimeattractorwait = 5;
  }
}

anyplayersspeaking() {
  foreach(var_1 in level.players) {
    if(maps\mp\zombies\_util::is_true(var_1.isspeaking)) {
      return 1;
    }
  }

  return 0;
}

waittilldonespeaking() {
  while(anyplayersspeaking() || maps\mp\zombies\_zombies_audio_announcer::isannouncerspeaking()) {
    waitframe();
  }
}

getclosestplayer(var_0) {
  var_1 = sortbydistance(level.players, var_0, undefined, 1);
  return var_1[0];
}

zmbaudiowave1vo() {
  if(level.players.size == 1) {
    level.players[0] maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "intro");
    level.zmbplayersmet = 1;
  } else {
    var_0 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("pilot");
    var_1 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("it");
    var_2 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("exec");
    var_3 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("guard");

    if(level.players.size == 3) {
      if(isDefined(var_0) && !isDefined(var_1)) {
        var_0 maps\mp\zombies\_zombies_audio::create_and_play_dialog("ignore_nearby", "intro", undefined, undefined, undefined, undefined, [var_0]);
      } else if(isDefined(var_1) && !isDefined(var_0)) {
        var_1 maps\mp\zombies\_zombies_audio::create_and_play_dialog("ignore_nearby", "intro", undefined, undefined, undefined, undefined, [var_1]);
      } else if(isDefined(var_2) && !isDefined(var_3)) {
        var_2 maps\mp\zombies\_zombies_audio::create_and_play_dialog("ignore_nearby", "intro", undefined, undefined, undefined, undefined, [var_2]);
      } else if(isDefined(var_3) && !isDefined(var_2)) {
        var_3 maps\mp\zombies\_zombies_audio::create_and_play_dialog("ignore_nearby", "intro", undefined, undefined, undefined, undefined, [var_3]);
      }
    }

    if(isDefined(var_0) && isDefined(var_1)) {
      level thread zmbintrodialogue(var_0, var_1);
    }

    if(isDefined(var_2) && isDefined(var_3)) {
      level thread zmbintrodialogue(var_2, var_3);
    }

    if(level.players.size > 2 && isDefined(var_0)) {
      level waittill("zmbIntroDialogue");
      level thread zmbaudioplayersmeet(var_0);
    } else {
      level.zmbplayersmet = 1;
    }
  }
}

zmbintrodialogue(var_0, var_1) {
  var_2 = isDefined(var_0) && isDefined(var_1);

  if(var_0 maps\mp\zombies\_zombies_audio::create_and_play_dialog("ignore_nearby", "dlc3_open_01", undefined, undefined, undefined, undefined, [var_0, var_1])) {
    var_0 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 10);
    var_2 = isDefined(var_0) && isDefined(var_1);
  }

  if(var_2 && var_1 maps\mp\zombies\_zombies_audio::create_and_play_dialog("ignore_nearby", "dlc3_open_01", undefined, undefined, undefined, undefined, [var_0, var_1])) {
    var_1 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 10);
    var_2 = isDefined(var_0) && isDefined(var_1);
  }

  if(var_2 && var_0 maps\mp\zombies\_zombies_audio::create_and_play_dialog("ignore_nearby", "dlc3_open_02", undefined, undefined, undefined, undefined, [var_0, var_1])) {
    var_0 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 10);
    var_2 = isDefined(var_0) && isDefined(var_1);
  }

  if(var_2 && var_1 maps\mp\zombies\_zombies_audio::create_and_play_dialog("ignore_nearby", "dlc3_open_02", undefined, undefined, undefined, undefined, [var_0, var_1])) {
    var_1 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 10);
    var_2 = isDefined(var_0) && isDefined(var_1);
  }

  if(var_2 && var_0 maps\mp\zombies\_zombies_audio::create_and_play_dialog("ignore_nearby", "dlc3_open_03", undefined, undefined, undefined, undefined, [var_0, var_1])) {
    var_0 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 10);
  }

  level notify("zmbIntroDialogue");
}

zmbaudioplayersmeet(var_0) {
  while(!isDefined(level.zone_data)) {
    wait 0.05;
  }

  for(;;) {
    if(!isDefined(var_0)) {
      level.zmbplayersmet = 1;
      return;
    }

    if(anyplayersspeaking()) {
      wait 1;
      continue;
    }

    var_1 = getarraykeys(level.zone_data.zones);

    foreach(var_3 in var_1) {
      var_4 = maps\mp\zombies\_zombies_zone_manager::getplayersinzone(var_3, 0);

      if(var_4.size > 1) {
        if(listincludescharacter(var_4, "pilot") && (listincludescharacter(var_4, "guard") || listincludescharacter(var_4, "exec"))) {
          var_5 = var_0;
          var_6 = getcharacterfromlist(var_4, "guard");
          var_7 = getcharacterfromlist(var_4, "exec");
          var_8 = var_6;

          if(!isDefined(var_6) || isDefined(var_7) && common_scripts\utility::cointoss()) {
            var_8 = var_7;
          }

          var_9 = isDefined(var_5) && isDefined(var_8);
          maps\mp\zombies\_zombies_audio::zmbsetglobalpriorityonly(1);

          if(var_5 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority", "meet1")) {
            var_5 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 10);
            var_9 = isDefined(var_5) && isDefined(var_8);
          }

          if(var_9 && var_8 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority", "meet2")) {
            var_8 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 10);
            var_9 = isDefined(var_5) && isDefined(var_8);
          }

          if(var_9 && var_5 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority", "meet3")) {
            var_5 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 10);
          }

          maps\mp\zombies\_zombies_audio::zmbsetglobalpriorityonly(0);
          level.zmbplayersmet = 1;
          return;
        }
      }
    }

    wait 1;
  }
}

listincludescharacter(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(var_3.characterindex == maps\mp\zombies\_zombies_audio::getcharacterindexbyprefix(var_1)) {
      return 1;
    }
  }

  return 0;
}

getcharacterfromlist(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(var_3.characterindex == maps\mp\zombies\_zombies_audio::getcharacterindexbyprefix(var_1)) {
      return var_3;
    }
  }
}

zmbaudiowavestartvo(var_0) {
  if(!var_0 && (level.wavecounter == 5 || level.wavecounter == 10 || level.wavecounter == 20 || level.wavecounter == 35 || level.wavecounter == 50)) {
    var_1 = randomintrange(0, level.players.size);
    level.players[var_1] maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "round_" + level.wavecounter);
    var_0 = 1;
  }

  return var_0;
}

zmbdowaveendvo() {
  return !maps\mp\zombies\_area_invalidation::is_next_round_transition_venting();
}

zmbwaveintermissionvo(var_0) {
  if(!level.zmbplayersmet) {
    return 1;
  } else if(maps\mp\zombies\_area_invalidation::is_next_round_transition_venting()) {
    level common_scripts\utility::waittill_notify_or_timeout("area_invalidation_vo_complete", 8);
    return 1;
  }

  return 0;
}

zmaudiocustomtrapvo(var_0, var_1) {
  wait 1;

  if(!isDefined(var_0.script_noteworthy) || !isDefined(var_1)) {
    return;
  }
  var_1 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", var_0.script_noteworthy);
}

zmbspotzombiesvo() {
  level thread zmbspotzombie("spiked");
  level thread zmbspotzombie("teleport");
  level thread zmbhandlegoliath();
}

zmbhandlegoliath() {
  level.zmbaudioplayedfirstspotmeleegoliath = 0;

  for(;;) {
    level waittill("onZombieMeleeGoliathSpawn", var_0);
    level thread zmbspotgoliath(var_0);
  }
}

zmbspotgoliath(var_0) {
  var_0 endon("death");
  var_1 = 1;
  level thread notifyongoliathdamaged(var_0, "waittillPlayerSpotsGoliathReturn", "damage");
  level thread notifyonplayerclosetogoliath(var_0, "waittillPlayerSpotsGoliathReturn", "close");

  for(;;) {
    var_0 waittill("waittillPlayerSpotsGoliathReturn", var_2, var_3);

    if(!isDefined(var_2)) {
      continue;
    }
    if(!level.zmbaudioplayedfirstspotmeleegoliath) {
      if(var_2 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "spot_first_goliath")) {
        var_1 = 0;
        level.zmbaudioplayedfirstspotmeleegoliath = 1;
      }
    } else if(var_1) {
      var_2 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "spot_goliath");
      var_1 = 0;
    } else if(var_3 == "damage" && var_0.health <= var_0.maxhealth / 2) {
      if(var_2 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "goliath_shoot")) {
        return;
      }
    }

    waitframe();
    level thread notifyongoliathdamaged(var_0, "waittillPlayerSpotsGoliathReturn", "damage");
  }
}

notifyongoliathdamaged(var_0, var_1, var_2) {
  var_0 endon(var_1);
  var_0 endon("death");

  for(;;) {
    var_0 waittill("damage", var_3, var_4);
    var_0 notify(var_1, var_4, var_2);
  }
}

notifyonplayerclosetogoliath(var_0, var_1, var_2) {
  var_0 endon(var_1);
  var_0 endon("death");

  for(;;) {
    var_3 = getplayerclosetozombie(var_0);

    if(isDefined(var_3)) {
      var_0 notify(var_1, var_3, var_2);
      return;
    }

    waitframe();
  }
}

zmbspotzombie(var_0) {
  level thread notifyonround(7, "end_spot_zombie_round_7");
  level endon("end_spot_zombie_round_7");
  var_1 = 0;

  for(;;) {
    var_2 = waittillplayerspotszombiereturn(var_0);

    if(!isDefined(var_2)) {
      continue;
    }
    if(!var_1) {
      if(var_2 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "spot_first_" + var_0)) {
        var_1 = 1;
        wait 15;
      } else {
        wait 1;
      }

      continue;
    } else {
      var_2 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "spot_" + var_0);
    }

    wait 15;
  }
}

notifyonround(var_0, var_1) {
  for(;;) {
    level waittill("zombie_wave_started");

    if(level.wavecounter >= var_0) {
      level notify(var_1);
      return;
    }
  }
}

waittillplayerspotszombiereturn(var_0) {
  level thread notifyonzombiemutatordamaged(var_0, "waittillPlayerSpotsZombieReturn_" + var_0);
  level thread notifyonplayerclosetozombiemutator(var_0, "waittillPlayerSpotsZombieReturn_" + var_0);
  level waittill("waittillPlayerSpotsZombieReturn_" + var_0, var_1);
  return var_1;
}

notifyonzombiemutatordamaged(var_0, var_1) {
  level endon(var_1);
  level endon("end_spot_zombie_round_7");

  for(;;) {
    level waittill("zombie_damaged", var_2, var_3);

    if(!isDefined(var_3) || !isDefined(var_2) || !var_2 maps\mp\zombies\_util::checkactivemutator(var_0)) {
      continue;
    }
    level notify(var_1, var_3);
    return;
  }
}

notifyonplayerclosetozombiemutator(var_0, var_1) {
  level endon(var_1);
  level endon("end_spot_zombie_round_7");

  for(;;) {
    var_2 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");

    foreach(var_4 in var_2) {
      if(var_4.team == level.playerteam || !var_4 maps\mp\zombies\_util::checkactivemutator(var_0)) {
        continue;
      }
      var_5 = getplayerclosetozombie(var_4);

      if(isDefined(var_5)) {
        level notify(var_1, var_5);
        return;
      }
    }

    waitframe();
  }
}

getplayerclosetozombie(var_0) {
  var_1 = 90000;

  foreach(var_3 in level.players) {
    var_4 = distancesquared(var_3.origin, var_0.origin);

    if(var_4 <= var_1) {
      return var_3;
    }
  }
}

zmbaudioplayaltvofunc(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(self.zmbvoxid == "announcer") {
    level.zmbaudioscheduleoz--;
    var_7 = level.zmbaudioscheduleoz <= 0;

    if(level.zmbaudioscheduleoz <= 0) {
      var_7 = 1;
      level.zmbaudioscheduleoz = randomintrange(10, 21);
    }

    if(!var_7) {
      var_7 = randomint(100) <= level.wavecounter * 2;
    }

    if(var_7) {
      var_8 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("oz")[0];
      var_8.origin = self.origin;
      return var_8 maps\mp\zombies\_zombies_audio::create_and_play_dialog(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
    }
  }

  return 0;
}

zmbaudioresponsetoannounceroverridefunc(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1) || level.zmballcustomozresponsesplayed || var_0.zmbvoxid != "announcer_oz") {
    return 0;
  }

  return var_1 playerdoozresponse(var_2 == "machine_per_player");
}

zmbcustomresponsetoannouncer(var_0, var_1, var_2, var_3, var_4) {
  if(level.zmballcustomozresponsesplayed || var_0.zmbvoxid != "announcer_oz") {
    return 0;
  }

  if(isDefined(var_4)) {
    var_4 = common_scripts\utility::array_removeundefined(var_4);
  }

  if(!isDefined(var_1)) {
    if(maps\mp\zombies\_zombies_audio_announcer::announcercategoryisplaylocal(var_2)) {
      var_1 = zmbgetplayerwithcustomozresponse();
    } else if(isDefined(var_4)) {
      var_1 = zmbgetplayerwithcustomozresponse(undefined, var_4);
    } else {
      var_1 = zmbgetplayerwithcustomozresponse(var_0.origin);
    }
  }

  if(isDefined(var_1)) {
    var_1 playerdoozresponse(var_2 == "machine_per_player");
  }
}

playerdoozresponse(var_0) {
  if(!isDefined(self.customozresponseindex)) {
    self.customozresponseindex = 0;
  }

  var_1 = self.customozresponseindex + 1;
  var_2 = "general";

  if(var_0) {
    var_2 = "monologue";
  }

  if(maps\mp\zombies\_zombies_audio::create_and_play_dialog(var_2, "oz_response", "", var_1)) {
    self.customozresponseindex++;

    if(self.customozresponseindex >= 2 && !isDefined(zmbgetplayerwithcustomozresponse())) {
      level.zmballcustomozresponsesplayed = 1;

      foreach(var_4 in level.players) {
        var_4.customozresponseindex = undefined;
      }
    }

    return 1;
  }

  return 0;
}

zmbgetplayerwithcustomozresponse(var_0, var_1) {
  var_2 = 250000;

  if(!isDefined(var_1)) {
    var_1 = level.players;
  }

  foreach(var_4 in var_1) {
    if((!isDefined(var_4.customozresponseindex) || var_4.customozresponseindex < 2) && (!isDefined(var_0) || distancesquared(var_4.origin, var_0) <= var_2)) {
      return var_4;
    }
  }
}

zmbcustomsupplydropvo() {
  if(!maps\mp\zombies\_util::is_true(level.zmkillstreakcrateprevo) || level.wavecounter < 5) {
    return;
  }
  var_0 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("oz")[0];
  var_0 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global", "supply");
}

zmbaudiokitingcustom() {
  level endon("zombie_wave_ended");
  wait(randomintrange(15, 30));
  var_0 = level.kitingconversations.size - 1;
  var_1 = level.kitingconversations[var_0];
  var_2 = "global";
  var_3 = "rand";
  var_4 = 0;

  if(isDefined(level.vox.speaker["player"].alias[var_2]) && isDefined(level.vox.speaker["player"].alias[var_2][var_3])) {
    var_5 = common_scripts\utility::array_randomize(level.players);

    foreach(var_7 in var_5) {
      maps\mp\zombies\_zombies_audio::waituntilquietnearby(var_7, var_2);
      var_8 = var_7 maps\mp\zombies\_zombies_audio::create_and_play_dialog(var_2, var_3);

      if(var_8) {
        break;
      }
    }
  } else if(isDefined(level.vox.speaker["announcer_oz"].alias[var_2]) && isDefined(level.vox.speaker["announcer_oz"].alias[var_2][var_3])) {
    var_10 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("oz")[0];
    var_10 maps\mp\zombies\_zombies_audio::create_and_play_dialog(var_2, var_3, undefined, undefined, undefined, level.players[0], level.players);
  } else {}

  level.kitingconversations[var_0] = undefined;
}