/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\gunship.gsc
*************************************************/

#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\targetmarkergroups;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\dialog_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\killstreaks\killstreak_shared;
#using scripts\mp\sentientpoolmanager;
#namespace gunship;

function init() {
  bundle = level.streakglobals.streakbundles["gunship"];

  if(!isDefined(bundle)) {
    return;
  }

  if(issharedfuncdefined("gunship", "init")) {
    [[getsharedfunc("gunship", "init")]]();
  }

  setdevdvarifuninitialized(@ "hash_fa402c92e4148a39", bundle.gunship_lifetime);
  setdevdvarifuninitialized(@ "hash_f49f4fd233809e37", 0);
  setdevdvarifuninitialized(@ "hash_a59a7da9fa17c00", 0);
  setdevdvarifuninitialized(@ "hash_cc9d9505b48bc357", 0);
  setdevdvarifuninitialized(@ "hash_302d41b2b6f9d002", 0);
  setdevdvarifuninitialized(@ "hash_9a9f1499825922aa", 0);
  setdevdvarifuninitialized(@ "hash_73471de3f4780421", 0);
  setdevdvarifuninitialized(@ "hash_55b253d027368418", 1);
  setdevdvarifuninitialized(@ "hash_9852a22e959385f5", 0);
  setdevdvarifuninitialized(@ "hash_1fa8dffa69ff4ed8", 0);

  level thread function_7ab42d42f465952f();
  level function_8e8513a8b071336c();
  level function_77e6149ef483d24a();
  level function_b0280ee1765554d1();
  level init_gunship_vo();
  level function_6fcb27d917ef709b();
  level function_ea9e0f077f0d655c();
  thread function_fff560b330fd842d();
}

function weapongivengunship(streakinfo) {
  return true;
}

function function_7ab42d42f465952f() {
  level endon("game_ended");
  flag_wait("onStartGameTypeFinished");

  if(isDefined(level.mapcenter)) {
    level.var_3065d0b3d892e79f = level.mapcenter;
    return;
  }

  level.var_3065d0b3d892e79f = (0, 0, 0);
}

function function_8e8513a8b071336c() {
  bundle = level.streakglobals.streakbundles["gunship"];
  level.gunship_speed["move"] = 250;
  level.gunship_speed["rotate"] = 120;
  level.var_89d6f5464d64ebf4 = makeweapon(bundle.deployweaponname);
  level.physicssphereradius[bundle.var_2b83894fc24a37fc] = 60;
  level.physicssphereradius[bundle.var_2cb6918da56b085b] = 600;
  level.physicssphereradius[bundle.var_b702d1aa92e3f7dc] = 1000;
  level.physicssphereforce[bundle.var_2b83894fc24a37fc] = 0;
  level.physicssphereforce[bundle.var_2cb6918da56b085b] = 3;
  level.physicssphereforce[bundle.var_b702d1aa92e3f7dc] = 6;
  level.weaponreloadtime[bundle.var_2b83894fc24a37fc] = bundle.var_67d0db070ddbff8d;
  level.weaponreloadtime[bundle.var_2cb6918da56b085b] = bundle.var_7a1254e0d125c272;
  level.weaponreloadtime[bundle.var_b702d1aa92e3f7dc] = bundle.var_f3502361de75bf6d;
  level.gunshiprigs = [];
  level.gunship_lockon = getdvarint(@ "hash_55b253d027368418", 1);
  registervisibilityomnvarforkillstreak("gunship", "on", 9);
}

function function_77e6149ef483d24a() {
  val::group_register("gunshipIntro", ["allow_jump", "usability", "killstreaks", "supers", "gesture", "fire", "weapon_switch", "allow_movement", "offhand_weapons", "shellshock"]);
  val::group_register("gunshipUse", ["usability", "killstreaks", "supers", "gesture", "weapon_switch", "allow_movement", "shellshock"]);
}

#using_animtree("script_model");

function function_b0280ee1765554d1() {
  level.scr_animtree["gunship"] = #animtree;
  animindex = "intro_gunship";
  level.scr_anim["gunship"][animindex] = % mp_acharlie130_intro;
  animindex = "intro_gunship_exterior";
  level.scr_anim["gunship"][animindex] = % iw9_mp_acharlie130_intro;
  animindex = "intro_gunner";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_player_intro;
  animindex = "intro_co_gunner";
  level.scr_anim["gunship"][animindex] = % wm_ks_gunship_pilot2_intro;
  animindex = "intro_desk";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_desk_intro;
  animindex = "intro_clipboard_1";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_clipboard1_intro;
  animindex = "intro_clipboard_2";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_clipboard2_intro;
  animindex = "intro_paper";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_paper1_intro;
  animindex = "intro_pen_1";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_pen1_intro;
  animindex = "intro_pen_2";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_pen2_intro;
  animindex = "intro_smartphone";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_smartphone1_intro;
  animindex = "intro_tablet";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_tablet1_intro;
  animindex = "intro_binder";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_binder_intro;
  animindex = "intro_joystick";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_joystick_intro;
  animindex = "outro_gunner";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_player_outro;
  animindex = "outro_co_gunner";
  level.scr_anim["gunship"][animindex] = % wm_ks_gunship_pilot2_outro;
  animindex = "outro_desk";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_desk_outro;
  animindex = "outro_clipboard_1";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_clipboard1_outro;
  animindex = "outro_clipboard_2";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_clipboard2_outro;
  animindex = "outro_paper";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_paper1_outro;
  animindex = "outro_pen_1";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_pen1_outro;
  animindex = "outro_pen_2";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_pen2_outro;
  animindex = "outro_smartphone";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_smartphone1_outro;
  animindex = "outro_tablet";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_tablet1_outro;
  animindex = "outro_binder";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_binder_outro;
  animindex = "outro_joystick";
  level.scr_anim["gunship"][animindex] = % vm_ks_gunship_joystick_outro;
  animindex = "outro_gunship_death";
  level.scr_anim["gunship"][animindex] = % mp_acharlie130_death;

  foreach(animindex, scr_anim in level.scr_anim["gunship"]) {
    level.scr_animlength["gunship"][animindex] = function_52351c3338da63f4("gunship", animindex);
  }

  bundle = level.streakglobals.streakbundles["gunship"];
  level.var_9c7d2f4c2fc66b1f = [];
  level.var_9c7d2f4c2fc66b1f["gunship_exterior"] = bundle.gunship_intromodel;
  level.var_9c7d2f4c2fc66b1f["gunner"] = "body_sp_ally_sensor_operator_vm_1_1_noface";
  level.var_9c7d2f4c2fc66b1f["co_gunner"] = "fullbody_sp_ally_sensor_operator_wm_1_1";
  level.var_9c7d2f4c2fc66b1f["desk"] = "misc_gunship_interior_desk";
  level.var_9c7d2f4c2fc66b1f["clipboard_1"] = "misc_un_office_clipboard_01";
  level.var_9c7d2f4c2fc66b1f["clipboard_2"] = "misc_un_office_clipboard_01";
  level.var_9c7d2f4c2fc66b1f["paper"] = "misc_un_office_paper_01";
  level.var_9c7d2f4c2fc66b1f["pen_1"] = "misc_un_office_pen_01";
  level.var_9c7d2f4c2fc66b1f["pen_2"] = "misc_un_office_pen_01";
  level.var_9c7d2f4c2fc66b1f["smartphone"] = "offhand1h_smartphone_static_v0";
  level.var_9c7d2f4c2fc66b1f["tablet"] = "offhand2h_tablet_static_v0";
  level.var_9c7d2f4c2fc66b1f["binder"] = "misc_un_office_binder_open";
  level.var_9c7d2f4c2fc66b1f["joystick"] = "misc_gunship_interior_joystick";
  level.gunship_animtype = getdvarint(@ "hash_a59a7da9fa17c00", 0);
}

function init_gunship_vo() {
  game["dialog"]["gunship" + "_use"] = "killstreak_remote_operator" + "_request_response";
  game["dialog"]["gunship" + "_leave"] = "killstreak_remote_operator" + "_leave";
  game["dialog"]["gunship" + "_engage"] = "killstreak_remote_operator" + "_engage";
  game["dialog"]["gunship" + "_random_radio"] = "killstreak_remote_operator" + "_radio_chatter";
  game["dialog"]["gunship" + "_flares"] = "killstreak_remote_operator" + "_flare_release";
  game["dialog"]["gunship" + "_light_damage"] = "killstreak_remote_operator" + "_light_damage";
  game["dialog"]["gunship" + "_med_damage"] = "killstreak_remote_operator" + "_med_damage";
  game["dialog"]["gunship" + "_heavy_damage"] = "killstreak_remote_operator" + "_heavy_damage";
  game["dialog"]["gunship" + "_lockedon"] = "killstreak_remote_operator" + "_missile_lock_warning";
  game["dialog"]["gunship" + "_crash"] = "killstreak_remote_operator" + "_crash";
  game["dialog"]["gunship" + "_hit_target"] = "killstreak_remote_operator" + "_hit_target";
  game["dialog"]["gunship" + "_miss_target"] = "killstreak_remote_operator" + "_miss_target";
  game["dialog"]["gunship" + "_spotted_single_target"] = "killstreak_remote_operator" + "_target_spotted_single";
  game["dialog"]["gunship" + "_spotted_multi_target"] = "killstreak_remote_operator" + "_miss_target";
  game["dialog"]["gunship" + "_hellfire_reload"] = "killstreak_remote_operator" + "_hellfire_reload";
  game["dialog"]["gunship" + "_40mm_reload"] = "killstreak_remote_operator" + "_40mm_reload";
  game["dialog"]["gunship" + "_25mm_reload"] = "killstreak_remote_operator" + "_25mm_reload";
}

function function_6fcb27d917ef709b() {
  level._effect["clouds"] = loadfx("vfx/iw8_mp/killstreak/vfx_ac130_view_clouds.vfx");
  level._effect["gunship_flares"] = loadfx("vfx/iw8_mp/killstreak/vfx_ac130_flares.vfx");
  level._effect["camera_spotlight"] = loadfx("vfx/iw8_mp/killstreak/vfx_ac130_ir_spotlight.vfx");
}

function function_ea9e0f077f0d655c() {
  if(isDefined(level.gunshipvisionset)) {
    function_c0b0a582ff9e4d57(level.gunshipvisionset);
  }

  bundle = level.streakglobals.streakbundles["gunship"];
  function_c0b0a582ff9e4d57(bundle.var_7a35928e082dd9b7);
  function_c0b0a582ff9e4d57(bundle.var_6070115b879adfc9);
  function_c0b0a582ff9e4d57(bundle.var_7c6da61313057613, 0.1, 0.2, 0.5);
  function_c0b0a582ff9e4d57(bundle.var_1773b3703b61838e, 0.1, 0.1, 0.3);
  function_c0b0a582ff9e4d57(bundle.var_ee69fd7db3c43c73, 0.1, 0.1, 0.2);
}

function tryusegunship() {
  streakinfo = createstreakinfo("gunship", self);
  return tryusegunshipfromstruct(streakinfo);
}

function tryusegunshipfromstruct(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("using_remote");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      return 0;
    }
  }

  deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(streakinfo, &weapongivengunship);

  if(!istrue(deployresult)) {
    return 0;
  }

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
    if(scripts\engine\utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\engine\utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    }

    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  return result;
}

function gunship_monitormanualplayerexit(owner) {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  owner endon("disconnect");

  if(issharedfuncdefined("killstreak", "allowRideKillstreakPlayerExit")) {
    self thread[[getsharedfunc("killstreak", "allowRideKillstreakPlayerExit")]]();
  }

  self waittill("killstreakExit");
  thread gunship_leave(owner);
}

function gunship_startuse(player, streakinfo) {
  level endon("game_ended");

  if(issharedfuncdefined("game", "disable_backpack_inventory")) {
    player[[getsharedfunc("game", "disable_backpack_inventory")]](1);
  }

  launchorigin = level.var_3065d0b3d892e79f;

  if(islargemap()) {
    if(level.gametype == "arm" || level.gametype == "conflict" || level.gametype == "gwtdm") {
      if(isDefined(level.hqmidpoint)) {
        launchorigin = level.hqmidpoint;
      } else if(isDefined(level.gunship_origin_override)) {
        launchorigin = level.gunship_origin_override;
      }
    } else {
      launchorigin = player.origin;
    }
  }

  var_2136b63785ee0579 = function_25233a050a5e41f0(player, launchorigin);

  if(!isDefined(var_2136b63785ee0579)) {
    return false;
  }

  bundle = level.streakglobals.streakbundles["gunship"];
  var_8945c22a67231e20 = randomint(360);
  radiusoffset = 9000;
  zoffset = 8000;

  foreach(map in bundle.var_b46a22c71ca5e923) {
    if(issubstr(level.mapname, map.name)) {
      if(isDefined(map.gunship_radiusoffset)) {
        radiusoffset = map.gunship_radiusoffset;
      }

      if(isDefined(map.gunship_zoffset)) {
        zoffset += map.gunship_zoffset;
      }

      break;
    }
  }

  if(utility::iscp()) {
    player.start_position = player.origin;

    if(isDefined(level.var_82219b46e414a2ae)) {
      var_8945c22a67231e20 = level.var_82219b46e414a2ae;
    }
  }

  var_6a0d59565e047ea2 = getdvarint(@ "hash_9852a22e959385f5", 0);
  zoffset += var_6a0d59565e047ea2;
  radiusoffsetoverride = getdvarint(@ "hash_74da12841dc5abf8", 0);

  if(radiusoffsetoverride != 0) {
    radiusoffset = radiusoffsetoverride;
  }

  zoffsetoverride = getdvarint(@ "hash_e9998dac93d948d8", 0);

  if(zoffsetoverride != 0) {
    zoffset = 8000 + zoffsetoverride;
  }

  xoffset = cos(var_8945c22a67231e20) * radiusoffset;
  yoffset = sin(var_8945c22a67231e20) * radiusoffset;
  var_78ac3c5ef5263d4f = vectorNormalize((xoffset, yoffset, zoffset));
  var_78ac3c5ef5263d4f *= zoffset;
  level.gunshipinuse = 1;
  gunshipintro = gunship_playintro(player, streakinfo, var_8945c22a67231e20, var_78ac3c5ef5263d4f, var_2136b63785ee0579);

  if(!isDefined(gunshipintro)) {
    level.gunshipinuse = 0;
    return false;
  }

  gunship = gunship_spawn(player, streakinfo, var_8945c22a67231e20, var_78ac3c5ef5263d4f, gunshipintro, var_2136b63785ee0579);

  if(issharedfuncdefined("emp", "setEMP_Applied_Callback")) {
    gunship[[getsharedfunc("emp", "setEMP_Applied_Callback")]](&function_aaedf89b93495d4f);
  }

  if(!isDefined(gunship)) {
    level.gunshipinuse = 0;
    return false;
  }

  if(utility::iscp()) {
    level.gunship = gunship;
    level.gunship.var_d6604e5e3d0ba3b7 = bundle.var_b702d1aa92e3f7dc;
    level.gunship.var_d6604d5e3d0ba184 = bundle.var_2cb6918da56b085b;
    level.gunship.var_d660505e3d0ba81d = bundle.var_2b83894fc24a37fc;
  }

  if(issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    thread[[getsharedfunc("hud", "teamPlayerCardSplash")]]("used_gunship", player);
  }

  if(getdvarint(@ "camera_thirdperson")) {
    if(issharedfuncdefined("player", "setThirdPersonDOF")) {
      player[[getsharedfunc("player", "setThirdPersonDOF")]](0);
    }
  }

  if(issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    gunship[[getsharedfunc("killstreak", "addToActiveKillstreakList")]](gunship.streakinfo.streakname, "Killstreak_Air", player);
  }

  setlockedoncallback(gunship, &gunship_lockedoncallback);
  setlockedonremovedcallback(gunship, &gunship_lockedonremovedcallback);
  gunship thread gunship_attachgunner(player);
  gunship thread gunship_watchchangeweapons(player);
  gunship thread gunship_watchweaponfired(player);
  gunship thread gunship_watchthermaltoggle(player);
  gunship thread gunship_watchdamage(player);
  gunship thread gunship_watchtimeout(player);
  gunship thread gunship_watchgameend(player);
  gunship thread function_aafc33d685563aa4(player);
  gunship thread function_5fbd9704078207ad(player);
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
  gunship thread function_39464052869b655d(player);

  thirdpersoncam = getdvarint(@ "hash_f49f4fd233809e37", 0);

  if(thirdpersoncam) {
    gunship thread function_45ad456c933cbb32();
    gunship thread gunship_watchplanedistance(var_2136b63785ee0579);
  }

  if(issharedfuncdefined("flares", "handleIncomingStinger")) {
    gunship thread[[getsharedfunc("flares", "handleIncomingStinger")]](&gunship_handlemissiledetection);
  }

  gunship playLoopSound("iw8_ks_ac130_lp");

  if(istrue(player.ksempd)) {
    gunship thread gunship_crash(player);
  }

  return true;
}

