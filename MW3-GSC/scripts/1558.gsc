/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1558.gsc
**************************************/

main() {
  _id_3C66();
  _id_3C6A();
  _id_3C6C();

  if(common_scripts\utility::issp_towerdefense()) {
    _id_3C6B();
    _id_3C6D();
  }
}

_id_3C66() {
  precachestring(&"SENTRY_MOVE");
  precachestring(&"SENTRY_PICKUP");
  precachestring(&"SENTRY_PLACE");
  precachestring(&"SENTRY_CANNOT_PLACE");
  precachemodel("tag_laser");
  level._id_3C67 = [];
  level._id_3C68 = [];
  level._id_3C69 = [];
  level._id_3C69["easy"] = [];
  level._id_3C69["easy"]["convergencePitchTime"] = 2.5;
  level._id_3C69["easy"]["convergenceYawTime"] = 2.5;
  level._id_3C69["easy"]["suppressionTime"] = 3.0;
  level._id_3C69["easy"]["aiSpread"] = 2.0;
  level._id_3C69["easy"]["playerSpread"] = 0.5;
  level._effect["sentry_turret_overheat_smoke_sp"] = loadfx("smoke/sentry_turret_overheat_smoke_sp");
  level._effect["sentry_turret_explode"] = loadfx("explosions/sentry_gun_explosion");
  level._effect["sentry_turret_explode_smoke"] = loadfx("smoke/car_damage_blacksmoke");
}

_id_3C6A() {
  precachemodel("sentry_minigun");
  precachemodel("sentry_minigun_obj");
  precachemodel("sentry_minigun_obj_red");
  precachemodel("sentry_minigun_folded_obj");
  precachemodel("sentry_minigun_destroyed");

  if(common_scripts\utility::issp() && !_id_0A36()) {
    precacheturret("sentry_minigun");
    precacheturret("sentry_minigun_enemy");
  } else if(_id_0A36()) {
    precacheturret("sentry_minigun_so");
  } else {
    precacheturret("sentry_minigun_mp");
  }
  level._id_3C68["sentry_minigun"] = spawnStruct();
  _id_3C7D("sentry_minigun");
  _id_3C6E("sentry_minigun");
  common_scripts\utility::array_thread(getEntArray("script_model_pickup_sentry_minigun", "classname"), ::_id_3C7F, "sentry_minigun");
}

_id_3C6B() {
  precachemodel("sentry_minigun_weak");
  precachemodel("sentry_minigun_weak_destroyed");
  precachemodel("sentry_minigun_weak_obj");
  precachemodel("sentry_minigun_weak_obj_red");
  precachemodel("sentry_minigun_weak_folded_obj");
  precacheturret("sentry_minigun_weak");
  level._id_3C68["sentry_minigun_weak"] = spawnStruct();
  _id_3C7E("sentry_minigun_weak");
  _id_3C6E("sentry_minigun_weak");
  common_scripts\utility::array_thread(getEntArray("script_model_pickup_sentry_minigun_weak", "classname"), ::_id_3C7F, "sentry_minigun_weak");
}

_id_3C6C() {
  precachemodel("sentry_grenade_launcher_upgrade");
  precachemodel("sentry_grenade_launcher_upgrade_destroyed");
  precachemodel("sentry_grenade_launcher_upgrade_obj");
  precachemodel("sentry_grenade_launcher_upgrade_obj_red");
  precachemodel("sentry_grenade_launcher_upgrade_folded_obj");

  if(common_scripts\utility::issp() && !_id_0A36()) {
    precacheturret("sentry_gun");
  } else if(_id_0A36()) {
    precacheturret("sentry_gun_so");
  } else {
    precacheturret("sentry_gun_mp");
  }
  level._id_3C68["sentry_gun"] = spawnStruct();
  _id_3C6F("sentry_gun");
  _id_3C6E("sentry_gun");
  common_scripts\utility::array_thread(getEntArray("script_model_pickup_sentry_gun", "classname"), ::_id_3C7F, "sentry_gun");
}

_id_3C6D() {
  precachemodel("sentry_grenade_launcher");
  precachemodel("sentry_grenade_launcher_destroyed");
  precachemodel("sentry_grenade_launcher_obj");
  precachemodel("sentry_grenade_launcher_obj_red");
  precachemodel("sentry_grenade_launcher_folded_obj");
  precacheturret("sentry_gun_weak");
  level._id_3C68["sentry_gun_weak"] = spawnStruct();
  _id_3C7C("sentry_gun_weak");
  _id_3C6E("sentry_gun_weak");
  common_scripts\utility::array_thread(getEntArray("script_model_pickup_sentry_gun_weak", "classname"), ::_id_3C7F, "sentry_gun_weak");
}

_id_3C6E(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {}
  var_3 _id_3C80(undefined, var_0);
}

_id_3C6F(var_0) {
  level._id_3C68[var_0].ammo = 100;
  level._id_3C68[var_0]._id_3C70 = 1;
  level._id_3C68[var_0]._id_3C71 = 1;
  level._id_3C68[var_0]._id_3C72 = 2;
  level._id_3C68[var_0]._id_3C73 = 1;
  level._id_3C68[var_0]._id_3C74 = 1.5;
  level._id_3C68[var_0]._id_3C75 = 1;
  level._id_3C68[var_0].model = "sentry_grenade_launcher_upgrade";
  level._id_3C68[var_0]._id_3C76 = "sentry_grenade_launcher_upgrade_destroyed";
  level._id_3C68[var_0]._id_3C77 = "sentry_grenade_launcher_upgrade_folded";
  level._id_3C68[var_0]._id_3C78 = "sentry_grenade_launcher_upgrade_folded_obj";
  level._id_3C68[var_0]._id_3C79 = "sentry_grenade_launcher_upgrade_obj";
  level._id_3C68[var_0]._id_3C7A = "sentry_grenade_launcher_upgrade_obj_red";
  level._id_3C68[var_0].health = 350;

  if(common_scripts\utility::issp() && !_id_0A36()) {
    level._id_3C68[var_0]._id_3C7B = 15;
    level._id_3C68[var_0].weaponinfo = "sentry_gun";
    level._id_3C68[var_0].targetname = "sentry_gun";
  } else if(_id_0A36()) {
    level._id_3C68[var_0].ammo = 50;
    level._id_3C68[var_0]._id_3C7B = 8;
    level._id_3C68[var_0].weaponinfo = "sentry_gun_so";
    level._id_3C68[var_0].targetname = "sentry_gun_so";
    level._id_3C68[var_0].health = 1200;
  } else {
    level._id_3C68[var_0]._id_3C7B = 5;
    level._id_3C68[var_0].weaponinfo = "sentry_gun_mp";
    level._id_3C68[var_0].targetname = "sentry_gun_mp";
  }
}

