/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\gunship.gsc
*************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gunship", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("gunship", "init")]]();

  level thread _id_7AB42D42F465952F();
  level _id_8E8513A8B071336C();
  level _id_77E6149EF483D24A();
  level _id_B0280EE1765554D1();
  level init_gunship_vo();
  level _id_6FCB27D917EF709B();
  level _id_EA9E0F077F0D655C();
  thread _id_FFF560B330FD842D();
}

weapongivengunship(streakinfo) {
  return 1;
}

_id_7AB42D42F465952F() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("onStartGameTypeFinished");

  if(isDefined(level.mapcenter))
    level._id_3065D0B3D892E79F = level.mapcenter;
  else
    level._id_3065D0B3D892E79F = (0, 0, 0);
}

_id_8E8513A8B071336C() {
  level.gunship_speed["move"] = 250;
  level.gunship_speed["rotate"] = 120;
  level._id_89D6F5464D64EBF4 = makeweapon("ks_remote_gunship_mp");
  level.physicssphereradius["gunship_25mm_mp"] = 60;
  level.physicssphereradius["gunship_40mm_mp"] = 600;
  level.physicssphereradius["gunship_hellfire_mp"] = 1000;
  level.physicssphereforce["gunship_25mm_mp"] = 0;
  level.physicssphereforce["gunship_40mm_mp"] = 3.0;
  level.physicssphereforce["gunship_hellfire_mp"] = 6.0;
  level.weaponreloadtime["gunship_25mm_mp"] = 2;
  level.weaponreloadtime["gunship_40mm_mp"] = 4;
  level.weaponreloadtime["gunship_hellfire_mp"] = 6;
  level._id_1217E6483E1A18A0 = [];
  level._id_241720CF8C74DDDE = getdvarint("dvar_55B253D027368418", 1);
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("gunship", "on", 9);
}

_id_77E6149EF483D24A() {
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("gunshipIntro", ["allow_jump", "usability", "killstreaks", "supers", "gesture", "fire", "weapon_switch", "allow_movement", "offhand_weapons", "shellshock"]);
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("gunshipUse", ["usability", "killstreaks", "supers", "gesture", "weapon_switch", "allow_movement", "shellshock"]);
}

#using_animtree("script_model");

_id_B0280EE1765554D1() {
  level.scr_animtree["gunship"] = #animtree;
  animindex = "intro_gunship";
  level.scr_anim["gunship"][animindex] = % mp_acharlie130_intro;
  level.scr_animname["gunship"][animindex] = "mp_acharlie130_intro";
  animindex = "intro_gunship_exterior";
  level.scr_anim["gunship"][animindex] = % iw9_mp_acharlie130_intro;
  level.scr_animname["gunship"][animindex] = "iw9_mp_acharlie130_intro";
  animindex = "intro_gunner";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_player_intro;
  level.scr_animname["gunship"][animindex] = "vm_ks_gunship_player_intro";
  animindex = "intro_co_gunner";
  level.scr_anim["gunship"][animindex] = % wm_ks_gunship_pilot2_intro;
  level.scr_animname["gunship"][animindex] = "wm_ks_gunship_pilot2_intro";
  animindex = "intro_desk";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_desk_intro;
  level.scr_animname["gunship"][animindex] = "vm_ks_gunship_desk_intro";
  animindex = "intro_clipboard_1";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_clipboard1_intro;
  level.scr_animname["gunship"][animindex] = "vm_ks_gunship_clipboard1_intro";
  animindex = "intro_clipboard_2";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_clipboard2_intro;
  level.scr_animname["gunship"][animindex] = "vm_ks_gunship_clipboard2_intro";
  animindex = "intro_paper";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_paper1_intro;
  level.scr_animname["gunship"][animindex] = "vm_ks_gunship_paper1_intro";
  animindex = "intro_pen_1";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_pen1_intro;
  level.scr_animname["gunship"][animindex] = "vm_ks_gunship_pen1_intro";
  animindex = "intro_pen_2";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_pen2_intro;
  level.scr_animname["gunship"][animindex] = "vm_ks_gunship_pen2_intro";
  animindex = "intro_smartphone";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_smartphone1_intro;
  level.scr_animname["gunship"][animindex] = "vm_ks_gunship_smartphone1_intro";
  animindex = "intro_tablet";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_tablet1_intro;
  level.scr_animname["gunship"][animindex] = "vm_ks_gunship_tablet1_intro";
  animindex = "intro_binder";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_binder_intro;
  level.scr_animname["gunship"][animindex] = "vm_ks_gunship_binder_intro";
  animindex = "intro_joystick";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_joystick_intro;
  level.scr_animname["gunship"][animindex] = "vm_ks_gunship_joystick_intro";
  animindex = "outro_gunner";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_player_outro;
  level.scr_animname["gunship"][animindex] = "vm_ks_gunship_player_outro";
  animindex = "outro_co_gunner";
  level.scr_anim["gunship"][animindex] = % wm_ks_gunship_pilot2_outro;
  level.scr_animname["gunship"][animindex] = "wm_ks_gunship_pilot2_outro";
  animindex = "outro_desk";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_desk_outro;
  level.scr_animname["gunship"][animindex] = "vm_ks_gunship_desk_outro";
  animindex = "outro_clipboard_1";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_clipboard1_outro;
  level.scr_animname["gunship"][animindex] = "vm_ks_gunship_clipboard1_outro";
  animindex = "outro_clipboard_2";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_clipboard2_outro;
  level.scr_animname["gunship"][animindex] = "vm_ks_gunship_clipboard2_outro";
  animindex = "outro_paper";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_paper1_outro;
  level.scr_animname["gunship"][animindex] = "vm_ks_gunship_paper1_outro";
  animindex = "outro_pen_1";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_pen1_outro;
  level.scr_animname["gunship"][animindex] = "vm_ks_gunship_pen1_outro";
  animindex = "outro_pen_2";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_pen2_outro;
  level.scr_animname["gunship"][animindex] = "vm_ks_gunship_pen2_outro";
  animindex = "outro_smartphone";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_smartphone1_outro;
  level.scr_animname["gunship"][animindex] = "vm_ks_gunship_smartphone1_outro";
  animindex = "outro_tablet";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_tablet1_outro;
  level.scr_animname["gunship"][animindex] = "vm_ks_gunship_tablet1_outro";
  animindex = "outro_binder";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_binder_outro;
  level.scr_animname["gunship"][animindex] = "vm_ks_gunship_binder_outro";
  animindex = "outro_joystick";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_joystick_outro;
  level.scr_animname["gunship"][animindex] = "vm_ks_gunship_joystick_outro";
  animindex = "outro_gunship_death";
  level.scr_anim["gunship"][animindex] = % mp_acharlie130_death;
  level.scr_animname["gunship"][animindex] = "mp_acharlie130_death";

  foreach(animindex, scr_anim in level.scr_anim["gunship"])
  level._id_539E9DC23256F26D["gunship"][animindex] = scripts\common\anim::_id_52351C3338DA63F4("gunship", animindex);

  level._id_9C7D2F4C2FC66B1F = [];
  level._id_9C7D2F4C2FC66B1F["gunship_exterior"] = "veh9_mil_air_gunship";
  level._id_9C7D2F4C2FC66B1F["gunner"] = "body_sp_ally_sensor_operator_vm_1_1_noface";
  level._id_9C7D2F4C2FC66B1F["co_gunner"] = "fullbody_sp_ally_sensor_operator_wm_1_1";
  level._id_9C7D2F4C2FC66B1F["desk"] = "misc_gunship_interior_desk";
  level._id_9C7D2F4C2FC66B1F["clipboard_1"] = "misc_un_office_clipboard_01";
  level._id_9C7D2F4C2FC66B1F["clipboard_2"] = "misc_un_office_clipboard_01";
  level._id_9C7D2F4C2FC66B1F["paper"] = "misc_un_office_paper_01";
  level._id_9C7D2F4C2FC66B1F["pen_1"] = "misc_un_office_pen_01";
  level._id_9C7D2F4C2FC66B1F["pen_2"] = "misc_un_office_pen_01";
  level._id_9C7D2F4C2FC66B1F["smartphone"] = "offhand1h_smartphone_static_v0";
  level._id_9C7D2F4C2FC66B1F["tablet"] = "offhand2h_tablet_static_v0";
  level._id_9C7D2F4C2FC66B1F["binder"] = "misc_un_office_binder_open";
  level._id_9C7D2F4C2FC66B1F["joystick"] = "misc_gunship_interior_joystick";
  level._id_FAF1ABA229E3E2A9 = getdvarint("dvar_0A59A7DA9FA17C00", 0);
}

init_gunship_vo() {
  game["dialog"]["gunship_use"] = "killstreak_remote_operator_request_response";
  game["dialog"]["gunship_leave"] = "killstreak_remote_operator_leave";
  game["dialog"]["gunship_engage"] = "killstreak_remote_operator_engage";
  game["dialog"]["gunship_random_radio"] = "killstreak_remote_operator_radio_chatter";
  game["dialog"]["gunship_flares"] = "killstreak_remote_operator_flare_release";
  game["dialog"]["gunship_light_damage"] = "killstreak_remote_operator_light_damage";
  game["dialog"]["gunship_med_damage"] = "killstreak_remote_operator_med_damage";
  game["dialog"]["gunship_heavy_damage"] = "killstreak_remote_operator_heavy_damage";
  game["dialog"]["gunship_lockedon"] = "killstreak_remote_operator_missile_lock_warning";
  game["dialog"]["gunship_crash"] = "killstreak_remote_operator_crash";
  game["dialog"]["gunship_hit_target"] = "killstreak_remote_operator_hit_target";
  game["dialog"]["gunship_miss_target"] = "killstreak_remote_operator_miss_target";
  game["dialog"]["gunship_spotted_single_target"] = "killstreak_remote_operator_target_spotted_single";
  game["dialog"]["gunship_spotted_multi_target"] = "killstreak_remote_operator_miss_target";
  game["dialog"]["gunship_hellfire_reload"] = "killstreak_remote_operator_hellfire_reload";
  game["dialog"]["gunship_40mm_reload"] = "killstreak_remote_operator_40mm_reload";
  game["dialog"]["gunship_25mm_reload"] = "killstreak_remote_operator_25mm_reload";
}

_id_6FCB27D917EF709B() {
  level._effect["clouds"] = loadfx("vfx/iw8_mp/killstreak/vfx_ac130_view_clouds.vfx");
  level._effect["gunship_flares"] = loadfx("vfx/iw8_mp/killstreak/vfx_ac130_flares.vfx");
  level._effect["camera_spotlight"] = loadfx("vfx/iw8_mp/killstreak/vfx_ac130_ir_spotlight.vfx");
}

_id_EA9E0F077F0D655C() {
  scripts\cp_mp\utility\killstreak_utility::_id_C0B0A582FF9E4D57("gunship_color_mp");
  scripts\cp_mp\utility\killstreak_utility::_id_C0B0A582FF9E4D57("gunship_color_fog_mp");
  scripts\cp_mp\utility\killstreak_utility::_id_C0B0A582FF9E4D57("gunship_hellfire_crt", 0.1, 0.2, 0.5);
  scripts\cp_mp\utility\killstreak_utility::_id_C0B0A582FF9E4D57("gunship_40mm_crt", 0.1, 0.1, 0.3);
  scripts\cp_mp\utility\killstreak_utility::_id_C0B0A582FF9E4D57("gunship_25mm_crt", 0.1, 0.1, 0.2);
}

tryusegunship() {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("gunship", self);
  return tryusegunshipfromstruct(streakinfo);
}

tryusegunshipfromstruct(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo))
      return 0;
  }

  _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(streakinfo, ::weapongivengunship);

  if(!istrue(_id_9B1DEB5E9D32BBE3))
    return 0;

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      streakinfo notify("killstreak_finished_with_deploy_weapon");
      return 0;
    }
  }

  if(level.gameended) {
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  result = gunship_startuse(self, streakinfo);

  if(!istrue(result)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");

    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  return result;
}

gunship_monitormanualplayerexit(owner) {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  owner endon("disconnect");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "allowRideKillstreakPlayerExit"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "allowRideKillstreakPlayerExit")]]();

  self waittill("killstreakExit");
  thread gunship_leave(owner);
}

