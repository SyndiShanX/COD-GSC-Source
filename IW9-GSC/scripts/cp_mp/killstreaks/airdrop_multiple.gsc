/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\airdrop_multiple.gsc
**********************************************************/

airdrop_multiple_init() {
  level.cratedropdata.ac130s = [];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop_multiple", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop_multiple", "init")]]();

  airdrop_multiple_initanimations();
  _id_4D3D5B47E3EF44CD();
}

airdrop_multiple_initanimations() {
  _id_DD9C6B6A52A14C8D();
  _id_CFF636AC94A2FEBC();
  _id_64D1F666AECF56F0();
  _id_86D69A3DBC763CB9();
}

_id_4D3D5B47E3EF44CD() {
  game["dialog"]["airdrop_multiple_use"] = "killstreak_remote_operator_request_response";
}

#using_animtree("script_model");

_id_DD9C6B6A52A14C8D() {
  animname = "care_package_drop_multiple";
  _id_7A950615615223F2 = undefined;
  _id_7A950615615223F2 = "ac130";
  level.scr_animtree[_id_7A950615615223F2] = #animtree;
  level.scr_anim[_id_7A950615615223F2][animname] = % mp_eadrop_acharlie130;
  level.scr_animname[_id_7A950615615223F2][animname] = "mp_eadrop_acharlie130";
  _id_7A950615615223F2 = "care_package_1";
  level.scr_animtree[_id_7A950615615223F2] = #animtree;
  level.scr_anim[_id_7A950615615223F2][animname] = % mp_eadrop_cpkg_01;
  level.scr_animname[_id_7A950615615223F2][animname] = "mp_eadrop_cpkg_01";
  _id_7A950615615223F2 = "care_package_2";
  level.scr_animtree[_id_7A950615615223F2] = #animtree;
  level.scr_anim[_id_7A950615615223F2][animname] = % mp_eadrop_cpkg_02;
  level.scr_animname[_id_7A950615615223F2][animname] = "mp_eadrop_cpkg_02";
  _id_7A950615615223F2 = "care_package_3";
  level.scr_animtree[_id_7A950615615223F2] = #animtree;
  level.scr_anim[_id_7A950615615223F2][animname] = % mp_eadrop_cpkg_03;
  level.scr_animname[_id_7A950615615223F2][animname] = "mp_eadrop_cpkg_03";
  _id_7A950615615223F2 = "care_package_chute_1";
  level.scr_animtree[_id_7A950615615223F2] = #animtree;
  level.scr_anim[_id_7A950615615223F2][animname] = % mp_eadrop_parachute_01;
  level.scr_animname[_id_7A950615615223F2][animname] = "mp_eadrop_parachute_01";
  _id_7A950615615223F2 = "care_package_chute_2";
  level.scr_animtree[_id_7A950615615223F2] = #animtree;
  level.scr_anim[_id_7A950615615223F2][animname] = % mp_eadrop_parachute_02;
  level.scr_animname[_id_7A950615615223F2][animname] = "mp_eadrop_parachute_02";
  _id_7A950615615223F2 = "care_package_chute_3";
  level.scr_animtree[_id_7A950615615223F2] = #animtree;
  level.scr_anim[_id_7A950615615223F2][animname] = % mp_eadrop_parachute_03;
  level.scr_animname[_id_7A950615615223F2][animname] = "mp_eadrop_parachute_03";
}

#using_animtree("mp_vehicles_always_loaded");

_id_CFF636AC94A2FEBC() {
  _id_7A950615615223F2 = "care_package_drop_multiple";
  animname = "heli_multi";
  level.scr_animtree[_id_7A950615615223F2] = #animtree;
  level.scr_anim[_id_7A950615615223F2][animname] = % iw9_air_heli_dropoff;
}

#using_animtree("script_model");

