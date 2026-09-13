/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_merits.gsc
***********************************************/

init() {
  precachestring(&"CP_MERIT_COMPLETED");

  if(!mayprocessmerits()) {
    return;
  }
  level.meritcallbacks = [];
  registermeritcallback("enemyKilled", ::mt_kills);
  level thread onplayerconnect();
}

mayprocessmerits() {
  return 0;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", player);

    if(!isDefined(player.pers["postGameMerits"]))
      player.pers["postGameMerits"] = 0;

    player thread initmeritdata();

    if(isai(player)) {
      continue;
    }
    player thread monitoradstime();
  }
}

initmeritdata() {
  self.pers["lastBulletKillTime"] = 0;
  self.pers["bulletStreak"] = 0;
  self.explosiveinfo = [];
}

registermeritcallback(callback, func) {
  if(!isDefined(level.meritcallbacks[callback]))
    level.meritcallbacks[callback] = [];

  level.meritcallbacks[callback][level.meritcallbacks[callback].size] = func;
}

getmeritstatus(name) {
  if(isDefined(self.meritdata[name]))
    return self.meritdata[name];
  else
    return 0;
}

mt_kills(data, time) {
  player = data.attacker;
  victim = data.victim;

  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }
  player processmerit("mt_kills");
}

enemykilled(einflictor, attacker, idamage, smeansofdeath, sweapon, sprimaryweapon, shitloc, modifiers) {
  self endon("disconnect");
  data = spawnStruct();
  data.victim = self;
  data.einflictor = einflictor;
  data.attacker = attacker;
  data.idamage = idamage;
  data.smeansofdeath = smeansofdeath;
  data.sweapon = sweapon;
  data.sprimaryweapon = sprimaryweapon;
  data.shitloc = shitloc;
  data.time = gettime();
  data.modifiers = modifiers;
  data.victimonground = data.victim isonground();
  domeritcallback("enemyKilled", data);
  data.attacker notify("playerKilledMeritsProcessed");
}

domeritcallback(callback, data) {
  if(!mayprocessmerits()) {
    return;
  }
  if(isDefined(data)) {
    player = data.player;

    if(!isDefined(player))
      player = data.attacker;

    if(isDefined(player) && isai(player))
      return;
  }

  if(getdvarint("dvar_0D498F433E251489") > 0) {
    return;
  }
  if(!isDefined(level.meritcallbacks[callback])) {
    return;
  }
  if(isDefined(data)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.meritcallbacks[callback].size; _id_AC0E594AC96AA3A8++)
      thread[[level.meritcallbacks[callback][_id_AC0E594AC96AA3A8]]](data);
  } else {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.meritcallbacks[callback].size; _id_AC0E594AC96AA3A8++)
      thread[[level.meritcallbacks[callback][_id_AC0E594AC96AA3A8]]]();
  }
}