gunship_startuse(player, streakinfo) {
  level endon("game_ended");
  _id_51C1B45046E1647C = level._id_3065D0B3D892E79F;

  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    if(level.gametype == "arm" || level.gametype == "conflict" || level.gametype == "gwtdm") {
      if(isDefined(level.hqmidpoint))
        _id_51C1B45046E1647C = level.hqmidpoint;
      else if(isDefined(level.gunship_origin_override))
        _id_51C1B45046E1647C = level.gunship_origin_override;
    } else
      _id_51C1B45046E1647C = player.origin;
  }

  _id_2136B63785EE0579 = _id_25233A050A5E41F0(player, _id_51C1B45046E1647C);

  if(!isDefined(_id_2136B63785EE0579))
    return 0;

  _id_8945C22A67231E20 = randomint(360);
  _id_0234183E65CC4B94 = 9000;

  if(issubstr(level.mapname, "mp_grandprix"))
    _id_0234183E65CC4B94 = 10000;

  xoffset = cos(_id_8945C22A67231E20) * _id_0234183E65CC4B94;
  yoffset = sin(_id_8945C22A67231E20) * _id_0234183E65CC4B94;
  zoffset = 8000;

  if(issubstr(level.mapname, "mp_grandprix"))
    zoffset = zoffset + 2000;

  if(issubstr(level.mapname, "mp_catedral"))
    zoffset = zoffset + 6000;

  _id_78AC3C5EF5263D4F = vectorNormalize((xoffset, yoffset, zoffset));
  _id_78AC3C5EF5263D4F = _id_78AC3C5EF5263D4F * zoffset;
  level.gunshipinuse = 1;

  if(scripts\common\utility::iscp())
    player.start_position = player.origin;

  _id_744FF9937DEC4EA7 = gunship_playintro(player, streakinfo, _id_8945C22A67231E20, _id_78AC3C5EF5263D4F, _id_2136B63785EE0579);

  if(!isDefined(_id_744FF9937DEC4EA7)) {
    level.gunshipinuse = 0;
    return 0;
  }

  gunship = gunship_spawn(player, streakinfo, _id_8945C22A67231E20, _id_78AC3C5EF5263D4F, _id_744FF9937DEC4EA7, _id_2136B63785EE0579);

  if(!isDefined(gunship)) {
    level.gunshipinuse = 0;
    return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash"))
    thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_gunship", player);

  if(getdvarint("camera_thirdPerson")) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "setThirdPersonDOF"))
      player[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "setThirdPersonDOF")]](0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList"))
    gunship[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](gunship.streakinfo.streakname, "Killstreak_Air", player);

  scripts\cp_mp\utility\weapon_utility::setlockedoncallback(gunship, ::gunship_lockedoncallback);
  scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback(gunship, ::gunship_lockedonremovedcallback);
  gunship thread gunship_attachgunner(player);

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    gunship thread _id_9516490C44814B4C(player);
  else
    gunship thread gunship_watchchangeweapons(player);

  gunship thread gunship_watchweaponfired(player);
  gunship thread gunship_watchthermaltoggle(player);
  gunship thread gunship_watchdamage(player);
  gunship thread gunship_watchtimeout(player);
  gunship thread gunship_watchgameend(player);
  gunship thread _id_AAFC33D685563AA4(player);
  gunship thread _id_5FBD9704078207AD(player);
  gunship thread gunship_watchownerexitaction(player, "disconnect");
  gunship thread gunship_watchownerexitaction(player, "joined_team");
  gunship thread gunship_watchownerexitaction(player, "joined_spectators");
  gunship thread gunship_watchownerexitaction(player, "team_kill_punish");
  gunship thread gunship_watchownerexitaction(player, "player_fatal_death");
  gunship thread gunship_watchendgame(player);
  gunship thread gunship_playpilotfx(player);
  gunship thread gunship_linklightfxent();
  gunship thread gunship_linkwingfxents();
  gunship thread gunship_monitormanualplayerexit(player);
  gunship thread gunship_trackvelocity(player);
  gunship thread gunship_watchtargets(player);
  gunship thread _id_39464052869B655D(player);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "handleIncomingStinger"))
    gunship thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "handleIncomingStinger")]](::gunship_handlemissiledetection);

  gunship playLoopSound("iw8_ks_ac130_lp");
  return 1;
}

_id_25233A050A5E41F0(owner, _id_51C1B45046E1647C) {
  _id_12A4204B9C132493 = undefined;

  if(!scripts\cp_mp\utility\game_utility::islargemap()) {
    if(level._id_1217E6483E1A18A0.size > 0)
      _id_12A4204B9C132493 = level._id_1217E6483E1A18A0[0];
  } else if(isDefined(level._id_1217E6483E1A18A0) && level._id_1217E6483E1A18A0.size >= 1)
    return undefined;

  if(!isDefined(_id_12A4204B9C132493)) {
    _id_12A4204B9C132493 = spawn("script_model", _id_51C1B45046E1647C);
    _id_12A4204B9C132493 setModel("tag_origin");
    _id_12A4204B9C132493.angles = (0, 115, 0);
    _id_12A4204B9C132493 hide();
    level._id_1217E6483E1A18A0[level._id_1217E6483E1A18A0.size] = _id_12A4204B9C132493;
    _id_12A4204B9C132493 thread _id_CBBAA3B3A43FA6B3();

    if(!scripts\cp_mp\utility\game_utility::islargemap())
      _id_12A4204B9C132493 thread _id_486B043F227FCA86();
  }

  return _id_12A4204B9C132493;
}

gunship_lockedoncallback() {
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship", "gunship_lockedon", 1, undefined, "pilot");
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("missileLocking", self.owner, "killstreak");
}

gunship_lockedonremovedcallback() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("missileLocking", self.owner, "killstreak");
}

gunship_playintro(player, streakinfo, angle, _id_DE9C77C124D1FFAB, _id_2136B63785EE0579) {
  player endon("disconnect");
  level endon("game_ended");
  _id_C8823E8C933EF356 = 0;
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  player disablephysicaldepthoffieldscripting();
  player gunship_allowstances(0);

  if(!_id_C8823E8C933EF356) {
    player scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    player _id_3B64EB40368C1450::_id_3633B947164BE4F3("gunshipIntro", 0);
  }

  _id_744FF9937DEC4EA7 = undefined;

  if(level._id_FAF1ABA229E3E2A9 == 1) {
    _id_0E4739DB3B860EF4 = "intro_gunship";
    _id_258B660F7DB9ABA6 = scripts\common\anim::_id_52351C3338DA63F4("gunship", _id_0E4739DB3B860EF4);
    _id_744FF9937DEC4EA7 = spawn("script_model", _id_2136B63785EE0579.origin);
    _id_744FF9937DEC4EA7 setModel("veh9_mil_air_gunship");
    _id_744FF9937DEC4EA7.angles = _id_2136B63785EE0579.angles;
    _id_744FF9937DEC4EA7 setotherent(player);
    _id_744FF9937DEC4EA7.animname = streakinfo.streakname;
    _id_744FF9937DEC4EA7.owner = player;

    if(!_id_C8823E8C933EF356) {
      foreach(_id_6C3D15091EFA3C48 in level.players) {
        if(_id_6C3D15091EFA3C48 != player)
          _id_744FF9937DEC4EA7 hidefromplayer(_id_6C3D15091EFA3C48);
      }

      _id_744FF9937DEC4EA7 thread gunship_hideintromodelonplayerconnect(player);
    }

    heightoffset = 2000;

    switch (level.mapname) {
      case "mp_cave":
      case "mp_cave_am":
        heightoffset = 500;
        break;
    }

    _id_744FF9937DEC4EA7 linkTo(_id_2136B63785EE0579, "tag_origin", _id_DE9C77C124D1FFAB - (0, 0, heightoffset), (0, angle + 90, 0));
    _id_744FF9937DEC4EA7 thread gunship_watchintrodisown("disconnect", streakinfo);
    _id_744FF9937DEC4EA7 thread gunship_watchintrodisown("joined_team", streakinfo);
    _id_744FF9937DEC4EA7 thread gunship_watchintrodisown("joined_spectators", streakinfo);
    _id_744FF9937DEC4EA7 thread gunship_watchintrodisown("player_fatal_death", streakinfo);
    waitframe();

    if(!isDefined(_id_744FF9937DEC4EA7))
      return undefined;

    _id_744FF9937DEC4EA7 scripts\common\anim::setanimtree();
    _id_744FF9937DEC4EA7._id_BA27AAC5A0F799E0 = spawn("script_model", _id_744FF9937DEC4EA7.origin);
    _id_744FF9937DEC4EA7._id_BA27AAC5A0F799E0.angles = _id_744FF9937DEC4EA7.angles;
    _id_744FF9937DEC4EA7._id_BA27AAC5A0F799E0 setModel("tag_origin");
    _id_744FF9937DEC4EA7 playsoundtoplayer("iw9_ks_ac130_intro", player);

    if(!_id_C8823E8C933EF356) {
      player cameralinkTo(_id_744FF9937DEC4EA7, "tag_player", 0, 1);
      player painvisionoff();
      player scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
      _id_744FF9937DEC4EA7 setscriptablepartstate("clouds_intro", "old", 0);
      _id_744FF9937DEC4EA7 setscriptablepartstate("bodyFX_intro", "on", 0);
      _id_744FF9937DEC4EA7 thread gunship_startintroshake(_id_258B660F7DB9ABA6, player);
      _id_744FF9937DEC4EA7 thread gunship_queuecamerazoom(_id_258B660F7DB9ABA6, player);
      _id_744FF9937DEC4EA7 thread _id_C285675BEE6618A3(_id_258B660F7DB9ABA6, player);
    }

    player scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship", "gunship_use", 1, undefined, "pilot");
    _id_744FF9937DEC4EA7._id_BA27AAC5A0F799E0 scripts\common\anim::anim_single_solo(_id_744FF9937DEC4EA7, _id_0E4739DB3B860EF4);
  } else {
    _id_8FB3C3F9C5517645 = 20000;

    if(level.mapname == "mp_shoothouse2")
      _id_8FB3C3F9C5517645 = 10000;

    if(level.mapname == "mp_shipment_iw9")
      _id_8FB3C3F9C5517645 = 19500;

    _id_C458EDAC96D58B16 = player.origin + anglesToForward(player.angles) * 100 + (0, 0, _id_8FB3C3F9C5517645);
    _id_D9979E10EEC99504 = spawn("script_model", _id_C458EDAC96D58B16);
    _id_D9979E10EEC99504 setModel("veh9_mil_air_gunship_interior_vm");
    _id_5CB1F0F95E16878E = [];
    _id_5CB1F0F95E16878E["gunship_interior"] = _id_D9979E10EEC99504;
    _id_BA27AAC5A0F799E0 = spawn("script_model", _id_D9979E10EEC99504 gettagorigin("tag_control_desk"));
    _id_BA27AAC5A0F799E0 setModel("tag_origin");
    _id_BA27AAC5A0F799E0.angles = _id_D9979E10EEC99504 gettagangles("tag_control_desk");
    _id_744FF9937DEC4EA7 = spawnStruct();
    _id_744FF9937DEC4EA7.owner = player;
    _id_744FF9937DEC4EA7._id_3589AD3885D61683 = _id_D9979E10EEC99504;
    _id_744FF9937DEC4EA7._id_9BC4ED07A250F4D3 = player _id_D176C031E49A9127("gunship_interior_probe", "gunship_shadow_brush");
    _id_744FF9937DEC4EA7 thread gunship_watchintrodisown("disconnect", streakinfo);
    _id_744FF9937DEC4EA7 thread gunship_watchintrodisown("joined_team", streakinfo);
    _id_744FF9937DEC4EA7 thread gunship_watchintrodisown("joined_spectators", streakinfo);
    _id_744FF9937DEC4EA7 thread gunship_watchintrodisown("player_fatal_death", streakinfo);
    _id_E618F33D2594B25B = undefined;

    foreach(modelindex, _id_7F6D36CC641739D9 in level._id_9C7D2F4C2FC66B1F) {
      _id_4D4D74B2657628EE = _id_BA27AAC5A0F799E0.origin;

      if(modelindex == "gunship_exterior")
        _id_E618F33D2594B25B = _id_4D4D74B2657628EE + (0, 0, 200);

      _id_C43A209B29EA8EAD = spawn("script_model", _id_BA27AAC5A0F799E0.origin);
      _id_C43A209B29EA8EAD setModel(_id_7F6D36CC641739D9);
      _id_C43A209B29EA8EAD setotherent(player);
      _id_C43A209B29EA8EAD.angles = _id_BA27AAC5A0F799E0.angles;
      _id_C43A209B29EA8EAD.animname = "gunship";
      _id_C43A209B29EA8EAD scripts\common\anim::setanimtree();

      if(modelindex == "desk")
        _id_E618F33D2594B25B = _id_C43A209B29EA8EAD;

      if(modelindex == "joystick") {
        _id_C43A209B29EA8EAD dontinterpolate();
        _id_C43A209B29EA8EAD.origin = _id_E618F33D2594B25B gettagorigin("tag_joystick_1");
        _id_C43A209B29EA8EAD linkTo(_id_E618F33D2594B25B);
      }

      _id_5CB1F0F95E16878E[modelindex] = _id_C43A209B29EA8EAD;
    }

    foreach(_id_B2A3F9ABCEE9D071 in _id_5CB1F0F95E16878E) {
      if(!_id_C8823E8C933EF356) {
        foreach(_id_6C3D15091EFA3C48 in level.players)
        _id_B2A3F9ABCEE9D071 hidefromplayer(_id_6C3D15091EFA3C48);

        _id_B2A3F9ABCEE9D071 thread gunship_hideintromodelonplayerconnect(player);
      }
    }

    _id_744FF9937DEC4EA7._id_BA27AAC5A0F799E0 = _id_BA27AAC5A0F799E0;
    _id_744FF9937DEC4EA7._id_5CB1F0F95E16878E = _id_5CB1F0F95E16878E;
    _id_B8A46AE48904492C = "gunship_exterior";
    _id_313A9E6067853BA8 = "intro_" + _id_B8A46AE48904492C;
    _id_1BE95B011EB36224 = getdvarint("dvar_CC9D9505B48BC357", 0);

    if(_id_1BE95B011EB36224) {
      level.scr_anim["gunship"][_id_313A9E6067853BA8] = % iw9_mp_acharlie130_intro_v2;
      level.scr_animname["gunship"][_id_313A9E6067853BA8] = "iw9_mp_acharlie130_intro_v2";
    } else {
      level.scr_anim["gunship"][_id_313A9E6067853BA8] = % iw9_mp_acharlie130_intro;
      level.scr_animname["gunship"][_id_313A9E6067853BA8] = "iw9_mp_acharlie130_intro";
    }

    player playsoundtoplayer("iw9_gunship_plr_intro", player);
    player scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship", "gunship_use", 1, undefined, "pilot");
    player painvisionoff();
    player scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
    player _id_FA9987DE43A6169B(_id_744FF9937DEC4EA7, _id_313A9E6067853BA8);
    _id_744FF9937DEC4EA7 _id_07EB343DD6A3F639(player, "light_interior_intro", "on", "ks_gunship_interior_intro", 0.0);
    player _id_FA9987DE43A6169B(_id_744FF9937DEC4EA7, "intro");
    _id_744FF9937DEC4EA7 _id_07EB343DD6A3F639(player, "light_interior_intro", "off", "ks_gunship_interior_intro", 0.5);
  }

  _id_744FF9937DEC4EA7 notify("gunship_end_intro");

  if(!_id_C8823E8C933EF356) {
    player disablephysicaldepthoffieldscripting();
    scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    player _id_3B64EB40368C1450::_id_588F2307A3040610("gunshipIntro");
  }

  return _id_744FF9937DEC4EA7;
}

gunship_watchintrodisown(action, streakinfo) {
  self endon("death");
  self endon("gunship_end_intro");
  level endon("game_ended");
  _id_69B64E348A80229E = self.owner;
  _id_69B64E348A80229E waittill(action);

  if(action == "disconnect")
    level.gunshipinuse = 0;

  gunship_detachplayerfromintro(_id_69B64E348A80229E, streakinfo);
}