function function_25233a050a5e41f0(owner, launchorigin) {
  gunshiprig = undefined;

  if(!islargemap()) {
    if(level.gunshiprigs.size > 0) {
      gunshiprig = level.gunshiprigs[0];
    }
  } else if(isDefined(level.gunshiprigs) && level.gunshiprigs.size >= 1) {
    return undefined;
  }

  if(!isDefined(gunshiprig)) {
    gunshiprig = spawn("script_model", launchorigin);
    gunshiprig setModel("tag_origin");
    gunshiprig.angles = (0, 115, 0);
    gunshiprig hide();
    level.gunshiprigs[level.gunshiprigs.size] = gunshiprig;
    gunshiprig thread gunship_rotaterig();

    if(!islargemap()) {
      gunshiprig thread function_486b043f227fca86();
    }
  }

  return gunshiprig;
}

function gunship_lockedoncallback() {
  playkillstreakoperatordialog("gunship", "gunship" + "_lockedon", 1, undefined, "pilot");
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("missileLocking", self.owner, "killstreak");
}

function gunship_lockedonremovedcallback() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("missileLocking", self.owner, "killstreak");
}

function gunship_playintro(player, streakinfo, angle, anglevector, var_2136b63785ee0579) {
  player endon("disconnect");
  level endon("game_ended");
  thirdpersoncam = 0;

  thirdpersoncam = getdvarint(@ "hash_f49f4fd233809e37", 0);

  if(thirdpersoncam) {
    streakinfo notify("<dev string:x1c>");
  }

  streakinfo endon("killstreak_finished_with_deploy_weapon");
  player disablephysicaldepthoffieldscripting();
  player gunship_allowstances(0);

  if(!thirdpersoncam) {
    player _stopshellshock();
    player val::group_set("gunshipIntro", 0);
  }

  gunshipintro = undefined;
  bundle = level.streakglobals.streakbundles["gunship"];

  level.gunship_animtype = getdvarint(@ "hash_a59a7da9fa17c00", 0);

  if(level.gunship_animtype == 1) {
    var_e4739db3b860ef4 = "intro_gunship";
    var_258b660f7db9aba6 = function_52351c3338da63f4("gunship", var_e4739db3b860ef4);
    gunshipintro = spawn("script_model", var_2136b63785ee0579.origin);
    gunshipintro setModel(bundle.gunship_intromodel);
    gunshipintro.angles = var_2136b63785ee0579.angles;
    gunshipintro setotherent(player);
    gunshipintro.animname = streakinfo.streakname;
    gunshipintro.owner = player;

    if(!thirdpersoncam) {
      foreach(var_6c3d15091efa3c48 in level.players) {
        if(var_6c3d15091efa3c48 != player) {
          gunshipintro hidefromplayer(var_6c3d15091efa3c48);
        }
      }

      gunshipintro thread gunship_hideintromodelonplayerconnect(player);
    }

    heightoffset = 2000;

    switch (level.mapname) {
      case #"hash_66ce5cdcd3b547f3":
      case #"hash_ff009e5fab42b778":
        heightoffset = 500;
        break;
    }

    gunshipintro linkTo(var_2136b63785ee0579, "tag_origin", anglevector - (0, 0, heightoffset), (0, angle + 90, 0));
    gunshipintro thread gunship_watchintrodisown("disconnect", streakinfo);
    gunshipintro thread gunship_watchintrodisown("joined_team", streakinfo);
    gunshipintro thread gunship_watchintrodisown("joined_spectators", streakinfo);
    gunshipintro thread gunship_watchintrodisown("player_fatal_death", streakinfo);
    waitframe();

    if(!isDefined(gunshipintro)) {
      return undefined;
    }

    gunshipintro scripts\common\anim::setanimtree();
    gunshipintro.var_ba27aac5a0f799e0 = spawn("script_model", gunshipintro.origin);
    gunshipintro.var_ba27aac5a0f799e0.angles = gunshipintro.angles;
    gunshipintro.var_ba27aac5a0f799e0 setModel("tag_origin");
    gunshipintro playsoundtoplayer("iw9_ks_ac130_intro", player);

    if(!thirdpersoncam) {
      player cameralinkTo(gunshipintro, "tag_player", 0, 1);
      player painvisionoff();
      player killstreak_savenvgstate();
      gunshipintro setscriptablepartstate("clouds_intro", "old", 0);
      gunshipintro setscriptablepartstate("bodyFX_intro", "on", 0);
      gunshipintro thread gunship_startintroshake(var_258b660f7db9aba6, player);
      gunshipintro thread gunship_queuecamerazoom(var_258b660f7db9aba6, player);
      gunshipintro thread function_c285675bee6618a3(var_258b660f7db9aba6, player);
    }

    player playkillstreakoperatordialog("gunship", "gunship" + "_use", 1, undefined, "pilot");
    gunshipintro.var_ba27aac5a0f799e0 scripts\common\anim::anim_single_solo(gunshipintro, var_e4739db3b860ef4);
  } else {
    bundle = level.streakglobals.streakbundles["gunship"];
    introz = 20000;

    foreach(map in bundle.var_b46a22c71ca5e923) {
      if(issubstr(level.mapname, map.name) && isDefined(map.introz)) {
        introz = map.introz;
      }
    }

    animpos = player.origin + anglesToForward(player.angles) * 100 + (0, 0, introz);

    var_b4a0772c51ea82ee = getdvarint(@ "hash_1fa8dffa69ff4ed8", 0);
    animpos += (0, 0, var_b4a0772c51ea82ee);

    var_d9979e10eec99504 = spawn("script_model", animpos);
    var_d9979e10eec99504 setModel("veh9_mil_air_gunship_interior_vm");
    var_5cb1f0f95e16878e = [];
    var_5cb1f0f95e16878e["gunship_interior"] = var_d9979e10eec99504;
    var_ba27aac5a0f799e0 = spawn("script_model", var_d9979e10eec99504 gettagorigin("tag_control_desk"));
    var_ba27aac5a0f799e0 setModel("tag_origin");
    var_ba27aac5a0f799e0.angles = var_d9979e10eec99504 gettagangles("tag_control_desk");
    gunshipintro = spawnStruct();
    gunshipintro.owner = player;
    gunshipintro.gunshipinterior = var_d9979e10eec99504;
    gunshipintro.var_9bc4ed07a250f4d3 = player function_d176c031e49a9127("gunship_interior_probe", "gunship_shadow_brush");
    gunshipintro thread gunship_watchintrodisown("disconnect", streakinfo);
    gunshipintro thread gunship_watchintrodisown("joined_team", streakinfo);
    gunshipintro thread gunship_watchintrodisown("joined_spectators", streakinfo);
    gunshipintro thread gunship_watchintrodisown("player_fatal_death", streakinfo);
    var_e618f33d2594b25b = undefined;

    foreach(modelindex, animmodel in level.var_9c7d2f4c2fc66b1f) {
      var_4d4d74b2657628ee = var_ba27aac5a0f799e0.origin;

      if(modelindex == "gunship_exterior") {
        var_e618f33d2594b25b = var_4d4d74b2657628ee + (0, 0, 200);
      }

      var_c43a209b29ea8ead = spawn("script_model", var_ba27aac5a0f799e0.origin);
      var_c43a209b29ea8ead setModel(animmodel);
      var_c43a209b29ea8ead setotherent(player);
      var_c43a209b29ea8ead.angles = var_ba27aac5a0f799e0.angles;
      var_c43a209b29ea8ead.animname = "gunship";
      var_c43a209b29ea8ead scripts\common\anim::setanimtree();

      if(modelindex == "desk") {
        var_e618f33d2594b25b = var_c43a209b29ea8ead;
      }

      if(modelindex == "joystick") {
        var_c43a209b29ea8ead dontinterpolate();
        var_c43a209b29ea8ead.origin = var_e618f33d2594b25b gettagorigin("tag_joystick_1");
        var_c43a209b29ea8ead linkTo(var_e618f33d2594b25b);
      }

      var_5cb1f0f95e16878e[modelindex] = var_c43a209b29ea8ead;
    }

    foreach(animent in var_5cb1f0f95e16878e) {
      if(!thirdpersoncam) {
        foreach(var_6c3d15091efa3c48 in level.players) {
          animent hidefromplayer(var_6c3d15091efa3c48);
        }

        animent thread gunship_hideintromodelonplayerconnect(player);
      }
    }

    gunshipintro.var_ba27aac5a0f799e0 = var_ba27aac5a0f799e0;
    gunshipintro.var_5cb1f0f95e16878e = var_5cb1f0f95e16878e;
    var_b8a46ae48904492c = "gunship_exterior";
    var_313a9e6067853ba8 = "intro_" + var_b8a46ae48904492c;
    var_1be95b011eb36224 = getdvarint(@ "hash_cc9d9505b48bc357", 0);

    if(var_1be95b011eb36224) {
      level.scr_anim["gunship"][var_313a9e6067853ba8] = % iw9_mp_acharlie130_intro_v2;
    } else {
      level.scr_anim["gunship"][var_313a9e6067853ba8] = % iw9_mp_acharlie130_intro;
    }

    player playsoundtoplayer("iw9_gunship_plr_intro", player);
    player playkillstreakoperatordialog("gunship", "gunship" + "_use", 1, undefined, "pilot");
    player painvisionoff();
    player killstreak_savenvgstate();
    player function_fa9987de43a6169b(gunshipintro, var_313a9e6067853ba8);
    gunshipintro function_7eb343dd6a3f639(player, "light_interior_intro", "on", "ks_gunship_interior_intro", 0);
    player function_fa9987de43a6169b(gunshipintro, "intro");
    gunshipintro function_7eb343dd6a3f639(player, "light_interior_intro", "off", "ks_gunship_interior_intro", 0.5);
  }

  gunshipintro notify("gunship_end_intro");

  if(!thirdpersoncam) {
    player disablephysicaldepthoffieldscripting();
    _stopshellshock();
    player val::group_reset("gunshipIntro");
  }

  return gunshipintro;
}

function gunship_watchintrodisown(action, streakinfo) {
  self endon("death");
  self endon("gunship_end_intro");
  level endon("game_ended");
  gunshipowner = self.owner;
  gunshipowner waittill(action);

  if(action == "disconnect") {
    level.gunshipinuse = 0;
  }

  gunship_detachplayerfromintro(gunshipowner, streakinfo);
}

function gunship_detachplayerfromintro(gunshipowner, streakinfo) {
  thirdpersoncam = 0;

  thirdpersoncam = getdvarint(@ "hash_f49f4fd233809e37", 0);

  if(isDefined(gunshipowner) && !thirdpersoncam) {
    gunshipowner cameraunlink();
    gunshipowner _stopshellshock();
    gunshipowner disablephysicaldepthoffieldscripting();
    gunshipowner val::group_reset("gunshipIntro");
    gunshipowner _setvisibiilityomnvarforkillstreak(streakinfo.streakname, "off");
    gunshipowner setclientomnvar("ui_gunship_hud", 0);
    gunshipowner painvisionon();
    gunshipowner killstreak_restorenvgstate();
    gunshipowner killstreak_setmainvision("");
    gunshipowner function_8b676f496920e2ab();
    gunshipowner notify("detach_gunship_intro");
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(gunshipowner, 0);
  }

  streakinfo notify("killstreak_finished_with_deploy_weapon");
  function_3856d3338b2c7ebf(self);
}

function gunship_hideintromodelonplayerconnect(owner) {
  self endon("death");
  owner endon("disconnect");

  while(true) {
    level waittill("connected", player);
    self hidefromplayer(player);
  }
}