process_agent_on_killed_merits(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration) {
  if(!isDefined(eattacker)) {
    return;
  }
  if(!isPlayer(eattacker)) {
    if(isDefined(eattacker.owner) && isPlayer(eattacker.owner))
      eattacker = eattacker.owner;
    else
      return;
  }

  _id_0DD6BF5F9DBA888C = scripts\cp\utility::getweaponclass(sweapon);
  _id_732C1A4DD3A04513 = istrue(eattacker.inlaststand);
  _id_A3192D2F80ED4FF8 = scripts\engine\utility::isbulletdamage(smeansofdeath);
  stance = eattacker getstance();
  species = self.species;
  _id_D4020A6F1CA2F526 = stance == "crouch";
  _id_30C9316FAB2DDE21 = stance == "prone" && !_id_732C1A4DD3A04513;
  _id_93DDA441E5C43170 = isexplosivedamagemod(smeansofdeath);
  ismelee = smeansofdeath == "MOD_MELEE";
  _id_A299BFE05DFF1299 = (istrue(self.is_burning) || istrue(self.is_chem_burning)) && (!_id_A3192D2F80ED4FF8 || sweapon.basename == "incendiary_ammo_mp");
  _id_989A30D1E639C863 = istrue(self.dismember_crawl);
  _id_DAC3F5ACB59AC043 = istrue(self.shockmelee);
  issliding = eattacker issprintsliding();
  _id_14325BA4DE8139AF = istrue(self.faf_burned_out);

  if(isDefined(einflictor.owner))
    _id_CA9C5794324E530A = eattacker scripts\cp\utility::is_trap(einflictor, sweapon) && einflictor.owner == eattacker;
  else
    _id_CA9C5794324E530A = eattacker scripts\cp\utility::is_trap(einflictor, sweapon);

  _id_8DC6916F38C01584 = 0;

  if(isDefined(level.all_magic_weapons)) {
    foreach(weapon in getarraykeys(level.all_magic_weapons)) {
      if(scripts\cp\utility::getrawbaseweaponname(sweapon) == weapon) {
        _id_8DC6916F38C01584 = 1;
        break;
      }
    }
  }

  isworweapon = isDefined(sweapon) && (sweapon.basename == "iw7_dischorddummy_zm" || sweapon.basename == "iw7_facemelterdummy_zm" || sweapon.basename == "iw7_headcutterdummy_zm" || sweapon.basename == "iw7_shredderdummy_zm");
  _id_5FD80A11F88EDCE0 = undefined;

  if(isDefined(sweapon))
    _id_5FD80A11F88EDCE0 = scripts\cp\utility::getrawbaseweaponname(sweapon);

  _id_BFE7EFC478E5CE70 = isDefined(_id_5FD80A11F88EDCE0) && (_id_5FD80A11F88EDCE0 == "harpoon1" || _id_5FD80A11F88EDCE0 == "harpoon2" || _id_5FD80A11F88EDCE0 == "harpoon3" || _id_5FD80A11F88EDCE0 == "harpoon4");

  if(_id_8DC6916F38C01584) {
    if(issubstr(sweapon.basename, "g18_"))
      _id_8DC6916F38C01584 = isDefined(eattacker.has_replaced_starting_pistol);
  }

  if(_id_93DDA441E5C43170) {
    if(issubstr(sweapon.basename, "shuriken"))
      _id_93DDA441E5C43170 = 0;
    else if(istrue(eattacker.kung_fu_mode))
      _id_93DDA441E5C43170 = 0;
  }

  _id_1C2F77BAF47FDC46 = sweapon.classname == "weapon_sniper" && _id_A3192D2F80ED4FF8;
  headshot = _id_A3192D2F80ED4FF8 && scripts\cp\utility::isheadshot(sweapon, shitloc, smeansofdeath, eattacker);

  if(!ismelee) {
    switch (_id_0DD6BF5F9DBA888C) {
      case "weapon_battle":
      case "weapon_assault":
        eattacker processmerit("mt_ar_kills");
        break;
      case "weapon_smg":
        eattacker processmerit("mt_smg_kills");
        break;
      case "weapon_lmg":
        eattacker processmerit("mt_lmg_kills");
        break;
      case "weapon_shotgun":
        eattacker processmerit("mt_shotgun_kills");
        break;
      case "weapon_sniper":
      case "weapon_dmr":
        eattacker processmerit("mt_sniper_kills");
        break;
      case "weapon_pistol":
        eattacker processmerit("mt_pistol_kills");
        break;
      case "other":
        if(isworweapon)
          eattacker processmerit("mt_pistol_kills");

        break;
      default:
        break;
    }
  }

  if(_id_93DDA441E5C43170)
    eattacker processmerit("mt_explosive_kills");

  if(ismelee)
    eattacker processmerit("mt_melee_kills");

  if(_id_A299BFE05DFF1299)
    eattacker processmerit("mt_fire_kills");

  if(_id_CA9C5794324E530A)
    eattacker processmerit("mt_trap_kills");

  if(_id_8DC6916F38C01584)
    eattacker processmerit("mt_magic_weapon_kills");

  if(headshot)
    eattacker processmerit("mt_headshot_kills");

  if(_id_989A30D1E639C863)
    eattacker processmerit("mt_crawler_kills");

  if(_id_DAC3F5ACB59AC043)
    eattacker processmerit("mt_faf_shock_melee_kills");

  if(issliding)
    eattacker processmerit("mt_sliding_kills");

  if(isworweapon || _id_BFE7EFC478E5CE70)
    eattacker processmerit("mt_quest_weapon_kills");

  if(_id_14325BA4DE8139AF && _id_A299BFE05DFF1299)
    eattacker processmerit("mt_faf_burned_out_kills");

  _id_1CDDE5644733A935 = sweapon.basename;

  if(getDvar("ui_mapname") == "cp_rave") {
    if(isDefined(self.agent_type) && self.agent_type == "zombie_sasquatch")
      eattacker processmerit("mt_dlc1_sasquatch_kills");

    if(ismelee) {
      if(_id_1CDDE5644733A935 == "iw7_golf_club_mp" || _id_1CDDE5644733A935 == "iw7_golf_club_mp_pap1" || _id_1CDDE5644733A935 == "iw7_golf_club_mp_pap2")
        eattacker processmerit("mt_dlc1_golf_kills");
      else if(_id_1CDDE5644733A935 == "iw7_spiked_bat_mp" || _id_1CDDE5644733A935 == "iw7_spiked_bat_mp_pap1" || _id_1CDDE5644733A935 == "iw7_spiked_bat_mp_pap2")
        eattacker processmerit("mt_dlc1_bat_kills");
      else if(_id_1CDDE5644733A935 == "iw7_machete_mp" || _id_1CDDE5644733A935 == "iw7_machete_mp_pap1" || _id_1CDDE5644733A935 == "iw7_machete_mp_pap2")
        eattacker processmerit("mt_dlc1_machete_kills");
      else if(_id_1CDDE5644733A935 == "iw7_two_headed_axe_mp" || _id_1CDDE5644733A935 == "iw7_two_headed_axe_mp_pap1" || _id_1CDDE5644733A935 == "iw7_two_headed_axe_mp_pap2")
        eattacker processmerit("mt_dlc1_axe_kills");
      else if(_id_1CDDE5644733A935 == "iw7_lawnmower_zm")
        eattacker processmerit("mt_dlc1_lawnmower_kills");
    }

    if(issubstr(_id_1CDDE5644733A935, "harpoon"))
      eattacker processmerit("mt_dlc1_harpoon_kills");

    if(istrue(eattacker.rave_mode))
      eattacker processmerit("mt_dlc1_kills_in_rave");
  }

  if(getDvar("ui_mapname") == "cp_disco") {
    if(_id_1CDDE5644733A935 == "iw7_katana_zm_pap2+camo222" || _id_1CDDE5644733A935 == "iw7_katana_windforce_zm")
      eattacker processmerit("mt_dlc2_pap2_katana");
    else if(_id_1CDDE5644733A935 == "iw7_nunchucks_zm_pap2+camo222")
      eattacker processmerit("mt_dlc2_pap2_nunchucks");
    else if(_id_1CDDE5644733A935 == "heart_cp")
      eattacker processmerit("mt_dlc2_heart_kills");

    if(isDefined(self.agent_type) && self.agent_type == "skater")
      eattacker processmerit("mt_dlc2_roller_skaters");

    if(_id_CA9C5794324E530A)
      eattacker processmerit("mt_dlc2_trap_kills");
    else if(istrue(eattacker.kung_fu_mode) && !is_crafted_trap_damage(_id_1CDDE5644733A935)) {
      if(eattacker.kungfu_style == "dragon")
        eattacker processmerit("mt_dlc2_dragon_kills");
      else if(eattacker.kungfu_style == "crane")
        eattacker processmerit("mt_dlc2_crane_kills");
      else if(eattacker.kungfu_style == "snake")
        eattacker processmerit("mt_dlc2_snake_kills");
      else if(eattacker.kungfu_style == "tiger")
        eattacker processmerit("mt_dlc2_tiger_kills");
    }
  }
}

