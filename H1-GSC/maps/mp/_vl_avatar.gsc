/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\_vl_avatar.gsc
********************************/

init_avatar() {
  level.maxavatars = 18;
  setdvar("scr_vl_link_primary_weap", 0);
  animateallweaponrooms();
}

init_avatar_pool() {
  var_0 = 3;
  var_1 = level.maxavatars + var_0;
  level.vlavatarpool = [];

  for (var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = maps\mp\agents\_agent_utility::getfreeagent();
    level.vlavatarpool[var_2] = var_3;
    var_3 spawnagent((0, 0, 0), (0, 0, 0));
    var_3 set_agent_values("spectator", "none");
    var_3 maps\mp\agents\_agent_common::set_agent_health(100);
    var_3 botclearscriptenemy();
    var_3 botclearscriptgoal();
    var_3 bot_disable_tactical_goals();
    var_3 botsetflag("disable_movement", 1);
    var_3 botsetflag("disable_rotation", 1);
    var_3.isfree = 1;
  }
}

playerspawnlocalplayeravatar(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self;
  var_6 = maps\mp\gametypes\_class::getloadout(var_5.pers["team"], var_1);
  maps\mp\_vl_base::vlprintln("adding xuid " + var_0 + "from vlobby_player");
  var_7 = getnewlobbyavatarownerid(var_0);
  var_8 = spawn_an_avatar(var_5, var_5.avatar_spawnpoint, var_6.primaryname, var_2, var_3, undefined, var_7);
  var_8._id_A7EA = var_6.emblemindex;
  var_8 _meth_8577(var_6._id_A7EC);
  var_8.controller = var_4;
  var_8.xuid = var_0;
  setdvar("virtuallobbymembers", level.vlavatars.size);
}

bot_disable_tactical_goals() {
  self.disable_tactical_goals = 1;
  self.tactical_goals = [];
}

set_agent_values(var_0, var_1) {
  maps\mp\agents\_agent_utility::set_agent_team(var_0);
  self.agent_gameparticipant = 0;
  self.isactive = 1;
  self.spawntime = gettime();
  self.issniper = 0;
  self.sessionteam = var_1;
}

alloc_avatar() {
  if(!isdefined(level.vlavatarpool))
    init_avatar_pool();

  foreach(var_1 in level.vlavatarpool) {
    if(var_1.isfree) {
      var_1.isfree = 0;
      return var_1;
    }
  }
}

free_avatar(var_0) {
  var_0 notify("free_avatar");
  var_0.isfree = 1;
}

teleport_avatar(var_0, var_1, var_2) {
  var_0 unlink();
  var_0 setplayerangles(var_1.angles);
  var_3 = getgroundposition(var_1.origin, 20, 512, 120);
  var_0 setorigin(var_3, 1);
  var_2 setorigin(var_3, 1);
  var_4 = get_ownerid_for_avatar(var_0);
  var_2 maps\mp\_vl_base::playerrefreshavatar(var_4);
}

