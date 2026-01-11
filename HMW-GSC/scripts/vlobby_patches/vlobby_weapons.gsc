vl_main() {
  replacefunc(maps\mp\_vl_firingrange::monitorweaponammo, ::monitorweaponammo_stub);
  replacefunc(maps\mp\_vl_avatar::playerteleportavatartoweaponroom, ::playerteleportavatartoweaponroom_stub);
  replacefunc(maps\mp\_vl_cac::positionweaponavatar, ::positionweaponavatar_stub);
}

positionweaponavatar_stub(var_0, var_1) {
  var_2 = maps\mp\_vl_cac::getavatarbounds(var_0);

  if(var_2.size == 0) {
    return;
  }
  var_3 = var_0;

  if(isDefined(var_0.linker)) {
    var_3 = var_0.linker;
  }

  var_3 unlink();
  var_4 = maps\mp\_vl_cac::getweaponavatarforwarddistance(var_0, var_2);
  maps\mp\_vl_camera::vl_dof_based_on_focus_weap_cac(var_4);
  var_5 = maps\mp\_vl_cac::getweaponavatarlocation(var_0, var_2);
  var_6 = maps\mp\_vl_cac::isavatarbottle(var_0);
  var_7 = var_2["midpoint"];
  var_8 = var_2["halfsize"];

  if(var_6) {
    var_7 = (0, 0, -1 * var_8[2]);
  }
  else if(var_1 == "Equipment") {
    var_7 = (0, 0, var_7[2]);
  }

  var_3.origin = var_5 - var_7;
  var_3.origin -= (3, 3, 0);

  if(var_6) {
    var_3.angles = (185.0, 126.0, 0.0);
  }
  else if(maps\mp\_vl_cac::isweaponavataraweapon(var_0)) {
    var_3.angles = (0.0, 350.0, 0);
  }
  else {
    var_3.angles = (0.0, 300.0, 15.0);
  }

  level.weaponavatarparent.origin = var_5;
  var_9 = level.weaponavatarparent.angles;
  level.weaponavatarparent.angles = (0.0, 180.0, 0.0);
  var_3 linktosynchronizedparent(level.weaponavatarparent);
  level.weaponavatarparent.angles = var_9;
}

playerteleportavatartoweaponroom_stub(var_0, var_1, var_2) {
  if(issubstr(var_0.primaryweapon, "akimbo")) {
    struct = common_scripts\utility::getstruct("characterShotgun", "targetname");
    var_1.scenenode = struct.scenenode;
    var_0 unlink();
    var_0 agentplaylobbyanimakimbo(var_1.scenenode, 1);
  } else {
    var_3 = maps\mp\_vl_base::getweaponroomstring(var_0.primaryweapon);
    var_4 = "character" + var_3;
    var_5 = common_scripts\utility::getstruct(var_4, "targetname");
    var_1.scenenode = var_5.scenenode;
    var_0 unlink();
    var_0 maps\mp\_vl_avatar::agentplaylobbyanim(var_1.scenenode, var_0.primaryweapon, var_2);
  }
}

agentplaylobbyanimakimbo(var_0, var_2) {
  var_5 = "idle";
  var_6 = "lobby_shotgun" + var_5;

  if(!isDefined(self.lastanim) || self.lastanim != var_6) {
    var_7 = 0.0;

    if(maps\mp\_utility::is_true(var_2)) {
      var_7 = randomfloat(1.0);
    }

    self setanimclass("vlobby_animclass");
    self setanimstate("lobby_shotgun_ranger", var_5, 1, var_7);
    self.lastanim = var_6;
    self scragentsetscripted(1);
    self scragentsetphysicsmode("noclip");
    self scragentsynchronizeanims(0, 0, var_0, "j_prop_1", "tag_origin");
  }

  maps\mp\_vl_avatar::show_avatar(self);
}

monitorweaponammo_stub(player) {
  player endon("enter_vlobby");

  for(;;) {
    var_1 = player getweaponslistall();

    foreach(var_3 in var_1) {
      player thread monitor_weapon_ammo_count(var_3);
      continue;
    }

    player waittill("applyLoadout");
  }
}

monitor_weapon_ammo_count(player) {
  self endon("enter_lobby");
  self endon("applyLoadout");

  while(level.in_firingrange) {
    var_1 = self getfractionmaxammo(player);

    if(var_1 <= 0.25) {
      self givemaxammo(player);
      continue;
    }

    wait 0.5;
  }
}