function function_c285675bee6618a3(animlength, owner, introsequence) {
  self endon("death");
  owner endon("disconnect");
  owner endon("detach_gunship_intro");
  owner enablephysicaldepthoffieldscripting();

  if(isDefined(introsequence)) {
    if(introsequence == "intro_gunship_exterior") {
      owner setphysicaldepthoffield(1.4, 87, 10, 10);
      phase1dof = animlength * 0.25;
      phase2dof = animlength * 0.65;
      thread function_37b61f53bc7c8643(owner, phase1dof, 2.2, 87, 50, 50);
      thread function_37b61f53bc7c8643(owner, phase2dof, 4, 350, 1, 1);
      return;
    }

    if(introsequence == "intro") {
      owner setphysicaldepthoffield(1.4, 21, 1000, 1000);
      phase1dof = animlength * 0.8;
      thread function_37b61f53bc7c8643(owner, phase1dof, 1.4, 43, 50, 50);
      return;
    }

    owner setphysicaldepthoffield(1.4, 43, 1000, 1000);
    phase1dof = animlength * 0.5;
    phase2dof = animlength * 0.7;
    thread function_37b61f53bc7c8643(owner, phase1dof, 1.4, 20, 50, 50);
    thread function_37b61f53bc7c8643(owner, phase2dof, 3, 100, 50, 50);
  }
}

function function_37b61f53bc7c8643(owner, delaytime, fstop, focusdistance, focusspeed, var_5587778bb9d6e798) {
  self endon("death");
  owner endon("disconnect");
  owner endon("detach_gunship_intro");
  wait delaytime;
  owner setphysicaldepthoffield(fstop, focusdistance, focusspeed, var_5587778bb9d6e798);
}

function gunship_startintroshake(animlength, owner, introsequence) {
  self endon("death");
  owner endon("disconnect");
  owner endon("detach_gunship_intro");
  animtime = animlength;
  eqscale = 0.45;
  shaketime = 0.05;

  if(isDefined(introsequence)) {
    if(introsequence == "intro_gunship_exterior") {
      eqscale = 0.01;
      shaketime = 0.25;
    }
  }

  while(animtime > 0) {
    owner earthquakeforplayer(eqscale, shaketime, self.origin, 5000);

    if(isDefined(introsequence)) {
      if(introsequence == "intro_gunship_exterior") {
        eqscale += 0.01;

        if(eqscale >= 0.1) {
          eqscale = 0.1;
        }
      }
    } else {
      eqscale -= 0.01;

      if(eqscale <= 0.12) {
        eqscale = 0.12;
      }
    }

    animtime -= shaketime;
    wait shaketime;
  }
}

function gunship_queuecamerazoom(animlength, owner) {
  self endon("death");
  owner endon("disconnect");
  owner endon("detach_gunship_intro");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(animlength - 0.2);
  owner killstreak_setmainvision("killstreak_slamzoom");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(owner, 1, 0.1);
}

function function_2be9ae7928984f8(animlength, owner) {
  owner endon("disconnect");
  level endon("game_ended");
  owner endon("detach_gunship_intro");
  wait animlength - 0.3;
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(owner, 1, 0.3);
  wait 0.7;
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(owner, 0, 0.3);
}

function gunship_returnplayer(player, crashing) {
  level callback::callback("killstreak_finish_use", {
    #streakinfo: self.streakinfo
  });

  if(isDefined(player)) {
    player endon("disconnect");
    thirdpersoncam = 0;

    thirdpersoncam = getdvarint(@ "hash_f49f4fd233809e37", 0);

    if(!thirdpersoncam) {
      player _stopshellshock();
    }

    player setclientomnvar("ui_killstreak_thermal_mode", 0);
    player setthermalvision(0);
    player _setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "off");
    player setclientomnvar("ui_gunship_hud", 0);
    player stoploopsound();
    player killstreak_setmainvision("");
    player clearclienttriggeraudiozone(0.5);
    player painvisionon();
    player _stopshellshock();
    player clearcinematicmotionoverride();

    if(issharedfuncdefined("game", "disable_backpack_inventory")) {
      player[[getsharedfunc("game", "disable_backpack_inventory")]](0);
    }

    player val::reset("gunship_weap_swap_safety", "weapon_switch");
    player notify("returning_killstreak_player");
    player.usinggunship = undefined;

    if(getdvarint(@ "camera_thirdperson")) {
      if(issharedfuncdefined("player", "setThirdPersonDOF")) {
        player[[getsharedfunc("player", "setThirdPersonDOF")]](1);
      }
    }

    if(isDefined(player.gunship_cloudsfx)) {
      player.gunship_cloudsfx delete();
    }

    if(!thirdpersoncam) {
      if(player scripts\cp_mp\utility\player_utility::_isalive()) {
        player _giveweapon(level.var_89d6f5464d64ebf4);
        player _switchtoweaponimmediate(level.var_89d6f5464d64ebf4);
      }

      player unlink();

      if(istrue(crashing) && level.gunship_animtype == 0) {
        player waittill("finished_gunship_anim_outro");
        player killstreak_setmainvision("killstreak_static");
        wait 1;
        player cameraunlink();
        player killstreak_setmainvision("");
      }

      player val::group_reset("gunshipUse");
      player gunship_allowstances(1);
      player function_8b676f496920e2ab();
      player killstreak_restorenvgstate();
      player thread gunship_restoreplayerweapon(self.streakinfo);
    } else {
      self.streakinfo notify("<dev string:x1c>");
    }
  }

  function_3856d3338b2c7ebf(self.gunshipintro);
  gunship_lockedonremovedcallback();

  if(isDefined(self.enemytargetmarkergroup)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.enemytargetmarkergroup);
  }

  if(isDefined(self.friendlytargetmarkergroup)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.friendlytargetmarkergroup);
  }

  if(issharedfuncdefined("gunship", "br_respawn")) {
    [[getsharedfunc("gunship", "br_respawn")]](player);
  }

  level.gunshipinuse = 0;
}

function gunship_restoreplayerweapon(streakinfo) {
  self endon("disconnect");
  streakinfo notify("killstreak_finished_with_deploy_weapon");
  var_263d5a6c4338e56c = getanimlength(%vm_ks_tablet_drop);
  bundle = level.streakglobals.streakbundles["gunship"];

  if(_isalive()) {
    val::set("gunshipExit", "fire", 0);
    val::set("gunshipExit", "allow_movement", 0);
    val::set("gunshipExit", "offhand_weapons", 0);
    val::set("gunshipExit", "mantle", 0);
    val::set("gunshipExit", "melee", 0);
    wait 0.05;
    _switchtoweapon(self.lastdroppableweaponobj);
    wait var_263d5a6c4338e56c;
    _takeweapon(bundle.var_b702d1aa92e3f7dc);
    _takeweapon(bundle.var_2cb6918da56b085b);
    _takeweapon(bundle.var_2b83894fc24a37fc);
    _takeweapon(level.var_89d6f5464d64ebf4);
    val::reset_all("gunshipExit");
  }
}

function gunship_watchdamage(gunner) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  self.damagetaken = 0;
  self.attractor = missile_createattractorent(self, 1000, 4096);
  bundle = level.streakglobals.streakbundles["gunship"];

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon);
    thirdpersoncam = undefined;
    debugdamage = undefined;

    thirdpersoncam = getdvarint(@ "hash_f49f4fd233809e37", 0);
    debugdamage = istrue(self.debugdamage);

    if(isDefined(level.teambased) && isPlayer(attacker) && attacker.team == self.team && (!isDefined(thirdpersoncam) || !thirdpersoncam) && (!isDefined(debugdamage) || !debugdamage)) {
      continue;
    }

    if(smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_EXPLOSIVE_BULLET") {
      continue;
    }

    if(isDefined(gunner) && gunner isusinggunship()) {
      var_bb22d61320ffe92d = "light";

      if(isexplosivedamagemod(smeansofdeath)) {
        if(ceil(damage / self.maxhealth) >= bundle.var_900fc143f1a96ed2) {
          gunner earthquakeforplayer(0.25, 0.2, self.camera.origin, 150);
          gunner playRumbleOnEntity("damage_heavy");
          var_bb22d61320ffe92d = "heavy";
        } else {
          gunner earthquakeforplayer(0.15, 0.15, self.camera.origin, 150);
          gunner playRumbleOnEntity("damage_light");
        }
      }

      gunner function_c144de677d9b9175(self.currentvisionset, var_bb22d61320ffe92d);
    }

    self.wasdamaged = 1;
    modifieddamage = undefined;

    if(isDefined(debugdamage)) {
      modifieddamage = damage;
    } else if(issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage")) {
      modifieddamage = self[[getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](attacker, objweapon, smeansofdeath, damage, self.maxhealth, 4, 5, 25, 0, 350);
    }

    if(isPlayer(attacker)) {
      if(issharedfuncdefined("damage", "updateDamageFeedback")) {
        attacker[[getsharedfunc("damage", "updateDamageFeedback")]]("hitequip");
      }
    }

    if(issharedfuncdefined("killstreak", "killstreakHit")) {
      [[getsharedfunc("killstreak", "killstreakHit")]](attacker, objweapon, self, smeansofdeath, modifieddamage);
    }

    if(isDefined(attacker.owner) && isPlayer(attacker.owner)) {
      if(issharedfuncdefined("damage", "updateDamageFeedback")) {
        attacker.owner[[getsharedfunc("damage", "updateDamageFeedback")]]("hitequip");
      }
    }

    self.damagetaken += modifieddamage;
    self.currenthealth -= modifieddamage;
    killstreak_updatedamagestate(self.currenthealth);

    if(self.damagetaken >= self.maxhealth) {
      streakname = self.streakinfo.streakname;
      damagetype = undefined;
      scorepopupname = "destroyed_" + streakname;
      leaderdialog = undefined;
      cardsplash = "callout_destroyed_" + streakname;
      skipdeathnotify = 1;

      if(isPlayer(attacker)) {
        if(issharedfuncdefined("hud", "teamPlayerCardSplash")) {
          thread[[getsharedfunc("hud", "teamPlayerCardSplash")]](cardsplash, attacker);
        }
      }

      if(scripts\engine\utility::issharedfuncdefined("damage", "onKillstreakKilled") && isDefined(attacker) && (isPlayer(attacker) || isDefined(attacker.owner))) {
        notifyattacker = self[[scripts\engine\utility::getsharedfunc("damage", "onKillstreakKilled")]](streakname, attacker, objweapon, damagetype, damage, scorepopupname, leaderdialog, cardsplash, skipdeathnotify);
      }

      thread gunship_crash(gunner);
    }
  }
}

function function_fd00f7fcdbcd8972() {
  self setscriptablepartstate("body_damage_light", "on");
  gunner = self.owner;

  if(isDefined(gunner) && gunner isusinggunship()) {
    self.flashlight setscriptablepartstate("camera_damage_light", "on");
    gunner playkillstreakoperatordialog("gunship", "gunship" + "_light_damage", 1, undefined, "pilot");
  }
}

function function_ab0ec37ba0afd257() {
  self setscriptablepartstate("body_damage_light", "off");
  self setscriptablepartstate("body_damage_medium", "on");
  gunner = self.owner;

  if(isDefined(gunner) && gunner isusinggunship()) {
    self.flashlight setscriptablepartstate("camera_damage_medium", "on");
    gunner playkillstreakoperatordialog("gunship", "gunship" + "_med_damage", 1, undefined, "pilot");
    gunner playlocalsound("ks_ac130_damage_warning");
    gunner setclienttriggeraudiozone("gunship_killstreak_damaged", 2);
  }
}

function function_cf130118900c4c47() {
  self setscriptablepartstate("body_damage_medium", "off");
  self setscriptablepartstate("contrails", "off");
  thread gunship_startengineblowoutfx();
  gunner = self.owner;

  if(isDefined(gunner) && gunner isusinggunship()) {
    self.flashlight setscriptablepartstate("camera_damage_heavy", "on");
    gunner playkillstreakoperatordialog("gunship", "gunship" + "_heavy_damage", 1, undefined, "pilot");
  }
}

function gunship_startengineblowoutfx() {
  level endon("game_ended");
  self.leftwingfxent setscriptablepartstate("engine_blowout", "on");
  self.leftwingfxent setscriptablepartstate("body_damage_heavy", "on");
  randomwait = randomfloatrange(0.5, 1);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(randomwait);
  self.rightwingfxent setscriptablepartstate("engine_blowout", "on");
  self.rightwingfxent setscriptablepartstate("body_damage_heavy", "on");
}

function gunship_watchtimeout(gunner) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(self.timeout);
  thread gunship_leave(gunner);
}

function gunship_watchgameend(gunner) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level waittill_any_2("start_game_ended", "game_ended");
  thread gunship_leave(gunner);
}

function gunship_leave(gunner) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  self notify("leaving");
  self unlink();
  self rotateroll(30, 3);
  currentangles = self.angles;
  currentdir = anglesToForward(currentangles);

  if(isDefined(self.owner)) {
    self.owner playkillstreakoperatordialog("gunship", "gunship" + "_leave", 1, undefined, "pilot");
  }

  thread gunship_returnplayer(gunner);
  self moveTo(self.origin + currentdir * 50000, 10, 5);
  gunship_waittilldestination(self.origin + currentdir * 50000);
  gunship_removeplane(0);
}

function gunship_waittilldestination(destination) {
  while(isDefined(self) && self.origin != destination) {
    waitframe();
  }
}

function gunship_watchownerexitaction(gunner, exitaction) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  gunner waittill(exitaction);

  if(exitaction == "player_fatal_death") {
    thread gunship_leave(gunner);
    return;
  }

  thread gunship_crash(gunner);
}

function gunship_watchendgame(gunner) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  gunner endon("disconnect");
  level waittill("game_ended");
  gunner _setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "off");
  gunner setclientomnvar("ui_gunship_hud", 0);
}

function gunship_trackvelocity(gunner) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  self.velocity = (0, 0, 0);

  while(true) {
    self.lastorigin = self.origin;
    wait level.framedurationseconds;
    self.velocity = (self.origin - self.lastorigin) / level.framedurationseconds;
  }
}