gunship_detachplayerfromintro(_id_69B64E348A80229E, streakinfo) {
  _id_C8823E8C933EF356 = 0;

  if(isDefined(_id_69B64E348A80229E) && !_id_C8823E8C933EF356) {
    _id_69B64E348A80229E cameraunlink();
    _id_69B64E348A80229E scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    _id_69B64E348A80229E disablephysicaldepthoffieldscripting();
    _id_69B64E348A80229E _id_3B64EB40368C1450::_id_588F2307A3040610("gunshipIntro");
    _id_69B64E348A80229E scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(streakinfo.streakname, "off");
    _id_69B64E348A80229E setclientomnvar("ui_gunship_hud", 0);
    _id_69B64E348A80229E painvisionon();
    _id_69B64E348A80229E scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
    _id_69B64E348A80229E scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785("");
    _id_69B64E348A80229E scripts\cp_mp\utility\killstreak_utility::_id_8B676F496920E2AB();
    _id_69B64E348A80229E notify("detach_gunship_intro");
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(_id_69B64E348A80229E, 0);
  }

  streakinfo notify("killstreak_finished_with_deploy_weapon");
  _id_3856D3338B2C7EBF(self);
}

gunship_hideintromodelonplayerconnect(owner) {
  self endon("death");
  owner endon("disconnect");

  for(;;) {
    level waittill("connected", player);
    self hidefromplayer(player);
  }
}

_id_C285675BEE6618A3(animlength, owner, introsequence) {
  self endon("death");
  owner endon("disconnect");
  owner endon("detach_gunship_intro");
  owner enablephysicaldepthoffieldscripting();

  if(isDefined(introsequence)) {
    if(introsequence == "intro_gunship_exterior") {
      owner setphysicaldepthoffield(1.4, 87, 10, 10);
      _id_31D8A5FD4175DCF4 = animlength * 0.25;
      _id_F2C9960FABE10533 = animlength * 0.65;
      thread _id_37B61F53BC7C8643(owner, _id_31D8A5FD4175DCF4, 2.2, 87, 50, 50);
      thread _id_37B61F53BC7C8643(owner, _id_F2C9960FABE10533, 4.0, 350, 1, 1);
    } else if(introsequence == "intro") {
      owner setphysicaldepthoffield(1.4, 21, 1000, 1000);
      _id_31D8A5FD4175DCF4 = animlength * 0.8;
      thread _id_37B61F53BC7C8643(owner, _id_31D8A5FD4175DCF4, 1.4, 43, 50, 50);
    } else {
      owner setphysicaldepthoffield(1.4, 43, 1000, 1000);
      _id_31D8A5FD4175DCF4 = animlength * 0.5;
      _id_F2C9960FABE10533 = animlength * 0.7;
      thread _id_37B61F53BC7C8643(owner, _id_31D8A5FD4175DCF4, 1.4, 20, 50, 50);
      thread _id_37B61F53BC7C8643(owner, _id_F2C9960FABE10533, 3.0, 100, 50, 50);
    }
  }
}

_id_37B61F53BC7C8643(owner, _id_74B5B12BB6514385, fstop, focusdistance, focusspeed, _id_5587778BB9D6E798) {
  self endon("death");
  owner endon("disconnect");
  owner endon("detach_gunship_intro");
  wait(_id_74B5B12BB6514385);
  owner setphysicaldepthoffield(fstop, focusdistance, focusspeed, _id_5587778BB9D6E798);
}

gunship_startintroshake(animlength, owner, introsequence) {
  self endon("death");
  owner endon("disconnect");
  owner endon("detach_gunship_intro");
  _id_EB5B1F36E255152D = animlength;
  _id_9DDFA144DACC4377 = 0.45;
  _id_23250AC0C394B3C8 = 0.05;

  if(isDefined(introsequence)) {
    if(introsequence == "intro_gunship_exterior") {
      _id_9DDFA144DACC4377 = 0.01;
      _id_23250AC0C394B3C8 = 0.25;
    }
  }

  while(_id_EB5B1F36E255152D > 0) {
    owner earthquakeforplayer(_id_9DDFA144DACC4377, _id_23250AC0C394B3C8, self.origin, 5000);

    if(isDefined(introsequence)) {
      if(introsequence == "intro_gunship_exterior") {
        _id_9DDFA144DACC4377 = _id_9DDFA144DACC4377 + 0.01;

        if(_id_9DDFA144DACC4377 >= 0.1)
          _id_9DDFA144DACC4377 = 0.1;
      }
    } else {
      _id_9DDFA144DACC4377 = _id_9DDFA144DACC4377 - 0.01;

      if(_id_9DDFA144DACC4377 <= 0.12)
        _id_9DDFA144DACC4377 = 0.12;
    }

    _id_EB5B1F36E255152D = _id_EB5B1F36E255152D - _id_23250AC0C394B3C8;
    wait(_id_23250AC0C394B3C8);
  }
}

gunship_queuecamerazoom(animlength, owner) {
  self endon("death");
  owner endon("disconnect");
  owner endon("detach_gunship_intro");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(animlength - 0.2);
  owner scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785("killstreak_slamzoom");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(owner, 1, 0.1);
}

_id_02BE9AE7928984F8(animlength, owner) {
  owner endon("disconnect");
  level endon("game_ended");
  owner endon("detach_gunship_intro");
  wait(animlength - 0.3);
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(owner, 1, 0.3);
  wait 0.7;
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(owner, 0, 0.3);
}

gunship_returnplayer(player, _id_07436690EA0E728C) {
  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](self.streakinfo);

  if(isDefined(player)) {
    player endon("disconnect");
    _id_C8823E8C933EF356 = 0;

    if(!_id_C8823E8C933EF356)
      player scripts\cp_mp\utility\shellshock_utility::_stopshellshock();

    player setclientomnvar("ui_killstreak_thermal_mode", 0);
    player scripts\cp_mp\utility\player_utility::setthermalvision(0);
    player scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "off");
    player setclientomnvar("ui_gunship_hud", 0);
    player stoploopsound();
    player scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785("");
    player clearclienttriggeraudiozone(0.5);
    player painvisionon();
    player scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    player clearcinematicmotionoverride();
    player notify("returning_killstreak_player");
    player.usinggunship = undefined;

    if(getdvarint("camera_thirdPerson")) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "setThirdPersonDOF"))
        player[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "setThirdPersonDOF")]](1);
    }

    if(isDefined(player.gunship_cloudsfx))
      player.gunship_cloudsfx delete();

    if(!_id_C8823E8C933EF356) {
      if(player scripts\cp_mp\utility\player_utility::_isalive()) {
        player scripts\cp_mp\utility\inventory_utility::_giveweapon(level._id_89D6F5464D64EBF4);
        player scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(level._id_89D6F5464D64EBF4);
      }

      player unlink();

      if(istrue(_id_07436690EA0E728C) && level._id_FAF1ABA229E3E2A9 == 0) {
        player waittill("finished_gunship_anim_outro");
        player scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785("killstreak_static");
        wait 1;
        player cameraunlink();
        player scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785("");
      }

      player _id_3B64EB40368C1450::_id_588F2307A3040610("gunshipUse");
      player gunship_allowstances(1);
      player scripts\cp_mp\utility\killstreak_utility::_id_8B676F496920E2AB();
      player scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
      player thread gunship_restoreplayerweapon(self.streakinfo);
    } else {}
  }

  _id_3856D3338B2C7EBF(self._id_744FF9937DEC4EA7);
  gunship_lockedonremovedcallback();

  if(isDefined(self.enemytargetmarkergroup))
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.enemytargetmarkergroup);

  if(isDefined(self.friendlytargetmarkergroup))
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.friendlytargetmarkergroup);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gunship", "br_respawn"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("gunship", "br_respawn")]](player);

  level.gunshipinuse = 0;
}

gunship_restoreplayerweapon(streakinfo) {
  self endon("disconnect");
  streakinfo notify("killstreak_finished_with_deploy_weapon");
  _id_263D5A6C4338E56C = getanimlength(%vm_ks_tablet_drop);

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    _id_3B64EB40368C1450::set("gunshipExit", "fire", 0);
    _id_3B64EB40368C1450::set("gunshipExit", "allow_movement", 0);
    _id_3B64EB40368C1450::set("gunshipExit", "offhand_weapons", 0);
    _id_3B64EB40368C1450::set("gunshipExit", "mantle", 0);
    _id_3B64EB40368C1450::set("gunshipExit", "melee", 0);
    wait 0.05;
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self.lastdroppableweaponobj);
    wait(_id_263D5A6C4338E56C);
    scripts\cp_mp\utility\inventory_utility::_takeweapon("gunship_hellfire_mp");
    scripts\cp_mp\utility\inventory_utility::_takeweapon("gunship_40mm_mp");
    scripts\cp_mp\utility\inventory_utility::_takeweapon("gunship_25mm_mp");
    scripts\cp_mp\utility\inventory_utility::_takeweapon(level._id_89D6F5464D64EBF4);
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("gunshipExit");
  }
}

gunship_watchdamage(gunner) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  self.damagetaken = 0;
  self.attractor = missile_createattractorent(self, 1000, 4096);

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon);
    _id_C8823E8C933EF356 = undefined;
    _id_1FAA3D3DEC8D49BD = undefined;

    if(isDefined(level.teambased) && isPlayer(attacker) && (attacker.team == self.team && (!isDefined(_id_C8823E8C933EF356) || !_id_C8823E8C933EF356)) && (!isDefined(_id_1FAA3D3DEC8D49BD) || !_id_1FAA3D3DEC8D49BD)) {
      continue;
    }
    if(smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_EXPLOSIVE_BULLET") {
      continue;
    }
    if(isDefined(gunner) && gunner isusinggunship()) {
      _id_BB22D61320FFE92D = "light";

      if(isexplosivedamagemod(smeansofdeath)) {
        if(ceil(damage / self.maxhealth) >= 0.33) {
          gunner earthquakeforplayer(0.25, 0.2, self.camera.origin, 150);
          gunner playRumbleOnEntity("damage_heavy");
          _id_BB22D61320FFE92D = "heavy";
        } else {
          gunner earthquakeforplayer(0.15, 0.15, self.camera.origin, 150);
          gunner playRumbleOnEntity("damage_light");
        }
      }

      gunner scripts\cp_mp\utility\killstreak_utility::_id_C144DE677D9B9175(self.currentvisionset, _id_BB22D61320FFE92D);
    }

    self.wasdamaged = 1;
    _id_702BFC08FABD86CB = undefined;

    if(isDefined(_id_1FAA3D3DEC8D49BD))
      _id_702BFC08FABD86CB = damage;
    else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage"))
      _id_702BFC08FABD86CB = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](attacker, objweapon, smeansofdeath, damage, self.maxhealth, 4, 5, 25, 0, 350);

    if(isPlayer(attacker)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback"))
        attacker[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("hitequip");
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakHit"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakHit")]](attacker, objweapon, self, smeansofdeath, _id_702BFC08FABD86CB);

    if(isDefined(attacker.owner) && isPlayer(attacker.owner)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback"))
        attacker.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("hitequip");
    }

    self.damagetaken = self.damagetaken + _id_702BFC08FABD86CB;
    self.currenthealth = self.currenthealth - _id_702BFC08FABD86CB;
    scripts\cp_mp\utility\killstreak_utility::_id_DB9562064A4DD635(self.currenthealth);

    if(self.damagetaken >= self.maxhealth) {
      streakname = self.streakinfo.streakname;
      _id_D95DA0355CF4CCB4 = undefined;
      _id_92D090CE35588AD2 = "destroyed_" + streakname;
      leaderdialog = undefined;
      _id_6342E2DA1DC12454 = "callout_destroyed_" + streakname;
      _id_DC695757F69ED065 = 1;

      if(isPlayer(attacker)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash"))
          thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]](_id_6342E2DA1DC12454, attacker);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "onKillstreakKilled") && isDefined(attacker) && (isPlayer(attacker) || isDefined(attacker.owner)))
        _id_3737240CEFE2C793 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "onKillstreakKilled")]](streakname, attacker, objweapon, _id_D95DA0355CF4CCB4, damage, _id_92D090CE35588AD2, leaderdialog, _id_6342E2DA1DC12454, _id_DC695757F69ED065);

      thread gunship_crash(gunner);
    }
  }
}

_id_FD00F7FCDBCD8972() {
  self setscriptablepartstate("body_damage_light", "on");
  gunner = self.owner;

  if(isDefined(gunner) && gunner isusinggunship()) {
    self.flashlight setscriptablepartstate("camera_damage_light", "on");
    gunner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship", "gunship_light_damage", 1, undefined, "pilot");
  }
}

_id_AB0EC37BA0AFD257() {
  self setscriptablepartstate("body_damage_light", "off");
  self setscriptablepartstate("body_damage_medium", "on");
  gunner = self.owner;

  if(isDefined(gunner) && gunner isusinggunship()) {
    self.flashlight setscriptablepartstate("camera_damage_medium", "on");
    gunner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship", "gunship_med_damage", 1, undefined, "pilot");
    gunner playlocalsound("ks_ac130_damage_warning");
    gunner setclienttriggeraudiozone("gunship_killstreak_damaged", 2);
  }
}

_id_CF130118900C4C47() {
  self setscriptablepartstate("body_damage_medium", "off");
  self setscriptablepartstate("contrails", "off");
  thread gunship_startengineblowoutfx();
  gunner = self.owner;

  if(isDefined(gunner) && gunner isusinggunship()) {
    self.flashlight setscriptablepartstate("camera_damage_heavy", "on");
    gunner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship", "gunship_heavy_damage", 1, undefined, "pilot");
  }
}

gunship_startengineblowoutfx() {
  level endon("game_ended");
  self.leftwingfxent setscriptablepartstate("engine_blowout", "on");
  self.leftwingfxent setscriptablepartstate("body_damage_heavy", "on");
  _id_DCD6EC5F89D73423 = randomfloatrange(0.5, 1);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_DCD6EC5F89D73423);
  self.rightwingfxent setscriptablepartstate("engine_blowout", "on");
  self.rightwingfxent setscriptablepartstate("body_damage_heavy", "on");
}

