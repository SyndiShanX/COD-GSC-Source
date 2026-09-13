/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1181ee13d09794ef.gsc
***********************************************/

_id_42370792FB04B498() {
  level._id_4C2A57FDA1CE8F13 = [];
  level._id_4C2A57FDA1CE8F13[0] = getEnt("ee_fight_0", "targetname");
  level._id_4C2A57FDA1CE8F13[1] = getEnt("ee_fight_1", "targetname");
  level._id_4C2A57FDA1CE8F13[2] = getEnt("ee_fight_2", "targetname");
  level._id_4C2A57FDA1CE8F13[3] = getEnt("ee_fight_3", "targetname");
  level._id_4C2A57FDA1CE8F13[4] = getEnt("ee_fight_4", "targetname");
  _id_238735A024CA3DE7();
  thread _id_B2C8F2F0F647E2DC();
}

_id_238735A024CA3DE7() {
  foreach(target in level._id_4C2A57FDA1CE8F13)
  target.hit = 0;
}

_id_B2C8F2F0F647E2DC() {
  level endon("game_ended");
  level endon("fight_ee_kill");

  for(;;) {
    _id_13CCF8E4199BBB79 = undefined;
    _id_3F60DBABDA8D1456 = undefined;
    _id_82EE3CBEFC94B1F0 = undefined;
    _id_DB43E80335806A70 = undefined;
    _id_7101378C5566689B = undefined;
    _id_238735A024CA3DE7();

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_4C2A57FDA1CE8F13.size; _id_AC0E594AC96AA3A8++) {
      while(level._id_4C2A57FDA1CE8F13[_id_AC0E594AC96AA3A8].hit < int(level._id_4C2A57FDA1CE8F13[_id_AC0E594AC96AA3A8].script_noteworthy)) {
        _id_82EE3CBEFC94B1F0 = gettime();
        level._id_4C2A57FDA1CE8F13[_id_AC0E594AC96AA3A8] waittill("damage", amount, attacker);

        if(isDefined(_id_7101378C5566689B) && _id_7101378C5566689B != attacker) {
          continue;
        }
        if(!isDefined(_id_13CCF8E4199BBB79)) {
          _id_13CCF8E4199BBB79 = gettime();
          _id_82EE3CBEFC94B1F0 = _id_13CCF8E4199BBB79;
        }

        _id_3F60DBABDA8D1456 = (gettime() - _id_82EE3CBEFC94B1F0) / 1000;
        _id_DB43E80335806A70 = (gettime() - _id_13CCF8E4199BBB79) / 1000;

        if(_id_DB43E80335806A70 >= level._id_0A5464F8C55D0857.timeout) {
          break;
        }

        level._id_4C2A57FDA1CE8F13[_id_AC0E594AC96AA3A8].hit++;
        _id_7101378C5566689B = attacker;
      }
    }

    _id_38C544AED01DD412 = gettime();
    time = (_id_38C544AED01DD412 - _id_13CCF8E4199BBB79) / 1000;
    time = scripts\engine\math::round_float(time, 2, 0);

    if(time <= level._id_0A5464F8C55D0857.timeout)
      _id_7101378C5566689B iprintlnbold(&"MP_M_FIGHT/EE_YOUR_TIME", time);
    else
      _id_7101378C5566689B iprintlnbold(&"MP_M_FIGHT/TIMEOUT");

    if(time < level._id_0A5464F8C55D0857._id_C2860AC9BF1552F1) {
      if(istrue(level._id_0A5464F8C55D0857._id_A0F2F446F54C692E))
        thread _id_109F14FBCC11573F(_id_7101378C5566689B);

      thread _id_9BF47F3E6B13C237();

      if(istrue(level._id_0A5464F8C55D0857._id_FA3D9843491A78AB))
        thread _id_A23EC77CB27F0558();

      scripts\mp\compass::setupminimap("compass_map_mp_m_fight_ee");
      level notify("fight_ee_kill");
      break;
    }

    _id_5ED47EE04969D752 = level._id_0A5464F8C55D0857._id_5ED47EE04969D752;

    if(istrue(_id_5ED47EE04969D752)) {
      wait(level._id_0A5464F8C55D0857.cooldown);
      continue;
    }

    level notify("fight_ee_kill");
    break;
  }
}

