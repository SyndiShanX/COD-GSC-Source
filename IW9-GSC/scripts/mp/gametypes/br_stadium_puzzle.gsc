/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_stadium_puzzle.gsc
******************************************************/

init() {
  level.stadiumpuzzleactive = getdvarint("scr_stadium_puzzle", 1);
  level.stadium_puzzle = spawnStruct();

  if(level.stadiumpuzzleactive) {
    level.stadium_puzzle.hints = [];
    level.stadium_puzzle.code = [];
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_stadium_code_computer", ::codecomputerscriptableused);
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_stadium_access_reader", ::accessreaderscriptableused);
  }

  level thread _id_7E52B56769FA7774::registeruniquelootcallback(2, ::awardstadiumblueprint);
  level thread initpostmain();
}

initpostmain() {
  waittillframeend;
  level thread gatherstadiumlocs();

  if(!level.stadiumpuzzleactive) {
    return;
  }
  if(level.mapname == "mp_bm_bunker01") {
    debug_bunkertestaccesscardlocs();
    debug_spawnrewardstest();
  } else
    registeraccesscardlocs();

  spawnaccesscards();
  scripts\mp\flags::gameflagwait("prematch_done");
  _id_885780D268327BA4 = getdvarint("dvar_2B534A885F537DFA", 8);
  setupboardroomcode(_id_885780D268327BA4, level.stadium_puzzle);
  serverroomrewardroll();
}

setupboardroomcode(_id_885780D268327BA4, _id_48B11326257052F1) {
  _id_7D625073C6379D53::generatenumbercode(_id_885780D268327BA4, _id_48B11326257052F1, 1, 1);
  _id_48B11326257052F1.displaycodes = _id_7D625073C6379D53::generatecodestoshow(_id_48B11326257052F1.code, 3, 1, 1);
  _id_7D625073C6379D53::assigncodecomputersdisplaycodes(_id_48B11326257052F1.hints["maphint_stadium_code_computer"], _id_48B11326257052F1.displaycodes);

  foreach(_id_6EB04909CB5CA84D in level.stadium_puzzle.hints["stadium_boardroom_keypad"]) {
    _id_6EB04909CB5CA84D.scriptable.code = _id_48B11326257052F1.code;
    _id_6EB04909CB5CA84D.scriptable.successfunction = ::boardroomdoorcodeentrysuccess;
  }

  if(0)
    return;
}

codecomputerscriptableused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  level thread _codecomputerscriptableused(instance, part, state, player, _id_A5B2C541413AA895);
}

_codecomputerscriptableused(instance, part, state, player, _id_A5B2C541413AA895) {
  if(state == "on") {
    if(!scripts\mp\flags::gameflag("prematch_done")) {
      playsoundatpos(instance.origin, "br_computer_deny");
      instance setscriptablepartstate("maphint_stadium_code_computer", "off");
      wait 3;
      instance setscriptablepartstate("maphint_stadium_code_computer", "on");
    } else {
      player scripts\mp\playerlogic::_id_E636E108DFFE6AB7();
      _id_259704388E91FE40 = _id_7D625073C6379D53::getcodecomputerdisplaycode(level.stadium_puzzle, instance.displaycodeindex);
      instance setscriptablepartstate("maphint_stadium_code_computer", "off");

      while(istrue(instance.computermakingnose))
        waitframe();

      instance notify("computer_used");
      playsoundatpos(instance.origin, "stadium_computer_code_start");
      instance.computerscriptable setscriptablepartstate("stadium_code_computer", "blank");
      wait 2;

      foreach(_id_5D8B57CC867A9F80 in _id_259704388E91FE40) {
        if(isint(_id_5D8B57CC867A9F80))
          _id_5D8B57CC867A9F80 = "num" + _id_5D8B57CC867A9F80;

        instance.computerscriptable setscriptablepartstate("stadium_code_computer", _id_5D8B57CC867A9F80);
        playsoundatpos(instance.origin, "stadium_computer_code_number");
        wait 0.6;
        instance.computerscriptable setscriptablepartstate("stadium_code_computer", "blank");
        wait 0.1;
      }

      instance.computerscriptable setscriptablepartstate("stadium_code_computer", "reset");
      playsoundatpos(instance.origin, "stadium_computer_code_end");
      wait 3;
      instance.computerscriptable setscriptablepartstate("stadium_code_computer", "intro");
      instance setscriptablepartstate("maphint_stadium_code_computer", "on");
    }
  }
}

accessreaderscriptableused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  level thread _accessreaderscriptableused(instance, part, state, player, _id_A5B2C541413AA895);
}

_accessreaderscriptableused(instance, part, state, player, _id_A5B2C541413AA895) {
  instance setscriptablepartstate("maphint_stadium_access_reader", "off");

  if(getdvarint("dvar_C18B5C0B64EB7D60", 0) == 1 || player _id_2CEDCC356F1B9FC8::hasaccesscard(instance.requiredcardtype)) {
    playsoundatpos(instance.origin, "br_keypad_confirm");
    _id_7D625073C6379D53::openscriptabledoors(instance);
    instance setscriptablepartstate("maphint_stadium_access_reader", "off");
    player _id_7E52B56769FA7774::removeaccesscard();
    instance.addedcollision delete();
  } else {
    if(soundexists("br_keypad_deny"))
      playsoundatpos(player.origin, "br_keypad_deny");

    instance setscriptablepartstate("maphint_stadium_access_reader", "off");
    wait 3;
    instance setscriptablepartstate("maphint_stadium_access_reader", "on");
  }
}