gunship_watchtimeout(gunner) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(self.timeout);
  thread gunship_leave(gunner);
}

gunship_watchgameend(gunner) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level scripts\engine\utility::waittill_any_2("start_game_ended", "game_ended");
  thread gunship_leave(gunner);
}

gunship_leave(gunner) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  self notify("leaving");
  self unlink();
  self rotateroll(30, 3);
  _id_9DBC893FB4BE54F2 = self.angles;
  _id_E21AA8DD0F14CEA5 = anglesToForward(_id_9DBC893FB4BE54F2);

  if(isDefined(self.owner))
    self.owner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship", "gunship_leave", 1, undefined, "pilot");

  thread gunship_returnplayer(gunner);
  self moveTo(self.origin + _id_E21AA8DD0F14CEA5 * 50000, 10, 5);
  gunship_waittilldestination(self.origin + _id_E21AA8DD0F14CEA5 * 50000);
  gunship_removeplane(0);
}

gunship_waittilldestination(destination) {
  while(isDefined(self) && self.origin != destination)
    waitframe();
}

gunship_watchownerexitaction(gunner, _id_304D14A0F176D5C3) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  gunner waittill(_id_304D14A0F176D5C3);

  if(_id_304D14A0F176D5C3 == "player_fatal_death")
    thread gunship_leave(gunner);
  else
    thread gunship_crash(gunner);
}

gunship_watchendgame(gunner) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  gunner endon("disconnect");
  level waittill("game_ended");
  gunner scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "off");
  gunner setclientomnvar("ui_gunship_hud", 0);
}

gunship_trackvelocity(gunner) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  self.velocity = (0, 0, 0);

  for(;;) {
    self.lastorigin = self.origin;
    wait(level.framedurationseconds);
    self.velocity = (self.origin - self.lastorigin) / level.framedurationseconds;
  }
}

gunship_spawn(owner, streakinfo, angle, _id_DE9C77C124D1FFAB, _id_744FF9937DEC4EA7, _id_2136B63785EE0579) {
  gunship = spawn("script_model", _id_2136B63785EE0579.origin);
  gunship setModel("veh9_mil_air_gunship_small");
  gunship setCanDamage(1);
  gunship.currenthealth = 1000;
  gunship.maxhealth = gunship.currenthealth;
  gunship.health = 99999;
  gunship.owner = owner;
  gunship.team = owner.team;
  gunship.timeout = 45;
  gunship._id_744FF9937DEC4EA7 = _id_744FF9937DEC4EA7;
  gunship._id_2136B63785EE0579 = _id_2136B63785EE0579;
  gunship.ispiloted = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gunship", "attachXRays"))
    gunship = [[scripts\cp_mp\utility\script_utility::getsharedfunc("gunship", "attachXRays")]](gunship);

  gunship._id_D933DAE6A2BE2FAF = 1;
  _id_F07DC7F04D04AF5F = spawn("script_model", gunship.origin);
  _id_F07DC7F04D04AF5F setModel("tag_origin");
  gunship._id_F07DC7F04D04AF5F = _id_F07DC7F04D04AF5F;

  if(scripts\cp_mp\utility\game_utility::islargemap())
    _id_2136B63785EE0579 thread _id_F14AA90C4EF905D2(gunship);

  gunship scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", owner, undefined, undefined, 1, 0);
  gunship scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(1, 750, ::_id_FD00F7FCDBCD8972);
  gunship scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(2, 500, ::_id_AB0EC37BA0AFD257);
  gunship scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(3, 250, ::_id_CF130118900C4C47);
  gunship.flaresreservecount = 2;
  gunship.streakinfo = streakinfo;
  gunship scriptmoveroutline();
  gunship scriptmoverthermal();
  gunship setotherent(owner);
  minimapid = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective"))
    minimapid = gunship[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]]("hud_icon_minimap_killstreak_gunship", gunship.team, 0, 1, 1);

  gunship.minimapid = minimapid;
  gunship linkTo(_id_2136B63785EE0579, "tag_origin", _id_DE9C77C124D1FFAB, (0, angle + 90, -30));
  level notify("matchrecording_plane", gunship);
  return gunship;
}

gunship_updateoverlaycoords(plane) {
  plane endon("death");
  plane endon("crashing");
  plane endon("leaving");
  self endon("disconnect");
  level endon("game_ended");
  wait 0.05;
  thread gunship_updateplanemodelcoords(plane);
  thread gunship_updateplayerpositioncoords(plane);
  thread gunship_updateaimingcoords(plane);
}

gunship_updateplanemodelcoords(plane) {
  plane endon("death");
  plane endon("crashing");
  plane endon("leaving");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self setclientomnvar("ui_gunship_coord1_posx", int(plane.origin[0]));
    self setclientomnvar("ui_gunship_coord1_posy", int(plane.origin[1]));
    self setclientomnvar("ui_gunship_coord1_posz", int(plane.origin[2]));
    wait 0.5;
  }
}

gunship_updateplayerpositioncoords(plane) {
  plane endon("death");
  plane endon("crashing");
  plane endon("leaving");
  self endon("disconnect");
  level endon("game_ended");
  waitframe();
  self setclientomnvar("ui_gunship_coord2_posx", int(self.origin[0]));
  self setclientomnvar("ui_gunship_coord2_posy", int(self.origin[1]));
  self setclientomnvar("ui_gunship_coord2_posz", int(self.origin[2]));
}

gunship_updateaimingcoords(plane) {
  plane endon("death");
  plane endon("crashing");
  plane endon("leaving");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    _id_22C4300CE1D248E8 = self getvieworigin();
    _id_98C6610C2907BA2B = _id_22C4300CE1D248E8 + anglesToForward(self getplayerangles()) * 15000;
    endpos = physicstrace(_id_22C4300CE1D248E8, _id_98C6610C2907BA2B);
    self setclientomnvar("ui_gunship_coord3_posx", int(endpos[0]));
    self setclientomnvar("ui_gunship_coord3_posy", int(endpos[1]));
    self setclientomnvar("ui_gunship_coord3_posz", int(endpos[2]));
    wait 0.1;
  }
}

_id_CBBAA3B3A43FA6B3() {
  self endon("death");
  _id_25BB708A7D591131 = 10;
  _id_CC5BC42930ABBC4F = level.gunship_speed["rotate"] / 360 * _id_25BB708A7D591131;
  self rotateYaw(self.angles[2] + _id_25BB708A7D591131, _id_CC5BC42930ABBC4F, _id_CC5BC42930ABBC4F, 0);
  _id_DE1A5ABB8AC2A421 = 360 / level.gunship_speed["rotate"];
  _id_31FC5244269DAE18 = _id_DE1A5ABB8AC2A421 * 0.0174533;
  level.gunship_magnitude = _id_31FC5244269DAE18 * 9000;

  for(;;) {
    self rotateYaw(360, level.gunship_speed["rotate"]);
    wait(level.gunship_speed["rotate"]);
  }
}

gunship_attachgunner(gunner) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  gunner scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785("");
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(gunner, 0, 0.1);
  gunner scripts\cp_mp\utility\inventory_utility::_giveweapon("gunship_hellfire_mp");
  gunner scripts\cp_mp\utility\inventory_utility::_giveweapon("gunship_40mm_mp");
  gunner scripts\cp_mp\utility\inventory_utility::_giveweapon("gunship_25mm_mp");
  gunner scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("gunship_hellfire_mp");
  self.currentvisionset = "gunship_color_mp";

  if(isDefined(level.mapname) && (issubstr(level.mapname, "mp_shipment") || issubstr(level.mapname, "mp_skerries")))
    self.currentvisionset = "gunship_color_fog_mp";

  waitframe();
  gunner cameraunlink();

  if(level._id_FAF1ABA229E3E2A9 == 1)
    _id_3856D3338B2C7EBF(self._id_744FF9937DEC4EA7);
  else
    gunner _id_5EFA20E5C624BE8F(self._id_744FF9937DEC4EA7);

  self.camera = spawn("script_model", self.origin - (0, 0, 20));
  self.camera setModel("tag_player");
  self.camera.angles = vectortoangles(self._id_2136B63785EE0579.origin - self.camera.origin);
  self.camera linkTo(self);

  if(isbot(gunner))
    gunner cameralinkTo(self.camera, "tag_player");
  else {
    gunner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship", "gunship_engage", 1, undefined, "pilot");
    gunner.usinggunship = 1;
    gunner playerlinkweaponviewtodelta(self.camera, "tag_player", 1.0, 100, 100, 17, 90, 0, 1, 1);
    gunner playerlinkedsetviewznear(0);
    gunner scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785(self.currentvisionset);
    gunner setclienttriggeraudiozone("gunship_killstreak", 2);
    gunner setplayerangles(self.camera.angles);
    gunner _id_3B64EB40368C1450::set("gunshipUse", "ads", 1);
    gunner setcinematicmotionoverride("player_gunship_ride_mp");
    gunner thread scripts\cp_mp\utility\killstreak_utility::_id_D13D2A81214FBFB8("65_instant_noscale");
    gunner scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "on");
    gunner setclientomnvar("ui_gunship_hud", 1);
    gunner setclientomnvar("ui_killstreak_weapon_1_ammo", gunner getweaponammoclip("gunship_hellfire_mp"));
    gunner setclientomnvar("ui_killstreak_weapon_2_ammo", gunner getweaponammoclip("gunship_40mm_mp"));
    gunner setclientomnvar("ui_killstreak_weapon_3_ammo", gunner getweaponammoclip("gunship_25mm_mp"));
    gunner setclientomnvar("ui_killstreak_countdown", gettime() + int(self.timeout * 1000));
    gunner setclientomnvar("ui_killstreak_health", self.maxhealth);
    gunner setclientomnvar("ui_killstreak_flares", self.flaresreservecount);
    gunner setclientomnvar("ui_killstreak_damage_state", 0);
    gunner scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_mp", "top", self.timeout, 0);
    gunner scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    gunner _id_3B64EB40368C1450::_id_3633B947164BE4F3("gunshipUse", 0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gunship", "assignTargetMarkers"))
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("gunship", "assignTargetMarkers")]](gunner);

    gunner thread gunship_updateoverlaycoords(self);
    thread _id_9214536761E6BE23("gunship_hellfire_mp");
  }
}

_id_623A9B1B10D1DB2E(gunner) {
  gunner endon("disconnect");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");

  if(!scripts\common\utility::ismp()) {
    return;
  }
  if(!istrue(level._id_241720CF8C74DDDE)) {
    return;
  }
  thread _id_7F87E01D436C03CC(gunner);

  for(;;) {
    if(gunner adsButtonPressed()) {
      currentweapon = gunner getcurrentweapon();

      if(currentweapon.basename == "gunship_hellfire_mp") {
        _id_DCEAA78F8D315302(gunner, 1);
        self notify("gunship_reset_hellfire_lockon");
      }
    }

    waitframe();
  }
}

_id_7F87E01D436C03CC(gunner) {
  gunner endon("disconnect");
  level endon("game_ended");

  for(;;) {
    result = scripts\engine\utility::waittill_any_return_4("death", "leaving", "crashing", "gunship_reset_hellfire_lockon");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gunship", "ResetMissileLauncherLocking"))
      gunner[[scripts\cp_mp\utility\script_utility::getsharedfunc("gunship", "ResetMissileLauncherLocking")]]();

    gunner._id_2BD8B6BEFEEB2B63 = undefined;
    gunner setclientomnvar("ui_gunship_hellfire_lockon", 0);

    if(result != "gunship_reset_hellfire_lockon") {
      break;
    }
  }
}

_id_DCEAA78F8D315302(gunner, _id_CC706C96147ED540) {
  gunner endon("disconnect");
  level endon("game_ended");

  while(gunner adsButtonPressed()) {
    if((gunner playerads() >= 0.95 || istrue(_id_CC706C96147ED540)) && istrue(self._id_D933DAE6A2BE2FAF)) {
      gunner.missilelauncheruseentered = 1;
      targets = [];

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gunship", "lockOnLaunchers_getTargetArray"))
        targets = [[scripts\cp_mp\utility\script_utility::getsharedfunc("gunship", "lockOnLaunchers_getTargetArray")]](0);

      if(targets.size == 0) {
        self notify("gunship_reset_hellfire_lockon");
        waitframe();
        continue;
      }

      targets = sortbydistance(targets, gunner.origin);

      if(!isDefined(gunner.missilelauncherstage))
        gunner.missilelauncherstage = 0;

      if(gunner.missilelauncherstage == 0) {
        _id_1FE8EEB95943F79F = undefined;
        _id_C7F50DD357B9CDCF = 0;

        foreach(target in targets) {
          if(!isDefined(target)) {
            continue;
          }
          _id_1FE8EEB95943F79F = _id_A3EC651EF5989FB9(gunner, target);

          if(isDefined(_id_1FE8EEB95943F79F)) {
            break;
          }
        }

        if(!isDefined(_id_1FE8EEB95943F79F)) {
          self notify("gunship_reset_hellfire_lockon");
          waitframe();
          continue;
        }

        gunner.missilelaunchertarget = _id_1FE8EEB95943F79F.target;
        gunner.missilelauncherlockstarttime = gettime();
        gunner.missilelauncherlostsightlinetime = 0;

        if(isDefined(gunner.missilelaunchertarget))
          scripts\cp_mp\utility\weapon_utility::addlockedon(gunner.missilelaunchertarget, gunner);

        thread _id_2B613E06060D8B55(gunner);
        gunner.missilelauncherstage = 1;
      }

      if(gunner.missilelauncherstage == 1) {
        _id_F05AEFECC4F91279 = _id_A3EC651EF5989FB9(gunner);

        if(!isDefined(_id_F05AEFECC4F91279)) {
          self notify("gunship_reset_hellfire_lockon");
          waitframe();
          continue;
        }

        _id_3B5803E733581858 = gettime() - gunner.missilelauncherlockstarttime;

        if(_id_3B5803E733581858 < 500) {
          waitframe();
          continue;
        }

        self notify("stop_gunship_hellfire_locking_sfx");
        thread _id_75EEE29AA3795A05(gunner);
        gunner.missilelauncherstage = 2;
      }

      if(gunner.missilelauncherstage == 2) {
        _id_F05AEFECC4F91279 = _id_A3EC651EF5989FB9(gunner);

        if(!isDefined(_id_F05AEFECC4F91279)) {
          self notify("gunship_reset_hellfire_lockon");
          waitframe();
          continue;
        }

        if(!istrue(gunner._id_2BD8B6BEFEEB2B63)) {
          gunner setclientomnvar("ui_gunship_hellfire_lockon", 1);
          gunner._id_2BD8B6BEFEEB2B63 = 1;

          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gunship", "missileLauncher_finalizeLock"))
            gunner[[scripts\cp_mp\utility\script_utility::getsharedfunc("gunship", "missileLauncher_finalizeLock")]](_id_F05AEFECC4F91279);

          waitframe();
          continue;
        }
      }
    }

    waitframe();
  }
}

