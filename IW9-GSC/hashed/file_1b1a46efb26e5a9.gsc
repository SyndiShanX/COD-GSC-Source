/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1b1a46efb26e5a9.gsc
***********************************************/

_id_1D8B88C55E1DA251() {
  level endon("game_ended");
  level endon("elevator_reach_bottom");
  level thread _id_75FF2DCB76553E90();
  level thread _id_5FBA63D762F32E45();
  level thread _id_DF291D99E73C616A();
  level thread _id_9FD0DF71BE357E1E();
  level thread _id_129C75E39137052E();
}

_id_49AD3A42842B4118() {
  level endon("game_ended");
  level thread _id_FBF194F47FFB0F98();
  level thread _id_7C2B27CA5F447E40();
}

_id_45BF1B26E346026D() {
  level endon("game_ended");
  level thread _id_0CFC9E5701526A8E();
  level thread _id_38E2B05BD7FAC643();
  level thread _id_4158C33B217100AA();
}

_id_291B7337A2A203C3() {
  level endon("game_ended");
  level thread _id_09F6DF35A461963F();
  level thread _id_2804600241ED7FE0();
}

_id_E00BA90C8FAF1451() {
  level endon("game_ended");
  level thread _id_0951D490E3D01CDD();
  level thread _id_EF27C75B03C327D9();
}

_id_75FF2DCB76553E90() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("vo_spotElevator");
  setmusicstate("mx_cp_raid1_boss1_tensionstingers");
}

_id_5FBA63D762F32E45() {
  level endon("game_ended");
  level waittill("elevator_button_pressed");
  setmusicstate("mx_cp_raid1_boss1_descend1");
}

_id_DF291D99E73C616A() {
  level endon("game_ended");
  level waittill("silo_power_switch_1_pulled");
  setmusicstate("mx_cp_raid1_boss1_descend2");
}

_id_129C75E39137052E() {
  level endon("game_ended");

  for(;;) {
    level waittill("saw_door_started", flagname);

    if(flagname == "silo_door_cut") {
      setmusicstate("mx_cp_raid1_boss1_saw");
      return;
    }
  }
}

_id_9FD0DF71BE357E1E() {
  level endon("game_ended");
  level waittill("silo_power_switch_2_pulled");
  setmusicstate("mx_cp_raid1_boss1_descend3");
}

_id_FBF194F47FFB0F98() {
  level endon("game_ended");
  trigger = getEnt("tripwire_sighted_music", "script_noteworthy");

  for(;;) {
    trigger waittill("trigger", player);

    if(!isPlayer(player) || !isalive(player)) {
      waitframe();
      continue;
    }

    setmusicstate("mx_cp_raid1_boss1_tensionstingers");
    return;
  }
}

_id_7C2B27CA5F447E40() {
  level endon("game_ended");
  trigger = getEnt("fil_hole_music", "script_noteworthy");

  for(;;) {
    trigger waittill("trigger", player);

    if(!isPlayer(player) || !isalive(player)) {
      waitframe();
      continue;
    }

    setmusicstate("mx_cp_raid1_boss1_tensionstingers");
    return;
  }
}

_id_4158C33B217100AA() {
  level endon("game_ended");
  level waittill("stealth_broken");
  setmusicstate("mx_cp_raid1_boss1_combatstingers");
}

_id_0CFC9E5701526A8E() {
  level endon("game_ended");
  level waittill("fil_power_on");
  setmusicstate("mx_cp_raid1_boss1_interactstingers");
}

_id_38E2B05BD7FAC643() {
  level endon("game_ended");
  level endon("fil_exit_granted");

  for(;;) {
    level waittill("securitykeygenerated");
    setmusicstate("mx_cp_raid1_boss1_interactstingers");
    level thread _id_B52CB1B1CD6E59A3();
  }
}

_id_B52CB1B1CD6E59A3() {
  level endon("game_ended");
  level endon("securitykeygenerated");
  level waittill("fil_exit_granted");
  setmusicstate("mx_cp_raid1_boss1_puzzlecomplete");
}

_id_2804600241ED7FE0() {
  level endon("game_ended");
  level waittill("kitchen_trigger");
  setmusicstate("mx_cp_raid1_boss1_combatstingers");
}

_id_09F6DF35A461963F() {
  level endon("game_ended");
  trigger = getEnt("boss_drop_music", "script_noteworthy");

  for(;;) {
    trigger waittill("trigger", player);

    if(!isPlayer(player) || !isalive(player)) {
      waitframe();
      continue;
    }

    setmusicstate("mx_cp_raid1_boss1_tensionstingers");
    return;
  }
}

_id_0951D490E3D01CDD() {
  level endon("game_ended");
  level notify("single_watch_for_catwalk_blown_up");
  level endon("single_watch_for_catwalk_blown_up");

  if(!scripts\engine\utility::flag_exist("p2_finished"))
    scripts\engine\utility::flag_init("p2_finished");

  scripts\engine\utility::flag_wait("p2_finished");
  setmusicstate("mx_cp_raid1_boss1_combatstingers");
}

_id_EF27C75B03C327D9() {
  level endon("game_ended");
  level notify("single_watch_for_saw_loop_music");
  level endon("single_watch_for_saw_loop_music");

  for(;;) {
    level waittill("saw_door_started", flagname);

    if(flagname == "sub_door_4_cut") {
      break;
    } else
      waitframe();
  }

  setmusicstate("mx_cp_raid1_boss1_finalsawloop");
  scripts\engine\utility::flag_wait("sub_door_4_cut");
  _func_A3901A965FC1D7DD("mx_cp_raid1_boss1_finalsawloop");
}