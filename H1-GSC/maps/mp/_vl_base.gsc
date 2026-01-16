/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\_vl_base.gsc
********************************/

vl_init() {
  setdvar("r_dof_physical_enable", 1);
  setdvar("r_dof_physical_bokehEnable", 1);
  setdvar("r_adaptiveSubdiv", 0);
  setdvar("r_eyePupil", 0.15);
  setdvar("r_uiblurdstmode", 3);
  setdvar("r_blurdstgaussianblurradius", 1.5);
  level.vl_onspawnplayer = ::onspawnplayer;
  level.partymembers_cb = ::party_members;
  level.vlavatars = [];
  level.vl_focus = 0;
  level.in_firingrange = 0;
  level.in_depot = 0;
  level.vl_active = 0;
  level.vl_loadoutfunc = ::getloadoutvl;
  level.vl_setup = 0;
  level.agent_funcs["player"]["on_killed"] = ::on_agent_player_killed;
  setdvar("virtuallobbymembers", 0);
  maps\mp\_vl_avatar::init_avatar();
  maps\mp\_vl_firingrange::init_firingrange();
  maps\mp\_vl_camera::init_camera();
  maps\mp\_vl_cac::init_cac();
  maps\mp\_vl_depot::init_depot();
  maps\mp\_vl_cao::init_cao();
}

onspawnplayer() {
  thread vlobby_player();
  self setdemigod(1);
  self setmlgspectator(0);
  thread monitor_member_timeouts();
}

getconstlocalplayer() {
  return 0;
}

playermonitorluinotifies(var_0) {
  self endon("disconnect");
  playerluistart();

  for (;;) {
    self waittill("luinotifyserver", var_1, var_2);
    thread playerprocessluiservernotify(var_1, var_2);
  }
}

playerprocessluiservernotify(var_0, var_1) {
  thread playermemberfocusprocesslui(var_0, var_1);
  thread maps\mp\_vl_cao::playerequipprocesslui(var_0, var_1);
  thread maps\mp\_vl_cao::playercollectionsprocesslui(var_0, var_1);
  thread maps\mp\_vl_cao::playerarmoryprocesslui(var_0, var_1);
  thread maps\mp\_vl_cao::playersupplycrateprocesslui(var_0, var_1);
  thread maps\mp\_vl_cac::playercacprocesslui(var_0, var_1);
  thread maps\mp\_vl_depot::playerdepotprocesslui(var_0, var_1);
  thread maps\mp\_vl_cao::playercaoprocesslui(var_0, var_1);
}

playerluistart() {
  var_0 = getdvarint("virtualLobbyMode", 0);
  var_1 = getdvar("virtualLobbyModeData", "");

  if(var_0 == 2) {
    var_2 = 0;

    if(var_1 != "")
      var_2 = int(var_1);

    thread playerprocessluiservernotify("classpreview", var_2);
  } else if(var_0 == 3) {
    var_2 = 0;

    if(var_1 != "")
      var_2 = int(var_1);

    thread playerprocessluiservernotify("cao", var_2);
  } else if(var_0 == 7)
    thread playerluistartupcaocostume(var_1);
  else if(var_0 == 8)
    thread playerluistartupcaocamo(var_1);
  else if(var_0 == 6)
    thread playerluistartupcacweapon(var_1);
  else if(var_0 == 9)
    thread playerluistartupcaocollections(var_1);
}

playerluistartupcaocollections(var_0) {
  var_1 = getdvar("virtualLobbyModeChannel");
  var_2 = getdvar("virtualLobbyModeChannel2");
  var_3 = getdvar("virtualLobbyModeData2");
  var_4 = strtok(var_3, "_");
  var_5 = int(var_4[0]);
  thread playerprocessluiservernotify("cao", var_5);
  thread playerprocessluiservernotify(var_2, var_3);
  thread playerprocessluiservernotify(var_1, var_0);
}

playerluistartupcaocostume(var_0) {
  var_1 = strtok(var_0, "_");
  var_2 = int(var_1[0]);
  thread playerprocessluiservernotify("cao", var_2);
  thread playerprocessluiservernotify("costume_preview", var_0);
}

playerluistartupcaocamo(var_0) {
  var_1 = strtok(var_0, "_");
  var_2 = int(var_1[0]);
  thread playerprocessluiservernotify("cao", var_2);
  thread playerprocessluiservernotify("camo_preview", var_0);
}

playerluistartupcacweapon(var_0) {
  maps\mp\_vl_cac::playercacprocesslui("cac", 1);
  maps\mp\_vl_cac::playercacprocesslui("weapon_highlighted", var_0);
}