teleport_avatar_stick(var_0, var_1, var_2) {
  var_0 unlink();

  if(!isdefined(var_0.teleportlinker)) {
    var_0.teleportlinker = spawn("script_model", var_1.origin);
    var_0.teleportlinker setmodel("tag_origin");
  }

  var_0.origin = var_1.origin;
  var_0.angles = var_1.angles;
  var_0.teleportlinker.origin = var_1.origin;
  var_0.teleportlinker.angles = var_1.angles;
  var_0.teleportlinker dontinterpolatewrapper();

  if(!maps\mp\_utility::is_true(level.vl_setup))
    maps\mp\_utility::waittillplayersnextsnapshot(var_2);

  var_0 linktosynchronizedparent(var_0.teleportlinker, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_2 setorigin(var_1.origin, 1);
  var_3 = get_ownerid_for_avatar(var_0);
  var_2 maps\mp\_vl_base::playerrefreshavatar(var_3);
}

dontinterpolatewrapper() {
  if(!isdefined(self.lastinterpolatetime))
    self.lastinterpolatetime = 0;

  var_0 = gettime();
  var_1 = self.lastinterpolatetime == var_0;

  if(!var_1)
    self dontinterpolate();

  self.lastinterpolatetime = var_0;
}

spawn_an_avatar(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isdefined(var_8))
    var_8 = 0;

  if(!isdefined(var_7))
    var_7 = 1;

  var_11 = "allies";
  var_12 = "none";
  var_13 = alloc_avatar();
  var_1.spawned_avatar = var_13;
  var_13.avatar_spawnpoint = var_1;
  var_13.costume = var_3;
  var_13 set_agent_values(var_11, var_12);
  var_14 = getgroundposition(var_13.avatar_spawnpoint.origin, 20, 512, 120);
  var_13.spawn_angles = (var_1.angles[0], var_1.angles[1], var_1.angles[2]);
  var_13.angles = var_13.spawn_angles;
  var_13 show();
  var_13 setplayerangles(var_13.spawn_angles);
  var_13 setorigin(var_14, 1);
  var_13.angles = var_13.spawn_angles;
  var_13.startangles = var_13.spawn_angles;
  maps\mp\_vl_base::resetrotationdata(var_13);
  var_13.camera_tag_origin = (0, 0, 0);
  var_13.camera_tag_angles = (0, 0, 0);
  var_13 motionblurhqenable();
  var_13 maps\mp\gametypes\_spawnlogic::addtocharactersarray();

  if(isdefined(var_9)) {
    var_13 detachall();
    var_13 setmodel(var_9);
    var_13.bodymodel = var_9;

    if(isdefined(var_10)) {
      var_13 attach(var_10);
      var_13.head = var_10;
    }
  } else {
    thread vl_avatar_loadout(var_0, var_6, var_2, var_3, var_4, var_13, var_5);
    var_0 thread wait_load_costume(var_13, var_7);
  }

  if(!isscriptedagent(var_13))
    var_13 enableanimstate(1);

  if(var_8)
    var_13.isdepotagent = 1;
  else {
    level.vlavatars[var_6] = var_13;

    if(var_7)
      var_0 playerteleportavatartoweaponroom(var_13, level.camparams.camera);
    else
      var_13 agentplaycacanim();
  }

  if(var_7)
    show_avatar(var_13, !var_8);
  else
    hide_avatar(var_13);

  var_13.fakemember = undefined;
  return var_13;
}

wait_load_costume_show(var_0) {
  if(isalive(var_0)) {
    var_1 = isdefined(level.cac_weap);

    if(!var_1)
      show_avatar(var_0);
  }
}

wait_load_costume_timeout(var_0, var_1) {
  self endon("disconnect");
  var_1 endon("wait_load_costume");
  var_1 endon("death");
  var_1 endon("hide_avatar");
  wait(var_0);
  wait_load_costume_show(var_1);
  var_1 notify("wait_load_costume");
}

wait_load_costume(var_0, var_1) {
  self endon("disconnect");
  var_0 notify("wait_load_costume");
  var_0 endon("wait_load_costume");
  var_0 endon("death");

  if(!isdefined(var_1))
    var_1 = 1;

  hide_avatar(var_0);

  if(var_1)
    thread wait_load_costume_timeout(5.0, var_0);

  var_2 = "none";

  if(isdefined(var_0.primaryweapon))
    var_2 = var_0.primaryweapon;

  var_3 = maps\mp\_vl_cac::getfactionteam();
  var_4 = maps\mp\_vl_cac::getfactionenvironment();
  var_0.costumeloaded = 0;

  for (var_5 = self loadcostumemodels(var_0.costume, var_0.team, var_2, var_4); !var_5; var_5 = self loadcostumemodels(var_0.costume, var_0.team, var_2, var_4))
    waitframe();

  var_0.costumeloaded = 1;

  if(var_1)
    wait_load_costume_show(var_0);

  var_0 notify("wait_load_costume");
}

allcostumesloaded() {
  foreach(var_1 in level.vlavatars) {
    if(!maps\mp\_utility::is_true(var_1.costumeloaded))
      return 0;
  }

  return 1;
}

getnewlobbyavatarownerid(var_0) {
  for (var_1 = 0; isdefined(level.vlavatars[var_1]); var_1++) {}

  maps\mp\_vl_base::vlprint("Adding new xuid " + var_0 + " with ownerId=" + var_1 + "\n");
  return var_1;
}

showavataronly(var_0, var_1) {
  foreach(var_3 in level.vlavatars) {
    if(var_0 == var_3) {
      show_avatar(var_3, var_1);
      continue;
    }

    hide_avatar(var_3);
  }
}

hide_avatar(var_0) {
  if(isdefined(var_0)) {
    var_0 notify("hide_avatar");
    var_0 hide();
    var_0 hideallparts();
    hide_avatar_weapons(var_0);
  }
}