is_crafted_trap_damage(sweapon) {
  if(!isDefined(sweapon))
    return 0;

  switch (sweapon) {
    case "alien_sentry_minigun_4_mp":
    case "iw7_robotzap_zm":
    case "zmb_robotprojectile_mp":
    case "incendiary_ammo_mp":
    case "iw7_electrictrap_zm":
      return 1;
  }

  return 0;
}

processmerit(basename, _id_5547E31D3C38B912, _id_D1DE6D2762880AA3) {
  if(!mayprocessmerits()) {
    return;
  }
  if(!isPlayer(self) || isai(self)) {
    return;
  }
  if(!isDefined(_id_5547E31D3C38B912))
    _id_5547E31D3C38B912 = 1;

  if(!havedataformerit(basename)) {
    return;
  }
  _id_9E1A0DB47D02FD80 = getmeritstatus(basename);

  if(_id_9E1A0DB47D02FD80 == 5) {
    return;
  }
  _id_B9654B45CF962022 = isDefined(level.meritinfo[basename]["operation"]);

  if(_id_9E1A0DB47D02FD80 > level.meritinfo[basename]["targetval"].size) {
    _id_855AD017459D2163 = _id_9E1A0DB47D02FD80 == level.meritinfo[basename]["targetval"].size + 1;
    _id_525FBD5628B3CDFC = isDefined(self.operationsmaxed) && isDefined(self.operationsmaxed[basename]);

    if(_id_855AD017459D2163 && !_id_525FBD5628B3CDFC)
      _id_9E1A0DB47D02FD80 = level.meritinfo[basename]["targetval"].size;
    else
      return;
  }

  _id_4335B4D453C6E781 = scripts\cp\cp_hud_util::mt_getprogress(basename);
  _id_51C6029A1DECEECF = level.meritinfo[basename]["targetval"][_id_9E1A0DB47D02FD80];

  if(!isDefined(_id_51C6029A1DECEECF)) {
    return;
  }
  if(isDefined(_id_D1DE6D2762880AA3) && _id_D1DE6D2762880AA3)
    _id_BFBD5393EF742E6E = _id_5547E31D3C38B912;
  else
    _id_BFBD5393EF742E6E = _id_4335B4D453C6E781 + _id_5547E31D3C38B912;

  _id_9A878A363B637930 = 0;

  if(_id_BFBD5393EF742E6E >= _id_51C6029A1DECEECF) {
    _id_D3249E7C7B32F8A5 = 1;
    _id_9A878A363B637930 = _id_BFBD5393EF742E6E - _id_51C6029A1DECEECF;
    _id_BFBD5393EF742E6E = _id_51C6029A1DECEECF;
  } else
    _id_D3249E7C7B32F8A5 = 0;

  if(_id_4335B4D453C6E781 < _id_BFBD5393EF742E6E)
    scripts\cp\cp_hud_util::mt_setprogress(basename, _id_BFBD5393EF742E6E);

  if(_id_D3249E7C7B32F8A5) {
    thread giverankxpafterwait(basename, _id_9E1A0DB47D02FD80);
    storecompletedmerit(basename);
    givemeritscore(level.meritinfo[basename]["score"][_id_9E1A0DB47D02FD80]);
    _id_9E1A0DB47D02FD80++;
    scripts\cp\cp_hud_util::mt_setstate(basename, _id_9E1A0DB47D02FD80);
    self.meritdata[basename] = _id_9E1A0DB47D02FD80;
    thread scripts\cp\cp_hud_message::showchallengesplash(basename);

    if(areallmerittierscomplete(basename))
      processmastermerit(basename);
  }
}

