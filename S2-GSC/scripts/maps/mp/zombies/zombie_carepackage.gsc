/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\zombie_carepackage.gsc
**********************************************************/

init() {
  level.zombiekillstreaksenabled = 1;
  var_0 = getEntArray("care_package", "targetname");

  if(!isDefined(var_0) || var_0.size == 0) {
    return;
  }
  level._effect["zmb_red_flare_idle"] = loadfx("vfx/map/mp_zombie_berlin/zmb_red_flare_idle");
  level thread _id_0526::_id_52F6();
  level thread _id_0529::_id_52F4();
  level.zombiecratecapturethink = ::zm_care_crate_capture_think;
  level.zombiecarepackageusefunc = ::zm_care_crate_capture;
  var_1 = common_scripts\utility::_id_46B7("carepackage_dz", "targetname");
  var_2 = var_1;

  foreach(var_4 in var_1) {
    if(isDefined(var_4._id_0165))
      var_2 = common_scripts\utility::_id_0F93(var_2, var_4);
  }

  var_6 = common_scripts\utility::random(var_2);
  level.care_package_lz = var_6;
  level thread zm_care_flare_marker(level.care_package_lz);
}

zm_care_flare_marker(var_0) {
  _id_0547::_id_A78B();
  var_1 = _getgroundposition(var_0.origin + (0, 0, 50), 1);

  if(!isDefined(var_1))
    var_1 = var_0.origin;

  var_0.flare_model = spawn("script_model", var_1);
  var_0.flare_model setModel("npc_gen_fusee_flare");
  var_0.flare_model.angles = var_1 + (0, 0, 90);
}

zm_care_spawn_toggle_fx(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_3 = common_scripts\utility::_id_46B7("carepackage_dz", "targetname");
    var_4 = [];

    foreach(var_6 in var_3) {
      if(_distance2d(var_6.origin, var_2.origin) < 250)
        var_4[var_4.size] = var_6;
    }

    if(isDefined(var_2))
      var_1 = common_scripts\utility::_id_4461(var_2.origin, var_4);
    else
      var_1 = common_scripts\utility::random(var_3);
  }

  if(!isDefined(var_1.flare_model)) {
    var_8 = _getgroundposition(var_1.origin + (0, 0, 50), 1);

    if(!isDefined(var_8))
      var_8 = var_1.origin;

    var_1.flare_model = spawn("script_model", var_8);
    var_1.flare_model setModel("npc_gen_fusee_flare");
    var_1.flare_model.angles = var_8 + (0, 0, 90);
  }

  if(isDefined(var_1.flare_model)) {
    if(isDefined(var_1._id_3D34))
      var_1._id_3D34 delete();

    if(common_scripts\utility::_id_562E(var_0)) {
      var_1._id_3D34 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_red_flare_idle"), var_1.flare_model, "TAG_FX");
      _triggerfx(var_1._id_3D34);
    }
  }
}

zm_care_spawn(var_0, var_1, var_2) {
  if(!common_scripts\utility::_id_562E(var_2))
    zm_care_spawn_toggle_fx(1, var_1);

  var_3 = _id_0527::_id_4570();
  var_0 _id_0527::_id_9302(var_0, [var_1.origin], [var_3], "zm_carepackage", undefined, "zm");
  level thread zm_care_crush_listen();
  level notify("zombie_airdrop_inbound");
}

zm_care_crush_listen() {
  level notify("new_zm_care_crush_listen");
  level endon("new_zm_care_crush_listen");

  for(;;) {
    if(isDefined(level.all_drop_crates)) {
      foreach(var_1 in level.all_drop_crates) {
        if(isDefined(var_1) && isDefined(var_1._id_6E4C) && !common_scripts\utility::_id_562E(var_1._id_6E4C.isonplayerwatch)) {
          var_1._id_6E4C.isonplayerwatch = 1;
          var_1._id_6E4C thread watch_for_player_damage(var_1);
        }

        var_1._id_A045 = ::unresolved_collision_nearest_node_carepackage;
      }
    }

    wait 0.5;
  }
}

watch_for_player_damage(var_0) {
  self waittill("damage");
  var_0 waittill("physics_impact");
  var_0 thread[[level.zombiecratecapturethink]](1);
  level.player zm_care_crate_capture(var_0);
}

unresolved_collision_nearest_node_carepackage(var_0) {
  var_1 = 1;
  var_2 = 0;
  var_3 = 18;
  var_4 = self.origin;

  for(;;) {
    var_5 = vectorNormalize(anglesToForward((0, var_2, 0)));
    var_4 = self.origin + var_1 * var_3 * var_5;
    var_4 = _func_2E1(var_4);
    var_1++;
    var_2 = var_2 + 90;

    if(var_2 > 360)
      var_2 = 0;

    if(!_canspawn(var_4)) {
      waitframe();
      continue;
    }

    if(_positionwouldtelefrag(var_4)) {
      waitframe();
      continue;
    }

    break;
  }

  if(var_0 getstance() == "prone")
    var_0 setstance("crouch");

  var_0 setOrigin(var_4);
}

zm_care_crate_capture(var_0) {
  var_1 = self;
  var_2 = var_0;
  level notify("zombies_crate_captured", var_1, var_2, var_0.origin);
  var_0 _id_0529::_id_2D30();
}

zm_care_crate_capture_think(var_0) {
  self endon("captured");
  level notify("zombie_airdrop_landed");
  zm_care_spawn_toggle_fx(0, undefined, self);

  if(common_scripts\utility::_id_562E(var_0)) {
    return;
  }
  var_1 = common_scripts\utility::_id_46B7("carepackage_dz", "targetname");
  var_2 = common_scripts\utility::_id_4461(self.origin, var_1, 250);
  self sethintstring(&"MP_CARE_PACKAGE_PICKUP");

  if(!self _meth_8562())
    self makeusable();
  else if(isDefined(level.players)) {
    foreach(var_4 in level.players) {
      if(!self _meth_8691(var_4))
        self enableplayeruse(var_4);
    }
  }

  if(isDefined(level.players) && !common_scripts\utility::_id_562E(var_2.no_crate_highlight))
    self hudoutlineenableforclients(level.players, 2, 0);

  while(isDefined(self)) {
    self waittill("trigger", var_6);
    thread zm_care_crate_attempt_capture(var_6);
  }
}

zm_care_crate_attempt_capture(var_0) {
  if(var_0 isjumping()) {
    return;
  }
  if(!var_0 isonground() && !_id_0529::_id_A7A0(var_0)) {
    return;
  }
  if(_id_0547::_id_577E(var_0)) {
    return;
  }
  var_1 = 1000;
  var_0._id_56A1 = 1;
  var_2 = _id_0547::zmcreatesustainedholdent();
  var_3 = var_2 _id_0547::zmsustainedholdthink(var_0, var_1, ["captured"]);

  if(isDefined(var_2))
    var_2 delete();

  if(isDefined(var_0))
    var_0._id_56A1 = 0;

  if(!var_3) {
    var_0 notify("attemptCaptureEnd");
    return;
  }

  self notify("captured", var_0);
  wait 0.2;
  var_0 notify("attemptCaptureEnd");
}