show_avatar(var_0, var_1) {
  var_0 show();
  var_0 showallparts();

  if(!isdefined(var_1))
    var_1 = 1;

  if(var_1) {
    show_avatar_primary_weapon(var_0);
    var_0.hideweapons = undefined;
  }
}

show_avatar_primary_weapon(var_0) {
  if(isdefined(var_0.primaryweaponent)) {
    var_0.primaryweaponent show();
    var_0.primaryweaponent showallparts();
  } else if(isdefined(var_0.heldweapon) && !var_0 hasweapon(var_0.heldweapon))
    var_0 thread avatargiveheldweapon();
}

avatargiveheldweapon() {
  self notify("give_avatar_held_weapon");
  self endon("give_avatar_held_weapon");
  self endon("free_avatar");
  self endon("heldWeaponGone");
  maps\mp\_vl_base::waitstreamweapon(level.vlplayer, self.heldweapon, 0);

  if(!maps\mp\_utility::is_true(self.hideweapons)) {
    self giveweapon(self.heldweapon);
    self switchtoweapon(self.heldweapon);
    self setspawnweapon(self.heldweapon);
  }
}

hide_avatar_primary_weapon(var_0) {
  if(isdefined(var_0.primaryweaponent)) {
    var_0 notify("hide_primary_weapon");
    var_0.primaryweaponent hide();
    var_0.primaryweaponent hideallparts();
  } else if(isdefined(var_0.heldweapon) && var_0 hasweapon(var_0.heldweapon))
    var_0 takeweapon(var_0.heldweapon);

  var_0 notify("heldWeaponGone");
  var_0.primaryhidden = 1;
}

hide_avatar_weapons(var_0) {
  hide_avatar_primary_weapon(var_0);
  var_0.hideweapons = 1;
}

hide_avatars() {
  foreach(var_1 in level.vlavatars)
  hide_avatar(var_1);
}

show_avatars() {
  foreach(var_1 in level.vlavatars)
  show_avatar(var_1);
}

get_xuid_for_avatar(var_0) {
  if(isdefined(var_0.xuid))
    return var_0.xuid;

  if(isdefined(var_0.loadout))
    return var_0.loadout.xuid;

  return "";
}

get_avatar_for_xuid(var_0) {
  foreach(var_2 in level.vlavatars) {
    if(isdefined(var_2.xuid) && var_2.xuid == var_0)
      return var_2;

    if(isdefined(var_2.loadout) && var_2.loadout.xuid == var_0)
      return var_2;
  }

  return undefined;
}

get_ownerid_for_avatar(var_0) {
  foreach(var_3, var_2 in level.vlavatars) {
    if(var_0 == var_2)
      return var_3;
  }

  return 0;
}

removelobbyavatar(var_0) {
  var_1 = get_ownerid_for_avatar(var_0);
  level.vlavatars[var_1] = undefined;
  setdvar("virtuallobbymembers", level.vlavatars.size);

  if(level.vl_focus == var_1) {
    if(level.vlavatars.size > 0) {
      foreach(var_4, var_3 in level.vlavatars) {
        level.vl_focus = var_4;
        break;
      }
    }
  }

  hide_avatar(var_0);
  var_0 takeallweapons();
  var_0 detachall();
  var_0.headmodel = undefined;
  var_0 hideallparts();

  if(isdefined(var_0.avatar_spawnpoint.spawned_avatar))
    var_0.avatar_spawnpoint.spawned_avatar = undefined;

  if(isdefined(var_0.primaryweaponent)) {
    var_0.primaryweaponent delete();
    var_0.primaryweaponent = undefined;
  }

  var_0.primaryweapon = undefined;
  var_0.stored_weapon = undefined;
  var_0.heldweapon = undefined;
  var_0.hideweapons = undefined;
  var_0.lastanim = undefined;
  var_0.updateloadout = undefined;
  var_0.updatecostume = undefined;
  var_0.weapclasschanged = undefined;
  free_avatar(var_0);

  if(level.vl_focus == var_1)
    level.vl_focus = 0;
}

vl_avatar_costume(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isdefined(var_2))
    var_1.costume = var_2;

  var_1 maps\mp\gametypes\_teams::applycostume(var_3, var_4, var_5);
}