_id_64D1F666AECF56F0() {
  _id_7A950615615223F2 = "care_package_drop_multiple";
  animname = "heli_multi_rope_1";
  level.scr_animtree[_id_7A950615615223F2] = #animtree;
  level.scr_anim[_id_7A950615615223F2][animname] = % iw9_air_heli_rope_dropoff_1;
  level.scr_animname[_id_7A950615615223F2][animname] = "iw9_air_heli_rope_dropoff_1";
  animname = "heli_multi_rope_2";
  level.scr_animtree[_id_7A950615615223F2] = #animtree;
  level.scr_anim[_id_7A950615615223F2][animname] = % iw9_air_heli_rope_dropoff_2;
  level.scr_animname[_id_7A950615615223F2][animname] = "iw9_air_heli_rope_dropoff_2";
  animname = "heli_multi_rope_3";
  level.scr_animtree[_id_7A950615615223F2] = #animtree;
  level.scr_anim[_id_7A950615615223F2][animname] = % iw9_air_heli_rope_dropoff_3;
  level.scr_animname[_id_7A950615615223F2][animname] = "iw9_air_heli_rope_dropoff_3";
}

_id_86D69A3DBC763CB9() {
  _id_7A950615615223F2 = "care_package_drop_multiple";
  animname = "heli_multi_crate_1";
  level.scr_animtree[_id_7A950615615223F2] = #animtree;
  level.scr_anim[_id_7A950615615223F2][animname] = % iw9_air_heli_crate_dropoff_1;
  level.scr_animname[_id_7A950615615223F2][animname] = "iw9_air_heli_crate_dropoff_1";
  animname = "heli_multi_crate_2a";
  level.scr_animtree[_id_7A950615615223F2] = #animtree;
  level.scr_anim[_id_7A950615615223F2][animname] = % iw9_air_heli_crate_dropoff_2a;
  level.scr_animname[_id_7A950615615223F2][animname] = "iw9_air_heli_crate_dropoff_2a";
  animname = "heli_multi_crate_2b";
  level.scr_animtree[_id_7A950615615223F2] = #animtree;
  level.scr_anim[_id_7A950615615223F2][animname] = % iw9_air_heli_crate_dropoff_2b;
  level.scr_animname[_id_7A950615615223F2][animname] = "iw9_air_heli_crate_dropoff_2b";
  animname = "heli_multi_crate_3a";
  level.scr_animtree[_id_7A950615615223F2] = #animtree;
  level.scr_anim[_id_7A950615615223F2][animname] = % iw9_air_heli_crate_dropoff_3a;
  level.scr_animname[_id_7A950615615223F2][animname] = "iw9_air_heli_crate_dropoff_3a";
  animname = "heli_multi_crate_3b";
  level.scr_animtree[_id_7A950615615223F2] = #animtree;
  level.scr_anim[_id_7A950615615223F2][animname] = % iw9_air_heli_crate_dropoff_3b;
  level.scr_animname[_id_7A950615615223F2][animname] = "iw9_air_heli_crate_dropoff_3b";
  animname = "heli_multi_crate_3c";
  level.scr_animtree[_id_7A950615615223F2] = #animtree;
  level.scr_anim[_id_7A950615615223F2][animname] = % iw9_air_heli_crate_dropoff_3c;
  level.scr_animname[_id_7A950615615223F2][animname] = "iw9_air_heli_crate_dropoff_3c";
}