_id_3C7C(var_0) {
  level._id_3C68[var_0]._id_3C70 = 0;
  level._id_3C68[var_0]._id_3C71 = 1;
  level._id_3C68[var_0]._id_3C72 = 2;
  level._id_3C68[var_0]._id_3C73 = 1;
  level._id_3C68[var_0]._id_3C74 = 1.5;
  level._id_3C68[var_0]._id_3C75 = 1;
  level._id_3C68[var_0].model = "sentry_grenade_launcher";
  level._id_3C68[var_0]._id_3C76 = "sentry_grenade_launcher_destroyed";
  level._id_3C68[var_0]._id_3C77 = "sentry_grenade_launcher_folded";
  level._id_3C68[var_0]._id_3C78 = "sentry_grenade_launcher_folded_obj";
  level._id_3C68[var_0]._id_3C79 = "sentry_grenade_launcher_obj";
  level._id_3C68[var_0]._id_3C7A = "sentry_grenade_launcher_obj_red";
  level._id_3C68[var_0].health = int(175.0);

  if(common_scripts\utility::issp()) {
    level._id_3C68[var_0]._id_3C7B = 15;
    level._id_3C68[var_0].weaponinfo = "sentry_gun_weak";
    level._id_3C68[var_0].targetname = "sentry_gun_weak";
  } else {
    level._id_3C68[var_0]._id_3C7B = 5;
    level._id_3C68[var_0].weaponinfo = "sentry_gun_mp";
    level._id_3C68[var_0].targetname = "sentry_gun_mp";
  }
}

#using_animtree("sentry_gun");

_id_3C7D(var_0) {
  level._id_3C68[var_0].ammo = 1000;
  level._id_3C68[var_0]._id_3C70 = 1;
  level._id_3C68[var_0]._id_3C71 = 20;
  level._id_3C68[var_0]._id_3C72 = 60;
  level._id_3C68[var_0]._id_3C73 = 0.5;
  level._id_3C68[var_0]._id_3C74 = 1.3;
  level._id_3C68[var_0]._id_3C75 = 0;
  level._id_3C68[var_0].model = "sentry_minigun";
  level._id_3C68[var_0]._id_3C76 = "sentry_minigun_destroyed";
  level._id_3C68[var_0]._id_3C77 = "sentry_minigun_folded";
  level._id_3C68[var_0]._id_3C78 = "sentry_minigun_folded_obj";
  level._id_3C68[var_0]._id_3C79 = "sentry_minigun_obj";
  level._id_3C68[var_0]._id_3C7A = "sentry_minigun_obj_red";
  level._id_3C68[var_0].health = 190;

  if(common_scripts\utility::issp() && !_id_0A36()) {
    level._id_3C68[var_0]._id_3C7B = 15;
    level._id_3C68[var_0]._id_11D6 = % minigun_spin_loop;
    level._id_3C68[var_0].weaponinfo = "sentry_minigun";
    level._id_3C68[var_0].targetname = "sentry_minigun";
  } else if(_id_0A36()) {
    level._id_3C68[var_0].ammo = 800;
    level._id_3C68[var_0]._id_3C7B = 8;
    level._id_3C68[var_0]._id_11D6 = % minigun_spin_loop;
    level._id_3C68[var_0].weaponinfo = "sentry_minigun_so";
    level._id_3C68[var_0].targetname = "sentry_minigun_so";
    level._id_3C68[var_0].health = 800;
  } else {
    level._id_3C68[var_0]._id_3C7B = 5;
    level._id_3C68[var_0].weaponinfo = "sentry_minigun_mp";
    level._id_3C68[var_0].targetname = "sentry_minigun_mp";
  }
}

_id_3C7E(var_0) {
  level._id_3C68[var_0].ammo = 800;
  level._id_3C68[var_0]._id_3C70 = 0;
  level._id_3C68[var_0]._id_3C71 = 10;
  level._id_3C68[var_0]._id_3C72 = 30;
  level._id_3C68[var_0]._id_3C73 = 1.0;
  level._id_3C68[var_0]._id_3C74 = 2.6;
  level._id_3C68[var_0]._id_3C75 = 0;
  level._id_3C68[var_0].model = "sentry_minigun_weak";
  level._id_3C68[var_0]._id_3C76 = "sentry_minigun_weak_destroyed";
  level._id_3C68[var_0]._id_3C77 = "sentry_minigun_weak_folded";
  level._id_3C68[var_0]._id_3C78 = "sentry_minigun_weak_folded_obj";
  level._id_3C68[var_0]._id_3C79 = "sentry_minigun_weak_obj";
  level._id_3C68[var_0]._id_3C7A = "sentry_minigun_weak_obj_red";
  level._id_3C68[var_0].health = int(95.0);

  if(common_scripts\utility::issp()) {
    level._id_3C68[var_0]._id_3C7B = 15;
    level._id_3C68[var_0]._id_11D6 = % minigun_spin_loop;
    level._id_3C68[var_0].weaponinfo = "sentry_minigun_weak";
    level._id_3C68[var_0].targetname = "sentry_minigun_weak";
  } else {
    level._id_3C68[var_0]._id_3C7B = 5;
    level._id_3C68[var_0].weaponinfo = "sentry_minigun_mp";
    level._id_3C68[var_0].targetname = "sentry_minigun_mp";
  }
}

