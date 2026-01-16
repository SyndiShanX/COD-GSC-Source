/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\shared.gsc
********************************/

placeweaponon(var_0, var_1, var_2) {
  self notify("weapon_position_change");
  var_3 = self.weaponinfo[var_0].position;

  if(var_1 != "none" && self.a.weaponpos[var_1] == var_0) {
    return;
  }
  detachallweaponmodels();

  if(var_3 != "none")
    detachweapon(var_0);

  if(var_1 == "none") {
    updateattachedweaponmodels();
    return;
  }

  if(self.a.weaponpos[var_1] != "none")
    detachweapon(self.a.weaponpos[var_1]);
  else if(isdefined(self.weaponinfo["none"]))
    self.weaponinfo["none"].position = "none";

  if(!isdefined(var_2))
    var_2 = 1;

  if(var_2 && (var_1 == "left" || var_1 == "right")) {
    attachweapon(var_0, var_1);
    self.weapon = var_0;
  } else
    attachweapon(var_0, var_1);

  updateattachedweaponmodels();
}

detachweapon(var_0) {
  self.a.weaponpos[self.weaponinfo[var_0].position] = "none";
  self.weaponinfo[var_0].position = "none";
}

attachweapon(var_0, var_1) {
  self.weaponinfo[var_0].position = var_1;
  self.a.weaponpos[var_1] = var_0;

  if(self.a.weaponposdropping[var_1] != "none") {
    self notify("end_weapon_drop_" + var_1);
    self.a.weaponposdropping[var_1] = "none";
  }
}

getweaponforpos(var_0) {
  var_1 = self.a.weaponpos[var_0];

  if(var_1 == "none")
    return self.a.weaponposdropping[var_0];

  return var_1;
}

detachallweaponmodels() {
  var_0 = [];
  var_0[var_0.size] = "right";
  var_0[var_0.size] = "left";
  var_0[var_0.size] = "chest";
  var_0[var_0.size] = "back";
  self laseroff();

  foreach(var_2 in var_0) {
    var_3 = getweaponforpos(var_2);

    if(var_3 == "none") {
      continue;
    }
    if(weapontype(var_3) == "riotshield" && isdefined(self.shieldmodelvariant)) {
      if(isdefined(self.shieldbroken) && self.shieldbroken) {
        playfxontag(common_scripts\utility::getfx("riot_shield_dmg"), self, "TAG_BRASS");
        self.shieldbroken = undefined;
      }
    }
  }

  self updateentitywithweapons();
}

updateattachedweaponmodels() {
  var_0 = [];
  var_1 = [];
  var_2 = [];
  var_0[var_0.size] = "right";
  var_0[var_0.size] = "left";
  var_0[var_0.size] = "chest";
  var_0[var_0.size] = "back";

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
    var_1[var_1.size] = getweaponforpos(var_0[var_3]);
    var_2[var_2.size] = gettagforpos(var_0[var_3]);
  }

  self updateentitywithweapons(var_1[0], var_2[0], var_1[1], var_2[1], var_1[2], var_2[2], var_1[3], var_2[3]);

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = getweaponforpos(var_0[var_3]);

    if(var_4 == "none") {
      continue;
    }
    if(self.weaponinfo[var_4].useclip && !self.weaponinfo[var_4].hasclip) {
      var_5 = getweaponmodel(var_4);
      self hidepart("tag_clip", var_5);
    }
  }

  updatelaserstatus();
}

updatelaserstatus() {
  if(isdefined(self.custom_laser_function))
    [[self.custom_laser_function]]();
  else {
    if(self.a.weaponpos["right"] == "none") {
      return;
    }
    if(canuselaser()) {
      self laseron();
      return;
    }

    self laseroff();
  }
}

canuselaser() {
  if(!self.a.laseron)
    return 0;

  if(animscripts\utility::isshotgun(self.weapon))
    return 0;

  if(!isdefined(level.player.nightvision_enabled))
    return 0;

  return isalive(self);
}

gettagforpos(var_0) {
  switch (var_0) {
    case "chest":
      return "tag_weapon_chest";
    case "back":
      return "tag_stowed_back";
    case "left":
      return "tag_weapon_left";
    case "right":
      return "tag_weapon_right";
    case "hand":
      return "tag_inhand";
    default:
      break;
  }
}