function gunship_spawn(owner, streakinfo, angle, anglevector, gunshipintro, var_2136b63785ee0579) {
  bundle = level.streakglobals.streakbundles["gunship"];
  gunship = spawn("script_model", var_2136b63785ee0579.origin);
  gunship setModel(bundle.var_9db3c2a9aa0ab053);
  gunship setCanDamage(1);
  gunship.currenthealth = bundle.maxhealth;
  gunship.maxhealth = gunship.currenthealth;
  gunship.health = 99999;
  gunship.owner = owner;
  gunship.team = owner.team;
  gunship.gunshipintro = gunshipintro;
  gunship.var_2136b63785ee0579 = var_2136b63785ee0579;
  gunship.ispiloted = 1;
  gunship.timeout = bundle.gunship_lifetime;

  if(issharedfuncdefined("gunship", "attachXRays")) {
    gunship = [[getsharedfunc("gunship", "attachXRays")]](gunship);
  }

  gunship.hellfireloaded = 1;
  hellfiretarget = spawn("script_model", gunship.origin);
  hellfiretarget setModel("tag_origin");
  gunship.hellfiretarget = hellfiretarget;

  if(islargemap()) {
    var_2136b63785ee0579 thread function_f14aa90c4ef905d2(gunship);
  }

  gunship scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", owner, undefined, undefined, 1, 0);
  gunship function_cfc5e3633ef950fd(1, bundle.var_bfb39f38f09df343, &function_fd00f7fcdbcd8972);
  gunship function_cfc5e3633ef950fd(2, bundle.var_bde8ccf56d975fe4, &function_ab0ec37ba0afd257);
  gunship function_cfc5e3633ef950fd(3, bundle.var_a59fd30a2552ed85, &function_cf130118900c4c47);

  timeoutoverride = getdvarint(@ "hash_fa402c92e4148a39", bundle.gunship_lifetime);
  var_2a98d1683cf44153 = getdvarint(@ "hash_2c01d701bac5d9d3", 0);

  if(var_2a98d1683cf44153) {
    timeoutoverride = 9999;
  }

  gunship.timeout = timeoutoverride;

  if(isDefined(level.var_aa1e2ad7dc79adc6)) {
    gunship.timeout = level.var_aa1e2ad7dc79adc6;
  }

  gunship.flaresreservecount = bundle.var_b5d84be31a39bf30;
  gunship.streakinfo = streakinfo;
  gunship scriptmoveroutline();
  gunship scriptmoverthermal();
  gunship setotherent(owner);
  minimapid = undefined;

  if(scripts\engine\utility::issharedfuncdefined("game", "createObjective")) {
    minimapid = gunship[[scripts\engine\utility::getsharedfunc("game", "createObjective")]]("hud_icon_minimap_killstreak_gunship", gunship.team, 0, 1, 1);
  }

  gunship.minimapid = minimapid;
  gunship linkTo(var_2136b63785ee0579, "tag_origin", anglevector, (0, angle + 90, -30));
  level notify("matchrecording_plane", gunship);
  return gunship;
}

function gunship_updateoverlaycoords(plane) {
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

function gunship_updateplanemodelcoords(plane) {
  plane endon("death");
  plane endon("crashing");
  plane endon("leaving");
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    self setclientomnvar("ui_gunship_coord1_posx", int(plane.origin[0]));
    self setclientomnvar("ui_gunship_coord1_posy", int(plane.origin[1]));
    self setclientomnvar("ui_gunship_coord1_posz", int(plane.origin[2]));
    wait 0.5;
  }
}

function gunship_updateplayerpositioncoords(plane) {
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

function gunship_updateaimingcoords(plane) {
  plane endon("death");
  plane endon("crashing");
  plane endon("leaving");
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    starttrace = self getvieworigin();
    endtrace = starttrace + anglesToForward(self getplayerangles()) * 15000;
    endpos = physicstrace(starttrace, endtrace);
    self setclientomnvar("ui_gunship_coord3_posx", int(endpos[0]));
    self setclientomnvar("ui_gunship_coord3_posy", int(endpos[1]));
    self setclientomnvar("ui_gunship_coord3_posz", int(endpos[2]));
    wait 0.1;
  }
}

function gunship_rotaterig() {
  self endon("death");
  rampupdegrees = 10;
  rotatetime = level.gunship_speed["rotate"] / 360 * rampupdegrees;
  self rotateYaw(self.angles[2] + rampupdegrees, rotatetime, rotatetime, 0);
  degreespersecond = 360 / level.gunship_speed["rotate"];
  var_31fc5244269dae18 = degreespersecond * 0.0174533;
  level.gunship_magnitude = var_31fc5244269dae18 * 9000;

  while(true) {
    self rotateYaw(360, level.gunship_speed["rotate"]);
    wait level.gunship_speed["rotate"];
  }
}

function gunship_attachgunner(gunner) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  gunner killstreak_setmainvision("");
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(gunner, 0, 0.1);

  thirdpersoncam = getdvarint(@ "hash_f49f4fd233809e37", 0);

  if(thirdpersoncam) {
    if(level.gunship_animtype == 1) {
      function_3856d3338b2c7ebf(self.gunshipintro);
    } else {
      gunner function_5efa20e5c624be8f(self.gunshipintro);
    }

    self.streakinfo notify("<dev string:x1c>");
    return;
  }

  bundle = level.streakglobals.streakbundles["gunship"];
  gunner _giveweapon(bundle.var_b702d1aa92e3f7dc);
  gunner _giveweapon(bundle.var_2cb6918da56b085b);
  gunner _giveweapon(bundle.var_2b83894fc24a37fc);
  gunner _switchtoweaponimmediate(bundle.var_b702d1aa92e3f7dc);
  gunner val::set("gunship_weap_swap_safety", "weapon_switch", 0);

  if(isDefined(level.gunshipvisionset)) {
    self.currentvisionset = level.gunshipvisionset;
  } else {
    self.currentvisionset = bundle.var_7a35928e082dd9b7;

    if(isDefined(level.mapname) && (issubstr(level.mapname, "_shipment") || issubstr(level.mapname, "mp_skerries"))) {
      self.currentvisionset = bundle.var_6070115b879adfc9;
    }
  }

  waitframe();
  gunner cameraunlink();

  if(level.gunship_animtype == 1) {
    function_3856d3338b2c7ebf(self.gunshipintro);
  } else {
    gunner function_5efa20e5c624be8f(self.gunshipintro);
  }

  self.camera = spawn("script_model", self.origin - (0, 0, 20));
  self.camera setModel("tag_player");
  self.camera.angles = vectortoangles(self.var_2136b63785ee0579.origin - self.camera.origin);
  self.camera linkTo(self);

  if(isbot(gunner)) {
    gunner cameralinkTo(self.camera, "tag_player");
    return;
  }

  arcclamps = function_58415bfdad59562c(bundle);
  gunner playkillstreakoperatordialog("gunship", "gunship" + "_engage", 1, undefined, "pilot");
  gunner.usinggunship = 1;
  gunner playerlinkweaponviewtodelta(self.camera, "tag_player", 1, arcclamps[0], arcclamps[1], arcclamps[2], arcclamps[3], 0, 1, 1);
  gunner playerlinkedsetviewznear(0);
  gunner killstreak_setmainvision(self.currentvisionset);
  gunner setclienttriggeraudiozone("gunship_killstreak", 2);
  gunner setplayerangles(self.camera.angles);
  gunner val::set("gunshipUse", "ads", 1);
  gunner setcinematicmotionoverride("player_gunship_ride_mp");
  gunner thread function_d13d2a81214fbfb8("65_instant_noscale");
  gunner _setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "on");
  gunner setclientomnvar("ui_gunship_hud", 1);
  gunner setclientomnvar("ui_killstreak_weapon_1_ammo", gunner getweaponammoclip(bundle.var_b702d1aa92e3f7dc));
  gunner setclientomnvar("ui_killstreak_weapon_2_ammo", gunner getweaponammoclip(bundle.var_2cb6918da56b085b));
  gunner setclientomnvar("ui_killstreak_weapon_3_ammo", gunner getweaponammoclip(bundle.var_2b83894fc24a37fc));
  gunner setclientomnvar("ui_killstreak_countdown", gettime() + int(self.timeout * 1000));
  gunner setclientomnvar("ui_killstreak_health", self.maxhealth);
  gunner setclientomnvar("ui_killstreak_flares", self.flaresreservecount);
  gunner setclientomnvar("ui_killstreak_damage_state", 0);
  gunner _shellshock("killstreak_veh_camera_mp", "top", self.timeout, 0);
  gunner _stopshellshock();
  gunner val::group_set("gunshipUse", 0);

  if(issharedfuncdefined("gunship", "assignTargetMarkers")) {
    self thread[[getsharedfunc("gunship", "assignTargetMarkers")]](gunner);
  }

  gunner thread gunship_updateoverlaycoords(self);
  thread function_9214536761e6be23(bundle.var_b702d1aa92e3f7dc);
}

function function_58415bfdad59562c(bundle) {
  rightarcclamp = 100;
  leftarcclamp = 100;
  toparcclamp = 17;
  bottomarcclamp = 90;

  foreach(map in bundle.var_b46a22c71ca5e923) {
    if(issubstr(level.mapname, map.name)) {
      if(isDefined(map.rightarcclamp)) {
        rightarcclamp = map.var_fbfc9b3202a01d51;
      }

      if(isDefined(map.leftarcclamp)) {
        leftarcclamp = map.var_112ab36579abf6b2;
      }

      if(isDefined(map.toparcclamp)) {
        toparcclamp = map.var_63dc0140ad437800;
      }

      if(isDefined(map.bottomarcclamp)) {
        bottomarcclamp = map.var_858f316c3c5c0478;
      }

      break;
    }
  }

  if(getdvarint(@ "hash_a9dd72f919820c3c", -1) >= 0) {
    rightarcclamp = getdvarint(@ "hash_a9dd72f919820c3c", -1);
  }

  if(getdvarint(@ "hash_f6f54c4504a08e99", -1) >= 0) {
    leftarcclamp = getdvarint(@ "hash_f6f54c4504a08e99", -1);
  }

  if(getdvarint(@ "hash_be524367b2923ffd", -1) >= 0) {
    toparcclamp = getdvarint(@ "hash_be524367b2923ffd", -1);
  }

  if(getdvarint(@ "hash_276a14d37ceed71f", -1) >= 0) {
    bottomarcclamp = getdvarint(@ "hash_276a14d37ceed71f", -1);
  }

  return [rightarcclamp, leftarcclamp, toparcclamp, bottomarcclamp];
}

function function_623a9b1b10d1db2e(gunner) {
  gunner endon("disconnect");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");

  if(!ismp()) {
    return;
  }

  if(!istrue(level.gunship_lockon)) {
    return;
  }

  thread function_7f87e01d436c03cc(gunner);

  while(true) {
    if(gunner adsButtonPressed()) {
      currentweapon = gunner getcurrentweapon();
      bundle = level.streakglobals.streakbundles["gunship"];

      if(currentweapon.basename == bundle.var_b702d1aa92e3f7dc) {
        function_dceaa78f8d315302(gunner, 1);
        self notify("gunship_reset_hellfire_lockon");
      }
    }

    waitframe();
  }
}

function function_7f87e01d436c03cc(gunner) {
  gunner endon("disconnect");
  level endon("game_ended");

  while(true) {
    result = waittill_any_return_4("death", "leaving", "crashing", "gunship_reset_hellfire_lockon");

    if(issharedfuncdefined("gunship", "ResetMissileLauncherLocking")) {
      gunner[[getsharedfunc("gunship", "ResetMissileLauncherLocking")]]();
    }

    gunner.var_2bd8b6befeeb2b63 = undefined;
    gunner setclientomnvar("ui_gunship_hellfire_lockon", 0);

    if(result != "gunship_reset_hellfire_lockon") {
      break;
    }
  }
}

function function_dceaa78f8d315302(gunner, var_cc706c96147ed540) {
  gunner endon("disconnect");
  level endon("game_ended");

  while(gunner adsButtonPressed()) {
    if((gunner playerads() >= 0.95 || istrue(var_cc706c96147ed540)) && istrue(self.hellfireloaded)) {
      gunner.missilelauncheruseentered = 1;
      targets = [];

      if(issharedfuncdefined("gunship", "lockOnLaunchers_getTargetArray")) {
        targets = [[getsharedfunc("gunship", "lockOnLaunchers_getTargetArray")]](0);
      }

      if(targets.size == 0) {
        self notify("gunship_reset_hellfire_lockon");
        waitframe();
        continue;
      }

      targets = sortbydistance(targets, gunner.origin);

      if(!isDefined(gunner.missilelauncherstage)) {
        gunner.missilelauncherstage = 0;
      }

      if(gunner.missilelauncherstage == 0) {
        stingtargstruct = undefined;
        var_c7f50dd357b9cdcf = 0;

        foreach(target in targets) {
          if(!isDefined(target)) {
            continue;
          }

          stingtargstruct = function_a3ec651ef5989fb9(gunner, target);

          if(isDefined(stingtargstruct)) {
            break;
          }
        }

        if(!isDefined(stingtargstruct)) {
          self notify("gunship_reset_hellfire_lockon");
          waitframe();
          continue;
        }

        gunner.missilelaunchertarget = stingtargstruct.target;
        gunner.missilelauncherlockstarttime = gettime();
        gunner.missilelauncherlostsightlinetime = 0;

        if(isDefined(gunner.missilelaunchertarget)) {
          addlockedon(gunner.missilelaunchertarget, gunner);
        }

        thread function_2b613e06060d8b55(gunner);
        gunner.missilelauncherstage = 1;
      }

      if(gunner.missilelauncherstage == 1) {
        var_f05aefecc4f91279 = function_a3ec651ef5989fb9(gunner);

        if(!isDefined(var_f05aefecc4f91279)) {
          self notify("gunship_reset_hellfire_lockon");
          waitframe();
          continue;
        }

        timepassed = gettime() - gunner.missilelauncherlockstarttime;

        if(timepassed < 500) {
          waitframe();
          continue;
        }

        self notify("stop_gunship_hellfire_locking_sfx");
        thread function_75eee29aa3795a05(gunner);
        gunner.missilelauncherstage = 2;
      }

      if(gunner.missilelauncherstage == 2) {
        var_f05aefecc4f91279 = function_a3ec651ef5989fb9(gunner);

        if(!isDefined(var_f05aefecc4f91279)) {
          self notify("gunship_reset_hellfire_lockon");
          waitframe();
          continue;
        }

        if(!istrue(gunner.var_2bd8b6befeeb2b63)) {
          gunner setclientomnvar("ui_gunship_hellfire_lockon", 1);
          gunner.var_2bd8b6befeeb2b63 = 1;

          if(issharedfuncdefined("gunship", "missileLauncher_finalizeLock")) {
            gunner[[getsharedfunc("gunship", "missileLauncher_finalizeLock")]](var_f05aefecc4f91279);
          }

          waitframe();
          continue;
        }
      }
    }

    waitframe();
  }
}