airdrop_multiple_dropcrates(owner, team, position, angles, destination, vehiclereserved, streakinfo) {
  if(level.cratedropdata.ac130s.size >= 2) {
    if(isDefined(owner) && isDefined(streakinfo)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/VEHICLE_REFUND_KILLSTREAK");

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "awardKillstreakFromStruct"))
        owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "awardKillstreakFromStruct")]](streakinfo.mpstreaksysteminfo, "other");
    }
  } else {
    _id_04A2AA8B66AC796D = [];
    cratetype = scripts\engine\utility::ter_op(isDefined(owner), "killstreak", "killstreak_no_owner");
    numcrates = 3;
    usephysics = undefined;

    if(isDefined(streakinfo.cratetype))
      cratetype = streakinfo.cratetype;

    if(isDefined(streakinfo.numcrates))
      numcrates = streakinfo.numcrates;

    if(isDefined(streakinfo.usephysics))
      usephysics = streakinfo.usephysics;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < numcrates; _id_AC0E594AC96AA3A8++) {
      streakname = undefined;

      if(_id_04A2AA8B66AC796D.size > 0)
        streakname = scripts\cp_mp\killstreaks\airdrop::getrandomkillstreak(_id_04A2AA8B66AC796D);
      else
        streakname = scripts\cp_mp\killstreaks\airdrop::getrandomkillstreak();

      _id_04A2AA8B66AC796D[_id_04A2AA8B66AC796D.size] = streakname;
    }

    if(isDefined(owner)) {
      owner thread scripts\cp_mp\killstreaks\airdrop::airdrop_playdeploydialog(streakinfo);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash"))
        thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_airdrop_multiple", owner);
    }

    _id_EBB5C644A3F5CFBC = _id_AD08AC92F283B91E(position);
    _id_46D5F28D2724BF1F = angles * (0, 1, 0);
    scenenode = spawn("script_model", _id_EBB5C644A3F5CFBC);
    scenenode.angles = _id_46D5F28D2724BF1F;
    scenenode setModel("tag_origin");
    scenenode.owner = owner;
    scenenode.team = team;
    scenenode.hasowner = isDefined(owner);
    scenenode.latestanimendtime = -1;
    heli = _id_1C989718D26B182D(scenenode, vehiclereserved, streakinfo);

    if(!isDefined(heli)) {
      scenenode _id_D1443844F7590343();
      return undefined;
    }

    rope = _id_A1C4A7CA871DCDF5(scenenode, _id_04A2AA8B66AC796D);

    if(!isDefined(rope)) {
      scenenode _id_D1443844F7590343();
      return undefined;
    }

    crates = _id_AF5C454F08DB45E1(cratetype, scenenode, _id_04A2AA8B66AC796D, streakinfo, position);

    if(scenenode.crates.size < numcrates) {
      scenenode _id_D1443844F7590343(1);
      return undefined;
    }

    scenenode thread _id_8E3FA08965432CFA();
  }
}

airdrop_multiple_watchdropcrates() {
  self endon("death");
  scripts\common\anim::anim_first_frame_solo(self.ac130, "care_package_drop_multiple");

  foreach(crate in self.crates)
  scripts\common\anim::anim_first_frame_solo(crate, "care_package_drop_multiple");

  foreach(chute in self.chutes)
  scripts\common\anim::anim_first_frame_solo(chute, "care_package_drop_multiple");

  airdrop_multiple_watchdropcratesinternal();
  thread airdrop_multiple_watchdropcratesend();
}

airdrop_multiple_watchdropcratesinternal() {
  _id_DDD3DF8D5EA97F86 = undefined;

  while(gettime() <= self.latestanimendtime) {
    if(self.hasowner) {
      if(!isDefined(self.ownerdisconnected)) {
        if(isDefined(self.owner)) {
          if(!isDefined(self.ownerjoinedteam)) {
            if(self.team != self.owner.team)
              self.ownerjoinedteam = 1;
          }
        } else
          self.ownerdisconnected = 1;
      }
    }

    if(!isDefined(_id_DDD3DF8D5EA97F86))
      _id_DDD3DF8D5EA97F86 = 1;
    else if(_id_DDD3DF8D5EA97F86) {
      if(isDefined(self.ac130)) {
        self.ac130 thread airdrop_multiple_ac130firstframe();
        thread scripts\common\anim::anim_single_solo(self.ac130, "care_package_drop_multiple");
      }

      foreach(crate in self.crates) {
        if(isDefined(crate)) {
          crate setscriptablepartstate("visibility", "show", 0);
          thread scripts\common\anim::anim_single_solo(crate, "care_package_drop_multiple");
        }
      }

      foreach(chute in self.chutes) {
        if(isDefined(chute)) {
          chute show();
          thread scripts\common\anim::anim_single_solo(chute, "care_package_drop_multiple");
        }
      }

      _id_DDD3DF8D5EA97F86 = 0;
    } else {
      _id_3A8CAC6C1D60003C = istrue(self.ownerdisconnected) || istrue(self.ownerjoinedteam);

      if(isDefined(self.ac130)) {
        if(_id_3A8CAC6C1D60003C || gettime() > self.ac130.animendtime)
          self.ac130 airdrop_multiple_destroyac130();
      }

      foreach(crate in self.crates) {
        if(isDefined(crate)) {
          if(gettime() > crate.animendtime) {
            if(_id_3A8CAC6C1D60003C)
              crate thread scripts\cp_mp\killstreaks\airdrop::destroycrate();

            thread scripts\cp_mp\killstreaks\airdrop::docratedropfromscripted(crate);
            continue;
          }

          if(gettime() > crate.animdroptime) {
            if(gettime() > crate.animstoptrailtime)
              crate setscriptablepartstate("trail", "neutral", 1);
            else
              crate setscriptablepartstate("trail", "active", 1);

            if(_id_3A8CAC6C1D60003C)
              crate thread scripts\cp_mp\killstreaks\airdrop::destroycrate();

            continue;
          }

          if(_id_3A8CAC6C1D60003C) {
            crate thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
            continue;
          }

          if(!isDefined(self.ac130) || istrue(self.ac130.isdestroyed))
            thread scripts\cp_mp\killstreaks\airdrop::docratedropfromscripted(crate);
        }
      }

      foreach(chute in self.chutes) {
        if(isDefined(chute)) {
          if(gettime() > chute.animendtime) {
            chute thread scripts\cp_mp\killstreaks\airdrop::destroychute();
            continue;
          }

          if(gettime() <= chute.crateanimdroptime && (!isDefined(chute.crate) || !isDefined(self.crates[chute.crate getentitynumber()]))) {
            chute thread scripts\cp_mp\killstreaks\airdrop::destroychute();
            continue;
          }

          if(gettime() > chute.animunhidetime)
            chute setscriptablepartstate("visibility", "show", 0);
        }
      }
    }

    waitframe();
  }
}