_id_3C7F(var_0) {
  self setModel(self.model);
  self.sentrytype = var_0;
  self setcursorhint("HINT_NOICON");
  self sethintstring(&"SENTRY_PICKUP");
  self makeusable();
  thread _id_3CBA(var_0);
}

givesentry(var_0) {
  self.last_sentry = var_0;
  thread _id_3CAE(var_0);
}

_id_3C80(var_0, var_1, var_2) {
  if(common_scripts\utility::issp()) {
    level._id_3C81 = 1;
    level._id_3C82 = 1;

    if(!isDefined(level._id_3C83)) {
      level._id_3C83 = 5;
    }
    if(!isDefined(level._id_3C84)) {
      level._id_3C84 = 2;
    }
  }

  if(!isDefined(var_0)) {
    if(!isDefined(self.script_team)) {
      self.script_team = "axis";
    }
    var_0 = self.script_team;
  }

  self setturretmodechangewait(1);
  _id_3CBF();
  self maketurretinoperable();
  _id_3CC1();
  self setCanDamage(1);
  self setdefaultdroppitch(-89.0);

  if(common_scripts\utility::issp() || level.teambased || _id_12DC()) {
    self setturretteam(var_0);
  }
  self.sentrytype = var_1;
  self._id_0A38 = 1;
  self._id_3C85 = 350;
  self._id_3C86 = 400;
  self._id_3C87 = 60;
  self._id_3C88 = level._id_3C68[self.sentrytype].ammo;

  if(common_scripts\utility::issp()) {
    if(self.weaponinfo == "sentry_gun") {
      self._id_2A6F = 2000;
    } else {
      self._id_2A6F = 1200;
    }
  } else if(self.weaponinfo == "sentry_gun") {
    self._id_2A6F = 300;
  } else {
    self._id_2A6F = 300;
  }
  if(common_scripts\utility::issp()) {
    self call[[level._id_1E83]](var_0);
    common_scripts\utility::self_func("useanimtree", #animtree);

    if(isDefined(self.script_team) && self.script_team == "axis") {
      thread _id_3CBD();
    }
  }

  self.health = level._id_3C68[var_1].health;
  _id_3C90();
  thread _id_3CAD();
  thread _id_3C96();
  thread _id_3C89();

  if(!common_scripts\utility::issp()) {
    thread _id_3CD4();
    thread _id_3CD3();
  }

  thread _id_3CBB();

  if(getdvarint("survival_chaos") != 1) {
    thread _id_3C8F();
  }
  if(!isDefined(var_2)) {
    if(common_scripts\utility::issp()) {
      var_2 = level.player;
    }
  }

  _id_3CC8(var_2);
  thread _id_3CCA(var_2);

  if(!isDefined(self._id_215B)) {
    self._id_215B = [];
  }
}

_id_3C89() {
  self endon("deleted");
  self waittill("death", var_0, var_1, var_2);
  level notify("a_sentry_died");

  if(isDefined(var_0) && isDefined(var_0.team) && self.team != var_0.team && isDefined(level._id_1E87)) {
    var_0[[level._id_1E87]](self, var_1, var_2);
  }
  if(!common_scripts\utility::issp()) {
    removefromturretlist();
    thread _id_3CC7();
  }

  thread _id_3CA1();
  thread _id_3CD7();
  self setModel(level._id_3C68[self.sentrytype]._id_3C76);
  _id_3CC3();

  if(common_scripts\utility::issp()) {
    self call[[level._id_1E84]]();
  }
  if(!common_scripts\utility::issp() && isDefined(var_0) && isPlayer(var_0)) {
    if(isDefined(self.owner)) {
      self.owner thread[[level.leaderdialogonplayer_func]]("destroy_sentry", "sentry_status");
    }
    var_0 thread[[level.onxpevent]]("kill");
  }

  self setsentrycarrier(undefined);
  self.carrier = undefined;
  self setCanDamage(1);
  self.ignoreme = 1;
  self makeunusable();
  self setsentryowner(undefined);
  self setturretminimapvisible(0);
  self playSound("sentry_explode");
  playFXOnTag(common_scripts\utility::getfx("sentry_turret_explode"), self, "tag_aim");

  if(common_scripts\utility::issp() && (!isDefined(self._id_3C8A) || !self._id_3C8A)) {
    self setcontents(0);
  }
  wait 1.5;
  self playSound("sentry_explode_smoke");
  var_3 = level._id_3C68[self.sentrytype]._id_3C7B * 1000;
  var_4 = gettime();

  for(;;) {
    playFXOnTag(common_scripts\utility::getfx("sentry_turret_explode_smoke"), self, "tag_aim");
    wait 0.4;

    if(gettime() - var_4 > var_3) {
      break;
    }
  }

  level._id_3C67 = common_scripts\utility::array_remove(level._id_3C67, self);

  if(!common_scripts\utility::issp() || getDvar("specialops") == "1") {
    thread _id_3CCE();
  }
}

_id_3C8B(var_0) {
  level endon("game_ended");
  self endon("sentry_placement_finished");
  self waittill("death");

  if(common_scripts\utility::issp()) {
    var_0 notify("death");
    return;
  }

  if(!self._id_3C8C) {
    var_0 _id_3CC7();
    var_0 notify("deleted");
    waittillframeend;
    var_0 delete();
    return;
  }

  if(!common_scripts\utility::issp()) {
    thread _id_3C94(var_0);
  }
}

_id_3C8D(var_0) {
  level endon("game_ended");
  self endon("sentry_placement_finished");
  self waittill("disconnect");
  var_0 notify("death");
}

_id_3C8E(var_0) {
  level endon("game_ended");
  self endon("sentry_placement_finished");
  self waittill("sentry_placement_canceled");
  var_0 _id_3CC7();
  _id_3CB9();
  var_0 notify("death");
}

_id_3C8F() {
  level endon("game_ended");
  self endon("death");

  if(self.health <= 0) {
    return;
  }
  self makeusable();

  for(;;) {
    self waittill("trigger", var_0);

    if(isDefined(var_0._id_1A96)) {
      continue;
    }
    if(!common_scripts\utility::issp()) {}

    break;
  }

  var_0 thread _id_3C8E(self);
  var_0 thread _id_3C8B(self);
  var_0 thread _id_3C8D(self);
  var_0 thread _id_3CB1(self);

  if(!common_scripts\utility::issp() && !isalive(var_0)) {
    return;
  }
  if(!common_scripts\utility::issp()) {
    _id_3CC6();
  }
  _id_3CC3();
  var_0._id_1A96 = self;
  self setsentrycarrier(var_0);
  self.carrier = var_0;
  self.ignoreme = 1;
  self setCanDamage(0);
  self makeunusable();
  var_0 common_scripts\utility::_disableweapon();
  _id_3CC0();
  _id_3C92();
  var_0 thread _id_3C93(self);
  var_0 thread _id_3CB5(self);
}

_id_3C90() {
  if(!common_scripts\utility::issp()) {
    return;
  }
  self._id_3C91 = "" + gettime();
  call[[level.badplace_cylinder_func]](self._id_3C91, 0, self.origin, 32, 128, self.team, "neutral");
}

_id_3C92() {
  if(!common_scripts\utility::issp()) {
    return;
  }
  call[[level.badplace_delete_func]](self._id_3C91);
  self._id_3C91 = undefined;
}

_id_3C93(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("deleted");
  self endon("death");
  self endon("disconnect");
  var_0 notify("sentry_move_started", self);
  self._id_00D3 = 1;

  for(;;) {
    _id_3CBE(0);
    _id_3CBE(1);
    _id_3CB6(var_0);

    if(self._id_3C8C) {
      break;
    }
  }

  var_0 notify("sentry_move_finished", self);
  self._id_00D3 = 0;
  _id_3C94(var_0);
}

_id_3C94(var_0) {
  if(!common_scripts\utility::issp()) {
    self endon("death");
    level endon("end_game");
  }

  self._id_1A96 = undefined;
  var_0 setsentrycarrier(undefined);
  var_0.carrier = undefined;
  var_0 setCanDamage(1);
  var_0.ignoreme = 0;
  common_scripts\utility::_enableweapon();
  var_0 _id_3CBF();
  var_0 setModel(level._id_3C68[var_0.sentrytype].model);
  var_0 _id_3C90();
  var_0 setcontents(var_0._id_3C95);
  var_0 _id_3CC8(self);
  self notify("sentry_placement_finished", var_0);
  var_0 notify("sentry_carried");
  var_0.overheated = 0;
  _id_3CB9();

  if(!common_scripts\utility::issp()) {
    var_0 _id_3CC5();
  }
  var_0 _id_3CC1();
  thread common_scripts\utility::play_sound_in_space("sentry_gun_plant", var_0.origin);
  _id_3CBE(0);

  if(getdvarint("survival_chaos") != 1) {
    var_0 thread _id_3C8F();
  }
}

_id_3C96() {
  level endon("game_ended");
  self endon("death");
  thread _id_3C97();

  for(;;) {
    common_scripts\utility::waittill_either("turretstatechange", "cooled");

    if(self isfiringturret()) {
      thread _id_3C9D();
      thread _id_3CD6();
      continue;
    }

    thread _id_3CA1();
    thread _id_3CD7();
  }
}

_id_3C97() {
  self endon("death");

  if(self.sentrytype != "sentry_minigun") {
    return;
  }
  if(!isDefined(level._id_3C81)) {
    return;
  }
  self._id_3C98 = 0;
  self.overheated = 0;

  if(getdvarint("sentry_overheat_debug") == 1) {
    thread _id_3C9A();
  }
  for(;;) {
    if(self._id_3C98 >= level._id_3C83 * 10) {
      thread _id_3C9B();
      common_scripts\utility::waittill_either("cooled", "sentry_carried");
    }

    if(self isfiringturret()) {
      self._id_3C98 = self._id_3C98 + 1;
    } else if(self._id_3C98 > 0) {
      self._id_3C98 = self._id_3C98 - 1;
    }
    wait(0.1 / level._id_3C81);
  }
}

_id_3C99() {
  self endon("death");

  while(self.overheated) {
    if(self._id_3C98 > 0) {
      self._id_3C98 = self._id_3C98 - 1;
    }
    wait(0.1 / level._id_3C81);
  }
}

_id_3C9A() {
  self endon("death");

  for(;;) {
    var_0 = self._id_3C98 / (level._id_3C83 * 10);
    var_1 = "[ ";
    var_2 = " ]";

    if(self.overheated) {
      var_1 = "{{{ ";
      var_2 = " }
    }
  }
  ";
}

wait 0.2;
}
}