vlobby_player() {
  self endon("disconnect");
  level.vl_active = 1;
  level.vlplayer = self;
  var_0 = self;
  var_0 maps\mp\_vl_camera::setup_camparams();
  var_0 setclientomnvar("ui_vlobby_round_state", 0);
  var_0 setclientomnvar("ui_vlobby_round_timer", 0);
  var_0 allowfire(0);
  var_1 = var_0 _meth_8568();
  var_2 = getclassforloadout(var_1);
  var_0.currentselectedclass = getlastcustomclass(var_1);
  var_3 = maps\mp\gametypes\_class::cac_getlastgroupstring(var_1);
  var_4 = maps\mp\_utility::cac_getcustomclassloc();

  if(var_3 != var_4) {
    var_2 = "lobby1";
    var_0.currentselectedclass = 1;
  }

  var_5 = maps\mp\gametypes\_class::cao_getactivecostume(var_1);
  var_6 = maps\mp\gametypes\_class::cao_getcharactercamoindex(var_1);
  maps\mp\_vl_cac::setselectedfaction(var_1);
  var_0 maps\mp\_vl_camera::vl_lighting_setup();
  var_7 = var_0 getxuid();
  level.vl_focus = 0;
  var_0.team = "spectator";
  waittillframeend;
  var_8 = maps\mp\_vl_camera::spawncamera(var_0);
  level.camparams.camera = var_8;
  level.forcecustomclassloc = var_4;
  var_0 virtual_lobby_set_class(0, var_1, var_2, 0);
  var_0 maps\mp\_vl_avatar::playerspawnlocalplayeravatar(var_7, var_2, var_5, var_6, var_1);
  level.forcecustomclassloc = undefined;
  var_9 = level.vlavatars[level.vl_focus];
  var_9.player = var_0;
  var_9.sessioncostume = var_9.costume;
  var_0 playersetlobbyfovscale();
  var_0 thread playermonitordisconnect();
  var_0 thread playerhandletasksafternextsnapshot(var_8);
  maps\mp\_utility::updatesessionstate("spectator");
  var_0 clientaddsoundsubmix("mp_no_foley", 1);
  var_0 playerchangecameramode("game_lobby");
  var_0 thread playermonitorluinotifies();
  var_0 thread playermonitorswitchtofiringrange();
  thread setvirtuallobbypresentable();

  if(getdvarint("virtualLobbyReady", 0) == 0)
    setdvar("virtualLobbyReady", "1");

  level.vl_setup = 1;
}

getlastclass(var_0) {
  var_1 = maps\mp\gametypes\_class::cac_getlastclassindex(var_0);

  if(!isdefined(var_1) || var_1 == 0)
    var_1 = 1;

  return var_1;
}

getlastcustomclass(var_0) {
  var_1 = getlastclass(var_0);

  if(var_1 > 100)
    var_1 = 1;

  return var_1;
}

getclassforloadout(var_0) {
  var_1 = getlastclass(var_0);

  if(var_1 <= 100)
    var_1 = "lobby" + var_1;
  else if(var_1 <= 200) {
    var_1 = var_1 - 101;
    var_1 = "class" + var_1;
  } else
    var_1 = "lobby1";

  return var_1;
}

playerpopcameramode() {
  var_0 = level.camparams;
  var_1 = self;

  if(isdefined(var_0.pushmode) && var_0.pushmode.size > 0) {
    var_2 = var_0.pushmode.size - 1;
    var_3 = var_0.pushmode[var_2];
    var_0.pushmode[var_2] = undefined;
    playerchangecameramode(var_3, 0);
  }
}

playerchangecameramode(var_0, var_1) {
  var_2 = level.camparams;
  var_3 = self;

  if(!isdefined(var_1))
    var_1 = 1;

  if(var_1) {
    if(isdefined(var_2.mode))
      var_2.pushmode[var_2.pushmode.size] = var_2.mode;
    else
      var_2.mode = "";
  }

  var_2.newmode = var_0;
  maps\mp\_vl_camera::playerupdatecamera();
}

playerhandletasksafternextsnapshot(var_0) {
  maps\mp\_utility::waittillplayersnextsnapshot(self);
  maps\mp\_vl_camera::cameralink(var_0, self);
}

setuploadoutcommonvl() {
  var_0 = self.vlcontroller;

  if(!isdefined(self.emblemloadout))
    self.emblemloadout = spawnstruct();

  self.emblemloadout.emblemindex = getcacplayerdataforgroup(var_0, common_scripts\utility::getstatsgroup_common(), "emblemPatchIndex");
  self.emblemloadout.shouldapplyemblemtoweapon = getcacplayerdataforgroup(var_0, common_scripts\utility::getstatsgroup_common(), "applyEmblemToWeapon");
  self.emblemloadout.shouldapplyemblemtocharacter = getcacplayerdataforgroup(var_0, common_scripts\utility::getstatsgroup_common(), "applyEmblemToCharacter");

  if(!isdefined(self.charactercamoloadout))
    self.charactercamoloadout = spawnstruct();

  self.charactercamoloadout.camoindex = getcacplayerdataforgroup(var_0, common_scripts\utility::getstatsgroup_common(), "characterCamoIndex");
}

getloadoutvl(var_0, var_1) {
  var_2 = self.vlcontroller;
  var_3 = [];
  var_3["primary"] = maps\mp\gametypes\_class::cac_getweapon(var_1, 0, var_2);
  var_3["primaryAttachKit"] = maps\mp\gametypes\_class::cac_getweaponattachkit(var_1, 0, var_2);
  var_3["primaryFurnitureKit"] = maps\mp\gametypes\_class::cac_getweaponfurniturekit(var_1, 0, var_2);
  var_3["primaryCamo"] = maps\mp\gametypes\_class::cac_getweaponcamo(var_1, 0, var_2);
  var_3["primaryReticle"] = maps\mp\gametypes\_class::cac_getweaponreticle(var_1, 0, var_2);
  var_3["primaryCamoNum"] = int(tablelookup("mp\camoTable.csv", 1, var_3["primaryCamo"], 0));
  var_3["primaryReticleNum"] = int(tablelookup("mp\reticleTable.csv", 1, var_3["primaryReticle"], 0));
  var_3["secondary"] = maps\mp\gametypes\_class::cac_getweapon(var_1, 1, var_2);
  var_3["secondaryAttachKit"] = maps\mp\gametypes\_class::cac_getweaponattachkit(var_1, 1, var_2);
  var_3["secondaryFurnitureKit"] = maps\mp\gametypes\_class::cac_getweaponfurniturekit(var_1, 1, var_2);
  var_3["secondaryCamo"] = maps\mp\gametypes\_class::cac_getweaponcamo(var_1, 1, var_2);
  var_3["secondaryReticle"] = maps\mp\gametypes\_class::cac_getweaponreticle(var_1, 1, var_2);
  var_3["secondaryCamoNum"] = int(tablelookup("mp\camoTable.csv", 1, var_3["secondaryCamo"], 0));
  var_3["secondaryReticleNum"] = int(tablelookup("mp\reticleTable.csv", 1, var_3["secondaryReticle"], 0));
  var_3["equipment"] = maps\mp\gametypes\_class::cac_getequipment(var_1, 0, var_2);
  var_3["offhand"] = maps\mp\gametypes\_class::cac_getequipment(var_1, 1, var_2);

  for (var_4 = 0; var_4 < 3; var_4++)
    var_3["perk" + var_4] = maps\mp\gametypes\_class::cac_getperk(var_1, var_4, var_2);

  var_3["meleeWeapon"] = maps\mp\gametypes\_class::cac_getmeleeweapon(var_1, var_2);
  return var_3;
}