function function_2b613e06060d8b55(gunner) {
  gunner endon("disconnect");
  self endon("death");
  self endon("crashing");
  self endon("explode");
  self endon("gunship_reset_hellfire_lockon");
  self endon("stop_gunship_hellfire_locking_sfx");
  level endon("game_ended");
  bundle = level.streakglobals.streakbundles["gunship"];

  while(true) {
    gunner playlocalsound(bundle.var_8d665c5e920f57d7);
    gunner playRumbleOnEntity(bundle.var_dda37cdc1cceaa1d);
    wait 0.6;
  }
}

function function_75eee29aa3795a05(gunner) {
  gunner endon("disconnect");
  self endon("death");
  self endon("crashing");
  self endon("explode");
  self endon("gunship_reset_hellfire_lockon");
  level endon("game_ended");
  bundle = level.streakglobals.streakbundles["gunship"];
  gunner playlocalsound(bundle.var_615f5055e4f0b368);

  while(true) {
    gunner playRumbleOnEntity(bundle.var_f21822264fab160);
    wait 0.25;
  }
}

function function_a3ec651ef5989fb9(gunner, targetoverride) {
  var_e688b198aa9a4b3f = 0;

  var_e688b198aa9a4b3f = getdvarint(@ "hash_10368af4dee3ba2c", 0);

  lockontarget = undefined;

  if(isDefined(gunner.missilelaunchertarget)) {
    lockontarget = gunner.missilelaunchertarget;
  } else if(isDefined(targetoverride)) {
    lockontarget = targetoverride;
  }

  if(!isDefined(lockontarget)) {
    return undefined;
  }

  if(!var_e688b198aa9a4b3f && lockontarget scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer(lockontarget, gunner)) {
    return undefined;
  }

  stingtargstruct = undefined;

  if(issharedfuncdefined("gunship", "stingTargStruct_create")) {
    stingtargstruct = [[getsharedfunc("gunship", "stingTargStruct_create")]](gunner, lockontarget);
  }

  if(!isDefined(stingtargstruct)) {
    return undefined;
  }

  if(issharedfuncdefined("gunship", "stingTargStruct_getOffsets")) {
    stingtargstruct[[getsharedfunc("gunship", "stingTargStruct_getOffsets")]]();
  }

  if(issharedfuncdefined("gunship", "stingTargStruct_getOrigins")) {
    stingtargstruct[[getsharedfunc("gunship", "stingTargStruct_getOrigins")]]();
  }

  if(issharedfuncdefined("gunship", "stingTargStruct_getInReticle")) {
    stingtargstruct[[getsharedfunc("gunship", "stingTargStruct_getInReticle")]]();
  }

  if(issharedfuncdefined("gunship", "stingTargStruct_isInReticle")) {
    if(!stingtargstruct[[getsharedfunc("gunship", "stingTargStruct_isInReticle")]]()) {
      return undefined;
    }
  }

  if(issharedfuncdefined("gunship", "stingTargStruct_getInLOS")) {
    stingtargstruct[[getsharedfunc("gunship", "stingTargStruct_getInLOS")]]();
  }

  if(issharedfuncdefined("gunship", "SoftSightTest")) {
    if(!gunner[[getsharedfunc("gunship", "SoftSightTest")]](stingtargstruct)) {
      return undefined;
    }
  }

  return stingtargstruct;
}

function gunship_watchchangeweapons(gunner) {
  gunner endon("disconnect");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");

  thirdpersoncam = getdvarint(@ "hash_f49f4fd233809e37", 0);

  if(thirdpersoncam) {
    return;
  }

  bundle = level.streakglobals.streakbundles["gunship"];
  weaponlistorder = [bundle.var_b702d1aa92e3f7dc, bundle.var_2cb6918da56b085b, bundle.var_2b83894fc24a37fc];
  currentweaponindex = weaponlistorder.size;

  if(!isai(gunner)) {
    gunner notifyonplayercommand("gunship_switch_weapon_next", "+weapnext");
    gunner notifyonplayercommand("gunship_switch_weapon_next", "selectweapon2");
    gunner notifyonplayercommand("gunship_switch_weapon_prev", "+weapprev");
    gunner notifyonplayercommand("gunship_switch_weapon_prev", "selectweapon1");
    gunner setclientomnvar("ui_killstreak_weapon", currentweaponindex);
  }

  gunner val::set("gunship_weap_swap_safety", "weapon_switch", 1);

  while(true) {
    cmd = gunner waittill_any_return_2("gunship_switch_weapon_prev", "gunship_switch_weapon_next");

    if(!isDefined(cmd)) {
      continue;
    }

    gunner playlocalsound("iw8_ks_ac130_weaponswitch");
    currentweapon = gunner getcurrentweapon();
    newweapon = undefined;

    foreach(index, weapon in weaponlistorder) {
      if(currentweapon.basename == weapon) {
        if(cmd == "gunship_switch_weapon_prev") {
          newweaponindex = index - 1;

          if(newweaponindex < 0) {
            newweaponindex = weaponlistorder.size - 1;
          }
        } else {
          newweaponindex = index + 1;

          if(newweaponindex > weaponlistorder.size - 1) {
            newweaponindex = 0;
          }
        }

        newweapon = weaponlistorder[newweaponindex];
        break;
      }
    }

    if(self.currentvisionset == function_44e0bd95b98288ab()) {
      dofinfo = gunship_getdofinfobyweapon(newweapon);
      gunner setphysicaldepthoffield(dofinfo.fstop, dofinfo.focusdistance, 20, 20);
    }

    if(cmd == "gunship_switch_weapon_prev") {
      currentweaponindex++;

      if(currentweaponindex > weaponlistorder.size) {
        currentweaponindex = 1;
      }
    } else {
      currentweaponindex--;

      if(currentweaponindex == 0) {
        currentweaponindex = weaponlistorder.size;
      }
    }

    if(!isDefined(newweapon)) {
      newweapon = weaponlistorder[currentweaponindex - 1];
    }

    if(newweapon != bundle.var_b702d1aa92e3f7dc) {
      gunner notify("gunship_hellfire_disable_tracking");
    }

    gunner _switchtoweaponimmediate(newweapon);
    gunner setclientomnvar("ui_killstreak_weapon", currentweaponindex);
    gunner function_58707ddfdd9744fa("killstreak_weapon_change_shutter");
    thread function_9214536761e6be23(newweapon);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.4);
  }
}

function gunship_watchweaponfired(gunner) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");

  thirdpersoncam = getdvarint(@ "hash_f49f4fd233809e37", 0);

  if(thirdpersoncam) {
    return;
  }

  streakinfo = self.streakinfo;
  bundle = level.streakglobals.streakbundles["gunship"];

  while(true) {
    gunner waittill("missile_fire", projectile);
    projectile.streakinfo = streakinfo;
    streakinfo.shots_fired++;
    weapon = gunner getcurrentweapon();
    currentammo = gunner getweaponammoclip(weapon);

    if(weapon.basename == bundle.var_b702d1aa92e3f7dc) {
      earthquake(0.2, 1, self.origin, 1000);
      gunner setclientomnvar("ui_killstreak_weapon_1_ammo", currentammo);
      projectile thread function_3f087cf63f4156fa(self, gunner);
    } else if(weapon.basename == bundle.var_2cb6918da56b085b) {
      earthquake(0.1, 0.5, self.origin, 1000);
      gunner setclientomnvar("ui_killstreak_weapon_2_ammo", currentammo);
    } else if(weapon.basename == bundle.var_2b83894fc24a37fc) {
      gunner setclientomnvar("ui_killstreak_weapon_3_ammo", currentammo);
    }

    projectile thread function_ccaa72b347c823bb(self, gunner, weapon.basename);

    if(currentammo == 0) {
      gunner thread gunship_weaponreload(weapon, self);
    }
  }
}

function getmissileexplscale(weaponname) {
  scale = 1;
  bundle = level.streakglobals.streakbundles["gunship"];

  if(weaponname == bundle.var_b702d1aa92e3f7dc) {
    scale = 0.75;
  } else if(weaponname == bundle.var_2cb6918da56b085b) {
    scale = 0.5;
  }

  return scale;
}

function getmissileexplradius(weaponname) {
  radius = 1;
  bundle = level.streakglobals.streakbundles["gunship"];

  if(weaponname == bundle.var_b702d1aa92e3f7dc) {
    radius = 2000;
  } else if(weaponname == bundle.var_2cb6918da56b085b) {
    radius = 1300;
  } else if(weaponname == bundle.var_2b83894fc24a37fc) {
    radius = 700;
  }

  return radius;
}

function function_3f087cf63f4156fa(gunship, gunner) {
  gunship endon("death");
  gunship endon("leaving");
  gunship endon("crashing");
  gunner endon("disconnect");
  self endon("death");
  targetent = gunship.hellfiretarget;

  if(isDefined(gunner.missilelaunchertarget) && isDefined(gunner.missilelauncherstage) && gunner.missilelauncherstage == 2) {
    targetent = gunner.missilelaunchertarget;
    gunship notify("gunship_reset_hellfire_lockon");
  }

  self missile_settargetEnt(targetent);
  gunner waittill("gunship_hellfire_disable_tracking");
  self missile_cleartarget();
}

function gunship_watchthermaltoggle(gunner) {
  if(!isai(gunner)) {
    gunner thread watchthermalinputchange();
  }

  gunship_watchthermaltoggleinternal(gunner);

  if(isDefined(gunner) && !isai(gunner)) {
    gunner stopwatchingthermalinputchange();
  }
}

function gunship_watchthermaltoggleinternal(gunner) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  gunner endon("disconnect");
  level endon("game_ended");
  self.flashlight = spawn("script_model", self.origin);
  self.flashlight setModel("ks_gunship_mp");
  self.flashlight dontinterpolate();
  self.flashlight thread gunship_watchthermalflashlightpos(self, gunner);

  if(isnightmap()) {
    self.flashlight thread gunship_showflashlight();
  }

  togglethermal = 0;
  var_9b037229590a3dc2 = 1;
  bundle = level.streakglobals.streakbundles["gunship"];

  thirdpersoncam = getdvarint(@ "hash_f49f4fd233809e37", 0);

  if(thirdpersoncam) {
    var_9b037229590a3dc2 = 0;
  }

  var_41799da9b6cce8be = 12;
  var_a044168d7664b127 = 1000;
  thermalvisionset = function_44e0bd95b98288ab();

  if(utility::iscp() && isDefined(level.var_f02a7fe4a43f02ee)) {
    function_c0b0a582ff9e4d57(level.var_f02a7fe4a43f02ee);
    thermalvisionset = level.var_f02a7fe4a43f02ee;
  }

  if(isnightmap() && istrue(var_9b037229590a3dc2)) {
    gunner setthermalvision(1, var_41799da9b6cce8be, var_a044168d7664b127);
    self.currentvisionset = thermalvisionset;
    self.flashlight notify("flashlight_on");
    togglethermal = 1;
    gunner _shellshock("killstreak_veh_camera_flir_mp", "top", self.timeout, 0);
    gunner setclientomnvar("ui_killstreak_thermal_mode", 1);
    gunner killstreak_setmainvision(thermalvisionset);
  }

  while(true) {
    gunner waittill("switch_thermal_mode");
    currentgunshipweapon = gunner getcurrentweapon();
    dofinfo = gunship_getdofinfobyweapon(currentgunshipweapon.basename);

    if(!istrue(togglethermal)) {
      gunner setthermalvision(1, dofinfo.fstop, dofinfo.focusdistance);
      self.currentvisionset = thermalvisionset;
      togglethermal = 1;
      gunner _shellshock("killstreak_veh_camera_flir_mp", "top", self.timeout, 0);
      gunner setclientomnvar("ui_killstreak_thermal_mode", 1);
      gunner killstreak_setmainvision(thermalvisionset);
      continue;
    }

    defaultvisionset = bundle.var_7a35928e082dd9b7;

    if(isDefined(level.mapname) && (issubstr(level.mapname, "_shipment") || issubstr(level.mapname, "mp_skerries") || getdvarint(@ "hash_ef7e2418dc2fe517", 0))) {
      defaultvisionset = bundle.var_6070115b879adfc9;
    }

    if(isDefined(level.gunshipvisionset)) {
      gunner killstreak_setmainvision(level.gunshipvisionset);
      self.currentvisionset = level.gunshipvisionset;
    } else {
      gunner killstreak_setmainvision(defaultvisionset);
      self.currentvisionset = defaultvisionset;
    }

    togglethermal = 0;
    gunner _shellshock("killstreak_veh_camera_mp", "top", self.timeout, 0);
    gunner setclientomnvar("ui_killstreak_thermal_mode", 0);
    gunner setthermalvision(0);
  }
}

function gunship_getdofinfobyweapon(weaponbasename) {
  dofinfo = spawnStruct();
  bundle = level.streakglobals.streakbundles["gunship"];

  if(weaponbasename == bundle.var_b702d1aa92e3f7dc) {
    dofinfo.fstop = 8;
    dofinfo.focusdistance = 600;
  } else if(weaponbasename == bundle.var_2cb6918da56b085b) {
    dofinfo.fstop = 8;
    dofinfo.focusdistance = 600;
  } else if(weaponbasename == bundle.var_2b83894fc24a37fc) {
    dofinfo.fstop = 8;
    dofinfo.focusdistance = 3500;
  }

  return dofinfo;
}

function gunship_watchthermalflashlightpos(gunship, gunner) {
  self endon("death");
  level endon("game_ended");
  useplayerangles = 1;

  thirdpersoncam = getdvarint(@ "hash_f49f4fd233809e37", 0);

  if(thirdpersoncam) {
    useplayerangles = 0;
  }

  while(isDefined(gunship) && isDefined(gunner)) {
    self.origin = gunship.origin;

    if(istrue(useplayerangles)) {
      self.angles = gunner getplayerangles();
    }

    wait 0.05;
  }

  if(isDefined(self)) {
    self delete();
  }
}

function gunship_showflashlight() {
  self endon("death");
  level endon("game_ended");
  playFXOnTag(getfx("camera_spotlight"), self, "tag_origin");

  while(true) {
    level waittill("player_enabled_nvgs");
    stopFXOnTag(getfx("camera_spotlight"), self, "tag_origin");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
    playFXOnTag(getfx("camera_spotlight"), self, "tag_origin");
  }
}