boardroomdoorcodeentrysuccess(instance) {
  playsoundatpos(instance.origin, "br_phone_code_correct");
  _id_7D625073C6379D53::unlockscriptabledoors(instance);

  if(!istrue(level.stadium_puzzle.boardroomopen))
    spawnuniqueboardroomloot();

  level.stadium_puzzle.boardroomopen = 1;

  foreach(_id_F4C1A97F167EEC9B in level.stadium_puzzle._id_E696F89E8FDC4B64) {
    if(isDefined(_id_F4C1A97F167EEC9B))
      _id_F4C1A97F167EEC9B delete();
  }

  scripts\engine\utility::exploder("stad_fireworks");
}

spawnuniqueboardroomloot() {
  spawnboardroomblueprintweapons();
  _id_C1A111FCE3901443 = 1;

  if(getDvar("dvar_7611A2790A0BF7FE", "") == "plunder")
    _id_C1A111FCE3901443 = 0;

  _id_0EB80FBB0BF8736D = getdvarint("dvar_9139ECE0E4029EFD", 1);
  _id_41D59B96CF4ECC51 = getdvarint("dvar_93865CC30C681EA1", 1);
  _id_CC2B025D5D9D414D = getdvarint("dvar_26DB1A3371C6B1BD", 1);
  _id_94C29EF7C8696D31 = getdvarint("dvar_7FD1C77D842E36E1", _id_C1A111FCE3901443);
  _id_4B38D0DFDAE99BFB = getdvarint("dvar_5753EF97F2730D0B", 1);
  _id_1B32ECD6577D3426 = getdvarint("dvar_CAA47D318EDE8A16", 1);
  total = 1 + _id_0EB80FBB0BF8736D + _id_41D59B96CF4ECC51 + _id_CC2B025D5D9D414D + _id_94C29EF7C8696D31 + _id_4B38D0DFDAE99BFB + _id_1B32ECD6577D3426;
  _id_8B591B0BC361AB3D = randomintrange(1, total);

  if(_id_8B591B0BC361AB3D <= _id_0EB80FBB0BF8736D)
    spawnboardroom_auav();
  else if(_id_8B591B0BC361AB3D <= _id_0EB80FBB0BF8736D + _id_41D59B96CF4ECC51)
    spawnboardroom_specialist();
  else if(_id_8B591B0BC361AB3D <= _id_0EB80FBB0BF8736D + _id_41D59B96CF4ECC51 + _id_CC2B025D5D9D414D)
    spawnboardroom_loadoutdrop();
  else if(_id_8B591B0BC361AB3D <= _id_0EB80FBB0BF8736D + _id_41D59B96CF4ECC51 + _id_CC2B025D5D9D414D + _id_94C29EF7C8696D31)
    spawnboardroom_gasmask();
  else if(_id_8B591B0BC361AB3D <= _id_0EB80FBB0BF8736D + _id_41D59B96CF4ECC51 + _id_CC2B025D5D9D414D + _id_94C29EF7C8696D31 + _id_4B38D0DFDAE99BFB)
    spawnboardroom_miniguns();
  else
    spawnboardroom_juggdrop();
}

spawnboardroomblueprintweapons() {
  _id_7957AE38C168F3DF = "brloot_weapon_bp_reward_sm_mpapa7_lege";
  count = _id_7D625073C6379D53::getitemcount(_id_7957AE38C168F3DF);
  _id_12B397CBEAAB23B6 = (31270, -265, 21.5);
  _id_924AF5F42304DAE4 = (0, 266, 80);
  origin2 = (31385, -373, 21.5);
  _id_924AF8F42304E17D = (0, 23, 80);

  if(level.mapname == "mp_bm_bunker01") {
    _id_12B397CBEAAB23B6 = (1247, -4060, 300);
    _id_924AF5F42304DAE4 = (0, 177, 75);
    origin2 = (1260, -3826, 300);
    _id_924AF8F42304E17D = (0, 1776, 75);
  }

  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(_id_12B397CBEAAB23B6, _id_924AF5F42304DAE4);
  scriptable = _id_7E52B56769FA7774::spawnpickup(_id_7957AE38C168F3DF, _id_CB4FAD49263E20C4, count, 0);

  if(isDefined(scriptable))
    scriptable.uniquelootitemid = "uniqueLootItem_2";

  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(origin2, _id_924AF8F42304E17D);
  scriptable = _id_7E52B56769FA7774::spawnpickup(_id_7957AE38C168F3DF, _id_CB4FAD49263E20C4, count, 0);

  if(isDefined(scriptable))
    scriptable.uniquelootitemid = "uniqueLootItem_2";
}