_id_3C9B() {
  self endon("death");
  self notify("overheated");
  self.overheated = 1;
  _id_3CA1();
  thread _id_3C9C();
}

_id_3C9C() {
  self endon("death");
  self endon("sentry_carried");
  thread _id_3C99();
  wait(level._id_3C84);
  self notify("cooled");
  self._id_3C98 = 0;
  self.overheated = 0;
}

_id_3C9D() {
  self endon("death");
  level endon("game_ended");

  if(level._id_3C68[self.sentrytype]._id_3C75) {
    self waittill("turret_on_target");
  }
  if(isDefined(self.overheated) && self.overheated) {
    return;
  }
  thread _id_3CA5();
  self endon("stop_shooting");
  self notify("shooting");
  var_0 = weaponfiretime(self.weaponinfo);

  for(;;) {
    _id_3CA3();
    var_1 = randomintrange(level._id_3C68[self.sentrytype]._id_3C71, level._id_3C68[self.sentrytype]._id_3C72);

    for(var_2 = 0; var_2 < var_1; var_2++) {
      if(_id_3CA0()) {
        self shootturret();
      }
      self notify("bullet_fired");
      wait(var_0);
    }

    wait(randomfloatrange(level._id_3C68[self.sentrytype]._id_3C73, level._id_3C68[self.sentrytype]._id_3C74));
  }
}