airdrop_multiple_watchdropcratesend() {
  if(isDefined(self.ac130))
    self.ac130 thread airdrop_multiple_destroyac130();

  foreach(crate in self.crates) {
    if(isDefined(crate))
      crate thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
  }

  foreach(chute in self.chutes) {
    if(isDefined(chute))
      chute thread scripts\cp_mp\killstreaks\airdrop::destroychute();
  }

  self delete();
}

airdrop_multiple_createac130(scenenode) {
  ac130 = spawn("script_model", scenenode.origin);
  ac130.angles = scenenode.angles;
  ac130.owner = scenenode.owner;
  ac130.team = scenenode.team;
  ac130.scenenode = scenenode;
  scenenode.ac130 = ac130;
  ac130 scriptmoveroutline();
  ac130 scriptmoverthermal();
  ac130 setotherent(scenenode.owner);
  ac130 setentityowner(scenenode.owner);
  ac130 hide();
  airdrop_multiple_addac130tolist(ac130);
  ac130.animname = "ac130";
  ac130 scripts\common\anim::setanimtree();
  _id_96668ADB78C5AA8A = level.scr_anim["ac130"]["care_package_drop_multiple"];
  ac130.animendtime = gettime() + getanimlength(_id_96668ADB78C5AA8A) * 1000;
  scenenode.latestanimendtime = scripts\engine\utility::ter_op(ac130.animendtime > scenenode.latestanimendtime, ac130.animendtime, scenenode.latestanimendtime);
  minimapid = -1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective"))
    minimapid = ac130[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]]("icon_minimap_dropship", scenenode.team, 1, 1, 1);

  if(minimapid != -1)
    ac130.minimapid = minimapid;

  return ac130;
}

airdrop_multiple_ac130firstframe() {
  self show();
  self playLoopSound("iw8_bradley_drop_c130");
  self setscriptablepartstate("lights2", "on", 0);
  self setscriptablepartstate("contrails", "on", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop_multiple", "monitorDamage"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop_multiple", "monitorDamage")]](1000, "hitequip", ::airdrop_multiple_ac130handlefataldamage, ::airdrop_multiple_ac130handledamage, 1);
}

airdrop_multiple_destroyac130() {
  airdrop_multiple_deleteac130();
}