areallmerittierscomplete(_id_FB5397C466F84C61) {
  if(self.meritdata[_id_FB5397C466F84C61] >= level.meritinfo[_id_FB5397C466F84C61]["targetval"].size)
    return 1;

  return 0;
}

get_table_name() {
  return "mp/splashtable.csv";
}

storecompletedmerit(basename) {
  if(!isDefined(self.meritscompleted))
    self.meritscompleted = [];

  _id_4DB060099C213256 = 0;

  foreach(_id_548AD9A06D18EE7E in self.meritscompleted) {
    if(_id_548AD9A06D18EE7E == basename)
      _id_4DB060099C213256 = 1;
  }

  if(!_id_4DB060099C213256)
    self.meritscompleted[self.meritscompleted.size] = basename;
}

storecompletedoperation(basename) {
  if(!isDefined(self.operationscompleted))
    self.operationscompleted = [];

  _id_4DB060099C213256 = 0;

  foreach(_id_548AD9A06D18EE7E in self.operationscompleted) {
    if(_id_548AD9A06D18EE7E == basename) {
      _id_4DB060099C213256 = 1;
      break;
    }
  }

  if(!_id_4DB060099C213256)
    self.operationscompleted[self.operationscompleted.size] = basename;
}

giverankxpafterwait(basename, _id_9E1A0DB47D02FD80) {
  self endon("disconnect");
  wait 0.25;
  scripts\cp\cp_persistence::give_player_xp(int(level.meritinfo[basename]["reward"][_id_9E1A0DB47D02FD80]));
  event = basename;

  if(!_func_D03495FE6418377B(event))
    event = _func_1823FF50BB28148D(event);

  _id_187A04151C40FB72::giverankxp(event, level.meritinfo[basename]["reward"][_id_9E1A0DB47D02FD80], undefined);
}