on_agent_player_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {}

playerwaittillloadoutstreamed() {
  self.vlcontroller = level.caccontroller;
  var_0 = maps\mp\_utility::getclassindex("lobby" + self.currentselectedclass);
  var_1 = maps\mp\_utility::cac_getcustomclassloc();
  var_2 = getloadoutvl(var_1, var_0);
  var_3 = var_2["primary"];
  var_4 = var_2["primaryAttachKit"];
  var_5 = var_2["primaryFurnitureKit"];
  var_6 = var_2["primaryCamoNum"];
  var_7 = var_2["primaryReticleNum"];
  var_8 = var_2["secondary"];
  var_9 = var_2["secondaryAttachKit"];
  var_10 = var_2["secondaryFurnitureKit"];
  var_11 = var_2["secondaryCamoNum"];
  var_12 = var_2["secondaryReticleNum"];
  var_13 = self.emblemloadout.emblemindex;

  if(!self.emblemloadout.shouldapplyemblemtoweapon)
    var_13 = -1;

  if(isdefined(level.vlavatars) && isdefined(level.vl_focus) && isdefined(level.vlavatars[level.vl_focus]))
    prep_for_controls(level.vlavatars[level.vl_focus], level.vlavatars[level.vl_focus].angles);

  var_14 = [];

  if(isdefined(var_3) && var_3 != "specialty_null")
    var_14[var_14.size] = maps\mp\gametypes\_class::buildweaponname(var_3, var_4, var_5, var_6, var_7, var_13);

  if(isdefined(var_8) && var_8 != "specialty_null")
    var_14[var_14.size] = maps\mp\gametypes\_class::buildweaponname(var_8, var_9, var_10, var_11, var_12, var_13);

  while (var_14.size > 0) {
    var_15 = self loadweapons(var_14);

    if(var_15 == 1) {
      break;
    }

    waitframe();
  }
}

playermonitorswitchtofiringrange() {
  var_0 = self;

  for (;;) {
    if(isdefined(level.in_firingrange)) {
      var_1 = getdvarint("virtualLobbyInFiringRange", 0);

      if(var_1 == 1 && !level.in_firingrange) {
        var_0 playerwaittillloadoutstreamed();
        var_0 showviewmodel();
        maps\mp\_vl_firingrange::enter_firingrange(var_0);
        var_0 clientclearsoundsubmix("mp_no_foley", 1);
        setdvar("r_dof_physical_bokehEnable", 0);
        setdvar("r_dof_physical_enable", 0);
        setdvar("r_uiblurdstmode", 0);
        setdvar("r_blurdstgaussianblurradius", 1);
      } else if(var_1 == 0 && level.in_firingrange) {
        var_0 hideviewmodel();
        var_0 maps\mp\_vl_firingrange::firingrangecleanup();
        var_0 disable_player_controls();
        resetplayeravatar();

        if(isdefined(var_0.primaryweapon))
          var_0 switchtoweapon(var_0.primaryweapon);

        var_0 notify("enter_lobby");
        enter_vlobby(var_0);
        var_0 clientaddsoundsubmix("mp_no_foley", 1);
        setdvar("r_dof_physical_enable", 1);
        setdvar("r_dof_physical_bokehEnable", 1);
        setdvar("r_uiblurdstmode", 3);
        setdvar("r_blurdstgaussianblurradius", 1.5);
      }
    }

    wait 0.05;
  }
}

playermonitordisconnect() {
  self waittill("disconnect");
  self.camera delete();
  vlprint("remove all ownerIds due to disconnect\n");
  var_0 = level.vlavatars.size;

  for (var_1 = var_0 - 1; var_1 >= 0; var_1--)
    maps\mp\_vl_avatar::removelobbyavatar(level.vlavatars[var_1]);
}

enter_vlobby(var_0) {
  maps\mp\_vl_firingrange::deactivate_targets();
  maps\mp\_vl_camera::cameralink(var_0.camera, var_0);
  var_0 playersetlobbyfovscale();
  var_0 _meth_857A(0);
  var_0 stopshellshock();
  var_0 enablephysicaldepthoffieldscripting();

  if(isdefined(level.vlavatars) && isdefined(level.vl_focus) && isdefined(level.vlavatars[level.vl_focus]))
    var_0 prep_for_controls(level.vlavatars[level.vl_focus], level.vlavatars[level.vl_focus].angles);

  level.in_firingrange = 0;
  var_0 allowfire(0);
  var_0.firingrangeready = undefined;
  maps\mp\_utility::updatesessionstate("spectator");
}

virtual_lobby_set_class(var_0, var_1, var_2, var_3, var_4) {
  if(!self _meth_8585(var_1)) {
    vlprintln("player does not have stats--skipping 'virtual_lobby_set_class': " + var_1);
    return;
  }

  self.pers["class"] = var_2;
  self.class = var_2;
  maps\mp\gametypes\_class::setclass(self.pers["class"]);
  self.vlcontroller = var_1;
  setuploadoutcommonvl();
  playerstreamloadout(var_0, var_3);
}