airdrop_multiple_deleteac130(_id_CBF7BE4F62A0DDB2) {
  self notify("death");

  if(isDefined(self.scenenode))
    self.scenenode.ac130 = undefined;

  airdrop_multiple_removeac130fromlist(self getentitynumber());
  self.scenenode = undefined;
  self.animendtime = undefined;
  self stoploopsound();

  if(isDefined(self.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self.minimapid);

    self.minimapid = undefined;
  }

  if(isDefined(_id_CBF7BE4F62A0DDB2) && _id_CBF7BE4F62A0DDB2 > 0)
    wait(_id_CBF7BE4F62A0DDB2);

  self delete();
}

airdrop_multiple_ac130handledamage(data) {
  if(isDefined(data.attacker) && isPlayer(data.attacker)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback"))
      data.attacker[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("");
  }

  return 0;
}

airdrop_multiple_ac130handlefataldamage(data) {
  if(isPlayer(data.attacker)) {
    friendlydamage = 0;

    if(level.teambased && data.attacker.team == self.team)
      friendlydamage = 1;
    else if(data.attacker == self.owner)
      friendlydamage = 1;

    if(!friendlydamage) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash"))
        thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("callout_destroyed_ac130", data.attacker);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "doScoreEvent"))
        data.attacker thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "doScoreEvent")]]("kill", data.objweapon, 400);
    }
  }

  airdrop_multiple_destroyac130();
}

_id_1C989718D26B182D(scenenode, vehiclereserved, streakinfo) {
  if(istrue(vehiclereserved))
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

  _id_284EC83142394E65 = scenenode.origin;
  _id_06C26E549B220A7D = scenenode.angles;
  heli = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(undefined, _id_284EC83142394E65, _id_06C26E549B220A7D, "veh_airdrop_mp_phys", "veh9_mil_air_heli_medium_airdrop_mp");

  if(!isDefined(heli))
    return undefined;

  if(!isDefined(scenenode.team))
    scenenode.team = "neutral";

  if(scenenode.team != "neutral")
    heli setvehicleteam(scenenode.team);

  heli.owner = scenenode.owner;
  heli.team = scenenode.team;
  heli.health = 999999;
  heli.scenenode = scenenode;
  heli.animname = "care_package_drop_multiple";
  heli.animindex = "heli_multi";
  heli._id_85DE4B2384EA1FE3 = level.scr_anim[heli.animname][heli.animindex];
  scenenode.heli = heli;
  scenenode.heliendtime = gettime() + getanimlength(heli._id_85DE4B2384EA1FE3) * 1000;
  scenenode._id_79AC0FF6C36A088D = getanimlength(heli._id_85DE4B2384EA1FE3);
  scenenode.latestanimendtime = scenenode.heliendtime;
  destroyedsplash = undefined;
  vodestroyed = undefined;
  scorepopup = undefined;

  if(isDefined(level.heliconfigs) && isDefined(level.heliconfigs["airdrop_multiple"])) {
    config = level.heliconfigs["airdrop_multiple"];
    heli.maxhealth = config.maxhealth;
    heli.currenthealth = config.maxhealth;
    _id_5A127424B8DF87B6 = config.callout;
    vodestroyed = config.vodestroyed;
    scorepopup = config.scorepopup;
  } else {
    heli.maxhealth = 1200;
    heli.currenthealth = heli.maxhealth;
  }

  heli.helitype = "airdrop_multiple";
  heli setscriptablepartstate("engine", "on", 0);
  heli setscriptablepartstate("lights", "active", 1);

  if(isDefined(heli.owner)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList"))
      heli[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]]("airdrop_multiple", "Killstreak_Air", heli.owner, 0, 0);

    if(scenenode.team != "neutral")
      heli scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", heli.owner);
  }

  heli _id_3856D0DD250DD766(streakinfo.streakname);
  heli thread scripts\cp_mp\killstreaks\airdrop::watchhelidestroyearly();
  return heli;
}