givemeritscore(score) {
  _id_4BF0ADEE32BC3338 = self getplayerdata("cp", "challengeScore");

  if(isDefined(_id_4BF0ADEE32BC3338))
    self setplayerdata("cp", "challengeScore", _id_4BF0ADEE32BC3338 + score);
}

updatemerits() {
  self.meritdata = [];
  self endon("disconnect");

  if(!mayprocessmerits()) {
    return;
  }
  _id_0C3F135BD4E0369D = 0;

  foreach(_id_6018F069F73D44EF, _id_EDBADD21D896C7F6 in level.meritinfo) {
    _id_0C3F135BD4E0369D++;

    if(_id_0C3F135BD4E0369D % 20 == 0)
      wait 0.05;

    self.meritdata[_id_6018F069F73D44EF] = 0;
    _id_4A7C87E047957CC2 = _id_EDBADD21D896C7F6["index"];
    status = scripts\cp\cp_hud_util::mt_getstate(_id_6018F069F73D44EF);
    self.meritdata[_id_6018F069F73D44EF] = status;
  }
}

getmeritfilter(_id_3F4FBF6DC9B74F9D) {
  return tablelookup("cp/allMeritsTable.csv", 0, _id_3F4FBF6DC9B74F9D, 5);
}

isweaponmerit(_id_3F4FBF6DC9B74F9D) {
  if(!isDefined(_id_3F4FBF6DC9B74F9D))
    return 0;

  _id_2BB98E30B07F3168 = getmeritfilter(_id_3F4FBF6DC9B74F9D);

  if(isDefined(_id_2BB98E30B07F3168))
    return 1;

  return 0;
}

getweaponfrommerit(_id_6018F069F73D44EF) {
  return getmeritfilter(_id_6018F069F73D44EF);
}