_id_3C9E(var_0, var_1) {
  self notify("allowFireThread");
  self endon("allowFireThread");
  self endon("death");
  self._id_3C9F = var_0;

  if(isDefined(var_1) && !var_0) {
    wait(var_1);

    if(isDefined(self)) {
      thread _id_3C9E(1);
    }
  }
}

_id_3CA0() {
  if(!isDefined(self._id_3C9F)) {
    return 1;
  }
  return self._id_3C9F;
}

_id_3CA1() {
  thread _id_3CA9();
  self notify("stop_shooting");
  thread _id_3CA2();
}

_id_3CA2() {
  self endon("shooting");
  self endon("deleted");
  wait(randomfloatrange(0.0, 1.0));
  var_0 = 6000;
  var_1 = gettime();

  if(isDefined(self)) {
    self playSound("sentry_steam");
  }
  while(isDefined(self)) {
    playFXOnTag(common_scripts\utility::getfx("sentry_turret_overheat_smoke_sp"), self, "tag_flash");
    wait 0.3;

    if(gettime() - var_1 > var_0) {
      break;
    }
  }
}

_id_3CA3() {
  if(isDefined(self._id_3CA4) && self._id_3CA4 == 0) {
    self waittill("allow_fire");
  }
}

_id_3CA5() {
  self notify("anim_state_change");
  self endon("anim_state_change");
  self endon("stop_shooting");
  self endon("deleted");
  level endon("game_ended");
  self endon("death");

  if(!isDefined(level._id_3C68[self.sentrytype]._id_11D6)) {
    return;
  }
  self._id_3CA4 = 0;

  if(!isDefined(self.momentum)) {
    self.momentum = 0;
  }
  thread _id_3CAA();

  for(;;) {
    if(self.momentum >= 1.0) {
      break;
    }

    self.momentum = self.momentum + 0.1;
    self.momentum = clamp(self.momentum, 0.0, 1.0);

    if(common_scripts\utility::issp()) {
      common_scripts\utility::self_func("setanim", level._id_3C68[self.sentrytype]._id_11D6, 1.0, 0.2, self.momentum);
    }
    wait 0.2;
  }

  self._id_3CA4 = 1;
  self notify("allow_fire");
}

_id_3CA6() {
  self notify("deleted");
  wait 0.05;
  self notify("death");

  if(isDefined(self._id_3CA7)) {
    self._id_3CA7 delete();
  }
  if(isDefined(self._id_3CA8)) {
    self._id_3CA8 delete();
  }
  self delete();
}

_id_3CA9() {
  self notify("anim_state_change");
  self endon("anim_state_change");

  if(!isDefined(level._id_3C68[self.sentrytype]._id_11D6)) {
    return;
  }
  thread _id_3CAC();
  self._id_3CA4 = 0;

  for(;;) {
    if(!isDefined(self.momentum)) {
      break;
    }

    if(self.momentum <= 0.0) {
      break;
    }

    self.momentum = self.momentum - 0.1;
    self.momentum = clamp(self.momentum, 0.0, 1.0);

    if(common_scripts\utility::issp()) {
      common_scripts\utility::self_func("setanim", level._id_3C68[self.sentrytype]._id_11D6, 1.0, 0.2, self.momentum);
    }
    wait 0.2;
  }
}

_id_3CAA() {
  self notify("sound_state_change");
  self endon("sound_state_change");
  self endon("deleted");

  if(self.momentum < 0.25) {
    self playSound("sentry_minigun_spinup1");
    wait 0.6;
    self playSound("sentry_minigun_spinup2");
    wait 0.5;
    self playSound("sentry_minigun_spinup3");
    wait 0.5;
    self playSound("sentry_minigun_spinup4");
    wait 0.5;
  } else if(self.momentum < 0.5) {
    self playSound("sentry_minigun_spinup2");
    wait 0.5;
    self playSound("sentry_minigun_spinup3");
    wait 0.5;
    self playSound("sentry_minigun_spinup4");
    wait 0.5;
  } else if(self.momentum < 0.75) {
    self playSound("sentry_minigun_spinup3");
    wait 0.5;
    self playSound("sentry_minigun_spinup4");
    wait 0.5;
  } else if(self.momentum < 1) {
    self playSound("sentry_minigun_spinup4");
    wait 0.5;
  }

  thread _id_3CAB();
}

_id_3CAB() {
  self endon("death");
  self notify("sound_state_change");
  self endon("sound_state_change");

  for(;;) {
    self playSound("sentry_minigun_spin");
    wait 2.5;
  }
}

_id_3CAC() {
  self notify("sound_state_change");
  self endon("sound_state_change");
  self endon("deleted");

  if(!isDefined(self.momentum)) {
    return;
  }
  if(self.momentum > 0.75) {
    self stopsounds();
    self playSound("sentry_minigun_spindown4");
    wait 0.5;
    self playSound("sentry_minigun_spindown3");
    wait 0.5;
    self playSound("sentry_minigun_spindown2");
    wait 0.5;
    self playSound("sentry_minigun_spindown1");
    wait 0.65;
  } else if(self.momentum > 0.5) {
    self playSound("sentry_minigun_spindown3");
    wait 0.5;
    self playSound("sentry_minigun_spindown2");
    wait 0.5;
    self playSound("sentry_minigun_spindown1");
    wait 0.65;
  } else if(self.momentum > 0.25) {
    self playSound("sentry_minigun_spindown2");
    wait 0.5;
    self playSound("sentry_minigun_spindown1");
    wait 0.65;
  } else {
    self playSound("sentry_minigun_spindown1");
    wait 0.65;
  }
}

