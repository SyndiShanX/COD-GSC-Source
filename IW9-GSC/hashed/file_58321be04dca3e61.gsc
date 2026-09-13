/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_58321be04dca3e61.gsc
***********************************************/

_id_E04BD99E1BB6430B() {
  chopperexif_fx_init();
}

chopperexfil_pack(_id_CBFC3BA10CEFC8CE) {
  if(!isDefined(_id_CBFC3BA10CEFC8CE))
    _id_CBFC3BA10CEFC8CE = (0, 0, 0);

  thread chopperexfil_introsound(5, _id_CBFC3BA10CEFC8CE);

  if(!getdvarint("dvar_19A406E3C51CE52F")) {
    self.transientname = get_chopperexfil_transient();
    loadinfiltransient(self.transientname);
    setomnvarforallclients("ui_br_end_game_splash_type", 18);

    for(_id_24B79087F3897E94 = 0; !_id_24B79087F3897E94; _id_24B79087F3897E94 = _func_2030CC4AD67D1634(self.transientname))
      waitframe();
  }

  chopper = _id_40F4C8F2B94C5CD9::spawn_script_model("veh8_mil_air_blima_scriptmodel");
  chopper hidepart("tag_main_rotor_blade_01");
  chopper hidepart("tag_main_rotor_blade_02");
  chopper hidepart("tag_main_rotor_blade_03");
  chopper hidepart("tag_main_rotor_blade_04");
  chopper hidepart("tag_tail_rotor_blade_01");
  chopper hidepart("tag_tail_rotor_blade_02");
  chopper hidepart("tag_tail_rotor_blade_03");
  chopper hidepart("tag_tail_rotor_blade_04");
  self.exfilchopper = chopper;
  _id_40F4C8F2B94C5CD9::chopperexfil_set_brcircle();
  head = ["head_mp_helicopter_crew", "j_spine4"];
  _id_31093158B2292193 = [head];
  body = "body_pilot_helicopter_british";
  ropeguy = _id_40F4C8F2B94C5CD9::spawn_script_model(body, undefined, _id_31093158B2292193);
  self.ropeguy = ropeguy;
  self.winners = scripts\engine\utility::array_removeundefined(self.winners);

  if(self.winners.size == 0)
    _id_40F4C8F2B94C5CD9::create_disconnectplayer(self);

  rope = _id_40F4C8F2B94C5CD9::spawn_script_model("equipment_fast_rope_wm_01_infil_heli_l");
  self.rope = rope;
  self.cam = _id_40F4C8F2B94C5CD9::create_cam();
  ascenders = [];
  ascenders[0] = _id_40F4C8F2B94C5CD9::spawn_script_model("misc_wm_ascender", "misc_wm_ascender0");

  if(self.winners.size > 1)
    ascenders[1] = _id_40F4C8F2B94C5CD9::spawn_script_model("misc_wm_ascender", "misc_wm_ascender1");

  if(self.winners.size > 2)
    ascenders[2] = _id_40F4C8F2B94C5CD9::spawn_script_model("misc_wm_ascender", "misc_wm_ascender2");

  if(self.winners.size > 3)
    ascenders[3] = _id_40F4C8F2B94C5CD9::spawn_script_model("misc_wm_ascender", "misc_wm_ascender3");

  self.ascenders = ascenders;
  self.packs = [];
  n = 0;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("scene1");
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_startfunc([], ::chopperexfil_sh010_start);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(chopper, level._id_1A209BD995A7FA83["br_exfil_blima_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(ropeguy, level._id_1A209BD995A7FA83["br_exfil_co_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(rope, level._id_1A209BD995A7FA83["br_exfil_rope_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["br_exfil_cam_sh010"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_fx("chopperExfil_gas", self.origin, self.angles);
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("scene2");
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_startfunc(self.winners, ::chopperexfil_sh020_start);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(chopper, level._id_1A209BD995A7FA83["br_exfil_blima_sh020"]);

  if(!isDefined(level.scr_notetrack["veh8_mil_air_blima_scriptmodel"]) || !isDefined(level.scr_notetrack["veh8_mil_air_blima_scriptmodel"]["any"]["guy0_aboard"])) {
    scripts\common\anim::addnotetrack_customfunction("veh8_mil_air_blima_scriptmodel", "guy0_aboard", ::chopperexfil_skip_ascend0);
    scripts\common\anim::addnotetrack_customfunction("veh8_mil_air_blima_scriptmodel", "guy1_aboard", ::chopperexfil_skip_ascend1);
    scripts\common\anim::addnotetrack_customfunction("veh8_mil_air_blima_scriptmodel", "guy2_aboard", ::chopperexfil_skip_ascend2);
    scripts\common\anim::addnotetrack_customfunction("veh8_mil_air_blima_scriptmodel", "slamtoblack", ::chopperexfil_slamtoblack);
  }

  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(ropeguy, level._id_1A209BD995A7FA83["br_exfil_pilot_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(rope, level._id_1A209BD995A7FA83["br_exfil_rope_sh020"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(ascenders[0], level._id_1A209BD995A7FA83["br_exfil_ascender0_sh020"]);

  if(self.winners.size > 1)
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(ascenders[1], level._id_1A209BD995A7FA83["br_exfil_ascender1_sh020"]);

  if(self.winners.size > 2)
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(ascenders[2], level._id_1A209BD995A7FA83["br_exfil_ascender2_sh020"]);

  if(self.winners.size > 3)
    self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(ascenders[3], level._id_1A209BD995A7FA83["br_exfil_ascender3_sh020"]);

  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[0], level._id_1A209BD995A7FA83["br_exfil_guy0_sh020"], level._id_1A209BD995A7FA83["br_exfil_guy0_sh020_fem"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[1], level._id_1A209BD995A7FA83["br_exfil_guy1_sh020"], level._id_1A209BD995A7FA83["br_exfil_guy1_sh020_fem"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[2], level._id_1A209BD995A7FA83["br_exfil_guy2_sh020"], level._id_1A209BD995A7FA83["br_exfil_guy2_sh020_fem"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[3], level._id_1A209BD995A7FA83["br_exfil_guy3_sh020"], level._id_1A209BD995A7FA83["br_exfil_guy3_sh020_fem"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["br_exfil_cam_sh020"]);
  n++;
  self.packs[n] = _id_40F4C8F2B94C5CD9::create_animpack("scene2.5");
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_startfunc(self.winners, ::chopperexfil_sh025_start);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(chopper, level._id_1A209BD995A7FA83["br_exfil_blima_sh025"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_modelanim(ropeguy, level._id_1A209BD995A7FA83["br_exfil_pilot_sh025"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[0], level._id_1A209BD995A7FA83["br_exfil_guy0_sh025"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[1], level._id_1A209BD995A7FA83["br_exfil_guy1_sh025"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[2], level._id_1A209BD995A7FA83["br_exfil_guy2_sh025"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_playeranim(self.winners[3], level._id_1A209BD995A7FA83["br_exfil_guy3_sh025"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::add_pack_camanim(level._id_1A209BD995A7FA83["br_exfil_cam_sh025"]);
  self.packs[n] _id_40F4C8F2B94C5CD9::_id_DECF1E23D78D0944(self.winners, ::chopperexfil_slamtoblack);
}

_id_A5538B1593309BB0() {
  _id_79A78F73D2D4925D = [];
  _id_078258CA0B59079A = 30.0;
  _id_E4C66FC441E3F497 = 68.0;
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["br_exfil_guy0_sh020"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["br_exfil_guy1_sh020"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["br_exfil_guy2_sh020"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_3F005B301EC7F15B(_id_79A78F73D2D4925D, level._id_1A209BD995A7FA83["br_exfil_guy3_sh020"], 0.0, undefined, _id_078258CA0B59079A, _id_E4C66FC441E3F497);
  _id_A5C6D4F05FA73949 = "veh8_mil_air_blima_scriptmodel";
  _id_FB88F2D5ECEBB3E1 = (0, 0, -70);
  _id_EA07460C784BE362 = 350.0;
  _id_ABA9DA4BE1CE5CE2 = 10;
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_F317A6F0AE25E3D4(_id_79A78F73D2D4925D, _id_A5C6D4F05FA73949, level._id_1A209BD995A7FA83["br_exfil_blima_sh020"], 0.0, _id_FB88F2D5ECEBB3E1, _id_EA07460C784BE362);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_F317A6F0AE25E3D4(_id_79A78F73D2D4925D, _id_A5C6D4F05FA73949, level._id_1A209BD995A7FA83["br_exfil_blima_sh025"], 0.0, _id_FB88F2D5ECEBB3E1, _id_EA07460C784BE362);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_F317A6F0AE25E3D4(_id_79A78F73D2D4925D, _id_A5C6D4F05FA73949, level._id_1A209BD995A7FA83["br_exfil_blima_sh030"], 0.0, _id_FB88F2D5ECEBB3E1, _id_EA07460C784BE362);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_F317A6F0AE25E3D4(_id_79A78F73D2D4925D, _id_A5C6D4F05FA73949, level._id_1A209BD995A7FA83["br_exfil_blima_sh040"], 0.0, _id_FB88F2D5ECEBB3E1, _id_EA07460C784BE362);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_F317A6F0AE25E3D4(_id_79A78F73D2D4925D, _id_A5C6D4F05FA73949, level._id_1A209BD995A7FA83["br_exfil_blima_sh050"], 0.0, _id_FB88F2D5ECEBB3E1, _id_EA07460C784BE362);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_F317A6F0AE25E3D4(_id_79A78F73D2D4925D, _id_A5C6D4F05FA73949, level._id_1A209BD995A7FA83["br_exfil_blima_sh060"], 0.0, _id_FB88F2D5ECEBB3E1, _id_EA07460C784BE362);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_F317A6F0AE25E3D4(_id_79A78F73D2D4925D, _id_A5C6D4F05FA73949, level._id_1A209BD995A7FA83["br_exfil_blima_sh070"], 0.0, _id_FB88F2D5ECEBB3E1, _id_EA07460C784BE362);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_F317A6F0AE25E3D4(_id_79A78F73D2D4925D, _id_A5C6D4F05FA73949, level._id_1A209BD995A7FA83["br_exfil_blima_sh070"], 0.99, _id_FB88F2D5ECEBB3E1, _id_EA07460C784BE362);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_19AE50E23FE0625A(_id_79A78F73D2D4925D, _id_A5C6D4F05FA73949, level._id_1A209BD995A7FA83["br_exfil_blima_sh010"], _id_FB88F2D5ECEBB3E1, _id_EA07460C784BE362, _id_ABA9DA4BE1CE5CE2);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_19AE50E23FE0625A(_id_79A78F73D2D4925D, _id_A5C6D4F05FA73949, level._id_1A209BD995A7FA83["br_exfil_blima_sh020"], _id_FB88F2D5ECEBB3E1, _id_EA07460C784BE362, _id_ABA9DA4BE1CE5CE2);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_19AE50E23FE0625A(_id_79A78F73D2D4925D, _id_A5C6D4F05FA73949, level._id_1A209BD995A7FA83["br_exfil_blima_sh025"], _id_FB88F2D5ECEBB3E1, _id_EA07460C784BE362, _id_ABA9DA4BE1CE5CE2);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_19AE50E23FE0625A(_id_79A78F73D2D4925D, _id_A5C6D4F05FA73949, level._id_1A209BD995A7FA83["br_exfil_blima_sh030"], _id_FB88F2D5ECEBB3E1, _id_EA07460C784BE362, _id_ABA9DA4BE1CE5CE2);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_19AE50E23FE0625A(_id_79A78F73D2D4925D, _id_A5C6D4F05FA73949, level._id_1A209BD995A7FA83["br_exfil_blima_sh040"], _id_FB88F2D5ECEBB3E1, _id_EA07460C784BE362, _id_ABA9DA4BE1CE5CE2);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_19AE50E23FE0625A(_id_79A78F73D2D4925D, _id_A5C6D4F05FA73949, level._id_1A209BD995A7FA83["br_exfil_blima_sh050"], _id_FB88F2D5ECEBB3E1, _id_EA07460C784BE362, _id_ABA9DA4BE1CE5CE2);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_19AE50E23FE0625A(_id_79A78F73D2D4925D, _id_A5C6D4F05FA73949, level._id_1A209BD995A7FA83["br_exfil_blima_sh060"], _id_FB88F2D5ECEBB3E1, _id_EA07460C784BE362, _id_ABA9DA4BE1CE5CE2);
  _id_79A78F73D2D4925D = _id_40F4C8F2B94C5CD9::_id_19AE50E23FE0625A(_id_79A78F73D2D4925D, _id_A5C6D4F05FA73949, level._id_1A209BD995A7FA83["br_exfil_blima_sh070"], _id_FB88F2D5ECEBB3E1, _id_EA07460C784BE362, _id_ABA9DA4BE1CE5CE2);
  return _id_79A78F73D2D4925D;
}

chopperexif_fx_init() {
  level._effect["chopperExfil_rotorwash"] = loadfx("vfx/iw8_br/gameplay/vfx_br_blima_rotor_infil.vfx");
  level._effect["chopperExfil_gas"] = loadfx("vfx/iw8_br/gameplay/circle/vfx_br_circle_gas_exfil_01.vfx");
  level._effect["player_disconnect"] = loadfx("vfx/iw8_br/gameplay/vfx_br_disconnect_player.vfx");
}

chopperexfil_introsound(time, _id_CBFC3BA10CEFC8CE) {
  setmusicstate("br_exfil_main_4player");
  _func_ADFD4002C83FE6B2("igc", 0.3, 0);
  endorigin = self.origin + (0, 0, 1000);
  forward = vectorNormalize(endorigin - _id_CBFC3BA10CEFC8CE);
  startorigin = endorigin + forward * 3000;
  temp = spawn("script_model", startorigin);
  temp playSound("br_exfil_incoming_heli_lr");
  temp moveTo(endorigin, time);
  wait(time);
  temp delete();
}

get_chopperexfil_transient() {
  switch (level.script) {
    case "mp_donetsk":
      return "mp_infil_br_donetsk_ending_chopper_tr";
    case "mp_donetsk2":
      return "mp_infil_br_donetsk2_ending_chopper_tr";
    case "mp_don3":
    case "mp_don3_mobile":
      return "mp_infil_br_don3_ending_chopper_tr";
    case "mp_mgl_ftue_downtown":
      return "mp_infil_br_ftue_downtown_ending_chopper_tr";
    case "mp_br_quarry":
      return "mp_infil_br_quarry_ending_chopper_tr";
    case "mp_747_dev":
    case "mp_br_mechanics":
      return "mp_infil_br_mechanics_ending_chopper_tr";
    case "mp_kstenod":
      return "mp_infil_br_kstenod_ending_chopper_tr";
    case "mp_escape2":
      return "mp_infil_br_escape2_ending_chopper_tr";
    case "mp_escape3":
      return "mp_infil_br_escape2_ending_chopper_tr";
    case "mp_saba":
    case "mp_saba_pm":
    case "mp_saba2":
      return "mp_infil_br_saba_ending_chopper_tr";
    case "mp_delta":
      return "mp_infil_br_saba_ending_chopper_tr";
  }

  return "";
}

chopperexfil_sh010_start(array) {
  level.br_ending.exfilchopper thread chopper_playFX();
  thread chopperexfil_music_start();

  if(!_id_2CEDCC356F1B9FC8::isanytutorialorbotpracticematch())
    setomnvarforallclients("ui_br_end_game_splash_type", 17);

  if(isDefined(level.br_ending_debugmode)) {
    level.br_ending.ropeguy show();

    foreach(player in level.players)
    player.player_rig unlink();
  }

  _id_40F4C8F2B94C5CD9::allplayers_setphysicaldof(2.8, 200);
}

chopperexfil_sh020_start(players) {
  _id_40F4C8F2B94C5CD9::allplayers_setphysicaldof(2.8, 250);
  level.br_ending.exfilchopper thread chopper_playFX();

  if(isDefined(level.br_ending_debugmode)) {
    foreach(ascender in level.br_ending.ascenders)
    ascender show();
  }

  foreach(player in players) {
    if(isDefined(player))
      player scripts\mp\utility\player::setwind("60", 1);
  }
}

chopperexfil_sh025_start(players) {
  _id_40F4C8F2B94C5CD9::allplayers_setphysicaldof(2.8, 250);

  if(!isDefined(level.br_ending_debugmode)) {
    if(level.br_ending.winners.size < 4) {
      if(isDefined(level.br_ending.rope))
        level.br_ending.rope delete();
    }
  }

  level.br_ending.exfilchopper thread chopper_playFX();

  if(isDefined(level.br_ending_debugmode)) {
    foreach(ascender in level.br_ending.ascenders)
    ascender hide();
  } else {
    foreach(ascender in level.br_ending.ascenders)
    ascender delete();
  }

  tags = ["tag_guy0", "tag_guy2", "tag_guy4", "tag_guy5"];

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    if(!isDefined(player.winindex)) {
      continue;
    }
    player.player_rig linkTo(level.br_ending.exfilchopper, tags[player.winindex], (0, 0, 0), (0, 0, 0));
    player.linkedtoent = level.br_ending.exfilchopper;
    player.linkedtotag = tags[player.winindex];
  }

  foreach(rig in level.br_ending.player_rigs) {
    if(isDefined(rig.player)) {
      continue;
    }
    if(!isDefined(rig.winindex)) {
      continue;
    }
    rig linkTo(level.br_ending.exfilchopper, tags[rig.winindex], (0, 0, 0), (0, 0, 0));
    rig.linkedtoent = level.br_ending.exfilchopper;
    rig.linkedtotag = tags[rig.winindex];
  }

  chopperexfil_sitting_wind(players);
}

chopperexfil_music_start() {
  if(level.br_ending.winners.size == 0) {
    return;
  }
  _id_4DE75E7F916838A0 = "br_exfil_part1_1person_lr";

  foreach(player in level.players)
  player playlocalsound(_id_4DE75E7F916838A0);

  waitframe();

  foreach(player in level.players)
  player setsoundsubmix("mp_br_exfil_fade", 4);
}

chopperexfil_sitting_wind(players) {
  foreach(player in players) {
    if(isDefined(player))
      player scripts\mp\utility\player::setwind("30", 1);
  }
}

chopperexfil_skip_ascend0(ent) {
  if(level.br_ending.winners.size == 1)
    stop_all_ascend_anims();
}

chopperexfil_skip_ascend1(ent) {
  if(level.br_ending.winners.size == 2)
    stop_all_ascend_anims();
}

chopperexfil_skip_ascend2(ent) {
  if(level.br_ending.winners.size == 3)
    stop_all_ascend_anims();
}

chopperexfil_slamtoblack(ent) {
  if(!isDefined(level.br_ending_debugmode))
    setomnvarforallclients("ui_world_fade", 1);
}

chopper_playFX() {
  self endon("death");
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("chopperExfil_rotorwash"), self, "tag_origin");
}

stop_all_ascend_anims() {
  level.br_ending.cam notify("single anim", "end");
}