isoperationmerit(_id_6018F069F73D44EF) {
  if(!isDefined(_id_6018F069F73D44EF))
    return 0;

  _id_2BB98E30B07F3168 = getmeritfilter(_id_6018F069F73D44EF);

  if(isDefined(_id_2BB98E30B07F3168)) {
    if(_id_2BB98E30B07F3168 == "perk_slot_0" || _id_2BB98E30B07F3168 == "perk_slot_1" || _id_2BB98E30B07F3168 == "perk_slot_2" || _id_2BB98E30B07F3168 == "proficiency" || _id_2BB98E30B07F3168 == "equipment" || _id_2BB98E30B07F3168 == "special_equipment" || _id_2BB98E30B07F3168 == "attachment" || _id_2BB98E30B07F3168 == "prestige" || _id_2BB98E30B07F3168 == "final_killcam" || _id_2BB98E30B07F3168 == "basic" || _id_2BB98E30B07F3168 == "humiliation" || _id_2BB98E30B07F3168 == "precision" || _id_2BB98E30B07F3168 == "revenge" || _id_2BB98E30B07F3168 == "elite" || _id_2BB98E30B07F3168 == "intimidation" || _id_2BB98E30B07F3168 == "operations" || scripts\cp\utility::isstrstart(_id_2BB98E30B07F3168, "killstreaks_"))
      return 1;
  }

  if(isweaponmerit(_id_6018F069F73D44EF))
    return 1;

  return 0;
}

merit_targetval(_id_00CEBA6EC7E8CA50, _id_3BBEDEB9EB59D6A7, _id_F1D895EB26AEBAD0) {
  value = tablelookup(_id_00CEBA6EC7E8CA50, 0, _id_3BBEDEB9EB59D6A7, 10 + _id_F1D895EB26AEBAD0 * 3);
  return int(value);
}

merit_rewardval(_id_00CEBA6EC7E8CA50, _id_3BBEDEB9EB59D6A7, _id_F1D895EB26AEBAD0) {
  value = tablelookup(_id_00CEBA6EC7E8CA50, 0, _id_3BBEDEB9EB59D6A7, 11 + _id_F1D895EB26AEBAD0 * 3);
  return int(value);
}

merit_scoreval(_id_00CEBA6EC7E8CA50, _id_3BBEDEB9EB59D6A7, _id_F1D895EB26AEBAD0) {
  value = tablelookup(_id_00CEBA6EC7E8CA50, 0, _id_3BBEDEB9EB59D6A7, 12 + _id_F1D895EB26AEBAD0 * 3);
  return int(value);
}