_id_3CAD() {
  self endon("death");

  for(;;) {
    wait(randomfloatrange(3.5, 4.5));
    thread common_scripts\utility::play_sound_in_space("sentry_gun_beep", self.origin + (0, 0, 40));
  }
}

_id_3CAE(var_0, var_1, var_2, var_3) {
  level endon("game_ended");

  if(isDefined(self._id_1A96)) {
    return undefined;
  }
  common_scripts\utility::_disableweapon();
  self notify("placingSentry");
  self._id_3CAF = undefined;

  if(!isDefined(var_1)) {
    var_1 = self.origin;
  }
  if(!isDefined(var_2)) {
    var_2 = self.angles;
  }
  if(!isDefined(var_3)) {
    var_3 = 0;
  }
  var_4 = spawnturret("misc_turret", var_1, level._id_3C68[var_0].weaponinfo);
  var_4 setModel(level._id_3C68[var_0]._id_3C79);
  var_4.weaponinfo = level._id_3C68[var_0].weaponinfo;
  var_4.targetname = level._id_3C68[var_0].targetname;
  var_4.weaponname = level._id_3C68[var_0].weaponinfo;
  var_4.angles = var_2;
  var_4.team = self.team;
  var_4.attacker = self;
  var_4.sentrytype = var_0;
  var_4 maketurretinoperable();
  var_4 _id_3CC3();
  var_4 setCanDamage(0);
  var_4 _id_3CC8(self);
  var_4 setdefaultdroppitch(-89.0);
  self._id_1A96 = var_4;
  var_4 setsentrycarrier(self);
  var_4.carrier = self;
  var_4 setCanDamage(0);
  var_4.ignoreme = 1;

  if(!common_scripts\utility::issp()) {
    var_4 addtoturretlist();
  }
  if(!var_3) {
    thread _id_3CB0(var_4);
    thread _id_3CB1(var_4);
  }

  thread _id_3CB3(var_4, var_3);

  if(!var_3) {
    thread _id_3CB5(var_4);

    if(!common_scripts\utility::issp()) {
      common_scripts\utility::waittill_any("sentry_placement_finished", "sentry_placement_canceled", "death");
    } else {
      common_scripts\utility::waittill_any("sentry_placement_finished", "sentry_placement_canceled");
    }
  }

  _id_3CB9();
  common_scripts\utility::_enableweapon();
  self._id_1A96 = undefined;
  self setCanDamage(1);
  var_4 setsentrycarrier(undefined);
  var_4.carrier = undefined;
  var_4.ignoreme = 0;

  if(_id_12DC()) {
    waittillframeend;

    if(isDefined(self._id_3CAF) && self._id_3CAF) {
      return undefined;
    }
  }

  level._id_3C67[level._id_3C67.size] = var_4;
  self notify("new_sentry", var_4);
  return var_4;
}

_id_3CB0(var_0) {
  self endon("sentry_placement_finished");

  if(!common_scripts\utility::issp()) {
    common_scripts\utility::waittill_any("sentry_placement_canceled", "death", "disconnect");
  } else {
    common_scripts\utility::waittill_any("sentry_placement_canceled");
  }
  if(_id_12DC()) {
    self._id_3CAF = 1;
  }
  waittillframeend;
  var_0 delete();
}

_id_3CB1(var_0) {
  self endon("sentry_placement_finished");

  if(common_scripts\utility::issp()) {
    return;
  }
  level waittill("game_ended");

  if(!isDefined(var_0)) {
    return;
  }
  if(!self._id_3C8C) {
    var_0 notify("deleted");
    waittillframeend;
    var_0 delete();
    return;
  }

  thread _id_3C94(var_0);
}

_id_3CB2() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("restock_reset");
  self notifyonplayercommand("cancel sentry", "+actionslot 4");
  common_scripts\utility::waittill_any("death", "cancel sentry");
  self notify("sentry_placement_canceled");
}

_id_3CB3(var_0, var_1) {
  level endon("game_ended");
  self endon("sentry_placement_canceled");

  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  if(!common_scripts\utility::issp()) {
    self endon("disconnect");
    var_0 thread _id_3CD0();
    thread _id_3CB2();
  }

  if(!var_1) {
    var_0 makeunusable();

    while(self useButtonPressed()) {
      wait 0.05;
    }
    for(;;) {
      _id_3CBE(0);
      _id_3CBE(1);
      _id_3CB6(var_0);

      if(self._id_3C8C) {
        break;
      }
    }
  }

  if(!common_scripts\utility::issp()) {
    self notify("restock_reset");
  }
  if(!common_scripts\utility::issp()) {
    var_0.lifeid = self.lifeid;
    _id_3CC4(var_0);
  }

  thread common_scripts\utility::play_sound_in_space("sentry_gun_plant", var_0.origin);
  var_0 setModel(level._id_3C68[var_0.sentrytype].model);
  var_0 _id_3C80(self.team, var_0.sentrytype, self);
  self notify("sentry_placement_finished", var_0);

  if(!var_1) {
    waittillframeend;
  }
  if(isDefined(level._id_3CB4) && level._id_3CB4) {
    var_0 thread _id_3CCC();
  }
  if(!common_scripts\utility::issp()) {
    var_0 thread _id_3CCB();
  }
}

_id_3CB5(var_0) {
  level endon("game_ended");
  var_0 notify("sentry_placement_started");
  self endon("sentry_placement_canceled");
  self endon("sentry_placement_finished");
  var_0 endon("death");
  var_0 endon("deleted");

  if(!common_scripts\utility::issp()) {
    self endon("disconnect");
    self endon("death");
  }

  for(;;) {
    _id_3CB6(var_0);
    wait 0.05;
  }
}

_id_3CB6(var_0) {
  var_1 = self canplayerplacesentry();
  var_0.origin = var_1["origin"];
  var_0.angles = var_1["angles"];
  self._id_3C8C = self isonground() && var_1["result"];
  _id_3CB7(self._id_3C8C);

  if(self._id_3C8C) {
    var_0 setModel(level._id_3C68[var_0.sentrytype]._id_3C79);
  } else {
    var_0 setModel(level._id_3C68[var_0.sentrytype]._id_3C7A);
  }
}