spawnboardroom_auav() {
  _id_12B397CBEAAB23B6 = (31484, -464, 12);
  _id_924AF5F42304DAE4 = (0, 135, 0);

  if(level.mapname == "mp_bm_bunker01")
    _id_12B397CBEAAB23B6 = _id_12B397CBEAAB23B6 + (-30113, -3566, 300);

  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(_id_12B397CBEAAB23B6, _id_924AF5F42304DAE4);
  scriptable = _id_7E52B56769FA7774::spawnpickup("brloot_killstreak_auav", _id_CB4FAD49263E20C4, 1, 0);
}

spawnboardroom_specialist() {
  _id_12B397CBEAAB23B6 = (31484, -464, 7);
  _id_924AF5F42304DAE4 = (0, randomint(359), 0);

  if(level.mapname == "mp_bm_bunker01")
    _id_12B397CBEAAB23B6 = _id_12B397CBEAAB23B6 + (-30113, -3566, 300);

  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(_id_12B397CBEAAB23B6, _id_924AF5F42304DAE4);
  scriptable = _id_7E52B56769FA7774::spawnpickup("brloot_specialist_bonus", _id_CB4FAD49263E20C4, 1, 0);
  _id_12B397CBEAAB23B6 = (31332, -82, 7);
  _id_924AF5F42304DAE4 = (0, randomint(359), 0);

  if(level.mapname == "mp_bm_bunker01")
    _id_12B397CBEAAB23B6 = _id_12B397CBEAAB23B6 + (-30113, -3566, 300);

  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(_id_12B397CBEAAB23B6, _id_924AF5F42304DAE4);
  scriptable = _id_7E52B56769FA7774::spawnpickup("brloot_specialist_bonus", _id_CB4FAD49263E20C4, 1, 0);
  _id_12B397CBEAAB23B6 = (31086, -370, 7);
  _id_924AF5F42304DAE4 = (0, randomint(359), 0);

  if(level.mapname == "mp_bm_bunker01")
    _id_12B397CBEAAB23B6 = _id_12B397CBEAAB23B6 + (-30113, -3566, 300);

  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(_id_12B397CBEAAB23B6, _id_924AF5F42304DAE4);
  scriptable = _id_7E52B56769FA7774::spawnpickup("brloot_specialist_bonus", _id_CB4FAD49263E20C4, 1, 0);
}

spawnboardroom_loadoutdrop() {
  _id_12B397CBEAAB23B6 = (31484, -464, 7);
  _id_924AF5F42304DAE4 = (0, 135, 0);

  if(level.mapname == "mp_bm_bunker01")
    _id_12B397CBEAAB23B6 = _id_12B397CBEAAB23B6 + (-30113, -3566, 300);

  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(_id_12B397CBEAAB23B6, _id_924AF5F42304DAE4);
  scriptable = _id_7E52B56769FA7774::spawnpickup("brloot_offhand_advancedsupplydrop", _id_CB4FAD49263E20C4, 1, 0);
}

spawnboardroom_gasmask() {
  _id_12B397CBEAAB23B6 = (31484, -464, 7);
  _id_924AF5F42304DAE4 = (0, randomint(359), 0);

  if(level.mapname == "mp_bm_bunker01")
    _id_12B397CBEAAB23B6 = _id_12B397CBEAAB23B6 + (-30113, -3566, 300);

  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(_id_12B397CBEAAB23B6, _id_924AF5F42304DAE4);
  scriptable = _id_7E52B56769FA7774::spawnpickup("brloot_equip_gasmask_durable", _id_CB4FAD49263E20C4, 1, 0);
  _id_12B397CBEAAB23B6 = (31332, -82, 7);
  _id_924AF5F42304DAE4 = (0, randomint(359), 0);

  if(level.mapname == "mp_bm_bunker01")
    _id_12B397CBEAAB23B6 = _id_12B397CBEAAB23B6 + (-30113, -3566, 300);

  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(_id_12B397CBEAAB23B6, _id_924AF5F42304DAE4);
  scriptable = _id_7E52B56769FA7774::spawnpickup("brloot_equip_gasmask_durable", _id_CB4FAD49263E20C4, 1, 0);
  _id_12B397CBEAAB23B6 = (31086, -370, 7);
  _id_924AF5F42304DAE4 = (0, randomint(359), 0);

  if(level.mapname == "mp_bm_bunker01")
    _id_12B397CBEAAB23B6 = _id_12B397CBEAAB23B6 + (-30113, -3566, 300);

  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(_id_12B397CBEAAB23B6, _id_924AF5F42304DAE4);
  scriptable = _id_7E52B56769FA7774::spawnpickup("brloot_equip_gasmask_durable", _id_CB4FAD49263E20C4, 1, 0);
}

spawnboardroom_miniguns() {
  _id_12B397CBEAAB23B6 = (31390, 0, 2);
  _id_924AF5F42304DAE4 = (-70, 145, 80);
  origin2 = (31022, -348, 2);
  _id_924AF8F42304E17D = (-70, 132, 80);

  if(level.mapname == "mp_bm_bunker01") {
    _id_12B397CBEAAB23B6 = (1247, -4060, 300);
    _id_924AF5F42304DAE4 = (0, 177, 75);
    origin2 = (1260, -3826, 300);
    _id_924AF8F42304E17D = (0, 1776, 75);
  }

  _id_7957AE38C168F3DF = "brloot_weapon_lm_dblmg_lege";
  count = _id_7D625073C6379D53::getitemcount(_id_7957AE38C168F3DF);
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(_id_12B397CBEAAB23B6, _id_924AF5F42304DAE4);
  scriptable = _id_7E52B56769FA7774::spawnpickup(_id_7957AE38C168F3DF, _id_CB4FAD49263E20C4, count, 0);
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(origin2, _id_924AF8F42304E17D);
  scriptable = _id_7E52B56769FA7774::spawnpickup(_id_7957AE38C168F3DF, _id_CB4FAD49263E20C4, count, 0);
}