_id_2B613E06060D8B55(gunner) {
  gunner endon("disconnect");
  self endon("death");
  self endon("crashing");
  self endon("explode");
  self endon("gunship_reset_hellfire_lockon");
  self endon("stop_gunship_hellfire_locking_sfx");
  level endon("game_ended");

  for(;;) {
    gunner playlocalsound("maaws_reticle_tracking");
    gunner playRumbleOnEntity("ac130_25mm_fire");
    wait 0.6;
  }
}

_id_75EEE29AA3795A05(gunner) {
  gunner endon("disconnect");
  self endon("death");
  self endon("crashing");
  self endon("explode");
  self endon("gunship_reset_hellfire_lockon");
  level endon("game_ended");
  gunner playlocalsound("maaws_reticle_locked");

  for(;;) {
    gunner playRumbleOnEntity("ac130_25mm_fire");
    wait 0.25;
  }
}

_id_A3EC651EF5989FB9(gunner, targetoverride) {
  _id_E688B198AA9A4B3F = 0;
  lockontarget = undefined;

  if(isDefined(gunner.missilelaunchertarget))
    lockontarget = gunner.missilelaunchertarget;
  else if(isDefined(targetoverride))
    lockontarget = targetoverride;

  if(!isDefined(lockontarget))
    return undefined;

  if(!_id_E688B198AA9A4B3F && (lockontarget scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer(lockontarget, gunner)))
    return undefined;

  _id_1FE8EEB95943F79F = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gunship", "stingTargStruct_create"))
    _id_1FE8EEB95943F79F = [[scripts\cp_mp\utility\script_utility::getsharedfunc("gunship", "stingTargStruct_create")]](gunner, lockontarget);

  if(!isDefined(_id_1FE8EEB95943F79F))
    return undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gunship", "stingTargStruct_getOffsets"))
    _id_1FE8EEB95943F79F[[scripts\cp_mp\utility\script_utility::getsharedfunc("gunship", "stingTargStruct_getOffsets")]]();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gunship", "stingTargStruct_getOrigins"))
    _id_1FE8EEB95943F79F[[scripts\cp_mp\utility\script_utility::getsharedfunc("gunship", "stingTargStruct_getOrigins")]]();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gunship", "stingTargStruct_getInReticle"))
    _id_1FE8EEB95943F79F[[scripts\cp_mp\utility\script_utility::getsharedfunc("gunship", "stingTargStruct_getInReticle")]]();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gunship", "stingTargStruct_isInReticle")) {
    if(!_id_1FE8EEB95943F79F[[scripts\cp_mp\utility\script_utility::getsharedfunc("gunship", "stingTargStruct_isInReticle")]]())
      return undefined;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gunship", "stingTargStruct_getInLOS"))
    _id_1FE8EEB95943F79F[[scripts\cp_mp\utility\script_utility::getsharedfunc("gunship", "stingTargStruct_getInLOS")]]();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gunship", "SoftSightTest")) {
    if(!gunner[[scripts\cp_mp\utility\script_utility::getsharedfunc("gunship", "SoftSightTest")]](_id_1FE8EEB95943F79F))
      return undefined;
  }

  return _id_1FE8EEB95943F79F;
}

gunship_watchchangeweapons(gunner) {
  gunner endon("disconnect");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  _id_28186422E412EF1B = ["gunship_hellfire_mp", "gunship_40mm_mp", "gunship_25mm_mp"];

  if(!isai(gunner)) {
    gunner notifyonplayercommand("gunship_switch_weapon_next", "+weapnext");
    gunner notifyonplayercommand("gunship_switch_weapon_prev", "+weapprev");
    gunner setclientomnvar("ui_killstreak_weapon", 3);
  }

  _id_D1A7AC1C8EF18462 = 3;

  for(;;) {
    _id_A5516703B3F7D1FF = gunner scripts\engine\utility::waittill_any_return_2("gunship_switch_weapon_prev", "gunship_switch_weapon_next");

    if(!isDefined(_id_A5516703B3F7D1FF)) {
      continue;
    }
    gunner playlocalsound("iw8_ks_ac130_weaponswitch");
    currentweapon = gunner getcurrentweapon();
    _id_DD515FCF025B2E79 = currentweapon;

    foreach(index, weapon in _id_28186422E412EF1B) {
      if(currentweapon.basename == weapon) {
        if(_id_A5516703B3F7D1FF == "gunship_switch_weapon_prev") {
          _id_1D78867302EF16AF = index - 1;

          if(_id_1D78867302EF16AF < 0)
            _id_1D78867302EF16AF = _id_28186422E412EF1B.size - 1;
        } else {
          _id_1D78867302EF16AF = index + 1;

          if(_id_1D78867302EF16AF > _id_28186422E412EF1B.size - 1)
            _id_1D78867302EF16AF = 0;
        }

        _id_DD515FCF025B2E79 = _id_28186422E412EF1B[_id_1D78867302EF16AF];
        break;
      }
    }

    if(_id_DD515FCF025B2E79 != "gunship_hellfire_mp")
      gunner notify("gunship_hellfire_disable_tracking");

    gunner scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(_id_DD515FCF025B2E79);

    if(self.currentvisionset == scripts\cp_mp\utility\killstreak_utility::_id_44E0BD95B98288AB()) {
      _id_6D34D38793B8FCCA = gunship_getdofinfobyweapon(_id_DD515FCF025B2E79);
      gunner setphysicaldepthoffield(_id_6D34D38793B8FCCA.fstop, _id_6D34D38793B8FCCA.focusdistance, 20, 20);
    }

    if(_id_A5516703B3F7D1FF == "gunship_switch_weapon_prev") {
      _id_D1A7AC1C8EF18462++;

      if(_id_D1A7AC1C8EF18462 > 3)
        _id_D1A7AC1C8EF18462 = 1;
    } else {
      _id_D1A7AC1C8EF18462--;

      if(_id_D1A7AC1C8EF18462 == 0)
        _id_D1A7AC1C8EF18462 = 3;
    }

    gunner setclientomnvar("ui_killstreak_weapon", _id_D1A7AC1C8EF18462);
    gunner scripts\cp_mp\utility\killstreak_utility::_id_58707DDFDD9744FA("killstreak_weapon_change_shutter");
    thread _id_9214536761E6BE23(_id_DD515FCF025B2E79);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.4);
  }
}

_id_9516490C44814B4C(gunner) {
  gunner endon("disconnect");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  weaponlist = [];
  weaponlist[1] = "gunship_25mm_mp";
  weaponlist[2] = "gunship_40mm_mp";
  weaponlist[3] = "gunship_hellfire_mp";

  if(!isai(gunner))
    gunner setclientomnvar("ui_killstreak_weapon", 3);

  _id_D1A7AC1C8EF18462 = 3;

  for(;;) {
    gunner waittill("gunship_switch_weapon_any", _id_1D78867302EF16AF);

    if(_id_1D78867302EF16AF == _id_D1A7AC1C8EF18462) {
      continue;
    }
    _id_D1A7AC1C8EF18462 = _id_1D78867302EF16AF;
    gunner playlocalsound("iw8_ks_ac130_weaponswitch");
    _id_DD515FCF025B2E79 = weaponlist[_id_1D78867302EF16AF];

    if(isDefined(_id_DD515FCF025B2E79)) {
      if(_id_DD515FCF025B2E79 != "gunship_hellfire_mp")
        gunner notify("gunship_hellfire_disable_tracking");

      gunner scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(_id_DD515FCF025B2E79);

      if(self.currentvisionset == scripts\cp_mp\utility\killstreak_utility::_id_44E0BD95B98288AB()) {
        _id_6D34D38793B8FCCA = gunship_getdofinfobyweapon(_id_DD515FCF025B2E79);
        gunner setphysicaldepthoffield(_id_6D34D38793B8FCCA.fstop, _id_6D34D38793B8FCCA.focusdistance, 20, 20);
      }

      gunner setclientomnvar("ui_killstreak_weapon", _id_1D78867302EF16AF);
      gunner scripts\cp_mp\utility\killstreak_utility::_id_58707DDFDD9744FA("killstreak_weapon_change_shutter");
      thread _id_9214536761E6BE23(_id_DD515FCF025B2E79);
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.4);
    }
  }
}

gunship_watchweaponfired(gunner) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  streakinfo = self.streakinfo;

  for(;;) {
    gunner waittill("missile_fire", projectile);
    projectile.streakinfo = streakinfo;
    streakinfo.shots_fired++;
    weapon = gunner getcurrentweapon();
    _id_B971E09CE070BD58 = gunner getweaponammoclip(weapon);

    switch (weapon.basename) {
      case "gunship_hellfire_mp":
        earthquake(0.2, 1, self.origin, 1000);
        gunner setclientomnvar("ui_killstreak_weapon_1_ammo", _id_B971E09CE070BD58);
        projectile thread _id_3F087CF63F4156FA(self, gunner);
        break;
      case "gunship_40mm_mp":
        earthquake(0.1, 0.5, self.origin, 1000);
        gunner setclientomnvar("ui_killstreak_weapon_2_ammo", _id_B971E09CE070BD58);
        break;
      case "gunship_25mm_mp":
        gunner setclientomnvar("ui_killstreak_weapon_3_ammo", _id_B971E09CE070BD58);
        break;
    }

    projectile thread _id_CCAA72B347C823BB(self, gunner, weapon.basename);

    if(_id_B971E09CE070BD58 == 0)
      gunner thread gunship_weaponreload(weapon, self);
  }
}

getmissileexplscale(weaponname) {
  scale = 1.0;

  switch (weaponname) {
    case "gunship_hellfire_mp":
      scale = 0.75;
      break;
    case "gunship_40mm_mp":
      scale = 0.5;
      break;
    case "gunship_25mm_mp":
      scale = 0.15;
      break;
  }

  return scale;
}

getmissileexplradius(weaponname) {
  radius = 1.0;

  switch (weaponname) {
    case "gunship_hellfire_mp":
      radius = 2000;
      break;
    case "gunship_40mm_mp":
      radius = 1300;
      break;
    case "gunship_25mm_mp":
      radius = 700;
      break;
  }

  return radius;
}

_id_3F087CF63F4156FA(gunship, gunner) {
  gunship endon("death");
  gunship endon("leaving");
  gunship endon("crashing");
  gunner endon("disconnect");
  self endon("death");
  targetent = gunship._id_F07DC7F04D04AF5F;

  if(isDefined(gunner.missilelaunchertarget) && isDefined(gunner.missilelauncherstage) && gunner.missilelauncherstage == 2) {
    targetent = gunner.missilelaunchertarget;
    gunship notify("gunship_reset_hellfire_lockon");
  }

  self missile_settargetEnt(targetent);
  gunner waittill("gunship_hellfire_disable_tracking");
  self missile_cleartarget();
}

gunship_watchthermaltoggle(gunner) {
  if(!isai(gunner))
    gunner thread scripts\cp_mp\utility\player_utility::watchthermalinputchange();

  gunship_watchthermaltoggleinternal(gunner);

  if(isDefined(gunner) && !isai(gunner))
    gunner scripts\cp_mp\utility\player_utility::stopwatchingthermalinputchange();
}

gunship_watchthermaltoggleinternal(gunner) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  gunner endon("disconnect");
  level endon("game_ended");
  self.flashlight = spawn("script_model", self.origin);
  self.flashlight setModel("ks_gunship_mp");
  self.flashlight dontinterpolate();
  self.flashlight thread gunship_watchthermalflashlightpos(self, gunner);

  if(scripts\cp_mp\utility\game_utility::isnightmap())
    self.flashlight thread gunship_showflashlight();

  _id_C550A393DA085C54 = 0;
  _id_9B037229590A3DC2 = 1;
  _id_41799DA9B6CCE8BE = 12;
  _id_A044168D7664B127 = 1000;
  _id_093B54405FDA960C = scripts\cp_mp\utility\killstreak_utility::_id_44E0BD95B98288AB();

  if(scripts\cp_mp\utility\game_utility::isnightmap() && istrue(_id_9B037229590A3DC2)) {
    gunner scripts\cp_mp\utility\player_utility::setthermalvision(1, _id_41799DA9B6CCE8BE, _id_A044168D7664B127);
    self.currentvisionset = _id_093B54405FDA960C;
    self.flashlight notify("flashlight_on");
    _id_C550A393DA085C54 = 1;
    gunner scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_flir_mp", "top", self.timeout, 0);
    gunner setclientomnvar("ui_killstreak_thermal_mode", 1);
    gunner scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785(_id_093B54405FDA960C);
  }

  for(;;) {
    gunner waittill("switch_thermal_mode");
    currentgunshipweapon = gunner getcurrentweapon();
    _id_6D34D38793B8FCCA = gunship_getdofinfobyweapon(currentgunshipweapon.basename);

    if(!istrue(_id_C550A393DA085C54)) {
      gunner scripts\cp_mp\utility\player_utility::setthermalvision(1, _id_6D34D38793B8FCCA.fstop, _id_6D34D38793B8FCCA.focusdistance);
      self.currentvisionset = _id_093B54405FDA960C;
      _id_C550A393DA085C54 = 1;
      gunner scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_flir_mp", "top", self.timeout, 0);
      gunner setclientomnvar("ui_killstreak_thermal_mode", 1);
      gunner scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785(_id_093B54405FDA960C);
      continue;
    }

    _id_B050705CE498BCB2 = "gunship_color_mp";

    if(isDefined(level.mapname) && (issubstr(level.mapname, "mp_shipment") || issubstr(level.mapname, "mp_skerries")))
      _id_B050705CE498BCB2 = "gunship_color_fog_mp";

    gunner scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785(_id_B050705CE498BCB2);
    self.currentvisionset = _id_B050705CE498BCB2;
    _id_C550A393DA085C54 = 0;
    gunner scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_mp", "top", self.timeout, 0);
    gunner setclientomnvar("ui_killstreak_thermal_mode", 0);
    gunner scripts\cp_mp\utility\player_utility::setthermalvision(0);
  }
}