_id_3CB7(var_0) {
  if(isDefined(self._id_3CB8) && self._id_3CB8 == var_0) {
    return;
  }
  self._id_3CB8 = var_0;

  if(getdvarint("survival_chaos") == 1) {
    if(self._id_3CB8) {
      self notify("sentry_notification", &"SENTRY_PLACE");
    } else {
      self notify("sentry_notification", &"SENTRY_CANNOT_PLACE");
    }
  } else if(self._id_3CB8) {
    self forceusehinton(&"SENTRY_PLACE");
  } else {
    self forceusehinton(&"SENTRY_CANNOT_PLACE");
  }
}

_id_3CB9() {
  if(!isDefined(self._id_3CB8)) {
    return;
  }
  if(getdvarint("survival_chaos") == 1) {
    self notify("sentry_notification");
  } else {
    self forceusehintoff();
  }
  self._id_3CB8 = undefined;
}

_id_3CBA(var_0) {
  self._id_3CA7 = spawn("script_model", self.origin);
  self._id_3CA7.angles = self.angles;
  self._id_3CA7 setModel(level._id_3C68[var_0]._id_3C78);

  for(;;) {
    self waittill("trigger", var_1);

    if(!isDefined(var_1)) {
      continue;
    }
    if(isDefined(var_1._id_1A96)) {
      continue;
    }
    if(!common_scripts\utility::issp()) {
      if(var_1 != self.owner) {
        continue;
      }
    }

    break;
  }

  thread common_scripts\utility::play_sound_in_space("sentry_pickup");
  self._id_3CA7 delete();
  self delete();
  var_1 thread _id_3CAE(var_0);
}

_id_3CBB() {
  self._id_163B = 20000;
  self.health = self.health + self._id_163B;
  self._id_29A1 = self.health;
  var_0 = undefined;
  var_1 = undefined;
  var_2 = 0;
  var_3 = 0;
  var_4 = gettime();

  while(self.health > 0) {
    self waittill("damage", var_5, var_0, var_6, var_7, var_1, var_8, var_9);

    if(isDefined(var_0) && !isPlayer(var_0)) {
      var_2 = var_2 + var_5;
      var_3 = var_3 + (gettime() - var_4);
      var_4 = gettime();

      if(var_3 < 3000 && var_2 > 300) {
        var_10 = 0;

        foreach(var_12 in level.players) {
          if(distancesquared(var_12.origin, self.origin) <= squared(500)) {
            var_10 = 1;
          }
        }

        if(!var_10) {
          level notify("a_sentry_is_underattack");
        }
        var_2 = 0;
        var_3 = 0;
      }

      if(var_3 >= 3000) {
        var_2 = 0;
        var_3 = 0;
      }
    }

    if(!common_scripts\utility::issp() && isDefined(var_0) && isPlayer(var_0) && var_0 _id_3CD2(self)) {
      self.health = self._id_29A1;
      return;
    }

    if(isDefined(level._id_1E88) && isDefined(var_0)) {
      var_0[[level._id_1E88]]();
    }
    if(isDefined(var_0) && isPlayer(var_0)) {
      if(!common_scripts\utility::issp()) {
        var_0[[level.func["damagefeedback"]]]("false");
      }
      thread _id_3C9E(0, 2.0);
    }

    if(_id_3CBC(var_1, var_0)) {
      self.health = self._id_29A1;
      self._id_2A6F = self._id_2A6F - var_5;
    } else {
      self._id_29A1 = self.health;
    }
    if(self.health < self._id_163B) {
      break;
    }
  }

  if(!common_scripts\utility::issp() && var_0 _id_3CD1(self)) {
    var_0 thread[[level.onxpevent]]("kill");
  }
  self notify("death", var_0, var_1);
}

_id_3CBC(var_0, var_1) {
  if(isDefined(var_1) && isai(var_1) && isDefined(var_1._id_0A37) && var_1._id_0A37) {
    return 0;
  }
  if(self._id_2A6F <= 0) {
    return 0;
  }
  if(!isDefined(var_0)) {
    return 0;
  }
  if(!issubstr(var_0, "BULLET")) {
    return 0;
  } else {
    return 1;
  }
}

_id_3CBD() {
  var_0 = "easy";
  self setconvergencetime(level._id_3C69[var_0]["convergencePitchTime"], "pitch");
  self setconvergencetime(level._id_3C69[var_0]["convergenceYawTime"], "yaw");
  self setsuppressiontime(level._id_3C69[var_0]["suppressionTime"]);
  self setaispread(level._id_3C69[var_0]["aiSpread"]);
  self setplayerspread(level._id_3C69[var_0]["playerSpread"]);
  self.maxrange = 1100;
  self._id_2A6F = 0;
}

_id_3CBE(var_0) {
  if(!common_scripts\utility::issp()) {
    self endon("death");
    self endon("disconnect");
  }

  if(var_0 == 1) {
    while(!self attackButtonPressed() && !self useButtonPressed()) {
      wait 0.05;
    }
  } else if(var_0 == 0) {
    while(self attackButtonPressed() || self useButtonPressed()) {
      wait 0.05;
    }
  }
}

_id_3CBF() {
  self maketurretsolid();
}

_id_3CC0() {
  self._id_3C95 = self setcontents(0);
}

_id_3CC1() {
  if(!issentient(self) && isDefined(self.owner) && isDefined(self.owner.team)) {
    self call[[level._id_1E83]](self.owner.team);
  }
  self setmode("sentry");
  self._id_3CC2 = 1;
}

_id_3CC3() {
  if(issentient(self)) {
    self call[[level._id_1E84]]();
  }
  self setmode("sentry_offline");
  self._id_3CC2 = 0;
}

_id_3CC4(var_0) {
  if(isDefined(self.pers["team"])) {
    var_0.pers["team"] = self.pers["team"];
  }
  var_0 _id_3CC5();
}