vl_avatar_loadout(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isdefined(var_5))
    var_5 = level.vlavatars[var_1];

  var_7 = maps\mp\_vl_cac::getfactionteam();
  var_8 = maps\mp\_vl_cac::getfactionenvironment();

  if(isdefined(var_6)) {
    var_7 = level.vl_factions[var_6].team;
    var_8 = level.vl_factions[var_6]._id_3338;
  } else if(isdefined(var_5.loadout) && isdefined(var_5.loadout._id_A7E7)) {
    var_7 = level.vl_factions[var_5.loadout._id_A7E7].team;
    var_8 = level.vl_factions[var_5.loadout._id_A7E7]._id_3338;
  }

  var_5 takeallweapons();
  vl_avatar_costume(var_0, var_5, var_3, var_2, var_7, var_8);
  var_0 setcostumemodels(var_5.costume, maps\mp\_utility::getbaseweaponname(var_2) + "_mp", var_7, var_8);
  var_0 _meth_857C(var_4);
  var_5 _meth_857C(var_4);
  var_5.primaryweapon = var_2;
  var_5._id_A7ED = var_4;
  maps\mp\_vl_base::waitstreamweapon(var_0, var_2, 0);
  vl_give_weapons(var_5);
}

vl_give_weapons(var_0) {
  if(!isdefined(var_0.primaryweapon)) {
    return;
  }
  if(var_0.primaryweapon != "" && var_0.primaryweapon != "none" && var_0.primaryweapon != "specialty_null")
    var_0 avatarattachprimaryweapons();
  else
    hide_avatar_weapons(var_0);
}

avatarattachprimaryweapons() {
  if(getdvarint("scr_vl_link_primary_weap", 0) != 0) {
    if(isdefined(self.heldweapon)) {
      if(self hasweapon(self.heldweapon))
        self takeweapon(self.heldweapon);

      self.heldweapon = undefined;
      self notify("heldWeaponGone");
    }

    if(!isdefined(self.primaryweaponent)) {
      var_0 = spawn("weapon_" + self.primaryweapon, (0, 0, 0));
      var_1 = get_xuid_for_avatar(self);
      self.primaryweaponent = var_0;
      var_0.primaryweapon = self.primaryweapon;
      self.primaryweaponent show();
      self.primaryweaponent showallparts();
      self.primaryweaponent setpickupweapon(self.primaryweapon);
    } else if(self.primaryweaponent.primaryweapon != self.primaryweapon) {
      self.primaryweaponent.primaryweapon = self.primaryweapon;
      self.primaryweaponent setpickupweapon(self.primaryweapon);
    }

    if(isdefined(self.primaryweaponent))
      thread attachprimaryweapon(self);
  } else {
    if(isdefined(self.primaryweaponent)) {
      var_1 = get_xuid_for_avatar(self);
      self.primaryweaponent delete();
      self.primaryweaponent = undefined;
    }

    if(!isdefined(self.heldweapon) || self.heldweapon != self.primaryweapon || !maps\mp\_utility::is_true(self.hideweapons) && !self hasweapon(self.heldweapon)) {
      if(isdefined(self.heldweapon))
        self takeweapon(self.heldweapon);

      self.heldweapon = self.primaryweapon;
      thread avatargiveheldweapon();
    }
  }
}

attachprimaryweapon(var_0) {
  var_1 = undefined;

  if(isdefined(var_0.player))
    var_1 = var_0.player;

  var_2 = "tag_weapon_right";

  if(issubstr(var_0.primaryweaponent.primaryweapon, "combatknife"))
    var_2 = "tag_inhand";

  if(issubstr(var_0.primaryweaponent.primaryweapon, "riotshield"))
    var_2 = "tag_weapon_left";

  var_0.primaryweaponent unlink();
  var_0.primaryweaponent.origin = var_0 gettagorigin(var_2);
  var_0.primaryweaponent.angles = var_0 gettagangles(var_2);
  var_0.primaryweaponent linktosynchronizedparent(var_0, var_2, (0, 0, 0), (0, 0, 0));
  var_0.primaryweaponent setowneroriginal(var_1);
}

playerteleportavatarcao(var_0, var_1) {
  teleport_avatar_stick(var_0, var_1, self);
  var_0 agentplaycacanim();
}

playerteleportavatartocac(var_0) {
  teleport_avatar(var_0, var_0.avatar_spawnpoint, self);
  var_0 agentplaycacanim();
}