dropaiweapon(var_0) {
  if(!isdefined(var_0))
    var_0 = self.weapon;

  if(var_0 == "none") {
    return;
  }
  if(isdefined(self.nodrop)) {
    return;
  }
  detachallweaponmodels();
  var_1 = self.weaponinfo[var_0].position;

  if(self.dropweapon && var_1 != "none")
    thread dropweaponwrapper(var_0, var_1);

  detachweapon(var_0);

  if(var_0 == self.weapon)
    self.weapon = "none";

  updateattachedweaponmodels();
}

dropallaiweapons() {
  if(isdefined(self.nodrop))
    return "none";

  var_0 = [];
  var_0[var_0.size] = "left";
  var_0[var_0.size] = "right";
  var_0[var_0.size] = "chest";
  var_0[var_0.size] = "back";
  detachallweaponmodels();

  foreach(var_2 in var_0) {
    var_3 = self.a.weaponpos[var_2];

    if(var_3 == "none") {
      continue;
    }
    self.weaponinfo[var_3].position = "none";
    self.a.weaponpos[var_2] = "none";

    if(self.dropweapon)
      thread dropweaponwrapper(var_3, var_2);
  }

  self.weapon = "none";
  updateattachedweaponmodels();
}

dropweaponwrapper(var_0, var_1) {
  if(self isragdoll())
    return "none";

  self.a.weaponposdropping[var_1] = var_0;
  var_2 = var_0;

  if(issubstr(tolower(var_2), "rpg"))
    var_2 = "rpg_player";

  if(issubstr(tolower(var_2), "mahem"))
    var_2 = "iw5_mahemplayer_sp_mahemscopebase";

  self dropweapon(var_2, var_1, 0);
  self endon("end_weapon_drop_" + var_1);
  wait 0.05;

  if(!isdefined(self)) {
    return;
  }
  detachallweaponmodels();
  self.a.weaponposdropping[var_1] = "none";
  updateattachedweaponmodels();
}

donotetracks(var_0, var_1, var_2, var_3) {
  for (;;) {
    self waittill(var_0, var_4);

    if(!isdefined(var_4))
      var_4 = "undefined";

    var_5 = animscripts\notetracks::handlenotetrack(var_4, var_0, var_1, var_3);

    if(isdefined(var_5))
      return var_5;
  }
}

getpredictedaimyawtoshootentorpos(var_0) {
  if(!isdefined(self.shootent)) {
    if(!isdefined(self.shootpos))
      return 0;

    return getaimyawtopoint(self.shootpos);
  }

  var_1 = self.shootent.origin + self.shootentvelocity * var_0;
  return getaimyawtopoint(var_1);
}

getaimyawtoshootentorpos() {
  if(!isdefined(self.shootent)) {
    if(!isdefined(self.shootpos))
      return 0;

    return getaimyawtopoint(self.shootpos);
  }

  if(common_scripts\utility::flag("_cloaked_stealth_enabled"))
    return getaimyawtopoint(animscripts\combat_utility::get_last_known_shoot_pos(self.shootent));
  else
    return getaimyawtopoint(self.shootent getshootatpos());
}

getaimpitchtoshootentorpos() {
  var_0 = getpitchtoshootentorpos();

  if(self.script == "cover_crouch" && isdefined(self.a.covermode) && self.a.covermode == "lean")
    var_0 = var_0 - anim.covercrouchleanpitch;

  return var_0;
}

getpitchtoshootentorpos() {
  if(!isdefined(self.shootent)) {
    if(!isdefined(self.shootpos))
      return 0;

    return animscripts\combat_utility::getpitchtospot(self.shootpos);
  }

  if(common_scripts\utility::flag("_cloaked_stealth_enabled"))
    return animscripts\combat_utility::getpitchtospot(animscripts\combat_utility::get_last_known_shoot_pos(self.shootent));
  else
    return animscripts\combat_utility::getpitchtospot(self.shootent getshootatpos());
}

getshootfrompos() {
  if(isdefined(self.usemuzzlesideoffset)) {
    var_0 = self getmuzzlesideoffsetpos();
    return (var_0[0], var_0[1], self geteye()[2]);
  }

  if(isdefined(self.usemuzzleforaim) && self.usemuzzleforaim) {
    if(self gettagindex("tag_flash") != -1) {
      var_1 = self gettagorigin("tag_flash");

      if(isdefined(var_1))
        return var_1;
    }
  }

  return (self.origin[0], self.origin[1], self geteye()[2]);
}

getaimyawtopoint(var_0) {
  var_1 = animscripts\utility::getyawtospot(var_0);
  var_2 = distance(self.origin, var_0);

  if(var_2 > 3) {
    var_3 = asin(-3 / var_2);
    var_1 = var_1 + var_3;
  }

  var_1 = angleclamp180(var_1);
  return var_1;
}