_id_3856D0DD250DD766(streakname) {
  _id_E25F9B0DE2CC7B81 = self;
  scorepopup = "destroyed_" + streakname;
  vodestroyed = undefined;
  destroyedsplash = "callout_destroyed_" + streakname;
  _id_8DFC256103CCE53E = ::_id_ABF972F8C94EE5A4;
  _id_191284E2E2837328 = ::_id_6AD0D2B89EBCCB68;
  _id_BACC6DD14316758C = ::_id_CC5032D2F9D08D1A;
  _id_7DA88D9C69433487 = ::_id_F1E65202514970C5;
  deathcallback = ::_id_71D81F98F8638B99;
  scripts\cp_mp\utility\killstreak_utility::_id_836A81868136192D(streakname, _id_E25F9B0DE2CC7B81, scorepopup, vodestroyed, destroyedsplash, _id_8DFC256103CCE53E, _id_191284E2E2837328, _id_BACC6DD14316758C, _id_7DA88D9C69433487, deathcallback);

  if(isDefined(self.owner))
    scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(self, self.owner, self.owner.team);

  scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(1, 1000, ::_id_36159D21C49360CA);
  scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(2, 500, ::_id_870290238449589F);
  scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(3, 250, ::_id_1A3DB0D03EC0014F);
}

_id_ABF972F8C94EE5A4(streakname) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageData"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageData")]](streakname, 7);
}

_id_6AD0D2B89EBCCB68(streakname) {}

_id_CC5032D2F9D08D1A(data) {
  damage = data.damage;
  attacker = data.attacker;
  return 1;
}

_id_F1E65202514970C5(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  self.currenthealth = self.currenthealth - damage;
  scripts\cp_mp\utility\killstreak_utility::_id_DB9562064A4DD635(self.currenthealth);
  return 1;
}

_id_36159D21C49360CA() {}

_id_870290238449589F() {}

_id_1A3DB0D03EC0014F() {}

_id_71D81F98F8638B99(data) {
  self.killedbyweapon = data.objweapon;
  thread scripts\cp_mp\killstreaks\airdrop::destroyheli();
  return 1;
}

_id_A1C4A7CA871DCDF5(scenenode, _id_400D80E48322C797) {
  heli = scenenode.heli;
  rope = spawn("script_model", heli.origin);
  rope setModel("veh9_mil_air_heli_airdrop_rig_mp");
  rope.animname = "care_package_drop_multiple";
  rope.animindex = _id_6624058BAC19055D(_id_400D80E48322C797);
  rope._id_85DE4B2384EA1FE3 = level.scr_anim[rope.animname][rope.animindex];
  rope.scenenode = scenenode;
  rope scripts\common\anim::setanimtree();
  scenenode.rope = rope;
  numcrates = _id_400D80E48322C797.size;

  if(numcrates < 3)
    rope setscriptablepartstate("rope_visibility", "show_" + numcrates);

  return rope;
}

_id_AF5C454F08DB45E1(cratetype, scenenode, _id_400D80E48322C797, streakinfo, _id_FE880EB7782C9EA0) {
  owner = scenenode.owner;
  team = scenenode.team;
  destination = scenenode.origin;
  usephysics = 0;
  _id_7A950615615223F2 = "care_package_drop_multiple";
  crates = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_400D80E48322C797.size; _id_AC0E594AC96AA3A8++) {
    animindex = _id_E23EB6D57186432C(_id_AC0E594AC96AA3A8, _id_400D80E48322C797);
    data = scripts\cp_mp\killstreaks\airdrop::getkillstreakcratedatabystreakname(_id_400D80E48322C797[_id_AC0E594AC96AA3A8], 0);
    crate = scripts\cp_mp\killstreaks\airdrop::createcrateforscripteddrop(owner, team, cratetype, destination, usephysics, 0, data, streakinfo, scenenode, _id_7A950615615223F2, animindex, 1, _id_FE880EB7782C9EA0);

    if(!isDefined(crate)) {
      break;
    }

    crate.animindex = animindex;
    crate._id_85DE4B2384EA1FE3 = level.scr_anim[crate.animname][crate.animindex];
    crate._id_79AC0FF6C36A088D = getanimlength(crate._id_85DE4B2384EA1FE3);
    crate.scenenode = scenenode;
    crates[crates.size] = crate;
  }

  return crates;
}

_id_D1443844F7590343(_id_C5701227F7F0D907) {
  if(isDefined(self.heli))
    self.heli thread scripts\cp_mp\killstreaks\airdrop::destroyheli();

  if(isDefined(self.rope))
    self.rope delete();

  if(istrue(_id_C5701227F7F0D907)) {
    if(isDefined(self.crates)) {
      foreach(crate in self.crates) {
        if(isDefined(crate))
          crate thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
      }
    }
  }

  self delete();
}