playerstreamloadout(var_0, var_1) {
  self notify("playerStreamLoadout");
  self endon("playerStreamLoadout");
  maps\mp\gametypes\_class::giveloadout(self.pers["team"], self.pers["class"]);
  var_2 = undefined;
  var_3 = self.loadout.primaryname;

  if(var_1) {
    var_2 = level.vlavatars[var_0];
    var_2.primaryweapon = var_3;
    var_2._id_A7ED = self.loadout._id_A7ED;
    thread playerrefreshavatar(var_0);
  }

  waitstreamweapon(self, var_3, 1);

  if(var_1) {
    var_2._id_A7EA = self.loadout.emblemindex;
    var_2 _meth_8577(self.loadout._id_A7EC);
  }

  maps\mp\gametypes\_class::applyloadout();
}

waitstreamweapon(var_0, var_1, var_2) {
  if(!isdefined(var_2))
    var_2 = 1;

  for (;;) {
    if(isweaponloaded(var_0, var_1, var_2)) {
      break;
    }

    waittillframeend;

    if(isweaponloaded(var_0, var_1, var_2)) {
      break;
    }

    waitframe();
  }
}

playerreloadallavatarmodels() {
  foreach(var_2, var_1 in level.vlavatars)
  playerrefreshavatar(var_2);
}

playerrefreshavatar(var_0) {
  var_1 = level.vlavatars[var_0];
  maps\mp\_vl_avatar::vl_avatar_loadout(self, var_0, var_1.primaryweapon, var_1.costume, var_1._id_A7ED, var_1);
}

getallweaponroomstrings() {
  return ["Sniper", "AssaultRifle", "SMG", "Shotgun", "LMG"];
}

getweaponroomstring(var_0) {
  var_1 = weaponclass(var_0);
  var_2 = "AssaultRifle";

  switch (var_1) {
    case "sniper":
      var_2 = "Sniper";
      break;
    case "rifle":
      var_2 = "AssaultRifle";
      break;
    case "smg":
      var_2 = "SMG";
      break;
    case "spread":
      var_2 = "Shotgun";
      break;
    case "mg":
      var_2 = "LMG";
      break;
    default:
      break;
  }

  return var_2;
}

getweaponroomanimstring(var_0) {
  var_1 = getweaponroomstring(var_0);
  var_2 = maps\mp\_utility::getbaseweaponname(var_0);

  switch (var_2) {
    case "h1_junsho":
      var_1 = var_1 + "_ranger";
      break;
    default:
      break;
  }

  return var_1;
}

getalignmentanimation(var_0) {
  var_1 = "h1_lobby_ar_align";

  switch (var_0) {
    case "Sniper":
      var_1 = "h1_lobby_sni_align";
      break;
    case "AssaultRifle":
      var_1 = "h1_lobby_ar_align";
      break;
    case "SMG":
      var_1 = "h1_lobby_smg_align";
      break;
    case "Shotgun":
      var_1 = "h1_lobby_sht_align";
      break;
    case "LMG":
      var_1 = "h1_lobby_lmg_align";
      break;
    default:
      break;
  }

  return var_1;
}

player_sticks_in_lefty_config(var_0) {
  if(common_scripts\utility::is_player_gamepad_enabled()) {
    var_1 = self getlocalplayerprofiledata("gpadSticksConfig");

    if(isdefined(var_1)) {
      if(var_1 == "thumbstick_default")
        return 0;
      else if(var_1 == "thumbstick_southpaw")
        return 1;
      else if(var_1 == "thumbstick_legacy")
        return var_0 == 1;
      else if(var_1 == "thumbstick_legacysouthpaw")
        return var_0 == 0;
      else {

      }
    }
  }

  return 0;
}

player_get_right_stick(var_0) {
  if(player_sticks_in_lefty_config(var_0.index))
    return var_0.unnormalizedleftstickangle;
  else {
    var_1 = self getunnormalizedcameramovement();
    return var_1[var_0.index];
  }
}

player_update_right_stick(var_0) {
  var_1 = 0;

  if(player_sticks_in_lefty_config(var_0.index)) {
    var_2 = self getnormalizedmovement();
    var_3 = 1;

    if(var_0.index == 1)
      var_3 = -12;
    else
      var_3 = -5;

    var_4 = var_2[var_0.index] * var_3;
    var_0.unnormalizedleftstickangle = angleclamp(var_0.unnormalizedleftstickangle + var_4);
    var_1 = var_0.unnormalizedleftstickangle;
  } else {
    var_2 = self getunnormalizedcameramovement();
    var_1 = var_2[var_0.index];
  }

  return var_1;
}

resetrotationdata(var_0) {
  var_0.mouserot = 0;

  if(!isdefined(var_0.rotateyawdata)) {
    var_0.rotateyawdata = spawnstruct();
    var_0.rotateyawdata.index = 1;
  }

  if(!isdefined(var_0.rotaterolldata)) {
    var_0.rotaterolldata = spawnstruct();
    var_0.rotaterolldata.index = 0;
  }

  var_0.rotateyawdata.storedstick = 0;
  var_0.rotateyawdata.storedangle = var_0.angles[1];
  var_0.rotateyawdata.total = 0;
  var_0.rotateyawdata.addtobaseangle = 0;
  var_0.rotateyawdata.lastangle = 0;
  var_0.rotateyawdata.lastdeltachanged = 0;
  var_0.rotateyawdata.unnormalizedleftstickangle = 0;
  var_0.rotaterolldata.storedstick = 0;
  var_0.rotaterolldata.storedangle = var_0.angles[2];
  var_0.rotaterolldata.total = 0;
  var_0.rotaterolldata.addtobaseangle = 0;
  var_0.rotaterolldata.lastangle = 0;
  var_0.rotaterolldata.lastchanged = 0;
  var_0.rotaterolldata.unnormalizedleftstickangle = 0;
}