_id_3CC5() {
  var_0 = (0, 0, 65);

  if(self.sentrytype == "sentry_gun") {
    var_0 = (0, 0, 75);
  }
  self[[level.func["setTeamHeadIcon"]]](self.pers["team"], var_0);
}

_id_3CC6() {
  self[[level.func["setTeamHeadIcon"]]]("none", (0, 0, 0));
}

_id_3CC7() {
  if(!isDefined(self.carrier)) {
    return;
  }
  self.carrier notify("sentry_placement_canceled");
  self.carrier common_scripts\utility::_enableweapon();
  self.carrier._id_1A96 = undefined;
  self setsentrycarrier(undefined);
  self.carrier = undefined;
  self setCanDamage(1);
  self.ignoreme = 0;
}

_id_3CC8(var_0) {
  if(isDefined(self.owner) && self.owner == var_0) {
    return;
  }
  var_0._id_3CC9 = self;
  self.owner = var_0;
  self setsentryowner(var_0);
  self setturretminimapvisible(1);
}

_id_3CCA(var_0) {
  level endon("game_ended");
  self endon("death");
  var_0 common_scripts\utility::waittill_any("disconnect", "joined_team", "joined_spectators");
  self notify("death");
}

_id_3CCB() {
  level endon("game_ended");
  self endon("death");
  self endon("deleted");
  self notify("battery_count_started");
  self endon("battery_count_started");

  while(self._id_3C87 >= 0) {
    if(self._id_3CC2) {
      self._id_3C87 = self._id_3C87 - 1;
    }
    wait 1;
  }

  self notify("death");
}

_id_3CCC() {
  level endon("game_ended");
  self endon("death");
  self endon("deleted");
  self notify("ammo_count_started");
  self endon("ammo_count_started");
  thread _id_3CCD();

  while(self._id_3C88 >= 0) {
    self waittill("bullet_fired");
    self._id_3C88 = self._id_3C88 - 1;
  }

  thread _id_3CA1();
  thread _id_3CD7();
  wait 1;
  _id_3CC3();
  wait 5;
  self notify("death");
}

_id_3CCD() {
  self endon("death");

  for(;;) {
    var_0 = level._id_3C68[self.sentrytype].ammo;
    var_1 = self._id_3C88;
    var_2 = var_1 / var_0;
    var_3 = "Ammo: " + var_1 + "/" + var_0;
    var_4 = level._id_3C68[self.sentrytype].health;
    var_5 = self.health - self._id_163B;
    var_6 = var_5 / var_4;
    var_7 = "Health: " + var_5 + "/" + var_4;
    wait 0.05;
  }
}

_id_3CCE() {
  if(isDefined(self._id_3CCF) && self._id_3CCF) {
    return;
  }
  _id_3CA6();
}

_id_3CD0() {
  self endon("death");
  self endon("deleted");
  self.owner common_scripts\utility::waittill_any("death", "disconnect");

  if(isDefined(self.owner._id_1A96) && self.owner._id_1A96 == self) {
    self.owner._id_1A96 = undefined;
    self setsentrycarrier(undefined);
    self.carrier = undefined;
    self setCanDamage(1);
    self.ignoreme = 0;
    self notify("death");
  }
}

_id_3CD1(var_0) {
  if(!isDefined(self)) {
    return 0;
  }
  if(!isPlayer(self)) {
    return 0;
  }
  if(!isDefined(level.onxpevent)) {
    return 0;
  }
  if(!isDefined(self.pers["team"])) {
    return 0;
  }
  if(!isDefined(var_0.team)) {
    return 0;
  }
  if(!level.teambased && self == var_0.owner) {
    return 0;
  }
  if(level.teambased && self.pers["team"] == var_0.team) {
    return 0;
  }
  return 1;
}

_id_3CD2(var_0) {
  if(!isDefined(self)) {
    return 0;
  }
  if(!isPlayer(self)) {
    return 0;
  }
  if(!level.teambased) {
    return 0;
  }
  if(self == var_0.owner) {
    return 0;
  }
  if(self.team != var_0.team) {
    return 0;
  }
  return 1;
}

_id_3CD3() {
  self endon("deleted");
  self endon("death");

  for(;;) {
    self waittill("emp_damage", var_0, var_1);
    thread _id_3CA1();
    thread _id_3CD7();
    _id_3CC3();
    playFXOnTag(common_scripts\utility::getfx("sentry_turret_explode"), self, "tag_aim");
    wait(var_1);
    _id_3CC1();
  }
}

_id_3CD4() {
  self endon("deleted");
  self endon("death");

  for(;;) {
    level waittill("emp_update");

    if(level.teamemped[self.team]) {
      thread _id_3CA1();
      thread _id_3CD7();
      _id_3CC3();
      playFXOnTag(common_scripts\utility::getfx("sentry_turret_explode"), self, "tag_aim");
      continue;
    }

    _id_3CC1();
  }
}

addtoturretlist() {
  level.turrets[self getentitynumber()] = self;
}

removefromturretlist() {
  level.turrets[self getentitynumber()] = undefined;
}

_id_3CD5(var_0, var_1, var_2, var_3) {
  var_0 endon(var_1);
  var_2 endon(var_3);
  level waittill("hell_freezes_over_AND_THEN_thaws_out");
}

_id_3CD6() {
  if(!level._id_3C68[self.sentrytype]._id_3C70) {
    return;
  }
  if(!isDefined(level.laseron_func)) {
    return;
  }
  self call[[level.laseron_func]]();
}

_id_3CD7() {
  if(!level._id_3C68[self.sentrytype]._id_3C70) {
    return;
  }
  if(!isDefined(level.laseroff_func)) {
    return;
  }
  self call[[level.laseroff_func]]();
}

_id_0A36() {
  return getdvarint("specialops") >= 1;
}

_id_12DC() {
  return _id_0A36() && getdvarint("so_survival") > 0;
}