buildmerittableinfo(_id_00CEBA6EC7E8CA50, typeid) {
  index = 0;
  _id_94CABB8B012F1DD6 = 0;
  index = 0;

  for(;;) {
    _id_3BBEDEB9EB59D6A7 = tablelookupbyrow(_id_00CEBA6EC7E8CA50, index, 0);

    if(_id_3BBEDEB9EB59D6A7 == "") {
      break;
    }

    _id_BD6BA653DD06FE4C = getmeritmasterchallenge(_id_3BBEDEB9EB59D6A7);
    level.meritinfo[_id_3BBEDEB9EB59D6A7] = [];
    level.meritinfo[_id_3BBEDEB9EB59D6A7]["index"] = index;
    level.meritinfo[_id_3BBEDEB9EB59D6A7]["type"] = typeid;
    level.meritinfo[_id_3BBEDEB9EB59D6A7]["targetval"] = [];
    level.meritinfo[_id_3BBEDEB9EB59D6A7]["reward"] = [];
    level.meritinfo[_id_3BBEDEB9EB59D6A7]["score"] = [];
    level.meritinfo[_id_3BBEDEB9EB59D6A7]["filter"] = getmeritfilter(_id_3BBEDEB9EB59D6A7);
    level.meritinfo[_id_3BBEDEB9EB59D6A7]["master"] = _id_BD6BA653DD06FE4C;

    if(isoperationmerit(_id_3BBEDEB9EB59D6A7)) {
      level.meritinfo[_id_3BBEDEB9EB59D6A7]["operation"] = 1;
      level.meritinfo[_id_3BBEDEB9EB59D6A7]["spReward"] = [];

      if(isweaponmerit(_id_3BBEDEB9EB59D6A7)) {
        baseweapon = getweaponfrommerit(_id_3BBEDEB9EB59D6A7);

        if(isDefined(baseweapon))
          level.meritinfo[_id_3BBEDEB9EB59D6A7]["weapon"] = baseweapon;
      }
    }

    for(_id_F1D895EB26AEBAD0 = 0; _id_F1D895EB26AEBAD0 < 5; _id_F1D895EB26AEBAD0++) {
      _id_C07A849575999F9B = merit_targetval(_id_00CEBA6EC7E8CA50, _id_3BBEDEB9EB59D6A7, _id_F1D895EB26AEBAD0);
      _id_AEFB40E0F9DEC515 = merit_rewardval(_id_00CEBA6EC7E8CA50, _id_3BBEDEB9EB59D6A7, _id_F1D895EB26AEBAD0);
      _id_D41181A1A3329128 = merit_scoreval(_id_00CEBA6EC7E8CA50, _id_3BBEDEB9EB59D6A7, _id_F1D895EB26AEBAD0);

      if(_id_C07A849575999F9B == 0) {
        break;
      }

      level.meritinfo[_id_3BBEDEB9EB59D6A7]["targetval"][_id_F1D895EB26AEBAD0] = _id_C07A849575999F9B;
      level.meritinfo[_id_3BBEDEB9EB59D6A7]["reward"][_id_F1D895EB26AEBAD0] = _id_AEFB40E0F9DEC515;
      level.meritinfo[_id_3BBEDEB9EB59D6A7]["score"][_id_F1D895EB26AEBAD0] = _id_D41181A1A3329128;
      _id_94CABB8B012F1DD6 = _id_94CABB8B012F1DD6 + _id_AEFB40E0F9DEC515;
    }

    _id_3BBEDEB9EB59D6A7 = tablelookupbyrow(_id_00CEBA6EC7E8CA50, index, 0);
    index++;
  }

  return int(_id_94CABB8B012F1DD6);
}

buildmeritinfo() {
  level.meritinfo = [];
  _id_94CABB8B012F1DD6 = 0;
  _id_94CABB8B012F1DD6 = _id_94CABB8B012F1DD6 + buildmerittableinfo("cp/allMeritsTable.csv", 0);
}

ismeritunlocked(_id_3F4FBF6DC9B74F9D) {
  _id_18176E8F61BB2E83 = level.meritinfo[_id_3F4FBF6DC9B74F9D]["filter"];

  if(!isDefined(_id_18176E8F61BB2E83))
    return 1;

  return self isitemunlocked(_id_18176E8F61BB2E83, "challenge");
}

havedataformerit(_id_3F4FBF6DC9B74F9D) {
  return isDefined(level.meritinfo) && isDefined(level.meritinfo[_id_3F4FBF6DC9B74F9D]);
}

getmeritmasterchallenge(_id_33BE63BF54F72FA9) {
  value = tablelookup("cp/allMeritsTable.csv", 0, _id_33BE63BF54F72FA9, 7);

  if(isDefined(value) && value == "")
    return undefined;

  return value;
}

processmastermerit(_id_AB501F397D3CD312) {
  _id_2BB10804512BF4D1 = level.meritinfo[_id_AB501F397D3CD312]["master"];

  if(isDefined(_id_2BB10804512BF4D1))
    thread processmerit(_id_2BB10804512BF4D1);
}

monitoradstime() {
  self endon("disconnect");
  self.adstime = 0.0;

  for(;;) {
    if(self playerads() == 1)
      self.adstime = self.adstime + 0.05;
    else
      self.adstime = 0.0;

    wait 0.05;
  }
}