prep_for_controls(var_0, var_1) {
  resetrotationdata(var_0);
  var_0.rotateyawdata.storedstick = player_get_right_stick(var_0.rotateyawdata);
  var_0.rotaterolldata.storedstick = player_get_right_stick(var_0.rotaterolldata);

  if(isdefined(var_1)) {
    var_1 = (0, var_1[1], 0);

    if(isagent(var_0))
      var_0 setplayerangles(var_1);
    else
      var_0.angles = var_1;
  }
}

rightstickrotateavatar(var_0, var_1, var_2, var_3) {
  var_4 = getyawrotationangle(var_0, var_1);

  if(isagent(var_0)) {
    var_5 = (0, var_4, 0);

    if(isdefined(var_0.teleportlinker) && var_0 islinked() && var_0 getlinkedparent() == var_0.teleportlinker)
      var_0.teleportlinker.angles = var_5;
    else
      var_0 setplayerangles(var_5);
  } else {
    var_6 = 0;

    if(isdefined(var_3) && var_3 != "Perk")
      var_6 = getrollrotationangle(var_0, var_2);

    var_5 = (0, var_4, var_6);
    var_0.angles = var_5;
  }
}

handlerotateplayeravatar() {
  self notify("handleRotateAvatar");
  self endon("handleRotateAvatar");
  var_0 = level.vlavatars[level.vl_focus];
  prep_for_controls(var_0);

  for (;;) {
    if(maps\mp\_utility::is_true(level.in_firingrange)) {
      waitframe();
      continue;
    }

    rightstickrotateavatar(var_0, 1.0, 5.0);
    waitframe();
  }
}

resetplayeravatar() {
  var_0 = level.vlavatars[level.vl_focus];
  var_0 setplayerangles(var_0.avatar_spawnpoint.angles);
}

handlerotateweaponavatar(var_0) {
  self notify("handleRotateAvatar");
  self endon("handleRotateAvatar");
  prep_for_controls(level.weaponavatarparent);

  for (;;) {
    rightstickrotateavatar(level.weaponavatarparent, 1.0, 5.0, var_0);
    rotaterollbackavatar(level.weaponavatarparent);
    waitframe();
  }
}

resetweaponavatar() {
  level.weaponavatarparent.angles = (0, 30, 0);
}

getyawrotationangle(var_0, var_1) {
  var_2 = player_update_right_stick(var_0.rotateyawdata);
  var_3 = angleclamp(var_2 - var_0.rotateyawdata.storedstick);
  var_4 = getdvarfloat("ui_mouse_char_rot", 0);

  if(var_4 != 0) {
    var_0.mouserot = angleclamp(var_0.mouserot + var_4);
    setdvar("ui_mouse_char_rot", 0);
  }

  var_5 = getangleadd(var_0.rotateyawdata, var_3, var_1);
  var_5 = var_5 * -1;
  var_6 = angleclamp(var_0.rotateyawdata.storedangle + var_5 + var_0.mouserot);
  var_0.rotateyawdata.lastdeltachanged = var_0.rotateyawdata.lastangle - var_6;
  var_0.rotateyawdata.lastangle = var_6;
  return var_6;
}

getrollrotationangle(var_0, var_1) {
  var_2 = 70;
  var_3 = 290;
  var_4 = player_update_right_stick(var_0.rotaterolldata);
  var_5 = angleclamp(var_4 - var_0.rotaterolldata.storedstick);
  var_6 = getangleadd(var_0.rotaterolldata, var_5, var_1);
  var_7 = angleclamp(var_0.rotaterolldata.storedangle + var_6);

  if(var_7 > var_2 && var_7 < var_3) {
    if(var_7 < 180) {
      var_0.rotaterolldata.storedangle = var_0.rotaterolldata.storedangle + (var_2 - var_7);
      var_7 = var_2;
    } else {
      var_0.rotaterolldata.storedangle = var_0.rotaterolldata.storedangle + (var_3 - var_7);
      var_7 = var_3;
    }

    var_0.rotaterolldata.lastchanged = gettime();
  } else if(var_0.rotaterolldata.lastangle != var_7)
    var_0.rotaterolldata.lastchanged = gettime();

  var_0.rotaterolldata.lastangle = var_7;
  return var_7;
}

getangleadd(var_0, var_1, var_2) {
  if(abs(var_1 - var_0.total) > 100) {
    if(var_1 >= 270) {
      var_0.addtobaseangle = var_0.addtobaseangle + -360 * var_2;

      if(var_0.addtobaseangle == -360)
        var_0.addtobaseangle = 0;
    } else if(var_1 <= 100) {
      var_0.addtobaseangle = var_0.addtobaseangle + 360 * var_2;

      if(var_0.addtobaseangle == 360)
        var_0.addtobaseangle = 0;
    }
  }

  var_0.total = var_1;
  var_3 = var_1 * var_2 + var_0.addtobaseangle;
  return var_3;
}

rotaterollbackavatar(var_0) {
  var_1 = 25;
  var_2 = 0.5;
  var_3 = 10;
  var_4 = var_0.angles[2];
  var_4 = angleclamp180(var_4);
  var_5 = abs(var_0.rotateyawdata.lastdeltachanged) > var_2 && abs(var_4) < var_3;

  if(var_4 != 0 && (var_0.rotaterolldata.lastchanged != gettime() || var_5)) {
    var_6 = common_scripts\utility::sign(var_4) * var_1;

    if(abs(var_4) < var_1)
      var_6 = var_4;

    var_7 = (var_0.angles[0], var_0.angles[1], var_0.angles[2] - var_6);
    var_0.angles = var_7;
    var_0.rotaterolldata.storedangle = var_0.rotaterolldata.storedangle - var_6;
    var_0.rotaterolldata.lastangle = var_7[2];
  }
}