_id_9BF47F3E6B13C237() {
  level endon("game_ended");
  wait 1;

  for(_id_83830407E2EFC1FC = level._id_0A5464F8C55D0857._id_B2892FF2F33B4FB6; _id_83830407E2EFC1FC > 0; _id_83830407E2EFC1FC--) {
    _id_C99BCC1633FD3654 = (randomintrange(-700, -200), randomintrange(800, 1000), 1000);
    _id_86C4DA168C6A69F5 = spawn("script_model", _id_C99BCC1633FD3654);
    _id_86C4DA168C6A69F5 setModel("toy_teddy_bear_01_brown_bloody_dyn");

    if(istrue(level._id_0A5464F8C55D0857._id_3B72D2F29AD349E6))
      _id_86C4DA168C6A69F5 thread _id_7AFBD9BCA2B0D11A();

    _id_86C4DA168C6A69F5 physics_takecontrol(1);
    _id_86C4DA168C6A69F5 physics_applyimpulse(_id_86C4DA168C6A69F5.origin + (0, 0, 50), (randomintrange(-50, 51), randomintrange(-50, 51), randomintrange(-50, 51)));
    wait 0.15;
  }
}

_id_7AFBD9BCA2B0D11A() {
  self endon("death");
  self physics_registerforcollisioncallback();
  self waittill("collision");
  playFX(scripts\engine\utility::getfx("vfx_teddy_pop"), self.origin);

  if(level._id_0A5464F8C55D0857._id_83CAA1F2CFC89661 == 1)
    playsoundatpos(self.origin, "thermite_bomb_impact");
  else if(level._id_0A5464F8C55D0857._id_83CAA1F2CFC89661 == 2)
    playsoundatpos(self.origin, "knife_impact");
}

_id_A23EC77CB27F0558() {
  level endon("game_ended");
  wait 1;
  scripts\engine\utility::exploder("rainbow");
}

#using_animtree("script_model");

_id_109F14FBCC11573F(owner) {
  level endon("game_ended");
  location = [];
  yaw = undefined;
  _id_5B5AAF2B1DD80391 = [];
  location[location.size] = (-528, 752, 2500);
  location[location.size] = (-776, 1824, 2500);
  location[location.size] = (-1664, 952, 2500);
  yaw = 315;
  streakinfo = spawnStruct();
  streakinfo.streakname = "fuel_airstrike";
  streakinfo.owner = owner;
  streakinfo.score = 0;
  streakinfo.shots_fired = 0;
  streakinfo.hits = 0;
  streakinfo.damage = 0;
  streakinfo.kills = 0;
  streakinfo._id_DA36495CA96B06BE = 0;
  streakinfo._id_E971626FA4901415 = 0;
  _id_97195D51C4C2B14E = undefined;
  animname = % mp_alfa10_flyin;
  airstrikeid = undefined;
  _id_5ED27D0675C3B6EB = 24000;
  _id_23122E7B902F2EA9 = 6500;
  _id_76AB620FD7CC70BD = 2500;
  _id_361663D437DB22F5 = 1500;
  _id_302D1041DAF77572 = 215;
  direction = (0, yaw, 0);
  _id_505331AD630BBC6B = undefined;
  player = owner;

  if(isDefined(player)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < location.size; _id_AC0E594AC96AA3A8++) {
      flightpath = scripts\cp_mp\killstreaks\airstrike::getflightpath(location[_id_AC0E594AC96AA3A8], direction, _id_5ED27D0675C3B6EB, 1, _id_76AB620FD7CC70BD, _id_23122E7B902F2EA9, _id_361663D437DB22F5, streakinfo.streakname, _id_505331AD630BBC6B);
      level thread _id_9C630D5BA476FB06(location[_id_AC0E594AC96AA3A8], flightpath["startPoint"], flightpath["endPoint"], _id_76AB620FD7CC70BD, _id_97195D51C4C2B14E, streakinfo, animname, streakinfo.owner, airstrikeid);
    }
  }
}