_id_8E3FA08965432CFA() {
  self endon("death");
  thread scripts\common\anim::anim_first_frame_solo(self.heli, self.heli.animindex);
  thread scripts\common\anim::anim_first_frame_solo(self.rope, self.rope.animindex);

  foreach(crate in self.crates)
  thread scripts\common\anim::anim_first_frame_solo(crate, crate.animindex);

  _id_DE1CCE0B2D73D436();
}

_id_DE1CCE0B2D73D436() {
  self endon("death");
  animendtime = self._id_79AC0FF6C36A088D;
  thread scripts\common\anim::anim_single_solo(self.heli, self.heli.animindex);
  thread scripts\common\anim::anim_single_solo(self.rope, self.rope.animindex);

  foreach(crate in self.crates) {
    if(isDefined(crate))
      thread _id_26877D0B1B30BD68(crate);
  }

  wait(animendtime);
  _id_D1443844F7590343();
}

_id_26877D0B1B30BD68(crate) {
  self endon("death");
  crate endon("death");
  animendtime = randomfloatrange(crate._id_79AC0FF6C36A088D - 0.1, crate._id_79AC0FF6C36A088D + 0.1);
  crate setscriptablepartstate("visibility", "show", 0);
  thread scripts\common\anim::anim_single_solo(crate, crate.animindex);
  wait(animendtime);
  scripts\cp_mp\killstreaks\airdrop::docratedropfromscripted(crate);
}

_id_AD08AC92F283B91E(position) {
  _id_07F9DADF5916FCE9 = position * (1, 1, 0) + (0, 0, scripts\cp_mp\killstreaks\airdrop::getscriptedhelidropheightbase());
  _id_B7E56BAD82BEF358 = _id_07F9DADF5916FCE9 + (0, 0, -30000);
  _id_B50CC6792FA30EFF = scripts\cp_mp\killstreaks\airdrop::getcratedropdestination(_id_07F9DADF5916FCE9, _id_B7E56BAD82BEF358, position);
  _id_B50CC6792FA30EFF = _id_B50CC6792FA30EFF + (0, 0, 1000);
  return _id_B50CC6792FA30EFF;
}

airdrop_multiple_getcratedropcaststart(position) {
  position = position * (1, 1, 0);
  position = position + (0, 0, scripts\cp_mp\killstreaks\airdrop::getscriptedhelidropheightbase() + 200);
  position = position + (0, 0, level.cratedropdata.ac130s.size * 300);
  return position;
}

airdrop_multiple_getdropheight() {
  return level.cratedropdata.ac130height + level.cratedropdata.ac130s.size * level.cratedropdata.ac130heightoffset;
}

airdrop_multiple_addac130tolist(ac130) {
  entnum = ac130 getentitynumber();
  level.cratedropdata.ac130s[entnum] = ac130;
}

airdrop_multiple_removeac130fromlist(entnum) {
  level.cratedropdata.ac130s[entnum] = undefined;
}

_id_6624058BAC19055D(_id_400D80E48322C797) {
  animindex = "heli_multi_rope_1";
  numcrates = _id_400D80E48322C797.size;

  if(numcrates == 2)
    animindex = "heli_multi_rope_2";
  else if(numcrates == 3)
    animindex = "heli_multi_rope_3";

  return animindex;
}

_id_E23EB6D57186432C(index, _id_400D80E48322C797) {
  animindex = "heli_multi_crate_1";
  numcrates = _id_400D80E48322C797.size;

  if(numcrates == 2) {
    switch (index) {
      case 0:
        animindex = "heli_multi_crate_2a";
        break;
      case 1:
        animindex = "heli_multi_crate_2b";
        break;
    }
  } else if(numcrates == 3) {
    switch (index) {
      case 0:
        animindex = "heli_multi_crate_3a";
        break;
      case 1:
        animindex = "heli_multi_crate_3b";
        break;
      case 2:
        animindex = "heli_multi_crate_3c";
        break;
    }
  }

  return animindex;
}