player_controls_internal(var_0) {
  self allowfire(var_0);
  self allowcrouch(var_0);
  self allowprone(var_0);
  self allowjump(var_0);
  self allowads(var_0);
  self allowlean(var_0);
  self allowmelee(var_0);
  self allowsprint(var_0);
}

disable_player_controls() {
  player_controls_internal(0);
}

enable_player_controls() {
  var_0 = getdvarint("virtualLobbyInFiringRange", 0);

  if(var_0 == 1 && level.in_firingrange == 1)
    player_controls_internal(1);
}

getfocusfromcontroller(var_0) {
  foreach(var_3, var_2 in level.vlavatars) {
    if(isdefined(var_2.loadout) && isdefined(var_2.loadout.player_controller) && var_2.loadout.player_controller == var_0 && !maps\mp\_utility::is_true(var_2.fakemember))
      return var_3;
  }

  vlprintln("unable to find avatar for controller " + var_0);
  return getconstlocalplayer();
}

playersetlobbyfovscale() {
  playersetfovscale(0.6153);
}

playersetfovscale(var_0) {
  self.fovscale = var_0;
  self setclientdvar("cg_fovscale", var_0);
}

setvirtuallobbypresentable() {
  level notify("cancel_vlp");
  level endon("cancel_vlp");

  while (!level.vl_active || level.vlavatars.size == 0 || !isdefined(level.vlavatars[0]) || !isdefined(level.vlavatars[0].primaryweapon) || !isweaponloaded(level.vlplayer, level.vlavatars[0].primaryweapon, 0) || getdvarint("virtualLobbyInFiringRange", 0) != 0 && !maps\mp\_utility::is_true(level.vlplayer.firingrangeready))
    waitframe();

  wait 0.5;
  setdvar("virtualLobbyPresentable", "1");
}

resetvirtuallobbypresentable() {
  level notify("cancel_vlp");
  level endon("cancel_vlp");
  wait 0.25;
  setdvar("virtualLobbyPresentable", "0");
}

isweaponloaded(var_0, var_1, var_2) {
  var_3 = 0;

  if(isdefined(var_0)) {
    if(var_2)
      var_3 = var_0 loadweapons(var_1);
    else {
      var_3 = var_0 worldweaponsloaded(var_1);

      if(!var_3)
        var_0 loadweapons(var_1);
    }
  }

  return var_3;
}

playermemberfocusprocesslui(var_0, var_1) {
  if(var_0 == "member_select") {
    level.vl_focus = getfocusforxuid(var_1);

    if(!isdefined(level.vl_focus)) {
      vlprint("vl_focus undefined, setting to 0\n");
      level.vl_focus = 0;
    }

    var_2 = level.vlavatars[level.vl_focus];
    thread updateavatarloadout(self, var_2);
    maps\mp\_vl_camera::playerupdatecamera();
    vlprint("selected member " + var_1 + " ownerId=" + level.vl_focus + "\n");
  } else if(var_0 == "vlpresentable") {
    vlprint("in main menu\n");
    thread setvirtuallobbypresentable();
  } else if(var_0 == "leave_lobby") {
    vlprint("leave_lobby xuid=" + var_1 + "\n");
    level.vl_active = 0;
    thread resetvirtuallobbypresentable();
    maps\mp\_vl_camera::playerupdatecamera();
  }
}

getfocusforxuid(var_0) {
  foreach(var_3, var_2 in level.vlavatars) {
    if(isdefined(var_2.loadout) && var_2.loadout.xuid == var_0)
      return var_3;
  }

  return undefined;
}

waittilldepotswitchcomplete() {
  if(maps\mp\_utility::is_true(level.depotinitialized) || getdvarint("vlDepotEnabled", 0) == 0) {
    return;
  }
  while (!maps\mp\_utility::is_true(level.depotinitialized))
    waitframe();

  while (maps\mp\_vl_avatar::allcostumesloaded())
    waitframe();
}

monitor_member_timeouts() {
  for (;;) {
    waittilldepotswitchcomplete();

    foreach(var_2, var_1 in level.vlavatars) {
      if(var_2 == 0) {
        continue;
      }
      if(var_1.membertimeout >= 0) {
        if(var_1.membertimeout < gettime()) {
          if(var_2 == 0 && !isdefined(var_1.memberhastimedout)) {
            var_1.membertimeout = gettime() + 2000;
            var_1.memberhastimedout = 1;
            continue;
          }

          vlprint("Schedule removal of ownerId " + var_2 + " from timeout\n");
          maps\mp\_vl_avatar::removelobbyavatar(var_1);
          maps\mp\_vl_camera::playerupdatecamera();
        }
      }
    }

    waitframe();
  }
}

updatelocalavatarloadouts(var_0) {
  foreach(var_2 in level.vlavatars) {
    if(isdefined(var_2.controller) && isdefined(var_2.loadout)) {
      var_3 = undefined;

      foreach(var_5 in var_0) {
        if(var_2.controller == var_5.player_controller) {
          var_3 = var_5;
          break;
        }
      }

      if(isdefined(var_3) && var_2.xuid != var_3.xuid) {
        var_2.loadout = var_3;
        var_2.xuid = var_3.xuid;
      }
    }
  }
}