gunship_getdofinfobyweapon(_id_5C3F9357F11D2223) {
  _id_6D34D38793B8FCCA = spawnStruct();

  switch (_id_5C3F9357F11D2223) {
    case "gunship_hellfire_mp":
      _id_6D34D38793B8FCCA.fstop = 8;
      _id_6D34D38793B8FCCA.focusdistance = 600;
      break;
    case "gunship_40mm_mp":
      _id_6D34D38793B8FCCA.fstop = 8;
      _id_6D34D38793B8FCCA.focusdistance = 600;
      break;
    case "gunship_25mm_mp":
      _id_6D34D38793B8FCCA.fstop = 8;
      _id_6D34D38793B8FCCA.focusdistance = 3500;
      break;
  }

  return _id_6D34D38793B8FCCA;
}

gunship_watchthermalflashlightpos(gunship, gunner) {
  self endon("death");
  level endon("game_ended");
  _id_9ACF6ADE59C12899 = 1;

  while(isDefined(gunship) && isDefined(gunner)) {
    self.origin = gunship.origin;

    if(istrue(_id_9ACF6ADE59C12899))
      self.angles = gunner getplayerangles();

    wait 0.05;
  }

  if(isDefined(self))
    self delete();
}

gunship_showflashlight() {
  self endon("death");
  level endon("game_ended");
  playFXOnTag(scripts\engine\utility::getfx("camera_spotlight"), self, "tag_origin");

  for(;;) {
    level waittill("player_enabled_nvgs");
    stopFXOnTag(scripts\engine\utility::getfx("camera_spotlight"), self, "tag_origin");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
    playFXOnTag(scripts\engine\utility::getfx("camera_spotlight"), self, "tag_origin");
  }
}

gunship_weaponreload(weapon, gunship) {
  gunship endon("death");
  gunship endon("crashing");
  gunship endon("leaving");
  self endon("disconnect");
  level endon("game_ended");
  _id_49E6EF3EDADD524E = getgunshipweaponrootname(weapon);
  _id_A5603E39D84F5137 = _id_49E6EF3EDADD524E + "_mp_reload";
  _id_DD020944EE631BA8 = strtok(_id_49E6EF3EDADD524E, "_");

  if(_id_DD020944EE631BA8[0] == "gunship") {
    _id_A5603E39D84F5137 = "ac130";

    for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < _id_DD020944EE631BA8.size; _id_AC0E594AC96AA3A8++) {
      _id_6712915FC5B2DE68 = _id_DD020944EE631BA8[_id_AC0E594AC96AA3A8];

      if(_id_6712915FC5B2DE68 == "hellfire")
        _id_6712915FC5B2DE68 = "105mm";

      _id_A5603E39D84F5137 = _id_A5603E39D84F5137 + "_" + _id_6712915FC5B2DE68;
    }

    _id_A5603E39D84F5137 = _id_A5603E39D84F5137 + "_mp_reload";
  }

  self playlocalsound(_id_A5603E39D84F5137);

  if(weapon.basename == "gunship_hellfire_mp")
    gunship._id_D933DAE6A2BE2FAF = 0;

  gunship_waitforweaponreloadtime(weapon, _id_49E6EF3EDADD524E);
  _id_00239A0FD1534C98 = _id_49E6EF3EDADD524E + "_reload";
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship", _id_00239A0FD1534C98, undefined, undefined, "pilot");
  maxammo = weaponmaxammo(weapon);
  self setweaponammoclip(weapon, maxammo);

  if(weapon.basename == "gunship_hellfire_mp")
    gunship._id_D933DAE6A2BE2FAF = 1;

  _id_F3FC82C371854578 = undefined;

  switch (_id_49E6EF3EDADD524E) {
    case "gunship_hellfire":
      _id_F3FC82C371854578 = "ui_killstreak_weapon_1_ammo";
      break;
    case "gunship_40mm":
      _id_F3FC82C371854578 = "ui_killstreak_weapon_2_ammo";
      break;
    case "gunship_25mm":
      _id_F3FC82C371854578 = "ui_killstreak_weapon_3_ammo";
      break;
  }

  self setclientomnvar(_id_F3FC82C371854578, maxammo);
}

gunship_waitforweaponreloadtime(weapon, _id_49E6EF3EDADD524E) {
  reloadtime = level.weaponreloadtime[weapon.basename];
  _id_D7DAC94935945AAB = undefined;

  switch (_id_49E6EF3EDADD524E) {
    case "gunship_hellfire":
      _id_D7DAC94935945AAB = "ui_killstreak_weapon_1_reloadtime";
      break;
    case "gunship_40mm":
      _id_D7DAC94935945AAB = "ui_killstreak_weapon_2_reloadtime";
      break;
    case "gunship_25mm":
      _id_D7DAC94935945AAB = "ui_killstreak_weapon_3_reloadtime";
      break;
  }

  self setclientomnvar(_id_D7DAC94935945AAB, gettime() + int(reloadtime * 1000));

  for(;;) {
    wait 0.05;
    reloadtime = reloadtime - 0.05;

    if(reloadtime <= 0) {
      break;
    }
  }
}

getgunshipweaponrootname(weapon) {
  index = 0;
  weaponname = weapon.basename;
  _id_67F14F8315CB0F2F = strtok(weaponname, "_");
  return _id_67F14F8315CB0F2F[index] + "_" + _id_67F14F8315CB0F2F[index + 1];
}

gunship_playpilotfx(pilot) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  pilot.gunship_cloudsfx = spawn("script_model", pilot getEye());
  pilot.gunship_cloudsfx setModel("tag_origin");
  pilot.gunship_cloudsfx linkTo(pilot, "tag_eye");
  waitframe();
  playfxontagforclients(scripts\engine\utility::getfx("clouds"), pilot.gunship_cloudsfx, "tag_origin", pilot);
}

deleteaftertime(delay) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(delay);
  self delete();
}

gunship_crash(gunner) {
  self notify("crashing");
  self.crashed = 1;
  thread _id_43C36396180EE798(gunner);
  thread gunship_movetocrashpos();
}

_id_43C36396180EE798(gunner) {
  if(!isDefined(gunner)) {
    return;
  }
  if(isDefined(self)) {
    self endon("death");
    gunner endon("disconnect");
    thread gunship_returnplayer(gunner, 1);

    if(isDefined(self._id_744FF9937DEC4EA7) && level._id_FAF1ABA229E3E2A9 == 0) {
      self._id_744FF9937DEC4EA7 _id_07EB343DD6A3F639(gunner, "light_interior_outro", "on", "ks_gunship_interior_outro", 0.5);
      self playsoundtoplayer("iw9_gunship_plr_outro", gunner);
      gunner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship", "gunship_crash", 1, undefined, "pilot");
      _id_FBDE3FF0D883172A = scripts\common\anim::_id_52351C3338DA63F4("gunship", "outro_gunner");
      gunner thread gunship_crashexplosionradiostatic(_id_FBDE3FF0D883172A);
      gunner _id_FA9987DE43A6169B(self._id_744FF9937DEC4EA7, "outro");
      self._id_744FF9937DEC4EA7 _id_07EB343DD6A3F639(gunner, "light_interior_outro", "off", "ks_gunship_interior_outro", 0.0);
    }
  }
}

gunship_movetocrashpos() {
  level endon("game_ended");
  self.leftwingfxent setscriptablepartstate("engine_blowout", "off");
  self.rightwingfxent setscriptablepartstate("engine_blowout", "off");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);
  self.leftwingfxent setscriptablepartstate("engine_blowout", "on");
  self.rightwingfxent setscriptablepartstate("engine_blowout", "on");
  self unlink();
  self._id_BA27AAC5A0F799E0 = spawn("script_model", self.origin);
  self._id_BA27AAC5A0F799E0 setModel("tag_origin");
  self._id_BA27AAC5A0F799E0.angles = vectortoangles(anglesToForward(self.angles));
  self.leftwingfxent setscriptablepartstate("engine_blowout", "off");
  self.rightwingfxent setscriptablepartstate("engine_blowout", "off");
  self.leftwingfxent setscriptablepartstate("body_damage_heavy", "off");
  self.rightwingfxent setscriptablepartstate("body_damage_heavy", "off");
  _id_CE1134BA0CDA2FB9 = spawn("script_model", self.origin);
  _id_CE1134BA0CDA2FB9 setModel("ks_gunship_mp_mesh");
  _id_CE1134BA0CDA2FB9.angles = self.angles;
  _id_CE1134BA0CDA2FB9.animname = self.streakinfo.streakname;
  _id_CE1134BA0CDA2FB9 scripts\common\anim::setanimtree();
  _id_9B7AA4DB8D96367F = spawn("script_model", self.origin);
  _id_9B7AA4DB8D96367F setModel("ks_gunship_mp");
  _id_9B7AA4DB8D96367F.angles = self.angles;
  _id_9B7AA4DB8D96367F linkTo(_id_CE1134BA0CDA2FB9, "tag_body", (0, 0, -10), (0, 0, 0));
  _id_D4A561CABC248249 = "crash_air";
  _id_9B7AA4DB8D96367F setscriptablepartstate(_id_D4A561CABC248249, "on", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("entity", "delayEntDelete")) {
    _id_9B7AA4DB8D96367F thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("entity", "delayEntDelete")]](10);
    _id_CE1134BA0CDA2FB9 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("entity", "delayEntDelete")]](10);
  }

  _id_CE1134BA0CDA2FB9 thread gunship_crash_audio();
  _id_1041B7883E5D3DA5 = "outro_gunship_death";
  _id_F7380E0BA9C6762F = scripts\common\anim::_id_52351C3338DA63F4("gunship", _id_1041B7883E5D3DA5);
  thread gunship_delayhide();
  thread gunship_crashexplosionscreenshake(_id_F7380E0BA9C6762F);
  self._id_BA27AAC5A0F799E0 scripts\common\anim::anim_single_solo(_id_CE1134BA0CDA2FB9, _id_1041B7883E5D3DA5);
  self._id_BA27AAC5A0F799E0 delete();
  gunship_removeplane(1);
}

gunship_delayhide() {
  level endon("game_ended");
  wait 0.05;
  self hide();
}

gunship_crashexplosionscreenshake(_id_74B5B12BB6514385) {
  level endon("game_ended");
  _id_14B1D0692795AF2F = _id_74B5B12BB6514385 - 2;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_14B1D0692795AF2F);

  foreach(player in level.players) {
    if(player scripts\cp_mp\utility\player_utility::_isalive())
      player earthquakeforplayer(0.25, 2, self.origin, 30000);
  }
}

gunship_crashexplosionradiostatic(_id_74B5B12BB6514385) {
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_74B5B12BB6514385);
  scripts\cp_mp\utility\killstreak_utility::_id_5A9772411551E56E("gunship", "pilot");
}

gunship_crash_audio() {
  waitframe();
  playsoundatpos(self.origin, "iw8_ks_ac130_explo_main");
  playsoundatpos(self.origin, "iw8_ks_ac130_explo_low_02");
  playsoundatpos(self.origin, "iw8_ks_ac130_shake_explo");
  playsoundatpos(self.origin, "iw8_ks_ac130_whine");
}

gunship_removeplane(_id_4FAC8B8CE36E09F1) {
  if(isDefined(self.flashlight))
    self.flashlight delete();

  if(isDefined(self.camera))
    self.camera delete();

  if(isDefined(self.leftwingfxent))
    self.leftwingfxent delete();

  if(isDefined(self.rightwingfxent))
    self.rightwingfxent delete();

  if(isDefined(self.lightfxent))
    self.lightfxent delete();

  if(isDefined(self._id_F07DC7F04D04AF5F))
    self._id_F07DC7F04D04AF5F delete();

  if(isDefined(self.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self.minimapid);

    self.minimapid = undefined;
  }

  self.streakinfo.expiredbydeath = istrue(_id_4FAC8B8CE36E09F1);

  if(isDefined(self.owner))
    self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);

  self delete();
}

_id_3856D3338B2C7EBF(_id_744FF9937DEC4EA7) {
  if(isDefined(_id_744FF9937DEC4EA7)) {
    if(isDefined(_id_744FF9937DEC4EA7._id_BA27AAC5A0F799E0))
      _id_744FF9937DEC4EA7._id_BA27AAC5A0F799E0 delete();

    if(isent(_id_744FF9937DEC4EA7)) {
      _id_744FF9937DEC4EA7 setscriptablepartstate("clouds_intro", "off", 0);
      _id_744FF9937DEC4EA7 setscriptablepartstate("bodyFX_intro", "off", 0);
      _id_744FF9937DEC4EA7 delete();
    } else if(isDefined(_id_744FF9937DEC4EA7._id_5CB1F0F95E16878E)) {
      foreach(_id_B2A3F9ABCEE9D071 in _id_744FF9937DEC4EA7._id_5CB1F0F95E16878E) {
        if(isDefined(_id_B2A3F9ABCEE9D071))
          _id_B2A3F9ABCEE9D071 delete();
      }
    }
  }
}

_id_5EFA20E5C624BE8F(_id_744FF9937DEC4EA7) {
  if(isDefined(_id_744FF9937DEC4EA7)) {
    if(isDefined(_id_744FF9937DEC4EA7._id_5CB1F0F95E16878E)) {
      foreach(_id_B2A3F9ABCEE9D071 in _id_744FF9937DEC4EA7._id_5CB1F0F95E16878E) {
        if(isDefined(_id_B2A3F9ABCEE9D071))
          _id_B2A3F9ABCEE9D071 hidefromplayer(_id_744FF9937DEC4EA7._id_DEE7149209C9DF8C);
      }
    }
  }
}