function gunship_weaponreload(weapon, gunship) {
  gunship endon("death");
  gunship endon("crashing");
  gunship endon("leaving");
  self endon("disconnect");
  level endon("game_ended");
  bundle = level.streakglobals.streakbundles["gunship"];
  weaponrootname = getgunshipweaponrootname(weapon);
  reloadsound = weaponrootname + "_mp_reload";
  var_dd020944ee631ba8 = strtok(weaponrootname, "_");

  if(var_dd020944ee631ba8[0] == "gunship") {
    reloadsound = "ac130";

    for(i = 1; i < var_dd020944ee631ba8.size; i++) {
      appendstring = var_dd020944ee631ba8[i];

      if(appendstring == "hellfire") {
        appendstring = "105mm";
      }

      reloadsound = reloadsound + "_" + appendstring;
    }

    reloadsound += "_mp_reload";
  }

  self playlocalsound(reloadsound);

  if(weapon.basename == bundle.var_b702d1aa92e3f7dc) {
    gunship.hellfireloaded = 0;
  }

  gunship_waitforweaponreloadtime(weapon, weaponrootname);
  reloaddialog = weaponrootname + "_reload";
  playkillstreakoperatordialog("gunship", reloaddialog, undefined, undefined, "pilot");
  maxammo = weaponmaxammo(weapon);
  self setweaponammoclip(weapon, maxammo);

  if(weapon.basename == bundle.var_b702d1aa92e3f7dc) {
    gunship.hellfireloaded = 1;
  }

  var_f3fc82c371854578 = undefined;

  switch (weaponrootname) {
    case #"hash_a595cc01d9fdb1c3":
      var_f3fc82c371854578 = "ui_killstreak_weapon_1_ammo";
      break;
    case #"hash_f7dc9df20da28f2":
      var_f3fc82c371854578 = "ui_killstreak_weapon_2_ammo";
      break;
    case #"hash_9e7bbed3c5c35ca3":
      var_f3fc82c371854578 = "ui_killstreak_weapon_3_ammo";
      break;
  }

  self setclientomnvar(var_f3fc82c371854578, maxammo);
}

function gunship_waitforweaponreloadtime(weapon, weaponrootname) {
  reloadtime = level.weaponreloadtime[weapon.basename];
  var_d7dac94935945aab = undefined;

  switch (weaponrootname) {
    case #"hash_a595cc01d9fdb1c3":
      var_d7dac94935945aab = "ui_killstreak_weapon_1_reloadtime";
      break;
    case #"hash_f7dc9df20da28f2":
      var_d7dac94935945aab = "ui_killstreak_weapon_2_reloadtime";
      break;
    case #"hash_9e7bbed3c5c35ca3":
      var_d7dac94935945aab = "ui_killstreak_weapon_3_reloadtime";
      break;
  }

  self setclientomnvar(var_d7dac94935945aab, gettime() + int(reloadtime * 1000));

  while(true) {
    wait 0.05;
    reloadtime -= 0.05;

    if(reloadtime <= 0) {
      break;
    }
  }
}

function getgunshipweaponrootname(weapon) {
  index = 0;
  weaponname = weapon.basename;
  tokens = strtok(weaponname, "_");
  return tokens[index] + "_" + tokens[index + 1];
}

function gunship_playpilotfx(pilot) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");

  thirdpersoncam = getdvarint(@ "hash_f49f4fd233809e37", 0);

  if(thirdpersoncam) {
    return;
  }

  pilot.gunship_cloudsfx = spawn("script_model", pilot getEye());
  pilot.gunship_cloudsfx setModel("tag_origin");
  pilot.gunship_cloudsfx linkTo(pilot, "tag_eye");
  waitframe();
  playfxontagforclients(getfx("clouds"), pilot.gunship_cloudsfx, "tag_origin", pilot);
}

function deleteaftertime(delay) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(delay);
  self delete();
}

function gunship_crash(gunner) {
  self notify("crashing");
  self.crashed = 1;
  thread function_43c36396180ee798(gunner);
  thread gunship_movetocrashpos();
}

function function_43c36396180ee798(gunner) {
  if(!isDefined(gunner)) {
    return;
  }

  if(isDefined(self)) {
    self endon("death");
    gunner endon("disconnect");
    thread gunship_returnplayer(gunner, 1);

    if(isDefined(self.gunshipintro) && level.gunship_animtype == 0) {
      self.gunshipintro function_7eb343dd6a3f639(gunner, "light_interior_outro", "on", "ks_gunship_interior_outro", 0.5);
      self playsoundtoplayer("iw9_gunship_plr_outro", gunner);
      gunner playkillstreakoperatordialog("gunship", "gunship" + "_crash", 1, undefined, "pilot");
      var_fbde3ff0d883172a = function_52351c3338da63f4("gunship", "outro_gunner");
      gunner thread gunship_crashexplosionradiostatic(var_fbde3ff0d883172a);
      gunner function_fa9987de43a6169b(self.gunshipintro, "outro");
      self.gunshipintro function_7eb343dd6a3f639(gunner, "light_interior_outro", "off", "ks_gunship_interior_outro", 0);
    }
  }
}

function gunship_movetocrashpos() {
  level endon("game_ended");
  self.leftwingfxent setscriptablepartstate("engine_blowout", "off");
  self.rightwingfxent setscriptablepartstate("engine_blowout", "off");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);
  self.leftwingfxent setscriptablepartstate("engine_blowout", "on");
  self.rightwingfxent setscriptablepartstate("engine_blowout", "on");
  self unlink();
  self.var_ba27aac5a0f799e0 = spawn("script_model", self.origin);
  self.var_ba27aac5a0f799e0 setModel("tag_origin");
  self.var_ba27aac5a0f799e0.angles = vectortoangles(anglesToForward(self.angles));
  self.leftwingfxent setscriptablepartstate("engine_blowout", "off");
  self.rightwingfxent setscriptablepartstate("engine_blowout", "off");
  self.leftwingfxent setscriptablepartstate("body_damage_heavy", "off");
  self.rightwingfxent setscriptablepartstate("body_damage_heavy", "off");
  bundle = level.streakglobals.streakbundles["gunship"];
  crashmodel = spawn("script_model", self.origin);
  crashmodel setModel(bundle.var_579059c670a08df4);
  crashmodel.angles = self.angles;
  crashmodel.animname = self.streakinfo.streakname;
  crashmodel scripts\common\anim::setanimtree();
  explosionfxent = spawn("script_model", self.origin);
  explosionfxent setModel("ks_gunship_mp");
  explosionfxent.angles = self.angles;
  explosionfxent linkTo(crashmodel, "tag_body", (0, 0, -10), (0, 0, 0));

  crashpart = "crash_air";
  explosionfxent setscriptablepartstate(crashpart, "on", 0);

  if(issharedfuncdefined("entity", "delayEntDelete")) {
    explosionfxent thread[[getsharedfunc("entity", "delayEntDelete")]](10);
    crashmodel thread[[getsharedfunc("entity", "delayEntDelete")]](10);
  }

  crashmodel thread gunship_crash_audio();
  var_1041b7883e5d3da5 = "outro_gunship_death";
  var_f7380e0ba9c6762f = function_52351c3338da63f4("gunship", var_1041b7883e5d3da5);
  thread gunship_delayhide();
  thread gunship_crashexplosionscreenshake(var_f7380e0ba9c6762f);
  self.var_ba27aac5a0f799e0 scripts\common\anim::anim_single_solo(crashmodel, var_1041b7883e5d3da5);
  self.var_ba27aac5a0f799e0 delete();
  gunship_removeplane(1);
}

function gunship_delayhide() {
  level endon("game_ended");
  wait 0.05;
  self hide();
}

function gunship_crashexplosionscreenshake(delaytime) {
  level endon("game_ended");
  var_14b1d0692795af2f = delaytime - 2;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_14b1d0692795af2f);

  foreach(player in level.players) {
    if(player scripts\cp_mp\utility\player_utility::_isalive()) {
      player earthquakeforplayer(0.25, 2, self.origin, 30000);
    }
  }
}

function gunship_crashexplosionradiostatic(delaytime) {
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(delaytime);
  function_5a9772411551e56e("gunship", "pilot");
}

function gunship_crash_audio() {
  waitframe();
  playsoundatpos(self.origin, "iw8_ks_ac130_explo_main");
  playsoundatpos(self.origin, "iw8_ks_ac130_explo_low_02");
  playsoundatpos(self.origin, "iw8_ks_ac130_shake_explo");
  playsoundatpos(self.origin, "iw8_ks_ac130_whine");
}

function gunship_removeplane(wasdestroyed) {
  if(isDefined(self.flashlight)) {
    self.flashlight delete();
  }

  if(isDefined(self.camera)) {
    self.camera delete();
  }

  if(isDefined(self.leftwingfxent)) {
    self.leftwingfxent delete();
  }

  if(isDefined(self.rightwingfxent)) {
    self.rightwingfxent delete();
  }

  if(isDefined(self.lightfxent)) {
    self.lightfxent delete();
  }

  if(isDefined(self.hellfiretarget)) {
    self.hellfiretarget delete();
  }

  if(isDefined(self.minimapid)) {
    if(scripts\engine\utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\engine\utility::getsharedfunc("game", "returnObjectiveID")]](self.minimapid);
    }

    self.minimapid = undefined;
  }

  self.streakinfo.expiredbydeath = istrue(wasdestroyed);

  if(isDefined(self.owner)) {
    self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);
  }

  self delete();
}

function function_3856d3338b2c7ebf(gunshipintro) {
  if(isDefined(gunshipintro)) {
    if(isDefined(gunshipintro.var_ba27aac5a0f799e0)) {
      gunshipintro.var_ba27aac5a0f799e0 delete();
    }

    if(isent(gunshipintro)) {
      gunshipintro setscriptablepartstate("clouds_intro", "off", 0);
      gunshipintro setscriptablepartstate("bodyFX_intro", "off", 0);
      gunshipintro delete();
      return;
    }

    if(isDefined(gunshipintro.var_5cb1f0f95e16878e)) {
      foreach(animent in gunshipintro.var_5cb1f0f95e16878e) {
        if(isDefined(animent)) {
          animent delete();
        }
      }
    }
  }
}

function function_5efa20e5c624be8f(gunshipintro) {
  if(isDefined(gunshipintro)) {
    if(isDefined(gunshipintro.var_5cb1f0f95e16878e)) {
      foreach(animent in gunshipintro.var_5cb1f0f95e16878e) {
        if(isDefined(animent)) {
          animent hidefromplayer(gunshipintro.var_dee7149209c9df8c);
        }
      }
    }
  }
}

function function_fa9987de43a6169b(gunshipintro, sequence) {
  self endon("disconnect");
  thirdpersoncam = 0;

  thirdpersoncam = getdvarint(@ "hash_f49f4fd233809e37", 0);

  if(!isDefined(gunshipintro.var_dee7149209c9df8c)) {
    gunshipintro.var_dee7149209c9df8c = self;
  }

  if(isDefined(gunshipintro) && isDefined(sequence)) {
    thread function_d13d2a81214fbfb8("80_instant_noscale", 1);

    if(sequence == "intro_gunship_exterior") {
      var_d0b97be6dc1a3eba = gunshipintro.var_5cb1f0f95e16878e["gunship_exterior"];
      var_258b660f7db9aba6 = function_52351c3338da63f4("gunship", sequence);
      var_d0b97be6dc1a3eba showtoplayer(gunshipintro.var_dee7149209c9df8c);
      var_d0b97be6dc1a3eba setscriptablepartstate("clouds_intro", "old", 0);
      var_d0b97be6dc1a3eba setscriptablepartstate("bodyFX_intro", "on", 0);
      gunshipintro.var_ba27aac5a0f799e0 thread scripts\common\anim::anim_single_solo(var_d0b97be6dc1a3eba, sequence);

      if(!thirdpersoncam) {
        gunshipintro.var_dee7149209c9df8c cameralinkTo(var_d0b97be6dc1a3eba, "tag_player", 1, 1);
      }

      var_d0b97be6dc1a3eba thread gunship_startintroshake(var_258b660f7db9aba6, self, sequence);
      var_d0b97be6dc1a3eba thread function_c285675bee6618a3(var_258b660f7db9aba6, self, sequence);
      var_d0b97be6dc1a3eba thread function_2be9ae7928984f8(var_258b660f7db9aba6, self);
      wait var_258b660f7db9aba6;

      if(!thirdpersoncam) {
        gunshipintro.var_dee7149209c9df8c cameraunlink();
      }
    } else {
      if(sequence == "intro") {
        var_d0b97be6dc1a3eba = gunshipintro.var_5cb1f0f95e16878e["gunship_exterior"];
        var_d0b97be6dc1a3eba setscriptablepartstate("clouds_intro", "off", 0);
        var_d0b97be6dc1a3eba setscriptablepartstate("bodyFX_intro", "off", 0);
      }

      if(isDefined(gunshipintro.var_5cb1f0f95e16878e)) {
        foreach(modelindex, animent in gunshipintro.var_5cb1f0f95e16878e) {
          if(isDefined(animent)) {
            if(modelindex == "gunship_exterior") {
              continue;
            }

            animent showtoplayer(gunshipintro.var_dee7149209c9df8c);

            if(modelindex == "gunship_interior") {
              continue;
            }

            var_465db5572e637fb7 = sequence + "_" + modelindex;
            gunshipintro.var_ba27aac5a0f799e0 thread scripts\common\anim::anim_single_solo(animent, var_465db5572e637fb7);

            if(!thirdpersoncam && modelindex == "gunner") {
              gunshipintro.var_dee7149209c9df8c cameralinkTo(animent, "tag_camera", 1, 1);
              var_9adc9e34bc4e0c77 = function_52351c3338da63f4("gunship", sequence + "_gunner");
              animent thread function_c285675bee6618a3(var_9adc9e34bc4e0c77, self, sequence);
            }
          }
        }

        var_258b660f7db9aba6 = function_52351c3338da63f4("gunship", sequence + "_gunner");
        wait var_258b660f7db9aba6;
      }
    }

    self notify("finished_gunship_anim_" + sequence);
  }
}