#using_animtree("generic_human");

ramboaim(var_0) {
  self endon("killanimscript");
  ramboaiminternal(var_0);
  self clearanim( % generic_aim_left, 0.5);
  self clearanim( % generic_aim_right, 0.5);
}

ramboaiminternal(var_0) {
  self endon("rambo_aim_end");
  waittillframeend;
  self clearanim( % generic_aim_left, 0.2);
  self clearanim( % generic_aim_right, 0.2);
  self setanimlimited( % generic_aim_45l, 1, 0.2);
  self setanimlimited( % generic_aim_45r, 1, 0.2);
  var_1 = 0.2;
  var_2 = 0;

  for (;;) {
    if(isdefined(self.shootpos)) {
      var_3 = animscripts\utility::getyaw(self.shootpos) - self.covernode.angles[1];
      var_3 = angleclamp180(var_3 - var_0);

      if(abs(var_3 - var_2) > 10) {
        if(var_3 > var_2)
          var_3 = var_2 + 10;
        else
          var_3 = var_2 - 10;
      }

      var_2 = var_3;
    }

    if(var_2 < 0) {
      var_4 = var_2 / -45;

      if(var_4 > 1)
        var_4 = 1;

      self setanimlimited( % generic_aim_right, var_4, var_1);
      self setanimlimited( % generic_aim_left, 0, var_1);
    } else {
      var_4 = var_2 / 45;

      if(var_4 > 1)
        var_4 = 1;

      self setanimlimited( % generic_aim_left, var_4, var_1);
      self setanimlimited( % generic_aim_right, 0, var_1);
    }

    wait(var_1);
  }
}

decidenumshotsforburst() {
  var_0 = 0;
  var_1 = weaponburstcount(self.weapon);

  if(var_1)
    var_0 = var_1;
  else if(animscripts\weaponlist::usingsemiautoweapon())
    var_0 = anim.semifirenumshots[randomint(anim.semifirenumshots.size)];
  else if(self.fastburst)
    var_0 = anim.fastburstfirenumshots[randomint(anim.fastburstfirenumshots.size)];
  else
    var_0 = anim.burstfirenumshots[randomint(anim.burstfirenumshots.size)];

  if(var_0 <= self.bulletsinclip)
    return var_0;

  if(self.bulletsinclip <= 0)
    return 1;

  return self.bulletsinclip;
}

decidenumshotsforfull() {
  var_0 = self.bulletsinclip;

  if(weaponclass(self.weapon) == "mg") {
    var_1 = randomfloat(10);

    if(var_1 < 3)
      var_0 = randomintrange(2, 6);
    else if(var_1 < 8)
      var_0 = randomintrange(6, 12);
    else
      var_0 = randomintrange(12, 20);
  }

  return var_0;
}

handledropclip(var_0) {
  self endon("killanimscript");
  self endon("abort_reload");
  var_1 = undefined;

  if(self.weaponinfo[self.weapon].useclip)
    var_1 = getweaponclipmodel(self.weapon);

  if(self.weaponinfo[self.weapon].hasclip) {
    if(animscripts\utility::usingsidearm())
      self playsound("weap_reload_pistol_clipout_npc");
    else
      self playsound("weap_reload_smg_clipout_npc");

    if(isdefined(var_1)) {
      var_2 = getweaponmodel(self.weapon);
      self hidepart("tag_clip", var_2);
      thread dropclipmodel(var_1, "tag_clip");
      self.weaponinfo[self.weapon].hasclip = 0;
      thread resetcliponabort(var_1);
    }
  }

  for (;;) {
    self waittill(var_0, var_3);

    switch (var_3) {
      case "attach clip right":
      case "attach clip left":
        if(isdefined(var_1)) {
          self attach(var_1, "tag_inhand");
          thread resetcliponabort(var_1, "tag_inhand");

          if(!self.weaponinfo[self.weapon].hasclip) {
            var_2 = getweaponmodel(self.weapon);
            self hidepart("tag_clip", var_2);
          }
        }

        animscripts\weaponlist::refillclip();
        break;
      case "detach clip nohand":
        if(isdefined(var_1))
          self detach(var_1, "tag_inhand");

        break;
      case "detach clip right":
      case "detach clip left":
        if(isdefined(var_1)) {
          self detach(var_1, "tag_inhand");
          var_2 = getweaponmodel(self.weapon);
          self showpart("tag_clip", var_2);
          self notify("clip_detached");
          self.weaponinfo[self.weapon].hasclip = 1;
        }

        if(animscripts\utility::usingsidearm())
          self playsound("weap_reload_pistol_clipin_npc");
        else
          self playsound("weap_reload_smg_clipin_npc");

        self.a.needstorechamber = 0;
        return;
    }
  }
}