_id_FA9987DE43A6169B(_id_744FF9937DEC4EA7, _id_927B3199642B75FC) {
  self endon("disconnect");
  _id_C8823E8C933EF356 = 0;

  if(!isDefined(_id_744FF9937DEC4EA7._id_DEE7149209C9DF8C))
    _id_744FF9937DEC4EA7._id_DEE7149209C9DF8C = self;

  if(isDefined(_id_744FF9937DEC4EA7) && isDefined(_id_927B3199642B75FC)) {
    thread scripts\cp_mp\utility\killstreak_utility::_id_D13D2A81214FBFB8("80_instant_noscale", 1);

    if(_id_927B3199642B75FC == "intro_gunship_exterior") {
      _id_D0B97BE6DC1A3EBA = _id_744FF9937DEC4EA7._id_5CB1F0F95E16878E["gunship_exterior"];
      _id_258B660F7DB9ABA6 = scripts\common\anim::_id_52351C3338DA63F4("gunship", _id_927B3199642B75FC);
      _id_D0B97BE6DC1A3EBA showtoplayer(_id_744FF9937DEC4EA7._id_DEE7149209C9DF8C);
      _id_D0B97BE6DC1A3EBA setscriptablepartstate("clouds_intro", "old", 0);
      _id_D0B97BE6DC1A3EBA setscriptablepartstate("bodyFX_intro", "on", 0);
      _id_744FF9937DEC4EA7._id_BA27AAC5A0F799E0 thread scripts\common\anim::anim_single_solo(_id_D0B97BE6DC1A3EBA, _id_927B3199642B75FC);

      if(!_id_C8823E8C933EF356)
        _id_744FF9937DEC4EA7._id_DEE7149209C9DF8C cameralinkTo(_id_D0B97BE6DC1A3EBA, "tag_player", 1, 1);

      _id_D0B97BE6DC1A3EBA thread gunship_startintroshake(_id_258B660F7DB9ABA6, self, _id_927B3199642B75FC);
      _id_D0B97BE6DC1A3EBA thread _id_C285675BEE6618A3(_id_258B660F7DB9ABA6, self, _id_927B3199642B75FC);
      _id_D0B97BE6DC1A3EBA thread _id_02BE9AE7928984F8(_id_258B660F7DB9ABA6, self);
      wait(_id_258B660F7DB9ABA6);

      if(!_id_C8823E8C933EF356)
        _id_744FF9937DEC4EA7._id_DEE7149209C9DF8C cameraunlink();
    } else {
      if(_id_927B3199642B75FC == "intro") {
        _id_D0B97BE6DC1A3EBA = _id_744FF9937DEC4EA7._id_5CB1F0F95E16878E["gunship_exterior"];
        _id_D0B97BE6DC1A3EBA setscriptablepartstate("clouds_intro", "off", 0);
        _id_D0B97BE6DC1A3EBA setscriptablepartstate("bodyFX_intro", "off", 0);
      }

      if(isDefined(_id_744FF9937DEC4EA7._id_5CB1F0F95E16878E)) {
        foreach(modelindex, _id_B2A3F9ABCEE9D071 in _id_744FF9937DEC4EA7._id_5CB1F0F95E16878E) {
          if(isDefined(_id_B2A3F9ABCEE9D071)) {
            if(modelindex == "gunship_exterior") {
              continue;
            }
            _id_B2A3F9ABCEE9D071 showtoplayer(_id_744FF9937DEC4EA7._id_DEE7149209C9DF8C);

            if(modelindex == "gunship_interior") {
              continue;
            }
            _id_465DB5572E637FB7 = _id_927B3199642B75FC + "_" + modelindex;
            _id_744FF9937DEC4EA7._id_BA27AAC5A0F799E0 thread scripts\common\anim::anim_single_solo(_id_B2A3F9ABCEE9D071, _id_465DB5572E637FB7);

            if(!_id_C8823E8C933EF356 && modelindex == "gunner") {
              _id_744FF9937DEC4EA7._id_DEE7149209C9DF8C cameralinkTo(_id_B2A3F9ABCEE9D071, "tag_camera", 1, 1);
              _id_9ADC9E34BC4E0C77 = scripts\common\anim::_id_52351C3338DA63F4("gunship", _id_927B3199642B75FC + "_gunner");
              _id_B2A3F9ABCEE9D071 thread _id_C285675BEE6618A3(_id_9ADC9E34BC4E0C77, self, _id_927B3199642B75FC);
            }
          }
        }

        _id_258B660F7DB9ABA6 = scripts\common\anim::_id_52351C3338DA63F4("gunship", _id_927B3199642B75FC + "_gunner");
        wait(_id_258B660F7DB9ABA6);
      }
    }

    self notify("finished_gunship_anim_" + _id_927B3199642B75FC);
  }
}

_id_D176C031E49A9127(_id_5E0676140EECDF2D, _id_D2D59B55E30230D3) {
  _id_9D01F34CCFFDAC1C = 1;
  _id_CF01D7BE22198C56 = spawnStruct();
  probe = getEnt(_id_5E0676140EECDF2D, "script_noteworthy");

  if(!isDefined(probe))
    return undefined;

  _id_8BDF4260870EC3D6 = getEntArray(_id_D2D59B55E30230D3, "targetname");

  if(!isDefined(_id_8BDF4260870EC3D6))
    return undefined;

  _id_CF01D7BE22198C56.probe = probe;
  _id_CF01D7BE22198C56._id_8BDF4260870EC3D6 = _id_8BDF4260870EC3D6;
  _id_AD02EAA051593BFF = [];
  _id_4662A9052A5547BD = [];
  _id_AD02EAA051593BFF["pos"] = probe.origin;
  _id_AD02EAA051593BFF["rot"] = probe.angles;
  _id_CF01D7BE22198C56._id_0AF2C99167339224 = _id_AD02EAA051593BFF;

  foreach(index, brush in _id_8BDF4260870EC3D6) {
    _id_3C1FB3060FC3306C = [];
    _id_3C1FB3060FC3306C["pos"] = brush.origin;
    _id_3C1FB3060FC3306C["rot"] = brush.angles;
    _id_4662A9052A5547BD[index] = _id_3C1FB3060FC3306C;
  }

  _id_CF01D7BE22198C56._id_959AC8221D7965BE = _id_4662A9052A5547BD;

  foreach(_id_6C3D15091EFA3C48 in level.players) {
    probe hidefromplayer(_id_6C3D15091EFA3C48);
    probe thread gunship_hideintromodelonplayerconnect(self);

    foreach(brush in _id_8BDF4260870EC3D6) {
      brush hidefromplayer(_id_6C3D15091EFA3C48);
      brush thread gunship_hideintromodelonplayerconnect(self);
    }
  }

  return _id_CF01D7BE22198C56;
}

_id_4293B1250D8A40EC(owner, _id_CF01D7BE22198C56, _id_6DA471E460C9B62C) {
  if(istrue(_id_6DA471E460C9B62C)) {
    _id_CF01D7BE22198C56.probe showtoplayer(owner);

    foreach(brush in _id_CF01D7BE22198C56._id_8BDF4260870EC3D6)
    brush showtoplayer(owner);
  } else {
    _id_CF01D7BE22198C56.probe hidefromplayer(owner);

    foreach(brush in _id_CF01D7BE22198C56._id_8BDF4260870EC3D6)
    brush hidefromplayer(owner);
  }
}

_id_4D00F78750774093(_id_CF01D7BE22198C56) {
  if(!isDefined(_id_CF01D7BE22198C56)) {
    return;
  }
  _id_CF01D7BE22198C56.probe linkTo(self, "tag_origin", (100, 0, 115), (0, 0, 0));
}

_id_BBFA3BCA65CB8E4C(_id_CF01D7BE22198C56) {
  if(!isDefined(_id_CF01D7BE22198C56)) {
    return;
  }
  foreach(brush in _id_CF01D7BE22198C56._id_8BDF4260870EC3D6)
  brush linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
}

_id_38101DB6ED950F17(_id_CF01D7BE22198C56) {
  if(!isDefined(_id_CF01D7BE22198C56)) {
    return;
  }
  _id_CF01D7BE22198C56.probe unlink();
  _id_CF01D7BE22198C56.probe.origin = _id_CF01D7BE22198C56._id_0AF2C99167339224["pos"];
  _id_CF01D7BE22198C56.probe.angles = _id_CF01D7BE22198C56._id_0AF2C99167339224["rot"];
}

_id_FFF560B330FD842D() {
  if(getdvarint("r_reflectionprobegenerate") == 0) {
    _id_0152974660457623 = getEntArray("ks_gunship_light_only", "script_noteworthy");

    foreach(_id_AC0E5D4AC96AAC74 in _id_0152974660457623)
    _id_AC0E5D4AC96AAC74 hide();
  }
}

_id_ECC286C2D3DCB77D(_id_CF01D7BE22198C56) {
  if(!isDefined(_id_CF01D7BE22198C56)) {
    return;
  }
  foreach(index, brush in _id_CF01D7BE22198C56._id_8BDF4260870EC3D6) {
    brush unlink();
    brush.origin = _id_CF01D7BE22198C56._id_959AC8221D7965BE[index]["pos"];
    brush.angles = _id_CF01D7BE22198C56._id_959AC8221D7965BE[index]["rot"];
  }
}

_id_07EB343DD6A3F639(player, _id_8A46C62F0A756DD3, state, _id_66DB8B0A5B8EF437, time) {
  _id_C8823E8C933EF356 = undefined;

  if(!isDefined(player)) {
    return;
  }
  if(state == "on") {
    self._id_3589AD3885D61683 _id_4293B1250D8A40EC(player, self._id_9BC4ED07A250F4D3, 1);
    self._id_3589AD3885D61683 _id_4D00F78750774093(self._id_9BC4ED07A250F4D3);
    self._id_3589AD3885D61683 _id_BBFA3BCA65CB8E4C(self._id_9BC4ED07A250F4D3);
    self._id_3589AD3885D61683 setscriptablepartstate(_id_8A46C62F0A756DD3, "on");
    player visionsetnakedforplayer(_id_66DB8B0A5B8EF437, time);
  } else if(state == "off") {
    self._id_3589AD3885D61683 _id_4293B1250D8A40EC(player, self._id_9BC4ED07A250F4D3, 0);
    _id_38101DB6ED950F17(self._id_9BC4ED07A250F4D3);
    _id_ECC286C2D3DCB77D(self._id_9BC4ED07A250F4D3);
    self._id_3589AD3885D61683 setscriptablepartstate(_id_8A46C62F0A756DD3, "off");
    player visionsetnakedforplayer("", time);
  }
}

gunship_control_bot_aiming() {
  _id_4AC4B608421ECBBB = undefined;
  _id_4D571DF5F3A8BEFC = undefined;
  _id_F3FF73980FAE5DB1 = undefined;
  _id_BEFBF47BFF2227BD = 0;
  _id_EA189B55DE5C8FA7 = 0;
  _id_AB3E79C5F7D858AF = undefined;
  _id_4174D86981043509 = (self botgetdifficultysetting("minInaccuracy") + self botgetdifficultysetting("maxInaccuracy")) / 2;
  _id_DEF9C228381A493A = 0;

  for(;;) {
    _id_D430BCDA6275A38B = 0;
    _id_4B05A8497817406A = 0;

    if(isDefined(_id_4D571DF5F3A8BEFC) && _id_4D571DF5F3A8BEFC.health <= 0 && gettime() - _id_4D571DF5F3A8BEFC.deathtime < 2000) {
      _id_D430BCDA6275A38B = 1;
      _id_4B05A8497817406A = 1;
    } else if(isalive(self.enemy) && (self botcanseeentity(self.enemy) || gettime() - self lastknowntime(self.enemy) <= 300)) {
      _id_D430BCDA6275A38B = 1;
      _id_4D571DF5F3A8BEFC = self.enemy;
      _id_7F9803312B446879 = _id_4D571DF5F3A8BEFC.origin;
      _id_4AC4B608421ECBBB = self.enemy.origin;

      if(self botcanseeentity(self.enemy)) {
        _id_DEF9C228381A493A = 0;
        _id_4B05A8497817406A = 1;
        _id_B8CCCB951E8A65C4 = gettime();
      } else {
        _id_DEF9C228381A493A = _id_DEF9C228381A493A + 0.05;

        if(_id_DEF9C228381A493A > 5.0)
          _id_D430BCDA6275A38B = 0;
      }
    }

    if(_id_D430BCDA6275A38B) {
      if(isDefined(_id_4AC4B608421ECBBB))
        _id_F3FF73980FAE5DB1 = _id_4AC4B608421ECBBB;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("bots", "bot_body_is_dead")) {
        if(_id_4B05A8497817406A && (self[[scripts\cp_mp\utility\script_utility::getsharedfunc("bots", "bot_body_is_dead")]]() || distancesquared(_id_F3FF73980FAE5DB1, level.gunship.origin) > level.physicssphereradius["gunship_hellfire_mp"] * level.physicssphereradius["gunship_hellfire_mp"]))
          self botpressbutton("attack");
      }

      if(gettime() > _id_EA189B55DE5C8FA7 + 500) {
        _id_BCFEC646853A95C1 = randomfloatrange(-1 * _id_4174D86981043509 / 2, _id_4174D86981043509 / 2);
        _id_BCFEC546853A938E = randomfloatrange(-1 * _id_4174D86981043509 / 2, _id_4174D86981043509 / 2);
        _id_BCFEC446853A915B = randomfloatrange(-1 * _id_4174D86981043509 / 2, _id_4174D86981043509 / 2);
        _id_AB3E79C5F7D858AF = (150 * _id_BCFEC646853A95C1, 150 * _id_BCFEC546853A938E, 150 * _id_BCFEC446853A915B);
        _id_EA189B55DE5C8FA7 = gettime();
      }

      _id_F3FF73980FAE5DB1 = _id_F3FF73980FAE5DB1 + _id_AB3E79C5F7D858AF;
    } else if(gettime() > _id_BEFBF47BFF2227BD) {
      _id_BEFBF47BFF2227BD = gettime() + randomintrange(1000, 2000);
      _id_F3FF73980FAE5DB1 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("bots", "get_random_outside_target"))
        _id_F3FF73980FAE5DB1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("bots", "get_random_outside_target")]]();
    }

    self botlookatpoint(_id_F3FF73980FAE5DB1, 0.2, "script_forced");
    wait 0.05;
  }
}