function function_d176c031e49a9127(var_5e0676140eecdf2d, brush_name) {
  init_succeed = 1;
  lighting_info = spawnStruct();
  probe = getEnt(var_5e0676140eecdf2d, "script_noteworthy");

  if(!isDefined(probe)) {
    assertex(0, "<dev string:x46>");
    self iprintln("<dev string:x46>");

    return undefined;
  }

  shadow_brushes = getEntArray(brush_name, "targetname");

  if(!isDefined(shadow_brushes)) {
    assertex(0, "<dev string:x46>");
    self iprintln("<dev string:x46>");

    return undefined;
  }

  lighting_info.probe = probe;
  lighting_info.shadow_brushes = shadow_brushes;
  var_ad02eaa051593bff = [];
  var_4662a9052a5547bd = [];
  var_ad02eaa051593bff["pos"] = probe.origin;
  var_ad02eaa051593bff["rot"] = probe.angles;
  lighting_info.var_af2c99167339224 = var_ad02eaa051593bff;

  foreach(index, brush in shadow_brushes) {
    brush_t = [];
    brush_t["pos"] = brush.origin;
    brush_t["rot"] = brush.angles;
    var_4662a9052a5547bd[index] = brush_t;
  }

  lighting_info.var_959ac8221d7965be = var_4662a9052a5547bd;

  foreach(var_6c3d15091efa3c48 in level.players) {
    probe hidefromplayer(var_6c3d15091efa3c48);
    probe thread gunship_hideintromodelonplayerconnect(self);

    foreach(brush in shadow_brushes) {
      brush hidefromplayer(var_6c3d15091efa3c48);
      brush thread gunship_hideintromodelonplayerconnect(self);
    }
  }

  return lighting_info;
}

function function_4293b1250d8a40ec(owner, lighting_info, showlighting) {
  if(istrue(showlighting)) {
    lighting_info.probe showtoplayer(owner);

    foreach(brush in lighting_info.shadow_brushes) {
      brush showtoplayer(owner);
    }

    return;
  }

  lighting_info.probe hidefromplayer(owner);

  foreach(brush in lighting_info.shadow_brushes) {
    brush hidefromplayer(owner);
  }
}

function function_4d00f78750774093(lighting_info) {
  if(!isDefined(lighting_info)) {
    return;
  }

  lighting_info.probe linkTo(self, "tag_origin", (100, 0, 115), (0, 0, 0));
}

function function_bbfa3bca65cb8e4c(lighting_info) {
  if(!isDefined(lighting_info)) {
    return;
  }

  foreach(brush in lighting_info.shadow_brushes) {
    brush linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  }
}

function function_38101db6ed950f17(lighting_info) {
  if(!isDefined(lighting_info)) {
    return;
  }

  lighting_info.probe unlink();
  lighting_info.probe.origin = lighting_info.var_af2c99167339224["pos"];
  lighting_info.probe.angles = lighting_info.var_af2c99167339224["rot"];
}

function function_fff560b330fd842d() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") == 0) {
    capture_model = getEntArray("ks_gunship_light_only", "script_noteworthy");

    foreach(m in capture_model) {
      m hide();
    }
  }
}

function unlink_brushes(lighting_info) {
  if(!isDefined(lighting_info)) {
    return;
  }

  foreach(index, brush in lighting_info.shadow_brushes) {
    brush unlink();
    brush.origin = lighting_info.var_959ac8221d7965be[index]["pos"];
    brush.angles = lighting_info.var_959ac8221d7965be[index]["rot"];
  }
}

function function_7eb343dd6a3f639(player, scriptablepart, state, visionset_name, time) {
  thirdpersoncam = undefined;

  thirdpersoncam = getdvarint(@ "hash_f49f4fd233809e37", 0);

  if(istrue(thirdpersoncam)) {
    return;
  }

  if(!isDefined(player)) {
    return;
  }

  if(state == "on") {
    self.gunshipinterior function_4293b1250d8a40ec(player, self.var_9bc4ed07a250f4d3, 1);
    self.gunshipinterior function_4d00f78750774093(self.var_9bc4ed07a250f4d3);
    self.gunshipinterior function_bbfa3bca65cb8e4c(self.var_9bc4ed07a250f4d3);
    self.gunshipinterior setscriptablepartstate(scriptablepart, "on");
    player visionsetnakedforplayer(visionset_name, time);
    return;
  }

  if(state == "off") {
    self.gunshipinterior function_4293b1250d8a40ec(player, self.var_9bc4ed07a250f4d3, 0);
    function_38101db6ed950f17(self.var_9bc4ed07a250f4d3);
    unlink_brushes(self.var_9bc4ed07a250f4d3);
    self.gunshipinterior setscriptablepartstate(scriptablepart, "off");
    player visionsetnakedforplayer("", time);
  }
}

function function_eb2299f7c29ac70c(gunshipintro, animent, var_465db5572e637fb7) {
  animent endon("<dev string:xb1>");
  self notifyonplayercommand("<dev string:xba>", "<dev string:xcd>");

  while(true) {
    self waittill("<dev string:xba>");
    gunshipintro.var_ba27aac5a0f799e0 thread scripts\common\anim::anim_single_solo(animent, var_465db5572e637fb7);
  }
}

function gunship_control_bot_aiming() {
  var_4ac4b608421ecbbb = undefined;
  last_enemy_seen = undefined;
  target_loc = undefined;
  var_befbf47bff2227bd = 0;
  var_ea189b55de5c8fa7 = 0;
  inaccuracy_vector = undefined;
  bot_inaccuracy = (self botgetdifficultysetting("minInaccuracy") + self botgetdifficultysetting("maxInaccuracy")) / 2;
  var_def9c228381a493a = 0;
  bundle = level.streakglobals.streakbundles["gunship"];

  while(true) {
    var_d430bcda6275a38b = 0;
    var_4b05a8497817406a = 0;

    if(isDefined(last_enemy_seen) && last_enemy_seen.health <= 0 && gettime() - last_enemy_seen.deathtime < 2000) {
      var_d430bcda6275a38b = 1;
      var_4b05a8497817406a = 1;
    } else if(isalive(self.enemy) && (self botcanseeentity(self.enemy) || gettime() - self lastknowntime(self.enemy) <= 300)) {
      var_d430bcda6275a38b = 1;
      last_enemy_seen = self.enemy;
      var_7f9803312b446879 = last_enemy_seen.origin;
      var_4ac4b608421ecbbb = self.enemy.origin;

      if(self botcanseeentity(self.enemy)) {
        var_def9c228381a493a = 0;
        var_4b05a8497817406a = 1;
        var_b8cccb951e8a65c4 = gettime();
      } else {
        var_def9c228381a493a += 0.05;

        if(var_def9c228381a493a > 5) {
          var_d430bcda6275a38b = 0;
        }
      }
    }

    if(var_d430bcda6275a38b) {
      if(isDefined(var_4ac4b608421ecbbb)) {
        target_loc = var_4ac4b608421ecbbb;
      }

      if(issharedfuncdefined("bots", "bot_body_is_dead")) {
        if(var_4b05a8497817406a && (self[[getsharedfunc("bots", "bot_body_is_dead")]]() || distancesquared(target_loc, level.gunship.origin) > level.physicssphereradius[bundle.var_b702d1aa92e3f7dc] * level.physicssphereradius[bundle.var_b702d1aa92e3f7dc])) {
          self botpressbutton("attack");
        }
      }

      if(gettime() > var_ea189b55de5c8fa7 + 500) {
        random_x = randomfloatrange(-1 * bot_inaccuracy / 2, bot_inaccuracy / 2);
        random_y = randomfloatrange(-1 * bot_inaccuracy / 2, bot_inaccuracy / 2);
        random_z = randomfloatrange(-1 * bot_inaccuracy / 2, bot_inaccuracy / 2);
        inaccuracy_vector = (150 * random_x, 150 * random_y, 150 * random_z);
        var_ea189b55de5c8fa7 = gettime();
      }

      target_loc += inaccuracy_vector;
    } else if(gettime() > var_befbf47bff2227bd) {
      var_befbf47bff2227bd = gettime() + randomintrange(1000, 2000);
      target_loc = undefined;

      if(issharedfuncdefined("bots", "get_random_outside_target")) {
        target_loc = [[getsharedfunc("bots", "get_random_outside_target")]]();
      }
    }

    self botlookatpoint(target_loc, 0.2, "script_forced");
    wait 0.05;
  }
}

function gunship_handlemissiledetection(player, missileteam, missiletarget, fxtagoverride) {
  self endon("death");

  while(true) {
    if(!isDefined(missiletarget)) {
      break;
    }

    center = missiletarget getpointinbounds(0, 0, 0);
    curdist = distance(self.origin, center);

    if(curdist < 4000 && missiletarget.flaresreservecount > 0) {
      if(issharedfuncdefined("flares", "reduceReserves")) {
        [[getsharedfunc("flares", "reduceReserves")]](missiletarget);
      }

      missiletarget thread gunship_playflaresfx(fxtagoverride);
      missiletarget playkillstreakoperatordialog("gunship", "gunship" + "_flares", 1, undefined, "pilot");
      newtarget = undefined;

      if(issharedfuncdefined("flares", "deploy")) {
        newtarget = missiletarget[[getsharedfunc("flares", "deploy")]]();
      }

      if(issharedfuncdefined("killstreak", "updateScrapAssistDataForceCredit")) {
        missiletarget[[getsharedfunc("killstreak", "updateScrapAssistDataForceCredit")]](player);
      }

      self missile_settargetEnt(newtarget);
      self notify("missile_pairedWithFlare");
      return;
    } else if(curdist < 300 && missiletarget.flaresreservecount <= 0) {
      missiletarget thread gunship_playfakebodyexplosion();
      weapon = makeweapon(self.weapon_name);
      missiledamage = weapon getmaxdamage(0);

      if(isDefined(self.owner)) {
        missiletarget dodamage(missiledamage, self.owner.origin, self.owner, self, "MOD_EXPLOSIVE", self.weapon_name);
      }

      self delete();
    }

    waitframe();
  }
}

function gunship_playfakebodyexplosion() {
  if(!isDefined(self.missileexplcounter)) {
    self.missileexplcounter = 0;
  }

  self.missileexplcounter++;

  if(self.missileexplcounter > 4) {
    self.missileexplcounter = 0;
  }

  self setscriptablepartstate("fake_missile_expl_" + self.missileexplcounter, "on", 0);
  self playsoundonmovingent("iw8_ks_ac130_dist_rkt_explo");
  wait 2;
  self setscriptablepartstate("fake_missile_expl_" + self.missileexplcounter, "off", 0);
}

function gunship_playflaresfx(fxtagoverride) {
  flarestag = "tag_origin";

  if(isDefined(fxtagoverride)) {
    flarestag = fxtagoverride;
  }

  playsoundatpos(self gettagorigin(flarestag), "ks_ac130_flares");
  playFXOnTag(getfx("gunship_flares"), self, flarestag);
  flaresgroup = self.flaresreservecount + 1;
  self setscriptablepartstate("fake_flares_" + flaresgroup, "on", 0);
}

function isusinggunship() {
  return isDefined(self.usinggunship);
}

function gunship_linklightfxent() {
  self endon("death");
  level endon("game_ended");
  wait 0.05;
  gunshipforward = anglesToForward(self.angles);
  self setscriptablepartstate("lights", "on");
}

function gunship_linkwingfxents() {
  self endon("death");
  level endon("game_ended");
  wait 0.05;
  var_633eaa5f21008b6f = self gettagorigin("tag_left_outer_prop");
  self.leftwingfxent = spawn("script_model", var_633eaa5f21008b6f);
  self.leftwingfxent setModel("ks_gunship_mp");
  self.leftwingfxent.angles = self.angles;
  self.leftwingfxent setotherent(self.owner);
  self.leftwingfxent linkTo(self, "tag_left_outer_prop", (0, 0, 0), (0, 0, 0));
  var_3eacd3938ccd4b6c = self gettagorigin("tag_right_outer_prop");
  self.rightwingfxent = spawn("script_model", var_3eacd3938ccd4b6c);
  self.rightwingfxent setModel("ks_gunship_mp");
  self.rightwingfxent.angles = self.angles;
  self.rightwingfxent setotherent(self.owner);
  self.rightwingfxent linkTo(self, "tag_right_outer_prop", (0, 0, 0), (0, 0, 0));
  self setscriptablepartstate("contrails", "on");
}

function function_9a76988758d4b96d(wingfxent) {
  self endon("<dev string:xb1>");
  level endon("<dev string:xd9>");

  while(true) {
    sphere(wingfxent.origin, 100, (1, 0, 0), 0, 1);
    wait 0.05;
  }
}

function gunship_watchtargets(gunner) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  gunner endon("disconnect");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);

  while(true) {
    visibletargets = [];

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

        if(!streakcanseetarget(self.origin, player gettagorigin("j_spineupper"), self)) {
          continue;
        }

        if(issharedfuncdefined("perk", "hasPerk")) {
          if(player[[getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
            continue;
          }
        }

        visibletargets = gunship_getnearbytargets(player);
        break;
      }

      wait 0.05;
    }

    if(visibletargets.size > 0 && visibletargets.size < 2) {
      gunner playkillstreakoperatordialog("gunship", "gunship" + "_spotted_single_target", undefined, undefined, "pilot");
    } else if(visibletargets.size >= 2) {
      gunner playkillstreakoperatordialog("gunship", "gunship" + "_spotted_single_multi", undefined, undefined, "pilot");
    }

    wait randomintrange(5, 15);
  }
}

function gunship_getnearbytargets(maintarget) {
  var_69338ca0bf9d8d91 = utility::playersinsphere(maintarget.origin, 300);
  nearbytargets = [];

  foreach(player in var_69338ca0bf9d8d91) {
    if(level.teambased && player.team != maintarget.team) {
      continue;
    }

    if(!level.teambased && player == self.owner) {
      continue;
    }

    nearbytargets[nearbytargets.size] = player;
  }

  return nearbytargets;
}

function function_39464052869b655d(gunner) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  gunner endon("disconnect");
  self.var_d743ac65ecce766 = 0;
  childthread gunship_watchkills();
  childthread function_c8437bfb873fd165();

  while(true) {
    if(self.var_d743ac65ecce766 != 0) {
      wait 2;

      if(self.var_d743ac65ecce766 >= 1) {
        playkillstreakoperatordialog("gunship", "gunship" + "_hit_target", undefined, undefined, "pilot");
      } else {
        playkillstreakoperatordialog("gunship", "gunship" + "_miss_target", undefined, undefined, "pilot");
      }

      self.var_d743ac65ecce766 = 0;
      wait 1;
    }

    waitframe();
  }
}

function gunship_watchkills() {
  while(true) {
    self.owner waittill("update_rapid_kill_buffered", recentkills, weaponname);

    if(isDefined(recentkills)) {
      self.var_d743ac65ecce766++;
    }
  }
}

function function_c8437bfb873fd165() {
  while(true) {
    self.owner waittill("update_rapid_agent_kill_buffered", recentkills, weaponname);

    if(isDefined(recentkills)) {
      self.var_d743ac65ecce766++;
    }
  }
}