spawnboardroom_juggdrop() {
  _id_12B397CBEAAB23B6 = (31484, -464, 7);
  _id_924AF5F42304DAE4 = (0, 135, 0);

  if(level.mapname == "mp_bm_bunker01")
    _id_12B397CBEAAB23B6 = _id_12B397CBEAAB23B6 + (-30113, -3566, 300);

  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(_id_12B397CBEAAB23B6, _id_924AF5F42304DAE4);
  scriptable = _id_7E52B56769FA7774::spawnpickup("brloot_killstreak_juggernaut", _id_CB4FAD49263E20C4, 1, 0);
}

awardstadiumblueprint(player) {
  foreach(_id_F0EA4030349A33D5 in scripts\mp\utility\teams::getteamdata(player.team, "players")) {
    if(!isDefined(_id_F0EA4030349A33D5)) {
      continue;
    }
    _id_F0EA4030349A33D5 scripts\cp_mp\challenges::onunlockitem("blueprint_unlock_629");
    _id_F0EA4030349A33D5 scripts\mp\analyticslog::logevent_challengeitemunlocked(_id_F0EA4030349A33D5, "blueprint_unlock_629", "blueprint", 629);
    optionalnumber = 0;

    if(optionalnumber > 0)
      _id_F0EA4030349A33D5 thread scripts\mp\hud_message::showsplash("br_unlockable_weapon_splash", optionalnumber);
  }

  return 1;
}

activatemusictrigger() {
  forward = anglesToForward(level.stadium_puzzle.interiordoor.angles);
  trigger = spawn("trigger_radius", level.stadium_puzzle.interiordoor.origin + forward * -128, 0, 128, 128);
  level thread musictriggerthink(trigger);
  wait 120;
  trigger notify("endMusicTrigger");
  trigger delete();
}

musictriggerthink(trigger) {
  trigger endon("endMusicTrigger");

  for(;;) {
    trigger waittill("trigger", player);
    waitframe();

    if(!isDefined(player)) {
      continue;
    }
    if(!isPlayer(player)) {
      continue;
    }
    if(!isalive(player)) {
      continue;
    }
    if(istrue(player.bunkermusicstarted)) {
      continue;
    }
    player.bunkermusicstarted = 1;
    player setplayermusicstate("br_bunker_reveal");
  }
}