memberclasschanges(var_0) {
  if(!isdefined(level.vlplayer) || !isdefined(level.camparams) || level.vlavatars.size == 0) {
    return;
  }
  var_1 = level.vlplayer;
  updatelocalavatarloadouts(var_0);

  foreach(var_3 in var_0) {
    var_4 = maps\mp\_vl_avatar::get_avatar_for_xuid(var_3.xuid);

    if(isdefined(var_4)) {
      if(var_3.player_controller >= 0) {
        var_5 = maps\mp\_vl_avatar::get_ownerid_for_avatar(var_4);
        var_6 = !level.vl_active || !isdefined(var_4.loadout) && getdvarint("virtualLobbyMode", 0) == 6;

        if(isdefined(var_4)) {
          var_4.loadout = var_3;
          var_4.xuid = var_3.xuid;
        }

        if(!var_6)
          continue;
      }
    }

    var_7 = tablelookup("mp\statstable.csv", 0, var_3.primary, 4);
    var_8 = var_3.primaryattachkit;
    var_9 = tablelookup("mp\attachkits.csv", 0, var_3.primaryattachkit, 1);
    var_10 = var_3.primaryfurniturekit;
    var_11 = tablelookup("mp\furniturekits.csv", 0, var_3.primaryfurniturekit, 1);
    var_12 = var_3.primarycamo;
    var_13 = tablelookup("mp\camoTable.csv", 0, var_3.primarycamo, 1);
    var_14 = var_3.primaryreticle;
    var_15 = tablelookup("mp\reticleTable.csv", 0, var_3.primaryreticle, 1);
    var_16 = var_3.playercardpatch;
    var_17 = var_16;
    var_18 = var_3._id_A7EB;
    var_19 = var_3._id_A7EC;

    if(!var_18)
      var_17 = -1;

    var_20 = maps\mp\gametypes\_class::buildweaponname(var_7, var_9, var_11, var_12, var_14, var_17);
    var_21 = maps\mp\_utility::getbaseweaponname(var_20);
    var_22 = [];
    var_22[level.costumecat2idx["gender"]] = var_3.gender;
    var_22[level.costumecat2idx["shirt"]] = var_3.shirt;
    var_22[level.costumecat2idx["head"]] = var_3.head;
    var_22[level.costumecat2idx["gloves"]] = var_3.gloves;
    var_23 = var_3._id_A7ED;

    if(!isdefined(var_4)) {
      var_5 = maps\mp\_vl_avatar::getnewlobbyavatarownerid(var_3.xuid);
      var_24 = maps\mp\gametypes\vlobby::getspawnpoint(getconstlocalplayer());
      var_4 = maps\mp\_vl_avatar::spawn_an_avatar(var_1, var_24, var_20, var_22, var_23, var_3._id_A7E7, var_5, 0);
      setdvar("virtuallobbymembers", level.vlavatars.size);
      thread setvirtuallobbypresentable();
      var_4._id_A7EA = var_16;
      var_4 _meth_8577(var_19);
      var_4.loadout = var_3;
      var_4.xuid = var_3.xuid;
      var_4.membertimeout = gettime() + 4000;

      if(var_3.player_controller >= 0)
        var_4.controller = var_3.player_controller;

      continue;
    }

    var_5 = maps\mp\_vl_avatar::get_ownerid_for_avatar(var_4);

    if(var_3.player_controller >= 0 && isdefined(var_4.savedcostume))
      var_22 = var_4.savedcostume;

    if(var_3.player_controller >= 0 || loadout_changed(var_4.loadout, var_3) || costume_changed(var_4.costume, var_22)) {
      var_25 = var_4.primaryweapon;
      var_4.loadout = var_3;
      var_4.updateloadout = 1;
      var_4.updatecostume = var_22;

      if(var_3.player_controller >= 0) {
        thread updateavatarloadout(var_1, var_4);
        maps\mp\_vl_cac::updatefactionselection(var_3._id_A7E7);

        if(!level.vl_active) {
          level.vl_focus = var_5;
          var_1 thread maps\mp\_vl_camera::playerupdatecamera();
        }

        level.vl_active = 1;
      } else if(!maps\mp\_utility::is_true(var_4.weapclasschanged)) {
        var_4.weapclasschanged = weaponclass_changed(var_25, var_20);

        if(!var_4.weapclasschanged)
          thread updateavatarloadout(var_1, var_4, var_25);
      }
    }
  }
}

updateavatarloadout(var_0, var_1, var_2) {
  if(!maps\mp\_utility::is_true(var_1.updateloadout) || maps\mp\_utility::is_true(level.in_firingrange)) {
    return;
  }
  var_3 = var_1.loadout;
  var_4 = var_1.updatecostume;
  var_5 = maps\mp\_vl_avatar::get_ownerid_for_avatar(var_1);
  var_6 = tablelookup("mp\statstable.csv", 0, var_3.primary, 4);
  var_7 = tablelookup("mp\attachkits.csv", 0, var_3.primaryattachkit, 1);
  var_8 = tablelookup("mp\furniturekits.csv", 0, var_3.primaryfurniturekit, 1);
  var_9 = var_3.primarycamo;
  var_10 = var_3.primaryreticle;
  var_11 = var_3.playercardpatch;
  var_1._id_A7EA = var_11;
  var_12 = var_3._id_A7EB;
  var_13 = var_3._id_A7EC;
  var_1 _meth_8577(var_13);

  if(!var_12)
    var_11 = -1;

  var_14 = maps\mp\gametypes\_class::buildweaponname(var_6, var_7, var_8, var_9, var_10, var_11);
  maps\mp\_vl_avatar::vl_avatar_loadout(var_0, var_5, var_14, var_4, var_3._id_A7ED);
  var_1.updateloadout = undefined;
  var_1.updatecostume = undefined;
  var_1.weapclasschanged = undefined;

  if(var_6 == "h1_junsho" || isdefined(var_2) && issubstr(var_2, "h1_junsho"))
    var_0 maps\mp\_vl_avatar::playerteleportavatartoweaponroom(var_1, level.camparams.camera, 1);
}