gunship_handlemissiledetection(player, _id_82FD3EE8FBACE30E, _id_6D87867F43E1D612, _id_5991F0E5DA9F9BD5) {
  self endon("death");

  for(;;) {
    if(!isDefined(_id_6D87867F43E1D612)) {
      break;
    }

    center = _id_6D87867F43E1D612 getpointinbounds(0, 0, 0);
    _id_6B40B4C28ABE0A05 = distance(self.origin, center);

    if(_id_6B40B4C28ABE0A05 < 4000 && _id_6D87867F43E1D612.flaresreservecount > 0) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "reduceReserves"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "reduceReserves")]](_id_6D87867F43E1D612);

      _id_6D87867F43E1D612 thread gunship_playflaresfx(_id_5991F0E5DA9F9BD5);
      _id_6D87867F43E1D612 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship", "gunship_flares", 1, undefined, "pilot");
      newtarget = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "deploy"))
        newtarget = _id_6D87867F43E1D612[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "deploy")]]();

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "updateScrapAssistDataForceCredit"))
        _id_6D87867F43E1D612[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "updateScrapAssistDataForceCredit")]](player);

      self missile_settargetEnt(newtarget);
      self notify("missile_pairedWithFlare");
      return;
    } else if(_id_6B40B4C28ABE0A05 < 300 && _id_6D87867F43E1D612.flaresreservecount <= 0) {
      _id_6D87867F43E1D612 thread gunship_playfakebodyexplosion();
      _id_CBBB045B041FFEBE = weapongetdamagemax(self.weapon_name);

      if(isDefined(self.owner))
        _id_6D87867F43E1D612 dodamage(_id_CBBB045B041FFEBE, self.owner.origin, self.owner, self, "MOD_EXPLOSIVE", self.weapon_name);

      self delete();
    }

    waitframe();
  }
}

gunship_playfakebodyexplosion() {
  if(!isDefined(self.missileexplcounter))
    self.missileexplcounter = 0;

  self.missileexplcounter++;

  if(self.missileexplcounter > 4)
    self.missileexplcounter = 0;

  self setscriptablepartstate("fake_missile_expl_" + self.missileexplcounter, "on", 0);
  self playsoundonmovingent("iw8_ks_ac130_dist_rkt_explo");
  wait 2;
  self setscriptablepartstate("fake_missile_expl_" + self.missileexplcounter, "off", 0);
}

gunship_playflaresfx(_id_5991F0E5DA9F9BD5) {
  _id_0023E275144756D0 = "tag_origin";

  if(isDefined(_id_5991F0E5DA9F9BD5))
    _id_0023E275144756D0 = _id_5991F0E5DA9F9BD5;

  playsoundatpos(self gettagorigin(_id_0023E275144756D0), "ks_ac130_flares");
  playFXOnTag(scripts\engine\utility::getfx("gunship_flares"), self, _id_0023E275144756D0);
  _id_F013AD964DEE7733 = self.flaresreservecount + 1;
  self setscriptablepartstate("fake_flares_" + _id_F013AD964DEE7733, "on", 0);
}

isusinggunship() {
  return isDefined(self.usinggunship);
}

gunship_linklightfxent() {
  self endon("death");
  level endon("game_ended");
  wait 0.05;
  _id_5B4BFD7150E39EE0 = anglesToForward(self.angles);
  self setscriptablepartstate("lights", "on");
}

gunship_linkwingfxents() {
  self endon("death");
  level endon("game_ended");
  wait 0.05;
  _id_633EAA5F21008B6F = self gettagorigin("tag_left_outer_prop");
  self.leftwingfxent = spawn("script_model", _id_633EAA5F21008B6F);
  self.leftwingfxent setModel("ks_gunship_mp");
  self.leftwingfxent.angles = self.angles;
  self.leftwingfxent setotherent(self.owner);
  self.leftwingfxent linkTo(self, "tag_left_outer_prop", (0, 0, 0), (0, 0, 0));
  _id_3EACD3938CCD4B6C = self gettagorigin("tag_right_outer_prop");
  self.rightwingfxent = spawn("script_model", _id_3EACD3938CCD4B6C);
  self.rightwingfxent setModel("ks_gunship_mp");
  self.rightwingfxent.angles = self.angles;
  self.rightwingfxent setotherent(self.owner);
  self.rightwingfxent linkTo(self, "tag_right_outer_prop", (0, 0, 0), (0, 0, 0));
  self setscriptablepartstate("contrails", "on");
}

gunship_watchtargets(gunner) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  gunner endon("disconnect");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);

  for(;;) {
    _id_C26B9F481753E189 = [];

    foreach(player in level.players) {
      if(!isDefined(player) || !player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(self.owner worldpointinreticle_circle(player.origin, 80, 100)) {
        if(level.teambased && player.team == self.team) {
          continue;
        }
        if(player == self.owner) {
          continue;
        }
        if(!scripts\cp_mp\utility\killstreak_utility::streakcanseetarget(self.origin, player gettagorigin("j_spineupper"), self)) {
          continue;
        }
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
          if(player[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline"))
            continue;
        }

        _id_C26B9F481753E189 = gunship_getnearbytargets(player);
        break;
      }

      wait 0.05;
    }

    if(_id_C26B9F481753E189.size > 0 && _id_C26B9F481753E189.size < 2)
      gunner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship", "gunship_spotted_single_target", undefined, undefined, "pilot");
    else if(_id_C26B9F481753E189.size >= 2)
      gunner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship", "gunship_spotted_single_multi", undefined, undefined, "pilot");

    wait(randomintrange(5, 15));
  }
}

gunship_getnearbytargets(_id_0050ED806F04C63D) {
  _id_69338CA0BF9D8D91 = scripts\common\utility::playersinsphere(_id_0050ED806F04C63D.origin, 300);
  _id_BC19A29ED084D79C = [];

  foreach(player in _id_69338CA0BF9D8D91) {
    if(level.teambased && player.team != _id_0050ED806F04C63D.team) {
      continue;
    }
    if(!level.teambased && player == self.owner) {
      continue;
    }
    _id_BC19A29ED084D79C[_id_BC19A29ED084D79C.size] = player;
  }

  return _id_BC19A29ED084D79C;
}

_id_39464052869B655D(gunner) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  gunner endon("disconnect");
  self._id_0D743AC65ECCE766 = 0;
  childthread gunship_watchkills();
  childthread _id_C8437BFB873FD165();

  for(;;) {
    if(self._id_0D743AC65ECCE766 != 0) {
      wait 2;

      if(self._id_0D743AC65ECCE766 >= 1)
        scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship", "gunship_hit_target", undefined, undefined, "pilot");
      else
        scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship", "gunship_miss_target", undefined, undefined, "pilot");

      self._id_0D743AC65ECCE766 = 0;
      wait 1;
    }

    waitframe();
  }
}

gunship_watchkills() {
  for(;;) {
    self.owner waittill("update_rapid_kill_buffered", _id_E4C6376813E5A077, weaponname);

    if(isDefined(_id_E4C6376813E5A077))
      self._id_0D743AC65ECCE766++;
  }
}

_id_C8437BFB873FD165() {
  for(;;) {
    self.owner waittill("update_rapid_agent_kill_buffered", _id_E4C6376813E5A077, weaponname);

    if(isDefined(_id_E4C6376813E5A077))
      self._id_0D743AC65ECCE766++;
  }
}

gunship_iskillstreakweapon(weaponname) {
  return scripts\engine\utility::ter_op(isDefined(weaponname) && (weaponname == "gunship_hellfire_mp" || weaponname == "gunship_40mm_mp" || weaponname == "gunship_25mm_mp"), 1, 0);
}

gunship_islargemap() {
  largemap = scripts\cp_mp\utility\game_utility::islargemap();
  return largemap;
}

gunship_allowstances(_id_B96D126FC701024B) {
  if(!istrue(_id_B96D126FC701024B)) {
    self.gunship_disabledstances = [];
    _id_0E85BB71774631A2 = self getstance();

    switch (_id_0E85BB71774631A2) {
      case "stand":
        self.gunship_disabledstances = ["crouch", "prone"];
        break;
      case "crouch":
        self.gunship_disabledstances = ["stand", "prone"];
        break;
      case "prone":
        self.gunship_disabledstances = ["stand", "crouch"];
        break;
    }

    _id_3B64EB40368C1450::_id_2D6E7E0B80767910("gunshipStance", self.gunship_disabledstances);
    _id_3B64EB40368C1450::_id_3633B947164BE4F3("gunshipStance", 0);
  } else
    _id_3B64EB40368C1450::_id_588F2307A3040610("gunshipStance");
}

_id_486B043F227FCA86() {
  self endon("death");
  level waittill("game_ended");
  level._id_1217E6483E1A18A0 = scripts\engine\utility::array_remove(level._id_1217E6483E1A18A0, self);
  self delete();
}

_id_F14AA90C4EF905D2(ent) {
  self endon("death");
  ent scripts\engine\utility::waittill_any_2("leaving", "death");
  level._id_1217E6483E1A18A0 = scripts\engine\utility::array_remove(level._id_1217E6483E1A18A0, self);
  self delete();
}

_id_AAFC33D685563AA4(owner) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  owner endon("disconnect");
  level endon("game_ended");

  for(;;) {
    targetpos = _id_CDF6E1BDFE5B42B5(owner);

    if(isDefined(targetpos))
      self._id_F07DC7F04D04AF5F.origin = targetpos;

    waitframe();
  }
}

_id_5FBD9704078207AD(owner) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  owner endon("disconnect");
  level endon("game_ended");
  _id_0BD96B768DAAE9F1 = 65;
  _id_A326F793BDAF5565 = 0.2;
  currentfov = _id_0BD96B768DAAE9F1;
  _id_D54D564805C29B7B = undefined;
  _id_91C95E88F4DE9ED7 = 0;
  _id_7B2D7A7927E3E11E = 0;
  owner setclientomnvar("ui_killstreak_zoom_fov", currentfov);

  for(;;) {
    if(!isDefined(self._id_5496FF174012E0E0)) {
      waitframe();
      continue;
    }

    if(owner adsButtonPressed()) {
      _id_91C95E88F4DE9ED7 = _id_91C95E88F4DE9ED7 + 0.05;

      if(_id_91C95E88F4DE9ED7 >= _id_A326F793BDAF5565)
        _id_91C95E88F4DE9ED7 = _id_A326F793BDAF5565;

      if(!istrue(_id_7B2D7A7927E3E11E)) {
        owner scripts\cp_mp\utility\killstreak_utility::_id_58707DDFDD9744FA("killstreak_ads_shutter");
        _id_7B2D7A7927E3E11E = 1;
      }
    } else if(_id_91C95E88F4DE9ED7 > 0) {
      _id_91C95E88F4DE9ED7 = _id_91C95E88F4DE9ED7 - 0.05;

      if(_id_91C95E88F4DE9ED7 <= 0)
        _id_91C95E88F4DE9ED7 = 0;

      if(istrue(_id_7B2D7A7927E3E11E))
        _id_7B2D7A7927E3E11E = 0;
    }

    if(_id_91C95E88F4DE9ED7 >= 0) {
      _id_D54D564805C29B7B = self._id_5496FF174012E0E0;
      _id_F29615BFB202E7D4 = _id_91C95E88F4DE9ED7 / _id_A326F793BDAF5565 * 100;
      currentfov = int(_id_F29615BFB202E7D4 * (_id_D54D564805C29B7B - _id_0BD96B768DAAE9F1) / 100 + _id_0BD96B768DAAE9F1);
    }

    owner setclientomnvar("ui_killstreak_zoom_fov", currentfov);
    wait 0.05;
  }
}

_id_CDF6E1BDFE5B42B5(owner) {
  _id_C56207BDA09B3A36 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicleclip"];
  contentoverride = physics_createcontents(_id_C56207BDA09B3A36);
  _id_22C4300CE1D248E8 = owner getvieworigin();
  _id_98C6610C2907BA2B = _id_22C4300CE1D248E8 + anglesToForward(owner getplayerangles()) * 50000;
  ignoreents = owner scripts\cp_mp\utility\killstreak_utility::playerkillstreakgetownerlookatignoreents();
  trace = scripts\engine\trace::ray_trace(_id_22C4300CE1D248E8, _id_98C6610C2907BA2B, ignoreents, contentoverride);
  endpos = trace["position"];
  return endpos;
}

_id_9214536761E6BE23(_id_8DDCEE7F743EE3A8) {
  self endon("death");
  self notify("gunhip_storing_fov");
  self endon("gunship_storing_fov");

  for(;;) {
    _id_CE70D40CF5E19337 = self.owner getcurrentweapon();

    if(isDefined(_id_CE70D40CF5E19337) && _id_CE70D40CF5E19337.basename == _id_8DDCEE7F743EE3A8) {
      break;
    }

    waitframe();
  }

  self._id_5496FF174012E0E0 = self.owner playergetzoomfov();
}

_id_CCAA72B347C823BB(gunship, gunner, _id_5C3F9357F11D2223) {
  gunship endon("death");
  gunship endon("leaving");
  gunship endon("crashing");
  gunner endon("disconnect");
  self waittill("death");

  if(_id_5C3F9357F11D2223 == "gunship_25mm_mp") {
    return;
  }
  _id_465F0D60F080D408 = "gunship_25mm_crt";

  if(_id_5C3F9357F11D2223 == "gunship_hellfire_mp") {
    _id_465F0D60F080D408 = "gunship_40mm_crt";
    earthquake(0.125, 0.5, gunship.origin, 1000);
  }

  gunner scripts\cp_mp\utility\killstreak_utility::_id_58707DDFDD9744FA(_id_465F0D60F080D408);
}