function gunship_iskillstreakweapon(weaponname) {
  bundle = level.streakglobals.streakbundles["gunship"];
  return ter_op(isDefined(weaponname) && (weaponname == bundle.var_b702d1aa92e3f7dc || weaponname == bundle.var_2cb6918da56b085b || weaponname == bundle.var_2b83894fc24a37fc), 1, 0);
}

function gunship_islargemap() {
  largemap = islargemap();

  crashtype = getdvarint(@ "hash_302d41b2b6f9d002", 0);

  if(crashtype) {
    largemap = 1;
  }

  return largemap;
}

function gunship_allowstances(boolean) {
  if(!istrue(boolean)) {
    self.gunship_disabledstances = [];
    currentstance = self getstance();

    switch (currentstance) {
      case #"hash_c6775c88e38f7803":
        self.gunship_disabledstances = ["crouch", "prone"];
        break;
      case #"hash_3fed0cbd303639eb":
        self.gunship_disabledstances = ["stand", "prone"];
        break;
      case #"hash_d91940431ed7c605":
        self.gunship_disabledstances = ["stand", "crouch"];
        break;
    }

    val::group_register("gunshipStance", self.gunship_disabledstances);
    val::group_set("gunshipStance", 0);
    return;
  }

  val::group_reset("gunshipStance");
}

function function_486b043f227fca86() {
  self endon("death");
  level waittill("game_ended");
  level.gunshiprigs = array_remove(level.gunshiprigs, self);
  self delete();
}

function function_f14aa90c4ef905d2(ent) {
  self endon("death");
  ent waittill_any_2("leaving", "death");
  level.gunshiprigs = array_remove(level.gunshiprigs, self);
  self delete();
}

function function_aafc33d685563aa4(owner) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  owner endon("disconnect");
  level endon("game_ended");

  while(true) {
    targetpos = function_cdf6e1bdfe5b42b5(owner);

    if(isDefined(targetpos)) {
      self.hellfiretarget.origin = targetpos;
    }

    waitframe();
  }
}

function function_5fbd9704078207ad(owner) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  owner endon("disconnect");
  level endon("game_ended");
  gunshipbasefov = 65;
  lerptime = 0.2;
  currentfov = gunshipbasefov;
  var_d54d564805c29b7b = undefined;
  timeheld = 0;
  playedvision = 0;
  owner setclientomnvar("ui_killstreak_zoom_fov", currentfov);

  while(true) {
    if(!isDefined(self.var_5496ff174012e0e0)) {
      waitframe();
      continue;
    }

    if(owner adsButtonPressed()) {
      timeheld += 0.05;

      if(timeheld >= lerptime) {
        timeheld = lerptime;
      }

      if(!istrue(playedvision)) {
        owner function_58707ddfdd9744fa("killstreak_ads_shutter");
        playedvision = 1;
      }
    } else if(timeheld > 0) {
      timeheld -= 0.05;

      if(timeheld <= 0) {
        timeheld = 0;
      }

      if(istrue(playedvision)) {
        playedvision = 0;
      }
    }

    if(timeheld >= 0) {
      var_d54d564805c29b7b = self.var_5496ff174012e0e0;
      timeperc = timeheld / lerptime * 100;
      currentfov = int(timeperc * (var_d54d564805c29b7b - gunshipbasefov) / 100 + gunshipbasefov);
    }

    owner setclientomnvar("ui_killstreak_zoom_fov", currentfov);
    wait 0.05;
  }
}

function function_cdf6e1bdfe5b42b5(owner) {
  content = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicleclip"];
  contentoverride = physics_createcontents(content);
  starttrace = owner getvieworigin();
  endtrace = starttrace + anglesToForward(owner getplayerangles()) * 50000;
  ignoreents = owner playerkillstreakgetownerlookatignoreents();
  trace = scripts\engine\trace::ray_trace(starttrace, endtrace, ignoreents, contentoverride);
  endpos = trace["position"];
  return endpos;
}

function function_9214536761e6be23(targetweapon) {
  self endon("death");
  self notify("gunhip_storing_fov");
  self endon("gunship_storing_fov");

  while(true) {
    currentplayerweapon = self.owner getcurrentweapon();

    if(isDefined(currentplayerweapon) && currentplayerweapon.basename == targetweapon) {
      break;
    }

    waitframe();
  }

  self.var_5496ff174012e0e0 = self.owner playergetzoomfov();
}

function function_ccaa72b347c823bb(gunship, gunner, weaponbasename) {
  gunship endon("death");
  gunship endon("leaving");
  gunship endon("crashing");
  gunner endon("disconnect");
  self waittill("death");
  bundle = level.streakglobals.streakbundles["gunship"];

  if(weaponbasename == bundle.var_2b83894fc24a37fc) {
    return;
  }

  var_465f0d60f080d408 = bundle.var_ee69fd7db3c43c73;

  if(weaponbasename == bundle.var_b702d1aa92e3f7dc) {
    var_465f0d60f080d408 = bundle.var_1773b3703b61838e;
    earthquake(0.125, 0.5, gunship.origin, 1000);
  }

  gunner function_58707ddfdd9744fa(var_465f0d60f080d408);
}

function function_aaedf89b93495d4f(data) {
  if(isDefined(self)) {
    gunship_crash(self.owner);
  }
}

function function_377ab89187436937(data) {
  self endon("death");
  self notify("gunship_mini_emp_hit");
  self endon("gunship_mini_emp_hit");
  self.owner endon("detach_gunship_intro");
  self.owner endon("returning_killstreak_player");
  thread function_f4b2a9371b53b7ab();

  if(!isDefined(self.var_e8d88b601e41fba5) && self.flaresreservecount > 0) {
    self.var_e8d88b601e41fba5 = gettime();

    if(issharedfuncdefined("flares", "reduceReserves")) {
      [[getsharedfunc("flares", "reduceReserves")]](self);
    }

    thread gunship_playflaresfx();

    if(issharedfuncdefined("flares", "deploy")) {
      self[[getsharedfunc("flares", "deploy")]]();
    }

    if(issharedfuncdefined("killstreak", "updateScrapAssistDataForceCredit")) {
      self[[getsharedfunc("killstreak", "updateScrapAssistDataForceCredit")]](data.attacker);
    }

    if(scripts\engine\utility::issharedfuncdefined("player", "doScoreEvent")) {
      data.attacker thread[[scripts\engine\utility::getsharedfunc("player", "doScoreEvent")]]("emped_killstreak");
    }

    return;
  }

  if(self.flaresreservecount > 0 && self.var_e8d88b601e41fba5 <= gettime() - 10000) {
    self.var_e8d88b601e41fba5 = gettime();

    if(issharedfuncdefined("flares", "reduceReserves")) {
      [[getsharedfunc("flares", "reduceReserves")]](self);
    }

    thread gunship_playflaresfx();

    if(issharedfuncdefined("flares", "deploy")) {
      self[[getsharedfunc("flares", "deploy")]]();
    }

    if(issharedfuncdefined("killstreak", "updateScrapAssistDataForceCredit")) {
      self[[getsharedfunc("killstreak", "updateScrapAssistDataForceCredit")]](data.attacker);
    }

    if(scripts\engine\utility::issharedfuncdefined("player", "doScoreEvent")) {
      data.attacker thread[[scripts\engine\utility::getsharedfunc("player", "doScoreEvent")]]("emped_killstreak");
    }
  }
}

function function_f4b2a9371b53b7ab() {
  self endon("death");
  self.owner endon("detach_gunship_intro");
  self.owner endon("returning_killstreak_player");
  self.owner _setvisibiilityomnvarforkillstreak(self.streakname, "off");
  result = waittill_any_ents_or_timeout_return(0.1, self.owner, "detach_gunship_intro", self.owner, "returning_killstreak_player", self, "death");

  if(!isDefined(result) || result != "timeout" || !isDefined(self) || !isalive(self)) {
    return;
  }

  if(self.owner isusinggunship()) {
    self.owner _setvisibiilityomnvarforkillstreak(self.streakname, "on");
  }

  result = waittill_any_ents_or_timeout_return(0.05, self.owner, "detach_gunship_intro", self.owner, "returning_killstreak_player", self, "death");

  if(!isDefined(result) || result != "timeout" || !isDefined(self) || !isalive(self)) {
    return;
  }

  self.owner _setvisibiilityomnvarforkillstreak(self.streakname, "off");
  result = waittill_any_ents_or_timeout_return(0.25, self.owner, "detach_gunship_intro", self.owner, "returning_killstreak_player", self, "death");

  if(!isDefined(result) || result != "timeout" || !isDefined(self) || !isalive(self)) {
    return;
  }

  if(self.owner isusinggunship()) {
    self.owner _setvisibiilityomnvarforkillstreak(self.streakname, "on");
  }
}

function gunship_watchplanedistance(var_2136b63785ee0579) {
  self endon("<dev string:xb1>");
  self.owner endon("<dev string:xe7>");
  self.owner endon("<dev string:x106>");

  while(true) {
    trace = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 40000), self);
    line(self.origin, trace["<dev string:x126>"], (1, 1, 1), 1, 0, 1);
    sphere(var_2136b63785ee0579.origin, 50, (1, 1, 0), 0, 1);
    self.owner iprintlnbold("<dev string:x132>" + distance(self.origin, trace["<dev string:x126>"]));
    waitframe();
  }
}

function watchdebuglocation(tagname, showaxis) {
  self endon("<dev string:xb1>");

  while(true) {
    debuglocation = self.origin;

    if(isDefined(tagname)) {
      debuglocation = self gettagorigin(tagname);
    }

    sphere(debuglocation, 100, (1, 1, 1), 0, 1);

    if(istrue(showaxis)) {
      testforward = anglesToForward(self.angles);
      testright = anglestoright(self.angles);
      testup = anglestoup(self.angles);
      line(debuglocation, debuglocation + testforward * 1000, (1, 0, 0), 1, 0, 1);
      line(debuglocation, debuglocation + testright * 1000, (0, 1, 0), 1, 0, 1);
      line(debuglocation, debuglocation + testup * 1000, (0, 0, 1), 1, 0, 1);
    }

    wait 0.05;
  }
}

function function_45ad456c933cbb32() {
  self endon("<dev string:xb1>");
  self endon("<dev string:x140>");
  self endon("<dev string:x14b>");
  self.owner notifyonplayercommand("<dev string:xe7>", "<dev string:x157>");
  self.owner notifyonplayercommand("<dev string:x106>", "<dev string:x164>");
  self.owner notifyonplayercommand("<dev string:x106>", "<dev string:x171>");
  self.flashlight notify("<dev string:x17f>");
  bundle = level.streakglobals.streakbundles["<dev string:x190>"];
  weaponstocycle = [bundle.var_b702d1aa92e3f7dc, bundle.var_2cb6918da56b085b, bundle.var_2b83894fc24a37fc];
  currentdebugweaponindex = 0;
  currentdebugweapon = weaponstocycle[0];

  while(true) {
    result = self.owner waittill_any_return_2("<dev string:xe7>", "<dev string:x106>");

    if(!isDefined(result)) {
      waitframe();
      continue;
    }

    if(result == "<dev string:xe7>") {
      currentdebugweaponindex++;

      if(currentdebugweaponindex > 2) {
        currentdebugweaponindex = 0;
      }

      currentdebugweapon = weaponstocycle[currentdebugweaponindex];
      self.owner iprintlnbold("<dev string:x19b>" + currentdebugweapon);
      continue;
    }

    shotgoal = gunship_getshotgoal(self.owner);
    thread function_4f101b253c661e40(shotgoal, currentdebugweapon);
  }
}

function gunship_getfiretime(weapon) {
  return weaponfiretime(weapon);
}

function gunship_getshotgoal(owner) {
  content = ["<dev string:x1b9>", "<dev string:x1d5>", "<dev string:x1f4>"];
  contentoverride = physics_createcontents(content);
  starttrace = owner getvieworigin();
  endtrace = starttrace + anglesToForward(owner getplayerangles()) * 50000;
  trace = scripts\engine\trace::ray_trace(starttrace, endtrace, level.characters, contentoverride);
  endpos = trace["<dev string:x126>"];
  return endpos;
}

function function_4f101b253c661e40(shotgoal, currentdebugweapon) {
  self endon("<dev string:xb1>");
  self endon("<dev string:x140>");
  self endon("<dev string:x14b>");
  self.owner endon("<dev string:xe7>");
  self.owner endon("<dev string:x106>");

  while(true) {
    sphere(shotgoal, 10, (1, 1, 0), 0, 60);
    self.owner iprintlnbold("<dev string:x20f>" + currentdebugweapon + "<dev string:x21a>" + shotgoal + "<dev string:x222>" + getweaponexplosionradius(currentdebugweapon));
    ammoleft = weaponmaxammo(currentdebugweapon);
    thread gunship_updatedebugflashlight(shotgoal);

    while(ammoleft > 0) {
      var_e84b952249e4abe = undefined;

      if(issharedfuncdefined("<dev string:x190>", "<dev string:x237>")) {
        var_e84b952249e4abe = [[getsharedfunc("<dev string:x190>", "<dev string:x237>")]](shotgoal, 100);
      }

      projectile = _magicbullet(makeweapon(currentdebugweapon), self.origin, var_e84b952249e4abe, self.owner);
      ammoleft--;

      if(ammoleft == 0) {
        wait 1;
        reloadtimer = level.weaponreloadtime[currentdebugweapon];

        while(reloadtimer > 0) {
          self.owner iprintlnbold("<dev string:x24a>" + currentdebugweapon);
          reloadtimer--;
          wait 1;
        }
      }

      wait gunship_getfiretime(currentdebugweapon);
    }
  }
}

function gunship_updatedebugflashlight(shotgoal) {
  self endon("<dev string:xb1>");
  self endon("<dev string:x140>");
  self endon("<dev string:x14b>");
  self.owner endon("<dev string:xe7>");
  self.owner endon("<dev string:x106>");

  while(true) {
    self.flashlight.angles = vectortoangles(shotgoal - self.origin);
    line(self.origin, shotgoal, (1, 1, 1), 1, 0, 1);
    waitframe();
  }
}

function function_66f838db99a91aa3() {
  self endon("<dev string:xb1>");
  wait 10;
  data = scripts\cp_mp\utility\damage_utility::packdamagedata(self.owner, self, 1, self.currentprimaryweapon, "<dev string:x258>", self);
  function_377ab89187436937(data);
  wait 10;
  function_377ab89187436937(data);
}

# /