setdefaultcostumeifneeded(var_0) {
  if(var_0[level.costumecat2idx["head"]] == 0)
    var_0[level.costumecat2idx["head"]] = 1;

  if(!var_0[level.costumecat2idx["shirt"]])
    var_0[level.costumecat2idx["shirt"]] = 1;

  if(!var_0[level.costumecat2idx["gloves"]])
    var_0[level.costumecat2idx["gloves"]] = 1;

  return var_0;
}

weaponclass_changed(var_0, var_1) {
  if(!isdefined(var_0) || !isdefined(var_1))
    return 1;

  var_2 = weaponclass(var_0);
  var_3 = weaponclass(var_1);

  if(var_2 != var_3)
    return 1;

  return 0;
}

loadout_changed(var_0, var_1) {
  if(!isdefined(var_0))
    return 1;

  if(var_0.primary != var_1.primary)
    return 1;

  if(var_0.primaryattachkit != var_1.primaryattachkit)
    return 1;

  if(var_0.primaryfurniturekit != var_1.primaryfurniturekit)
    return 1;

  if(var_0.primarycamo != var_1.primarycamo)
    return 1;

  if(var_0._id_A7E7 != var_1._id_A7E7)
    return 1;

  if(var_0.playercardpatch != var_1.playercardpatch)
    return 1;

  if(var_0._id_A7EB != var_1._id_A7EB)
    return 1;

  if(var_0._id_A7EC != var_1._id_A7EC)
    return 1;

  if(var_0._id_A7ED != var_1._id_A7ED)
    return 1;

  return 0;
}

costume_changed(var_0, var_1) {
  if(!isdefined(var_0)) {
    if(!isdefined(var_1))
      return 0;

    return 1;
  }

  if(var_0.size != var_1.size)
    return 1;

  if(!maps\mp\gametypes\_teams::validcostume(var_1))
    return 0;

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] < 0)
      return 0;

    if(var_0[var_2] != var_1[var_2])
      return 1;
  }

  return 0;
}

party_members(var_0) {
  if(!isdefined(level.vlavatars) || level.vlavatars.size == 0) {
    return;
  }
  if(!isdefined(level.mccqueue))
    level.mccqueue = [];

  foreach(var_2 in var_0) {
    var_3 = var_2.xuid;
    var_4 = maps\mp\_vl_avatar::get_avatar_for_xuid(var_3);

    if(isdefined(var_4)) {
      var_4.membertimeout = gettime() + 2000;
      var_4.memberhastimedout = undefined;
    }

    if(var_2.primary >= 0)
      add_party_member_class_change(var_2);
  }

  memberclasschanges(level.mccqueue);
  level.mccqueue = [];
}

add_party_member_class_change(var_0) {
  for (var_1 = 0; var_1 < level.mccqueue.size; var_1++) {
    if(level.mccqueue[var_1].xuid == var_0.xuid) {
      level.mccqueue[var_1] = var_0;
      var_0 = undefined;
      break;
    }
  }

  if(isdefined(var_0))
    level.mccqueue[level.mccqueue.size] = var_0;
}

weaponroomscenelightsoff() {
  if(!isdefined(level.weapon_room_lights))
    var_0 = ["weapons_lobby", "weapons_collection", "characters_collection", "characters_personalization", "heads_personalization", "heads_collection"];
  else
    var_0 = [level.weapon_room_lights];

  foreach(var_2 in var_0) {
    var_3 = getentarray(var_2, "targetname");

    foreach(var_5 in var_3) {
      if(!isdefined(var_5.baseintensity)) {
        if(isdefined(var_5.script_multiplier))
          var_5.baseintensity = var_5.script_multiplier;
        else
          var_5.baseintensity = var_5 getlightintensity();
      }

      var_5 setlightintensity(0);
    }
  }
}

weaponroomscenelightsupdate(var_0) {
  weaponroomdof(var_0);

  if(isdefined(level.weapon_room_lights) && level.weapon_room_lights == var_0) {
    return;
  }
  weaponroomscenelightsoff();
  var_1 = getentarray(var_0, "targetname");

  if(var_1.size == 0) {
    if(var_0 == "heads_personalization" || var_0 == "heads_collection" || var_0 == "characters_personalization")
      var_0 = "characters_collection";

    var_1 = getentarray(var_0, "targetname");
  }

  level.weapon_room_lights = var_0;

  foreach(var_3 in var_1)
  var_3 setlightintensity(var_3.baseintensity);
}

weaponroomdof(var_0) {
  if(isdefined(level.weapon_room_dof) && level.weapon_room_dof == var_0) {
    return;
  }
  level.weapon_room_dof = var_0;
  var_1 = 4.7;
  var_2 = 83.2;

  if(var_0 == "heads_personalization") {
    var_1 = 7.1;
    var_2 = 65.1;
  } else if(var_0 == "heads_collection") {
    var_1 = 7.1;
    var_2 = 65.1;
  } else if(var_0 == "characters_personalization") {
    var_1 = 4.7;
    var_2 = 83.2;
  } else if(var_0 == "characters_collection") {
    var_1 = 4.7;
    var_2 = 83.2;
  } else if(var_0 == "weapons_collection" || var_0 == "weapons_lobby")
    return;
  else {}

  maps\mp\_vl_camera::playervlsetphysicaldepthoffield(var_1, var_2);
}

vlprint(var_0) {}

vlprintln(var_0) {}