resetcliponabort(var_0, var_1) {
  self notify("clip_detached");
  self endon("clip_detached");
  common_scripts\utility::waittill_any("killanimscript", "abort_reload");

  if(!isdefined(self)) {
    return;
  }
  if(isdefined(var_1))
    self detach(var_0, var_1);

  if(isalive(self)) {
    if(self.weapon != "none" && self.weaponinfo[self.weapon].position != "none") {
      var_2 = getweaponmodel(self.weapon);
      self showpart("tag_clip", var_2);
    }

    self.weaponinfo[self.weapon].hasclip = 1;
  } else if(isdefined(var_1))
    dropclipmodel(var_0, var_1);
}

dropclipmodel(var_0, var_1) {
  var_2 = spawn("script_model", self gettagorigin(var_1));
  var_2 setmodel(var_0);
  var_2.angles = self gettagangles(var_1);
  var_2 physicslaunchclient(var_2.origin, (0, 0, 0));
  wait 10;

  if(isdefined(var_2))
    var_2 delete();
}

movetonodeovertime(var_0, var_1) {
  self endon("killanimscript");
  var_2 = var_0.origin;
  var_3 = distancesquared(self.origin, var_2);

  if(var_3 < 1) {
    self safeteleport(var_2);
    return;
  }

  if(var_3 > 256 && !self maymovetopoint(var_2, !self.swimmer)) {
    return;
  }
  self.keepclaimednodeifvalid = 1;
  var_4 = distance(self.origin, var_2);
  var_5 = int(var_1 * 20);

  for (var_6 = 0; var_6 < var_5; var_6++) {
    var_2 = var_0.origin;
    var_7 = self.origin - var_2;
    var_7 = vectornormalize(var_7);
    var_8 = var_2 + var_7 * var_4;
    var_9 = var_8 + (var_2 - var_8) * ((var_6 + 1) / var_5);
    self safeteleport(var_9);
    wait 0.05;
  }

  self.keepclaimednodeifvalid = 0;
}

returntrue() {
  return 1;
}

playlookanimation(var_0, var_1, var_2) {
  if(!isdefined(var_2))
    var_2 = ::returntrue;

  for (var_3 = 0; var_3 < var_1 * 10; var_3++) {
    if(isalive(self.enemy)) {
      if(animscripts\utility::canseeenemy() && [
          [var_2]
        ]())
        return;
    }

    if(animscripts\utility::issuppressedwrapper() && [
        [var_2]
      ]()) {
      return;
    }
    self setanimknoball(var_0, % body, 1, 0.1);
    wait 0.1;
  }
}

throwdownweapon(var_0) {
  self endon("killanimscript");
  self animmode("angle deltas");
  self setflaggedanimknoballrestart("weapon swap", var_0, % body, 1, 0.1, 1);
  thread animscripts\combat_utility::putgunbackinhandonkillanimscript();
  donotetracks("weapon swap");
  maps\_gameskill::didsomethingotherthanshooting();
}

rpgplayerrepulsor() {
  var_0 = rpgplayerrepulsor_getnummisses();

  if(var_0 == 0) {
    return;
  }
  self endon("tracksuit_removed");
  self endon("death");

  for (;;) {
    level waittill("an_enemy_shot", var_1);

    if(var_1 != self) {
      continue;
    }
    if(!isdefined(var_1.enemy)) {
      continue;
    }
    if(var_1.enemy != level.player) {
      continue;
    }
    if(isdefined(level.createrpgrepulsors) && level.createrpgrepulsors == 0) {
      continue;
    }
    thread rpgplayerrepulsor_create();
    var_0--;

    if(var_0 <= 0)
      return;
  }
}

rpgplayerrepulsor_getnummisses() {
  var_0 = maps\_utility::getdifficulty();

  switch (var_0) {
    case "gimp":
    case "easy":
      return 2;
    case "difficult":
    case "hard":
    case "medium":
      return 1;
    case "fu":
      return 0;
  }

  return 2;
}

rpgplayerrepulsor_create() {
  var_0 = missile_createrepulsorent(level.player, 5000, 800);
  wait 4.0;
  missile_deleteattractor(var_0);
}