_id_9C630D5BA476FB06(targetsite, _id_6D29E82378E59E76, _id_98255165B50D8173, _id_76AB620FD7CC70BD, _id_97195D51C4C2B14E, streakinfo, animname, owner, airstrikeid) {
  if(!isDefined(owner)) {
    return;
  }
  owner endon("disconnect");
  level endon("game_ended");
  config = level.airstrikesettings[streakinfo.streakname];
  _id_4C4796C182975686 = getanimlength(animname);
  _id_7B00721E9D1EF2A0 = scripts\engine\utility::get_notetrack_time(animname, "attack");
  _id_3A69E5FC82079CE3 = targetsite * (1, 1, 0) + (0, 0, _id_76AB620FD7CC70BD);
  _id_7789CDA8C1E3128E = vectortoangles(_id_98255165B50D8173 - _id_6D29E82378E59E76);
  planemodel = config.modelbase;

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(owner) && isDefined(config.modelbasealt))
    planemodel = config.modelbasealt;

  plane = spawn("script_model", _id_3A69E5FC82079CE3);
  plane setModel(planemodel);
  plane.angles = _id_7789CDA8C1E3128E;
  plane.flightdir = anglesToForward(_id_7789CDA8C1E3128E);
  plane.flightheight = _id_76AB620FD7CC70BD;
  plane.owner = owner;
  plane.team = owner.team;
  plane.lifeid = streakinfo.lifeid;
  plane.streakinfo = streakinfo;
  plane.airstrikeid = airstrikeid;
  plane setotherent(owner);
  plane scriptmoveroutline();
  plane scriptmoverthermal();
  plane scriptmoverplane();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList"))
    plane[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](streakinfo.streakname, "Killstreak_Air", owner, 0, 1, 100);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br", "challengeEvaluator")) {
    _id_CD37CE775909957B = spawnStruct();
    _id_CD37CE775909957B.plane = plane;
    _id_CD37CE775909957B.targetsite = targetsite;
    owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("br", "challengeEvaluator")]]("br_mastery_pointBlank_airstrike", _id_CD37CE775909957B);
  }

  _id_9604A2586B0A302C = "hud_icon_minimap_killstreak_airstrike";

  if(streakinfo.streakname == "fuel_airstrike")
    _id_9604A2586B0A302C = "hud_icon_minimap_killstreak_fuel_airstrike";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective"))
    plane.minimapid = plane[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]](_id_9604A2586B0A302C, plane.team, undefined, 1, 1);

  _id_FAFBDA0EBA9C0AAB = _id_7B00721E9D1EF2A0 - 0.75;
  _id_3A20F9101E50025F = 0.05;
  _id_3A020E101E2DDEAD = _id_FAFBDA0EBA9C0AAB;
  _id_7C39D972E849C204 = 8.596;

  if(streakinfo.streakname == "fuel_airstrike")
    _id_FAFBDA0EBA9C0AAB = _id_7B00721E9D1EF2A0 + 1;

  _id_E4D26F59DB05025A = config._id_C80E3EA2A37A7182;

  if(!isDefined(_id_E4D26F59DB05025A))
    _id_E4D26F59DB05025A = "ks_airstrike_mp";

  plane thread scripts\cp_mp\killstreaks\airstrike::airstrike_delayplayscriptable(0.05);
  level scripts\cp_mp\killstreaks\airstrike::airstrike_playflyfx(plane, _id_E4D26F59DB05025A, _id_6D29E82378E59E76, anglesToForward(_id_7789CDA8C1E3128E), _id_3A20F9101E50025F, _id_3A020E101E2DDEAD, _id_7C39D972E849C204, _id_4C4796C182975686, streakinfo);
  plane.animname = streakinfo.streakname;
  plane scripts\common\anim::setanimtree();
  plane.scenenode = spawn("script_model", _id_3A69E5FC82079CE3);
  plane.scenenode.angles = plane.angles;
  plane.scenenode setModel("tag_origin");
  plane.scenenode scripts\common\anim::anim_single_solo(plane, "airstrike_flyby");

  if(isDefined(plane.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](plane.minimapid);
  }

  plane notify("delete");

  if(isDefined(plane.turrettarget))
    plane.turrettarget delete();

  if(isDefined(plane.scenenode))
    plane.scenenode delete();

  if(isDefined(plane))
    plane delete();
}