gatherstadiumlocs() {
  loc = scripts\engine\utility::getStruct("stadium_parking_garage_access_reader", "targetname");
  loc.scriptable = spawnscriptable("maphint_stadium_access_reader", loc.origin);
  loc.scriptable.name = "stadium_parking_garage_access_reader";
  loc.scriptable.requiredcardtype = "brloot_access_card_blue_stadium_parking";
  loc.scriptable.doors = getentitylessscriptablearray(loc.target, "targetname");
  _id_7D625073C6379D53::lockscriptabledoors(loc.scriptable);
  door = loc.scriptable.doors[0];
  forward = anglesToForward(door.angles);
  right = anglestoright(door.angles);
  _id_C548D45F1D62279A = door.origin + forward * 27 + right * 64;
  _id_1E15CA204F179886 = getEnt("clip128x128x128", "targetname");
  _id_10688B3021ACC893 = spawn("script_model", _id_C548D45F1D62279A);
  _id_10688B3021ACC893.angles = door.angles;
  _id_10688B3021ACC893 clonebrushmodeltoscriptmodel(_id_1E15CA204F179886);
  loc.scriptable.addedcollision = _id_10688B3021ACC893;
  level.stadium_puzzle.hints["stadium_parking_garage_access_reader"] = loc;
  loc = scripts\engine\utility::getStruct("stadium_concourse_access_reader", "targetname");
  loc.scriptable = spawnscriptable("maphint_stadium_access_reader", loc.origin);
  loc.scriptable.name = "stadium_concourse_access_reader";
  loc.scriptable.requiredcardtype = "brloot_access_card_blue_stadium_concourse";
  loc.scriptable.doors = getentitylessscriptablearray(loc.target, "targetname");
  _id_7D625073C6379D53::lockscriptabledoors(loc.scriptable);
  door = loc.scriptable.doors[0];
  forward = anglesToForward(door.angles);
  right = anglestoright(door.angles);
  _id_C548D45F1D62279A = door.origin + forward * 27 + right * 64;
  _id_1E15CA204F179886 = getEnt("clip128x128x128", "targetname");
  _id_10688B3021ACC893 = spawn("script_model", _id_C548D45F1D62279A);
  _id_10688B3021ACC893.angles = door.angles;
  _id_10688B3021ACC893 clonebrushmodeltoscriptmodel(_id_1E15CA204F179886);
  loc.scriptable.addedcollision = _id_10688B3021ACC893;
  level.stadium_puzzle.hints["stadium_concourse_access_reader"] = loc;
  loc = scripts\engine\utility::getStruct("stadium_upper_level_access_card", "targetname");
  loc.origin = loc.origin - (2, 4, -2);
  loc.scriptable = spawnscriptable("maphint_stadium_access_reader", loc.origin);
  loc.scriptable.name = "stadium_upper_level_access_card";
  loc.scriptable.requiredcardtype = "brloot_access_card_blue_stadium_executive";
  loc.scriptable.doors = getentitylessscriptablearray(loc.target, "targetname");
  _id_7D625073C6379D53::lockscriptabledoors(loc.scriptable);
  door = loc.scriptable.doors[0];
  forward = anglesToForward(door.angles);
  right = anglestoright(door.angles);
  _id_C548D45F1D62279A = door.origin + forward * 27 + right * 64;
  _id_1E15CA204F179886 = getEnt("clip128x128x128", "targetname");
  _id_10688B3021ACC893 = spawn("script_model", _id_C548D45F1D62279A);
  _id_10688B3021ACC893.angles = door.angles;
  _id_10688B3021ACC893 clonebrushmodeltoscriptmodel(_id_1E15CA204F179886);
  loc.scriptable.addedcollision = _id_10688B3021ACC893;
  level.stadium_puzzle.hints["stadium_upper_level_access_card"] = loc;
  _id_9577902B42FBD7F6 = scripts\engine\utility::getStructArray("maphint_stadium_code_computer", "targetname");
  level.stadium_puzzle.hints["maphint_stadium_code_computer"] = [];

  foreach(_id_AC0E594AC96AA3A8, loc in _id_9577902B42FBD7F6) {
    computerscriptable = spawnscriptable("stadium_code_computer", loc.origin, loc.angles);

    if(0)
      level thread computer_debugtestloop(computerscriptable);

    targetarray = scripts\engine\utility::getStructArray(loc.target, "targetname");
    loc.scriptable = spawnscriptable("maphint_stadium_code_computer", targetarray[0].origin, targetarray[0].angles);
    loc.scriptable.computerscriptable = computerscriptable;
    level.stadium_puzzle.hints["maphint_stadium_code_computer"][_id_AC0E594AC96AA3A8] = loc;
  }

  _id_9577902B42FBD7F6 = scripts\engine\utility::getStructArray("stadium_boardroom_keypad", "targetname");
  level.stadium_puzzle._id_E696F89E8FDC4B64 = [];

  foreach(loc in _id_9577902B42FBD7F6) {
    _id_A5B06CFCDA6B2425 = undefined;

    if(distance2dsquared(loc.origin, (31075, -521, 42)) < 1024) {
      loc.origin = loc.origin - (5, 5, 0);
      _id_A5B06CFCDA6B2425 = (31226, -510, 0);
    } else
      _id_A5B06CFCDA6B2425 = (31499, -192, 0);

    loc.scriptable = spawnscriptable("maphint_stadium_keypad", loc.origin);
    loc.scriptable.doors = getentitylessscriptablearray(loc.target, "targetname");
    loc.scriptable.name = "stadium_boardroom_keypad";
    _id_7D625073C6379D53::lockscriptabledoors(loc.scriptable);
    door = loc.scriptable.doors[0];
    _id_1E15CA204F179886 = getEnt("clip128x128x128", "targetname");
    _id_10688B3021ACC893 = spawn("script_model", _id_A5B06CFCDA6B2425);
    _id_10688B3021ACC893.angles = door.angles;
    _id_10688B3021ACC893 clonebrushmodeltoscriptmodel(_id_1E15CA204F179886);
    level.stadium_puzzle._id_E696F89E8FDC4B64[level.stadium_puzzle._id_E696F89E8FDC4B64.size] = _id_10688B3021ACC893;
  }

  level.stadium_puzzle.hints["stadium_boardroom_keypad"] = _id_9577902B42FBD7F6;
}