playerteleportavatartoweaponroom(var_0, var_1, var_2) {
  var_3 = maps\mp\_vl_base::getweaponroomstring(var_0.primaryweapon);
  maps\mp\_vl_base::vlprintln("playerTeleportAvatarToWeaponRoom - weap = " + var_0.primaryweapon + ", loc = " + var_3);
  var_4 = "character" + var_3;
  var_5 = common_scripts\utility::getstruct(var_4, "targetname");
  var_1.scenenode = var_5.scenenode;
  var_0 unlink();
  var_0 agentplaylobbyanim(var_1.scenenode, var_0.primaryweapon, var_2);
}

getlobbyidleanimalias(var_0) {
  var_1 = "idle";
  var_2 = maps\mp\_utility::getbaseweaponname(var_0);

  switch (var_2) {
    case "h1_junsnp":
    case "h1_dragunov":
    case "h1_barrett":
    case "h1_m14":
      var_1 = "idle_alt";
      break;
    default:
      break;
  }

  return var_1;
}

agentplaylobbyanim(var_0, var_1, var_2) {
  var_3 = tolower(maps\mp\_vl_base::getweaponroomanimstring(var_1));
  var_4 = "lobby_" + var_3;
  var_5 = getlobbyidleanimalias(var_1);
  var_6 = var_4 + var_5;

  if(!isdefined(self.lastanim) || self.lastanim != var_6) {
    var_7 = 0.0;

    if(maps\mp\_utility::is_true(var_2))
      var_7 = randomfloat(1.0);

    self setanimclass("vlobby_animclass");
    self setanimstate(var_4, var_5, 1, var_7);
    self.lastanim = var_6;
    self scragentsetscripted(1);
    self scragentsetphysicsmode("noclip");
    self scragentsynchronizeanims(0, 0, var_0, "j_prop_1", "tag_origin");
  }

  show_avatar(self);
}

debugnode(var_0) {
  var_0 notify("debugNode");
  var_0 endon("debugNode");

  for (;;) {
    var_1 = var_0.origin;
    var_2 = var_0 gettagorigin("j_prop_1");
    var_3 = var_0 gettagangles("j_prop_1");
    var_4 = anglestoforward(var_3);
    var_5 = var_2 + var_4 * 5;
    var_6 = var_0 gettagorigin("j_prop_2");
    var_7 = var_0 gettagangles("j_prop_2");
    var_8 = anglestoforward(var_7);
    var_9 = var_6 + var_8 * 5;
    waitframe();
  }
}

agentplaycacanim() {
  var_0 = "lobby_idle";
  var_1 = "cao_01";
  var_2 = var_0 + var_1;

  if(!isdefined(self.lastanim) || self.lastanim != var_2) {
    self setanimclass("vlobby_animclass");
    self scragentsetscripted(0);
    self scragentsetorientmode("face angle abs", self.spawn_angles);
    self setanimstate(var_0, var_1);
    self.lastanim = var_2;
  }

  hide_avatar_weapons(self);
}

animateallweaponrooms() {
  var_0 = maps\mp\_vl_base::getallweaponroomstrings();

  foreach(var_2 in var_0) {
    var_3 = "character" + var_2;
    var_4 = common_scripts\utility::getstruct(var_3, "targetname");
    var_4.scenenode = spawn("script_model", var_4.origin);
    var_4.scenenode setmodel("genericprop_x5");
    var_4.scenenode.location = var_2;
    var_4.scenenode.characterstruct = var_4;
    animateweaponroomscenenode(var_4.scenenode, var_4, var_2);
  }
}

animateweaponroomscenenode(var_0, var_1, var_2) {
  var_3 = maps\mp\_vl_base::getalignmentanimation(var_2);
  var_0 scriptmodelplayanimdeltamotionfrompos(var_3, var_1.origin, var_1.angles, "scene_node_anim");
  startweaponroompropanimations(var_0, var_1, var_2);
}

cameralinktoscenenode(var_0, var_1, var_2) {
  var_0 linktosynchronizedparent(var_1, var_2, (0, 0, 0), (0, 0, 0));
}

startweaponroompropanimations(var_0, var_1, var_2) {
  var_3 = getent("mk19", "targetname");

  if(var_2 == "LMG") {
    if(isdefined(var_3)) {
      if(!var_3 islinked())
        var_3 linktosynchronizedparent(var_0, "J_prop_3", (0, 0, 0), (0, 0, 0));

      var_3 show();
      var_3 scriptmodelplayanimdeltamotionfrompos("h1_lobby_mk19_idle", var_1.origin, var_1.angles, "mk19_anim");
    }
  } else if(isdefined(var_3))
    var_3 hide();
}