registeraccesscardlocs() {
  level.stadium_puzzle.keycardlocs = [];
  level.stadium_puzzle.keycardlocs[0] = (32343, 1601, -614);
  level.stadium_puzzle.keycardlocs[1] = (27868, 115, -614);
  level.stadium_puzzle.keycardlocs[2] = (27788, 1064, -686);
  level.stadium_puzzle.keycardlocs[3] = (26328, 3252, -662);
  level.stadium_puzzle.keycardlocs[4] = (29046, 4572, -614);
  level.stadium_puzzle.keycardlocs[5] = (27803, 6043, -614);
  level.stadium_puzzle.keycardlocs[6] = (27089, 5807, -614);
  level.stadium_puzzle.keycardlocs[7] = (25513, 4366, -614);
  level.stadium_puzzle.keycardlocs[8] = (25010, 3209, -614);
  level.stadium_puzzle.keycardlocs[9] = (25521, 2418, -614);
  level.stadium_puzzle.keycardlocs[10] = (25459, 1454, -614);
  level.stadium_puzzle.keycardlocs[11] = (29470, 3561, -748);
  level.stadium_puzzle.keycardlocs[12] = (30640, 2603, -662);
  level.stadium_puzzle.keycardlocs[13] = (28113, 5767, -422);
  level.stadium_puzzle.keycardlocs[14] = (25253, 2907, -422);
  level.stadium_puzzle.keycardlocs[15] = (27085, 1023, -470);
  level.stadium_puzzle.keycardlocs[16] = (31592, 1282, -494);
  level.stadium_puzzle.keycardlocs[17] = (28554, 134, -806);
  level.stadium_puzzle.keycardlocs[18] = (28896, 272, -806);
  level.stadium_puzzle.keycardlocs[19] = (25164, 2910, -871);
  level.stadium_puzzle.keycardlocs[20] = (26221, 5046, -878);
  level.stadium_puzzle.keycardlocs[21] = (26709, 5693, -870);
  level.stadium_puzzle.keycardlocs[22] = (29938, 5509, -870);
  level.stadium_puzzle.keycardlocs[23] = (31855, 4102, -870);
  level.stadium_puzzle.keycardlocs[24] = (31491, -1129, -878);
  level.stadium_puzzle.keycardlocs[25] = (32145, -453, -878);
  level.stadium_puzzle.keycardlocs[26] = (26502, 2027, -870);
  level.stadium_puzzle.keycardlocs[27] = (25909, 4970, 42);
  level.stadium_puzzle.keycardlocs[28] = (26570, 5592, 26);
  level.stadium_puzzle.keycardlocs[29] = (28871, 6308, 35);
  level.stadium_puzzle.keycardlocs[30] = (30576, 4789, 41);
  level.stadium_puzzle.keycardlocs[31] = (32066, 3792, 41);
  level.stadium_puzzle.keycardlocs[32] = (27438, -744, 41);
}

spawnaccesscards() {
  _id_F4DD331CD2CB26F1 = getdvarint("dvar_54E24CEFD08FF3C1", 1);
  _id_208F22AE47059089 = (0, 0, 15);
  level.stadium_puzzle.keycardlocs = scripts\engine\utility::array_randomize(level.stadium_puzzle.keycardlocs);
  level.stadium_puzzle.keycardlocs_chosen = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F4DD331CD2CB26F1 * 3; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 3) {
    origin = scripts\engine\utility::drop_to_ground(level.stadium_puzzle.keycardlocs[_id_AC0E594AC96AA3A8], 0) + _id_208F22AE47059089;
    scriptable = spawnscriptable("brloot_access_card_blue_stadium_parking", origin);
    _id_7E52B56769FA7774::registerscriptableinstance(scriptable);
    level.stadium_puzzle.keycardlocs_chosen[level.stadium_puzzle.keycardlocs_chosen.size] = scriptable;

    if(0)
      thread scripts\mp\utility\debug::drawsphere(origin, 128, 10000, (0, 1, 0));

    origin = scripts\engine\utility::drop_to_ground(level.stadium_puzzle.keycardlocs[_id_AC0E594AC96AA3A8 + 1], 0) + _id_208F22AE47059089;
    scriptable = spawnscriptable("brloot_access_card_blue_stadium_executive", origin);
    _id_7E52B56769FA7774::registerscriptableinstance(scriptable);
    level.stadium_puzzle.keycardlocs_chosen[level.stadium_puzzle.keycardlocs_chosen.size] = scriptable;

    if(0)
      thread scripts\mp\utility\debug::drawsphere(origin, 128, 10000, (0, 1, 0));

    origin = scripts\engine\utility::drop_to_ground(level.stadium_puzzle.keycardlocs[_id_AC0E594AC96AA3A8 + 2], 0) + _id_208F22AE47059089;
    scriptable = spawnscriptable("brloot_access_card_blue_stadium_concourse", origin);
    _id_7E52B56769FA7774::registerscriptableinstance(scriptable);
    level.stadium_puzzle.keycardlocs_chosen[level.stadium_puzzle.keycardlocs_chosen.size] = scriptable;

    if(0)
      thread scripts\mp\utility\debug::drawsphere(origin, 128, 10000, (0, 1, 0));
  }
}

serverroomrewardroll() {
  level.stadium_puzzle.serverroomrewardlocs = [];

  if(level.mapname == "mp_bm_bunker01") {
    level.stadium_puzzle.serverroomrewardlocs[0] = spawnStruct();
    level.stadium_puzzle.serverroomrewardlocs[0].origin = (2237, -3467, 322);
    level.stadium_puzzle.serverroomrewardlocs[0].angles = (5, 180, 0);
    level.stadium_puzzle.serverroomrewardlocs[0].locname = "stadium_parking_garage_access_reader";
    level.stadium_puzzle.serverroomrewardlocs[1] = spawnStruct();
    level.stadium_puzzle.serverroomrewardlocs[1].origin = (2237, -4005, 322);
    level.stadium_puzzle.serverroomrewardlocs[1].angles = (0, 0, 0);
    level.stadium_puzzle.serverroomrewardlocs[1].locname = "stadium_upper_level_access_card";
    level.stadium_puzzle.serverroomrewardlocs[2] = spawnStruct();
    level.stadium_puzzle.serverroomrewardlocs[2].origin = (2237, -4400, 322);
    level.stadium_puzzle.serverroomrewardlocs[2].angles = (0, 0, 0);
    level.stadium_puzzle.serverroomrewardlocs[2].locname = "stadium_concourse_access_reader";
  } else {
    level.stadium_puzzle.serverroomrewardlocs[0] = spawnStruct();
    level.stadium_puzzle.serverroomrewardlocs[0].origin = (28811, -5117, -1100);
    level.stadium_puzzle.serverroomrewardlocs[0].angles = (5, 180, 0);
    level.stadium_puzzle.serverroomrewardlocs[0].locname = "stadium_parking_garage_access_reader";
    level.stadium_puzzle.serverroomrewardlocs[1] = spawnStruct();
    level.stadium_puzzle.serverroomrewardlocs[1].origin = (28617, -1566, 10);
    level.stadium_puzzle.serverroomrewardlocs[1].angles = (0, 0, 0);
    level.stadium_puzzle.serverroomrewardlocs[1].locname = "stadium_upper_level_access_card";
    level.stadium_puzzle.serverroomrewardlocs[2] = spawnStruct();
    level.stadium_puzzle.serverroomrewardlocs[2].origin = (25743, 1821, -635);
    level.stadium_puzzle.serverroomrewardlocs[2].angles = (0, 0, 0);
    level.stadium_puzzle.serverroomrewardlocs[2].locname = "stadium_concourse_access_reader";
  }

  _id_C1A111FCE3901443 = 8;

  if(getDvar("dvar_7611A2790A0BF7FE", "") == "plunder")
    _id_C1A111FCE3901443 = 0;

  _id_0EB80FBB0BF8736D = getdvarint("dvar_F6309D261CB765A6", 8);
  _id_41D59B96CF4ECC51 = getdvarint("dvar_C9F85FE8A0808A02", 8);
  _id_CC2B025D5D9D414D = getdvarint("dvar_A0F7456D2A7F2EC0", 8);
  _id_94C29EF7C8696D31 = getdvarint("dvar_8BA797C60EFAC2A0", _id_C1A111FCE3901443);
  _id_1B32ECD6577D3426 = getdvarint("dvar_DFC4BE00D82601F1", 18);
  _id_80932ED77012B17D = getdvarint("dvar_FCBA69702BF87B60", 50);
  total = _id_0EB80FBB0BF8736D + _id_41D59B96CF4ECC51 + _id_CC2B025D5D9D414D + _id_94C29EF7C8696D31 + _id_1B32ECD6577D3426 + _id_80932ED77012B17D;
  _id_8B591B0BC361AB3D = randomintrange(1, total);

  if(_id_8B591B0BC361AB3D < _id_0EB80FBB0BF8736D)
    serverroomrewardspawn("brloot_killstreak_auav");
  else if(_id_8B591B0BC361AB3D <= _id_0EB80FBB0BF8736D + _id_41D59B96CF4ECC51)
    serverroomrewardspawn("brloot_specialist_bonus");
  else if(_id_8B591B0BC361AB3D <= _id_0EB80FBB0BF8736D + _id_41D59B96CF4ECC51 + _id_CC2B025D5D9D414D)
    serverroomrewardspawn("brloot_offhand_advancedsupplydrop");
  else if(_id_8B591B0BC361AB3D <= _id_0EB80FBB0BF8736D + _id_41D59B96CF4ECC51 + _id_CC2B025D5D9D414D + _id_94C29EF7C8696D31)
    serverroomrewardspawn("brloot_equip_gasmask_durable");
  else if(_id_8B591B0BC361AB3D <= _id_0EB80FBB0BF8736D + _id_41D59B96CF4ECC51 + _id_CC2B025D5D9D414D + _id_94C29EF7C8696D31 + _id_1B32ECD6577D3426)
    serverroomrewardspawn("brloot_killstreak_juggernaut");
}

serverroomrewardspawn(_id_0F0B26F5F8DB069E) {
  loc = scripts\engine\utility::random(level.stadium_puzzle.serverroomrewardlocs);
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(loc.origin, loc.angles);
  scriptable = _id_7E52B56769FA7774::spawnpickup(_id_0F0B26F5F8DB069E, _id_CB4FAD49263E20C4, 1, 0);
}

showdebugresult(_id_1B0D855F76756D57) {
  for(_id_018DA35A53F30FFD = 0; _id_018DA35A53F30FFD < 5; _id_018DA35A53F30FFD = _id_018DA35A53F30FFD + 0.05)
    waitframe();
}

debug_printcode(_id_48B11326257052F1) {
  level notify("endStadiumCodeDebugPrint");
  level endon("endStadiumCodeDebugPrint");
  _id_DD1003EA8B91BB85 = 10;

  for(;;) {
    if(!scripts\mp\flags::gameflag("prematch_done")) {} else {
      foreach(_id_AC0E594AC96AA3A8, number in _id_48B11326257052F1.code["array"]) {}
    }

    waitframe();
  }
}

debug_bunkertestaccesscardlocs() {
  level.stadium_puzzle.keycardlocs = [];
  level.stadium_puzzle.keycardlocs[0] = (1949, -3276, 322);
  level.stadium_puzzle.keycardlocs[1] = (1949, -3576, 322);
  level.stadium_puzzle.keycardlocs[2] = (1949, -3776, 322);
  level.stadium_puzzle.keycardlocs[3] = (1949, -3976, 322);
  level.stadium_puzzle.keycardlocs[4] = (1949, -4176, 322);
  level.stadium_puzzle.keycardlocs[5] = (1949, -4276, 322);
  level.stadium_puzzle.keycardlocs[6] = (1949, -3076, 322);
}

debug_spawnallaccesscards() {
  _id_95E0549C81B7F37D = ["brloot_access_card_blue_stadium_parking", "brloot_access_card_blue_stadium_executive", "brloot_access_card_blue_stadium_concourse"];
  _id_208F22AE47059089 = (0, 0, 15);

  foreach(loc in level.stadium_puzzle.keycardlocs) {
    origin = scripts\engine\utility::drop_to_ground(loc, 0) + _id_208F22AE47059089;
    scriptable = spawnscriptable(scripts\engine\utility::random(_id_95E0549C81B7F37D), origin);
    _id_7E52B56769FA7774::registerscriptableinstance(scriptable);
    thread scripts\mp\utility\debug::drawsphere(origin, 128, 10000, (0, 1, 0));
  }
}

debug_spawnrewardstest() {
  angles = (0, 0, 0);
  origin = (1563, -3289, 300);
  count = _id_7D625073C6379D53::getitemcount("brloot_killstreak_auav");
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(origin, angles);
  scriptable = _id_7E52B56769FA7774::spawnpickup("brloot_killstreak_auav", _id_CB4FAD49263E20C4, count, 0);
  origin = (1563, -3402, 300);
  count = _id_7D625073C6379D53::getitemcount("brloot_specialist_bonus");
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(origin, angles);
  scriptable = _id_7E52B56769FA7774::spawnpickup("brloot_specialist_bonus", _id_CB4FAD49263E20C4, 1, 0);
  origin = (1563, -3533, 300);
  count = _id_7D625073C6379D53::getitemcount("brloot_offhand_advancedsupplydrop");
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(origin, angles);
  scriptable = _id_7E52B56769FA7774::spawnpickup("brloot_offhand_advancedsupplydrop", _id_CB4FAD49263E20C4, 1, 0);
  origin = (1563, -3650, 300);
  count = _id_7D625073C6379D53::getitemcount("brloot_equip_gasmask_durable");
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(origin, angles);
  scriptable = _id_7E52B56769FA7774::spawnpickup("brloot_equip_gasmask_durable", _id_CB4FAD49263E20C4, 1, 0);
  origin = (1690, -3289, 300);
  count = _id_7D625073C6379D53::getitemcount("brloot_weapon_lm_dblmg_lege");
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(origin, angles);
  scriptable = _id_7E52B56769FA7774::spawnpickup("brloot_weapon_lm_dblmg_lege", _id_CB4FAD49263E20C4, 1, 0);
  origin = (1690, -3402, 300);
  count = _id_7D625073C6379D53::getitemcount("brloot_killstreak_juggernaut");
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(origin, angles);
  scriptable = _id_7E52B56769FA7774::spawnpickup("brloot_killstreak_juggernaut", _id_CB4FAD49263E20C4, 1, 0);
}

computer_debugtestloop(scriptable) {
  for(;;) {
    scriptable setscriptablepartstate("stadium_code_computer", "intro");
    wait 1;
    scriptable setscriptablepartstate("stadium_code_computer", "num0");
    wait 1;
    scriptable setscriptablepartstate("stadium_code_computer", "num1");
    wait 1;
    scriptable setscriptablepartstate("stadium_code_computer", "num2");
    wait 1;
    scriptable setscriptablepartstate("stadium_code_computer", "num3");
    wait 1;
    scriptable setscriptablepartstate("stadium_code_computer", "num4");
    wait 1;
    scriptable setscriptablepartstate("stadium_code_computer", "num5");
    wait 1;
    scriptable setscriptablepartstate("stadium_code_computer", "num6");
    wait 1;
    scriptable setscriptablepartstate("stadium_code_computer", "num7");
    wait 1;
    scriptable setscriptablepartstate("stadium_code_computer", "num8");
    wait 1;
    scriptable setscriptablepartstate("stadium_code_computer", "num9");
    wait 1;
    scriptable setscriptablepartstate("stadium_code_computer", "symbol1");
    wait 1;
    scriptable setscriptablepartstate("stadium_code_computer", "symbol2");
    wait 1;
    scriptable setscriptablepartstate("stadium_code_computer", "symbol3");
    wait 1;
    scriptable setscriptablepartstate("stadium_code_computer", "symbol4");
    wait 1;
    scriptable setscriptablepartstate("stadium_code_computer", "reset");
    wait 1;
  }
}

debug_showcardlocs() {
  level notify("endStadiumCardLocs");
  level endon("endStadiumCardLocs");

  for(;;) {
    foreach(scriptable in level.stadium_puzzle.keycardlocs_chosen) {
      if(isDefined(scriptable.origin))
        thread scripts\mp\utility\debug::drawsphere(scriptable.origin, 128, 1, (0, 1, 0));
    }

    wait 1;
  }
}

debug_show2dvotext(text, time) {
  if(!0) {
    return;
  }
  for(_id_6B7BEE46F2C6DA28 = 0; _id_6B7BEE46F2C6DA28 < time; _id_6B7BEE46F2C6DA28 = _id_6B7BEE46F2C6DA28 + 0.05)
    waitframe();
}